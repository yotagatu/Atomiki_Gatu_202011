// =====================================================================
// SuperCollider Workspace
// =====================================================================


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// 

/* by  minkepatt */
(play{Schmidt.ar(Saw.ar([48,50,60].midicps), (LFPar.kr(0.87.rand)), (LFPar.ar(CuspL.ar(0.45.rand))))};)

// (play{var a,f,t;a=Dseq([1,3,5,8,2,5]*[2,0,0.5],inf);t=(Impulse.kr([5,4,7]));f=Demand.kr(t,0,a)*[13,89];LFTri.ar(f)*0.2**Dust.ar(2)};)

// ({PanB2.ar(Gendy1.ar(3,4,2,2,305,500,0.33)*LFNoise2.kr(0.2,0.5),Saw.kr(0.2,3))}.play;)

// ({PanB2.ar(Gendy1.ar(6,2,3,4,rrand(15,250),5000,0.1)*LFNoise2.kr(0.2,2),LFNoise0.kr(0.2))}.play;)

{Splay.ar({SinOscFB.ar(LFSaw.ar(Sweep.ar(Impulse.ar(Rand()),2)).range(Rand(99,999), Rand()),Sweep.ar(Impulse.ar(Rand())))}!10)}.play

// play{a=VarSaw.ar(SinOsc.ar(1/20,7/3,80,80),0,LFNoise1.kr(1,1/2,1/2))*Line.ar(0,1)!2;CombN.ar(a,2,2,20,1,a).softclip}//#supercollider

// (play{LFTri.ar(CombL.ar(Dust.kr(GrayNoise.ar)*44.1,1e-17,1e-6).round(441/3.5))};) 

/* by  batuhan bozkurt */
play{t=Impulse.ar(8)*LFNoise1.ar(2);CombL.ar(Saw.ar([3,4],Decay.ar(t,0.1)).tanh,1,TRand.ar(0,0.01,t).round(15e-4),TRand.ar(-30,30,t))};//#sc


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// SYNTHDEF

(
SynthDef(\minkepatt1, { |out|
	var  sound;

	sound = HPF.ar(
		Schmidt.ar(
			PinkNoise.ar(\noise.kr(1)),
			LFPar.kr(0.87.rand),
			LFPar.ar(0.45.rand)),
		\cutoff.kr(2000),
		\q.kr(0.3)
	) * \amp.kr(0.5);

	Out.ar(out,sound)
}
).add
)

x = Synth(\minkepatt1);
x.set(\q, 3);				

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

(
SynthDef(\minkepatt2, { |out=0|
	var  trigger, sound;

	//	trigge = (Impulse.kr(\trig.kr([5,2,3])));
	trigger = TDuty.kr(
		Impulse.kr(1),
		0,
		Dseq([[1,3,5,8,2,5]*[2,0,0.5]],inf))*[18,29];
	
	sound = LFTri.ar(trigger)*0.2**Dust.ar(2);

	Out.ar(out, sound);
}).add;
)

(
~x = Pbindef(
	\gi,
	\instrument, \minkepatt2,
	\trig, Pseq([1,4,3],inf),
	\f1, 300,
	\f2, 890,
	\dur, Pseq([1,0.3,0.4,8]*[0.2,0.5],inf),
	\amp, 0.8,
	\out, 0
).play;
)

~x.stop;


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
(
SynthDef(\batuhan, {|out=0|
	var t,  sound;
	
	t = Impulse.ar(\imp.kr) * LFNoise1.ar(\noiz.kr(2));
	sound = CombL.ar(
		Saw.ar(
			[\freq1.kr(3),\freq2.kr(4)],Decay.ar(t,0.1)
		).tanh,
		1,
		\delay.kr(0.01),
		\decay.kr(0.01)
	) * EnvGen.kr(Env.adsr, \gate.kr, doneAction: 2);

	Out.ar(out,sound)
}).add;
)

// TRand.ar(0,0.01,t).round(15e-4),
// TRand.ar(-30,30,t)

x = Synth(\batuhan, [\imp, 8, \noiz, 2, \freq1, 3, \freq2, 4, \delay, 0.02, \decay, 0.02, \gate, 1]);

x.set(\delay, rrand(0.0,0.02));
x.set(\decay, rrand(-20,1));

x.set(\delay, 0.02, \decay, 0.02);
x.set(\imp, 4);

x.set(\noiz, 40);
x.set(\decay, -20);
x.set(\noiz, 2, \imp, 8);
x.set(\decay, 0.02);

x.set(\freq1, 4);
x.set(\imp, 9, \decay, -10);
x.set(\decay, -20.rand2, \imp, 8);
x.set(\decay, 0.02, \freq1, 3);

x.free;


(
var x,y;
x = Prand([0,1],8).asStream;
//y = x.asStream;
Task({
	2.do({
		Synth(\batuhan, [\imp, x.next, \decay, -30,\gate, 1]);
		1.0.wait;
		
	})
});
)

t.start;
t.stop;

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//
(play{Schmidt.ar(Saw.ar([48,50,60].midicps), (LFPar.kr(0.87.rand)), (LFPar.ar(CuspL.ar(0.45.rand))))};)

(
SynthDef(\minkepatt3, { |out=0|
	var sound;

	sound = Schmidt.ar(
		Saw.ar([\f1.kr,\f2.kr,\f3.kr].midicps),
		(LFPar.kr(\low.kr)),
		(LFPar.ar(CuspL.ar(\high.kr)))
	) * Env.adsr.kr(2) * \gate.kr;

	Out.ar(out, sound)
}).add;
)

x = Synth(\minkepatt3, [\f1, 52, \f2, 40, \f3, 120, \low, 0.87, \high, 0.45]);
x.set(\gate,1)
x.set(\f1, 48, \f2, 50, \f3, 60);

(play{Schmidt.ar(Saw.ar([48,50,60].midicps), (LFPar.kr(0.87.rand)), (LFPar.ar(CuspL.ar(0.45.rand))))};)

(
SynthDef(\minkepatt4, { |out=0|
	var sound;

	sound = Schmidt.ar(
		Saw.ar(\freq.kr().midicps),
		(LFPar.kr(\lo.kr)),
		(LFPar.ar(CuspL.ar(\hi.kr)))) * EnvGen.ar(Env.asr,\gate.kr,doneAction: Done.freeSelf);

	Out.ar(out,sound)
}).add;
)

x = Synth(\minkepatt4, [\freq, 47, \lo, 0.87.rand, \hi, 0.45.rand]);
x.set(\gate, 1);


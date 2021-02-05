// =====================================================================
// SuperCollider Workspace
// =====================================================================


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/* by  micromoog */

// play{BPF.ar(VarSaw.ar(LFNoise1.kr(3,40,200),0,0.25)+PinkNoise.ar(0.1),LFNoise2.kr(12,700,1000),0.3)!2};//#supercollider

/* by  micromoog */
// play{a=VarSaw.ar(SinOsc.ar(1/20,7/3,80,80),0,LFNoise1.kr(1,1/2,1/2))*Line.ar(0,1)!2;CombN.ar(a,2,2,20,1,a).softclip}//#supercollider

/* by  micromoog */
 {BPF.ar(DynKlang.ar(`[[3,5,[4,6]]],Demand.kr(Impulse.kr(1/3),0,Dseq([9,8,6,4],inf))*7).floor,LFPar.ar(1,2,911,999))/3}.play;//#supercollider

/* by  micromoog */
play{a=LFNoise1;SinOsc.ar(round(VarSaw.ar(a.kr(10,0.1),0,1)*a.kr(1!2!2,400),a.kr(1/50,32,76))).tanh}//#supercollider

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

(
SynthDef(\minimoog1, { |out|
	var env, sound;

	env = EnvGen.ar(Env.asr, \gate.kr, doneAction: Done.freeSelf);
	sound = BPF.ar
	(
		DynKlang.ar
		(`[	[3,5,6]],
			Demand.kr(
				Impulse.kr(
					1/3
				),
				0,
				Dseq(
					\pat.kr
				))*7).floor,
		LFPar.ar
		(
			1,2,911,999
		)
	) * \amp.kr(0.5) * Env.asr.ar(2);
	
	Out.ar(out, sound)
}).add;
)

x = Synth(\minimoog1, [\gate, 1]);
(
x = Pbindef(
	\pao,
	\instrument, \minimoog1,
	\pat, 14,
	//Pseq([16,14,12,19],2),
	\dur, 1,
	\amp, 0.2,
	\gate, 1,
	\out, 0
).play
)
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

play{a=LFNoise1;SinOsc.ar(round(VarSaw.ar(a.kr(10,0.1),0,1)*a.kr(1!2!2,400),a.kr(1/50,32,76))).tanh}

////////////////////////////////////////////////////////////

(
SynthDef(\micromoog2, { |out=0|
	var env, sound, sig;

	env = EnvGen.ar(Env.adsr(\atk.kr,\dc.kr,\sus.kr,\rel.kr),\gate.kr(1),doneAction: 2);

	//	env = Env.perc(\atk.kr(0.01),\dc.kr(0.1),\rel.kr(0.5)).kr(2);

	sound = SinOsc.ar(
		round(
			VarSaw.ar(LFNoise1.kr(\noise1.kr,\mul1.kr),0,1) * LFNoise1.kr(\many.kr!2!2,\freq.kr),LFNoise1.kr(\n1.kr,\n2.kr,\n3.kr)
		)
	).tanh;

	sig = sound*env*\amp.kr;

	Out.ar(out,sound)
}).add;
)

x = Synth(\micromoog2,[\noise1,12,\mul1, 0.1, \many,1, \freq,400,\n1,1/50,\n2,32,\n3,76]);
x.set(\noise1, 12, \n1, 1/50);
x.set(\many,3);
x.set(\noise1, 40);
x.set(\mul1, 0.4);
x.set(\n1, 1/40, \n2, 88, \n3, 24);
x.set(\atk,0.1, \dc, 0.2,\sus,0.3,\rel,0.4);
x.set(\amp,0.8);
x.set(\freq,180);
x.set(\n1, 1/4, \n2, 400, \n3, 14);
x.set(\gate, 1);

(
~x = Pbindef(
	\scopos,
	\instrument, \micromoog2,
	\noise1, 12,
	\mul1, 0.1,
	\many, 1,
	\freq, 400,
	\n1, 10,
	\n2, 1,
	\n3, 1,
	\atk, 0.08,
	\dc, 0.2,
	\sus, 0.3,
	\rel, 1.8,
	\gate, 1,
	\dur, Pseq([4],inf),
	\out, 0
).play;
)

~x.stop;
s.freeAll;
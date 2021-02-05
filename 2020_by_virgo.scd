// =====================================================================
// SuperCollider Workspace
// =====================================================================


////////////////////////////////////////////////////////////////////////

s.options.memSize = 8192*2;
s.reboot;

////////////////////////////////////////////////////////////////////////
// ORIGINAL

/* by  nathaniel virgo */
play{w=LFSaw;a=w.ar(-3,1)+1/2;f=Sweep.ar(0,3).floor;f=(f**3+f%8+4)*(f%3+3)%49*3;CombN.ar(RLPF.ar(w.ar(f)*a,f**a*30,0.3).tanh,5/6,5/6,6)!2}

/* by  nathaniel virgo */
play{PitchShift.ar(CombN.ar(Formant.ar(101,4**LFNoise1.kr(0.5)*450,200),1,0.5,99),1,Duty.kr(4,0,Dseq([[6,8,10],[6,7.2,7]]/8,inf))).sum/25!2}

/* by nathaniel virgo */
{a=PinkNoise.ar(1!2);50.do{a=BBandStop.ar(a,LFNoise1.kr(0.05.rand).exprange(40,15000),exprand(0.1,2))};LPF.ar(a,1e5)}.play// #supercollider

n={|r,f,n=0,d=1|round(r**LFNoise0.ar([4,1,8,2]!d)*f,n)};play{Splay.ar(d=n.(3,0.6);Ringz.ar(d*0.01,n.(2,n.(20,400),40,20),d).mean.tanh)}

////////////////////////////////////////////////////////////////////////

{ LFSaw.ar(-3,1)+1/2 }.plot(1);
{ LFSaw.ar(-3,1) }.plot(1);
{ LFSaw.ar(LFSaw.ar(-30,1)+1/2)}.plot(8);
{ LFSaw.ar(LFSaw.ar(-3,1)+1/2)}.plot(2);
{ LFSaw.ar(LFSaw.ar(Sweep.ar(0,3)**3)) }.plot(3);
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
// SYNTHDEF

(
SynthDef(\virgo1, { |out|
	var gen, w, a, f, sound;

	gen = EnvGen.ar(Env.adsr(
		\atk.kr(0.02);
		\dec.kr(0.2);
		\sus.kr(0.3);
		\rel.kr(0.7);
	),
		\gate.kr(0),
		doneAction: Done.freeSelf
	);

	// bipolar
	w = LFSaw;
	
	// unipolar. harmonics.
	a = w.ar(\sa.kr,\phs.kr); 

	// Rated trigger
	f = Sweep.ar(0,\rat.kr).floor;
	f = (f**\jump.kr(3)%\mod1.kr+4)*(f%\mod2.kr+3); //f = (f**3+f%\lolos.kr(8)+4)*(f%3+3)%49*3;

	sound = CombN.ar(RLPF.ar(w.ar(\freq.kr),f**a*\rsn.kr(30),0.3).tanh,\maxd.kr(5/6),\del.kr(5/6),\decay.kr(6))!2;

	sound = sound * gen * \amp.kr;

	Out.ar(out,sound)
}
).add
)


y = Synth(\virgo1);
y.set(\freq, 120);
y.set(\atk, 0.01, \dec, 0.04, \sus, 0.15, \rel, 0.3);
y.set(\atk, 1.9, \dec, 0.1, \sus, 1.2, \rel, 5.3);
y.set(\maxd,0.2,\del,0.2, \decay,0.8);
y.set(\gate, 1, \amp, 0.4);
y.set(\sa, -4);
y.set(\sa, 1);
y.set(\phs, 1);
y.set(\freq, 145);
y.set(\rat, 5);
y.set(\jump, 9);
y.set(\mod1, 9, \mod2, 8);
y.set(\rsn, 100);

y.free;

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// SYNTHDEF

(
SynthDef(\virgo2, { |out|
	
	var gen, sound;

	gen = EnvGen.ar
	(
		Env.adsr
		(
			\atk.kr(0.01),
			\dec.kr(0.2),
			\sus.kr(0.3),
			\rel.kr(0.8)
		),
		\gate.kr(0),
		doneAction: Done.freeSelf
	);

	sound = PitchShift.ar
	(
		CombN.ar
		(
			Formant.ar
			(
				\freq.kr(101),\harm.kr(4)**LFNoise1.kr(\noise.kr(0.5))*\hfreq.kr(250),\bffreq.kr(200)
			),
			\max_del.kr(1),\del.kr(0.5),\del_dec.kr(9)
		),
		3,
		//		Duty.kr(\durd.kr(1),0,Dseq([[6,8,10],[6,7.2,7]]/8,2,))).sum!2 * gen;
		Duty.kr
		(
			\time.kr(8),0,
			Dibrown
			(
				0,4,[3,3]
			)**LFNoise1.kr
			(
				\noise2.kr(0.05)+0.5
			)
		)
	) * gen * \amp.kr(0.5);

	Out.ar(out,sound)

}
).add
)

x = Synth(\virgo2, [\gate, 1])
x.set(\freq, 800);
x.set(\hfreq, 2200);
x.set(\bffreq, 100);
x.set(\atk, 0.05, \dec, 0.2, \sus, 0.8, \rel, 1.4)
x.set(\amp, 0.9);
x.set(\harm, 22);
x.set(\noise, 0.2);
x.set(\noise2, 0.5);
x.set(\time, 8);
x.set(\del_dec, 9);

x.free;

////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////
//




	

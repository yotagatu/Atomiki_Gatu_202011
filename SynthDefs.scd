// =====================================================================
// SuperCollider Workspace
// =====================================================================



////////////////////////////////////////////////////////////
//
/* by  nathaniel virgo */
play{w=LFSaw;a=w.ar(-3,1)+1/2;f=Sweep.ar(0,3).floor;f=(f**3+f%8+4)*(f%3+3)%49*3;CombN.ar(RLPF.ar(w.ar(f)*a,f**a*30,0.3).tanh,5/6,5/6,6)!2}

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

////////////////////////////////////////////////////////////

play{PitchShift.ar(CombN.ar(Formant.ar(101,4**LFNoise1.kr(0.5)*450,200),1,0.5,99),1,Duty.kr(4,0,Dseq([[6,8,10],[6,7.2,7]]/8,inf))).sum/25!2}

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

////////////////////////////////////////////////////////////

(
SynthDef(\redfrik3, { |out=0|
	var env, x, y, sound;

	env = Env.perc.kr(2);
	x = CombN.ar(Phasor.ar(0,{|i|i+1/20}!22),0.042,0.042);
	y = Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,\f1.kr,\f2.kr)),x);
	sound = Splay.ar(y)* \amp.kr(0.4) * env;

	Out.ar(out,sound)
}).add
)

////////////////////////////////////////////////////////////

play{x=LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(200,2e3,x).lag(2),x.range(5e-4,1e-3),0.0012)}//#SuperCollider

(
SynthDef(\redfrik4, { |out=0|
	var env, x, sound;

	env = Env.perc.kr(2);
	x = LFNoise1.ar(0.5!2);
	sound = Formlet.ar(
		Crackle.ar(x.range(1.8,1.98)),
		TExpRand.ar(200,2e3,x).lag(2),
		x.range(1e-4,1e-3),
		0.0012
	) * env;

	Out.ar(out,sound)
}).add
)

////////////////////////////////////////////////////////////

/* by  batuhan bozkurt */
play{t=Impulse.ar(8)*LFNoise1.ar(2);CombL.ar(Saw.ar([3,4],Decay.ar(t,0.1)).tanh,1,TRand.ar(0,0.01,t).round(15e-4),TRand.ar(-30,30,t))};//#sc

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

////////////////////////////////////////////////////////////

/* by  minkepatt */
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

////////////////////////////////////////////////////////////

/* by  micromoog */
play{a=LFNoise1;SinOsc.ar(round(VarSaw.ar(a.kr(10,0.1),0,1)*a.kr(1!2!2,400),a.kr(1/50,32,76))).tanh}//#supercollider

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

////////////////////////////////////////////////////////////

play{x=165;b=SinOsc;p=Trig.ar(Saw.ar(x),1);y=b.ar(p*x);z=b.ar(p);(GVerb.ar(GrainIn.ar(2,y,y/2,z,p*z,-1),9))/9}

(
SynthDef(\bassogettato, { |out=0|
	var p, y, z, env, sound;
	
	p = Trig.ar(Saw.ar(\f.kr(165)),\tf.kr(1));
	y = SinOsc.ar(p * \f.kr(165));
	z = SinOsc.ar(p);

	env = Env.adsr(\atk.kr(0.1),\dec.kr(0.02),\sus.kr(0.2),\rel.kr(0.3)).kr(2);

	sound = GVerb.ar(GrainIn.ar(2,y,y/2,z,\pan.kr(0),-1),\reverb.kr(2));

	Out.ar(out, sound*env*\amp.kr(0.1))
}).add;
)

////////////////////////////////////////////////////////////

/* by tim walters */
play{HPF.ar(GVerb.ar(({|k|({|i|y=SinOsc;y.ar(i,y.ar(i+k*i)/Decay.kr(Impulse.kr(0.5**i/k),[1,2]+i,k))}!6).sum}!16).sum,1,1)/180,40)}

(
SynthDef(\walters, { 
	var adsr_env, c, sound;
	adsr_env = Env.adsr(\atk.kr(0.1),\dec.kr(0.01),\sus.kr(0.2),\rel.kr(0.3)).kr(2);
	//	perc_env = Env.perc(\patk.kr(0.001),\psus.kr(0.5),\prel.kr(0.4),).kr(2);
	sound = HPF.ar(
		GVerb.ar(
			({ |k|
				({ |i|
					SinOsc.ar(i,SinOsc.ar(\freq.kr(120))/Decay.kr(Impulse.kr(\p.kr(0.5)**i/k),[1,2]+i,k))
				}!6
				).sum
			}!16).sum
			,\room.kr(1),\rev.kr(1))
		,\cutoff.kr(400))/180 * adsr_env * \amp.kr(0.5);

	Out.ar(0,sound)
	
}).add;
)

////////////////////////////////////////////////////////////

{t=Impulse.ar(9);h=Latch.ar(SinOsc.ar(5.258,[0,0.5]),t);Blip.ar(h[0].range(40,200).round(44),h[1].range(1,50),0.2).dup}.play;

(
SynthDef(\marimoto,
	{
		var e = EnvGen.ar(Env.adsr(
			\atk.kr(0.01),
			\dec.kr(0.025),
			\sus.kr(0.25),
			\rel.kr(0.5)),
			gate: \gate.kr(0),
			levelScale: \amp.kr(0.2),
			doneAction: 2
		);

		var t = Impulse.ar(\impulse.kr(9));

		var h = Latch.ar(
			SinOsc.ar(
				\freq.kr(5.258),
				[\phase1.kr(0),\phase2.kr(0.5)]
			),
			t
		);

		Out.ar(0,
			Blip.ar(
				h[0]
				.range(\freq1.kr(20),\freq2.kr(20000))
				.round(\freq_base.kr(44)),
				h[1]
				.range(\harm1.kr(1),\harm2.kr(50))
			)!2 * e;
		);
	}
).add;
)

////////////////////////////////////////////////////////////

(
SynthDef(\rukano2, {|out=0|
	var sound;

	sound = SinOsc.ar(Latch.ar(SinOsc.ar(\freq.kr,0,\mul.kr,\add.kr),Impulse.ar(\imp.kr))).lag(0.1) * Env.asr.kr(2);

		Out.ar(out,sound)
}).add
)

////////////////////////////////////////////////////////////

/* by rukano */
play{t = Impulse.kr(6);f=lag(Demand.kr(t,0,Drand(midicps((10,13..40)),inf)));RLPF.ar(Pulse.ar(f),1+Decay2.kr(t)*LFNoise2.kr(2,8,9)*f,1/9)!2}

(
SynthDef(\rukano3, {|out=0|
	var t, sound;

	t = Impulse.kr(\trigger.kr);
	sound = RLPF.ar(Pulse.ar(\freq.kr).midicps,\rsn.kr(0)+Decay2.kr(t)*LFNoise2.kr(1,10,11)*\freq.kr,1/9)!2;

	Out.ar(out,sound * Env.triangle.kr(2))
}).add
)

////////////////////////////////////////////////////////////

/* by rukano */
play{Splay.ar(Logistic.ar(LFCub.kr([1,2,4,8],0,1.9,2),LFNoise0.kr(1/[16,12,8,4],400,999).round(150)))}

(
SynthDef(\rukano4, {|out=0|
	var sound;

	sound = Logistic.ar(
		LFCub.kr
		(
			// XLine.kr(1.2,3.99,0.01),
			//  Trig.kr(Impulse.kr(\trig.kr),\rate.kr),
			0,1.9,2
		),
		LFNoise0.kr
		(
			1/[16,40,100,120],400,999
		).round(80),
	);

	Out.ar(out,sound)
}).add;
)

////////////////////////////////////////////////////////////

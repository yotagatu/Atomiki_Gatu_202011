// =====================================================================
// SuperCollider Workspace
// =====================================================================


play{Splay.ar(Ringz.ar(Decay2.ar(Impulse.ar([2,3]),0.0001,0.01),Array.geom(9,40,1.75)*LFDNoise3.ar(4,0.1),0.9,0.1))} // #supercollider #sc

// play{x=LFDNoise3;Blip.ar(x.kr(1,[400,100],500),x.kr([1,2],6,5))*Gendy3.ar(1,1,1,1,x.kr(1,99,91),1,0.1)*x.ar(0.5,0.5,0.5)}// #sc

// play{t = Impulse.kr(6);f=lag(Demand.kr(t,0,Drand(midicps((10,13..40)),inf)));RLPF.ar(Pulse.ar(f),1+Decay2.kr(t)*LFNoise2.kr(2,8,9)*f,1/9)!2}

play{Splay.ar(Logistic.ar(LFCub.kr([1,2,4,8],0,1.9,2),LFNoise0.kr(1/[16,12,8,4],400,999).round(150)))}// #supercollider #sc <3 chaotic noise

// play{l=LFSaw;l.ar(l.kr(l.kr([1,3],0,4,[5,6]),l.kr(1/[4,8]),l.kr(1,0,99,100),l.kr(1/2,0,50,l.kr(1/4,1/3,50,100))))/2} // #sc LFSaw galore

play{l=LFPar;Clip.ar((LFCub.ar(l.kr(1/[8,9],0,25,25).round(1),0,50,50) & l.kr(1/[7,5],0,25,25)),-1,1)}

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

play{Splay.ar(Ringz.ar(Decay2.ar(Impulse.ar([2,3]),0.0001,0.01),Array.geom(9,40,1.75)*LFDNoise3.ar(4,0.1),0.9,0.1))} // #supercollider #sc

(
SynthDef(\rukano1, {|out=0|
	var sig, sound;

	sig = Decay2.ar(Impulse.ar(\imp.kr([2,3])),0.0001,01);
	sound = Ringz.ar(sig,Array.geom(9,40,1.75) * LFDNoise3.ar(\noise.kr(4),0.1),0.9,0.1);

	Out.ar(out,sound*\amp.kr(0.5))
	
}).play;
)

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//
play{
	x = LFDNoise3;
	Blip.ar
	(
		LFDNoise3.kr
		(
			1,[400,100],500
		),
		LFDNoise3.kr
		(
			[1,2],6,5
		)
	)
	*
	Gendy3.ar
	(
		1,1,1,1,LFDNoise3.kr
		(
			1,99,91
		),
		1,0.1
	)
	*
	LFDNoise3.ar
	(
		0.5,0.5,0.5
	)
}
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// DAF
(
play{
	a = [1,1.01,2,2.02,3.5,4.01,5.501];
	SinOsc.ar
	(
		Duty.kr
		(
			0.4,0,Dseq
			(
				[10,11,0,12.2,0,0,10,0]+39,inf
			).midicps
		)
		*
		(
			a++(a*2)
		)
	).sum!2/2
}
)		
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// Latch.
play{SinOsc.ar(Latch.ar(SinOsc.ar(2.75,0,180,80),Impulse.ar(9)).lag(0.1))!2}

(
SynthDef(\rukano2, {|out=0|
	var sound;

	sound = SinOsc.ar(Latch.ar(SinOsc.ar(\freq.kr,0,\mul.kr,\add.kr),Impulse.ar(\imp.kr))).lag(0.1) * Env.asr.kr(2);

		Out.ar(out,sound)
}).add
)

x = Synth(\rukano2,[\freq,0.75,\mul,120,\add,80,\imp,4]);
x.set(\freq, 2.75);
x.set(\imp, 4);
x.set(\mul, 1800, \add, 20);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//
play{t = Impulse.kr(6);f=lag(Demand.kr(t,0,Drand(midicps((10,13..40)),inf)));RLPF.ar(Pulse.ar(f),1+Decay2.kr(t)*LFNoise2.kr(2,8,9)*f,1/9)!2}

(
SynthDef(\rukano3, {|out=0|
	var t, sound;

	t = Impulse.kr(\trigger.kr);
	sound = RLPF.ar(Pulse.ar(\freq.kr).midicps,\rsn.kr(0)+Decay2.kr(t)*LFNoise2.kr(1,10,11)*\freq.kr,1/9)!2;

	Out.ar(out,sound * Env.triangle.kr(2))
}).add
)

(
x = Pbindef(
	\loal,
	\instrument, \rukano3,
	\trigger, Pseq([1,2],inf),
	\freq, Pseq([48,Rest(1),44,22,60],inf),
	\rsn, 1,
	\out, 1
).play;
)

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

play{
	Splay.ar
	(
		Logistic.ar
		(
			LFCub.kr
			(
				[1,2,4,8],0,1.9,2
			),
			LFNoise0.kr
			(
				1/[16,12,8,4],400,999
			).round(150)
		)
	)
}

{ Splay.ar(Logistic.ar(LFCub.kr(XLine.kr(1.2,3.99,0.01),0,1.9,2),LFNoise0.kr(1/[16,120,80,40],400,999).round(150)))}.play;

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

x = Synth(\rukano4, [\trig, 1, \rate, 1])
x.set(\trig, 3.99);
x.set(\rate, 1.86);

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

play{
	l=LFPar;
	Clip.ar
	(
		(
			LFCub.ar
			(
				l.kr
				(
					1/9,0,25,25
				).round(1),
				0,50,50
			)
			&
			l.kr
			(
				1/5,0,25,25
			)
		),
		-1,1
	)
}
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//

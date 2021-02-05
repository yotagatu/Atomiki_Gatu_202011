// =====================================================================
// SuperCollider Workspace
// =====================================================================

// by morimoto
// https://sccode.org/1-4Tf

{t=Impulse.ar(9);h=Latch.ar(SinOsc.ar(5.258,[0,0.5]),t);Blip.ar(h[0].range(40,200).round(44),h[1].range(1,50),0.2).dup}.play;


////////////////////////////////////////////////////////////////////////////////
// 

t = Impulse.ar(9);

/*
	A sinusoidal running with phase difference for left and right,
	snapshoted t times inside Latch, a sample and hold Ugen, so the 
	output is a continuous pattern of numbers/steps, different on
	each channel due to phase offseting.
*/

h = Latch.ar(SinOsc.ar(5.252,[0,0.5]),t);

{ Latch.ar(SinOsc.ar(5.252,[0,0.5]),Impulse.ar(9))}.plot(10);

/* 
	h's number patterns are fed into Blip's frequency and harmonics input.
	h[0] values are mapped and run exponentially from 40 to 200
	quantizing the values only to output multiples of 44, acting as a tone base. 
	h[1] values are scaled to run from 1 to 50.
*/

Blip.ar(h[0].exprange(40,200).round(44),h[1].range(1,50),0.2).dup

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*
	Synth Definition
	An adsr envelope is added for control.
	All inputs become control nodes.
*/
(
SynthDef(\morimoto,
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
////////////////////////////////////////////////////////////
x = Synth(\morimoto, [\gate, 1, \impulse, 9]);
x.set(\freq2, 400);
x.set(\freq1, 80, \freq2, 220, \harm1, 1, \harm2, 8);
x.set(\freq, 4.1, \impulse, 4);
x.set(\harm1, 1, \harm2, 30);
x.set(\impulse, 9);
x.set(\freq,120);
x.set(\freq1, 120, \freq2, 2000);
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

		
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

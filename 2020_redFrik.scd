// «sctweets by redFrik» by Fredrik Olofsson
// https://sccode.org/1-4Qy


//--tweet0028
play{MoogFF.ar(LFTri.ar(CombN.ar(Duty.ar(1/8,0,Dseq(Dshuf(List.fib(16)%8*99,8),inf)),4,4,16))/4,LFTri.kr(1/16,0,2e3,3e3))!2}//#SuperCollider

//--tweet0030
play{a=LFPar;GVerb.ar(VarSaw.ar(a.ar(1,0,5,a.ar([0.05,0.04],0,50,160).round(50)),0,a.ar(0.2,0,0.5,a.ar(3,0,0.2,0.5)))/8,80)}//#SuperCollider

//--tweet0034
play{x=CombN.ar(Phasor.ar(0,{|i|i+1/20}!22),0.042,0.042);y=Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,400,500)),x);Splay.ar(y)*0.25}//#SuperCollider

play{x=LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(200,2e3,x).lag(2),x.range(5e-4,1e-3),0.0012)}//#SuperCollider


////////////////////////////////////////////////////////////
//

// play{MoogFF.ar(LFTri.ar(CombN.ar(Duty.ar(1,0,Dseq(Dshuf(List.fib(16)%4*120,4),inf)),4,4,16))/4,LFTri.kr(1/16,0,2e3,3e3))!2}//#SuperCollider


{
	a=[0.02,0.1,1,2,3,4];
	k=LFPar.kr(a+0.5).sum;
	f=Latch.kr(k,Impulse.kr(a));
	Splay.ar(SinOsc.ar(f*100+300)/5)
}.play 

        
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//
play{MoogFF.ar(LFTri.ar(CombN.ar(Duty.ar(1/8,0,Dseq(Dshuf(List.fib(16)%8*99,8),inf)),4,4,16))/4,LFTri.kr(1/16,0,2e3,3e3))!2}//#SuperCollider

(
SynthDef(\redfrik1,{|out=0|
	var sound;

	sound = MoogFF.ar(LFTri.ar(CombN.ar(\seq.kr,4,4,1,6)),LFTri.kr(1/16,0,2e3,3e3))!2;

	Out.ar(out,sound*Env.adsr.kr(2)*\amp.kr)
}).add;
)

// Replacing Demand UGens with patterns.
// Duty.ar(1/8,0,Dseq(Dshuf(List.fib(16)%8*99,8),inf)),4,4,16))/4
// wtf the allocation?

(
Pbind(
	\instrument, \redfrik1,
	\seq, Pn(Pseq(List.fib(16)%8),4),
	\freq, 120,
	\amp, 0.5,
	\dur, 1,
	\out, 0
).play;
)

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
// Chains?

play{ a=LFPar;GVerb.ar(VarSaw.ar(a.ar(1,0,5,a.ar(0.05,0,50,160).round(50)),0,a.ar(0.2,0,0.5,a.ar(3,0,0.2,0.5)))/8,8)}

(
SynthDef(\redfrik2, { |out|
	var a, sound;

	a = LFPar;
	sound = GVerb.ar(
		VarSaw.ar(
			a.ar(\f1.kr,\f10.kr,
				a.ar(\f2.kr,0,\f3.kr,\f4.kr).round(\f3.kr)
			)
			,0,
			a.ar(\f5.kr,0,\f6.kr,a.ar(\f7.kr,0,\f8.kr,\f9.kr))
		)/8,
		\reverb.kr) * Env.adsr.kr(2);

	Out.ar(out, sound * \amp.kr);
}).add;
)


x = Synth(\redfrik2, [\f1, 1,\f10, 5, \f2, 0.05,\f3, 50,\f4, 160,\f5, 0.2,\f6, 0.5,\f7, 3,\f8, 0.2,\f9, 0.5,\reverb, 8, \amp, 0.5])
x.set(\f1, 12);
x.set(\f10, 2);
x.set(\f3, 60);
x.set(\f4, 160);
x.set(\f5, 200);
x.set(\reverb, 8);

////////////////////////////////////////////////////////////
//

play{x = CombN.ar(Phasor.ar(0,{|i|i+1/2}!2),0.042,0.042);y = Phasor.ar(LPF.ar(x,LFPar.ar(1/99,0,400,500)),x);Splay.ar(y)*0.25}

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

x = Synth(\redfrik3,[\f1, 400,\f2, 500]);

////////////////////////////////////////////////////////////
//

play{x = LFNoise1.ar(0.5!2);Formlet.ar(Crackle.ar(x.range(1.8,1.98)),TExpRand.ar(2000,2e3,x).lag(2),x.range(1e-4,1e-3),0.0012)}

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

x = Synth(\redfrik4)


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
//







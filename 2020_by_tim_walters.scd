// =====================================================================
// SuperCollider Workspace
// =====================================================================


////////////////////////////////////////////////////////////////////////
// 

/* by tim walters */
play{HPF.ar(GVerb.ar(({|k|({|i|y=SinOsc;y.ar(i,y.ar(i+k*i)/Decay.kr(Impulse.kr(0.5**i/k),[1,2]+i,k))}!6).sum}!16).sum,1,1)/180,40)}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//

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

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//

x = Synth(\w, [\p, 0.2, \amp, 0.9, \freq, 20, \cutoff, 40])

x.set(\rev, 0.8);

x.set(\p, 1);
x.set(\freq, 2000);
x.set(\rel, 4.2);
x.set(\cutoff, 400);
x.set(\amp, 0.2);

y = Synth(\w, [\p, 1, \freq, 200, \cutoff, 2000]);
y.set(\p, 2);
y.set(\freq, 2);
y.set(\cutoff, 100);

y.set(\rel, 0.2);
x.free;
y.free; x.free;

////////////////////////////////////////////////////////////////////////

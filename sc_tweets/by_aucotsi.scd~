// https://sccode.org/1-4RE
// «..and tweets» by aucotsi

// 01
play{a=SinOsc.ar(_);g=Stepper.ar(_);f=111!2+(148*a.(3.0166));FreeVerb.ar(HPF.ar(a.(2**f)/3,7e3)+a.(g.(a.(2))*444/g.(f)))}// #SuperCollider

// 02
play{a=SinOsc.ar(_);b=LFPulse.ar(_);g=Stepper.ar(_);Splay.ar(HPF.ar(a.({|i| f=111!2+(148*a.(1/i));g.(b.(i.sqrt))*(444/i)/g.(f) }!12,123)))}

// 03
play{a=SinOsc;b=LFPulse;g=Stepper;Splay.ar(HPF.ar(a.ar({|i|f=111!2+(148*a.ar(1/i));g.ar(b.ar(i))*(444/i)/g.ar(f)}!8,123).tanh))}// #sc140

// 04
(SynthDef(\n,{|f,j|Out.ar(0,LFTri.ar(f!2)/8*Line.ar(2,1,j,1,0,2))}).add;29.do{|i|Pbind(\instrument,\n,\f,(i+1)%9*88,\dur,i+1/9,\j,i/99).play})

// 05 - nasty for cpu ~8k ugens, ~40% on my machine
d=Dust;a=SinOsc;300.do{|i|{a.ar(Stepper.kr(d.kr(1),0,0,t=TChoose.kr(d.kr(3),(4..7)))*129+[a.kr(t),a.kr(t+1).neg],a.kr(i/t),i+1*1e-4)}.play}

//1.
play{p=Pulse;GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,128),WhiteNoise.ar*p.ar(8,5e-4)+SinOsc.ar(9*p.ar(1),0,n=p.kr(p.ar(5)))),n)))}//w8
//2.
play{a=SinOsc;p=Pulse;WhiteNoise.ar*p.kr(8,0.01)+a.ar(98*n=p.ar(4),0,p.kr(2,add:1))+GVerb.ar(a.ar(99*n)+p.ar(p.kr(3*n)),1,mul:0.1)}// #sc140
//3.
play{p=Pulse;WhiteNoise.ar*p.ar(8,h=3e-3)+GVerb.ar(GrainSin.ar(2,p.ar(8),n=h*t=LFNoise0.ar,1/n),2)+PMOsc.ar(9*p.ar(4*t),111,p.kr(6,t,1,1))}
//4.
play{GVerb.ar(IFFT(PV_BrickWall(FFT(Buffer.alloc(s,1024),WhiteNoise.ar*Pulse.ar(8,2e-2)),SinOsc.ar(Duty.kr(1,0,Dseq((10..19),inf))))))}
//5.
play{a=SinOsc;p=Pulse;GVerb.ar(WhiteNoise.ar*p.ar(TChoose.kr(a.kr(2),[5,8,20,30]))*p.ar(16,0.1))+a.ar(97*p.ar(4),0,p.kr(5,add:1))}// #sc140
//6.
ProxySpace.push;~a0.play;~a1.play;fork{loop{2.do{|i|currentEnvironment[(\a++i).asSymbol]={GVerb.ar(LFTri.ar(99+9.rand2),1,i)/2};0.2.wait}}}

// a drum part
play{b=SinOsc.kr(1);a=Line.kr(0.1,2*pi,37);FreeVerb.ar(SinOsc.ar(b*340!2*Impulse.kr(b*680),LFPulse.kr(2,0,pi/2),LFPulse.kr(3,0,1/pi*a)))}

//sticky morning clock
play{c=LFPulse.kr(0.5);b=SinOsc.kr(0.0034);a=Line.kr(0.1,2pi,37);FreeVerb.ar(Blip.ar(a*340!2*Impulse.kr(b*34/pi),c*TIRand.kr(0,113,c),c))}

// another drum part
play{a=Impulse;b=SinOsc;a.kr(6).lag*Crackle.ar(LFSaw.kr(5).abs.lag2)+a.ar(7).lag*b.ar(222*b.kr(29))+([a.kr(2,0,4)+a.kr(1)].lag*b.ar(70!2))}

/// i like to play these two on series
play{a=Impulse;a.kr(8).lag2*Crackle.ar(LFSaw.kr(5).abs.lag2)+GVerb.ar([a.kr(2,0,4).lag+a.kr(1,pi/5).lag]*Blip.ar(5,2,0.2)!2,6,0.4)}
///
play{a=Impulse;a.kr(8).lag2*Crackle.ar(LFSaw.kr(7).abs.lag3)+GVerb.ar([a.kr(2,0,4).lag+a.kr(1,pi/1.2).lag]*SinOsc.ar(20)!2,6,0.4,0.4)}

// https://sccode.org/1-34v
// «fractal tweets» by aucotsi

// I was looking some fractal structures, with a friend who studies the maths, and we found a // simple algorithm. So i made some tweets with the formula. 

r{inf.do{|i|a=i.asInteger.rand2;if(a.even){a=a/2}{a=a*3+1};play{SinOsc.ar(a,0,0.1)!2*EnvGen.ar(Env.perc,1,1,0,1,2)};0.07.wait;}}.play
//
r{inf.do{|i|a=i.asInteger;if(a.even){a=a/2}{a=a*3+1};play{SinOsc.ar(a,0,0.1)!2*EnvGen.ar(Env.perc,1,1,0,1,2)};0.01.wait;}}.play
//
a=(-23);r{inf.do{a=a.asInteger;a.postln;if(a.even){a=a/2}{a=a*3+1};play{SinOsc.ar(a,0,0.1)!2*EnvGen.ar(Env.perc,1,1,0,1,2)};0.1.wait}}.play
//
a=(-917);r{inf.do{a=a.asInteger.postln;if(a.even){a=a/2}{a=a*3+1};play{SinOsc.ar(a,0,0.1)!2*EnvGen.ar(Env.perc,1,1,0,1,2)};0.1.wait}}.play

// the funny thing is that when you have a negative input this folds into a loop!

// the correct formula is this below
a=73;r=r{inf.do{a=a.asInteger;if(a==1){r.stop};if(a.even){a=a/2}{a=a*3+1};play{Blip.ar(a)!2*EnvGen.ar(Env.perc,1,1,0,1,2)};0.1.wait}}.play

// by morimoto
{t=Impulse.ar(9);h=Latch.ar(SinOsc.ar(5.258,[0,0.5pi]),t);Blip.ar(h[0].range(40,200).round(44),h[1].range(1,50)).dup}.play;




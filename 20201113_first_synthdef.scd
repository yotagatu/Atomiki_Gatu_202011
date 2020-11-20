SynthDef(\bomb_bass, { 

	var carr_lfo, mod_lfo, src, env, out;
	carr_lfo = Select.kr(1, [SinOsc.kr(\c_lfo.kr(90)).abs, Saw.kr(\c_lfo.kr(90)).abs, LFSaw.kr(\c_lfo.kr(90)).abs]);
	mod_lfo = Select.kr(Line.kr(0.0,2.0,4), [SinOsc.kr(\m_lfo.kr(10.sin)).abs, Saw.kr(\m_lfo.kr(10.sin)).abs, LFSaw.kr(\m_lfo.kr(10.sin)).abs]);
	src = PMOsc.ar(\carr_freq.kr(400.4)*carr_lfo,\mod_freq.kr(80.8)*mod_lfo,\phase_shift.kr(4),0.5*Saw.kr(7).lag);
	
	env = EnvGen.ar(Env([0.0,0.9,0.0],[0.7,0.5]).circle);
	out = FreeVerb.ar(src,\mix.kr(0),\room.kr(0),\dump.kr(0)) * env;  

	Out.ar(0, out)
}).play;
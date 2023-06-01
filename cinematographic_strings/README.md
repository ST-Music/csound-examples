I recently found a new virtual analog synthesizer app that's been ported to Android, Flowtones. https://www.toneboosters.com/tb_flowtones_v1.html

One of the most advanced and versatile synth apps I've found for Android so far, Csound aside. It has many similar features and waveform graphics seen in modern wavetable apps like Serum and Vital. While claiming to be virtual analog synthesis it seems more of a hybrid, for example settings for unison voices, 4 varieties for each waveform (Ideal, Enhance, Vintage 1, Vintage 2) etc.

One patch initially caught my ear, called Cinematographic Strings. I decided to try and somewhat replicate it, good practice as I have little experience creating unique waveshapes via combining or modulating standard ones.

The Flowtones patch uses some interesting bandlimited waveforms, two saw-pulse shapes. Essentially the negative portion is a square, the positive a reverse saw (ramp) which utilizes pwm. The saw full pulse 2 has two neg. pulse shapes per cycle, splitting the ramp in two. The saw full pulse 4 has four downward pulse shapes splitting the single ramp four times etc.

While one might create the shapes easier with tables (GEN07 then bandlimiting with GEN30) this creates an issue with potential aliasing using higher freq. notes. So I opted to use vco2 and modulate and sum simple waveforms instead, taking advantage of the opcodes bandlimiting.

One other interesting part of the patch was the use of the reverb algorithm to create the slow attack/release. The oscillators use a fairly quick attack , 77 ms & 25 ms respectively. By putting the reverb in series with no parallel dry signal (essentially 100% wet) a slow attack/release results. I increased the attack time to .77 as it wasn't really possible to mimic their particular reverb algorithm easily (probably some pre-delay, early reflections etc.).

I didn't exactly nail it but the end result is similar. It creates a fairly full multi-octave pad using a single note.

I've also included a few pics of the raw waveforms created in Csound and an audio example.

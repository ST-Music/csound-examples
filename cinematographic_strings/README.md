I recently found a new virtual analog synthesizer app that's been ported to Android, Flowtones. https://www.toneboosters.com/tb_flowtones_v1.html

(also available for Windows, macOS & iPadOS)

One of the more advanced and versatile synth apps I've found for Android so far, Csound aside of course. It has many similar features and waveform graphics seen in modern wavetable apps like Serum and Vital. While claiming to be virtual analog synthesis it seems more of a hybrid, for example settings for unison voices, 4 varieties for each waveform (Ideal, Enhance, Vintage 1, Vintage 2) etc.

One patch initially caught my ear, called Cinematographic Strings. I decided to try and somewhat replicate it, good practice as I have little experience creating unique waveshapes via combining or modulating standard ones.

The Flowtones patch uses some interesting bandlimited waveforms, two saw-pulse shapes. Essentially with the saw full pulse the negative portion is a pulse, the positive a reverse saw (ramp) and utilizes pwm. The saw full pulse 2 has two neg. pulse shapes per cycle, splitting the ramp in two. The saw full pulse 4 has four downward pulse shapes splitting the single ramp four times etc.

While one might create the shapes easier with tables (GEN07 then bandlimiting with GEN30) this creates an issue with potential aliasing using higher freq. notes. 

(Related article:)
http://www.csounds.com/journal/issue6/BandLimiting.html

So I opted to use several vco2 osc and modulate/sum simple waveforms instead, taking advantage of the opcodes bandlimiting.

One other interesting part of the patch was the use of the reverb algorithm to create the slow attack/release. The oscillators in the Flowtones patch use a fairly quick attack , 77 ms & 25 ms respectively. By putting the reverb in series with no parallel dry signal (essentially 100% wet) a slower attack/release results. It was hard, however to replicate the response of their reverb algorithm (possibly pre-delay & early reflections in there?) so for the linked audio example I increased the attack time to .77 (I think...).

I didn't exactly nail it but the end result is similar. It creates a fairly full multi-octave pad using single notes.

I've also included a few pics of the raw waveforms as created in Csound.

There's an audio example here:
https://www.dropbox.com/s/kh5krepdrca4kjy/cinematographic_strings.mp3?dl=0

Most wavetable synths I've seen (Serum/Massive/Vital etc.) seem to morph/interpolate between two adjacent frames in a wavetable. In Serum, frames are essentially single-cycle waveforms. While it's possible to move linearly thru the wavetable, back and forth, they generally only play two adjacent frames.

The tabmorphak & tabmorpha opcodes can morph between non-linear and/or adjacent waveforms simultaneously, allowing for up to 4 waveforms to be morphed simultaneously, although two of the four must be adjacent.

The "tabmorphak_example_1" file demonstrates this.

You can also move thru the wavetable in two directions simultaneously, for example having ktabnum1 moving forwards from waveform 0 to 40 while ktabnum2 moves backwards from 40 to 0.

[More to come soon...]

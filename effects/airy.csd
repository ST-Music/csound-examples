<CsoundSynthesizer>
<CsOptions>
 -odac -m2
; -o airy.wav
</CsOptions>
;==================================
<CsInstruments>
// authored by Scott Daughtrey (ST Music) //
sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1

seed 0

instr 1
  gaRvb   init 0
  aEnv  = linseg(0, 4, 1, p3 - 8, 1, 4, 0)             
; random spline ties elements together. as amp increases,
; so does frequency & amount of noise/wind "whistling"

; the first two values control the general range of the
; amp. & freq. modulation, the last two control the lowest
; and fastest "speed" of mod.
  kMod  = rspline(.5, 1, .05, .2)
; amount of low pass filtering, higher values filter more
  iLpf  = 400
  iAmp  = 70 ; overall amplitude
  aNoiz = noise(kMod * iAmp, 1 - kMod/iLpf)
  iFreq = 1000 ; base frequency of noise/wind
  iFmod = 1 ; amount of freq. modulation

; amount of whistling, adjust iAmp accordingly
  iBW   = 300 ; lower value = more whistling
  iMod  = 2.5
  aBpf  = butbp(aNoiz, iFreq * kMod * iFmod, iBW/(kMod * iMod))

  aHpf  = buthp(aBpf, iFreq * 2.5)
  aBpf2 = butlp(aHpf, iFreq * kMod * iFmod, iBW * 2)
; mix of dry/reverb: 1 = dry, .5 = 50% dry, 50% reverb
  iMix  = .5
  outs(aBpf2 * aEnv * iMix, aBpf2 * aEnv * iMix)
  gaRvb += aBpf2 * aEnv * (1 - iMix)
endin 

instr reverb
  aL, aR  reverbsc gaRvb, gaRvb, .94, 16000
  outs(aL, aR)
  clear(gaRvb) 
endin

</CsInstruments>
;==================================
<CsScore>
i1 0 240
i"reverb" 0 245
</CsScore>
</CsoundSynthesizer>

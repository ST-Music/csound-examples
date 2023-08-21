<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
-odac     ;;;RT audio out
;-iadc    ;;;uncomment -iadc if RT audio input is needed too
; For Non-realtime ouput leave only the line below:
;-o chebyshevpoly.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

; seed for randomizing rsplines
seed 0
giSine  ftgen 0, 0, 2^14, 10, 1

instr trigger
  iNote[] fillarray 50, 51, 53, 55, 57, 58, 60, 62, 63, 65, 67, 69, 70 
  iLen  = lenarray(iNote)
  iDur  = 8 ; trigger note every iDur seconds
  kTrig = metro(1/iDur)
  ; randomly choose note from arr each time metro triggers
  kNote = int(trandom(kTrig, 0, iLen-.01)) 
  ; randomly set amplitude for each note
  kAmp  = trandom(kTrig, .03, .09)
  ; when metro triggers, send parameters to partials instr
  schedkwhen kTrig, 0, 0, "partials", 0, iDur, kAmp, iNote[kNote]
endin

instr partials
  ; these six lines control the relative powers of the harmonics
  k1    = rspline(0.5, .9, .1, 2)
  k2    = rspline(0.1, .9, .1, 2)
  k3    = rspline(0.1, .9, .1, 2)
  k4    = rspline(0.1, .8, .1, 2)
  k5    = rspline(0.1, .7, .1, 2)
  k6    = rspline(0.1, .6, .1, 2)
  k7    = rspline(0.1, .5, .1, 2)
  k8    = rspline(0.1, .4, .1, 2)
  k9    = rspline(0.1, .3, .1, 2)

  ; convert midi note numbers to cps (Hz)
  iFreq = mtof:i(p5)

  ; initial oscillator
  aX    = poscil(1, iFreq, giSine)
	
  ; waveshape it
  aY    = chebyshevpoly(aX, 0, k1, k2, k3, k4, k5, k6, k7, k8, k9)
	
  ; envelope to avoid clicks, scale final amplitude, and output
  iAmp  = p4 ; main amplitude level
  aEnv  = linsegr(0.0, 3, iAmp, p3, iAmp, 4, 0)
  aSig  = aY * aEnv
	      outs aSig, aSig

  ; reverb send level
  iRvb  = .3

  ; global reverb sends
  gaRvbL += aSig * iRvb
  gaRvbR += aSig * iRvb
endin

instr reverb
    aL, aR  reverbsc gaRvbL, gaRvbR, .93, 14000, sr, .4
            outs aL, aR
            clear gaRvbL, gaRvbR
endin

</CsInstruments>
<CsScore>
i"partials" 0  120  .07  31 ; sustain low note
i"trigger"  8  112; triggers random higher notes
i"reverb"   0  126
e
</CsScore>
</CsoundSynthesizer>

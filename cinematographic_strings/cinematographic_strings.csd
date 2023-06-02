<CsoundSynthesizer>
<CsOptions>
 -o dac   -d -m2
; -o strings.wav
</CsOptions>
;================================
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1
                   
giNotes[]   fillarray 36, 48, 44, 41, 36, 51, 48, 38

gkNote  init 0

gaChoL  init 0
gaChoR  init 0
gaRvbL  init 0
gaRvbR  init 0

giAmp   init 2.4
        seed 0

  instr trig
iLen  = lenarray(giNotes)
iDur  = 4 ; note duration in seconds
kTrig   metro 1/iDur ; trigger note every 4 seconds

    if  gkNote == iLen then
        gkNote = 0
    endif

kFreq = mtof(giNotes[gkNote])
; randomize phase every trigger event
kPhs  = trandom(kTrig, 0, 1)
; to sawPulse instr
schedkwhen kTrig, 0, 0, 1, 0, iDur, kFreq, 1, kPhs, 1
schedkwhen kTrig, 0, 0, 1, 0, iDur, kFreq * 1.002, .6, kPhs, 1.2
schedkwhen kTrig, 0, 0, 1, 0, iDur, kFreq * 0.997, .6, kPhs, .8
schedkwhen kTrig, 0, 0, 1, 0, iDur, kFreq * 1.005, .4, kPhs, 1.4
schedkwhen kTrig, 0, 0, 1, 0, iDur, kFreq * 0.994, .4, kPhs, .6
; to subFund
schedkwhen kTrig, 0, 0, 2, 0, iDur, kFreq, .1, kPhs

    if  kTrig == 1 then
        gkNote += 1
    endif

  endin

  instr 1, sawPulse
; saw(ramp)/pulse - positive side of waveform is saw/ramp, negative is square
; p4  = pitch (including detune [5-voice "unison"] 
; p5  = amp
; p6  = phase (0 - 1, randomized per trigger event) 
; p7  = pan
aEnv  = madsr(.77, 4.004, .21, .025)
iNyx  = .25 ; bandlimiting value
; pwm
kPw   = rspline(.5, .66, .3, .5) ; width of pos. part of pulse cycle, based on how wide ramp wave will be   
aPwm1 = vco2(.7, p4, 2, kPw, p6, iNyx)
kPw2  = rspline(.6, .7, .4, .6)
aPwm2 = vco2(.3, p4 * 4, 2, kPw2, p6, iNyx)
; ramp saw
aRamp = vco2(.7, p4, 20, .99, p6, iNyx)
aRmp2 = vco2(.3, p4 * 2, 20, .99, p6, iNyx)
aMix1 = dcblock2(aRamp * (aPwm1 + .7) + (aPwm1 -.7), 256)
aMix2 = dcblock2(aRmp2 * (aPwm2 + .3) + (aPwm2 -.3), 256)
kQ    = adsr(.06, 4.358, .08, .06)/7
a1,a12,a18,a24 mvclpf4 aMix1 * p5 * aEnv, 4000, .12 - kQ * .68
a2,a12,a18,a24 mvclpf4 aMix2 * p5 * aEnv, 4000, .12 - kQ * .68
iAmp  = .17 ; amp. attenuation
gaChoL  += (a1 + a2) * iAmp * p7 * giAmp
gaChoR  += (a1 + a2) * iAmp * (2 - p7) * giAmp
  endin 

  instr chorus
kMod  = lfo(3, .6) + 3
kMod2 = lfo(3, .65) + 3
aDelL = vdelay(gaChoL, 10 + kMod, 20)
aDelR = vdelay(gaChoR, 10 + kMod2, 20)

gaRvbL  = gaChoL * .65 + aDelL * .3
gaRvbR  = gaChoR * .65 + aDelR * .3

        clear gaChoL, gaChoR
  endin

  instr 2, subFund ; sub-osc & reinforce fundamental
aEnv  = madsr(1.27, 4.504, .21, 1.025)
aSub  = poscil(.04, p4/2, -1, p6) * -1
aFund = poscil(.05, p4, -1, p6) * -1
        outs (aSub + aFund) * aEnv * giAmp, (aSub + aFund) * aEnv * giAmp
  endin 

  instr reverb
aDelL = delay(gaRvbL, .33)
aDelR = delay(gaRvbR, .4)
aL,aR   reverbsc gaRvbL + aDelL, gaRvbR + aDelR, p5/100, p6*1000      
; low freq roll-off
aL    = buthp(aL, 60)
aR    = buthp(aR, 60)
; 6 dB/octave high freq roll-off
aL,a12,a18,a24 mvclpf4 aL, 3500, .01
aR,a12,a18,a24 mvclpf4 aR, 3500, .01
        outs aL, aR
        clear gaRvbL, gaRvbR
  endin

</CsInstruments>
;================================
<CsScore>
i"trig"    0   29
i"chorus"  0   40
i"reverb"  0   40   10   92   10.5
</CsScore>
</CsoundSynthesizer>
; coded by Scott Daughtrey

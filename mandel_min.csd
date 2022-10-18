<CsoundSynthesizer>
<CsLicence>
Copyright © Scott Daughtrey [ST Music]
https://soundcloud.com/stoons-1
This work is licenced under the
Creative Commons Attribution-NonCommercial-NoDerivatives
(CC BY-NC-ND 4.0)
http://creativecommons.org/licenses/by/4.0/
</CsLicence>
; formatted for easier viewing on
; mobile devices
<CsOptions>
-odac
; -o/sdcard/mandel.wav ; for Android devices
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs  = 1
    
        seed 0
gaChoL  init ; initialize Chorus send channels
gaChoR  init
gaRvbL  init ; initialize global reverb
gaRvbR  init
; ftable containing midi note #s for C#m scale
giMin       ftgen 0, 0, 0, 2, 49, 51, 52, 54, 56, 57, \
            59, 61, 63, 64, 66, 68, 69, 71, 73, 75, 76, \
            78, 80, 81, 83, 85
giDuration  ftgen 0, 0, 0, 2, -1.5, -1.25, -1, -.75, \
            -.5, -.25, 0, .25, .5, .75, 1, 1.25, 1.5
giPartials1 ftgen   0, 0, 16384, 10, .6, \
            .5, .8, .2, .3, .15, 1       
giPartials2 ftgen   0, 0, 16384, 10, .3, \
            .7, .4, .5, .17, .2, .09       

    instr Trigger 
kRand = randomh(0, 12, .25) ; create a random # between 0-12
kDur  = table(kRand, giDuration) ; randomly select a duration from giDuration 
kTrig = metro(2+kDur) ; randomly trigger mandel opcode & timing of note production
kX    = trandom(kTrig, -1.6, 0) ; randomly select X coordinates
kY    = randomh(0, 1.2, 10) ; randomly select Y coordinates
kMaxI = rspline(12, 21, .1, 3) ; randomly alter max iterations between 12-21
kIter, kOutrig mandel  kTrig, kX, kY, kMaxI
  schedkwhen kOutrig, 0, 0, "Mandel", 0, .6, p4, p5, p6, kIter ; trigger Mandel instr & send relevant parameters
    endin

    instr Mandel
iNote = table(p6+p7, giMin, 0, 0, 0) ; table uses mandel iterations to select indexed notes from giNotes ftable
print iNote
iFreq = cpsmidinn(iNote) ; convert midi note #s to cps
iRand = random(.5, .99) ; randomize amplitude & pluck position (iPlk)
kEnv  = linsegr(0, .001, .3*p4, p3, .3*p4, .5, 0)
aSig  = wgpluck2(iRand, kEnv*iRand, iFreq, .2, .3)
iPan  = random(.2, .8) ; randomize pan position
aL, aR  pan2 aSig, iPan ; pan each note
  outs aL, aR ; output stereo signal
gaRvbL  +=  aL*p5 ; send to global reverb channels
gaRvbR  +=  aR*p5
    endin

    instr TriggerPad
kTime = rspline(.005, .1, .8, .1) ; randomize duration of Pad instr   
kTrig = metro(.125)
kRndF = trandom(kTrig, 0, 6)
kFreq = table(kRndF, giMin) ;frequency ftable (giFreq)
kAmp  = trandom(kTrig, .3, 1)
        schedkwhen  kTrig, 0, 0, "Pad", \
                    0, kTime*150, kAmp*p4, p5, p6, kFreq-12
    endin

    instr Pad
kEnv  = linsegr(0, 2, p5/10, p3-3, p5/10, 3, 0) ; envelope with release
kFreq = cpsmidinn(p7) ; convert midi note #s to cps
aOsc1 = oscil(kEnv, kFreq, giPartials1) ; read partials from ftable 1
kDtun = rspline(-.7, .7, .2, 2) ; random LFO to detune Osc2 & Osc 4
aOsc2 = oscil(kEnv, kFreq+kDtun, giPartials2) ; read partials from ftable 1
aOsc3 = vco2(kEnv, kFreq) ; saw wave
aFlt1 = butbp(aOsc3, kFreq, kFreq/2) ; bandpass filter for Osc3
aOsc4 = vco2(kEnv, kFreq+kDtun) ; slightly detuned saw
aFlt2 = butbp(aOsc4, kFreq*(1/1+kDtun), kFreq/1.8) ; bandpass filter for Osc4
kMix  = rspline(0.01, 1, .01, 2) ; random LFO affecting out mix
aMix  = ntrpol(aOsc1, aFlt2, kMix) ; output mix
kMix2 = rspline(0.01, 1, .04, 2.2) ; 2nd random LFO affecting out mix
aMix2 = ntrpol(aOsc2, aFlt1, kMix2) ; random LFO affecting out mix2
kPan  = rspline(.2, .8, .01, 2) ; random LFO affecting pan
a1, a2  pan2 aMix, kPan ; random pan
a3, a4  pan2 aMix2, 1/kPan ; inverse of random pan
  outs a1 + a3, a2 + a4

gaChoL   +=  a1 + a3*p6 ;send to Chorus 
gaChoR   +=  a2 + a4*p6
gaRvbL   += (a1 + a3)*p5
gaRvbR   += (a2 + a4)*p5
    outs(a1+a3, a2+a4)
     endin
 
    instr Chorus
kMod  = rspline(5, 20, .1, .5)
aDelL = vdelay(gaChoL, kMod, 30)
aDelR = vdelay(gaChoR, 1/kMod, 30)
  outs(aDelL*p4, aDelR*p4)
gaRvbL   += aDelL*p5
gaRvbR   += aDelR*p5
   clear gaChoL, gaChoR
    endin

    instr Reverb ; reverb instrument
aL, aR reverbsc gaRvbL, gaRvbR, .93, 2^14
  outs aL, aR
   clear gaRvbL, gaRvbR
    endin

</CsInstruments>
<CsScore>
;====================Parameters====================
; "Trigger" p4=amp for Mandel instr, p5=reverb send
; p6=note offset, raising value will increase note
; range (add higher notes)
; "TriggerPad" p4=amp for Pad instr, p5=reverb send, 
; p6=chorus send
; "Chorus" p4=amp, p5=reverb send
i"Trigger"      0   3600    .7  .3   -12
i"TriggerPad"   0   3600   .65 .25    .5
i"Chorus"       0   3606     1  .5
i"Reverb"       0   3606
e
</CsScore>
</CsoundSynthesizer>
Other Links:
; https://soundcloud.com/st-csound
; https://youtube.com/channel/UCGhwmkS1uWmX6mhTIQ0IDsg

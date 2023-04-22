<CsoundSynthesizer>
<CsOptions>
-odac -m2
</CsOptions>
;================================
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

        seed  0
gkCount init -1
gkAccnt init  0
giBPM   init 90
giBeat  init 60/giBPM

instr Trig
    iDur    ftgen 0, 0, 4, -2, 4, 4, 4, 1
    kDur  = table(gkCount, iDur, 0, 0, 1)
    kTrig   metro 4/giBeat/kDur
    
        if (kTrig == 1) then
            gkCount += 1
        endif
    
    schedkwhen kTrig, 0, 0, "Clave", 0, .1

    iAcc    ftgen 0, 0, -13, -2, 1, .5, .7, .5,\
            1, .5, .7, .5, 1, .5, .7, .5, .8
    kAcc  = table(gkAccnt, iAcc, 0, 0, 1)
    kTrig2  metro 4/giBeat
    
        if (kTrig2 == 1) then
            gkAccnt += 1
        endif

    schedkwhen kTrig2, 0, 0, "Shaker", 0, .2, kAcc
endin

instr Clave
    iRamp = random(.01, .2) ;random amp
    kEnv  = transeg(0.001, 0.003, 2, .1 + iRamp, .03, 2, 0.001)
    aOsc  = oscil(kEnv, 2093)
    aOsc2 = oscil(kEnv*.1, 1318)
    aOut  = (aOsc + aOsc2)
    outs aOut, aOut
endin

instr Shaker
    kRamp = random(.6, 1) 
    kEnv  = linseg(0, .025, .3, .027, 0)
    aNoiz = noise(kEnv, -.9)
    aFlt  = butbp(aNoiz*p4*kRamp, 12000, 4000)
    outs aFlt, aFlt
endin

</CsInstruments>
;================================
<CsScore>
i"Trig"  0   32
</CsScore>
</CsoundSynthesizer>
; example by Scott Daughtrey
; https://soundcloud.com/st-csound

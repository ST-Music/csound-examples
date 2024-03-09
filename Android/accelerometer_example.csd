<CsoundSynthesizer>
<CsOptions>
-odac -m2
</CsOptions>
<CsInstruments>
sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1

; initialize global reverb
gaRvb init

instr sine
    kAccelX chnget "accelerometerX"
    kAccelY chnget "accelerometerY"
; printk 1, kAccelX
; printk 1, kAccelY
    iAmp    = .7
    kAmpMod = portk(kAccelX/30, .5)
    iFrq    = 110
    kFrqMod = portk(kAccelY * 100, .5)
    aEnv    = linsegr:a(0, 1, .8, p3, .8, 3, 0)
    aSig    = poscil(iAmp * kAmpMod * aEnv, iFrq + kFrqMod)
    outs(aSig, aSig)
    gaRvb  += aSig * .4
endin

instr reverb
    aRvbL, aRvbR reverbsc gaRvb, gaRvb, 0.94, 12000
    outs aRvbL,aRvbR
    clear gaRvb
endin

</CsInstruments>
<CsScore>
i"reverb" 0 z
i"sine"   0 z
</CsScore>
</CsoundSynthesizer>

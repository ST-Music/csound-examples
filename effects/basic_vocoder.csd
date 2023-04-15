<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
-odac
; For Non-realtime audio ouput leave only one line 
; below according to platform
; -o/sdcard/vocoder.wav
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 1
0dbfs  = 1

giSine    ftgen 0, 0, 4096, 10, 1

instr 1
    aFile   diskin "fox.wav"
    ffs1  = pvsanal(aFile, 1024, 256, 1024, 0)
    kEnv  = linseg(0, .002, 1, p3 - .004, 1, .002, 0)
    aSig  = buzz(kEnv, 50, 100, giSine)
    ffs2  = pvsanal(aSig, 1024, 256, 1024, 0)

    iDepth = 1
    iGain = 35
    iBands = 60
    fOut  = pvsvoc(ffs1, ffs2, iDepth, iGain, iBands)

    aOut    pvsynth fOut
    out     aOut
endin

</CsInstruments>
<CsScore>
i1  0   3

e
</CsScore>
</CsoundSynthesizer>

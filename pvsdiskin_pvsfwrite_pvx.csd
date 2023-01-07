<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
-odac
; For Non-realtime audio ouput leave only one line 
; below according to platform

; ANDROID: (seems to work for most Android
; devices excluding Chromebooks): 
; -o/sdcard/MyAudio/pvsfwrite.wav

; Chromebooks:
; -o/storage/emulated/0/Music/pvfswrite.wav

; for audio file output on any other platform
; -o pvsfwrite.wav -W
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 1
0dbfs  = 1
/* By Victor Lazzarini 2008 (edited by Scott Daughtrey 2022)
   edited for writing pvx files on Android 
   devices as pvanal utility doesn't seem to work */

    instr 1
aFile   diskin "fox.wav"
fAnal = pvsanal(aFile, 1024, 256, 1024, 0)
        pvsfwrite fAnal, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fAnal
        out aSynth
    endin

    instr 2 ; must be called after instr 1 finishes
kTime   timeinsts
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fPvx
        out aSynth 
    endin

    instr 3 
kTime = line(0, p3, p3)
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fPvx
        out aSynth 
    endin
    
    instr 4 
kTime = line(0, p3, p3/2)
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fPvx
        out aSynth 
    endin

    
    instr 5 
kTime = line(p3, p3, 0)
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fPvx
        out aSynth 
    endin

    instr 6 
kTime = linseg(0, 2, 3, 4, 0)
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
aSynth  pvsynth fPvx
        out aSynth
    endin
    
    instr 7
kTime = line(0, p3, p3)
fPvx    pvsfread kTime, "/storage/emulated/0/mypvs.pvx"
fShift  pvshift fPvx, 1000, 2
aSynth  pvsynth fShift
        out aSynth 
    endin
</CsInstruments>
<CsScore>
f1 0 16384 10 1
i1 0   3
i2 3   3
i3 6   3
i4 9   6
i5 15  3
i6 18  6
i7 24  6
e
</CsScore>
</CsoundSynthesizer>

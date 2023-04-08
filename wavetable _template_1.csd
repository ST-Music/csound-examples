<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1

gaRvbL  init
gaRvbR  init

; preload time necessary or tabmorphak may
; report table not found as it takes a fraction
; of a second for ftsamplebank to load the files

; preload time dependant on the speed of device/computer
  instr preload
giFirstTableNumber = 1;
giFileCount init 1
giNumFiles  ftsamplebank "/your_directory/",\
            giFirstTableNumber, 0, 0, 1        
  endin

  instr wavetable
aamp      = linseg(0, 1, p5/3, p3 - 2, p5/3, 1, 0)
; phasor speed controls frequency
aindex    = phasor(cpsmidinn(p4))
kweightpoint = 0
ktabnum1  = linseg(0, p3, giNumFiles - 1)
ktabnum2  = ktabnum1
asig 	    tabmorphak aindex, kweightpoint,\
            ktabnum1,ktabnum2, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, \
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20, \
            21, 22, 23, 24, 25, 26, 27, 28, 29, 30, \
            31, 32, 33, 34, 35, 36, 37, 38, 39, 40, \
            41, 42, 43, 44, 45, 46, 47, 48, 49, 50, \
            51, 52, 53, 54, 55, 56, 57, 58, 59, 60, \
            61, 62, 63, 64, 65, 66, 67, 68, 69, 70, \
            71, 72, 73, 74, 75, 76, 77, 78, 79, 80, \
            81, 82, 83, 84, 85, 86, 87, 88, 89, 90, \
            91, 92, 93, 94, 95, 96, 97, 98, 99, 100

aOut  = asig*aamp
outs    aOut, aOut

gaRvbL += aOut * .2
gaRvbR += aOut * .2
  endin

  instr print
print giNumFiles    
  endin

  instr reverb
aL,aR   reverbsc gaRvbL, gaRvbR, .88, 12000
outs  aL, aR
clear gaRvbL, gaRvbR
  endin

  instr monitor, record ;read the stereo csound output buffer
allL, allR monitor
; write the output of csound to an audio file
; wav file: 14 = 16 bits with header
;           16 = 32 bits
;           fout "/sdcard/wavetable.wav", 14, allL, allR
  endin

</CsInstruments>
<CsScore>

i"preload"    0     1
i"print"     .5     1
i"reverb"     0    40
i"monitor"    0    40
;                     note amp
i"wavetable"  1    30  48  .25
i.           32     5   .    .
e
</CsScore>
</CsoundSynthesizer>
; written by Scott Daughtrey/ST Music
; https://soundcloud.com/st-csound
; https://soundcloud.com/stoons-1
; https://youtube.com/channel/UCGhwmkS1uWmX6mhTIQ0IDsg

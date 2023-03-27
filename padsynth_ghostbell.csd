<CsoundSynthesizer>
<CsOptions>
-odac -m0
; -o/sdcard/ghost_bell.wav -3 --format=wav:float ; 32 bit float
</CsOptions>
<CsInstruments>

sr  = 44100
ksmps  = 32
nchnls  = 2
0dbfs   = 1

gaDelL  init
gaDelR  init

gaRvbL  init
gaRvbR  init

	instr GhostBell, 2

; iBaseHz = 284.76252 ; for 48000
iBaseHz = 261.625565 ; middle C

                                                                                
;                 p1 p2  p3      p4         p5       p6  p7  p8  p9  p10                   
iPadSyn ftgenonce 0, 0, 2^18, "padsynth", iBaseHz,   p6,  2,  1, 1,  1,   \  
                  0,.03, .0, .8,  0, .2,  0, .2,  0,.02,  0,.03,  0,.02,  0,.04      
;                 R   R   5   R   3   5  b7   R   9   3  b5   5  #5   6  b7   R       
                                                                                

aEnv  = madsr(.002, .4, .3, 1)
iFreq = cpsmidinn(p4)
aSig  = poscil(p5 * aEnv, iFreq*(sr/2^18/iBaseHz), iPadSyn)
aL, aR  pan2 aSig*.9, 0.5

gaDelL  += aL * .35
gaDelR  += aR * .35
gaRvbL  += aL * .12
gaRvbR  += aR * .12
  outs aL, aR
    endin

    instr Delay
aDelL = multitap(gaDelL, p5, .95, p5*3, \
                .70, p5*5, .43, p5*7, .15)
aDelR = multitap(gaDelR, p5*2, .83, p5*4, \
                .57, p5*6, .31, p5*8, .05)
  outs aDelL*p4, aDelR*p4
   clear gaDelL, gaDelR
    endin


    instr Reverb
aL,aR   reverbsc gaRvbL, gaRvbR, .94, 12000
  outs aL, aR
   clear gaRvbL, gaRvbR
    endin

</CsInstruments>
<CsScore>
i"Delay" 0 192 1 .75
;b+200
i2  0     .15  60   .7   1
i2  0.5    .   64   .    3
i2  0.75   .   60   .    3
i2  1      .   61   .    3
i2  1.5    .   65   .    5
;b+16
i2 16     .15  60   .    1
i2 16.5    .   64   .    3
i2 16.75   .   60   .    3
i2 17      .   61   .    3
i2 17.5    .   65   .    5
;b+32
i2 32     .15  60   .    1
i2 32      .   72   .5   1
i2 32.5    .   64   .7   3
i2 32.75   .   60   .    3
i2 33      .   61   .    3
i2 33.5    .   65   .    5
;b+40
i2 40     .15  65   .    1
i2 40.5    .   61   .    3
i2 40.75   .   65   .    3
i2 41      .   64   .    3
i2 41      .   72   .5   1
i2 41.5    .   60   .7   5
;b+72
i2 72     .15  60   .    1
i2 72      .   72   .5   1
i2 72.5    .   64   .7   3
i2 72.75   .   60   .    3
i2 73      .   61   .    3
i2 73.5    .   65   .    5
;b+80 
i2 80     .15  64   .    1
i2 80.5    .   68   .7   3
i2 80.75   .   64   .    3
i2 81      .   65   .    3
i2 81.5    .   69   .    5
;b+88
i2 88     .15  60   .    1
i2 88      .   72   .5   1
i2 88.5    .   64   .7   3
i2 88.75   .   60   .    3
i2 89      .   61   .    3
i2 89.5    .   65   .    5
;b+96
i2 96     .15  65   .    1
i2 96.5    .   61   .    3
i2 96.75   .   65   .    3
i2 97      .   64   .    3
i2 97      .   72   .5   1
i2 97.5    .   60   .7   5
;b+104
i2 104    .15   60   .    1
i2 104      .   72   .5   1
i2 104.5    .   64   .7   3
i2 104.75   .   60   .    3
i2 105      .   61   .    3
i2 105.5    .   65   .    5
;b+112 
i2 112     .15  64   .    1
i2 112.5    .   68   .    3
i2 112.75   .   64   .    3
i2 113      .   65   .    3
i2 113.5    .   69   .    5
;b+120
i2 120    .15   60   .    1
i2 120      .   72   .5   1
i2 120.5    .   67   .7   3
i2 121      .   68   .    3
i2 121.5    .   65   .    3
;b+128
i2 128    .15   67   .    1
i2 128.5    .   63   .7   3
i2 129      .   65   .    3
i2 129.5    .   60   .    1
i2 129.5    .   72   .5   2
;b+152
i2 152    .15   60   .7   1
i2 152      .   72   .5   1
i2 153    .15   61   .7   1
i2 153      .   73   .5   3
i2 154    .15   58   .7   1
i2 154      .   70   .5   3
i2 155    .15   60   .7   1
i2 155      .   72   .5   3
;b+160
i2 160    .15   67   .7   1
i2 161      .   63   .    3
i2 162      .   62   .    3
i2 163    .15   60   .    1
i2 163      .   72   .5   .
;b+168
i2 168    .15   60   .7   1
i2 168      .   72   .5   1
i2 169    .15   61   .7   1
i2 169      .   73   .5   1
i2 170    .15   58   .7   1
i2 170      .   70   .5   1
i2 171    .15   60   .7   1
i2 171      .   72   .5   1
;b+176
i2 176    .15   63   .7   1
i2 177    .15   67   .    3
i2 178      .   71   .    2
i2 178    .15   59   .5   2
i2 179      .   72   .7   1
i2 179    .15   60   .5   1

i"Reverb" 0 192

e
</CsScore>
</CsoundSynthesizer>

<CsoundSynthesizer>
<CsOptions>
-o dac
;-o/sdcard/talbot.wav
</CsOptions>
;================================
<CsInstruments>

sr = 44100
ksmps =  1
nchnls = 2
0dbfs  = 1

gaRvbL  init
gaRvbR  init
giSine  ftgen 1, 0, 4096, 10, 1

    instr 1
kX  init 0
kX  = p6
kRx init 0
kRx = line(p7, p3, p8)
kY  init 0
kY  = p9
kRy init 0
kRy = line(p10, p3, p11)
kFreq = cpspch(p4)
kSin  = oscil:k(1, kFreq)
kCos  = oscil:k(1, kFreq, -1, .25)
kCprm = line(p14, p3, p15)
kXvar = kX + kRx * kCos * (1 + kCprm * kSin^2)
; fx(t) = kx + krx * cos(t) * (1 + kcurveparam * sin(t)*sin(t))
kYvar = kY + kRy * kSin * (1 - kCprm - kCprm * kCos^2)
; fy(t) = ky + kry * sin(t) * (1 - kcurveparam - kcurveparam*cos(t)*cos(t)) 
kEnv  = linseg(0, 2, p5/2, p3-4, p5/2, 2, 0)
a1    = wterrain(kEnv, kFreq, kXvar, kYvar,\
        kRx, kRy, p12, p13)  
aSig    = dcblock(a1)
gaRvbL  += aSig*.22
gaRvbR  += aSig*.22
  outs  aSig, aSig
    endin 

    instr Reverb
aL,aR   reverbsc gaRvbL, gaRvbR, .92, 10000
  outs aL, aR
   clear gaRvbL, gaRvbR
    endin

</CsInstruments>
;=======================================================     
<CsScore>
; p4=pitch, p5=amp, p6=X center, p7=X radius min,   
; p8=X radius max, p9=Y center, p10=Y radius min, 
; p11=Y radius max, p12=table 1, p13=table 2, 
; p14=curve start param., p15=curve end param.
                                                         
;        p4  p5  p6  p7  p8  p9  p10 p11 p12 p13 p14 p15  
i1 0 10 6.00 .7  .5  .5  .5  .2  .5  .5   1   1   .5  .5
i1 +  .  .   .   .   .   .   .   .   .    .   .   .8  .8 
i1 +  .  .   .   .   .   .   .   .   .    .   .    1   1
i1 +  .  .   .   .   .   .   .   .   .    .   .  1.5 1.5
i1 +  .  .   .   .  0.1 1.9  .   .   .    .   .   .5  .5 
i1 +  .  .   .   .   .5  .5  .   .1  .9   .   .    .   .
i1 +  .  .   .   .   .   .   .   .5  .5   .   .    . 1.5 
i1 +  .  .   .   .   .   .   .   .   .    .   .  1.5  .5
i1 +  .  .   .   .  0.1 1.9  .   .1  .9   .   .   .5 1.5
i1 +  .  .   .   .  0.1 1.9  .   .1  .9   .   .  1.5 1.5
i1 +  .  .   .   .  1.9 1.9  .   .9  .9   .   .   .5 1.5
i"Reverb" 0 115
e
</CsScore>
</CsoundSynthesizer>
; Scott Daughtrey [ST Music]
; https://soundcloud.com/stoons-1
; https://soundcloud.com/st-csound

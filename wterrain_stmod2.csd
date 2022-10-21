<CsoundSynthesizer>
<CsOptions>
-o dac
;-o/sdcard/xxxxxxxx.wav
</CsOptions>
;================================
<CsInstruments>
sr = 44100
ksmps =  1
nchnls = 2
0dbfs  = 1
        
        seed 0    
gaRvbL  init
gaRvbR  init
giSine  ftgen 1, 0, 4096, 10, 1

    instr 1
kX  init 0
kX  = p7
kRx init 0
kRx = rspline(0.1, 1.9, .1, 1)
kY  init 0
kY  = p8
kRy init 0
kRy = rspline(.2, .8, .2, .99)
kFreq = cpspch(p4)
kSine = oscil:k(1, kFreq)
kCos  = oscil:k(1, kFreq, -1, .25)
        seed 1
kCprm = rspline(.01, .8, .01, 1.2)
kXvar = kX + kRx * kSine * (kCos + kCprm)
; fx(t) = kx + krx * sin(t) * (cos(t) + kcurveparam)
kYvar = kY + kRy * kCos * (kCos + kCprm)
; fy(t) = ky + kry * cos(t) * (cos(t) + kcurveparam)
kEnv  = linseg(0, 2, p5/2, p3-4, p5/2, 2, 0)
a1    = wterrain(kEnv, kFreq, kXvar, kYvar,\
        kRx, kRy, p9, p10)  
aSig  = dcblock(a1)
aL,aR   pan2 aSig, p6
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
; p4=pitch, p5=amp, p6=pan pos, p7=X center,   
; p8=Y center, p10=table 1, p12=table 2    
                                                                 
;         p4     p5  p6  p7  p8  p9  p10 
i1 0 120 5.001   .4  .6  .5  .2   1   1   
i1 0 120 5.00    .4  .4  .5  .2   1   1   
i1 0 120 6.00    .3  .7  .5  .2   1   1   
i1 0 120 6.001   .3  .3  .5  .2   1   1   

i"Reverb" 0 125
e
</CsScore>
</CsoundSynthesizer>
; Scott Daughtrey [ST Music]
; https://soundcloud.com/stoons-1
; https://soundcloud.com/st-csound
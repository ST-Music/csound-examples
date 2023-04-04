<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
-odac     ;;;realtime audio out
;-iadc    ;;;uncomment -iadc if realtime audio input is needed too
; For Non-realtime ouput leave only the line below:
;-o/sdcard/tabmorphak.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

seed 0
; harmonic partials
giRoot  ftgen	0, 0, 8192, 10, 1 
gi5th   ftgen	1, 0, 8192, 10, 0, 0, 1             
gi3rd   ftgen	2, 0, 8192, 10, 0, 0, 0, 0, 1
; flat (dominant) 7th
gib7th	ftgen	3, 0, 8192, 10, 0, 0, 0, 0, 0, 0, 1 
	
instr	1
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
; phasor speed determines pitch
aindex	  = phasor(110)
; kweightpoint equally divided between
; ktablenum1 & ktablenum2
kweightpoint = .5
; ktabnum1 equally combining 
; table 0 (Root) & table 1 (5th)
ktabnum1  = .5
; ktabnum2 equally combining
; table 2 (5th) & table 3 (3rd)
ktabnum2  = 2.5
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot, gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
	
outs    asig, asig
endin

instr	2
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
aindex	  = phasor(110)
; ktabnum1 only, ktabnum2 values irrelevant
kweightpoint = 0
; ktabnum1 morphing between Root & 5th
ktabnum1  = rspline(.1, .9, .5, 1)
; silent due to kweightpoint of 0
ktabnum2  = 2.5
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot,  gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
outs    asig, asig
endin

instr	3
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
aindex	  = phasor(110)
; ktabnum2 only
kweightpoint = .99
; ktabnum1 silent due to kweightpoint
ktabnum1  = .5
; ktabnum2 morphing between 3rd & 7th
ktabnum2  = rspline(2.1, 2.9, .5, 1)
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot, gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
outs    asig, asig
endin

instr	4
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
aindex	  = phasor(110)
; kweightpont morphing between Root (ktablenum1)
; & 3rd ktablenum2
kweightpoint = rspline(0.1, .9, 0.5, 1)
; ktabnum1 = Root
ktabnum1  = 0
; ktabnum2 = 3rd
ktabnum2  = 2
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot, gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
outs    asig, asig
endin

instr	5
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
aindex	  = phasor(110)
; kweightpoint morphing between 
; ktablenum1 & ktablenum2
kweightpoint = rspline(0.1, .9, 0.5, 1)
; ktabnum1 = 5th
ktabnum1  = 1
; ktabnum2 7th
ktabnum2  = 3
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot, gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
outs    asig, asig
endin

    instr 6
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
; phasor speed determines pitch
aindex	  = phasor(110)
; kweightpont morphing between ktablenum1 & ktablenum2
kweightpoint = rspline(.1, .9, .5, 1)
; ktabnum1 morphing between Root & 5th
ktabnum1  = rspline(.1, .9, .5, 1)
; ktabnum2 morphing between 3rd & 7th
ktabnum2  = rspline(2.1, 2.9, .5, 1)
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, giRoot, gi5th, gi3rd, gib7th)     
asig	  = asig*kamp
outs    asig, asig
    endin


</CsInstruments>
<CsScore>
i1  0  10 ; Roor, 3rd, 5th, flat7th
i2 10  20 ; morph Root, 5th
i3 30  20 ; morph 3rd, flat7th
i4 50  20 ; morph Root, 3rd
i5 70  20 ; morph 5th, 7th
i6 90  20 ; morph all 4 notes
e
</CsScore>
</CsoundSynthesizer>
example written by Scott Daughtrey
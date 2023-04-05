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
gi1 ftgen   0, 0, 8192, 10, 1 
gi2 ftgen	1, 0, 8192, 10, 0, 1             
gi3 ftgen	2, 0, 8192, 10, 0, 0, 1
gi4 ftgen	3, 0, 8192, 10, 0, 0, 0, 1 
gi5 ftgen	4, 0, 8192, 10, 0, 0, 0, 0, 1
gi6 ftgen	5, 0, 8192, 10, 0, 0, 0, 0, 0, 1
gi7 ftgen	6, 0, 8192, 10, 0, 0, 0, 0, 0, 0, 1 
gi8 ftgen	7, 0, 8192, 10, 0, 0, 0, 0, 0, 0, 0, 1 

    instr 1
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
; phasor speed determines pitch
aindex	  = phasor(110)
; kweightpoint of 0 means only ktabnum1
; is audible
kweightpoint = 0
; ktabnum1 moving forwards thru all 8 tables
ktabnum1  = linseg(0, 1, 0, p3-2, 7, 1, 7)
; since weightpoint is 0, value of ktabnum2
; is irrelevant
ktabnum2  = 0
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, gi1, gi2, gi3, \
            gi4, gi5, gi6, gi7, gi8)   
asig	  = asig*kamp
outs    asig, asig
    endin

    instr 2
kamp	  = linseg(0, 1, .8, p3 - 2, .8, 1, 0)
aindex	  = phasor(110)
; kweightpoint evenly combining ktablenum1 & ktablenum2
kweightpoint = .5
; ktabnum1 moving forwards thru all 8 tables
ktabnum1  = linseg(0, 1, 0, p3-2, 7, 1, 7)
; ktabnum2 moving backwards thru all 8 tables
ktabnum2  = linseg(7, 1, 7, p3-2, 0, 1, 0)
asig 	  = tabmorphak(aindex, kweightpoint, \
            ktabnum1, ktabnum2, gi1, gi2, gi3, \
            gi4, gi5, gi6, gi7, gi8)   
asig	  = asig*kamp
outs    asig, asig
    endin

</CsInstruments>
<CsScore>
i1   0  20
i2  20  20
e
</CsScore>
</CsoundSynthesizer>
; example by Scott Daughtrey

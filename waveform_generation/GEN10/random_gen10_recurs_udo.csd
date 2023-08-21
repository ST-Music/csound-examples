<CsoundSynthesizer>
<CsOptions>
 -odac -d -m2
; -o  rand_gen10_udo.wav

; written by Scott Daughtrey, 2023
; https://soundcloud.com/st-csound
; https://youtube.com/@stmusic2164

</CsOptions>
;==================================
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1

gaRvb       init 0

            seed 0
giTabNum    init 1 ; starting index for wavetable
giMorf      ftgen 0, 0, 4096, 10, 1
; iterations for UDO (number of partial tables
; that will be created) 
giIter      init 16
; wavetable containing the index (table number)
; for each partial table created
giWavetable ftgen 0, 0, giIter, -2, \
            1, 2, 3, 4, 5, 6, 7, 8, \
            9, 10, 11, 12, 13, 14, 15, 16

; UDO to create multiple partial tables which together
; form a larger wavetable that can be utilized with
; ftmorf or one of the tabmorph opcodes
opcode genTable, i, i
  iIter xin

    if  iIter > 1 then
        iIter genTable iIter - 1
    endif

; randomly generate values for the strengths
; of 12 partials
  iPrt1   = random(0, 1)
  iPrt2   = random(0, 1)
  iPrt3   = random(0, 1)
  iPrt4   = random(0, 1)
  iPrt5   = random(0, 1)
  iPrt6   = random(0, 1)
  iPrt7   = random(0, 1)
  iPrt8   = random(0, 1)
  iPrt9   = random(0, 1)
  iPrt10  = random(0, 1)
  iPrt11  = random(0, 1)
  iPrt12  = random(0, 1)
  
  giTable ftgen giTabNum, 0, 4096, 10, \
                iPrt1, iPrt2, iPrt3, iPrt4, \
                iPrt5, iPrt6, iPrt7, iPrt8, \
                iPrt9, iPrt10, iPrt11, iPrt12
  giTabNum += 1
  xout iIter
endop

; instr to call the UDO
instr gen_tables
  iNull genTable giIter
endin

instr trigger
  iDur = 12 ; note duration in seconds
  kTrig = metro(1/iDur)
  schedkwhen kTrig, 0, 0, "partials", 0, iDur
endin

instr partials
; randomize the starting index & speed/direction to read
; thru partials wavetable individually for each note
; played

; kNdx value can be higher than 15 as ftmorf will wrap
; from index 15 (table 16) back to index 0 (table 1)
; whenever the index >= 16 (hence the purpose of allowing
; max. rspline values of > 16)

; ie. kNdx 0 = kNdx 16, kNdx 17 = kNdx 1 etc.

; this also allows "wrapping in reverse" if,
; during the duration of a note, the kNdx value is > 16
; and then falls below 

  kNdx  = rspline(0.3, 32, .05, .2)
  printk 1, kNdx ; print kNdx values once per second
  ftmorf  kNdx, giWavetable, giMorf
  iFreq = int(random(24, 72)) ; randomize note frequency
  aSig  = poscil:a(linsegr:a(0, p3/3, .25, p3, \
          .25, p3, 0), mtof(iFreq), giMorf)
;         outs aSig, aSig
          
  gaRvb += aSig * .7
endin

instr reverb
  aL, aR  reverbsc gaRvb, gaRvb, .97, 14000, sr, .6   
          outs  aL, aR
          clear gaRvb
endin

</CsInstruments>
;==================================
<CsScore>
i"gen_tables" 0  .01
i"trigger"    1  150
i"reverb"     0  185
</CsScore>
</CsoundSynthesizer>

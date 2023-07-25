<CsoundSynthesizer>
<CsOptions>
-odac -m2
; -o wguide1_dur_48000.wav
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs  = 1

gkCnt   init 0
        seed 0

instr trig
  kNote[] fillarray 33, 40, 45, 52, 57, 64, 69
  kLen  = lenarray(kNote)
  kTrig = metro(.2)
  kFreq = mtof(kNote[gkCnt])
  schedkwhen kTrig, 0, 0, 2, 0, 5, kFreq

    if  kTrig == 1 then
        gkCnt += 1
    endif

    if  gkCnt == kLen then
        gkCnt  = 0
    endif

endin

instr 2     
  aEnv  = expseg:a(1, .1, .0001)
  aSig  = noise(2 * aEnv, 0.99)
  kFreq = p4
; kDur affects general duration of notes
; by exponentially raising cutoff relative
; to note frequency
; in this case, when the highest note (A440)
; is played, the cutoff is 22kHz
  iDur  = 50 ; affects general duration
  kCut  = p4 * iDur ; filter cutoff freq.
  print   p4 ; prints note freq.
  print   p4 * iDur ; prints cutoff freq.
; kRtio = duration of lower vs higher freq
; ex. value of .5 will increase dur. of high notes vs low
;     value of .01 will decrease dur. of higher notes vs low
  iRtio = .5
; prints feedback value
  print .992 + (.006 - (.6/p4 * iRtio))
  kFbk  = 0.992 + (.006 - (.6/kFreq * iRtio))
  aWg1  = wguide1(aSig, kFreq, kCut, kFbk)
  aOut  = dcblock2(aWg1)
          outs aOut, aOut

endin

</CsInstruments>
<CsScore>
i"trig"  0  70
e
</CsScore>
</CsoundSynthesizer>

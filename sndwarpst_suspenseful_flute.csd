<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

/* the name of the soundfile used is defined
   as a string variable as it will be used 
   twice in the code. This simplifies adapting
   the orchestra to use a different soundfile */
gSfile = "flute.wav"

; waveform used for granulation
giSound ftgen 1,0,0,1,gSfile,0,0,0

; window function - used as an amplitude envelope for each grain
giWFn   ftgen 2,0,16384,9,0.5,1,0

seed 0 ; seed the random generators from the system clock
gaSendL init 0  ; initialize global reverb send variables
gaSendR init 0

  instr Trigger ; triggers instrument 2
kRndTime  = randomh(1/3,1/12,4) ; randomize note generation
ktrigger    metro kRndTime
kRand     = trandom(ktrigger,6,12) ; randomizenote lengths
schedkwhen  ktrigger,0,0,"Sndwarpst",0,kRand ;trigger instr. 2
  endin

  instr Sndwarpst ; generates granular synthesis textures
  ;define the input variables
ifn1      = giSound
ilen      = nsamp(ifn1)/sr
iPtrStart = random(1,ilen-1)
iPtrTrav  = random(-1,1)
ktimewarp = line(iPtrStart,p3,iPtrStart+iPtrTrav)
kamp      = linsegr(0,4,0.1,p3-6,0.1,8,0)
iresample = random(-42, 6.99)
iresample = semitone(int(iresample))
ifn2      = giWFn
ibeg      = 0
iwsize    = random(400,10000)
irandw    = iwsize/3
ioverlap  = 14
itimemode = .3

; create a stereo granular synthesis texture using sndwarp
aSigL,aSigR sndwarpst   kamp*.6,ktimewarp,iresample,ifn1,ibeg,\
                        iwsize,irandw,ioverlap,ifn2,itimemode
; send to reverb
gaSendL  += aSigL * 0.48
gaSendR  += aSigR * 0.6
                    
; main stereo output
outs    aSigL * .8,aSigR
  endin

  instr Reverb
aRvbL,aRvbR reverbsc    gaSendL,gaSendR,0.92,12000
            outs        aRvbL,aRvbR
            clear       gaSendL,gaSendR
  endin

  instr Record ;read the stereo csound output buffer
allL, allR  monitor
; write the output of csound to an audio file
; wav file: 16 bits with header
fout "/sdcard/sndwarpst9.wav",16,allL,allR
  endin

</CsInstruments>
<CsScore>
;   p1    p2   p3
i"Trigger" 0   47 ; triggers instr 2
i .       57   60
i .      124   50
i"Reverb"  0  202 ; reverb instrument
;i"Record"  0  203 ; record instrument
</CsScore>
</CsoundSynthesizer>
; original example written by Iain McCurdy
; see FLOSS manual 05G09_selfmade_grain.csd
; slightly modified by Scott Daughtrey

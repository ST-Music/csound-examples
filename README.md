# csound-examples
Various Csound examples

pvsdiskin_pvsfwrite_pvx.csd :
Modified to write pvx files to Android devices using the pvsfwrite opcode as the standard command line utility doesn't seem to work properly.

The general goal here is to see if converting audio to pvx separately and subsequently using pvsread for a pre-written pvx file into a different csd reduces the cpu load when using pvsynth etc. as then pvsanal is not necessary in realtime.


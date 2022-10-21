If you can use the wterrain2 and sterrain opcodes this is probably of no interest. 

Using Android for Csound, found wterrain2 and sterrain opcodes do not work (wterrain2 is unstable and sterrain is not recognized). So decided to try and apply some of the curves/shapes available with the extended opcodes to wterrain, in this case a limacon. wterrain_st_comp simply compares a single note of the standard wterrain vs 4 notes using different "curve parameters" as described in the manual for wterrain2. 

I have no way to visualize or confirm what's going on here to know if it's working the way I'm hoping so I have to judge based on sound comparison to the standard opcode. 

wterrain_stmod1 uses the limacon formula but applies some changes to the parameters via the score, for example altering the X and/or Y radius, or the curve param., seperately and together. 

wterrain_stmod2 again uses the formula to create a pad texture, with several rsplines functioning like random LFOs to affect a few parameters. 

NOTE: the Canonical reference manual entry for wterrain2 has a few mistakes, duplicate formulas for limacron and cornoid as well as trisectrix and scarabeus. 

docB has kindly clarified the correct formula for cornoid is: 

fx(t) = kx + krx * cos(t) * cos(2*t) 

fy(t) = ky + kry * sin(t) * (kcurveparam + cos(2*t))

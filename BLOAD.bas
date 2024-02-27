 10 REM ******* Bruce Lee *******   
 20 REM .........................     
 30 *FX 200 3
 40 IF !&FFFC<>&DC1CD9CD THEN PRINT''"This program is only suitable for":PRINT'"a model B BBC micro with OS 1.20":END
 50 !&70=RND(&93FBA722)
 60 $&700="A920A2FDA0446CAD30"
 70 MODE7:VDU23;11;0;0;0;:PRINTTAB(10,0)"U.S. Gold presents":FORA%=1TO2:PRINTTAB(10,A%)CHR$141"B R U C E  L E E":NEXT:PRINTTAB(9)"````````````````````":ONERRORGOTO450
 80 PRINTTAB(7)"BBC version by D. Cowham"
 90 PRINTTAB(8)"    for Micro Power"
100 PRINTTAB(8)" (C) 1985 Datasoft Inc."
110 FORA%=1TO5000:NEXT:*FX200,2
120 PRINT
130 PRINT"Guide Bruce Lee to discover Immortalityby beating the evil wizard and his     minions."
140 PRINT"Bruce must explore the play area       picking up lanterns, which will open   up new areas for him to explore."
150 PRINT"The evil wizard's troops attack you in the form of The Green Yamo (fat guy)   and The Ninja (little guy). However,   Bruce can dispatch these by kicking or punching them (stand still and fire"
160 PRINT"for punch, run and fire for kick)."
170 PRINT"Later screens get more complicated withkiller bugs, swords, moving walls and  mines to contend with!"
180 PRINTTAB(4,24);"Press Space-bar to continue";:*FX15
190 REPEATUNTILGET=32:FORA%=23TO7 STEP-1:PRINTTAB(0,A%)"                                        ";:*FX19
200 NEXT
210 PRINT"An opulent, mysterious, and perilous   fortress is the setting as Bruce Lee   seeks to claim infinite wealth and the secret of immortality from the wizard  who dwells within."
220 PRINT"Throughout your search for the wizard, you are attacked by the ninja who      brandish their BOKKEN sticks. Even moredangerous is the Yamo, who runs after  you and delivers crushing kicks."
230 PRINT"Duck and run away to foil their        attempts to harm you, then come back   kicking and chopping - the Yamo can    survive only three blows and the ninja can survive only two."
240 *FX15
250 REPEATUNTILGET=32:FORA%=23TO7 STEP-1:PRINTTAB(0,A%)"                                        ";:*FX19
260 NEXT
270 PRINT"To get around each room, you can climb vines (up, down, or sideways), leap    from ledge to ledge, and jump down froma ledge without injury."
280 PRINT"Hazards and traps await you in rooms   close to the wizard's chamber."
290 PRINT"You must avoid electrical charges      passing through gaps between ledges,   PAN lights streaming across the floor, and exploding T'SUNG-LIN (bushes)      appearing from nowhere."
300 PRINT"When you finally reach the wizard, keepaway from the fire balls streaming fromhis eyes. Destroy the wizard - and his fortunes are yours!"
310 PRINTTAB(4,24);"Press Space-bar to continue";:*FX15
320 REPEATUNTILGET=32:FORA%=23TO7 STEP-1:PRINTTAB(0,A%)"                                        ";:*FX19
330 NEXT
340 PRINT"Lantern...........................125"
350 PRINT"Chopping ninja or Yamo............100"
360 PRINT"Kicking ninja or Yamo..............75"
370 PRINT"Entering new room................2000"
380 PRINT"Knocking out ninja................200"
390 PRINT"Knocking out Yamo.................450"
400 PRINT"Destroying wizard................3000"
410 PRINT"Landing on ninja or Yamo...........50"
420 PRINTTAB(4,24);"Press Space-bar to Load Game";:*FX15
430 REPEATUNTILGET=32:PRINTTAB(4,24);"                              ";
440 I=INKEY(150):*FX15,1
450 *FX200,3
460 CLS          
470 PAGE=&1100
480 CHAIN"BRUCE0"
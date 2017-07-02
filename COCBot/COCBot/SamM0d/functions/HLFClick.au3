; #FUNCTION# ====================================================================================================================
; Name ..........: HLFClick v0.4
; Description ...: Implemental Advanced Random Click On The Button Area Like Human
;                  Even we already set to Random Click, but some button like Returm Home, Surrender, Those Still Click on same pixel.
;                  Since Mybot is an open source program, if Supercell need make spy on it,
;                  away click will be the high risk for SC Psychic Octopus looking for, not human can be click at the same pixel at x1,y40
;
;                  With old method of remove troops all fast tempo click at same pixel, so here i also randomize it
;				   Re-Define all the button region, and random click inside the button region
;				   I know this is not efficient for the code CheckClickMsg using string to check the what is click, but as a mod the only way for easy maintain to upgrade if got new official release XD
;                  From the official release, i still found out some click use the same debug code #
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Samkie (31 Dec 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Global $aButtonClose1[9] 	= [817, 84  + $midOffsetY, 836, 104 + $midOffsetY, 824, 91  + $midOffsetY, 	0xFFFFFF, 10, "=-= Close Train [X]"] ; Train window, Close Button
Global $aButtonClose2[9]    = [755, 76  + $midOffsetY, 775, 96  + $midOffsetY, 764, 84  + $midOffsetY,  0xFFFFFF, 10, "=-= Close Setting [X] | Def / Atk Log [X]"] ; Def / Atk log window / setting window, Close Button
Global $aButtonClose3[9]   	= [815, 35  + $midOffsetY, 836, 60  + $midOffsetY, 826, 43  + $midOffsetY,  0xFFFFFF, 10, "=-= Close Profile/League [X]"] ; Profile / League page, Close Button
Global $aButtonClose4[9]    = [620, 150 + $midOffsetY, 642, 170 + $midOffsetY, 632, 158 + $midOffsetY, 	0xFFFFFF, 10, "=-= Close Shield Info [X]"] ; PB Info page, Close Button
Global $aButtonClose5[9] 	= [806, 27               , 828, 52               , 817, 37               ,  0xFFFFFF, 10, "=-= Close Shop [X]"] ; Shop, Close Button  / Same area with map editor close button
;Global $aButtonClose6[9]	= [666, 135 + $midOffsetY, 685, 155 + $midOffsetY, 680, 142 + $midOffsetY, 	0xFFFFFF, 10, "=-= Close Achievements [X]"] ; Main Page, Achievement Close Button
Global $aButtonClose6[9]    = [790, 25               , 818, 48               , 804, 33               , 	0xFFFFFF, 10, "=-= Close Launch Attack [X]"] ; Launch Attack Page, Close Button
Global $aButtonClose7[9]    = [720, 104 + $midOffsetY, 738, 125 + $midOffsetY, 730, 112 + $midOffsetY, 	0xFFFFFF, 10, "=-= Close Laboratory [X]"] ; Laboratory Page, Close Button
Global $aButtonClose8[9]	= [780, 185              , 835, 250              , 0  , 0                , 	0x0     ,  0, "=-= Random Away Coordinate"]

;~ ; ScreenCoordinates - first 4 values store the region [x1,y1,x2,y2] that can click; values 5,6,7,8 is the color check pixel x,y,color,tolerance level for confirm the button exist if needed.
Global $aButtonOpenTrainArmy[9]  	  	  = [20 , 540 + $midOffsetY, 55 , 570 + $midOffsetY, 50 , 537 + $midOffsetY, 	0xE1A339, 20, "=-= Open Train Army Page"] ; Main Screen, Army Train Button
Global $aButtonOpenProfile[9]    	  	  = [28 , 23               , 46 , 46               , 38 , 18               ,    0x10D0F0, 20, "=-= Open Profile Page"] ; Main page, Open Profile Button
Global $aButtonOpenShieldInfo[9] 	  	  = [430, 7                , 442, 20               , 435, 14               ,    0xE8E8E0, 20, "=-= Open Shield Info Page"] ; main page, open shield info page
Global $aButtonOpenLaunchAttack[9] 		  = [30 , 610 + $midOffsetY, 90 , 670 + $midOffsetY, 22 , 644 + $midOffsetY, 	0x9A4916, 30, "=-= Open Launce Attack Page"] ; Main Page, Attack! Button

Global $aButtonClanWindowOpen[9]   	      = [8  , 325 + $midOffsetY, 28 , 380 + $midOffsetY, 16 , 380 + $midOffsetY, 	0xB84408, 20, "=-= Open Chat Window"] ; main page, clan chat Button
Global $aButtonClanWindowClose[9]  	      = [321, 325 + $midOffsetY, 342, 380 + $midOffsetY, 330, 380 + $midOffsetY, 	0xB84408, 20, "=-= Close Chat Window"] ; main page, clan chat Button
Global $aButtonClanChatTab[9]    	  	  = [175, 14               , 275, 30               , 280, 30               ,    0x706C50, 20, "=-= Switch to Clan Channel"] ; Chat page, ClanChat Tab
Global $aButtonClanDonateScrollUp[9] 	  = [289, 69  + $midOffsetY, 299, 83  + $midOffsetY, 293, 73  + $midOffsetY,  	0xFFFFFF, 10, "=-= Donate Scroll Up"] ; Donate / Chat Page, Scroll up Button
Global $aButtonClanDonateScrollDown[9] 	  = [289, 620 + $midOffsetY, 299, 636 + $midOffsetY, 294, 625 + $midOffsetY, 	0xFFFFFF, 10, "=-= Donate Scroll Down"] ; Donate / Chat Page, Scroll Down Button

Global $aButtonAttackReturnHome[9]     	  = [385, 528 + $midOffsetY, 480, 568 + $midOffsetY, 440, 558 + $midOffsetY, 	0x60B010, 20, "=-= Return Home"] ; IsReturnHomeBattlePage, ReturnHome Button
Global $aButtonAttackSurrender[9]      	  = [25 , 555 + $midOffsetY, 110, 579 + $midOffsetY, 66 , 576 + $midOffsetY, 	0xC00000, 20, "=-= Surrender Battle"] ; Attack Page, Surrender Button
Global $aButtonAttackEndBattle[9]      	  = [25 , 555 + $midOffsetY, 110, 579 + $midOffsetY, 66 , 576 + $midOffsetY, 	0xC00000, 20, "=-= End Battle"] ; Attack Page, EndBattle Button
Global $aButtonAttackNext[9] 	          = [710, 530 + $midOffsetY, 830, 570 + $midOffsetY, 780, 546 + $bottomOffsetY, 0xD34300, 20, "=-= Next"] ; Village Search Next Button
Global $aButtonAttackFindMatch[9] 		  = [200, 505 + $midOffsetY, 300, 570 + $midOffsetY, 148, 499 + $midOffsetY, 	0xF8E0A2, 30, "=-= Find A Match"] ; Attack Page Find A Match Button
Global $aButtonAttackFindMatchWShield[9]  = [200, 460 + $midOffsetY, 300, 500 + $midOffsetY, 148, 454 + $midOffsetY, 	0xF8E0A4, 30, "=-= Find A Match (With Shield)"] ; Attack Page Find A Match Button With Shield

Global $aButtonRequestCC[9] 			  = [680, 520 + $midOffsetY, 765, 550 + $midOffsetY, 758, 542 + $midOffsetY, 	0x76C01E, 20, "=-= Request CC"] ; Train, RequestCC Button
Global $aButtonRequestCCText[9] 		  = [370, 100 + $midOffsetY, 510, 140 + $midOffsetY, 430, 140 + $midOffsetY, 	0xFFFFFF, 10, "=-= Select Text"] ; RequestCC, TXT Button
Global $aButtonRequestCCSend[9] 		  = [470, 185 + $midOffsetY, 570, 225 + $midOffsetY, 520, 224 + $midOffsetY, 	0x60AC10, 20, "=-= Send Request"] ; RequestCC, Send Button

Global $aButtonSetting[9]				  = [810, 545 + $midOffsetY, 830, 565 + $midOffsetY, 814, 539 + $midOffsetY, 	0xFFFFFF, 10, "=-= Setting"]
Global $aButtonSettingTabSetting[9]		  = [388, 80  + $midOffsetY, 484, 100 + $midOffsetY, 434, 80  + $midOffsetY, 	0xF0F4F0, 10, "=-= Tab Settings"]
Global $aButtonGoogleConnectRed[9]		  = [410, 380 + $midOffsetY, 460, 400 + $midOffsetY, 431, 401 + $midOffsetY, 	0xD00408, 20, "=-= Connect Red"]
Global $aButtonGoogleConnectGreen[9]	  = [410, 380 + $midOffsetY, 460, 400 + $midOffsetY, 431, 378 + $midOffsetY, 	0xD0E878, 20, "=-= Connect Green"]

Global $aButtonVillageLoad[9] 		      = [480, 385 + $midOffsetY, 550, 415 + $midOffsetY, 455, 407 + $midOffsetY, 	0x66B410, 20, "=-= Village Load"]
Global $aButtonVillageCancel[9] 		  = [310, 385 + $midOffsetY, 380, 415 + $midOffsetY, 288, 403 + $midOffsetY, 	0xE06824, 20, "=-= Village Cancel"]
Global $aButtonVillageConfirmClose[9]     = [575, 20               , 595, 40               , 562, 37               , 	0x605450, 20, "=-= Village Confirm Close"]
Global $aButtonVillageConfirmText[9]      = [320, 160 + $midOffsetY, 375, 170 + $midOffsetY, 350, 165 + $midOffsetY, 	0xFFFFFF, 5 , "=-= Village Confirm Text"]
Global $aButtonVillageConfirmOK[9]        = [500, 155 + $midOffsetY, 555, 175 + $midOffsetY, 480, 168 + $midOffsetY, 	0x76C01E, 20, "=-= Village Confirm Okay"]
Global $aButtonVillageWasAttackOK[9]	  = [380, 475 + $midOffsetY, 470, 510 + $midOffsetY, 405, 507 + $midOffsetY, 	0x5EAC10, 20, "=-= Village Was Attacked Confirm Okay"]

Global $aButtonArmyTab[9]                 = [50,  85 + $midOffsetY , 160, 110 + $midOffsetY, 110, 84 + $midOffsetY ,    0XF8F8F8, 5 , "=-= Army Tab"]
Global $aButtonTrainTroopsTab[9]          = [250, 85 + $midOffsetY , 360, 110 + $midOffsetY, 310, 84 + $midOffsetY ,    0XF8F8F8, 5 , "=-= Train Troops Tab"]
Global $aButtonBrewSpellsTab[9]           = [450, 85 + $midOffsetY , 560, 110 + $midOffsetY, 510, 84 + $midOffsetY ,    0XF8F8F8, 5 , "=-= Brew Spells Tab"]
Global $aButtonQuickTrainTab[9]           = [650, 85 + $midOffsetY , 760, 110 + $midOffsetY, 710, 84 + $midOffsetY ,    0XF8F8F8, 5 , "=-= Quick Train Tab"]

Global $aButtonEditArmy[9]                = [740, 445+ $midOffsetY , 800, 470 + $midOffsetY, 800, 442 + $midOffsetY,    0XD0E878, 20, "=-= Edit Army"]
Global $aButtonEditCancel[9]              = [740, 470+ $midOffsetY , 800, 490 + $midOffsetY, 800, 485 + $midOffsetY,    0XD80408, 20, "=-= Edit Army Cancel"]
Global $aButtonEditOkay[9]                = [740, 532+ $midOffsetY , 800, 552 + $midOffsetY, 800, 530 + $midOffsetY,    0XD0E878, 20, "=-= Edit Army Okay"]

Global $aButtonBrewLightning[9]           = [50,  390 + $midOffsetY, 90 , 420 + $midOffsetY, 61 , 394 + $midOffsetY,    0X011CEA, 20, "=-= Brew Lightning"]
Global $aButtonBrewRage[9]                = [148, 390 + $midOffsetY, 193, 420 + $midOffsetY, 166, 394 + $midOffsetY,    0X402064, 20, "=-= Brew Rage"]
Global $aButtonBrewFreeze[9]              = [248, 390 + $midOffsetY, 288, 420 + $midOffsetY, 266, 380 + $midOffsetY,    0X48CCF0, 20, "=-= Brew Freeze"]
Global $aButtonBrewHeal[9]                = [50,  490 + $midOffsetY, 90 , 520 + $midOffsetY, 86 , 506 + $midOffsetY,    0XF4DC68, 20, "=-= Brew Heal"]
Global $aButtonBrewJump[9]                = [148, 490 + $midOffsetY, 193, 520 + $midOffsetY, 156, 490 + $midOffsetY,    0X70AC2C, 20, "=-= Brew Jump"]
Global $aButtonBrewClone[9]               = [248, 490 + $midOffsetY, 288, 520 + $midOffsetY, 285, 506 + $midOffsetY,    0X21ECDA, 20, "=-= Brew Clone"]
Global $aButtonBrewPoison[9]              = [355, 390 + $midOffsetY, 395, 420 + $midOffsetY, 375, 406 + $midOffsetY,    0XF87D0C, 20, "=-= Brew Poison"]
Global $aButtonBrewHaste[9]               = [455, 390 + $midOffsetY, 495, 420 + $midOffsetY, 470, 407 + $midOffsetY,    0XF46AA8, 20, "=-= Brew Haste"]
Global $aButtonBrewEarth[9]               = [355, 490 + $midOffsetY, 395, 520 + $midOffsetY, 371, 506 + $midOffsetY,    0XBB8958, 20, "=-= Brew Earth"]
Global $aButtonBrewSkeleton[9]            = [455, 490 + $midOffsetY, 495, 520 + $midOffsetY, 476, 507 + $midOffsetY,    0XE11400, 20, "=-= Brew Skeleton"]

Global $aButtonTrainBarb[9]               = [45 ,  390 + $midOffsetY, 95 , 425 + $midOffsetY, 85 , 364 + $midOffsetY,   0XF5BC30, 20, "=-= Train Barbarian"]
Global $aButtonTrainGiant[9]              = [144,  390 + $midOffsetY, 194, 425 + $midOffsetY, 181, 363 + $midOffsetY,   0XF8A258, 20, "=-= Train Giant"]
Global $aButtonTrainWall[9]               = [243,  390 + $midOffsetY, 293, 425 + $midOffsetY, 287, 368 + $midOffsetY,   0X8B522B, 20, "=-= Train Wall Breaker"]
Global $aButtonTrainWiza[9]               = [342,  390 + $midOffsetY, 395, 425 + $midOffsetY, 366, 375 + $midOffsetY,   0XF8CCB0, 20, "=-= Train Wizard"]
Global $aButtonTrainDrag[9]               = [441,  390 + $midOffsetY, 491, 425 + $midOffsetY, 469, 365 + $midOffsetY,   0X8179E8, 20, "=-= Train Dragon"]
Global $aButtonTrainBabyD[9]              = [540,  390 + $midOffsetY, 590, 425 + $midOffsetY, 558, 370 + $midOffsetY,   0X80D650, 20, "=-= Train Baby Dragon"]

Global $aButtonTrainArch[9]               = [45 ,  490 + $midOffsetY, 95 , 525 + $midOffsetY, 78 , 473 + $midOffsetY,   0XB82A68, 20, "=-= Train Archer"]
Global $aButtonTrainGobl[9]               = [144,  490 + $midOffsetY, 194, 525 + $midOffsetY, 178, 459 + $midOffsetY,   0XA8E061, 20, "=-= Train Goblin"]
Global $aButtonTrainBall[9]               = [243,  490 + $midOffsetY, 293, 525 + $midOffsetY, 286, 470 + $midOffsetY,   0X580800, 20, "=-= Train Balloon"]
Global $aButtonTrainHeal[9]               = [342,  490 + $midOffsetY, 395, 525 + $midOffsetY, 360, 464 + $midOffsetY,   0XEDDACA, 20, "=-= Train Healer"]
Global $aButtonTrainPekk[9]               = [441,  490 + $midOffsetY, 491, 525 + $midOffsetY, 478, 474 + $midOffsetY,   0XABD6F0, 20, "=-= Train Pekka"]
Global $aButtonTrainMine[9]               = [540,  490 + $midOffsetY, 590, 525 + $midOffsetY, 577, 494 + $midOffsetY,   0XFFDCAB, 20, "=-= Train Miner"]

Global $aButtonTrainMini[9]               = [645,  390 + $midOffsetY, 695, 425 + $midOffsetY, 677, 381 + $midOffsetY,   0X66B5E6, 20, "=-= Train Minion"]
Global $aButtonTrainHogs[9]               = [645,  490 + $midOffsetY, 695, 525 + $midOffsetY, 680, 471 + $midOffsetY,   0XCC9988, 20, "=-= Train Hog Rider"]
Global $aButtonTrainValk[9]               = [744,  390 + $midOffsetY, 794, 425 + $midOffsetY, 766, 366 + $midOffsetY,   0XF05002, 20, "=-= Train Valkyrie"]
Global $aButtonTrainGole[9]               = [744,  490 + $midOffsetY, 794, 525 + $midOffsetY, 775, 478 + $midOffsetY,   0XC8B298, 20, "=-= Train Golem"]

Global $aButtonTrainWitc[9]               = [660,  390 + $midOffsetY, 710, 425 + $midOffsetY, 681, 380 + $midOffsetY,   0X202453, 20, "=-= Train Witch"]
Global $aButtonTrainLava[9]               = [660,  490 + $midOffsetY, 710, 525 + $midOffsetY, 699, 493 + $midOffsetY,   0X50443E, 20, "=-= Train Lava Hound"]
Global $aButtonTrainBowl[9]               = [759,  390 + $midOffsetY, 809, 425 + $midOffsetY, 775, 375 + $midOffsetY,   0X686AE8, 20, "=-= Train Bowler"]

Global $aButtonTrainArmy1[9]              = [750,  320 + $midOffsetY, 800, 335 + $midOffsetY, 735, 320 + $midOffsetY,   0XC0E468, 20, "=-= Quick Train Army 1"]
Global $aButtonTrainArmy2[9]              = [750,  437 + $midOffsetY, 800, 452 + $midOffsetY, 735, 437 + $midOffsetY,   0XC0E468, 20, "=-= Quick Train Army 2"]
Global $aButtonTrainArmy3[9]              = [750,  553 + $midOffsetY, 800, 572 + $midOffsetY, 735, 556 + $midOffsetY,   0XC0E468, 20, "=-= Quick Train Army 3"]

Func CheckClickMsg(ByRef $x, ByRef $y, ByRef $times, ByRef $speed, ByRef $MsgCode)
	; return 0, do nothing
	; return 1, success do randomize and let continue perform click
	; return 2, use HMLClick or HMLPureClick, cancel the original click (Click, PureClick)
	If $x = 1 And $y = 40 Then
		; replace the away click
		Return HMLClickAway($x, $y, $MsgCode)
	Else
	Switch $MsgCode
		Case "#VWAO"
			$MsgCode = $aButtonVillageWasAttackOK[8]
			Return HMLClickPR($aButtonVillageWasAttackOK,$x,$y)
		Case "#BS01","#BS02","#TT01"
			Return 1
		Case "ChatCollapseBtn"
			$MsgCode = $aButtonClanWindowClose[8]
			Return HMLClickPR($aButtonClanWindowClose,$x,$y)
		Case "ArmyTab"
			$MsgCode = $aButtonArmyTab[8]
			Return HMLClickPR($aButtonArmyTab,$x,$y,2)
		Case "BrewSpellsTab"
			$MsgCode = $aButtonBrewSpellsTab[8]
			Return HMLClickPR($aButtonBrewSpellsTab,$x,$y,2)
		Case "QuickTrainTab"
			$MsgCode = $aButtonQuickTrainTab[8]
			Return HMLClickPR($aButtonQuickTrainTab,$x,$y,2)
		Case "TrainTroopsTab"
			$MsgCode = $aButtonTrainTroopsTab[8]
			Return HMLClickPR($aButtonTrainTroopsTab,$x,$y,2)
		Case "OpenTrainBtn"
			$MsgCode = $aButtonOpenTrainArmy[8]
			Return HMLClickPR($aButtonOpenTrainArmy,$x,$y)
		Case "#EditArmy"
			$MsgCode = $aButtonEditArmy[8]
			Return HMLClickPR($aButtonEditArmy,$x,$y)
		Case "#EditArmyOkay"
			$MsgCode = $aButtonEditOkay[8]
			Return HMLClickPR($aButtonEditOkay,$x,$y)
		Case "#TabSettings"
			$MsgCode = $aButtonSettingTabSetting[8]
			Return HMLClickPR($aButtonSettingTabSetting,$x,$y,2)
		Case "#VL01"
			$MsgCode = $aButtonVillageCancel[8]
			Return HMLClickPR($aButtonVillageCancel,$x,$y)
		Case "#GALo"
			$MsgCode = $aButtonVillageLoad[8]
			Return HMLClickPR($aButtonVillageLoad,$x,$y)
		Case "#GATe"
			$MsgCode = $aButtonVillageConfirmText[8]
			Return HMLClickPR($aButtonVillageConfirmText,$x,$y)
		Case "#GACo"
			$MsgCode = $aButtonVillageConfirmOK[8]
			Return HMLClickPR($aButtonVillageConfirmOK,$x,$y)
		Case "#Setting"
			$MsgCode = $aButtonSetting[8]
			Return HMLClickPR($aButtonSetting,$x,$y, 1)
		Case "#ConnectGoogle"
			$MsgCode = $aButtonGoogleConnectGreen[8]
			Return HMLClickPR($aButtonGoogleConnectGreen,$x,$y)
		Case "QuickTrainTabBtn"
			$MsgCode = "=-= QuickTrainTabBtn"
			$x = Random($x-10, $x+25,1)
			$y = Random($y-3, $y+3,1)
			Return 1
		Case "Army1","Army2","Army3","Previous Army"
			;If $debugClick = 1 And $EnableHMLSetLog = 1 Then SetLog("Randomize click pixel of " & $MsgCode & " Button - ValIn: X=" & $x & " Y=" & $y,$COLOR_HMLClick_LOG)
			$MsgCode = "=-= " & $MsgCode
			$x = Random($x-10, $x+25,1)
			$y = Random($y-4, $y+4,1)
			Return 1
		Case "#0176","#0171"
			$MsgCode = $aButtonClose8[8]
			Return HMLClickPR($aButtonClose8,$x,$y)
		Case "#0666","#0096","#0097","#0098","#0102","#0103","#0104","#0105","#0106","#0107","#0108","#0109"; Randomize all troops drop pixel (DropTroopFromINI #0666, DropOnPixel #0096,#0097,#0098, DropOnEdge #0102,#0103,#0104,#0105,#0106,#0107,#0108,#0109)
			For $i = 0 To $times - 1
				HMLPureClick(Random($x-1,$x+1,1),Random($y-1,$y+1,1),1,$speed,"#R666")
			Next
			Return 2
		Case "#0168"
			$bDonateAwayFlag = True
			$MsgCode = $aButtonClanWindowOpen[8]
			Return HMLClickPR($aButtonClanWindowOpen,$x,$y)
		Case "#0169"
			$MsgCode = $aButtonClanChatTab[8]
			Return HMLClickPR($aButtonClanChatTab,$x,$y,2)
		Case "#0173","#0136"
			$bDonateAwayFlag = False
			$MsgCode = $aButtonClanWindowClose[8] & " From: " & $MsgCode
			Return HMLClickPR($aButtonClanWindowClose,$x,$y,1)
		Case "#0101"
			$MsgCode = $aButtonAttackReturnHome[8]
			Return HMLClickPR($aButtonAttackReturnHome,$x,$y)
		Case "#9997"
			$MsgCode = $aButtonOpenShieldInfo[8]
			Return HMLClickPR($aButtonOpenShieldInfo,$x,$y,1)
		Case "#0099"
			$MsgCode = $aButtonAttackSurrender[8]
			Return HMLClickPR($aButtonAttackSurrender,$x,$y)
		Case "#0172"
			If $y < 120 Then
				$MsgCode = $aButtonClanDonateScrollUp[8]
				Return HMLClickPR($aButtonClanDonateScrollUp,$x,$y,1)
			Else
				$MsgCode = $aButtonClanDonateScrollDown[8]
				Return HMLClickPR($aButtonClanDonateScrollDown,$x,$y,1)
			EndIf
		Case "#0315"
			$MsgCode = $aButtonClose5[8]
			Return HMLClickPR($aButtonClose5,$x,$y,1) ;Shop, Close Button
		Case "#0253"
			$MsgCode = $aButtonRequestCC[8]
			Return HMLClickPR($aButtonRequestCC,$x,$y,1)
		Case "#0254"
			$MsgCode = $aButtonRequestCCText[8]
			Return HMLClickPR($aButtonRequestCCText,$x,$y,1)
		Case "#0256"
			$MsgCode = $aButtonRequestCCSend[8]
			Return HMLClickPR($aButtonRequestCCSend,$x,$y,1)
		Case "#0222"
			$MsgCode = $aButtonOpenProfile[8]
			Return HMLClickPR($aButtonOpenProfile,$x,$y,1)
		Case "#0223"
			$MsgCode = $aButtonClose3[8]
			Return HMLClickPR($aButtonClose3,$x,$y,1) ; Profile page close
		Case "#0293","#0334","#0347","#1293"
			$MsgCode = $aButtonOpenTrainArmy[8] & " From: " & $MsgCode
			Return HMLClickPR($aButtonOpenTrainArmy,$x,$y,1)
		Case "#0155"
			$MsgCode = $aButtonAttackNext[8]
			Return HMLClickPR($aButtonAttackNext,$x,$y)
		Case "#0149"
			$MsgCode = $aButtonOpenLaunchAttack[8]
			Return HMLClickPR($aButtonOpenLaunchAttack,$x,$y,1)
		Case "#0150"
			If _ColorCheck(_GetPixelColor($aButtonAttackFindMatch[4], $aButtonAttackFindMatch[5], True), Hex($aButtonAttackFindMatch[6], 6), $aButtonAttackFindMatch[7]) Then
				$MsgCode = $aButtonAttackFindMatch[8]
				Return HMLClickPR($aButtonAttackFindMatch,$x,$y,1)
			ElseIf _ColorCheck(_GetPixelColor($aButtonAttackFindMatchWShield[4], $aButtonAttackFindMatchWShield[5], True), Hex($aButtonAttackFindMatchWShield[6], 6), $aButtonAttackFindMatchWShield[7]) Then
				$MsgCode = $aButtonAttackFindMatchWShield[8]
				Return HMLClickPR($aButtonAttackFindMatchWShield,$x,$y,1)
			Else
				Return 0
			EndIf
		Case "#0236"
			$MsgCode = "=-= Atk Log Button"
			$x = Random($x-5, $x+5,1)
			$y = Random($y, $y+10,1)
			Return 1
		Case "#0117"
			$MsgCode = "=-= Okay Button"
			$x = Random($x-15, $x+15,1)
			$y = Random($y-10, $y+10,1)
			Return 1
		Case "#0225"
			$MsgCode = "=-= TownHall"
			$x = Random($x-2, $x+2,1)
			$y = Random($y, $y+7,1)
			Return 1
		Case "#0430"
			$MsgCode = "=-= Collector"
			$x = Random($x-4, $x+4,1)
			$y = Random($y-4, $y+4,1)
			Return 1
		Case "#0290"
			$MsgCode = "=-= Create Spell"
			$x = Random($x-20, $x+20,1)
			$y = Random($y-10, $y+10,1)
			Return 1
		Case "#0174"
			$MsgCode = "=-= Donate Button"
			$x = Random($x-20, $x+20,1)
			$y = Random($y, $y+15,1)
			Return 1
		Case "#0111","#0092","#0094","#X998","#0090"
			$MsgCode = "=-= SelectTroop - From: " & $MsgCode
			$x = Random($x-8, $x+8,1)
			$y = Random($y, $y+30,1)
			Return 1
		Case "#0330"
			$MsgCode = "=-= LootCart"
			$x = Random($x-5, $x,1)
			$y = Random($y-1, $y+2,1)
			Return 1
		Case "#0331"
			$MsgCode = "=-= LootCart Collect Button"
			$x = Random($x-20, $x+20,1)
			$y = Random($y-20, $y+10,1)
			Return 1
		Case "#0316"
			$MsgCode = "=-=  Upgrade Wall With Gold"
			$x = Random($x, $x+30,1)
			$y = Random($y, $y+20,1)
			Return 1
		Case "#0317"
			$MsgCode = "=-= Confirm With Gold"
			$x = Random($x-30, $x,1)
			$y = Random($y, $y+30,1)
			Return 1
		Case "#0318"
			$MsgCode = "=-= Confirm With Elixir"
			$x = Random($x-30, $x,1)
			$y = Random($y, $y+30,1)
			Return 1
		Case "#0322"
			$MsgCode = "=-= Upgrade Wall With Elixir"
			$x = Random($x, $x+30,1)
			$y = Random($y, $y+20,1)
			Return 1
		Case "#0600","#0175"
			$MsgCode = "=-= Donate Troops / Spell From: " & $MsgCode
			$x = Random($x-5, $x+25,1)
			$y = Random($y-30, $y,1)
			Return 1
		Case Else
			Return 0
	EndSwitch
	EndIf
	Return 0
EndFunc ;==>CheckClickMsg

Func RemoveAllTroopAlreadyTrain()
	If $debugsetlogTrain = 1 Then SetLog("====Start Delete Troops====",$COLOR_HMLClick_LOG)
	Local $iRanX = Random(817,829,1)
	Local $iRanY = Random(166 + $midOffsetY,177 + $midOffsetY,1)
	Local $iRanX2 = Random(746,758,1)
	Local $iRanX3 = Random(677,688,1)
	Local $iRanX4 = Random(606,616,1)
	$icount = 0
	ForceCaptureRegion()
	While Not _ColorCheck(_GetPixelColor(823, 175 + $midOffsetY, True), Hex(0xCFCFC8, 6), 20) ; while not disappears  green arrow
		; FFF delete
		If isProblemAffectBeforeClick($icount) Then ExitLoop
		For $i = 0 To 9
			HMLPureClick(Random($iRanX-2,$iRanX+2,1), Random($iRanY-2,$iRanY+2,1),1,0,"#0702")
			HMLPureClick(Random($iRanX2-2,$iRanX2+2,1), Random($iRanY-2,$iRanY+2,1),1,0,"#0702")
			HMLPureClick(Random($iRanX3-2,$iRanX3+2,1), Random($iRanY-2,$iRanY+2,1),1,0,"#0702")
			HMLPureClick(Random($iRanX4-2,$iRanX4+2,1), Random($iRanY-2,$iRanY+2,1),1,0,"#0702")
			If _Sleep(Random(($isldTrainITDelay*90)/100, ($isldTrainITDelay*110)/100, 1), False) Then ExitLoop
		Next
		$icount += 1
		If $icount > 30 Then ExitLoop
	WEnd
	If $debugsetlogTrain = 1 Then SetLog("====Ended Delete Troops====",$COLOR_HMLClick_LOG)
EndFunc

Func HMLClickAway(ByRef $x, ByRef $y, ByRef $MsgCode)
	If $bDonateAwayFlag = True Then
		Return HMLClickPR($aButtonClose8,$x,$y)
	Else
		ForceCaptureRegion()
		_CaptureRegion()
		For $i = 1 To 7
			Local $tempButton = Eval("aButtonClose" & $i)
			If _ColorCheck(_GetPixelColor($tempButton[4], $tempButton[5]), Hex($tempButton[6], 6), Number($tempButton[7])) Then
				$MsgCode = $tempButton[8]
				Return HMLClickPR($tempButton,$x,$y)
			EndIf
		Next
		; randomize some pixel area we usually aways click, like train page, League page and profile page close area
		; even if the close button not exist, we use to Away
		$MsgCode = "=-= Random Away Coordinate =-= " & $MsgCode
		Return HMLClickPR($aButtonClose8,$x,$y)
	EndIf
EndFunc

Func HMLClickPR($point, ByRef $x, ByRef $y, $checkpixelcolor = 0, $bForceReCapRegion = True)
	Switch $checkpixelcolor
		Case 1
			; Do Check color if the pixel color define at button variable = true then we click
			If _ColorCheck(_GetPixelColor($point[4], $point[5], $bForceReCapRegion), Hex($point[6], 6), $point[7]) Then
				$x = Random($point[0],$point[2],1)
				$y = Random($point[1],$point[3],1)
				Return 1
			Else
				If $debugClick = 1 And $EnableHMLSetLog = 1 Then SetLog($point[8] & " @ Pixel Color Not Match then skip click =-= x,y,color1,color2: " & $point[4] & "," & $point[5] & "," & Hex($point[6],6) & "," & _GetPixelColor($point[4], $point[5], True), $COLOR_RED)
				Return 2
			EndIf
		Case 2
			; Do Check color if the pixel color define at button variable = false then we click
			If Not _ColorCheck(_GetPixelColor($point[4], $point[5], $bForceReCapRegion), Hex($point[6], 6), $point[7]) Then
				$x = Random($point[0],$point[2],1)
				$y = Random($point[1],$point[3],1)
				Return 1
			Else
				If $debugClick = 1 And $EnableHMLSetLog = 1 Then SetLog($point[8] & " @ Pixel Color Match then skip click =-= x,y,color1,color2: " & $point[4] & "," & $point[5] & "," & Hex($point[6],6) & "," & _GetPixelColor($point[4], $point[5], True), $COLOR_RED)
				Return 2
			EndIf
		Case Else
			; No check pixel color, just randomize the click
			$x = Random($point[0],$point[2],1)
			$y = Random($point[1],$point[3],1)
			Return 1
	EndSwitch
EndFunc ;===>HMLClickPR

Func HMLPureClick($x, $y, $times = 1, $speed = 0, $debugtxt = "") ; original Code from PureClick
	If $EnableHMLSetLog = 1 Then
		;Local $txt = _DecodeDebug($debugtxt)
		SetLog("HMLPureClick X:" & $x & " Y:" & $y & " T:" & $times & " S:" & $speed & " DMsg:" & $debugtxt, $COLOR_HMLClick_LOG, "Verdana", "7.5", 0)
	EndIf
	If TestCapture() Then Return

    If $AndroidAdbClick = True Then
	   AndroidClick($x, $y, $times, $speed, False)
	EndIf
	If $AndroidAdbClick = True Then
	   Return
    EndIf

    Local $SuspendMode = ResumeAndroid()
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			MoveMouseOutBS()
			_ControlClick($x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		MoveMouseOutBS()
		_ControlClick($x, $y)
	EndIf
    SuspendAndroid($SuspendMode)
EndFunc

Func HMLClick($x, $y, $times = 1, $speed = 0, $debugtxt = "") ; original Code from Click
	If $EnableHMLSetLog = 1 Then
		;Local $txt = _DecodeDebug($debugtxt)
		SetLog("HMLClick X:" & $x & " Y:" & $y & " T:" & $times & " S:" & $speed & " DMsg:" & $debugtxt, $COLOR_HMLClick_LOG, "Verdana", "7.5", 0)
	EndIf

	If TestCapture() Then Return

    If $AndroidAdbClick = True Then
		AndroidClick($x, $y, $times, $speed)
	EndIf
	If $AndroidAdbClick = True Then
	   Return
    EndIf

    Local $SuspendMode = ResumeAndroid()
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			If isProblemAffectBeforeClick($i) Then
				If $debugClick = 1 Then Setlog("VOIDED Click " & $x & "," & $y & "," & $times & "," & $speed & " " & $debugtxt, $COLOR_ERROR, "Verdana", "7.5", 0)
				checkMainScreen(False)
				SuspendAndroid($SuspendMode)
				Return  ; if need to clear screen do not click
			EndIf
			MoveMouseOutBS()
			_ControlClick($x, $y)
			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		If isProblemAffectBeforeClick() Then
			If $debugClick = 1 Then Setlog("VOIDED Click " & $x & "," & $y & "," & $times & "," & $speed & " " & $debugtxt, $COLOR_ERROR, "Verdana", "7.5", 0)
			checkMainScreen(False)
			SuspendAndroid($SuspendMode)
			Return  ; if need to clear screen do not click
		EndIf
		MoveMouseOutBS()
		_ControlClick($x, $y)
	EndIf
    SuspendAndroid($SuspendMode)
EndFunc

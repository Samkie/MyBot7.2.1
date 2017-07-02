; #FUNCTION# ====================================================================================================================
; Name ..........: CustomTrain,DoCheckReVamp
; Description ...: Train custom troops base on gui setting, revamp donated troops.
; Syntax ........: CustomTrain(),DoCheckReVamp($bDoFullTrain = False)
; Parameters ....:
; Return values .: None
; Author ........: Samkie (27 Dec 2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the term
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func CustomTrain()
	Local $tempCounter = 0
	Local $tempElixir = ""
	Local $tempDElixir = ""
	Local $tempElixirSpent = 0
	Local $tempDElixirSpent = 0
	Local $bNotStuckJustOnBoost = False

	If $debugsetlogTrain = 1 Then SetLog("Func Train ", $COLOR_DEBUG)
	If $bTrainEnabled = False Then Return

	; Read Resource Values For army cost Stats
	VillageReport(True, True)
	$tempCounter = 0
	While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 5
		$tempCounter += 1
		If _Sleep(100) Then Return
		VillageReport(True, True)
	WEnd
	$tempElixir = $iElixirCurrent
	$tempDElixir = $iDarkCurrent
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	SetLog("Training Troops & Spells", $COLOR_INFO)
	If _Sleep($iDelayTrain1) Then Return
	ClickP($aAway, 1, 0, "#0268") ;Click Away to clear open windows in case user interupted
	If _Sleep($iDelayTrain4) Then Return

	If _Sleep($iDelayBarracksStatus1) Then Return
	checkAttackDisable($iTaBChkIdle)
	If $Restart = True Then Return

	;OPEN ARMY OVERVIEW WITH NEW BUTTON
	; WaitforPixel($iLeft, $iTop, $iRight, $iBottom, $firstColor, $iColorVariation, $maxDelay = 10)
	If WaitforPixel(28, 505 + $bottomOffsetY, 30, 507 + $bottomOffsetY, Hex(0xE4A438, 6), 5, 10) Then
		If $debugsetlogTrain = 1 Then SetLog("Click $aArmyTrainButton", $COLOR_SUCCESS)
		If IsMainPage() Then
			If $iUseRandomClick = 0 Then
				Click($aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0, "#1293") ; Button Army Overview
			Else
				ClickR($aArmyTrainButtonRND, $aArmyTrainButton[0], $aArmyTrainButton[1], 1, 0)
			EndIf
		EndIf
	EndIf

	If _Sleep(250) Then Return


	getArmyHeroCount()
	If _Sleep($iDelayBarracksStatus1) Then Return ; 10ms improve pause button response

	getArmyCCCapacity()
	If _Sleep($iDelayBarracksStatus1) Then Return ; 10ms improve pause button response

	getMyArmyCapacity()
	If _Sleep($iDelayBarracksStatus1) Then Return ; 10ms improve pause button response

	If $iChkUseQuickTrain = 1 Then
		If Int($CurCamp / $TotalCamp * 100) >= 95 And $CurCamp <> $TotalCamp Then
			Setlog("Check troops queue in train, is that any troops stuck...")
			If gotoTrainTroops() Then
				If _Sleep($tDelayBtn) Then Return
				If _ColorCheck(_GetPixelColor(808, 156 + $midOffsetY, True), Hex(0xD7AFA9, 6), 10) Then ; pink color
					RemoveAllTroopAlreadyTrain()
					If _Sleep($tDelayBtn) Then Return
				Else
					Setlog("Troops train working fine.",$COLOR_SUCCESS)
				EndIf
			Else
				SetLog("Cannot open train troops tab page.",$COLOR_ERROR)
				Return
			EndIf
		EndIf
		QuickTrain($iCmbCurrentArmy, False)
	Else
		getArmyTroopTime()
		If _Sleep($iDelayBarracksStatus1) Then Return

		; stick to train page until troop finish
		Local $iCount = 0
		While 1
			If $bRestartCustomTrain Then $iCount = 0
			$bRestartCustomTrain = False

			If _Sleep($iDelayBarracksStatus1) Then Return
			checkAttackDisable($iTaBChkIdle)
			If $Restart = True Then Return

			$iCount += 1
			If $iCount > (10 + $itxtStickToTrainWindow) Then ExitLoop
			If $aTimeTrain[0] <= 0 Then
				;getMyArmyCapacity()
				;If _Sleep($iDelayBarracksStatus1) Then Return
				If $iSamM0dDebug Then SetLog("$fullArmy: " & $fullArmy)
				If $fullArmy = False Then
					;If _ColorCheck(_GetPixelColor(389, 99 + $midOffsetY, True), Hex(0X6AB31F, 6), 10) = False Then ;color green arrow > not appear. no troops on train, direct revamp troops
					If _ColorCheck(_GetPixelColor(389, 100 + $midOffsetY, True), Hex(0X5E5748, 6), 20) Or $bNotStuckJustOnBoost Then ;color green arrow > not appear. no troops on train, direct revamp troops
						; situation need revamp
						getMyArmyTroopCount()
						If $bRestartCustomTrain Then ContinueLoop

						If _Sleep($iDelayBarracksStatus1) Then Return
						DoCheckReVamp()
						If _Sleep($iDelayBarracksStatus1) Then Return
						If gotoArmy() Then ; get train troops time before exit loop
							getArmyTroopTime()
							If _Sleep($iDelayBarracksStatus1) Then Return
						EndIf
						ExitLoop
					Else ; when train time = 0 and troops are not full and got some troops on train
						;If Int(($CurCamp / (($TotalCamp * $fulltroop) / 100)) * 100) >= 95 And $CurCamp <> (($TotalCamp * $fulltroop) / 100) Then
							Setlog("Check troops queue in train, is that any troops stuck...")
							If gotoTrainTroops() Then
								If _Sleep($tDelayBtn) Then Return
								If _ColorCheck(_GetPixelColor(808, 156 + $midOffsetY, True), Hex(0xD7AFA9, 6), 10) Then ; pink color
									RemoveAllTroopAlreadyTrain()
									If _Sleep($tDelayBtn) Then Return
								;Else
								;	Setlog("Troops train working fine.",$COLOR_SUCCESS)
								EndIf

								$bNotStuckJustOnBoost = True

								If gotoArmy() = False Then
									SetLog("Cannot open army overview tab page.",$COLOR_ERROR)
									Return
								EndIf
							Else
								SetLog("Cannot open train troops tab page.",$COLOR_ERROR)
								Return
							EndIf

						;EndIf
					EndIf
				Else
					If $ichkDisablePretrainTroops = 1 Then
						;If _ColorCheck(_GetPixelColor(389, 99 + $midOffsetY, True), Hex(0X6AB31F, 6), 10) Then
						If _ColorCheck(_GetPixelColor(389, 100 + $midOffsetY, True), Hex(0X5E5748, 6), 20) = False Then
							If gotoTrainTroops() Then
								If _Sleep($tDelayBtn) Then Return
								If _ColorCheck(_GetPixelColor(808, 156 + $midOffsetY, True), Hex(0xD7AFA9, 6), 10) Then ; pink color
									RemoveAllTroopAlreadyTrain()
									If _Sleep($tDelayBtn) Then Return
								EndIf
							Else
								SetLog("Cannot open train troops tab page.",$COLOR_ERROR)
							EndIf
						Else
							getMyArmyTroopCount()
							If $bRestartCustomTrain Then ContinueLoop
							If _Sleep($iDelayBarracksStatus1) Then Return
						EndIf
					Else
						getMyArmyTroopCount()
						If $bRestartCustomTrain Then ContinueLoop
						If _Sleep($iDelayBarracksStatus1) Then Return
						If $icmbMyQuickTrain = 0 Then
							DoCheckReVamp(True)
						Else
							DoMyQuickTrain($icmbMyQuickTrain)
						EndIf
					EndIf
					ExitLoop
				EndIf
			Else
				If $ichkEnableDeleteExcessTroops = 1 Then
					If _Sleep($iDelayBarracksStatus1) Then Return
					getMyArmyTroopCount()
					If $bRestartCustomTrain Then ContinueLoop
				EndIf

				If $aTimeTrain[0] > $itxtStickToTrainWindow Then
					If $iChkTrophyRange = 1 Then
						If _Sleep($iDelayBarracksStatus1) Then Return
						getMyArmyTroopCount()
					EndIf
					ExitLoop
				EndIf
			EndIf
			Local $iStickDelay
			If $aTimeTrain[0] < 1 Then
				$iStickDelay = Int($aTimeTrain[0] * 60000) + 250
			ElseIf $aTimeTrain[0] >= 2 Then
				$iStickDelay = 60000
			Else
				$iStickDelay = 30000
			EndIf
			If _Sleep($iStickDelay) Then Return
			getMyArmyCapacity()
			If _Sleep($iDelayBarracksStatus1) Then Return ; 10ms improve pause button response
			getArmyTroopTime()
			If _Sleep($iDelayBarracksStatus1) Then Return
		WEnd
	EndIf

	If $debugsetlogTrain = 1 Then SetLog("$tempDisableBrewSpell: " & $tempDisableBrewSpell)

	If $tempDisableBrewSpell = False Then
		If _Sleep($iDelayBarracksStatus1) Then Return
		CustomSpells()
	Else
		; continue check getMyArmySpellCount() until $bFullArmySpells = True
		If $bFullArmySpells = False Then
			If gotoArmy() Then
				If _Sleep($iDelayBarracksStatus1) Then Return
				getMyArmySpellCount()
			EndIf
		EndIf
	EndIf

	If $ichkEnableMySwitch = 1 Then
		If gotoArmy() Then
			Local $iKTime[5] = [0,0,0,0,0]
			getArmyTroopTime(False,False)
			$iKTime[4] = $aTimeTrain[0]
			If BitAND($iHeroWait[$DB], $HERO_KING) = $HERO_KING Or BitAND($iHeroWait[$LB], $HERO_KING) = $HERO_KING Then
				$iKTime[0] = getArmyHeroTime($eKing)
			EndIf
			If BitAND($iHeroWait[$DB], $HERO_QUEEN) = $HERO_QUEEN Or BitAND($iHeroWait[$LB], $HERO_QUEEN) = $HERO_QUEEN Then
				$iKTime[1] = getArmyHeroTime($eQueen)
			EndIf
			If BitAND($iHeroWait[$DB], $HERO_WARDEN) = $HERO_WARDEN Or BitAND($iHeroWait[$LB], $HERO_WARDEN) = $HERO_WARDEN Then
				$iKTime[2] = getArmyHeroTime($eWarden)
			EndIf
			If $iEnableSpellsWait[$DB] Or $iEnableSpellsWait[$LB] Then
				getArmySpellTime()
				$iKTime[3] = $aTimeTrain[1]
			EndIf
			_ArraySort($iKTime,1)
			If $iCurActiveAcc <> -1 Then
				For $i = 0 To UBound($aSwitchList) - 1
					If $aSwitchList[$i][4] = $iCurActiveAcc Then
						$aSwitchList[$i][0] = _DateAdd('n', $iKTime[0], _NowCalc())
						ExitLoop
					EndIf
				Next
			EndIf
		EndIf
	EndIf

	If gotoArmy() Then
		getArmyCCStatus()
		If _Sleep($iDelayBarracksStatus1) Then Return ; 10ms improve pause button response
	Else
		SetLog("Cannot open army overview tab page.",$COLOR_ERROR)
	EndIf


	If $debugsetlogTrain = 1 Then Setlog("Fullarmy = " & $fullarmy & " CurCamp = " & $CurCamp & " TotalCamp = " & $TotalCamp & " - result = " & ($fullarmy = True And $CurCamp = $TotalCamp), $COLOR_DEBUG)
	If $fullarmy = True Then
		SetLog("Your Army Camps are now Full", $COLOR_SUCCESS, "Times New Roman", 10)
		If (($NotifyPBEnabled = 1 Or $NotifyTGEnabled = 1) And $NotifyAlertCampFull = 1) Then PushMsg("CampFull")
	EndIf

	If _Sleep($iDelayTrain4) Then Return
	ClickP($aAway, 1, $iDelayTrain5, "#0504")
	If _Sleep($iDelayTrain5) Then Return
	;ClickP($aAway, 1, $iDelayTrain5, "#0504")

	$FirstStart = False

	;;;;;; Protect Army cost stats from being missed up by DC and other errors ;;;;;;;
	If _Sleep($iDelayTrain4) Then Return
	VillageReport(True, True)

	$tempCounter = 0
	While ($iElixirCurrent = "" Or ($iDarkCurrent = "" And $iDarkStart <> "")) And $tempCounter < 30
		$tempCounter += 1
		If _Sleep(100) Then Return
		VillageReport(True, True)
	WEnd

	If $tempElixir <> "" And $iElixirCurrent <> "" Then
		$tempElixirSpent = ($tempElixir - $iElixirCurrent)
		$iTrainCostElixir += $tempElixirSpent
		$iElixirTotal -= $tempElixirSpent
	EndIf

	If $tempDElixir <> "" And $iDarkCurrent <> "" Then
		$tempDElixirSpent = ($tempDElixir - $iDarkCurrent)
		$iTrainCostDElixir += $tempDElixirSpent
		$iDarkTotal -= $tempDElixirSpent
	EndIf

	UpdateStats()

	If $bFullArmySpells = False Then
		$bFullArmySpells = ($iDBcheck = 1 And $iEnableSpellsWait[$DB] = 0) Or ($iABcheck = 1 And $iEnableSpellsWait[$LB] = 0)
	EndIf

	If $fullArmy = True And $bFullArmyHero = True And $bFullArmySpells = True Then
		$IsFullArmywithHeroesAndSpells = True
	Else
		$IsFullArmywithHeroesAndSpells = False
	EndIf
EndFunc   ;==>CustomTrain

Func DoCheckReVamp($bDoFullTrain = False)

	If _Sleep(500) Then Return
	Local $bReVampFlag = False
	Local $tempTroops[19][5]
	$tempTroops	= $MyTroops

	If $ichkMyTroopsOrder Then
		_ArraySort($tempTroops,0,0,0,1)
	EndIf

	For $i = 0 To UBound($tempTroops) - 1
		If $debugsetlogTrain = 1 Then SetLog("$tempTroops[" & $i & "]: " & $tempTroops[$i][0] & " - " & $tempTroops[$i][1])
		; reset variable
		Assign("Dif" & $tempTroops[$i][0],0)
		Assign("Add" & $tempTroops[$i][0],0)
	Next

	If $bDoFullTrain = False Then
		For $i = 0 To UBound($tempTroops) - 1
			Local $tempCurComp = $tempTroops[$i][3]
			Local $tempCur = Eval("Cur" & $tempTroops[$i][0])
			If $debugsetlogTrain = 1 Then SetLog("$tempMyTroops: " & $tempCurComp)
			If $debugsetlogTrain = 1 Then SetLog("$tempCur: " & $tempCur)
			If $tempCurComp <> $tempCur Then
				Assign("Dif" & $tempTroops[$i][0], $tempCurComp - $tempCur)
			EndIf
		Next
	Else
		For $i = 0 To UBound($tempTroops) - 1
			If $tempTroops[$i][3] > 0 Then
				Assign("Dif" & $tempTroops[$i][0], $tempTroops[$i][3])
			EndIf
		Next
	EndIf

	For $i = 0 To UBound($tempTroops) - 1
		If Eval("Dif" & $tempTroops[$i][0]) > 0 Then
			If $debugsetlogTrain = 1 Then SetLog("Some troops haven't train: " & $tempTroops[$i][0])
			If $debugsetlogTrain = 1 Then SetLog("Setting Qty Of " & $tempTroops[$i][0] & " troops: " & $tempTroops[$i][3])
			;SetLog("Prepare for train number Of " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]), Eval("Dif" & $tempTroops[$i][0])) & " x" & Eval("Dif" & $tempTroops[$i][0]),$COLOR_ACTION)
			Assign("Add" & $tempTroops[$i][0], Eval("Dif" & $tempTroops[$i][0]))
			$bReVampFlag = True
		ElseIf Eval("Dif" & $tempTroops[$i][0]) < 0 Then
			If $debugsetlogTrain = 1 Then SetLog("Some troops over train: " & $tempTroops[$i][0])
			If $debugsetlogTrain = 1 Then SetLog("Setting Qty Of " & $tempTroops[$i][0] & " troops: " & $tempTroops[$i][3])
			If $debugsetlogTrain = 1 Then SetLog("Current Qty Of " & $tempTroops[$i][0] & " troops: " & $tempTroops[$i][3]- Eval("Dif" & $tempTroops[$i][0]))
		EndIf
	Next

	If $bReVampFlag Then
		If gotoTrainTroops() Then
			If _sleep(100) Then Return
			; starttrain
			Local $iRemainTroopsCapacity = 0
			Local $iCreatedTroopsCapacity = 0
			Local $bFlagOutOfResource = False
			If $bDoFullTrain Then
				; delete all exist pretrain troops before full train
				Local $aMaxCapacity = getTrainArmyCapacity()
				If $aMaxCapacity = "" then Return
				If $debugsetlogTrain = 1 Then SetLog("Train Troops Capacity: " & $aMaxCapacity[0] & "/" & $aMaxCapacity[1])

				If IsArray($aMaxCapacity) Then
					If ($aMaxCapacity[0] >= (Int(($aMaxCapacity[1] * $fulltroop) / 100) * 2) And $fulltroop <> 100) Then
						SetLog("There are already full troops pre-train, skip train.",$COLOR_INFO)
						Return
					Else
						Local $bNeedRemoveAllTroops = False
						If $fulltroop = 100 Then

						;If $aMaxCapacity[0] > (($aMaxCapacity[1] * $fulltroop) / 100) Then
							Local $iCount = 0
							Local $iQueueCap = 0
							While $bNeedRemoveAllTroops = False
								$iQueueCap = 0
								Local $iCount2 = 0
								While (_ColorCheck(_GetPixelColor(228, 160 + $midOffsetY , True), Hex(0xFEFEFE, 6), 5) And _ColorCheck(_GetPixelColor(326, 160 + $midOffsetY , True), Hex(0xFEFEFE, 6), 5)) Or _ColorCheck(_GetPixelColor(498, 184 + $midOffsetY , True), Hex(0xFFFFFF, 6), 5) Or _ColorCheck(_GetPixelColor(357, 183 + $midOffsetY , True), Hex(0xFFFFFF, 6), 5)
									If $debugsetlogTrain = 1 Then SetLog("Donate or other message blocked screen, postpone action.",$COLOR_RED)
									If _Sleep(1000) Then Return
									$iCount2 += 1
									If $iCount2 >= 30 Then
										ExitLoop
									EndIf
								WEnd

								$iCount += 1
								If $iCount > 3 Then
									$bNeedRemoveAllTroops = True
									ExitLoop
								EndIf
								If _ColorCheck(_GetPixelColor(20,220,True), Hex(0XCFCFC8, 6), 10) = False Then $bNeedRemoveAllTroops = True
								If $bNeedRemoveAllTroops = False Then
									Local $aFindResult
									$aFindResult = getQueueArmyTypeAndSlot()
									If $debugsetlogTrain = 1 Then SetLog("============End getQueueArmyTypeAndSlot ============")
									If $aFindResult <> "" Then
										For $i = 0 To UBound($aFindResult,$UBOUND_ROWS) - 1
											If $aFindResult[$i][2] <> 0 Then
												Assign("OnQ" & $aFindResult[$i][0], Eval("OnQ" & $aFindResult[$i][0]) + $aFindResult[$i][2])
											Else
												SetLog("Error detect quantity no. On Troop: " & MyNameOfTroop(Eval("e" & $aFindResult[$i][0]), $aFindResult[$i][2]),$COLOR_RED)
												ContinueLoop 2
											EndIf
										Next
									EndIf
									For $i = 0 To UBound($tempTroops) - 1
										Local $iOnQQty = Eval("OnQ" & $tempTroops[$i][0])
										If $iOnQQty > 0 Then
											SetLog(" - No. of On Queue " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]), $iOnQQty) & ": " & $iOnQQty, (Eval("e" & $tempTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
											$iQueueCap += $tempTroops[$i][2] * $iOnQQty
											If $iOnQQty > Eval("Add" & $tempTroops[$i][0]) Then
												$bNeedRemoveAllTroops = True
												ExitLoop
											EndIf
										EndIf
									Next
									If $iQueueCap <> ($aMaxCapacity[0] - $CurCamp) Then ContinueLoop
									ExitLoop
								EndIf
								If _Sleep(1000) Then Return
							WEnd
						Else
							$bNeedRemoveAllTroops = True
						EndIf
							If $bNeedRemoveAllTroops = True Then
								;SetLog("There are some old troops remain pre-train, remove all before new train",$COLOR_ACTION)
								RemoveAllTroopAlreadyTrain()
								If $icmbMyQuickTrain <> 0 Then
									DoMyQuickTrain($icmbMyQuickTrain)
									Return
								EndIf
							Else
								; reset build army troops unit
								For $i = 0 To UBound($tempTroops) - 1
									Local $iOnQQty = Eval("OnQ" & $tempTroops[$i][0])
									If $iOnQQty > 0 Then
										If $iOnQQty <= Eval("Add" & $tempTroops[$i][0]) Then
											Assign("Add" & $tempTroops[$i][0], Eval("Dif" & $tempTroops[$i][0]) - $iOnQQty)
										EndIf
									EndIf
								Next
							EndIf
							If _Sleep($tDelayBtn) Then Return
						;EndIf
					EndIf
				EndIf
				$iRemainTroopsCapacity = $TotalCamp
			Else
				$iRemainTroopsCapacity = $TotalCamp - $CurCamp
			EndIf

			For $i = 0 To UBound($tempTroops) - 1
				Local $iOnQQty = Eval("Add" & $tempTroops[$i][0])
				If $iOnQQty > 0 Then
					SetLog("Prepare for train number Of " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]), $iOnQQty) & " x" & $iOnQQty,$COLOR_ACTION)
				EndIf
			Next

			For $i = 0 To UBound($tempTroops) - 1
				Local $Troop4Add = Eval("Add" & $tempTroops[$i][0])
				If $Troop4Add > 0 Then

;~ 				If $isIceWizardAvailable <> 1 Then ; Check if santa spell variable is not set YET
;~ 					ForceCaptureRegion()
;~ 					Local $_IsIceWizardPixel[4] = [357, 513, 0xD0AF98, 20]

;~ 					Local $rPixelCheck = _CheckPixel($_IsIceWizardPixel, True)

;~ 					If $rPixelCheck = True Then
;~ 						$isIceWizardAvailable = 1
;~ 					Else
;~ 						$isIceWizardAvailable = 0
;~ 					EndIf
;~ 				EndIf
;~ 				If $isIceWizardAvailable = 1 Then
;~ 					Global $aButtonTrainHeal[9]               = [441,  390 + $midOffsetY, 491, 425 + $midOffsetY, 481, 397 + $midOffsetY,   0XF0A48A, 20, "=-= Train Healer"]
;~ 					Global $aButtonTrainPekk[9]               = [540,  390 + $midOffsetY, 590, 425 + $midOffsetY, 558, 374 + $midOffsetY,   0X404C7F, 20, "=-= Train Pekka"]
;~ 					Global $aButtonTrainMine[9]               = [639,  390 + $midOffsetY, 689, 425 + $midOffsetY, 672, 396 + $midOffsetY,   0XFFDCAC, 20, "=-= Train Miner"]
;~ 					Global $aButtonTrainDrag[9]               = [441,  490 + $midOffsetY, 491, 525 + $midOffsetY, 471, 484 + $midOffsetY,   0X7760E0, 20, "=-= Train Dragon"]
;~ 					Global $aButtonTrainBabyD[9]              = [540,  490 + $midOffsetY, 590, 525 + $midOffsetY, 556, 472 + $midOffsetY,   0X80DA55, 20, "=-= Train Baby Dragon"]

;~ 					Global $aButtonTrainMini[9]               = [740,  390 + $midOffsetY, 790, 425 + $midOffsetY, 780, 379 + $midOffsetY,   0XB0E9F8, 20, "=-= Train Minion"]
;~ 					Global $aButtonTrainHogs[9]               = [740,  490 + $midOffsetY, 790, 525 + $midOffsetY, 774, 472 + $midOffsetY,   0XC99888, 20, "=-= Train Hog Rider"]

;~ 					Global $aButtonTrainValk[9]               = [565,  390 + $midOffsetY, 615, 425 + $midOffsetY, 604, 403 + $midOffsetY,   0XF1A078, 20, "=-= Train Valkyrie"]
;~ 					Global $aButtonTrainGole[9]               = [565,  490 + $midOffsetY, 615, 525 + $midOffsetY, 594, 483 + $midOffsetY,   0XC8B198, 20, "=-= Train Golem"]

;~ 				Else
;~ 					Global $aButtonTrainDrag[9]               = [441,  390 + $midOffsetY, 491, 425 + $midOffsetY, 469, 365 + $midOffsetY,   0X8179E8, 20, "=-= Train Dragon"]
;~ 					Global $aButtonTrainBabyD[9]              = [540,  390 + $midOffsetY, 590, 425 + $midOffsetY, 558, 370 + $midOffsetY,   0X80D650, 20, "=-= Train Baby Dragon"]
;~ 					Global $aButtonTrainHeal[9]               = [342,  490 + $midOffsetY, 395, 525 + $midOffsetY, 360, 464 + $midOffsetY,   0XEDDACA, 20, "=-= Train Healer"]
;~ 					Global $aButtonTrainPekk[9]               = [441,  490 + $midOffsetY, 491, 525 + $midOffsetY, 478, 474 + $midOffsetY,   0XABD6F0, 20, "=-= Train Pekka"]
;~ 					Global $aButtonTrainMine[9]               = [540,  490 + $midOffsetY, 590, 525 + $midOffsetY, 577, 494 + $midOffsetY,   0XFFDCAB, 20, "=-= Train Miner"]

;~ 					Global $aButtonTrainMini[9]               = [645,  390 + $midOffsetY, 695, 425 + $midOffsetY, 677, 381 + $midOffsetY,   0X66B5E6, 20, "=-= Train Minion"]
;~ 					Global $aButtonTrainHogs[9]               = [645,  490 + $midOffsetY, 695, 525 + $midOffsetY, 680, 471 + $midOffsetY,   0XCC9988, 20, "=-= Train Hog Rider"]
;~ 					Global $aButtonTrainValk[9]               = [744,  390 + $midOffsetY, 794, 425 + $midOffsetY, 766, 366 + $midOffsetY,   0XF05002, 20, "=-= Train Valkyrie"]
;~ 					Global $aButtonTrainGole[9]               = [744,  490 + $midOffsetY, 794, 525 + $midOffsetY, 775, 478 + $midOffsetY,   0XC8B298, 20, "=-= Train Golem"]
;~ 				EndIf

					Local $tempButton = Eval("aButtonTrain" & $tempTroops[$i][0])
					Local $fixRemain = 0

					; check need swipe
					CheckNeedSwipe(Eval("e" & $tempTroops[$i][0]))

					Local $iCost
					; check train cost before click, incase use gem
					If $tempTroops[$i][4] = 0 Then
						$iCost = getTroopCost($tempTroops[$i][0])
						If $iCost = 0 Then
							; cannot read train cost, use max level train cost
							$iCost = $MyTroopsCost[Eval("e" & $tempTroops[$i][0])][0]
						EndIf
						$tempTroops[$i][4] = $iCost
						$MyTroops[Eval("e" & $tempTroops[$i][0])][4] = $iCost
					EndIf

					$iCost = $tempTroops[$i][4]
					If $debugsetlogTrain = 1 Then SetLog("$iCost: " & $iCost)

					Local $iBuildCost = (Eval("e" & $tempTroops[$i][0]) > 11 ? getMyOcrCurDEFromTrain() : getMyOcrCurGoldFromTrain())
					If $debugsetlogTrain = 1 Then SetLog("$iBuildCost: " & $iBuildCost)
					If $debugsetlogTrain = 1 Then SetLog("Total need: " & ($Troop4Add * $iCost))
					If ($Troop4Add * $iCost) > $iBuildCost Then
						$bFlagOutOfResource = True
						; use eval and not $i to compare because of maybe after array sort $tempTroops
						Setlog("Not enough " & (Eval("e" & $tempTroops[$i][0]) > 11 ? "Dark " : "") & "Elixir to train " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]),0) & " troops!", $COLOR_ERROR)
					EndIf

					If $bFlagOutOfResource Then
						$OutOfElixir = 1
						Setlog("Switching to Halt Attack, Stay Online Mode...", $COLOR_ERROR)
						$ichkBotStop = 1 ; set halt attack variable
						$icmbBotCond = 18; set stay online
						If Not ($fullarmy = True) Then $Restart = True ;If the army camp is full, If yes then use it to refill storages
						Return ; We are out of Elixir stop training.
					EndIf
					; use eval and not $i to compare because of maybe after array sort $tempTroops
					SetLog("Ready to train " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]),$Troop4Add) & " x" & $Troop4Add & " with total " & (Eval("e" & $tempTroops[$i][0]) > 11 ? "Dark " : "") & "Elixir: " & ($Troop4Add * $iCost),(Eval("e" & $tempTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))

					If ($tempTroops[$i][2] * $Troop4Add) <= $iRemainTroopsCapacity Then
						MyTrainClick(Eval("aButtonTrain" & $tempTroops[$i][0]),$Troop4Add,$isldTrainITDelay,"#TT01")
						$iRemainTroopsCapacity -= ($tempTroops[$i][2] * $Troop4Add)
					Else
						Local $iReduceCap = Int($iRemainTroopsCapacity / $tempTroops[$i][2])
						SetLog("troops above cannot fit to max capicity, reduce to train " & MyNameOfTroop(Eval("e" & $tempTroops[$i][0]),$iReduceCap) & " x" & $iReduceCap,$COLOR_ERROR)
						MyTrainClick(Eval("aButtonTrain" & $tempTroops[$i][0]),$iReduceCap ,$isldTrainITDelay,"#TT01")
						$fixRemain = $iRemainTroopsCapacity - ($iReduceCap * $tempTroops[$i][2])
						$iRemainTroopsCapacity -= ($iRemainTroopsCapacity - ($iReduceCap * $tempTroops[$i][2]))
					EndIf
					If $fixRemain > 0 Then
						CheckNeedSwipe($eArch)
						SetLog("still got remain capacity, so train " & MyNameOfTroop(Eval("eArch"),$fixRemain) & " x" & $fixRemain & " to fit it.",$COLOR_ERROR)
						MyTrainClick($aButtonTrainArch,$fixRemain,$isldTrainITDelay,"#TT01")
						$iRemainTroopsCapacity -= $fixRemain
					EndIf
					; reduce some speed
					If _Sleep(500) Then Return
				EndIf
			Next
		Else
			SetLog("Cannot open train troops tab page.",$COLOR_ERROR)
		EndIf
	EndIf
EndFunc

Func DoMyQuickTrain($MyTrainArmy)
	If gotoTrainTroops() Then
		; delete all exist pretrain troops before full train
		Local $aMaxCapacity = getTrainArmyCapacity()

		If $aMaxCapacity = "" then Return
		If $debugsetlogTrain = 1 Then SetLog("Train Troops Capacity: " & $aMaxCapacity[0] & "/" & $aMaxCapacity[1])
		If IsArray($aMaxCapacity) Then
			;If $aMaxCapacity[0] >= ((($aMaxCapacity[1] * $fulltroop) / 100) * 2) Then
			;	SetLog("There are already full troops pre-train, skip train.",$COLOR_INFO)
			;	Return
			;Else
				If $aMaxCapacity[0] > Int(($aMaxCapacity[1] * $fulltroop) / 100) And $fulltroop = 100 Then
					;SetLog("There are some old troops remain pre-train, change to custom train for revamp queue troops.",$COLOR_ACTION)
					DoCheckReVamp(True)
					Return
				Else
					RemoveAllTroopAlreadyTrain()
				EndIf
			;EndIf
		EndIf

		If _Sleep(200) Then Return

		If gotoQuickTrain() = True Then
			Local $aButtonTemp[9]
			Switch $MyTrainArmy
				Case 1
					$aButtonTemp = $aButtonTrainArmy1
				Case 2
					$aButtonTemp = $aButtonTrainArmy2
				case 3
					$aButtonTemp = $aButtonTrainArmy3
			EndSwitch
			If _Sleep(200) Then Return
			If _ColorCheck(_GetPixelColor($aButtonTemp[4], $aButtonTemp[5], True), Hex($aButtonTemp[6], 6), $aButtonTemp[7]) Then
				Local $x, $y
				HMLClickPR($aButtonTemp, $x, $y)
				HMLClick($x, $y)
				SetLog("Train army using quick train army " & $MyTrainArmy & " button.", $COLOR_SUCCESS)
				If _Sleep(200) Then Return
			Else
				SetLog("Failed to locate quick train army " & $MyTrainArmy & " button.", $COLOR_ERROR)
				SetLog("Try using custom train for train troops.", $COLOR_ERROR)
				DoCheckReVamp(True)
			EndIf
		Else
			SetLog("Cannot open quick train tab page.",$COLOR_ERROR)
		EndIf
	Else
		SetLog("Cannot open train troops tab page.",$COLOR_ERROR)
	EndIf
EndFunc

Func CheckNeedSwipe($TrainTroop)
	; check need swipe
	Local $iSwipeNum = 15
;~ 	If $isIceWizardAvailable = 1 Then $iSwipeNum = 13
	If $TrainTroop > $iSwipeNum Then
		If _ColorCheck(_GetPixelColor(22, 370 + $midOffsetY, True), Hex(0XD3D3CB, 6), 10) Then
;~ 			If $isIceWizardAvailable = 1 Then
;~ 				ClickDrag(712,476,218,476,250)
;~ 				If _sleep(500) Then Return
;~ 			Else
				ClickDrag(617,476,418,476,250)
				If _sleep(500) Then Return
;~ 			EndIf
		EndIf
	Else
		If _ColorCheck(_GetPixelColor(22, 370 + $midOffsetY, True), Hex(0XD3D3CB, 6), 10) = False Then
;~ 			If $isIceWizardAvailable = 1 Then
;~ 				ClickDrag(136,476,636,476,250)
;~ 				If _sleep(500) Then Return
;~ 			Else
				ClickDrag(436,476,636,476,250)
				If _sleep(500) Then Return
;~ 			EndIf
		EndIf
	EndIf
EndFunc

Func getTroopCost($trooptype)
;~ 	If $isIceWizardAvailable <> 1 Then ; Check if santa spell variable is not set YET
;~ 		ForceCaptureRegion()
;~ 		Local $_IsIceWizardPixel[4] = [357, 513, 0xD0AF98, 20]
;~ 		Local $rPixelCheck = _CheckPixel($_IsIceWizardPixel, True)

;~ 		If $rPixelCheck = True Then
;~ 			$isIceWizardAvailable = 1
;~ 		Else
;~ 			$isIceWizardAvailable = 0
;~ 		EndIf
;~ 	EndIf
	Local $iResult = 0
;~ 	If $isIceWizardAvailable = 1 Then
;~ 	Switch $trooptype
;~ 		Case "Heal"
;~ 			$iResult = getMyOcr(424,450,60,16,"troopcost",True)
;~ 		Case "Drag"
;~ 			$iResult = getMyOcr(424,552,60,16,"troopcost",True)
;~ 		Case "Pekk"
;~ 			$iResult = getMyOcr(522,450,60,16,"troopcost",True)
;~ 		Case "BabyD"
;~ 			$iResult = getMyOcr(522,552,60,16,"troopcost",True)
;~ 		Case "Mine"
;~ 			$iResult = getMyOcr(620,450,60,16,"troopcost",True)

;~ 		Case "Mini"
;~ 			$iResult = getMyOcr(725,450,60,16,"troopcost",True)
;~ 		Case "Hogs"
;~ 			$iResult = getMyOcr(725,552,60,16,"troopcost",True)

;~ 		Case "Valk"
;~ 			$iResult = getMyOcr(548,450,60,16,"troopcost",True)
;~ 		Case "Gole"
;~ 			$iResult = getMyOcr(548,552,60,16,"troopcost",True)


;~ 		Case "Barb"
;~ 			$iResult = getMyOcr(30,450,60,16,"troopcost",True)
;~ 		Case "Arch"
;~ 			$iResult = getMyOcr(30,552,60,16,"troopcost",True)
;~ 		Case "Giant"
;~ 			$iResult = getMyOcr(128,450,60,16,"troopcost",True)
;~ 		Case "Gobl"
;~ 			$iResult = getMyOcr(128,552,60,16,"troopcost",True)
;~ 		Case "Wall"
;~ 			$iResult = getMyOcr(226,450,60,16,"troopcost",True)
;~ 		Case "Ball"
;~ 			$iResult = getMyOcr(226,552,60,16,"troopcost",True)

;~ 		Case "Wiza"
;~ 			$iResult = getMyOcr(325,450,60,16,"troopcost",True)

;~ 		Case "Witc"
;~ 			$iResult = getMyOcr(648,450,60,16,"troopcost",True)
;~ 		Case "Lava"
;~ 			$iResult = getMyOcr(648,552,60,16,"troopcost",True)
;~ 		Case "Bowl"
;~ 			$iResult = getMyOcr(747,450,60,16,"troopcost",True)

;~ 	EndSwitch

;~ 	Else
	Switch $trooptype
		Case "Barb"
			$iResult = getMyOcr(35,450,60,16,"troopcost",True)
		Case "Arch"
			$iResult = getMyOcr(35,552,60,16,"troopcost",True)
		Case "Giant"
			$iResult = getMyOcr(134,450,60,16,"troopcost",True)
		Case "Gobl"
			$iResult = getMyOcr(134,552,60,16,"troopcost",True)
		Case "Wall"
			$iResult = getMyOcr(233,450,60,16,"troopcost",True)
		Case "Ball"
			$iResult = getMyOcr(233,552,60,16,"troopcost",True)
		Case "Wiza"
			$iResult = getMyOcr(332,450,60,16,"troopcost",True)
		Case "Heal"
			$iResult = getMyOcr(332,552,60,16,"troopcost",True)
		Case "Drag"
			$iResult = getMyOcr(431,450,60,16,"troopcost",True)
		Case "Pekk"
			$iResult = getMyOcr(431,552,60,16,"troopcost",True)
		Case "BabyD"
			$iResult = getMyOcr(530,450,60,16,"troopcost",True)
		Case "Mine"
			$iResult = getMyOcr(530,552,60,16,"troopcost",True)

		Case "Mini"
			$iResult = getMyOcr(632,450,60,16,"troopcost",True)
		Case "Hogs"
			$iResult = getMyOcr(632,552,60,16,"troopcost",True)
		Case "Valk"
			$iResult = getMyOcr(731,450,60,16,"troopcost",True)
		Case "Gole"
			$iResult = getMyOcr(731,552,60,16,"troopcost",True)
		Case "Witc"
			$iResult = getMyOcr(648,450,60,16,"troopcost",True)
		Case "Lava"
			$iResult = getMyOcr(648,552,60,16,"troopcost",True)
		Case "Bowl"
			$iResult = getMyOcr(747,450,60,16,"troopcost",True)

	EndSwitch
;~ 	EndIf
	If $debugsetlogTrain = 1 Then SetLog("$iResult: " & $iResult)
	If $iResult = "" Then $iResult = 0
	Return $iResult
EndFunc

Func getSpellCost($trooptype)
;~ 	If $isSantaSpellAvailable <> 1 Then ; Check if santa spell variable is not set YET
;~ 		ForceCaptureRegion()
;~ 		Local $_IsSantaSpellPixel[4] = [65, 540, 0x7C0427, 20]

;~ 		Local $rPixelCheck = _CheckPixel($_IsSantaSpellPixel, True)

;~ 		If $rPixelCheck = True Then
;~ 			$isSantaSpellAvailable = 1
;~ 		Else
;~ 			$isSantaSpellAvailable = 0
;~ 		EndIf
;~ 	EndIf

	Local $iResult = 0
;~ 	If $isSantaSpellAvailable = 1 Then
;~ 		Switch $trooptype
;~ 			Case "Lightning"
;~ 				$iResult = getMyOcr(35,450,60,16,"troopcost",True)
;~ 			Case "Heal"
;~ 				$iResult = getMyOcr(132,450,60,16,"troopcost",True)
;~ 			Case "Jump"
;~ 				$iResult = getMyOcr(230,450,60,16,"troopcost",True)

;~ 			Case "Clone"
;~ 				$iResult = getMyOcr(328,450,60,16,"troopcost",True)

;~ 			Case "Rage"
;~ 				$iResult = getMyOcr(132,550,60,16,"troopcost",True)
;~ 			Case "Freeze"
;~ 				$iResult = getMyOcr(230,550,60,16,"troopcost",True)

;~ 			Case "Poison"
;~ 				$iResult = getMyOcr(336+98,450,60,16,"troopcost",True)
;~ 			Case "Earth"
;~ 				$iResult = getMyOcr(336+98,550,60,16,"troopcost",True)
;~ 			Case "Haste"
;~ 				$iResult = getMyOcr(434+98,450,60,16,"troopcost",True)
;~ 			Case "Skeleton"
;~ 				$iResult = getMyOcr(434+98,550,60,16,"troopcost",True)
;~ 		EndSwitch
;~ 	Else
		Switch $trooptype
			Case "Lightning"
				$iResult = getMyOcr(35,450,60,16,"troopcost",True)
			Case "Rage"
				$iResult = getMyOcr(132,450,60,16,"troopcost",True)
			Case "Freeze"
				$iResult = getMyOcr(230,450,60,16,"troopcost",True)

			Case "Heal"
				$iResult = getMyOcr(35,550,60,16,"troopcost",True)
			Case "Jump"
				$iResult = getMyOcr(132,550,60,16,"troopcost",True)
			Case "Clone"
				$iResult = getMyOcr(230,550,60,16,"troopcost",True)

			Case "Poison"
				$iResult = getMyOcr(336,450,60,16,"troopcost",True)
			Case "Earth"
				$iResult = getMyOcr(336,550,60,16,"troopcost",True)
			Case "Haste"
				$iResult = getMyOcr(434,450,60,16,"troopcost",True)
			Case "Skeleton"
				$iResult = getMyOcr(434,550,60,16,"troopcost",True)
		EndSwitch
;~ 	EndIf
	If $debugsetlogTrain = 1 Then SetLog("$iResult: " & $iResult)
	If $iResult = "" Then $iResult = 0
	Return $iResult
EndFunc

Func getTrainArmyCapacity()
	If $debugsetlogTrain = 1 Or $debugSetlog = 1 Then SETLOG("Begin getTrainArmyCapacity:", $COLOR_DEBUG1)

	Local $aGetFactorySize
	Local $iCount
	Local $sArmyInfo = ""
	Local $CurBrewSFactory = 0
	Local $tempCurS = 0
	Local $tempCurT = 0

	; Verify spell current and total capacity
	If $iTotalCountSpell > 0 Then ; only use this code if the user had input spells to brew ... and assign the spells quantity
		$iCount = 0 ; reset OCR loop counter
		While $iCount < 20 ; In case the CC donations recieved msg are blocking, need to keep checking numbers till valid
			;$sArmyInfo = getArmyCampCap($aArmySpellSize[0], $aArmySpellSize[1]) ; OCR read Spells and total capacity
			; samm0d
			$sArmyInfo = getMyOcrTrainArmyOrBrewSpellCap() ; OCR read Spells and total capacity
			$aGetFactorySize = StringSplit($sArmyInfo, "#", $STR_NOCOUNT) ; split the existen Spells from the total Spell factory capacity
			If IsArray($aGetFactorySize) Then
				If UBound($aGetFactorySize) > 1 Then
					If $aGetFactorySize[0] <> "" And $aGetFactorySize[1] <> "" Then
						If $tempCurS = Number($aGetFactorySize[0]) And $tempCurT = Number($aGetFactorySize[1]) Then ExitLoop
						$tempCurS = Number($aGetFactorySize[0])
						$tempCurT = Number($aGetFactorySize[1])
					EndIf
				EndIf
			EndIf
			$iCount += 1
			If _Sleep(200) Then Return ""; Wait 200ms
		WEnd

		If $iCount >= 20 Then
			If $debugsetlogTrain = 1 Then Setlog("$sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
			SetLog("Error reading ocr for train troops capacity, please check your setting or contact author.", $COLOR_ERROR)
			Return ""
		Else
			If $debugsetlogTrain = 1 Then Setlog("$sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
			SetLog("Train Troops: " & $tempCurS & "/" & $tempCurT)
		EndIf
	EndIf

	If $TotalCamp <> $tempCurT Then ; if Total camp size is still not set or value not same as read use forced value
		If $ichkTotalCampForced = 0 Then ; check if forced camp size set in expert tab
		    Local $proposedTotalCamp = $tempCurT
			If $TotalCamp > $tempCurT Then $proposedTotalCamp = $TotalCamp
			$sInputbox = InputBox("Question", _
								  "Enter your total Army Camp capacity." & @CRLF & @CRLF & _
								  "Please check it matches with total Army Camp capacity" & @CRLF & _
								  "you see in Army Overview right now in Android Window:" & @CRLF & _
								  $Title & @CRLF & @CRLF & _
								  "(This window closes in 2 Minutes with value of " & $proposedTotalCamp & ")", $proposedTotalCamp, "", 330, 220, Default, Default, 120, $frmbot)
			Local $error = @error
			If $error = 1 Then
			   Setlog("Army Camp User input cancelled, still using " & $TotalCamp, $COLOR_ACTION)
			Else
			   If $error = 2 Then
				  ; Cancelled, using proposed value
				  $TotalCamp = $proposedTotalCamp
			   Else
				  $TotalCamp = Number($sInputbox)
			   EndIf
			   If $error = 0 Then
				  $iValueTotalCampForced = $TotalCamp
				  $ichkTotalCampForced = 1
				  Setlog("Army Camp User input = " & $TotalCamp, $COLOR_INFO)
			   Else
				  ; timeout
				  Setlog("Army Camp proposed value = " & $TotalCamp, $COLOR_ACTION)
			   EndIf
			EndIF
		Else
			$TotalCamp = Number($iValueTotalCampForced)
		EndIf
	EndIf


	Return $aGetFactorySize
EndFunc   ;==>getTrainArmyCapacity
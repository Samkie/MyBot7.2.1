; #FUNCTION# ====================================================================================================================
; Name ..........: getCCCapacity
; Description ...: Obtains current and total capacity of troops from Training - Army Overview window
; Syntax ........: getCCCapacity()
; Parameters ....:
;
; Return values .: None
; Author ........:
; Modified ......: Samkie (19 JUN 2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func getMyArmyCCCapacity()
	If $g_iSamM0dDebug = 1 Or $g_iDebugSetlog = 1 Then SETLOG("Begin getCCCapacity:", $COLOR_DEBUG1)
	Local $aGetCCSize[3] = ["", "", ""]
	Local $sCCInfo = ""
	Local $iCount

	$iCount = 0 ; reset loop safety exit counter

	While 1
		$sCCInfo = getMyOcrCCCap()
		If $g_iSamM0dDebug = 1 Then Setlog("$sCCInfo = " & $sCCInfo, $COLOR_DEBUG)
		$aGetCCSize = StringSplit($sCCInfo, "#")
		If IsArray($aGetCCSize) Then
			If $aGetCCSize[0] > 1 Then
				If Number($aGetCCSize[2]) < 10 Or Mod(Number($aGetCCSize[2]), 5) <> 0 Then ; check to see if camp size is multiple of 5, or try to read again
					If $g_iSamM0dDebug = 1 Then Setlog(" OCR value is not valid cc camp size", $COLOR_DEBUG)
					ContinueLoop
				EndIf
				$CurTotalCCCamp = Number($aGetCCSize[2])
				$CurCCCamp = Number($aGetCCSize[1])
				$CCCapacity = Int($CurCCCamp / $CurTotalCCCamp * 100)
				SetLog("Clan Castle troops: " & $CurCCCamp & "/" & $CurTotalCCCamp & " (" & $CCCapacity & "%)")
				ExitLoop
			Else
				$CurCCCamp = 0
				$CurTotalCCCamp = 0
			EndIf
		Else
			$CurCCCamp = 0
			$CurTotalCCCamp = 0
		EndIf
		$iCount += 1
		If $iCount > 100 Then ExitLoop ; try reading 30 times for 250+150ms OCR for 4 sec
		If _Sleep(250) Then Return ; Wait 250ms
	WEnd

	If $CurCCCamp = 0 And $CurTotalCCCamp = 0 Then
		Setlog("CC size read error...", $COLOR_ERROR) ; log if there is read error
		$FullCCTroops = True
		If $g_iChkWait4CC = 1 Then $FullCCTroops = False
		;If ($g_abAttackTypeEnable[$DB] And $g_abSearchCastleTroopsWaitEnable[$DB]) Or ($g_abAttackTypeEnable[$LB] And $g_abSearchCastleTroopsWaitEnable[$LB]) Then
		;	$FullCCTroops = False
		;EndIf
		Return
	EndIf
	;If _Sleep(500) Then Return
	If $g_iChkWait4CC = 1 Then
		If ($CurCCCamp >= ($CurTotalCCCamp * $CCStrength / 100)) Then
			$FullCCTroops = True
		Else
			$FullCCTroops = False
		EndIf
		If $FullCCTroops = False Then
			SETLOG(" All mode - Waiting clan castle troops before start attack.", $COLOR_ACTION)
		EndIf
	Else
		$FullCCTroops = True
	EndIf
EndFunc   ;==>getMyArmyCCCapacity

Func getMyArmyCCSpellCapacity()
	If $g_iSamM0dDebug = 1 Or $g_iDebugSetlog = 1 Then SETLOG("Begin getMyArmyCCSpellCapacity:", $COLOR_DEBUG1)
	Local $aGetCCSpellSize[3] = ["", "", ""]
	Local $sCCSpellInfo = ""
	Local $iCount
	$iCount = 0 ; reset loop safety exit counter
	While 1
		$sCCSpellInfo = getMyOcrCCSpellCap()
		If $g_iSamM0dDebug = 1 Then Setlog("$sCCSpellInfo = " & $sCCSpellInfo, $COLOR_DEBUG)
		$aGetCCSpellSize = StringSplit($sCCSpellInfo, "#")
		If IsArray($aGetCCSpellSize) Then
			If $aGetCCSpellSize[0] > 1 Then
				If Number($aGetCCSpellSize[2]) > 2 And $aGetCCSpellSize[2] = 0 Then
					If $g_iSamM0dDebug = 1 Then Setlog(" OCR value is not valid cc spell camp size", $COLOR_DEBUG)
					ContinueLoop
				EndIf
				$g_iCurTotalCCSpellCamp = Number($aGetCCSpellSize[2])
				$g_iCurCCSpellCamp = Number($aGetCCSpellSize[1])
				SetLog("Clan Castle spells: " & $g_iCurCCSpellCamp & "/" & $g_iCurTotalCCSpellCamp)
				ExitLoop
			Else
				$g_iCurCCSpellCamp = 0
				$g_iCurTotalCCSpellCamp = 0
			EndIf
		Else
			$g_iCurCCSpellCamp = 0
			$g_iCurTotalCCSpellCamp = 0
		EndIf
		$iCount += 1
		If $iCount > 100 Then ExitLoop
		If _Sleep(250) Then Return ; Wait 250ms
	WEnd
	If $g_iCurCCSpellCamp = 0 And $g_iCurTotalCCSpellCamp = 0 Then
		Setlog("CC Spell size read error...", $COLOR_ERROR) ; log if there is read error
		$g_bFullCCSpells = True
		If $g_iChkWait4CCSpell = 1 Then $g_bFullCCSpells = False
		Return
	EndIf
	If $g_iChkWait4CCSpell = 1 Then
		If $g_iCurCCSpellCamp >= $g_iCurTotalCCSpellCamp Then
			$g_bFullCCSpells = True
		Else
			$g_bFullCCSpells = False
		EndIf
		If $g_bFullCCSpells = False Then
			SETLOG(" All mode - Waiting clan castle spells before start attack.", $COLOR_ACTION)
		EndIf
	Else
		$g_bFullCCSpells = True
	EndIf
EndFunc   ;==>getMyArmyCCSpellCapacity

Func getTrainArmyCapacity($bSpellFlag = False)
	If $g_iSamM0dDebug = 1 Or $g_iDebugSetlog = 1 Then SETLOG("Begin getTrainArmyCapacity:", $COLOR_DEBUG1)

	Local $aGetFactorySize[2] = [0,0]
	Local $aTempSize
	Local $iCount
	Local $sArmyInfo = ""
	Local $CurBrewSFactory = 0
	Local $tempCurS = 0
	Local $tempCurT = 0
	Local $tmpTotalCamp = 0

	$iCount = 0
	While 1
		$sArmyInfo = getMyOcrTrainArmyOrBrewSpellCap()
		$aTempSize = StringSplit($sArmyInfo, "#", $STR_NOCOUNT)
		If IsArray($aTempSize) Then
			If UBound($aTempSize) = 2 Then
				If Number($aTempSize[1]) < 20 Or Mod(Number($aTempSize[1]), 5) <> 0 Then ; check to see if camp size is multiple of 5, or try to read again
					If $g_iSamM0dDebug = 1 Then Setlog(" OCR value is not valid camp size", $COLOR_DEBUG)
					ContinueLoop
				EndIf
				$tmpTotalCamp = Number($aTempSize[1])
				$tempCurS = Number($aTempSize[0])
				If $tempCurT = 0 Then $tempCurT = $tmpTotalCamp
				If $g_iSamM0dDebug = 1 Then Setlog("$tempCurS = " & $tempCurS & ", $tempCurT = " & $tempCurT, $COLOR_DEBUG)
				ExitLoop
			Else
				$tempCurS = 0
				$tmpTotalCamp = 0
			EndIf
		Else
			$tempCurS = 0
			$tmpTotalCamp = 0
		EndIf
		$iCount += 1
		If $iCount > 100 Then ExitLoop ; try reading 30 times for 250+150ms OCR for 4 sec
		If _Sleep(250) Then Return ; Wait 250ms
	WEnd
	$aGetFactorySize[0] = $tempCurS
	$aGetFactorySize[1] = $tempCurT
	If $bSpellFlag = False Then
		If $g_iTotalCampSpace <> ($tempCurT / 2) Then ; if Total camp size is still not set or value not same as read use forced value
			If $g_bTotalCampForced = False Then ; check if forced camp size set in expert tab
				Local $proposedTotalCamp = $tempCurT
				If $g_iTotalCampSpace > $tempCurT Then $proposedTotalCamp = $g_iTotalCampSpace
				Local $sInputbox = InputBox("Question", _
									  "Enter your total Army Camp capacity." & @CRLF & @CRLF & _
									  "Please check it matches with total Army Camp capacity" & @CRLF & _
									  "you see in Army Overview right now in Android Window:" & @CRLF & _
									  $g_sAndroidTitle & @CRLF & @CRLF & _
									  "(This window closes in 2 Minutes with value of " & $proposedTotalCamp & ")", $proposedTotalCamp, "", 330, 220, Default, Default, 120, $g_hFrmBotEx)
				Local $error = @error
				If $error = 1 Then
				   Setlog("Army Camp User input cancelled, still using " & $g_iTotalCampSpace, $COLOR_ACTION)
				Else
				   If $error = 2 Then
					  ; Cancelled, using proposed value
					  $g_iTotalCampSpace = $proposedTotalCamp
				   Else
					  $g_iTotalCampSpace = Number($sInputbox)
				   EndIf
				   If $error = 0 Then
					  $g_iTotalCampForcedValue = $g_iTotalCampSpace
					  $g_bTotalCampForced = True
					  Setlog("Army Camp User input = " & $g_iTotalCampSpace, $COLOR_INFO)
				   Else
					  ; timeout
					  Setlog("Army Camp proposed value = " & $g_iTotalCampSpace, $COLOR_ACTION)
				   EndIf
				EndIF
			Else
				$g_iTotalCampSpace = Number($g_iTotalCampForcedValue)
			EndIf
		EndIf
	Else
		If ($tempCurT / 2) <> $g_iTotalSpellValue Then
			Setlog("Note: Spell Factory Size read not same User Input Value.", $COLOR_WARNING) ; log if there difference between user input and OCR
		EndIf
	EndIf
	Return $aGetFactorySize
EndFunc   ;==>getTrainArmyCapacity

Func getMyArmyCapacityMini($hHBitmap, $bShowLog = True)
	Local $aGetArmySize[3] = ["", "", ""]
	Local $sArmyInfo = ""
	Local $tmpTotalCamp

	; reset Global Variable
	$g_CurrentCampUtilization = 0
	$g_iTotalCampSpace = 0

	$sArmyInfo = getMyOcrArmyCap($hHBitmap)
	If $g_iSamM0dDebug = 1 Then Setlog("getMyArmyCapacityMini $sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
	$aGetArmySize = StringSplit($sArmyInfo, "#")
	If IsArray($aGetArmySize) Then
		If $aGetArmySize[0] > 1 Then
			If Number($aGetArmySize[2]) < 20 Or Mod(Number($aGetArmySize[2]), 5) <> 0 Then ; check to see if camp size is multiple of 5, or try to read again
				If $g_iSamM0dDebug = 1 Then Setlog(" OCR value is not valid camp size", $COLOR_DEBUG)
			Else
				$g_CurrentCampUtilization = Number($aGetArmySize[1])
				$g_iTotalCampSpace = Number($aGetArmySize[2])
			EndIf
		EndIf
	EndIf
	If $g_iTotalCampSpace <> 0 Then
		$g_iArmyCapacity = Int($g_CurrentCampUtilization / $g_iTotalCampSpace * 100)
		If $bShowLog Then SetLog("Troops: " & $g_CurrentCampUtilization & "/" & $g_iTotalCampSpace & " (" & $g_iArmyCapacity & "%)")
	EndIf

	If $g_CurrentCampUtilization >= Int(($g_iMyTroopsSize * $g_iTrainArmyFullTroopPct) / 100) Then
		$g_bfullArmy = True
	Else
		$g_bfullArmy = False
	EndIf
EndFunc

Func getTrainArmyCapacityMini($hHBitmap, $bShowLog = True)
	Local $aTempSize
	Local $sArmyInfo = ""

	; reset Global Variable
	$g_aiTroopsMaxCamp[0] = 0
	$g_aiTroopsMaxCamp[1] = 0

	$sArmyInfo = getMyOcrTrainArmyOrBrewSpellCap($hHBitmap)
	If $g_iSamM0dDebug = 1 Then Setlog("getTrainArmyCapacityMini $sArmyInfo = " & $sArmyInfo, $COLOR_DEBUG)
	$aTempSize = StringSplit($sArmyInfo, "#", $STR_NOCOUNT)
	If IsArray($aTempSize) Then
		If UBound($aTempSize) = 2 Then
			If Number($aTempSize[1]) < 20 Or Mod(Number($aTempSize[1]), 5) <> 0 Then ; check to see if camp size is multiple of 5, or try to read again
				If $g_iSamM0dDebug = 1 Then Setlog(" OCR value is not valid camp size", $COLOR_DEBUG)
			Else
				$g_aiTroopsMaxCamp[0] = Number($aTempSize[0])
				$g_aiTroopsMaxCamp[1] = Number($aTempSize[1])
			EndIf
		EndIf
	EndIf
	If $g_aiTroopsMaxCamp[1] <> 0 Then
		If $bShowLog Then SetLog("Max Troops: " & $g_aiTroopsMaxCamp[0] & "/" & $g_aiTroopsMaxCamp[1])
	EndIf
EndFunc

Func getMySpellCapacityMini($hHBitmap, $bShowLog = True)
	Local $aGetSpellSize[3] = ["", "", ""]
	Local $sSpellInfo = ""
	Local $tmpTotalCamp

	; reset Global Variable
	$g_iSpellFactorySize = 0
	$g_iTotalSpellCampSpace = 0

	$sSpellInfo = getMyOcrSpellCap($hHBitmap)
	If $g_iSamM0dDebug = 1 Then Setlog("getMySpellCapacityMini $sSpellInfo = " & $sSpellInfo, $COLOR_DEBUG)
	$aGetSpellSize = StringSplit($sSpellInfo, "#")
	If IsArray($aGetSpellSize) Then
		If $aGetSpellSize[0] > 1 Then
			$g_iSpellFactorySize = Number($aGetSpellSize[1])
			$g_iTotalSpellCampSpace = Number($aGetSpellSize[2])
		EndIf
	EndIf
	If $g_iTotalSpellCampSpace <> 0 Then
		If $bShowLog Then SetLog("Spells: " & $g_iSpellFactorySize & "/" & $g_iTotalSpellCampSpace)
	EndIf
	$g_bFullArmySpells = $g_iSpellFactorySize >= $g_iMySpellsSize
EndFunc

Func getBrewSpellCapacityMini($hHBitmap, $bShowLog = True)
	Local $aTempSize
	Local $sSpellInfo = ""

	; reset Global Variable
	$g_aiSpellsMaxCamp[0] = 0
	$g_aiSpellsMaxCamp[1] = 0

	$sSpellInfo = getMyOcrTrainArmyOrBrewSpellCap($hHBitmap)
	If $g_iSamM0dDebug = 1 Then Setlog("getBrewSpellCapacityMini $sSpellInfo = " & $sSpellInfo, $COLOR_DEBUG)
	$aTempSize = StringSplit($sSpellInfo, "#", $STR_NOCOUNT)
	If IsArray($aTempSize) Then
		If UBound($aTempSize) = 2 Then
			$g_aiSpellsMaxCamp[0] = Number($aTempSize[0])
			$g_aiSpellsMaxCamp[1] = Number($aTempSize[1])
		EndIf
	EndIf
	If $g_aiSpellsMaxCamp[1] <> 0 Then
		If $bShowLog Then SetLog("Max Spells: " & $g_aiSpellsMaxCamp[0] & "/" & $g_aiSpellsMaxCamp[1])
	EndIf
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........:
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Samkie (25 Jun 2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func gotoArmy()
	If IsTrainPage() Then
		Local $iCount = 0
		While _ColorCheck(_GetPixelColor($aButtonArmyTab[4],$aButtonArmyTab[5], True), Hex($aButtonArmyTab[6], 6), $aButtonArmyTab[7]) = False
			ClickP($aButtonArmyTab,1,0,"ArmyTab")
			$iCount += 1
			If $iCount >= 10 Then
				setlog("Failed to open army page.")
				Return False
			EndIf
			If _Sleep(100) Then Return
		WEnd
		If _Sleep(100) Then Return
		Return True
	EndIf
EndFunc

Func gotoTrainTroops()
	If IsTrainPage() Then
		Local $iCount = 0
		While _ColorCheck(_GetPixelColor($aButtonTrainTroopsTab[4],$aButtonTrainTroopsTab[5], True), Hex($aButtonTrainTroopsTab[6], 6), $aButtonTrainTroopsTab[7]) = False
			ClickP($aButtonTrainTroopsTab,1,0,"TrainTroopsTab")
			$iCount += 1
			If $iCount >= 10 Then
				setlog("Failed to open train troops page.")
				Return False
			EndIf
			If _Sleep(100) Then Return
		WEnd
		If _Sleep(100) Then Return
		Return True
	EndIf
EndFunc

Func gotoBrewSpells()
	If IsTrainPage() Then
		Local $iCount = 0
		While _ColorCheck(_GetPixelColor($aButtonBrewSpellsTab[4],$aButtonBrewSpellsTab[5], True), Hex($aButtonBrewSpellsTab[6], 6), $aButtonBrewSpellsTab[7]) = False
			ClickP($aButtonBrewSpellsTab,1,0,"BrewSpellsTab")
			$iCount += 1
			If $iCount >= 10 Then
				setlog("Failed to open brew spells page.")
				Return False
			EndIf
			If _Sleep(100) Then Return
		WEnd
		If _Sleep(100) Then Return
		Return True
	EndIf
EndFunc

Func gotoQuickTrain()
	If IsTrainPage() Then
		Local $iCount = 0
		While _ColorCheck(_GetPixelColor($aButtonQuickTrainTab[4],$aButtonQuickTrainTab[5], True), Hex($aButtonQuickTrainTab[6], 6), $aButtonQuickTrainTab[7]) = False
			ClickP($aButtonQuickTrainTab,1,0,"QuickTrainTab")
			$iCount += 1
			If $iCount >= 10 Then
				setlog("Failed to open quick train page.")
				Return False
			EndIf
			If _Sleep(100) Then Return
		WEnd
		If _Sleep(100) Then Return
		Return True
	EndIf
EndFunc
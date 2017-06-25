; #FUNCTION# ====================================================================================================================
; Name ..........:
; Description ...: This file Includes all functions to current GUI
; Syntax ........: RemoveSpecialObstacleBB()
; Parameters ....: None
; Return values .: None
; Author ........: Samkie(25 Jun, 2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func RemoveSpecialObstacleBB()
	getBuilderCount(True, True)
	If $g_iFreeBuilderCountBB = $g_iTotalBuilderCountBB Then
		BuildingClick(400,591)
		If _Sleep(500) Then Return
		Local $iTreeCoust = getMyOcr(0,407,595 + $g_iMidOffsetY,47,15,"armycap",True)
		If $iTreeCoust = 2000 Then
			HMLPureClick(Random(410,450,1), Random(640,670,1))
		EndIf
	EndIf
EndFunc
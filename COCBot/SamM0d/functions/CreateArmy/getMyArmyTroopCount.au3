
; #FUNCTION# ====================================================================================================================
; Name ..........: getArmyTroopCount
; Description ...: Reads current quanitites/type of troops from Training - Army Overview window, updates $CurXXXX and $g_avDTtroopsToBeUsed values
; Syntax ........: getArmyTroopCount()
; Parameters ....: $bOpenArmyWindow     - [optional] a boolean value. Default is False.
;                  $bCloseArmyWindow    - [optional] a boolean value. Default is False.
; Return values .: None
; Author ........: Samkie (27 Nov 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getMyArmyTroopCount($bOpenArmyWindow = False, $bCloseArmyWindow = False, $test = false)
	If $iSamM0dDebug = 1 Or $g_iDebugSetlog = 1 Then SETLOG("Begin getArmyTroopCount:", $COLOR_DEBUG1)

	If $test = false  Then
		If $bOpenArmyWindow = False And IsTrainPage() = False Then ; check for train page
			SetError(1)
			Return ; not open, not requested to be open - error.
		ElseIf $bOpenArmyWindow = True Then
			If openArmyOverview() = False Then
				SetError(2)
				Return ; not open, requested to be open - error.
			EndIf
			If _Sleep(250) Then Return
		EndIf
	Else
		Setlog("test")
	EndIf

	;====Reset the variable======
	For $i = 0 To UBound($g_avDTtroopsToBeUsed, 1) - 1
		$g_avDTtroopsToBeUsed[$i][1] = 0
	Next
	For $i = 0 To UBound($MyTroops) - 1
		Assign("cur" & $MyTroops[$i][0], 0)
	Next
	For $i = 0 To UBound($MyTroops) - 1
		Assign("OnQ" & $MyTroops[$i][0], 0)
	Next
	For $i = 0 To UBound($MyTroops) - 1
		Assign("OnT" & $MyTroops[$i][0], 0)
	Next
	For $i = 0 To 10
		Assign("RemSlot" & $i + 1, 0)
	Next
	;============================

	Local $iCount = 0

	While $g_CurrentCampUtilization > 0
		Local $iCount2 = 0
		While IsQueueBlockByMsg() ; 检查游戏上的讯息，是否有挡着训练界面， 最多30秒
			If _Sleep(1000) Then Return
			$iCount2 += 1
			If $iCount2 >= 30 Then
				ExitLoop
			EndIf
		WEnd

		Local $bDeletedExcess = False
		Local $iAvailableCamp = 0
		Local $iMyTroopsCampSize = 0

		; 预防进入死循环
		$iCount += 1
		If $iCount > 3 Then
			If $g_hHBitmapArmyTab <> 0 Then
				GdiDeleteHBitmap($g_hHBitmapArmyTab)
			EndIf
			If $g_hHBitmapTrainTab <> 0 Then
				GdiDeleteHBitmap($g_hHBitmapTrainTab)
			EndIf
			ExitLoop
		EndIf

		; 首先截获列队中的图像，然后去造兵界面截获排队中的图像
		If $g_hHBitmapArmyTab <> 0 Then
			GdiDeleteHBitmap($g_hHBitmapArmyTab)
		EndIf
		If $g_hHBitmapTrainTab <> 0 Then
			GdiDeleteHBitmap($g_hHBitmapTrainTab)
		EndIf

		If gotoArmy() = False Then Return

		getMyArmyCapacity(False,False,False)
		_CaptureGameScreen($g_hHBitmapArmyTab, $g_iArmyTab_x1, $g_iArmyTab_y1, $g_iArmyTab_x2, $g_iArmyTab_y2)

		If gotoTrainTroops() = False Then Return
		_CaptureGameScreen($g_hHBitmapTrainTab, $g_iTrainTab_x1, $g_iTrainTab_y1, $g_iTrainTab_x2, $g_iTrainTab_y2)

		_debugSaveHBitmapToImage($g_hHBitmapArmyTab, "debug_BitmapArmyTab")
		_debugSaveHBitmapToImage($g_hHBitmapTrainTab, "debug_BitmapTrainTab")

		$aiTroopsMaxCamp = getTrainArmyCapacity()

		SetLog("Max Troops: " & $aiTroopsMaxCamp[0] & "/" & $aiTroopsMaxCamp[1])

		; 检查列队中的队伍兵种和数量
		If _checkAvailableUnit() = True Then
			; 已经造好的部队没有问题，继续检查排队中正在训练的队伍
			If _checkOnTrainUnit() = True Then
				$bDeletedExcess = False
				For $i = 0 To UBound($MyTroops) - 1
					Local $itempTotal = Eval("cur" & $MyTroops[$i][0]) + Eval("OnT" & $MyTroops[$i][0])
					If Eval("OnT" & $MyTroops[$i][0]) > 0 Then
						SetLog(" - No. of On Train " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnT" & $MyTroops[$i][0])) & ": " &  Eval("OnT" & $MyTroops[$i][0]), (Eval("e" & $MyTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
					EndIf
					If $MyTroops[$i][3] < $itempTotal Then
						If $ichkEnableDeleteExcessTroops = 1 Then
							$bDeletedExcess = True
							ExitLoop
						EndIf
					EndIf
					If $itempTotal > 0 Then
						$iAvailableCamp += $itempTotal * $MyTroops[$i][2]
					EndIf
					If $MyTroops[$i][3] > 0 Then
						$iMyTroopsCampSize += $MyTroops[$i][3] * $MyTroops[$i][2]
					EndIf
				Next

				If $bDeletedExcess Then
					$bDeletedExcess = False
					;If _ColorCheck(_GetPixelColor(389, 99 + $g_iMidOffsetY, True), Hex(0X6AB31F, 6), 10) Then ; check color if got train arrow
					;If _ColorCheck(_GetPixelColor(389, 100 + $g_iMidOffsetY, True), Hex(0X5E5748, 6), 20) = False Then
					If gotoTrainTroops() = False Then Return
					If Not _ColorCheck(_GetPixelColor(823, 175 + $g_iMidOffsetY, True), Hex(0xCFCFC8, 6), 20) Then
						SetLog(" >>> stop train troops.", $COLOR_RED)
						If _Sleep(1000) Then Return
						RemoveAllTroopAlreadyTrain()
						If _Sleep(1000) Then Return
					EndIf
					$iCount = 0
					ContinueLoop
				EndIf
				; 已经造好的部队没有问题和排队中正在训练的队伍，继续检查预造的队伍
				If _checkOnQueueUnit() = True Then
					$bDeletedExcess = False
					Local $bGotOnQueueFlag = False
					For $i = 0 To UBound($MyTroops) - 1
						Local $itempTotal = Eval("OnQ" & $MyTroops[$i][0])
						If $itempTotal > 0 Then
							SetLog(" - No. of On Queue " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnQ" & $MyTroops[$i][0])) & ": " &  Eval("OnQ" & $MyTroops[$i][0]), (Eval("e" & $MyTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
							$bGotOnQueueFlag = True
						EndIf
						If $MyTroops[$i][3] < $itempTotal Then
							SetLog("Error: " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnQ" & $MyTroops[$i][0])) & " need " & $MyTroops[$i][3] & " only, and i made " & $itempTotal)
							$bDeletedExcess = True
							ExitLoop
						EndIf
					Next

					If $bGotOnQueueFlag Then
						If $iAvailableCamp <> $iMyTroopsCampSize Then
							SetLog("Error: Troops size not correct but pretrain already." & $iMyTroopsCampSize, $COLOR_ERROR)
							SetLog("Error: Detected Troops size = " & $iAvailableCamp & ", My Troops size = " & $iMyTroopsCampSize, $COLOR_ERROR)
							$bDeletedExcess = True
						EndIf
					EndIf

					If $bDeletedExcess Then
						$bDeletedExcess = False
						;If _ColorCheck(_GetPixelColor(389, 99 + $g_iMidOffsetY, True), Hex(0X6AB31F, 6), 10) Then ; check color if got train arrow
						;If _ColorCheck(_GetPixelColor(389, 100 + $g_iMidOffsetY, True), Hex(0X5E5748, 6), 20) = False Then
						If gotoTrainTroops() = False Then Return
						SetLog(" >>> stop pre-train troops.", $COLOR_RED)
						RemoveAllPreTrainTroops()
						$iCount = 0
						ContinueLoop
					EndIf

					If $g_hHBitmapArmyTab <> 0 Then
						GdiDeleteHBitmap($g_hHBitmapArmyTab)
					EndIf
					If $g_hHBitmapTrainTab <> 0 Then
						GdiDeleteHBitmap($g_hHBitmapTrainTab)
					EndIf

					ExitLoop
				EndIf
			EndIf
		EndIf
		If $bRestartCustomTrain Then ExitLoop
	WEnd

	If $bRestartCustomTrain Then
		If gotoArmy() = False Then Return
		getArmyTroopTime()
		If _Sleep(50) Then Return
	EndIf

	If $bCloseArmyWindow = True Then
		ClickP($aAway, 1, 0, "#0000") ;Click Away
		If _Sleep(500) Then Return
	EndIf

EndFunc   ;==>getArmyTroopCount

Func _checkAvailableUnit()
	If $iSamM0dDebug = 1 Then SetLog("============Start _checkAvailableUnit ============")
	SetLog("Start check available unit...", $COLOR_INFO)
	Local $aLastResult[1][3]
	Local $sDirectory = @ScriptDir & "\COCBot\SamM0d\images\Army\"
	Local $returnProps="objectname,objectpoints"
	Local $aCoor, $aPropsValues
	Local $AvailableCamp = 0
	Local $bDeletedExcess = False

	; reset variable
	For $i = 0 To UBound($MyTroops) - 1
		Assign("cur" & $MyTroops[$i][0], 0)
	Next

	Local $result = findMultiImage($g_hHBitmapArmyTab, $sDirectory ,"FV" ,"FV", 0, 1000, 1 , $returnProps)

	If IsArray($result) then
		ReDim $aLastResult[UBound($result)][3]
		For $i = 0 To UBound($result) -1
			If $iSamM0dDebug = 1 Then SetLog("--------------------------------------------------")
			$aPropsValues = $result[$i] ; should be return objectname,objectpoints
			If UBound($aPropsValues) = 2 then
				$aLastResult[$i][0] = $aPropsValues[0] ; objectname
				If $iSamM0dDebug = 1 Then SetLog("objectname: " & $aLastResult[$i][0], $COLOR_DEBUG)

				$aCoor = StringSplit($aPropsValues[1],",",$STR_NOCOUNT) ; objectpoints, split by "," tp get coor x
				$aLastResult[$i][1] = GetArmySlotPosition($aCoor[0]) ; get the army slot base on coor X
				If $iSamM0dDebug = 1 Then SetLog("objectpoints: " & $aPropsValues[1], $COLOR_DEBUG)
				If $iSamM0dDebug = 1 Then SetLog("slot: " & $aLastResult[$i][1], $COLOR_DEBUG)
				$aLastResult[$i][2] = getArmyQtyFromSlot($aLastResult[$i][1])
				If $iSamM0dDebug = 1 Then SetLog("Qty: " & $aLastResult[$i][2], $COLOR_DEBUG)
				If $aLastResult[$i][2] <> 0 Then
					Assign("cur" & $aLastResult[$i][0], $aLastResult[$i][2])
					$AvailableCamp += ($aLastResult[$i][2] * $TroopsUnitSize[Eval("e" & $aLastResult[$i][0])])
					; assign variable for drop trophy troops type
					For $j = 0 To UBound($g_avDTtroopsToBeUsed) - 1
						If $g_avDTtroopsToBeUsed[$j][0] = $aLastResult[$i][0] Then
							$g_avDTtroopsToBeUsed[$j][1] = $aLastResult[$i][2]
							ExitLoop
						EndIf
					Next
				Else
					SetLog("Error detect quantity no. On Troop: " & MyNameOfTroop(Eval("e" & $aLastResult[$i][0]), $aLastResult[$i][2]),$COLOR_RED)
					Return False
				EndIf
			EndIf
		Next

		_ArraySort($aLastResult, 0, 0, 0, 1) ; 重新排序兵种位置

		For $i = 0 To UBound($aLastResult) - 1
			If $iSamM0dDebug = 1 Then Setlog(" Slot : " & $i + 1, $COLOR_DEBUG)
			If $aLastResult[$i][1] <> $i + 1 Then
				If $iSamM0dDebug = 1 Then Setlog(" Slot : " & $i + 1 & " - Troops detection error.", $COLOR_DEBUG)
				Return False
			EndIf
		Next

		If $AvailableCamp <> $g_CurrentCampUtilization Then
			If $iSamM0dDebug = 1 Then SetLog("Error: Troops size for all available Unit: " & $AvailableCamp & "  -  Camp: " & $g_CurrentCampUtilization, $COLOR_RED)
			Return False
		Else
			For $i = 0 To UBound($aLastResult,$UBOUND_ROWS) - 1
				SetLog(" - No. of Available " & MyNameOfTroop(Eval("e" & $aLastResult[$i][0]), $aLastResult[$i][2]) & ": " & $aLastResult[$i][2], (Eval("e" & $aLastResult[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
				If $ichkEnableDeleteExcessTroops = 1 Then
					If $aLastResult[$i][2] > $MyTroops[Eval("e" & $aLastResult[$i][0])][3] Then
						$bRestartCustomTrain = True
						$bDeletedExcess = True
						SetLog(" >>> excess: " & $aLastResult[$i][2] - $MyTroops[Eval("e" & $aLastResult[$i][0])][3],$COLOR_RED)
						Assign("RemSlot" & $aLastResult[$i][1],$aLastResult[$i][2] - $MyTroops[Eval("e" & $aLastResult[$i][0])][3])
						If $iSamM0dDebug = 1 Then SetLog("Slot: " & $aLastResult[$i][1])
					EndIf
				EndIf
			Next
				;SetLog("Troops size for all available Unit: " & $AvailableCamp,$COLOR_GREEN)

			If $bDeletedExcess Then
				$bDeletedExcess = False
				;If _ColorCheck(_GetPixelColor(389, 99 + $g_iMidOffsetY, True), Hex(0X6AB31F, 6), 10) Then ; check color if got train arrow
				;If _ColorCheck(_GetPixelColor(389, 100 + $g_iMidOffsetY, True), Hex(0X5E5748, 6), 20) = False Then
				If gotoTrainTroops() = False Then Return
				If Not _ColorCheck(_GetPixelColor(823, 175 + $g_iMidOffsetY, True), Hex(0xCFCFC8, 6), 20) Then
					SetLog(" >>> stop train troops.", $COLOR_RED)
					RemoveAllTroopAlreadyTrain()
					Return False
				EndIf

				If gotoArmy() = False Then Return
				SetLog(" >>> remove excess troops.", $COLOR_RED)
				If WaitforPixel($aButtonEditArmy[4],$aButtonEditArmy[5],$aButtonEditArmy[4]+1,$aButtonEditArmy[5]+1,Hex($aButtonEditArmy[6], 6), $aButtonEditArmy[7],20) Then
					Click($aButtonEditArmy[0],$aButtonEditArmy[1],1,0,"#EditArmy")
				Else
					Return False
				EndIf

				If WaitforPixel($aButtonEditCancel[4],$aButtonEditCancel[5],$aButtonEditCancel[4]+1,$aButtonEditCancel[5]+1,Hex($aButtonEditCancel[6], 6), $aButtonEditCancel[7],20) Then
					For $i = 10 To 0 Step -1
						Local $RemoveSlotQty = Eval("RemSlot" & $i + 1)
						If $iSamM0dDebug = 1 Then SetLog($i & " $RemoveSlotQty: " & $RemoveSlotQty)
						If $RemoveSlotQty > 0 Then
							Local $iRx = (80 + (73 * $i))
							Local $iRy = 240 + $g_iMidOffsetY
							For $j = 1 To $RemoveSlotQty
								Click(Random($iRx-2,$iRx+2,1),Random($iRy-2,$iRy+2,1))
								If _Sleep($g_iTrainClickDelay) Then Return
							Next
							Assign("RemSlot" & $i + 1, 0)
						EndIf
					Next
				Else
					Return
				EndIf

				If WaitforPixel($aButtonEditOkay[4],$aButtonEditOkay[5],$aButtonEditOkay[4]+1,$aButtonEditOkay[5]+1,Hex($aButtonEditOkay[6], 6), $aButtonEditOkay[7],20) Then
					Click($aButtonEditOkay[0],$aButtonEditOkay[1],1,0,"#EditArmyOkay")
				Else
					Return False
				EndIf

				ClickOkay()
				Return False
			EndIf
		EndIf
		Return True
	Else
		setlog("No Army Available",$COLOR_ERROR)
	EndIf
	Return False
EndFunc	;==>_checkAvailableUnit

Func getQueueArmyStartSlot()
	For $i = 0 To 10
		If Not _ColorCheck(_GetPixelColor(805 - Int($i * 70.5) , 2, False), Hex(0XCFCFC8, 6), 10) Then
			Return $i
		Else
			If	$i = 10 Then
				Return 11
			EndIf
		EndIf
	Next
EndFunc

Func _checkOnTrainUnit()
	If $iSamM0dDebug = 1 Then SetLog("============Start _checkOnTrainUnit ============")
	SetLog("Start check on train unit...", $COLOR_INFO)
	Local $aLastResult[1][3]
	Local $sDirectory = @ScriptDir & "\COCBot\SamM0d\images\Army\Train\"
	Local $returnProps="objectname,objectpoints"
	Local $aCoor, $aPropsValues
	Local $iMax, $jMax
	Local $iCount = 0
	Local $aCoorXY
	Local $StartAtSlot = 0

	For $i = 0 To UBound($MyTroops) - 1
		Assign("OnT" & $MyTroops[$i][0], 0)
	Next

	; 重建构_captureregion()里的变量$g_hHBitmap，$g_hBitmap，给_GetPixelColor()使用
	If $g_hHBitmap <> 0 Then
		GdiDeleteHBitmap($g_hHBitmap)
	EndIf
	$g_hHBitmap = GetHHBitmapArea($g_hHBitmapTrainTab, 0, 0, $g_iTrainTab_x2 - $g_iTrainTab_x1, $g_iTrainTab_y2 - $g_iTrainTab_y1)
	If $g_hBitmap <> 0 Then
		GdiDeleteBitmap($g_hBitmap)
	EndIf
	$g_hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap)

	; 检查是否有兵造着，空白就返回
	If _ColorCheck(_GetPixelColor(820,12,False), Hex(0XCFCFC8, 6), 10) And _ColorCheck(_GetPixelColor(820,2,False), Hex(0XCFCFC8, 6), 10) Then
		setlog("No Army On Train",$COLOR_ERROR)
		Return True
	EndIf

	; 检查造兵列表是否过长
	If _ColorCheck(_GetPixelColor(27,1,False), Hex(0XCFCFC8, 6), 10) And Not _ColorCheck(_GetPixelColor(25,29,False), Hex(0XCFCFC8, 6), 10) Then
		SetLog(" >>> stop train troops. Troops was long queue. Remove troop and retraining.", $COLOR_RED)
		RemoveAllTroopAlreadyTrain()
		Return False
	EndIf

	$StartAtSlot = getQueueArmyStartSlot()
	If $iSamM0dDebug Then SETLOG("$StartAtSlot: " & $StartAtSlot)

	_debugSaveHBitmapToImage($g_hHBitmap, "_checkOnTrainUnit")

	If $StartAtSlot = 0 Then
		setlog("No Army On Train",$COLOR_ERROR)
		Return True
	EndIf

	If _Sleep(100) Then Return

	Local $result
	;$result = getMyOcr(30 + (73 * ($iSlot-1)), 166 + $g_iMidOffsetY, 58 , 18,"ArmyQTY", True)
	Local $hBitmapOnTArmy = GetHHBitmapArea($g_hHBitmapTrainTab, (((11-$StartAtSlot)*70.5)+65), 0, $g_iTrainTab_x2 - $g_iTrainTab_x1 , $g_iTrainTab_y2 - $g_iTrainTab_y1)

	_debugSaveHBitmapToImage($hBitmapOnTArmy, "hBitmapOnTArmy")

	Local $result = findMultiImage($hBitmapOnTArmy, $sDirectory ,"FV" ,"FV", 0, 0, 0 , $returnProps)

	If IsArray($result) then
		$iMax = UBound($result) -1
		For $i = 0 To $iMax
			$aPropsValues = $result[$i]
			If UBound($aPropsValues) = 2 then
				$aCoor = StringSplit($aPropsValues[1],"|",$STR_NOCOUNT)
				$jMax = UBound($aCoor) - 1
				For $j = 0 To $jMax
					ReDim $aLastResult[$iCount + 1][3]
					$aLastResult[$iCount][0] = $aPropsValues[0]
					$aCoorXY = StringSplit($aCoor[$j],",",$STR_NOCOUNT)
					If IsArray($aCoorXY) Then
						$aLastResult[$iCount][1] = getQueueArmySlotPosition(Number($aCoorXY[0]+(((11-$StartAtSlot)*70.5)+65)))
						Local $hHBitmapQty = GetHHBitmapArea($hBitmapOnTArmy, 4 + Number(70.5 * (($aLastResult[$iCount][1] - (11 - $StartAtSlot)) - 1)), 6, 4 + Number(70.5 * (($aLastResult[$iCount][1] - (11 - $StartAtSlot)) - 1)) + 58 , 22)
						_debugSaveHBitmapToImage($hHBitmapQty, "OnTSlot" & $aLastResult[$iCount][1])
						$aLastResult[$iCount][2] = getMyOcr($hHBitmapQty, 4 + Number(70.5 * (($aLastResult[$iCount][1] - (11 - $StartAtSlot)) - 1)), 6, 58 , 22, "spellqtybrew", True)
						If $hHBitmapQty <> 0 Then
							GdiDeleteHBitmap($hHBitmapQty)
						EndIf
					EndIf
					Assign("OnT" & $aLastResult[$iCount][0], Eval("OnT" & $aLastResult[$iCount][0]) + $aLastResult[$iCount][2])
					$iCount += 1
				Next
			EndIf
		Next

		_ArraySort($aLastResult, 1, 0, 0, 1)

		If $iSamM0dDebug = 1 Then
			For $i = 0 To UBound($aLastResult) - 1
				SetLog("Afrer _ArraySort - Obj:" & $aLastResult[$i][0] & " Slot:" & $aLastResult[$i][1] & " Qty: " & $aLastResult[$i][2], $COLOR_DEBUG)
				If Eval("OnT" & $aLastResult[$i][0]) > 0 Then
					Setlog(" Total OnTrain " & $aLastResult[$i][0] & ": " & Eval("OnT" & $aLastResult[$i][0]))
				EndIf
			Next
		EndIf
		If $hBitmapOnTArmy <> 0 Then
			GdiDeleteHBitmap($hBitmapOnTArmy)
		EndIf
		Return True
	Else
		setlog("No Army On Train",$COLOR_ERROR)
	EndIf
	If $hBitmapOnTArmy <> 0 Then
		GdiDeleteHBitmap($hBitmapOnTArmy)
	EndIf
	Return False
EndFunc	;==>_checkOnTrainUnit

Func _checkOnQueueUnit()
	If $iSamM0dDebug = 1 Then SetLog("============Start _checkOnQueueUnit ============")
	SetLog("Start check on queue unit...", $COLOR_INFO)
	Local $aLastResult[1][3]
	Local $sDirectory = @ScriptDir & "\COCBot\SamM0d\images\Army\Queue\"
	Local $returnProps="objectname,objectpoints"
	Local $aCoor, $aPropsValues
	Local $iMax, $jMax
	Local $iCount = 0
	Local $aCoorXY
	Local $StartAtSlot = -1

	For $i = 0 To UBound($MyTroops) - 1
		Assign("OnQ" & $MyTroops[$i][0], 0)
	Next

	; 重建构_captureregion()里的变量$g_hHBitmap，$g_hBitmap，给_GetPixelColor()使用
	If $g_hHBitmap <> 0 Then
		GdiDeleteHBitmap($g_hHBitmap)
	EndIf
	$g_hHBitmap = GetHHBitmapArea($g_hHBitmapTrainTab, 0, 0, $g_iTrainTab_x2 - $g_iTrainTab_x1, $g_iTrainTab_y2 - $g_iTrainTab_y1)
	If $g_hBitmap <> 0 Then
		GdiDeleteBitmap($g_hBitmap)
	EndIf
	$g_hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap)

	$StartAtSlot = getQueueArmyStartSlot()

	If $iSamM0dDebug Then SETLOG("$StartAtSlot: " & $StartAtSlot)

	_debugSaveHBitmapToImage($g_hHBitmap, "_checkOnQueueUnit")

	If $StartAtSlot >= 11 Then
		setlog("No Army On Queue",$COLOR_ERROR)
		Return True
	EndIf
	If _Sleep(100) Then Return

	Local $result
	;$result = getMyOcr(30 + (73 * ($iSlot-1)), 166 + $g_iMidOffsetY, 58 , 18,"ArmyQTY", True)
	Local $hHBitmapOnQArmy = GetHHBitmapArea($g_hHBitmapTrainTab, 65, 0, $g_iTrainTab_x2 - ($g_iTrainTab_x1 + ($StartAtSlot*70.5)) , $g_iTrainTab_y2 - $g_iTrainTab_y1)

	_debugSaveHBitmapToImage($hHBitmapOnQArmy, "hBitmapOnQArmy")

	Local $result = findMultiImage($hHBitmapOnQArmy, $sDirectory ,"FV" ,"FV", 0, 0, 0 , $returnProps)

	If IsArray($result) then
		$iMax = UBound($result) -1
		For $i = 0 To $iMax
			$aPropsValues = $result[$i]
			If UBound($aPropsValues) = 2 then
				$aCoor = StringSplit($aPropsValues[1],"|",$STR_NOCOUNT)
				$jMax = UBound($aCoor) - 1
				For $j = 0 To $jMax
					ReDim $aLastResult[$iCount + 1][3]
					$aLastResult[$iCount][0] = $aPropsValues[0]
					$aCoorXY = StringSplit($aCoor[$j],",",$STR_NOCOUNT)
					If IsArray($aCoorXY) Then
						$aLastResult[$iCount][1] = GetQueueArmySlotPosition(Number($aCoorXY[0]) + 65)
						Local $hHBitmapQty = GetHHBitmapArea($hHBitmapOnQArmy, 4 + Number(70.5 * ($aLastResult[$iCount][1] - 1)), 6, 4 + Number(70.5 * ($aLastResult[$iCount][1] - 1)) + 58 , 22)
						_debugSaveHBitmapToImage($hHBitmapQty, "OnQSlot" & $aLastResult[$iCount][1])
						$aLastResult[$iCount][2] = getMyOcr($hHBitmapQty, 4 + Number(70.5 * ($aLastResult[$iCount][1] - 1)), 6, 58 , 22, "spellqtypre", True)
						If $hHBitmapQty <> 0 Then
							GdiDeleteHBitmap($hHBitmapQty)
						EndIf
					EndIf
					Assign("OnQ" & $aLastResult[$iCount][0], Eval("OnQ" & $aLastResult[$iCount][0]) + $aLastResult[$iCount][2])
					$iCount += 1
				Next
			EndIf
		Next

		_ArraySort($aLastResult, 1, 0, 0, 1)

		If $iSamM0dDebug = 1 Then
			For $i = 0 To UBound($aLastResult) - 1
				SetLog("Afrer _ArraySort - Obj:" & $aLastResult[$i][0] & " Slot:" & $aLastResult[$i][1] & " Qty: " & $aLastResult[$i][2], $COLOR_DEBUG)
				If Eval("OnQ" & $aLastResult[$i][0]) > 0 Then
					Setlog(" Total On Queue " & $aLastResult[$i][0] & ": " & Eval("OnQ" & $aLastResult[$i][0]))
				EndIf
			Next
		EndIf
		If $hHBitmapOnQArmy <> 0 Then
			GdiDeleteHBitmap($hHBitmapOnQArmy)
		EndIf
		Return True
	Else
		setlog("No Army On Queue",$COLOR_ERROR)
	EndIf
	If $hHBitmapOnQArmy <> 0 Then
		GdiDeleteHBitmap($hHBitmapOnQArmy)
	EndIf
	Return False
EndFunc	;==>_checkOnQueueUnit

Func getArmyQtyFromSlot($iSlot)
	If $iSlot = 99 Then Return 0
	Local $result
	;$result = getMyOcr(30 + (73 * ($iSlot-1)), 166 + $g_iMidOffsetY, 58 , 18,"ArmyQTY", True)
	Local $hHBitmapQty = GetHHBitmapArea($g_hHBitmapArmyTab, 13 + (73 * ($iSlot-1)), 2, 13 + (73 * ($iSlot-1)) + 58 , 20)

	_debugSaveHBitmapToImage($hHBitmapQty, "OnASlot" & $iSlot)

	$result = getMyOcr($hHBitmapQty, 13 + (73 * ($iSlot-1)), 2, 58 , 20,"ArmyQTY", True)

	If $hHBitmapQty <> 0 Then
		GdiDeleteHBitmap($hHBitmapQty)
	EndIf

	Return $result
EndFunc

Func getArmyQtyFromTrainSlot($iSlot)
	If $iSlot = 99 Then Return 0
	Local $result
	;$result = getMyOcr(30 + (73 * ($iSlot-1)), 166 + $g_iMidOffsetY, 58 , 18,"ArmyQTY", True)
	Local $hHBitmapQty = GetHHBitmapArea($g_hHBitmapArmyTab, 13 + (73 * ($iSlot-1)), 2, 13 + (73 * ($iSlot-1)) + 58 , 20)

	$result = getMyOcr($hHBitmapQty, 13 + (73 * ($iSlot-1)), 2, 58 , 18,"ArmyQTY", True)

	If $hHBitmapQty <> 0 Then
		GdiDeleteHBitmap($hHBitmapQty)
	EndIf

	Return $result
EndFunc

Func GetQueueArmySlotPosition($InputX)
	Switch $InputX
		Case $InputX >= 66 And $InputX <= 131
			Return 1
		Case $InputX >= 137 And $InputX <= 201
			Return 2
		Case $InputX >= 207 And $InputX <= 272
			Return 3
		Case $InputX >= 278 And $InputX <= 342
			Return 4
		Case $InputX >= 348 And $InputX <= 413
			Return 5
		Case $InputX >= 419 And $InputX <= 483
			Return 6
		Case $InputX >= 489 And $InputX <= 554
			Return 7
		Case $InputX >= 560 And $InputX <= 624
			Return 8
		Case $InputX >= 630 And $InputX <= 695
			Return 9
		Case $InputX >= 701 And $InputX <= 765
			Return 10
		Case $InputX >= 771 And $InputX <= 836
			Return 11
		Case Else
			Return 99
	EndSwitch
EndFunc

Func getArmySlotPosition($InputX)
	Switch $InputX
		Case $InputX >= 23 And $InputX <= 93
			Return 1
		Case $InputX >= 97 And $InputX <= 167
			Return 2
		Case $InputX >= 171 And $InputX <= 241
			Return 3
		Case $InputX >= 245 And $InputX <= 315
			Return 4
		Case $InputX >= 319 And $InputX <= 389
			Return 5
		Case $InputX >= 393 And $InputX <= 463
			Return 6
		Case $InputX >= 467 And $InputX <= 537
			Return 7
		Case $InputX >= 541 And $InputX <= 611
			Return 8
		Case $InputX >= 615 And $InputX <= 685
			Return 9
		Case $InputX >= 689 And $InputX <= 759
			Return 10
		Case $InputX >= 763 And $InputX <= 833
			Return 11
		Case Else
			Return 99
	EndSwitch
EndFunc
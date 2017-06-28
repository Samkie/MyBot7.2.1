; #FUNCTION# ====================================================================================================================
; Name ..........: CheckOnTrainUnit
; Description ...: Reads current quanitites/type of troops from Training window, updates $OnT (On Train unit and quantity), $OnQ (On Queue unit and quantity)
;                  Check troops train correctly, will remove what un need.
; Syntax ........: CheckOnTrainUnit
; Parameters ....: $hHBitmap
;
; Return values .: None
; Author ........: Samkie (27 Jun 2017)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func CheckOnTrainUnit($hHBitmap)
	If $hHBitmap = 0 Then
		SetLog("Error: $hHBitmap = 0",$COLOR_ERROR)
		Return False
	EndIf
	If $g_iSamM0dDebug = 1 Then SetLog("============Start CheckOnTrainUnit ============")
	SetLog("Start check on train unit...", $COLOR_INFO)
	; reset variable
	For $i = 0 To UBound($MyTroops) - 1
		Assign("OnT" & $MyTroops[$i][0], 0)
		Assign("OnQ" & $MyTroops[$i][0], 0)
		Assign("RemoveUnitOfOnT" & $MyTroops[$i][0], 0)
		Assign("RemoveUnitOfOnQ" & $MyTroops[$i][0], 0)
	Next

	; clone my current $hHBitmap to $g_hBitmap same like make _CaptureRegion(), use for color check later.
	;-----------------------------------------------------------------------------------------------------
	If $g_hHBitmap <> 0 Then
		GdiDeleteHBitmap($g_hHBitmap)
	EndIf
	$g_hHBitmap = GetHHBitmapArea($hHBitmap)
	If $g_hBitmap <> 0 Then
		GdiDeleteBitmap($g_hBitmap)
	EndIf
	$g_hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap)
	;------------------------------------------------------------------------------------------------------

	Local $aiTroopInfo[11][4]
	Local $iAvailableCamp = 0
	Local $iOnQueueCamp = 0
	Local $iMyTroopsCampSize = 0

	Local $sDirectory
	Local $returnProps="objectname"
	Local $aPropsValues
	Local $bDeletedExcess = False
	Local $bGotOnTrainFlag = False
	Local $bGotOnQueueFlag = False
	Local $iCount = 0
	For $i = 10 To 0 Step -1
		If _ColorCheck(_GetPixelColor(Int(65 + (70.5 * $i) + (70.5 / 2)),196,False), Hex(0XCFCFC8, 6), 10) And _ColorCheck(_GetPixelColor(Int(65 + (70.5 * $i) + (70.5 / 2)),186,False), Hex(0XCFCFC8, 6), 10) Then
			; Is Empty Slot
			$aiTroopInfo[$i][0] = ""
			$aiTroopInfo[$i][1] = 0
			$aiTroopInfo[$i][2] = $i + 1
			$aiTroopInfo[$i][3] = False
			$iCount += 1
		Else
			Local $bIsQueueTroop = False
			; if color check is pink that mean pre train unit
			If _ColorCheck(_GetPixelColor(Int(65 + (70.5 * $i) + (70.5 / 2)),186,False), Hex(0XD7AFA9, 6), 10) Then
				$sDirectory = @ScriptDir & "\COCBot\SamM0d\images\Troops\Queue\"
				$bIsQueueTroop = True
			Else
				$sDirectory = @ScriptDir & "\COCBot\SamM0d\images\Troops\Train\"
			EndIf

			Assign("g_hHBitmap_OT_Slot" & $i + 1, GetHHBitmapArea($hHBitmap, Int(65 + (70.5 * $i) + ((70.5 - 20) / 2)), $g_aiArmyOnTrainSlot[1] - 2, Int(65 + (70.5* $i) + ((70.5 - 20) / 2) + 20), $g_aiArmyOnTrainSlot[3] + 2))

			Local $result = findMultiImage(Eval("g_hHBitmap_OT_Slot" & $i + 1), $sDirectory ,"FV" ,"FV", 0, 1000, 1 , $returnProps)

			Local $sObjectname = ""
			Local $iQty = 0
			If IsArray($result) then
				For $j = 0 To UBound($result) -1
					If $j = 0 Then
						$aPropsValues = $result[$j] ; should be return objectname
						If UBound($aPropsValues) = 1 then
							$sObjectname = $aPropsValues[0] ; objectname
						EndIf
					ElseIf $j = 1 Then
						$aPropsValues = $result[$j]
						SetLog("Error: Multiple detect troops on slot: " & $i + 1 , $COLOR_ERROR)
						SetLog("Troop: " & $sObjectname, $COLOR_ERROR)
						SetLog("Troop: " & $aPropsValues[0], $COLOR_ERROR)
					Else
						$aPropsValues = $result[$j]
						SetLog("Troop: " & $aPropsValues[0], $COLOR_ERROR)
					EndIf
				Next

			Else
				SetLog("Error: Cannot detect what troops on slot: " & $i + 1 , $COLOR_ERROR)
			EndIf

			;If $bExitLoopFlag = True Then ExitLoop


			Assign("g_hHBitmap_OT_SlotQty" & $i + 1, GetHHBitmapArea($hHBitmap, Int(67 + (70.5 * $i)), $g_aiArmyOnTrainSlotQty[1], Int(67 + (70.5* $i) + 40), $g_aiArmyOnTrainSlotQty[3]))

			If $bIsQueueTroop Then
				$iQty = getMyOcr(Eval("g_hHBitmap_OT_SlotQty" & $i + 1),0,0,0,0,"spellqtypre", True)
			Else
				$iQty = getMyOcr(Eval("g_hHBitmap_OT_SlotQty" & $i + 1),0,0,0,0,"spellqtybrew", True)
			EndIf

			If $iQty <> 0 Then
				$aiTroopInfo[$i][0] = $sObjectname
				$aiTroopInfo[$i][1] = $iQty
				$aiTroopInfo[$i][2] = $i + 1
				$aiTroopInfo[$i][3] = $bIsQueueTroop
				If $bIsQueueTroop Then
					Assign("OnQ" & $sObjectname, Eval("OnQ" & $sObjectname) + $iQty)
				Else
					Assign("OnT" & $sObjectname, Eval("OnT" & $sObjectname) + $iQty)
				EndIf
			Else
				SetLog("Error detect quantity no. On Troop: " & MyNameOfTroop(Eval("e" & $sObjectname), $iQty),$COLOR_RED)
				ExitLoop
			EndIf
		EndIf
	Next

	If $g_hHBitmap <> 0 Then
		GdiDeleteHBitmap($g_hHBitmap)
	EndIf
	$g_hHBitmap = GetHHBitmapArea($hHBitmap)
	If $g_hBitmap <> 0 Then
		GdiDeleteBitmap($g_hBitmap)
	EndIf

	If $iCount = 11 Then
		SetLog("No Army On Train.",$COLOR_ERROR)
		Return True
	EndIf

	For $i = 0 To UBound($MyTroops) - 1
		Local $itempTotal = Eval("cur" & $MyTroops[$i][0]) + Eval("OnT" & $MyTroops[$i][0])
		If Eval("OnT" & $MyTroops[$i][0]) > 0 Then
			SetLog(" - No. of On Train " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnT" & $MyTroops[$i][0])) & ": " &  Eval("OnT" & $MyTroops[$i][0]), (Eval("e" & $MyTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
			$bGotOnTrainFlag = True
		EndIf
		If $MyTroops[$i][3] < $itempTotal Then
			If $ichkEnableDeleteExcessTroops = 1 Then
				SetLog("Error: " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnT" & $MyTroops[$i][0])) & " need " & $MyTroops[$i][3] & " only, and i made " & $itempTotal)
				Assign("RemoveUnitOfOnT" & $MyTroops[$i][0], $itempTotal - $MyTroops[$i][3])
				$bDeletedExcess = True
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
		SetLog(" >>> Some troops over train, stop and remove excess troops.", $COLOR_RED)
		If gotoTrainTroops() = False Then Return
		RemoveAllPreTrainTroops()

		_ArraySort($aiTroopInfo, 0, 0, 0, 2) ; sort to make remove start from left to right
		For $i = 0 To 10
			If $aiTroopInfo[$i][1] <> 0 And $aiTroopInfo[$i][3] = False Then
				; 檢查這個兵種是否要刪除
				Local $iUnitToRemove = Eval("RemoveUnitOfOnT" & $aiTroopInfo[$i][0])
				If $iUnitToRemove > 0 Then
					If $aiTroopInfo[$i][1] > $iUnitToRemove Then
						SetLog("Remove " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]),  $aiTroopInfo[$i][1]) & " at slot: " & $aiTroopInfo[$i][2] & ", unit to remove: " & $iUnitToRemove, $COLOR_ACTION)
						RemoveTrainTroops($aiTroopInfo[$i][2]-1, $iUnitToRemove)
						$iUnitToRemove = 0
						Assign("RemoveUnitOfOnT" & $aiTroopInfo[$i][0], $iUnitToRemove)
					Else
						SetLog("Remove " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]),  $aiTroopInfo[$i][1]) & " at slot: " & $aiTroopInfo[$i][2] & ", unit to remove: " & $aiTroopInfo[$i][1], $COLOR_ACTION)
						RemoveTrainTroops($aiTroopInfo[$i][2]-1, $aiTroopInfo[$i][1])
						$iUnitToRemove -= $aiTroopInfo[$i][1]
						Assign("RemoveUnitOfOnT" & $aiTroopInfo[$i][0], $iUnitToRemove)
					EndIf
				EndIf
			EndIf
		Next
		$g_bRestartCheckTroop = True
		Return False
	Else
		$bDeletedExcess = False
		$bGotOnQueueFlag = False
		For $i = 0 To UBound($MyTroops) - 1
			Local $itempTotal = Eval("OnQ" & $MyTroops[$i][0])
			If $itempTotal > 0 Then
				SetLog(" - No. of On Queue " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnQ" & $MyTroops[$i][0])) & ": " &  Eval("OnQ" & $MyTroops[$i][0]), (Eval("e" & $MyTroops[$i][0]) > 11 ? $COLOR_DARKELIXIR : $COLOR_ELIXIR))
				$bGotOnQueueFlag = True
				If $MyTroops[$i][3] < $itempTotal Then
					If $ichkEnableDeleteExcessTroops = 1 Then
						SetLog("Error: " & MyNameOfTroop(Eval("e" & $MyTroops[$i][0]),  Eval("OnQ" & $MyTroops[$i][0])) & " need " & $MyTroops[$i][3] & " only, and i made " & $itempTotal)
						Assign("RemoveUnitOfOnQ" & $MyTroops[$i][0], $itempTotal - $MyTroops[$i][3])
						$bDeletedExcess = True
					EndIf
				EndIf
				$iOnQueueCamp += $itempTotal * $MyTroops[$i][2]
			EndIf
		Next
		If $bGotOnQueueFlag And $bGotOnTrainFlag Then
			If $iAvailableCamp <> $iMyTroopsCampSize Or $ichkDisablePretrainTroops Then
				If $ichkDisablePretrainTroops Then
					SetLog("Pre-Train troops disable by user, remove all pre-train troops.", $COLOR_ERROR)
				Else
					SetLog("Error: Troops size not correct but pretrain already." & $iMyTroopsCampSize, $COLOR_ERROR)
					SetLog("Error: Detected Troops size = " & $iAvailableCamp & ", My Troops size = " & $iMyTroopsCampSize, $COLOR_ERROR)
				EndIf
				If gotoTrainTroops() = False Then Return
				RemoveAllPreTrainTroops()
				$g_bRestartCheckTroop = True
				Return False
			EndIf
		EndIf
		If $bDeletedExcess Then
			$bDeletedExcess = False
			SetLog(" >>> Some troops over train, stop and remove excess pre-train troops.", $COLOR_RED)
			If gotoTrainTroops() = False Then Return

			_ArraySort($aiTroopInfo, 0, 0, 0, 2) ; sort to make remove start from left to right
			For $i = 0 To 10
				If $aiTroopInfo[$i][1] <> 0 And $aiTroopInfo[$i][3] = True Then
					; 檢查這個兵種是否要刪除
					Local $iUnitToRemove = Eval("RemoveUnitOfOnQ" & $aiTroopInfo[$i][0])
					If $iUnitToRemove > 0 Then
						If $aiTroopInfo[$i][1] > $iUnitToRemove Then
							SetLog("Remove " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]),  $aiTroopInfo[$i][1]) & " at slot: " & $aiTroopInfo[$i][2] & ", unit to remove: " & $iUnitToRemove, $COLOR_ACTION)
							RemoveTrainTroops($aiTroopInfo[$i][2]-1, $iUnitToRemove)
							$iUnitToRemove = 0
							Assign("RemoveUnitOfOnQ" & $aiTroopInfo[$i][0], $iUnitToRemove)
						Else
							SetLog("Remove " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]),  $aiTroopInfo[$i][1]) & " at slot: " & $aiTroopInfo[$i][2] & ", unit to remove: " & $aiTroopInfo[$i][1], $COLOR_ACTION)
							RemoveTrainTroops($aiTroopInfo[$i][2]-1, $aiTroopInfo[$i][1])
							$iUnitToRemove -= $aiTroopInfo[$i][1]
							Assign("RemoveUnitOfOnQ" & $aiTroopInfo[$i][0], $iUnitToRemove)
						EndIf
					EndIf
				EndIf
				If _Sleep(Random((250*90)/100, (250*110)/100, 1), False) Then Return False
			Next
			$g_bRestartCheckTroop = True
			Return False
		EndIf

		; if don't have on train troops then i check the pre train troop size
		If $bGotOnTrainFlag = False And $bGotOnQueueFlag Then
			If $aiTroopInfo[0][1] > 0 Then
				If $iOnQueueCamp <> $iMyTroopsCampSize Then
					SetLog("Error: Pre-Train Troops size not correct.", $COLOR_ERROR)
					SetLog("Error: Detected Pre-Train Troops size = " & $iOnQueueCamp & ", My Troops size = " & $iMyTroopsCampSize, $COLOR_ERROR)
					If gotoBrewSpells() = False Then Return
					RemoveAllPreTrainTroops()
					$g_bRestartCheckTroop = True
					Return False
				EndIf
			EndIf
			If $ichkDisablePretrainTroops Then
				SetLog("Pre-Train troops disable by user, remove all pre-train troops.", $COLOR_ERROR)
				If gotoTrainTroops() = False Then Return
				RemoveAllPreTrainTroops()
			EndIf
		Else
			If $ichkMyTroopsOrder Then
				Local $tempTroops[19][5]
				$tempTroops	= $MyTroops
				_ArraySort($tempTroops,0,0,0,1)
				_ArraySort($aiTroopInfo, 0, 0, 0, 2) ; sort to make remove start from left to right
				For $i =  UBound($aiTroopInfo) - 1 To 0 Step -1
					If $aiTroopInfo[$i][3] = True Then
						If $aiTroopInfo[$i][0] <> $tempTroops[0][0] Then
							SetLog("Pre-Train first slot: " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]), $aiTroopInfo[$i][1]), $COLOR_ERROR)
							SetLog("My first order troops: " & MyNameOfTroop(Eval("e" & $tempTroops[0][0]), $tempTroops[0][3]), $COLOR_ERROR)
							SetLog("Remove and re training by order.", $COLOR_ERROR)
							RemoveAllPreTrainTroops()
							$g_bRestartCheckTroop = True
							Return False
						Else
							If $aiTroopInfo[$i][1] < $tempTroops[0][3] Then
								SetLog("Pre-Train first slot: " & MyNameOfTroop(Eval("e" & $aiTroopInfo[$i][0]), $aiTroopInfo[$i][1]) & " - Units: " & $aiTroopInfo[$i][1], $COLOR_ERROR)
								SetLog("My first order troops: " & MyNameOfTroop(Eval("e" & $tempTroops[0][0]), $tempTroops[0][3]) & " - Units: " & $tempTroops[0][3], $COLOR_ERROR)
								SetLog("Not enough quantity, remove and re-training again.", $COLOR_ERROR)
								RemoveAllPreTrainTroops()
								$g_bRestartCheckTroop = True
								Return False
							EndIf
						EndIf
					EndIf
				Next
			EndIf
		EndIf
	EndIf
	Return True
EndFunc

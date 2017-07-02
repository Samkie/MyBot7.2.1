; #FUNCTION# ====================================================================================================================
; Name ..........:getNextSwitchList [BETA]
; Description ...:
; Syntax ........:getNextSwitchList()
; Parameters ....:
; Return values .: None
; Author ........: Samkie (18 Dec 2016)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func getTotalGoogleAccount()
	ForceCaptureRegion()
	Local $x1 = 160
	Local $x2 = 699
	Local $iCount = 0
	Local $aStartPos = _PixelSearch($x2-1,0,$x2,300,Hex(0xFFFFFF, 6),5)

	If IsArray($aStartPos) Then
		If $iSamM0dDebug Then SetLog("$aStartPos: " & $aStartPos[0] & "," & $aStartPos[1])
		$iSlotYOffset = $aStartPos[1]
		_CaptureRegion()
		For $i = 0 To 7
			If _ColorCheck(_GetPixelColor($x1, 96 + $aStartPos[1] + ($i * 72),$bNoCapturePixel), Hex(0xFFFFFF,6), 5) And _
				_ColorCheck(_GetPixelColor($x2, 96 + $aStartPos[1] + ($i * 72),$bNoCapturePixel), Hex(0xFFFFFF,6), 5) Then
				$iCount += 1
			Else
				ExitLoop
			EndIf
		Next
		If $iSamM0dDebug Then SetLog("Acc. $iCount: " & $iCount)
		Return $iCount
	EndIf
	Return 0
EndFunc

Func SelectGoogleAccount($iSlot)
	; open setting page
	Click($aButtonSetting[0],$aButtonSetting[1],1,0,"#Setting")

	Local $iCount
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonClose2[4], $aButtonClose2[5],True), Hex($aButtonClose2[6],6), $aButtonClose2[7])
		$iCount += 1
		If $iCount > 10 Then
			SetLog("Cannot load setting page, restart game...", $COLOR_RED)
			CloseCoC(True)
			If _Sleep(10000) Then Return False
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd

	Click($aButtonSettingTabSetting[0],$aButtonSettingTabSetting[1],1,0,"#TabSettings")
	If _Sleep(500) Then Return False

	If _Sleep($iDelayRespond) Then Return False
	If _ColorCheck(_GetPixelColor($aButtonGoogleConnectRed[4], $aButtonGoogleConnectRed[5],True), Hex($aButtonGoogleConnectRed[6],6), $aButtonGoogleConnectRed[7]) Then
		Click($aButtonGoogleConnectRed[0],$aButtonGoogleConnectRed[1],1,0,"#ConnectGoogle")
	Else
		Click($aButtonGoogleConnectGreen[0],$aButtonGoogleConnectGreen[1],2,500,"#ConnectGoogle")
	EndIf

	$iCount = 0
	While Not _ColorCheck(_GetPixelColor(160, 380,True), Hex(0xFFFFFF, 6),10)
		If $iSamM0dDebug Then SetLog("wait for google account page Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount > 20 Then
			SetLog("Cannot load google account page, restart game...", $COLOR_RED)
			CloseCoC(True)
			If _Sleep(10000) Then Return False
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd

	If _Sleep(250) Then Return False
	Local $iTotalAcc = getTotalGoogleAccount()
	If $iTotalAcc < $iSlot + 1 Then
		SetLog("You cannot select account slot " & $iSlot + 1 & ", because you only got total: " & $iTotalAcc, $COLOR_RED)
		AndroidBackButton()
		If _Sleep(500) Then Return False
		AndroidBackButton()
		BotStop()
		Return False
	Else
		Click(241, 84 + $iSlotYOffset + ($iSlot * 72), 1, 0, "#GASe")
	EndIf

	Local $iResult
	$iResult = DoLoadVillage()

	If $iResult <> 1 And $iResult <> 2 Then Return False

	If _Sleep(500) Then Return False

	If $iSamM0dDebug Then SetLog("$iResult: " & $iResult)

	If _Sleep($iDelayRespond) Then Return False

	If $iResult = 1 Then
		If DoConfirmVillage() = False Then Return False
	Else
		ClickP($aAway,1,0)
	EndIf

	; wait for game reload
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonSetting[4], $aButtonSetting[5],True), Hex($aButtonSetting[6], 6), Number($aButtonSetting[7]))
		If $iSamM0dDebug Then SetLog("Color: " & _GetPixelColor(160, 380,True))
		If _ColorCheck(_GetPixelColor(402, 516,True), Hex(0xFFFFFF, 6), 5) And _ColorCheck(_GetPixelColor(405, 537,True), Hex(0x5EAC10, 6), 20) Then
			Click($aButtonVillageWasAttackOK[0],$aButtonVillageWasAttackOK[1],1,0,"#VWAO")
			If _Sleep(1000) Then Return True
			Return True ;  village was attacked okay button
		EndIf
		$iCount += 1
		If $iCount > 20 Then
			; if cannot locate button setting, let continue checkMainScreen() handle.
			ExitLoop
		EndIf
		If _Sleep(1000) Then Return True
	WEnd
	Return True
EndFunc

Func DoLoadVillage()
	Local $iCount = 0
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonVillageLoad[4], $aButtonVillageLoad[5],True), Hex($aButtonVillageLoad[6],6), $aButtonVillageLoad[7])
		If $iSamM0dDebug Then SetLog("village load button Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount = 20 Then
			SetLog("Cannot load village load button, restart game...", $COLOR_RED)
			CloseCoC(True)
			If _Sleep(10000) Then Return
		EndIf
		If $iCount >= 30 Then
			Return 0
		EndIf
		If _ColorCheck(_GetPixelColor($aButtonGoogleConnectGreen[4], $aButtonGoogleConnectGreen[5],True), Hex($aButtonGoogleConnectGreen[6],6), $aButtonGoogleConnectGreen[7]) Then
			Return 2
		EndIf
		If _Sleep(1000) Then Return 0
	WEnd
	Click($aButtonVillageLoad[0],$aButtonVillageLoad[1],1,0,"#GALo")
	Return 1
EndFunc

Func DoConfirmVillage()
	Local $iCount = 0
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonVillageConfirmClose[4], $aButtonVillageConfirmClose[5],True), Hex($aButtonVillageConfirmClose[6],6), $aButtonVillageConfirmClose[7])
		If $iSamM0dDebug Then SetLog("load village confirm button Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount > 15 Then
			SetLog("Cannot load village confirm button, restart game...", $COLOR_RED)
			CloseCoC(True)
			If _Sleep(10000) Then Return
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd
	Click($aButtonVillageConfirmText[0],$aButtonVillageConfirmText[1],1,0,"#GATe")
	If _Sleep(500) Then Return False
	If SendText("CONFIRM") = 0 Then
		SetLog("Cannot type CONFIRM to emulator, restart game...", $COLOR_RED)
		CloseCoC(True)
		If _Sleep(10000) Then Return
		Return False
	EndIf
	If _Sleep(500) Then Return False
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonVillageConfirmOK[4], $aButtonVillageConfirmOK[5],True), Hex($aButtonVillageConfirmOK[6],6), $aButtonVillageConfirmOK[7])
		If $iSamM0dDebug Then SetLog("confirm village Okay button Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount > 15 Then
			SetLog("Cannot confirm village Okay button, restart game...", $COLOR_RED)
			CloseCoC(True)
			If _Sleep(10000) Then Return
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd
	Click($aButtonVillageConfirmOK[0],$aButtonVillageConfirmOK[1],1,0,"#GACo")
	If _Sleep(500) Then Return False
	Return True
EndFunc

Func saveCurStats($iSlot)
	For $i = 4 To 54
		$aProfileStats[$i][$iSlot+1] = Eval($aProfileStats[$i][0])
	Next
	$aProfileStats[57][$iSlot+1] = Eval($aProfileStats[57][0])
EndFunc

Func loadCurStats($iSlot)
	Local $aTemp[4] = [0,0,0,0]
	For $i = 0 To 45
		Assign($aProfileStats[$i][0],$aProfileStats[$i][$iSlot+1])
	Next

	Assign($aProfileStats[57][0],$aProfileStats[57][$iSlot+1])

	If Not IsArray($aProfileStats[46][$iSlot+1]) Then
		$iAttackedVillageCount = $aTemp
		$iTotalGoldGain = $aTemp
		$iTotalElixirGain = $aTemp
		$iTotalDarkGain = $aTemp
		$iTotalTrophyGain = $aTemp
		$iNbrOfDetectedMines = $aTemp
		$iNbrOfDetectedCollectors = $aTemp
		$iNbrOfDetectedDrills = $aTemp
	Else
		$iAttackedVillageCount = ($aProfileStats[46][$iSlot+1])
		$iTotalGoldGain = $aProfileStats[47][$iSlot+1]
		$iTotalElixirGain = $aProfileStats[48][$iSlot+1]
		$iTotalDarkGain = $aProfileStats[49][$iSlot+1]
		$iTotalTrophyGain = $aProfileStats[50][$iSlot+1]
		$iNbrOfDetectedMines = $aProfileStats[51][$iSlot+1]
		$iNbrOfDetectedCollectors = $aProfileStats[52][$iSlot+1]
		$iNbrOfDetectedDrills = $aProfileStats[53][$iSlot+1]
	EndIf

	If $aProfileStats[54][$iSlot+1] = 0 And $iTownHallLevel > 0 Then $aProfileStats[54][$iSlot+1] = $iTownHallLevel

	displayStats($iSlot)
EndFunc

Func resetCurStats($iSlot)
	Local $aTemp[4] = [0,0,0,0]
	For $i = 0 To 45
		$aProfileStats[$i][$iSlot+1] = 0
	Next
	$aProfileStats[46][$iSlot+1] = $aTemp
	$aProfileStats[47][$iSlot+1] = $aTemp
	$aProfileStats[48][$iSlot+1] = $aTemp
	$aProfileStats[49][$iSlot+1] = $aTemp
	$aProfileStats[50][$iSlot+1] = $aTemp
	$aProfileStats[51][$iSlot+1] = $aTemp
	$aProfileStats[52][$iSlot+1] = $aTemp
	$aProfileStats[53][$iSlot+1] = $aTemp
	$aProfileStats[57][$iSlot+1] = 0
	$aProfileStats[2][$iSlot+1] = ""
	$aProfileStats[41][$iSlot+1] = ""
EndFunc

Func buildSwitchList()
	Local $OldSwitchList[1][7]
	Local $iCount = 0

	ReDim $OldSwitchList[UBound($aSwitchList)][7]
	$OldSwitchList = $aSwitchList

	ReDim $aSwitchList[$iCount + 1][7]
	$aSwitchList[$iCount][0] = 0
	$aSwitchList[$iCount][1] = 0
	$aSwitchList[$iCount][2] = 0
	$aSwitchList[$iCount][4] = 0
	$aSwitchList[$iCount][5] = 0
	$aSwitchList[$iCount][6] = 0
	$iTotalDonateType = 0
	For $i = 0 To 7
		If $ichkEnableAcc[$i] = 1 Then
			If $ichkUseADBLoadVillage = 1 Then
				If Not FileExists(@ScriptDir & "\profiles\" & $icmbWithProfile[$i] & "\shared_prefs\HSJsonData.xml") Then
					MsgBox($MB_SYSTEMMODAL, "Error!", "shared_prefs for " & $icmbWithProfile[$i] & " not found." & @CRLF _
					& "Please Load profile " & $icmbWithProfile[$i] & " and goto emulator load village " & $icmbWithProfile[$i] & @CRLF _
					& "Then use get shared_prefs button to get shared_prefs before use this feature.")
					$ichkUseADBLoadVillage = 0
					GUICtrlSetState($chkUseADBLoadVillage, $GUI_UNCHECKED)
					IniWrite(@ScriptDir & "\Profiles\MySwitch.ini", "MySwitch", "EnablesPrefSwitch", 0)
				EndIf
			EndIf
			If $ichkProfileImage = 1 Then
				If Not FileExists(@ScriptDir & "\profiles\" & $icmbWithProfile[$i] & "\village_92.png") Then
					MsgBox($MB_SYSTEMMODAL, "Error!", "village_92.png for " & $icmbWithProfile[$i] & " not found." & @CRLF _
					& "Please Load profile " & $icmbWithProfile[$i] & " and goto emulator load village " & $icmbWithProfile[$i] & @CRLF _
					& "Then use get shared_prefs button to get village_92.png before use this feature.")
					$ichkProfileImage = 0
					GUICtrlSetState($chkProfileImage, $GUI_UNCHECKED)
					IniWrite(@ScriptDir & "\Profiles\MySwitch.ini", "MySwitch", "CheckVillage", 0)
				EndIf
			EndIf
			ReDim $aSwitchList[$iCount + 1][7]
			$aSwitchList[$iCount][0] = _NowCalc() ;initialize army train time with date and time now
			$aSwitchList[$iCount][1] = TimerInit()
			$aSwitchList[$iCount][2] = $icmbAtkDon[$i] ; atk or don flag
			$aSwitchList[$iCount][3] = $icmbWithProfile[$i] ; profile name
			$aSwitchList[$iCount][4] = $i ; account slot
			$aSwitchList[$iCount][5] = 0
			$aSwitchList[$iCount][6] = $icmbStayTime[$i] ; stay time (minutes)
			If $icmbAtkDon[$i] = 1 Then
				$iTotalDonateType += 1
			EndIf
			$iCount += 1
		Else
			If $i = $iCurActiveAcc Then
				$iCurActiveAcc = -1
			EndIf
		EndIf
	Next

	;restore army time from old setting if got
	For $i = 0 To UBound($aSwitchList) - 1
		For $j = 0 To UBound($OldSwitchList) - 1
			If $aSwitchList[$i][4] = $OldSwitchList[$j][4] And $aSwitchList[$i][3] = $OldSwitchList[$j][3] Then
				$aSwitchList[$i][0] = $OldSwitchList[$j][0]
				$aSwitchList[$i][5] = $OldSwitchList[$j][5]
				ExitLoop
			EndIf
		Next
	Next

	sortSwitchList()
EndFunc

Func sortSwitchList()
	; sort switch list for make atk type first, donate type last
	$iSortEnd = -1
	Local $iMaxCount = UBound($aSwitchList) - 1

	_ArraySort($aSwitchList,0,0,0,2)

	For $i = 0 to $iMaxCount
		If $aSwitchList[$i][2] = 1 Then
			$iSortEnd = $i - 1
			ExitLoop
		EndIf
	Next

	If $iSortEnd <> -1 Then
		If $iSortEnd <> 0 Then
			_ArraySort($aSwitchList,0,0,$iSortEnd,0)
			If $iSortEnd + 1 < $iMaxCount Then
				_ArraySort($aSwitchList,0,$iSortEnd + 1,$iMaxCount,0)
			EndIf
		Else
			If $iSortEnd + 1 < $iMaxCount Then
				_ArraySort($aSwitchList,0,$iSortEnd + 1,$iMaxCount,0)
			EndIf
		EndIf
	Else
		_ArraySort($aSwitchList,0,0,0,0)
	EndIf
EndFunc

Func getNextSwitchList()
	Local $bFlagDoSortSwitchList = False
	Local $bFlagGotTrainTimeout = False
	Local $iNextAccSlot = $iCurActiveAcc
	Local $iFirstAtkDonAcc = -1
	Local $iStayRemain

	SetLog("Start checking is that any accounts ready for switch.",$COLOR_INFO)

	For $i = 0 to UBound($aSwitchList) - 1
		Local $iDateCalc = _DateDiff('s', $aSwitchList[$i][0], _NowCalc()) ;compare date time from last check, return different seconds

		SetLog("Account:" & $aSwitchList[$i][4] + 1 & " - " & $aSwitchList[$i][3] & " [" & ($aSwitchList[$i][2] = 1 ? "D" : "A") &  "] - " & _
		($iDateCalc >= 0 ? "Army getting ready." : "Army getting ready within " & 0 - $iDateCalc & " seconds.") & ($aSwitchList[$i][5] = 1 ? " - PB" : ""),$COLOR_INFO)

		If $iDateCalc >= 0 Then $aSwitchList[$i][5] = 0 ; if current date time over, reset PB flag to enable switch again
		; early 180 seconds for switch change acc if any attack type account train finish soon
		If $iDateCalc >= (-120 * $iTotalDonateType) And $aSwitchList[$i][2] = 0 Then $bFlagGotTrainTimeout = True
		; check the first donate acc
		If $iFirstAtkDonAcc = -1 Then
			If $aSwitchList[$i][2] = 1 Then
				$iFirstAtkDonAcc = $i ; first donate type account found, for use with $ichkSwitchDonTypeOnlyWhenAtkTypeNotReady, hidden option if need this feature, variable set to 1 and recompile
			EndIf
		EndIf

		If $aSwitchList[$i][4] = $iCurActiveAcc Then
			$bChangeNextAcc = True
			If $bFlagGotTrainTimeout = False Then
				$iStayRemain = TimerDiff($aSwitchList[$i][1])
				If $aSwitchList[$i][2] = 1 Then ; if current active account is donate type, then check for attack type acc if any available attack type acc for switch, if not just stay donate acc.
					If $ichkSwitchDonTypeOnlyWhenAtkTypeNotReady Then ; hidden option
						SetLog("Attack type account still didn't get ready, stay donate type account.",$COLOR_INFO)
						If $i = UBound($aSwitchList) - 1 Then
							If $iFirstAtkDonAcc <> $i Then ; check switch change other donate acc.
								If $aSwitchList[$iFirstAtkDonAcc][5] = 0 Then ; if not PB time
									If $iStayRemain >= (($aSwitchList[$i][6] * 60) * 1000) Then ; stay ? minutes before change account
										If $iSamM0dDebug Then SetLog("$aSwitchList[$iFirstAtkDonAcc][4]: " & $aSwitchList[$iFirstAtkDonAcc][4])
										SetLog("Switch other donate account: " & $aSwitchList[$iFirstAtkDonAcc][3],$COLOR_INFO)
										Return $aSwitchList[$iFirstAtkDonAcc][4]
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
				; stay ? minutes before change account
				If $iStayRemain <= (($aSwitchList[$i][6] * 60) * 1000) And $aSwitchList[$i][5] = 0 Then
					SetLog("Stay remain: " & ($aSwitchList[$i][6] * 60) - Int($iStayRemain / 1000) & " seconds",$COLOR_INFO)
					$bChangeNextAcc = False
				EndIf
			EndIf
		EndIf
	Next

	If $iSamM0dDebug Then SetLog("$iNextAccSlot: " & $iNextAccSlot)
	If $iSamM0dDebug Then SetLog("$bChangeNextAcc: " & $bChangeNextAcc)
	If $iSamM0dDebug Then SetLog("$bFlagGotTrainTimeout: " & $bFlagGotTrainTimeout)
	If $iSamM0dDebug Then SetLog("$iFirstAtkDonAcc: " & $iFirstAtkDonAcc)
	If $iSamM0dDebug Then SetLog("$bFlagDoSortSwitchList: " & $bFlagDoSortSwitchList)

	If $bFlagGotTrainTimeout = False Then
		If $bChangeNextAcc = False Then Return $iNextAccSlot
	Else
		If $iStayRemain > 0 Then
			SetLog("Stay voided, got attack type account ready for farming.",$COLOR_INFO)
		EndIf
	EndIf

	If $iSamM0dDebug Then SetLog("$iNextAccSlot1: " & $iNextAccSlot)

	For $i = 0 to UBound($aSwitchList) - 1
		If $aSwitchList[$i][4] = $iNextAccSlot Then
			If $i >= UBound($aSwitchList) - 1 Then
				; this will be end of switch list, prepare sort switchlist with train time again
				$bFlagDoSortSwitchList = True
			Else
				$iNextAccSlot = $aSwitchList[$i+1][4]
				If $aSwitchList[$i+1][5] = 0 Then ExitLoop ; select this profile if not is PB activate
			EndIf
		EndIf
	Next

	If $iSamM0dDebug Then SetLog("$iNextAccSlot2: " & $iNextAccSlot)
	If $iSamM0dDebug Then SetLog("$bFlagDoSortSwitchList: " & $bFlagDoSortSwitchList)

	If $bFlagDoSortSwitchList Or $iCurActiveAcc = -1 Then
		sortSwitchList()
		;$iNextAccSlot = $aSwitchList[0][4]
		For $i = 0 to UBound($aSwitchList) - 1
			If $aSwitchList[$i][5] = 0 Then  ; select this profile if not is PB activate
				$iNextAccSlot = $aSwitchList[$i][4]
				ExitLoop
			EndIf
		Next
	EndIf

	If $iSamM0dDebug Then SetLog("$iNextAccSlot3: " & $iNextAccSlot)
	Return $iNextAccSlot
EndFunc

Func DoSwitchAcc()
	If _Sleep($iDelaycheckArmyCamp4) Then Return

	If $iCurActiveAcc = - 1 Then
		$iDoPerformAfterSwitch = True
	Else
		If $iDoPerformAfterSwitch Then
			SetLog("Check train before switch account...",$COLOR_ACTION)
			If $ichkCustomTrain = 1 Then
				CustomTrain()
			Else
				TrainRevamp()
			EndIf
		EndIf
	EndIf

	If $iDoPerformAfterSwitch = False Then Return

	$iNextAcc = getNextSwitchList()

	If $iSamM0dDebug Then SetLog("$iCurActiveAcc: " & $iCurActiveAcc)
	If $iSamM0dDebug Then SetLog("$iNextAcc: " & $iNextAcc)

	If $iCurActiveAcc <> $iNextAcc Then
		If _Sleep($iDelaycheckArmyCamp4) Then Return

		If $iCurActiveAcc <> - 1 Then
			;SetLog("Do train army and brew spell",$COLOR_ACTION)
			SetLog("Switch account from " & $icmbWithProfile[$iCurActiveAcc] & " to " & $icmbWithProfile[$iNextAcc] ,$COLOR_ACTION)
			saveCurStats($iCurActiveAcc)
		Else
			SetLog("Switch account start from " & $icmbWithProfile[$iNextAcc] ,$COLOR_ACTION)
		EndIf

		If _Sleep($iDelaycheckArmyCamp4) Then Return

		If $ichkUseADBLoadVillage = 1 Then
			Local $iTempNextACC = -1
			For $i = 0 To UBound($aSwitchList) - 1
				If $aSwitchList[$i][4] = $iNextAcc Then
					$iTempNextACC = $i
					$aSwitchList[$i][1] = TimerInit()
				EndIf
			Next

			If $iSamM0dDebug Then SetLog("$iTempNextACC: " & $iTempNextACC)
			If $iSamM0dDebug Then SetLog("$aSwitchList[$iTempNextACC][3]: " & $aSwitchList[$iTempNextACC][3])
			If $iSamM0dDebug Then SetLog("$aSwitchList[$iTempNextACC][4]: " & $aSwitchList[$iTempNextACC][4])

			If $iTempNextACC <> - 1 Then
				If loadVillageFrom($aSwitchList[$iTempNextACC][3], $aSwitchList[$iTempNextACC][4]) = True Then
					$iCurActiveAcc = $iNextAcc
					DoVillageLoadSucess($iCurActiveAcc)
				Else
					$Restart = True
					$iSelectAccError += 1
					If $iSelectAccError > 2 Then
						$iSelectAccError = 0
						DoVillageLoadFailed()
					EndIf
				EndIf
			EndIf
		Else
			If _ColorCheck(_GetPixelColor($aButtonSetting[4], $aButtonSetting[5],True), Hex($aButtonSetting[6], 6), Number($aButtonSetting[7])) Then
				If SelectGoogleAccount($iNextAcc) = True Then
					$iCurActiveAcc = $iNextAcc
					DoVillageLoadSucess($iCurActiveAcc)

				Else
					$Restart = True
					$iSelectAccError += 1
					If $iSelectAccError > 2 Then
						$iSelectAccError = 0
						DoVillageLoadFailed()
					EndIf
				EndIf
			Else
				SetLog("Cannot find setting button.",$COLOR_RED)
				CloseCoC(True)
				If _Sleep(10000) Then Return
				$Restart = True
			EndIf
		EndIf
	EndIf

	;GUICtrlSetData($lblActiveAcc,"Current Active Acc: " & $iCurActiveAcc + 1)
	GUICtrlSetData($grpMySwitch,"Current Active Acc: " & @CRLF & $aSwitchList[$iCurStep][4] + 1 & " - " & $aSwitchList[$iCurStep][3] & " [" & ($aSwitchList[$iCurStep][2] = 1 ? "D" : "A") &  "]")
	If $iCurActiveAcc <> - 1 Then
		GUICtrlSetData($lblProfileName,$icmbWithProfile[$iCurActiveAcc])
	Else
		$bChangeNextAcc = True
	EndIf

	If $ichkCloseWaitEnable = 1 Then
		SetLog("Disable smart wait")
		$ichkCloseWaitEnable = 0
	EndIf

	ClickP($aAway,1,0)
	If _Sleep($iDelaycheckArmyCamp4) Then Return
EndFunc

Func DoVillageLoadSucess($iAcc)
	If $iSamM0dDebug Then SetLog("DoVillageLoadSucess: " & $icmbWithProfile[$iAcc])
	For $i = 0 To UBound($aSwitchList) - 1
		If $aSwitchList[$i][4] = $iAcc Then
			$iCurStep = $i
			$aSwitchList[$i][1] = TimerInit()
		EndIf
	Next

	setCombolistByText($cmbProfile, $icmbWithProfile[$iAcc])

	SetLog("Prepare to load profile: " & GUICtrlRead($cmbProfile),$COLOR_ACTION)
	cmbProfile()
	If $iSamM0dDebug Then SetLog("$iAcc: " & $iAcc)
	loadCurStats($iAcc)

	; after load new profile, reset variable below for new runbot() loop
	$Restart = False
	$bDonateAwayFlag = False
	$bJustMakeDonate = False
	$tempDisableBrewSpell = False
	$fullArmy = False
	$FullCCTroops = False
	$bFullArmyHero = False
	$bFullArmySpells = False
	$Is_ClientSyncError = False
	$Is_SearchLimit = False
	$Quickattack = False
	$aShieldStatus[0] = ""
	$aShieldStatus[1] = ""
	$aShieldStatus[2] = ""
	$sPBStartTime = ""
	;$iShouldRearm = (Random(0,1,1) = 0 ? 1 : 0)

	$NotNeedAllTime[0] = (Random(0,1,1) = 0 ? 1 : 0) ; check rearm
	$NotNeedAllTime[1] = (Random(0,1,1) = 0 ? 1 : 0) ; check tomb

	$CommandStop = -1
	$iSelectAccError = 0

	If _Sleep($iDelayRunBot1) Then Return
	checkMainScreen()

	If $ichkProfileImage = 1 Then ; check with image is that village load correctly
		If checkProfileCorrect() = True Then
			SetLog("Profile match with village.png, profile loaded correctly.", $COLOR_INFO)
			$iCheckAccProfileError = 0
			;$bProfileImageChecked = True
		Else
			SetLog("Profile not match with village.png, profile load failed.", $COLOR_ERROR)
			$iCheckAccProfileError += 1
			If $iCheckAccProfileError > 2 Then
				$iCheckAccProfileError = 0
				DoVillageLoadFailed()
			EndIf
			$iCurActiveAcc = -1
			$Restart = True
		EndIf
	EndIf
EndFunc

Func DoVillageLoadFailed()
	; Reboot Android
	SetLog("Restart emulator since cannot change account more than 2 times.",$COLOR_RED)
	Local $_NoFocusTampering = $NoFocusTampering
	$NoFocusTampering = True
	RebootAndroid()
	$NoFocusTampering = $_NoFocusTampering
EndFunc

Func DoCheckSwitchEnable()
	; auto enable switch account if current profile are tick as enable switch profile
	$ichkEnableMySwitch = 0

	For $i = 0 To UBound($aSwitchList) - 1
		If $aSwitchList[$i][3] = $sCurrProfile Then
			$ichkEnableMySwitch = 1
			ExitLoop
		EndIf
	Next

	If UBound($aSwitchList) <= 1 Then $ichkEnableMySwitch = 0

	If $ichkEnableMySwitch = 1 Then
		GUICtrlSetState($chkEnableMySwitch, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkEnableMySwitch, $GUI_UNCHECKED)
	EndIf
EndFunc


Func DoViewStats1()
	If $iCurActiveAcc <> - 1 Then
		If UBound($aSwitchList) > 1 Then
			If $iCurStep > 0 Then
				$iCurStep -= 1
			Else
				$iCurStep = UBound($aSwitchList) - 1
			EndIf
		EndIf
		$bUpdateStats = False
		GUICtrlSetState($arrowleft2,$GUI_DISABLE + $GUI_HIDE)
		displayStats($aSwitchList[$iCurStep][4])
		GUICtrlSetData($lblProfileName,$aSwitchList[$iCurStep][3])
		GUICtrlSetData($grpVillage, GetTranslated(603, 32, "Village") & ": " & $aSwitchList[$iCurStep][3])
		GUICtrlSetState($arrowleft2,$GUI_ENABLE + $GUI_SHOW)
	EndIf
EndFunc

Func DoViewStats2()
	If $iCurActiveAcc <> - 1 Then
		If UBound($aSwitchList) > 1 Then
			If $iCurStep + 1 > UBound($aSwitchList) - 1 Then
				$iCurStep = 0
			Else
				$iCurStep += 1
			EndIf
		EndIf
		$bUpdateStats = False
		GUICtrlSetState($arrowright2,$GUI_DISABLE + $GUI_HIDE)
		displayStats($aSwitchList[$iCurStep][4])
		GUICtrlSetData($lblProfileName,$aSwitchList[$iCurStep][3])
		GUICtrlSetData($grpVillage, GetTranslated(603, 32, "Village") & ": " & $aSwitchList[$iCurStep][3])
		GUICtrlSetState($arrowright2,$GUI_ENABLE + $GUI_SHOW)
	EndIf
EndFunc

Func displayStats($iSlot)

	If $FirstRun = 1 Then Return

	If $aProfileStats[4][$iSlot+1] > 0 Then
		;GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
		;GUICtrlSetState($lblLastAttackBonusTemp, $GUI_HIDE)
		;GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
		;GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE)
		$aProfileStats[4][$iSlot+1] = 2
	Else
		;GUICtrlSetState($lblLastAttackTemp, $GUI_SHOW)
		;GUICtrlSetState($lblLastAttackBonusTemp, $GUI_SHOW)
		;GUICtrlSetState($lblTotalLootTemp, $GUI_SHOW)
		;GUICtrlSetState($lblHourlyStatsTemp, $GUI_SHOW)

		GUICtrlSetData($lblHourlyStatsGold, "")
		GUICtrlSetData($lblHourlyStatsElixir, "")
		GUICtrlSetData($lblHourlyStatsDark, "")
		GUICtrlSetData($lblHourlyStatsTrophy, "")
		GUICtrlSetData($lblResultGoldHourNow, "") ;GUI BOTTOM
		GUICtrlSetData($lblResultElixirHourNow, "");GUI BOTTOM
		GUICtrlSetData($lblResultDEHourNow, "") ;GUI BOTTOM

		GUICtrlSetData($lblGoldLoot, "")
		GUICtrlSetData($lblElixirLoot, "")
		GUICtrlSetData($lblDarkLoot, "")
		GUICtrlSetData($lblTrophyLoot, "")
		GUICtrlSetData($lblGoldLastAttack, "")
		GUICtrlSetData($lblElixirLastAttack, "")
		GUICtrlSetData($lblDarkLastAttack, "")
		GUICtrlSetData($lblTrophyLastAttack, "")
		GUICtrlSetData($lblGoldBonusLastAttack, "")
		GUICtrlSetData($lblElixirBonusLastAttack, "")
		GUICtrlSetData($lblDarkBonusLastAttack, "")
	EndIf

	If $aProfileStats[2][$iSlot+1] <> "" Then
		If GUICtrlGetState($lblResultDEStart) = $GUI_ENABLE + $GUI_HIDE Then
			GUICtrlSetState($lblResultDEStart, $GUI_SHOW)
			GUICtrlSetState($picResultDEStart, $GUI_SHOW)
			GUICtrlSetState($picResultDeNow, $GUI_SHOW)
			If GUICtrlGetState($lblResultGoldNow) = $GUI_ENABLE + $GUI_SHOW Then
				GUICtrlSetState($lblResultDeNow, $GUI_SHOW)
				GUICtrlSetState($lblResultDEHourNow, $GUI_HIDE)
			Else
				GUICtrlSetState($lblResultDeNow, $GUI_HIDE)
				GUICtrlSetState($lblResultDEHourNow, $GUI_SHOW)
			EndIf
			GUICtrlSetState($lblDarkLoot,$GUI_SHOW)
			GUICtrlSetState($picDarkLoot, $GUI_SHOW)
			GUICtrlSetState($lblDarkLastAttack, $GUI_SHOW)
			GUICtrlSetState($picDarkLastAttack, $GUI_SHOW)
			GUICtrlSetState($lblHourlyStatsDark, $GUI_SHOW)
			GUICtrlSetState($picHourlyStatsDark, $GUI_SHOW)
		EndIf
	Else
		If GUICtrlGetState($lblResultDEStart) = $GUI_ENABLE + $GUI_SHOW Then
			GUICtrlSetState($lblResultDEStart, $GUI_HIDE)
			GUICtrlSetState($picResultDEStart, $GUI_HIDE)
			GUICtrlSetState($lblResultDeNow, $GUI_HIDE)
			GUICtrlSetState($picResultDeNow, $GUI_HIDE)
			GUICtrlSetState($lblResultDEHourNow, $GUI_HIDE)
			GUICtrlSetState($lblDarkLoot,$GUI_HIDE)
			GUICtrlSetState($picDarkLoot, $GUI_HIDE)
			GUICtrlSetState($lblDarkLastAttack, $GUI_HIDE)
			GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
			GUICtrlSetState($lblHourlyStatsDark, $GUI_HIDE)
			GUICtrlSetState($picHourlyStatsDark, $GUI_HIDE)
		EndIf
	EndIf


	GUICtrlSetData($lblResultGoldStart, _NumberFormat($aProfileStats[0][$iSlot+1], True))
	GUICtrlSetData($lblResultElixirStart, _NumberFormat($aProfileStats[1][$iSlot+1], True))
	GUICtrlSetData($lblResultDEStart, _NumberFormat($aProfileStats[2][$iSlot+1], True))
	GUICtrlSetData($lblResultTrophyStart, _NumberFormat($aProfileStats[3][$iSlot+1], True))

	GUICtrlSetData($lblResultGoldNow, _NumberFormat($aProfileStats[39][$iSlot+1], True))
	GUICtrlSetData($lblResultElixirNow, _NumberFormat($aProfileStats[40][$iSlot+1], True))
	GUICtrlSetData($lblResultDeNow, _NumberFormat($aProfileStats[41][$iSlot+1], True))
	GUICtrlSetData($lblResultTrophyNow, _NumberFormat($aProfileStats[42][$iSlot+1], True))

	GUICtrlSetData($lblWallUpgCostGold, _NumberFormat($aProfileStats[18][$iSlot+1], True))
	GUICtrlSetData($lblWallUpgCostElixir, _NumberFormat($aProfileStats[19][$iSlot+1], True))
	GUICtrlSetData($lblBuildingUpgCostGold, _NumberFormat($aProfileStats[20][$iSlot+1], True))
	GUICtrlSetData($lblBuildingUpgCostElixir, _NumberFormat($aProfileStats[21][$iSlot+1], True))
	GUICtrlSetData($lblHeroUpgCost, _NumberFormat($aProfileStats[22][$iSlot+1], True))
	GUICtrlSetData($lblresultvillagesskipped, _NumberFormat($aProfileStats[16][$iSlot+1], True))
	GUICtrlSetData($lblResultSkippedHourNow, _NumberFormat($aProfileStats[16][$iSlot+1], True))
	GUICtrlSetData($lblresulttrophiesdropped, _NumberFormat($aProfileStats[17][$iSlot+1], True))
	GUICtrlSetData($lblWallgoldmake, $aProfileStats[23][$iSlot+1])
	GUICtrlSetData($lblWallelixirmake, $aProfileStats[24][$iSlot+1])
	GUICtrlSetData($lblNbrOfBuildingUpgGold, $aProfileStats[25][$iSlot+1])
	GUICtrlSetData($lblNbrOfBuildingUpgElixir, $aProfileStats[26][$iSlot+1])
	GUICtrlSetData($lblNbrOfHeroUpg, $aProfileStats[27][$iSlot+1])
	GUICtrlSetData($lblSearchCost, _NumberFormat($aProfileStats[28][$iSlot+1], True))
	GUICtrlSetData($lblTrainCostElixir, _NumberFormat($aProfileStats[29][$iSlot+1], True))
	GUICtrlSetData($lblTrainCostDElixir, _NumberFormat($aProfileStats[30][$iSlot+1], True))
	GUICtrlSetData($lblNbrOfOoS, $aProfileStats[31][$iSlot+1])
	GUICtrlSetData($lblNbrOfTSFailed, $aProfileStats[32][$iSlot+1])
	GUICtrlSetData($lblNbrOfTSSuccess, $aProfileStats[33][$iSlot+1])
	GUICtrlSetData($lblGoldFromMines, _NumberFormat($aProfileStats[34][$iSlot+1], True))
	GUICtrlSetData($lblElixirFromCollectors, _NumberFormat($aProfileStats[35][$iSlot+1], True))
	GUICtrlSetData($lblDElixirFromDrills, _NumberFormat($aProfileStats[36][$iSlot+1], True))

	GUICtrlSetData($lblResultBuilderNow, $aProfileStats[43][$iSlot+1] & "/" & $aProfileStats[44][$iSlot+1])
	GUICtrlSetData($lblResultGemNow, _NumberFormat($aProfileStats[45][$iSlot+1], True))


	Local $aTemp[4] = [0,0,0,0]
	Local $tempAttackedVillageCount[$iModeCount+1]
	Local $tempTotalGoldGain[$iModeCount+1]
	Local $tempTotalElixirGain[$iModeCount+1]
	Local $tempTotalDarkGain[$iModeCount+1]
	Local $tempTotalTrophyGain[$iModeCount+1]
	Local $tempNbrOfDetectedMines[$iModeCount+1]
	Local $tempNbrOfDetectedCollectors[$iModeCount+1]
	Local $tempNbrOfDetectedDrills[$iModeCount+1]

	If Not IsArray($aProfileStats[46][$iSlot+1]) Then
		$tempAttackedVillageCount = $aTemp
		$tempTotalGoldGain = $aTemp
		$tempTotalElixirGain = $aTemp
		$tempTotalDarkGain = $aTemp
		$tempTotalTrophyGain = $aTemp
		$tempNbrOfDetectedMines = $aTemp
		$tempNbrOfDetectedCollectors = $aTemp
		$tempNbrOfDetectedDrills = $aTemp
	Else
		$tempAttackedVillageCount = $aProfileStats[46][$iSlot+1]
		$tempTotalGoldGain = $aProfileStats[47][$iSlot+1]
		$tempTotalElixirGain = $aProfileStats[48][$iSlot+1]
		$tempTotalDarkGain = $aProfileStats[49][$iSlot+1]
		$tempTotalTrophyGain = $aProfileStats[50][$iSlot+1]
		$tempNbrOfDetectedMines = $aProfileStats[51][$iSlot+1]
		$tempNbrOfDetectedCollectors = $aProfileStats[52][$iSlot+1]
		$tempNbrOfDetectedDrills = $aProfileStats[53][$iSlot+1]
	EndIf

	Local $iAttackedCount = 0
	For $i = 0 To $iModeCount
		GUICtrlSetData($lblAttacked[$i], _NumberFormat($tempAttackedVillageCount[$i], True))
		$iAttackedCount += $tempAttackedVillageCount[$i]

		GUICtrlSetData($lblTotalGoldGain[$i], _NumberFormat($tempTotalGoldGain[$i], True))
		GUICtrlSetData($lblTotalElixirGain[$i], _NumberFormat($tempTotalElixirGain[$i], True))

		GUICtrlSetData($lblTotalDElixirGain[$i], _NumberFormat($tempTotalDarkGain[$i], True))
		GUICtrlSetData($lblTotalTrophyGain[$i], _NumberFormat($tempTotalTrophyGain[$i], True))
	Next

	GUICtrlSetData($lblresultvillagesattacked, _NumberFormat($iAttackedCount, True))
	GUICtrlSetData($lblResultAttackedHourNow, _NumberFormat($iAttackedCount, True))

	For $i = 0 To $iModeCount
		If $i = $TS Then ContinueLoop
		GUICtrlSetData($lblNbrOfDetectedMines[$i], $tempNbrOfDetectedMines[$i])
		GUICtrlSetData($lblNbrOfDetectedCollectors[$i], $tempNbrOfDetectedCollectors[$i])
		GUICtrlSetData($lblNbrOfDetectedDrills[$i], $tempNbrOfDetectedDrills[$i])
	Next

	If $aProfileStats[4][$iSlot+1] = 2 Then
		GUICtrlSetData($lblHourlyStatsGold, _NumberFormat(Round($aProfileStats[5][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
		GUICtrlSetData($lblHourlyStatsElixir, _NumberFormat(Round($aProfileStats[6][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
		GUICtrlSetData($lblHourlyStatsTrophy, _NumberFormat(Round($aProfileStats[8][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")

		GUICtrlSetData($lblResultGoldHourNow, _NumberFormat(Round($aProfileStats[5][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM
		GUICtrlSetData($lblResultElixirHourNow, _NumberFormat(Round($aProfileStats[6][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM

		GUICtrlSetData($lblGoldLoot, _NumberFormat($aProfileStats[5][$iSlot+1]))
		GUICtrlSetData($lblElixirLoot, _NumberFormat($aProfileStats[6][$iSlot+1]))
		GUICtrlSetData($lblTrophyLoot, _NumberFormat($aProfileStats[8][$iSlot+1]))
		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($aProfileStats[9][$iSlot+1]))
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($aProfileStats[10][$iSlot+1]))
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($aProfileStats[12][$iSlot+1]))
		GUICtrlSetData($lblGoldBonusLastAttack, _NumberFormat($aProfileStats[13][$iSlot+1]))
		GUICtrlSetData($lblElixirBonusLastAttack, _NumberFormat($aProfileStats[14][$iSlot+1]))
		GUICtrlSetData($lblDarkBonusLastAttack, _NumberFormat($aProfileStats[15][$iSlot+1]))

		;If $aProfileStats[2][$iSlot+1] <> "" Then
			GUICtrlSetData($lblHourlyStatsDark, _NumberFormat(Round($aProfileStats[7][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")
			GUICtrlSetData($lblResultDEHourNow, _NumberFormat(Round($aProfileStats[7][$iSlot+1] / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h") ;GUI BOTTOM
			GUICtrlSetData($lblDarkLoot, _NumberFormat($aProfileStats[7][$iSlot+1]))
			GUICtrlSetData($lblDarkLastAttack, _NumberFormat($aProfileStats[11][$iSlot+1]))
		;Else
		;	GUICtrlSetData($lblHourlyStatsDark, "")
		;	GUICtrlSetData($lblResultDEHourNow, "") ;GUI BOTTOM
		;	GUICtrlSetData($lblDarkLoot, "")
		;	GUICtrlSetData($lblDarkLastAttack, "")
		;EndIf
	EndIf

   ; SmartZap DE Gain - From ChaCalGyn(LunaEclipse) - DEMEN
	GUICtrlSetData($lblMySmartZap, _NumberFormat($aProfileStats[37][$iSlot+1], True))
	GUICtrlSetData($lblSmartZapStats, _NumberFormat($aProfileStats[37][$iSlot+1], True))

	; SmartZap Spells Used  From ChaCalGyn(LunaEclipse) - DEMEN
	GUICtrlSetData($lblMyLightningUsed, _NumberFormat($aProfileStats[38][$iSlot+1], True))
	GUICtrlSetData($lblLightningUsedStats, _NumberFormat($aProfileStats[38][$iSlot+1], True))

	GUICtrlSetData($lblEarthQuakeUsedStats, _NumberFormat($aProfileStats[57][$iSlot+1], True))

	_GUI_Value_STATE("HIDE",$groupListTHLevels)
	If $aProfileStats[54][$iSlot+1] >= 4 And $aProfileStats[54][$iSlot+1] <= 11 Then
		GUICtrlSetState(Eval("THLevels" & StringFormat("%02i",$aProfileStats[54][$iSlot+1])), $GUI_SHOW)
	EndIf

	GUICtrlSetData($lblLeague, "")
	If $aProfileStats[56][$iSlot+1] = 1 Then
		GUICtrlSetData($lblLeague, "1")
	ElseIf $aProfileStats[56][$iSlot+1] = 2 Then
		GUICtrlSetData($lblLeague, "2")
	ElseIf $aProfileStats[56][$iSlot+1] = 3 Then
		GUICtrlSetData($lblLeague, "3")
	EndIf

	_GUI_Value_STATE("HIDE",$groupLeague)
	If String($aProfileStats[55][$iSlot+1]) = "B" Then
		GUICtrlSetState($BronzeLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "S" Then
		GUICtrlSetState($SilverLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "G" Then
		GUICtrlSetState($GoldLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "c" Then
		GUICtrlSetState($CrystalLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "M" Then
		GUICtrlSetState($MasterLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "C" Then
		GUICtrlSetState($ChampionLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "T" Then
		GUICtrlSetState($TitanLeague,$GUI_SHOW)
	ElseIf String($aProfileStats[55][$iSlot+1]) = "LE" Then
		GUICtrlSetState($LegendLeague,$GUI_SHOW)
	Else
		GUICtrlSetState($UnrankedLeague,$GUI_SHOW)
	EndIf
EndFunc

Func btnMakeSwitchADBFolder()
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor($aButtonClose3[4], $aButtonClose3[5], True), Hex($aButtonClose3[6], 6), Number($aButtonClose3[7])) Then
		$hClone = _GDIPlus_BitmapCloneArea($hBitmap, 70,127,80,17, $GDIP_PXF24RGB)
		_GDIPlus_ImageSaveToFile($hClone, @ScriptDir & "\profiles\" & $sCurrProfile & "\village_92.png")

		Local $lResult
		Local $sMyProfilePath4shared_prefs = @ScriptDir & "\profiles\" & $sCurrProfile & "\shared_prefs"
		; remove old village before new copy
		DirRemove($sMyProfilePath4shared_prefs, 1)

		If StringInStr($sAndroidInfo,"bluestacks") Then
			$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " shell "& Chr(34) & "su -c 'chmod 777 /data/data/" & $AndroidGamePackage & "/shared_prefs; mkdir /sdcard/tempshared; cp /data/data/" & $AndroidGamePackage & _
			"/shared_prefs/* /sdcard/tempshared; exit; exit'" & Chr(34), "", @SW_HIDE)
			If $lResult = 0 Then
				$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " pull /sdcard/tempshared " & $sMyProfilePath4shared_prefs, "", @SW_HIDE)
				If $lResult = 0 Then
					$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " shell "& Chr(34) & "su -c 'rm -r /sdcard/tempshared; exit; exit'" & Chr(34), "", @SW_HIDE)
				EndIf
			EndIf
		Else
			If $iSamM0dDebug Then SetLog("Command: " & $AndroidAdbPath & " -s " & $AndroidAdbDevice & " pull /data/data/" & $AndroidGamePackage & "/shared_prefs " & $sMyProfilePath4shared_prefs)
			$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " pull /data/data/" & $AndroidGamePackage & "/shared_prefs " & $sMyProfilePath4shared_prefs, "", @SW_HIDE)
		EndIf

		If $lResult = 0 Then
			Local $bFileFlag = 0
			Local $bshared_prefs_file = False
			Local $bVillagePng = False
			If FileExists($sMyProfilePath4shared_prefs & "\HSJsonData.xml") Then $bFileFlag = BitOR($bFileFlag, 1)
			If FileExists(@ScriptDir & "\profiles\" & $sCurrProfile & "\village_92.png") Then $bFileFlag = BitOR($bFileFlag, 2)

			;If FileExists($sMyProfilePath4shared_prefs & "\localPrefs.xml") Then FileDelete($sMyProfilePath4shared_prefs & "\localPrefs.xml")

			Switch $bFileFlag
				Case 3
					MsgBox($MB_SYSTEMMODAL, "", "Sucess: shared_prefs copied and village_92.png captured.")
				Case 2
					MsgBox($MB_SYSTEMMODAL, "", "Failed to copy shared_prefs from emulator, but village_92.png captured.")
				Case 1
					MsgBox($MB_SYSTEMMODAL, "", "Failed to capture village_92.png from emulator, but shared_prefs copied.")
				Case Else
					MsgBox($MB_SYSTEMMODAL, "", "Failed to copy shared_prefs and capture village_92.png from emulator.")
			EndSwitch
		EndIf
	Else
		MsgBox($MB_SYSTEMMODAL, "", "Please open emulator and coc, then go to profile page before doing this action.")
	EndIf
EndFunc

Func loadVillageFrom($Profilename, $iSlot)
	PoliteCloseCoC()
	If _Sleep(1500) Then Return False
	Local $lResult
	Local $sMyProfilePath4shared_prefs = @ScriptDir & "\profiles\" & $Profilename & "\shared_prefs"
	Local $hostPath = $AndroidPicturesHostPath & $AndroidPicturesHostFolder & "shared_prefs"
	Local $androidPath = $AndroidPicturesPath & StringReplace($AndroidPicturesHostFolder, "\", "/") & "shared_prefs/"

	;If FileExists($sMyProfilePath4shared_prefs & "\localPrefs.xml") Then FileDelete($sMyProfilePath4shared_prefs & "\localPrefs.xml")

	If StringInStr($sAndroidInfo,"bluestacks") Then
		$lResult = DirCopy($sMyProfilePath4shared_prefs, $hostPath, 1)
		If $lResult = 1 Then
			$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " shell "& Chr(34) & "su -c 'chmod 777 /data/data/" & $AndroidGamePackage & "/shared_prefs; " & _
			"cp -r " & $androidPath & "* /data/data/" & $AndroidGamePackage & "/shared_prefs; exit; exit'" & Chr(34), "", @SW_HIDE)
			DirRemove($hostPath, 1)
			If $lResult = 0 Then
				SetLog("shared_prefs copy to emulator should be okay.", $COLOR_INFO)
				CloseCoC(True)
				Return True
			EndIf
		EndIf
	Else
		$lResult = RunWait($AndroidAdbPath & " -s " & $AndroidAdbDevice & " push " & $sMyProfilePath4shared_prefs & " /data/data/" & $AndroidGamePackage & "/shared_prefs", "", @SW_HIDE)
		If $lResult = 0 Then
			SetLog("shared_prefs copy to emulator should be okay.", $COLOR_INFO)
			CloseCoC(True)
			Return True
		EndIf
	EndIf
	Return False
EndFunc

Func checkProfileCorrect()
	If IsMainPage() Then
		Click($aButtonOpenProfile[0],$aButtonOpenProfile[1],1,0,"#0222")
		Local $iCount
		$iCount = 0
		While Not _ColorCheck(_GetPixelColor(85, 163, True), Hex(0X959AB6,6), 20) And Not _ColorCheck(_GetPixelColor(20, 295, True), Hex(0X4E4D79,6), 10)
			ClickDrag(380, 140 + $midOffsetY, 380, 580 + $midOffsetY, 1000)
			$iCount += 1
			If $iCount > 15 Then
				SetLog("Cannot load profile page...", $COLOR_RED)
				Return False
			EndIf
			If _Sleep(1000) Then Return False
		WEnd

		For $i = 0 To 2
			_CaptureRegion(68,126,155,145)

			Local $result = DllCall($hImgLib, "str", "FindTile", "handle", $hHBitmap, "str", @ScriptDir & "\profiles\" & $sCurrProfile & "\village_92.png", "str", "FV", "int", 1)
			If @error Then _logErrorDLLCall($pImgLib, @error)
			If IsArray($result) Then
				If $iSamM0dDebug Then SetLog("DLL Call succeeded " & $result[0], $COLOR_ERROR)
				If $result[0] = "0" Or $result[0] = "" Then
					If $iSamM0dDebug Then SetLog("Image not found", $COLOR_ERROR)
				ElseIf StringLeft($result[0], 2) = "-1" Then
					SetLog("DLL Error: " & $result[0], $COLOR_ERROR)
				Else
					If $iSamM0dDebug Then SetLog("$result[0]: " & $result[0])
					Local $aCoor = StringSplit($result[0],"|",$STR_NOCOUNT)
					If IsArray($aCoor) Then
						If StringLeft($aCoor[1], 2) <> "-1" Then
							ClickP($aAway,1,0)
							If _Sleep(1000) Then Return True
							Return True
						EndIf
					EndIf
				EndIf
			EndIf
			If _Sleep(1000) Then Return False
		Next
		ClickP($aAway,1,0)
		If _Sleep(1000) Then Return False
	EndIf
	Return False
EndFunc
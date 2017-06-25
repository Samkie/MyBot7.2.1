; #FUNCTION# ====================================================================================================================
; Name ..........:getNextSwitchList [BETA]
; Description ...:
; Syntax ........:getNextSwitchList()
; Parameters ....:
; Return values .: None
; Author ........: Samkie (21 JUN, 2017)
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
			If _ColorCheck(_GetPixelColor($x1, 96 + $aStartPos[1] + ($i * 72),$g_bNoCapturePixel), Hex(0xFFFFFF,6), 5) And _
				_ColorCheck(_GetPixelColor($x2, 96 + $aStartPos[1] + ($i * 72),$g_bNoCapturePixel), Hex(0xFFFFFF,6), 5) Then
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
			Wait4Main()
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd

	Click($aButtonSettingTabSetting[0],$aButtonSettingTabSetting[1],1,0,"#TabSettings")
	If _Sleep(500) Then Return False

	If _Sleep(5) Then Return False
	If _ColorCheck(_GetPixelColor($aButtonGoogleConnectRed[4], $aButtonGoogleConnectRed[5],True), Hex($aButtonGoogleConnectRed[6],6), $aButtonGoogleConnectRed[7]) Then
		Click($aButtonGoogleConnectRed[0],$aButtonGoogleConnectRed[1],1,0,"#ConnectGoogle")
	Else
		Click($aButtonGoogleConnectGreen[0],$aButtonGoogleConnectGreen[1],2,500,"#ConnectGoogle")
	EndIf

	$iCount = 0
	While Not _ColorCheck(_GetPixelColor(160, 380,True), Hex(0xFFFFFF, 6),10)
		If $iSamM0dDebug Then SetLog("wait for google account page Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount > 30 Then
			SetLog("Cannot load google account page, restart game...", $COLOR_RED)
			CloseCoC(True)
			Wait4Main()
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd

	$iCount = 0
	Local $bErrorFlag = 0
	While $iCount <= 10
		If _Sleep(1000) Then Return False
		Local $iTotalAcc = getTotalGoogleAccount()
		If $iTotalAcc < $iSlot + 1 Then
			$bErrorFlag += 1
			If $bErrorFlag >= 3 Then
				SetLog("You cannot select account slot " & $iSlot + 1 & ", because you only got total: " & $iTotalAcc, $COLOR_RED)
				AndroidBackButton()
				If _Sleep(500) Then Return False
				AndroidBackButton()
				BotStop()
				Return False
			EndIf
		Else
			Click(241, 84 + $iSlotYOffset + ($iSlot * 72), 1, 0, "#GASe")
			ExitLoop
		EndIf
		$iCount += 1
	WEnd

	Local $iResult
	$iResult = DoLoadVillage()

	If $iResult <> 1 And $iResult <> 2 Then Return False

	If _Sleep(500) Then Return False

	If $iSamM0dDebug Then SetLog("$iResult: " & $iResult)

	If _Sleep(5) Then Return False

	If $iResult = 1 Then
		If DoConfirmVillage() = False Then Return False
	Else
		ClickP($aAway,1,0)
	EndIf

	; wait for game reload
	Wait4Main()

;~ 	$iCount = 0
;~ 	While Not _ColorCheck(_GetPixelColor($aButtonSetting[4], $aButtonSetting[5],True), Hex($aButtonSetting[6], 6), Number($aButtonSetting[7]))
;~ 		If $iSamM0dDebug Then SetLog("Color: " & _GetPixelColor(160, 380,True))
;~ 		If _ColorCheck(_GetPixelColor(402, 516,True), Hex(0xFFFFFF, 6), 5) And _ColorCheck(_GetPixelColor(405, 537,True), Hex(0x5EAC10, 6), 20) Then
;~ 			Click($aButtonVillageWasAttackOK[0],$aButtonVillageWasAttackOK[1],1,0,"#VWAO")
;~ 			If _Sleep(1000) Then Return True
;~ 			Return True ;  village was attacked okay button
;~ 		EndIf
;~ 		$iCount += 1
;~ 		If $iCount > 20 Then
;~ 			; if cannot locate button setting, let continue checkMainScreen() handle.
;~ 			ExitLoop
;~ 		EndIf
;~ 		If _Sleep(1000) Then Return True
;~ 	WEnd
	Return True
EndFunc

Func DoLoadVillage()
	Local $iCount = 0
	$iCount = 0
	While Not _ColorCheck(_GetPixelColor($aButtonVillageLoad[4], $aButtonVillageLoad[5],True), Hex($aButtonVillageLoad[6],6), $aButtonVillageLoad[7])
		If $iSamM0dDebug Then SetLog("village load button Color: " & _GetPixelColor(160, 380,True))
		$iCount += 1
		If $iCount = 60 Then
			SetLog("Cannot load village load button, restart game...", $COLOR_RED)
			CloseCoC(True)
			Wait4Main()
		EndIf
		If $iCount >= 120 Then
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
			Wait4Main()
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd
	Click($aButtonVillageConfirmText[0],$aButtonVillageConfirmText[1],1,0,"#GATe")
	If _Sleep(500) Then Return False
	If SendText("CONFIRM") = 0 Then
		SetLog("Cannot type CONFIRM to emulator, restart game...", $COLOR_RED)
		CloseCoC(True)
		Wait4Main()
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
			Wait4Main()
			Return False
		EndIf
		If _Sleep(1000) Then Return False
	WEnd
	Click($aButtonVillageConfirmOK[0],$aButtonVillageConfirmOK[1],1,0,"#GACo")
	If _Sleep(500) Then Return False
	Return True
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
	If _Sleep(500) Then Return

	If $iCurActiveAcc = - 1 Then
		$iDoPerformAfterSwitch = True
	Else
		If $iDoPerformAfterSwitch Then
			For $i = 0 To UBound($aSwitchList) - 1
				If $aSwitchList[$i][4] = $iCurActiveAcc Then
					If $aSwitchList[$i][2] <> 1 Then
						If $g_bIsFullArmywithHeroesAndSpells Or $ichkForcePreTrainB4Switch Then ;If $g_bIsFullArmywithHeroesAndSpells = True mean just back from attack, then we check train before switch acc.
							SetLog("Check train before switch account...",$COLOR_ACTION)
							If $ichkCustomTrain = 1 Then
								CustomTrain($ichkForcePreTrainB4Switch = 1)
							Else
								TrainRevamp()
							EndIf
							If $bAvoidSwitch Then
								SetLog("Avoid switch, troops getting ready or soon.", $COLOR_INFO)
								Return
							EndIf
						EndIf
					EndIf
				EndIf
			Next
		EndIf
	EndIf

	If $iDoPerformAfterSwitch = False Then Return

	$iNextAcc = getNextSwitchList()

	If $iSamM0dDebug Then SetLog("$iCurActiveAcc: " & $iCurActiveAcc)
	If $iSamM0dDebug Then SetLog("$iNextAcc: " & $iNextAcc)

	If $iCurActiveAcc <> $iNextAcc Then
		If _Sleep(500) Then Return

		If $iCurActiveAcc <> - 1 Then
			;SetLog("Do train army and brew spell",$COLOR_ACTION)
			SetLog("Switch account from " & $icmbWithProfile[$iCurActiveAcc] & " to " & $icmbWithProfile[$iNextAcc] ,$COLOR_ACTION)
			saveCurStats($iCurActiveAcc)
		Else
			SetLog("Switch account start from " & $icmbWithProfile[$iNextAcc] ,$COLOR_ACTION)
		EndIf

		If _Sleep(500) Then Return

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
					$g_bRestart = True
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
					$g_bRestart = True
					$iSelectAccError += 1
					If $iSelectAccError > 2 Then
						$iSelectAccError = 0
						DoVillageLoadFailed()
					EndIf
				EndIf
			Else
				SetLog("Cannot find setting button.",$COLOR_RED)
				CloseCoC(True)
				Wait4Main()
				$g_bRestart = True
			EndIf
		EndIf
	EndIf

	;GUICtrlSetData($g_hLblActiveAcc,"Current Active Acc: " & $iCurActiveAcc + 1)
	GUICtrlSetData($grpMySwitch,"Current Active Acc: " & @CRLF & $aSwitchList[$iCurStep][4] + 1 & " - " & $aSwitchList[$iCurStep][3] & " [" & ($aSwitchList[$iCurStep][2] = 1 ? "D" : "A") &  "]")
	If $iCurActiveAcc <> - 1 Then
		GUICtrlSetData($g_hLblProfileName,$icmbWithProfile[$iCurActiveAcc])
	Else
		$bChangeNextAcc = True
	EndIf

	If $g_bCloseWhileTrainingEnable Then
		SetLog("Disable smart wait")
		$g_bCloseWhileTrainingEnable = False
	EndIf

	ClickP($aAway,1,0)
	If _Sleep(500) Then Return
EndFunc

Func DoVillageLoadSucess($iAcc)
	If $iSamM0dDebug Then SetLog("DoVillageLoadSucess: " & $icmbWithProfile[$iAcc])
	For $i = 0 To UBound($aSwitchList) - 1
		If $aSwitchList[$i][4] = $iAcc Then
			$iCurStep = $i
			$aSwitchList[$i][1] = TimerInit()
		EndIf
	Next

	setCombolistByText($g_hCmbProfile, $icmbWithProfile[$iAcc])

	SetLog("Prepare to load profile: " & GUICtrlRead($g_hCmbProfile),$COLOR_ACTION)
	cmbProfile()
	If $iSamM0dDebug Then SetLog("$iAcc: " & $iAcc)
	loadCurStats($iAcc)

	; after load new profile, reset variable below for new runbot() loop
	$g_bRestart = False
	$bDonateAwayFlag = False
	$bJustMakeDonate = False
	$tempDisableBrewSpell = False
	$tempDisableTrain = False
	$iDonatedUnit = 0
	$g_bFullArmy = False
	$FullCCTroops = False
	$g_bFullArmyHero = False
	$g_bFullArmySpells = False
	$g_bIsClientSyncError = False
	$g_bIsSearchLimit = False
	$g_bQuickattack = False
	$g_asShieldStatus[0] = ""
	$g_asShieldStatus[1] = ""
	$g_asShieldStatus[2] = ""
	$g_sPBStartTime = ""
	;$iShouldRearm = (Random(0,1,1) = 0 ? 1 : 0)

	$g_abNotNeedAllTime[0] = (Random(0,1,1) = 0 ? 1 : 0) ; check rearm
	$g_abNotNeedAllTime[1] = (Random(0,1,1) = 0 ? 1 : 0) ; check tomb

	$g_iCommandStop = -1
	$iSelectAccError = 0

	If _Sleep(1000) Then Return
	checkMainScreen(True)

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
			$g_bRestart = True
		EndIf
	EndIf
EndFunc

Func DoVillageLoadFailed()
	; Reboot Android
	SetLog("Restart emulator since cannot change account more than 2 times.",$COLOR_RED)
	Local $_NoFocusTampering = $g_bNoFocusTampering
	$g_bNoFocusTampering = True
	RebootAndroid()
	$g_bNoFocusTampering = $_NoFocusTampering
EndFunc

Func DoCheckSwitchEnable()
	; auto enable switch account if current profile are tick as enable switch profile
	$ichkEnableMySwitch = 0

	For $i = 0 To UBound($aSwitchList) - 1
		If $aSwitchList[$i][3] = $g_sProfileCurrentName Then
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


Func saveCurStats($iSlot)
	For $i = 0 To 43
		$aProfileStats[$i][$iSlot+1] = Eval($aProfileStats[$i][0])
	Next
EndFunc

Func loadCurStats($iSlot)
	Local $aTemp[4] = [0,0,"",0]
	Local $aTempB[6] = [0,0,0,0,0,0]
	For $i = 0 To 30
		If $i <> 25 Then
			Assign($aProfileStats[$i][0],$aProfileStats[$i][$iSlot+1])
		EndIf
	Next

	If Not IsArray($aProfileStats[31][$iSlot+1]) Then
		$g_aiCurrentLoot = $aTemp
	Else
		$g_aiCurrentLoot = ($aProfileStats[31][$iSlot+1])
	EndIf

	If Not IsArray($aProfileStats[32][$iSlot+1]) Then
		$g_iStatsStartedWith = $aTemp
		$g_iStatsTotalGain = $aTemp
		$g_iStatsLastAttack = $aTemp
		$g_iStatsBonusLast = $aTemp
	Else
		$g_iStatsStartedWith = $aProfileStats[32][$iSlot+1]
		$g_iStatsTotalGain = $aProfileStats[33][$iSlot+1]
		$g_iStatsLastAttack = $aProfileStats[34][$iSlot+1]
		$g_iStatsBonusLast = $aProfileStats[35][$iSlot+1]
	EndIf

	If Not IsArray($aProfileStats[36][$iSlot+1]) Then
		$g_aiAttackedVillageCount = $aTempB
		$g_aiTotalGoldGain = $aTempB
		$g_aiTotalElixirGain = $aTempB
		$g_aiTotalDarkGain = $aTempB
		$g_aiTotalTrophyGain = $aTempB
		$g_aiNbrOfDetectedMines = $aTempB
		$g_aiNbrOfDetectedCollectors = $aTempB
		$g_aiNbrOfDetectedDrills = $aTempB
	Else
		$g_aiAttackedVillageCount = ($aProfileStats[36][$iSlot+1])
		$g_aiTotalGoldGain = $aProfileStats[37][$iSlot+1]
		$g_aiTotalElixirGain = $aProfileStats[38][$iSlot+1]
		$g_aiTotalDarkGain = $aProfileStats[39][$iSlot+1]
		$g_aiTotalTrophyGain = $aProfileStats[40][$iSlot+1]
		$g_aiNbrOfDetectedMines = $aProfileStats[41][$iSlot+1]
		$g_aiNbrOfDetectedCollectors = $aProfileStats[42][$iSlot+1]
		$g_aiNbrOfDetectedDrills = $aProfileStats[43][$iSlot+1]
	EndIf

	If $aProfileStats[25][$iSlot+1] = 0 And $g_iTownHallLevel > 0 Then $aProfileStats[25][$iSlot+1] = $g_iTownHallLevel

	displayStats($iSlot)
EndFunc

Func resetCurStats($iSlot)
;~ 	Local $aTemp[4] = [0,0,"",0]
;~ 	Local $aTempB[6] = [0,0,0,0,0,0]
	For $i = 0 To 43
		$aProfileStats[$i][$iSlot+1] = 0
	Next
;~ 	For $i = 31 To 35
;~ 		$aProfileStats[$i][$iSlot+1] = $aTemp
;~ 	Next
;~ 	For $i = 36 To 43
;~ 		$aProfileStats[$i][$iSlot+1] = $aTempB
;~ 	Next
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
		GUICtrlSetData($g_hLblProfileName,$aSwitchList[$iCurStep][3])
		GUICtrlSetData($g_hGrpVillage, GetTranslatedFileIni("MBR GUI Design Bottom", "GrpVillage", "Village") & ": " & $aSwitchList[$iCurStep][3])
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
		GUICtrlSetData($g_hLblProfileName,$aSwitchList[$iCurStep][3])
		GUICtrlSetData($g_hGrpVillage, GetTranslatedFileIni("MBR GUI Design Bottom", "GrpVillage", "Village") & ": " & $aSwitchList[$iCurStep][3])
		GUICtrlSetState($arrowright2,$GUI_ENABLE + $GUI_SHOW)
	EndIf
EndFunc

Func displayStats($iSlot)

	If $g_iFirstRun = 1 Then Return

	If $aProfileStats[0][$iSlot+1] > 0 Then
		;GUICtrlSetState($g_hLblLastAttackTemp, $GUI_HIDE)
		;GUICtrlSetState($g_hLblLastAttackBonusTemp, $GUI_HIDE)
		;GUICtrlSetState($g_hLblTotalLootTemp, $GUI_HIDE)
		;GUICtrlSetState($g_hLblHourlyStatsTemp, $GUI_HIDE)
		$aProfileStats[0][$iSlot+1] = 2
	Else
		;GUICtrlSetState($g_hLblLastAttackTemp, $GUI_SHOW)
		;GUICtrlSetState($g_hLblLastAttackBonusTemp, $GUI_SHOW)
		;GUICtrlSetState($g_hLblTotalLootTemp, $GUI_SHOW)
		;GUICtrlSetState($g_hLblHourlyStatsTemp, $GUI_SHOW)

		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootGold], "")
		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootElixir], "")
		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootDarkElixir], "")
		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootTrophy], "")

		GUICtrlSetData($g_hLblResultGoldHourNow, "") ;GUI BOTTOM
		GUICtrlSetData($g_hLblResultElixirHourNow, "");GUI BOTTOM
		GUICtrlSetData($g_hLblResultDEHourNow, "") ;GUI BOTTOM

		GUICtrlSetData($g_ahLblStatsTotalGain[$eLootGold], "")
		GUICtrlSetData($g_ahLblStatsTotalGain[$eLootElixir], "")
		GUICtrlSetData($g_ahLblStatsTotalGain[$eLootDarkElixir], "")
		GUICtrlSetData($g_ahLblStatsTotalGain[$eLootTrophy], "")

		GUICtrlSetData($g_ahLblStatsLastAttack[$eLootGold], "")
		GUICtrlSetData($g_ahLblStatsLastAttack[$eLootElixir], "")
		GUICtrlSetData($g_ahLblStatsLastAttack[$eLootDarkElixir], "")
		GUICtrlSetData($g_ahLblStatsLastAttack[$eLootTrophy], "")

		GUICtrlSetData($g_ahLblStatsBonusLast[$eLootGold], "")
		GUICtrlSetData($g_ahLblStatsBonusLast[$eLootElixir], "")
		GUICtrlSetData($g_ahLblStatsBonusLast[$eLootDarkElixir], "")
	EndIf

	If IsArray($aProfileStats[32][$iSlot+1]) Then
		Local $tempProf = $aProfileStats[32][$iSlot+1]
		If $tempProf[2] <> "" Then
			If GUICtrlGetState($g_hLblResultDENow) = $GUI_ENABLE + $GUI_HIDE Then
				GUICtrlSetState($g_hPicResultDENow, $GUI_SHOW)
				If GUICtrlGetState($g_hLblResultGoldNow) = $GUI_ENABLE + $GUI_SHOW Then
					GUICtrlSetState($g_hLblResultDeNow, $GUI_SHOW)
					GUICtrlSetState($g_hLblResultDEHourNow, $GUI_HIDE)
				Else
					GUICtrlSetState($g_hLblResultDeNow, $GUI_HIDE)
					GUICtrlSetState($g_hLblResultDEHourNow, $GUI_SHOW)
				EndIf
			EndIf
		Else
			If GUICtrlGetState($g_hLblResultDENow) = $GUI_ENABLE + $GUI_SHOW Then
				GUICtrlSetState($g_hLblResultDeNow, $GUI_HIDE)
				GUICtrlSetState($g_hPicResultDENow, $GUI_HIDE)
				GUICtrlSetState($g_hLblResultDEHourNow, $GUI_HIDE)
			EndIf
		EndIf
	Else
		If GUICtrlGetState($g_hLblResultDENow) = $GUI_ENABLE + $GUI_SHOW Then
			GUICtrlSetState($g_hLblResultDeNow, $GUI_HIDE)
			GUICtrlSetState($g_hPicResultDENow, $GUI_HIDE)
			GUICtrlSetState($g_hLblResultDEHourNow, $GUI_HIDE)
		EndIf
	EndIf

	Local $aTemp[4] = [0,0,0,0]
	Local $tempStatsTotalGain
	Local $tempStats

	If Not IsArray($aProfileStats[32][$iSlot+1]) Then
		$tempStats = $aTemp
	Else
		$tempStats = $aProfileStats[32][$iSlot+1]
	EndIf
;~ 	SetLog("$tempStats[$eLootGold]: " & $tempStats[$eLootGold])
;~ 	SetLog("$tempStats[$eLootElixir]: " & $tempStats[$eLootElixir])
;~ 	SetLog("$tempStats[$eLootDarkElixir]: " & $tempStats[$eLootDarkElixir])
;~ 	SetLog("$tempStats[$eLootTrophy]: " & $tempStats[$eLootTrophy])

 	GUICtrlSetData($g_ahLblStatsStartedWith[$eLootGold], _NumberFormat($tempStats[$eLootGold], True))
 	GUICtrlSetData($g_ahLblStatsStartedWith[$eLootElixir], _NumberFormat($tempStats[$eLootElixir], True))
 	GUICtrlSetData($g_ahLblStatsStartedWith[$eLootDarkElixir], _NumberFormat($tempStats[$eLootDarkElixir], True))
 	GUICtrlSetData($g_ahLblStatsStartedWith[$eLootTrophy], _NumberFormat($tempStats[$eLootTrophy], True))

	If Not IsArray($aProfileStats[33][$iSlot+1]) Then
		$tempStats = $aTemp
	Else
		$tempStats = $aProfileStats[33][$iSlot+1]
	EndIf
	$tempStatsTotalGain = $tempStats
 	GUICtrlSetData($g_ahLblStatsTotalGain[$eLootGold], _NumberFormat($tempStats[0], True))
 	GUICtrlSetData($g_ahLblStatsTotalGain[$eLootElixir], _NumberFormat($tempStats[1], True))
 	GUICtrlSetData($g_ahLblStatsTotalGain[$eLootDarkElixir], _NumberFormat($tempStats[2], True))
 	GUICtrlSetData($g_ahLblStatsTotalGain[$eLootTrophy], _NumberFormat($tempStats[3], True))

	If Not IsArray($aProfileStats[34][$iSlot+1]) Then
		$tempStats = $aTemp
	Else
		$tempStats = $aProfileStats[34][$iSlot+1]
	EndIf
 	GUICtrlSetData($g_ahLblStatsLastAttack[$eLootGold], _NumberFormat($tempStats[0], True))
 	GUICtrlSetData($g_ahLblStatsLastAttack[$eLootElixir], _NumberFormat($tempStats[1], True))
 	GUICtrlSetData($g_ahLblStatsLastAttack[$eLootDarkElixir], _NumberFormat($tempStats[2], True))
 	GUICtrlSetData($g_ahLblStatsLastAttack[$eLootTrophy], _NumberFormat($tempStats[3], True))

	If Not IsArray($aProfileStats[35][$iSlot+1]) Then
		$tempStats = $aTemp
	Else
		$tempStats = $aProfileStats[35][$iSlot+1]
	EndIf
 	GUICtrlSetData($g_ahLblStatsBonusLast[$eLootGold], _NumberFormat($tempStats[0], True))
 	GUICtrlSetData($g_ahLblStatsBonusLast[$eLootElixir], _NumberFormat($tempStats[1], True))
 	GUICtrlSetData($g_ahLblStatsBonusLast[$eLootDarkElixir], _NumberFormat($tempStats[2], True))

	GUICtrlSetData($g_hLblresultvillagesskipped, _NumberFormat($aProfileStats[1][$iSlot+1], True))
	GUICtrlSetData($g_hLblResultSkippedHourNow, _NumberFormat($aProfileStats[1][$iSlot+1], True))
	GUICtrlSetData($g_hLblresulttrophiesdropped, _NumberFormat($aProfileStats[2][$iSlot+1], True))

	GUICtrlSetData($g_hLblWallUpgCostGold, _NumberFormat($aProfileStats[3][$iSlot+1], True))
	GUICtrlSetData($g_hLblWallUpgCostElixir, _NumberFormat($aProfileStats[4][$iSlot+1], True))
	GUICtrlSetData($g_hLblBuildingUpgCostGold, _NumberFormat($aProfileStats[5][$iSlot+1], True))
	GUICtrlSetData($g_hLblBuildingUpgCostElixir, _NumberFormat($aProfileStats[6][$iSlot+1], True))
	GUICtrlSetData($g_hLblHeroUpgCost, _NumberFormat($aProfileStats[7][$iSlot+1], True))
	GUICtrlSetData($g_hLblWallgoldmake, $aProfileStats[8][$iSlot+1])
	GUICtrlSetData($g_hLblWallelixirmake, $aProfileStats[9][$iSlot+1])
	GUICtrlSetData($g_hLblNbrOfBuildingUpgGold, $aProfileStats[10][$iSlot+1])
	GUICtrlSetData($g_hLblNbrOfBuildingUpgElixir, $aProfileStats[11][$iSlot+1])
	GUICtrlSetData($g_hLblNbrOfHeroUpg, $aProfileStats[12][$iSlot+1])
	GUICtrlSetData($g_hLblSearchCost, _NumberFormat($aProfileStats[13][$iSlot+1], True))
	GUICtrlSetData($g_hLblTrainCostElixir, _NumberFormat($aProfileStats[14][$iSlot+1], True))
	GUICtrlSetData($g_hLblTrainCostDElixir, _NumberFormat($aProfileStats[15][$iSlot+1], True))
	GUICtrlSetData($g_hLblNbrOfOoS, $aProfileStats[16][$iSlot+1])
	GUICtrlSetData($g_hLblNbrOfTSFailed, $aProfileStats[17][$iSlot+1])
	GUICtrlSetData($g_hLblNbrOfTSSuccess, $aProfileStats[18][$iSlot+1])
	GUICtrlSetData($g_hLblGoldFromMines, _NumberFormat($aProfileStats[19][$iSlot+1], True))
	GUICtrlSetData($g_hLblElixirFromCollectors, _NumberFormat($aProfileStats[20][$iSlot+1], True))
	GUICtrlSetData($g_hLblDElixirFromDrills, _NumberFormat($aProfileStats[21][$iSlot+1], True))
	GUICtrlSetData($g_hLblResultBuilderNow, $aProfileStats[22][$iSlot+1] & "/" & $aProfileStats[23][$iSlot+1])
	GUICtrlSetData($g_hLblResultGemNow, _NumberFormat($aProfileStats[24][$iSlot+1], True))

;~ 	GUICtrlSetData($g_hLblresultvillagesskipped, _NumberFormat($aProfileStats[16][$iSlot+1], True))
;~ 	GUICtrlSetData($g_hLblResultSkippedHourNow, _NumberFormat($aProfileStats[16][$iSlot+1], True))
;~ 	GUICtrlSetData($g_hLblresulttrophiesdropped, _NumberFormat($aProfileStats[17][$iSlot+1], True))
;~ 	GUICtrlSetData($g_hLblNbrOfHeroUpg, $aProfileStats[27][$iSlot+1])


	Local $aTemp[4] = [0,0,0,0]

	Local $tempCurrentLoot[$eLootCount]

	Local $tempAttackedVillageCount[$g_iModeCount+1]
	Local $tempTotalGoldGain[$g_iModeCount+1]
	Local $tempTotalElixirGain[$g_iModeCount+1]
	Local $tempTotalDarkGain[$g_iModeCount+1]
	Local $tempTotalTrophyGain[$g_iModeCount+1]

	Local $tempNbrOfDetectedMines[$g_iModeCount+1]
	Local $tempNbrOfDetectedCollectors[$g_iModeCount+1]
	Local $tempNbrOfDetectedDrills[$g_iModeCount+1]

	If Not IsArray($aProfileStats[31][$iSlot+1]) Then
		$tempCurrentLoot = $aTemp
	Else
		$tempCurrentLoot = $aProfileStats[31][$iSlot+1]
	EndIf

	GUICtrlSetData($g_hLblResultGoldNow, _NumberFormat($tempCurrentLoot[$eLootGold], True))
	GUICtrlSetData($g_hLblResultElixirNow, _NumberFormat($tempCurrentLoot[$eLootElixir], True))
	GUICtrlSetData($g_hLblResultDeNow, _NumberFormat($tempCurrentLoot[$eLootDarkElixir], True))
	GUICtrlSetData($g_hLblResultTrophyNow, _NumberFormat($tempCurrentLoot[$eLootTrophy], True))

	If Not IsArray($aProfileStats[36][$iSlot+1]) Then
		$tempAttackedVillageCount = $aTemp
		$tempTotalGoldGain = $aTemp
		$tempTotalElixirGain = $aTemp
		$tempTotalDarkGain = $aTemp
		$tempTotalTrophyGain = $aTemp
		$tempNbrOfDetectedMines = $aTemp
		$tempNbrOfDetectedCollectors = $aTemp
		$tempNbrOfDetectedDrills = $aTemp
	Else
		$tempAttackedVillageCount = $aProfileStats[36][$iSlot+1]
		$tempTotalGoldGain = $aProfileStats[37][$iSlot+1]
		$tempTotalElixirGain = $aProfileStats[38][$iSlot+1]
		$tempTotalDarkGain = $aProfileStats[39][$iSlot+1]
		$tempTotalTrophyGain = $aProfileStats[40][$iSlot+1]
		$tempNbrOfDetectedMines = $aProfileStats[41][$iSlot+1]
		$tempNbrOfDetectedCollectors = $aProfileStats[42][$iSlot+1]
		$tempNbrOfDetectedDrills = $aProfileStats[43][$iSlot+1]
	EndIf

	Local $iAttackedCount = 0

	For $i = 0 To $g_iModeCount
		GUICtrlSetData($g_hLblAttacked[$i], _NumberFormat($tempAttackedVillageCount[$i], True))
		$iAttackedCount += $tempAttackedVillageCount[$i]

		GUICtrlSetData($g_hLblTotalGoldGain[$i], _NumberFormat($tempTotalGoldGain[$i], True))
		GUICtrlSetData($g_hLblTotalElixirGain[$i], _NumberFormat($tempTotalElixirGain[$i], True))

		GUICtrlSetData($g_hLblTotalDElixirGain[$i], _NumberFormat($tempTotalDarkGain[$i], True))
		GUICtrlSetData($g_hLblTotalTrophyGain[$i], _NumberFormat($tempTotalTrophyGain[$i], True))
	Next

	GUICtrlSetData($g_hLblresultvillagesattacked, _NumberFormat($iAttackedCount, True))
	GUICtrlSetData($g_hLblResultAttackedHourNow, _NumberFormat($iAttackedCount, True))

	For $i = 0 To $g_iModeCount
		If $i = $TS Then ContinueLoop
		GUICtrlSetData($g_hLblNbrOfDetectedMines[$i], $tempNbrOfDetectedMines[$i])
		GUICtrlSetData($g_hLblNbrOfDetectedCollectors[$i], $tempNbrOfDetectedCollectors[$i])
		GUICtrlSetData($g_hLblNbrOfDetectedDrills[$i], $tempNbrOfDetectedDrills[$i])
	Next

	If $aProfileStats[0][$iSlot+1] = 2 Then

		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootGold], _NumberFormat(Round($tempStatsTotalGain[$eLootGold] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h")
		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootElixir], _NumberFormat(Round($tempStatsTotalGain[$eLootElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h")
		If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
			GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootDarkElixir], _NumberFormat(Round($tempStatsTotalGain[$eLootDarkElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h")
		EndIf
		GUICtrlSetData($g_ahLblStatsGainPerHour[$eLootTrophy], _NumberFormat(Round($tempStatsTotalGain[$eLootTrophy] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h")

		GUICtrlSetData($g_hLblResultGoldHourNow, _NumberFormat(Round($tempStatsTotalGain[$eLootGold] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h") ;GUI BOTTOM
		GUICtrlSetData($g_hLblResultElixirHourNow, _NumberFormat(Round($tempStatsTotalGain[$eLootElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600)) & "k / h") ;GUI BOTTOM
		If $g_iStatsStartedWith[$eLootDarkElixir] <> "" Then
			GUICtrlSetData($g_hLblResultDEHourNow, _NumberFormat(Round($tempStatsTotalGain[$eLootDarkElixir] / (Int(__TimerDiff($g_hTimerSinceStarted) + $g_iTimePassed)) * 3600 * 1000)) & " / h") ;GUI BOTTOM
		EndIf
	EndIf

;~    ; SmartZap DE Gain - From ChaCalGyn(LunaEclipse) - DEMEN
	GUICtrlSetData($lblMySmartZap, _NumberFormat($aProfileStats[28][$iSlot+1], True))
	GUICtrlSetData($g_hLblSmartZap, _NumberFormat($aProfileStats[28][$iSlot+1], True))

;~ 	; SmartZap Spells Used  From ChaCalGyn(LunaEclipse) - DEMEN
	GUICtrlSetData($lblMyLightningUsed, _NumberFormat($aProfileStats[30][$iSlot+1], True))
	GUICtrlSetData($g_hLblSmartLightningUsed, _NumberFormat($aProfileStats[30][$iSlot+1], True))
	GUICtrlSetData($g_hLblSmartEarthQuakeUsed, _NumberFormat($aProfileStats[29][$iSlot+1], True))

	_GUI_Value_STATE("HIDE",$g_aGroupListTHLevels)
	If $aProfileStats[25][$iSlot+1] >= 4 And $aProfileStats[25][$iSlot+1] <= 11 Then
		GUICtrlSetState($g_ahPicTHLevels[$aProfileStats[25][$iSlot+1]], $GUI_SHOW)
	EndIf
	GUICtrlSetData($g_hLblTHLevels, $aProfileStats[25][$iSlot+1])

	GUICtrlSetData($g_hLblLeague, "")
	If $aProfileStats[27][$iSlot+1] = 1 Then
		GUICtrlSetData($g_hLblLeague, "1")
	ElseIf $aProfileStats[27][$iSlot+1] = 2 Then
		GUICtrlSetData($g_hLblLeague, "2")
	ElseIf $aProfileStats[27][$iSlot+1] = 3 Then
		GUICtrlSetData($g_hLblLeague, "3")
	EndIf

	_GUI_Value_STATE("HIDE",$g_aGroupLeague)

	If String($aProfileStats[26][$iSlot+1]) = "B" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueBronze], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "S" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueSilver], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "G" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueGold], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "c" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueCrystal], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "M" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueMaster], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "C" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueChampion], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "T" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueTitan], $GUI_SHOW)
	ElseIf String($aProfileStats[26][$iSlot+1]) = "LE" Then
		GUICtrlSetState($g_ahPicLeague[$eLeagueLegend], $GUI_SHOW)
	Else
		GUICtrlSetState($g_ahPicLeague[$eLeagueUnranked],$GUI_SHOW)
	EndIf

EndFunc

Func btnMakeSwitchADBFolder()
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor($aButtonClose3[4], $aButtonClose3[5], $g_bNoCapturePixel), Hex($aButtonClose3[6], 6), Number($aButtonClose3[7])) Then
		Local $iSecondBaseTabHeight
		If _ColorCheck(_GetPixelColor(146, 146, $g_bNoCapturePixel), Hex(0XB8B8A8,6), 10) = True Then
			$iSecondBaseTabHeight = 49
		Else
			$iSecondBaseTabHeight = 0
		EndIf

		Local $hClone = _GDIPlus_BitmapCloneArea($g_hBitmap, 70,127 + $iSecondBaseTabHeight, 80,17, $GDIP_PXF24RGB)
		_GDIPlus_ImageSaveToFile($hClone, @ScriptDir & "\profiles\" & $g_sProfileCurrentName & "\village_92.png")

		Local $lResult
		Local $sMyProfilePath4shared_prefs = @ScriptDir & "\profiles\" & $g_sProfileCurrentName & "\shared_prefs"
		; remove old village before new copy
		DirRemove($sMyProfilePath4shared_prefs, 1)

		If $iSamM0dDebug Then SetLog("$g_sEmulatorInfo4MySwitch: " & $g_sEmulatorInfo4MySwitch)

		If StringInStr($g_sEmulatorInfo4MySwitch,"bluestacks") Then
			$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " shell "& Chr(34) & "su -c 'chmod 777 /data/data/" & $g_sAndroidGamePackage & "/shared_prefs; mkdir /sdcard/tempshared; cp /data/data/" & $g_sAndroidGamePackage & _
			"/shared_prefs/* /sdcard/tempshared; exit; exit'" & Chr(34), "", @SW_HIDE)
			If $lResult = 0 Then
				$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " pull /sdcard/tempshared " & Chr(34) & $sMyProfilePath4shared_prefs & Chr(34), "", @SW_HIDE)
				If $lResult = 0 Then
					$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " shell "& Chr(34) & "su -c 'rm -r /sdcard/tempshared; exit; exit'" & Chr(34), "", @SW_HIDE)
				EndIf
			EndIf
		Else
			If $iSamM0dDebug Then SetLog("Command: " & $g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " pull /data/data/" & $g_sAndroidGamePackage & "/shared_prefs " & Chr(34) & $sMyProfilePath4shared_prefs & Chr(34))
			$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " pull /data/data/" & $g_sAndroidGamePackage & "/shared_prefs " & Chr(34) & $sMyProfilePath4shared_prefs & Chr(34), "", @SW_HIDE)
		EndIf

		If @error Then
			MsgBox($MB_SYSTEMMODAL, "", "Failed to run adb command.")
		Else
			If $lResult = 0 Then
				Local $bFileFlag = 0
				Local $bshared_prefs_file = False
				Local $bVillagePng = False
				If FileExists($sMyProfilePath4shared_prefs & "\HSJsonData.xml") Then $bFileFlag = BitOR($bFileFlag, 1)
				If FileExists(@ScriptDir & "\profiles\" & $g_sProfileCurrentName & "\village_92.png") Then $bFileFlag = BitOR($bFileFlag, 2)

				;If FileExists($sMyProfilePath4shared_prefs & "\localPrefs.xml") Then FileDelete($sMyProfilePath4shared_prefs & "\localPrefs.xml")

				Switch $bFileFlag
					Case 3
						MsgBox($MB_SYSTEMMODAL, "", GetTranslatedFileIni("sam m0d", "MySwitch_Capture_Msg1", "Sucess: shared_prefs copied and village_92.png captured."))
					Case 2
						MsgBox($MB_SYSTEMMODAL, "", GetTranslatedFileIni("sam m0d", "MySwitch_Capture_Msg2", "Failed to copy shared_prefs from emulator, but village_92.png captured."))
					Case 1
						MsgBox($MB_SYSTEMMODAL, "", GetTranslatedFileIni("sam m0d", "MySwitch_Capture_Msg3", "Failed to capture village_92.png from emulator, but shared_prefs copied."))
					Case Else
						MsgBox($MB_SYSTEMMODAL, "", GetTranslatedFileIni("sam m0d", "MySwitch_Capture_Msg4", "Failed to copy shared_prefs and capture village_92.png from emulator."))
				EndSwitch
			Else
				MsgBox($MB_SYSTEMMODAL, "", "Failed to run operate adb command.")
			EndIf
		EndIf
	Else
		MsgBox($MB_SYSTEMMODAL, "", GetTranslatedFileIni("sam m0d", "MySwitch_Capture_Shared_Prefs_Error", "Please open emulator and coc, then go to profile page before doing this action."))
	EndIf
EndFunc

Func loadVillageFrom($Profilename, $iSlot)
	PoliteCloseCoC()
	If _Sleep(1500) Then Return False
	Local $lResult
	Local $sMyProfilePath4shared_prefs = @ScriptDir & "\profiles\" & $Profilename & "\shared_prefs"
	Local $hostPath = $g_sAndroidPicturesHostPath & $g_sAndroidPicturesHostFolder & "shared_prefs"
	Local $androidPath = $g_sAndroidPicturesPath & StringReplace($g_sAndroidPicturesHostFolder, "\", "/") & "shared_prefs/"

	;If FileExists($sMyProfilePath4shared_prefs & "\localPrefs.xml") Then FileDelete($sMyProfilePath4shared_prefs & "\localPrefs.xml")

	If StringInStr($g_sEmulatorInfo4MySwitch,"bluestacks") Then
		$lResult = DirCopy($sMyProfilePath4shared_prefs, $hostPath, 1)
		If $lResult = 1 Then
			$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " shell "& Chr(34) & "su -c 'chmod 777 /data/data/" & $g_sAndroidGamePackage & "/shared_prefs; " & _
			"cp -r " & $androidPath & "* /data/data/" & $g_sAndroidGamePackage & "/shared_prefs; exit; exit'" & Chr(34), "", @SW_HIDE)
			DirRemove($hostPath, 1)
		EndIf
	Else
		$lResult = RunWait($g_sAndroidAdbPath & " -s " & $g_sAndroidAdbDevice & " push " & Chr(34) & $sMyProfilePath4shared_prefs & Chr(34) & " /data/data/" & $g_sAndroidGamePackage & "/shared_prefs", "", @SW_HIDE)
	EndIf

	If $lResult = 0 Then
		SetLog("shared_prefs copy to emulator should be okay.", $COLOR_INFO)
		OpenCoC()
		Wait4Main()
		Return True
	EndIf

	Return False
EndFunc

Func checkProfileCorrect()
	If IsMainPage() Then
		Click($aButtonOpenProfile[0],$aButtonOpenProfile[1],1,0,"#0222")
		If _Sleep(1000) Then Return False

		Local $iCount, $iImageNotMatchCount
		Local $bVillagePageFlag = False
		Local $iSecondBaseTabHeight

		; Waiting for profile page fully load.
		ForceCaptureRegion()
		$iCount = 0
		While 1
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(250, 95, $g_bNoCapturePixel), Hex(0XE8E8E0,6), 10) = True And _ColorCheck(_GetPixelColor(360, 145, $g_bNoCapturePixel), Hex(0XE8E8E0,6), 10) = False Then
				ExitLoop
			EndIf
			If _Sleep(250) Then Return False
			$iCount += 1
			If $iCount > 40 Then ExitLoop
		WEnd

		$iCount = 0
		$iImageNotMatchCount = 0

		While 1
			_CaptureRegion()
			If _ColorCheck(_GetPixelColor(146, 146, $g_bNoCapturePixel), Hex(0XB8B8A8,6), 10) = True Then
				$iSecondBaseTabHeight = 49
			Else
				$iSecondBaseTabHeight = 0
			EndIf

			If $iSamM0dDebug = 1 Then SetLog("_GetPixelColor(85, " & 163 + $iSecondBaseTabHeight & ", True): " & _GetPixelColor(85, 163 + $iSecondBaseTabHeight, $g_bNoCapturePixel))
			If $iSamM0dDebug = 1 Then SetLog("_GetPixelColor(20, " & 295 + $iSecondBaseTabHeight & ", True): " & _GetPixelColor(20, 295 + $iSecondBaseTabHeight, $g_bNoCapturePixel))

			$bVillagePageFlag = _ColorCheck(_GetPixelColor(85, 163 + $iSecondBaseTabHeight, $g_bNoCapturePixel), Hex(0X959AB6,6), 20) = True And _ColorCheck(_GetPixelColor(20, 295 + $iSecondBaseTabHeight, $g_bNoCapturePixel), Hex(0X4E4D79,6), 10) = True

			If $bVillagePageFlag = True Then
				_CaptureRegion(68,125 + $iSecondBaseTabHeight,155,146 + $iSecondBaseTabHeight)
				Local $result = DllCall($g_hLibImgLoc, "str", "FindTile", "handle", $g_hHBitmap, "str", @ScriptDir & "\profiles\" & $g_sProfileCurrentName & "\village_92.png", "str", "FV", "int", 1)
				If @error Then _logErrorDLLCall($g_sLibImgLocPath, @error)
				If IsArray($result) Then
					If $iSamM0dDebug Then SetLog("DLL Call succeeded " & $result[0], $COLOR_ERROR)
					If $result[0] = "0" Or $result[0] = "" Then
						If $iSamM0dDebug Then SetLog("Image not found", $COLOR_ERROR)
						$bVillagePageFlag = False
						$iImageNotMatchCount += 1
						If $iImageNotMatchCount > 3 Then
							Return False
						EndIf
					ElseIf StringLeft($result[0], 2) = "-1" Then
						SetLog("DLL Error: " & $result[0], $COLOR_ERROR)
					Else
						If $iSamM0dDebug Then SetLog("$result[0]: " & $result[0])
						Local $aCoor = StringSplit($result[0],"|",$STR_NOCOUNT)
						If IsArray($aCoor) Then
							If StringLeft($aCoor[1], 2) <> "-1" Then
								ExitLoop
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				ClickDrag(380, 140 + $g_iMidOffsetY + $iSecondBaseTabHeight, 380, 580 + $g_iMidOffsetY, 500)
			EndIf
			$iCount += 1
			If $iCount > 15 Then
				SetLog("Cannot load profile page...", $COLOR_RED)
				ClickP($aAway,1,0)
				Return False
			EndIf
			If _Sleep(100) Then Return False
		WEnd

		ClickP($aAway,1,0)
		If _Sleep(1000) Then Return True
		Return True
	EndIf
	Return False
EndFunc

Func Wait4Main()
	Local $iCount

	For $i = 0 To 105 ;105*2000 = 3.5 Minutes
		$iCount += 1
		If $iSamM0dDebug Then
			Setlog("ChkObstl Loop = " & $i & "   ExitLoop = " & $iCount, $COLOR_DEBUG) ; Debug stuck loop
		EndIf
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor($aButtonOpenShieldInfo[4], $aButtonOpenShieldInfo[5], $g_bNoCapturePixel), Hex($aButtonOpenShieldInfo[6], 6), Number($aButtonOpenShieldInfo[7])) Then ;Checks for Main Screen
			If $iSamM0dDebug Then Setlog("Screen cleared, WaitMainScreen exit", $COLOR_DEBUG)
			ExitLoop
		Else
			If TestCapture() = False And _Sleep($DELAYWAITMAINSCREEN1) Then Return
			If _ColorCheck(_GetPixelColor(402, 516, $g_bNoCapturePixel), Hex(0xFFFFFF, 6), 5) And _ColorCheck(_GetPixelColor(405, 537, $g_bNoCapturePixel), Hex(0x5EAC10, 6), 20) Then
				Click($aButtonVillageWasAttackOK[0],$aButtonVillageWasAttackOK[1],1,0,"#VWAO")
				If _Sleep(1000) Then Return True
				;Return True ;  village was attacked okay button
			EndIf
			checkObstacles() ;See if there is anything in the way of mainscreen
		EndIf
		If ($i > 105) Or ($iCount > 120) Then ExitLoop ; If CheckObstacles forces reset, limit total time to 4 minutes
	Next
EndFunc
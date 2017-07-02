
Func chkMyTroopOrder()

	Local $tempOrder[19]
	Local $tempSwap
	Local $tempSwapTo
	Local $TotalCapacity = 0
	For $i = 0 To 18
		$tempOrder[$i] = GUICtrlRead(Eval("cmbMy" & $MyTroops[$i][0] & "Order"))
	Next
	For $i = 0 To 18
		If $tempOrder[$i] <> $MyTroops[$i][1] Then
			For $j = 0 To 18
				If $MyTroops[$j][1] = $tempOrder[$i] Then
					$tempOrder[$j] = Number($MyTroops[$i][1])
					ExitLoop
				EndIf
			Next
			ExitLoop
		EndIf
	Next
	For $i = 0 To 18
		$MyTroops[$i][1] = Number($tempOrder[$i])
		_GUICtrlComboBox_SetCurSel(Eval("cmbMy" & $MyTroops[$i][0] & "Order"), $MyTroops[$i][1]-1)
		$TotalCapacity += GUICtrlRead(Eval("txtMy" & $MyTroops[$i][0])) * $MyTroops[$i][2]
	Next

	If GUICtrlRead($chkMyTroopsOrder) = $GUI_CHECKED Then
		$ichkMyTroopsOrder = 1
	Else
		$ichkMyTroopsOrder = 0
	EndIf
	$fulltroop = Int(GUICtrlRead($txtFullTroop))
	GUICtrlSetData($lblTotalCapacityOfMyTroops,GetTranslated(671, 76, "Total") & ": " & $TotalCapacity & "/" & Int(($TotalCamp * $fulltroop) / 100))
	If $TotalCapacity > (($TotalCamp * $fulltroop) / 100) Then
		GUICtrlSetColor($lblTotalCapacityOfMyTroops,$COLOR_RED)
		GUICtrlSetData($idProgressbar,100)
		_SendMessage(GUICtrlGetHandle($idProgressbar), $PBM_SETSTATE, 2) ; red
	Else
		GUICtrlSetColor($lblTotalCapacityOfMyTroops,$COLOR_BLACK)
		GUICtrlSetData($idProgressbar, Int(($TotalCapacity / (($TotalCamp * $fulltroop) / 100)) * 100))
		_SendMessage(GUICtrlGetHandle($idProgressbar), $PBM_SETSTATE, 1) ; green
	EndIf
EndFunc

Func chkDisablePretrainTroops()
	If GUICtrlRead($chkDisablePretrainTroops) = $GUI_CHECKED Then
		$ichkDisablePretrainTroops = 1
	Else
		$ichkDisablePretrainTroops = 0
	EndIf
EndFunc

Func chkCustomTrain()
	If GUICtrlRead($chkCustomTrain) = $GUI_CHECKED Then
		$ichkCustomTrain = 1
	Else
		$ichkCustomTrain = 0
	EndIf
EndFunc

Func cmbTroopSetting()
	For $i = 0 To UBound($MyTroops) - 1
		IniWriteS($config, "MyTroops", $MyTroops[$i][0] & $icmbTroopSetting, GUICtrlRead(Eval("txtMy" & $MyTroops[$i][0])))
		IniWriteS($config, "MyTroops", $MyTroops[$i][0] & "Order" & $icmbTroopSetting, GUICtrlRead(Eval("cmbMy"& $MyTroops[$i][0] & "Order")))
	Next

	$icmbTroopSetting = _GUICtrlComboBox_GetCurSel($cmbTroopSetting)

	$ichkMyTroopsOrder = IniRead($config, "MyTroops", "Order" & $icmbTroopSetting, "0")
	For $i = 0 To UBound($MyTroops) - 1
		$MyTroops[$i][3] =  IniRead($config, "MyTroops", $MyTroops[$i][0] & $icmbTroopSetting, "0")
		$MyTroops[$i][1] =  Number(IniRead($config, "MyTroops", $MyTroops[$i][0] & "Order" & $icmbTroopSetting, $i + 1))
	Next

	For $i = 0 To UBound($MyTroops)-1
		GUICtrlSetData(Eval("txtMy" & $MyTroops[$i][0]), $MyTroops[$i][3])
		_GUICtrlComboBox_SetCurSel(Eval("cmbMy" & $MyTroops[$i][0] & "Order"), $MyTroops[$i][1]-1)
	Next

	chkMyTroopOrder()
EndFunc

Func cmbMyQuickTrain()
	$icmbMyQuickTrain = _GUICtrlComboBox_GetCurSel($cmbMyQuickTrain)
EndFunc

Func btnResetTroops()
	For $i = 0 To 18
		GUICtrlSetData(Eval("txtMy" & $MyTroops[$i][0]),"0")
		$MyTroops[$i][3] = 0
	Next
	chkMyTroopOrder()
EndFunc

Func btnResetOrder()
	For $i = 0 To 18
		_GUICtrlComboBox_SetCurSel(Eval("cmbMy" & $MyTroops[$i][0] & "Order"), $i)
		$MyTroops[$i][1] = $i + 1
	Next
	chkMyTroopOrder()
EndFunc

Func chkWait4CC()
	If GUICtrlRead($chkWait4CC) = $GUI_CHECKED Then
		$ichkWait4CC = 1
		GUICtrlSetState($txtCCStrength, $GUI_ENABLE)
	Else
		$ichkWait4CC = 0
		GUICtrlSetState($txtCCStrength, $GUI_DISABLE)
	EndIf
	$CCStrength = GUICtrlRead($txtCCStrength)
EndFunc

Func chkUnitFactor()
	If GUICtrlRead($chkUnitFactor) = $GUI_CHECKED Then
		$ichkUnitFactor = 1
		GUICtrlSetState($txtUnitFactor, $GUI_ENABLE)
	Else
		$ichkUnitFactor = 0
		GUICtrlSetState($txtUnitFactor, $GUI_DISABLE)
	EndIf
	$itxtUnitFactor = GUICtrlRead($txtUnitFactor)
EndFunc

Func chkWaveFactor()
	If GUICtrlRead($chkWaveFactor) = $GUI_CHECKED Then
		$ichkWaveFactor = 1
		GUICtrlSetState($txtWaveFactor, $GUI_ENABLE)
	Else
		$ichkWaveFactor = 0
		GUICtrlSetState($txtWaveFactor, $GUI_DISABLE)
	EndIf
	$itxtWaveFactor = GUICtrlRead($txtWaveFactor)
EndFunc

Func chkEnableDeleteExcessTroops()
	If GUICtrlRead($chkEnableDeleteExcessTroops) = $GUI_CHECKED Then
		$ichkEnableDeleteExcessTroops = 1
	Else
		$ichkEnableDeleteExcessTroops = 0
	EndIf
EndFunc


Func chkAutoDock()
	If GUICtrlRead($chkAutoDock) = $GUI_CHECKED Then
		$ichkAutoDock = 1
	Else
		$ichkAutoDock = 0
	EndIf
EndFunc

Func lblMyTotalCountSpell()
	_GUI_Value_STATE("HIDE", $groupListMySpells)
	; calculate $iTotalTrainSpaceSpell value
	$iMyTotalTrainSpaceSpell = (GUICtrlRead($txtNumLightningSpell) * 2) + (GUICtrlRead($txtNumHealSpell) * 2) + (GUICtrlRead($txtNumRageSpell) * 2) + (GUICtrlRead($txtNumJumpSpell) * 2) + _
			(GUICtrlRead($txtNumFreezeSpell) * 2) + (GUICtrlRead($txtNumCloneSpell) * 4) + GUICtrlRead($txtNumPoisonSpell) + GUICtrlRead($txtNumHasteSpell) + GUICtrlRead($txtNumEarthSpell) + GUICtrlRead($txtNumSkeletonSpell)

	If $iMyTotalTrainSpaceSpell < GUICtrlRead($txtTotalCountSpell2) + 1 Then
		GUICtrlSetBkColor($txtNumLightningSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumHealSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumRageSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumJumpSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumFreezeSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumCloneSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumPoisonSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumEarthSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumHasteSpell, $COLOR_MONEYGREEN)
		GUICtrlSetBkColor($txtNumSkeletonSpell, $COLOR_MONEYGREEN)
	Else
		GUICtrlSetBkColor($txtNumLightningSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumHealSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumRageSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumFreezeSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumCloneSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumJumpSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumPoisonSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumEarthSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumHasteSpell, $COLOR_RED)
		GUICtrlSetBkColor($txtNumSkeletonSpell, $COLOR_RED)
	EndIf
	$iTownHallLevel = Int($iTownHallLevel)
	If $iTownHallLevel > 4 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyLightning)
	Else
		GUICtrlSetData($txtNumLightningSpell, 0)
		GUICtrlSetData($txtNumRageSpell, 0)
		GUICtrlSetData($txtNumHealSpell, 0)
		GUICtrlSetData($txtNumJumpSpell, 0)
		GUICtrlSetData($txtNumFreezeSpell, 0)
		GUICtrlSetData($txtNumCloneSpell, 0)
		GUICtrlSetData($txtNumPoisonSpell, 0)
		GUICtrlSetData($txtNumEarthSpell, 0)
		GUICtrlSetData($txtNumHasteSpell, 0)
		GUICtrlSetData($txtNumSkeletonSpell, 0)
		GUICtrlSetData($txtTotalCountSpell, 0)
	EndIf
	If $iTownHallLevel > 5 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyHeal)
	Else
		GUICtrlSetData($txtNumRageSpell, 0)
		GUICtrlSetData($txtNumJumpSpell, 0)
		GUICtrlSetData($txtNumFreezeSpell, 0)
		GUICtrlSetData($txtNumCloneSpell, 0)
		GUICtrlSetData($txtNumPoisonSpell, 0)
		GUICtrlSetData($txtNumEarthSpell, 0)
		GUICtrlSetData($txtNumHasteSpell, 0)
		GUICtrlSetData($txtNumSkeletonSpell, 0)
	EndIf
	If $iTownHallLevel > 6 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyRage)
	Else
		GUICtrlSetData($txtNumJumpSpell, 0)
		GUICtrlSetData($txtNumFreezeSpell, 0)
		GUICtrlSetData($txtNumCloneSpell, 0)
		GUICtrlSetData($txtNumPoisonSpell, 0)
		GUICtrlSetData($txtNumEarthSpell, 0)
		GUICtrlSetData($txtNumHasteSpell, 0)
		GUICtrlSetData($txtNumSkeletonSpell, 0)
	EndIf
	If $iTownHallLevel > 7 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyPoison)
		_GUI_Value_STATE("SHOW", $groupMyEarthquake)
	Else
		GUICtrlSetData($txtNumJumpSpell, 0)
		GUICtrlSetData($txtNumFreezeSpell, 0)
		GUICtrlSetData($txtNumCloneSpell, 0)
		GUICtrlSetData($txtNumHasteSpell, 0)
		GUICtrlSetData($txtNumSkeletonSpell, 0)
	EndIf
	If $iTownHallLevel > 8 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyJumpSpell)
		_GUI_Value_STATE("SHOW", $groupMyFreeze)
		_GUI_Value_STATE("SHOW", $groupMyHaste)
		_GUI_Value_STATE("SHOW", $groupMySkeleton)
	Else
		GUICtrlSetData($txtNumCloneSpell, 0)
	EndIf
	If $iTownHallLevel > 9 Or $iTownHallLevel = 0 Then
		_GUI_Value_STATE("SHOW", $groupMyClone)
	EndIf
EndFunc   ;==>lblTotalCountSpell

Func chkCheck4CC()
	If GUICtrlRead($chkCheck4CC) = $GUI_CHECKED Then
		$ichkCheck4CC = 1
		GUICtrlSetState($txtCheck4CCWaitTime, $GUI_ENABLE)
	Else
		$ichkCheck4CC = 0
		GUICtrlSetState($txtCheck4CCWaitTime, $GUI_DISABLE)
	EndIf
	$itxtCheck4CCWaitTime = GUICtrlRead($txtCheck4CCWaitTime)
	If $itxtCheck4CCWaitTime = 0 Then
		$itxtCheck4CCWaitTime = 7
		GUICtrlSetData($txtCheck4CCWaitTime,$itxtCheck4CCWaitTime)
	EndIf
EndFunc

Func txtStickToTrainWindow()
	$itxtStickToTrainWindow = GUICtrlRead($txtStickToTrainWindow)
	If $itxtStickToTrainWindow > 5 Then
		$itxtStickToTrainWindow = 5
		GUICtrlSetData($txtStickToTrainWindow,5)
	EndIf
EndFunc

Func chkIncreaseGlobalDelay()
	If GUICtrlRead($chkIncreaseGlobalDelay) = $GUI_CHECKED Then
		$ichkIncreaseGlobalDelay = 1
		GUICtrlSetState($txtIncreaseGlobalDelay, $GUI_ENABLE)
	Else
		$ichkIncreaseGlobalDelay = 0
		GUICtrlSetState($txtIncreaseGlobalDelay, $GUI_DISABLE)
	EndIf
	$itxtIncreaseGlobalDelay = GUICtrlRead($txtIncreaseGlobalDelay)
EndFunc

;~ Func cmbCoCVersion()
;~ 	Local $iSection = GUICtrlRead($cmbCoCVersion)
;~ 	$AndroidGamePackage = IniRead(@ScriptDir & "\COCBot\COCVersions.ini",$iSection,"1PackageName",$AndroidGamePackage)
;~ 	$AndroidGameClass = IniRead(@ScriptDir & "\COCBot\COCVersions.ini",$iSection,"2ActivityName",$AndroidGameClass)
;~ EndFunc

Func cmbZapMethod()
	If GUICtrlRead($chkUseSamM0dZap) = $GUI_CHECKED Then
		$ichkUseSamM0dZap = 1
	Else
		$ichkUseSamM0dZap = 0
	EndIf
EndFunc   ;==>chkSmartLightSpell

Func chkEnableHLFClickSetlog()
	If GUICtrlRead($chkEnableHLFClickSetlog) = $GUI_CHECKED Then
		$EnableHMLSetLog = 1
	Else
		$EnableHMLSetLog = 0
	EndIf
	SetLog("HLFClickSetlog " & ($EnableHMLSetLog = 1 ? "enabled" : "disabled"))
EndFunc   ;==>chkEnableHLFClickSetlog

Func sldHLFClickDelayTime()
	$isldHLFClickDelayTime = GUICtrlRead($sldHLFClickDelayTime)
	GUICtrlSetData($lblHLFClickDelayTime, $isldHLFClickDelayTime & " ms")
EndFunc   ;==>sldHLFClickDelayTime

Func chkEnableHLFClick()
	If GUICtrlRead($chkEnableHLFClick) = $GUI_CHECKED Then
		GUICtrlSetState($sldHLFClickDelayTime, $GUI_ENABLE)
		$ichkEnableHLFClick = 1
	Else
		GUICtrlSetState($sldHLFClickDelayTime, $GUI_DISABLE)
		$ichkEnableHLFClick = 0
	EndIf
EndFunc

Func chkSmartUpdateWall()
	If GUICtrlRead($chkSmartUpdateWall) = $GUI_CHECKED Then
		GUICtrlSetState($txtClickWallDelay, $GUI_ENABLE)
		If $debugsetlog = 1 Then SetLog("BaseNode: " & $aBaseNode[0] & "," & $aBaseNode[1])
		If $debugsetlog = 1 Then SetLog("LastWall: " & $aLastWall[0] & "," & $aLastWall[1])
		If $debugsetlog = 1 Then SetLog("FaceDirection: " & $iFaceDirection)
	Else
		GUICtrlSetState($txtClickWallDelay, $GUI_DISABLE)
		; reset all data
		$aLastWall[0] = -1
		$aLastWall[1] = -1
		$aBaseNode[0] = -1
		$aBaseNode[1] = -1
		$iFaceDirection = 1
	EndIf
EndFunc

Func chkDropCCFirst()
	If GUICtrlRead($chkDropCCFirst) = $GUI_CHECKED Then
		$ichkDropCCFirst = 1
	Else
		$ichkDropCCFirst = 0
	EndIf
EndFunc

Func chkEnableCustomOCR4CCRequest()
	If GUICtrlRead($chkEnableCustomOCR4CCRequest) = $GUI_CHECKED Then
		$ichkEnableCustomOCR4CCRequest = 1
	Else
		$ichkEnableCustomOCR4CCRequest = 0
	EndIf
EndFunc

Func chkDebugMyOcr()
	If GUICtrlRead($chkDebugMyOcr) = $GUI_CHECKED Then
		$MyOcrDebug = 1
	Else
		$MyOcrDebug = 0
	EndIf
EndFunc

Func chkDebugSamM0d()
	If GUICtrlRead($chkDebugSamM0d) = $GUI_CHECKED Then
		$iSamM0dDebug = 1
	Else
		$iSamM0dDebug = 0
	EndIf
EndFunc

; CSV Deployment Speed Mod
Func sldSelectedSpeedDB()
	$isldSelectedCSVSpeed[$DB] = GUICtrlRead($sldSelectedSpeedDB)
	Local $speedText = $iCSVSpeeds[$isldSelectedCSVSpeed[$DB]] & "x";
	IF $isldSelectedCSVSpeed[$DB] = 4 Then $speedText = "Normal"
	GUICtrlSetData($lbltxtSelectedSpeedDB, $speedText & " speed")
EndFunc   ;==>sldSelectedSpeedDB

Func sldSelectedSpeedAB()
	$isldSelectedCSVSpeed[$LB] = GUICtrlRead($sldSelectedSpeedAB)
	Local $speedText = $iCSVSpeeds[$isldSelectedCSVSpeed[$LB]] & "x";
	IF $isldSelectedCSVSpeed[$LB] = 4 Then $speedText = "Normal"
	GUICtrlSetData($lbltxtSelectedSpeedAB, $speedText & " speed")
EndFunc   ;

Func AttackNowLB()
	Setlog("Begin Live Base Attack TEST")
	$iMatchMode = $LB			; Select Live Base As Attack Type
	$iAtkAlgorithm[$LB] = 1			; Select Scripted Attack
	$scmbABScriptName = GuiCtrlRead($cmbScriptNameAB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$iMatchMode = 1			; Select Live Base As Attack Type
	$RunState = True

	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	Setlog("End Live Base Attack TEST")
EndFunc   ;==>AttackNowLB

Func AttackNowDB()
	Setlog("Begin Dead Base Attack TEST")
	$iMatchMode = $DB			; Select Dead Base As Attack Type
	$iAtkAlgorithm[$DB] = 1			; Select Scripted Attack
	$scmbABScriptName = GuiCtrlRead($cmbScriptNameDB)		; Select Scripted Attack File From The Combo Box, Cos it wasn't refreshing until pressing Start button
	$iMatchMode = 0			; Select Dead Base As Attack Type
	$RunState = True
	ForceCaptureRegion()
	_CaptureRegion2()

	If CheckZoomOut("VillageSearch", True, False) = False Then
		$i = 0
		Local $bMeasured
		Do
			$i += 1
			If _Sleep($iDelayPrepareSearch3) Then Return ; wait 500 ms
			ForceCaptureRegion()
			$bMeasured = CheckZoomOut("VillageSearch", $i < 2, True)
		Until $bMeasured = True Or $i >= 2
		If $bMeasured = False Then Return ; exit func
	EndIf

	PrepareAttack($iMatchMode)			; lol I think it's not needed for Scripted attack, But i just Used this to be sure of my code
	Attack()			; Fire xD
	Setlog("End Dead Base Attack TEST")
EndFunc   ;==>AttackNowLB

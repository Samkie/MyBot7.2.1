; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Multi Finger (LunaEclipse)
IniWriteS($config, "MultiFinger", "Select", _GUICtrlComboBox_GetCurSel($cmbDBMultiFinger))

; Unit Wave Factor
If GUICtrlRead($chkUnitFactor) = $GUI_CHECKED Then
	IniWriteS($config, "SetSleep", "EnableUnitFactor", 1)
Else
	IniWriteS($config, "SetSleep", "EnableUnitFactor", 0)
EndIf
IniWriteS($config, "SetSleep", "UnitFactor", GUICtrlRead($txtUnitFactor))

If GUICtrlRead($chkWaveFactor) = $GUI_CHECKED Then
	IniWriteS($config, "SetSleep", "EnableWaveFactor", 1)
Else
	IniWriteS($config, "SetSleep", "EnableWaveFactor", 0)
EndIf
IniWriteS($config, "SetSleep", "WaveFactor", GUICtrlRead($txtWaveFactor))


; SmartZap Settings from ChaCalGyn (LunaEclipse) - DEMEN

If GUICtrlRead($chkUseSamM0dZap) = $GUI_CHECKED Then
	IniWrite($config, "Zap", "SamM0dZap", 1)
Else
	IniWrite($config, "Zap", "SamM0dZap", 0)
EndIf


If GUICtrlRead($chkSmartZapDB) = $GUI_CHECKED Then
	IniWrite($config, "SmartZap", "ZapDBOnly", 1)
Else
	IniWrite($config, "SmartZap", "ZapDBOnly", 0)
EndIf

If GUICtrlRead($chkSmartZapSaveHeroes) = $GUI_CHECKED Then
	IniWrite($config, "SmartZap", "THSnipeSaveHeroes", 1)
Else
	IniWrite($config, "SmartZap", "THSnipeSaveHeroes", 0)
EndIf

IniWrite($config, "SmartZap", "MinDE", GUICtrlRead($txtMinDark))

; samm0d zap
If GUICtrlRead($chkSmartZapRnd) = $GUI_CHECKED Then
	IniWrite($config, "SamM0dZap", "UseSmartZapRnd", 1)
Else
	IniWrite($config, "SamM0dZap", "UseSmartZapRnd", 0)
EndIf
If GUICtrlRead($chkDrillExistBeforeZap) = $GUI_CHECKED Then
	IniWrite($config, "SamM0dZap", "CheckDrillBeforeZap", 1)
Else
	IniWrite($config, "SamM0dZap", "CheckDrillBeforeZap", 0)
EndIf

If GUICtrlRead($chkPreventTripleZap) = $GUI_CHECKED Then
	IniWrite($config, "SamM0dZap", "PreventTripleZap", 1)
Else
	IniWrite($config, "SamM0dZap", "PreventTripleZap", 0)
EndIf

IniWrite($config, "SamM0dZap", "MinDEGetFromDrill", GUICtrlRead($txtMinDEGetFromDrill))


; Check Collectors Outside
If GUICtrlRead($chkDBMeetCollOutside) = $GUI_CHECKED Then
	IniWriteS($config, "search", "DBMeetCollOutside", 1)
Else
	IniWriteS($config, "search", "DBMeetCollOutside", 0)
EndIf

If GUICtrlRead($chkSkipCollectorCheckIF) = $GUI_CHECKED Then
	IniWriteS($config, "search", "SkipCollectorCheckIF", 1)
Else
	IniWriteS($config, "search", "SkipCollectorCheckIF", 0)
EndIf
IniWriteS($config, "search", "DBMinCollOutsidePercent", GUICtrlRead($txtDBMinCollOutsidePercent))
IniWriteS($config, "search", "SkipCollectorGold", GUICtrlRead($txtSkipCollectorGold))
IniWriteS($config, "search", "SkipCollectorElixir", GUICtrlRead($txtSkipCollectorElixir))
IniWriteS($config, "search", "SkipCollectorDark", GUICtrlRead($txtSkipCollectorDark))

If GUICtrlRead($chkSkipCollectorCheckIFTHLevel) = $GUI_CHECKED Then
	IniWriteS($config, "search", "SkipCollectorCheckIFTHLevel", 1)
Else
	IniWriteS($config, "search", "SkipCollectorCheckIFTHLevel", 0)
EndIf
IniWriteS($config, "search", "IFTHLevel", GUICtrlRead($txtIFTHLevel))

; dropp cc first
If GUICtrlRead($chkDropCCFirst) = $GUI_CHECKED Then
	IniWrite($config, "CCFirst", "Enable", 1)
Else
	IniWrite($config, "CCFirst", "Enable", 0)
EndIf

; Check League For DeadBase
If GUICtrlRead($chkDBNoLeague) = $GUI_CHECKED Then
	IniWrite($config, "search", "DBNoLeague", 1)
Else
	IniWrite($config, "search", "DBNoLeague", 0)
EndIf

If GUICtrlRead($chkABNoLeague) = $GUI_CHECKED Then
	IniWrite($config, "search", "ABNoLeague", 1)
Else
	IniWrite($config, "search", "ABNoLeague", 0)
EndIf

; HLFClick By Samkie
If GUICtrlRead($chkEnableHLFClick) = $GUI_CHECKED Then
	IniWrite($config, "HLFClick", "EnableHLFClick", 1)
Else
	IniWrite($config, "HLFClick", "EnableHLFClick", 0)
EndIf
IniWrite($config, "HLFClick", "HLFClickDelayTime", GUICtrlRead($sldHLFClickDelayTime))

If GUICtrlRead($chkEnableHLFClickSetlog) = $GUI_CHECKED Then
	IniWrite($config, "HLFClick", "EnableHLFClickSetlog", 1)
Else
	IniWrite($config, "HLFClick", "EnableHLFClickSetlog", 0)
EndIf

; advanced update for wall by Samkie
If GUICtrlRead($chkSmartUpdateWall) = $GUI_CHECKED Then
	IniWrite($config, "AU4Wall", "EnableSmartUpdateWall", 1)
Else
	IniWrite($config, "AU4Wall", "EnableSmartUpdateWall", 0)
EndIf

; samm0d ocr
If GUICtrlRead($chkEnableCustomOCR4CCRequest) = $GUI_CHECKED Then
	IniWrite($config, "GetMyOcr", "EnableCustomOCR4CCRequest", 1)
Else
	IniWrite($config, "GetMyOcr", "EnableCustomOCR4CCRequest", 0)
EndIf

; auto dock
If GUICtrlRead($chkAutoDock) = $GUI_CHECKED Then
	IniWrite($config, "AutoDock", "Enable", 1)
Else
	IniWrite($config, "AutoDock", "Enable", 0)
EndIf


IniWriteS($config, "AU4Wall", "ClickWallDelay", GUICtrlRead($txtClickWallDelay))
IniWriteS($config, "AU4Wall", "BaseNodeX", $aBaseNode[0])
IniWriteS($config, "AU4Wall", "BaseNodeY", $aBaseNode[1])
IniWriteS($config, "AU4Wall", "LastWallX", $aLastWall[0])
IniWriteS($config, "AU4Wall", "LastWallY", $aLastWall[1])
IniWriteS($config, "AU4Wall", "FaceDirection", $iFaceDirection)

; CSV Deployment Speed Mod
IniWriteS($config, "attack", "CSVSpeedDB", $isldSelectedCSVSpeed[$DB])
IniWriteS($config, "attack", "CSVSpeedAB", $isldSelectedCSVSpeed[$LB])


; My Switch
;~ $ichkEnableMySwitch = IniRead($config, "MySwitch", "Enable", "0")
;~ If GUICtrlRead($chkEnableMySwitch) = $GUI_CHECKED Then
;~ 	IniWrite($config, "MySwitch", "Enable", 1)
;~ Else
;~ 	IniWrite($config, "MySwitch", "Enable", 0)
;~ EndIf

; Wait 4 CC
If GUICtrlRead($chkWait4CC) = $GUI_CHECKED Then
	IniWriteS($config, "Wait4CC", "Enable", 1)
Else
	IniWriteS($config, "Wait4CC", "Enable", 0)
EndIf
IniWriteS($config, "Wait4CC", "CCStrength", GUICtrlRead($txtCCStrength))

; check 4 cc
If GUICtrlRead($chkCheck4CC) = $GUI_CHECKED Then
	IniWrite($config, "Check4CC", "Enable", 1)
Else
	IniWrite($config, "Check4CC", "Enable", 0)
EndIf
IniWrite($config, "Check4CC", "WaitTime", GUICtrlRead($txtCheck4CCWaitTime))

; global delay increse
If GUICtrlRead($chkIncreaseGlobalDelay) = $GUI_CHECKED Then
	IniWrite($config, "GlobalDelay", "Enable", 1)
Else
	IniWrite($config, "GlobalDelay", "Enable", 0)
EndIf
IniWrite($config, "GlobalDelay", "DelayPercentage", GUICtrlRead($txtIncreaseGlobalDelay))

; stick to train page
IniWrite($config, "StickToTrainPage", "Minutes", GUICtrlRead($txtStickToTrainWindow))

; My Troops
If GUICtrlRead($chkDisablePretrainTroops) = $GUI_CHECKED Then
	IniWriteS($config, "MyTroops", "PreTrain", 1)
Else
	IniWriteS($config, "MyTroops", "PreTrain", 0)
EndIf

If GUICtrlRead($chkEnableDeleteExcessTroops) = $GUI_CHECKED Then
	IniWriteS($config, "MyTroops", "DeleteExcess", 1)
Else
	IniWriteS($config, "MyTroops", "DeleteExcess", 0)
EndIf

If GUICtrlRead($chkCustomTrain) = $GUI_CHECKED Then
	IniWriteS($config, "MyTroops", "EnableCustomTrain", 1)
Else
	IniWriteS($config, "MyTroops", "EnableCustomTrain", 0)
EndIf

If GUICtrlRead($chkMyTroopsOrder) = $GUI_CHECKED Then
	IniWriteS($config, "MyTroops", "Order", 1)
Else
	IniWriteS($config, "MyTroops", "Order", 0)
EndIf

;IniWrite($config, "COCVer", "CoCVersion", _GUICtrlComboBox_GetCurSel($cmbCoCVersion))

IniWriteS($config, "MyTroops", "TrainCombo", _GUICtrlComboBox_GetCurSel($cmbMyQuickTrain))

IniWriteS($config, "MyTroops", "Composition", _GUICtrlComboBox_GetCurSel($cmbTroopSetting))

For $i = 0 To UBound($MyTroops) - 1
	IniWriteS($config, "MyTroops", $MyTroops[$i][0] & _GUICtrlComboBox_GetCurSel($cmbTroopSetting), GUICtrlRead(Eval("txtMy" & $MyTroops[$i][0])))
	IniWriteS($config, "MyTroops", $MyTroops[$i][0] & "Order" & _GUICtrlComboBox_GetCurSel($cmbTroopSetting), GUICtrlRead(Eval("cmbMy"& $MyTroops[$i][0] & "Order")))
Next

For $i = 0 To UBound($MySpells) - 1
	If GUICtrlRead(Eval("chkPre" & $MySpells[$i][0])) = $GUI_CHECKED Then
		IniWriteS($config, "MySpells", $MySpells[$i][0], 1)
	Else
		IniWriteS($config, "MySpells", $MySpells[$i][0], 0)
	EndIf
Next

IniWriteS($config, "Spells", "LightningSpell", GUICtrlRead($txtNumLightningSpell))
IniWriteS($config, "Spells", "RageSpell", GUICtrlRead($txtNumRageSpell))
IniWriteS($config, "Spells", "HealSpell", GUICtrlRead($txtNumHealSpell))
IniWriteS($config, "Spells", "JumpSpell", GUICtrlRead($txtNumJumpSpell))
IniWriteS($config, "Spells", "FreezeSpell", GUICtrlRead($txtNumFreezeSpell))
IniWriteS($config, "Spells", "CloneSpell", GUICtrlRead($txtNumCloneSpell))
IniWriteS($config, "Spells", "PoisonSpell", GUICtrlRead($txtNumPoisonSpell))
IniWriteS($config, "Spells", "EarthSpell", GUICtrlRead($txtNumEarthSpell))
IniWriteS($config, "Spells", "HasteSpell", GUICtrlRead($txtNumHasteSpell))
IniWriteS($config, "Spells", "SkeletonSpell", GUICtrlRead($txtNumSkeletonSpell))

; #FUNCTION# ====================================================================================================================
; Name ..........: readConfig.au3
; Description ...: Reads config file and sets variables
; Syntax ........: readConfig()
; Parameters ....: NA
; Return values .: NA
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; Multi Finger (LunaEclipse)
IniReadS($iMultiFingerStyle, $config, "MultiFinger", "Select", "1")

; Unit Wave Factor

IniReadS($ichkUnitFactor, $config, "SetSleep", "EnableUnitFactor", "1", "Int")
IniReadS($itxtUnitFactor, $config, "SetSleep", "UnitFactor", "10","Int")

IniReadS($ichkWaveFactor, $config, "SetSleep", "EnableWaveFactor", "1", "Int")
IniReadS($itxtWaveFactor, $config, "SetSleep", "WaveFactor", "100","Int")


; SmartZap from ChaCalGyn (LunaEclipse) - DEMEN

$ichkUseSamM0dZap = IniRead($config, "Zap", "SamM0dZap", "1")

$ichkSmartZapDB = IniRead($config, "SmartZap", "ZapDBOnly", "1")
$ichkSmartZapSaveHeroes = IniRead($config, "SmartZap", "THSnipeSaveHeroes", "1")
$itxtMinDE = IniRead($config, "SmartZap", "MinDE", "300")

; samm0d zap
$ichkSmartZapRnd = IniRead($config, "SamM0dZap", "UseSmartZapRnd", "1")
$ichkDrillExistBeforeZap = IniRead($config, "SamM0dZap", "CheckDrillBeforeZap", "1")
$itxtMinDEGetFromDrill = IniRead($config, "SamM0dZap", "MinDEGetFromDrill", "100")
$ichkPreventTripleZap = IniRead($config, "SamM0dZap", "PreventTripleZap", "1")


; Check Collectors Outside - Added by TheRevenor
$ichkDBMeetCollOutside = IniRead($config, "search", "DBMeetCollOutside", "0")
$iDBMinCollOutsidePercent = IniRead($config, "search", "DBMinCollOutsidePercent", "50")

$ichkSkipCollectorCheckIF = IniRead($config, "search", "SkipCollectorCheckIF", "0")
$itxtSkipCollectorGold = IniRead($config, "search", "SkipCollectorGold", "500000")
$itxtSkipCollectorElixir = IniRead($config, "search", "SkipCollectorElixir", "500000")
$itxtSkipCollectorDark = IniRead($config, "search", "SkipCollectorDark", "3000")
$ichkSkipCollectorCheckIFTHLevel = IniRead($config, "search", "SkipCollectorCheckIFTHLevel", "0")
$itxtIFTHLevel = IniRead($config, "search", "IFTHLevel", "7")

; drop cc first
$ichkDropCCFirst = IniRead($config, "CCFirst", "Enable", "0")

; Check League For DeadBase
$iChkNoLeague[$DB] = IniRead($config, "search", "DBNoLeague", "0")
$iChkNoLeague[$LB] = IniRead($config, "search", "ABNoLeague", "0")

; HLFClick By Samkie
$ichkEnableHLFClick = IniRead($config, "HLFClick", "EnableHLFClick", "0")
$isldHLFClickDelayTime = IniRead($config, "HLFClick", "HLFClickDelayTime", "500")
$EnableHMLSetLog = IniRead($config, "HLFClick", "EnableHLFClickSetlog", "0")


; advanced update for wall by Samkie
$ichkSmartUpdateWall  = IniRead($config, "AU4Wall", "EnableSmartUpdateWall", "0")
$itxtClickWallDelay  = IniRead($config, "AU4Wall", "ClickWallDelay", "500")
$aBaseNode[0] = IniRead($config, "AU4Wall", "BaseNodeX", "-1")
$aBaseNode[1] = IniRead($config, "AU4Wall", "BaseNodeY", "-1")
$aLastWall[0] = IniRead($config, "AU4Wall", "LastWallX", "-1")
$aLastWall[1] = IniRead($config, "AU4Wall", "LastWallY", "-1")
$iFaceDirection = IniRead($config, "AU4Wall", "FaceDirection", "1")

; samm0d ocr
$ichkEnableCustomOCR4CCRequest = IniRead($config, "GetMyOcr", "EnableCustomOCR4CCRequest", "0")

; auto dock
$ichkAutoDock = IniRead($config, "AutoDock", "Enable", "0")

; CSV Deployment Speed Mod
IniReadS($isldSelectedCSVSpeed[$DB], $config, "attack", "CSVSpeedDB", 3)
IniReadS($isldSelectedCSVSpeed[$LB], $config, "attack", "CSVSpeedAB", 3)

; Wait 4 CC
IniReadS($ichkWait4CC, $config, "Wait4CC", "Enable", "0")
IniReadS($CCStrength, $config, "Wait4CC", "CCStrength", "100")

; check 4 cc
$ichkCheck4CC = IniRead($config, "Check4CC", "Enable", "0")
$itxtCheck4CCWaitTime = IniRead($config, "Check4CC", "WaitTime", "7")


; global delay increse
$ichkIncreaseGlobalDelay = IniRead($config, "GlobalDelay", "Enable", "0")
$itxtIncreaseGlobalDelay = IniRead($config, "GlobalDelay", "DelayPercentage", "10")

;stick to train page
$itxtStickToTrainWindow = IniRead($config, "StickToTrainPage", "Minutes", 2)

; My Troops
IniReadS($ichkCustomTrain, $config, "MyTroops", "EnableCustomTrain", "0")
IniReadS($ichkMyTroopsOrder, $config, "MyTroops", "Order", "0")
IniReadS($ichkEnableDeleteExcessTroops, $config, "MyTroops", "DeleteExcess", "0")



IniReadS($icmbMyQuickTrain, $config, "MyTroops", "TrainCombo", "0", "Int")
IniReadS($icmbTroopSetting, $config, "MyTroops", "Composition", "0", "Int")
;$icmbCoCVersion = IniRead($config, "COCVer", "CoCVersion", "0")

IniReadS($ichkDisablePretrainTroops, $config, "MyTroops", "PreTrain", "0", "Int")

For $i = 0 To UBound($MyTroops) - 1
	;$MyTroops[$i][3] =  IniRead($config, "MyTroops", $MyTroops[$i][0] & $icmbTroopSetting, "0")
	;$MyTroops[$i][1] =  Number(IniRead($config, "MyTroops", $MyTroops[$i][0] & "Order" & $icmbTroopSetting, $i + 1))
	IniReadS($MyTroops[$i][3],$config, "MyTroops", $MyTroops[$i][0] & $icmbTroopSetting, "0","Int")
	IniReadS($MyTroops[$i][1],$config, "MyTroops", $MyTroops[$i][0] & "Order" & $icmbTroopSetting, $i + 1,"Int")
Next

For $i = 0 To UBound($MySpells) - 1
	Local $tempPreSpell
	IniReadS($tempPreSpell, $config, "MySpells", $MySpells[$i][0], "0", "Int")
	Assign("ichkPre" & $MySpells[$i][0], $tempPreSpell)
	;IniReadS($MySpells[$i][1], $config, "MyTroops", $MySpells[$i][0] & "Order", $i + 1)
Next

IniReadS($iLightningSpellComp, $config, "Spells", "LightningSpell", "0","Int")
IniReadS($iRageSpellComp, $config, "Spells", "RageSpell", "0","Int")
IniReadS($iHealSpellComp, $config, "Spells", "HealSpell", "0","Int")
IniReadS($iJumpSpellComp, $config, "Spells", "JumpSpell", "0","Int")
IniReadS($iFreezeSpellComp, $config, "Spells", "FreezeSpell", "0","Int")
IniReadS($iCloneSpellComp, $config, "Spells", "CloneSpell", "0", "Int")
IniReadS($iPoisonSpellComp, $config, "Spells", "PoisonSpell", "0","Int")
IniReadS($iHasteSpellComp, $config, "Spells", "HasteSpell", "0","Int")
IniReadS($iEarthSpellComp, $config, "Spells", "EarthSpell", "0","Int")
IniReadS($iSkeletonSpellComp, $config, "Spells", "SkeletonSpell", "0", "Int")

;$iTotalTrainSpaceSpell = 0
;For $i = 0 To 9
;	$iTotalTrainSpaceSpell += Number(Eval("i" & $MySpells[$i][0] & "SpellComp") * $MySpells[$i][2])
;	if $iSamM0dDebug = 1 Then SetLog("$iTotalTrainSpaceSpell: " & $iTotalTrainSpaceSpell)
;Next



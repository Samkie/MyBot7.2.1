; #FUNCTION# ====================================================================================================================
; Name ..........: saveConfig.au3
; Description ...: Saves all of the GUI values to the config.ini and building.ini files
; Syntax ........: saveConfig()
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


Func saveConfig() ;Saves the controls settings to the config

	;from GUI donate fields to variables  ----------------------------------------
	If GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		$ichkDonateBarbarians = 1
	Else
		$ichkDonateBarbarians = 0
	EndIf
	$sTxtDonateBarbarians = GUICtrlRead($txtDonateBarbarians)
	$sTxtBlacklistBarbarians = GUICtrlRead($txtBlacklistBarbarians)
	If GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		$ichkDonateArchers = 1
	Else
		$ichkDonateArchers = 0
	EndIf
	$sTxtDonateArchers = GUICtrlRead($txtDonateArchers)
	$sTxtBlacklistArchers = GUICtrlRead($txtBlacklistArchers)
	If GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		$ichkDonateGiants = 1
	Else
		$ichkDonateGiants = 0
	EndIf
	$sTxtDonateGiants = GUICtrlRead($txtDonateGiants)
	$sTxtBlacklistGiants = GUICtrlRead($txtBlacklistGiants)
	If GUICtrlRead($chkDonateGoblins) = $GUI_CHECKED Then
		$ichkDonateGoblins = 1
	Else
		$ichkDonateGoblins = 0
	EndIf
	$sTxtDonateGoblins = GUICtrlRead($txtDonateGoblins)
	$sTxtBlacklistGoblins = GUICtrlRead($txtBlacklistGoblins)
	If GUICtrlRead($chkDonateWallBreakers) = $GUI_CHECKED Then
		$ichkDonateWallBreakers = 1
	Else
		$ichkDonateWallBreakers = 0
	EndIf
	$sTxtDonateWallBreakers = GUICtrlRead($txtDonateWallBreakers)
	$sTxtBlacklistWallBreakers = GUICtrlRead($txtBlacklistWallBreakers)
	If GUICtrlRead($chkDonateBalloons) = $GUI_CHECKED Then
		$ichkDonateBalloons = 1
	Else
		$ichkDonateBalloons = 0
	EndIf
	$sTxtDonateBalloons = GUICtrlRead($txtDonateBalloons)
	$sTxtBlacklistBalloons = GUICtrlRead($txtBlacklistBalloons)
	If GUICtrlRead($chkDonateWizards) = $GUI_CHECKED Then
		$ichkDonateWizards = 1
	Else
		$ichkDonateWizards = 0
	EndIf
	$sTxtDonateWizards = GUICtrlRead($txtDonateWizards)
	$sTxtBlacklistWizards = GUICtrlRead($txtBlacklistWizards)
	If GUICtrlRead($chkDonateHealers) = $GUI_CHECKED Then
		$ichkDonateHealers = 1
	Else
		$ichkDonateHealers = 0
	EndIf
	$sTxtDonateHealers = GUICtrlRead($txtDonateHealers)
	$sTxtBlacklistHealers = GUICtrlRead($txtBlacklistHealers)
	If GUICtrlRead($chkDonateDragons) = $GUI_CHECKED Then
		$ichkDonateDragons = 1
	Else
		$ichkDonateDragons = 0
	EndIf
	$sTxtDonateDragons = GUICtrlRead($txtDonateDragons)
	$sTxtBlacklistDragons = GUICtrlRead($txtBlacklistDragons)
	If GUICtrlRead($chkDonatePekkas) = $GUI_CHECKED Then
		$ichkDonatePekkas = 1
	Else
		$ichkDonatePekkas = 0
	EndIf
	$sTxtDonatePekkas = GUICtrlRead($txtDonatePekkas)
	$sTxtBlacklistPekkas = GUICtrlRead($txtBlacklistPekkas)
	If GUICtrlRead($chkDonateBabyDragons) = $GUI_CHECKED Then
		$ichkDonateBabyDragons = 1
	Else
		$ichkDonateBabyDragons = 0
	EndIf
	$sTxtDonateBabyDragons = GUICtrlRead($txtDonateBabyDragons)
	$sTxtBlacklistBabyDragons = GUICtrlRead($txtBlacklistBabyDragons)
	If GUICtrlRead($chkDonateMiners) = $GUI_CHECKED Then
		$ichkDonateMiners = 1
	Else
		$ichkDonateMiners = 0
	EndIf
	$sTxtDonateMiners = GUICtrlRead($txtDonateMiners)
	$sTxtBlacklistMiners = GUICtrlRead($txtBlacklistMiners)
	If GUICtrlRead($chkDonateLightningSpells) = $GUI_CHECKED Then
		$ichkDonateLightningSpells = 1
	Else
		$ichkDonateLightningSpells = 0
	EndIf
	$sTxtDonateLightningSpells = GUICtrlRead($txtDonateLightningSpells)
	$sTxtBlacklistLightningSpells = GUICtrlRead($txtBlacklistLightningSpells)
	If GUICtrlRead($chkDonateHealSpells) = $GUI_CHECKED Then
		$ichkDonateHealSpells = 1
	Else
		$ichkDonateHealSpells = 0
	EndIf
	$sTxtDonateHealSpells = GUICtrlRead($txtDonateHealSpells)
	$sTxtBlacklistHealSpells = GUICtrlRead($txtBlacklistHealSpells)
	If GUICtrlRead($chkDonateRageSpells) = $GUI_CHECKED Then
		$ichkDonateRageSpells = 1
	Else
		$ichkDonateRageSpells = 0
	EndIf
	$sTxtDonateRageSpells = GUICtrlRead($txtDonateRageSpells)
	$sTxtBlacklistRageSpells = GUICtrlRead($txtBlacklistRageSpells)
	If GUICtrlRead($chkDonateJumpSpells) = $GUI_CHECKED Then
		$ichkDonateJumpSpells = 1
	Else
		$ichkDonateJumpSpells = 0
	EndIf
	$sTxtDonateJumpSpells = GUICtrlRead($txtDonateJumpSpells)
	$sTxtBlacklistJumpSpells = GUICtrlRead($txtBlacklistJumpSpells)
	If GUICtrlRead($chkDonateFreezeSpells) = $GUI_CHECKED Then
		$ichkDonateFreezeSpells = 1
	Else
		$ichkDonateFreezeSpells = 0
	EndIf
	$sTxtDonateFreezeSpells = GUICtrlRead($txtDonateFreezeSpells)
	$sTxtBlacklistFreezeSpells = GUICtrlRead($txtBlacklistFreezeSpells)
	If GUICtrlRead($chkDonateMinions) = $GUI_CHECKED Then
		$ichkDonateMinions = 1
	Else
		$ichkDonateMinions = 0
	EndIf
	$sTxtDonateMinions = GUICtrlRead($txtDonateMinions)
	$sTxtBlacklistMinions = GUICtrlRead($txtBlacklistMinions)
	If GUICtrlRead($chkDonateHogRiders) = $GUI_CHECKED Then
		$ichkDonateHogRiders = 1
	Else
		$ichkDonateHogRiders = 0
	EndIf
	$sTxtDonateHogRiders = GUICtrlRead($txtDonateHogRiders)
	$sTxtBlacklistHogRiders = GUICtrlRead($txtBlacklistHogRiders)
	If GUICtrlRead($chkDonateValkyries) = $GUI_CHECKED Then
		$ichkDonateValkyries = 1
	Else
		$ichkDonateValkyries = 0
	EndIf
	$sTxtDonateValkyries = GUICtrlRead($txtDonateValkyries)
	$sTxtBlacklistValkyries = GUICtrlRead($txtBlacklistValkyries)
	If GUICtrlRead($chkDonateGolems) = $GUI_CHECKED Then
		$ichkDonateGolems = 1
	Else
		$ichkDonateGolems = 0
	EndIf
	$sTxtDonateGolems = GUICtrlRead($txtDonateGolems)
	$sTxtBlacklistGolems = GUICtrlRead($txtBlacklistGolems)
	If GUICtrlRead($chkDonateWitches) = $GUI_CHECKED Then
		$ichkDonateWitches = 1
	Else
		$ichkDonateWitches = 0
	EndIf
	$sTxtDonateWitches = GUICtrlRead($txtDonateWitches)
	$sTxtBlacklistWitches = GUICtrlRead($txtBlacklistWitches)
	If GUICtrlRead($chkDonateLavaHounds) = $GUI_CHECKED Then
		$ichkDonateLavaHounds = 1
	Else
		$ichkDonateLavaHounds = 0
	EndIf
	$sTxtDonateLavaHounds = GUICtrlRead($txtDonateLavaHounds)
	$sTxtBlacklistLavaHounds = GUICtrlRead($txtBlacklistLavaHounds)
	If GUICtrlRead($chkDonateBowlers) = $GUI_CHECKED Then
		$ichkDonateBowlers = 1
	Else
		$ichkDonateBowlers = 0
	EndIf
	$sTxtDonateBowlers = GUICtrlRead($txtDonateBowlers)
	$sTxtBlacklistBowlers = GUICtrlRead($txtBlacklistBowlers)
	If GUICtrlRead($chkDonatePoisonSpells) = $GUI_CHECKED Then
		$ichkDonatePoisonSpells = 1
	Else
		$ichkDonatePoisonSpells = 0
	EndIf
	$sTxtDonatePoisonSpells = GUICtrlRead($txtDonatePoisonSpells)
	$sTxtBlacklistPoisonSpells = GUICtrlRead($txtBlacklistPoisonSpells)
	If GUICtrlRead($chkDonateEarthQuakeSpells) = $GUI_CHECKED Then
		$ichkDonateEarthQuakeSpells = 1
	Else
		$ichkDonateEarthQuakeSpells = 0
	EndIf
	$sTxtDonateEarthQuakeSpells = GUICtrlRead($txtDonateEarthQuakeSpells)
	$sTxtBlacklistEarthQuakeSpells = GUICtrlRead($txtBlacklistEarthQuakeSpells)
	If GUICtrlRead($chkDonateHasteSpells) = $GUI_CHECKED Then
		$ichkDonateHasteSpells = 1
	Else
		$ichkDonateHasteSpells = 0
	EndIf
	$sTxtDonateHasteSpells = GUICtrlRead($txtDonateHasteSpells)
	$sTxtBlacklistHasteSpells = GUICtrlRead($txtBlacklistHasteSpells)
	If GUICtrlRead($chkDonateSkeletonSpells) = $GUI_CHECKED Then
		$ichkDonateSkeletonSpells = 1
	Else
		$ichkDonateSkeletonSpells = 0
	EndIf
	$sTxtDonateSkeletonSpells = GUICtrlRead($txtDonateSkeletonSpells)
	$sTxtBlacklistSkeletonSpells = GUICtrlRead($txtBlacklistSkeletonSpells)

	;;; Custom Combination Donate by ChiefM3
	If GUICtrlRead($chkDonateCustomA) = $GUI_CHECKED Then
		$ichkDonateCustomA = 1
	Else
		$ichkDonateCustomA = 0
	EndIf
	$sTxtDonateCustomA = GUICtrlRead($txtDonateCustomA)
	$sTxtBlacklistCustomA = GUICtrlRead($txtBlacklistCustomA)

	$varDonateCustomA[0][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomA1)
	$varDonateCustomA[0][1] = GUICtrlRead($txtDonateCustomA1)
	$varDonateCustomA[1][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomA2)
	$varDonateCustomA[1][1] = GUICtrlRead($txtDonateCustomA2)
	$varDonateCustomA[2][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomA3)
	$varDonateCustomA[2][1] = GUICtrlRead($txtDonateCustomA3)

	If GUICtrlRead($chkDonateCustomB) = $GUI_CHECKED Then
		$ichkDonateCustomB = 1
	Else
		$ichkDonateCustomB = 0
	EndIf
	$sTxtDonateCustomB = GUICtrlRead($txtDonateCustomB)
	$sTxtBlacklistCustomB = GUICtrlRead($txtBlacklistCustomB)

	$varDonateCustomB[0][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomB1)
	$varDonateCustomB[0][1] = GUICtrlRead($txtDonateCustomB1)
	$varDonateCustomB[1][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomB2)
	$varDonateCustomB[1][1] = GUICtrlRead($txtDonateCustomB2)
	$varDonateCustomB[2][0] = _GUICtrlComboBox_GetCurSel($cmbDonateCustomB3)
	$varDonateCustomB[2][1] = GUICtrlRead($txtDonateCustomB3)

	$sTxtBlacklist = GUICtrlRead($txtBlacklist)

	If GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		$ichkDonateAllBarbarians = 1
	Else
		$ichkDonateAllBarbarians = 0
	EndIf
	If GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		$ichkDonateAllArchers = 1
	Else
		$ichkDonateAllArchers = 0
	EndIf
	If GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		$ichkDonateAllGiants = 1
	Else
		$ichkDonateAllGiants = 0
	EndIf
	If GUICtrlRead($chkDonateAllGoblins) = $GUI_CHECKED Then
		$ichkDonateAllGoblins = 1
	Else
		$ichkDonateAllGoblins = 0
	EndIf
	If GUICtrlRead($chkDonateAllWallBreakers) = $GUI_CHECKED Then
		$ichkDonateAllWallBreakers = 1
	Else
		$ichkDonateAllWallBreakers = 0
	EndIf
	If GUICtrlRead($chkDonateAllBalloons) = $GUI_CHECKED Then
		$ichkDonateAllBalloons = 1
	Else
		$ichkDonateAllBalloons = 0
	EndIf
	If GUICtrlRead($chkDonateAllWizards) = $GUI_CHECKED Then
		$ichkDonateAllWizards = 1
	Else
		$ichkDonateAllWizards = 0
	EndIf
	If GUICtrlRead($chkDonateAllHealers) = $GUI_CHECKED Then
		$ichkDonateAllHealers = 1
	Else
		$ichkDonateAllHealers = 0
	EndIf
	If GUICtrlRead($chkDonateAllDragons) = $GUI_CHECKED Then
		$ichkDonateAllDragons = 1
	Else
		$ichkDonateAllDragons = 0
	EndIf
	If GUICtrlRead($chkDonateAllPekkas) = $GUI_CHECKED Then
		$ichkDonateAllPekkas = 1
	Else
		$ichkDonateAllPekkas = 0
	EndIf
	If GUICtrlRead($chkDonateAllBabyDragons) = $GUI_CHECKED Then
		$ichkDonateAllBabyDragons = 1
	Else
		$ichkDonateAllBabyDragons = 0
	EndIf
	If GUICtrlRead($chkDonateAllMiners) = $GUI_CHECKED Then
		$ichkDonateAllMiners = 1
	Else
		$ichkDonateAllMiners = 0
	EndIf
	If GUICtrlRead($chkDonateAllLightningSpells) = $GUI_CHECKED Then
		$ichkDonateAllLightningSpells = 1
	Else
		$ichkDonateAllLightningSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllHealSpells) = $GUI_CHECKED Then
		$ichkDonateAllHealSpells = 1
	Else
		$ichkDonateAllHealSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllRageSpells) = $GUI_CHECKED Then
		$ichkDonateAllRageSpells = 1
	Else
		$ichkDonateAllRageSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllJumpSpells) = $GUI_CHECKED Then
		$ichkDonateAllJumpSpells = 1
	Else
		$ichkDonateAllJumpSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllFreezeSpells) = $GUI_CHECKED Then
		$ichkDonateAllFreezeSpells = 1
	Else
		$ichkDonateAllFreezeSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllMinions) = $GUI_CHECKED Then
		$ichkDonateAllMinions = 1
	Else
		$ichkDonateAllMinions = 0
	EndIf
	If GUICtrlRead($chkDonateAllHogRiders) = $GUI_CHECKED Then
		$ichkDonateAllHogRiders = 1
	Else
		$ichkDonateAllHogRiders = 0
	EndIf
	If GUICtrlRead($chkDonateAllValkyries) = $GUI_CHECKED Then
		$ichkDonateAllValkyries = 1
	Else
		$ichkDonateAllValkyries = 0
	EndIf
	If GUICtrlRead($chkDonateAllGolems) = $GUI_CHECKED Then
		$ichkDonateAllGolems = 1
	Else
		$ichkDonateAllGolems = 0
	EndIf
	If GUICtrlRead($chkDonateAllWitches) = $GUI_CHECKED Then
		$ichkDonateAllWitches = 1
	Else
		$ichkDonateAllWitches = 0
	EndIf
	If GUICtrlRead($chkDonateAllLavaHounds) = $GUI_CHECKED Then
		$ichkDonateAllLavaHounds = 1
	Else
		$ichkDonateAllLavaHounds = 0
	EndIf
	If GUICtrlRead($chkDonateAllBowlers) = $GUI_CHECKED Then
		$ichkDonateAllBowlers = 1
	Else
		$ichkDonateAllBowlers = 0
	EndIf
	If GUICtrlRead($chkDonateAllPoisonSpells) = $GUI_CHECKED Then
		$ichkDonateAllPoisonSpells = 1
	Else
		$ichkDonateAllPoisonSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllEarthQuakeSpells) = $GUI_CHECKED Then
		$ichkDonateAllEarthQuakeSpells = 1
	Else
		$ichkDonateAllEarthQuakeSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllHasteSpells) = $GUI_CHECKED Then
		$ichkDonateAllHasteSpells = 1
	Else
		$ichkDonateAllHasteSpells = 0
	EndIf
	If GUICtrlRead($chkDonateAllSkeletonSpells) = $GUI_CHECKED Then
		$ichkDonateAllSkeletonSpells = 1
	Else
		$ichkDonateAllSkeletonSpells = 0
	EndIf

	If GUICtrlRead($chkDonateAllCustomA) = $GUI_CHECKED Then
		$ichkDonateAllCustomA = 1
	Else
		$ichkDonateAllCustomA = 0
	EndIf
	If GUICtrlRead($chkDonateAllCustomB) = $GUI_CHECKED Then
		$ichkDonateAllCustomB = 1
	Else
		$ichkDonateAllCustomB = 0
	EndIf

	; Extra Alphabets, Cyrillic, Chinese.
	If GUICtrlRead($chkExtraAlphabets) = $GUI_CHECKED Then
		$ichkExtraAlphabets = 1
	Else
		$ichkExtraAlphabets = 0
	EndIf
	If GUICtrlRead($chkExtraChinese) = $GUI_CHECKED Then
		$ichkExtraChinese = 1
	Else
		$ichkExtraChinese = 0
	EndIf


	$icmbFilterDonationsCC = _GUICtrlComboBox_GetCurSel($cmbFilterDonationsCC)


	; save upgrade buildings GUI -> Variables ------------------------------------------------------------------

	If GUICtrlRead($chkLab) = $GUI_CHECKED Then
		$ichkLab = 1
	Else
		$ichkLab = 0
	EndIf
	$icmbLaboratory = _GUICtrlComboBox_GetCurSel($cmbLaboratory)

	If GUICtrlRead($chkUpgradeKing) = $GUI_CHECKED Then
		$ichkUpgradeKing = 1
	Else
		$ichkUpgradeKing = 0
	EndIf

	If GUICtrlRead($chkUpgradeQueen) = $GUI_CHECKED Then
		$ichkUpgradeQueen = 1
	Else
		$ichkUpgradeQueen = 0
	EndIf

	If GUICtrlRead($chkUpgradeWarden) = $GUI_CHECKED Then
		$ichkUpgradeWarden = 1
	Else
		$ichkUpgradeWarden = 0
	EndIf


	For $iz = 0 To UBound($aUpgrades, 1) - 1 ; Apply the buildings upgrade varaible to GUI
		If GUICtrlRead($chkbxUpgrade[$iz]) = $GUI_CHECKED Then
			$ichkbxUpgrade[$iz] = 1
		Else
			$ichkbxUpgrade[$iz] = 0
		EndIf
		If GUICtrlRead($chkUpgrdeRepeat[$iz]) = $GUI_CHECKED Then
			$ichkUpgrdeRepeat[$iz] = 1
		Else
			$ichkUpgrdeRepeat[$iz] = 0
		EndIf
	Next

	$itxtUpgrMinGold = GUICtrlRead($txtUpgrMinGold)
	$itxtUpgrMinElixir = GUICtrlRead($txtUpgrMinElixir)
	$itxtUpgrMinDark = GUICtrlRead($txtUpgrMinDark)

	; upgrade walls GUI -> variables ----------------------------------------------------

	If GUICtrlRead($chkWalls) = $GUI_CHECKED Then
		$ichkWalls = 1
	Else
		$ichkWalls = 0
	EndIf

	$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
	$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)

	; $iMaxNbWall = GUICtrlRead($sldMaxNbWall)

	If GUICtrlRead($UseGold) = $GUI_CHECKED Then
		$iUseStorage = 0
	ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
		$iUseStorage = 1
	ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
		$iUseStorage = 2
	EndIf

	$itxtWall04ST = GUICtrlRead($txtWall04ST)
	$itxtWall05ST = GUICtrlRead($txtWall05ST)
	$itxtWall06ST = GUICtrlRead($txtWall06ST)
	$itxtWall07ST = GUICtrlRead($txtWall07ST)
	$itxtWall08ST = GUICtrlRead($txtWall08ST)
	$itxtWall09ST = GUICtrlRead($txtWall09ST)
	$itxtWall10ST = GUICtrlRead($txtWall10ST)
	$itxtWall11ST = GUICtrlRead($txtWall11ST)
	$itxtWall12ST = GUICtrlRead($txtWall12ST)

	If GUICtrlRead($chkSaveWallBldr) = $GUI_CHECKED Then
		$iSaveWallBldr = 1
	Else
		$iSaveWallBldr = 0
	EndIf

	$icmbWalls = _GUICtrlComboBox_GetCurSel($cmbWalls)


	; unbreakable gui -> variables ---------------------------------------------------
	$iUnbreakableWait = GUICtrlRead($txtUnbreakable)
	$iUnBrkMinGold = GUICtrlRead($txtUnBrkMinGold)
	$iUnBrkMinElixir = GUICtrlRead($txtUnBrkMinElixir)
	$iUnBrkMinDark = GUICtrlRead($txtUnBrkMinDark)
	$iUnBrkMaxGold = GUICtrlRead($txtUnBrkMaxGold)
	$iUnBrkMaxElixir = GUICtrlRead($txtUnBrkMaxElixir)
	$iUnBrkMaxDark = GUICtrlRead($txtUnBrkMaxDark)
	If GUICtrlRead($chkUnbreakable) = $GUI_CHECKED Then
		$iUnbreakableMode = 1
	Else
		$iUnbreakableMode = 0
	EndIf

	; save PushBullet / Telegram GUI -> Variables ----------------------------------------

	If GUICtrlRead($chkNotifyPBEnabled) = $GUI_CHECKED Then
		$NotifyPBEnabled = 1
	Else
		$NotifyPBEnabled = 0
	EndIf

	If GUICtrlRead($chkNotifyRemote) = $GUI_CHECKED Then
		$NotifyRemoteEnable = 1
	Else
		$NotifyRemoteEnable = 0
	EndIf

	If GUICtrlRead($chkNotifyDeleteAllPBPushes) = $GUI_CHECKED Then
		$NotifyDeleteAllPushesOnStart = 1
	Else
		$NotifyDeleteAllPushesOnStart = 0
	EndIf

	If GUICtrlRead($chkNotifyDeleteOldPBPushes) = $GUI_CHECKED Then
		$NotifyDeletePushesOlderThan = 1
	Else
		$NotifyDeletePushesOlderThan = 0
	EndIf

	$NotifyDeletePushesOlderThanHours = _GUICtrlComboBox_GetCurSel($cmbNotifyPushHours)

	If GUICtrlRead($chkNotifyAlertMatchFound) = $GUI_CHECKED Then
		$NotifyAlertMatchFound = 1
	Else
		$NotifyAlertMatchFound = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertLastRaidIMG) = $GUI_CHECKED Then
		$NotifyAlerLastRaidIMG = 1
	Else
		$NotifyAlerLastRaidIMG = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertUpgradeWall) = $GUI_CHECKED Then
		$NotifyAlertUpgradeWalls = 1
	Else
		$NotifyAlertUpgradeWalls = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertOutOfSync) = $GUI_CHECKED Then
		$NotifyAlertOutOfSync = 1
	Else
		$NotifyAlertOutOfSync = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertAnotherDevice) = $GUI_CHECKED Then
		$NotifyAlertAnotherDevice = 1
	Else
		$NotifyAlertAnotherDevice = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertBuilderIdle) = $GUI_CHECKED Then
		$NotifyAlertBulderIdle = 1
	Else
		$NotifyAlertBulderIdle = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertMaintenance) = $GUI_CHECKED Then
		$NotifyAlertMaintenance = 1
	Else
		$NotifyAlertMaintenance = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertBAN) = $GUI_CHECKED Then
		$NotifyAlertBAN = 1
	Else
		$NotifyAlertBAN = 0
	EndIf

	If GUICtrlRead($chkNotifyBOTUpdate) = $GUI_CHECKED Then
		$NotifyAlertBOTUpdate = 1
	Else
		$NotifyAlertBOTUpdate = 0
	EndIf

	If GUICtrlRead($chkNotifyDeleteOldPBPushes) = $GUI_CHECKED Then
		$NotifyDeletePushesOlderThan = 1
	Else
		$NotifyDeletePushesOlderThan = 0
	EndIf

	$NotifyPBToken = GUICtrlRead($txbNotifyPBToken)
	$NotifyTGToken = GUICtrlRead($txbNotifyTGToken)
	$NotifyOrigin = GUICtrlRead($txbNotifyOrigin)

	If GUICtrlRead($chkNotifyAlertLastRaidTXT) = $GUI_CHECKED Then
		$NotifyAlerLastRaidTXT = 1
	Else
		$NotifyAlerLastRaidTXT = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertLastAttack) = $GUI_CHECKED Then
		$NotifyAlertLastAttack = 1
	Else
		$NotifyAlertLastAttack = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertCampFull) = $GUI_CHECKED Then
		$NotifyAlertCampFull = 1
	Else
		$NotifyAlertCampFull = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertVillageStats) = $GUI_CHECKED Then
		$NotifyAlertVillageReport = 1
	Else
		$NotifyAlertVillageReport = 0
	EndIf

	If GUICtrlRead($chkNotifyAlertTakeBreak) = $GUI_CHECKED Then
		$NotifyAlertTakeBreak = 1
	Else
		$NotifyAlertTakeBreak = 0
	EndIf

	; halt&resume gui -> variables ---------------------------------------------------
	If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
		$ichkBotStop = 1
	Else
		$ichkBotStop = 0
	EndIf
	$icmbBotCommand = _GUICtrlComboBox_GetCurSel($cmbBotCommand)
	$icmbBotCond = _GUICtrlComboBox_GetCurSel($cmbBotCond)
	$icmbHoursStop = _GUICtrlComboBox_GetCurSel($cmbHoursStop)

	$sTimeWakeUp = Int(GUICtrlRead($txtTimeWakeUp)) * 60 ; Minutes are entered

	$itxtRestartGold = GUICtrlRead($txtRestartGold)
	$itxtRestartElixir = GUICtrlRead($txtRestartElixir)
	$itxtRestartDark = GUICtrlRead($txtRestartDark)

	; bot options gui -> variables ----------------------------------------------------
	If GUICtrlRead($chkDisableSplash) = $GUI_CHECKED Then
		$ichkDisableSplash = 1
	Else
		$ichkDisableSplash = 0
	EndIf
	If GUICtrlRead($chkVersion) = $GUI_CHECKED Then
		$ichkVersion = 1
	Else
		$ichkVersion = 0
	EndIf
	If GUICtrlRead($chkDeleteLogs) = $GUI_CHECKED Then
		$ichkDeleteLogs = 1
	Else
		$ichkDeleteLogs = 0
	EndIf
	$iDeleteLogsDays = GUICtrlRead($txtDeleteLogsDays)
	If GUICtrlRead($chkDeleteTemp) = $GUI_CHECKED Then
		$ichkDeleteTemp = 1
	Else
		$ichkDeleteTemp = 0
	EndIf
	$iDeleteTempDays = GUICtrlRead($txtDeleteTempDays)
	If GUICtrlRead($chkDeleteLoots) = $GUI_CHECKED Then
		$ichkDeleteLoots = 1
	Else
		$ichkDeleteLoots = 0
	EndIf
	$iDeleteLootsDays = GUICtrlRead($txtDeleteLootsDays)

	If GUICtrlRead($chkAutoStart) = $GUI_CHECKED Then
		$ichkAutoStart = 1
	Else
		$ichkAutoStart = 0
	EndIf
	$ichkAutoStartDelay = GUICtrlRead($txtAutoStartDelay)
	If GUICtrlRead($ChkLanguage) = $GUI_CHECKED Then
		$ichkLanguage = 1
	Else
		$ichkLanguage = 0
	EndIf
	If GUICtrlRead($chkDisposeWindows) = $GUI_CHECKED Then
		$iDisposeWindows = 1
	Else
		$iDisposeWindows = 0
	EndIf
	$icmbDisposeWindowsPos = _GUICtrlComboBox_GetCurSel($cmbDisposeWindowsCond)
	$iWAOffsetX = GUICtrlRead($txtWAOffsetX)
	$iWAOffsetY = GUICtrlRead($txtWAOffsetY)

	If GUICtrlRead($chkDebugClick) = $GUI_CHECKED Then
		$debugClick = 1
	Else
		$debugClick = 0
	EndIf
	If $devmode = 1 Then
		If GUICtrlRead($chkDebugSetlog) = $GUI_CHECKED Then
			$DebugSetlog = 1
		Else
			$DebugSetlog = 0
		EndIf
		If GUICtrlRead($chkDebugDisableZoomout) = $GUI_CHECKED Then
			$debugDisableZoomout = 1
		Else
			$debugDisableZoomout = 0
		EndIf
		If GUICtrlRead($chkDebugDisableVillageCentering) = $GUI_CHECKED Then
			$debugDisableVillageCentering = 1
		Else
			$debugDisableVillageCentering = 0
		EndIf
		If GUICtrlRead($chkDebugDeadbaseImage) = $GUI_CHECKED Then
			$debugDeadbaseImage = 1
		Else
			$debugDeadbaseImage = 0
		EndIf
		If GUICtrlRead($chkDebugOcr) = $GUI_CHECKED Then
			$debugOcr = 1
		Else
			$debugOcr = 0
		EndIf
		If GUICtrlRead($chkDebugImageSave) = $GUI_CHECKED Then
			$DebugImageSave = 1
		Else
			$DebugImageSave = 0
		EndIf
		If GUICtrlRead($chkdebugBuildingPos) = $GUI_CHECKED Then
			$debugBuildingPos = 1
		Else
			$debugBuildingPos = 0
		EndIf
		If GUICtrlRead($chkdebugTrain) = $GUI_CHECKED Then
			$debugsetlogTrain = 1
		Else
			$debugsetlogTrain = 0
		EndIf
		If GUICtrlRead($chkdebugOCRDonate) = $GUI_CHECKED Then
			$debugOCRdonate = 1
		Else
			$debugOCRdonate = 0
		EndIf
		If GUICtrlRead($chkdebugAttackCSV) = $GUI_CHECKED Then
			$debugAttackCSV = 1
		Else
			$debugAttackCSV = 0
		EndIf
		If GUICtrlRead($chkmakeIMGCSV ) = $GUI_CHECKED Then
			$makeIMGCSV  = 1
		Else
			$makeIMGCSV  = 0
		EndIf
	EndIf

	If GUICtrlRead($hChk_UseQTrain) = $GUI_CHECKED Then
		$ichkUseQTrain = 1
	Else
		$ichkUseQTrain = 0
	EndIf

	If GUICtrlRead($chkForceBrewBeforeAttack) = $GUI_CHECKED Then
		$ichkForceBrewBeforeAttack = 1
	Else
		$ichkForceBrewBeforeAttack = 0
	EndIf

	If GUICtrlRead($chkTotalCampForced) = $GUI_CHECKED Then
		$ichkTotalCampForced = 1
	Else
		$ichkTotalCampForced = 0
	EndIf
	$iValueTotalCampForced = GUICtrlRead($txtTotalCampForced)

	If GUICtrlRead($chkSinglePBTForced) = $GUI_CHECKED Then
		$ichkSinglePBTForced = 1
	Else
		$ichkSinglePBTForced = 0
	EndIf
	$iValueSinglePBTimeForced = GUICtrlRead($txtSinglePBTimeForced)
	$iValuePBTimeForcedExit = GUICtrlRead($txtPBTimeForcedExit)

	If GUICtrlRead($chkUseRandomClick) = $GUI_CHECKED Then
		$iUseRandomClick = 1
	Else
		$iUseRandomClick = 0
	EndIf

	If GUICtrlRead($chkAddDelayIdlePhaseEnable) = $GUI_CHECKED Then
		$ichkAddIdleTime = 1
	Else
		$ichkAddIdleTime = 0
	EndIf

	If GUICtrlRead($chkScreenshotType) = $GUI_CHECKED Then
		$iScreenshotType = 1
	Else
		$iScreenshotType = 0
	EndIf
	If GUICtrlRead($chkScreenshotHideName) = $GUI_CHECKED Then
		$ichkScreenshotHideName = 1
	Else
		$ichkScreenshotHideName = 0
	EndIf
	$iVSDelay = GUICtrlRead($sldVSDelay)
	$iMaxVSDelay = GUICtrlRead($sldMaxVSDelay)
	$isldTrainITDelay = GUICtrlRead($sldTrainITDelay)

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		$AlertSearch = 1
	Else
		$AlertSearch = 0
	EndIf

	; boost barracks gui -> variables -------------------------------------------------
	$icmbQuantBoostBarracks = GUICtrlRead($cmbQuantBoostBarracks)
	$icmbBoostBarracks = GUICtrlRead($cmbBoostBarracks)
	$icmbBoostSpellFactory = GUICtrlRead($cmbBoostSpellFactory)
	$icmbBoostDarkSpellFactory = GUICtrlRead($cmbBoostDarkSpellFactory)
	$icmbBoostBarbarianKing = GUICtrlRead($cmbBoostBarbarianKing)
	$icmbBoostArcherQueen = GUICtrlRead($cmbBoostArcherQueen)
	$icmbBoostWarden = GUICtrlRead($cmbBoostWarden)

	For $i = 0 To 23
		If GUICtrlRead(Eval("chkBoostBarracksHours" & $i)) = $GUI_CHECKED Then
			$iPlannedBoostBarracksHours[$i] = 1
		Else
			$iPlannedBoostBarracksHours[$i] = 0
		EndIf
	Next

	; reduction gui -> variables ------------------------------------------------------
	$ReduceCount = GUICtrlRead($txtSearchReduceCount)
	$ReduceGold = GUICtrlRead($txtSearchReduceGold)
	$ReduceElixir = GUICtrlRead($txtSearchReduceElixir)
	$ReduceGoldPlusElixir = GUICtrlRead($txtSearchReduceGoldPlusElixir)
	$ReduceDark = GUICtrlRead($txtSearchReduceDark)
	$ReduceTrophy = GUICtrlRead($txtSearchReduceTrophy)

	; th bully gui -> variables -------------------------------------------------------
	$ATBullyMode = GUICtrlRead($txtATBullyMode)
	$YourTH = _GUICtrlComboBox_GetCurSel($cmbYourTH)
	If GUICtrlRead($radUseDBAttack) = $GUI_CHECKED Then
		$iTHBullyAttackMode = 0
	Else
		$iTHBullyAttackMode = 1
	EndIf
	; tropies gui -> variables ---------------------------------------------------------
	$itxtMaxTrophy = GUICtrlRead($txtMaxTrophy)
	$itxtdropTrophy = GUICtrlRead($txtdropTrophy)
	If GUICtrlRead($chkTrophyRange) = $GUI_CHECKED Then
		$iChkTrophyRange = 1
	Else
		$iChkTrophyRange = 0
	EndIf
	If GUICtrlRead($chkTrophyHeroes) = $GUI_CHECKED Then
		$iChkTrophyHeroes = 1
	Else
		$iChkTrophyHeroes = 0
    EndIf
	IniWriteS($config, "search", "cmbTrophyHeroesPriority", _GUICtrlComboBox_GetCurSel($cmbTrophyHeroesPriority))


	If GUICtrlRead($chkTrophyAtkDead) = $GUI_CHECKED Then
		$iChkTrophyAtkDead = 1
	Else
		$iChkTrophyAtkDead = 0
	EndIf
	$itxtDTArmyMin = GUICtrlRead($txtDTArmyMin)

	; end battle AB options gui -> variables ----------------------------------------
	If GUICtrlRead($chkDESideEB) = $GUI_CHECKED Then
		$DESideEB = 1
	Else
		$DESideEB = 0
	EndIf
	$DELowEndMin = GUICtrlRead($txtDELowEndMin)
	If GUICtrlRead($chkDisableOtherEBO) = $GUI_CHECKED Then
		$DisableOtherEBO = 1
	Else
		$DisableOtherEBO = 0
	EndIf
	If GUICtrlRead($chkDEEndAq) = $GUI_CHECKED Then
		$DEEndAq = 1
	Else
		$DEEndAq = 0
	EndIf
	If GUICtrlRead($chkDEEndBk) = $GUI_CHECKED Then
		$DEEndBk = 1
	Else
		$DEEndBk = 0
	EndIf
	If GUICtrlRead($chkDEEndOneStar) = $GUI_CHECKED Then
		$DEEndOneStar = 1
	Else
		$DEEndOneStar = 0
	EndIf

	; Milking GUI -> variables ------------------------------------------------------
	;1 Elixir Collectors Minimum Level
	Local $TempMilkFarmElixirParam = ""
	For $i = 0 To 8
		$TempMilkFarmElixirParam &= _GUICtrlComboBox_GetCurSel(Eval("cmbMilkLvl" & $i + 4)) - 1 & "|"
	Next
	$MilkFarmElixirParam = StringSplit(StringLeft($TempMilkFarmElixirParam, StringLen($TempMilkFarmElixirParam) - 1), "|", 2)

	;2. If Elixir Collectors Found, Then
	If GUICtrlRead($chkAtkElixirExtractors) = $GUI_CHECKED Then
		$MilkFarmLocateElixir = 1
	Else
		$MilkFarmLocateElixir = 0
	EndIf

	If GUICtrlRead($chkAtkGoldMines) = $GUI_CHECKED Then
		$MilkFarmLocateMine = 1
	Else
		$MilkFarmLocateMine = 0
	EndIf

	$MilkFarmMineParam = _GUICtrlComboBox_GetCurSel($cmbAtkGoldMinesLevel) + 1

	If GUICtrlRead($chkAtkDarkDrills) = $GUI_CHECKED Then
		$MilkFarmLocateDrill = 1
	Else
		$MilkFarmLocateDrill = 0
	EndIf

	$MilkFarmDrillParam = _GUICtrlComboBox_GetCurSel($cmbAtkDarkDrillsLevel) + 1

	;3. Only Attack If
	$MilkFarmResMaxTilesFromBorder = _GUICtrlComboBox_GetCurSel($cmbRedlineResDistance)

	If GUICtrlRead($chkAttackMinesifGold) = $GUI_CHECKED Then
		$MilkFarmAttackGoldMines = 1
	Else
		$MilkFarmAttackGoldMines = 0
	EndIf

	If GUICtrlRead($chkAttackMinesifElixir) = $GUI_CHECKED Then
		$MilkFarmAttackElixirExtractors = 1
	Else
		$MilkFarmAttackElixirExtractors = 0
	EndIf

	If GUICtrlRead($chkAttackMinesifDarkElixir) = $GUI_CHECKED Then
		$MilkFarmAttackDarkDrills = 1
	Else
		$MilkFarmAttackDarkDrills = 0
	EndIf

	$MilkFarmLimitGold = GUICtrlRead($txtAttackMinesIfGold)
	$MilkFarmLimitElixir = GUICtrlRead($txtAttackMinesifElixir)
	$MilkFarmLimitDark = GUICtrlRead($txtAttackMinesifDarkElixir)

	;4 Troops to Use For Each Resource
	$MilkFarmTroopForWaveMin = GUICtrlRead($txtLowerXWave)
	$MilkFarmTroopForWaveMax = GUICtrlRead($txtUpperXWave)
	$MilkFarmTroopMaxWaves = GUICtrlRead($txtMaxWaves)
	$MilkFarmDelayFromWavesMin = GUICtrlRead($txtLowerDelayWaves)
	$MilkFarmDelayFromWavesMax = GUICtrlRead($txtUpperDelayWaves)

	;5 Snipe Outside TH


	$MilkFarmTHMaxTilesFromBorder = GUICtrlRead($txtMaxTilesMilk)

	$MilkFarmAlgorithmTh = GUICtrlRead($cmbMilkSnipeAlgorithm)

	If GUICtrlRead($chkSnipeIfNoElixir) = $GUI_CHECKED Then
		$MilkFarmSnipeEvenIfNoExtractorsFound = 1
	Else
		$MilkFarmSnipeEvenIfNoExtractorsFound = 0
	EndIf

	If $devmode = 1 Then

		If GUICtrlRead($chkMilkingDebugIMG) = $GUI_CHECKED Then
			$debugresourcesoffset = 1
		Else
			$debugresourcesoffset = 0
		EndIf

		If GUICtrlRead($chkMilkingDebugVillage) = $GUI_CHECKED Then
			$debugMilkingIMGmake = 1
		Else
			$debugMilkingIMGmake = 0
		EndIf

		If GUICtrlRead($chkMilkingDebugFullSearch) = $GUI_CHECKED Then
			$continuesearchelixirdebug = 1
		Else
			$continuesearchelixirdebug = 0
		EndIf


	EndIf

	If GUICtrlRead($chkMilkFarmForcetolerance) = $GUI_CHECKED Then
		$MilkFarmForcetolerance = 1
	Else
		$MilkFarmForcetolerance = 0
	EndIf
	$MilkFarmForcetolerancenormal = GUICtrlRead($txtMilkFarmForcetolerancenormal)
	$MilkFarmForcetoleranceboosted = GUICtrlRead($txtMilkFarmForcetoleranceboosted)
	$MilkFarmForcetolerancedestroyed = GUICtrlRead($txtMilkFarmForcetolerancedestroyed)


	$MilkAttackType = _GUICtrlComboBox_GetCurSel($cmbMilkAttackType)

	If GUICtrlRead($chkStructureDestroyedBeforeAttack) = $GUI_CHECKED Then
		$MilkingAttackCheckStructureDestroyedBeforeAttack = 1
	Else
		$MilkingAttackCheckStructureDestroyedBeforeAttack = 0
	EndIf

	If GUICtrlRead($chkStructureDestroyedAfterAttack) = $GUI_CHECKED Then
		$MilkingAttackCheckStructureDestroyedAfterAttack = 1
	Else
		$MilkingAttackCheckStructureDestroyedAfterAttack = 0
	EndIf

	$MilkingAttackDropGoblinAlgorithm = _GUICtrlComboBox_GetCurSel($cmbMilkingAttackDropGoblinAlgorithm)
	$MilkingAttackStructureOrder = _GUICtrlComboBox_GetCurSel($cmbStructureOrder)



	;scripted attack save
	If GUICtrlRead($chkMilkAfterAttackScripted) = $GUI_CHECKED Then
		$MilkAttackAfterScriptedAtk = 1
	Else
		$MilkAttackAfterScriptedAtk = 0
	EndIf

	Local $indexofscript = _GUICtrlComboBox_GetCurSel($cmbMilkingCSVScriptName)
	Local $scriptname
	_GUICtrlComboBox_GetLBText($cmbMilkingCSVScriptName, $indexofscript, $scriptname)
	$MilkAttackCSVscript = $scriptname

	If GUICtrlRead($chkMilkAfterAttackTHSnipe) = $GUI_CHECKED Then
		$MilkAttackAfterTHSnipe = 1
	Else
		$MilkAttackAfterTHSnipe = 0
	EndIf

	; standard attack options ----------------------------------------------------------------
	$iCmbStandardAlgorithm[$DB] = _GUICtrlComboBox_GetCurSel($cmbStandardAlgorithmDB)
	$iChkDeploySettings[$DB] = _GUICtrlComboBox_GetCurSel($cmbDeployDB)
	$iCmbUnitDelay[$DB] = _GUICtrlComboBox_GetCurSel($cmbUnitDelayDB)
	$iCmbWaveDelay[$DB] = _GUICtrlComboBox_GetCurSel($cmbWaveDelayDB)
	If GUICtrlRead($chkRandomSpeedAtkDB) = $GUI_CHECKED Then
		$iChkRandomspeedatk[$DB] = 1
	Else
		$iChkRandomspeedatk[$DB] = 0
	EndIf
	If GUICtrlRead($chkSmartAttackRedAreaDB) = $GUI_CHECKED Then
		$iChkRedArea[$DB] = 1
	Else
		$iChkRedArea[$DB] = 0
	EndIf

	$iCmbSmartDeploy[$DB] = _GUICtrlComboBox_GetCurSel($cmbSmartDeployDB)

	If GUICtrlRead($chkAttackNearGoldMinEDB) = $GUI_CHECKED Then
		$iChkSmartAttack[$DB][0] = 1
	Else
		$iChkSmartAttack[$DB][0] = 0
	EndIf
	If GUICtrlRead($chkAttackNearElixirCollectorDB) = $GUI_CHECKED Then
		$iChkSmartAttack[$DB][1] = 1
	Else
		$iChkSmartAttack[$DB][1] = 0
	EndIf
	If GUICtrlRead($chkAttackNearDarkElixirDrillDB) = $GUI_CHECKED Then
		$iChkSmartAttack[$DB][2] = 1
	Else
		$iChkSmartAttack[$DB][2] = 0
	EndIf

	If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
		$chkATH = 1
	Else
		$chkATH = 0
	EndIf

	$iCmbStandardAlgorithm[$LB] = _GUICtrlComboBox_GetCurSel($cmbStandardAlgorithmAB)
	$iChkDeploySettings[$LB] = _GUICtrlComboBox_GetCurSel($cmbDeployAB)
	$iCmbUnitDelay[$LB] = _GUICtrlComboBox_GetCurSel($cmbUnitDelayAB)
	$iCmbWaveDelay[$LB] = _GUICtrlComboBox_GetCurSel($cmbWaveDelayAB)
	If GUICtrlRead($chkRandomSpeedAtkAB) = $GUI_CHECKED Then
		$iChkRandomspeedatk[$LB] = 1
	Else
		$iChkRandomspeedatk[$LB] = 0
	EndIf
	If GUICtrlRead($chkSmartAttackRedAreaAB) = $GUI_CHECKED Then
		$iChkRedArea[$LB] = 1
	Else
		$iChkRedArea[$LB] = 0
	EndIf

	$iCmbSmartDeploy[$LB] = _GUICtrlComboBox_GetCurSel($cmbSmartDeployAB)

	If GUICtrlRead($chkAttackNearGoldMineAB) = $GUI_CHECKED Then
		$iChkSmartAttack[$LB][0] = 1
	Else
		$iChkSmartAttack[$LB][0] = 0
	EndIf
	If GUICtrlRead($chkAttackNearElixirCollectorAB) = $GUI_CHECKED Then
		$iChkSmartAttack[$LB][1] = 1
	Else
		$iChkSmartAttack[$LB][1] = 0
	EndIf
	If GUICtrlRead($chkAttackNearDarkElixirDrillAB) = $GUI_CHECKED Then
		$iChkSmartAttack[$LB][2] = 1
	Else
		$iChkSmartAttack[$LB][2] = 0
	EndIf

	; attackcsv gui -> variables--------------------------------------------------------
	Local $indexofscript = _GUICtrlComboBox_GetCurSel($cmbScriptNameDB)
	Local $scriptname
	_GUICtrlComboBox_GetLBText($cmbScriptNameDB, $indexofscript, $scriptname)
	$scmbDBScriptName = $scriptname

	Local $indexofscript = _GUICtrlComboBox_GetCurSel($cmbScriptNameAB)
	Local $scriptname
	_GUICtrlComboBox_GetLBText($cmbScriptNameAB, $indexofscript, $scriptname)
	$scmbABScriptName = $scriptname

	SetDebugLog("Save Config " & $config)

	; collectors gui -> variables --------------------------------------------------

	For $collectorLevel = 6 To 12
		If GUICtrlRead(Eval("chkLvl" & $collectorLevel)) = $GUI_CHECKED Then
			Assign("chkLvl" & $collectorLevel & "Enabled", 1)
		Else
			Assign("chkLvl" & $collectorLevel & "Enabled", 0)
		EndIf

		Assign("cmbLvl" & $collectorLevel & "Fill", _GUICtrlComboBox_GetCurSel(Eval("cmbLvl" & $collectorLevel)))
	Next
	IniWriteS($config, "collectors", "tolerance", GUICtrlRead($sldCollectorTolerance))

	; replayshare GUI -> variables -------------------------------------------------
	$iShareminGold = GUICtrlRead($txtShareMinGold)
	$iShareminElixir = GUICtrlRead($txtShareMinElixir)
	$iShareminDark = GUICtrlRead($txtShareMinDark)
	$sShareMessage = GUICtrlRead($txtShareMessage)

	; Write the stats arrays to the stat files
	saveWeakBaseStats()


	;General Settings--------------------------------------------------------------------------

	Local $hFile = -1
	If $ichkExtraAlphabets = 1 Or $ichkExtraChinese = 1 Then $hFile = FileOpen($config, $FO_UTF16_LE + $FO_OVERWRITE)

	IniWriteS($config, "general", "version", GetVersionNormalized($sBotVersion))
	IniWriteS($config, "general", "cmbProfile", _GUICtrlComboBox_GetCurSel($cmbProfile))
	IniWriteS($config, "general", "frmBotPosX", $frmBotPosX)
	IniWriteS($config, "general", "frmBotPosY", $frmBotPosY)
	; read now android position again, as it might have changed
	If $HWnD <> 0 Then WinGetAndroidHandle()
	IniWriteS($config, "general", "AndroidPosX", $AndroidPosX)
	IniWriteS($config, "general", "AndroidPosY", $AndroidPosY)
	IniWriteS($config, "general", "frmBotDockedPosX", $frmBotDockedPosX)
	IniWriteS($config, "general", "frmBotDockedPosY", $frmBotDockedPosY)
	IniWriteS($config, "general", "UpdatingWhenMinimized", $iUpdatingWhenMinimized)
	IniWriteS($config, "general", "HideWhenMinimized", $iHideWhenMinimized)
	IniWriteS($config, "general", "villageName", GUICtrlRead($txtVillageName))

	IniWriteS($config, "general", "logstyle", _GUICtrlComboBox_GetCurSel($cmbLog))
	IniWriteS($config, "general", "LogDividerY", $iDividerY)

	IniWriteS($config, "general", "AutoStart", $ichkAutoStart)
	IniWriteS($config, "general", "AutoStartDelay", $ichkAutoStartDelay)



	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		IniWriteS($config, "general", "Background", 1)
	Else
		IniWriteS($config, "general", "Background", 0)
	EndIf

	;Halt bot conditions
	IniWriteS($config, "general", "BotStop", $ichkBotStop)
	IniWriteS($config, "general", "Command", $icmbBotCommand)
	IniWriteS($config, "general", "Cond", $icmbBotCond)
	IniWriteS($config, "general", "Hour", $icmbHoursStop)


	IniWriteS($config, "general", "DisposeWindows", $iDisposeWindows)
	IniWriteS($config, "general", "DisposeWindowsPos", $icmbDisposeWindowsPos)

	IniWriteS($config, "general", "GUIStyle", $iGUIStyle)

	IniWriteS($config, "general", "RedrawBotWindowMode", $RedrawBotWindowMode)

	;Search Settings------------------------------------------------------------------------

	IniWriteS($config, "general", "AlertSearch", $AlertSearch)

	IniWriteS($config, "search", "DBMeetGE", _GUICtrlComboBox_GetCurSel($cmbDBMeetGE))

	If GUICtrlRead($chkDBMeetDE) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetDE", 1)
	Else
		IniWriteS($config, "search", "DBMeetDE", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTrophy) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetTrophy", 1)
	Else
		IniWriteS($config, "search", "DBMeetTrophy", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTH) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetTH", 1)
	Else
		IniWriteS($config, "search", "DBMeetTH", 0)
	EndIf

	If GUICtrlRead($chkDBMeetTHO) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetTHO", 1)
	Else
		IniWriteS($config, "search", "DBMeetTHO", 0)
	EndIf

	; weak base gui -> variables ----------------------------------------------------
	$iCmbWeakMortar[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakMortar[$DB])
	$iCmbWeakWizTower[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakWizTower[$DB])
	$iCmbWeakAirDefense[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakAirDefense[$DB])
	$iCmbWeakXBow[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakXBow[$DB])
	$iCmbWeakInferno[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakInferno[$DB])
	$iCmbWeakEagle[$DB] = _GUICtrlComboBox_GetCurSel($cmbWeakEagle[$DB])

	$iCmbWeakMortar[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakMortar[$LB])
	$iCmbWeakWizTower[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakWizTower[$LB])
	$iCmbWeakAirDefense[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakAirDefense[$LB])
	$iCmbWeakXBow[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakXBow[$LB])
	$iCmbWeakInferno[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakInferno[$LB])
	$iCmbWeakEagle[$LB] = _GUICtrlComboBox_GetCurSel($cmbWeakEagle[$LB])

	; Assign Weakbase enabled GUI defense types to variables
	For $mode = $DB To $iModeCount - 1
		If GUICtrlRead($chkMaxMortar[$mode]) = $GUI_CHECKED Then
			$iChkMaxMortar[$mode] = 1
		Else
			$iChkMaxMortar[$mode] = 0
		EndIf
		If GUICtrlRead($chkMaxWizTower[$mode]) = $GUI_CHECKED Then
			$iChkMaxWizTower[$mode] = 1
		Else
			$iChkMaxWizTower[$mode] = 0
		EndIf
		If GUICtrlRead($chkMaxAirDefense[$mode]) = $GUI_CHECKED Then
			$iChkMaxAirDefense[$mode] = 1
		Else
			$iChkMaxAirDefense[$mode] = 0
		EndIf
		If GUICtrlRead($chkMaxXBow[$mode]) = $GUI_CHECKED Then
			$iChkMaxXBow[$mode] = 1
		Else
			$iChkMaxXBow[$mode] = 0
		EndIf
		If GUICtrlRead($chkMaxInferno[$mode]) = $GUI_CHECKED Then
			$iChkMaxInferno[$mode] = 1
		Else
			$iChkMaxInferno[$mode] = 0
		EndIf
		If GUICtrlRead($chkMaxEagle[$mode]) = $GUI_CHECKED Then
			$iChkMaxEagle[$mode] = 1
		Else
			$iChkMaxEagle[$mode] = 0
		EndIf
	Next


	If GUICtrlRead($chkDBMeetOne) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBMeetOne", 1)
	Else
		IniWriteS($config, "search", "DBMeetOne", 0)
	EndIf

	IniWriteS($config, "search", "DBEnableAfterCount", GUICtrlRead($txtDBSearchesMin))
	IniWriteS($config, "search", "DBEnableBeforeCount", GUICtrlRead($txtDBSearchesMax))
	IniWriteS($config, "search", "DBEnableAfterTropies", GUICtrlRead($txtDBTropiesMin))
	IniWriteS($config, "search", "DBEnableBeforeTropies", GUICtrlRead($txtDBTropiesMax))
	IniWriteS($config, "search", "DBEnableAfterArmyCamps", GUICtrlRead($txtDBArmyCamps))
	IniWriteS($config, "search", "DBsearchGold", GUICtrlRead($txtDBMinGold))
	IniWriteS($config, "search", "DBsearchElixir", GUICtrlRead($txtDBMinElixir))
	IniWriteS($config, "search", "DBsearchGoldPlusElixir", GUICtrlRead($txtDBMinGoldPlusElixir))
	IniWriteS($config, "search", "DBsearchDark", GUICtrlRead($txtDBMinDarkElixir))
	IniWriteS($config, "search", "DBsearchTrophy", GUICtrlRead($txtDBMinTrophy))
	IniWriteS($config, "search", "DBTHLevel", _GUICtrlComboBox_GetCurSel($cmbDBTH))

	IniWriteS($config, "search", "DBWeakMortar", $iCmbWeakMortar[$DB])
	IniWriteS($config, "search", "DBWeakWizTower", $iCmbWeakWizTower[$DB])
	IniWriteS($config, "search", "DBWeakXBow", $iCmbWeakXBow[$DB])
	IniWriteS($config, "search", "DBWeakInferno", $iCmbWeakInferno[$DB])
	IniWriteS($config, "search", "DBWeakEagle", $iCmbWeakEagle[$DB])
	IniWriteS($config, "search", "DBWeakAirDefense", $iCmbWeakAirDefense[$DB])

	IniWriteS($config, "search", "DBCheckMortar", $iChkMaxMortar[$DB])
	IniWriteS($config, "search", "DBCheckWizTower", $iChkMaxWizTower[$DB])
	IniWriteS($config, "search", "DBCheckAirDefense", $iChkMaxAirDefense[$DB])
	IniWriteS($config, "search", "DBCheckXBow", $iChkMaxXBow[$DB])
	IniWriteS($config, "search", "DBCheckInferno", $iChkMaxInferno[$DB])
	IniWriteS($config, "search", "DBCheckEagle", $iChkMaxEagle[$DB])

	If GUICtrlRead($DBcheck) = $GUI_CHECKED Then
		IniWriteS($config, "search", "DBcheck", 1)
	Else
		IniWriteS($config, "search", "DBcheck", 0)
	EndIf

	If GUICtrlRead($ABcheck) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABcheck", 1)
	Else
		IniWriteS($config, "search", "ABcheck", 0)
	EndIf

	If GUICtrlRead($TScheck) = $GUI_CHECKED Then
		IniWriteS($config, "search", "TScheck", 1)
	Else
		IniWriteS($config, "search", "TScheck", 0)
	EndIf

	If GUICtrlRead($chkDBActivateSearches) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBSearchSearches", 1)
	Else
		IniWriteS($config, "search", "ChkDBSearchSearches", 0)
	EndIf

	If GUICtrlRead($chkABActivateSearches) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABSearchSearches", 1)
	Else
		IniWriteS($config, "search", "ChkABSearchSearches", 0)
	EndIf

	If GUICtrlRead($chkTSActivateSearches) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkTSSearchSearches", 1)
	Else
		IniWriteS($config, "search", "ChkTSSearchSearches", 0)
	EndIf

	If GUICtrlRead($chkDBActivateTropies) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBSearchTropies", 1)
	Else
		IniWriteS($config, "search", "ChkDBSearchTropies", 0)
	EndIf

	If GUICtrlRead($chkABActivateTropies) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABSearchTropies", 1)
	Else
		IniWriteS($config, "search", "ChkABSearchTropies", 0)
	EndIf

	If GUICtrlRead($chkTSActivateTropies) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkTSSearchTropies", 1)
	Else
		IniWriteS($config, "search", "ChkTSSearchTropies", 0)
	EndIf

	If GUICtrlRead($chkDBActivateCamps) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBSearchCamps", 1)
	Else
		IniWriteS($config, "search", "ChkDBSearchCamps", 0)
	EndIf

	If GUICtrlRead($chkABActivateCamps) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABSearchCamps", 1)
	Else
		IniWriteS($config, "search", "ChkABSearchCamps", 0)
	EndIf

	If GUICtrlRead($chkTSActivateCamps) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkTSSearchCamps", 1)
	Else
		IniWriteS($config, "search", "ChkTSSearchCamps", 0)
	EndIf

	IniWriteS($config, "search", "ABMeetGE", _GUICtrlComboBox_GetCurSel($cmbABMeetGE))

	If GUICtrlRead($chkABMeetDE) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABMeetDE", 1)
	Else
		IniWriteS($config, "search", "ABMeetDE", 0)
	EndIf

	If GUICtrlRead($chkABMeetTrophy) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABMeetTrophy", 1)
	Else
		IniWriteS($config, "search", "ABMeetTrophy", 0)
	EndIf

	If GUICtrlRead($chkABMeetTH) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABMeetTH", 1)
	Else
		IniWriteS($config, "search", "ABMeetTH", 0)
	EndIf

	If GUICtrlRead($chkABMeetTHO) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABMeetTHO", 1)
	Else
		IniWriteS($config, "search", "ABMeetTHO", 0)
	EndIf

	If GUICtrlRead($chkABMeetOne) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ABMeetOne", 1)
	Else
		IniWriteS($config, "search", "ABMeetOne", 0)
	EndIf

	IniWriteS($config, "search", "ABEnableAfterCount", GUICtrlRead($txtABSearchesMin))
	IniWriteS($config, "search", "ABEnableBeforeCount", GUICtrlRead($txtABSearchesMax))
	IniWriteS($config, "search", "ABEnableAfterTropies", GUICtrlRead($txtABTropiesMin))
	IniWriteS($config, "search", "ABEnableBeforeTropies", GUICtrlRead($txtABTropiesMax))
	IniWriteS($config, "search", "ABEnableAfterArmyCamps", GUICtrlRead($txtABArmyCamps))

	IniWriteS($config, "search", "ABsearchGold", GUICtrlRead($txtABMinGold))
	IniWriteS($config, "search", "ABsearchElixir", GUICtrlRead($txtABMinElixir))
	IniWriteS($config, "search", "ABsearchGoldPlusElixir", GUICtrlRead($txtABMinGoldPlusElixir))
	IniWriteS($config, "search", "ABsearchDark", GUICtrlRead($txtABMinDarkElixir))
	IniWriteS($config, "search", "ABsearchTrophy", GUICtrlRead($txtABMinTrophy))
	IniWriteS($config, "search", "ABTHLevel", _GUICtrlComboBox_GetCurSel($cmbABTH))

	IniWriteS($config, "search", "ABWeakMortar", $iCmbWeakMortar[$LB])
	IniWriteS($config, "search", "ABWeakWizTower", $iCmbWeakWizTower[$LB])
	IniWriteS($config, "search", "ABWeakXBow", $iCmbWeakXBow[$LB])
	IniWriteS($config, "search", "ABWeakInferno", $iCmbWeakInferno[$LB])
	IniWriteS($config, "search", "ABWeakEagle", $iCmbWeakEagle[$LB])
	IniWriteS($config, "search", "ABWeakAirDefense", $iCmbWeakAirDefense[$LB])

	IniWriteS($config, "search", "ABCheckMortar", $iChkMaxMortar[$LB])
	IniWriteS($config, "search", "ABCheckWizTower", $iChkMaxWizTower[$LB])
	IniWriteS($config, "search", "ABCheckAirDefense", $iChkMaxAirDefense[$LB])
	IniWriteS($config, "search", "ABCheckXBow", $iChkMaxXBow[$LB])
	IniWriteS($config, "search", "ABCheckInferno", $iChkMaxInferno[$LB])
	IniWriteS($config, "search", "ABCheckEagle", $iChkMaxEagle[$LB])

	If GUICtrlRead($chkSearchReduction) = $GUI_CHECKED Then
		IniWriteS($config, "search", "reduction", 1)
	Else
		IniWriteS($config, "search", "reduction", 0)
	EndIf

	IniWriteS($config, "search", "reduceCount", $ReduceCount)
	IniWriteS($config, "search", "reduceGold", $ReduceGold)
	IniWriteS($config, "search", "reduceElixir", $ReduceElixir)
	IniWriteS($config, "search", "reduceGoldPlusElixir", $ReduceGoldPlusElixir)
	IniWriteS($config, "search", "reduceDark", $ReduceDark)
	IniWriteS($config, "search", "reduceTrophy", $ReduceTrophy)


	If GUICtrlRead($ChkRestartSearchLimit) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkRestartSearchLimit", 1)
	Else
		IniWriteS($config, "search", "ChkRestartSearchLimit", 0)
	EndIf
	IniWriteS($config, "search", "RestartSearchLimit", GUICtrlRead($TxtRestartSearchlimit))

	If GUICtrlRead($chkDeadBaseDisableCollectorsFilter) = $GUI_CHECKED Then
		IniWriteS($config, "search", "chkDisableCollectorsFilter", 1)
	Else
		IniWriteS($config, "search", "chkDisableCollectorsFilter", 0)
	EndIf


	;Attack Basic Settings-------------------------------------------------------------------------

	IniWriteS($config, "attack", "DBAtkAlgorithm", _GUICtrlComboBox_GetCurSel($cmbDBAlgorithm))
	IniWriteS($config, "attack", "ABAtkAlgorithm", _GUICtrlComboBox_GetCurSel($cmbABAlgorithm))

	IniWriteS($config, "attack", "DBSelectTroop", _GUICtrlComboBox_GetCurSel($cmbDBSelectTroop))
	IniWriteS($config, "attack", "ABSelectTroop", _GUICtrlComboBox_GetCurSel($cmbABSelectTroop))
	IniWriteS($config, "attack", "TSSelectTroop", _GUICtrlComboBox_GetCurSel($cmbTSSelectTroop))

	IniWriteS($config, "attack", "DBStandardAlgorithm", $icmbStandardAlgorithm[$DB])
	IniWriteS($config, "attack", "LBStandardAlgorithm", $icmbStandardAlgorithm[$LB])

	IniWriteS($config, "attack", "DBDeploy", $iChkDeploySettings[$DB])
	IniWriteS($config, "attack", "DBUnitD", $iCmbUnitDelay[$DB])
	IniWriteS($config, "attack", "DBWaveD", $iCmbWaveDelay[$DB])
	IniWriteS($config, "attack", "DBRandomSpeedAtk", $iChkRandomspeedatk[$DB])
	IniWriteS($config, "attack", "DBSmartAttackGoldMine", $iChkSmartAttack[$DB][0])
	IniWriteS($config, "attack", "DBSmartAttackElixirCollector", $iChkSmartAttack[$DB][1])
	IniWriteS($config, "attack", "DBSmartAttackDarkElixirDrill", $iChkSmartAttack[$DB][2])
	IniWriteS($config, "attack", "DBSmartAttackRedArea", $iChkRedArea[$DB])
	IniWriteS($config, "attack", "DBSmartAttackGoldMine", $iChkSmartAttack[$DB][0])
	IniWriteS($config, "attack", "$chkDBAttackNearElixirCollector", $iChkSmartAttack[$DB][1])
	IniWriteS($config, "attack", "$chkDBAttackNearDarkElixirDrill", $iChkSmartAttack[$DB][2])
	IniWriteS($config, "attack", "DBSmartAttackDeploy", $iCmbSmartDeploy[$DB])

	IniWriteS($config, "attack", "ABDeploy", $iChkDeploySettings[$LB])
	IniWriteS($config, "attack", "ABUnitD", $iCmbUnitDelay[$LB])
	IniWriteS($config, "attack", "ABWaveD", $iCmbWaveDelay[$LB])
	IniWriteS($config, "attack", "ABRandomSpeedAtk", $iChkRandomspeedatk[$LB])
	IniWriteS($config, "attack", "ABSmartAttackGoldMine", $iChkSmartAttack[$LB][0])
	IniWriteS($config, "attack", "ABSmartAttackElixirCollector", $iChkSmartAttack[$LB][1])
	IniWriteS($config, "attack", "ABSmartAttackDarkElixirDrill", $iChkSmartAttack[$LB][2])
	IniWriteS($config, "attack", "ABSmartAttackRedArea", $iChkRedArea[$LB])
	IniWriteS($config, "attack", "ABSmartAttackGoldMine", $iChkSmartAttack[$LB][0])
	IniWriteS($config, "attack", "$chkABAttackNearElixirCollector", $iChkSmartAttack[$LB][1])
	IniWriteS($config, "attack", "$chkABAttackNearDarkElixirDrill", $iChkSmartAttack[$LB][2])
	IniWriteS($config, "attack", "ABSmartAttackDeploy", $iCmbSmartDeploy[$LB])

	If GUICtrlRead($chkDBKingAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBKingAtk", $HERO_KING)
	Else
		IniWriteS($config, "attack", "DBKingAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkDBKingWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBKingWait", $HERO_KING)
	Else
		IniWriteS($config, "attack", "DBKingWait", $HERO_NOHERO)
	EndIf

	If GUICtrlRead($chkABKingAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABKingAtk", $HERO_KING)
	Else
		IniWriteS($config, "attack", "ABKingAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkABKingWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABKingWait", $HERO_KING)
	Else
		IniWriteS($config, "attack", "ABKingWait", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkTSKingAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSKingAtk", 1)
	Else
		IniWriteS($config, "attack", "TSKingAtk", 0)
	EndIf

	If GUICtrlRead($chkDBQueenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBQueenAtk", $HERO_QUEEN)
	Else
		IniWriteS($config, "attack", "DBQueenAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkDBQueenWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBQueenWait", $HERO_QUEEN)
	Else
		IniWriteS($config, "attack", "DBQueenWait", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkABQueenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABQueenAtk", $HERO_QUEEN)
	Else
		IniWriteS($config, "attack", "ABQueenAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkABQueenWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABQueenWait", $HERO_QUEEN)
	Else
		IniWriteS($config, "attack", "ABQueenWait", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkTSQueenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSQueenAtk", 1)
	Else
		IniWriteS($config, "attack", "TSQueenAtk", 0)
	EndIf

	If GUICtrlRead($chkDBDropCC) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBDropCC", 1)
	Else
		IniWriteS($config, "attack", "DBDropCC", 0)
	EndIf


	If GUICtrlRead($chkDBWardenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBWardenAtk", $HERO_WARDEN)
	Else
		IniWriteS($config, "attack", "DBWardenAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkDBWardenWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBWardenWait", $HERO_WARDEN)
	Else
		IniWriteS($config, "attack", "DBWardenWait", $HERO_NOHERO)
	EndIf

	If GUICtrlRead($chkABWardenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABWardenAtk", $HERO_WARDEN)
	Else
		IniWriteS($config, "attack", "ABWardenAtk", $HERO_NOHERO)
	EndIf
	If GUICtrlRead($chkABWardenWait) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABWardenWait", $HERO_WARDEN)
	Else
		IniWriteS($config, "attack", "ABWardenWait", $HERO_NOHERO)
	EndIf

	If GUICtrlRead($chkTSWardenAttack) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSWardenAtk", $HERO_WARDEN)
	Else
		IniWriteS($config, "attack", "TSWardenAtk", $HERO_NOHERO)
	EndIf

	If GUICtrlRead($chkABDropCC) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABDropCC", 1)
	Else
		IniWriteS($config, "attack", "ABDropCC", 0)
	EndIf

	If GUICtrlRead($chkUseCCBalanced) = $GUI_CHECKED Then
		IniWrite($config, "attack", "BalanceCC", 1)
	Else
		IniWrite($config, "attack", "BalanceCC", 0)
	EndIf

	IniWrite($config, "attack", "BalanceCCDonated", _GUICtrlComboBox_GetCurSel($cmbCCDonated) + 1)
	IniWrite($config, "attack", "BalanceCCReceived", _GUICtrlComboBox_GetCurSel($cmbCCReceived) + 1)

	If GUICtrlRead($radManAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Manual")
	ElseIf GUICtrlRead($radAutoAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Auto")
	EndIf

	If GUICtrlRead($chkUseWardenAbility) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateWarden", 1)
	Else
		IniWrite($config, "attack", "ActivateWarden", 0)
	EndIf

	IniWrite($config, "attack", "delayActivateKQ", GUICtrlRead($txtManAbilities))
	IniWrite($config, "attack", "delayActivateW", GUICtrlRead($txtWardenAbility))

	If GUICtrlRead($chkTakeLootSS) = $GUI_CHECKED Then
		IniWrite($config, "attack", "TakeLootSnapShot", 1)
	Else
		IniWrite($config, "attack", "TakeLootSnapShot", 0)
	EndIf

	If GUICtrlRead($chkScreenshotLootInfo) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ScreenshotLootInfo", 1)
	Else
		IniWrite($config, "attack", "ScreenshotLootInfo", 0)
	EndIf

	If GUICtrlRead($chkTSDropCC) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSDropCC", 1)
	Else
		IniWriteS($config, "attack", "TSDropCC", 0)
	EndIf

	If GUICtrlRead($chkUseCCBalanced) = $GUI_CHECKED Then
		IniWriteS($config, "ClanClastle", "BalanceCC", 1)
	Else
		IniWriteS($config, "ClanClastle", "BalanceCC", 0)
	EndIf

	If GUICtrlRead($chkDBLightSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBLightSpell", 1)
	Else
		IniWriteS($config, "attack", "DBLightSpell", 0)
	EndIf
	If GUICtrlRead($chkABLightSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABLightSpell", 1)
	Else
		IniWriteS($config, "attack", "ABLightSpell", 0)
	EndIf
	If GUICtrlRead($chkTSLightSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSLightSpell", 1)
	Else
		IniWriteS($config, "attack", "TSLightSpell", 0)
	EndIf

	If GUICtrlRead($chkDBHealSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBHealSpell", 1)
	Else
		IniWriteS($config, "attack", "DBHealSpell", 0)
	EndIf
	If GUICtrlRead($chkABHealSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABHealSpell", 1)
	Else
		IniWriteS($config, "attack", "ABHealSpell", 0)
	EndIf
	If GUICtrlRead($chkTSHealSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSHealSpell", 1)
	Else
		IniWriteS($config, "attack", "TSHealSpell", 0)
	EndIf

	If GUICtrlRead($chkDBRageSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBRageSpell", 1)
	Else
		IniWriteS($config, "attack", "DBRageSpell", 0)
	EndIf
	If GUICtrlRead($chkABRageSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABRageSpell", 1)
	Else
		IniWriteS($config, "attack", "ABRageSpell", 0)
	EndIf
	If GUICtrlRead($chkTSRageSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSRageSpell", 1)
	Else
		IniWriteS($config, "attack", "TSRageSpell", 0)
	EndIf

	If GUICtrlRead($chkDBJumpSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBJumpSpell", 1)
	Else
		IniWriteS($config, "attack", "DBJumpSpell", 0)
	EndIf
	If GUICtrlRead($chkABJumpSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABJumpSpell", 1)
	Else
		IniWriteS($config, "attack", "ABJumpSpell", 0)
	EndIf
	If GUICtrlRead($chkTSJumpSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSJumpSpell", 1)
	Else
		IniWriteS($config, "attack", "TSJumpSpell", 0)
	EndIf

	If GUICtrlRead($chkDBFreezeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBFreezeSpell", 1)
	Else
		IniWriteS($config, "attack", "DBFreezeSpell", 0)
	EndIf
	If GUICtrlRead($chkABFreezeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABFreezeSpell", 1)
	Else
		IniWriteS($config, "attack", "ABFreezeSpell", 0)
	EndIf
	If GUICtrlRead($chkTSFreezeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSFreezeSpell", 1)
	Else
		IniWriteS($config, "attack", "TSFreezeSpell", 0)
	EndIf

	If GUICtrlRead($chkDBPoisonSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBPoisonSpell", 1)
	Else
		IniWriteS($config, "attack", "DBPoisonSpell", 0)
	EndIf
	If GUICtrlRead($chkABPoisonSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABPoisonSpell", 1)
	Else
		IniWriteS($config, "attack", "ABPoisonSpell", 0)
	EndIf
	If GUICtrlRead($chkTSPoisonSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSPoisonSpell", 1)
	Else
		IniWriteS($config, "attack", "TSPoisonSpell", 0)
	EndIf

	If GUICtrlRead($chkDBEarthquakeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBEarthquakeSpell", 1)
	Else
		IniWriteS($config, "attack", "DBEarthquakeSpell", 0)
	EndIf
	If GUICtrlRead($chkABEarthquakeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABEarthquakeSpell", 1)
	Else
		IniWriteS($config, "attack", "ABEarthquakeSpell", 0)
	EndIf
	If GUICtrlRead($chkTSEarthquakeSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSEarthquakeSpell", 1)
	Else
		IniWriteS($config, "attack", "TSEarthquakeSpell", 0)
	EndIf

	If GUICtrlRead($chkDBHasteSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBHasteSpell", 1)
	Else
		IniWriteS($config, "attack", "DBHasteSpell", 0)
	EndIf
	If GUICtrlRead($chkABHasteSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABHasteSpell", 1)
	Else
		IniWriteS($config, "attack", "ABHasteSpell", 0)
	EndIf
	If GUICtrlRead($chkTSHasteSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TSHasteSpell", 1)
	Else
		IniWriteS($config, "attack", "TSHasteSpell", 0)
	EndIf

	If GUICtrlRead($chkDBCloneSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBCloneSpell", 1)
	Else
		IniWriteS($config, "attack", "DBCloneSpell", 0)
	EndIf
	If GUICtrlRead($chkABCloneSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABCloneSpell", 1)
	Else
		IniWriteS($config, "attack", "ABCloneSpell", 0)
	EndIf

	If GUICtrlRead($chkDBSkeletonSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "DBSkeletonSpell", 1)
	Else
		IniWriteS($config, "attack", "DBSkeletonSpell", 0)
	EndIf
	If GUICtrlRead($chkABSkeletonSpell) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ABSkeletonSpell", 1)
	Else
		IniWriteS($config, "attack", "ABSkeletonSpell", 0)
	EndIf

	;TH SNIPE AFTER DB AND LB ATTACK
	If GUICtrlRead($chkTHSnipeBeforeDBEnable) = $GUI_CHECKED Then
		$THSnipeBeforeDBEnable = 1
	Else
		$THSnipeBeforeDBEnable = 0
	EndIf
	If GUICtrlRead($chkTHSnipeBeforeLBEnable) = $GUI_CHECKED Then
		$THSnipeBeforeLBEnable = 1
	Else
		$THSnipeBeforeLBEnable = 0
	EndIf
	$THSnipeBeforeDBTiles = GUICtrlRead($txtTHSnipeBeforeDBTiles)
	$THSnipeBeforeLBTiles = GUICtrlRead($txtTHSnipeBeforeLBTiles)
	$THSnipeBeforeDBScript = GUICtrlRead($cmbTHSnipeBeforeDBScript)
	$THSnipeBeforeLBScript = GUICtrlRead($cmbTHSnipeBeforeLBScript)
	IniWriteS($config, "attack", "THSnipeBeforeDBEnable", $THSnipeBeforeDBEnable)
	IniWriteS($config, "attack", "THSnipeBeforeLBEnable", $THSnipeBeforeLBEnable)
	IniWriteS($config, "attack", "THSnipeBeforeDBTiles", $THSnipeBeforeDBTiles)
	IniWriteS($config, "attack", "THSnipeBeforeLBTiles", $THSnipeBeforeLBTiles)
	IniWriteS($config, "attack", "THSnipeBeforeDBScript", $THSnipeBeforeDBScript)
	IniWriteS($config, "attack", "THSnipeBeforeLBScript", $THSnipeBeforeLBScript)

	If GUICtrlRead($chkUseCCBalanced) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "BalanceCC", 1)
	Else
		IniWriteS($config, "attack", "BalanceCC", 0)
	EndIf

	IniWriteS($config, "ClanClastle", "BalanceCCDonated", _GUICtrlComboBox_GetCurSel($cmbCCDonated) + 1)
	IniWriteS($config, "ClanClastle", "BalanceCCReceived", _GUICtrlComboBox_GetCurSel($cmbCCReceived) + 1)

	If GUICtrlRead($radManAbilities) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ActivateKQ", "Manual")
	ElseIf GUICtrlRead($radAutoAbilities) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ActivateKQ", "Auto")
	EndIf

	If GUICtrlRead($chkUseWardenAbility) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ActivateWarden", 1)
	Else
		IniWriteS($config, "attack", "ActivateWarden", 0)
	EndIf

	IniWriteS($config, "attack", "delayActivateKQ", GUICtrlRead($txtManAbilities))
	IniWriteS($config, "attack", "delayActivateW", GUICtrlRead($txtWardenAbility))

	If GUICtrlRead($chkTakeLootSS) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "TakeLootSnapShot", 1)
	Else
		IniWriteS($config, "attack", "TakeLootSnapShot", 0)
	EndIf

	If GUICtrlRead($chkScreenshotLootInfo) = $GUI_CHECKED Then
		IniWriteS($config, "attack", "ScreenshotLootInfo", 1)
	Else
		IniWriteS($config, "attack", "ScreenshotLootInfo", 0)
	EndIf

	;End Battle Settings------------------------------------------------------------------------
	IniWriteS($config, "endbattle", "txtDBTimeStopAtk", GUICtrlRead($txtDBTimeStopAtk))
	IniWriteS($config, "endbattle", "chkDBTimeStopAtk", GUICtrlRead($chkDBTimeStopAtk))
	IniWriteS($config, "endbattle", "txtDBTimeStopAtk2", GUICtrlRead($txtDBTimeStopAtk2))
	IniWriteS($config, "endbattle", "chkDBTimeStopAtk2", GUICtrlRead($chkDBTimeStopAtk2))
	IniWriteS($config, "endbattle", "txtDBMinGoldStopAtk2", GUICtrlRead($txtDBMinGoldStopAtk2))
	IniWriteS($config, "endbattle", "txtDBMinElixirStopAtk2", GUICtrlRead($txtDBMinElixirStopAtk2))
	IniWriteS($config, "endbattle", "txtDBMinDarkElixirStopAtk2", GUICtrlRead($txtDBMinDarkElixirStopAtk2))
	IniWriteS($config, "endbattle", "chkDBEndOneStar", GUICtrlRead($chkDBEndOneStar))
	IniWriteS($config, "endbattle", "chkDBEndTwoStars", GUICtrlRead($chkDBEndTwoStars))
	If GUICtrlRead($chkDBEndNoResources) = $GUI_CHECKED Then
		IniWriteS($config, "endbattle", "chkDBEndNoResources", 1)
	Else
		IniWriteS($config, "endbattle", "chkDBEndNoResources", 0)
	EndIf

	IniWriteS($config, "endBattle", "txtABTimeStopAtk", GUICtrlRead($txtABTimeStopAtk))
	IniWriteS($config, "endBattle", "chkABTimeStopAtk", GUICtrlRead($chkABTimeStopAtk))
	IniWriteS($config, "endBattle", "txtABTimeStopAtk2", GUICtrlRead($txtABTimeStopAtk2))
	IniWriteS($config, "endBattle", "chkABTimeStopAtk2", GUICtrlRead($chkABTimeStopAtk2))
	IniWriteS($config, "endBattle", "txtABMinGoldStopAtk2", GUICtrlRead($txtABMinGoldStopAtk2))
	IniWriteS($config, "endBattle", "txtABMinElixirStopAtk2", GUICtrlRead($txtABMinElixirStopAtk2))
	IniWriteS($config, "endBattle", "txtABMinDarkElixirStopAtk2", GUICtrlRead($txtABMinDarkElixirStopAtk2))
	IniWriteS($config, "endBattle", "chkABEndOneStar", GUICtrlRead($chkABEndOneStar))
	IniWriteS($config, "endBattle", "chkABEndTwoStars", GUICtrlRead($chkABEndTwoStars))
	If GUICtrlRead($chkABEndNoResources) = $GUI_CHECKED Then
		IniWriteS($config, "endBattle", "chkABEndNoResources", 1)
	Else
		IniWriteS($config, "endBattle", "chkABEndNoResources", 0)
	EndIf

#CS
	IniWriteS($config, "endBattle", "txtTSTimeStopAtk", GUICtrlRead($txtTSTimeStopAtk))
	IniWriteS($config, "endBattle", "chkTSTimeStopAtk", GUICtrlRead($chkTSTimeStopAtk))
	IniWriteS($config, "endBattle", "txtTSTimeStopAtk2", GUICtrlRead($txtTSTimeStopAtk2))
	IniWriteS($config, "endBattle", "chkTSTimeStopAtk2", GUICtrlRead($chkTSTimeStopAtk2))
	IniWriteS($config, "endBattle", "txtTSMinGoldStopAtk2", GUICtrlRead($txtTSMinGoldStopAtk2))
	IniWriteS($config, "endBattle", "txtTSMinElixirStopAtk2", GUICtrlRead($txtTSMinElixirStopAtk2))
	IniWriteS($config, "endBattle", "txtTSMinDarkElixirStopAtk2", GUICtrlRead($txtTSMinDarkElixirStopAtk2))
	IniWriteS($config, "endBattle", "chkTSEndOneStar", GUICtrlRead($chkTSEndOneStar))
	IniWriteS($config, "endBattle", "chkTSEndTwoStars", GUICtrlRead($chkTSEndTwoStars))
	If GUICtrlRead($chkTSEndNoResources) = $GUI_CHECKED Then
		IniWriteS($config, "endBattle", "chkTSEndNoResources", 1)
	Else
		IniWriteS($config, "endBattle", "chkTSEndNoResources", 0)
	EndIf
#CE

	; end battle de side
	IniWriteS($config, "endbattle", "chkDESideEB", $DESideEB)
	IniWriteS($config, "endbattle", "txtDELowEndMin", $DELowEndMin)
	IniWriteS($config, "endbattle", "chkDisableOtherEBO", $DisableOtherEBO)
	IniWriteS($config, "endbattle", "chkDEEndAq", $DEEndAq)
	IniWriteS($config, "endbattle", "chkDEEndBk", $DEEndBk)
	IniWriteS($config, "endbattle", "chkDEEndOneStar", $DEEndOneStar)

	;Advanced Settings--------------------------------------------------------------------------
	If GUICtrlRead($chkAttackNow) = $GUI_CHECKED Then
		IniWriteS($config, "general", "attacknow", 1)
	Else
		IniWriteS($config, "general", "attacknow", 0)
	EndIf
	IniWriteS($config, "general", "attacknowdelay", _GUICtrlComboBox_GetCurSel($cmbAttackNowDelay))

	If GUICtrlRead($chkbtnScheduler) = $GUI_CHECKED Then
		IniWriteS($config, "general", "BtnScheduler", 1)
	Else
		IniWriteS($config, "general", "BtnScheduler", 0)
	EndIf


	If GUICtrlRead($BullyCheck) = $GUI_CHECKED Then
		IniWriteS($config, "search", "BullyMode", 1)
	Else
		IniWriteS($config, "search", "BullyMode", 0)
	EndIf

	IniWriteS($config, "search", "ATBullyMode", $ATBullyMode)
	IniWriteS($config, "search", "YourTH", $YourTH)

	IniWriteS($config, "search", "THBullyAttackMode", $iTHBullyAttackMode)

	IniWriteS($config, "search", "THaddTiles", GUICtrlRead($txtTHaddtiles))
	;	IniWriteS($config, "attack", "AttackTHType", _GUICtrlComboBox_GetCurSel($cmbAttackTHType))
	$txtAttackTHType = GUICtrlRead($cmbAttackTHType)
	IniWriteS($config, "attack", "AttackTHType", $scmbAttackTHType)

	IniWriteS($config, "search", "TSMeetGE", _GUICtrlComboBox_GetCurSel($cmbTSMeetGE))
	IniWriteS($config, "search", "TSEnableAfterCount", GUICtrlRead($txtTSSearchesMin))
	IniWriteS($config, "search", "TSEnableBeforeCount", GUICtrlRead($txtTSSearchesMax))
	IniWriteS($config, "search", "TSEnableAfterTropies", GUICtrlRead($txtTSTropiesMin))
	IniWriteS($config, "search", "TSEnableBeforeTropies", GUICtrlRead($txtTSTropiesMax))
	IniWriteS($config, "search", "TSEnableAfterArmyCamps", GUICtrlRead($txtTSArmyCamps))

	IniWriteS($config, "search", "TSsearchGold", GUICtrlRead($txtTSMinGold))
	IniWriteS($config, "search", "TSsearchElixir", GUICtrlRead($txtTSMinElixir))
	IniWriteS($config, "search", "TSsearchGoldPlusElixir", GUICtrlRead($txtTSMinGoldPlusElixir))
	IniWriteS($config, "search", "TSsearchDark", GUICtrlRead($txtTSMinDarkElixir))

	IniWriteS($config, "Unbreakable", "chkUnbreakable", $iUnbreakableMode)
	IniWriteS($config, "Unbreakable", "UnbreakableWait", $iUnbreakableWait)
	IniWriteS($config, "Unbreakable", "minUnBrkgold", $iUnBrkMinGold)
	IniWriteS($config, "Unbreakable", "minUnBrkelixir", $iUnBrkMinElixir)
	IniWriteS($config, "Unbreakable", "minUnBrkdark", $iUnBrkMinDark)
	IniWriteS($config, "Unbreakable", "maxUnBrkgold", $iUnBrkMaxGold)
	IniWriteS($config, "Unbreakable", "maxUnBrkelixir", $iUnBrkMaxElixir)
	IniWriteS($config, "Unbreakable", "maxUnBrkdark", $iUnBrkMaxDark)


	;atk their king
	;attk their queen

	;Donate Settings-------------------------------------------------------------------------

;~ 	IniWriteS($config, "donate", "chkRequest", $iChkRequest)
	IniWriteS($config, "donate", "txtRequest", GUICtrlRead($txtRequestCC))
	If GUICtrlRead($chkskipDonateNearFulLTroopsEnable) = $GUI_CHECKED Then
		IniWriteS($config, "donate", "SkipDonateNearFulLTroopsEnable", 1)
	Else
		IniWriteS($config, "donate", "SkipDonateNearFulLTroopsEnable", 0)
	EndIf
	IniWriteS($config, "donate", "SkipDonateNearFulLTroopsPercentual", number(GUICtrlRead($txtSkipDonateNearFulLTroopsPercentual)))
	IniWriteS($config, "donate", "chkDonateBarbarians", $ichkDonateBarbarians)
	IniWriteS($config, "donate", "chkDonateAllBarbarians", $ichkDonateAllBarbarians)
	IniWriteS($config, "donate", "txtDonateBarbarians", StringReplace($sTxtDonateBarbarians, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistBarbarians", StringReplace($sTxtBlacklistBarbarians, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateArchers", $ichkDonateArchers)
	IniWriteS($config, "donate", "chkDonateAllArchers", $ichkDonateAllArchers)
	IniWriteS($config, "donate", "txtDonateArchers", StringReplace($sTxtDonateArchers, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistArchers", StringReplace($sTxtBlacklistArchers, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateGiants", $ichkDonateGiants)
	IniWriteS($config, "donate", "chkDonateAllGiants", $ichkDonateAllGiants)
	IniWriteS($config, "donate", "txtDonateGiants", StringReplace($sTxtDonateGiants, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistGiants", StringReplace($sTxtBlacklistGiants, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateGoblins", $ichkDonateGoblins)
	IniWriteS($config, "donate", "chkDonateAllGoblins", $ichkDonateAllGoblins)
	IniWriteS($config, "donate", "txtDonateGoblins", StringReplace($sTxtDonateGoblins, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistGoblins", StringReplace($sTxtBlacklistGoblins, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateWallBreakers", $ichkDonateWallBreakers)
	IniWriteS($config, "donate", "chkDonateAllWallBreakers", $ichkDonateAllWallBreakers)
	IniWriteS($config, "donate", "txtDonateWallBreakers", StringReplace($sTxtDonateWallBreakers, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistWallBreakers", StringReplace($sTxtBlacklistWallBreakers, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateBalloons", $ichkDonateBalloons)
	IniWriteS($config, "donate", "chkDonateAllBalloons", $ichkDonateAllBalloons)
	IniWriteS($config, "donate", "txtDonateBalloons", StringReplace($sTxtDonateBalloons, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistBalloons", StringReplace($sTxtBlacklistBalloons, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateWizards", $ichkDonateWizards)
	IniWriteS($config, "donate", "chkDonateAllWizards", $ichkDonateAllWizards)
	IniWriteS($config, "donate", "txtDonateWizards", StringReplace($sTxtDonateWizards, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistWizards", StringReplace($sTxtBlacklistWizards, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateHealers", $ichkDonateHealers)
	IniWriteS($config, "donate", "chkDonateAllHealers", $ichkDonateAllHealers)
	IniWriteS($config, "donate", "txtDonateHealers", StringReplace($sTxtDonateHealers, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistHealers", StringReplace($sTxtBlacklistHealers, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateDragons", $ichkDonateDragons)
	IniWriteS($config, "donate", "chkDonateAllDragons", $ichkDonateAllDragons)
	IniWriteS($config, "donate", "txtDonateDragons", StringReplace($sTxtDonateDragons, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistDragons", StringReplace($sTxtBlacklistDragons, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonatePekkas", $ichkDonatePekkas)
	IniWriteS($config, "donate", "chkDonateAllPekkas", $ichkDonateAllPekkas)
	IniWriteS($config, "donate", "txtDonatePekkas", StringReplace($sTxtDonatePekkas, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistPekkas", StringReplace($sTxtBlacklistPekkas, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateBabyDragons", $ichkDonateBabyDragons)
	IniWriteS($config, "donate", "chkDonateAllBabyDragons", $ichkDonateAllBabyDragons)
	IniWriteS($config, "donate", "txtDonateBabyDragons", StringReplace($sTxtDonateBabyDragons, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistBabyDragons", StringReplace($sTxtBlacklistBabyDragons, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateMiners", $ichkDonateMiners)
	IniWriteS($config, "donate", "chkDonateAllMiners", $ichkDonateAllMiners)
	IniWriteS($config, "donate", "txtDonateMiners", StringReplace($sTxtDonateMiners, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistMiners", StringReplace($sTxtBlacklistMiners, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateLightningSpells", $ichkDonateLightningSpells)
	IniWriteS($config, "donate", "chkDonateAllLightningSpells", $ichkDonateAllLightningSpells)
	IniWriteS($config, "donate", "txtDonateLightningSpells", StringReplace($sTxtDonateLightningSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistLightningSpells", StringReplace($sTxtBlacklistLightningSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateHealSpells", $ichkDonateHealSpells)
	IniWriteS($config, "donate", "chkDonateAllHealSpells", $ichkDonateAllHealSpells)
	IniWriteS($config, "donate", "txtDonateHealSpells", StringReplace($sTxtDonateHealSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistHealSpells", StringReplace($sTxtBlacklistHealSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateRageSpells", $ichkDonateRageSpells)
	IniWriteS($config, "donate", "chkDonateAllRageSpells", $ichkDonateAllRageSpells)
	IniWriteS($config, "donate", "txtDonateRageSpells", StringReplace($sTxtDonateRageSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistRageSpells", StringReplace($sTxtBlacklistRageSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateJumpSpells", $ichkDonateJumpSpells)
	IniWriteS($config, "donate", "chkDonateAllJumpSpells", $ichkDonateAllJumpSpells)
	IniWriteS($config, "donate", "txtDonateJumpSpells", StringReplace($sTxtDonateJumpSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistJumpSpells", StringReplace($sTxtBlacklistJumpSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateFreezeSpells", $ichkDonateFreezeSpells)
	IniWriteS($config, "donate", "chkDonateAllFreezeSpells", $ichkDonateAllFreezeSpells)
	IniWriteS($config, "donate", "txtDonateFreezeSpells", StringReplace($sTxtDonateFreezeSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistFreezeSpells", StringReplace($sTxtBlacklistFreezeSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateMinions", $ichkDonateMinions)
	IniWriteS($config, "donate", "chkDonateAllMinions", $ichkDonateAllMinions)
	IniWriteS($config, "donate", "txtDonateMinions", StringReplace($sTxtDonateMinions, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistMinions", StringReplace($sTxtBlacklistMinions, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateHogRiders", $ichkDonateHogRiders)
	IniWriteS($config, "donate", "chkDonateAllHogRiders", $ichkDonateAllHogRiders)
	IniWriteS($config, "donate", "txtDonateHogRiders", StringReplace($sTxtDonateHogRiders, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistHogRiders", StringReplace($sTxtBlacklistHogRiders, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateValkyries", $ichkDonateValkyries)
	IniWriteS($config, "donate", "chkDonateAllValkyries", $ichkDonateAllValkyries)
	IniWriteS($config, "donate", "txtDonateValkyries", StringReplace($sTxtDonateValkyries, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistValkyries", StringReplace($sTxtBlacklistValkyries, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateGolems", $ichkDonateGolems)
	IniWriteS($config, "donate", "chkDonateAllGolems", $ichkDonateAllGolems)
	IniWriteS($config, "donate", "txtDonateGolems", StringReplace($sTxtDonateGolems, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistGolems", StringReplace($sTxtBlacklistGolems, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateWitches", $ichkDonateWitches)
	IniWriteS($config, "donate", "chkDonateAllWitches", $ichkDonateAllWitches)
	IniWriteS($config, "donate", "txtDonateWitches", StringReplace($sTxtDonateWitches, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistWitches", StringReplace($sTxtBlacklistWitches, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateLavaHounds", $ichkDonateLavaHounds)
	IniWriteS($config, "donate", "chkDonateAllLavaHounds", $ichkDonateAllLavaHounds)
	IniWriteS($config, "donate", "txtDonateLavaHounds", StringReplace($sTxtDonateLavaHounds, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistLavaHounds", StringReplace($sTxtBlacklistLavaHounds, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateBowlers", $ichkDonateBowlers)
	IniWriteS($config, "donate", "chkDonateAllBowlers", $ichkDonateAllBowlers)
	IniWriteS($config, "donate", "txtDonateBowlers", StringReplace($sTxtDonateBowlers, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistBowlers", StringReplace($sTxtBlacklistBowlers, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonatePoisonSpells", $ichkDonatePoisonSpells)
	IniWriteS($config, "donate", "chkDonateAllPoisonSpells", $ichkDonateAllPoisonSpells)
	IniWriteS($config, "donate", "txtDonatePoisonSpells", StringReplace($sTxtDonatePoisonSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistPoisonSpells", StringReplace($sTxtBlacklistPoisonSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateEarthQuakeSpells", $ichkDonateEarthQuakeSpells)
	IniWriteS($config, "donate", "chkDonateAllEarthQuakeSpells", $ichkDonateAllEarthQuakeSpells)
	IniWriteS($config, "donate", "txtDonateEarthQuakeSpells", StringReplace($sTxtDonateEarthQuakeSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistEarthQuakeSpells", StringReplace($sTxtBlacklistEarthQuakeSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateHasteSpells", $ichkDonateHasteSpells)
	IniWriteS($config, "donate", "chkDonateAllHasteSpells", $ichkDonateAllHasteSpells)
	IniWriteS($config, "donate", "txtDonateHasteSpells", StringReplace($sTxtDonateHasteSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistHasteSpells", StringReplace($sTxtBlacklistHasteSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "chkDonateSkeletonSpells", $ichkDonateSkeletonSpells)
	IniWriteS($config, "donate", "chkDonateAllSkeletonSpells", $ichkDonateAllSkeletonSpells)
	IniWriteS($config, "donate", "txtDonateSkeletonSpells", StringReplace($sTxtDonateSkeletonSpells, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistSkeletonSpells", StringReplace($sTxtBlacklistSkeletonSpells, @CRLF, "|"))
	;;; Custom Combination Donate by ChiefM3
	IniWriteS($config, "donate", "chkDonateCustomA", $ichkDonateCustomA)
	IniWriteS($config, "donate", "chkDonateAllCustomA", $ichkDonateAllCustomA)
	IniWriteS($config, "donate", "txtDonateCustomA", StringReplace($sTxtDonateCustomA, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistCustomA", StringReplace($sTxtBlacklistCustomA, @CRLF, "|"))
	IniWriteS($config, "donate", "cmbDonateCustomA1", $varDonateCustomA[0][0])
	IniWriteS($config, "donate", "txtDonateCustomA1", $varDonateCustomA[0][1])
	IniWriteS($config, "donate", "cmbDonateCustomA2", $varDonateCustomA[1][0])
	IniWriteS($config, "donate", "txtDonateCustomA2", $varDonateCustomA[1][1])
	IniWriteS($config, "donate", "cmbDonateCustomA3", $varDonateCustomA[2][0])
	IniWriteS($config, "donate", "txtDonateCustomA3", $varDonateCustomA[2][1])

	IniWriteS($config, "donate", "chkDonateCustomB", $ichkDonateCustomB)
	IniWriteS($config, "donate", "chkDonateAllCustomB", $ichkDonateAllCustomB)
	IniWriteS($config, "donate", "txtDonateCustomB", StringReplace($sTxtDonateCustomB, @CRLF, "|"))
	IniWriteS($config, "donate", "txtBlacklistCustomB", StringReplace($sTxtBlacklistCustomB, @CRLF, "|"))
	IniWriteS($config, "donate", "cmbDonateCustomB1", $varDonateCustomB[0][0])
	IniWriteS($config, "donate", "txtDonateCustomB1", $varDonateCustomB[0][1])
	IniWriteS($config, "donate", "cmbDonateCustomB2", $varDonateCustomB[1][0])
	IniWriteS($config, "donate", "txtDonateCustomB2", $varDonateCustomB[1][1])
	IniWriteS($config, "donate", "cmbDonateCustomB3", $varDonateCustomB[2][0])
	IniWriteS($config, "donate", "txtDonateCustomB3", $varDonateCustomB[2][1])

	IniWriteS($config, "donate", "txtBlacklist", StringReplace($sTxtBlacklist, @CRLF, "|"))

	; Extra Alphabets, Cyrillic, Chinese

	IniWriteS($config, "donate", "chkExtraAlphabets", $ichkExtraAlphabets)
	IniWriteS($config, "donate", "chkExtraChinese", $ichkExtraChinese)


	IniWriteS($config, "donate", "cmbFilterDonationsCC", $icmbFilterDonationsCC)

	;Troop and Spells Settings--------------------------------------------------------------------------
	Local $tempTroop
	For $T = 0 To UBound($TroopName) - 1
		$tempTroop = GUICtrlRead(Eval("txtNum" & $TroopName[$T]))
		IniWriteS($config, "troop", $TroopName[$T], $tempTroop)
		Assign($TroopName[$T] & "Comp", $tempTroop)
		IniWriteS($config, "LevelTroop", $TroopName[$T], Eval("itxtLev" & $TroopName[$T]))
	Next
	Local $tempSpell
	IniWriteS($config, "Spells", "SpellFactory", GUICtrlRead($txtTotalCountSpell))
	For $S = 0 To (UBound($SpellName) - 1)
		$tempSpell = GUICtrlRead(Eval("txtNum" & $SpellName[$S]))
		IniWriteS($config, "Spells", $SpellName[$S], $tempSpell)
		Assign($SpellName[$S] & "Comp", $tempSpell)
		IniWriteS($config, "LevelSpell", $SpellName[$S], Eval("itxtLev" & $SpellName[$S]))
	Next

	If GUICtrlRead($hRadio_Army1) = $GUI_CHECKED Then
		$iChkQuickArmy1 = 1
	Else
		$iChkQuickArmy1 = 0
	EndIf
	If GUICtrlRead($hRadio_Army2) = $GUI_CHECKED Then
		$iChkQuickArmy2 = 1
	Else
		$iChkQuickArmy2 = 0
	EndIf
	If GUICtrlRead($hRadio_Army3) = $GUI_CHECKED Then
		$iChkQuickArmy3 = 1
	Else
		$iChkQuickArmy3 = 0
	EndIf

	IniWriteS($config, "troop", "fulltroop", GUICtrlRead($txtFullTroop))
	IniWriteS($config, "other", "TrainITDelay", $isldTrainITDelay)

	IniWriteS($config, "other", "chkCloseWaitEnable", $ichkCloseWaitEnable)
	IniWriteS($config, "other", "chkCloseWaitTrain", $ichkCloseWaitTrain)
	IniWriteS($config, "other", "btnCloseWaitStop", $ibtnCloseWaitStop)
	IniWriteS($config, "other", "btnCloseWaitStopRandom", $ibtnCloseWaitStopRandom)
	IniWriteS($config, "other", "btnCloseWaitExact", $ibtnCloseWaitExact)
	IniWriteS($config, "other", "btnCloseWaitRandom", $ibtnCloseWaitRandom)
	IniWriteS($config, "other", "CloseWaitRdmPercent", _GUICtrlComboBox_GetCurSel($cmbCloseWaitRdmPercent))
	IniWriteS($config, "other", "MinimumTimeToClose", GUICtrlRead($cmbMinimumTimeClose))

	IniWriteS($config, "troop", "chkTroopOrder", $ichkTroopOrder)
	For $z = 0 To UBound($DefaultTroopGroup) -1
		IniWriteS($config, "troop", "cmbTroopOrder" & $z, _GUICtrlComboBox_GetCurSel($cmbTroopOrder[$z]))
	Next

	; IniWriteS($config, "troop", "chkDarkTroopOrder", $ichkDarkTroopOrder)
	; For $z = 0 To UBound($DefaultTroopGroupDark) -1
		; IniWriteS($config, "troop", "cmbDarkTroopOrder" & $z, _GUICtrlComboBox_GetCurSel($cmbDarkTroopOrder[$z]))
	; Next

	;Level Troops
		; IniWriteS($config, "LevelTroop", "Barb", $itxtLevBarb)
		; IniWriteS($config, "LevelTroop", "Arch", $itxtLevArch)
		; IniWriteS($config, "LevelTroop", "Gobl", $itxtLevGobl)
		; IniWriteS($config, "LevelTroop", "Giant", $itxtLevGiant)
		; IniWriteS($config, "LevelTroop", "Wall", $itxtLevWall)
		; IniWriteS($config, "LevelTroop", "Heal", $itxtLevHeal)
		; IniWriteS($config, "LevelTroop", "Pekk", $itxtLevPekk)
		; IniWriteS($config, "LevelTroop", "Ball", $itxtLevBall)
		; IniWriteS($config, "LevelTroop", "Wiza", $itxtLevWiza)
		; IniWriteS($config, "LevelTroop", "Drag", $itxtLevDrag)
		; IniWriteS($config, "LevelTroop", "BabyD", $itxtLevBabyD)
		; IniWriteS($config, "LevelTroop", "Mine", $itxtLevMine)
		; IniWriteS($config, "LevelTroop", "Mini", $itxtLevMini)
		; IniWriteS($config, "LevelTroop", "Hogs", $itxtLevHogs)
		; IniWriteS($config, "LevelTroop", "Valk", $itxtLevValk)
		; IniWriteS($config, "LevelTroop", "Gole", $itxtLevGole)
		; IniWriteS($config, "LevelTroop", "Witc", $itxtLevWitc)
		; IniWriteS($config, "LevelTroop", "Lava", $itxtLevLava)
		; IniWriteS($config, "LevelTroop", "Bowl", $itxtLevBowl)
	;barracks boost not saved (no use)

	; Spells Creation  ---------------------------------------------------------------------
	; IniWriteS($config, "Spells", "LightningSpell", GUICtrlRead($txtNumLSpell))
	; IniWriteS($config, "Spells", "RageSpell", GUICtrlRead($txtNumRSpell))
	; IniWriteS($config, "Spells", "HealSpell", GUICtrlRead($txtNumHSpell))
	; IniWriteS($config, "Spells", "JumpSpell", GUICtrlRead($txtNumJSpell))
	; IniWriteS($config, "Spells", "FreezeSpell", GUICtrlRead($txtNumFSpell))
	; IniWriteS($config, "Spells", "CloneSpell", GUICtrlRead($txtNumCSpell))
	; IniWriteS($config, "Spells", "PoisonSpell", GUICtrlRead($txtNumPSpell))
	; IniWriteS($config, "Spells", "EarthSpell", GUICtrlRead($txtNumESpell))
	; IniWriteS($config, "Spells", "HasteSpell", GUICtrlRead($txtNumHaSpell))
	; IniWriteS($config, "Spells", "SkeletonSpell", GUICtrlRead($txtNumSkSpell))

	;Level spell
	; IniWriteS($config, "LevelSpell", "Lightning", $itxtLevLSpell)
	; IniWriteS($config, "LevelSpell", "Heal", $itxtLevHSpell)
	; IniWriteS($config, "LevelSpell", "Rage", $itxtLevRSpell)
	; IniWriteS($config, "LevelSpell", "JumpSpell", $itxtLevJSpell)
	; IniWriteS($config, "LevelSpell", "Freeze", $itxtLevFSpell)
	; IniWriteS($config, "LevelSpell", "Clone", $itxtLevCSpell)
	; IniWriteS($config, "LevelSpell", "Poison", $itxtLevPSpell)
	; IniWriteS($config, "LevelSpell", "Earthquake", $itxtLevESpell)
	; IniWriteS($config, "LevelSpell", "Haste", $itxtLevHaSpell)
	; IniWriteS($config, "LevelSpell", "Skeleton", $itxtLevSkSpell)

	;Upgrades
	IniWriteS($building, "upgrade", "upgradetroops", $ichkLab)
	IniWriteS($building, "upgrade", "upgradetroopname", $icmbLaboratory)
	IniWrite($building, "upgrade", "upgradelabtime", $sLabUpgradeTime)
	IniWriteS($building, "upgrade", "LabPosX", $aLabPos[0])
	IniWriteS($building, "upgrade", "LabPosY", $aLabPos[1])
	IniWriteS($config, "upgrade", "UpgradeKing", $ichkUpgradeKing)
	IniWriteS($config, "upgrade", "UpgradeQueen", $ichkUpgradeQueen)
	IniWriteS($config, "upgrade", "UpgradeWarden", $ichkUpgradeWarden)
	IniWriteS($config, "upgrade", "auto-wall", $ichkWalls)
	IniWriteS($config, "upgrade", "savebldr", $iSaveWallBldr)
	IniWriteS($config, "upgrade", "use-storage", $iUseStorage)
	IniWriteS($config, "upgrade", "walllvl", $icmbWalls)
	IniWriteS($config, "upgrade", "MaxNbWall", $iMaxNbWall)
	IniWriteS($config, "upgrade", "minwallgold", $itxtWallMinGold)
	IniWriteS($config, "upgrade", "minwallelixir", $itxtWallMinElixir)
	IniWriteS($config, "upgrade", "minupgrgold", $itxtUpgrMinGold)
	IniWriteS($config, "upgrade", "minupgrelixir", $itxtUpgrMinElixir)
	IniWriteS($config, "upgrade", "minupgrdark", $itxtUpgrMinDark)
	IniWriteS($config, "upgrade", "WallCost", $WallCost)

	IniWriteS($config, "Walls", "Wall04", $itxtWall04ST)
	IniWriteS($config, "Walls", "Wall05", $itxtWall05ST)
	IniWriteS($config, "Walls", "Wall06", $itxtWall06ST)
	IniWriteS($config, "Walls", "Wall07", $itxtWall07ST)
	IniWriteS($config, "Walls", "Wall08", $itxtWall08ST)
	IniWriteS($config, "Walls", "Wall09", $itxtWall09ST)
	IniWriteS($config, "Walls", "Wall10", $itxtWall10ST)
	IniWriteS($config, "Walls", "Wall11", $itxtWall11ST)
	IniWriteS($config, "Walls", "Wall12", $itxtWall12ST)

	For $iz = 0 To UBound($aUpgrades, 1) - 1 ; Save Upgrades data
		IniWrite($building, "upgrade", "xupgrade" & $iz, $aUpgrades[$iz][0])
		IniWrite($building, "upgrade", "yupgrade" & $iz, $aUpgrades[$iz][1])
		IniWrite($building, "upgrade", "upgradevalue" & $iz, $aUpgrades[$iz][2])
		IniWrite($building, "upgrade", "upgradetype" & $iz, $aUpgrades[$iz][3])
		IniWrite($building, "upgrade", "upgradename" & $iz, $aUpgrades[$iz][4])
		IniWrite($building, "upgrade", "upgradelevel" & $iz, $aUpgrades[$iz][5])
		IniWrite($building, "upgrade", "upgradetime" & $iz, $aUpgrades[$iz][6])
		IniWrite($building, "upgrade", "upgradeend" & $iz, $aUpgrades[$iz][7])
		IniWrite($building, "upgrade", "upgradestatusicon" & $iz, $ipicUpgradeStatus[$iz])
		IniWrite($building, "upgrade", "upgradechk" & $iz, $ichkbxUpgrade[$iz])
		IniWrite($building, "upgrade", "upgraderepeat" & $iz, $ichkUpgrdeRepeat[$iz])
	Next

	;PushBullet / Telegram----------------------------------------

	IniWriteS($config, "notify", "PBEnabled", $NotifyPBEnabled)
	IniWriteS($config, "notify", "PBToken", $NotifyPBToken)
	IniWriteS($config, "notify", "Origin", $NotifyOrigin)
	IniWriteS($config, "notify", "PBRemote", $NotifyRemoteEnable)
	IniWriteS($config, "notify", "DeleteAllPBPushes", $NotifyDeleteAllPushesOnStart)
	IniWriteS($config, "notify", "DeleteOldPBPushes", $NotifyDeletePushesOlderThan)
	IniWriteS($config, "notify", "HoursPushBullet", $NotifyDeletePushesOlderThanHours)
	IniWriteS($config, "notify", "TGEnabled", $NotifyTGEnabled)
	IniWriteS($config, "notify", "TGToken", $NotifyTGToken)
	IniWriteS($config, "notify", "AlertPBVMFound", $NotifyAlertMatchFound)
	IniWriteS($config, "notify", "AlertPBLastRaid", $NotifyAlerLastRaidIMG)
	IniWriteS($config, "notify", "AlertPBWallUpgrade", $NotifyAlertUpgradeWalls)
	IniWriteS($config, "notify", "AlertPBOOS", $NotifyAlertOutOfSync)
	IniWriteS($config, "notify", "AlertPBOtherDevice", $NotifyAlertAnotherDevice)
	IniWriteS($config, "notify", "AlertPBLastRaidTxt", $NotifyAlerLastRaidTXT)
	IniWriteS($config, "notify", "AlertPBCampFull", $NotifyAlertCampFull)
	IniWriteS($config, "notify", "AlertPBVillage", $NotifyAlertVillageReport)
	IniWriteS($config, "notify", "AlertPBLastAttack", $NotifyAlertLastAttack)
	IniWriteS($config, "notify", "AlertPBVBreak", $NotifyAlertTakeBreak)
	IniWriteS($config, "notify", "AlertBuilderIdle", $NotifyAlertBulderIdle)
	IniWriteS($config, "notify", "AlertPBMaintenance", $NotifyAlertMaintenance)
	IniWriteS($config, "notify", "AlertPBBAN", $NotifyAlertBAN)
	IniWriteS($config, "notify", "AlertPBUpdate", $NotifyAlertBOTUpdate)

	;Schedule
	If GUICtrlRead($chkNotifyWeekDays) = $GUI_CHECKED Then
		IniWrite($config, "notify", "NotifyWeekDaysEnable", 1)
	Else
		IniWrite($config, "notify", "NotifyWeekDaysEnable", 0)
	EndIf
	Local $string = ""
	For $i = 0 To 6
		If GUICtrlRead(Eval("chkNotifyWeekdays" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWrite($config, "notify", "NotifyWeekDays", $string)

	If GUICtrlRead($chkNotifyHours) = $GUI_CHECKED Then
		IniWrite($config, "notify", "NotifyHoursEnable", 1)
	Else
		IniWrite($config, "notify", "NotifyHoursEnable", 0)
	EndIf
	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkNotifyHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWrite($config, "notify", "NotifyHours", $string)

	;Misc Settings--------------------------------------------------------------------------


	IniWriteS($config, "other", "minrestartgold", $itxtRestartGold)
	IniWriteS($config, "other", "minrestartelixir", $itxtRestartElixir)
	IniWriteS($config, "other", "minrestartdark", $itxtRestartDark)


	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkTrap", 1)
	Else
		IniWriteS($config, "other", "chkTrap", 0)
	EndIf
	If GUICtrlRead($chkCollect) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkCollect", 1)
	Else
		IniWriteS($config, "other", "chkCollect", 0)
	EndIf
	If GUICtrlRead($chkTombstones) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkTombstones", 1)
	Else
		IniWriteS($config, "other", "chkTombstones", 0)
	EndIf
	IniWriteS($config, "other", "txtTimeWakeUp", $sTimeWakeUp)
	IniWriteS($config, "other", "VSDelay", $iVSDelay)
	IniWriteS($config, "other", "MaxVSDelay", $iMaxVSDelay)


	If GUICtrlRead($chkCleanYard) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkCleanYard", 1)
	Else
		IniWriteS($config, "other", "chkCleanYard", 0)
	EndIf

	;Boju Only clear GemBox
	If GUICtrlRead($chkGemsBox) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkGemsBox", 1)
	Else
		IniWriteS($config, "other", "chkGemsBox", 0)
	EndIf
	;Only clear GemBox


	IniWriteS($config, "search", "TrophyRange", $iChkTrophyRange)
	IniWriteS($config, "search", "MaxTrophy", $itxtMaxTrophy)
	IniWriteS($config, "search", "MinTrophy", $itxtdropTrophy)
	IniWriteS($config, "search", "chkTrophyHeroes", $iChkTrophyHeroes)
	IniWriteS($config, "search", "chkTrophyAtkDead", $iChkTrophyAtkDead)
	IniWriteS($config, "search", "DTArmyMin", $itxtDTArmyMin)

	SetDebugLog("Save Building Config " & $building)

	IniWriteS($building, "general", "version", GetVersionNormalized($sBotVersion))

	IniWriteS($building, "other", "xTownHall", $TownHallPos[0])
	IniWriteS($building, "other", "yTownHall", $TownHallPos[1])
	IniWriteS($building, "other", "LevelTownHall", $iTownHallLevel)

	IniWriteS($building, "other", "xCCPos", $aCCPos[0])
	IniWriteS($building, "other", "yCCPos", $aCCPos[1])

	IniWriteS($building, "other", "xArmy", $ArmyPos[0])
	IniWriteS($building, "other", "yArmy", $ArmyPos[1])
	IniWriteS($building, "other", "totalcamp", $TotalCamp)

	;IniWriteS($building, "other", "barrackNum", $barrackNum)
	;IniWriteS($building, "other", "barrackDarkNum", $barrackDarkNum)

	IniWriteS($building, "other", "listResource", $listResourceLocation)


	IniWriteS($building, "other", "xBarrack1", $barrackPos[0][0])
	IniWriteS($building, "other", "yBarrack1", $barrackPos[0][1])

	IniWriteS($building, "other", "xBarrack2", $barrackPos[1][0])
	IniWriteS($building, "other", "yBarrack2", $barrackPos[1][1])

	IniWriteS($building, "other", "xBarrack3", $barrackPos[2][0])
	IniWriteS($building, "other", "yBarrack3", $barrackPos[2][1])

	IniWriteS($building, "other", "xBarrack4", $barrackPos[3][0])
	IniWriteS($building, "other", "yBarrack4", $barrackPos[3][1])


	IniWriteS($building, "other", "xspellfactory", $SFPos[0])
	IniWriteS($building, "other", "yspellfactory", $SFPos[1])

	IniWriteS($building, "other", "xDspellfactory", $DSFPos[0])
	IniWriteS($building, "other", "yDspellfactory", $DSFPos[1])

	IniWriteS($building, "other", "xKingAltarPos", $KingAltarPos[0])
	IniWriteS($building, "other", "yKingAltarPos", $KingAltarPos[1])

	IniWriteS($building, "other", "xQueenAltarPos", $QueenAltarPos[0])
	IniWriteS($building, "other", "yQueenAltarPos", $QueenAltarPos[1])

	IniWriteS($building, "other", "xWardenAltarPos", $WardenAltarPos[0])
	IniWriteS($building, "other", "yWardenAltarPos", $WardenAltarPos[1])




	IniWriteS($config, "other", "WAOffsetX", $iWAOffsetX)
	IniWriteS($config, "other", "WAOffsetY", $iWAOffsetY)


	; delete Files
	IniWriteS($config, "deletefiles", "DeleteLogs", $ichkDeleteLogs)
	IniWriteS($config, "deletefiles", "DeleteLogsDays", $iDeleteLogsDays)

	IniWriteS($config, "deletefiles", "DeleteTemp", $ichkDeleteTemp)
	IniWriteS($config, "deletefiles", "DeleteTempDays", $iDeleteTempDays)

	IniWriteS($config, "deletefiles", "DeleteLoots", $ichkDeleteLoots)
	IniWriteS($config, "deletefiles", "DeleteLootsDays", $iDeleteLootsDays)

	; planned
	If GUICtrlRead($chkRequestCCHours) = $GUI_CHECKED Then
		IniWriteS($config, "planned", "RequestHoursEnable", 1)
	Else
		IniWriteS($config, "planned", "RequestHoursEnable", 0)
	EndIf
	If GUICtrlRead($chkDonateHours) = $GUI_CHECKED Then
		IniWriteS($config, "planned", "DonateHoursEnable", 1)
	Else
		IniWriteS($config, "planned", "DonateHoursEnable", 0)
	EndIf

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkDonateHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "DonateHours", $string)

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkRequestCCHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "RequestHours", $string)

	If GUICtrlRead($chkDropCCHoursEnable) = $GUI_CHECKED Then
		IniWriteS($config, "planned", "DropCCEnable", 1)
	Else
		IniWriteS($config, "planned", "DropCCEnable", 0)
	EndIf

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkDropCCHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "DropCCHours", $string)

	Local $string = ""
	For $i = 0 To 23
		If $iPlannedBoostBarracksHours[$i] = 1 Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "BoostBarracksHours", $string)

	Local $string = ""
	For $i = 0 To 23
		If GUICtrlRead(Eval("chkattackHours" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "attackHours", $string)

	Local $string = ""
	For $i = 0 To 6
		If GUICtrlRead(Eval("chkAttackWeekdays" & $i)) = $GUI_CHECKED Then
			$string &= "1|"
		Else
			$string &= "0|"
		EndIf
	Next
	IniWriteS($config, "planned", "attackDays", $string)

	IniWriteS($config, "planned", "chkAttackPlannerEnable", $ichkAttackPlannerEnable)
	IniWriteS($config, "planned", "chkAttackPlannerCloseCoC", $ichkAttackPlannerCloseCoC)
	IniWriteS($config, "planned", "chkAttackPlannerCloseAll", $ichkAttackPlannerCloseAll)
	IniWriteS($config, "planned", "chkAttackPlannerRandom", $ichkAttackPlannerRandom)
	IniWriteS($config, "planned", "cmbAttackPlannerRandom", _GUICtrlComboBox_GetCurSel($cmbAttackPlannerRandom))
	IniWriteS($config, "planned", "chkAttackPlannerDayLimit", $ichkAttackPlannerDayLimit)
	$icmbAttackPlannerDayMin = GUICtrlRead($cmbAttackPlannerDayMin)
	$icmbAttackPlannerDayMax = GUICtrlRead($cmbAttackPlannerDayMax)
	IniWriteS($config, "planned", "cmbAttackPlannerDayMin", $icmbAttackPlannerDayMin)
	IniWriteS($config, "planned", "cmbAttackPlannerDayMax", $icmbAttackPlannerDayMax)

	;Share Attack Settings----------------------------------------
	IniWriteS($config, "shareattack", "minGold", $iShareminGold)
	IniWriteS($config, "shareattack", "minElixir", $iShareminElixir)
	IniWriteS($config, "shareattack", "minDark", $iShareminDark)
	IniWriteS($config, "shareattack", "Message", StringReplace($sShareMessage, @CRLF, "|"))
	If GUICtrlRead($chkShareAttack) = $GUI_CHECKED Then
		IniWriteS($config, "shareattack", "ShareAttack", 1)
	Else
		IniWriteS($config, "shareattack", "ShareAttack", 0)
	EndIf

	;Use random click
	IniWriteS($config, "other", "UseRandomClick", $iUseRandomClick)

	;Add idle phase during training
	IniWriteS($config, "other", "chkAddIdleTime", $ichkAddIdleTime)

	;screenshot
	IniWriteS($config, "other", "ScreenshotType", $iScreenshotType)
	IniWriteS($config, "other", "ScreenshotHideName", $ichkScreenshotHideName)

	; debug

	IniWriteS($config, "debug", "debugsetclick", $debugClick)
	If $devmode = 1 Then
		IniWriteS($config, "debug", "debugsetlog", $DebugSetlog)
		IniWriteS($config, "debug", "disablezoomout", $debugDisableZoomout)
		IniWriteS($config, "debug", "disablevillagecentering", $debugDisableVillageCentering)
		IniWriteS($config, "debug", "debugdeadbaseimage", $debugDeadbaseImage)
		IniWriteS($config, "debug", "debugocr", $debugOcr)
		IniWriteS($config, "debug", "debugimagesave", $DebugImageSave)
		IniWriteS($config, "debug", "debugbuildingpos", $debugBuildingPos)
		IniWriteS($config, "debug", "debugtrain", $debugsetlogTrain)
		IniWriteS($config, "debug", "debugresourcesoffset", $debugresourcesoffset)
		IniWriteS($config, "debug", "continuesearchelixirdebug", $continuesearchelixirdebug)
		IniWriteS($config, "debug", "debugMilkingIMGmake", $debugMilkingIMGmake)
		IniWriteS($config, "debug", "debugOCRDonate", $debugOCRdonate)
		IniWriteS($config, "debug", "debugAttackCSV", $debugAttackCSV)
		IniWriteS($config, "debug", "debugmakeimgcsv", $makeIMGCSV)
	Else
		IniDelete($config, "debug", "debugocr")
		IniDelete($config, "debug", "debugsetlog")
		IniDelete($config, "debug", "debugimagesave")
		IniDelete($config, "debug", "debugbuildingpos")
		IniDelete($config, "debug", "debugtrain")
		IniDelete($config, "debug", "debugresourcesoffset")
		IniDelete($config, "debug", "continuesearchelixirdebug")
		IniDelete($config, "debug", "debugMilkingIMGmake")
		IniDelete($config, "debug", "debugOCRDonate")
		IniDelete($config, "debug", "debugAttackCSV")
		IniDelete($config, "debug", "debugmakeimgcsv")
	EndIf

	IniWriteS($config, "other", "ChkUseQTrain", $ichkUseQTrain)
	IniWriteS($config, "other", "ChkForceBrewBeforeAttack", $ichkForceBrewBeforeAttack)

	;forced Total Camp values
	IniWriteS($config, "other", "ChkTotalCampForced", $ichkTotalCampForced)
	IniWriteS($config, "other", "ValueTotalCampForced", $iValueTotalCampForced)

	IniWriteS($config, "other", "chkSinglePBTForced", $ichkSinglePBTForced)
	IniWriteS($config, "other", "ValueSinglePBTimeForced", $iValueSinglePBTimeForced)
	IniWriteS($config, "other", "ValuePBTimeForcedExit", $iValuePBTimeForcedExit)

	IniWriteS($config, "General", "ChkLanguage", $ichkLanguage)

	IniWriteS($config, "General", "ChkDisableSplash", $ichkDisableSplash)
	IniWriteS($config, "General", "ChkVersion", $ichkVersion)

	If GUICtrlRead($chkFixClanCastle) = $GUI_CHECKED Then
		IniWriteS($config, "other", "ChkFixClanCastle", 1)
	Else
		IniWriteS($config, "other", "ChkFixClanCastle", 0)
	EndIf

	IniWriteS($config, "search", "SWTtiles", GUICtrlRead($txtSWTTiles))

	;Multilanguage
	IniWriteS($config, "other", "language", $sLanguage)

	If $ichkExtraAlphabets = 1 Or $ichkExtraChinese = 1 Then FileClose($config)

	SaveStatChkTownHall() ;call function save stats
	SaveStatChkDeadBase() ;call function save stats

	IniWriteS($config, "attack", "ScriptDB", $scmbDBScriptName)
	IniWriteS($config, "attack", "ScriptAB", $scmbABScriptName)

	IniWriteS($config, "attack", "RedlineRoutineDB", $iRedlineRoutine[$DB])
	IniWriteS($config, "attack", "RedlineRoutineAB", $iRedlineRoutine[$LB])
	IniWriteS($config, "attack", "DroplineEdgeDB", $iDroplineEdge[$DB])
	IniWriteS($config, "attack", "DroplineEdgeAB", $iDroplineEdge[$LB])

	;MilkingAttack Options
	IniWriteS($config, "MilkingAttack", "LocateMine", $MilkFarmLocateMine)
	IniWriteS($config, "MilkingAttack", "LocateElixir", $MilkFarmLocateElixir)
	IniWriteS($config, "MilkingAttack", "LocateDrill", $MilkFarmLocateDrill)
	Local $tempElixirParam = ""
	For $i = 0 To UBound($MilkFarmElixirParam) - 1
		$tempElixirParam &= $MilkFarmElixirParam[$i] & "|"
	Next
	$tempElixirParam = StringLeft($tempElixirParam, StringLen($tempElixirParam) - 1)
	IniWriteS($config, "MilkingAttack", "LocateElixirLevel", $tempElixirParam)
	IniWriteS($config, "MilkingAttack", "MineParam", $MilkFarmMineParam)
	IniWriteS($config, "MilkingAttack", "DrillParam", $MilkFarmDrillParam)

	IniWriteS($config, "MilkingAttack", "AttackElixir", $MilkFarmAttackElixirExtractors)
	IniWriteS($config, "MilkingAttack", "AttackMine", $MilkFarmAttackGoldMines)
	IniWriteS($config, "MilkingAttack", "AttackDrill", $MilkFarmAttackDarkDrills)
	IniWriteS($config, "MilkingAttack", "LimitGold", $MilkFarmLimitGold)
	IniWriteS($config, "MilkingAttack", "LimitElixir", $MilkFarmLimitElixir)
	IniWriteS($config, "MilkingAttack", "LimitDark", $MilkFarmLimitDark)
	IniWriteS($config, "MilkingAttack", "MaxTiles", $MilkFarmResMaxTilesFromBorder)

	IniWriteS($config, "MilkingAttack", "TroopForWaveMin", $MilkFarmTroopForWaveMin)
	IniWriteS($config, "MilkingAttack", "TroopForWaveMax", $MilkFarmTroopForWaveMax)
	IniWriteS($config, "MilkingAttack", "MaxWaves", $MilkFarmTroopMaxWaves)
	IniWriteS($config, "MilkingAttack", "DelayBetweenWavesMin", $MilkFarmDelayFromWavesMin)
	IniWriteS($config, "MilkingAttack", "DelayBetweenWavesMax", $MilkFarmDelayFromWavesMax)
	IniWriteS($config, "MilkingAttack", "TownhallTiles", $MilkFarmTHMaxTilesFromBorder)
	IniWriteS($config, "MilkingAttack", "TownHallAlgorithm", $MilkFarmAlgorithmTh)
	IniWriteS($config, "MilkingAttack", "TownHallHitAnyway", $MilkFarmSnipeEvenIfNoExtractorsFound)

	IniWriteS($config, "MilkingAttack", "MilkFarmForceTolerance", $MilkFarmForcetolerance)
	IniWriteS($config, "MilkingAttack", "MilkFarmForcetolerancenormal", $MilkFarmForcetolerancenormal)
	IniWriteS($config, "MilkingAttack", "MilkFarmForcetoleranceboosted", $MilkFarmForcetoleranceboosted)
	IniWriteS($config, "MilkingAttack", "MilkFarmForcetolerancedestroyed", $MilkFarmForcetolerancedestroyed)

	IniWriteS($config, "MilkingAttack", "CheckStructureDestroyedBeforeAttack", $MilkingAttackCheckStructureDestroyedBeforeAttack)
	IniWriteS($config, "MilkingAttack", "CheckStructureDestroyedAfterAttack", $MilkingAttackCheckStructureDestroyedAfterAttack)

	IniWriteS($config, "MilkingAttack", "DropRandomPlace", $MilkingAttackDropGoblinAlgorithm)
	IniWriteS($config, "MilkingAttack", "StructureOrder", $MilkingAttackStructureOrder)

	IniWriteS($config, "MilkingAttack", "MilkAttackAfterTHSnipe", $MilkAttackAfterTHSnipe)
	IniWriteS($config, "MilkingAttack", "MilkAttackAfterScriptedAtk", $MilkAttackAfterScriptedAtk)

;~ 	IniWriteS($config, "MilkingAttack", "MAStandardAlgorithm",$iCmbStandardAlgorithm[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MADeploy", $iChkDeploySettings[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MAUnitD", $iCmbUnitDelay[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MAWaveD", $iCmbWaveDelay[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MARandomSpeedAtk", $iChkRandomspeedatk[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MASmartAttackRedArea", $iChkRedArea[$MA])
;~ 	IniWriteS($config, "MilkingAttack", "MASmartAttackGoldMine", $iChkSmartAttack[$MA][0])
;~ 	IniWriteS($config, "MilkingAttack", "MASmartAttackElixirCollector", $iChkSmartAttack[$MA][1])
;~ 	IniWriteS($config, "MilkingAttack", "MASmartAttackDarkElixirDrill", $iChkSmartAttack[$MA][2])

	IniWriteS($config, "MilkingAttack", "MilkAttackCSVscript", $MilkAttackCSVscript)
	IniWriteS($config, "MilkingAttack", "MilkAttackType", $MilkAttackType)

	IniWriteS($config, "collectors", "lvl6Enabled", $chkLvl6Enabled)
	IniWriteS($config, "collectors", "lvl7Enabled", $chkLvl7Enabled)
	IniWriteS($config, "collectors", "lvl8Enabled", $chkLvl8Enabled)
	IniWriteS($config, "collectors", "lvl9Enabled", $chkLvl9Enabled)
	IniWriteS($config, "collectors", "lvl10Enabled", $chkLvl10Enabled)
	IniWriteS($config, "collectors", "lvl11Enabled", $chkLvl11Enabled)
	IniWriteS($config, "collectors", "lvl12Enabled", $chkLvl12Enabled)
	IniWriteS($config, "collectors", "lvl6fill", $cmbLvl6Fill)
	IniWriteS($config, "collectors", "lvl7fill", $cmbLvl7Fill)
	IniWriteS($config, "collectors", "lvl8fill", $cmbLvl8Fill)
	IniWriteS($config, "collectors", "lvl9fill", $cmbLvl9Fill)
	IniWriteS($config, "collectors", "lvl10fill", $cmbLvl10Fill)
	IniWriteS($config, "collectors", "lvl11fill", $cmbLvl11Fill)
	IniWriteS($config, "collectors", "lvl12fill", $cmbLvl12Fill)
	IniWriteS($config, "collectors", "minmatches", $iMinCollectorMatches)
	IniWriteS($config, "collectors", "tolerance", $toleranceOffset)


	; Android Configuration
	cmbCOCDistributors()
	IniWriteS($config, "android", "auto.adjust.config", ($AndroidAutoAdjustConfig ? "1" : "0"))
	IniWriteS($config, "android", "game.distributor", $AndroidGameDistributor)
	IniWriteS($config, "android", "game.package", $AndroidGamePackage)
	IniWriteS($config, "android", "game.class", $AndroidGameClass)
	IniWriteS($config, "android", "user.distributor", $UserGameDistributor)
	IniWriteS($config, "android", "user.package", $UserGamePackage)
	IniWriteS($config, "android", "user.class", $UserGameClass)
	IniWriteS($config, "android", "check.time.lag.enabled", ($AndroidCheckTimeLagEnabled ? "1" : "0"))
	IniWriteS($config, "android", "adb.screencap.timeout.min", $AndroidAdbScreencapTimeoutMin)
	IniWriteS($config, "android", "adb.screencap.timeout.max", $AndroidAdbScreencapTimeoutMax)
	IniWriteS($config, "android", "adb.screencap.timeout.dynamic", $AndroidAdbScreencapTimeoutDynamic)
	IniWriteS($config, "android", "adb.input.enabled", ($AndroidAdbInputEnabled ? "1" : "0"))
	IniWriteS($config, "android", "adb.click.enabled", ($AndroidAdbClickEnabled ? "1" : "0"))
	IniWriteS($config, "android", "adb.click.group", $AndroidAdbClickGroup)
	IniWriteS($config, "android", "adb.clicks.enabled", ($AndroidAdbClicksEnabled ? "1" : "0"))
	IniWriteS($config, "android", "adb.clicks.troop.deploy.size", $AndroidAdbClicksTroopDeploySize)
	IniWriteS($config, "android", "no.focus.tampering", ($NoFocusTampering ? "1" : "0"))
	IniWriteS($config, "android", "shield.color", Hex($AndroidShieldColor, 6))
	IniWriteS($config, "android", "shield.transparency", $AndroidShieldTransparency)
	IniWriteS($config, "android", "active.color", Hex($AndroidActiveColor, 6))
	IniWriteS($config, "android", "active.transparency", $AndroidActiveTransparency)
	IniWriteS($config, "android", "inactive.color", Hex($AndroidInactiveColor, 6))
	IniWriteS($config, "android", "inactive.transparency", $AndroidInactiveTransparency)

	;Apply to switch Attack Standard after THSnipe End ==>
	If GUICtrlRead($chkTSActivateCamps2) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkTSSearchCamps2", 1)
	Else
		IniWriteS($config, "search", "ChkTSSearchCamps2", 0)
	EndIf
	IniWriteS($config, "search", "TSEnableAfterArmyCamps2", GUICtrlRead($txtTSArmyCamps2))
	;==> Apply to switch Attack Standard after THSnipe End

	; Wait For Spells
	If GUICtrlRead($chkDBSpellsWait) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBSpellsWait", 1)
	Else
		IniWriteS($config, "search", "ChkDBSpellsWait", 0)
	EndIf

	If GUICtrlRead($chkDBWaitForCastleSpell) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBCastleSpellWait", 1)
	Else
		IniWriteS($config, "search", "ChkDBCastleSpellWait", 0)
	EndIf

	If GUICtrlRead($chkABSpellsWait) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABSpellsWait", 1)
	Else
		IniWriteS($config, "search", "ChkABSpellsWait", 0)
	EndIf
	IniWriteS($config, "search", "TotalTrainSpaceSpell", 0)

	If GUICtrlRead($chkABWaitForCastleSpell) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABCastleSpellWait", 1)
	Else
		IniWriteS($config, "search", "ChkABCastleSpellWait", 0)
	EndIf


	If GUICtrlRead($chkDBWaitForCastleTroops) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkDBCastleTroopsWait", 1)
	Else
		IniWriteS($config, "search", "ChkDBCastleTroopsWait", 0)
	EndIf
	If GUICtrlRead($chkABWaitForCastleTroops) = $GUI_CHECKED Then
		IniWriteS($config, "search", "ChkABCastleTroopsWait", 1)
	Else
		IniWriteS($config, "search", "ChkABCastleTroopsWait", 0)
	EndIf
	IniWriteS($config, "search", "cmbDBWaitForCastleSpell", _GUICtrlComboBox_GetCurSel($cmbDBWaitForCastleSpell))
	IniWriteS($config, "search", "cmbDBWaitForCastleSpell2", _GUICtrlComboBox_GetCurSel($cmbDBWaitForCastleSpell2))
	IniWriteS($config, "search", "cmbABWaitForCastleSpell", _GUICtrlComboBox_GetCurSel($cmbABWaitForCastleSpell))
	IniWriteS($config, "search", "cmbABWaitForCastleSpell2", _GUICtrlComboBox_GetCurSel($cmbABWaitForCastleSpell2))

	;Add idle phase during training	, save variables to config file
	If GUICtrlRead($chkAddDelayIdlePhaseEnable) = $GUI_CHECKED Then
		IniWriteS($config, "other", "chkAddDelayIdlePhaseEnable", "1")
	Else
		IniWriteS($config, "other", "chkAddDelayIdlePhaseEnable", "0")
	EndIf
	IniWriteS($config, "other", "txtAddDelayIdlePhaseTimeMin", GUICtrlRead($txtAddDelayIdlePhaseTimeMin))
	IniWriteS($config, "other", "txtAddDelayIdlePhaseTimeMax", GUICtrlRead($txtAddDelayIdlePhaseTimeMax))
	;===========SamM0d Config=======================
	#include "..\..\SamM0d\saveConfig.au3"
	;==============End SamM0D Config================
	IniWriteS($config, "troop", "QuickTrain1", $iChkQuickArmy1)
	IniWriteS($config, "troop", "QuickTrain2", $iChkQuickArmy2)
	IniWriteS($config, "troop", "QuickTrain3", $iChkQuickArmy3)
; ============================================================================
; ================================= SmartZap =================================
; ============================================================================
	If GUICtrlRead($chkSmartLightSpell) = $GUI_CHECKED Then
		IniWrite($config, "SmartZap", "UseSmartZap", 1)
	Else
		IniWrite($config, "SmartZap", "UseSmartZap", 0)
	EndIf
	If GUICtrlRead($chkNoobZap) = $GUI_CHECKED Then
		IniWrite($config, "SmartZap", "UseNoobZap", 1)
	Else
		IniWrite($config, "SmartZap", "UseNoobZap", 0)
	EndIf
	If GUICtrlRead($chkEarthQuakeZap) = $GUI_CHECKED Then
		IniWrite($config, "SmartZap", "UseEarthQuakeZap", 1)
	Else
		IniWrite($config, "SmartZap", "UseEarthQuakeZap", 0)
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
	If GUICtrlRead($chkDebugSmartZap) = $GUI_CHECKED Then
		IniWrite($config, "SmartZap", "DebugSmartZap", 1)
	Else
		IniWrite($config, "SmartZap", "DebugSmartZap", 0)
	EndIf
	IniWrite($config, "SmartZap", "MinDE", GUICtrlRead($txtMinDark))
	IniWrite($config, "SmartZap", "ExpectedDE", GUICtrlRead($txtExpectedDE))
; ============================================================================
; ================================= SmartZap =================================
; ============================================================================

	If $hFile <> -1 Then FileClose($hFile)

EndFunc   ;==>saveConfig

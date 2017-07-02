; #FUNCTION# ====================================================================================================================
; Name ..........: UpdateStats
; Description ...: This function will update the statistics in the GUI.
; Syntax ........: UpdateStats()
; Parameters ....: None
; Return values .: None
; Author ........: kaganus (2015-jun-20)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......:
; ===============================================================================================================================

Global $ResetStats = 0
Global $iOldFreeBuilderCount, $iOldTotalBuilderCount, $iOldGemAmount ; builder and gem amounts
Global $iOldGoldCurrent, $iOldElixirCurrent, $iOldDarkCurrent, $iOldTrophyCurrent ; current stats
Global $iOldGoldTotal, $iOldElixirTotal, $iOldDarkTotal, $iOldTrophyTotal ; total stats
Global $iOldGoldLast, $iOldElixirLast, $iOldDarkLast, $iOldTrophyLast ; loot and trophy gain from last raid
Global $iOldGoldLastBonus, $iOldElixirLastBonus, $iOldDarkLastBonus ; bonus loot from last raid
Global $iOldSkippedVillageCount, $iOldDroppedTrophyCount ; skipped village and dropped trophy counts
Global $iOldCostGoldWall, $iOldCostElixirWall, $iOldCostGoldBuilding, $iOldCostElixirBuilding, $iOldCostDElixirHero ; wall, building and hero upgrade costs
Global $iOldNbrOfWallsUppedGold, $iOldNbrOfWallsUppedElixir, $iOldNbrOfBuildingsUppedGold, $iOldNbrOfBuildingsUppedElixir, $iOldNbrOfHeroesUpped ; number of wall, building, hero upgrades with gold, elixir, delixir
Global $iOldSearchCost, $iOldTrainCostElixir, $iOldTrainCostDElixir ; search and train troops cost
Global $iOldNbrOfOoS ; number of Out of Sync occurred
Global $iOldNbrOfTHSnipeFails, $iOldNbrOfTHSnipeSuccess ; number of fails and success while TH Sniping
Global $iOldGoldFromMines, $iOldElixirFromCollectors, $iOldDElixirFromDrills ; number of resources gain by collecting mines, collectors, drills
Global $iOldAttackedCount, $iOldAttackedVillageCount[$iModeCount + 1] ; number of attack villages for DB, LB, TB, TS
Global $iOldTotalGoldGain[$iModeCount + 1], $iOldTotalElixirGain[$iModeCount + 1], $iOldTotalDarkGain[$iModeCount + 1], $iOldTotalTrophyGain[$iModeCount + 1] ; total resource gains for DB, LB, TB, TS
Global $iOldNbrOfDetectedMines[$iModeCount + 1], $iOldNbrOfDetectedCollectors[$iModeCount + 1], $iOldNbrOfDetectedDrills[$iModeCount + 1] ; number of mines, collectors, drills detected for DB, LB, TB

Func UpdateStats()
	If $FirstRun = 1 Then
		;GUICtrlSetState($lblResultStatsTemp, $GUI_HIDE)
		GUICtrlSetState($lblVillageReportTemp, $GUI_HIDE)
		GUICtrlSetState($picResultGoldTemp, $GUI_HIDE)
		GUICtrlSetState($picResultElixirTemp, $GUI_HIDE)
		GUICtrlSetState($picResultDETemp, $GUI_HIDE)

		GUICtrlSetState($lblResultGoldNow, $GUI_SHOW + $GUI_DISABLE) ; $GUI_DISABLE to trigger default view in btnVillageStat
		GUICtrlSetState($picResultGoldNow, $GUI_SHOW)
		GUICtrlSetState($lblResultElixirNow, $GUI_SHOW)
		GUICtrlSetState($picResultElixirNow, $GUI_SHOW)
		If $iDarkCurrent <> "" Then
			GUICtrlSetState($lblResultDeNow, $GUI_SHOW)
			GUICtrlSetState($picResultDeNow, $GUI_SHOW)
		Else
			GUICtrlSetState($picResultDEStart, $GUI_HIDE)
			GUICtrlSetState($picDarkLoot, $GUI_HIDE)
			GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
			GUICtrlSetState($picHourlyStatsDark, $GUI_HIDE)
		EndIf
		GUICtrlSetState($lblResultTrophyNow, $GUI_SHOW)
		GUICtrlSetState($lblResultBuilderNow, $GUI_SHOW)
		GUICtrlSetState($lblResultGemNow, $GUI_SHOW)
		btnVillageStat("UpdateStats")
		$iGoldStart = $iGoldCurrent
		$iElixirStart = $iElixirCurrent
		$iDarkStart = $iDarkCurrent
		$iTrophyStart = $iTrophyCurrent
		GUICtrlSetData($lblResultGoldStart, _NumberFormat($iGoldCurrent, True))
		GUICtrlSetData($lblResultGoldNow, _NumberFormat($iGoldCurrent, True))
		$iOldGoldCurrent = $iGoldCurrent
		GUICtrlSetData($lblResultElixirStart, _NumberFormat($iElixirCurrent, True))
		GUICtrlSetData($lblResultElixirNow, _NumberFormat($iElixirCurrent, True))
		$iOldElixirCurrent = $iElixirCurrent
		If $iDarkStart <> "" Then
			GUICtrlSetData($lblResultDEStart, _NumberFormat($iDarkCurrent, True))
			GUICtrlSetData($lblResultDeNow, _NumberFormat($iDarkCurrent, True))
			$iOldDarkCurrent = $iDarkCurrent
		EndIf
		GUICtrlSetData($lblResultTrophyStart, _NumberFormat($iTrophyCurrent, True))
		GUICtrlSetData($lblResultTrophyNow, _NumberFormat($iTrophyCurrent, True))
		$iOldTrophyCurrent = $iTrophyCurrent
		GUICtrlSetData($lblResultGemNow, _NumberFormat($iGemAmount, True))
		$iOldGemAmount = $iGemAmount
		GUICtrlSetData($lblResultBuilderNow, $iFreeBuilderCount & "/" & $iTotalBuilderCount)
		$iOldFreeBuilderCount = $iFreeBuilderCount
		$iOldTotalBuilderCount = $iTotalBuilderCount
		$FirstRun = 0
		GUICtrlSetState($btnResetStats, $GUI_ENABLE)
		Return

	EndIf

	If $FirstAttack = 1 Then
		;GUICtrlSetState($lblLastAttackTemp, $GUI_HIDE)
		;GUICtrlSetState($lblLastAttackBonusTemp, $GUI_HIDE)
		;GUICtrlSetState($lblTotalLootTemp, $GUI_HIDE)
		;GUICtrlSetState($lblHourlyStatsTemp, $GUI_HIDE)
		$FirstAttack = 2
	EndIf

	If Number($iGoldLast) > Number($topgoldloot) Then
		$topgoldloot = $iGoldLast
		GUICtrlSetData($lbltopgoldloot, _NumberFormat($topgoldloot))
	EndIf

	If Number($iElixirLast) > Number($topelixirloot) Then
		$topelixirloot = $iElixirLast
		GUICtrlSetData($lbltopelixirloot, _NumberFormat($topelixirloot))
	EndIf

	If Number($iDarkLast) > Number($topdarkloot) Then
		$topdarkloot = $iDarkLast
		GUICtrlSetData($lbltopdarkloot, _NumberFormat($topdarkloot))
	EndIf

	If Number($iTrophyLast) > Number($topTrophyloot) Then
		$topTrophyloot = $iTrophylast
		GUICtrlSetData($lbltopTrophyloot, _NumberFormat($topTrophyloot))
	EndIf

	If $ResetStats = 1 Then
		GUICtrlSetData($lblResultGoldStart, _NumberFormat($iGoldCurrent, True))
		GUICtrlSetData($lblResultElixirStart, _NumberFormat($iElixirCurrent, True))
		If $iDarkStart <> "" Then
			GUICtrlSetData($lblResultDEStart, _NumberFormat($iDarkCurrent, True))
		EndIf
		GUICtrlSetData($lblResultTrophyStart, _NumberFormat($iTrophyCurrent, True))
		GUICtrlSetData($lblHourlyStatsGold, "")
		GUICtrlSetData($lblHourlyStatsElixir, "")
		GUICtrlSetData($lblHourlyStatsDark, "")
		GUICtrlSetData($lblHourlyStatsTrophy, "")
		GUICtrlSetData($lblResultGoldHourNow, "") ;GUI BOTTOM
		GUICtrlSetData($lblResultElixirHourNow, "") ;GUI BOTTOM
		GUICtrlSetData($lblResultDEHourNow, "") ;GUI BOTTOM

	EndIf

	If $iOldFreeBuilderCount <> $iFreeBuilderCount Or $iOldTotalBuilderCount <> $iTotalBuilderCount Then
		GUICtrlSetData($lblResultBuilderNow, $iFreeBuilderCount & "/" & $iTotalBuilderCount)
		$iOldFreeBuilderCount = $iFreeBuilderCount
		$iOldTotalBuilderCount = $iTotalBuilderCount
	EndIf

	If $iOldGemAmount <> $iGemAmount Then
		GUICtrlSetData($lblResultGemNow, _NumberFormat($iGemAmount, True))
		$iOldGemAmount = $iGemAmount
	EndIf

	If $iOldGoldCurrent <> $iGoldCurrent Then
		GUICtrlSetData($lblResultGoldNow, _NumberFormat($iGoldCurrent, True))
		$iOldGoldCurrent = $iGoldCurrent
	EndIf

	If $iOldElixirCurrent <> $iElixirCurrent Then
		GUICtrlSetData($lblResultElixirNow, _NumberFormat($iElixirCurrent, True))
		$iOldElixirCurrent = $iElixirCurrent
	EndIf

	If $iOldDarkCurrent <> $iDarkCurrent And $iDarkStart <> "" Then
		GUICtrlSetData($lblResultDeNow, _NumberFormat($iDarkCurrent, True))
		$iOldDarkCurrent = $iDarkCurrent
	EndIf

	If $iOldTrophyCurrent <> $iTrophyCurrent Then
		GUICtrlSetData($lblResultTrophyNow, _NumberFormat($iTrophyCurrent, True))
		$iOldTrophyCurrent = $iTrophyCurrent
	EndIf

	If $iOldGoldTotal <> $iGoldTotal And ($FirstAttack = 2 Or $ResetStats = 1) Then
		GUICtrlSetData($lblGoldLoot, _NumberFormat($iGoldTotal))
		$iOldGoldTotal = $iGoldTotal
	EndIf

	If $iOldElixirTotal <> $iElixirTotal And ($FirstAttack = 2 Or $ResetStats = 1) Then
		GUICtrlSetData($lblElixirLoot, _NumberFormat($iElixirTotal))
		$iOldElixirTotal = $iElixirTotal
	EndIf

	If $iOldDarkTotal <> $iDarkTotal And (($FirstAttack = 2 And $iDarkStart <> "") Or $ResetStats = 1) Then
		GUICtrlSetData($lblDarkLoot, _NumberFormat($iDarkTotal))
		$iOldDarkTotal = $iDarkTotal
	EndIf

	If $iOldTrophyTotal <> $iTrophyTotal And ($FirstAttack = 2 Or $ResetStats = 1) Then
		GUICtrlSetData($lblTrophyLoot, _NumberFormat($iTrophyTotal))
		$iOldTrophyTotal = $iTrophyTotal
	EndIf

	If $iOldGoldLast <> $iGoldLast Then
		GUICtrlSetData($lblGoldLastAttack, _NumberFormat($iGoldLast))
		$iOldGoldLast = $iGoldLast
	EndIf

	If $iOldElixirLast <> $iElixirLast Then
		GUICtrlSetData($lblElixirLastAttack, _NumberFormat($iElixirLast))
		$iOldElixirLast = $iElixirLast
	EndIf

	If $iOldDarkLast <> $iDarkLast Then
		GUICtrlSetData($lblDarkLastAttack, _NumberFormat($iDarkLast))
		$iOldDarkLast = $iDarkLast
	EndIf

	If $iOldTrophyLast <> $iTrophyLast Then
		GUICtrlSetData($lblTrophyLastAttack, _NumberFormat($iTrophyLast))
		$iOldTrophyLast = $iTrophyLast
	EndIf

	If $iOldGoldLastBonus <> $iGoldLastBonus Then
		GUICtrlSetData($lblGoldBonusLastAttack, _NumberFormat($iGoldLastBonus))
		$iOldGoldLastBonus = $iGoldLastBonus
	EndIf

	If $iOldElixirLastBonus <> $iElixirLastBonus Then
		GUICtrlSetData($lblElixirBonusLastAttack, _NumberFormat($iElixirLastBonus))
		$iOldElixirLastBonus = $iElixirLastBonus
	EndIf

	If $iOldDarkLastBonus <> $iDarkLastBonus Then
		GUICtrlSetData($lblDarkBonusLastAttack, _NumberFormat($iDarkLastBonus))
		$iOldDarkLastBonus = $iDarkLastBonus
	EndIf

	If $iOldCostGoldWall <> $iCostGoldWall Then
		GUICtrlSetData($lblWallUpgCostGold, _NumberFormat($iCostGoldWall, True))
		$iOldCostGoldWall = $iCostGoldWall
	EndIf

	If $iOldCostElixirWall <> $iCostElixirWall Then
		GUICtrlSetData($lblWallUpgCostElixir, _NumberFormat($iCostElixirWall, True))
		$iOldCostElixirWall = $iCostElixirWall
	EndIf

	If $iOldCostGoldBuilding <> $iCostGoldBuilding Then
		GUICtrlSetData($lblBuildingUpgCostGold, _NumberFormat($iCostGoldBuilding, True))
		$iOldCostGoldBuilding = $iCostGoldBuilding
	EndIf

	If $iOldCostElixirBuilding <> $iCostElixirBuilding Then
		GUICtrlSetData($lblBuildingUpgCostElixir, _NumberFormat($iCostElixirBuilding, True))
		$iOldCostElixirBuilding = $iCostElixirBuilding
	EndIf

	If $iOldCostDElixirHero <> $iCostDElixirHero Then
		GUICtrlSetData($lblHeroUpgCost, _NumberFormat($iCostDElixirHero, True))
		$iOldCostDElixirHero = $iCostDElixirHero
	EndIf

	If $iOldSkippedVillageCount <> $iSkippedVillageCount Then
		GUICtrlSetData($lblresultvillagesskipped, _NumberFormat($iSkippedVillageCount, True))
		GUICtrlSetData($lblResultSkippedHourNow, _NumberFormat($iSkippedVillageCount, True))
		$iOldSkippedVillageCount = $iSkippedVillageCount
	EndIf

	If $iOldDroppedTrophyCount <> $iDroppedTrophyCount Then
		GUICtrlSetData($lblresulttrophiesdropped, _NumberFormat($iDroppedTrophyCount, True))
		$iOldDroppedTrophyCount = $iDroppedTrophyCount
	EndIf

	If $iOldNbrOfWallsUppedGold <> $iNbrOfWallsUppedGold Then
		GUICtrlSetData($lblWallgoldmake, $iNbrOfWallsUppedGold)
		$iOldNbrOfWallsUppedGold = $iNbrOfWallsUppedGold
		WallsStatsMAJ()
	EndIf

	If $iOldNbrOfWallsUppedElixir <> $iNbrOfWallsUppedElixir Then
		GUICtrlSetData($lblWallelixirmake, $iNbrOfWallsUppedElixir)
		$iOldNbrOfWallsUppedElixir = $iNbrOfWallsUppedElixir
		WallsStatsMAJ()
	EndIf

	If $iOldNbrOfBuildingsUppedGold <> $iNbrOfBuildingsUppedGold Then
		GUICtrlSetData($lblNbrOfBuildingUpgGold, $iNbrOfBuildingsUppedGold)
		$iOldNbrOfBuildingsUppedGold = $iNbrOfBuildingsUppedGold
	EndIf

	If $iOldNbrOfBuildingsUppedElixir <> $iNbrOfBuildingsUppedElixir Then
		GUICtrlSetData($lblNbrOfBuildingUpgElixir, $iNbrOfBuildingsUppedElixir)
		$iOldNbrOfBuildingsUppedElixir = $iNbrOfBuildingsUppedElixir
	EndIf

	If $iOldNbrOfHeroesUpped <> $iNbrOfHeroesUpped Then
		GUICtrlSetData($lblNbrOfHeroUpg, $iNbrOfHeroesUpped)
		$iOldNbrOfHeroesUpped = $iNbrOfHeroesUpped
	EndIf

	If $iOldSearchCost <> $iSearchCost Then
		GUICtrlSetData($lblSearchCost, _NumberFormat($iSearchCost, True))
		$iOldSearchCost = $iSearchCost
	EndIf

	If $iOldTrainCostElixir <> $iTrainCostElixir Then
		GUICtrlSetData($lblTrainCostElixir, _NumberFormat($iTrainCostElixir, True))
		$iOldTrainCostElixir = $iTrainCostElixir
	EndIf

	If $iOldTrainCostDElixir <> $iTrainCostDElixir Then
		GUICtrlSetData($lblTrainCostDElixir, _NumberFormat($iTrainCostDElixir, True))
		$iOldTrainCostDElixir = $iTrainCostDElixir
	EndIf

	If $iOldNbrOfOoS <> $iNbrOfOoS Then
		GUICtrlSetData($lblNbrOfOoS, $iNbrOfOoS)
		$iOldNbrOfOoS = $iNbrOfOoS
	EndIf

	If $iOldNbrOfTHSnipeFails <> $iNbrOfTHSnipeFails Then
		GUICtrlSetData($lblNbrOfTSFailed, $iNbrOfTHSnipeFails)
		$iOldNbrOfTHSnipeFails = $iNbrOfTHSnipeFails
	EndIf

	If $iOldNbrOfTHSnipeSuccess <> $iNbrOfTHSnipeSuccess Then
		GUICtrlSetData($lblNbrOfTSSuccess, $iNbrOfTHSnipeSuccess)
		$iOldNbrOfTHSnipeSuccess = $iNbrOfTHSnipeSuccess
	EndIf

	If $iOldGoldFromMines <> $iGoldFromMines Then
		GUICtrlSetData($lblGoldFromMines, _NumberFormat($iGoldFromMines, True))
		$iOldGoldFromMines = $iGoldFromMines
	EndIf

	If $iOldElixirFromCollectors <> $iElixirFromCollectors Then
		GUICtrlSetData($lblElixirFromCollectors, _NumberFormat($iElixirFromCollectors, True))
		$iOldElixirFromCollectors = $iElixirFromCollectors
	EndIf

	If $iOldDElixirFromDrills <> $iDElixirFromDrills Then
		GUICtrlSetData($lblDElixirFromDrills, _NumberFormat($iDElixirFromDrills, True))
		$iOldDElixirFromDrills = $iDElixirFromDrills
	EndIf

	; ============================================================================
	; ================================= SmartZap =================================
	; ============================================================================
	; samm0d - samm0dzap
	; SmartZap DE Gain
	If $iOldSmartZapGain <> $smartZapGain Then
		GUICtrlSetData($lblSmartZapStats, _NumberFormat($smartZapGain, True))
		GUICtrlSetData($lblMySmartZap, _NumberFormat($smartZapGain, True))
		$iOldSmartZapGain = $smartZapGain
	EndIf

	; SmartZap Spells Used
	If $iOldNumLTSpellsUsed <> $numLSpellsUsed Then
		GUICtrlSetData($lblLightningUsedStats, _NumberFormat($numLSpellsUsed, True))
		GUICtrlSetData($lblMyLightningUsed, _NumberFormat($numLSpellsUsed, True))
		$iOldNumLTSpellsUsed = $numLSpellsUsed
	EndIf

	; EarthQuake Spells Used
	If $iOldNumEQSpellsUsed <> $numEQSpellsUsed Then
		GUICtrlSetData($lblEarthQuakeUsedStats, _NumberFormat($numEQSpellsUsed, True))
		$iOldNumEQSpellsUsed = $numEQSpellsUsed
	EndIf
	; ============================================================================
	; ================================= SmartZap =================================
	; ============================================================================

	$iAttackedCount = 0

	For $i = 0 To $iModeCount

		If $iOldAttackedVillageCount[$i] <> $iAttackedVillageCount[$i] Then
			GUICtrlSetData($lblAttacked[$i], _NumberFormat($iAttackedVillageCount[$i], True))
			$iOldAttackedVillageCount[$i] = $iAttackedVillageCount[$i]
		EndIf
		$iAttackedCount += $iAttackedVillageCount[$i]

		If $iOldTotalGoldGain[$i] <> $iTotalGoldGain[$i] Then
			GUICtrlSetData($lblTotalGoldGain[$i], _NumberFormat($iTotalGoldGain[$i], True))
			$iOldTotalGoldGain[$i] = $iTotalGoldGain[$i]
		EndIf

		If $iOldTotalElixirGain[$i] <> $iTotalElixirGain[$i] Then
			GUICtrlSetData($lblTotalElixirGain[$i], _NumberFormat($iTotalElixirGain[$i], True))
			$iOldTotalElixirGain[$i] = $iTotalElixirGain[$i]
		EndIf

		If $iOldTotalDarkGain[$i] <> $iTotalDarkGain[$i] Then
			GUICtrlSetData($lblTotalDElixirGain[$i], _NumberFormat($iTotalDarkGain[$i], True))
			$iOldTotalDarkGain[$i] = $iTotalDarkGain[$i]
		EndIf

		If $iOldTotalTrophyGain[$i] <> $iTotalTrophyGain[$i] Then
			GUICtrlSetData($lblTotalTrophyGain[$i], _NumberFormat($iTotalTrophyGain[$i], True))
			$iOldTotalTrophyGain[$i] = $iTotalTrophyGain[$i]
		EndIf

	Next

	If $iOldAttackedCount <> $iAttackedCount Then
		GUICtrlSetData($lblresultvillagesattacked, _NumberFormat($iAttackedCount, True))
		GUICtrlSetData($lblResultAttackedHourNow, _NumberFormat($iAttackedCount, True))
		$iOldAttackedCount = $iAttackedCount
	EndIf

	For $i = 0 To $iModeCount

		If $i = $TS Then ContinueLoop

		If $iOldNbrOfDetectedMines[$i] <> $iNbrOfDetectedMines[$i] Then
			GUICtrlSetData($lblNbrOfDetectedMines[$i], $iNbrOfDetectedMines[$i])
			$iOldNbrOfDetectedMines[$i] = $iNbrOfDetectedMines[$i]
		EndIf

		If $iOldNbrOfDetectedCollectors[$i] <> $iNbrOfDetectedCollectors[$i] Then
			GUICtrlSetData($lblNbrOfDetectedCollectors[$i], $iNbrOfDetectedCollectors[$i])
			$iOldNbrOfDetectedCollectors[$i] = $iNbrOfDetectedCollectors[$i]
		EndIf

		If $iOldNbrOfDetectedDrills[$i] <> $iNbrOfDetectedDrills[$i] Then
			GUICtrlSetData($lblNbrOfDetectedDrills[$i], $iNbrOfDetectedDrills[$i])
			$iOldNbrOfDetectedDrills[$i] = $iNbrOfDetectedDrills[$i]
		EndIf

	Next

	If $FirstAttack = 2 Then
		GUICtrlSetData($lblHourlyStatsGold, _NumberFormat(Round($iGoldTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
		GUICtrlSetData($lblHourlyStatsElixir, _NumberFormat(Round($iElixirTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h")
		If $iDarkStart <> "" Then
			GUICtrlSetData($lblHourlyStatsDark, _NumberFormat(Round($iDarkTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")
		EndIf
		GUICtrlSetData($lblHourlyStatsTrophy, _NumberFormat(Round($iTrophyTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h")

		GUICtrlSetData($lblResultGoldHourNow, _NumberFormat(Round($iGoldTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM
		GUICtrlSetData($lblResultElixirHourNow, _NumberFormat(Round($iElixirTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600)) & "K / h") ;GUI BOTTOM
		If $iDarkStart <> "" Then
			GUICtrlSetData($lblResultDEHourNow, _NumberFormat(Round($iDarkTotal / (Int(TimerDiff($sTimer) + $iTimePassed)) * 3600 * 1000)) & " / h") ;GUI BOTTOM
		EndIf

	EndIf

	If Number($iGoldLast) > Number($topgoldloot) Then
		$topgoldloot = $iGoldLast
		GUICtrlSetData($lbltopgoldloot, _NumberFormat($topgoldloot))
	EndIf

	If Number($iElixirLast) > Number($topelixirloot) Then
		$topelixirloot = $iElixirLast
		GUICtrlSetData($lbltopelixirloot, _NumberFormat($topelixirloot))
	EndIf

	If Number($iDarkLast) > Number($topdarkloot) Then
		$topdarkloot = $idarklast
		GUICtrlSetData($lbltopdarkloot, _NumberFormat($topdarkloot))
	EndIf

	If Number($iTrophyLast) > Number($topTrophyloot) Then
		$topTrophyloot = $iTrophylast
		GUICtrlSetData($lbltopTrophyloot, _NumberFormat($topTrophyloot))
	EndIf

	If $ichkEnableMySwitch Then
		If $iCurActiveAcc <> - 1 Then
			If $aProfileStats[0][$iCurActiveAcc+1] = 0 Then
				$aProfileStats[0][$iCurActiveAcc+1] = $iGoldCurrent
				$aProfileStats[1][$iCurActiveAcc+1] = $iElixirCurrent
				$aProfileStats[2][$iCurActiveAcc+1] = $iDarkCurrent
				$aProfileStats[3][$iCurActiveAcc+1] = $iTrophyCurrent
				$iDarkStart = $iDarkCurrent
				GUICtrlSetData($lblResultGoldStart, _NumberFormat($aProfileStats[0][$iCurActiveAcc+1], True))
				GUICtrlSetData($lblResultElixirStart, _NumberFormat($aProfileStats[1][$iCurActiveAcc+1], True))
				If $aProfileStats[2][$iCurActiveAcc+1] <> "" Then
					GUICtrlSetData($lblResultDEStart, _NumberFormat($aProfileStats[2][$iCurActiveAcc+1], True))
					GUICtrlSetData($lblResultDeNow, _NumberFormat($aProfileStats[2][$iCurActiveAcc+1], True))
				EndIf
				GUICtrlSetData($lblResultTrophyStart, _NumberFormat($aProfileStats[3][$iCurActiveAcc+1], True))
			EndIf

			saveCurStats($iCurActiveAcc)

			If $aProfileStats[2][$iCurActiveAcc+1] <> "" Then
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

			If $bUpdateStats = True Then
				If $aSwitchList[$iCurStep][4] <> $iCurActiveAcc Then
					For $i = 0 To UBound($aSwitchList) - 1
						If $aSwitchList[$i][4] = $iCurActiveAcc Then
							$iCurStep = $i
						EndIf
					Next
					GUICtrlSetData($grpVillage, GetTranslated(603, 32, "Village") & ": " & $aSwitchList[$iCurStep][3])
					GUICtrlSetData($lblProfileName,$aSwitchList[$iCurStep][3])
					displayStats($iCurActiveAcc)
				EndIf
			EndIf
		EndIf
	EndIf
	;===================================

	If $ResetStats = 1 Then
		$ResetStats = 0
	EndIf

EndFunc   ;==>UpdateStats

Func ResetStats()
	$ResetStats = 1
	$FirstAttack = 0
	$iTimePassed = 0
	$sTimer = TimerInit()
	GUICtrlSetData($lblresultruntime, "00:00:00")
	GUICtrlSetData($lblResultRuntimeNow, "00:00:00")
	;GUICtrlSetState($lblLastAttackTemp, $GUI_SHOW)
	;GUICtrlSetState($lblLastAttackBonusTemp, $GUI_SHOW)
	;GUICtrlSetState($lblTotalLootTemp, $GUI_SHOW)
	;GUICtrlSetState($lblHourlyStatsTemp, $GUI_SHOW)
	$iGoldStart = $iGoldCurrent
	$iElixirStart = $iElixirCurrent
	$iDarkStart = $iDarkCurrent
	$iTrophyStart = $iTrophyCurrent
	$iGoldTotal = 0
	$iElixirTotal = 0
	$iDarkTotal = 0
	$iTrophyTotal = 0
	$iGoldLast = 0
	$iElixirLast = 0
	$iDarkLast = 0
	$iTrophyLast = 0
	$iGoldLastBonus = 0
	$iElixirLastBonus = 0
	$iDarkLastBonus = 0
	$iSkippedVillageCount = 0
	$iDroppedTrophyCount = 0
	$iCostGoldWall = 0
	$iCostElixirWall = 0
	$iCostGoldBuilding = 0
	$iCostElixirBuilding = 0
	$iCostDElixirHero = 0
	$iNbrOfWallsUppedGold = 0
	$iNbrOfWallsUppedElixir = 0
	$iNbrOfBuildingsUppedGold = 0
	$iNbrOfBuildingsUppedElixir = 0
	$iNbrOfHeroesUpped = 0
	$iSearchCost = 0
	$iTrainCostElixir = 0
	$iTrainCostDElixir = 0
	$iNbrOfOoS = 0
	$iNbrOfTHSnipeFails = 0
	$iNbrOfTHSnipeSuccess = 0
	$iGoldFromMines = 0
	$iElixirFromCollectors = 0
	$iDElixirFromDrills = 0
	; ======================= SmartZap =======================
	$smartZapGain = 0
	$numLSpellsUsed = 0
	$numEQSpellsUsed = 0
	; ======================= SmartZap =======================
	For $i = 0 To $iModeCount
		$iAttackedVillageCount[$i] = 0
		$iTotalGoldGain[$i] = 0
		$iTotalElixirGain[$i] = 0
		$iTotalDarkGain[$i] = 0
		$iTotalTrophyGain[$i] = 0
		$iNbrOfDetectedMines[$i] = 0
		$iNbrOfDetectedCollectors[$i] = 0
		$iNbrOfDetectedDrills[$i] = 0
	Next
	;========SamM0d===========
   ; SmartZap DE Gain - From ChaCalGyn(LunaEclipse) - DEMEN
	$smartZapGain = 0
	$numLSpellsUsed = 0

	If $ichkEnableMySwitch Then
		If $iCurActiveAcc <> - 1 Then
			; samm0d myswitch
			For $i = 0 To 7
				resetCurStats($i)
			Next
			$aProfileStats[0][$iCurActiveAcc+1] = $iGoldCurrent
			$aProfileStats[1][$iCurActiveAcc+1] = $iElixirCurrent
			$aProfileStats[2][$iCurActiveAcc+1] = $iDarkCurrent
			$aProfileStats[3][$iCurActiveAcc+1] = $iTrophyCurrent
		EndIf
	EndIf
	For $i = 0 To 28
		$TroopsDonQ[$i] = 0
		GUICtrlSetData($lblDonQ[$i], $TroopsDonQ[$i])
		$TroopsDonXP[$i] = 0
	Next

	GUICtrlSetData($lblTotalTroopsQ, "Total Donated : 0")
	GUICtrlSetData($lblTotalSpellsQ, "Total Donated : 0")
	GUICtrlSetData($lblTotalTroopsXP, "XP Won : 0")
	GUICtrlSetData($lblTotalSpellsXP, "XP Won : 0")

	UpdateStats()
EndFunc   ;==>ResetStats

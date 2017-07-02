; #FUNCTION# ====================================================================================================================
; Name ..........: DonateCC
; Description ...: This file includes functions to Donate troops
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Zax (2015)
; Modified ......: Safar46 (2015), Hervidero (2015-04), HungLe (2015-04), Sardo (2015-08), Promac (2015-12), Hervidero (2016-01), MonkeyHunter (2016-07), Fliegerfaust (2016-12)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
;
Global $DonationWindowY
Global $PrepDon[4] = [False, False, False, False]

Func PrepareDonateCC()

	$PrepDon[0] = BitOR($iChkDonateBarbarians, $iChkDonateArchers, $iChkDonateGiants, $iChkDonateGoblins, _
			$iChkDonateWallBreakers, $iChkDonateBalloons, $iChkDonateWizards, $iChkDonateHealers, _
			$iChkDonateDragons, $iChkDonatePekkas, $iChkDonateBabyDragons, $iChkDonateMiners, $iChkDonateMinions, $iChkDonateHogRiders, _
			$iChkDonateValkyries, $iChkDonateGolems, $iChkDonateWitches, $iChkDonateLavaHounds, $iChkDonateBowlers, $iChkDonateCustomA, $iChkDonateCustomB)

	$PrepDon[1] = BitOR($iChkDonateAllBarbarians, $iChkDonateAllArchers, $iChkDonateAllGiants, $iChkDonateAllGoblins, _
			$iChkDonateAllWallBreakers, $iChkDonateAllBalloons, $iChkDonateAllWizards, $iChkDonateAllHealers, _
			$iChkDonateAllDragons, $iChkDonateAllPekkas, $iChkDonateAllBabyDragons, $iChkDonateAllMiners, $iChkDonateAllMinions, $iChkDonateAllHogRiders, _
			$iChkDonateAllValkyries, $iChkDonateAllGolems, $iChkDonateAllWitches, $iChkDonateAllLavaHounds, $iChkDonateAllBowlers, $iChkDonateAllCustomA, $iChkDonateAllCustomB)

	$PrepDon[2] = BitOR($iChkDonatePoisonSpells, $iChkDonateEarthQuakeSpells, $iChkDonateHasteSpells, $iChkDonateSkeletonSpells, $iChkDonateLightningSpells, $iChkDonateHealSpells, $iChkDonateRageSpells, $iChkDonateJumpSpells, $iChkDonateFreezeSpells)
	$PrepDon[3] = BitOR($iChkDonateAllPoisonSpells, $iChkDonateAllEarthQuakeSpells, $iChkDonateAllHasteSpells, $iChkDonateAllSkeletonSpells, $iChkDonateAllLightningSpells, $iChkDonateAllHealSpells, $iChkDonateAllRageSpells, $iChkDonateAllJumpSpells, $iChkDonateAllFreezeSpells)

	$bActiveDonate = BitOR($PrepDon[0], $PrepDon[1], $PrepDon[2], $PrepDon[3])
	;$bDonate = BitOR($PrepDon[0], $PrepDon[1], $PrepDon[2], $PrepDon[3])
	;Setlog(" - Donate: $bDonate:" & $bDonate & " $bDonateTroop:" & $PrepDon[0] & " $bDonateAllTroop:" & $PrepDon[1] & " $bDonateSpell:" & $PrepDon[2] & " $bDonateAllSpell:" & $PrepDon[3], $COLOR_GREEN)
EndFunc   ;==>PrepareDonateCC

Func DonateCC($Check = False)

	Local $bDonateTroop = $PrepDon[0]

	Local $bDonateAllTroop = $PrepDon[1]

	Local $bDonateSpell = $PrepDon[2]
	Local $bDonateAllSpell = $PrepDon[3]

	Local $bDonate = $bActiveDonate

	Local $bOpen = True, $bClose = False

	;Global $bDonate = BitOR($bDonateTroop, $bDonateAllTroop, $bDonateSpell, $bDonateAllSpell)
	;Setlog(" - Donate: $bDonate:" & $bDonate & " $bDonateTroop:" & $bDonateTroop & " $bDonateAllTroop:" & $bDonateAllTroop & " $bDonateSpell:" & $bDonateSpell & " $bDonateAllSpell:" & $bDonateAllSpell, $COLOR_GREEN)
	Global $iTotalDonateCapacity, $iTotalDonateSpellCapacity

	Global $iDonTroopsLimit = 8, $iDonSpellsLimit = 1, $iDonTroopsAv = 0, $iDonSpellsAv = 0
	Global $iDonTroopsQuantityAv = 0, $iDonTroopsQuantity = 0, $iDonSpellsQuantityAv = 0, $iDonSpellsQuantity = 0

	Global $bSkipDonTroops = False, $bSkipDonSpells = False

	Local $ClanString = ""

	If $bDonate = False Or $bDonationEnabled = False Then
		If $debugsetlog = 1 Then Setlog("Donate Clan Castle troops skip", $COLOR_DEBUG)
		Return ; exit func if no donate checkmarks
	EndIf

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)

	If $iPlannedDonateHours[$hour[0]] = 0 And $iPlannedDonateHoursEnable = 1 Then
		If $debugsetlog = 1 Then SetLog("Donate Clan Castle troops not planned, Skipped..", $COLOR_DEBUG)
		Return ; exit func if no planned donate checkmarks
	EndIf

	;If SkipDonateNearFullTroops() = True Then Return

	Local $y = 90

	;check for new chats first
	If $Check = True Then
		If _ColorCheck(_GetPixelColor(26, 312 + $midOffsetY, True), Hex(0xf00810, 6), 20) = False And $CommandStop <> 3 Then
			Return ;exit if no new chats
		EndIf
	EndIf

	SetLog(_PadStringCenter(" Checking Donate Requests in Clan Chat ", 54, "="), $COLOR_INFO)

	Local $iCount = 0
	While 1
		;<---- opens clan tab and verbose in log
		ClickP($aAway, 1, 0, "#0167") ;Click Away
		ForceCaptureRegion()
		If _ColorCheck(_GetPixelColor($aButtonClanWindowOpen[4], $aButtonClanWindowOpen[5], True), Hex($aButtonClanWindowOpen[6], 6), $aButtonClanWindowOpen[7]) Then
			Click($aButtonClanWindowOpen[0],$aButtonClanWindowOpen[1], 1, 0, "#0168") ; Clicks chat tab
			If _Sleep($iDelayDonateCC4) Then Return
		EndIf

		;If Clan tab is selected.
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x706C50, 6), 20) = True Then ; color med gray
			ExitLoop
		EndIf

		;If Global tab is selected.
		If _ColorCheck(_GetPixelColor(189, 24, True), Hex(0x383828, 6), 20) = True Then ; Darker gray
			If _Sleep($iDelayDonateCC1) Then Return ;small delay to allow tab to completely open
			ClickP($aClanTab, 1, 0, "#0169") ; clicking clan tab
			ExitLoop
		EndIf

		;counter for time approx 3 sec max allowed for tab to open
		$iCount += 1
		If $iCount >= 15 Then ; allows for up to a sleep of 3000
			SetLog("Clan Chat Did Not Open - Abandon Donate")
			AndroidPageError("DonateCC")
			Return
		EndIf
		If _Sleep($iDelayDonateCC1) Then Return ; delay Allow 15x
	WEnd

	Local $Scroll
	Local $donateCCfilter = False
	Local $bCheckRemainingCCcapacity = False
	Local $bDonateWindowOpen = False
	; add scroll here
	While 1
		ForceCaptureRegion()
		;$Scroll = _PixelSearch(288, 640 + $bottomOffsetY, 290, 655 + $bottomOffsetY, Hex(0x588800, 6), 20)
		$y = 90
		$Scroll = _PixelSearch(293, 8 + $y, 295, 23 + $y, Hex(0xFFFFFF, 6), 20)
		If IsArray($Scroll) And _ColorCheck(_GetPixelColor(300, 110, True), Hex(0x509808, 6), 20) = True Then ; a second pixel for the green
			$bDonate = True
			Click($Scroll[0], $Scroll[1], 1, 0, "#0172")
			$y = 90
			If _Sleep($iDelayDonateCC2 + 100) Then ExitLoop
			ContinueLoop
		EndIf
		ExitLoop
	WEnd
	While $bDonate
		checkAttackDisable($iTaBChkIdle) ; Early Take-A-Break detection
		$ClanString = ""
		;samm0d reset value
		;=========================
		$bDonateFlag = False
		$bCheckRemainingCCcapacity = False
		$bDonateWindowOpen = False
		For $i = 0 To 18
			Assign("canDon" & $MyTroops[$i][0],False)
		Next
		$canDonCustomA =False
		$canDonCustomB = False

		For $i = 0 To 9
			If $i <> 5 Then
				Assign("canDon" & $SpellGroup[$i][0],False)
			EndIf
		Next
;~ 		$canDonPSpell = False
;~ 		$canDonESpell = False
;~ 		$canDonHaSpell = False
;~ 		$canDonSkSpell = False
;~ 		$canDonFSpell = False
;~ 		$canDonJSpell = False
;~ 		$canDonHSpell = False
;~ 		$canDonRSpell = False
;~ 		$canDonLSpell = False
		;=========================

		If _Sleep($iDelayDonateCC2) Then ExitLoop
		ForceCaptureRegion()
		$DonatePixel = _MultiPixelSearch(202, $y, 224, 660 + $bottomOffsetY, 50, 1, Hex(0x98D057, 6), $aChatDonateBtnColors, 15)
		If IsArray($DonatePixel) Then ; if Donate Button found
			If $debugsetlog = 1 Then Setlog("$DonatePixel: (" & $DonatePixel[0] & "," & $DonatePixel[1] & ")", $COLOR_DEBUG)
			SetLog(_PadStringCenter(" CC Request ", 54, "="), $COLOR_INFO)

			; collect donate users images
			$donateCCfilter= donateCCWBLUserImageCollect($DonatePixel[0],$DonatePixel[1])

			;reset every run
			$bDonate = False ; donate only for one request at a time
			$bSkipDonTroops = False
			;removed because we can launch donateCC previous to read TH level and status of dark spell factory
;~ 			If $iTownHallLevel < 8 Or $numFactoryDarkSpellAvaiables = 0 Then ; if you are a < TH8 you don't have a Dark Spells Factory OR Dark Spells Factory is Upgrading
;~ 				$bSkipDonSpells = True
;~ 			Else
			$bSkipDonSpells = False
;~ 			EndIf

			If $donateCCfilter = False Then
			   Setlog("Skip Donation at this Clan Mate...", $COLOR_ACTION)
			Else
				;Read chat request for DonateTroop and DonateSpell
				If ($bDonateTroop = 1 And $bSkipDonTroops = False) Or ($bDonateSpell = 1 And $bSkipDonSpells = False) Then
					If $debugsetlog = 1 Then Setlog("Troop/Spell checkpoint.", $COLOR_DEBUG)

					If $ichkExtraAlphabets = 1 Then
						; Chat Request using "coc-latin-cyr" xml: Latin + Cyrillic derived alphabets / three paragraphs
						Setlog("Using OCR to read Latin and Cyrillic derived alphabets..", $COLOR_ACTION)
						$ClanString = ""
						$ClanString = getChatString(30, $DonatePixel[1] - 50, "coc-latin-cyr")
						If $ClanString = "" Then
							$ClanString = getChatString(30, $DonatePixel[1] - 36, "coc-latin-cyr")
						Else
							$ClanString &= " " & getChatString(30, $DonatePixel[1] - 36, "coc-latin-cyr")
						EndIf
						If $ClanString = "" Or $ClanString = " " Then
							$ClanString = getChatString(30, $DonatePixel[1] - 23, "coc-latin-cyr")
						Else
							$ClanString &= " " & getChatString(30, $DonatePixel[1] - 23, "coc-latin-cyr")
						EndIf
						If _Sleep($iDelayDonateCC2) Then ExitLoop
					Else ; default
						; Chat Request using "coc-latinA" xml: only Latin derived alphabets / three paragraphs
						Setlog("Using OCR to read Latin derived alphabets..", $COLOR_ACTION)
						$ClanString = ""
						$ClanString = getChatString(30, $DonatePixel[1] - 50, "coc-latinA")
						If $ClanString = "" Then
							$ClanString = getChatString(30, $DonatePixel[1] - 36, "coc-latinA")
						Else
							$ClanString &= " " & getChatString(30, $DonatePixel[1] - 36, "coc-latinA")
						EndIf
						If $ClanString = "" Or $ClanString = " " Then
							$ClanString = getChatString(30, $DonatePixel[1] - 23, "coc-latinA")
						Else
							$ClanString &= " " & getChatString(30, $DonatePixel[1] - 23, "coc-latinA")
						EndIf
						If _Sleep($iDelayDonateCC2) Then ExitLoop
					EndIf
					; Chat Request using IMGLOC: Chinese alphabet / one paragraph
					If $ichkExtraChinese = 1 Then
						Setlog("Using OCR to read the Chinese alphabet..", $COLOR_ACTION)
						If $ClanString = "" Then
							$ClanString = getChatStringChinese(30, $DonatePixel[1] - 24)
						Else
							$ClanString &= " " & getChatStringChinese(30, $DonatePixel[1] - 24)
						EndIf
						If _Sleep($iDelayDonateCC2) Then ExitLoop
					EndIf

					; samm0d
					If $ichkEnableCustomOCR4CCRequest = 1 Then
						Setlog("Using custom OCR to read cc request message..", $COLOR_ACTION)
						If $ClanString = "" Then
							$ClanString = getMyOcr(30, $DonatePixel[1] - 24,160,14,"ccrequest",False,True)
						Else
							$ClanString &= " " & getMyOcr(30, $DonatePixel[1] - 24,160,14,"ccrequest",False,True)
						EndIf
					EndIf

					If $ClanString = "" Or $ClanString = " " Then
						SetLog("Unable to read Chat Request!", $COLOR_ERROR)
						$bDonate = True
						$y = $DonatePixel[1] + 50
						ContinueLoop ;go to next button if cant read Castle Troops and Spells before the donate window opens
					Else
						If $ichkExtraAlphabets = 1 Then
							ClipPut($ClanString)
							Local $tempClip = ClipGet()
							SetLog("Chat Request: " & $tempClip)
						Else
							SetLog("Chat Request: " & $ClanString)
						EndIf
					EndIf

					; Get remaining CC capacity of requested troops from your ClanMates
					RemainingCCcapacity()
					$bCheckRemainingCCcapacity = True

					If $iTotalDonateCapacity <= 0 Then
						   Setlog("Clan Castle troops are full, skip troop donation...", $COLOR_ACTION)
						$bSkipDonTroops = True
					EndIf
					If $iTotalDonateSpellCapacity = 0 Then
						   Setlog("Clan Castle spells are full, skip spell donation...", $COLOR_ACTION)
						$bSkipDonSpells = True
					ElseIf $iTotalDonateSpellCapacity = -1 Then
						; no message, this CC has no Spell capability
						   If $debugsetlog = 1 Then Setlog("This CC cannot accept spells, skip spell donation...", $COLOR_DEBUG)
						$bSkipDonSpells = True
					ElseIf $CurTotalDonSpell[0] = 0 Then
						If $debugsetlog = 1 Then Setlog("No spells available, skip spell donation...", $COLOR_DEBUG) ;Debug
						Setlog("No spells available, skip spell donation...", $COLOR_ORANGE)
						$bSkipDonSpells = True
					EndIf


					If $bSkipDonTroops And $bSkipDonSpells Then
						$bDonate = True
						$y = $DonatePixel[1] + 50
						ContinueLoop ; go to next button if cannot donate troop and spell before donate window opens
					EndIf

					; ==== samm0d
					; compare
					If $debugsetlogTrain = 1 Then SetLog("$CurPSpell: " & $CurPSpell)
					If $debugsetlogTrain = 1 Then SetLog("$CurESpell: " & $CurESpell)
					If $debugsetlogTrain = 1 Then SetLog("$CurHaSpell: " & $CurHaSpell)
					If $debugsetlogTrain = 1 Then SetLog("$CurSkSpell: " & $CurSkSpell)
					If $bDonateTroop = 1 And $bSkipDonTroops = False Then
						For $i = 0 To 18
							If Eval("iChkDonate" & StringStripWS(NameOfTroop($i,1),$STR_STRIPALL)) = 1 Then
								Assign("canDon" & $MyTroops[$i][0], CheckDonateTroop($i, Eval("aDon" & StringStripWS(NameOfTroop($i,1),$STR_STRIPALL)), Eval("aBlk" & StringStripWS(NameOfTroop($i,1),$STR_STRIPALL)), $aBlackList, $ClanString))
								If Eval("canDon" & $MyTroops[$i][0]) Then $bDonateFlag = True
							EndIf
						Next
						If $iChkDonateCustomA = 1 Then
							$canDonCustomA = CheckDonateTroop(19, $aDonCustomA, $aBlkCustomA, $aBlackList, $ClanString)
							If $canDonCustomA Then $bDonateFlag = True
						EndIf
						If $iChkDonateCustomB = 1 Then
							$canDonCustomB = CheckDonateTroop(19, $aDonCustomB, $aBlkCustomB, $aBlackList, $ClanString)
							If $canDonCustomB Then $bDonateFlag = True
						EndIf
					EndIf

					If $bDonateSpell = 1 And $bSkipDonSpells = False Then
						If $iChkDonateLightningSpells = 1 Then
							$canDonLSpell = CheckDonateTroop($eLSpell, $aDonLightningSpells, $aBlkLightningSpells, $aBlackList, $ClanString)
							If $canDonLSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateHealSpells = 1 Then
							$canDonHSpell = CheckDonateTroop($eHSpell, $aDonHealSpells, $aBlkHealSpells, $aBlackList, $ClanString)
							If $canDonHSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateRageSpells = 1 Then
							$canDonRSpell = CheckDonateTroop($eRSpell, $aDonRageSpells, $aBlkRageSpells, $aBlackList, $ClanString)
							If $canDonRSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateJumpSpells = 1 Then
							$canDonJSpell = CheckDonateTroop($eJSpell, $aDonJumpSpells, $aBlkJumpSpells, $aBlackList, $ClanString)
							If $canDonJSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateFreezeSpells = 1 Then
							$canDonFSpell = CheckDonateTroop($eFSpell, $aDonFreezeSpells, $aBlkFreezeSpells, $aBlackList, $ClanString)
							If $canDonFSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonatePoisonSpells = 1 Then
							$canDonPSpell = CheckDonateTroop($ePSpell, $aDonPoisonSpells, $aBlkPoisonSpells, $aBlackList, $ClanString)
							If $canDonPSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateEarthQuakeSpells = 1 Then
							$canDonESpell = CheckDonateTroop($eESpell, $aDonEarthQuakeSpells, $aBlkEarthQuakeSpells, $aBlackList, $ClanString)
							If $canDonESpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateHasteSpells = 1 Then
							$canDonHaSpell = CheckDonateTroop($eHaSpell, $aDonHasteSpells, $aBlkHasteSpells, $aBlackList, $ClanString)
							If $canDonHaSpell Then $bDonateFlag = True
						EndIf
						If $iChkDonateSkeletonSpells = 1 Then
							$canDonSkSpell = CheckDonateTroop($eSkSpell, $aDonSkeletonSpells, $aBlkSkeletonSpells, $aBlackList, $ClanString)
							If $canDonSkSpell Then $bDonateFlag = True
						EndIf
					EndIf


					If $bDonateFlag Then
						If $bDonateTroop Or $bDonateSpell Then
							; open Donate Window
							If ($bSkipDonTroops = True And $bSkipDonSpells = True) Or DonateWindow($bOpen) = False Then
								$bDonate = True
								$y = $DonatePixel[1] + 50
								ContinueLoop ; go to next button if donate window did not open
							EndIf
							$bDonateWindowOpen = True
							; read available donate cap, and ByRef set the $bSkipDonTroops and $bSkipDonSpells flags
							DonateWindowCap($bSkipDonTroops, $bSkipDonSpells)
							If $bSkipDonTroops And $bSkipDonSpells Then
								DonateWindow($bClose)
								$bDonateWindowOpen = False
								$bDonate = True
								$y = $DonatePixel[1] + 50
								If _Sleep($iDelayDonateCC2) Then ExitLoop
								ContinueLoop ; go to next button if already donated, maybe this is an impossible case..
							EndIf

							If $bDonateTroop = 1 And $bSkipDonTroops = False Then
								If $debugsetlog = 1 Then Setlog("Troop checkpoint.", $COLOR_DEBUG)

								;;; Custom Combination Donate by ChiefM3, edited by MonkeyHunter
								If $canDonCustomA Then
									For $i = 0 To 2
										If $varDonateCustomA[$i][0] < $eBarb Then
											$varDonateCustomA[$i][0] = $eArch ; Change strange small numbers to archer
										ElseIf $varDonateCustomA[$i][0] > $eBowl Then
											ContinueLoop ; If "Nothing" is selected then continue
										EndIf
										If $varDonateCustomA[$i][1] < 1 Then
											ContinueLoop ; If donate number is smaller than 1 then continue
										ElseIf $varDonateCustomA[$i][1] > 8 Then
											$varDonateCustomA[$i][1] = 8 ; Number larger than 8 is unnecessary
										EndIf
										DonateTroopType($varDonateCustomA[$i][0], $varDonateCustomA[$i][1], $iChkDonateCustomA) ;;; Donate Custom Troop using DonateTroopType2
									Next
								EndIf

								If $canDonCustomB Then
									For $i = 0 To 2
										If $varDonateCustomB[$i][0] < $eBarb Then
											$varDonateCustomB[$i][0] = $eArch ; Change strange small numbers to archer
										ElseIf $varDonateCustomB[$i][0] > $eBowl Then
											ContinueLoop ; If "Nothing" is selected then continue
										EndIf
										If $varDonateCustomB[$i][1] < 1 Then
											ContinueLoop ; If donate number is smaller than 1 then continue
										ElseIf $varDonateCustomB[$i][1] > 8 Then
											$varDonateCustomB[$i][1] = 8 ; Number larger than 8 is unnecessary
										EndIf
										DonateTroopType($varDonateCustomB[$i][0], $varDonateCustomB[$i][1], $iChkDonateCustomB) ;;; Donate Custom Troop using DonateTroopType2
									Next
								EndIf

								; samm0d
								For $i = 0 To 18
									If Eval("canDon" & $MyTroops[$i][0]) = True Then
										DonateTroopType($i)
									EndIf
								Next
							EndIf

							; samm0d
							If $bDonateSpell = 1 And $bSkipDonSpells = False Then
								If $debugsetlog = 1 Then Setlog("Spell checkpoint.", $COLOR_DEBUG)
								For $i = 0 To 9
									If $i <> 5 Then
										If Eval("canDon" & $SpellGroup[$i][0]) = True Then
											DonateTroopType($i+23)
										EndIf
									EndIf
								Next
								;If $canDonPSpell Then DonateTroopType($ePSpell)
								;If $canDonESpell Then DonateTroopType($eESpell)
								;If $canDonHaSpell Then DonateTroopType($eHaSpell)
								;If $canDonSkSpell Then DonateTroopType($eSkSpell)
							EndIf
						EndIf
					Else
						If $donateCCfilter Then
							SetLog("Skip: Keyword or space not match with this request.",$COLOR_RED)
						EndIf
					EndIf
				EndIf

				If ($bDonateAllTroop Or $bDonateAllSpell) Then
					If $debugsetlog = 1 Then Setlog("Troop/Spell All checkpoint.", $COLOR_DEBUG) ;Debug
					If $bCheckRemainingCCcapacity = False Then
						; Get remaining CC capacity of requested troops from your ClanMates
						RemainingCCcapacity()

						If $iTotalDonateCapacity <= 0 Then
							   Setlog("Clan Castle troops are full, skip troop donation...", $COLOR_ACTION)
							$bSkipDonTroops = True
						EndIf
						If $iTotalDonateSpellCapacity = 0 Then
							   Setlog("Clan Castle spells are full, skip spell donation...", $COLOR_ACTION)
							$bSkipDonSpells = True
						ElseIf $iTotalDonateSpellCapacity = -1 Then
							; no message, this CC has no Spell capability
							   If $debugsetlog = 1 Then Setlog("This CC cannot accept spells, skip spell donation...", $COLOR_DEBUG)
							$bSkipDonSpells = True
						ElseIf $CurTotalDonSpell[0] = 0 Then
							If $debugsetlog = 1 Then Setlog("No spells available, skip spell donation...", $COLOR_DEBUG) ;Debug
							Setlog("No spells available, skip spell donation...", $COLOR_ORANGE)
							$bSkipDonSpells = True
						EndIf

						If $bSkipDonTroops And $bSkipDonSpells Then
							$bDonate = True
							$y = $DonatePixel[1] + 50
							ContinueLoop ; go to next button if cannot donate troop and spell before donate window opens
						EndIf
					EndIf

					;$bDonateAllRespectBlk = True
					If $bDonateWindowOpen = False Then
						; open Donate Window
						If ($bSkipDonTroops = True And $bSkipDonSpells = True) Or DonateWindow($bOpen) = False Then
							$bDonate = True
							$y = $DonatePixel[1] + 50
							ContinueLoop ; go to next button if donate window did not open
						EndIf
						$bDonateWindowOpen = True
					EndIf
					; read available donate cap, and ByRef set the $bSkipDonTroops and $bSkipDonSpells flags
					DonateWindowCap($bSkipDonTroops, $bSkipDonSpells)
					If $bSkipDonTroops And $bSkipDonSpells Then
						DonateWindow($bClose)
						$bDonateWindowOpen = False
						$bDonate = True
						$y = $DonatePixel[1] + 50
						If _Sleep($iDelayDonateCC2) Then ExitLoop
						ContinueLoop ; go to next button if already donated, maybe this is an impossible case..
					EndIf

					If $bDonateAllTroop And $bSkipDonTroops = False Then
						If $debugsetlog = 1 Then Setlog("Troop All checkpoint.", $COLOR_DEBUG)
						Select
							Case $iChkDonateAllCustomA = 1
								For $i = 0 To 2
									If $varDonateCustomA[$i][0] < $eBarb Then
										$varDonateCustomA[$i][0] = $eArch ; Change strange small numbers to archer
									ElseIf $varDonateCustomA[$i][0] > $eBowl Then
										DonateWindow($bClose)
										$bDonate = True
										$y = $DonatePixel[1] + 50
										If _Sleep($iDelayDonateCC2) Then ExitLoop
										ContinueLoop ; If "Nothing" is selected then continue
									EndIf
									If $varDonateCustomA[$i][1] < 1 Then
										DonateWindow($bClose)
										$bDonate = True
										$y = $DonatePixel[1] + 50
										If _Sleep($iDelayDonateCC2) Then ExitLoop
										ContinueLoop ; If donate number is smaller than 1 then continue
									ElseIf $varDonateCustomA[$i][1] > 8 Then
										$varDonateCustomA[$i][1] = 8 ; Number larger than 8 is unnecessary
									EndIf
									DonateTroopType($varDonateCustomA[$i][0], $varDonateCustomA[$i][1], $iChkDonateAllCustomA, $bDonateAllTroop) ;;; Donate Custom Troop using DonateTroopType2
								Next
							Case $iChkDonateAllCustomB = 1
								For $i = 0 To 2
									If $varDonateCustomB[$i][0] < $eBarb Then
										$varDonateCustomB[$i][0] = $eArch ; Change strange small numbers to archer
									ElseIf $varDonateCustomB[$i][0] > $eBowl Then
										DonateWindow($bClose)
										$bDonate = True
										$y = $DonatePixel[1] + 50
										If _Sleep($iDelayDonateCC2) Then ExitLoop
										ContinueLoop ; If "Nothing" is selected then continue
									EndIf
									If $varDonateCustomB[$i][1] < 1 Then
										DonateWindow($bClose)
										$bDonate = True
										$y = $DonatePixel[1] + 50
										If _Sleep($iDelayDonateCC2) Then ExitLoop
										ContinueLoop ; If donate number is smaller than 1 then continue
									ElseIf $varDonateCustomB[$i][1] > 8 Then
										$varDonateCustomB[$i][1] = 8 ; Number larger than 8 is unnecessary
									EndIf
									DonateTroopType($varDonateCustomB[$i][0], $varDonateCustomB[$i][1], $iChkDonateAllCustomB, $bDonateAllTroop) ;;; Donate Custom Troop using DonateTroopType2
								Next
							Case $iChkDonateAllLavaHounds = 1
								DonateTroopType($eLava, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllGolems = 1
								DonateTroopType($eGole, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllPekkas = 1
								DonateTroopType($ePekk, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllDragons = 1
								DonateTroopType($eDrag, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllWitches = 1
								DonateTroopType($eWitc, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllHealers = 1
								DonateTroopType($eHeal, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllBabyDragons = 1
								DonateTroopType($eBabyD, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllValkyries = 1
								DonateTroopType($eValk, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllBowlers = 1
								DonateTroopType($eBowl, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllMiners = 1
								DonateTroopType($eMine, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllGiants = 1
								DonateTroopType($eGiant, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllBalloons = 1
								DonateTroopType($eBall, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllHogRiders = 1
								DonateTroopType($eHogs, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllWizards = 1
								DonateTroopType($eWiza, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllWallBreakers = 1
								DonateTroopType($eWall, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllMinions = 1
								DonateTroopType($eMini, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllBarbarians = 1
								DonateTroopType($eBarb, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllArchers = 1
								DonateTroopType($eArch, 0, False, $bDonateAllTroop)
							Case $iChkDonateAllGoblins = 1
								DonateTroopType($eGobl, 0, False, $bDonateAllTroop)
						EndSelect
					EndIf

					If $bDonateAllSpell And $bSkipDonSpells = False Then
						If $debugsetlog = 1 Then Setlog("Spell All checkpoint.", $COLOR_DEBUG)
						Select
							Case $iChkDonateAllLightningSpells = 1
								DonateTroopType($eLSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllHealSpells = 1
								DonateTroopType($eHSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllRageSpells = 1
								DonateTroopType($eRSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllJumpSpells = 1
								DonateTroopType($eJSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllFreezeSpells = 1
								DonateTroopType($eFSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllPoisonSpells = 1
								DonateTroopType($ePSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllEarthQuakeSpells = 1
								DonateTroopType($eESpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllHasteSpells = 1
								DonateTroopType($eHaSpell, 0, False, $bDonateAllSpell)
							Case $iChkDonateAllSkeletonSpells = 1
								DonateTroopType($eSkSpell, 0, False, $bDonateAllSpell)
						EndSelect
					EndIf
					;$bDonateAllRespectBlk = False
				EndIf
			EndIf
			;close Donate Window
			DonateWindow($bClose)

			$bDonate = True
			$y = $DonatePixel[1] + 50
			ClickP($aAway, 1, 0, "#0171")
			If _Sleep($iDelayDonateCC2) Then ExitLoop
		EndIf
		;ck for more donate buttons
		ForceCaptureRegion()
		$DonatePixel = _MultiPixelSearch(202, $y, 224, 660 + $bottomOffsetY, 50, 1, Hex(0x98D057, 6), $aChatDonateBtnColors, 15)
		If IsArray($DonatePixel) Then
			If $debugsetlog = 1 Then Setlog("More Donate buttons found, new $DonatePixel: (" & $DonatePixel[0] & "," & $DonatePixel[1] & ")", $COLOR_DEBUG)
			ContinueLoop
		Else
			If $debugsetlog = 1 Then Setlog("No more Donate buttons found, closing chat ($y=" & $y & ")", $COLOR_DEBUG)
		EndIf
		; Scroll Down

		ForceCaptureRegion()
		;$Scroll = _PixelSearch(288, 640 + $bottomOffsetY, 290, 655 + $bottomOffsetY, Hex(0x588800, 6), 20)
		;$y = 90
		;$Scroll = _PixelSearch(293, 8 + $y, 295, 23 + $y, Hex(0xFFFFFF, 6), 20)
		$Scroll = _PixelSearch(293, 687 - 30, 295, 693 - 30, Hex(0xFFFFFF, 6), 20)


		If IsArray($Scroll) Then
			$bDonate = True
			Click($Scroll[0], $Scroll[1], 1, 0, "#0172")
			$y = 600

			If _Sleep($iDelayDonateCC2) Then ExitLoop
			ContinueLoop
		EndIf
		$bDonate = False
		SetLog(_PadStringCenter(" Donate End ", 54, "="), $COLOR_INFO)
	WEnd

	ClickP($aAway, 1, 0, "#0176") ; click away any possible open window
	If _Sleep($iDelayDonateCC2) Then Return

	$i = 0
	While 1
		If _Sleep(100) Then Return
		If _ColorCheck(_GetPixelColor($aCloseChat[0], $aCloseChat[1], True), Hex($aCloseChat[2], 6), $aCloseChat[3]) Then
			; Clicks chat thing
			Click($aCloseChat[0], $aCloseChat[1], 1, 0, "#0173") ;Clicks chat thing
			ExitLoop
		Else
			If _Sleep(100) Then Return
			$i += 1
			If $i > 30 Then
				SetLog("Error finding Clan Tab to close...", $COLOR_ERROR)
				AndroidPageError("DonateCC")
				ExitLoop
			EndIf
		EndIf
	WEnd

	If _Sleep($iDelayDonateCC2) Then Return

EndFunc   ;==>DonateCC

Func CheckDonateTroop($Type, $aDonTroop, $aBlkTroop, $aBlackList, $ClanString)
	; samm0d
	Local $bKeywordFound = False

	For $i = 1 To UBound($aDonTroop) - 1
		If CheckDonateString($aDonTroop[$i], $ClanString) Then
			If $Type = 19 Then
				Setlog("Custom Donation Keyword found: " & $aDonTroop[$i], $COLOR_SUCCESS)
			Else
				Setlog(NameOfTroop($Type) & " Keyword found: " & $aDonTroop[$i], $COLOR_SUCCESS)
			EndIf
			$bKeywordFound = True
		EndIf
	Next
	If $bKeywordFound Then
		For $i = 1 To UBound($aBlackList) - 1
			If CheckDonateString($aBlackList[$i], $ClanString) Then
				If $Type = 19 Then
					SetLog("General Blacklist Keyword found: " & $aBlackList[$i] & ", when try donate custom troops or spell.", $COLOR_ERROR)
				Else
					SetLog("General Blacklist Keyword found: " & $aBlackList[$i] & ", when try donate " & NameOfTroop($Type), $COLOR_ERROR)
				EndIf
				SetLog("Skip: ...", $COLOR_ERROR)
				Return False
			EndIf
		Next

		For $i = 1 To UBound($aBlkTroop) - 1
			If CheckDonateString($aBlkTroop[$i], $ClanString) Then
				If $Type = 19 Then
					Setlog("Custom Blacklist Keyword found: " & $aBlkTroop[$i], $COLOR_ERROR)
				Else
					SetLog(NameOfTroop($Type) & " Blacklist Keyword found: " & $aBlkTroop[$i], $COLOR_ERROR)
				EndIf
				SetLog("Skip: ...", $COLOR_ERROR)
				Return False
			EndIf
		Next
	EndIf
	If $bKeywordFound = True Then
		If $iTotalDonateCapacity = 0 And $iTotalDonateSpellCapacity = 0 Then Return

		If $Type >= $eBarb And $Type <= $eBowl Then
			;troops
			For $i = 0 To UBound($TroopName) - 1
				If Eval("e" & $TroopName[$i]) = $Type Then
					$iDonTroopsQuantityAv = Floor($iTotalDonateCapacity / $TroopHeight[$i])
					If $iDonTroopsQuantityAv < 1 Then
						Setlog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
						Return False
					EndIf
				EndIf
			Next
		EndIf
		If $Type >= $eLSpell And $Type <= $eSkSpell Then
			;spells
			For $i = 0 To UBound($SpellName) - 1
				If Eval("e" & $SpellName[$i]) = $Type Then
					$iDonSpellsQuantityAv = Floor($iTotalDonateSpellCapacity / $SpellHeight[$i])
					If $iDonSpellsQuantityAv < 1 Then
						Setlog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
						Return
					EndIf
				EndIf
			Next
		EndIf
		Return $bKeywordFound
	Else
		;If $debugsetlog = 1 Then Setlog("Bad call of CheckDonateTroop:" & $Type & "=" & NameOfTroop($Type), $COLOR_DEBUG)
		;SetLog("Skip: Donation keyword not found.",$COLOR_RED)
		Return False
	EndIf
EndFunc   ;==>CheckDonateTroop

Func CheckDonateString($String, $ClanString) ;Checks if exact
	Local $Contains = StringMid($String, 1, 1) & StringMid($String, StringLen($String), 1)

	If $Contains = "[]" Then
		If $ClanString = StringMid($String, 2, StringLen($String) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($ClanString, $String, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>CheckDonateString

Func DonateTroopType($Type, $Quant = 0, $Custom = False, $bDonateAll = False)

	If $debugsetlog = 1 Then Setlog("$DonateTroopType Start: " & NameOfTroop($Type), $COLOR_DEBUG)

	Local $Slot = -1, $YComp = 0, $sTextToAll = ""
	Local $detectedSlot = -1
	Local $donaterow = -1 ;( =3 for spells)
	Local $donateposinrow = -1

	If $iTotalDonateCapacity = 0 And $iTotalDonateSpellCapacity = 0 Then Return

	If $Type >= $eBarb And $Type <= $eBowl Then
		;troops
		For $i = 0 To UBound($TroopName) - 1
			If Eval("e" & $TroopName[$i]) = $Type Then
				$iDonTroopsQuantityAv = Floor($iTotalDonateCapacity / $TroopHeight[$i])
				If $iDonTroopsQuantityAv < 1 Then
					Setlog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
					Return
				EndIf
				If $iDonTroopsQuantityAv >= $iDonTroopsLimit Then
					$iDonTroopsQuantity = $iDonTroopsLimit
				Else
					$iDonTroopsQuantity = $iDonTroopsQuantityAv
				EndIf
			EndIf
		Next
#CS
		For $i = 0 To UBound($TroopDarkName) - 1
			If Eval("e" & $TroopDarkName[$i]) = $Type Then
				$iDonTroopsQuantityAv = Floor($iTotalDonateCapacity / $TroopDarkHeight[$i])
				If $iDonTroopsQuantityAv < 1 Then
					Setlog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
					Return
				EndIf
				If $iDonTroopsQuantityAv >= $iDonTroopsLimit Then
					$iDonTroopsQuantity = $iDonTroopsLimit
				Else
					$iDonTroopsQuantity = $iDonTroopsQuantityAv
				EndIf
			EndIf
		Next
 #CE
	EndIf

	If $Type >= $eLSpell And $Type <= $eSkSpell Then
		;spells
		For $i = 0 To UBound($SpellName) - 1
			If Eval("e" & $SpellName[$i]) = $Type Then
				$iDonSpellsQuantityAv = Floor($iTotalDonateSpellCapacity / $SpellHeight[$i])
				If $iDonSpellsQuantityAv < 1 Then
					Setlog("Sorry Chief! " & NameOfTroop($Type, 1) & " don't fit in the remaining space!")
					Return
				EndIf
				If $iDonSpellsQuantityAv >= $iDonSpellsLimit Then
					$iDonSpellsQuantity = $iDonSpellsLimit
				Else
					$iDonSpellsQuantity = $iDonSpellsQuantityAv
				EndIf
			EndIf
		Next
	EndIf

	; Detect the Troops Slot
	If $debugOCRdonate = 1 Then
		Local $oldDebugOcr = $debugOcr
		$debugOcr = 1
	EndIf
	If $Type > $eHaSpell And $CurTotalDonSpell[1] > 6 Then DragSpellDonWindow()
	$Slot = DetectSlotTroop($Type)
	$detectedSlot = $Slot
	If $debugsetlog = 1 Then setlog("slot found = " & $Slot, $COLOR_DEBUG)
	If $debugOCRdonate = 1 Then $debugOcr = $oldDebugOcr

	If $Slot = -1 Then Return

	$donaterow = 1 ;first row of trrops
	$donateposinrow = $Slot
	If $Slot >= 6 And $Slot <= 11 Then
		$donaterow = 2 ;second row of troops
		$Slot = $Slot - 6
		$donateposinrow = $Slot
		$YComp = 88 ; correct 860x780
	EndIf

	If $Slot >= 12 And $Slot <= 17 Then
		$donaterow = 3 ;row of poisons
		$Slot = $Slot - 12
		$donateposinrow = $Slot
		$YComp = 203 ; correct 860x780
	EndIf

	If $YComp <> 203 Then ; troops
		; Verify if the type of troop to donate exists
		If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
				_ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
				_ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then ; check for 'blue'
			Local $plural = 0
			If $Custom Then
				If $Quant > 1 Then $plural = 1
				If $bDonateAll Then $sTextToAll = " (to all requests)"
				SetLog("Donating " & $Quant & " " & NameOfTroop($Type, $plural) & $sTextToAll, $COLOR_SUCCESS)
				If $debugOCRdonate = 1 Then
					Setlog("donate", $COLOR_ERROR)
					Setlog("row: " & $donaterow, $COLOR_ERROR)
					Setlog("pos in row: " & $donateposinrow, $COLOR_ERROR)
					setlog("coordinate: " & 365 + ($Slot * 68) & "," & $DonationWindowY + 100 + $YComp, $COLOR_ERROR)
					debugimagesave("LiveDonateCC-r" & $donaterow & "-c" & $donateposinrow & "-" & NameOfTroop($Type) & "_")
				EndIf

				If $debugOCRdonate = 0 Then
					; Use slow click when the Train system is Quicktrain
					If $ichkUseQTrain = 1 Then
						$icount = 0
						For $x = 0 To $Quant
							If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
							   _ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
							   _ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then ; check for 'blue'
								Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, 1, $iDelayDonateCC3, "#0175")
								If $CommandStop = 3 Then
									$CommandStop = 0
									$fullArmy = False
								EndIf
								; samm0d
								$bJustMakeDonate = True

								If _Sleep(1000) Then Return
								$icount += 1
							EndIf
						Next
						$Quant = $icount ; Count Troops Donated Clicks
						DonatedTroop($Type, $Quant)
					Else
						If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
						   _ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
						   _ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then ; check for 'blue'
							Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, $Quant, $iDelayDonateCC3, "#0175")
							DonatedTroop($Type, $Quant)
							If $CommandStop = 3 Then
								$CommandStop = 0
								$fullArmy = False
							EndIf
							; samm0d
							$bJustMakeDonate = True
						EndIf
					EndIf

					; Adjust Values for donated troops to prevent a Double ghost donate to stats and train
					If $Type >= $eBarb And $Type <= $eBowl Then
						For $i = 0 To UBound($TroopName) - 1
							If Eval("e" & $TroopName[$i]) = $Type Then
								;Reduce iTotalDonateCapacity by troops donated
								$iTotalDonateCapacity = $iTotalDonateCapacity - ($Quant * $TroopHeight[$i])
								;If donated max allowed troop qty set $bSkipDonTroops = True
								If $iDonTroopsLimit = $Quant Then
									$bSkipDonTroops = True
								EndIf
							EndIf
						Next
#CS
						;Dark Troops
						For $i = 0 To UBound($TroopDarkName) - 1
							If Eval("e" & $TroopDarkName[$i]) = $Type Then
								;Reduce iTotalDonateCapacity by troops donated
								$iTotalDonateCapacity = $iTotalDonateCapacity - ($Quant * $TroopDarkHeight[$i])
								;If donated max allowed troop qty set $bSkipDonTroops = True
								If $iDonTroopsLimit = $Quant Then
									$bSkipDonTroops = True
								EndIf
							EndIf
						Next

 #CE
					EndIf
				EndIf

			Else
				If $iDonTroopsQuantity > 1 Then $plural = 1
				If $debugOCRdonate = 1 Then
					Setlog("donate", $color_RED)
					Setlog("row: " & $donaterow, $color_RED)
					Setlog("pos in row: " & $donateposinrow, $color_red)
					setlog("coordinate: " & 365 + ($Slot * 68) & "," & $DonationWindowY + 100 + $YComp, $color_red)
					debugimagesave("LiveDonateCC-r" & $donaterow & "-c" & $donateposinrow & "-" & NameOfTroop($Type) & "_")
				EndIf
				If $debugOCRdonate = 0 Then
					; Use slow clikc when the Train system is Quicktrain
					If $ichkUseQTrain = 1 Then
						$icount = 0
						For $x = 0 To $iDonTroopsQuantity
							If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
							   _ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
							   _ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then ; check for 'blue'
								Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, 1, $iDelayDonateCC3, "#0175")
								$icount += 1
								If $CommandStop = 3 Then
									$CommandStop = 0
									$fullArmy = False
								EndIf
								; samm0d
								$bJustMakeDonate = True
								If _Sleep(1000) Then Return
							EndIf
						Next
						$iDonTroopsQuantity = $icount ; Count Troops Donated Clicks
						DonatedTroop($Type, $iDonTroopsQuantity)
					Else
						If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
						   _ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x306ca8, 6), 20) Or _
						   _ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x306ca8, 6), 20) Then ; check for 'blue'
							Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, $iDonTroopsQuantity, $iDelayDonateCC3, "#0175")
							DonatedTroop($Type, $iDonTroopsQuantity)
							If $CommandStop = 3 Then
								$CommandStop = 0
								$fullArmy = False
							EndIf
							; samm0d
							$bJustMakeDonate = True
						EndIf
					EndIf

					If $bDonateAll Then $sTextToAll = " (to all requests)"
					SetLog("Donating " & $iDonTroopsQuantity & " " & NameOfTroop($Type, $plural) & $sTextToAll, $COLOR_GREEN)

					; Adjust Values for donated troops to prevent a Double ghost donate to stats and train
					If $Type >= $eBarb And $Type <= $eBowl Then
						For $i = 0 To UBound($TroopName) - 1
							If Eval("e" & $TroopName[$i]) = $Type Then
								;Reduce iTotalDonateCapacity by troops donated
								$iTotalDonateCapacity = $iTotalDonateCapacity - ($iDonTroopsQuantity * $TroopHeight[$i])
								;If donated max allowed troop qty set $bSkipDonTroops = True
								If $iDonTroopsLimit = $iDonTroopsQuantity Then
									$bSkipDonTroops = True
								EndIf
							EndIf
						Next
#CS
						;Dark Troops
						For $i = 0 To UBound($TroopDarkName) - 1
							If Eval("e" & $TroopDarkName[$i]) = $Type Then
								;Reduce iTotalDonateCapacity by troops donated
								$iTotalDonateCapacity = $iTotalDonateCapacity - ($iDonTroopsQuantity * $TroopDarkHeight[$i])
								;If donated max allowed troop qty set $bSkipDonTroops = True
								If $iDonTroopsLimit = $iDonTroopsQuantity Then
									$bSkipDonTroops = True
								EndIf
							EndIf
						Next
 #CE
					EndIf
				EndIf
			EndIf

			$bDonate = True

			; Assign the donated quantity troops to train : $Don $TroopName

			If $Custom Then
				For $i = 0 To UBound($TroopName) - 1
					If Eval("e" & $TroopName[$i]) = $Type Then
						Assign("Don" & $TroopName[$i], Eval("Don" & $TroopName[$i]) + $Quant)
					EndIf
				Next
#CS
				For $i = 0 To UBound($TroopDarkName) - 1
					If Eval("e" & $TroopDarkName[$i]) = $Type Then
						Assign("Don" & $TroopDarkName[$i], Eval("Don" & $TroopDarkName[$i]) + $Quant)
					EndIf
				Next
 #CE
			Else
				For $i = 0 To UBound($TroopName) - 1
					If Eval("e" & $TroopName[$i]) = $Type Then
						Assign("Don" & $TroopName[$i], Eval("Don" & $TroopName[$i]) + $iDonTroopsQuantity)
					EndIf
				Next
#CS
				For $i = 0 To UBound($TroopDarkName) - 1
					If Eval("e" & $TroopDarkName[$i]) = $Type Then
						Assign("Don" & $TroopDarkName[$i], Eval("Don" & $TroopDarkName[$i]) + $iDonTroopsQuantity)
					EndIf
				Next
 #CE
			EndIf

		ElseIf $DonatePixel[1] - 5 + $YComp > 675 Then
			Setlog("Unable to donate " & NameOfTroop($Type) & ". Donate screen not visible, will retry next run.", $COLOR_ERROR)
		Else
			SetLog("No " & NameOfTroop($Type) & " available to donate..", $COLOR_ERROR)
		EndIf
	Else ; spells
		SetLog("Spells Condition Matched", $COLOR_ORANGE)
		If _ColorCheck(_GetPixelColor(350 + ($Slot * 68), $DonationWindowY + 105 + $YComp, True), Hex(0x6038B0, 6), 20) Or _
				_ColorCheck(_GetPixelColor(355 + ($Slot * 68), $DonationWindowY + 106 + $YComp, True), Hex(0x6038B0, 6), 20) Or _
				_ColorCheck(_GetPixelColor(360 + ($Slot * 68), $DonationWindowY + 107 + $YComp, True), Hex(0x6038B0, 6), 20) Then ; check for 'purple'
			If $bDonateAll Then $sTextToAll = " (to all requests)"
			;SetLog("Else Spell Colors Conditions Matched ALSO", $COLOR_ORANGE)
			SetLog("Donating " & $iDonSpellsQuantity & " " & NameOfTroop($Type) & $sTextToAll, $COLOR_GREEN)
			;Setlog("click donate")
			If $debugOCRdonate = 1 Then
				Setlog("donate", $COLOR_ERROR)
				Setlog("row: " & $donaterow, $COLOR_ERROR)
				Setlog("pos in row: " & $donateposinrow, $COLOR_ERROR)
				setlog("coordinate: " & 365 + ($Slot * 68) & "," & $DonationWindowY + 100 + $YComp, $COLOR_ERROR)
				debugimagesave("LiveDonateCC-r" & $donaterow & "-c" & $donateposinrow & "-" & NameOfTroop($Type) & "_")
			EndIf
			If $debugOCRdonate = 0 Then
				Click(365 + ($Slot * 68), $DonationWindowY + 100 + $YComp, $iDonSpellsQuantity, $iDelayDonateCC3, "#0600")
				$bFullArmySpells = False
				$fullArmy = False
				For $i = 0 To UBound($SpellName) - 1
					If Eval("e" & $SpellName[$i]) = $Type Then
						Assign("Don" & $SpellName[$i], Eval("Don" & $SpellName[$i]) + 1)
					EndIf
				Next
				If $CommandStop = 3 Then
					$CommandStop = 0
					$bFullArmySpells = False
				EndIf
				DonatedSpell($Type, $iDonSpellsQuantity)
				; samm0d
				$bJustMakeDonate = True
				$tempDisableBrewSpell = False
			EndIf

			$bDonate = True

			; Assign the donated quantity Spells to train : $Don $SpellName
			; need to implement assign $DonPoison etc later

		ElseIf $DonatePixel[1] - 5 + $YComp > 675 Then
			Setlog("Unable to donate " & NameOfTroop($Type) & ". Donate screen not visible, will retry next run.", $COLOR_ERROR)
		Else
			SetLog("No " & NameOfTroop($Type) & " available to donate..", $COLOR_ERROR)
		EndIf
	EndIf

EndFunc   ;==>DonateTroopType

Func DragSpellDonWindow()
	If Not $RunState Then Return
	If _ColorCheck(_GetPixelColor(350 ,$DonationWindowY, True), Hex(0xFFFFFF, 6), 20) Then
		ClickDrag(715, $DonationWindowY + 303, 580, $DonationWindowY + 303, 50)
		If $debugSetlog = 1 Then SetLog("Dragged Spell Window successfully", $COLOR_ACTION)
	Else
		If $debugSetlog = 1 Then SetLog("Couldn't drag the Spell Window because the Donation Window is not open!", $COLOR_ERROR)
		Return
	EndIf
	If _Sleep(800) Then Return
EndFunc

Func DonateWindow($Open = True)
	If $debugsetlog = 1 And $Open = True Then Setlog("DonateWindow Open Start", $COLOR_DEBUG)
	If $debugsetlog = 1 And $Open = False Then Setlog("DonateWindow Close Start", $COLOR_DEBUG)

	If $Open = False Then ; close window and exit
		ClickP($aAway, 1, 0, "#0176")
		If _Sleep($iDelayDonateWindow1) Then Return
		If $debugsetlog = 1 Then Setlog("DonateWindow Close Exit", $COLOR_DEBUG)
		Return
	EndIf

	; Click on Donate Button and wait for the window
	Local $iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0, $i
	For $i = 0 To UBound($aChatDonateBtnColors) - 1
		If $aChatDonateBtnColors[$i][1] < $iLeft Then $iLeft = $aChatDonateBtnColors[$i][1]
		If $aChatDonateBtnColors[$i][1] > $iRight Then $iRight = $aChatDonateBtnColors[$i][1]
		If $aChatDonateBtnColors[$i][2] < $iTop Then $iTop = $aChatDonateBtnColors[$i][2]
		If $aChatDonateBtnColors[$i][2] > $iBottom Then $iBottom = $aChatDonateBtnColors[$i][2]
	Next
	$iLeft += $DonatePixel[0]
	$iTop += $DonatePixel[1]
	$iRight += $DonatePixel[0] + 1
	$iBottom += $DonatePixel[1] + 1
	ForceCaptureRegion()
	Local $DonatePixelCheck = _MultiPixelSearch($iLeft, $iTop, $iRight, $iBottom, 50, 1, Hex(0x98D057, 6), $aChatDonateBtnColors, 15)
	If IsArray($DonatePixelCheck) Then
		Click($DonatePixel[0] + 50, $DonatePixel[1] + 10, 1, 0, "#0174")
	Else
		If $debugsetlog = 1 Then SetLog("Could not find the Donate Button!", $COLOR_DEBUG)
		Return False
	EndIf
	If _Sleep($iDelayDonateWindow1) Then Return

	;_CaptureRegion(0, 0, 320 + $midOffsetY, $DonatePixel[1] + 30 + $YComp)
	$icount = 0
	While Not (_ColorCheck(_GetPixelColor(331, $DonatePixel[1], True), Hex(0xffffff, 6), 0))
		If _Sleep($iDelayDonateWindow1) Then Return
		;_CaptureRegion(0, 0, 320 + $midOffsetY, $DonatePixel[1] + 30 + $YComp)
		$icount += 1
		If $icount = 20 Then ExitLoop
	WEnd

	; Determinate the right position of the new Donation Window
	; Will search in $Y column = 410 for the first pure white color and determinate that position the $DonationWindowTemp
	$DonationWindowY = 0

	Local $aDonWinOffColors[2][3] = [[0xFFFFFF, 0, 2], [0xc7c5bc, 0, 209]]
	Local $aDonationWindow = _MultiPixelSearch(409, 0, 410, $DEFAULT_HEIGHT, 1, 1, Hex(0xFFFFFF, 6), $aDonWinOffColors, 10)

	If IsArray($aDonationWindow) Then
		$DonationWindowY = $aDonationWindow[1]
		If _Sleep($iDelayDonateWindow1) Then Return
		If $debugsetlog = 1 Then Setlog("$DonationWindowY: " & $DonationWindowY, $COLOR_DEBUG)
	Else
		SetLog("Could not find the Donate Window!", $COLOR_ERROR)
		Return False
	EndIf

	If $debugsetlog = 1 Then Setlog("DonateWindow Open Exit", $COLOR_DEBUG)
	Return True
EndFunc   ;==>DonateWindow

Func DonateWindowCap(ByRef $bSkipDonTroops, ByRef $bSkipDonSpells)
	If $debugsetlog = 1 Then Setlog("DonateCapWindow Start", $COLOR_DEBUG)
	;read troops capacity
	If $bSkipDonTroops = False Then
		Local $sReadCCTroopsCap = getCastleDonateCap(427, $DonationWindowY + 15) ; use OCR to get donated/total capacity
		If $debugsetlog = 1 Then Setlog("$sReadCCTroopsCap: " & $sReadCCTroopsCap, $COLOR_DEBUG)

		Local $aTempReadCCTroopsCap = StringSplit($sReadCCTroopsCap, "#")
		If $aTempReadCCTroopsCap[0] >= 2 Then
			;  Note - stringsplit always returns an array even if no values split!
			If $debugsetlog = 1 Then Setlog("$aTempReadCCTroopsCap splitted :" & $aTempReadCCTroopsCap[1] & "/" & $aTempReadCCTroopsCap[2], $COLOR_DEBUG)
			If $aTempReadCCTroopsCap[2] > 0 Then
				$iDonTroopsAv = $aTempReadCCTroopsCap[1]
				$iDonTroopsLimit = $aTempReadCCTroopsCap[2]
				;Setlog("Donate Troops: " & $iDonTroopsAv & "/" & $iDonTroopsLimit)
			EndIf
		Else
			Setlog("Error reading the Castle Troop Capacity...", $COLOR_ERROR) ; log if there is read error
			$iDonTroopsAv = 0
			$iDonTroopsLimit = 0
		EndIf
	EndIf

	If $bSkipDonSpells = False Then
		Local $sReadCCSpellsCap = getCastleDonateCap(420, $DonationWindowY + 220) ; use OCR to get donated/total capacity
		If $debugsetlog = 1 Then Setlog("$sReadCCSpellsCap: " & $sReadCCSpellsCap, $COLOR_DEBUG)
		Local $aTempReadCCSpellsCap = StringSplit($sReadCCSpellsCap, "#")
		If $aTempReadCCSpellsCap[0] >= 2 Then
			;  Note - stringsplit always returns an array even if no values split!
			If $debugsetlog = 1 Then Setlog("$aTempReadCCSpellsCap splitted :" & $aTempReadCCSpellsCap[1] & "/" & $aTempReadCCSpellsCap[2], $COLOR_DEBUG)
			If $aTempReadCCSpellsCap[2] > 0 Then
				$iDonSpellsAv = $aTempReadCCSpellsCap[1]
				$iDonSpellsLimit = $aTempReadCCSpellsCap[2]
				;Setlog("Donate Spells: " & $iDonSpellsAv & "/" & $iDonSpellsLimit)
			EndIf
		Else
			Setlog("Error reading the Castle Spells Capacity...", $COLOR_ERROR) ; log if there is read error
			$iDonSpellsAv = 0
			$iDonSpellsLimit = 0
		EndIf
	EndIf

	If $iDonTroopsAv = $iDonTroopsLimit Then
		$bSkipDonTroops = True
		SetLog("Donate Troop Limit Reached")
	EndIf
	If $iDonSpellsAv = $iDonSpellsLimit Then
		$bSkipDonSpells = True
		SetLog("Donate Spell Limit Reached")
	EndIf

	If $bSkipDonTroops = True And $bSkipDonSpells = True And $iDonTroopsAv < $iDonTroopsLimit And $iDonSpellsAv < $iDonSpellsLimit Then
		Setlog("Donate Troops: " & $iDonTroopsAv & "/" & $iDonTroopsLimit & ", Spells: " & $iDonSpellsAv & "/" & $iDonSpellsLimit)
	EndIf
	If $bSkipDonSpells = False And $iDonTroopsAv < $iDonTroopsLimit And $iDonSpellsAv = $iDonSpellsLimit Then Setlog("Donate Troops: " & $iDonTroopsAv & "/" & $iDonTroopsLimit)
	If $bSkipDonTroops = False And $iDonTroopsAv = $iDonTroopsLimit And $iDonSpellsAv < $iDonSpellsLimit Then Setlog("Donate Spells: " & $iDonSpellsAv & "/" & $iDonSpellsLimit)

	If $debugsetlog = 1 Then Setlog("$bSkipDonTroops: " & $bSkipDonTroops, $COLOR_DEBUG)
	If $debugsetlog = 1 Then Setlog("$bSkipDonSpells: " & $bSkipDonSpells, $COLOR_DEBUG)
	If $debugsetlog = 1 Then Setlog("DonateCapWindow End", $COLOR_DEBUG)
EndFunc   ;==>DonateWindowCap

Func RemainingCCcapacity()
	; Remaining CC capacity of requested troops from your ClanMates
	; Will return the $iTotalDonateCapacity with that capacity for use in donation logic.

	Local $aCapTroops = "", $aTempCapTroops = "", $aCapSpells = "", $aTempCapSpells
	Local $iDonatedTroops = 0, $iDonatedSpells = 0
	Local $iCapTroopsTotal = 0, $iCapSpellsTotal = 0

	$iTotalDonateCapacity = -1
	$iTotalDonateSpellCapacity = -1

	; Verify with OCR the Donation Clan Castle capacity
	If $debugsetlog = 1 Then Setlog("Started dual getOcrSpaceCastleDonate", $COLOR_DEBUG)
	$aCapTroops = getOcrSpaceCastleDonate(49, $DonatePixel[1]) ; when the request is troops+spell
	$aCapSpells = getOcrSpaceCastleDonate(154, $DonatePixel[1]) ; when the request is troops+spell

	If $debugsetlog = 1 Then Setlog("$aCapTroops :" & $aCapTroops, $COLOR_DEBUG)
	If $debugsetlog = 1 Then Setlog("$aCapSpells :" & $aCapSpells, $COLOR_DEBUG)

	If Not (StringInStr($aCapTroops, "#") Or StringInStr($aCapSpells, "#")) Then ; verify if the string is valid or it is just a number from request without spell
		If $debugsetlog = 1 Then Setlog("Started single getOcrSpaceCastleDonate", $COLOR_DEBUG)
		$aCapTroops = getOcrSpaceCastleDonate(78, $DonatePixel[1]) ; when the Request don't have Spell

		If $debugsetlog = 1 Then Setlog("$aCapTroops :" & $aCapTroops, $COLOR_DEBUG)
		$aCapSpells = -1
	EndIf

	If $aCapTroops <> "" Then
		; Splitting the XX/XX
		$aTempCapTroops = StringSplit($aCapTroops, "#")

		; Local Variables to use
		If $aTempCapTroops[0] >= 2 Then
			;  Note - stringsplit always returns an array even if no values split!
			If $debugsetlog = 1 Then Setlog("$aTempCapTroops splitted :" & $aTempCapTroops[1] & "/" & $aTempCapTroops[2], $COLOR_DEBUG)
			If $aTempCapTroops[2] > 0 Then
				$iDonatedTroops = $aTempCapTroops[1]
				$iCapTroopsTotal = $aTempCapTroops[2]
				If $iCapTroopsTotal = 0 Then
					$iCapTroopsTotal = 30
				EndIf
				If $iCapTroopsTotal = 5 Then
					$iCapTroopsTotal = 35
				EndIf
			EndIf
		Else
			Setlog("Error reading the Castle Troop Capacity...", $COLOR_ERROR) ; log if there is read error
			$iDonatedTroops = 0
			$iCapTroopsTotal = 0
		EndIf
	Else
		Setlog("Error reading the Castle Troop Capacity...", $COLOR_ERROR) ; log if there is read error
		$iDonatedTroops = 0
		$iCapTroopsTotal = 0
	EndIf

	If $aCapSpells <> -1 Then
		If $aCapSpells <> "" Then
			; Splitting the XX/XX
			$aTempCapSpells = StringSplit($aCapSpells, "#")

			; Local Variables to use
			If $aTempCapSpells[0] >= 2 Then
				; Note - stringsplit always returns an array even if no values split!
				If $debugsetlog = 1 Then Setlog("$aTempCapSpells splitted :" & $aTempCapSpells[1] & "/" & $aTempCapSpells[2], $COLOR_DEBUG)
				If $aTempCapSpells[2] > 0 Then
					$iDonatedSpells = $aTempCapSpells[1]
					$iCapSpellsTotal = $aTempCapSpells[2]
				EndIf
			Else
				Setlog("Error reading the Castle Spell Capacity...", $COLOR_ERROR) ; log if there is read error
				$iDonatedSpells = 0
				$iCapSpellsTotal = 0
			EndIf
		Else
			Setlog("Error reading the Castle Spell Capacity...", $COLOR_ERROR) ; log if there is read error
			$iDonatedSpells = 0
			$iCapSpellsTotal = 0
		EndIf
	EndIf


	; $iTotalDonateCapacity it will be use to determinate the quantity of kind troop to donate
	$iTotalDonateCapacity = ($iCapTroopsTotal - $iDonatedTroops)
	If $aCapSpells <> -1 Then $iTotalDonateSpellCapacity = ($iCapSpellsTotal - $iDonatedSpells)

	If $iTotalDonateCapacity < 0 Then
		SetLog("Unable to read Castle Capacity!", $COLOR_ERROR)
	Else
		If $aCapSpells <> -1 Then
			SetLog("Chat Troops: " & $iDonatedTroops & "/" & $iCapTroopsTotal & ", Spells: " & $iDonatedSpells & "/" & $iCapSpellsTotal)
		Else
			SetLog("Chat Troops: " & $iDonatedTroops & "/" & $iCapTroopsTotal)
		EndIf
	EndIf

	;;Return $iTotalDonateCapacity

EndFunc   ;==>RemainingCCcapacity

Func DetectSlotTroop($Type)

	Local $FullTemp

	Local $directory = @ScriptDir & "\imgxml\DonateCC"
	Local $directorySpells = @ScriptDir & "\imgxml\DonateCCSpells"


	If $Type >= $eBarb And $Type <= $eBowl Then
		For $Slot = 0 To 5
			Local $x = 343 + (68 * $Slot)
			Local $y = $DonationWindowY + 37
			Local $x1 = $x + 75
			Local $y1 = $y + 43

			$FullTemp = SearchImgloc($directory,$x,$y,$x1,$y1)
			;$FullTemp = getOcrDonationTroopsDetection(343 + (68 * $Slot), $DonationWindowY + 37)

			If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & " SearchImgloc returned >>" & $FullTemp[0] & "<<", $COLOR_DEBUG)
			If StringInStr($FullTemp[0] & " ", "empty") > 0 Then ExitLoop
			If $FullTemp[0] <> "" Then
				For $i = $eBarb To $eBowl
					$sTmp = StringStripWS(StringLeft(NameOfTroop($i), 4), $STR_STRIPTRAILING)
					;If $debugsetlog = 1 Then Setlog(NameOfTroop($i) & " = " & $sTmp, $COLOR_DEBUG)
					If StringInStr($FullTemp[0] & " ", $sTmp) > 0 Then
						If $debugsetlog = 1 Then Setlog("Detected " & NameOfTroop($i), $COLOR_DEBUG)
						If $Type = $i Then Return $Slot
						ExitLoop
					EndIf
					If $i = $eBowl Then ; detection failed
						If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & "Troop Detection Failed", $COLOR_DEBUG)
					EndIf
				Next
			EndIf
		Next
		For $Slot = 6 To 11
			Local $x = 343 + (68 * ($Slot - 6))
			Local $y = $DonationWindowY + 124
			Local $x1 = $x + 75
			Local $y1 = $y + 43

			$FullTemp = SearchImgloc($directory,$x,$y,$x1,$y1)
			;$FullTemp = getOcrDonationTroopsDetection(343 + (68 * ($Slot - 6)), $DonationWindowY + 124)

			If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & " SearchImgloc returned >>" & $FullTemp[0] & "<<", $COLOR_DEBUG)
			If StringInStr($FullTemp[0] & " ", "empty") > 0 Then ExitLoop
			If $FullTemp[0] <> "" Then
				For $i = $eBall To $eBowl
					$sTmp = StringStripWS(StringLeft(NameOfTroop($i), 4), $STR_STRIPTRAILING)
					;If $debugsetlog = 1 Then Setlog(NameOfTroop($i) & " = " & $sTmp, $COLOR_DEBUG)
					If StringInStr($FullTemp[0] & " ", $sTmp) > 0 Then
						If $debugsetlog = 1 Then Setlog("Detected " & NameOfTroop($i), $COLOR_DEBUG)
						If $Type = $i Then Return $Slot
						ExitLoop
					EndIf
					If $i = $eBowl Then ; detection failed
						If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & "Troop Detection Failed", $COLOR_DEBUG)
					EndIf
				Next
			EndIf
		Next
	EndIf
	If $Type >= $eLSpell And $Type <= $eSkSpell Then
		For $Slot = 12 To 17
			Local $x = 343 + (68 * ($Slot - 12))
			Local $y = $DonationWindowY + 241
			Local $x1 = $x + 75
			Local $y1 = $y + 43

			$FullTemp = SearchImgloc($directorySpells,$x,$y,$x1,$y1)
			;$FullTemp = getOcrDonationTroopsDetection(343 + (68 * ($Slot - 12)), $DonationWindowY + 241)

			If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & " SearchImgloc returned >>" & $FullTemp[0] & "<<", $COLOR_DEBUG)
			If StringInStr($FullTemp[0] & " ", "empty") > 0 Then ExitLoop
			If $FullTemp[0] <> "" Then
				For $i = $eLSpell To $eSkSpell
					$sTmp = StringLeft(NameOfTroop($i), 4)
					;If $debugsetlog = 1 Then Setlog(NameOfTroop($i) & " = " & $sTmp, $COLOR_DEBUG)
					If StringInStr($FullTemp[0] & " ", $sTmp) > 0 Then
						If $debugsetlog = 1 Then Setlog("Detected " & NameOfTroop($i), $COLOR_DEBUG)
						If $Type = $i Then Return $Slot
						ExitLoop
					EndIf
					If $i = $eSkSpell Then ; detection failed
						If $debugsetlog = 1 Then Setlog("Slot: " & $Slot & "Spell Detection Failed", $COLOR_DEBUG)
					EndIf
				Next
			EndIf
		Next
	EndIf

	Return -1

EndFunc   ;==>DetectSlotTroop

Func SkipDonateNearFullTroops($setlog = False, $aHeroResult = Default)

	If $bDonationEnabled = False Then Return True ; will disable the donation

	If $iSkipDonateNearFulLTroopsEnable = 0 Then Return False ; will enable the donation

	If $CommandStop = 0 And $bTrainEnabled = True Then Return False ; IF is halt Attack and Train/Donate ....Enable the donation

	Local $hour = StringSplit(_NowTime(4), ":", $STR_NOCOUNT)

	If $iPlannedDonateHours[$hour[0]] = 0 And $iPlannedDonateHoursEnable = 1 Then Return True ; will disable the donation

	If $iSkipDonateNearFulLTroopsEnable = 1 Then
		If (Number($ArmyCapacity) > Number($sSkipDonateNearFulLTroopsPercentual)) Then
			Local $rIsWaitforHeroesActive = IsWaitforHeroesActive()
			If $rIsWaitforHeroesActive = True Then
				If $aHeroResult = Default Or IsArray($aHeroResult) = False Then
					If OpenArmyWindow() = False Then Return False ; Return False if failed to Open Army Window
					$aHeroResult = getArmyHeroTime("all")
				EndIf
				If @error Or UBound($aHeroResult) < 3 Then
					Setlog("getArmyHeroTime return error: #" & @error & "|IA:" & IsArray($aHeroResult) & "," & UBound($aHeroResult) & ", exit SkipDonateNearFullTroops!", $COLOR_ERROR)
					Return False ; if error, then quit SkipDonateNearFullTroops enable the donation
				EndIf
				If $debugSetlog = 1 Then SetLog("getArmyHeroTime returned: " & $aHeroResult[0] & ":" & $aHeroResult[1] & ":" & $aHeroResult[2], $COLOR_DEBUG)
				Local $iActiveHero = 0
				Local $iHighestTime = -1
				For $pTroopType = $eKing To $eWarden ; check all 3 hero
					For $pMatchMode = $DB To $iModeCount - 1 ; check all attack modes
						$iActiveHero = -1
						If IsSearchModeActiveMini($pMatchMode) And IsSpecialTroopToBeUsed($pMatchMode, $pTroopType) And $iHeroUpgrading[$pTroopType - $eKing] <> 1 And $iHeroWaitNoBit[$pMatchMode][$pTroopType - $eKing] = 1 Then
							$iActiveHero = $pTroopType - $eKing ; compute array offset to active hero
						EndIf
								;SetLog("$iActiveHero = " & $iActiveHero, $COLOR_DEBUG)
						If $iActiveHero <> -1 And $aHeroResult[$iActiveHero] > 0 Then ; valid time?
							If $aHeroResult[$iActiveHero] > $iHighestTime Then	; Is the time higher than indexed time?
								$iHighestTime = $aHeroResult[$iActiveHero]
							EndIf
						EndIf
					Next
					If _Sleep($iDelayRespond) Then Return
				Next
				If $debugSetlog = 1 Then SetLog("$iHighestTime = " & $iHighestTime & "|" & String($iHighestTime > 5), $COLOR_DEBUG)
				If $iHighestTime > 5 Then
					If $setlog Then Setlog("» Donations enabled, Heroes recover time is long", $COLOR_INFO)
					Return False
				Else
					If $setlog Then Setlog("» Donation disabled, available troops " & $ArmyCapacity & "%, limit " & $sSkipDonateNearFulLTroopsPercentual & "%", $COLOR_INFO)
					Return True ; troops camps% > limit
				EndIf
			Else
				If $setlog Then Setlog("» Donation disabled, available troops " & $ArmyCapacity & "%, limit " & $sSkipDonateNearFulLTroopsPercentual & "%", $COLOR_INFO)
				Return True ; troops camps% > limit
			EndIf
		Else
			If $setlog Then Setlog("» Donations enabled, available troops " & $ArmyCapacity & "%, limit " & $sSkipDonateNearFulLTroopsPercentual & "%", $COLOR_INFO)
			Return False ; troops camps% into limits
		EndIf
	Else
		;Setlog("ok, donate enabled (Skip Donate Near FulL Troops disabled option)")
		Return False ; feature disabled
	EndIf
EndFunc   ;==>SkipDonateNearFullTroops

Func DonatedTroop($Type, $iDonTroopsQuantity)

	Switch $Type
		Case $eBarb
			$TroopsDonQ[1] += $iDonTroopsQuantity
			$TroopsDonXP[1] += $iDonTroopsQuantity
		Case $eArch
			$TroopsDonQ[2] += $iDonTroopsQuantity
			$TroopsDonXP[2] += $iDonTroopsQuantity
		Case $eGiant
			$TroopsDonQ[3] += $iDonTroopsQuantity
			$TroopsDonXP[3] += $iDonTroopsQuantity * 5
		Case $eGobl
			$TroopsDonQ[4] += $iDonTroopsQuantity
			$TroopsDonXP[4] += $iDonTroopsQuantity
		Case $eWall
			$TroopsDonQ[5] += $iDonTroopsQuantity
			$TroopsDonXP[5] += $iDonTroopsQuantity * 2
		Case $eWiza
			$TroopsDonQ[6] += $iDonTroopsQuantity
			$TroopsDonXP[6] += $iDonTroopsQuantity * 4
		Case $eBall
			$TroopsDonQ[7] += $iDonTroopsQuantity
			$TroopsDonXP[7] += $iDonTroopsQuantity * 5
		Case $eHeal
			$TroopsDonQ[8] += $iDonTroopsQuantity
			$TroopsDonXP[8] += $iDonTroopsQuantity * 14
		Case $eDrag
			$TroopsDonQ[9] += $iDonTroopsQuantity
			$TroopsDonXP[9] += $iDonTroopsQuantity * 20
		Case $ePekk
			$TroopsDonQ[10] += $iDonTroopsQuantity
			$TroopsDonXP[10] += $iDonTroopsQuantity * 25
		Case $eBabyD
			$TroopsDonQ[11] += $iDonTroopsQuantity
			$TroopsDonXP[11] += $iDonTroopsQuantity * 10
		Case $eMine
			$TroopsDonQ[12] += $iDonTroopsQuantity
			$TroopsDonXP[12] += $iDonTroopsQuantity * 5
		Case $eMini
			$TroopsDonQ[13] += $iDonTroopsQuantity
			$TroopsDonXP[13] += $iDonTroopsQuantity * 2
		Case $eHogs
			$TroopsDonQ[14] += $iDonTroopsQuantity
			$TroopsDonXP[14] += $iDonTroopsQuantity * 5
		Case $eValk
			$TroopsDonQ[15] += $iDonTroopsQuantity
			$TroopsDonXP[15] += $iDonTroopsQuantity * 8
		Case $eWitc
			$TroopsDonQ[16] += $iDonTroopsQuantity
			$TroopsDonXP[16] += $iDonTroopsQuantity * 12
		Case $eGole
			$TroopsDonQ[17] += $iDonTroopsQuantity
			$TroopsDonXP[17] += $iDonTroopsQuantity * 30
		Case $eLava
			$TroopsDonQ[18] += $iDonTroopsQuantity
			$TroopsDonXP[18] += $iDonTroopsQuantity * 30
		Case $eBowl
			$TroopsDonQ[19] += $iDonTroopsQuantity
			$TroopsDonXP[19] += $iDonTroopsQuantity * 6
	EndSwitch

	For $i = 1 To 19
		GUICtrlSetData($lblDonQ[$i], $TroopsDonQ[$i])
	Next

	Local $TotalTrQ = 0
	For $i = 1 To 19
		$TotalTrQ += $TroopsDonQ[$i]
	Next

	Local $TotalTrXPWon = 0
	For $i = 1 To 19
		$TotalTrXPWon += $TroopsDonXP[$i]
	Next

	GUICtrlSetData($lblTotalTroopsQ, GetTranslated(632,120,"Total Donated") & " : " & $TotalTrQ)
	GUICtrlSetData($lblTotalTroopsXP, GetTranslated(632,121,"XP Won") & " : " & $TotalTrXPWon)

EndFunc   ;==>DonatedTroop

Func DonatedSpell($Type, $iDonSpellsQuantity)

	Switch $Type
		Case $eLSpell
			$TroopsDonQ[20] += $iDonSpellsQuantity
			$TroopsDonXP[20] += $iDonSpellsQuantity * 10
		Case $eHSpell
			$TroopsDonQ[21] += $iDonSpellsQuantity
			$TroopsDonXP[21] += $iDonSpellsQuantity * 10
		Case $eRSpell
			$TroopsDonQ[22] += $iDonSpellsQuantity
			$TroopsDonXP[22] += $iDonSpellsQuantity * 10
		Case $eJSpell
			$TroopsDonQ[23] += $iDonSpellsQuantity
			$TroopsDonXP[23] += $iDonSpellsQuantity * 10
		Case $eFSpell
			$TroopsDonQ[24] += $iDonSpellsQuantity
			$TroopsDonXP[24] += $iDonSpellsQuantity * 10
		Case $ePSpell
			$TroopsDonQ[25] += $iDonSpellsQuantity
			$TroopsDonXP[25] += $iDonSpellsQuantity * 5
		Case $eESpell
			$TroopsDonQ[26] += $iDonSpellsQuantity
			$TroopsDonXP[26] += $iDonSpellsQuantity * 5
		Case $eHaSpell
			$TroopsDonQ[27] += $iDonSpellsQuantity
			$TroopsDonXP[27] += $iDonSpellsQuantity * 5
		Case $eSkSpell
			$TroopsDonQ[28] += $iDonSpellsQuantity
			$TroopsDonXP[28] += $iDonSpellsQuantity * 5
	EndSwitch

	For $i = 20 To 28
		GUICtrlSetData($lblDonQ[$i], $TroopsDonQ[$i])
	Next

	Local $TotalSpQ = 0
	For $i = 20 To 28
		$TotalSpQ += $TroopsDonQ[$i]
	Next

	Local $TotalSpXPWon = 0
	For $i = 20 To 28
		$TotalSpXPWon += $TroopsDonXP[$i]
	Next

	GUICtrlSetData($lblTotalSpellsQ, GetTranslated(632,120,"Total Donated") & " : " & $TotalSpQ)
	GUICtrlSetData($lblTotalSpellsXP, GetTranslated(632,121,"XP Won") & " : " & $TotalSpXPWon)

EndFunc   ;==>DonatedSpell

Func SearchImgloc($directory = "", $x = 0, $y = 0, $x1 = 0, $y1 = 0)

	; Setup arrays, including default return values for $return
	Local $aResult[1], $aCoordArray[1][2], $aCoords, $aCoordsSplit, $aValue
	Local $Redlines = "FV"
	; Capture the screen for comparison
	_CaptureRegion2($x, $y, $x1, $y1)
	$res = DllCall($hImgLib, "str", "SearchMultipleTilesBetweenLevels", "handle", $hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", $Redlines, "Int", 0, "Int", 1000)

	If $res[0] <> "" Then
		; Get the keys for the dictionary item.
		Local $aKeys = StringSplit($res[0], "|", $STR_NOCOUNT)

		; Redimension the result array to allow for the new entries
		ReDim $aResult[UBound($aKeys)]

		; Loop through the array
		For $i = 0 To UBound($aKeys) - 1
			; Get the property values
			$aResult[$i] = returnPropertyValue($aKeys[$i], "objectname")
		Next
		Return $aResult
	EndIf
	$aResult[0] = "queued"
	Return $aResult
EndFunc
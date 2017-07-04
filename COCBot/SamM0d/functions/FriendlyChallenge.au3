Func FriendlyChallenge()
	ForceCaptureRegion()
	_CaptureRegion2(260,85,272,624)
	Local $aLastResult[1][2]
	Local $sDirectory = $g_sSamM0dImageLocation & "\Chat\"
	Local $returnProps="objectpoints"
	Local $aCoor
	Local $aPropsValues
	Local $aCoorXY
	Local $result
	Local $sReturn = ""
	Local $iCount = 0
	Local $iMax = 0
	Local $jMax = 0
	Local $i, $j
	Local $ClanString

	Local $hmyHBitmap2 = GetHHBitmapArea($g_hHBitmap2)
	Local $hHBitmapDivider = GetHHBitmapArea($hmyHBitmap2,0,0,10,539)

	Local $result = findMultiImage($hHBitmapDivider, $sDirectory ,"FV" ,"FV", 0, 0, 0 , $returnProps)
	If $hHBitmapDivider <> 0 Then GdiDeleteHBitmap($hHBitmapDivider)

	If IsArray($result) then
		$iMax = UBound($result) -1
		For $i = 0 To $iMax
			$aPropsValues = $result[$i] ; should be return objectname,objectpoints,objectlevel
			If UBound($aPropsValues) = 1 then
				SetLog("$aPropsValues[0]: " & $aPropsValues[0], $COLOR_DEBUG)
				$aCoor = StringSplit($aPropsValues[0],"|",$STR_NOCOUNT) ; objectpoints, split by "|" to get multi coor x,y ; same image maybe can detect at different location.
				If IsArray($aCoor) Then
					For $j =  0 to UBound($aCoor) - 1
						$aCoorXY = StringSplit($aCoor[$j],",",$STR_NOCOUNT)
						ReDim $aLastResult[$iCount + 1][2]
						$aLastResult[$iCount][0] = Int($aCoorXY[0])
						$aLastResult[$iCount][1] = Int($aCoorXY[1]) + 83
						$iCount += 1
					Next
				EndIf
			EndIf
		Next
		If UBound($aLastResult) > 1 Then
			_ArraySort($aLastResult, 1, 0, 0, 1) ; rearrange order by coor Y
			_CaptureRegion2(0,0,287,732)
			For $i = 0 To UBound($aLastResult) - 1
				SetLog("Afrer _ArraySort - Coor X,Y:" & $aLastResult[$i][0] & "," & $aLastResult[$i][1], $COLOR_DEBUG)

				If $g_bChkExtraAlphabets Then
					; Chat Request using "coc-latin-cyr" xml: Latin + Cyrillic derived alphabets / three paragraphs
					Setlog("Using OCR to read Latin and Cyrillic derived alphabets..", $COLOR_ACTION)
					$ClanString = ""
					$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 17, 280, 16, Default, Default, False)
					If $ClanString = "" Then
						$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 31, 280, 16, Default, Default, False)
					Else
						$ClanString &= " " & getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 31, 280, 16, Default, Default, False)
					EndIf
					If $ClanString = "" Or $ClanString = " " Then
						$ClanString = getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 44, 280, 16, Default, Default, False)
					Else
						$ClanString &= " " & getOcrAndCapture("coc-latin-cyr", 30, $aLastResult[$i][1] + 44, 280, 16, Default, Default, False)
					EndIf
					If _Sleep($DELAYDONATECC2) Then ExitLoop
				Else ; default
					; Chat Request using "coc-latinA" xml: only Latin derived alphabets / three paragraphs
					Setlog("Using OCR to read Latin derived alphabets..", $COLOR_ACTION)
					$ClanString = ""
					$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 17, 280, 16, Default, Default, False)
					If $ClanString = "" Then
						$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 31, 280, 16, Default, Default, False)
					Else
						$ClanString &= " " & getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 31, 280, 16, Default, Default, False)
					EndIf
					If $ClanString = "" Or $ClanString = " " Then
						$ClanString = getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 44, 280, 16, Default, Default, False)
					Else
						$ClanString &= " " & getOcrAndCapture("coc-latinA", 30, $aLastResult[$i][1] + 44, 280, 16, Default, Default, False)
					EndIf
					If _Sleep($DELAYDONATECC2) Then ExitLoop
				EndIf
				; Chat Request using IMGLOC: Chinese alphabet / one paragraph
				If $g_bChkExtraChinese Then
					Setlog("Using OCR to read the Chinese alphabet..", $COLOR_ACTION)
					If $ClanString = "" Then
						$ClanString = getOcrAndCapture("chinese-bundle", 30, $aLastResult[$i][1] + 43, 160, 14, Default, True, False)
					Else
						$ClanString &= " " & getOcrAndCapture("chinese-bundle", 30, $aLastResult[$i][1] + 43, 160, 14, Default, True, False)
					EndIf
					If _Sleep($DELAYDONATECC2) Then ExitLoop
				EndIf
				; Chat Request using IMGLOC: Korean alphabet / one paragraph
				If $g_bChkExtraKorean Then
					Setlog("Using OCR to read the Korean alphabet..", $COLOR_ACTION)
					If $ClanString = "" Then
						$ClanString = getOcrAndCapture("korean-bundle", 30, $aLastResult[$i][1] + 43, 160, 14, Default, True, False)
					Else
						$ClanString &= " " & getOcrAndCapture("korean-bundle", 30, $aLastResult[$i][1] + 43, 160, 14, Default, True, False)
					EndIf
					If _Sleep($DELAYDONATECC2) Then ExitLoop
				EndIf
				; Chat Request using IMGLOC: Persian alphabet / one paragraph
				If $g_bChkExtraPersian Then
					Setlog("Using OCR to read the Persian alphabet..", $COLOR_ACTION)
					If $ClanString = "" Then
						$ClanString = getChatStringPersianMod(30, $aLastResult[$i][1] + 36)
					Else
						$ClanString &= " " & getChatStringPersianMod(30, $aLastResult[$i][1] + 36)
					EndIf
					If _Sleep($DELAYDONATECC2) Then ExitLoop
				EndIf
				; samm0d
				If $ichkEnableCustomOCR4CCRequest = 1 Then
					Setlog("Using custom OCR to read cc request message..", $COLOR_ACTION)
					Local $hHBitmapCustomOCR = GetHHBitmapArea($g_hHBitmap2,30, $aLastResult[$i][1] + 43, 190, $aLastResult[$i][1] + 43 + 14)
					If $ClanString = "" Then
						$ClanString = getMyOcr($hHBitmapCustomOCR, 30, $aLastResult[$i][1] + 43,160,14,"ccrequest",False,True)
					Else
						$ClanString &= " " & getMyOcr($hHBitmapCustomOCR, 30, $aLastResult[$i][1] + 43,160,14,"ccrequest",False,True)
					EndIf

					If $hHBitmapCustomOCR <> 0 Then GdiDeleteHBitmap($hHBitmapCustomOCR)
				EndIf

				If $ClanString = "" Or $ClanString = " " Then
					SetLog("Unable to read Chat!", $COLOR_ERROR)
				Else
					SetLog("Chat: " & $ClanString)
				EndIf
			Next
		EndIf
	EndIf
	If $g_hHBitmap2 <> 0 Then GdiDeleteHBitmap($g_hHBitmap2)
EndFunc

Func getChatStringPersianMod($x_start, $y_start, $bConvert = True) ; -> Get string chat request - Persian - "DonateCC.au3"
	Local $bUseOcrImgLoc = True
	Local $OCRString = getOcrAndCapture("persian-bundle", $x_start, $y_start, 240, 20, Default, $bUseOcrImgLoc, False)
	If $bConvert = True Then
		$OCRString = StringReverse($OCRString)
		$OCRString = StringReplace($OCRString, "A", "?")
		$OCRString = StringReplace($OCRString, "B", "?")
		$OCRString = StringReplace($OCRString, "C", "?")
		$OCRString = StringReplace($OCRString, "D", "?")
		$OCRString = StringReplace($OCRString, "F", "?")
		$OCRString = StringReplace($OCRString, "G", "?")
		$OCRString = StringReplace($OCRString, "J", "?")
		$OCRString = StringReplace($OCRString, "H", "?")
		$OCRString = StringReplace($OCRString, "R", "?")
		$OCRString = StringReplace($OCRString, "K", "?")
		$OCRString = StringReplace($OCRString, "K", "?")
		$OCRString = StringReplace($OCRString, "M", "?")
		$OCRString = StringReplace($OCRString, "N", "?")
		$OCRString = StringReplace($OCRString, "P", "?")
		$OCRString = StringReplace($OCRString, "S", "?")
		$OCRString = StringReplace($OCRString, "T", "?")
		$OCRString = StringReplace($OCRString, "V", "?")
		$OCRString = StringReplace($OCRString, "Y", "?")
		$OCRString = StringReplace($OCRString, "L", "?")
		$OCRString = StringReplace($OCRString, "Z", "?")
		$OCRString = StringReplace($OCRString, "X", "?")
		$OCRString = StringReplace($OCRString, "Q", "?")
		$OCRString = StringReplace($OCRString, ",", ",")
		$OCRString = StringReplace($OCRString, "0", " ")
		$OCRString = StringReplace($OCRString, "1", ".")
		$OCRString = StringReplace($OCRString, "22", "?")
		$OCRString = StringReplace($OCRString, "44", "?")
		$OCRString = StringReplace($OCRString, "55", "?")
		$OCRString = StringReplace($OCRString, "66", "?")
		$OCRString = StringReplace($OCRString, "77", "?")
		$OCRString = StringReplace($OCRString, "88", "??")
		$OCRString = StringReplace($OCRString, "99", "?")
		$OCRString = StringStripWS($OCRString, 1 + 2)
	EndIf
	Return $OCRString
EndFunc   ;==>getChatStringPersian
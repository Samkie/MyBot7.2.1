; #FUNCTION# ====================================================================================================================
; Name ..........: searchTroopBar
; Description ...: Searches for the Troops and Spels in Troop Attack Bar
; Syntax ........: searchTroopBar($directory, $maxReturnPoints = 1, $TroopBarSlots)
; Parameters ....: $directory - tile location to perform search , $maxReturnPoints ( max number of coords returned ,   $TroopBarSlots array to hold return values
; Return values .: $TroopBarSlots
; Author ........: TRLopes (June 2016)
; Modified ......: ProMac ( Dec 2016 )
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
Func TestImglocTroopBar()
	$RunState = True
	$debugSetlog = 1
	$debugOCR = 1
	$debugImageSave = 1

	Setlog("=========== Imgloc ============")
	PrepareAttack($DB)
	$debugSetlog = 0
	$debugOCR = 0
	$debugImageSave = 0
	$RunState = False
EndFunc

Func AttackBarCheck()

	Local $x = 0, $y = 659, $x1 = 853, $y1 = 698
	Local $CheckSlot12 = False
	Local $CheckSlotwHero = False

	; Setup arrays, including default return values for $return
	Local $aResult[1][5], $aCoordArray[1][2], $aCoords, $aCoordsSplit, $aValue
	Local $redLines = "FV"
	Local $directory =  @ScriptDir & "\imgxml\AttackBar"
	If $RunState = False Then Return
	; Capture the screen for comparison
	_CaptureRegion2($x, $y, $x1, $y1)

	Local $strinToReturn = ""
	; Perform the search
	$res = DllCall($hImgLib, "str", "SearchMultipleTilesBetweenLevels", "handle", $hHBitmap2, "str", $directory, "str", "FV", "Int", 0, "str", $redLines, "Int", 0, "Int", 1000)

	If IsArray($res) Then
		If $res[0] = "0" Or $res[0] = "" Then
			SetLog("Imgloc|AttackBarCheck not found!", $COLOR_RED)
		ElseIf StringLeft($res[0], 2) = "-1" Then
			SetLog("DLL Error: " & $res[0] & ", AttackBarCheck", $COLOR_RED)
		Else
			; Get the keys for the dictionary item.
			Local $aKeys = StringSplit($res[0], "|", $STR_NOCOUNT)

			; Redimension the result array to allow for the new entries
			ReDim $aResult[UBound($aKeys)][5]

			; Loop through the array
			For $i = 0 To UBound($aKeys) - 1
				If $RunState = False Then Return
				; Get the property values
				$aResult[$i][0] = returnPropertyValue($aKeys[$i], "objectname")
				; Get the coords property
				$aValue = returnPropertyValue($aKeys[$i], "objectpoints")
				$aCoords = StringSplit($aValue, "|", $STR_NOCOUNT)
				$aCoordsSplit = StringSplit($aCoords[0], ",", $STR_NOCOUNT)
				If UBound($aCoordsSplit) = 2 Then
					; Store the coords into a two dimensional array
					$aCoordArray[0][0] = $aCoordsSplit[0] ; X coord.
					$aCoordArray[0][1] = $aCoordsSplit[1] ; Y coord.
				Else
					$aCoordArray[0][0] = -1
					$aCoordArray[0][1] = -1
				EndIf
				If $debugSetlog = 1 Then Setlog($aResult[$i][0] & " | $aCoordArray: " & $aCoordArray[0][0] & "-" & $aCoordArray[0][1])
				;;;;;;;; If exist Castle Spell ;;;;;;;
				If UBound($aCoords) > 1 And StringInStr($aResult[$i][0], "Spell") <> 0 Then
					If $debugSetlog = 1 Then Setlog($aResult[$i][0] & " detected twice!")
					Local $aCoordsSplit2 = StringSplit($aCoords[1], ",", $STR_NOCOUNT)
					If UBound($aCoordsSplit2) = 2 Then
						; Store the coords into a two dimensional array
						If $aCoordsSplit2[0] < $aCoordsSplit[0] Then
							$aCoordArray[0][0] = $aCoordsSplit2[0] ; X coord.
							$aCoordArray[0][1] = $aCoordsSplit2[1] ; Y coord.
							If $debugSetlog = 1 Then Setlog($aResult[$i][0] & " | $aCoordArray: " & $aCoordArray[0][0] & "-" & $aCoordArray[0][1])
						EndIf
					Else
						$aCoordArray[0][0] = -1
						$aCoordArray[0][1] = -1
					EndIf
				EndIf
				; Store the coords array as a sub-array
				$aResult[$i][1] = Number($aCoordArray[0][0])
				$aResult[$i][2] = Number($aCoordArray[0][1])
			Next

			_ArraySort($aResult, 0, 0, 0, 1) ; Sort By X position , will be the Slot 0 to $i

			$CheckSlot12 = _ColorCheck(_GetPixelColor(17, 643, True), Hex(0x478AC6, 6), 15) Or _  	; Slot Filled / Background Blue / More than 11 Slots
						   _ColorCheck(_GetPixelColor(17, 643, True), Hex(0x434343, 6), 10)   		; Slot deployed / Gray / More than 11 Slots

			If $debugSetlog = 1 Then
				Setlog(" Slot > 12 _ColorCheck 0x478AC6 at (17," & 643 & "): " & $CheckSlot12, $COLOR_DEBUG) ;Debug
				Local $CheckSlot12Color = _GetPixelColor(17, 643, $bCapturePixel)
				Setlog(" Slot > 12 _GetPixelColor(17," & 643 & "): " & $CheckSlot12Color, $COLOR_DEBUG) ;Debug
			EndIf

			For $i = 0 To UBound($aResult) - 1
				If $aResult[$i][0] = "King" Or $aResult[$i][0] = "Queen" Or $aResult[$i][0] = "Warden" Then
					$CheckSlotwHero = True
				EndIf
			Next

			For $i = 0 To UBound($aResult) - 1
				Local $Slottemp
				If $aResult[$i][1] > 0 Then
					If $debugSetlog = 1 Then SetLog("SLOT : " & $i, $COLOR_DEBUG) ;Debug
					If $debugSetlog = 1 Then SetLog("Detection : " & $aResult[$i][0] & "|x" & $aResult[$i][1] & "|y" & $aResult[$i][2], $COLOR_DEBUG) ;Debug
					$Slottemp = SlotAttack(number($aResult[$i][1]), $CheckSlot12, $CheckSlotwHero)
					If $RunState = False Then Return ; Stop function
					If _Sleep(20) then return        ; Pause function
					If Ubound($Slottemp) = 2 then
						If $debugSetlog = 1 Then SetLog("OCR : " & $Slottemp[0] & "|SLOT: " & $Slottemp[1], $COLOR_DEBUG) ;Debug
						If $aResult[$i][0] = "Castle" Or $aResult[$i][0] = "King" Or $aResult[$i][0] = "Queen" Or $aResult[$i][0] = "Warden" Then
							$aResult[$i][3] = 1
							$aResult[$i][4] = $Slottemp[1]
						Else
							$aResult[$i][3] = Number(getTroopCountBig(Number($Slottemp[0]), 636)) ; For Bigg Numbers , when the troops is selected
							$aResult[$i][4] = $Slottemp[1]
							If $aResult[$i][3] = "" Or $aResult[$i][3] = 0 Then
								$aResult[$i][3] = Number(getTroopCountSmall(Number($Slottemp[0]), 641)) ; For small Numbers
								$aResult[$i][4] = $Slottemp[1]
							EndIf
						EndIf
					Else
						Setlog("Problem with Attack bar detection!", $COLOR_RED)
						SetLog("Detection : " & $aResult[$i][0] & "|x" & $aResult[$i][1] & "|y" & $aResult[$i][2], $COLOR_DEBUG)
						$aResult[$i][3] = -1
						$aResult[$i][4] = -1
					EndIf
					$strinToReturn &= "|" & Eval("e" & $aResult[$i][0]) & "#" & $aResult[$i][4] & "#" & $aResult[$i][3]
				EndIf
			Next
		EndIf
	EndIf

	If $debugImageSave = 1 Then
		Local $x = 0, $y = 659, $x1 = 853, $y1 = 698
		_CaptureRegion2($x, $y, $x1, $y1)
		Local $subDirectory = $dirTempDebug & "AttackBarDetection"
		DirCreate($subDirectory)
		Local $Date = @YEAR & "-" & @MON & "-" & @MDAY
		Local $Time = @HOUR & "." & @MIN & "." & @SEC
		Local $filename = String($Date & "_" & $Time & "_.png")
		Local $editedImage = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap2)
		Local $hGraphic = _GDIPlus_ImageGetGraphicsContext($editedImage)
		Local $hPenRED = _GDIPlus_PenCreate(0xFFFF0000, 3) ; Create a pencil Color FF0000/RED

		For $i = 0 To UBound($aResult) - 1
			addInfoToDebugImage($hGraphic, $hPenRED, $aResult[$i][0], $aResult[$i][1], $aResult[$i][2])
			;_GDIPlus_GraphicsDrawRect($hGraphic, $aResult[$i][1] - 5, $aResult[$i][2] - 5, 10, 10, $hPenRED)
		Next

		_GDIPlus_ImageSaveToFile($editedImage, $subDirectory & "\" & $filename)
		_GDIPlus_PenDispose($hPenRED)
		_GDIPlus_GraphicsDispose($hGraphic)
		_GDIPlus_BitmapDispose($EditedImage)
	EndIf

	$strinToReturn = StringTrimLeft($strinToReturn, 1)

	; Setlog("String: " & $strinToReturn)
	; Will return [0] = Name , [1] = X , [2] = Y , [3] = Quantities , [4] = Slot Number
	; Old style is: "|" & Troopa Number & "#" & Slot Number & "#" & Quantities
	Return $strinToReturn

EndFunc   ;==>AttackBarCheck

Func SlotAttack($PosX, $CheckSlot12, $CheckSlotwHero)

	Local $Slottemp[2] = [0, 0]

	for $i = 0 to 12
		If $PosX >= 25 + ($i * 73)  and $PosX < 98 + ($i * 73) then
			$Slottemp[0] = 35 + ($i * 73)
			$Slottemp[1] = $i
			If $CheckSlot12 = True Then
				$Slottemp[0] -= 13
			ElseIf $CheckSlotwHero = False Then
				$Slottemp[0] += 8
			EndIf
			If $debugSetlog = 1 Then Setlog("Slot: " & $i & " | $x > " & 25 + ($i * 73) & " and $x < " & 98 + ($i * 73))
			If $debugSetlog = 1 Then Setlog("Slot: " & $i & " | $PosX: " & $PosX & " |  OCR x position: " & $Slottemp[0] & " | OCR Slot: " & $Slottemp[1])
			Return $Slottemp
		EndIF
		If $RunState = False Then Return
	next

	Return $Slottemp

EndFunc   ;==>SlotAttack

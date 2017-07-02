; #FUNCTION# ====================================================================================================================
; Name ..........: CheckZoomOut
; Description ...:
; Syntax ........: CheckZoomOut()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #12
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
;
Func CheckZoomOut($sSource = "CheckZoomOut", $bCheckOnly = False, $bForecCapture = True)
	If $bForecCapture = True Then
		_CaptureRegion2()
	EndIf
	; samm0d - reset variable
	For $i = 0 To 4
		$TopLeft[$i][0] = $TopLeftOri[$i][0]
		$TopRight[$i][0] = $TopRightOri[$i][0]
		$BottomLeft[$i][0] = $BottomLeftOri[$i][0]
		$BottomRight[$i][0] = $BottomRightOri[$i][0]
		$TopLeft[$i][1] = $TopLeftOri[$i][1]
		$TopRight[$i][1] = $TopRightOri[$i][1]
		$BottomLeft[$i][1] = $BottomLeftOri[$i][1]
		$BottomRight[$i][1] = $BottomRightOri[$i][1]
	Next

	Local $aVillageResult = SearchZoomOut(False, True, $sSource, False)
	If IsArray($aVillageResult) = 0 Or $aVillageResult[0] = "" Then
		; not zoomed out, Return
		If $bCheckOnly = False Then
			SetLog("Not Zoomed Out! Exiting to MainScreen...", $COLOR_ERROR)
			checkMainScreen() ;exit battle screen
			$Restart = True ; Restart Attack
			$Is_ClientSyncError = True ; quick restart
		EndIf
		Return False
	EndIf

	; samm0d - update edge coor
	For $i = 0 To 4
		$TopLeft[$i][0] = $TopLeftOri[$i][0] + $aVillageResult[1]
		$TopRight[$i][0] = $TopRightOri[$i][0] + $aVillageResult[1]
		$BottomLeft[$i][0] = $BottomLeftOri[$i][0] + $aVillageResult[1]
		$BottomRight[$i][0] = $BottomRightOri[$i][0] + $aVillageResult[1]

		$TopLeft[$i][1] = $TopLeftOri[$i][1] + $aVillageResult[2]
		$TopRight[$i][1] = $TopRightOri[$i][1] + $aVillageResult[2]
		$BottomLeft[$i][1] = $BottomLeftOri[$i][1] + $aVillageResult[2]
		$BottomRight[$i][1] = $BottomRightOri[$i][1] + $aVillageResult[2]

		If $BottomLeft[$i][1] > 620 Then
			$BottomLeft[$i][1] = 620
		EndIf
		If $BottomRight[$i][1] > 620 Then
			$BottomRight[$i][1] = 620
		EndIf
		If $iSamM0dDebug = 1 Then SetLog("$TopLeft: " & $TopLeft[$i][0] & "," & $TopLeft[$i][1])
		If $iSamM0dDebug = 1 Then SetLog("$TopRight: " & $TopRight[$i][0] & "," & $TopRight[$i][1])
		If $iSamM0dDebug = 1 Then SetLog("$BottomLeft: " & $BottomLeft[$i][0] & "," & $BottomLeft[$i][1])
		If $iSamM0dDebug = 1 Then SetLog("$BottomRight: " & $BottomRight[$i][0] & "," & $BottomRight[$i][1])
	Next

	If $iSamM0dDebug = 1 Then SetLog("$aVillageResult[0]: " & $aVillageResult[0])
	If $iSamM0dDebug = 1 Then SetLog("$aVillageResult[1]: " & $aVillageResult[1])
	If $iSamM0dDebug = 1 Then SetLog("$aVillageResult[2]: " & $aVillageResult[2])
	If $iSamM0dDebug = 1 Then SetLog("$aVillageResult[3]: " & $aVillageResult[3])
	If $iSamM0dDebug = 1 Then SetLog("$aVillageResult[4]: " & $aVillageResult[4])

	Return True
EndFunc   ;==>CheckZoomOut

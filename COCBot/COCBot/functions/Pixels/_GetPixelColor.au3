
; #FUNCTION# ====================================================================================================================
; Name ..........: _GetPixelColor
; Description ...: Returns color of pixel in the coordinations
; Syntax ........: _GetPixelColor($iX, $iY[, $bNeedCapture = False])
; Parameters ....: $iX                  - x location.
;                  $iY                  - y location.
;                  $bNeedCapture        - [optional] a boolean flag to get new screen capture
;                  $sLogText            - [optional] a string value for text of log message. Default is Default.
;                  $LogTextColor        - [optional] an integer value for log text color. Default is Default.
;                  $bSilentSetLog       - [optional] a boolean value to suppress user log of text. Default is Default.
; Return values .: None
; Author ........:
; Modified ......: MonkeyHunter (08-2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func _GetPixelColor($iX, $iY, $bNeedCapture = False, $sLogText = Default, $LogTextColor = Default, $bSilentSetLog = Default)
	If $bNeedCapture = False Or $RunState = False Then
		$aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
	Else
		_CaptureRegion($iX - 1, $iY - 1, $iX + 1, $iY + 1)
		$aPixelColor = _GDIPlus_BitmapGetPixel($hBitmap, 1, 1)
	EndIf
	If $sLogText <> Default And IsString($sLogText) Then
		Local $String = $sLogText & " at X,Y: " & $iX & "," & $iY & " Found: " & Hex($aPixelColor, 6)
		SetDebugLog($String, $LogTextColor, $bSilentSetLog)
	EndIf
	Return Hex($aPixelColor, 6)
EndFunc   ;==>_GetPixelColor

Func IsPixelColorGray($sPixelColorRgbHex)
	If StringLen($sPixelColorRgbHex) <> 6 Then Return False
	Local $sRed = StringLeft($sPixelColorRgbHex, 2)
	Local $sBlue = StringRight($sPixelColorRgbHex, 2)
	Return $sRed = $sBlue And $sRed = StringMid($sPixelColorRgbHex, 3, 2)
EndFunc   ;==>IsPixelColorGray
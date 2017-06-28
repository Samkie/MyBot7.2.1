Func _debugSaveHBitmapToImage($hHBitmap, $sFilename)
	If $g_iSamM0dDebugImage = 1 Then
		If $hHBitmap <> 0 Then
			Local $EditedImage = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
			_GDIPlus_ImageSaveToFile($EditedImage, @ScriptDir & "\profiles\" & $g_sProfileCurrentName & "\SamM0d Debug\Images\" & $sFilename & ".png")
			_GDIPlus_BitmapDispose($EditedImage)
		EndIf
	EndIf
EndFunc
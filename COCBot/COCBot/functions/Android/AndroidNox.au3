; #FUNCTION# ====================================================================================================================
; Name ..........: AndroidNox
; Description ...: Nox Android functions
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Cosote (2016-02)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func OpenNox($bRestart = False)

   Local $PID, $hTimer, $iCount = 0, $process_killed, $cmdOutput, $connected_to, $cmdPar

   SetLog("Starting " & $Android & " and Clash Of Clans", $COLOR_SUCCESS)

   $launchAndroid = WinGetAndroidHandle() = 0
   If $launchAndroid Then
	  ; Launch Nox
	  $cmdPar = GetAndroidProgramParameter()
	  SetDebugLog("ShellExecute: " & $AndroidProgramPath & " " & $cmdPar)
	  $PID = ShellExecute($AndroidProgramPath, $cmdPar, $__Nox_Path)
	  If _Sleep(1000) Then Return False
	  If $PID <> 0 Then $PID = ProcessExists($PID)
	  SetDebugLog("$PID= "&$PID)
	  If $PID = 0 Then  ; IF ShellExecute failed
		SetLog("Unable to load " & $Android & ($AndroidInstance = "" ? "" : "(" & $AndroidInstance & ")") & ", please check emulator/installation.", $COLOR_ERROR)
		SetLog("Unable to continue........", $COLOR_WARNING)
		btnStop()
		SetError(1, 1, -1)
		Return False
	  EndIf
   EndIf

   SetLog("Please wait while " & $Android & " and CoC start...", $COLOR_SUCCESS)
   $hTimer = TimerInit()

   If WaitForRunningVMS($AndroidLaunchWaitSec - TimerDiff($hTimer) / 1000, $hTimer) Then Return False

   ; update ADB port, as that can changes when Nox just started...
   $InitAndroid = True
   InitAndroid()

   ; Test ADB is connected
   $connected_to = ConnectAndroidAdb(False, 60 * 1000)
   If Not $RunState Then Return False

   ; Wair for boot to finish
   If WaitForAndroidBootCompleted($AndroidLaunchWaitSec - TimerDiff($hTimer) / 1000, $hTimer) Then Return False

   If TimerDiff($hTimer) >= $AndroidLaunchWaitSec * 1000 Then ; if it took 4 minutes, Android/PC has major issue so exit
	  SetLog("Serious error has occurred, please restart PC and try again", $COLOR_ERROR)
	  SetLog($Android & " refuses to load, waited " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds for window", $COLOR_ERROR)
	  SetError(1, @extended, False)
	  Return False
   EndIf

   SetLog($Android & " Loaded, took " & Round(TimerDiff($hTimer) / 1000, 2) & " seconds to begin.", $COLOR_SUCCESS)

   Return True

EndFunc   ;==>OpenNox

Func IsNoxCommandLine($CommandLine)
   SetDebugLog($CommandLine)
   $CommandLine = StringReplace($CommandLine, GetNoxRtPath(), "")
   $CommandLine = StringReplace($CommandLine, "Nox.exe", "")
   Local $param1 = StringReplace(GetNoxProgramParameter(), """", "")
   Local $param2 = StringReplace(GetNoxProgramParameter(True), """", "")
   If StringInStr($CommandLine, $param1 & " ") > 0 Or StringRight($CommandLine, StringLen($param1)) = $param1 Then Return True
   If StringInStr($CommandLine, $param2 & " ") > 0 Or StringRight($CommandLine, StringLen($param2)) = $param2 Then Return True
   If StringInStr($CommandLine, "-clone:") = 0 And $param2 = "" Then Return True
   Return False
EndFunc

Func GetNoxProgramParameter($bAlternative = False)
   ; see http://en.bignox.com/blog/?p=354
   Local $customScreen = "-resolution:" & $AndroidClientWidth & "x" & $AndroidClientHeight & " -dpi:160"
   Local $clone = """-clone:" & ($AndroidInstance = "" ? $AndroidAppConfig[$AndroidConfig][1] : $AndroidInstance) & """"
   If $bAlternative = False Then
	  ; should be launched with these parameter
	  Return $customScreen & " " & $clone
   EndIf
   If $AndroidInstance = "" Or $AndroidInstance = $AndroidAppConfig[$AndroidConfig][1] Then Return ""
   ; default instance gets launched when no parameter was specified (this is the alternative way)
   Return $clone
EndFunc

Func GetNoxRtPath()
   Local $path = RegRead($HKLM & "\SOFTWARE\BigNox\VirtualBox\", "InstallDir")
   If @error = 0 Then
	   If StringRight($path, 1) <> "\" Then $path &= "\"
   EndIf
   If FileExists($path) = 0 Then
	  $path = @ProgramFilesDir & "\Bignox\BigNoxVM\RT\"
   EndIf
   If FileExists($path) = 0 Then
	  $path = EnvGet("ProgramFiles(x86)") & "\Bignox\BigNoxVM\RT\"
   EndIf
   SetError(0, 0, 0)
   Return StringReplace($path, "\\", "\")
EndFunc

Func GetNoxPath()
   Local $path = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\DuoDianOnline\SetupInfo\", "InstallPath")
   If @error = 0 Then
	  If StringRight($path, 1) <> "\" Then $path &= "\"
	  $path &= "bin\"
   Else
	  $path = ""
	  SetError(0, 0, 0)
   EndIf
   Return StringReplace($path, "\\", "\")
EndFunc

Func GetNoxAdbPath()
   Local $adbPath = GetNoxPath() & "nox_adb.exe"
   If FileExists($adbPath) Then Return $adbPath
   Return ""
EndFunc

Func InitNox($bCheckOnly = False)
   Local $process_killed, $aRegExResult, $AndroidAdbDeviceHost, $AndroidAdbDevicePort, $oops = 0
   Local $Version = RegRead($HKLM & "\SOFTWARE" & $Wow6432Node & "\Microsoft\Windows\CurrentVersion\Uninstall\Nox\", "DisplayVersion")
   SetError(0, 0, 0)

   Local $Path = GetNoxPath()
   Local $RtPath = GetNoxRtPath()

   Local $NoxFile = $Path & "Nox.exe"
   Local $AdbFile = $Path & "nox_adb.exe"
   Local $VBoxFile = $RtPath & "BigNoxVMMgr.exe"

   Local $Files[3] = [$NoxFile, $AdbFile, $VBoxFile]
   Local $File

   For $File in $Files
	  If FileExists($File) = False Then
		 If Not $bCheckOnly Then
			SetLog("Serious error has occurred: Cannot find " & $Android & " file:", $COLOR_ERROR)
			SetLog($File, $COLOR_ERROR)
			SetError(1, @extended, False)
		 EndIf
		 Return False
	  EndIf
   Next

   ; Read ADB host and Port
   If Not $bCheckOnly Then
	  InitAndroidConfig(True) ; Restore default config

	  $__VBoxVMinfo = LaunchConsole($VBoxFile, "showvminfo " & $AndroidInstance, $process_killed)
	  ; check if instance is known
	  If StringInStr($__VBoxVMinfo, "Could not find a registered machine named") > 0 Then
		 ; Unknown vm
		 SetLog("Cannot find " & $Android & " instance " & $AndroidInstance, $COLOR_ERROR)
		 Return False
	  EndIf
	  ; update global variables
	  $AndroidProgramPath = $NoxFile
	  $AndroidAdbPath = FindPreferredAdbPath()
	  If $AndroidAdbPath = "" Then $AndroidAdbPath = GetNoxAdbPath()
	  $AndroidVersion = $Version
	  $__Nox_Path = $Path
	  $__VBoxManage_Path = $VBoxFile
	  $aRegExResult = StringRegExp($__VBoxVMinfo, ".*host ip = ([^,]+), .* guest port = 5555", $STR_REGEXPARRAYMATCH)
	  If Not @error Then
		 $AndroidAdbDeviceHost = $aRegExResult[0]
		 If $debugSetlog = 1 Then Setlog("Func LaunchConsole: Read $AndroidAdbDeviceHost = " & $AndroidAdbDeviceHost, $COLOR_DEBUG)
	  Else
		 $oops = 1
		 SetLog("Cannot read " & $Android & "(" & $AndroidInstance & ") ADB Device Host", $COLOR_ERROR)
	  EndIF

	  $aRegExResult = StringRegExp($__VBoxVMinfo, "name = .*host port = (\d{3,5}), .* guest port = 5555", $STR_REGEXPARRAYMATCH)
	  If Not @error Then
		 $AndroidAdbDevicePort = $aRegExResult[0]
		 If $debugSetlog = 1 Then Setlog("Func LaunchConsole: Read $AndroidAdbDevicePort = " & $AndroidAdbDevicePort, $COLOR_DEBUG)
	  Else
		 $oops = 1
		 SetLog("Cannot read " & $Android & "(" & $AndroidInstance & ") ADB Device Port", $COLOR_ERROR)
	  EndIF

	  If $oops = 0 Then
		 $AndroidAdbDevice = $AndroidAdbDeviceHost & ":" & $AndroidAdbDevicePort
	  Else ; use defaults
		 SetLog("Using ADB default device " & $AndroidAdbDevice & " for " & $Android, $COLOR_ERROR)
	  EndIf

	  ;$AndroidPicturesPath = "/mnt/shell/emulated/0/Download/other/"
	  ;$AndroidPicturesPath = "/mnt/shared/Other/"
	  $AndroidPicturesPath = "(/mnt/shared/Other|/mnt/shell/emulated/0/Download/other)"
	  $aRegExResult = StringRegExp($__VBoxVMinfo, "Name: 'Other', Host path: '(.*)'.*", $STR_REGEXPARRAYGLOBALMATCH)
	  If Not @error Then
		$AndroidSharedFolderAvailable = True
		 $AndroidPicturesHostPath = $aRegExResult[UBound($aRegExResult) - 1] & "\"
	  Else
		$AndroidSharedFolderAvailable = False
		 $AndroidAdbScreencap = False
		 $AndroidPicturesHostPath = ""
		 SetLog($Android & " Background Mode is not available", $COLOR_ERROR)
	  EndIf

	  $__VBoxGuestProperties = LaunchConsole($__VBoxManage_Path, "guestproperty enumerate " & $AndroidInstance, $process_killed)

	  ; Update Android Screen and Window
	  ;UpdateNoxConfig()
   EndIf

   Return True

EndFunc

Func SetScreenNox()

   If Not InitAndroid() Then Return False

   Local $cmdOutput, $process_killed

   ; These setting don't stick, so not used and instead using paramter: http://en.bignox.com/blog/?p=354
   ; Set width and height
   ;$cmdOutput = LaunchConsole($__VBoxManage_Path, "guestproperty set " & $AndroidInstance & " vbox_graph_mode " & $AndroidClientWidth & "x" & $AndroidClientHeight & "-16", $process_killed)
   ; Set dpi
   ;$cmdOutput = LaunchConsole($__VBoxManage_Path, "guestproperty set " & $AndroidInstance & " vbox_dpi 160", $process_killed)

   AndroidPicturePathAutoConfig(@MyDocumentsDir, "\Nox_share\Other") ; ensure $AndroidPicturesHostPath is set and exists
   If $AndroidSharedFolderAvailable = False And $AndroidPicturesPathAutoConfig = True And FileExists($AndroidPicturesHostPath) = 1 Then
      ; remove tailing backslash
	  Local $path = $AndroidPicturesHostPath
	  If StringRight($path, 1) = "\" Then $path = StringLeft($path, StringLen($path) - 1)
	  $cmdOutput = LaunchConsole($__VBoxManage_Path, "sharedfolder add " & $AndroidInstance & " --name Other --hostpath """ & $path & """  --automount", $process_killed)
   EndIf

   Return True

EndFunc

Func RebootNoxSetScreen()

   Return RebootAndroidSetScreenDefault()

EndFunc

Func CloseNox()

	Return CloseVboxAndroidSvc()

EndFunc   ;==>CloseNox

Func CheckScreenNox($bSetLog = True)

   If Not InitAndroid() Then Return False

   Local $aValues[2][2] = [ _
	  ["vbox_dpi", "160"], _
	  ["vbox_graph_mode", $AndroidClientWidth & "x" & $AndroidClientHeight & "-16"] _
   ]
   Local $i, $Value, $iErrCnt = 0, $process_killed, $aRegExResult

   For $i = 0 To UBound($aValues) -1
	  $aRegExResult = StringRegExp($__VBoxGuestProperties, "Name: " & $aValues[$i][0] & ", value: (.+), timestamp:", $STR_REGEXPARRAYMATCH)
	  If @error = 0 Then $Value = $aRegExResult[0]
	  If $Value <> $aValues[$i][1] Then
		 If $iErrCnt = 0 Then
			If $bSetLog Then
			   SetLog("MyBot doesn't work with " & $Android & " screen configuration!", $COLOR_ERROR)
			Else
			   SetDebugLog("MyBot doesn't work with " & $Android & " screen configuration!", $COLOR_ERROR)
			EndIf
		 EndIf
		 If $bSetLog Then
			SetLog("Setting of " & $aValues[$i][0] & " is " & $Value & " and will be changed to " & $aValues[$i][1], $COLOR_ERROR)
		 Else
			SetDebugLog("Setting of " & $aValues[$i][0] & " is " & $Value & " and will be changed to " & $aValues[$i][1], $COLOR_ERROR)
		 EndIf
		 $iErrCnt += 1
	  EndIf
   Next

   ; check if shared folder exists
   If AndroidPicturePathAutoConfig(@MyDocumentsDir, "\Nox_share\Other", $bSetLog) Then $iErrCnt += 1

   If $iErrCnt > 0 Then Return False
   Return True

EndFunc

Func GetNoxRunningInstance($bStrictCheck = True)
   Local $a[2] = [0, ""]
   SetDebugLog("GetAndroidRunningInstance: Try to find """ & $AndroidProgramPath & """")
   For $pid In ProcessesExist($AndroidProgramPath, "", 1) ; find all process
	  Local $currentInstance = $AndroidInstance
	  ; assume last parameter is instance
	  Local $commandLine = ProcessGetCommandLine($pid)
	  SetDebugLog("GetNoxRunningInstance: Found """ & $commandLine & """ by PID=" & $pid)
	  Local $aRegExResult = StringRegExp($commandLine, ".*""-clone:([^""]+)"".*|.*-clone:([\S]+).*", $STR_REGEXPARRAYMATCH)
	  If @error = 0 Then
		 $AndroidInstance = $aRegExResult[0]
		 If $AndroidInstance = "" Then $AndroidInstance = $aRegExResult[1]
		 SetDebugLog("Running " & $Android & " instance is """ & $AndroidInstance & """")
	  EndIf
	  ; validate
	  If WinGetAndroidHandle() <> 0 Then
		 $a[0] = $HWnD
		 $a[1] = $AndroidInstance
		 Return $a
	  Else
		 $AndroidInstance = $currentInstance
	  EndIf
   Next
   Return $a
EndFunc

Func RedrawNoxWindow()
	Local $aPos = WinGetPos($HWnD)
	;_PostMessage_ClickDrag($aPos[0] + Int($aPos[2] / 2), $aPos[1] + 3, $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 53)
	;_PostMessage_ClickDrag($aPos[0] + Int($aPos[2] / 2), $aPos[1] + 53, $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 3)
	Local $aMousePos = MouseGetPos()
	MouseClickDrag("left", $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 3, $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 53, 0)
	MouseClickDrag("left", $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 53, $aPos[0] + Int($aPos[2] / 2), $aPos[1] + 3, 0)
	MouseMove($aMousePos[0], $aMousePos[1], 0)
	;WinMove2($HWnD, "", $AndroidWinPos[0], $AndroidWinPos[1], $aAndroidWindow[0], $aAndroidWindow[1])
	;ControlMove($HWnD, $AppPaneName, $AppClassInstance, 0, 0, $AndroidClientWidth, $AndroidClientHeight)
	;If _Sleep(500) Then Return False ; Just wait, not really required...
	;$new_BSsize = ControlGetPos($HWnD, $AppPaneName, $AppClassInstance)
	$aPos = WinGetPos($HWnD)
	ControlClick($HWnD, "", "", "left", 1, $aPos[2] - 46, 18)
	If _Sleep(500) Then Return False
	$aPos = WinGetPos($HWnD)
	ControlClick($HWnD, "", "", "left", 1, $aPos[2] - 46, 18)
	;If _Sleep(500) Then Return False
EndFunc

Func HideNoxWindow($bHide = True)
	Return EmbedNox($bHide)
EndFunc   ;==>HideNoxWindow

Func EmbedNox($bEmbed = Default)

	If $bEmbed = Default Then $bEmbed = $AndroidEmbedded

	; Find QTool Parent Window
	Local $aWin = _WinAPI_EnumProcessWindows(GetAndroidPid(), False)
	Local $i
	Local $hToolbar = 0

	For $i = 1 To UBound($aWin) - 1
		Local $h = $aWin[$i][0]
		Local $c = $aWin[$i][1]
		If $c = "Qt5QWindowToolSaveBits" Then
			Local $aPos = WinGetPos($h)
			If UBound($aPos) > 2 Then
				; found toolbar
				$hToolbar = $h
			EndIF
		EndIf
	Next

	If $hToolbar = 0 Then
		SetDebugLog("EmbedNox(" & $bEmbed & "): toolbar Window not found, list of windows:" & $c, Default, True)
		For $i = 1 To UBound($aWin) - 1
			Local $h = $aWin[$i][0]
			Local $c = $aWin[$i][1]
			SetDebugLog("EmbedNox(" & $bEmbed & "): Handle = " & $h & ", Class = " & $c, Default, True)
		Next
	Else
		SetDebugLog("EmbedNox(" & $bEmbed & "): $hToolbar=" & $hToolbar, Default, True)
		WinMove2($hToolbar, "", -1, -1, -1, -1, $HWND_NOTOPMOST, 0, False)
		_WinAPI_ShowWindow($hToolbar, ($bEmbed ? @SW_HIDE : @SW_SHOWNOACTIVATE))
	EndIf

EndFunc   ;==>EmbedNox

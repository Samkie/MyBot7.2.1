; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No

$hGUI_MOD = GUICreate("", $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, $_GUI_CHILD_LEFT, $_GUI_CHILD_TOP, $WS_CHILD, -1, $frmBotEx)

;GUISetBkColor($COLOR_WHITE, $hGUI_BOT)

GUISwitch($hGUI_MOD)

;========================Attack=============================
GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 20, $_GUI_MAIN_HEIGHT - 255, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
GUICtrlCreateTabItem(GetTranslated(671, 54, "Attack"))

;======================smartzap================================
Local $x = 10, $y = 30 ;Start location

$grpSmartZap = GUICtrlCreateGroup(GetTranslated(671, 1, "Zap"), $x, $y, 430, 250)
	GUICtrlCreateIcon($pIconLib, $eIcnDrill, $x + 10, $y + 20, 24, 24)
	GUICtrlCreateIcon($pIconLib, $eIcnLightSpell, $x + 10, $y + 50, 24, 24)

;$lblZapMethod = GUICtrlCreateLabel(GetTranslated(671, 2, "Zap Style: "), $x + 40, $y + 20, -1, -1)

$chkUseSamM0dZap = GUICtrlCreateCheckbox(GetTranslated(671, 2, "Use SamM0d Zap "), $x + 40, $y + 20, -1, -1)
	$txtTip = "Select this to drop lightning spells on Dark Elixir Drills with SamM0d Method." & @CRLF & @CRLF & _
	"First zap higher level drill first, then second zap the drill that get higher DE from last zap."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "cmbZapMethod")
	GUICtrlSetState(-1, $GUI_CHECKED)

$y -= 20

$lblMinDark2 = GUICtrlCreateLabel(GetTranslated(671, 3, "Min. amount of Dark Elixir:"), $x + 30, $y + 70, 160, -1, $SS_RIGHT)

$txtMinDark2 = GUICtrlCreateInput("400", $x + 195, $y + 70, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = "The value here depends a lot on what level your Town Hall is, " & @CRLF & _
			  "and what level drills you most often see."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 4)
	GUICtrlSetOnEvent(-1, "txtMinDark2")

$chkSmartZapDB2 = GUICtrlCreateCheckbox(GetTranslated(671, 4, "Only Zap Drills in Dead Bases"), $x + 40, $y + 95, -1, -1)
	$txtTip = "It is recommended you only zap drills in dead bases as most of the " & @CRLF & _
			  "Dark Elixir in a live base will be in the storage."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkSmartZapDB2")
	GUICtrlSetState(-1, $GUI_CHECKED)

$chkSmartZapSaveHeroes2 = GUICtrlCreateCheckbox(GetTranslated(671, 5, "TH snipe NoZap if Heroes Deployed"), $x + 40, $y + 120, -1, -1)
	$txtTip = "This will stop SmartZap from zapping a base on a Town Hall Snipe " & @CRLF & _
			  "if your heroes were deployed. " & @CRLF & @CRLF & _
			  "This protects their health so they will be ready for battle sooner!"
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkSmartZapSaveHeroes2")
	GUICtrlSetState(-1, $GUI_CHECKED)

$y += 20

$chkSmartZapRnd = GUICtrlCreateCheckbox(GetTranslated(671, 6, "Random Zap Drills Position"), $x + 40, $y + 145, -1, -1)
	$txtTip = "Random Drop On Drill Area, More Human Like."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkSmartZapRnd")
	GUICtrlSetState(-1, $GUI_CHECKED)

$chkDrillExistBeforeZap = GUICtrlCreateCheckbox(GetTranslated(671, 7, "Check Drill exist before do second or third zap"), $x + 40, $y + 170, -1, -1)
	$txtTip = "Prevent zap on damaged drill."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkDrillExistBeforeZap")
	GUICtrlSetState(-1, $GUI_CHECKED)

$chkPreventTripleZap = GUICtrlCreateCheckbox(GetTranslated(671, 8, "Prevent triple zap on same drill"), $x + 40, $y + 195, -1, -1)
	$txtTip = "Prevent triple zap on same drill. Normally wouldnot get much DE on third zap."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkPreventTripleZap")
	GUICtrlSetState(-1, $GUI_CHECKED)


$lblMinDEGetFromDrill = GUICtrlCreateLabel(GetTranslated(671, 9, "Min. DE from each Drill:"), $x + 30, $y + 220, 160, -1, $SS_RIGHT)

$txtMinDEGetFromDrill = GUICtrlCreateInput("120", $x + 195, $y + 220, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = "After perform zap will check how many DE gain from this drill," & @CRLF & _
			  "If the value lower than this setting, this drill will be ignore for zap again."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 4)
	GUICtrlSetOnEvent(-1, "txtMinDEGetFromDrill")


$x += 220
$y += 40

GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 160, $y, 24, 24)
$lblMySmartZap = GUICtrlCreateLabel("0", $x + 60, $y, 80, 30, $SS_RIGHT)
	GUICtrlSetFont(-1, 16, $FW_BOLD, Default, "arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, 0x279B61)
	$txtTip = "Number of dark elixir zapped during the attack with lightning."
	_GUICtrlSetTip(-1, $txtTip)

GUICtrlCreateIcon($pIconLib, $eIcnLightSpell, $x + 160, $y + 40, 24, 24)
$lblMyLightningUsed = GUICtrlCreateLabel("0", $x + 60, $y + 40, 80, 30, $SS_RIGHT)
	GUICtrlSetFont(-1, 16, $FW_BOLD, Default, "arial", $CLEARTYPE_QUALITY)
	GUICtrlSetColor(-1, 0x279B61)
	$txtTip = "Amount of used spells."
	_GUICtrlSetTip(-1, $txtTip)

GUICtrlCreateGroup("", -99, -99, 1, 1)

;===============END smartZap========================================

Local $x = 0, $y = 290

; CSV Deployment Speed Mod
$grpScriptSpeedDB = GUICtrlCreateGroup(GetTranslated(671, 55, "CSV Deployment Speed - Dead Base"), $x+10, $y, 230, 50)
$lbltxtSelectedSpeedDB = GUICtrlCreateLabel("Normal speed", $x + 20, $y+20, 75, 25)
$txtTip = GetTranslated(671, 56, "Increase or decrease the speed at which the CSV attack script deploys troops and waves.")
_GUICtrlSetTip(-1, $txtTip)
$sldSelectedSpeedDB = GUICtrlCreateSlider($x + 108, $y + 20, 125, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
_GUICtrlSetTip(-1, $txtTip)
_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
_GUICtrlSlider_SetTicFreq(-1, 1)
GUICtrlSetLimit(-1, 18, 0) ; change max/min value
GUICtrlSetData(-1, 5) ; default value
GUICtrlSetOnEvent(-1, "sldSelectedSpeedDB")
GUICtrlCreateGroup("", -99, -99, 1, 1)


		$btnAttNowDB = GUICtrlCreateButton(GetTranslated(671, 58, "Attack Now"), $x+250, $y+15, 91, 25)
				;GUISetState(@SW_SHOW)
				GUICtrlSetOnEvent(-1, "AttackNowDB")

$y += 50
; CSV Deployment Speed Mod
$grpScriptSpeedAB = GUICtrlCreateGroup(GetTranslated(671, 57, "CSV Deployment Speed - Alive Base "), $x+10, $y, 230, 50)
$lbltxtSelectedSpeedAB = GUICtrlCreateLabel("Normal speed", $x + 20, $y+20, 75, 25)
_GUICtrlSetTip(-1, $txtTip)
$sldSelectedSpeedAB = GUICtrlCreateSlider($x + 108, $y + 20, 125, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
_GUICtrlSetTip(-1, $txtTip)
_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
_GUICtrlSlider_SetTicFreq(-1, 1)
GUICtrlSetLimit(-1, 18, 0) ; change max/min value
GUICtrlSetData(-1, 5) ; default value
GUICtrlSetOnEvent(-1, "sldSelectedSpeedAB")
GUICtrlCreateGroup("", -99, -99, 1, 1)


		$btnAttNowLB = GUICtrlCreateButton(GetTranslated(671, 58, "Attack Now"), $x+250, $y+15, 91, 25)
				;GUISetState(@SW_SHOW)
				GUICtrlSetOnEvent(-1, "AttackNowLB")

GUICtrlCreateTabItem(GetTranslated(671, 112, "Attack II"))

GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 10, $y = 30

GUICtrlCreateGroup(GetTranslated(671, 107, "Deploy speed for all standard attack mode."), $x, $y, 430, 100)

$chkUnitFactor = GUICtrlCreateCheckbox(GetTranslated(671, 108, "Modify Unit Factor"), $x+10, $y + 20, 130, 25)
	$txtTip = GetTranslated(671, 109, "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkUnitFactor")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$txtUnitFactor = GUICtrlCreateInput("10", $x + 180, $y + 20, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = GetTranslated(671, 109, "Unit deploy delay = Unit setting x Unit Factor (millisecond)")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 10)
	GUICtrlSetOnEvent(-1, "chkUnitFactor")
$y += 30
$chkWaveFactor = GUICtrlCreateCheckbox(GetTranslated(671, 110, "Modify Wave Factor"), $x+10, $y + 20, 130, 25)
	$txtTip = GetTranslated(671, 111, "Switch troop delay = Wave setting x Wave Factor (millisecond)")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkWaveFactor")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$txtWaveFactor = GUICtrlCreateInput("100", $x + 180, $y + 20, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = GetTranslated(671, 111, "Switch troop delay = Wave setting x Wave Factor (millisecond)")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 100)
	GUICtrlSetOnEvent(-1, "chkWaveFactor")


GUICtrlCreateGroup("", -99, -99, 1, 1)

$y = 140
$chkDropCCFirst = GUICtrlCreateCheckbox(GetTranslated(671, 105, "Enable deploy cc troops first"), $x+10, $y, -1, -1)
	$txtTip = GetTranslated(671, 106, "Deploy cc troops first, only support for standard attack mode")
	GUICtrlSetOnEvent(-1, "chkDropCCFirst")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$y += 5

$chkDBNoLeague = GUICtrlCreateCheckbox(GetTranslated(671, 15, "No League"), $x+10, $y+20, -1, -1)
	$txtTip ="Search for a Dead bases that has no league."
	_GUICtrlSetTip(-1, $txtTip)

$chkDBMeetCollOutside = GUICtrlCreateCheckbox(GetTranslated(671, 16, "Collectors outside"), $x+10, $y+45, -1, -1)
	$txtTip = "Search for Dead bases that has their collectors outside."
	GUICtrlSetOnEvent(-1, "chkDBMeetCollOutside")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	GUICtrlCreateLabel("Min: ", $x + 120, $y +49, -1, -1)
$txtDBMinCollOutsidePercent = GUICtrlCreateInput("80", $x + 145, $y+45, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = "Set the Min. % of collectors outside to search for on a village to attack."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetData(-1, 50)
	GUICtrlCreateLabel("%", $x + 176, $y+49, -1, -1)
	_GUICtrlSetTip(-1, $txtTip)

$chkSkipCollectorCheckIF = GUICtrlCreateCheckbox(GetTranslated(671, 17, "Skip outside collectors check IF Target Resource Over"), $x+30, $y+70, -1, -1)
	$txtTip = "If you don't want compare one of the resource below, just set to 0"
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$y += 95
	$x += 30
		$lblSkipCollectorGold = GUICtrlCreateLabel(ChrW(8805), $x + 22, $y + 2, -1, -1)
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 82, $y, 16, 16)
		$txtSkipCollectorGold = GUICtrlCreateInput("400000", $x + 30, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(610,37, "Skip outside collectors check IF target Gold value over")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
	$x += 90
		$lblSkipCollectorElixir = GUICtrlCreateLabel(ChrW(8805), $x + 22, $y + 2, -1, -1)
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 82, $y, 16, 16)
		$txtSkipCollectorElixir = GUICtrlCreateInput("400000", $x + 30, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(610,38, "Skip outside collectors check IF target Elixir value over")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 7)
	$x += 90
		$lblSkipCollectorDark = GUICtrlCreateLabel(ChrW(8805), $x + 22, $y + 2, -1, -1)
		GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 82, $y, 16, 16)
		$txtSkipCollectorDark = GUICtrlCreateInput("0", $x + 30, $y, 50, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = GetTranslated(610,39, "Skip outside collectors check IF target Dark Elixir value over")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
$x = 10
$y += 25
	$chkSkipCollectorCheckIFTHLevel = GUICtrlCreateCheckbox(GetTranslated(671, 22, "Skip outside collectors check IF Target Townhall Level is lower than or equal: "), $x+30, $y, -1, -1)
	$txtTip = "Compare the level if is lower than or equal my setting, just attack!"
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$txtIFTHLevel = GUICtrlCreateCombo("", $x+30, $y+25, 100, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "7|8|9|10","7")


Local $x = 10, $y = 30

GUICtrlCreateTabItem(GetTranslated(671, 10, "Random Click"))
$grpHLFClick = GUICtrlCreateGroup(GetTranslated(671, 11, "Advanced Random Click On Button"), $x, $y, 430, 180)
	; More Human Like When Train Click By Sam
	$chkEnableHLFClick = GUICtrlCreateCheckbox(GetTranslated(671, 12, "Enable Random Click On Button Area =-= Train/Remove Troops And Etc."),$x+10, $y+20)
		$txtTip = "More human like if random click 5-10 clicks per wave at around the same pixel then delay awhile" & @CRLF & _
		   	      "Click Tempo is random -10% and + 10% between each click base on Train Click Timing" & @CRLF & _
			      "As human like, we tapping on the screen with fast tempo, we almost hit on the same pixel, just -3+3 pixels different."
		GUICtrlSetState(-1, $GUI_CHECKED)
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "chkEnableHLFClick")

	$lblHLFClickDelay = GUICtrlCreateLabel(GetTranslated(636,32, "delay"), $x+28, $y+42, 40, 30)
		$txtTip = "Delay awhile after each wave, for chance to detect is that barrack full, if not will keep click train button until loop finish, even you need create 1 unit only."
		_GUICtrlSetTip(-1, $txtTip)
	$lblHLFClickDelayTime = GUICtrlCreateLabel("400 ms", $x+28, $y+58, 40, 30)
		_GUICtrlSetTip(-1, $txtTip)
	$sldHLFClickDelayTime = GUICtrlCreateSlider($x + 73, $y+45, 90, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
		_GUICtrlSetTip(-1, "Increase the delay if your PC is slow or set the timer for your train button take how long to stop animate."  & @CRLF & "Random Delay +- 10% base on this value.")
		_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
		_GUICtrlSlider_SetTicFreq(-100, 100)
		GUICtrlSetLimit(-1, 1000, 300) ; change max/min value
		GUICtrlSetData(-1, 400) ; default value
		GUICtrlSetOnEvent(-1, "sldHLFClickDelayTime")

	$y += 80

	$lblDesc1 = GUICtrlCreateLabel("Feature: Army Train page fully random click, Surrender Button," & @CRLF & "Return Home Button, PB Page Close Button, Random Away Click," & @CRLF & "RequestCC Button, Open Profile, And Etc." , $x+28, $y)

	$y += 30
	$chkEnableHLFClickSetlog = GUICtrlCreateCheckbox(GetTranslated(671, 13, "Enable Setlog for Advanced Random Click."),$x+10, $y+20)
		$txtTip = "Attention: after enable Advanced Random Click, normal debug click only show the click that haven't process randomize."
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetState(-1, $GUI_UNCHECKED)
		GUICtrlSetOnEvent(-1, "chkEnableHLFClickSetlog")


GUICtrlCreateTabItem(GetTranslated(671, 64, "My Troops"))

Local $xStart, $yStart

$xStart = 10
$yStart = 10

Local $x = $xStart, $y = $yStart

	$chkCustomTrain = GUICtrlCreateCheckbox(GetTranslated(671, 66, "Enable Custom Train and spell"),$x+10, $y+20)
		_GUICtrlSetTip(-1, "Use Custom Train and Spell replace for official train system.")
		GUICtrlSetState(-1, $GUI_UNCHECKED)
		GUICtrlSetOnEvent(-1, "chkCustomTrain")

$lblMyQuickTrain = GUICtrlCreateLabel(GetTranslated(671, 98, "Train Combo: "), $x + 220, $y + 25, -1, -1,$SS_RIGHT)
$cmbMyQuickTrain = GUICtrlCreateCombo("", $x+300, $y+20, 130, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, GetTranslated(671, 99, "Custom Mode Only") & "|" & GetTranslated(671, 100, "Custom + Army 1") & "|" & GetTranslated(671, 101, "Custom + Army 2") & "|" & GetTranslated(671, 102, "Custom + Army 3"),GetTranslated(671, 99, "Custom Mode Only"))
		$txtTip = GetTranslated(671, 103, "Use quick train to train army, custom train setting to revamp donated troops.")
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "cmbMyQuickTrain")


Local $sComboData= ""
Local $aTroopOrderList[20] = ["","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"]
For $j = 0 To 19
	$sComboData &= $aTroopOrderList[$j] & "|"
Next


$xStart = 10
$yStart = 55

Local $x = $xStart, $y = $yStart

$grpOtherTroops = GUICtrlCreateGroup(GetTranslated(671, 64, "My Troops"), $x, $y, 430, 335)
$chkMyTroopsOrder = GUICtrlCreateCheckbox(GetTranslated(671, 67, "By Order"), $x+136, $y+15, -1, -1)
_GUICtrlSetTip(-1, GetTranslated(671, 68, "ReVamp or Train will be follow the order you had set."))
GUICtrlSetOnEvent(-1, "chkMyTroopOrder")
$cmbTroopSetting = GUICtrlCreateCombo("", $x+10, $y + 15, 124, 20, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, GetTranslated(671, 71, "Composition Army 1") & "|" & GetTranslated(671, 72, "Composition Army 2") & "|" & GetTranslated(671, 73, "Composition Army 3"), GetTranslated(671, 71, "Composition Army 1"))
	GUICtrlSetOnEvent(-1, "cmbTroopSetting")

$x += 10
$y += 40
For $i = 0 To UBound($MyTroops) - 1
	Assign("icnMy" & $MyTroops[$i][0], GUICtrlCreateIcon ($pIconLib, $MyTroopsIcon[$i], $x, $y, 23, 23))
	Assign("lblMy" & $MyTroops[$i][0], GUICtrlCreateLabel(Eval("sTxt" & StringReplace(MyNameOfTroop($i,1)," ","")), $x + 26, $y, -1, -1))
	Assign("txtMy" & $MyTroops[$i][0], GUICtrlCreateInput("0", $x + 94, $y, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER)))
		_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & Eval("sTxt" & StringReplace(MyNameOfTroop($i,1)," ","")))
		GUICtrlSetLimit(-1, 3)
		GUICtrlSetOnEvent(-1, "chkMyTroopOrder")
	Assign("cmbMy"& $MyTroops[$i][0] & "Order", GUICtrlCreateCombo("", $x+126, $y, 36, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL)))
		GUICtrlSetData(-1, $sComboData, $i + 1)
		GUICtrlSetOnEvent(-1, "chkMyTroopOrder")
	$y +=24
	If $i = 11 Then
		$x = 205
		$y = $yStart + 40
	EndIf
Next

$y = $yStart + 80
$btnResetTroops= GUICtrlCreateButton(GetTranslated(671, 74, "Reset Troops"), $x+167, $y, 40, 47,$BS_MULTILINE)
GUICtrlSetOnEvent(-1, "btnResetTroops")
$y = $yStart + 128
$btnResetOrder= GUICtrlCreateButton(GetTranslated(671, 75, "Reset Order"), $x + 167, $y, 40, 47,$BS_MULTILINE)
GUICtrlSetOnEvent(-1, "btnResetOrder")
$y = $yStart + 20
$lblTotalCapacityOfMyTroops = GUICtrlCreateLabel(GetTranslated(671, 76, "Total") & ": 0/0", $x+125, $y, 100, -1,$SS_RIGHT)
GUICtrlSetFont(-1,10,$FW_BOLD)
$idProgressbar = GUICtrlCreateProgress($x+210, $y+20,15, 165,$PBS_VERTICAL)


$y = $yStart + 220

$chkDisablePretrainTroops = GUICtrlCreateCheckbox(GetTranslated(671, 69, "Disable pre-train troops"), $x, $y, -1, -1)
_GUICtrlSetTip(-1, GetTranslated(671, 70, "Disable pre-train troops, normally use by donate and train setting together."))
GUICtrlSetOnEvent(-1, "chkDisablePretrainTroops")

$y += 25
$chkEnableDeleteExcessTroops = GUICtrlCreateCheckbox(GetTranslated(671, 62, "Enable delete excess troops"), $x, $y, -1, -1)
	$txtTip = GetTranslated(671, 63, "Check is that troops excess your custom army quantity setting, if yes then delete excess value.")
	GUICtrlSetOnEvent(-1, "chkEnableDeleteExcessTroops")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$y += 40
$lblStickToTrainWindow = GUICtrlCreateLabel(GetTranslated(671, 59, "Stick to army train page when train time left") , $x, $y)
$y += 20
$txtStickToTrainWindow = GUICtrlCreateInput("2", $x, $y-2, 30, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = GetTranslated(671, 60, "Will stick to army train page until troops train finish. (Max 5 minutes)")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 1)
	GUICtrlSetData(-1, 2)
	GUICtrlSetOnEvent(-1, "txtStickToTrainWindow")
	GUICtrlCreateLabel(GetTranslated(671, 61, "minute(s)"), $x+35, $y, -1, -1)
	_GUICtrlSetTip(-1, $txtTip)

GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateTabItem(GetTranslated(671, 65, "My Spells"))

Local $xStart, $yStart

$xStart = 10
$yStart = 55

Local $x = $xStart, $y = $yStart

	$grpSpells = GUICtrlCreateGroup(GetTranslated(671, 65, "My Spells"), $x, $y, 430, 335)
		$lblTotalSpell = GUICtrlCreateLabel(GetTranslated(622,2, "Spells Capacity"), $x+3 , $y + 24, -1, -1, $SS_RIGHT)
		$txtTotalCountSpell2 = GUICtrlCreateCombo("", $x + 125, $y+20 , 35, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(622,3, "Enter the No. of Spells Capacity. Set to ZERO if you don't want any Spells"))
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
			GUICtrlSetData(-1, "0|2|4|6|7|8|9|10|11", "0")
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$y += 55
		$lblLightningIcon = GUICtrlCreateIcon ($pIconLib, $eIcnLightSpell, $x + 10, $y, 24, 24)
		$lblLightningSpell = GUICtrlCreateLabel($sTxtLiSpell, $x + 38, $y+3, -1, -1)
		$txtNumLightningSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtLiSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesLightS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)

		$y +=25
		$lblHealIcon=GUICtrlCreateIcon ($pIconLib, $eIcnHealSpell, $x + 10, $y, 24, 24)
		$lblHealSpell = GUICtrlCreateLabel($sTxtHeSpell, $x + 38, $y+3, -1, -1)
		$txtNumHealSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHeSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesHealS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblRageIcon=GUICtrlCreateIcon ($pIconLib, $eIcnRageSpell, $x + 10, $y, 24, 24)
		$lblRageSpell = GUICtrlCreateLabel($sTxtRaSpell, $x + 38, $y+3, -1, -1)
		$txtNumRageSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtRaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesRageS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblJumpSpellIcon=GUICtrlCreateIcon ($pIconLib, $eIcnJumpSpell, $x + 10, $y, 24, 24)
		$lblJumpSpell = GUICtrlCreateLabel($sTxtJuSPell, $x + 38, $y+3, -1, -1)
		$txtNumJumpSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtJuSPell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesJumpS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblFreezeIcon=GUICtrlCreateIcon ($pIconLib, $eIcnFreezeSpell, $x + 10, $y, 24, 24)
		$lblFreezeSpell = GUICtrlCreateLabel($sTxtFrSpell, $x + 38, $y+3, -1, -1)
		$txtNumFreezeSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtFrSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblFreezeS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblCloneIcon=GUICtrlCreateIcon ($pIconLib, $eIcnCloneSpell, $x + 10, $y, 24, 24)
		$lblCloneSpell = GUICtrlCreateLabel($sTxtClSpell, $x + 38, $y+3, -1, -1)
		$txtNumCloneSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtClSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblCloneS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblPoisonIcon = GUICtrlCreateIcon ($pIconLib, $eIcnPoisonSpell, $x + 10, $y, 24, 24)
		$lblPoisonSpell = GUICtrlCreateLabel($sTxtPoSpell, $x + 38, $y+3, -1, -1)
		$txtNumPoisonSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtPoSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesPoisonS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblEarthquakeIcon = GUICtrlCreateIcon ($pIconLib, $eIcnEarthquakeSpell, $x + 10, $y, 24, 24)
		$lblEarthquakeSpell = GUICtrlCreateLabel($sTxtEaSpell, $x + 38, $y+3, -1, -1)
		$txtNumEarthSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtEaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesEarthquakeS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblHasteIcon = GUICtrlCreateIcon ($pIconLib, $eIcnHasteSpell, $x + 10, $y, 24, 24)
		$lblHasteSpell = GUICtrlCreateLabel($sTxtHaSpell, $x + 38, $y+3, -1, -1)
		$txtNumHasteSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesHasteS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)
		$y +=25
		$lblSkeletonIcon = GUICtrlCreateIcon ($pIconLib, $eIcnSkeletonSpell, $x + 10, $y, 24, 24)
		$lblSkeletonSpell = GUICtrlCreateLabel($sTxtSkSpell, $x + 38, $y+3, -1, -1)
		$txtNumSkeletonSpell = GUICtrlCreateInput("0", $x + 125, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtSkSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblMyTotalCountSpell")
		$lblTimesSkeletonS = GUICtrlCreateLabel("x", $x + 157, $y+3, -1, -1)

Local $x = $xStart + 100, $y = $yStart + 55

	For $i = 0 To UBound($MySpells) - 1
		Assign("chkPre" & $MySpells[$i][0], GUICtrlCreateCheckbox(GetTranslated(671, 77 + $i, "Pre-Brew " & $MySpells[$i][0]) , $x + 94, $y, -1, -1))
			_GUICtrlSetTip(-1, GetTranslated(671, 87 + $i, "Pre-Brew " & $MySpells[$i][0] & " after available spell prepare finish."))
		$y +=25
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)


GUICtrlCreateTabItem(GetTranslated(671, 14, "Other"))

Local $x = 10, $y = 30

$grpStatsMisc = GUICtrlCreateGroup(GetTranslated(671, 14, "Other"), $x, $y, 430, 360)

$y += 20

$chkSmartUpdateWall = GUICtrlCreateCheckbox(GetTranslated(671, 18, "Enable advanced update for wall"), $x+10, $y, -1, -1)
	$txtTip = "Save the last position, then next update will start at last position and checking around if got wall match for update."
	GUICtrlSetOnEvent(-1, "chkSmartUpdateWall")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_CHECKED)


$y += 25
GUICtrlCreateLabel(GetTranslated(671, 19, "Delay: "), $x + 30, $y, -1, -1)
$txtTip = "Set the delay between each click of wall. Increase the delay if your PC is slow."
_GUICtrlSetTip(-1, $txtTip)
$txtClickWallDelay = GUICtrlCreateInput("500", $x + 60, $y, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetData(-1, 500)

$x = 10
$y += 25
$chkEnableCustomOCR4CCRequest = GUICtrlCreateCheckbox(GetTranslated(671, 20, "Enable custom ocr image to read clan castle request."), $x+10, $y, -1, -1)
	$txtTip = "Using imgloc detect some non latin derived alphabets that normally we use for request cc."
	GUICtrlSetOnEvent(-1, "chkEnableCustomOCR4CCRequest")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$x = 10
$y += 25
$chkWait4CC = GUICtrlCreateCheckbox(GetTranslated(671, 35, "Wait CC Troops for all mode. Troops Strength:"), $x+10, $y, 240, 25)
	GUICtrlSetOnEvent(-1, "chkWait4CC")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$txtCCStrength = GUICtrlCreateInput("100", $x + 255, $y+2, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	$txtTip = "CC Troops Strength"
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 100)
	GUICtrlSetOnEvent(-1, "chkWait4CC")
	GUICtrlCreateLabel("%", $x + 286, $y+6, -1, -1)
	_GUICtrlSetTip(-1, $txtTip)

$x = 10
$y += 25
$chkCheck4CC = GUICtrlCreateCheckbox(GetTranslated(671, 51, "Custom Donate CC checking time: "), $x+10, $y, 240, 25)
	$txtTip = GetTranslated(671, 53, "When waiting for full army, use how many seconds for check the clan chat if got new message.")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkCheck4CC")
	GUICtrlSetState(-1, $GUI_UNCHECKED)


$txtCheck4CCWaitTime = GUICtrlCreateInput("7", $x + 255, $y+2, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	;$txtTip = GetTranslated(671, 53, "When waiting for full army, use how many seconds for check the clan chat if got new message.")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 2)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 7)
	GUICtrlSetOnEvent(-1, "chkCheck4CC")
	GUICtrlCreateLabel(GetTranslated(671, 52, "seconds"), $x + 286, $y+6, -1, -1)
	_GUICtrlSetTip(-1, $txtTip)

$x = 10
$y += 25
$chkIncreaseGlobalDelay = GUICtrlCreateCheckbox(GetTranslated(671, 40, "Increase global delay setting: "), $x+10, $y, 240, 25)
	$txtTip = "Increase delay for all delay setting, more stabilize for slow pc."
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkIncreaseGlobalDelay")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

$txtIncreaseGlobalDelay = GUICtrlCreateInput("10", $x + 255, $y+2, 31, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetLimit(-1, 3)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetData(-1, 10)
	GUICtrlSetOnEvent(-1, "chkIncreaseGlobalDelay")
	GUICtrlCreateLabel("%", $x + 286, $y+6, -1, -1)
	_GUICtrlSetTip(-1, $txtTip)


$x = 10
$y += 25
$chkAutoDock = GUICtrlCreateCheckbox(GetTranslated(671, 97, "Auto dock to emulator"), $x+10, $y, -1, -1)
	GUICtrlSetOnEvent(-1, "chkAutoDock")
	GUICtrlSetState(-1, $GUI_UNCHECKED)

GUICtrlCreateGroup("", -99, -99, 1, 1)



;~ $tabMyTroops = GUICtrlCreateTabItem("My Troops")
;~ Local $sComboData= ""
;~ Local $aTroopOrderList[20] = ["","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"]
;~ For $j = 0 To 19
;~ 	$sComboData &= $aTroopOrderList[$j] & "|"
;~ Next

;~ Local $x = 10, $y = 30
;~ $grpOtherTroops = GUICtrlCreateGroup("My Troops", $x, $y, 430, 360)
;~ $chkMyTroopsOrder = GUICtrlCreateCheckbox("Order", $x+135, $y+12, -1, -1)
;~ _GUICtrlSetTip(-1, "Order for ReVamp or Train.")
;~ GUICtrlSetOnEvent(-1, "$chkMyTroopsOrder")

;~ $x += 10
;~ $y += 40
;~ For $i = 0 To UBound($MyTroops) - 1
;~ 	Assign("icnMy" & $MyTroops[$i][0], GUICtrlCreateIcon ($pIconLib, $MyTroopsIcon[$i], $x, $y, 24, 24))
;~ 	Assign("lblMy" & $MyTroops[$i][0], GUICtrlCreateLabel(Eval("sTxt" & StringReplace(NameOfTroop($i,1)," ","")), $x + 26, $y, -1, -1))
;~ 	Assign("txtMy" & $MyTroops[$i][0], GUICtrlCreateInput("0", $x + 94, $y, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER)))
;~ 		_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & Eval("sTxt" & StringReplace(NameOfTroop($i,1)," ","")))
;~ 		GUICtrlSetLimit(-1, 3)
;~ 		GUICtrlSetOnEvent(-1, "chkMyTroopOrder")
;~ 	Assign("cmbMy"& $MyTroops[$i][0] & "Order", GUICtrlCreateCombo("", $x+126, $y, 40, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL)))
;~ 		GUICtrlSetData(-1, $sComboData, $i + 1)
;~ 		GUICtrlSetOnEvent(-1, "chkMyTroopOrder")
;~ 	$y +=25
;~ 	If $i = 11 Then
;~ 		$x = 230
;~ 		$y = 70
;~ 	EndIf
;~ Next
;~ $y +=25
;~ $lblTotalCapacityOfMyTroops = GUICtrlCreateLabel("Total: 0/0", $x, $y, 100, -1)
;~ $y +=25
;~ $btnResetTroops= GUICtrlCreateButton("Reset Troops", $x, $y, 91, 25)
;~ GUICtrlSetOnEvent(-1, "btnResetTroops")
;~ $btnResetOrder= GUICtrlCreateButton("Reset Order", $x + 100, $y, 91, 25)
;~ GUICtrlSetOnEvent(-1, "btnResetOrder")

;~ GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("") ; end tabitem definition









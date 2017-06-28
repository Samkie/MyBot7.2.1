Global $chkModTrain, $lblMyQuickTrain, $cmbMyQuickTrain, $grpOtherTroops, $chkMyTroopsOrder, $cmbTroopSetting, $btnResetTroops, $btnResetOrder, $lblTotalCapacityOfMyTroops, $idProgressbar, _
$chkDisablePretrainTroops, $chkEnableDeleteExcessTroops, $lblStickToTrainWindow, $txtStickToTrainWindow
Global $grpSpells,$lblTotalSpell,$txtTotalCountSpell2

Global $lblLightningIcon,$lblHealIcon,$lblRageIcon,$lblJumpSpellIcon,$lblFreezeIcon,$lblCloneIcon,$lblPoisonIcon,$lblEarthquakeIcon,$lblHasteIcon,$lblSkeletonIcon
Global $lblLightningSpell,$lblHealSpell,$lblRageSpell,$lblJumpSpell,$lblFreezeSpell,$lblCloneSpell,$lblPoisonSpell,$lblEarthquakeSpell,$lblHasteSpell,$lblSkeletonSpell
Global $txtNumLightningSpell,$txtNumHealSpell,$txtNumRageSpell,$txtNumJumpSpell,$txtNumFreezeSpell,$txtNumCloneSpell,$txtNumPoisonSpell,$txtNumEarthSpell,$txtNumHasteSpell,$txtNumSkeletonSpell
Global $lblTimesLightS, $lblTimesHealS,$lblTimesRageS,$lblTimesJumpS,$lblFreezeS,$lblCloneS,$lblTimesPoisonS,$lblTimesEarthquakeS,$lblTimesHasteS,$lblTimesSkeletonS

Global $ichkModTrain = 0
Global $g_aiTroopsMaxCamp[2] = [0,0]
Global $g_aiSpellsMaxCamp[2] = [0,0]

Global $COLOR_ELIXIR = 0xDE1AC0
Global $COLOR_DARKELIXIR = 0x301D38

Global $bTempDisAddIdleTime = False ;disable add train idle when train finish soon

Global $ichkMyTroopsOrder = 0
Global $ichkDisablePretrainTroops = 0
Global $ichkEnableDeleteExcessTroops = 0
Global $bRestartCustomTrain = False

Global $icmbTroopSetting = 0
Global $icmbMyQuickTrain = 0
Global $txtMyBarb, $txtMyArch, $txtMyGiant, $txtMyGobl, $txtMyWall, $txtMyBall, $txtMyWiza, $txtMyHeal, $txtMyDrag, $txtMyPekk, $txtMyBabyD, $txtMyMine, _
$txtMyMini, $txtMyHogs, $txtMyValk, $txtMyGole, $txtMyWitc, $txtMy, $txtMyLava, $txtMyBowl
Global $cmbMyBarbOrder, $cmbMyArchOrder, $cmbMyGiantOrder, $cmbMyGoblOrder, $cmbMyWallOrder, $cmbMyBallOrder, $cmbMyWizaOrder, $cmbMyHealOrder, $cmbMyDragOrder, $cmbMyPekkOrder, $cmbMyBabyDOrder, $cmbMyMineOrder, _
$cmbMyMiniOrder, $cmbMyHogsOrder, $cmbMyValkOrder, $cmbMyGoleOrder, $cmbMyWitcOrder, $cmbMyOrder, $cmbMyLavaOrder, $cmbMyBowlOrder

Global $CurBarb = 0, $CurArch = 0, $CurGiant = 0, $CurGobl = 0, $CurWall = 0, $CurBall = 0, $CurWiza = 0, $CurHeal = 0
Global $CurMini = 0, $CurHogs = 0, $CurValk = 0, $CurGole = 0, $CurWitc = 0, $CurLava = 0, $CurBowl = 0, $CurDrag = 0, $CurPekk = 0, $CurBabyD = 0, $CurMine = 0

Global $OnQBarb = 0, $OnQArch = 0, $OnQGiant = 0, $OnQGobl = 0, $OnQWall = 0, $OnQBall = 0, $OnQWiza = 0, $OnQHeal = 0
Global $OnQMini = 0, $OnQHogs = 0, $OnQValk = 0, $OnQGole = 0, $OnQWitc = 0, $OnQLava = 0, $OnQBowl = 0, $OnQDrag = 0, $OnQPekk = 0, $OnQBabyD = 0, $OnQMine = 0

Global $OnTBarb = 0, $OnTArch = 0, $OnTGiant = 0, $OnTGobl = 0, $OnTWall = 0, $OnTBall = 0, $OnTWiza = 0, $OnTHeal = 0
Global $OnTMini = 0, $OnTHogs = 0, $OnTValk = 0, $OnTGole = 0, $OnTWitc = 0, $OnTLava = 0, $OnTBowl = 0, $OnTDrag = 0, $OnTPekk = 0, $OnTBabyD = 0, $OnTMine = 0

Global $MyTroopsSetting[3][19][2]=[[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]]
Global $MySpellSetting[3][10][3] = [[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],[[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]]

Global $g_iMyTroopsSize = 0
Global $MyTroopsIcon[19] = [$eIcnBarbarian, $eIcnArcher, $eIcnGiant, $eIcnGoblin, $eIcnWallBreaker, $eIcnBalloon, $eIcnWizard, $eIcnHealer, $eIcnDragon, $eIcnPekka, $eIcnBabyDragon, $eIcnMiner,$eIcnMinion, $eIcnHogRider, $eIcnValkyrie, $eIcnGolem, $eIcnWitch, $eIcnLavaHound, $eIcnBowler]
Global $MyTroops[19][5] = _
[["Barb",  1,  1, 0,0], _
["Arch"	,  2,  1, 0,0], _
["Giant",  3,  5, 0,0], _
["Gobl"	,  4,  1, 0,0], _
["Wall"	,  5,  2, 0,0], _
["Ball"	,  6,  5, 0,0], _
["Wiza"	,  7,  4, 0,0], _
["Heal"	,  8, 14, 0,0], _
["Drag"	,  9, 20, 0,0], _
["Pekk"	, 10, 25, 0,0], _
["BabyD", 11, 10, 0,0], _
["Mine"	, 12,  5, 0,0], _
["Mini"	, 13,  2, 0,0], _
["Hogs"	, 14,  5, 0,0], _
["Valk"	, 15,  8, 0,0], _
["Gole"	, 16, 30, 0,0], _
["Witc"	, 17, 12, 0,0], _
["Lava"	, 18, 30, 0,0], _
["Bowl"	, 19,  6, 0,0]]
;name,order,size,unit quantity,train cost

Global $MyTroopsCost[19][9] = _
[[250,25,40,60,100,150,200,250,250], _
[500,50,80,120,200,300,400,500,500], _
[4000,250,750,1250,1750,2250,3000,3500,4000], _
[200,25,40,60,80,100,150,200,200], _
[3500,1000,1500,2000,2500,3000,3500,3500,3500], _
[5000,2000,2500,3000,3500,4000,4500,5000,5000], _
[4500,1500,2000,2500,3000,3500,4000,4500,4500], _
[10000,5000,6000,8000,10000,10000,10000,10000,10000], _
[47000,25000,29000,33000,37000,42000,47000,47000,47000], _
[45000,28000,32000,36000,40000,45000,45000,45000,45000], _
[19000,15000,16000,17000,18000,19000,19000,19000,19000], _
[6000,4200,4800,5400,6000,6000,6000,6000,6000], _
[12,6,7,8,9,10,11,12,12], _
[90,40,45,52,58,65,90,90,90], _
[190,70,100,130,160,190,190,190,190], _
[750,450,550,600,675,750,750,750,750], _
[450,250,350,450,450,450,450,450,450], _
[570,390,450,510,570,570,570,570,570], _
[170,130,150,170,170,170,170,170,170]]

Global Enum $enumLightning, $enumHeal, $enumRage, $enumJump, $enumFreeze, $enumClone, $enumPoison, $enumEarth, $enumHaste, $enumSkeleton

;Global $iLightningSpellComp = 0, $iHealSpellComp = 0, $iRageSpellComp = 0, $iJumpSpellComp = 0, $iFreezeSpellComp = 0,$iCloneSpellComp = 0, $iPoisonSpellComp = 0, $iEarthSpellComp = 0, $iHasteSpellComp = 0, $iSkeletonSpellComp = 0
Global $CurLightningSpell = 0, $CurHealSpell = 0, $CurRageSpell = 0, $CurJumpSpell = 0, $CurFreezeSpell = 0, $CurCloneSpell = 0, $CurPoisonSpell = 0, $CurHasteSpell = 0, $CurEarthSpell = 0, $CurSkeletonSpell = 0
Global $OnQLightningSpell = 0, $OnQHealSpell = 0, $OnQRageSpell = 0, $OnQJumpSpell = 0, $OnQFreezeSpell = 0, $OnQCloneSpell = 0, $OnQPoisonSpell = 0, $OnQHasteSpell = 0, $OnQEarthSpell = 0, $OnQSkeletonSpell = 0
Global $OnTLightningSpell = 0, $OnTHealSpell = 0, $OnTRageSpell = 0, $OnTJumpSpell = 0, $OnTFreezeSpell = 0, $OnTCloneSpell = 0, $OnTPoisonSpell = 0, $OnTHasteSpell = 0, $OnTEarthSpell = 0, $OnTSkeletonSpell = 0

Global $chkPreLightning, $chkPreHeal, $chkPreRage, $chkPreJump, $chkPreFreeze, $chkPreClone, $chkPrePoison, $chkPreEarth, $chkPreHaste, $chkPreSkeleton

Global $chkMySpellsOrder, $ichkMySpellsOrder
Global $chkEnableDeleteExcessSpells, $ichkEnableDeleteExcessSpells
Global $chkForcePreBrewSpell, $ichkForcePreBrewSpell
Global $cmbMyLightningOrder, $cmbMyHealOrder, $cmbMyRageOrder, $cmbMyJumpOrder, $cmbMyFreezeOrder, $cmbMyCloneOrder, $cmbMyPoisonOrder, $cmbMyEarthOrder, $cmbMyHasteOrder, $cmbMySkeletonOrder

Global $g_iMySpellsSize = 0
Global $MySpells[10][5] = _
[["Lightning",  1,  2, 0, 0], _
["Heal"	     ,  2,  2, 0, 0], _
["Rage"      ,  3,  2, 0, 0], _
["Jump"	     ,  4,  2, 0, 0], _
["Freeze"	 ,  5,  2, 0, 0], _
["Clone"	 ,  6,  4, 0, 0], _
["Poison"	 ,  7,  1, 0, 0], _
["Earth"	 ,  8,  1, 0, 0], _
["Haste"	 ,  9,  1, 0, 0], _
["Skeleton"	 , 10,  1, 0, 0]]

Global $MySpellsCost[10][8] = _
[[26000,15000,16500,18000,20000,22000,24000,26000], _
[24000,15000,16500,18000,20000,22000,24000,24000], _
[33000,23000,25000,27000,30000,33000,33000,33000], _
[31000,23000,27000,31000,31000,31000,31000,31000], _
[35000,26000,29000,31000,33000,35000,35000,35000], _
[44000,38000,40000,42000,44000,44000,44000,44000], _
[140,95,110,125,140,140,140,140], _
[180,125,140,160,180,180,180,180], _
[95,80,85,90,95,95,95,95], _
[140,110,120,130,140,140,140,140]]

;~ Global $preLightning = 0
;~ Global $preRage = 0
;~ Global $preJump = 0
;~ Global $preHeal = 0
;~ Global $preFreeze = 0
;~ Global $preClone = 0
;~ Global $prePoison = 0
;~ Global $preHaste = 0
;~ Global $preSkeleton = 0
;~ Global $preEarth = 0

;~ Global $preLightningSlot = 0
;~ Global $preRageSlot = 0
;~ Global $preJumpSlot = 0
;~ Global $preHealSlot = 0
;~ Global $preFreezeSlot = 0
;~ Global $preCloneSlot = 0
;~ Global $prePoisonSlot = 0
;~ Global $preHasteSlot = 0
;~ Global $preSkeletonSlot = 0
;~ Global $preEarthSlot = 0

;~ Global $OnBrewLightning = 0
;~ Global $OnBrewRage = 0
;~ Global $OnBrewJump = 0
;~ Global $OnBrewHeal = 0
;~ Global $OnBrewFreeze = 0
;~ Global $OnBrewClone = 0
;~ Global $OnBrewPoison = 0
;~ Global $OnBrewHaste = 0
;~ Global $OnBrewSkeleton = 0
;~ Global $OnBrewEarth = 0

;~ Global $OnBrewLightningSlot = 0
;~ Global $OnBrewRageSlot = 0
;~ Global $OnBrewJumpSlot = 0
;~ Global $OnBrewHealSlot = 0
;~ Global $OnBrewFreezeSlot = 0
;~ Global $OnBrewCloneSlot = 0
;~ Global $OnBrewPoisonSlot = 0
;~ Global $OnBrewHasteSlot = 0
;~ Global $OnBrewSkeletonSlot = 0
;~ Global $OnBrewEarthSlot = 0

Global $ichkPreLightning = 0
Global $ichkPreRage = 0
Global $ichkPreJump = 0
Global $ichkPreHeal = 0
Global $ichkPreFreeze = 0
Global $ichkPreClone = 0
Global $ichkPrePoison = 0
Global $ichkPreHaste = 0
Global $ichkPreSkeleton = 0
Global $ichkPreEarth = 0

Global $tempDisableBrewSpell = False
Global $tempDisableTrain = False
Global $g_iTotalSpellCampSpace = 0

Global $g_bRestartCheckTroop = False
Global $g_hHBitmapArmyTab
Global $g_hHBitmapArmyCap
Global $g_aiArmyCap[4] = [112,167,192,181]
Global $g_hHBitmapSpellCap
Global $g_aiSpellCap[4] = [99,314,179,328]
Global $g_hHBitmap_Av_Slot1, $g_hHBitmap_Av_Slot2, $g_hHBitmap_Av_Slot3, $g_hHBitmap_Av_Slot4, $g_hHBitmap_Av_Slot5, $g_hHBitmap_Av_Slot6, $g_hHBitmap_Av_Slot7, $g_hHBitmap_Av_Slot8, $g_hHBitmap_Av_Slot9, $g_hHBitmap_Av_Slot10, $g_hHBitmap_Av_Slot11
Global $g_hHBitmap_Av_SlotQty1, $g_hHBitmap_Av_SlotQty2, $g_hHBitmap_Av_SlotQty3, $g_hHBitmap_Av_SlotQty4, $g_hHBitmap_Av_SlotQty5, $g_hHBitmap_Av_SlotQty6, $g_hHBitmap_Av_SlotQty7, $g_hHBitmap_Av_SlotQty8, $g_hHBitmap_Av_SlotQty9, $g_hHBitmap_Av_SlotQty10, $g_hHBitmap_Av_SlotQty11
Global $g_hHBitmap_Capture_Av_Slot1, $g_hHBitmap_Capture_Av_Slot2, $g_hHBitmap_Capture_Av_Slot3, $g_hHBitmap_Capture_Av_Slot4, $g_hHBitmap_Capture_Av_Slot5, $g_hHBitmap_Capture_Av_Slot6, $g_hHBitmap_Capture_Av_Slot7, $g_hHBitmap_Capture_Av_Slot8, $g_hHBitmap_Capture_Av_Slot9, $g_hHBitmap_Capture_Av_Slot10, $g_hHBitmap_Capture_Av_Slot11
Global $g_hHBitmap_Av_Spell_Slot1, $g_hHBitmap_Av_Spell_Slot2, $g_hHBitmap_Av_Spell_Slot3, $g_hHBitmap_Av_Spell_Slot4, $g_hHBitmap_Av_Spell_Slot5, $g_hHBitmap_Av_Spell_Slot6, $g_hHBitmap_Av_Spell_Slot7
Global $g_hHBitmap_Av_Spell_SlotQty1, $g_hHBitmap_Av_Spell_SlotQty2, $g_hHBitmap_Av_Spell_SlotQty3, $g_hHBitmap_Av_Spell_SlotQty4, $g_hHBitmap_Av_Spell_SlotQty5, $g_hHBitmap_Av_Spell_SlotQty6, $g_hHBitmap_Av_Spell_SlotQty7
Global $g_hHBitmap_Capture_Av_Spell_Slot1, $g_hHBitmap_Capture_Av_Spell_Slot2, $g_hHBitmap_Capture_Av_Spell_Slot3, $g_hHBitmap_Capture_Av_Spell_Slot4, $g_hHBitmap_Capture_Av_Spell_Slot5, $g_hHBitmap_Capture_Av_Spell_Slot6, $g_hHBitmap_Capture_Av_Spell_Slot7

Global $g_hHBitmapTrainTab
Global $g_hHBitmapTrainCap
Global $g_aiTrainCap[4] = [45,161,115,174]
Global $g_hHBitmap_OT_Slot1, $g_hHBitmap_OT_Slot2, $g_hHBitmap_OT_Slot3, $g_hHBitmap_OT_Slot4, $g_hHBitmap_OT_Slot5, $g_hHBitmap_OT_Slot6, $g_hHBitmap_OT_Slot7, $g_hHBitmap_OT_Slot8, $g_hHBitmap_OT_Slot9, $g_hHBitmap_OT_Slot10, $g_hHBitmap_OT_Slot11
Global $g_hHBitmap_OT_SlotQty1, $g_hHBitmap_OT_SlotQty2, $g_hHBitmap_OT_SlotQty3, $g_hHBitmap_OT_SlotQty4, $g_hHBitmap_OT_SlotQty5, $g_hHBitmap_OT_SlotQty6, $g_hHBitmap_OT_SlotQty7, $g_hHBitmap_OT_SlotQty8, $g_hHBitmap_OT_SlotQty9, $g_hHBitmap_OT_SlotQty10, $g_hHBitmap_OT_SlotQty11
Global $g_hHBitmap_Capture_OT_Slot1, $g_hHBitmap_Capture_OT_Slot2, $g_hHBitmap_Capture_OT_Slot3, $g_hHBitmap_Capture_OT_Slot4, $g_hHBitmap_Capture_OT_Slot5, $g_hHBitmap_Capture_OT_Slot6, $g_hHBitmap_Capture_OT_Slot7, $g_hHBitmap_Capture_OT_Slot8, $g_hHBitmap_Capture_OT_Slot9, $g_hHBitmap_Capture_OT_Slot10, $g_hHBitmap_Capture_OT_Slot11
Global $g_aiArmyOnTrainSlot[4] = [65,212,838,228]
Global $g_aiArmyOnTrainSlotQty[4] = [65,192,838,207]
Global $g_aiArmyAvailableSlot[4] = [20,230,840,246]
Global $g_aiArmyAvailableSlotQty[4] = [20,198,840,213]

Global $g_hHBitmapBrewTab
Global $g_hHBitmapBrewCap
Global $g_aiBrewCap[4] = [45,161,90,174]
Global $g_hHBitmap_OB_Slot1, $g_hHBitmap_OB_Slot2, $g_hHBitmap_OB_Slot3, $g_hHBitmap_OB_Slot4, $g_hHBitmap_OB_Slot5, $g_hHBitmap_OB_Slot6, $g_hHBitmap_OB_Slot7, $g_hHBitmap_OB_Slot8, $g_hHBitmap_OB_Slot9, $g_hHBitmap_OB_Slot10, $g_hHBitmap_OB_Slot11
Global $g_hHBitmap_OB_SlotQty1, $g_hHBitmap_OB_SlotQty2, $g_hHBitmap_OB_SlotQty3, $g_hHBitmap_OB_SlotQty4, $g_hHBitmap_OB_SlotQty5, $g_hHBitmap_OB_SlotQty6, $g_hHBitmap_OB_SlotQty7, $g_hHBitmap_OB_SlotQty8, $g_hHBitmap_OB_SlotQty9, $g_hHBitmap_OB_SlotQty10, $g_hHBitmap_OB_SlotQty11
Global $g_hHBitmap_Capture_OB_Slot1, $g_hHBitmap_Capture_OB_Slot2, $g_hHBitmap_Capture_OB_Slot3, $g_hHBitmap_Capture_OB_Slot4, $g_hHBitmap_Capture_OB_Slot5, $g_hHBitmap_Capture_OB_Slot6, $g_hHBitmap_Capture_OB_Slot7, $g_hHBitmap_Capture_OB_Slot8, $g_hHBitmap_Capture_OB_Slot9, $g_hHBitmap_Capture_OB_Slot10, $g_hHBitmap_Capture_OB_Slot11
Global $g_aiArmyOnBrewSlot[4] = [65,212,838,228]
Global $g_aiArmyOnBrewSlotQty[4] = [65,191,838,206]
Global $g_aiArmyAvailableSpellSlot[4] = [20,372,840,388]
Global $g_aiArmyAvailableSpellSlotQty[4] = [20,343,840,358]


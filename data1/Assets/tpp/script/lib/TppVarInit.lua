-- TppVarInit.lua
local this={}
local i=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local i=Tpp.IsTypeNumber
local i=bit.bnot
local i,i,i=bit.band,bit.bor,bit.bxor
function this.StartTitle(i)
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  local function DoStart()
    TppSave.CopyGameDataFromSavingSlot()
    this.InitializeForNewMission{}
    gvars.elapsedTimeSinceLastPlay=TppScriptVars.GetElapsedTimeSinceLastPlay()
    gvars.elapsedTimeSinceLastUseChickCap=gvars.elapsedTimeSinceLastUseChickCap+gvars.elapsedTimeSinceLastPlay
    TppSave.VarSaveOnlyGlobalData()
  end
  gvars.ini_isTitleMode=true
  local missionIdInit=TppDefine.SYS_MISSION_ID.INIT
  if TppSave.IsGameDataLoadResultOK()then
    do
      DoStart()
    end
    if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      this.SetVarsTitleCypr()
    else
      this.SetVarsTitleHeliSpace()
    end
  else
    if gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
    end
    this.SetVarsTitleCypr()
  end
  PlayRecord.RegistPlayRecord"TPP_START_UP"
  TppSave.VarSavePersonalData()
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    TppMission.Load(vars.missionCode,missionIdInit,{showLoadingTips=false})
  else
    TppMission.RequestLoad(vars.missionCode,missionIdInit,{showLoadingTips=false})
  end
  local actMode=Fox.GetActMode()
  if(actMode=="EDIT")then
    Fox.SetActMode"GAME"
  end
end
function this.SetVarsTitleCypr()
  TppMission.VarResetOnNewMission()
  vars.locationCode=TppDefine.LOCATION_ID.CYPR
  vars.missionCode=10010
  TppPlayer.SetWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
  TppPlayer.SetItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
  gvars.title_nextLocationCode=vars.locationCode
  gvars.title_nextMissionCode=vars.missionCode
end
function this.SetVarsTitleHeliSpace()
  TppMission.VarResetOnNewMission()
  local missionCode,locationCode=TppMission.GetCurrentLocationHeliMissionAndLocationCode()
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=locationCode
  vars.missionCode=missionCode
  vars.locationCode=locationCode
  TppUiCommand.LoadoutSetForStartFromHelicopter()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
end
function this.InitializeOnStartTitle()
  this.InitializeOnStatingMainFrame()
  this.InitializeOnNewGameAtFirstTime()
  this.InitializeOnNewGame()
end
function this.ClearAllVarsAndSlot()--RETAILPATCH: 1006
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppScriptVars.InitForNewGame()
  TppGVars.AllInitialize()
  TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  local saveInfo=TppSave.GetSaveGameDataQueue(vars.missionCode)
  for k,v in ipairs(saveInfo.slot)do
    TppScriptVars.CopySlot({saveInfo.savingSlot,v},v)
  end
end--
function this.InitializeOnStatingMainFrame()
  local oneK=1024
  local saveSlotSizes={
    [TppDefine.SAVE_SLOT.GLOBAL+1]=14*oneK,
    [TppDefine.SAVE_SLOT.CHECK_POINT+1]=65*oneK,
    [TppDefine.SAVE_SLOT.RETRY+1]=11*oneK,
    [TppDefine.SAVE_SLOT.MB_MANAGEMENT+1]=80.5*oneK+2688,
    [TppDefine.SAVE_SLOT.QUEST+1]=2*oneK,
    [TppDefine.SAVE_SLOT.MISSION_START+1]=10*oneK,
    [TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE+1]=10*oneK
  }
  local compositeSlotSize={}
  local slotsTotalSize=0
  for slotIndex,size in ipairs(saveSlotSizes)do
    slotsTotalSize=slotsTotalSize+size
    compositeSlotSize[slotIndex]=size
  end
  saveSlotSizes[TppDefine.SAVE_SLOT.SAVING+1]=slotsTotalSize+92
  local configSize=1*oneK
  local platform=TppGameSequence.GetTargetPlatform()
  if((platform=="Steam"or platform=="Win32")or platform=="Win64")then
    configSize=2*oneK
  end
  saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]=configSize
  saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG_SAVE+1]=saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]
  local personalSize=3*oneK
  saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]=personalSize
  saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL_SAVE+1]=personalSize
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    local mgoSize=16*oneK
    saveSlotSizes[TppDefine.SAVE_SLOT.MGO+1]=mgoSize
    saveSlotSizes[TppDefine.SAVE_SLOT.MGO_SAVE+1]=mgoSize
  end
  Tpp.DEBUG_DumpTable(compositeSlotSize)
  Tpp.DEBUG_DumpTable(saveSlotSizes)
  TppScriptVars.CreateSaveSlot(saveSlotSizes)
  TppSave.RegistCompositSlotSize(compositeSlotSize)
  TppSave.SetUpCompositSlot()
  TppScriptVars.SetFileSizeList{
    {TppSave.GetGameSaveFileName(),saveSlotSizes[TppDefine.SAVE_SLOT.SAVING+1]},
    {TppDefine.CONFIG_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]},
    {TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]},
    {TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]},
    {"MGO_GAME_DATA",16*oneK}
  }
end
function this.InitializeOnNewGameAtFirstTime()
  vars.locationCode=TppDefine.LOCATION_ID.CYPR
  vars.missionCode=10010
end
function this.InitializeOnNewGame()
  gvars.ply_initialPlayerState=TppDefine.INITIAL_PLAYER_STATE.ON_FOOT
  gvars.ply_missionStartPoint=0
  gvars.heli_missionStartRoute=0
  gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_START
  TppPackList.SetDefaultMissionPackLabelName()
  gvars.sav_varRestoreForContinue=false
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionOpenPermission[e]=false
  end
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionOpenFlag[e]=false
  end
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionClearedFlag[e]=false
  end
  TppStory.PermitMissionOpen(10010)
  TppStory.MissionOpen(10010)
  gvars.mis_isExistOpenMissionFlag=true
  gvars.ene_isRecoverdInterpreterAfgh=false
  gvars.ene_isRecoverdInterpreterMafr=false
  gvars.dbg_autoMissionOpenClearCheck=false
  gvars.ini_isTitleMode=false
  for e=0,1024 do
    gvars.gim_missionStartBreakableObjects[e]=0
    gvars.gim_checkPointBreakableObjects[e]=0
    gvars.gim_missionStartFultonableObjects[e]=0
    gvars.gim_checkPointStartFultonableObjects[e]=0
  end
  for e=0,511 do
    gvars.gim_brekableLightStatus[e]=false
  end
  for e=0,1999 do
    gvars.col_daimondStatus_afgh[e]=0
    gvars.col_daimondStatus_mafr[e]=0
    gvars.col_isRegisteredInDb_afgh[e]=false
    gvars.col_isRegisteredInDb_mafr[e]=false
  end
  for e=0,32 do
    gvars.col_markerStatus_afgh[e]=0
    gvars.col_markerStatus_mafr[e]=0
  end
  local startTapes={"tp_bgm_10_01","tp_bgm_10_02","tp_bgm_10_03","tp_bgm_10_04","tp_bgm_10_05","tp_bgm_10_06","tp_bgm_10_07"}
  for i,trackName in ipairs(startTapes)do
    TppMotherBaseManagement.AddCassetteTapeTrack(trackName)
  end
  TppMotherBaseManagement.DirectAddResource{resource="Plant2005",count=20,isNew=true}
  gvars.solface_groupNumber=(math.random(0,255)*65536)+math.random(1,255)
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
  local initWeaponsTable,initPlayerItems
  do
    initWeaponsTable={
      {slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,equip=TppEquip.EQP_None},
      {slot=TppDefine.WEAPONSLOT.SECONDARY,equip=TppEquip.EQP_None},
      {slot=TppDefine.WEAPONSLOT.SUPPORT_0,equip=TppEquip.EQP_None},
      {slot=TppDefine.WEAPONSLOT.SUPPORT_1,equip=TppEquip.EQP_None}
    }
    initPlayerItems={TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None}
  end
  this.SetInitPlayerWeapons(initWeaponsTable)
  TppPlayer.SupplyAllAmmoFullOnMissionFinalize()
  this.SetInitPlayerItems(initPlayerItems)
  this.InitializeAllPlatformForNewGame()
end
function this.InitializeForNewMission(missionTable)
  TppSave.VarRestoreOnMissionStart()
  TppStory.DisableMissionNewOpenFlag(vars.missionCode)
  TppClock.RestoreMissionStartClock()
  if missionTable.sequence and missionTable.sequence.MISSION_START_INITIAL_WEATHER then
    TppWeather.SetMissionStartWeather(missionTable.sequence.MISSION_START_INITIAL_WEATHER)
  end
  TppWeather.RestoreMissionStartWeather()
  TppPlayer.SetInitialPlayerState(missionTable)
  TppPlayer.ResetDisableAction()
  TppEnemy.RestoreOnMissionStart()
  if missionTable.sequence then
    TppPlayer.InitItemStockCount()
  end
  Player.ResetVarsOnMissionStart()
  TppPlayer.SetSelfSubsistenceOnHardMission()
  TppPlayer.RestoreChimeraWeaponParameter()
  if missionTable.sequence and IsTable(missionTable.sequence.playerInitialWeaponTable)then
    TppPlayer.SetInitWeapons(missionTable.sequence.playerInitialWeaponTable)
  end
  TppPlayer.RestorePlayerWeaponsOnMissionStart()
  TppPlayer.SetMissionStartAmmoCount()
  if missionTable.sequence and IsTable(missionTable.sequence.playerInitialItemTable)then
    TppPlayer.SetInitItems(missionTable.sequence.playerInitialItemTable)
  end
  TppPlayer.RestorePlayerItemsOnMissionStart()
  TppUI.OnMissionStart()
  local e=TppMission.SetMissionOrderBoxPosition()
  if not e then
    if TppMission.IsFreeMission(vars.missionCode)then
      TppPlayer.SetMissionStartPositionFromNoOrderBoxPosition()
    end
  end
  TppPlayer.SetInitialPositionFromMissionStartPosition()
  TppMotherBaseManagement.ClearAllStaffBonusPopupFlag()
  TppBuddyService.ResetVarsMissionStart()
  if not gvars.ini_isTitleMode then
    Vehicle.LoadCarry()
  end
  Gimmick.RestoreSaveDataPermanentGimmickFromMission()
  TppMotherBaseManagement.SetupAfterRestoreFromSVars()
  RecordRanking.WriteServerRankingScore()--RETAILPATCH 1070: Added
  --RETAILPATCH 1090>
  if not gvars.ini_isTitleMode then
    this.InitializeOnlineChallengeTaskVarsForNewMission()
  end
  --<
end
--RETAILPATCH 1090>
function this.InitializeOnlineChallengeTaskVarsForNewMission()
  if Tpp.IsOnlineMode()and(not Tpp.IsValidLocalOnlineChallengeTaskVersion())then
    gvars.localOnlineChallengeTaskVersion=TppNetworkUtil.GetOnlineChallengeTaskVersion()
    this.InitializeOnlineChallengeTaskLocalCompletedVars()
  end
end
function this.InitializeOnlineChallengeTaskLocalCompletedVars()
  for e=0,23 do
    TppChallengeTask.SetFlagCompletedOnlineTask(e,false)
  end
end
--<
function this.InitializeForContinue(e)
  TppSave.VarRestoreOnContinueFromCheckPoint()
  TppEnemy.RestoreOnContinueFromCheckPoint()
  if not TppMission.IsFOBMission(vars.missionCode)then
    Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint()
  end
  TppMotherBaseManagement.SetupAfterRestoreFromSVars()
  vars.requestFlagsAboutEquip=255
  if svars.chickCapEnabled then
    gvars.elapsedTimeSinceLastUseChickCap=0
  end
  if e.sequence and e.sequence.ALWAYS_APPLY_TEMPORATY_PLAYER_PARTS_SETTING then
    TppPlayer.MissionStartPlayerTypeSetting()
  end
  if gvars.isContinueFromTitle then
    TppMission.IncrementRetryCount()
    TppSave.VarSaveOnRetry()
  end
end
function this.ClearIsContinueFromTitle()
  gvars.isContinueFromTitle=false
end
function this.StartInitMission()
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppMission.VarResetOnNewMission()
  TppPlayer.ResetInitialPosition()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  TppSave.VarSave(nil,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  TppMission.Load(vars.locationCode,nil,{force=true,showLoadingTips=false})
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"
  end
end
function this.SetInitPlayerWeapons(initWeaponsTable)
  for n,info in pairs(initWeaponsTable)do
    local ammo=info.ammo
    local slot=info.slot
    local equip=info.equip
    local ammoMax=info.ammoMax
    local bulletId=info.bulletId
    if slot>=TppDefine.WEAPONSLOT.SUPPORT_0 and slot<=TppDefine.WEAPONSLOT.SUPPORT_3 then
      local n=slot-TppDefine.WEAPONSLOT.SUPPORT_0
      vars.initSupportWeapons[n]=equip
      vars.ammoStockIds[slot]=bulletId
      vars.ammoStockCounts[slot]=ammo
    else
      vars.initWeapons[slot]=equip
      vars.ammoStockIds[slot]=bulletId
      vars.ammoStockCounts[slot]=ammo
      vars.ammoInWeapons[slot]=ammoMax
      vars.isInitialWeapon[slot]=1
    end
  end
end
function this.SetInitPlayerItems(e)
  for e,i in pairs(e)do
    vars.initItems[e-1]=i
    vars.items[e-1]=i
  end
end
function this.DEBUG_GetDefaultPlayerWeaponAndItemTable()
  return{{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,equip=TppEquip.EQP_WP_30101,bulletId=TppEquip.BL_Rf556x45mm,ammoMax=30,ammo=240},{slot=TppDefine.WEAPONSLOT.SECONDARY,equip=TppEquip.EQP_WP_10101,bulletId=TppEquip.BL_HgTranq,ammoMax=7,ammo=21},{slot=TppDefine.WEAPONSLOT.SUPPORT_0,equip=TppEquip.EQP_SWP_Grenade,bulletId=TppEquip.BL_SWP_Grenade,ammoMax=8,ammo=8},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,equip=TppEquip.EQP_SWP_Magazine,bulletId=TppEquip.BL_SWP_Magazine,ammoMax=-1,ammo=-1}},{TppEquip.EQP_None,TppEquip.EQP_IT_Nvg,TppEquip.EQP_IT_TimeCigarette,TppEquip.EQP_IT_CBox}
end
function this.InitializeAllPlatformForNewGame()
  local grade=0
  local commandStartGrade=1
  local categories={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
  local baseTypes={"MotherBase","Fob1","Fob2","Fob3","Fob4"}
  for i,base in ipairs(baseTypes)do
    for j,category in ipairs(categories)do
      TppMotherBaseManagement.SetClusterSvars{base=base,category=category,grade=grade,buildStatus="Completed",timeMinute=0,isNew=false}
    end
  end
  TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Command",grade=commandStartGrade,buildStatus="Completed",timeMinute=0,isNew=true}
end
function this.SetHorseObtainedAndCanSortie()
  TppBuddyService.SetObtainedBuddyType(BuddyType.HORSE)
  TppBuddyService.SetSortieBuddyType(BuddyType.HORSE)
end
return this

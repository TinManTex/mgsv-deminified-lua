-- DOBUILD: 1
local this={}
local ApendArray=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
local UpdateScriptsInScriptBlocks=ScriptBlock.UpdateScriptsInScriptBlocks
local GetCurrentMessageResendCount=Mission.GetCurrentMessageResendCount
local updateList={}
local numUpdate=0
local onUpdateList={}--NMC: from mission scripts, sequences use this, RESEARCH but does this also grab OnUpdate in mission_main.lua?
local numOnUpdate=0
--ORPHAN local RENAMEsomeupdatetable2={}
--ORPHAN local RENAMEsomeupdate2=0
local n={}
local n=0
local onMessageTable={}
local P={}
local onMessageTableSize=0
local messageExecTable={}
local h={}
local messageExecTableSize=0
local function RENAMEwhatisquarksystem()--NMC: cant actually see this referenced anywhere
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()
    coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function this.DisableGameStatus()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}
end
function this.DisableGameStatusOnGameOverMenu()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}
end
function this.EnableGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableGameStatusForDemo()
  TppDemo.ReserveEnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableAllGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}
end
function this.EnablePlayerPad()
  TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.DisablePlayerPad()
  TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.EnablePause()
  TppPause.RegisterPause"TppMain.lua"
end
function this.DisablePause()
  TppPause.UnregisterPause"TppMain.lua"
end
function this.EnableBlackLoading(e)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if e then
    TppUI.StartLoadingTips()
  end
end
function this.DisableBlackLoading()
  TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")
  TppUI.FinishLoadingTips()
end
function this.OnAllocate(missionTable)--NMC: via mission_main.lua, is called in order laid out, OnAllocate is before OnInitialize
  --InfMenu.DebugPrint(Time.GetRawElapsedTimeSinceStartUp().." Onallocate begin")
  --SplashScreen.Show(SplashScreen.Create("dbeinak","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.1,0)--tex dog--tex ghetto as 'does it run?' indicator DEBUG 
  InfMain.OnAllocateTop(missionTable)--tex
  TppWeather.OnEndMissionPrepareFunction()
  this.DisableGameStatus()
  this.EnablePause()
  TppClock.Stop()
  updateList={}
  numUpdate=0
  --ORPHAN: RENAMEsomeupdatetable2={}
  --ORPHAN: RENAMEsomeupdate2=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFOBMissionFlag()
    TppGameStatus.Set("Mission","S_IS_ONLINE")
  else
    TppGameStatus.Reset("Mission","S_IS_ONLINE")
  end
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(missionTable)
  TppClock.OnAllocate(missionTable)
  TppTrap.OnAllocate(missionTable)
  TppCheckPoint.OnAllocate(missionTable)
  TppUI.OnAllocate(missionTable)
  TppDemo.OnAllocate(missionTable)
  TppScriptBlock.OnAllocate(missionTable)
  TppSound.OnAllocate(missionTable)
  TppPlayer.OnAllocate(missionTable)
  TppMission.OnAllocate(missionTable)
  TppTerminal.OnAllocate(missionTable)
  TppEnemy.OnAllocate(missionTable)
  TppRadio.OnAllocate(missionTable)
  TppGimmick.OnAllocate(missionTable)
  TppMarker.OnAllocate(missionTable)
  TppRevenge.OnAllocate(missionTable)
  this.ClearStageBlockMessage()
  TppQuest.OnAllocate(missionTable)
  TppAnimal.OnAllocate(missionTable)
  InfMain.OnAllocate(missionTable)--tex
  local function locationOnAllocate()
    if TppLocation.IsAfghan()then
      if afgh then
        afgh.OnAllocate()
      end
    elseif TppLocation.IsMiddleAfrica()then
      if mafr then
        mafr.OnAllocate()
      end
    elseif TppLocation.IsCyprus()then
      if cypr then
        cypr.OnAllocate()
      end
    elseif TppLocation.IsMotherBase()then
      if mtbs then
        mtbs.OnAllocate()
      end
    end
  end
  locationOnAllocate()
  if missionTable.sequence then
    if f30050_sequence then--
      function f30050_sequence.NeedPlayQuietWishGoMission()--RETAILPATCH: 1.0.4.1 PATCHUP: in general I understand the need for patch ups, and in cases like this i even admire the method, however the implementation of just shoving them seemingly anywhere... needs better execution.
        local isClearedSideOps=TppQuest.IsCleard"mtbs_q99011"
        local isNotPlayDemo=not TppDemo.IsPlayedMBEventDemo"QuietWishGoMission"
        local isCanArrival=TppDemo.GetMBDemoName()==nil
        return(isClearedSideOps and isNotPlayDemo)and isCanArrival
      end
    end
    if IsTypeFunc(missionTable.sequence.MissionPrepare)then
      missionTable.sequence.MissionPrepare()
    end
    if IsTypeFunc(missionTable.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(missionTable.sequence.OnEndMissionPrepareSequence)
    end
  end
  InfMain.MissionPrepare()--tex
  for n,missionScript in pairs(missionTable)do
    if IsTypeFunc(missionScript.OnLoad)then
      missionScript.OnLoad()
    end
  end
  do
    local allSvars={}
    this.allSvars=allSvars--tex DEBUGNOW see Ivars debug thingamy
    for t,lib in ipairs(Tpp._requireList)do
      if _G[lib]then
        if _G[lib].DeclareSVars then
          ApendArray(allSvars,_G[lib].DeclareSVars(missionTable))
        end
      end
    end
    local missionSvars={}
    for n,e in pairs(missionTable)do
      if IsTypeFunc(e.DeclareSVars)then
        ApendArray(missionSvars,e.DeclareSVars())
      end
      if IsTypeTable(e.saveVarsList)then
        ApendArray(missionSvars,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    ApendArray(allSvars,missionSvars)
    TppScriptVars.DeclareSVars(allSvars)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while IsSavingOrLoading()do
      coroutine.yield()
    end
    TppRadioCommand.SetScriptDeclVars()
    local layoutCode=vars.mbLayoutCode
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(missionTable)
        TppPlayer.MissionStartPlayerTypeSetting()
        if not TppMission.IsFOBMission(vars.missionCode)then
          TppSave.VarSave(vars.missionCode,true)
        end
      else
        TppVarInit.InitializeForContinue(missionTable)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    TppUiCommand.ExcludeNonPermissionContents()--RETAILPATCH: 1.0.4.1 --tex trying to lock down dlc mods?
    TppStory.SetMissionClearedS10030()
    if(not TppMission.IsDefiniteMissionClear())then--RETAILPATCH: 1060 check added
      TppTerminal.StartSyncMbManagementOnMissionStart()
    end
    if TppLocation.IsMotherBase()then
      if layoutCode~=vars.mbLayoutCode then
        if vars.missionCode==30050 then
          vars.mbLayoutCode=layoutCode
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    TppPlayer.FailSafeInitialPositionForFreePlay()--RETAILPATCH: 1060
    this.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    if vars.missionCode~=10260 then--RETAILPATCH 1070 wrapped in check NMC why didnt you add this to the function itself konami?
      TppMission.ResetQuietEquipIfUndevelop()--RETAILPATCH: 1060
    end
    TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}
    if missionTable.sequence then
      local dbt=missionTable.sequence.DISABLE_BUDDY_TYPE
      if TppMission.IsMbFreeMissions(vars.missionCode) and Ivars.mbEnableBuddies:Is(1) then--tex no DISABLE_BUDDY_TYPE
        dbt=nil
      end--
      if dbt ~= nil then
        local disableBuddyType
        if IsTypeTable(dbt)then
          disableBuddyType=dbt
        else
          disableBuddyType={dbt}
        end
        for n,buddyType in ipairs(disableBuddyType)do
          TppBuddyService.SetDisableBuddyType(buddyType)
        end
      end
    end
    --if(vars.missionCode==11043)or(vars.missionCode==11044)then--tex ORIG: changed to issubs check, more robust even without my mod
    if TppMission.IsActualSubsistenceMission() or Ivars.disableBuddies:Is(1) then--tex disablebuddy, was just IsSubsistenceMission
      TppBuddyService.SetDisableAllBuddy()
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if missionTable.sequence and missionTable.sequence.OnBuddyBlockLoad then
        missionTable.sequence.OnBuddyBlockLoad()
      end
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  InfSoldierParams.SoldierParametersMod()--tex
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(missionTable.enemy.soldierPowerSettings)
    end
  end
  TppRevenge.DecideRevenge(missionTable)
  if TppEquip.CreateEquipMissionBlockGroup then
    if(vars.missionCode>6e4)then--NMC the e3/tradeshow demos I think
      TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}--=9338880 -- nearly 5x the max retail block size
    else
      --TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*32}--DEBUG TEST
      TppPlayer.SetEquipMissionBlockGroupSize()--TppDefine.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE = 1677721, sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE= max 1887437 (s10054)
    end
  end
  if TppEquip.CreateEquipGhostBlockGroups then
    if TppSystemUtility.GetCurrentGameMode()=="MGO"then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=16}
    elseif TppMission.IsFOBMission(vars.missionCode) then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=1}
    end
  end
  TppEquip.StartLoadingToEquipMissionBlock()
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if missionTable.sequence then
    mvars.mis_baseList=missionTable.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(missionTable.sequence.checkPointList)
  end
  --InfMenu.DebugPrint(Time.GetRawElapsedTimeSinceStartUp().." Onallocate end")--DEBUG
  --SplashScreen.Show(SplashScreen.Create("dbeinak","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.1,0)--tex dog--tex ghetto as 'does it run?' indicator
end
function this.OnInitialize(missionTable)--NMC: see onallocate for notes
  --InfMenu.DebugPrint(Time.GetRawElapsedTimeSinceStartUp().." Oninitialize begin")--DEBUG
  --SplashScreen.Show(SplashScreen.Create("dbbinin","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640))--tex eagle--tex ghetto as 'does it run?' indicator
  InfMain.OnInitializeTop(missionTable)--tex
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFobPlayerStartPoint()
  elseif TppMission.IsNeedSetMissionStartPositionToClusterPosition()then
    TppMission.SetMissionStartPositionMtbsClusterPosition()
    this.StageBlockCurrentPosition(true)
  else
    TppCheckPoint.SetCheckPointPosition()
  end
  if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  TppAnimalBlock.InitializeBlockStatus()
  if TppQuestList then
    TppQuest.RegisterQuestList(TppQuestList.questList)
    TppQuest.RegisterQuestPackList(TppQuestList.questPackList)
  end
  TppHelicopter.AdjustBuddyDropPoint()
  if missionTable.sequence then
    local settings=missionTable.sequence.NPC_ENTRY_POINT_SETTING
    if IsTypeTable(settings)then
      TppEnemy.NPCEntryPointSetting(settings)
    end
  end
  TppLandingZone.OverwriteBuddyVehiclePosForALZ()
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if IsTypeFunc(missionTable.enemy.SpawnVehicleOnInitialize)then
      missionTable.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for name,entry in pairs(missionTable)do
    if IsTypeFunc(entry.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(entry.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  TppLandingZone.OnInitialize()
  for t,lib in ipairs(Tpp._requireList)do
    if _G[lib].Init then
      _G[lib].Init(missionTable)
    end
  end
  if missionTable.enemy then
    if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
      GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
    end
    if IsTypeTable(missionTable.enemy.soldierDefine)then
      TppEnemy.DefineSoldiers(missionTable.enemy.soldierDefine)
    end
    if missionTable.enemy.InitEnemy and IsTypeFunc(missionTable.enemy.InitEnemy)then
      missionTable.enemy.InitEnemy()
    end
    if IsTypeTable(missionTable.enemy.soldierPersonalAbilitySettings)then
      TppEnemy.SetUpPersonalAbilitySettings(missionTable.enemy.soldierPersonalAbilitySettings)
    end
    if IsTypeTable(missionTable.enemy.travelPlans)then
      TppEnemy.SetTravelPlans(missionTable.enemy.travelPlans)
    end
    TppEnemy.SetUpSoldiers()
    if IsTypeTable(missionTable.enemy.soldierDefine)then
      TppEnemy.InitCpGroups()
      TppEnemy.RegistCpGroups(missionTable.enemy.cpGroups)
      TppEnemy.SetCpGroups()
      if mvars.loc_locationGimmickCpConnectTable then
        TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)
      end
    end
    if IsTypeTable(missionTable.enemy.interrogation)then
      TppInterrogation.InitInterrogation(missionTable.enemy.interrogation)
    end
    if IsTypeTable(missionTable.enemy.useGeneInter)then
      TppInterrogation.AddGeneInter(missionTable.enemy.useGeneInter)
    end
    if IsTypeTable(missionTable.enemy.uniqueInterrogation)then
      TppInterrogation.InitUniqueInterrogation(missionTable.enemy.uniqueInterrogation)
    end
    do
      local routeSets
      if IsTypeTable(missionTable.enemy.routeSets)then
        routeSets=missionTable.enemy.routeSets
        for cpName,n in pairs(routeSets)do
          if not IsTypeTable(mvars.ene_soldierDefine[cpName])then
          end
        end
      end
      if routeSets then
        TppEnemy.RegisterRouteSet(routeSets)
        TppEnemy.MakeShiftChangeTable()
        TppEnemy.SetUpCommandPost()
        TppEnemy.SetUpSwitchRouteFunc()
      end
    end
    if missionTable.enemy.soldierSubTypes then
      TppEnemy.SetUpSoldierSubTypes(missionTable.enemy.soldierSubTypes)
    end
    TppRevenge.SetUpEnemy()
    TppEnemy.ApplyPowerSettingsOnInitialize()
    TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()
    TppEnemy.SetOccasionalChatList()
    TppEneFova.ApplyUniqueSetting()
    if missionTable.enemy.SetUpEnemy and IsTypeFunc(missionTable.enemy.SetUpEnemy)then
      missionTable.enemy.SetUpEnemy()
    end
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  TppPlayer.RestoreSupplyCbox()
  TppPlayer.RestoreSupportAttack()
  TppTerminal.MakeMessage()
  if missionTable.sequence then
    local SetUpRoutes=missionTable.sequence.SetUpRoutes
    if SetUpRoutes and IsTypeFunc(SetUpRoutes)then
      SetUpRoutes()
    end
    TppEnemy.RegisterRouteAnimation()
    local SetUpLocation=missionTable.sequence.SetUpLocation
    if SetUpLocation and IsTypeFunc(SetUpLocation)then
      SetUpLocation()
    end
  end
  for n,module in pairs(missionTable)do
    if module.OnRestoreSVars then
      module.OnRestoreSVars()
    end
  end
  TppMission.RestoreShowMissionObjective()
  TppRevenge.SetUpRevengeMine()
  if TppPickable.StartToCreateFromLocators then
    TppPickable.StartToCreateFromLocators()
  end
  if TppPlaced and TppPlaced.StartToCreateFromLocators then
    TppPlaced.StartToCreateFromLocators()
  end
  if TppMission.IsMissionStart()then
    TppRadioCommand.RestoreRadioState()
  else
    TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()
  end
  TppMission.SetPlayRecordClearInfo()--RETAILPATCH 1070
  TppChallengeTask.RequestUpdateAllChecker()--RETAILPATCH 1070
  TppMission.PostMissionOrderBoxPositionToBuddyDog()
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
  TppQuest.UpdateActiveQuest()
  TppDevelopFile.OnMissionCanStart()
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    if TppQuest.IsActiveQuestHeli()then
      TppEnemy.ReserveQuestHeli()
    end
  end
  TppDemo.UpdateNuclearAbolitionFlag()
  TppQuest.AcquireKeyItemOnMissionStart()
  --InfMenu.DebugPrint(Time.GetRawElapsedTimeSinceStartUp().." Oninitialize end")--DEBUG
  --SplashScreen.Show(SplashScreen.Create("dbeonin","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640),0,0.1,0)--tex eagle--tex ghetto as 'does it run?' indicator
end
function this.SetUpdateFunction(missionTable)
  updateList={}
  numUpdate=0
  onUpdateList={}
  numOnUpdate=0
  --ORPHANL RENAMEsomeupdatetable2={}
  --ORPHAN: RENAMEsomeupdate2=0
  updateList={
    TppMission.Update,
    TppSequence.Update,
    TppSave.Update,
    TppDemo.Update,
    TppPlayer.Update,
    TppMission.UpdateForMissionLoad,
    InfMain.Update,--tex
  }
  numUpdate=#updateList
  for n,e in pairs(missionTable)do
    if IsTypeFunc(e.OnUpdate)then
      numOnUpdate=numOnUpdate+1
      onUpdateList[numOnUpdate]=e.OnUpdate
    end
  end
end
function this.OnEnterMissionPrepare()
  if TppMission.IsMissionStart()then
    TppScriptBlock.PreloadSettingOnMissionStart()
  end
  TppScriptBlock.ReloadScriptBlock()
end
function this.OnTextureLoadingWaitStart()
  if not TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  gvars.canExceptionHandling=true
end
function this.OnMissionStartSaving()
end
function this.OnMissionCanStart()
  if TppMission.IsMissionStart()then
    TppWeather.SetDefaultWeatherProbabilities()
    TppWeather.SetDefaultWeatherDurations()
    if(not gvars.ini_isTitleMode)and(not TppMission.IsFOBMission(vars.missionCode))then
      TppSave.VarSave(nil,true)
    end
  end
  TppLocation.ActivateBlock()
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  TppMission.OnMissionStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  TppLandingZone.OnMissionCanStart()
  TppOutOfMissionRangeEffect.Disable(0)
  if TppLocation.IsMiddleAfrica()then
    TppGimmick.MafrRiverPrimSetting()
  end
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  if vars.missionCode==10240 and TppLocation.IsMBQF()then--PATCHUP:
    Player.AttachGasMask()
  end
  if(vars.missionCode==10150)then--PATCHUP:
    local e=TppSequence.GetMissionStartSequenceIndex()
    if(e~=nil)and(e<TppSequence.GetSequenceIndex"Seq_Game_SkullFaceToPlant")then
      if(svars.mis_objectiveEnable[17]==false)then
        Gimmick.ForceResetOfRadioCassetteWithCassette()
      end
    end
  end
end
function this.OnMissionGameStart(n)
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"
    end
  TppQuest.InitializeQuestActiveStatus()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    this.EnableGameStatusForDemo()
  else
    this.EnableGameStatus()
  end
  if Player.RequestChickenHeadSound~=nil then
    Player.RequestChickenHeadSound()
  end
  TppTerminal.OnMissionGameStart()
  if TppSequence.IsLandContinue()then
    TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  end
  TppSoundDaemon.ResetMute"Telop"
end
function this.ClearStageBlockMessage()
StageBlock.ClearLargeBlockNameForMessage()
StageBlock.ClearSmallBlockIndexForMessage()
end
function this.ReservePlayerLoadingPosition(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  this.DisableGameStatus()
  if missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if nextIsHeliSpace then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif isHeliSpace then
      local isGroundStart=false--tex
      if gvars.heli_missionStartRoute~=0 then
        local groundStart=InfLZ.groundStartPositions[gvars.heli_missionStartRoute]--tex startOnFoot>
        local rotY=0
        local isMbFree=TppMission.IsMbFreeMissions(vars.missionCode) and (nextIsFreeMission or isFreeMission)
        if Ivars.startOnFoot:Is(1) and (groundStart~=nil or isMbFree) then
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
          --TppHelicopter.ResetMissionStartHelicopterRoute()
          if groundStart~=nil then
            isGroundStart=true
            rotY=groundStart.rotY or 0--tex TODO: RETRY: fill out, or tocenter or to closest 
            mvars.mis_helicopterMissionStartPosition=groundStart.pos
          end
        else--not ground start --tex <startOnFoot
          TppPlayer.SetStartStatusRideOnHelicopter()
        end
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,rotY)--tex added rotY was 0
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,rotY)
        end      
      else--heli_missionStartRoute~=0
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        local noHeliMissionStartPos=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if noHeliMissionStartPos then
          TppPlayer.SetInitialPosition(noHeliMissionStartPos,0)
          TppPlayer.SetMissionStartPosition(noHeliMissionStartPos,0)
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
        end
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
      if isGroundStart then--tex 10054,11054 mission timer fix, but doing all to be safe
        TppMission.ResetIsStartFromHelispace()
        TppMission.SetIsStartFromFreePlay()
      end--<
    elseif nextIsFreeMission then
      if TppLocation.IsMotherBase()then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
      TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
    elseif(isFreeMission and TppLocation.IsMotherBase())then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    else
      if isFreeMission then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
          TppPlayer.ResetNoOrderBoxMissionStartPosition()
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
          local noBoxMissionStartPos={
          [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
          [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
          [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
          [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
          [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
          [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
          [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
          }
          noBoxMissionStartPos[11050]=noBoxMissionStartPos[10050]
          noBoxMissionStartPos[11080]=noBoxMissionStartPos[10080]
          noBoxMissionStartPos[11140]=noBoxMissionStartPos[10140]
          noBoxMissionStartPos[10151]=noBoxMissionStartPos[10150]
          noBoxMissionStartPos[11151]=noBoxMissionStartPos[10150]
          local posrot=noBoxMissionStartPos[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and posrot then
            TppPlayer.SetNoOrderBoxMissionStartPosition(posrot,posrot[4])
          else
            TppPlayer.ResetNoOrderBoxMissionStartPosition()
          end
        end
        local noOrderFixHeliRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if noOrderFixHeliRoute then
          TppPlayer.SetStartStatusRideOnHelicopter()
          TppMission.SetIsStartFromHelispace()
          TppMission.ResetIsStartFromFreePlay()
        else
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
          TppHelicopter.ResetMissionStartHelicopterRoute()
          TppMission.ResetIsStartFromHelispace()
          TppMission.SetIsStartFromFreePlay()
        end
        local missionClearType=TppMission.GetMissionClearType()
        TppQuest.SpecialMissionStartSetting(missionClearType)
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromHelispace()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if abortWithSave then
      if nextIsFreeMission then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif nextIsHeliSpace then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if nextIsHeliSpace then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif nextIsFreeMission then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if isHeliSpace and isLocationChange then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(e)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.DisablePosition()
    if e then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function this.OnReload(missionTable)
  for name,entry in pairs(missionTable)do
    if IsTypeFunc(entry.OnLoad)then
      entry.OnLoad()
    end
    if IsTypeFunc(entry.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(entry.Messages())
    end
  end
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"
      TppClock.UnregisterClockMessage"ShiftChangeAtMorning"
      TppEnemy.RegisterRouteSet(missionTable.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for t,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnReload then
      _G[lib].OnReload(missionTable)
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if missionTable.sequence then
    TppCheckPoint.RegisterCheckPointList(missionTable.sequence.checkPointList)
  end
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
end
function this.OnUpdate(e)
  --NMC OFF local e
  local update=updateList
  local onUpdate=onUpdateList
  --NMC OFF local t=RENAMEsomeupdatetable2
  for n=1,numUpdate do
    update[n]()
  end
  for m=1,numOnUpdate do
    onUpdate[m]()
  end
  UpdateScriptsInScriptBlocks()
end
function this.OnChangeSVars(subScripts,varName,key)--NMC: called via mission_main
  for i,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnChangeSVars then
      _G[lib].OnChangeSVars(varName,key)
    end
  end
end
function this.SetMessageFunction(missionTable)--RENAME:
  onMessageTable={}
  onMessageTableSize=0
  messageExecTable={}
  messageExecTableSize=0
  for n,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnMessage then
      onMessageTableSize=onMessageTableSize+1
      onMessageTable[onMessageTableSize]=_G[lib].OnMessage
    end
  end
  for n,t in pairs(missionTable)do
    if missionTable[n]._messageExecTable then
      messageExecTableSize=messageExecTableSize+1
      messageExecTable[messageExecTableSize]=missionTable[n]._messageExecTable
    end
  end
end
function this.OnMessage(n,sender,messageId,arg0,arg1,arg2,arg3)
  local mvars=mvars--LOCALOPT
  local l=""
  local T
  local DoMessage=Tpp.DoMessage--LOCALOPT
  local CheckMessageOption=TppMission.CheckMessageOption--LOCALOPT
  local T=TppDebug
  local T=P
  local T=h
  local T=TppDefine.MESSAGE_GENERATION[sender]and TppDefine.MESSAGE_GENERATION[sender][messageId]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local m=GetCurrentMessageResendCount()
  if m<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for s=1,onMessageTableSize do
    local n=l
    onMessageTable[s](sender,messageId,arg0,arg1,arg2,arg3,n)
  end
  for n=1,messageExecTableSize do
    local strLogText=l
    DoMessage(messageExecTable[n],CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,l)
  end
  if mvars.order_box_script then
    mvars.order_box_script.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,l)
  end
  if mvars.animalBlockScript and mvars.animalBlockScript.OnMessage then
    mvars.animalBlockScript.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,l)
  end
end
function this.OnTerminate(e)
  if e.sequence then
    if IsTypeFunc(e.sequence.OnTerminate)then
      e.sequence.OnTerminate()
    end
  end
end
return this

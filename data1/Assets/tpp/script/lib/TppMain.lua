-- DOBUILD: 1
-- TppMain.lua
local this={}
local ApendArray=Tpp.ApendArray
--ORPHAN local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
local UpdateScriptsInScriptBlocks=ScriptBlock.UpdateScriptsInScriptBlocks
local GetCurrentMessageResendCount=Mission.GetCurrentMessageResendCount
local InfCore=InfCore--tex

local moduleUpdateFuncs={}
local numModuleUpdateFuncs=0
local missionScriptOnUpdateFuncs={}
local numOnUpdate=0
--ORPHAN local RENAMEsomeupdatetable2={}
--ORPHAN local RENAMEsomeupdate2=0
--ORPHAN local unk1={}
--ORPHAN local unk2=0
local onMessageTable={}
--ORPHAN local unk3={}
local onMessageTableSize=0
local messageExecTable={}
--ORPHAN local unk4={}
local messageExecTableSize=0
--NMC: cant actually see this referenced anywhere
local function YieldForQuarkSystemLoad()
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
function this.EnableBlackLoading(showLoadingTips)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if showLoadingTips then--tex CULL and not Ivars.debugMode:Is"BLANK_LOADING_SCREEN" then--tex added bypass
    TppUI.StartLoadingTips()
  end
end
function this.DisableBlackLoading()
  TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")
  TppUI.FinishLoadingTips()
end
--NMC: via mission_main.lua, is called in order laid out, OnAllocate is before OnInitialize
function this.OnAllocate(missionTable)
  --InfCore.PCallDebug(function(missionTable)--tex can't use consistantly since it triggers yield across c boundary error
  InfCore.LogFlow("OnAllocate Top "..vars.missionCode)--tex
  InfMain.OnAllocateTop(missionTable)--tex
  TppWeather.OnEndMissionPrepareFunction()
  this.DisableGameStatus()
  this.EnablePause()
  TppClock.Stop()
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  --ORPHAN: debugUpdateFuncs={}
  --ORPHAN: numDebugUpdateFuncs=0
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

  --tex REWORKED to allow pcall TODO: should probably lua-hang on error rather than let it continue
  local libAllocateOrder={
    "TppException",
    "TppClock",
    "TppTrap",
    "TppCheckPoint",
    "TppUI",
    "TppDemo",
    "TppScriptBlock",
    "TppSound",
    "TppPlayer",
    "TppMission",
    "TppTerminal",
    "TppEnemy",
    "TppRadio",
    "TppGimmick",
    "TppMarker",
    "TppRevenge",
  }
  --tex in lua pcalls on a yield triggers an 'attempt to yield across metamethod/C-call boundary' error
  local yields={
    TppUI=true,
  }
  for i,libName in ipairs(libAllocateOrder)do
    InfCore.LogFlow(libName..".OnAllocate")
    if not _G[libName].OnAllocate then
      InfCore.Log("ERROR: TppMain.OnAllocate: could not find "..libName..".OnAllocate",false,true)
    else
      if yields[libName] then
        _G[libName].OnAllocate(missionTable)
      else
        InfCore.PCallDebug(_G[libName].OnAllocate,missionTable)
      end
    end
  end
  this.ClearStageBlockMessage()--tex VERIFY that TppQuest, TppAnimal .onallocate needs ClearStageBlockMessage (see ORIG)
  local libAllocateOrderPostBlockMessageClear={
    "TppQuest",
    "TppAnimal",
    "InfMain",--tex
  }
  for i,libName in ipairs(libAllocateOrderPostBlockMessageClear)do
    InfCore.LogFlow(libName..".OnAllocate")
    if not _G[libName].OnAllocate then
      InfCore.Log("ERROR: TppMain.OnAllocate: could not find "..libName..".OnAllocate",false,true)
    else
      if yields[libName] then
        _G[libName].OnAllocate(missionTable)
      else
        InfCore.PCallDebug(_G[libName].OnAllocate,missionTable)
      end
    end
  end

  --ORIG
  --  TppException.OnAllocate(missionTable)
  --  TppClock.OnAllocate(missionTable)
  --  TppTrap.OnAllocate(missionTable)
  --  TppCheckPoint.OnAllocate(missionTable)
  --  TppUI.OnAllocate(missionTable)
  --  TppDemo.OnAllocate(missionTable)
  --  TppScriptBlock.OnAllocate(missionTable)
  --  TppSound.OnAllocate(missionTable)
  --  TppPlayer.OnAllocate(missionTable)
  --  TppMission.OnAllocate(missionTable)
  --  TppTerminal.OnAllocate(missionTable)
  --  TppEnemy.OnAllocate(missionTable)
  --  TppRadio.OnAllocate(missionTable)
  --  TppGimmick.OnAllocate(missionTable)
  --  TppMarker.OnAllocate(missionTable)
  --  TppRevenge.OnAllocate(missionTable)
  --  this.ClearStageBlockMessage()
  --  TppQuest.OnAllocate(missionTable)
  --  TppAnimal.OnAllocate(missionTable)
  --  InfMain.OnAllocate(missionTable)--tex
  --tex reworked
  local locationName=TppLocation.GetLocationName()
  local locationModule=_G[locationName]
  if locationModule then
    locationModule.OnAllocate()
  end--<
  --ORIG
  --  local function LocationOnAllocate()
  --    if TppLocation.IsAfghan()then
  --      if afgh then
  --        afgh.OnAllocate()
  --      end
  --    elseif TppLocation.IsMiddleAfrica()then
  --      if mafr then
  --        mafr.OnAllocate()
  --      end
  --    elseif TppLocation.IsCyprus()then
  --      if cypr then
  --        cypr.OnAllocate()
  --      end
  --    elseif TppLocation.IsMotherBase()then
  --      if mtbs then
  --        mtbs.OnAllocate()
  --      end
  --    end
  --  end
  --  LocationOnAllocate()
  if missionTable.sequence then
    if f30050_sequence then--
      --RETAILPATCH: 1.0.4.1 PATCHUP: in general I understand the need for patch ups, and in cases like this i even admire the method, however the implementation of just shoving them seemingly anywhere... needs better execution.
      function f30050_sequence.NeedPlayQuietWishGoMission()
        local isClearedVisitQuietQuest=TppQuest.IsCleard"mtbs_q99011"
        local isNotPlayDemo=not TppDemo.IsPlayedMBEventDemo"QuietWishGoMission"
        local isCanArrival=TppDemo.GetMBDemoName()==nil
        return(isClearedVisitQuietQuest and isNotPlayDemo)and isCanArrival
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
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnLoad)then
      InfCore.PCallDebug(module.OnLoad)--tex wrapped in pcall
    end
  end
  do
    local allSvars={}
    this.allSvars=allSvars--tex DEBUG see Ivars debug thingamy
    for i,lib in ipairs(Tpp._requireList)do
      if _G[lib]then
        local DeclareSVars=_G[lib].DeclareSVars
        if DeclareSVars then
          InfCore.LogFlow(lib..".DeclareSVars")--tex DEBUG
          ApendArray(allSvars,InfCore.PCallDebug(DeclareSVars,missionTable))--tex PCall
        end
      end
    end
    --tex>
    --tex not fob check pretty critical here since svars mismatch actoss clients cause corruption and hangs across clients
    if not InfMain.IsOnlineMission(vars.missionCode)then
      for i,module in ipairs(InfModules)do
        if module.DeclareSVars then
          InfCore.LogFlow(module.name..".DeclareSVars:")
          ApendArray(allSvars,InfCore.PCallDebug(module.DeclareSVars,missionTable))
        end
      end
    end
    --<
    local missionSvars={}
    for name,module in pairs(missionTable)do
      if IsTypeFunc(module.DeclareSVars)then
        ApendArray(missionSvars,module.DeclareSVars())
      end
      if IsTypeTable(module.saveVarsList)then
        ApendArray(missionSvars,TppSequence.MakeSVarsTable(module.saveVarsList))
      end
    end
    if OnlineChallengeTask then--RETAILPATCH 1090>
      ApendArray(missionSvars,OnlineChallengeTask.DeclareSVars())
    end--<
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
      local disableBuddyType=missionTable.sequence.DISABLE_BUDDY_TYPE
      if TppMission.IsMbFreeMissions(vars.missionCode) and Ivars.mbEnableBuddies:Is(1) then--tex no DISABLE_BUDDY_TYPE
        disableBuddyType=nil
      end--
      if disableBuddyType ~= nil then
        local disableBuddyTypes
        if IsTypeTable(disableBuddyType)then
          disableBuddyTypes=disableBuddyType
        else
          disableBuddyTypes={disableBuddyType}
        end
        for n,buddyType in ipairs(disableBuddyTypes)do
          TppBuddyService.SetDisableBuddyType(buddyType)
        end
      end
    end

    --if(vars.missionCode==11043)or(vars.missionCode==11044)then--tex ORIG: changed to issubs check, more robust even without my mod
    if TppMission.IsSubsistenceMission() or IvarProc.GetForMission"heliSpace_NoBuddyMenuFromMissionPreparetion"==2 then--tex added NoBuddyMenu check DEBUGNOW rethink
      TppBuddyService.SetDisableAllBuddy()
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if missionTable.sequence and missionTable.sequence.OnBuddyBlockLoad then
        missionTable.sequence.OnBuddyBlockLoad()
      end
      local locationInfo=InfMission.GetLocationInfo(vars.locationCode)--tex added locationInfo check -v-
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica() or (locationInfo and locationInfo.requestTppBuddy2BlockController)then
        InfCore.LogFlow"TppBuddy2BlockController.Load"--tex DEBUG
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
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
  --RETAILPATCH 1.0.11>
  if not TppMission.IsFOBMission(vars.missionCode)then
    TppPlayer.ForceChangePlayerFromOcelot()
  end
  --<
  --end,missionTable)--DEBUG
  InfCore.LogFlow("OnAllocate Bottom "..vars.missionCode)--tex
end
--NOTE: GameObjects loaded after OnAllocate and are gettable by OnInitialize
function this.OnInitialize(missionTable)--NMC: see onallocate for notes
  --InfCore.PCallDebug(function(missionTable)--tex off till I can verify doesn't run into same issue as OnAllocate
  InfCore.LogFlow("OnInitialize Top "..vars.missionCode)--tex
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
  --InfMainTpp.OverwriteBuddyPosForMb()--tex no go CULL
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if IsTypeFunc(missionTable.enemy.SpawnVehicleOnInitialize)then
      missionTable.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(module.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  TppLandingZone.OnInitialize()
  for i,lib in ipairs(Tpp._requireList)do
    local Init=_G[lib].Init
    if Init then
      InfCore.LogFlow(lib..".Init")--tex DEBUG
      InfCore.PCallDebug(Init,missionTable)--tex wrapped in pcall
    end
  end
  if OnlineChallengeTask then--RETAILPATCH 1090>
    OnlineChallengeTask.Init()
  end--<
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
      if missionTable.enemy.soldierDefine and type(missionTable.enemy.soldierSubTypes)=="boolean" and missionTable.enemy.cpSubTypes~=nil then--tex> use missionTable.enemy.cpSubTypes
        local soldierSubTypes={}
        for cpName,cpSoldiers in pairs(missionTable.enemy.soldierDefine)do
          local soldierSubType=type(missionTable.enemy.cpSubTypes)~="table" and missionTable.enemy.cpSubTypes or missionTable.enemy.cpSubTypes[cpName]
          if soldierSubType==nil then
          else
            soldierSubTypes[soldierSubType]=soldierSubTypes[soldierSubType] or {}
            table.insert(soldierSubTypes[soldierSubType],cpSoldiers)
          end 
        end--for soldierDefine
        TppEnemy.SetUpSoldierSubTypes(soldierSubTypes)
      else--<
      TppEnemy.SetUpSoldierSubTypes(missionTable.enemy.soldierSubTypes)
      end
    end
    TppRevenge.SetUpEnemy()
    TppEnemy.ApplyPowerSettingsOnInitialize()
    TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()
    TppEnemy.SetOccasionalChatList()
    TppEneFova.ApplyUniqueSetting()
    if missionTable.enemy.SetUpEnemy and IsTypeFunc(missionTable.enemy.SetUpEnemy)then
      InfCore.PCallDebug(missionTable.enemy.SetUpEnemy)--tex wrapped in pcall
    end
    InfMain.SetUpEnemy(missionTable)--tex
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
    --< if missionTable.enemy
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
  for name,module in pairs(missionTable)do
    if module.OnRestoreSVars then
      if vars.missionCode==10010 then--tex> WORKAROUND, s10010_sequence.OnRestoreSvars has a coroutine.yield()
        module.OnRestoreSVars()
      else--<
        InfCore.PCallDebug(module.OnRestoreSVars)--tex wrapped in pcall
      end
    end
  end
  InfMain.OnRestoreSvars()--tex
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
  InfMain.OnInitializeBottom(missionTable)--tex
  InfCore.LogFlow("OnInitialize Bottom "..vars.missionCode)--tex
  --end,missionTable)--tex DEBUG
end
function this.SetUpdateFunction(missionTable)
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  missionScriptOnUpdateFuncs={}
  numOnUpdate=0
  --ORPHAN: debugUpdateFuncs={}
  --ORPHAN: numDebugUpdateFuncs=0
  moduleUpdateFuncs={
    InfMain.UpdateBegin,--tex
    TppMission.Update,
    TppSequence.Update,
    TppSave.Update,
    TppDemo.Update,
    TppPlayer.Update,
    TppMission.UpdateForMissionLoad,
    InfMain.Update,--tex
  }
  numModuleUpdateFuncs=#moduleUpdateFuncs

  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnUpdate)then
      numOnUpdate=numOnUpdate+1
      missionScriptOnUpdateFuncs[numOnUpdate]=module.OnUpdate
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
--CALLER: TppSequence Seq_Mission_Prepare.OnUpdate END_SAVING_FILE
function this.OnMissionCanStart()
  InfCore.LogFlow"TppMain.OnMissionCanStart"--tex
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
    local missionStartSequenceIndex=TppSequence.GetMissionStartSequenceIndex()
    if(missionStartSequenceIndex~=nil)and(missionStartSequenceIndex<TppSequence.GetSequenceIndex"Seq_Game_SkullFaceToPlant")then
      if(svars.mis_objectiveEnable[17]==false)then
        Gimmick.ForceResetOfRadioCassetteWithCassette()
      end
    end
  end
  InfMain.OnMissionCanStartBottom()--tex
end
--CALLER: TppSequence. Seq_Mission_Prepare OnLeave
function this.OnMissionGameStart(sequenceName)
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
--tex broken out from ReservePlayerLoadingPosition
local function HasHeliRoute()
  return gvars.heli_missionStartRoute~=0
end
--NMC from MISSION_FINALIZE
local function LoadingPositionToHeliSpace()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
  TppPlayer.ResetNoOrderBoxMissionStartPosition()
  TppMission.ResetIsStartFromHelispace()
  TppMission.ResetIsStartFromFreePlay()
end
--NMC from MISSION_FINALIZE
local function LoadingPositionFromHeliSpace(nextIsFreeMission,isFreeMission)
  if HasHeliRoute() then
    --TppPlayer.SetStartStatusRideOnHelicopter()--tex <broken out for clarity-v-
    TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()--^
    if mvars.mis_helicopterMissionStartPosition then
      TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
      TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
    end
    --tex start on foot >
    local groundStartPosition=InfLZ.GetGroundStartPosition(gvars.heli_missionStartRoute)
    local isAssaultLz=TppLandingZone.IsAssaultDropLandingZone(gvars.heli_missionStartRoute)
    local startOnFoot=groundStartPosition and InfMain.IsStartOnFoot(vars.missionCode,isAssaultLz)
    local isMbFree=TppMission.IsMbFreeMissions(vars.missionCode) and (nextIsFreeMission or isFreeMission)
    if startOnFoot then
      TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
      --TppHelicopter.ResetMissionStartHelicopterRoute()
      if not isMbFree then
        --tex WORKAROUND mission timers fix see TppMission.IsStartFromHelispace note
        igvars.mis_isGroundStart=true
      end
      local pos=groundStartPosition.pos
      local rotY=groundStartPosition.rotY or 0--tex TODO: RETRY: fill out, or tocenter or to closest
      mvars.mis_helicopterMissionStartPosition=pos
      TppPlayer.SetInitialPosition(pos,rotY)
      TppPlayer.SetMissionStartPosition(pos,rotY)
    end--<
  else--no heli start
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
end
--NMC from MISSION_FINALIZE, not from helispace
local function LoadingPositionToFree()
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
  --TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())-v-NMC: broken out for clarity>
  if TppMission.GetMissionClearType()==TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR then
    if mvars.mis_helicopterMissionStartPosition then
      TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
      TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
    end
    TppMission.SetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
  end--^
  if HasHeliRoute() then--tex startOnFoot zoo/ward transfer>
    local groundStartPosition=InfLZ.GetGroundStartPosition(gvars.heli_missionStartRoute)
    local isAssaultLz=TppLandingZone.IsAssaultDropLandingZone(gvars.heli_missionStartRoute)
    local startOnFoot=groundStartPosition and InfMain.IsStartOnFoot(vars.missionCode,isAssaultLz) and TppMission.GetMissionClearType()~=TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR
    if startOnFoot then
      TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
      local pos=groundStartPosition.pos
      local rotY=groundStartPosition.rotY or 0
      mvars.mis_helicopterMissionStartPosition=pos
      TppPlayer.SetInitialPosition(pos,rotY)
      TppPlayer.SetMissionStartPosition(pos,rotY)
    end
  end--<
end
--
local loadPositionFuncs={}
--
loadPositionFuncs[TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE]=function(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  if nextIsHeliSpace then
    LoadingPositionToHeliSpace()
  elseif isHeliSpace then
    LoadingPositionFromHeliSpace(nextIsFreeMission,isFreeMission)
  elseif nextIsFreeMission then
    LoadingPositionToFree()
  elseif(isFreeMission and TppLocation.IsMotherBase())then
    if HasHeliRoute() then
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
        --tex shifted to TppDefine
        --ORIG
        --        local noBoxMissionStartPos={
        --          [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
        --          [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
        --          [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
        --          [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
        --          [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
        --          [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
        --          [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
        --        }
        --        noBoxMissionStartPos[11050]=noBoxMissionStartPos[10050]
        --        noBoxMissionStartPos[11080]=noBoxMissionStartPos[10080]
        --        noBoxMissionStartPos[11140]=noBoxMissionStartPos[10140]
        --        noBoxMissionStartPos[10151]=noBoxMissionStartPos[10150]
        --        noBoxMissionStartPos[11151]=noBoxMissionStartPos[10150]
        --        local posrot=noBoxMissionStartPos[vars.missionCode]
        local posrot=TppDefine.NO_BOX_MISSION_START_POSITION[vars.missionCode]
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
      --NMC not free mission
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    end
  end
end
--
loadPositionFuncs[TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT]=function(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
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
end
--
loadPositionFuncs[TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART]=function(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)end
loadPositionFuncs[TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT]=function(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)end
--NMC: tex most commonly only called with just missionLoadType, so the params are really just specific to the call with the missionLoadType that actually passes them in.
function this.ReservePlayerLoadingPosition(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  igvars.mis_isGroundStart=false--tex WORKAROUND
  this.DisableGameStatus()
  loadPositionFuncs[missionLoadType](missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)--tex broke out from this functions
  if isHeliSpace and isLocationChange then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(yieldTillEmpty)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.DisablePosition()
    if yieldTillEmpty then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function this.OnReload(missionTable)
  InfCore.LogFlow("OnReload Top "..vars.missionCode)--tex
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnLoad)then
      module.OnLoad()
    end
    if IsTypeFunc(module.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(module.Messages())
    end
  end
  if OnlineChallengeTask then--RETAILPATCH 1090>
    OnlineChallengeTask.OnReload()
  end--<
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"
      TppClock.UnregisterClockMessage"ShiftChangeAtMorning"
      TppEnemy.RegisterRouteSet(missionTable.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for i,lib in ipairs(Tpp._requireList)do
    local OnReload=_G[lib].OnReload
    if OnReload then
      InfCore.LogFlow(lib..".OnReload")--tex DEBUG
      InfCore.PCallDebug(OnReload,missionTable)--tex PCall
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
function this.OnUpdate(missionTable)
  --ORPHAN: local e
  local moduleUpdateFuncs=moduleUpdateFuncs--NMC set in SetUpdateFunction
  local missionScriptOnUpdateFuncs=missionScriptOnUpdateFuncs
  --ORPHAN: local debugUpdateFuncs=debugUpdateFuncs
  --tex
  if InfCore.debugOnUpdate then
    for i=1,numModuleUpdateFuncs do
      InfCore.PCallDebug(moduleUpdateFuncs[i],missionTable)--tex added missionTable param
    end
    for i=1,numOnUpdate do
      InfCore.PCallDebug(missionScriptOnUpdateFuncs[i])
    end
    --ORIG>
  else
    for i=1,numModuleUpdateFuncs do
      moduleUpdateFuncs[i](missionTable)--tex added missionTable param
    end
    for i=1,numOnUpdate do
      missionScriptOnUpdateFuncs[i]()
    end
  end
  UpdateScriptsInScriptBlocks()
end
--NMC: called via mission_main
function this.OnChangeSVars(subScripts,varName,key)
  for i,lib in ipairs(Tpp._requireList)do
    local OnChangeSVars=_G[lib].OnChangeSVars
    if OnChangeSVars then
      InfCore.LogFlow(lib..".OnChangeSVars")--tex DEBUG
      InfCore.PCallDebug(OnChangeSVars,varName,key)--tex PCALL
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
  --tex>
  if not InfMain.IsOnlineMission(vars.missionCode)then
    for i,module in ipairs(InfModules)do
      if module.OnMessage then
        InfCore.LogFlow("SetMessageFunction:"..module.name)
        onMessageTableSize=onMessageTableSize+1
        onMessageTable[onMessageTableSize]=module.OnMessage--tex InfModules
      end
    end
  end
  --<
  for name,module in pairs(missionTable)do
    if missionTable[name]._messageExecTable then
      messageExecTableSize=messageExecTableSize+1
      messageExecTable[messageExecTableSize]=missionTable[name]._messageExecTable
    end
  end
end
--tex called by the exe (via mission_main.OnMessage) TODO: describe when OnMessage is called 
--messages are exclusively fired by code in the engine as a mechanism for lua to respond to events
--sender and messageClass are actually str32 of the original messageexec creation definitions
--GOTCHA: sender is actuall the message class (Player,MotherBaseManagement,UI etc), not to be confused with the sender defined in the messageexec definitions.
--args are lua type number, but may represent enum,int,float, StrCode32, whatever.
--arg0 may match sender (not messageClass) in messageexec definition (see Tpp.DoMessage)
--messages are re-sent until they hit a resend count, and only then is the message actually sent to those subscribed to the messages
--pretty much always defaults to 1/the second time the message is resent (except for Fulton and VehicleBroken which is on the first send)
--can only assume this is to give a frame leeway of the code that fires the message/avoid race conditions
function this.OnMessage(missionTable,sender,messageId,arg0,arg1,arg2,arg3)
  local mvars=mvars--LOCALOPT
  local strLogTextEmpty=""
  --ORPHAN local T
  local DoMessage=Tpp.DoMessage--LOCALOPT
  local CheckMessageOption=TppMission.CheckMessageOption--LOCALOPT
  --ORPHAN local T=TppDebug
  --ORPHAN local T=unk3
  --ORPHAN local T=unk4
  local resendCount=TppDefine.MESSAGE_GENERATION[sender]and TppDefine.MESSAGE_GENERATION[sender][messageId]--0 for Fulton,VehicleBroken
  if not resendCount then
    resendCount=TppDefine.DEFAULT_MESSAGE_GENERATION--1
  end
  local currentResendCount=GetCurrentMessageResendCount()--NMC: tex counts up from 0
  if this.debugModule and InfCore.debugMode and Ivars.debugMessages:Is(1)then--tex>
    InfCore.Log("OnMessage "..messageId.." "..sender.." resendCount:"..resendCount.." currentResendCount:"..currentResendCount.." ON_MESSAGE_RESULT_RESEND:"..Mission.ON_MESSAGE_RESULT_RESEND)
  end--<
  if currentResendCount<resendCount then
    return Mission.ON_MESSAGE_RESULT_RESEND--NMC: tex was 1 when dumped, don't think it changes, but who knows
  end
  if InfCore.debugMode and Ivars.debugMessages:Is(1)then--tex>
    if InfLookup then
      InfCore.PCall(InfLookup.PrintOnMessage,sender,messageId,arg0,arg1,arg2,arg3)
  end
  end--<
  for i=1,onMessageTableSize do
    local strLogText=strLogTextEmpty
    InfCore.PCallDebug(onMessageTable[i],sender,messageId,arg0,arg1,arg2,arg3,strLogText)--tex wrapped in pcall
  end
  --missionTable modules _messageExecTable s
  for i=1,messageExecTableSize do
    local strLogText=strLogTextEmpty
    InfCore.PCallDebug(DoMessage,messageExecTable[i],CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)--tex wrapped in pcall
  end
  if OnlineChallengeTask then--RETAILPATCH 1090>
    InfCore.PCallDebug(OnlineChallengeTask.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end--<
  if mvars.loc_locationCommonTable then
    InfCore.PCallDebug(mvars.loc_locationCommonTable.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
  if mvars.order_box_script then
    InfCore.PCallDebug(mvars.order_box_script.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
  if mvars.animalBlockScript and mvars.animalBlockScript.OnMessage then
    InfCore.PCallDebug(mvars.animalBlockScript.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
  if this.debugModule and InfCore.debugMode and Ivars.debugMessages:Is(1)then--tex>
    InfCore.LogFlow("OnMessage Bottom")--tex DEBUGNOW
  end--<
end
function this.OnTerminate(missionTable)
  if missionTable.sequence then
    if IsTypeFunc(missionTable.sequence.OnTerminate)then
      missionTable.sequence.OnTerminate()
    end
  end
end
return this

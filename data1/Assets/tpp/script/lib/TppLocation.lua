--TppLocation.lua
local this={}
function this.GetLocationName()
  if vars.locationCode==10 then
    return"afgh"
  elseif vars.locationCode==20 then
    return"mafr"
  elseif vars.locationCode==30 then
    return"cypr"
  elseif vars.locationCode==50 then
    return"mtbs"
  elseif vars.locationCode==55 then
    return"mbqf"
  end
end
function this.IsAfghan()
  if vars.locationCode==10 then
    return true
  else
    return false
  end
end
function this.IsMiddleAfrica()
  if vars.locationCode==20 then
    return true
  else
    return false
  end
end
function this.IsCyprus()
  if vars.locationCode==30 then
    return true
  else
    return false
  end
end
function this.IsMotherBase()
  if vars.locationCode==50 then
    return true
  else
    return false
  end
end
function this.IsMBQF()
  if vars.locationCode==55 then
    return true
  else
    return false
  end
end
function this.SetBuddyBlock(locationId)
  if TppGameSequence.GetGameTitleName()=="TPP"then
    if locationId==10 or locationId==20 then--afgh,mafr
      if TppBuddy2BlockController.CreateBlock then
        TppBuddy2BlockController.CreateBlock()
    end
    else
      if TppBuddy2BlockController.DeleteBlock then
        TppBuddy2BlockController.DeleteBlock()
      end
    end
  end
  return locationPackagePath--RETAILBUG: VERIFY NMC: this is a strange one, this function is only called once and doesnt grab the return, the return variable has no declaration anywhere, could be some kind of module, but not named or used like one, or maybe the minifier didnt know what to do with it since it was orphaned?, I guess lua is robust enough to keep rolling if it is an actual error?, interprets the function up to that point, errors dont spill outside the function??
end
MotherBaseStage.RegisterModifyLayoutCodes{0,10,20,30,40,70,80,90,980}
function this.ModifyMbsLayoutCode(layoutCode)
  return MotherBaseStage.ModifyLayoutCode(layoutCode)
end
this.debug_useDebugMbParam=nil
function this.DEBUG_UseDebugMbParam()
  this.debug_useDebugMbParam=true
end
function this.ApplyPlatformParamToMbStage(missionCode,baseType)
  if not TppMotherBaseManagement.BaseSvarsToMbsParam then
    return false
  end
  if this.debug_useDebugMbParam then
    this.debug_useDebugMbParam=nil
    return false
  end
  if missionCode==10030 and TppMotherBaseManagement.SetUpMbsParamFor10030 then
    TppMotherBaseManagement.SetUpMbsParamFor10030()
  elseif missionCode~=50050 then
    if TppDefine.EMERGENCY_MISSION_ENUM[missionCode]then
      TppUiCommand.MapParamToMbsParam()
    else
      TppMotherBaseManagement.BaseSvarsToMbsParam{base=baseType}
    end
  else
    TppMotherBaseManagement.BaseFobToMbsParam()
  end
  return true
end
function this.GetMbStageHelicopterRoute(missionCode,e,heliRoute)
  local heliRoute
  if missionCode==50050 then
    TppMotherBaseManagement.BaseFobToMbsParam()
    local mbsTopology=TppMotherBaseManagement.GetMbsTopologyType{}
    local mbsFirstCluster=TppMotherBaseManagement.GetMbsFirstCluster{}
    local mbsFirstClusterGrade=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[mbsFirstCluster+1]}
    heliRoute=string.format("ly%03d_cl%02d_%05d_heli0000|cl%02dpl%01d_mb_fndt_plnt_heli_%05d|rt_apr_of",mbsTopology,mbsFirstCluster,missionCode,mbsFirstCluster,mbsFirstClusterGrade-1,missionCode)
  else
    heliRoute=heliRoute
  end
  return heliRoute
end
function this.SetForceConstructDevelopCluster()
  this.ApplyPlatformParamToMbStage()
  local developGrade=TppMotherBaseManagement.GetMbsClusterGrade{category="Develop"}
  local forceGrade=1
  if developGrade<forceGrade then
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Develop",grade=forceGrade,buildStatus="Completed",timeMinute=0,isNew=true}
  end
end
function this.RegistBaseAssetTable(onActiveTable,onActiveSmallBlockTable)
  if onActiveTable then
    mvars.loc_locationBaseAssetOnActive={}
    for name,OnActive in pairs(onActiveTable)do
      mvars.loc_locationBaseAssetOnActive[Fox.StrCode32(name)]=OnActive
    end
  end
  if onActiveSmallBlockTable then
    mvars.loc_locationBaseOnActiveSmallBlock=onActiveSmallBlockTable
    for name,info in pairs(onActiveSmallBlockTable)do
      local activeArea=info.activeArea
      if activeArea then
        local indices=Tpp.AreaToIndices(activeArea)
        StageBlock.AddSmallBlockIndexForMessage(indices)
      end
      if not info.OnActive then
      end
    end
  end
end
function this.RegistMissionAssetInitializeTable(baseOnActiveTable,onActiveSmallBlockTable)
  if baseOnActiveTable then
    mvars.loc_missionAssetOnActive={}
    for cpName,cpOnActiveFunction in pairs(baseOnActiveTable)do
      mvars.loc_missionAssetOnActive[Fox.StrCode32(cpName)]=cpOnActiveFunction
    end
  end
  if onActiveSmallBlockTable then
    mvars.loc_missionAssetOnActiveSmallBlock=onActiveSmallBlockTable
    for cpName,onActiveInfo in pairs(onActiveSmallBlockTable)do
      local activeArea=onActiveInfo.activeArea
      if activeArea then
        local areaIndices=Tpp.AreaToIndices(activeArea)
        StageBlock.AddSmallBlockIndexForMessage(areaIndices)
      end
      if not onActiveInfo.OnActive then
      end
    end
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.ActivateBlock()
  local noLoadTable={[1]=true,[30]=true,[50]=true,[55]=true}--init,cypr,mtbs,mbqf
  if noLoadTable[vars.locationCode]then
    return
  end
  local loadedLargeBlocks=StageBlock.GetLoadedLargeBlocks(0)
  for t,blockName in pairs(loadedLargeBlocks)do
    this.OnActiveLargeBlock(blockName,StageBlock.ACTIVE)
  end
  local a=4
  local t,n=StageBlock.GetCurrentMinimumSmallBlockIndex()
  if not((t==0)and(n==0))then
    local o=t+a
    local a=n+a
    for t=t,o do
      for n=n,a do
        this.OnActiveSmallBlock(t,n,StageBlock.ACTIVE)
      end
    end
  end
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Messages()
  return Tpp.StrCode32Table{
    Block={
      {msg="OnChangeLargeBlockState",func=this.OnActiveLargeBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true}},
      {msg="OnChangeSmallBlockState",func=this.OnActiveSmallBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true}},
    },
    nil
  }
end
function this.OnActiveLargeBlock(blockName,blockStatus)
  if blockStatus==StageBlock.INACTIVE then
    return
  end
  if TppSequence.IsEndSaving()==false then
    return
  end
  local locationBaseAssetOnActive=mvars.loc_locationBaseAssetOnActive
  if locationBaseAssetOnActive then
    local OnActive=locationBaseAssetOnActive[blockName]
    if OnActive then
      OnActive()
    end
  end
  local missionAssetOnActive=mvars.loc_missionAssetOnActive
  if missionAssetOnActive then
    local OnActive=missionAssetOnActive[blockName]
    if OnActive then
      OnActive()
    end
  end
end
function this.OnActiveSmallBlock(t,n,blockStatus)
  if blockStatus==StageBlock.INACTIVE then
    return
  end
  local locationBaseOnActiveSmallBlock=mvars.loc_locationBaseOnActiveSmallBlock
  if locationBaseOnActiveSmallBlock then
    for blockName,blockInfo in pairs(locationBaseOnActiveSmallBlock)do
      local activeInfo,OnActive=blockInfo.activeArea,blockInfo.OnActive
      if activeInfo then
        if Tpp.CheckBlockArea(activeInfo,t,n)then
          OnActive()
        end
      end
    end
  end
  local missionAssetOnActiveSmallBlock=mvars.loc_missionAssetOnActiveSmallBlock
  if missionAssetOnActiveSmallBlock then
    for blockName,blockInfo in pairs(missionAssetOnActiveSmallBlock)do
      local activeInfo,OnActive=blockInfo.activeArea,blockInfo.OnActive
      if activeInfo then
        if Tpp.CheckBlockArea(activeInfo,t,n)then
          OnActive()
        end
      end
    end
  end
end
function this.GetMbStageClusterGrade(clusterId)
  local clusterGrade=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[clusterId]}
  if TppMotherBaseManagement.GetMbsClusterBuildStatus{category=TppDefine.CLUSTER_NAME[clusterId]}=="Building"then
    clusterGrade=clusterGrade-1
  end
  return clusterGrade
end
function this.GetLocalMbStageClusterGrade(clusterId)
  return TppMotherBaseManagement.GetClusterGrade{base="MotherBase",category=TppDefine.CLUSTER_NAME[clusterId]}
end
function this.MbFreeSpecialMissionStartSetting(missionClearType)
  if missionClearType==TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR then
    if mvars.mis_helicopterMissionStartPosition then
      TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
      TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
    end
    TppMission.SetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
  end
end
return this

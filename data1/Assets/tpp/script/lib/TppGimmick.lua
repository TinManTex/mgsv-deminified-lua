-- TppGimmick.lua
local this={}
local StrCode32=Fox.StrCode32
local GetTypeIndex=GameObject.GetTypeIndex
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local IsTypeTable=Tpp.IsTypeTable
this.MissionCollectionTable={
  [10020]={"col_diamond_s_s10020_0000"},
  [10033]={"col_develop_HighprecisionAR_s10033_0000"},
  [10036]={"col_herb_10036","col_material_CM_10036"},
  [10041]={"col_diamond_l_s10041_0000"},
  [10043]={"col_diamond_l_s10043_0000"},
  [10070]={"col_develop_Semiauto_SR_s10070_0000"},
  [10082]={"col_herb_r_s10082_0000"},
  [10085]={"col_herb_l_s10085_0000"},
  [10093]={"col_diamond_l_s10093_0000"},
  [10100]={"col_diamond_s_s10100_0000","col_diamond_s_s10100_0001","col_diamond_s_s10100_0002"},
  [10110]={"col_diamond_l_s10110_0000","col_diamond_l_s10110_0001","col_diamond_l_s10110_0002"},
  [10120]={"col_diamond_l_s10120_0000"},
  [10156]={"col_diamond_l_s10156_0000"},
  [10171]={"col_diamond_l_s10171_0000"},
  [10200]={"col_herb_l_s10200_0000","col_herb_l_s10200_0001","col_herb_l_s10200_0002"}
}
this.MissionCollectionMissionTaskTable={
  [10020]={30},
  [10033]={17},
  [10036]={17,18},
  [10043]={"first"},
  [10070]={27},
  [10082]={22},
  [10085]={31},
  [10120]={12},
  [10093]={27},
  [10171]={40}
}
this.GIMMICK_TYPE={NONE=0,ANTN=1,MCHN=2,CMMN=3,GUN=4,MORTAR=5,GNRT=6,CNTN=7,ANTIAIR=8,AACR=9,LIGHT=10,TOWER=11,TLET=12,TRSH=13,CSET=14,SWTC=15,FLOWSTATION_TANK001=100,FLOWSTATION_TANK002=101,FACTORY_WALL=102,FACTORY_FRAME=103,FACTORY_WTTR=104,FACTORY_TNNL=105,LAB_BRDG=106,FACTORY_TANK=107,FACTORY_WTNK=108,FACTORY_WSST=109,FLOWSTATION_PDOR=110,FACTORY_CRTN=111,FLOWSTATION_COPS=112,MAX=255}
local gimmickToAnnounceType={[this.GIMMICK_TYPE.AACR]="destroyRadar"}
this.COLLECTION_REPOP_COUNT_DECREMENT_TABLE={
  [TppCollection.TYPE_DIAMOND_LARGE]=60,
  [TppCollection.TYPE_DIAMOND_SMALL]=100,
  [TppCollection.TYPE_MATERIAL_CM_0]=100,
  [TppCollection.TYPE_MATERIAL_CM_1]=100,
  [TppCollection.TYPE_MATERIAL_CM_2]=100,
  [TppCollection.TYPE_MATERIAL_CM_3]=100,
  [TppCollection.TYPE_MATERIAL_CM_4]=100,
  [TppCollection.TYPE_MATERIAL_CM_5]=100,
  [TppCollection.TYPE_MATERIAL_CM_6]=100,
  [TppCollection.TYPE_MATERIAL_CM_7]=100,
  [TppCollection.TYPE_MATERIAL_MM_0]=100,
  [TppCollection.TYPE_MATERIAL_MM_1]=100,
  [TppCollection.TYPE_MATERIAL_MM_2]=100,
  [TppCollection.TYPE_MATERIAL_MM_3]=100,
  [TppCollection.TYPE_MATERIAL_MM_4]=100,
  [TppCollection.TYPE_MATERIAL_MM_5]=100,
  [TppCollection.TYPE_MATERIAL_MM_6]=100,
  [TppCollection.TYPE_MATERIAL_MM_7]=100,
  [TppCollection.TYPE_MATERIAL_PM_0]=100,
  [TppCollection.TYPE_MATERIAL_PM_1]=100,
  [TppCollection.TYPE_MATERIAL_PM_2]=100,
  [TppCollection.TYPE_MATERIAL_PM_3]=100,
  [TppCollection.TYPE_MATERIAL_PM_4]=100,
  [TppCollection.TYPE_MATERIAL_PM_5]=100,
  [TppCollection.TYPE_MATERIAL_PM_6]=100,
  [TppCollection.TYPE_MATERIAL_PM_7]=100,
  [TppCollection.TYPE_MATERIAL_FR_0]=100,
  [TppCollection.TYPE_MATERIAL_FR_1]=100,
  [TppCollection.TYPE_MATERIAL_FR_2]=100,
  [TppCollection.TYPE_MATERIAL_FR_3]=100,
  [TppCollection.TYPE_MATERIAL_FR_4]=100,
  [TppCollection.TYPE_MATERIAL_FR_5]=100,
  [TppCollection.TYPE_MATERIAL_FR_6]=100,
  [TppCollection.TYPE_MATERIAL_FR_7]=100,
  [TppCollection.TYPE_MATERIAL_BR_0]=100,
  [TppCollection.TYPE_MATERIAL_BR_1]=100,
  [TppCollection.TYPE_MATERIAL_BR_2]=100,
  [TppCollection.TYPE_MATERIAL_BR_3]=100,
  [TppCollection.TYPE_MATERIAL_BR_4]=100,
  [TppCollection.TYPE_MATERIAL_BR_5]=100,
  [TppCollection.TYPE_MATERIAL_BR_6]=100,
  [TppCollection.TYPE_MATERIAL_BR_7]=100,
  [TppCollection.TYPE_HERB_G_CRESCENT]=100,
  [TppCollection.TYPE_HERB_A_PEACH]=100,
  [TppCollection.TYPE_HERB_DIGITALIS_P]=100,
  [TppCollection.TYPE_HERB_DIGITALIS_R]=100,
  [TppCollection.TYPE_HERB_B_CARROT]=100,
  [TppCollection.TYPE_HERB_WORM_WOOD]=100,
  [TppCollection.TYPE_HERB_TARRAGON]=100,
  [TppCollection.TYPE_HERB_HAOMA]=100,
  [TppCollection.TYPE_HERB_0]=100,
  [TppCollection.TYPE_HERB_1]=100
}
function this.Messages()
  return Tpp.StrCode32Table{
    Radio={
      {msg="Finish",sender="f1000_rtrg2020",func=function()
        TppUI.ShowAnnounceLog"unlockLz"
      end}},
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
        this.OnMissionGameStart()
      end,
      option={isExecMissionPrepare=true,isExecMissionClear=true}}},
    nil}
end
function this.IsBroken(isBrokenParams)
  if not IsTypeTable(isBrokenParams)then
    return
  end
  local gimmickId,searchFromSaveData
  gimmickId=isBrokenParams.gimmickId
  searchFromSaveData=isBrokenParams.searchFromSaveData
  if not gimmickId then
    return
  end
  if not mvars.gim_identifierParamTable then
    return
  end
  local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
  if Gimmick.IsBrokenGimmick and gimmickInfo then
    if searchFromSaveData then
      return Gimmick.IsBrokenGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName)
    else
      return Gimmick.IsBrokenGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName,1)
    end
  end
end
function this.ResetGimmick(resetParams)
  if not IsTypeTable(resetParams)then
    return
  end
  if not this.IsBroken(resetParams)then
    return
  end
  local gimmickId
  gimmickId=resetParams.gimmickId
  if not gimmickId then
    return
  end
  local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
  if Gimmick.ResetGimmick and gimmickInfo then
    Gimmick.ResetGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName)
  end
end
function this.EnableMarkerGimmick(gimmickId)
  local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
  if not Gimmick.BreakGimmick then
    return
  end
  Gimmick.EnableMarkerGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName,true)
end
function this.OnAllocate(missionTable)
  if TppLocation.IsAfghan()then
    TppCollection.SetScriptDeclVars("col_daimondStatus_afgh","col_markerStatus_afgh","col_isRegisteredInDb_afgh")
  elseif TppLocation.IsMiddleAfrica()then
    TppCollection.SetScriptDeclVars("col_daimondStatus_mafr","col_markerStatus_mafr","col_isRegisteredInDb_mafr")
  elseif TppLocation.IsMotherBase()then
    TppCollection.SetScriptDeclVars("col_daimondStatus_mtbs","col_markerStatus_mtbs","col_isRegisteredInDb_mtbs")
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  if TppMission.IsFreeMission(vars.missionCode)then
    Gimmick.EspionageBoxOnGround(false)
  else
    Gimmick.EspionageBoxOnGround(true)
  end
  if TppMission.IsFreeMission(vars.missionCode)then
    mvars.gim_shownEspionageBox=true
    Gimmick.EspionageBoxAllInvisible(false)
  elseif(gvars.heli_missionStartRoute~=0)or(not TppMission.IsMissionStart())then
    mvars.gim_shownEspionageBox=false
    Gimmick.EspionageBoxAllInvisible(true)
  else
    mvars.gim_shownEspionageBox=true
    Gimmick.EspionageBoxAllInvisible(false)
  end
  TppTerminal.InitializeBluePrintLocatorIdTable()
  if TppMission.IsMissionStart()then
    for missionCode,collectionNames in pairs(this.MissionCollectionTable)do
      local isCurrent=(vars.missionCode==missionCode)
      if isCurrent==false then
        if TppMission.IsHardMission(vars.missionCode)then
          local normalMissionCode=TppMission.GetNormalMissionCodeFromHardMission(vars.missionCode)
          isCurrent=(normalMissionCode==missionCode)
        end
      end
      this.EnableCollectionTable(collectionNames,isCurrent,true)
    end
    do
      local collection={"col_develop_Revolver_Shotgun"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Emergencyrescue"}
      local enable
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Antimaterial"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Highprecision_SMG"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_FLamethrower"}
      local enable
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_HighprecisionAR"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Semiauto_SR"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Shield"}
      local enable
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Shield0000"}
      local enable
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Shield0001"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_TO_MATHER_BASE then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
    do
      local collection={"col_develop_Shield0002"}
      local enable
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        enable=true
      else
        enable=false
      end
      this.EnableCollectionTable(collection,enable)
    end
  else
    this.RepopMissionTaskCollection()
    if vars.missionCode==10200 then
      local missionCollection=this.MissionCollectionTable[10200]
      local count=0
      for i,n in pairs(missionCollection)do
        if TppCollection.RepopCountOperation("GetAt",n)>0 then
          count=count+1
        end
      end
      local count2=count-svars.CollectiveCount
      for i,collectionName in pairs(missionCollection)do
        if count2>0 then
          if TppCollection.RepopCountOperation("GetAt",collectionName)>0 then
            TppCollection.RepopCountOperation("SetAt",collectionName,0)
            count2=count2-1
          end
        end
      end
    end
  end
  local collectionTable={
    "col_develop_BullpupAR",
    "col_develop_LongtubeShotgun",
    "col_develop_RevolverGrenade0001",
    "col_develop_RevolverGrenade0002",
    "col_develop_RevolverGrenade0003",
    "col_develop_RevolverGrenade0004",
    "col_develop_EuropeSMG0001",
    "col_develop_EuropeSMG0002",
    "col_develop_EuropeSMG0003",
    "col_develop_EuropeSMG0004",
    "col_develop_Stungrenade"
  }
  this.EnableCollectionTable(collectionTable,true)
  this.InitQuest()
end
function this.RepopMissionTaskCollection()
  local missionCode=vars.missionCode
  if TppMission.IsHardMission(missionCode)then
    missionCode=TppMission.GetNormalMissionCodeFromHardMission(missionCode)
  end
  local missionColMissionTaskTable=this.MissionCollectionMissionTaskTable[missionCode]
  if not missionColMissionTaskTable then
    return
  end
  local missionColTable=this.MissionCollectionTable[missionCode]
  for missionCode,collectionNames in pairs(missionColTable)do
    if TppCollection.IsExistLocator(collectionNames)and(TppCollection.RepopCountOperation("GetAt",collectionNames)>0)then
      local doRepop=false
      local missionTask=missionColMissionTaskTable[missionCode]
      if missionTask=="first"then
        if not svars.isCompleteFirstBonus then
          doRepop=true
        end
      else
        if(svars.mis_objectiveEnable[missionTask]==false)then
          doRepop=true
        end
      end
      if doRepop then
        TppCollection.RepopCountOperation("SetAt",collectionNames,0)
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
function this.OnMissionGameStart()
  if not TppMission.IsFreeMission(vars.missionCode)then
    if mvars.gim_shownEspionageBox then
      Gimmick.EspionageBoxFadeout()
    end
  end
end
function this.DecrementCollectionRepopCount()
  for type,count in pairs(this.COLLECTION_REPOP_COUNT_DECREMENT_TABLE)do
    TppCollection.RepopCountOperation("DecByType",type,count)
  end
end
function this.MafrRiverPrimSetting()
  if not TppEffectUtility.UpdatePrimRiver then
    return
  end
  --Mission 13 - Pitch Dark
  if vars.missionCode==10080 or vars.missionCode==11080 then
    this.SetMafrRiverPrimVisibility(false)
  else
    this.SetMafrRiverPrimVisibility(true)
  end
end
function this.SetMafrRiverPrimVisibility(enable)
  local primLayers={"cleanRiver","dirtyRiver","oilMud_open","dirtyFlow"}
  local primLayerShow={true,false,false,false}
  for i,layerName in ipairs(primLayers)do
    local show
    if enable then
      show=primLayerShow[i]
    else
      show=not primLayerShow[i]
    end
    TppEffectUtility.SetPrimRiverVisibility(layerName,show)
  end
  TppEffectUtility.UpdatePrimRiver()
end
--<location>_gimmick.gimmickIdentifierParamTable or mvars.mbItem_funcGetGimmickIdentifierTable
--mtbs is   {[clusterId]={gimmickInfo,...}}
--afgh/mafr {gimmickInfo,...}
--REF gimmickInfo
--  commFacility_antn001 = {--identifier
--    type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
--    locatorName = "afgh_antn001_vrtn004_gim_n0000|srt_afgh_antn001_fndt004",
--    dataSetName = "/Assets/tpp/level/location/afgh/block_large/commFacility/afgh_commFacility_gimmick.fox2",
--    gimmickType = TppGimmick.GIMMICK_TYPE.ANTN,
--    blockLarge ="afgh_commFacility",
--  },
--see also GetGimmickID
function this.SetUpIdentifierTable(identifierTable)
  mvars.gim_identifierParamTable={}
  Tpp.MergeTable(mvars.gim_identifierParamTable,identifierTable)
  mvars.gim_identifierParamStrCode32Table={}
  mvars.gim_gimmackNameStrCode32Table={}
  for identifier,gimmickInfo in pairs(identifierTable)do
    local idStr32=StrCode32(identifier)
    mvars.gim_identifierParamStrCode32Table[idStr32]=gimmickInfo
    mvars.gim_gimmackNameStrCode32Table[idStr32]=identifier
  end
  mvars.gim_identifierTable={}
  for identifier,gimmickInfo in pairs(identifierTable)do
    local typeIndex=gimmickInfo.type
    local locatorName=gimmickInfo.locatorName
    local dataSetName=gimmickInfo.dataSetName
    mvars.gim_identifierTable[typeIndex]=mvars.gim_identifierTable[typeIndex]or{}
    local gimmicksOfType=mvars.gim_identifierTable[typeIndex]
    gimmicksOfType[StrCode32(locatorName)]=gimmicksOfType[StrCode32(locatorName)]or{}
    local locatorIdentifiers=gimmicksOfType[StrCode32(locatorName)]
    locatorIdentifiers[Fox.PathFileNameCode32(dataSetName)]=identifier
  end
  
  --STRUCTURE
--   mvars.gim_identifierTable={
--    [gimmick game object type index / gimmickInfo.type]={
--      [StrCode32(locatorName)]={
--        Fox.PathFileNameCode32(dataSetName)]=identifier,
--        ..
--      },
--      ...
--    },
--   }
end
--afgh_gimmick.gimmickBreakConnectTable / mafr_...
--REF {swamp_antn001 = "swamp_mchn001",...}
function this.SetUpBreakConnectTable(gimmickBreakConnectTable)
  mvars.gim_breakConnectTable={}
  for gimmack1,gimmick2 in pairs(gimmickBreakConnectTable)do
    mvars.gim_breakConnectTable[gimmack1]=gimmick2
    mvars.gim_breakConnectTable[gimmick2]=gimmack1
  end
end
--afgh_gimmick.checkBrokenAndBreakConnectTable / mafr_...
function this.SetUpCheckBrokenAndBreakConnectTable(checkBrokenAndBreakConnectTable)
  mvars.gim_checkBrokenAndBreakConnectTable={}
  for gimmickId,gimmickInfo in pairs(checkBrokenAndBreakConnectTable)do
    this._SetUpCheckBrokenAndBreakConnectTable(gimmickId,gimmickInfo)
  end
end
function this._SetUpCheckBrokenAndBreakConnectTable(gimmickId,gimmickInfo)
  if not mvars.gim_identifierParamTable[gimmickId]then
    return
  end
  local breakGimmickId=gimmickInfo.breakGimmickId
  local checkBrokenGimmickId=gimmickInfo.checkBrokenGimmickId
  if not breakGimmickId then
    return
  end
  if not checkBrokenGimmickId then
    return
  end
  if not mvars.gim_identifierParamTable[breakGimmickId]then
    return
  end
  if not mvars.gim_identifierParamTable[checkBrokenGimmickId]then
    return
  end
  mvars.gim_checkBrokenAndBreakConnectTable[gimmickId]=gimmickInfo
  mvars.gim_checkBrokenAndBreakConnectTable[checkBrokenGimmickId]={checkBrokenGimmickId=gimmickId,breakGimmickId=breakGimmickId}
end
--NMC cant see any references to this
function this.SetUpUseGimmickRouteTable(e)
  mvars.gim_routeGimmickConnectTable={}
  for e,n in pairs(e)do
    mvars.gim_routeGimmickConnectTable[StrCode32(e)]=n.gimmickId
  end
  Tpp.DEBUG_DumpTable(mvars.gim_routeGimmickConnectTable)
end
function this.GetRouteConnectedGimmickId(route)
  if not mvars.gim_routeGimmickConnectTable then
    return
  end
  return mvars.gim_routeGimmickConnectTable[route]
end
--ConnectLandingZoneTable
function this.SetUpConnectLandingZoneTable(connectLZTable)
  mvars.gim_connectLandingZoneTable={}
  for gimmickName,lzInfo in pairs(connectLZTable)do
    mvars.gim_connectLandingZoneTable[gimmickName]=lzInfo.aprLandingZoneName
  end
end
function this.SetUpConnectPowerCutTable(e)
  mvars.gim_connectPowerCutAreaTable={}
  mvars.gim_connectPowerCutCpTable={}
  for gimmickId,e in pairs(e)do
    local areaName=e.powerCutAreaName
    local cpName=e.cpName
    mvars.gim_connectPowerCutAreaTable[gimmickId]=areaName
    if cpName then
      local cpId=GetGameObjectId(cpName)
      if cpId~=NULL_ID then
        mvars.gim_connectPowerCutCpTable[gimmickId]=cpId
        local tppCommandPost={type="TppCommandPost2"}
        local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
        local command={id="SetPowerSourceGimmick",cpName=cpName,gimmicks=gimmickInfo,areaName=areaName}
        GameObject.SendCommand(tppCommandPost,command)
      end
    end
  end
end
function this.SetUpConnectVisibilityTable(e)
  mvars.gim_connectVisibilityTable={}
  for e,n in pairs(e)do
    mvars.gim_connectVisibilityTable[e]=n
  end
end
function this.SetCommunicateGimmick(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.gim_gimmickIdToCpTable=mvars.gim_gimmickIdToCpTable or{}
  local tppCommandPost={type="TppCommandPost2"}
  for cpName,e in pairs(e)do
    local gimmicks={}
    for e,gimmickId in ipairs(e)do
      local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
      if gimmickInfo then
        table.insert(gimmicks,gimmickInfo)
      end
      local cpId=GetGameObjectId(cpName)
      if cpId~=NULL_ID then
        mvars.gim_gimmickIdToCpTable[StrCode32(gimmickId)]=cpId
      end
    end
    local isCommunicateBase=e.isCommunicateBase
    local groupName=e.groupName
    local command={id="SetCommunicateGimmick",cpName=cpName,isCommunicateBase=isCommunicateBase,gimmicks=gimmicks,groupName=groupName}
    GameObject.SendCommand(tppCommandPost,command)
  end
end
--NMC on GameObject SwitBreakGimmickchGimmick msg
function this.BreakGimmick(gameId,locatorNameHash,dataSetNameHash,unkP4)
  local gimmickId=this.GetGimmickID(gameId,locatorNameHash,dataSetNameHash)
  --GetGimmickID(gameId,locatorNameHash,dataSetNameHash)
  if not gimmickId then
    return
  end
  this.BreakConnectedGimmick(gimmickId)
  this.CheckBrokenAndBreakConnectedGimmick(gimmickId)
  this.HideAsset(gimmickId)
  this.ShowAnnounceLog(gimmickId)
  this.UnlockLandingZone(gimmickId)
  local unkLBool=false
  if(unkP4==NULL_ID)then
    unkLBool=true
  end
  this.PowerCut(gimmickId,true,unkLBool)
  this.SetHeroicAndOrgPoint(gimmickId,unkP4)
end
--NMC returns gimmickIdentifierParamTable identifier, see  SetUpIdentifierTable
function this.GetGimmickID(gameId,locatorNameHash,dataSetNameHash)
  local typeIndex=GetTypeIndex(gameId)
  local gim_identifierTable=mvars.gim_identifierTable
  if not gim_identifierTable then
    return
  end
  local gimmicksOfType=gim_identifierTable[typeIndex]
  if not gimmicksOfType then
    return
  end
  local locatorIdentifiers=gimmicksOfType[locatorNameHash]
  if not locatorIdentifiers then
    return
  end
  local identifier=locatorIdentifiers[dataSetNameHash]
  if not locatorIdentifiers then
    return
  end
  return identifier
end
function this.GetGameObjectId(gimmickId)
  local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
  if not gimmickInfo then
    return
  end
  return Gimmick.GetGameObjectId(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName)
end
function this.BreakConnectedGimmick(e)
  local connectedGimmickId=mvars.gim_breakConnectTable[e]
  if not connectedGimmickId then
    return
  end
  local gimmickInfo=mvars.gim_identifierParamTable[connectedGimmickId]
  Gimmick.BreakGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName,false)
end
function this.CheckBrokenAndBreakConnectedGimmick(gimmickId)
  if not mvars.gim_checkBrokenAndBreakConnectTable then
    return
  end
  local connectTable=mvars.gim_checkBrokenAndBreakConnectTable[gimmickId]
  if not connectTable then
    return
  end
  local checkBrokenGimmickId=connectTable.checkBrokenGimmickId
  local breakGimmickId=connectTable.breakGimmickId
  if this.IsBroken{gimmickId=checkBrokenGimmickId}then
    local gimmickInfo=mvars.gim_identifierParamTable[breakGimmickId]
    if gimmickInfo then
      Gimmick.BreakGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName,false)
    end
  end
end
function this.HideAsset(e)
  local e=mvars.gim_connectVisibilityTable[e]
  if not e then
    return
  end
  for i,n in pairs(e.invisibilityList)do
    TppDataUtility.SetVisibleDataFromIdentifier(e.identifierName,n,false,true)
  end
end
function this.Show(show)
  local e=this.SetVisibility(show,false)
end
function this.Hide(hide)
  this.SetVisibility(hide,true)
end
function this.SetVisibility(gimmickId,visible)
  local gimmickInfo=mvars.gim_identifierParamTable[gimmickId]
  if not gimmickInfo then
    return
  end
  Gimmick.InvisibleGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName,visible)
  return true
end
function this.UnlockLandingZone(gimmickId)
  if TppLandingZone.IsDisableUnlockLandingZoneOnMission()then
    return
  end
  local lzs=mvars.gim_connectLandingZoneTable[gimmickId]
  if not lzs then
    return
  end
  local doesExist
  for i,landingZoneName in pairs(lzs)do
    if TppHelicopter.GetLandingZoneExists{landingZoneName=landingZoneName}then
      TppHelicopter.SetEnableLandingZone{landingZoneName=landingZoneName}
      doesExist=true
    end
  end
  if doesExist then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE)
  end
end
function this.ShowAnnounceLog(gimmickId)
  local gimmickType=mvars.gim_identifierParamTable[gimmickId].gimmickType
  if not gimmickType then
    return
  end
  local announceType=gimmickToAnnounceType[gimmickType]
  if announceType then
    TppUI.ShowAnnounceLog(announceType)
  end
  this._ShowCommCutOffAnnounceLog(gimmickId)
end
function this._ShowCommCutOffAnnounceLog(e)
  if not mvars.gim_gimmickIdToCpTable then
    return
  end
  local cpId=mvars.gim_gimmickIdToCpTable[StrCode32(e)]
  if not cpId then
    return
  end
  GameObject.SendCommand(cpId,{id="SetCommunicateAnnounce"})
end
--NMC on GameObject SwitchGimmick msg
function this.SwitchGimmick(gameId,locatorNameHash,dataSetNameHash,switchFlag)
  local gimmickId=this.GetGimmickID(gameId,locatorNameHash,dataSetNameHash)
  if not gimmickId then
    return
  end
  local powerCutOn=false
  if(switchFlag==0)then
    powerCutOn=true
  end
  this.PowerCut(gimmickId,powerCutOn,false)
end
function this.PowerCut(gimmickId,powerCutOn,RENsomeBool)
  local connectPowerCutAreaTable=mvars.gim_connectPowerCutAreaTable[gimmickId]
  if connectPowerCutAreaTable then
    if powerCutOn then
      Gimmick.PowerCutOn(connectPowerCutAreaTable,RENsomeBool)
    else
      Gimmick.PowerCutOff(connectPowerCutAreaTable)
    end
  end
end
function this.SetHeroicAndOrgPoint(gimmickId,e)
  if e==NULL_ID then
    return
  end
  local gimmickType=mvars.gim_identifierParamTable[gimmickId].gimmickType
  if not gimmickType then
    return
  end
  TppHero.AnnounceBreakGimmickByGimmickType(gimmickType)
end
function this.EnableCollectionTable(collectionNames,enable,force)
  local showFlag=0
  if not enable then
    showFlag=1
  end
  local function IsGotKeyItem(locator)
    local typeId=TppCollection.GetTypeIdByLocatorName(locator)
    if typeId~=TppCollection.TYPE_DEVELOPMENT_FILE then
      return false
    end
    local uniqueId=TppCollection.GetUniqueIdByLocatorName(locator)
    local keyItemId=TppTerminal.GetBluePrintKeyItemId(uniqueId)
    if keyItemId then
      if TppMotherBaseManagement.IsGotDataBase{dataBaseId=keyItemId}then
        return true
      end
    end
    return false
  end
  for i,locator in pairs(collectionNames)do
    if TppCollection.IsExistLocator(locator)then
      if not IsGotKeyItem(locator)or force then
        TppCollection.RepopCountOperation("SetAt",locator,showFlag)
      end
    end
  end
end
function this.DEBUG_DumpIdentiferParam(n,e)
  if e then
  end
end
function this.InitQuest()
  mvars.gim_questTargetList={}
  mvars.gim_isQuestSetup=false
  mvars.gim_isquestMarkStart=false
  mvars.gim_questMarkStartName=nil
  mvars.gim_questMarkStartLocator=nil
  mvars.gim_questMarkStartData=nil
  mvars.gim_questMarkSetIndex=0
  mvars.gim_questMarkCount=0
  mvars.gim_questMarkTotalCount=0
end
function this.OnAllocateQuest(questTable)
  if questTable==nil then
    return
  end
  if mvars.gim_isQuestSetup==false then
  end
end
function this.OnActivateQuest(questTable)
  if questTable==nil then
    return
  end
  if mvars.gim_isQuestSetup==false then
    this.InitQuest()
  end
  local questIsSetUp=false
  if mvars.gim_isQuestSetup==false then
    if(questTable.targetGimmicklList and Tpp.IsTypeTable(questTable.targetGimmicklList))and next(questTable.targetGimmicklList)then
      for n,gimmickId in pairs(questTable.targetGimmicklList)do
        local targetInfo={gimmickId=gimmickId,messageId="None",idType="Gimmick"}
        table.insert(mvars.gim_questTargetList,targetInfo)
        TppMarker.SetQuestMarkerGimmick(gimmickId)
      end
      questIsSetUp=true
    end
    if(questTable.targetDevelopList and Tpp.IsTypeTable(questTable.targetDevelopList))and next(questTable.targetDevelopList)then
      for n,developId in pairs(questTable.targetDevelopList)do
        local targetInfo={developId=developId,messageId="None",idType="Develop"}
        table.insert(mvars.gim_questTargetList,targetInfo)
      end
      questIsSetUp=true
    end
    if(questTable.gimmickMarkList and Tpp.IsTypeTable(questTable.gimmickMarkList))and next(questTable.gimmickMarkList)then
      for i,gimmickMarkInfo in pairs(questTable.gimmickMarkList)do
        if gimmickMarkInfo.isStartGimmick==true then
          mvars.gim_questMarkStartName=StrCode32(gimmickMarkInfo.locatorName)
          mvars.gim_questMarkStartLocator=gimmickMarkInfo.locatorName
          mvars.gim_questMarkStartData=gimmickMarkInfo.dataSetName
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,true)
        else
          local targetInfo={locatorName=gimmickMarkInfo.locatorName,dataSetName=gimmickMarkInfo.dataSetName,messageId="None",setIndex=gimmickMarkInfo.setIndex}
          table.insert(mvars.gim_questTargetList,targetInfo)
          questIsSetUp=true
          mvars.gim_questMarkTotalCount=mvars.gim_questMarkTotalCount+1
        end
      end
      questIsSetUp=true
      this.SetQuestInvisibleGimmick(0,true,true)
    end
    if questTable.gimmickTimerList then
      mvars.gim_questDisplayTimeSec=questTable.gimmickTimerList.displayTimeSec
      mvars.gim_questCautionTimeSec=questTable.gimmickTimerList.cautionTimeSec
      questIsSetUp=true
    end
    if questTable.gimmickOffsetType then
      local position,rotation=mtbs_cluster.GetDemoCenter(questTable.gimmickOffsetType,"plnt0")
      Gimmick.SetOffsetPosition(position,rotation)
      if mvars.gim_questMarkStartName then
        Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,false)
      end
      questIsSetUp=true
    end
    if(questTable.containerList and Tpp.IsTypeTable(questTable.containerList))and next(questTable.containerList)then
      for n,container in pairs(questTable.containerList)do
        local locatorName=container.locatorName
        local dataSetName=container.dataSetName
        Gimmick.SetFultonableContainerForMission(locatorName,dataSetName,0,false)
      end
      questIsSetUp=true
    end
  end
  if questIsSetUp==true then
    mvars.gim_isQuestSetup=true
  end
end
function this.OnDeactivateQuest(questTable)
  if mvars.gim_isQuestSetup==true then
    local clearType=this.CheckQuestAllTarget(questTable.questType,nil,true)
    TppQuest.ClearWithSave(clearType)
    this.SetQuestInvisibleGimmick(0,true,true)
  end
end
function this.OnTerminateQuest(questTable)
  if mvars.gim_isQuestSetup==true then
    this.InitQuest()
  end
end
--NMC: gimmickIdentifier = gameId, or collectionUniqueId or
function this.CheckQuestAllTarget(questType,gimmickIdentifier,targetPracticeTimeOut)
  local clearType=TppDefine.QUEST_CLEAR_TYPE.NONE
  local targetPracticeTimeOut=targetPracticeTimeOut or false
  local isPracticeTarget=false
  local currentQuestName=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(currentQuestName)then
    return clearType
  end
  if targetPracticeTimeOut==false then
    if questType==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED then
      for n,targetInfo in pairs(mvars.gim_questTargetList)do
        if targetInfo.idType=="Develop"then
          if gimmickIdentifier==TppCollection.GetUniqueIdByLocatorName(targetInfo.developId)then
            targetInfo.messageId="Recovered"
          end
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE then
      for n,targetInfo in pairs(mvars.gim_questTargetList)do
        local locatorStrCode32=StrCode32(targetInfo.locatorName)
        if gimmickIdentifier==locatorStrCode32 then
          targetInfo.messageId="Break"
          isPracticeTarget=true
          mvars.gim_questMarkCount=mvars.gim_questMarkCount+1
          break
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
      if Tpp.IsFultonContainer(gimmickIdentifier)then
        for i,targetInfo in pairs(mvars.gim_questTargetList)do
          if targetInfo.idType=="Gimmick"then
            local ret,gameId=this.GetGameObjectId(targetInfo.gimmickId)
            if gameId==NULL_ID then
            else
              if gimmickIdentifier==gameId then
                targetInfo.messageId="Recovered"
              end
            end
          end
        end
      end
    end
  end
  if questType==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED or questType==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
    local recoveredCount=0
    local totalCount=0
    for i,targetInfo in pairs(mvars.gim_questTargetList)do
      if targetInfo.messageId=="Recovered"then
        recoveredCount=recoveredCount+1
      end
      totalCount=totalCount+1
    end
    if totalCount>0 then
      if recoveredCount>=totalCount then
        clearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      end
    end
  elseif questType==TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE then
    if isPracticeTarget==true then
      --ORPHAN local unk1={}
      local markedGimmick=true
      for i,targetInfo in pairs(mvars.gim_questTargetList)do
        if targetInfo.setIndex==mvars.gim_questMarkSetIndex then
          if targetInfo.messageId=="None"then
            markedGimmick=false
          end
        end
      end
      if markedGimmick==true then
        if mvars.gim_questMarkCount<mvars.gim_questMarkTotalCount then
          mvars.gim_questMarkSetIndex=mvars.gim_questMarkSetIndex+1
          this.SetQuestInvisibleGimmick(mvars.gim_questMarkSetIndex,false,false)
        end
      end
      if mvars.gim_questMarkCount>=mvars.gim_questMarkTotalCount then
        clearType=TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR
      else
        clearType=TppDefine.QUEST_CLEAR_TYPE.UPDATE
      end
    else
      if targetPracticeTimeOut==true then
        if mvars.gim_isquestMarkStart==true then
          clearType=TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY
        end
      end
    end
  end
  return clearType
end
function this.IsQuestTarget(checkId)
  if mvars.gim_isQuestSetup==false then
    return false
  end
  if not next(mvars.gim_questTargetList)then
    return false
  end
  for i,targetInfo in pairs(mvars.gim_questTargetList)do
    if targetInfo.idType=="Gimmick"then
      local ret,gimmickId=this.GetGameObjectId(targetInfo.gimmickId)
      if gimmickId==checkId then
        return true
      end
    end
  end
  return false
end
function this.SetQuestInvisibleGimmick(questMarkSetIndex,visible,skipCheck)
  local force=skipCheck or false
  for i,targetInfo in pairs(mvars.gim_questTargetList)do
    if questMarkSetIndex==mvars.gim_questMarkSetIndex or force==true then
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,targetInfo.locatorName,targetInfo.dataSetName,visible)
    end
  end
end
function this.SetQuestSootingTargetInvincible(setInvis)
  for i,targetInfo in pairs(mvars.gim_questTargetList)do
    Gimmick.InvincibleGimmickData(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,"mtbs_bord001_vrtn003_ev_gim_i0000|TppPermanentGimmick_mtbs_bord001_vrtn003_ev",targetInfo.dataSetName,setInvis)
    break--NMC wut
  end
end
--NMC no references
function this.IsQuestStartSwitchGimmick(locatorS32)
  if locatorS32==mvars.gim_questMarkStartName then
    return true
  end
  return false
end
function this.StartQuestShootingPractice()
  this.SetQuestInvisibleGimmick(mvars.gim_questMarkSetIndex,false,false)
  mvars.gim_isquestMarkStart=true
end
function this.SetQuestShootingPracticeTargetInvisible()
  this.SetQuestInvisibleGimmick(mvars.gim_questMarkSetIndex,true,true)
end
function this.EndQuestShootingPractice(questClearType)
  if questClearType==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY then
    mvars.gim_isquestMarkStart=false
    for n,targetInfo in pairs(mvars.gim_questTargetList)do
      targetInfo.messageId="None"
    end
    mvars.gim_questMarkCount=0
  end
end
function this.IsStartQuestShootingPractice()
  return mvars.gim_isquestMarkStart
end
function this.GetQuestShootingPracticeCount()
  return mvars.gim_questMarkCount,mvars.gim_questMarkTotalCount
end
function this.SetUpMineQuest(questmineTotalCount)
  if mvars.gim_isQuestSetup==false then
    mvars.gim_questmineCount=0
    mvars.gim_questmineTotalCount=questmineTotalCount
    mvars.gim_isQuestSetup=true
  end
end
function this.OnTerminateMineQuest()
  if mvars.gim_isQuestSetup==true then
    mvars.gim_questmineCount=0
    mvars.gim_questmineTotalCount=0
    mvars.gim_isQuestSetup=false
  end
end
function this.CheckQuestPlaced(mineEquipId,index)
  if this.CheckQuestMine(mineEquipId,index)then
    mvars.gim_questmineCount=mvars.gim_questmineCount+1
    TppUI.ShowAnnounceLog("mine_quest_log",mvars.gim_questmineCount,mvars.gim_questmineTotalCount)
  end
  if mvars.gim_questmineCount>=mvars.gim_questmineTotalCount then
    return true
  else
    return false
  end
end
function this.CheckQuestMine(mineEquipId,index)
  for i,equipId in pairs(TppDefine.QUEST_MINE_TYPE_LIST)do
    if mineEquipId==equipId then
      if TppPlaced.IsQuestBlock(index)then
        return true
      else
        return false
      end
    end
  end
  return false
end
return this

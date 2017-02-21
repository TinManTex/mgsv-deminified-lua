local this={}
local StrCode32=Fox.StrCode32
local IsTypeTable=GameObject.GetTypeIndex
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
  local gimmick=mvars.gim_identifierParamTable[gimmickId]
  if Gimmick.IsBrokenGimmick and gimmick then
    if searchFromSaveData then
      return Gimmick.IsBrokenGimmick(gimmick.type,gimmick.locatorName,gimmick.dataSetName)
    else
      return Gimmick.IsBrokenGimmick(gimmick.type,gimmick.locatorName,gimmick.dataSetName,1)
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
  local gimmickIdParams=mvars.gim_identifierParamTable[gimmickId]
  if Gimmick.ResetGimmick and gimmickIdParams then
    Gimmick.ResetGimmick(gimmickIdParams.type,gimmickIdParams.locatorName,gimmickIdParams.dataSetName)
  end
end
function this.EnableMarkerGimmick(e)
  local e=mvars.gim_identifierParamTable[e]
  if not Gimmick.BreakGimmick then
    return
  end
  Gimmick.EnableMarkerGimmick(e.type,e.locatorName,e.dataSetName,true)
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
      local n=(vars.missionCode==missionCode)
      if n==false then
        if TppMission.IsHardMission(vars.missionCode)then
          local e=TppMission.GetNormalMissionCodeFromHardMission(vars.missionCode)
          n=(e==missionCode)
        end
      end
      this.EnableCollectionTable(collectionNames,n,true)
    end
    do
      local t={"col_develop_Revolver_Shotgun"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local i={"col_develop_Emergencyrescue"}
      local n
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(i,n)
    end
    do
      local t={"col_develop_Antimaterial"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local t={"col_develop_Highprecision_SMG"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local i={"col_develop_FLamethrower"}
      local n
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(i,n)
    end
    do
      local t={"col_develop_HighprecisionAR"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local t={"col_develop_Semiauto_SR"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local i={"col_develop_Shield"}
      local n
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(i,n)
    end
    do
      local i={"col_develop_Shield0000"}
      local n
      local t=TppStory.GetCurrentStorySequence()
      if t>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(i,n)
    end
    do
      local t={"col_develop_Shield0001"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_TO_MATHER_BASE then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
    end
    do
      local t={"col_develop_Shield0002"}
      local n
      local i=TppStory.GetCurrentStorySequence()
      if i>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
        n=true
      else
        n=false
      end
      this.EnableCollectionTable(t,n)
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
      for i,n in pairs(missionCollection)do
        if count2>0 then
          if TppCollection.RepopCountOperation("GetAt",n)>0 then
            TppCollection.RepopCountOperation("SetAt",n,0)
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
  local i=this.MissionCollectionMissionTaskTable[missionCode]
  if not i then
    return
  end
  local e=this.MissionCollectionTable[missionCode]
  for t,n in pairs(e)do
    if TppCollection.IsExistLocator(n)and(TppCollection.RepopCountOperation("GetAt",n)>0)then
      local e=false
      local i=i[t]
      if i=="first"then
        if not svars.isCompleteFirstBonus then
          e=true
        end
      else
        if(svars.mis_objectiveEnable[i]==false)then
          e=true
        end
      end
      if e then
        TppCollection.RepopCountOperation("SetAt",n,0)
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
  if vars.missionCode==10080 or vars.missionCode==11080 then
    this.SetMafrRiverPrimVisibility(false)
  else
    this.SetMafrRiverPrimVisibility(true)
  end
end
function this.SetMafrRiverPrimVisibility(o)
  local e={"cleanRiver","dirtyRiver","oilMud_open","dirtyFlow"}
  local i={true,false,false,false}
  for n,t in ipairs(e)do
    local e
    if o then
      e=i[n]
    else
      e=not i[n]
    end
    TppEffectUtility.SetPrimRiverVisibility(t,e)
  end
  TppEffectUtility.UpdatePrimRiver()
end
function this.SetUpIdentifierTable(e)
  mvars.gim_identifierParamTable={}
  Tpp.MergeTable(mvars.gim_identifierParamTable,e)
  mvars.gim_identifierParamStrCode32Table={}
  mvars.gim_gimmackNameStrCode32Table={}
  for n,t in pairs(e)do
    local e=StrCode32(n)
    mvars.gim_identifierParamStrCode32Table[e]=t
    mvars.gim_gimmackNameStrCode32Table[e]=n
  end
  mvars.gim_identifierTable={}
  for o,e in pairs(e)do
    local n=e.type
    local t=e.locatorName
    local a=e.dataSetName
    mvars.gim_identifierTable[n]=mvars.gim_identifierTable[n]or{}
    local e=mvars.gim_identifierTable[n]e[StrCode32(t)]=e[StrCode32(t)]or{}
    local e=e[StrCode32(t)]e[Fox.PathFileNameCode32(a)]=o
  end
end
function this.SetUpBreakConnectTable(e)
  mvars.gim_breakConnectTable={}
  for n,e in pairs(e)do
    mvars.gim_breakConnectTable[n]=e
    mvars.gim_breakConnectTable[e]=n
  end
end
function this.SetUpCheckBrokenAndBreakConnectTable(n)
  mvars.gim_checkBrokenAndBreakConnectTable={}
  for n,i in pairs(n)do
    this._SetUpCheckBrokenAndBreakConnectTable(n,i)
  end
end
function this._SetUpCheckBrokenAndBreakConnectTable(e,i)
  if not mvars.gim_identifierParamTable[e]then
    return
  end
  local t=i.breakGimmickId
  local n=i.checkBrokenGimmickId
  if not t then
    return
  end
  if not n then
    return
  end
  if not mvars.gim_identifierParamTable[t]then
    return
  end
  if not mvars.gim_identifierParamTable[n]then
    return
  end
  mvars.gim_checkBrokenAndBreakConnectTable[e]=i
  mvars.gim_checkBrokenAndBreakConnectTable[n]={checkBrokenGimmickId=e,breakGimmickId=t}
end
function this.SetUpUseGimmickRouteTable(e)
  mvars.gim_routeGimmickConnectTable={}
  for e,n in pairs(e)do
    mvars.gim_routeGimmickConnectTable[StrCode32(e)]=n.gimmickId
  end
  Tpp.DEBUG_DumpTable(mvars.gim_routeGimmickConnectTable)
end
function this.GetRouteConnectedGimmickId(e)
  if not mvars.gim_routeGimmickConnectTable then
    return
  end
  return mvars.gim_routeGimmickConnectTable[e]
end
function this.SetUpConnectLandingZoneTable(e)
  mvars.gim_connectLandingZoneTable={}
  for n,e in pairs(e)do
    mvars.gim_connectLandingZoneTable[n]=e.aprLandingZoneName
  end
end
function this.SetUpConnectPowerCutTable(e)
  mvars.gim_connectPowerCutAreaTable={}
  mvars.gim_connectPowerCutCpTable={}
  for n,e in pairs(e)do
    local t=e.powerCutAreaName
    local e=e.cpName
    mvars.gim_connectPowerCutAreaTable[n]=t
    if e then
      local i=GetGameObjectId(e)
      if i~=NULL_ID then
        mvars.gim_connectPowerCutCpTable[n]=i
        local i={type="TppCommandPost2"}
        local n=mvars.gim_identifierParamTable[n]
        local e={id="SetPowerSourceGimmick",cpName=e,gimmicks=n,areaName=t}
        GameObject.SendCommand(i,e)
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
  local r={type="TppCommandPost2"}
  for cpName,e in pairs(e)do
    local gimmicks={}
    for e,t in ipairs(e)do
      local e=mvars.gim_identifierParamTable[t]
      if e then
        table.insert(gimmicks,e)
      end
      local e=GetGameObjectId(cpName)
      if e~=NULL_ID then
        mvars.gim_gimmickIdToCpTable[StrCode32(t)]=e
      end
    end
    local isCommunicateBase=e.isCommunicateBase
    local groupName=e.groupName
    local e={id="SetCommunicateGimmick",cpName=cpName,isCommunicateBase=isCommunicateBase,gimmicks=gimmicks,groupName=groupName}
    GameObject.SendCommand(r,e)
  end
end
function this.BreakGimmick(a,n,t,i)
  local n=this.GetGimmickID(a,n,t)
  if not n then
    return
  end
  this.BreakConnectedGimmick(n)
  this.CheckBrokenAndBreakConnectedGimmick(n)
  this.HideAsset(n)
  this.ShowAnnounceLog(n)
  this.UnlockLandingZone(n)
  local t=false
  if(i==NULL_ID)then
    t=true
  end
  this.PowerCut(n,true,t)
  this.SetHeroicAndOrgPoint(n,i)
end
function this.GetGimmickID(gameId,n,i)
  local isTable=IsTypeTable(gameId)
  local gim_identifierTable=mvars.gim_identifierTable
  if not gim_identifierTable then
    return
  end
  local e=gim_identifierTable[isTable]
  if not e then
    return
  end
  local e=e[n]
  if not e then
    return
  end
  local n=e[i]
  if not e then
    return
  end
  return n
end
function this.GetGameObjectId(e)
  local gimmickIdParams=mvars.gim_identifierParamTable[e]
  if not gimmickIdParams then
    return
  end
  return Gimmick.GetGameObjectId(gimmickIdParams.type,gimmickIdParams.locatorName,gimmickIdParams.dataSetName)
end
function this.BreakConnectedGimmick(e)
  local e=mvars.gim_breakConnectTable[e]
  if not e then
    return
  end
  local gimmickIdParams=mvars.gim_identifierParamTable[e]
  Gimmick.BreakGimmick(gimmickIdParams.type,gimmickIdParams.locatorName,gimmickIdParams.dataSetName,false)
end
function this.CheckBrokenAndBreakConnectedGimmick(n)
  if not mvars.gim_checkBrokenAndBreakConnectTable then
    return
  end
  local n=mvars.gim_checkBrokenAndBreakConnectTable[n]
  if not n then
    return
  end
  local checkBrokenGimmickId=n.checkBrokenGimmickId
  local breakGimmickId=n.breakGimmickId
  if this.IsBroken{gimmickId=checkBrokenGimmickId}then
    local gimmickIdParams=mvars.gim_identifierParamTable[breakGimmickId]
    if gimmickIdParams then
      Gimmick.BreakGimmick(gimmickIdParams.type,gimmickIdParams.locatorName,gimmickIdParams.dataSetName,false)
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
function this.SetVisibility(e,n)
  local e=mvars.gim_identifierParamTable[e]
  if not e then
    return
  end
  Gimmick.InvisibleGimmick(e.type,e.locatorName,e.dataSetName,n)
  return true
end
function this.UnlockLandingZone(e)
  if TppLandingZone.IsDisableUnlockLandingZoneOnMission()then
    return
  end
  local e=mvars.gim_connectLandingZoneTable[e]
  if not e then
    return
  end
  local doesExist
  for i,landingZoneName in pairs(e)do
    if TppHelicopter.GetLandingZoneExists{landingZoneName=landingZoneName}then
      TppHelicopter.SetEnableLandingZone{landingZoneName=landingZoneName}
      doesExist=true
    end
  end
  if doesExist then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE)
  end
end
function this.ShowAnnounceLog(n)
  local gimmickType=mvars.gim_identifierParamTable[n].gimmickType
  if not gimmickType then
    return
  end
  local announceType=gimmickToAnnounceType[gimmickType]
  if announceType then
    TppUI.ShowAnnounceLog(announceType)
  end
  this._ShowCommCutOffAnnounceLog(n)
end
function this._ShowCommCutOffAnnounceLog(e)
  if not mvars.gim_gimmickIdToCpTable then
    return
  end
  local e=mvars.gim_gimmickIdToCpTable[StrCode32(e)]
  if not e then
    return
  end
  GameObject.SendCommand(e,{id="SetCommunicateAnnounce"})
end
function this.SwitchGimmick(n,i,t,o)
  local n=this.GetGimmickID(n,i,t)
  if not n then
    return
  end
  local i=false
  if(o==0)then
    i=true
  end
  this.PowerCut(n,i,false)
end
function this.PowerCut(e,n,i)
  local e=mvars.gim_connectPowerCutAreaTable[e]
  if e then
    if n then
      Gimmick.PowerCutOn(e,i)
    else
      Gimmick.PowerCutOff(e)
    end
  end
end
function this.SetHeroicAndOrgPoint(n,e)
  if e==NULL_ID then
    return
  end
  local e=mvars.gim_identifierParamTable[n].gimmickType
  if not e then
    return
  end
  TppHero.AnnounceBreakGimmickByGimmickType(e)
end
function this.EnableCollectionTable(collectionNames,e,o)
  local n=0
  if not e then
    n=1
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
  for t,locator in pairs(collectionNames)do
    if TppCollection.IsExistLocator(locator)then
      if not IsGotKeyItem(locator)or o then
        TppCollection.RepopCountOperation("SetAt",locator,n)
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
function this.OnAllocateQuest(e)
  if e==nil then
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
  local t=false
  if mvars.gim_isQuestSetup==false then
    if(questTable.targetGimmicklList and Tpp.IsTypeTable(questTable.targetGimmicklList))and next(questTable.targetGimmicklList)then
      for n,gimmickId in pairs(questTable.targetGimmicklList)do
        local targetInfo={gimmickId=gimmickId,messageId="None",idType="Gimmick"}
        table.insert(mvars.gim_questTargetList,targetInfo)
        TppMarker.SetQuestMarkerGimmick(gimmickId)
      end
      t=true
    end
    if(questTable.targetDevelopList and Tpp.IsTypeTable(questTable.targetDevelopList))and next(questTable.targetDevelopList)then
      for n,e in pairs(questTable.targetDevelopList)do
        local e={developId=e,messageId="None",idType="Develop"}
        table.insert(mvars.gim_questTargetList,e)
      end
      t=true
    end
    if(questTable.gimmickMarkList and Tpp.IsTypeTable(questTable.gimmickMarkList))and next(questTable.gimmickMarkList)then
      for n,e in pairs(questTable.gimmickMarkList)do
        if e.isStartGimmick==true then
          mvars.gim_questMarkStartName=StrCode32(e.locatorName)
          mvars.gim_questMarkStartLocator=e.locatorName
          mvars.gim_questMarkStartData=e.dataSetName
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,true)
        else
          local e={locatorName=e.locatorName,dataSetName=e.dataSetName,messageId="None",setIndex=e.setIndex}
          table.insert(mvars.gim_questTargetList,e)
          t=true
          mvars.gim_questMarkTotalCount=mvars.gim_questMarkTotalCount+1
        end
      end
      t=true
      this.SetQuestInvisibleGimmick(0,true,true)
    end
    if questTable.gimmickTimerList then
      mvars.gim_questDisplayTimeSec=questTable.gimmickTimerList.displayTimeSec
      mvars.gim_questCautionTimeSec=questTable.gimmickTimerList.cautionTimeSec
      t=true
    end
    if questTable.gimmickOffsetType then
      local n,e=mtbs_cluster.GetDemoCenter(questTable.gimmickOffsetType,"plnt0")
      Gimmick.SetOffsetPosition(n,e)
      if mvars.gim_questMarkStartName then
        Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,mvars.gim_questMarkStartLocator,mvars.gim_questMarkStartData,false)
      end
      t=true
    end
    if(questTable.containerList and Tpp.IsTypeTable(questTable.containerList))and next(questTable.containerList)then
      for n,container in pairs(questTable.containerList)do
        local locatorName=container.locatorName
        local dataSetName=container.dataSetName
        Gimmick.SetFultonableContainerForMission(locatorName,dataSetName,0,false)
      end
      t=true
    end
  end
  if t==true then
    mvars.gim_isQuestSetup=true
  end
end
function this.OnDeactivateQuest(n)
  if mvars.gim_isQuestSetup==true then
    local clearType=this.CheckQuestAllTarget(n.questType,nil,true)
    TppQuest.ClearWithSave(clearType)
    this.SetQuestInvisibleGimmick(0,true,true)
  end
end
function this.OnTerminateQuest(questTable)
  if mvars.gim_isQuestSetup==true then
    this.InitQuest()
  end
end
function this.CheckQuestAllTarget(questType,a,l)
  local clearType=TppDefine.QUEST_CLEAR_TYPE.NONE
  local r=l or false
  local l=false
  local currentQuestName=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(currentQuestName)then
    return clearType
  end
  if r==false then
    if questType==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED then
      for n,e in pairs(mvars.gim_questTargetList)do
        if e.idType=="Develop"then
          if a==TppCollection.GetUniqueIdByLocatorName(e.developId)then
            e.messageId="Recovered"
            end
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE then
      for n,e in pairs(mvars.gim_questTargetList)do
        local locatorStrCode32=StrCode32(e.locatorName)
        if a==locatorStrCode32 then
          e.messageId="Break"
          l=true
          mvars.gim_questMarkCount=mvars.gim_questMarkCount+1
          break
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
      if Tpp.IsFultonContainer(a)then
        for i,n in pairs(mvars.gim_questTargetList)do
          if n.idType=="Gimmick"then
            local i,e=this.GetGameObjectId(n.gimmickId)
            if e==NULL_ID then
            else
              if a==e then
                n.messageId="Recovered"
                end
            end
          end
        end
      end
    end
  end
  if questType==TppDefine.QUEST_TYPE.DEVELOP_RECOVERED or questType==TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
    local n=0
    local e=0
    for t,i in pairs(mvars.gim_questTargetList)do
      if i.messageId=="Recovered"then
        n=n+1
      end
      e=e+1
    end
    if e>0 then
      if n>=e then
        clearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      end
    end
  elseif questType==TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE then
    if l==true then
      local n={}
      local n=true
      for i,e in pairs(mvars.gim_questTargetList)do
        if e.setIndex==mvars.gim_questMarkSetIndex then
          if e.messageId=="None"then
            n=false
          end
        end
      end
      if n==true then
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
      if r==true then
        if mvars.gim_isquestMarkStart==true then
          clearType=TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY
        end
      end
    end
  end
  return clearType
end
function this.IsQuestTarget(i)
  if mvars.gim_isQuestSetup==false then
    return false
  end
  if not next(mvars.gim_questTargetList)then
    return false
  end
  for t,n in pairs(mvars.gim_questTargetList)do
    if n.idType=="Gimmick"then
      local n,e=this.GetGameObjectId(n.gimmickId)
      if e==i then
        return true
      end
    end
  end
  return false
end
function this.SetQuestInvisibleGimmick(t,i,e)
  local n=e or false
  for o,e in pairs(mvars.gim_questTargetList)do
    if t==mvars.gim_questMarkSetIndex or n==true then
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.locatorName,e.dataSetName,i)
    end
  end
end
function this.SetQuestSootingTargetInvincible(n)
  for i,e in pairs(mvars.gim_questTargetList)do
    Gimmick.InvincibleGimmickData(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,"mtbs_bord001_vrtn003_ev_gim_i0000|TppPermanentGimmick_mtbs_bord001_vrtn003_ev",e.dataSetName,n)
    break--NMC wut
  end
end
function this.IsQuestStartSwitchGimmick(e)
  if e==mvars.gim_questMarkStartName then
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
    for n,e in pairs(mvars.gim_questTargetList)do
      e.messageId="None"
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
function this.CheckQuestPlaced(mineEquipId,n)
  if this.CheckQuestMine(mineEquipId,n)then
    mvars.gim_questmineCount=mvars.gim_questmineCount+1
    TppUI.ShowAnnounceLog("mine_quest_log",mvars.gim_questmineCount,mvars.gim_questmineTotalCount)
  end
  if mvars.gim_questmineCount>=mvars.gim_questmineTotalCount then
    return true
  else
    return false
  end
end
function this.CheckQuestMine(mineEquipId,e)
  for n,equipId in pairs(TppDefine.QUEST_MINE_TYPE_LIST)do
    if mineEquipId==equipId then
      if TppPlaced.IsQuestBlock(e)then
        return true
      else
        return false
      end
    end
  end
  return false
end
return this

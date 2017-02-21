local this={}
local StrCode32=Fox.StrCode32
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local SendCommand=GameObject.SendCommand
this.GoalTypes={none="GOAL_NONE",moving="GOAL_MOVE",attack="GOAL_ATTACK",defend="GOAL_DEFENSE",moving_fix="GOAL_MOVE_FIX"}
this.ViewTypes={map={"VIEW_MAP_GOAL"},all={"VIEW_MAP_GOAL","VIEW_WORLD_GOAL"},map_only_icon={"VIEW_MAP_ICON"},map_and_world_only_icon={"VIEW_MAP_ICON","VIEW_WORLD_ICON"}}
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="LookingTarget",func=function(r,a)
        this._OnSearchTarget(a,r,"LookingTarget")
      end}
    },
    GameObject={
      {msg="Carried",func=function(a,r)
        if r==0 then
          this._OnSearchTarget(a,nil,"Carried")
        end
      end},
      {msg="Restraint",func=function(a,r)
        if r==0 then
          this._OnSearchTarget(a,nil,"Restraint")
        end
      end}
    },
    Marker={{msg="ChangeToEnable",func=this._OnMarkerChangeToEnable}},
    nil
  }
end
--NMC: radiusLevel- 0-9, randomLevel matches
function this.Enable(gameObjectName,radiusLevel,goalType,viewType,randomLevel,setImportant,setNew,mapRadioName,langId,goalLangId,setInterrogation)
  local gameId
  if Tpp.IsTypeString(gameObjectName)then
    gameId=GetGameObjectId(gameObjectName)
  elseif Tpp.IsTypeNumber(gameObjectName)then
    gameId=gameObjectName
  else
    return
  end
  if gameId==NULL_ID then
    return
  end
  if(not this._CanSetMarker(gameId))then
    return
  end
  radiusLevel=radiusLevel or 0
  goalType=goalType or"moving"
  viewType=viewType or"map"
  randomLevel=randomLevel or 9
  if(type(radiusLevel)~="number")then
    return
  end
  if(radiusLevel<0 or radiusLevel>9)then
    return
  end
  if(type(randomLevel)~="number")then
    return
  end
  if(randomLevel<0 or randomLevel>9)then
    return
  end
  local goalType=this.GoalTypes[goalType]
  if(goalType==nil)then
    return
  end
  local viewLayer=this.ViewTypes[viewType]
  if(viewLayer==nil)then
    return
  end
  TppMarker2System.EnableMarker{gameObjectId=gameId,viewLayer=viewLayer}
  local markerGoalType={gameObjectId=gameId,radiusLevel=radiusLevel,goalType=goalType,randomLevel=randomLevel}
  TppMarker2System.SetMarkerGoalType(markerGoalType)
  if setImportant~=nil then
    local markerImportant={gameObjectId=gameId,isImportant=setImportant}
    TppMarker2System.SetMarkerImportant(markerImportant)
  end
  if setNew~=nil then
    local markerNew={gameObjectId=gameId,isNew=setNew}
    TppMarker2System.SetMarkerNew(markerNew)
  end
  if setInterrogation~=nil then
    local markerInterrogation={gameObjectId=gameId,isInterrogation=setInterrogation}
    if TppMarker2System.SetMarkerInterrogation then
      TppMarker2System.SetMarkerInterrogation(markerInterrogation)
    end
  end
  if mapRadioName~=nil then
    local strCodeName=StrCode32(mapRadioName)
    TppUiCommand.RegisterMapRadio(gameId,strCodeName)
  end
  if langId~=nil then
    if goalLangId~=nil then
      TppUiCommand.RegisterIconUniqueInformation{markerId=gameId,iconLangId=langId,goalLangId=goalLangId}
    else
      TppUiCommand.RegisterIconUniqueInformation{markerId=gameId,langId=langId}
    end
  elseif goalLangId~=nil then
    TppUiCommand.RegisterIconUniqueInformation{markerId=gameId,goalLangId=goalLangId}
  end
end
function this.Disable(gameId,unregisterMapRadio,isLocator)
  local gameObjectId
  if IsTypeString(gameId)then
    gameObjectId=GetGameObjectId(gameId)
  elseif IsTypeNumber(gameId)then
    gameObjectId=gameId
  end
  if gameObjectId==NULL_ID then
    return
  end
  if(not this._CanSetMarker(gameObjectId))then
    return
  end
  if Tpp.IsMarkerLocator(gameObjectId)or isLocator then
    TppMarker2System.DisableMarker{gameObjectId=gameObjectId}
  else
    TppMarker2System.SetMarkerImportant{gameObjectId=gameObjectId,isImportant=false}
  end
  TppUiCommand.UnRegisterIconUniqueInformation(gameObjectId)
  if unregisterMapRadio~=nil then
    TppUiCommand.UnregisterMapRadio(gameObjectId)
  end
end
function this.DisableAll()
  TppMarker2System.DisableAllMarker()
end
function this.SetUpSearchTarget(searchTargetInfos)
  if IsTypeTable(searchTargetInfos)then
    for a,searchTarget in pairs(searchTargetInfos)do
      mvars.mar_searchTargetPrePareList[searchTarget.gameObjectName]={
        gameObjectName=searchTarget.gameObjectName,
        gameObjectType=searchTarget.gameObjectType,
        messageName=searchTarget.messageName,
        skeletonName=searchTarget.skeletonName,
        offSet=searchTarget.offSet,
        targetFox2Name=searchTarget.targetFox2Name,
        doDirectionCheck=searchTarget.doDirectionCheck,
        objectives=searchTarget.objectives,
        func=searchTarget.func,
        notImportant=searchTarget.notImportant,
        wideCheckRange=searchTarget.wideCheckRange
      }
    end
  end
end
function this.CompleteSearchTarget(targetName)
  local gameId=GetGameObjectId(targetName)
  if gameId~=NULL_ID then
    this._OnSearchTarget(gameId,nil,"script")
  end
end
function this.EnableSearchTarget(a)
  if not this._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==StrCode32(a)then
      svars.mar_searchTargeEnable[e]=true
      return
    end
  end
end
function this.DisableSearchTarget(a)
  if not this._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==StrCode32(a)then
      svars.mar_searchTargeEnable[e]=false
      return
    end
  end
end
function this.GetSearchTargetIsFound(a)
  if not this._IsCheckSVarsSearchTargetName(a)then
    return
  end
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==StrCode32(a)then
      return svars.mar_searchTargeIsFound[e]
    end
  end
  return false
end
function this.SetQuestMarker(targetNameOrId)
  local targetId
  if Tpp.IsTypeString(targetNameOrId)then
    targetId=GetGameObjectId(targetNameOrId)
  elseif Tpp.IsTypeNumber(targetNameOrId)then
    targetId=targetNameOrId
  end
  if targetId==NULL_ID then
  else
    local markerInfo={gameObjectId=targetId,isImportant=true,isQuestImportant=true}
    TppMarker2System.SetMarkerImportant(markerInfo)
  end
end
function this.SetQuestMarkerGimmick(gimmickId)
  local a,gimmickId=TppGimmick.GetGameObjectId"q40010_cntn001"
  if gimmickId==NULL_ID then
  else
    local markerInfo={gameObjectId=gimmickId,isImportant=true,isQuestImportant=true}
    TppMarker2System.SetMarkerImportant(markerInfo)
  end
end
function this.EnableQuestTargetMarker(name)
  local gameId
  if Tpp.IsTypeString(name)then
    gameId=GetGameObjectId(name)
  elseif Tpp.IsTypeNumber(name)then
    gameId=name
  end
  if gameId==NULL_ID then
  else
    this.Enable(gameId,0,"defend","map_and_world_only_icon",0,false,true)
    this.SetQuestMarker(gameId)
    TppUI.ShowAnnounceLog("updateMap",nil,nil,1)
  end
end
function this.DeclareSVars()
  return{{name="mar_searchTargetName",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_searchTargeEnable",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_searchTargeIsFound",arraySize=TppDefine.SEARCH_TARGET_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mar_locatorMarker",arraySize=100,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.OnAllocate()
  mvars.mar_searchTargetList={}
  mvars.mar_searchTargetPrePareList={}
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMissionCanStart()
  for targetGameObjectName,searchTarget in pairs(mvars.mar_searchTargetPrePareList)do
    local targetGameId=GetGameObjectId(targetGameObjectName)
    if targetGameId==NULL_ID then
    else
      mvars.mar_searchTargetList[targetGameId]=searchTarget
      if not this._IsCheckSVarsSearchTargetName(targetGameObjectName)then
        for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
          if svars.mar_searchTargetName[e]==0 then
            svars.mar_searchTargetName[e]=StrCode32(targetGameObjectName)break
          end
        end
      end
      if not this._IsCheckSVarsSearchTarget(targetGameId,"mar_searchTargeIsFound")then
        TppPlayer.SetSearchTarget(targetGameObjectName,searchTarget.gameObjectType,searchTarget.messageName,searchTarget.skeletonName,searchTarget.offSet,searchTarget.targetFox2Name,searchTarget.doDirectionCheck,searchTarget.wideCheckRange)
        this.EnableSearchTarget(targetGameObjectName)
      end
    end
  end
  mvars.mar_searchTargetPrePareList=nil
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.RestoreMarkerLocator()
  if this.IsExistMarkerLocatorSystem()then
    local e={type="TppMarker2LocatorSystem"}
    SendCommand(e,{id="RestoreFromSVars"})
  end
end
function this.StoreMarkerLocator()
  if this.IsExistMarkerLocatorSystem()then
    local e={type="TppMarker2LocatorSystem"}
    SendCommand(e,{id="StoreToSVars"})
  end
end
function this.IsExistMarkerLocatorSystem()
  if GameObject.GetGameObjectIdByIndex("TppMarker2LocatorSystem",0)~=NULL_ID then
    return true
  else
    return false
  end
end
function this._OnSearchTarget(gameId,t,s)
  if not mvars.mar_searchTargetList[gameId]then
    return
  end
  if this._IsCheckSVarsSearchTarget(gameId,"mar_searchTargeIsFound")then
    return
  end
  if not this._IsCheckSVarsSearchTarget(gameId,"mar_searchTargeEnable")then
    return
  end
  for n=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local r=this._GetStrCode32SearchTargetName(gameId)
    if svars.mar_searchTargetName[n]==r then
      if mvars.mar_searchTargetList[gameId].objectives==nil then
        local isImportant
        if mvars.mar_searchTargetList[gameId].notImportant then
          isImportant=false
        else
          isImportant=true
        end
        this.Enable(mvars.mar_searchTargetList[gameId].gameObjectName,0,"moving","map_and_world_only_icon",0,isImportant,true)
      else
        local objectives={}
        if IsTypeTable(mvars.mar_searchTargetList[gameId].objectives)then
          objectives=mvars.mar_searchTargetList[gameId].objectives
        else
          table.insert(objectives,mvars.mar_searchTargetList[gameId].objectives)
        end
        TppMission.UpdateObjective{objectives=objectives}
      end
      if mvars.mar_searchTargetList[gameId].func then
        mvars.mar_searchTargetList[gameId].func(t,gameId,s)
      end
      TppSoundDaemon.PostEvent"sfx_s_enemytag_main_tgt"
      this._CallSearchTargetEnabledRadio(gameId)
      svars.mar_searchTargeIsFound[n]=true
      return
    end
  end
end
function this._GetStrCode32SearchTargetName(gameId)
  for r,targetInfo in pairs(mvars.mar_searchTargetList)do
    local targetNane=targetInfo.gameObjectName
    if gameId==GetGameObjectId(targetNane)then
      return StrCode32(targetNane)
    end
  end
  return nil
end
function this._IsCheckSVarsSearchTargetName(targetName)
  local targetNameStr32=StrCode32(targetName)
  for e=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    if svars.mar_searchTargetName[e]==targetNameStr32 then
      return true
    end
  end
  return false
end
function this._IsCheckSVarsSearchTarget(a,svarName)
  local n=this._GetStrCode32SearchTargetName(a)
  if n==nil then
    return false
  end
  for a=0,TppDefine.SEARCH_TARGET_COUNT-1 do
    local e=false
    if svarName==nil then
      e=true
    else
      e=svars[svarName][a]
    end
    if svars.mar_searchTargetName[a]==n and e then
      return true
    end
  end
  return false
end
function this._OnMarkerChangeToEnable(n,n,gameId,a)
  if a==Fox.StrCode32"Player"then
    this._CallMarkerRadio(gameId)
  end
end
function this._CallMarkerRadio(gameId)
  if not this._IsRadioTarget(gameId)then
    return
  end
  if mvars.mar_searchTargetList[gameId]and this._IsCheckSVarsSearchTarget(gameId,"mar_searchTargeEnable")then
    if not this._IsCheckSVarsSearchTarget(gameId,"mar_searchTargeIsFound")then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_MARKED)
    end
  else
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
  end
end
function this._CallSearchTargetEnabledRadio(gameId)
  if not this._IsRadioTarget(gameId)then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED)
end
function this._IsRadioTarget(gameId)
  local isEliminateTarget=TppEnemy.IsEliminateTarget(gameId)
  local isRescueTarget=TppEnemy.IsRescueTarget(gameId)
  if not isEliminateTarget and not isRescueTarget then
    return false
  end
  return true
end
function this._CanSetMarker(gameId)
  if Tpp.IsVehicle(gameId)then
    return TppEnemy.IsVehicleAlive(gameId)
  else
    return true
  end
end
return this

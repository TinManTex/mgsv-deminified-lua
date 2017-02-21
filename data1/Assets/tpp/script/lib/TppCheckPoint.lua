local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeFunc=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local n=GameObject.SendCommand
local n=Tpp.DEBUG_StrCode32ToString
local IsHelicopter=Tpp.IsHelicopter
local IsNotAlert=Tpp.IsNotAlert
local s=0
function this.DeclareSVars()
  return{
    {name="chk_checkPointName",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="chk_checkPointEnable",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_BOOL,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.Messages()
  if not mvars.loc_locationCommonCheckPointList then
    return nil
  end
  local n={}
  for t,i in pairs(mvars.loc_locationCommonCheckPointList)do
    if mvars.mis_baseList and this._DoesBaseListInclude(t)then
      for t,i in pairs(i)do
        local t="trap_"..i
        local e={msg="Enter",sender=t,
          func=function(n,n)
            this.Update{checkPoint=i,trapName=t,safetyCurrentPosition=true}
          end
        }
        table.insert(n,e)
      end
      table.insert(n,nil)
    end
  end
  return Tpp.StrCode32Table{Trap=n}
end
function this.OnAllocate()
  mvars.mis_checkPointList={}
end
function this.Init()
  local messagesTable=this.Messages()
  if messagesTable then
    this.messageExecTable=Tpp.MakeMessageExecTable(messagesTable)
  end
end
function this.OnReload()
  local n=this.Messages()
  if n then
    this.messageExecTable=Tpp.MakeMessageExecTable(n)
  end
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Enable(n)
  this._SetEnable(n,true)
end
function this.Disable(n)
  this._SetEnable(n,false)
end
function this.Reset()
  gvars.mis_checkPoint=s
end
function this.RegisterCheckPointList(n)
  local n=n or{}
  for t,n in pairs(n)do
    this._RegisterCheckPoint(n)
  end
  if IsTypeFunc(mvars.mis_baseList)then
    for t,n in pairs(mvars.mis_baseList)do
      if mvars.loc_locationCommonCheckPointList and mvars.loc_locationCommonCheckPointList[n]then
        for t,n in pairs(mvars.loc_locationCommonCheckPointList[n])do
          this._RegisterCheckPoint(n)
        end
      end
    end
  end
  if next(mvars.mis_checkPointList)then
    mvars.mis_checkPointList=Tpp.Enum(mvars.mis_checkPointList)
  end
end
function this.SetCheckPointPosition()
  if mvars.mis_checkPointList==nil then
    return
  end
  local n
  for t,e in pairs(mvars.mis_checkPointList)do
    if StrCode32(e)==gvars.mis_checkPoint then
      n=e
      break
    end
  end
  if n==nil then
    return
  end
  local e,n=this.GetCheckPointLocator(n)
  if e then
    TppPlayer.SetInitialPosition(e,n)
  end
end
function this.GetCheckPointLocator(e)--NMC returns position,rotation
  if not IsTypeString(e)then
    return
  end
  return Tpp.GetLocator("CheckPointIdentifier",e.."_Player")
end
function this.FindNearestCheckPoint(checkPoint)
  if not IsTypeFunc(checkPoint)then
    return
  end
  local maxDist,o=65526,1600
  local closestDist,closest=maxDist,nil
  for a,checkpointName in pairs(checkPoint)do
    if IsTypeString(checkpointName)then
      local checkpointPoint,rotation=this.GetCheckPointLocator(checkpointName)
      if checkpointPoint then
        local playerPos=TppPlayer.GetPosition()
        local distSqr=TppMath.FindDistance(checkpointPoint,playerPos)
        if distSqr<closestDist then
          closestDist=distSqr
          closest=checkpointName
        end
      end
    end
  end
  if closest then
    return closest
  end
end
function this.IsEnable(e)
  local n
  if IsTypeString(e)then
    n=StrCode32(e)
  else
    n=e
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==n then
      return svars.chk_checkPointEnable[e]
    end
  end
  return false
end
function this.Update(n)
  local checkPoint
  local ignoreAlert
  local permitHelicopter
  local atCurrentPosition
  local safetyCurrentPosition
  local trapName
  if IsTypeString(n)then
    checkPoint=n
  elseif IsTypeFunc(n)then
    checkPoint=n.checkPoint
    ignoreAlert=n.ignoreAlert
    permitHelicopter=n.permitHelicopter
    atCurrentPosition=n.atCurrentPosition
    safetyCurrentPosition=n.safetyCurrentPosition
    trapName=n.trapName
  else
    return
  end
  if checkPoint~=nil and not this.IsEnable(checkPoint)then
    return
  end
  local isSyncDefMissionClear,isSyncMissionClearType,isSyncDefGameOver,isSyncGameOverType=TppMission.GetSyncMissionStatus()
  if isSyncDefGameOver then
    return
  end
  if not permitHelicopter and IsHelicopter(vars.playerVehicleGameObjectId)then
    return
  end
  if not ignoreAlert and not IsNotAlert()then
    return
  end
  local saveBusy
  if atCurrentPosition then
    this.Reset()
    TppPlayer.SetInitialPositionToCurrentPosition()
  elseif safetyCurrentPosition then
    if Gimmick.IsVehicleFultonUpdating()then
      return
    end
    if Player.CanSaveAsCheckPoint and Player.CanSaveAsCheckPoint()then
      this.Reset()
      TppPlayer.SetInitialPositionToCurrentPosition()
      Player.NotifyCheckPointTrapName(trapName)
      local gameSaveFileName=TppSave.GetGameSaveFileName()
      if TppSave.IsSavingWithFileName(gameSaveFileName)or TppSave.HasQueue(gameSaveFileName)then
        saveBusy=true
      end
    end
  else
    if not mvars.mis_checkPointList then
      return
    end
    if not mvars.mis_checkPointList[checkPoint]then
      return
    end
    gvars.mis_checkPoint=StrCode32(checkPoint)
    this.SetCheckPointPosition()
  end
  TppMission.VarSaveOnUpdateCheckPoint(saveBusy)
  GkEventTimerManager.Start("Timer_UpdateCheckPoint",.01)
end
function this.UpdateAtCurrentPosition()
  this.Update{atCurrentPosition=true}
end
function this.DEBUG_Init()
  mvars.debug.showCheckPointList=false;(nil).AddDebugMenu("LuaCheckPoint","CHK.showCheckPointList","bool",mvars.debug,"showCheckPointList")
end
function this.DebugUpdate()
  local i=(nil).NewContext()
  if mvars.debug.showCheckPointList then
    (nil).Print(i,{.5,.5,1},"TppCheckPoint: showCheckPointList")
    for o,n in pairs(mvars.mis_checkPointList)do
      if IsTypeString(n)and this.IsEnable(n)then(nil).Print(i,{1,1,1},n)
      end
    end
  end
end
function this._SetEnable(n,o)
  if not n then
    return
  end
  if IsTypeFunc(n)then
    if n.baseName then
      if IsTypeFunc(n.baseName)then
        for t,n in pairs(n.baseName)do
          this._SetEnable({baseName=n},o)
        end
      else
        if this._DoesBaseListInclude(n.baseName)then
          for t,n in pairs(mvars.loc_locationCommonCheckPointList[n.baseName])do
            this._SetEnable({checkPointName=n},o)
          end
        end
      end
    end
    if n.checkPointName then
      if IsTypeFunc(n.checkPointName)then
        for t,n in pairs(n.checkPointName)do
          this._SetEnable({checkPointName=n},o)
        end
      else
        local checkpointNameStr32
        if IsTypeString(n.checkPointName)then
          checkpointNameStr32=StrCode32(n.checkPointName)
        else
          checkpointNameStr32=n.checkPointName
        end
        if checkpointNameStr32 and checkpointNameStr32~=0 then
          for n=0,TppDefine.CHECK_POINT_MAX-1 do
            if svars.chk_checkPointName[n]==checkpointNameStr32 then
              svars.chk_checkPointEnable[n]=o
              return
            end
          end
        end
      end
    end
  end
end
function this._RegisterCheckPoint(n)
  if not n then
    return
  end
  table.insert(mvars.mis_checkPointList,n)
  local o
  if IsTypeString(n)then
    o=StrCode32(n)
  else
    o=n
  end
  if this._DoesCheckPointListInclude(o)then
    return
  end
  if IsTypeFunc(svars.chk_checkPointName)then
    local e=0
    for n=0,TppDefine.CHECK_POINT_MAX-1 do
      if svars.chk_checkPointName[n]==0 then
        e=n
        break
      end
    end
    svars.chk_checkPointName[e]=o
    svars.chk_checkPointEnable[e]=true
  end
end
function this._DoesBaseListInclude(n)
  if mvars.mis_baseList==nil then
    return
  end
  for t,e in pairs(mvars.mis_baseList)do
    if e==n then
      return true
    end
  end
  return false
end
function this._DoesCheckPointListInclude(e)
  if not e then
    return false
  end
  local checkPointNameStr32
  if IsTypeString(e)then
    checkPointNameStr32=StrCode32(e)
  else
    checkPointNameStr32=e
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==checkPointNameStr32 then
      return true
    end
  end
  return false
end
return this

--TppCheckPoint.lua
local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeFunc=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
--ORPHANS
--local GetGameObjectId=GameObject.GetGameObjectId
--local NULL_ID=GameObject.NULL_ID
--local SendCommand=GameObject.SendCommand
--ORPHAN local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
local IsHelicopter=Tpp.IsHelicopter
local IsNotAlert=Tpp.IsNotAlert
local zero=0
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
  local trapMessageTable={}
  for baseName,checkPointNames in pairs(mvars.loc_locationCommonCheckPointList)do
    if mvars.mis_baseList and this._DoesBaseListInclude(baseName)then
      for i,checkPoint in pairs(checkPointNames)do
        local trapName="trap_"..checkPoint
        local message={msg="Enter",sender=trapName,
          func=function(trap,gameId)
            this.Update{checkPoint=checkPoint,trapName=trapName,safetyCurrentPosition=true}
          end
        }
        table.insert(trapMessageTable,message)
      end
      table.insert(trapMessageTable,nil)
    end
  end
  return Tpp.StrCode32Table{Trap=trapMessageTable}
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
function this.Enable(enableInfo)
  this._SetEnable(enableInfo,true)
end
function this.Disable(enableInfo)
  this._SetEnable(enableInfo,false)
end
function this.Reset()
  gvars.mis_checkPoint=zero
end
--missionTable.sequence.checkPointList
function this.RegisterCheckPointList(checkPointList)
  local checkPointList=checkPointList or{}
  for i,checkPointName in pairs(checkPointList)do
    this._RegisterCheckPoint(checkPointName)
  end
  if IsTypeFunc(mvars.mis_baseList)then
    for i,baseName in pairs(mvars.mis_baseList)do
      if mvars.loc_locationCommonCheckPointList and mvars.loc_locationCommonCheckPointList[baseName]then
        for j,checkpointName in pairs(mvars.loc_locationCommonCheckPointList[baseName])do
          this._RegisterCheckPoint(checkpointName)
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
  local currentCheckPoint
  for i,checkPointName in pairs(mvars.mis_checkPointList)do
    if StrCode32(checkPointName)==gvars.mis_checkPoint then
      currentCheckPoint=checkPointName
      break
    end
  end
  if currentCheckPoint==nil then
    return
  end
  local pos,rotY=this.GetCheckPointLocator(currentCheckPoint)
  if pos then
    TppPlayer.SetInitialPosition(pos,rotY)
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
function this.IsEnable(checkPointName)
  local checkPointStr32
  if IsTypeString(checkPointName)then
    checkPointStr32=StrCode32(checkPointName)
  else
    checkPointStr32=checkPointName
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==checkPointStr32 then
      return svars.chk_checkPointEnable[e]
    end
  end
  return false
end
function this.Update(checkPointInfo)
  local checkPoint
  local ignoreAlert
  local permitHelicopter
  local atCurrentPosition
  local safetyCurrentPosition
  local trapName
  if IsTypeString(checkPointInfo)then
    checkPoint=checkPointInfo
  elseif IsTypeFunc(checkPointInfo)then
    checkPoint=checkPointInfo.checkPoint
    ignoreAlert=checkPointInfo.ignoreAlert
    permitHelicopter=checkPointInfo.permitHelicopter
    atCurrentPosition=checkPointInfo.atCurrentPosition
    safetyCurrentPosition=checkPointInfo.safetyCurrentPosition
    trapName=checkPointInfo.trapName
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
  mvars.debug.showCheckPointList=false
  ;(nil).AddDebugMenu("LuaCheckPoint","CHK.showCheckPointList","bool",mvars.debug,"showCheckPointList")
end
function this.DebugUpdate()
  local newContext=(nil).NewContext()
  if mvars.debug.showCheckPointList then
    (nil).Print(newContext,{.5,.5,1},"TppCheckPoint: showCheckPointList")
    for i,checkPointName in pairs(mvars.mis_checkPointList)do
      if IsTypeString(checkPointName)and this.IsEnable(checkPointName)then
      (nil).Print(newContext,{1,1,1},checkPointName)
      end
    end
  end
end
function this._SetEnable(enableInfo,enable)
  if not enableInfo then
    return
  end
  if IsTypeFunc(enableInfo)then
    if enableInfo.baseName then
      if IsTypeFunc(enableInfo.baseName)then
        for i,baseName in pairs(enableInfo.baseName)do
          this._SetEnable({baseName=baseName},enable)
        end
      else
        if this._DoesBaseListInclude(enableInfo.baseName)then
          for i,checkPointName in pairs(mvars.loc_locationCommonCheckPointList[enableInfo.baseName])do
            this._SetEnable({checkPointName=checkPointName},enable)
          end
        end
      end
    end
    if enableInfo.checkPointName then
      if IsTypeFunc(enableInfo.checkPointName)then
        for t,checkPointName in pairs(enableInfo.checkPointName)do
          this._SetEnable({checkPointName=checkPointName},enable)
        end
      else
        local checkpointNameStr32
        if IsTypeString(enableInfo.checkPointName)then
          checkpointNameStr32=StrCode32(enableInfo.checkPointName)
        else
          checkpointNameStr32=enableInfo.checkPointName
        end
        if checkpointNameStr32 and checkpointNameStr32~=0 then
          for n=0,TppDefine.CHECK_POINT_MAX-1 do
            if svars.chk_checkPointName[n]==checkpointNameStr32 then
              svars.chk_checkPointEnable[n]=enable
              return
            end
          end
        end
      end
    end
  end
end
function this._RegisterCheckPoint(checkPointName)
  if not checkPointName then
    return
  end
  table.insert(mvars.mis_checkPointList,checkPointName)
  local checkPointStr32
  if IsTypeString(checkPointName)then
    checkPointStr32=StrCode32(checkPointName)
  else
    checkPointStr32=checkPointName
  end
  if this._DoesCheckPointListInclude(checkPointStr32)then
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
    svars.chk_checkPointName[e]=checkPointStr32
    svars.chk_checkPointEnable[e]=true
  end
end
function this._DoesBaseListInclude(baseName)
  if mvars.mis_baseList==nil then
    return
  end
  for i,baseName in pairs(mvars.mis_baseList)do
    if baseName==baseName then
      return true
    end
  end
  return false
end
function this._DoesCheckPointListInclude(checkPointId)
  if not checkPointId then
    return false
  end
  local checkPointNameStr32
  if IsTypeString(checkPointId)then
    checkPointNameStr32=StrCode32(checkPointId)
  else
    checkPointNameStr32=checkPointId
  end
  for i=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[i]==checkPointNameStr32 then
      return true
    end
  end
  return false
end
return this

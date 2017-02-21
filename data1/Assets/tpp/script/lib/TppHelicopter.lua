local this={}
local StrCode32=Fox.StrCode32
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local SendCommand=GameObject.SendCommand
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
function this.GetSupportHeliGameObjectId()
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  return GameObject.GetGameObjectId("TppHeli2","SupportHeli")
end
function this.SetNoSupportHelicopter()
  mvars.hel_isExistSupportHelicopter=false
end
function this.UnsetNoSupportHelicopter()
  mvars.hel_isExistSupportHelicopter=true
end
function this.ForceCallToLandingZone(_lzName)
  if not IsTypeTable(_lzName)then
    return
  end
  local landingZoneName=_lzName.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=NULL_ID then
    GameObject.SendCommand(gameId,{id="CallToLandingZoneAtName",name=landingZoneName})
    GameObject.SendCommand(gameId,{id="DisablePullOut"})
    GameObject.SendCommand(gameId,{id="EnableDescentToLandingZone"})
  else
    return
  end
end
function this.CallToLandingZone(_lzName)
  if not IsTypeTable(_lzName)then
    return
  end
  local landingZoneName=_lzName.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=NULL_ID then
    GameObject.SendCommand(gameId,{id="CallToLandingZoneAtName",name=landingZoneName})
    GameObject.SendCommand(gameId,{id="EnableDescentToLandingZone"})
  else
    return
  end
end
function this.SetEnableLandingZone(_lzName)
  if not IsTypeTable(_lzName)then
    return
  end
  local landingZoneName=_lzName.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=NULL_ID then
    GameObject.SendCommand(gameId,{id="EnableLandingZone",name=landingZoneName})
  else
    return
  end
end
function this.SetDisableLandingZone(_lzName)
  if not IsTypeTable(_lzName)then
    return
  end
  local landingZoneName=_lzName.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local heliId=this.GetSupportHeliGameObjectId()
  if heliId~=NULL_ID then
    GameObject.SendCommand(heliId,{id="DisableLandingZone",name=landingZoneName})
  else
    return
  end
end
function this.GetLandingZoneExists(lzName)
  if not IsTypeTable(lzName)then
    return
  end
  local landingZoneName=lzName.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local heliId=this.GetSupportHeliGameObjectId()
  if heliId~=NULL_ID then
    return GameObject.SendCommand(heliId,{id="DoesLandingZoneExists",name=landingZoneName})
  else
    return false
  end
end
function this.SetNewestPassengerTable()
  if not mvars.hel_isExistSupportHelicopter then
    this.ClearPassengerTable()
    return
  end
  local passengerIds
  local heliId=this.GetSupportHeliGameObjectId()
  if heliId~=NULL_ID then
    passengerIds=SendCommand(heliId,{id="GetPassengerIdsStaffOnly"})
    mvars.hel_passengerListGameObjectId=heliId
  else
    return
  end
  if not IsTypeTable(passengerIds)or next(passengerIds)==nil then
    return
  end
  mvars.hel_heliPassengerTable={}
  for n,gameId in ipairs(passengerIds)do
    mvars.hel_heliPassengerTable[gameId]=true
  end
  mvars.hel_heliPassengerList=passengerIds
  mvars.hel_passengerListGameObjectId=heliId
end
function this.GetPassengerlist()
  return mvars.hel_heliPassengerList
end
function this.ClearPassengerTable()
  if mvars.hel_passengerListGameObjectId then
    SendCommand(mvars.hel_passengerListGameObjectId,{id="InitializePassengers"})
  end
  mvars.hel_passengerListGameObjectId=nil
  mvars.hel_heliPassengerTable=nil
  mvars.hel_heliPassengerList=nil
end
function this.IsInHelicopter(passengerId)
  if not IsTypeTable(mvars.hel_heliPassengerTable)then
    return
  end
  local gameId
  if Tpp.IsTypeString(passengerId)then
    gameId=GetGameObjectId(passengerId)
  else
    gameId=passengerId
  end
  return mvars.hel_heliPassengerTable[gameId]
end
function this.ForcePullOut()
  GameObject.SendCommand({type="TppHeli2",index=0},{id="PullOut",forced=true})
end
function this.AdjustBuddyDropPoint()
  if gvars.heli_missionStartRoute~=0 then
    TppBuddyService.AdjustFromDropPoint(gvars.heli_missionStartRoute,EntryBuddyType.BUDDY,6,3.14)
    TppBuddyService.AdjustFromDropPoint(gvars.heli_missionStartRoute,EntryBuddyType.VEHICLE,6,0)
  end
end
function this.Init(missionTable)
  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==NULL_ID then
    mvars.hel_isExistSupportHelicopter=false
    return
  end
  mvars.hel_isExistSupportHelicopter=true
  if TppMission.IsCanMissionClear()then
    this.SetNoTakeOffTime()
  else
    this.SetDefaultTakeOffTime()
  end
  if gvars.ply_initialPlayerState~=TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
    return
  end
  local helicopterRouteList=nil
  if(missionTable.sequence and missionTable.sequence.missionStartPosition)and missionTable.sequence.missionStartPosition.helicopterRouteList then
    if not Tpp.IsTypeFunc(missionTable.sequence.missionStartPosition.IsUseRoute)or missionTable.sequence.missionStartPosition.IsUseRoute()then
      helicopterRouteList=missionTable.sequence.missionStartPosition.helicopterRouteList
    end
  end
  if helicopterRouteList==nil then
    return
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    GameObject.SendCommand(heliId,{id="Realize"})
  else
    if gvars.heli_missionStartRoute~=0 then
      if not svars.ply_isUsedPlayerInitialAction then
        GameObject.SendCommand(heliId,{id="SendPlayerAtRouteReady",route=gvars.heli_missionStartRoute})
      end
    end
  end
end
function this.SetDefaultTakeOffTime()
  local heliId=this.GetSupportHeliGameObjectId()
  if(heliId==nil)then
    return
  end
  if heliId==NULL_ID then
    return
  end
  GameObject.SendCommand(heliId,{id="SetTakeOffWaitTime",time=5})
end
function this.SetNoTakeOffTime()
  local heliId=this.GetSupportHeliGameObjectId()
  if(heliId==nil)then
    return
  end
  if heliId==NULL_ID then
    return
  end
  GameObject.SendCommand(heliId,{id="SetTakeOffWaitTime",time=0})
end
function this.SetRouteToHelicopterOnStartMission()
  local heliId=this.GetSupportHeliGameObjectId()
  if(heliId==nil)then
    return
  end
  if heliId==NULL_ID then
    return
  end
  if gvars.heli_missionStartRoute~=0 then
    GameObject.SendCommand(heliId,{id="SendPlayerAtRouteStart",isAssault=TppLandingZone.IsAssaultDropLandingZone(gvars.heli_missionStartRoute)})
  end
end
function this.ResetMissionStartHelicopterRoute()
  gvars.heli_missionStartRoute=0
end
function this.GetMissionStartHelicopterRoute()
  return gvars.heli_missionStartRoute
end
local heliColors={
  [TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT]={pack="",fova=""},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_blk.fv2"},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_red.fv2"}
}
function this.GetEnemyColoringPack(heliColoringType)
  return heliColors[heliColoringType].pack
end
function this.SetEnemyColoring(heliColoringType)
  SendCommand({type="TppEnemyHeli",index=0},{id="SetColoring",coloringType=heliColoringType,fova=heliColors[heliColoringType].fova})
end
return this

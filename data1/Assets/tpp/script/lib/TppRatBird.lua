-- TppRatBird.lua
local this={}
local StrCode32=Fox.StrCode32
local maxBirds=2
function this.RegisterRat(ratList,ratRouteList)
  mvars.rat_bird_ratList=ratList
  mvars.rat_bird_ratRouteList=ratRouteList
end
function this.RegisterBird(birdList,birdFlyZoneList)
  mvars.rat_bird_birdList=birdList
  mvars.rat_bird_flyZoneList=birdFlyZoneList
  if mvars.rat_bird_birdType then
    for n,birdInfo in ipairs(mvars.rat_bird_birdList)do
      birdInfo.birdType=mvars.rat_bird_birdType
    end
  end
end
function this.RegisterBaseList(e)
  mvars.rat_bird_baseStrCodeList={}
  for a,e in ipairs(e)do
    mvars.rat_bird_baseStrCodeList[StrCode32(e)]=e
  end
end
function this.EnableRat()
  mvars.rat_bird_enableRat=true
end
function this.EnableBird(birdType)
  if birdType==nil then
    return
  end
  mvars.rat_bird_enableBird=true
  mvars.rat_bird_birdType=birdType
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if mvars.rat_bird_ratList or mvars.rat_bird_birdList then
    Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  end
end
function this.Messages()
  return Tpp.StrCode32Table{Block={{msg="OnChangeLargeBlockState",func=this._OnChangeLargeBlockState}}}
end
function this.OnMissionCanStart()
  if not mvars.rat_bird_baseStrCodeList then
    return
  end
  local a=Tpp.GetLoadedLargeBlock()
  if a then
    this._OnChangeLargeBlockState(a,StageBlock.ACTIVE)
  end
end
function this._WarpRats(e)
  local tppRat={type="TppRat",index=0}
  for n,name in ipairs(mvars.rat_bird_ratList)do
    local ratRouteInfo=mvars.rat_bird_ratRouteList[e][n]
    if ratRouteInfo then
      local command={id="Warp",name=name,ratIndex=0,position=ratRouteInfo.pos,degreeRotationY=0,route=ratRouteInfo.name,nodeIndex=0}
      GameObject.SendCommand(tppRat,command)
    end
  end
end
function this._EnableRats(enabled)
  if not mvars.rat_bird_ratList then
    return
  end
  for n,name in ipairs(mvars.rat_bird_ratList)do
    local tppRatId={type="TppRat",index=0}
    local command={id="SetEnabled",name=name,ratIndex=0,enabled=enabled}
    GameObject.SendCommand(tppRatId,command)
  end
end
function this._WarpBird(e)
  if not mvars.rat_bird_birdList then
    return
  end
  for i,birdInfo in ipairs(mvars.rat_bird_birdList)do
    local birdTypeTppObject={type=birdInfo.birdType,index=0}
    local flyZone=mvars.rat_bird_flyZoneList[e][i]
    if flyZone then
      local command={id="ChangeFlyingZone",name=birdInfo.name,center=flyZone.center,radius=flyZone.radius,height=flyZone.height}
      GameObject.SendCommand(birdTypeTppObject,command)
      local command=nil
      if flyZone.ground then
        for birdIndex=0,maxBirds do
          if flyZone.ground[birdIndex+1]then
            command={id="SetLandingPoint",birdIndex=birdIndex,name=birdInfo.name,groundPos=flyZone.ground[birdIndex+1]}
            GameObject.SendCommand(birdTypeTppObject,command)
          end
        end
      elseif flyZone.perch then
        for birdIndex=0,maxBirds do
          if flyZone.perch[birdIndex+1]then
            command={id="SetLandingPoint",birdIndex=birdIndex,name=birdInfo.name,perchPos=flyZone.perch[birdIndex+1]}
          end
          GameObject.SendCommand(birdTypeTppObject,command)
        end
      end
      local command={id="SetAutoLanding",name=birdInfo.name}
      GameObject.SendCommand(birdTypeTppObject,command)
    end
  end
end
function this._EnableBirds(enabled)
  for n,birdInfo in ipairs(mvars.rat_bird_birdList)do
    local tppBirdTypeId={type=birdInfo.birdType,index=0}
    --RETAILBUG: birdindex not defined, I assume it's the index of rat_bird_birdList but not sure, the equivalent for rats just sets 0, this function is overridden to a function that does nothing in TppAnimal
    local command={id="SetEnabled",name=birdInfo.name,birdIndex=i,enabled=enabled}
    GameObject.SendCommand(tppBirdTypeId,command)
  end
end
function this._Activate(a)
  if mvars.rat_bird_enableRat then
    this._EnableRats(true)
    this._WarpRats(a)
  end
  if mvars.rat_bird_enableBird then
    this._EnableBirds(true)
    this._WarpBird(a)
  end
end
function this._Deactivate()
  if mvars.rat_bird_enableRat then
    this._EnableRats(false)
  end
  if mvars.rat_bird_enableBird then
    this._EnableBirds(false)
  end
end
function this._OnChangeLargeBlockState(a,n)
  local a=mvars.rat_bird_baseStrCodeList[a]
  if n==StageBlock.ACTIVE then
    this._Activate(a)
  else
    this._Deactivate(a)
  end
end
return this

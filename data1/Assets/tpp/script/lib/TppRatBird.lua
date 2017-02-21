local this={}
local n=Fox.StrCode32
local d=2
function this.RegisterRat(a,e)
  mvars.rat_bird_ratList=a
  mvars.rat_bird_ratRouteList=e
end
function this.RegisterBird(a,e)
  mvars.rat_bird_birdList=a
  mvars.rat_bird_flyZoneList=e
  if mvars.rat_bird_birdType then
    for a,e in ipairs(mvars.rat_bird_birdList)do
      e.birdType=mvars.rat_bird_birdType
    end
  end
end
function this.RegisterBaseList(e)
  mvars.rat_bird_baseStrCodeList={}
  for a,e in ipairs(e)do
    mvars.rat_bird_baseStrCodeList[n(e)]=e
  end
end
function this.EnableRat()
  mvars.rat_bird_enableRat=true
end
function this.EnableBird(e)
  if e==nil then
    return
  end
  mvars.rat_bird_enableBird=true
  mvars.rat_bird_birdType=e
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(a)
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
  local r={type="TppRat",index=0}
  for n,a in ipairs(mvars.rat_bird_ratList)do
    local e=mvars.rat_bird_ratRouteList[e][n]
    if e then
      local e={id="Warp",name=a,ratIndex=0,position=e.pos,degreeRotationY=0,route=e.name,nodeIndex=0}
      GameObject.SendCommand(r,e)
    end
  end
end
function this._EnableRats(n)
  if not mvars.rat_bird_ratList then
    return
  end
  for a,e in ipairs(mvars.rat_bird_ratList)do
    local a={type="TppRat",index=0}
    local e={id="SetEnabled",name=e,ratIndex=0,enabled=n}
    GameObject.SendCommand(a,e)
  end
end
function this._WarpBird(e)
  if not mvars.rat_bird_birdList then
    return
  end
  for r,a in ipairs(mvars.rat_bird_birdList)do
    local n={type=a.birdType,index=0}
    local e=mvars.rat_bird_flyZoneList[e][r]
    if e then
      local r={id="ChangeFlyingZone",name=a.name,center=e.center,radius=e.radius,height=e.height}
      GameObject.SendCommand(n,r)
      local r=nil
      if e.ground then
        for t=0,d do
          if e.ground[t+1]then
            r={id="SetLandingPoint",birdIndex=t,name=a.name,groundPos=e.ground[t+1]}
            GameObject.SendCommand(n,r)
          end
        end
      elseif e.perch then
        for t=0,d do
          if e.perch[t+1]then
            r={id="SetLandingPoint",birdIndex=t,name=a.name,perchPos=e.perch[t+1]}
          end
          GameObject.SendCommand(n,r)
        end
      end
      local e={id="SetAutoLanding",name=a.name}
      GameObject.SendCommand(n,e)
    end
  end
end
function this._EnableBirds(a)
  for n,e in ipairs(mvars.rat_bird_birdList)do
    local n={type=e.birdType,index=0}
    local e={id="SetEnabled",name=e.name,birdIndex=i,enabled=a}
    GameObject.SendCommand(n,e)
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

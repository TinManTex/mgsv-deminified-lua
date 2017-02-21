local this={}
local l=Fox.StrCode32
local i=Tpp.IsTypeTable
local t=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local r=GameObject.SendCommand
local a=Tpp.DEBUG_StrCode32ToString
function this.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="Interrogate",func=this._OnInterrogation},{msg="InterrogateEnd",func=this._OnInterrogationEnd},{msg="MapUpdate",func=this._OnMapUpdate}}}
end
function this.DeclareSVars()
  return{{name="InterrogationNormal",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="InterrogationHigh",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.MakeFlagHigh(e)
  if e==n then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local n=mvars.interTable[e].index
  for a,e in pairs(mvars.interTable[e].layer.high)do
    if e.name~=0 then
      local e=svars.InterrogationHigh[n]
      local a=bit.lshift(1,a-1)svars.InterrogationHigh[n]=bit.bor(e,a)
    end
  end
end
function this.ResetFlagHigh(e)
  if e==n then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local e=mvars.interTable[e].index
  svars.InterrogationHigh[e]=0
end
function this.ResetFlagNormal(e)
  if e==n then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local e=mvars.interTable[e].index
  svars.InterrogationNormal[e]=bit.bnot(0)
end
function this.UniqueInterrogationWithVoice(a,i)
  if a==n then
    return
  end
  local e=0
  for a,n in pairs(mvars.uniqueInterTable.unique)do
    if i==n.name then
      e=a
    end
  end
  if e==0 then
  else
    e=e+64
  end
  r(a,{id="AssignInterrogationWithVoice",soundParameterId=i,index=e})
end
function this.UniqueInterrogation(i,a)
  if i==n then
    return
  end
  local e=0
  for n,r in pairs(mvars.uniqueInterTable.unique)do
    if a==r.name then
      e=n
    end
  end
  if e==0 then
  else
    e=e+64
  end
  r(i,{id="AssignInterrogation",messageId=a,index=e})
end
function this.QuestInterrogation(a,i)
  if a==n then
    return
  end
  local e=0
  for n,a in pairs(mvars.questTable.unique)do
    if i==a.name then
      e=n
    end
  end
  if e==0 then
  else
    e=e+96
  end
  r(a,{id="AssignInterrogation",messageId=i,index=e})
end
function this.SetQuestHighIntTable(e,a)
  if e==n then
    return
  end
  if i(mvars.interTable[e].layer.high)==false then
    return
  end
  local n=1
  for e,e in pairs(mvars.interTable[e].layer.high)do
    n=n+1
  end
  for a,r in pairs(a)do
    local a=n
    if n>32 then
      return
    end
    for e,n in pairs(mvars.interTable[e].layer.high)do
      if r.name==0 then
        a=e
        break
      end
    end
    if a==n then
      n=n+1
      mvars.interTable[e].layer.high[a]={name=0,func=0}
    end
    mvars.interTable[e].layer.high[a].name=r.name
    mvars.interTable[e].layer.high[a].func=r.func
    local e=mvars.interTable[e].index
    local n=svars.InterrogationHigh[e]
    local a=bit.lshift(1,a-1)svars.InterrogationHigh[e]=bit.bor(n,a)
  end
end
function this.RemoveQuestHighIntTable(e,a)
  if e==n then
    return
  end
  if i(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,r in pairs(a)do
    for n,a in pairs(mvars.interTable[e].layer.high)do
      if r.name==a.name then
        mvars.interTable[e].layer.high[n]={name=0,func=0}
        local e=mvars.interTable[e].index
        local a=svars.InterrogationHigh[e]
        local n=bit.lshift(1,n-1)svars.InterrogationHigh[e]=bit.band(a,bit.bnot(n))break
      end
    end
  end
end
function this.AddHighInterrogation(e,a)
  if e==n then
    return
  end
  if i(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,a in pairs(a)do
    for r,n in pairs(mvars.interTable[e].layer.high)do
      if a.name==n.name then
        if a.func==n.func then
          local e=mvars.interTable[e].index
          local n=svars.InterrogationHigh[e]
          local a=bit.lshift(1,r-1)svars.InterrogationHigh[e]=bit.bor(n,a)
        end
      end
    end
  end
end
function this.RemoveHighInterrogation(e,a)
  if e==n then
    return
  end
  if i(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,a in pairs(a)do
    for r,n in pairs(mvars.interTable[e].layer.high)do
      if a.name==n.name then
        if a.func==n.func then
          local e=mvars.interTable[e].index
          local a=svars.InterrogationHigh[e]
          local n=bit.lshift(1,r-1)svars.InterrogationHigh[e]=bit.band(a,bit.bnot(n))
        end
      end
    end
  end
end
function this.InitUniqueInterrogation(e)
  mvars.uniqueInterTable={uniqueChara={},unique={}}
  for e,n in pairs(e)do
    mvars.uniqueInterTable[e]={}
    for n,a in pairs(n)do
      mvars.uniqueInterTable[e][n]={name=0,func=0}
      mvars.uniqueInterTable[e][n].name=a.name
      mvars.uniqueInterTable[e][n].func=a.func
    end
  end
end
function this.ResetQuestTable()
  if mvars.questTable==nil then
    mvars.questTable={uniqueChara={},unique={}}
  end
  for e,n in pairs(mvars.questTable)do
    for n,a in pairs(n)do
      mvars.questTable[e][n]={name=0,func=0}
    end
  end
end
function this.AddQuestTable(n)
  if mvars.questTable==nil then
    mvars.questTable={uniqueChara={},unique={}}
    this.ResetQuestTable()
  end
  for e,n in pairs(n)do
    mvars.questTable[e]={}
    for n,a in pairs(n)do
      mvars.questTable[e][n]={name=0,func=0}
      mvars.questTable[e][n].name=a.name
      mvars.questTable[e][n].func=a.func
    end
  end
end
function this.InitInterrogation(e)
  mvars.interTable={}
  local a=0
  for e,r in pairs(e)do
    a=a+1
    local e=t(e)
    if e==n then
    else
      mvars.interTable[e]={index=a,layer={normal={},high={},uniqueChara={}}}
      for n,a in pairs(r)do
        mvars.interTable[e].layer[n]={}
        for a,r in pairs(a)do
          mvars.interTable[e].layer[n][a]={name=0,func=0}
          mvars.interTable[e].layer[n][a].name=r.name
          mvars.interTable[e].layer[n][a].func=r.func
        end
      end
    end
  end
end
function this._AddGene(a)
  if a==n then
    return
  end
  if mvars.interTable[a]==nil then
    local e=0
    for a,n in pairs(mvars.interTable)do
      if e>n.index then
        e=n.index
      end
    end
    e=e+1
    mvars.interTable[a]={index=e,layer={normal={},high={},uniqueChara={}}}
  end
end
function this.AddGeneInter(a)
  for a,r in pairs(a)do
    if r then
      local a=t(a)
      if a==n then
      else
        this._AddGene(a)
      end
    end
  end
end
function this._OnMapUpdate()
  TppUI.ShowAnnounceLog"updateMap"end
function this._OnInterrogation(a,n,r)
  if r>0 then
  end
  if mvars.questTable~=nil then
    for r,e in pairs(mvars.questTable.uniqueChara)do
      if a==t(e.name)then
        if e.func(a,n)then
          return
        end
      end
    end
  end
  if mvars.uniqueInterTable~=nil then
    for r,e in pairs(mvars.uniqueInterTable.uniqueChara)do
      if a==t(e.name)then
        if e.func(a,n)then
          return
        end
      end
    end
  end
  local a=this._SelectInterrogation(n,r)
  if a==nil then
    return
  end
  this._AssignInterrogation(n,a.name,a.index)
end
function this._OnInterrogationEnd(r,n,i,e)
  if e==0 then
    return
  end
  local e=e
  if e>96 then
    e=e-96
    local a=false
    for n,e in pairs(mvars.questTable.unique)do
      if i==l(e.name)then
        a=e.name
      end
    end
    if a==false then
    else
      mvars.questTable.unique[e].func(r,n,a)
      return
    end
  end
  if e>64 then
    e=e-64
    local a=false
    for n,e in pairs(mvars.uniqueInterTable.unique)do
      if i==l(e.name)then
        a=e.name
      end
    end
    if a==false then
    else
      mvars.uniqueInterTable.unique[e].func(r,n,a)
      return
    end
  end
  if mvars.interTable[n]==nil then
    return
  end
  local a=mvars.interTable[n].index
  if e>32 then
    e=e-32
    local i=false
    for n,a in pairs(mvars.interTable[n].layer.high)do
      if n==e then
        i=a.name
      end
    end
    if i==false then
    else
      mvars.interTable[n].layer.high[e].func(r,n,i)
    end
    local n=svars.InterrogationHigh[a]svars.InterrogationHigh[a]=bit.band(n,bit.bnot(bit.lshift(1,e-1)))
  else
    local i=false
    for a,n in pairs(mvars.interTable[n].layer.normal)do
      if a==e then
        i=n.name
      end
    end
    if i==false then
    else
      mvars.interTable[n].layer.normal[e].func(r,n,i)
    end
    local n=svars.InterrogationNormal[a]
    svars.InterrogationNormal[a]=bit.band(svars.InterrogationNormal[a],bit.bnot(bit.lshift(1,e-1)))
  end
end
function this._AssignInterrogation(e,n,a)
r(e,{id="AssignInterrogation",messageId=n,index=a})
end
function this._AssignInterrogationCollection(e)
r(e,{id="AssignInterrogationCollection"})
end
function this._SelectInterrogation(n,a)
  if mvars.interTable==nil then
    if a>0 then
      this._AssignInterrogationCollection(n)
      return nil
    end
    return{index=0,name=0}
  end
  if mvars.interTable[n]==nil then
    if a>0 then
      this._AssignInterrogationCollection(n)
      return nil
    end
    return{index=0,name=0}
  end
  local r=mvars.interTable[n].index
  for e,a in pairs(mvars.interTable[n].layer.high)do
    local n=bit.band(svars.InterrogationHigh[r],bit.lshift(1,e-1))
    if n~=0 then
      return{index=e+32,name=a.name}
    end
  end
  if a>0 then
    local a=math.random(1,10)
    if a>=5 then
      this._AssignInterrogationCollection(n)
      return nil
    end
  end
  local i=1
  for e,n in pairs(mvars.interTable[n].layer.normal)do
    i=e
  end
  local i=math.random(1,i)
  for e,n in pairs(mvars.interTable[n].layer.normal)do
    if e>=i then
      local a=bit.band(svars.InterrogationNormal[r],bit.lshift(1,e-1))
      if a~=0 then
        return{index=e,name=n.name}
      end
    end
  end
  for e,a in pairs(mvars.interTable[n].layer.normal)do
    local n=bit.band(svars.InterrogationNormal[r],bit.lshift(1,e-1))
    if n~=0 then
      return{index=e,name=a.name}
    end
  end
  if a>0 then
    this._AssignInterrogationCollection(n)
    return nil
  end
  return{index=0,name=0}
end
return this

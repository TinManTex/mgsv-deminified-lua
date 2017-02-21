local this={}
local StrCode32=Fox.StrCode32
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local trapListMax=64
function this.OnAllocate(missionTable)
  if missionTable.sequence and missionTable.sequence.VARIABLE_TRAP_SETTING then
    if not IsTable(missionTable.sequence.VARIABLE_TRAP_SETTING)then
      return
    end
    mvars.trp_variableTrapList=missionTable.sequence.VARIABLE_TRAP_SETTING
    if#mvars.trp_variableTrapList==0 then
      return
    end
    if#mvars.trp_variableTrapList>trapListMax then
      return
    end
    mvars.trp_variableTrapTable={}
    for r,e in ipairs(mvars.trp_variableTrapList)do
      local a=e.name
      if not IsString(a)then
        return
      end
      if e.initialState==nil then
        return
      end
      if e.type==nil then
        return
      end
      mvars.trp_variableTrapTable[a]={}
      mvars.trp_variableTrapTable[a].type=e.type
      mvars.trp_variableTrapTable[a].initialState=e.initialState
      mvars.trp_variableTrapTable[a].index=r
      mvars.trp_variableTrapTable[a].packLabel=e.packLabel
    end
  end
end
function this.DEBUG_Init()
  mvars.debug.showTrapStatus=false
  ;(nil).AddDebugMenu("LuaSystem","TRP.trapStatus","bool",mvars.debug,"showTrapStatus")
  mvars.debug.trapStatusScroll=0
  ;(nil).AddDebugMenu("LuaSystem","TRP.trapScroll","int32",mvars.debug,"trapStatusScroll")
end
function this.DebugUpdate()
  local mvars=mvars
  local debug=mvars.debug
  local print=(nil).Print
  local context=(nil).NewContext()
  if mvars.debug.showTrapStatus and mvars.trp_variableTrapList then
    print(context,{.5,.5,1},"LuaSystem TRP.trapStatus")
    local e=1
    if mvars.debug.trapStatusScroll>1 then
      e=mvars.debug.trapStatusScroll
    end
    for a,n in ipairs(mvars.trp_variableTrapList)do
      if a>=e then
        local e=n.name
        local a=svars.trp_variableTrapEnable[a]
        print(context,{.5,.5,1},"trapName = "..(tostring(e)..(", status = "..tostring(a))))
      end
    end
  end
end
function this.InitializeVariableTraps()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for t,e in ipairs(mvars.trp_variableTrapList)do
    local t=true
    if e.packLabel then
      t=TppPackList.IsMissionPackLabelList(e.packLabel)
    end
    if t then
      if e.initialState==TppDefine.TRAP_STATE.ENABLE then
        this.Enable(e.name)
      elseif e.initialState==TppDefine.TRAP_STATE.DISABLE then
        this.Disable(e.name)
      else
        this.Enable(e.name)
      end
    end
  end
end
function this.RestoreVariableTrapState()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for r,e in ipairs(mvars.trp_variableTrapList)do
    local t=true
    if e.packLabel then
      t=TppPackList.IsMissionPackLabelList(e.packLabel)
    end
    if t then
      if svars.trp_variableTrapEnable[r]then
        this.Enable(e.name)
      else
        this.Disable(e.name)
      end
    end
  end
end
function this.DeclareSVars()
  return{{name="trp_variableTrapEnable",arraySize=trapListMax,type=TppScriptVars.TYPE_BOOL,value=true,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.Enable(e)
  this.ChangeTrapState(e,true)
end
function this.Disable(e)
  this.ChangeTrapState(e,false)
end
function this.ChangeTrapState(e,t)
  local r=mvars.trp_variableTrapTable[e]
  if r==nil then
    return
  end
  local i=r.index
  local n
  if r.type==TppDefine.TRAP_TYPE.NORMAL then
    n=this.ChangeNormalTrapState(e,t)
  elseif r.type==TppDefine.TRAP_TYPE.TRIGGER then
    n=this.ChangeTriggerTrapState(e,t)
  else
    n=this.ChangeNormalTrapState(e,t)
  end
  if n then
    svars.trp_variableTrapEnable[i]=t
  end
end
function this.ChangeNormalTrapState(a,t)
  local e=Tpp.GetDataBodyWithIdentifier("VariableTrapIdentifier",a,"GeoTrap")
  if e then
    TppDataUtility.SetEnableDataFromIdentifier("VariableTrapIdentifier",a,t)
    return true
  end
end
function this.ChangeTriggerTrapState(e,a)
  Geo.GeoLuaEnableTriggerTrap(e,a)
  return true
end
return this

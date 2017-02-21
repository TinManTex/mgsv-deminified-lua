local this={}
local d=ScriptBlock.GetCurrentScriptBlockId
local t=ScriptBlock.GetScriptBlockState
local r=GameObject.NULL_ID
local i=Tpp.IsTypeTable
local c=Tpp.IsTypeString
local animalBlockName="animal_block"
local CheckBlockArea=Tpp.CheckBlockArea
local animalsTable={
  Goat={type="TppGoat",locatorFormat="anml_goat_%02d",routeFormat="rt_anml_goat_%02d",nightRouteFormat="rt_anml_goat_n%02d",isHerd=true,isDead=false},
  Wolf={type="TppWolf",locatorFormat="anml_wolf_%02d",routeFormat="rt_anml_wolf_%02d",nightRouteFormat="rt_anml_wolf_n%02d",isHerd=true,isDead=false},
  Nubian={type="TppNubian",locatorFormat="anml_nubian_%02d",routeFormat="rt_anml_nubian_%02d",nightRouteFormat="rt_anml_nubian_n%02d",isHerd=true,isDead=false},
  Jackal={type="TppJackal",locatorFormat="anml_jackal_%02d",routeFormat="rt_anml_jackal_%02d",nightRouteFormat="rt_anml_jackal_n%02d",isHerd=true,isDead=false},
  Zebra={type="TppZebra",locatorFormat="anml_Zebra_%02d",routeFormat="rt_anml_Zebra_%02d",nightRouteFormat="rt_anml_Zebra_n%02d",isHerd=true,isDead=false},
  Bear={type="TppBear",locatorFormat="anml_bear_%02d",routeFormat="rt_anml_bear_%02d",nightRouteFormat="rt_anml_bear_n%02d",isHerd=false,isDead=false},
  BuddyPuppy={type="TppBuddyPuppy",locatorFormat="anml_BuddyPuppy_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false},
  MotherDog={type="TppJackal",locatorFormat="anml_MotherDog_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=true},
  Rat={type="TppRat",locatorFormat="anml_rat_%02d",routeFormat="rt_anml_rat_%02d",nightRouteFormat="rt_anml_rat_%02d",isHerd=false,isDead=false},
  NoAnimal={type="NoAnimal",locatorFormat="anml_NoAnimal_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false}
  }
local nightTimes={
Goat={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Wolf={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Bear={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Nubian={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Jackal={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Zebra={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
BuddyPuppy={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
MotherDog={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
Rat={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},
NoAnimal={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"}
}
local m=5
this.CLOCK_MESSAGE_AT_NIGHT_FORMAT="AnimalRouteChangeAtNight%02d"
this.CLOCK_MESSAGE_AT_MORNING_FORMAT="AnimalRouteChangeAtMorning%02d"
this.weatherTable={}
local l=0
local o=0
function this.GetDefaultTimeTable(e)
  if e=="Goat"then
    return nightTimes.Goat
  elseif e=="Wolf"then
    return nightTimes.Wolf
  elseif e=="Bear"then
    return nightTimes.Bear
  elseif e=="Nubian"then
    return nightTimes.Nubian
  elseif e=="Jackal"then
    return nightTimes.Jackal
  elseif e=="Zebra"then
    return nightTimes.Zebra
  elseif e=="BuddyPuppy"then
    return nightTimes.BuddyPuppy
  elseif e=="MotherDog"then
    return nightTimes.MotherDog
  elseif e=="Rat"then
    return nightTimes.Rat
  elseif e=="NoAnimal"then
    return nightTimes.NoAnimal
  else
    return nil
  end
end
function this.StopAnimalBlockLoad()
  mvars.anm_stopAnimalBlockLoad=true
end
function this.UpdateLoadAnimalBlock(i,o)
  if mvars.anm_stopAnimalBlockLoad then
    return
  end
  local mvars=mvars
  local locationAnimalSettingTable=mvars.loc_locationAnimalSettingTable
  local animalAreaSetting=locationAnimalSettingTable.animalAreaSetting
  local MAX_AREA_NUM=locationAnimalSettingTable.MAX_AREA_NUM
  if not MAX_AREA_NUM then
    return
  end
  local animalBlockKeyName,animalBlockAreaName=this._GetAnimalBlockAreaName(animalAreaSetting,MAX_AREA_NUM,"loadArea",i,o)
  if animalBlockKeyName~=nil then
    mvars.animalBlockAreaName=animalBlockAreaName
    mvars.animalBlockKeyName=animalBlockKeyName
    TppScriptBlock.Load(animalBlockName,animalBlockKeyName)
  else
    mvars.animalBlockAreaName=nil
    mvars.animalBlockKeyName=nil
    TppScriptBlock.Unload(animalBlockName)
  end
end
function this.GetCurrentAnimalBlockAreaName()
  local e=mvars.animalBlockAreaName
  if e==nil then
  end
  return e
end
function this._UpdateActiveAnimalBlock(a,o)
  local t=mvars.loc_locationAnimalSettingTable
  local l=t.animalAreaSetting
  local t=t.MAX_AREA_NUM
  if not t then
    return
  end
  local t,e=this._GetAnimalBlockAreaName(l,t,"activeArea",a,o)
  if e~=nil then
    local e=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.ActivateScriptBlockState(e)
  else
    local e=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.DeactivateScriptBlockState(e)
  end
end
function this._GetAnimalBlockAreaName(areaSetting,maxAreaNum,areaId,n,a)
  --local o=areaSetting
  for t=1,maxAreaNum do
    local t=areaSetting[t]
    local e=t[areaId]
    if CheckBlockArea(e,n,a)then
      for a,e in ipairs(t.defines)do
        if(not Tpp.IsTypeFunc(e.conditionFunc))or(e.conditionFunc())then
          local time=TppClock.GetTime"number"
          return e.keyList[time%#e.keyList+1],t.areaName
        end
      end
    end
  end
end
function this._GetSetupTable(e)
  if e=="Goat"then
    return animalsTable.Goat
  elseif e=="Wolf"then
    return animalsTable.Wolf
  elseif e=="Bear"then
    return animalsTable.Bear
  elseif e=="Nubian"then
    return animalsTable.Nubian
  elseif e=="Jackal"then
    return animalsTable.Jackal
  elseif e=="Zebra"then
    return animalsTable.Zebra
  elseif e=="BuddyPuppy"then
    return animalsTable.BuddyPuppy
  elseif e=="MotherDog"then
    return animalsTable.MotherDog
  elseif e=="Rat"then
    return animalsTable.Rat
  elseif e=="NoAnimal"then
    return animalsTable.NoAnimal
  else
    return nil
  end
end
function this._IsNight(e,t,a)
  local e=(e<a)or(e>=t)
  return e
end
function this._IsNightForAnimalType(t,a)
  local t=this.GetDefaultTimeTable(t)
  local n=t.nightStartTime
  local n=TppClock.ParseTimeString(n,"number")
  local t=t.nightEndTime
  local t=TppClock.ParseTimeString(t,"number")
  return this._IsNight(a,n,t)
end
function this._InitializeCommonAnimalSetting(o,a,t)
  local l=1
  if i(a)then
    l=a.groupNumber or 0
  end
  local n=a.nightStartTime
  if n==nil then
    n=this.GetDefaultTimeTable(o).nightStartTime
  end
  local r=TppClock.ParseTimeString(n,"number")
  local n=a.nightEndTime
  if n==nil then
    n=this.GetDefaultTimeTable(o).nightEndTime
  end
  local c=TppClock.ParseTimeString(n,"number")
  local n=a.timeLag
  if n==nil then
    n=this.GetDefaultTimeTable(o).timeLag
  end
  local o=TppClock.ParseTimeString(n,"number")
  local i=TppClock.GetTime"number"local n=0
  if t.isDead==false then
    if t.isHerd==false then
      for a=0,(l-1)do
        n=o*a
        if this._IsNight(i,r+n,c+n)then
          this._SetRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
        else
          this._SetRoute(t.type,t.locatorFormat,t.routeFormat,a)
        end
      end
    else
      for a=0,(l-1)do
        n=o*a
        if this._IsNight(i,r+n,c+n)then
          this._SetHerdRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
        else
          this._SetHerdRoute(t.type,t.locatorFormat,t.routeFormat,a)
        end
      end
    end
  else
    this._ChangeDeadState(t.type,a.position,a.degRotationY)
  end
end
function this._SetHerdRoute(e,a,n,t)
  local e={type=e,index=0}
  if e==r then
    return
  end
  local a=string.format(a,t)
  local t=string.format(n,t)
  local t={id="SetHerdEnabledCommand",type="Route",name=a,instanceIndex=0,route=t}
  GameObject.SendCommand(e,t)
end
function this._SetRoute(e,a,n,t)
  local e={type=e,index=0}
  if e==r then
    return
  end
  local a=string.format(a,t)
  local t=string.format(n,t)
  local t={id="SetRoute",name=a,route=t}
  GameObject.SendCommand(e,t)
end
function this._ChangeDeadState(e,t,a)
  local e={type=e,index=0}
  if e==r then
    return
  end
  local n=t or Vector3(0,0,0)
  local t=a or 0
  local t={id="ChangeDeadState",position=n,degRotationY=t}
  GameObject.SendCommand(e,t)
end
function this._RegisterWeatherTable(t,a,n)
  this.weatherTable[l]={msg="Clock",sender=t,func=function(l,a)
    if n then
      n(t,a)
    else
      this._ChangeRouteAtTime(t,a)
    end
  end}l=l+1
end
function this._RegisterClockMessage(t,i,o,n,a,l)
  local t=string.format(t,a)
  this._RegisterWeatherTable(t,n,l)
  local e=i+o*a
  local e=TppClock.FormalizeTime(e,"string")
  TppClock.RegisterClockMessage(t,e)
  return t
end
function this._AddClockMessage(n,t,a,r)
  local a=1
  if i(t)then
    a=t.groupNumber or 0
  end
  if r+a>m then
    return
  end
  local m=r+a
  local a=t.nightStartTime
  if a==nil then
    a=this.GetDefaultTimeTable(n).nightStartTime
  end
  local c=TppClock.ParseTimeString(a,"number")
  local a=t.nightEndTime
  if a==nil then
    a=this.GetDefaultTimeTable(n).nightEndTime
  end
  local i=TppClock.ParseTimeString(a,"number")
  local t=t.timeLag
  if t==nil then
    t=this.GetDefaultTimeTable(n).timeLag
  end
  local t=TppClock.ParseTimeString(t,"number")
  l=0
  for a=r,m-1 do
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,c,t,true,a)
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,i,t,false,a)o=o+1
  end
end
function this._ChangeRouteAtTime(t,m)
  local a=mvars.loc_locationAnimalSettingTable
  local o=a.animalTypeSetting[mvars.animalBlockKeyName]
  local a=-1
  for e in string.gmatch(t,"%d+")do
    a=tonumber(e)
  end
  if a==-1 then
    return
  end
  local l=0
  local n=nil
  local r=nil
  for m,e in pairs(o)do
    local o
    local t
    if c(e)then
      o=e
    elseif i(e)then
      o=m
      t=e
    end
    local e=t.groupNumber or 0
    if l<=a and a<l+e then
      n=o
      r=t
      break
    end
    l=l+e
  end
  if n==nil or r==nil then
    return
  end
  local t=this._GetSetupTable(n)
  if t==nil then
    return
  end
  local a=a-l
  local l=this._IsNightForAnimalType(n,m)
  if n=="Bear"then
    if l then
      this._SetRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
    else
      this._SetRoute(t.type,t.locatorFormat,t.routeFormat,a)
    end
  else
    if l then
      this._SetHerdRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
    else
      this._SetHerdRoute(t.type,t.locatorFormat,t.routeFormat,a)
    end
  end
end
function this._MakeMessageExecTable()
  mvars.animalBlockScript.messageExecTable=Tpp.MakeMessageExecTable(mvars.animalBlockScript.Messages)
end
function this._GetAnimalBlockState()
  local e=ScriptBlock.GetScriptBlockId(animalBlockName)
  if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(e)
end
function this.InitializeBlockStatus()
  local e=ScriptBlock.GetScriptBlockId(animalBlockName)
  if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  TppScriptBlock.ClearSavedScriptBlockInfo(e)
end
function this.OnActivateAnimalBlock(e)
  for e,e in pairs(e)do
  end
end
function this.OnInitializeAnimalBlock()
  coroutine.yield()
  coroutine.yield()
  if not mvars.animalBlockKeyName then
    return
  end
  mvars.animalBlockScript.DidInitialized=true
  mvars.animalBlockScript.Messages=Tpp.StrCode32Table{Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=function(t,a)this._UpdateActiveAnimalBlock(t,a)end}}}
  o=0
  this.weatherTable={}
  local t=mvars.loc_locationAnimalSettingTable
  local t=t.animalTypeSetting[mvars.animalBlockKeyName]
  local l=0
  for o,n in pairs(t)do
    local t
    local a
    if c(n)then
      t=n
    elseif i(n)then
      t=o
      a=n
    end
    local n=this._GetSetupTable(t)
    if n~=nil and t~="NoAnimal"then
      this._InitializeCommonAnimalSetting(t,a,n)
      this._AddClockMessage(t,a,n,l)
      TppFreeHeliRadio.RegistAnimalOptionalRadio(t)
      local e=a.groupNumber or 0
      l=l+e
    end
  end
  local weatherTable32=Tpp.StrCode32Table{Weather=this.weatherTable}
  mvars.animalBlockScript.Messages=Tpp.MergeTable(mvars.animalBlockScript.Messages,weatherTable32,false)
  mvars.animalBlockScript.OnReload=this.OnReload
  function mvars.animalBlockScript.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogTex)
    Tpp.DoMessage(mvars.animalBlockScript.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogTex)
  end
  this._MakeMessageExecTable()
end
function this.OnReload()
  if not mvars.loc_locationAnimalSettingTable or not mvars.animalBlockKeyName then
    return
  end
  local t=mvars.loc_locationAnimalSettingTable
  local t=t.animalTypeSetting[mvars.animalBlockKeyName]
  local a=0
  for r,n in pairs(t)do
    local t
    local l
    if c(n)then
      t=n
    elseif i(n)then
      t=r
      l=n
    end
    local e=this._GetSetupTable(t)
    if e~=nil and t~="NoAnimal"then
      local e=l.groupNumber or 0
      if a+e>m then
        break
      end
      a=a+e
    end
  end
  o=a
  this._MakeMessageExecTable()
end
function this.OnAllocate(a)
  local t=d()
  TppScriptBlock.InitScriptBlockState(t)
  mvars.animalBlockScript=a
  local t,a=Tpp.GetCurrentStageSmallBlockIndex()
  this._UpdateActiveAnimalBlock(t,a)
  function mvars.animalBlockScript.OnMessage(e,e,e,e,e,e,e)
  end
end
function this.OnTerminate()
  if mvars.animalBlockScript.DidInitialized then
    for a=0,o-1 do
      local t=string.format(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,a)
      TppClock.UnregisterClockMessage(t)t=string.format(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,a)
      TppClock.UnregisterClockMessage(t)
    end
  end
  local e=d()
  TppScriptBlock.FinalizeScriptBlockState(e)
  TppFreeHeliRadio.UnregistAnimalOptionalRadio()
  mvars.animalBlockScript.DidInitialized=nil
  mvars.animalBlockScript.OnReload=nil
  mvars.animalBlockScript.OnMessage=nil
  mvars.animalBlockScript=nil
end
return this

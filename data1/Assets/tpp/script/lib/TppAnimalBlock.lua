local this={}
local GetCurrentScriptBlockId=ScriptBlock.GetCurrentScriptBlockId
local GetScriptBlockState=ScriptBlock.GetScriptBlockState
local NULL_ID=GameObject.NULL_ID
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
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
local maxAnimals=5
this.CLOCK_MESSAGE_AT_NIGHT_FORMAT="AnimalRouteChangeAtNight%02d"
this.CLOCK_MESSAGE_AT_MORNING_FORMAT="AnimalRouteChangeAtMorning%02d"
this.weatherTable={}
local weatherTableCount=0
local l_numAnimals=0
function this.GetDefaultTimeTable(animal)
  if animal=="Goat"then
    return nightTimes.Goat
  elseif animal=="Wolf"then
    return nightTimes.Wolf
  elseif animal=="Bear"then
    return nightTimes.Bear
  elseif animal=="Nubian"then
    return nightTimes.Nubian
  elseif animal=="Jackal"then
    return nightTimes.Jackal
  elseif animal=="Zebra"then
    return nightTimes.Zebra
  elseif animal=="BuddyPuppy"then
    return nightTimes.BuddyPuppy
  elseif animal=="MotherDog"then
    return nightTimes.MotherDog
  elseif animal=="Rat"then
    return nightTimes.Rat
  elseif animal=="NoAnimal"then
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
  local name=mvars.animalBlockAreaName
  if name==nil then
  end
  return name
end
function this._UpdateActiveAnimalBlock(a,o)
  local loc_locationAnimalSettingTable=mvars.loc_locationAnimalSettingTable
  local animalAreaSetting=loc_locationAnimalSettingTable.animalAreaSetting
  local MAX_AREA_NUM=loc_locationAnimalSettingTable.MAX_AREA_NUM
  if not MAX_AREA_NUM then
    return
  end
  local t,e=this._GetAnimalBlockAreaName(animalAreaSetting,MAX_AREA_NUM,"activeArea",a,o)
  if e~=nil then
    local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.ActivateScriptBlockState(blockId)
  else
    local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.DeactivateScriptBlockState(blockId)
  end
end
function this._GetAnimalBlockAreaName(areaSettings,maxAreaNum,areaId,n,a)
  --ORPHAN local o=areaSettings
  for i=1,maxAreaNum do
    local t=areaSettings[i]
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
function this._GetSetupTable(animalType)
  if animalType=="Goat"then
    return animalsTable.Goat
  elseif animalType=="Wolf"then
    return animalsTable.Wolf
  elseif animalType=="Bear"then
    return animalsTable.Bear
  elseif animalType=="Nubian"then
    return animalsTable.Nubian
  elseif animalType=="Jackal"then
    return animalsTable.Jackal
  elseif animalType=="Zebra"then
    return animalsTable.Zebra
  elseif animalType=="BuddyPuppy"then
    return animalsTable.BuddyPuppy
  elseif animalType=="MotherDog"then
    return animalsTable.MotherDog
  elseif animalType=="Rat"then
    return animalsTable.Rat
  elseif animalType=="NoAnimal"then
    return animalsTable.NoAnimal
  else
    return nil
  end
end
function this._IsNight(e,t,a)
  local e=(e<a)or(e>=t)
  return e
end
function this._IsNightForAnimalType(animalType,time)
  local timeTable=this.GetDefaultTimeTable(animalType)
  local nightStartString=timeTable.nightStartTime
  local nightStart=TppClock.ParseTimeString(nightStartString,"number")
  local nightEndString=timeTable.nightEndTime
  local nightEnd=TppClock.ParseTimeString(nightEndString,"number")
  return this._IsNight(time,nightStart,nightEnd)
end
function this._InitializeCommonAnimalSetting(animalType,animalSetting,setupTable)
  local groupNumber=1
  if IsTable(animalSetting)then
    groupNumber=animalSetting.groupNumber or 0
  end
  local n=animalSetting.nightStartTime
  if n==nil then
    n=this.GetDefaultTimeTable(animalType).nightStartTime
  end
  local r=TppClock.ParseTimeString(n,"number")
  local n=animalSetting.nightEndTime
  if n==nil then
    n=this.GetDefaultTimeTable(animalType).nightEndTime
  end
  local c=TppClock.ParseTimeString(n,"number")
  local time=animalSetting.timeLag
  if time==nil then
    time=this.GetDefaultTimeTable(animalType).timeLag
  end
  local o=TppClock.ParseTimeString(time,"number")
  local currentTime=TppClock.GetTime"number"
  local n=0
  if setupTable.isDead==false then
    if setupTable.isHerd==false then
      for a=0,(groupNumber-1)do
        n=o*a
        if this._IsNight(currentTime,r+n,c+n)then
          this._SetRoute(setupTable.type,setupTable.locatorFormat,setupTable.nightRouteFormat,a)
        else
          this._SetRoute(setupTable.type,setupTable.locatorFormat,setupTable.routeFormat,a)
        end
      end
    else
      for a=0,(groupNumber-1)do
        n=o*a
        if this._IsNight(currentTime,r+n,c+n)then
          this._SetHerdRoute(setupTable.type,setupTable.locatorFormat,setupTable.nightRouteFormat,a)
        else
          this._SetHerdRoute(setupTable.type,setupTable.locatorFormat,setupTable.routeFormat,a)
        end
      end
    end
  else
    this._ChangeDeadState(setupTable.type,animalSetting.position,animalSetting.degRotationY)
  end
end
function this._SetHerdRoute(type,a,n,t)
  local herdId={type=type,index=0}
  if herdId==NULL_ID then
    return
  end
  local name=string.format(a,t)
  local route=string.format(n,t)
  local command={id="SetHerdEnabledCommand",type="Route",name=name,instanceIndex=0,route=route}
  GameObject.SendCommand(herdId,command)
end
function this._SetRoute(type,a,n,t)
  local herdId={type=type,index=0}
  if herdId==NULL_ID then
    return
  end
  local name=string.format(a,t)
  local route=string.format(n,t)
  local command={id="SetRoute",name=name,route=route}
  GameObject.SendCommand(herdId,command)
end
function this._ChangeDeadState(type,position,rotY)
  local herdId={type=type,index=0}
  if herdId==NULL_ID then
    return
  end
  local position=position or Vector3(0,0,0)
  local degRotationY=rotY or 0
  local command={id="ChangeDeadState",position=position,degRotationY=degRotationY}
  GameObject.SendCommand(herdId,command)
end
function this._RegisterWeatherTable(sender,param,func)
  this.weatherTable[weatherTableCount]={
    msg="Clock",sender=sender,func=function(l,a)
      if func then
        func(sender,a)
      else
        this._ChangeRouteAtTime(sender,a)
      end
    end
  }
  weatherTableCount=weatherTableCount+1
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
  local numAnimals=1
  if IsTable(t)then
    numAnimals=t.groupNumber or 0
  end
  if r+numAnimals>maxAnimals then
    return
  end
  local m=r+numAnimals
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
  weatherTableCount=0
  for a=r,m-1 do
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,c,t,true,a)
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,i,t,false,a)
    l_numAnimals=l_numAnimals+1
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
    if IsString(e)then
      o=e
    elseif IsTable(e)then
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
  local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(blockId)
end
function this.InitializeBlockStatus()
  local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  TppScriptBlock.ClearSavedScriptBlockInfo(blockId)
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
  l_numAnimals=0
  this.weatherTable={}
  local t=mvars.loc_locationAnimalSettingTable
  local t=t.animalTypeSetting[mvars.animalBlockKeyName]
  local l=0
  for o,n in pairs(t)do
    local animalType
    local animalSetting
    if IsString(n)then
      animalType=n
    elseif IsTable(n)then
      animalType=o
      animalSetting=n
    end
    local setupTable=this._GetSetupTable(animalType)
    if setupTable~=nil and animalType~="NoAnimal"then
      this._InitializeCommonAnimalSetting(animalType,animalSetting,setupTable)
      this._AddClockMessage(animalType,animalSetting,setupTable,l)
      TppFreeHeliRadio.RegistAnimalOptionalRadio(animalType)
      local e=animalSetting.groupNumber or 0
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
  local locationAnimalSettingTable=mvars.loc_locationAnimalSettingTable
  local animalSetting=locationAnimalSettingTable.animalTypeSetting[mvars.animalBlockKeyName]
  local numAnimals=0
  for k,v in pairs(animalSetting)do
    local animalType
    local l
    if IsString(v)then
      animalType=v
    elseif IsTable(v)then
      animalType=k
      l=v
    end
    --REF setupTable {type="TppGoat",locatorFormat="anml_goat_%02d",routeFormat="rt_anml_goat_%02d",nightRouteFormat="rt_anml_goat_n%02d",isHerd=true,isDead=false},
    local setupTable=this._GetSetupTable(animalType)
    if setupTable~=nil and animalType~="NoAnimal"then
      local groupNumber=l.groupNumber or 0
      if numAnimals+groupNumber>maxAnimals then
        break
      end
      numAnimals=numAnimals+groupNumber
    end
  end
  l_numAnimals=numAnimals
  this._MakeMessageExecTable()
end
function this.OnAllocate(missionTable)
  local blockId=GetCurrentScriptBlockId()
  TppScriptBlock.InitScriptBlockState(blockId)
  mvars.animalBlockScript=missionTable
  local t,a=Tpp.GetCurrentStageSmallBlockIndex()
  this._UpdateActiveAnimalBlock(t,a)
  function mvars.animalBlockScript.OnMessage(e,e,e,e,e,e,e)
  end
end
function this.OnTerminate()
  if mvars.animalBlockScript.DidInitialized then
    for a=0,l_numAnimals-1 do
      local t=string.format(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,a)
      TppClock.UnregisterClockMessage(t)
      t=string.format(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,a)
      TppClock.UnregisterClockMessage(t)
    end
  end
  local blockId=GetCurrentScriptBlockId()
  TppScriptBlock.FinalizeScriptBlockState(blockId)
  TppFreeHeliRadio.UnregistAnimalOptionalRadio()
  mvars.animalBlockScript.DidInitialized=nil
  mvars.animalBlockScript.OnReload=nil
  mvars.animalBlockScript.OnMessage=nil
  mvars.animalBlockScript=nil
end
return this

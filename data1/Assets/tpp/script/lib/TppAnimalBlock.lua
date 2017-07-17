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
function this.GetDefaultTimeTable(animalType)
  --tex REWORKED
  return nightTimes[animalType]
    --ORIG
    --  if animal=="Goat"then
    --    return nightTimes.Goat
    --  elseif animal=="Wolf"then
    --    return nightTimes.Wolf
    --  elseif animal=="Bear"then
    --    return nightTimes.Bear
    --  elseif animal=="Nubian"then
    --    return nightTimes.Nubian
    --  elseif animal=="Jackal"then
    --    return nightTimes.Jackal
    --  elseif animal=="Zebra"then
    --    return nightTimes.Zebra
    --  elseif animal=="BuddyPuppy"then
    --    return nightTimes.BuddyPuppy
    --  elseif animal=="MotherDog"then
    --    return nightTimes.MotherDog
    --  elseif animal=="Rat"then
    --    return nightTimes.Rat
    --  elseif animal=="NoAnimal"then
    --    return nightTimes.NoAnimal
    --  else
    --    return nil
    --  end
end
function this.StopAnimalBlockLoad()
  mvars.anm_stopAnimalBlockLoad=true
end
function this.UpdateLoadAnimalBlock(blockIndexX,blockIndexY)
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
  local animalBlockKeyName,animalBlockAreaName=this._GetAnimalBlockAreaName(animalAreaSetting,MAX_AREA_NUM,"loadArea",blockIndexX,blockIndexY)
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
function this._UpdateActiveAnimalBlock(blockIndexX,blockIndexY)
  local loc_locationAnimalSettingTable=mvars.loc_locationAnimalSettingTable
  local animalAreaSetting=loc_locationAnimalSettingTable.animalAreaSetting
  local MAX_AREA_NUM=loc_locationAnimalSettingTable.MAX_AREA_NUM
  if not MAX_AREA_NUM then
    return
  end
  local animalBlockKeyName,animalBlockAreaName=this._GetAnimalBlockAreaName(animalAreaSetting,MAX_AREA_NUM,"activeArea",blockIndexX,blockIndexY)
  if animalBlockAreaName~=nil then
    local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.ActivateScriptBlockState(blockId)
  else
    local blockId=ScriptBlock.GetScriptBlockId(animalBlockName)
    TppScriptBlock.DeactivateScriptBlockState(blockId)
  end
end
-- RET: animalBlockKeyName,animalBlockAreaName
function this._GetAnimalBlockAreaName(areaSettings,maxAreaNum,areaKey,blockIndexX,blockIndexY)
  --ORPHAN local o=areaSettings
  for i=1,maxAreaNum do
    local areaSetting=areaSettings[i]
    local areaExtents=areaSetting[areaKey]
    if CheckBlockArea(areaExtents,blockIndexX,blockIndexY)then
      for i,areaDef in ipairs(areaSetting.defines)do
        if(not Tpp.IsTypeFunc(areaDef.conditionFunc))or(areaDef.conditionFunc())then
          local time=TppClock.GetTime"number"
          return areaDef.keyList[time%#areaDef.keyList+1],areaSetting.areaName
        end
      end
    end
  end
end
function this._GetSetupTable(animalType)
  --tex REWORKED
  return animalsTable[animalType]
    --ORIG
    --  if animalType=="Goat"then
    --    return animalsTable.Goat
    --  elseif animalType=="Wolf"then
    --    return animalsTable.Wolf
    --  elseif animalType=="Bear"then
    --    return animalsTable.Bear
    --  elseif animalType=="Nubian"then
    --    return animalsTable.Nubian
    --  elseif animalType=="Jackal"then
    --    return animalsTable.Jackal
    --  elseif animalType=="Zebra"then
    --    return animalsTable.Zebra
    --  elseif animalType=="BuddyPuppy"then
    --    return animalsTable.BuddyPuppy
    --  elseif animalType=="MotherDog"then
    --    return animalsTable.MotherDog
    --  elseif animalType=="Rat"then
    --    return animalsTable.Rat
    --  elseif animalType=="NoAnimal"then
    --    return animalsTable.NoAnimal
    --  else
    --    return nil
    --  end
end
function this._IsNight(currentTime,nightStart,nightEnd)
  local isNight=(currentTime<nightEnd)or(currentTime>=nightStart)
  return isNight
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
  local nightStartTime=animalSetting.nightStartTime
  if nightStartTime==nil then
    nightStartTime=this.GetDefaultTimeTable(animalType).nightStartTime
  end
  local nightStartClockTime=TppClock.ParseTimeString(nightStartTime,"number")
  local nightEndTime=animalSetting.nightEndTime
  if nightEndTime==nil then
    nightEndTime=this.GetDefaultTimeTable(animalType).nightEndTime
  end
  local nightEndClockTime=TppClock.ParseTimeString(nightEndTime,"number")
  local timeLag=animalSetting.timeLag
  if timeLag==nil then
    timeLag=this.GetDefaultTimeTable(animalType).timeLag
  end
  local timeLagClockTime=TppClock.ParseTimeString(timeLag,"number")
  local currentTime=TppClock.GetTime"number"
  local timeLagForAnimal=0
  if setupTable.isDead==false then
    if setupTable.isHerd==false then
      for animalIndex=0,(groupNumber-1)do
        timeLagForAnimal=timeLagClockTime*animalIndex
        if this._IsNight(currentTime,nightStartClockTime+timeLagForAnimal,nightEndClockTime+timeLagForAnimal)then
          this._SetRoute(setupTable.type,setupTable.locatorFormat,setupTable.nightRouteFormat,animalIndex)
        else
          this._SetRoute(setupTable.type,setupTable.locatorFormat,setupTable.routeFormat,animalIndex)
        end
      end
    else
      for animalIndex=0,(groupNumber-1)do
        timeLagForAnimal=timeLagClockTime*animalIndex
        if this._IsNight(currentTime,nightStartClockTime+timeLagForAnimal,nightEndClockTime+timeLagForAnimal)then
          this._SetHerdRoute(setupTable.type,setupTable.locatorFormat,setupTable.nightRouteFormat,animalIndex)
        else
          this._SetHerdRoute(setupTable.type,setupTable.locatorFormat,setupTable.routeFormat,animalIndex)
        end
      end
    end
  else
    this._ChangeDeadState(setupTable.type,animalSetting.position,animalSetting.degRotationY)
  end
end
function this._SetHerdRoute(type,locatorFormat,routeFormat,groupIndex)
  local herdId={type=type,index=0}
  if herdId==NULL_ID then
    return
  end
  local name=string.format(locatorFormat,groupIndex)
  local route=string.format(routeFormat,groupIndex)
  local command={id="SetHerdEnabledCommand",type="Route",name=name,instanceIndex=0,route=route}
  GameObject.SendCommand(herdId,command)
end
function this._SetRoute(type,locatorFormat,routeFormat,animalIndex)
  local herdId={type=type,index=0}
  if herdId==NULL_ID then
    return
  end
  local name=string.format(locatorFormat,animalIndex)
  local route=string.format(routeFormat,animalIndex)
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
    msg="Clock",sender=sender,func=function(_sender,time)
      if func then
        func(sender,time)
      else
        this._ChangeRouteAtTime(sender,time)
      end
    end
  }
  weatherTableCount=weatherTableCount+1
end
function this._RegisterClockMessage(clockFmt,clockTime,timeLagClock,RENsomeBool,animalGroupCount,changeRouteFunc)
  local clockName=string.format(clockFmt,animalGroupCount)
  this._RegisterWeatherTable(clockName,RENsomeBool,changeRouteFunc)
  local time=clockTime+timeLagClock*animalGroupCount
  local tppClockTime=TppClock.FormalizeTime(time,"string")
  TppClock.RegisterClockMessage(clockName,tppClockTime)
  return clockName
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
  local nightStartTime=t.nightStartTime
  if nightStartTime==nil then
    nightStartTime=this.GetDefaultTimeTable(n).nightStartTime
  end
  local c=TppClock.ParseTimeString(nightStartTime,"number")
  local nightEndTime=t.nightEndTime
  if nightEndTime==nil then
    nightEndTime=this.GetDefaultTimeTable(n).nightEndTime
  end
  local i=TppClock.ParseTimeString(nightEndTime,"number")
  local timeLag=t.timeLag
  if timeLag==nil then
    timeLag=this.GetDefaultTimeTable(n).timeLag
  end
  local t=TppClock.ParseTimeString(timeLag,"number")
  weatherTableCount=0
  for a=r,m-1 do
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,c,t,true,a)
    this._RegisterClockMessage(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,i,t,false,a)
    l_numAnimals=l_numAnimals+1
  end
end
function this._ChangeRouteAtTime(sender,time)
  local a=mvars.loc_locationAnimalSettingTable
  local o=a.animalTypeSetting[mvars.animalBlockKeyName]
  local a=-1
  for e in string.gmatch(sender,"%d+")do
    a=tonumber(e)
  end
  if a==-1 then
    return
  end
  local l=0
  local animalType=nil
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
    local groupNumber=t.groupNumber or 0
    if l<=a and a<l+groupNumber then
      animalType=o
      r=t
      break
    end
    l=l+groupNumber
  end
  if animalType==nil or r==nil then
    return
  end
  local t=this._GetSetupTable(animalType)
  if t==nil then
    return
  end
  local a=a-l
  local isNight=this._IsNightForAnimalType(animalType,time)
  if animalType=="Bear"then
    if isNight then
      this._SetRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
    else
      this._SetRoute(t.type,t.locatorFormat,t.routeFormat,a)
    end
  else
    if isNight then
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
  mvars.animalBlockScript.Messages=Tpp.StrCode32Table{
    Block={
      {msg="StageBlockCurrentSmallBlockIndexUpdated",func=function(x,y)this._UpdateActiveAnimalBlock(x,y)end}
    }
  }
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
      local groupNumber=animalSetting.groupNumber or 0
      l=l+groupNumber
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
  local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()
  this._UpdateActiveAnimalBlock(blockIndexX,blockIndexY)
  function mvars.animalBlockScript.OnMessage(e,e,e,e,e,e,e)
  end
end
function this.OnTerminate()
  if mvars.animalBlockScript.DidInitialized then
    for i=0,l_numAnimals-1 do
      local t=string.format(this.CLOCK_MESSAGE_AT_NIGHT_FORMAT,i)
      TppClock.UnregisterClockMessage(t)
      t=string.format(this.CLOCK_MESSAGE_AT_MORNING_FORMAT,i)
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

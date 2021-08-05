-- DOBUILD: 0
-- TppWeather.lua
local this={}
local minuteInSeconds=60
local hourInSeconds=60*60

--tex following tables changed from locals to module members
this.weatherProbabilitiesTable={
  AFGH={
    {TppDefine.WEATHER.SUNNY,80},
    {TppDefine.WEATHER.CLOUDY,20}
  },
  MAFR={
    {TppDefine.WEATHER.SUNNY,70},
    {TppDefine.WEATHER.CLOUDY,30}
  },
  MTBS={
    {TppDefine.WEATHER.SUNNY,80},
    {TppDefine.WEATHER.CLOUDY,20}
  },
}
this.weatherProbabilitiesTable.AFGH_NO_SANDSTORM=this.weatherProbabilitiesTable.AFGH--tex use it directly since it was same values any way
this.weatherDurations={
  {TppDefine.WEATHER.SUNNY,5*hourInSeconds,8*hourInSeconds},
  {TppDefine.WEATHER.CLOUDY,3*hourInSeconds,5*hourInSeconds},
  {TppDefine.WEATHER.SANDSTORM,13*minuteInSeconds,20*minuteInSeconds},
  {TppDefine.WEATHER.RAINY,1*hourInSeconds,2*hourInSeconds},
  {TppDefine.WEATHER.FOGGY,13*minuteInSeconds,20*minuteInSeconds}
}
--tex broken out from SetDefaultWeatherDurations>
this.extraWeatherInterval={
  min=5*hourInSeconds,
  max=8*hourInSeconds,
}
--<
this.extraWeatherProbabilitiesTable={
  NONE={},--tex added
  AFGH={{TppDefine.WEATHER.SANDSTORM,100}},
  MAFR={{TppDefine.WEATHER.RAINY,100}},
  MTBS={
    {TppDefine.WEATHER.RAINY,50},
    {TppDefine.WEATHER.FOGGY,50}
  },
  AFGH_HELI={},
  MAFR_HELI={{TppDefine.WEATHER.RAINY,100}},
  MTBS_HELI={{TppDefine.WEATHER.RAINY,100}},
  --AFGH_NO_SANDSTORM={}--tex SetWeatherProbabilitiesAfghNoSandStorm now uses NONE
}
--tex> CULL
local altExtraWeatherProbabilitiesTable={
  AFGH={
    {TppDefine.WEATHER.SANDSTORM,80},
    {TppDefine.WEATHER.RAINY,10},
    {TppDefine.WEATHER.FOGGY,10},
  },
  MAFR={
    {TppDefine.WEATHER.RAINY,70},
    {TppDefine.WEATHER.FOGGY,20},
    {TppDefine.WEATHER.SANDSTORM,10},
  },
  MTBS={
    {TppDefine.WEATHER.RAINY,50},
    {TppDefine.WEATHER.FOGGY,50},
  },
  AFGH_HELI={},
  MAFR_HELI={
    {TppDefine.WEATHER.RAINY,60},
    {TppDefine.WEATHER.FOGGY,40},
  },
  MTBS_HELI={
    {TppDefine.WEATHER.RAINY,70},
    {TppDefine.WEATHER.SANDSTORM,30},
  },
}
--<
local sandStormOrFoggy={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local userIdScript="Script"
local userIdWeather="WeatherSystem"
local defaultInterpTime=20
local unkM1NoWeather=255
function this.RequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(true)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{
    priority=WeatherManager.REQUEST_PRIORITY_NORMAL,
    userId=userIdScript,
    weatherType=weatherType,
    interpTime=interpTime,
    fogDensity=fogInfo.fogDensity,
    fogType=fogInfo.fogType
  }
end
function this.CancelRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(false)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  if weatherType~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,
      userId=userIdScript,
      weatherType=weatherType,
      interpTime=interpTime,
      fogDensity=fogInfo.fogDensity,
      fogType=fogInfo.fogType
    }
  end
end
function this.ForceRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{
    priority=WeatherManager.REQUEST_PRIORITY_FORCE,
    userId=userIdScript,
    weatherType=weatherType,
    interpTime=interpTime,
    fogDensity=fogInfo.fogDensity,
    fogType=fogInfo.fogType
  }
end
function this.CancelForceRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=userIdScript}
  if weatherType~=nil then
    WeatherManager.RequestWeather{
      priority=WeatherManager.REQUEST_PRIORITY_NORMAL,
      userId=userIdScript,
      weatherType=weatherType,
      interpTime=interpTime,
      fogDensity=fogInfo.fogDensity,
      fogType=fogInfo.fogType
    }
  end
end
--CALLER: TppMain.OnMissionCanStart
function this.SetDefaultWeatherDurations()
  WeatherManager.SetWeatherDurations(this.weatherDurations)
  if not WeatherManager.SetExtraWeatherInterval then
    return
  end
  WeatherManager.SetExtraWeatherInterval(this.extraWeatherInterval.min,this.extraWeatherInterval.max)--tex values broken out to extraWeatherInterval
end
--CALLER: TppMain.OnMissionCanStart
--tex hooking in InfWeather so I don't disturb existing mods
function this.SetDefaultWeatherProbabilities()
  local weatherProbabilities
  local extraWeatherProbabilities
  local isHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)

  --tex reworked>
  local locationName=TppLocation.GetLocationName()
  locationName=string.upper(locationName)
  local heliSuffix=""
  if isHeliSpace then
    heliSuffix="_HELI"
  end

  weatherProbabilities=this.weatherProbabilitiesTable[locationName]
  extraWeatherProbabilities=this.extraWeatherProbabilitiesTable[locationName..heliSuffix] or this.extraWeatherProbabilitiesTable.NONE
  --<
  -- ORIG
  --  if TppLocation.IsAfghan()then
  --    weatherProbabilities=weatherProbabilitiesTable.AFGH
  --    if isHeliSpace then
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.AFGH_HELI
  --    else
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.AFGH
  --    end
  --  elseif TppLocation.IsMiddleAfrica()then
  --    weatherProbabilities=weatherProbabilitiesTable.MAFR
  --    if isHeliSpace then
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.MAFR_HELI
  --    else
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.MAFR
  --    end
  --  elseif TppLocation.IsMotherBase()then
  --    weatherProbabilities=weatherProbabilitiesTable.MTBS
  --    if isHeliSpace then
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.MTBS_HELI
  --    else
  --      extraWeatherProbabilities=extraWeatherProbabilitiesTable.MTBS
  --    end
  --  end
  if weatherProbabilities then
    WeatherManager.SetNewWeatherProbabilities("default",weatherProbabilities)
  end
  if extraWeatherProbabilities then
    WeatherManager.SetExtraWeatherProbabilities(extraWeatherProbabilities)
  end
end--SetDefaultWeatherProbabilities
--CALLER: several story missions
function this.SetWeatherProbabilitiesAfghNoSandStorm()
  WeatherManager.SetNewWeatherProbabilities("default",this.weatherProbabilitiesTable.AFGH_NO_SANDSTORM)
  WeatherManager.SetExtraWeatherProbabilities(this.extraWeatherProbabilitiesTable.NONE)--tex was extraWeatherProbabilitiesTable.AFGH_NO_SANDSTORM
end
function this.SetMissionStartWeather(weatherType)
  mvars.missionStartWeatherScript=weatherType
end
function this.SaveMissionStartWeather()
  gvars.missionStartWeather=vars.weather
  if sandStormOrFoggy[gvars.missionStartWeather]then
    gvars.missionStartWeather=TppDefine.WEATHER.SUNNY
  end
  WeatherManager.StoreToSVars()
  gvars.missionStartWeatherNextTime=vars.weatherNextTime
  gvars.missionStartExtraWeatherInterval=vars.extraWeatherInterval
end
function this.RestoreMissionStartWeather()
  WeatherManager.InitializeWeather()
  local missionStartWeather=mvars.missionStartWeatherScript or gvars.missionStartWeather
  local defaultWeatherType=TppDefine.WEATHER.SUNNY
  local weatherType
  if missionStartWeather==TppDefine.WEATHER.SANDSTORM or missionStartWeather==TppDefine.WEATHER.RAINY then
    weatherType=missionStartWeather
  else
    defaultWeatherType=missionStartWeather
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdWeather,weatherType=defaultWeatherType,interpTime=defaultInterpTime}
  if weatherType~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_EXTRA,userId=userIdWeather,weatherType=weatherType,interpTime=defaultInterpTime}
  end
  WeatherManager.StoreToSVars()
  vars.weatherNextTime=gvars.missionStartWeatherNextTime
  vars.extraWeatherInterval=gvars.missionStartExtraWeatherInterval
  WeatherManager.RestoreFromSVars()
end
--no refrences
function this.OverrideColorCorrectionLUT(unk1)
  TppColorCorrection.SetLUT(unk1)
end
function this.RestoreColorCorrectionLUT()
  TppColorCorrection.RemoveLUT()
end
--no refrences
function this.OverrideColorCorrectionParameter(unk1,unk2,unk3)
  TppColorCorrection.SetParameter(unk1,unk2,unk3)
end
function this.RestoreColorCorrectionParameter()
  TppColorCorrection.RemoveParameter()
end
function this.StoreToSVars()
  WeatherManager.StoreToSVars()
end
function this.RestoreFromSVars()
  local isFOBMission=TppMission.IsFOBMission(vars.missionCode)
  if isFOBMission then
  else
    local normalWeatherType=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]
    if sandStormOrFoggy[normalWeatherType]then
      vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]=TppDefine.WEATHER.SUNNY
      vars.weatherNextTime=0
    end
    local extraWeatherType=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]
    if sandStormOrFoggy[extraWeatherType]then
      vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=unkM1NoWeather
      vars.weatherNextTime=0
    end
  end
  WeatherManager.RestoreFromSVars()
end
function this.Init()
  TppEffectUtility.RemoveColorCorrectionLut()
  TppEffectUtility.RemoveColorCorrectionParameter()
end
function this.OnMissionCanStart()
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    TppEffectWeatherParameterMediator.SetParameters{addTppSkyOffsetY=1320,setTppSkyScale=.1,setTppSkyScrollSpeedRate=-20}
  else
    TppEffectWeatherParameterMediator.RestoreDefaultParameters()
  end
end
local SetDefaultReflectionTexture=WeatherManager.SetDefaultReflectionTexture or function()end
function this.OnEndMissionPrepareFunction()
  if WeatherManager.ClearTag then
    WeatherManager.ClearTag()
  else
    WeatherManager.RequestTag("default",0)
  end
  SetDefaultReflectionTexture()
end
--NMC returns interpTime (integer), fogInfo (table)
function this._GetRequestWeatherArgs(param1,param2)
  if Tpp.IsTypeTable(param1)then
    return nil,param1
  elseif Tpp.IsTypeTable(param2)then
    return param1,param2
  else
    return param1,{}
  end
end
return this

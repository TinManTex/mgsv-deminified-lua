-- DOBUILD: 0
-- TppWeather.lua
local this={}
local minuteInSeconds=60
local hourInSeconds=60*60

local weatherProbabilitiesTable={
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
  AFGH_NO_SANDSTORM={
    {TppDefine.WEATHER.SUNNY,80},
    {TppDefine.WEATHER.CLOUDY,20}
  }
}
local weatherDurations={
  {TppDefine.WEATHER.SUNNY,5*hourInSeconds,8*hourInSeconds},
  {TppDefine.WEATHER.CLOUDY,3*hourInSeconds,5*hourInSeconds},
  {TppDefine.WEATHER.SANDSTORM,13*minuteInSeconds,20*minuteInSeconds},
  {TppDefine.WEATHER.RAINY,1*hourInSeconds,2*hourInSeconds},
  {TppDefine.WEATHER.FOGGY,13*minuteInSeconds,20*minuteInSeconds}
}
--tex broken out from SetDefaultWeatherDurations>
local extraWeatherInterval={
  min=5*hourInSeconds,
  max=8*hourInSeconds,
}
--<
local extraWeatherProbabilitiesTable={
  AFGH={{TppDefine.WEATHER.SANDSTORM,100}},
  MAFR={{TppDefine.WEATHER.RAINY,100}},
  MTBS={
    {TppDefine.WEATHER.RAINY,50},
    {TppDefine.WEATHER.FOGGY,50}
  },
  AFGH_HELI={},
  MAFR_HELI={{TppDefine.WEATHER.RAINY,100}},
  MTBS_HELI={{TppDefine.WEATHER.RAINY,100}},
  AFGH_NO_SANDSTORM={}
}
--tex>
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
  AFGH_NO_SANDSTORM={}
}
--<
local sandStormOrFoggy={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local userIdScript="Script"
local userIdWeather="WeatherSystem"
local defaultInterpTime=20
local RENnoWeather=255
function this.RequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(true)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdScript,weatherType=weatherType,interpTime=interpTime,fogDensity=fogInfo.fogDensity,fogType=fogInfo.fogType}
end
function this.CancelRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(false)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  if weatherType~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdScript,weatherType=weatherType,interpTime=interpTime,fogDensity=fogInfo.fogDensity,fogType=fogInfo.fogType}
  end
end
function this.ForceRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=userIdScript,weatherType=weatherType,interpTime=interpTime,fogDensity=fogInfo.fogDensity,fogType=fogInfo.fogType}
end
function this.CancelForceRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=userIdScript}
  if weatherType~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdScript,weatherType=weatherType,interpTime=interpTime,fogDensity=fogInfo.fogDensity,fogType=fogInfo.fogType}
  end
end
function this.SetDefaultWeatherDurations()
  WeatherManager.SetWeatherDurations(weatherDurations)
  if not WeatherManager.SetExtraWeatherInterval then
    return
  end
  WeatherManager.SetExtraWeatherInterval(extraWeatherInterval.min,extraWeatherInterval.max)--tex values broken out to extraWeatherInterval
end
function this.SetDefaultWeatherProbabilities()
  local weatherProbabilities
  local extraWeatherProbabilities
  local isHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)

  --tex reworked>
  local locationName=InfUtil.GetLocationName()--tex use TppLocation.GetLocationName() if modding this independantly from Infinite Heaven
  locationName=string.upper(locationName)
  local heliSuffix=""
  if isHeliSpace then
    heliSuffix="_HELI"
  end

  weatherProbabilities=weatherProbabilitiesTable[locationName]
  extraWeatherProbabilities=extraWeatherProbabilitiesTable[locationName..heliSuffix]
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
end
function this.SetWeatherProbabilitiesAfghNoSandStorm()
  WeatherManager.SetNewWeatherProbabilities("default",weatherProbabilitiesTable.AFGH_NO_SANDSTORM)
  WeatherManager.SetExtraWeatherProbabilities(extraWeatherProbabilitiesTable.AFGH_NO_SANDSTORM)
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
function this.OverrideColorCorrectionLUT(e)
  TppColorCorrection.SetLUT(e)
end
function this.RestoreColorCorrectionLUT()
  TppColorCorrection.RemoveLUT()
end
function this.OverrideColorCorrectionParameter(t,e,r)
  TppColorCorrection.SetParameter(t,e,r)
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
      vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=RENnoWeather
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
--returns interpTime (integer), fogInfo (table)
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

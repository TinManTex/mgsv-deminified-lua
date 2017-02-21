-- DOBUILD: 1
local this={}
local StrCode32=Fox.StrCode32
local t=(1/60)/60
local c=1/60
local hour=60*60
local minute=60
this.DEPLOY_TIME={CURRENT=0,MORNING=1,NIGHT=2}
function this.FormalizeTime(time,_timeStringType)
  local timeStringType=_timeStringType or"time"
  if(timeStringType=="number")then
    return time
  end
  local hours=math.floor(time*t)
  local l=hours*hour
  local minutes=math.floor((time-l)*c)
  local o=minutes*minute
  local seconds=math.floor((time-l)-o)
  local l=seconds
  if(timeStringType=="time")then
    return hours,minutes,seconds
  elseif(timeStringType=="string")then
    return string.format("%02d:%02d:%02d",hours,minutes,seconds)
  else
    return nil
  end
end
this.DAY_TO_NIGHT=this.FormalizeTime(WeatherManager.NIGHT_START_CLOCK,"string")
this.NIGHT_TO_DAY=this.FormalizeTime(WeatherManager.NIGHT_END_CLOCK,"string")
this.NIGHT_TO_MIDNIGHT="22:00:00"
function this.RegisterClockMessage(id,_seconds)
  local seconds
  if(type(_seconds)=="string")then
    seconds=this.ParseTimeString(_seconds,"number")
  elseif(type(_seconds)=="number")then
    seconds=_seconds
  else
    return
  end
  TppCommand.Weather.RegisterClockMessage{id=StrCode32(id),seconds=seconds,isRepeat=true,nil}
end
function this.UnregisterClockMessage(id)
  TppCommand.Weather.UnregisterClockMessage{id=StrCode32(id)}
end
function this.GetTime(timeStringType)
  return this.FormalizeTime(vars.clock,timeStringType)
end
function this.GetTimeOfDay()
  if(WeatherManager.IsNight())then
    return"night"
  else
    return"day"
  end
end
function this.GetTimeOfDayIncludeMidNight()
  if WeatherManager.IsNight()then
    local currentTime=this.GetTime"number"
  if(currentTime<this.TIME_AT_MIDNIGHT)then
      return"night"
    else
      return"midnight"
    end
  else
    return"day"
  end
end
function this.SetTime(time)
  local seconds=this.ParseTimeString(time,"number")
  vars.clock=seconds
end
function this.AddTime(time)
  local seconds
  if(type(time)=="number")then
    seconds=time
  else
    seconds=this.ParseTimeString(time,"number")
  end
  vars.clock=vars.clock+seconds
end
function this.SetTimeFromHelicopterSpace(deployTime,fromLocation,toLocation)
  if(deployTime==this.DEPLOY_TIME.CURRENT)or(deployTime==nil)then
    this.AddTimeFromHelicopterSpace(fromLocation,toLocation)
    return
  end
  if deployTime==this.DEPLOY_TIME.MORNING then
    vars.clock=this.TIME_AT_MORNING
    return
  end
  if deployTime==this.DEPLOY_TIME.NIGHT then
    vars.clock=this.TIME_AT_NIGHT
    return
  end
  this.AddTimeFromHelicopterSpace(fromLocation,toLocation)
end
function this.AddTimeFromHelicopterSpace(fromLocation,toLocation)
  local idLocationChange
  local function IsToMotherBase(locationCode)
    if(locationCode==50)or(locationCode==55)then
      return true
    else
      return false
    end
  end
  if fromLocation~=toLocation then
    if IsToMotherBase(fromLocation)and IsToMotherBase(toLocation)then
      idLocationChange=false
    else
      idLocationChange=true
    end
  else
    idLocationChange=false
  end
  local addTime
  if idLocationChange then
    addTime=6
  else
    addTime=1
  end
  this.AddTime(addTime*hour)
end
function this.Start()
  TppCommand.Weather.SetClockTimeScale(Ivars.clockTimeScale:Get())--tex was 20
end
function this.Stop()
  TppCommand.Weather.SetClockTimeScale(0)
end
function this.SaveMissionStartClock(time)
  if time then
    gvars.missionStartClock=this.ParseTimeString(time,"number")
  else
    gvars.missionStartClock=vars.clock
  end
end
function this.RestoreMissionStartClock()
  vars.clock=gvars.missionStartClock
end
function this.ParseTimeString(timeString,timeType)
  if(type(timeString)~="string")then
    return nil
  end
  local splitString=Tpp.SplitString(timeString,":")
  local hours=tonumber(splitString[1])
  local minutes=tonumber(splitString[2])
  local seconds=tonumber(splitString[3])
  timeType=timeType or"time"
  if(timeType=="time")then
    return hours,minutes,seconds
  elseif(timeType=="number")then
    local hoursSec=hours*hour
    local minutesSec=minutes*minute
    local sec=seconds
    return((hoursSec+minutesSec)+sec)
  else
    return nil
  end
end
function this.OnAllocate(n)
  if TppCommand.Weather.UnregisterAllClockMessages then
    TppCommand.Weather.UnregisterAllClockMessages()
  end
end
this.TIME_AT_NIGHT=this.ParseTimeString(this.DAY_TO_NIGHT,"number")
this.TIME_AT_MORNING=this.ParseTimeString(this.NIGHT_TO_DAY,"number")
this.TIME_AT_MIDNIGHT=this.ParseTimeString(this.NIGHT_TO_MIDNIGHT,"number")
return this

-- DOBUILD: 1
-- TppMission.lua
local this={}
local StrCode32=InfLog.StrCode32--tex was Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local n=GkEventTimerManager.Start
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local SVarsIsSynchronized=TppScriptVars.SVarsIsSynchronized
local RegistPlayRecord=PlayRecord.RegistPlayRecord
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local TimerStart=GkEventTimerManager.Start
local TimerStop=GkEventTimerManager.Stop
local IsTimerActive=GkEventTimerManager.IsTimerActive
local IsHelicopter=Tpp.IsHelicopter
local IsNotAlert=Tpp.IsNotAlert
local IsPlayerStatusNormal=Tpp.IsPlayerStatusNormal
local r=DemoDaemon.IsDemoPlaying
local r=10
local r=3
local outSideOfHotZoneCount=5
local outSideOfInnerZoneTime=2.5
local Timer_outsideOfInnerZone="Timer_outsideOfInnerZone"
local missionClearCodeNone=0
local maxObjective=64
local deathLimitToStealthAssistPopup=1--RETAILPATCH 1060 was 2 --deaths till chicken hat popup
local deathLimitToPerfectStealthPopup=0--RETAILPATCH 1060 was 4 --RETAILPATCH 1070 to 0 from 3 --deaths to super chicken hat popup
local dayInSeconds=(24*60)*60
local RENsomenumber=2
local MAX_32BIT_UINT=TppDefine.MAX_32BIT_UINT
local function RegistMissionTimerPlayRecord()
  RegistPlayRecord"MISSION_TIMER_UPDATE"
end
function this.GetMissionID()
  return vars.missionCode
end
function this.GetMissionName()
  return mvars.mis_missionName
end
function this.GetMissionClearType()
  return svars.mis_missionClearType
end
function this.IsDefiniteMissionClear()--RETAILPATCH: 1060
  return svars.mis_isDefiniteMissionClear
end--
function this.RegiserMissionSystemCallback(callbacks)
  this.RegisterMissionSystemCallback(callbacks)
end
function this.RegisterMissionSystemCallback(callbacks)
  if IsTypeTable(callbacks)then
    if IsTypeFunc(callbacks.OnEstablishMissionClear)then
      this.systemCallbacks.OnEstablishMissionClear=callbacks.OnEstablishMissionClear
    end
    if IsTypeFunc(callbacks.OnDisappearGameEndAnnounceLog)then
      this.systemCallbacks.OnDisappearGameEndAnnounceLog=callbacks.OnDisappearGameEndAnnounceLog
    end
    if IsTypeFunc(callbacks.OnEndMissionCredit)then
      this.systemCallbacks.OnEndMissionCredit=callbacks.OnEndMissionCredit
    end
    if IsTypeFunc(callbacks.OnEndMissionReward)then
      this.systemCallbacks.OnEndMissionReward=callbacks.OnEndMissionReward
    end
    if IsTypeFunc(callbacks.OnGameOver)then
      this.systemCallbacks.OnGameOver=callbacks.OnGameOver
    end
    if IsTypeFunc(callbacks.OnOutOfMissionArea)then
      this.systemCallbacks.OnOutOfMissionArea=callbacks.OnOutOfMissionArea
    end
    if IsTypeFunc(callbacks.OnUpdateWhileMissionPrepare)then
      this.systemCallbacks.OnUpdateWhileMissionPrepare=callbacks.OnUpdateWhileMissionPrepare
    end
    if IsTypeFunc(callbacks.OnFobDefenceGameOver)then
      this.systemCallbacks.OnFobDefenceGameOver=callbacks.OnFobDefenceGameOver
    end
    if IsTypeFunc(callbacks.OnFinishBlackTelephoneRadio)then
      this.systemCallbacks.OnFinishBlackTelephoneRadio=callbacks.OnFinishBlackTelephoneRadio
    end
    if IsTypeFunc(callbacks.OnOutOfHotZone)then
    end
    if IsTypeFunc(callbacks.OnOutOfHotZoneMissionClear)then
      this.systemCallbacks.OnOutOfHotZoneMissionClear=callbacks.OnOutOfHotZoneMissionClear
    end
    if IsTypeFunc(callbacks.OnUpdateStorySequenceInGame)then
      this.systemCallbacks.OnUpdateStorySequenceInGame=callbacks.OnUpdateStorySequenceInGame
    end
    if IsTypeFunc(callbacks.CheckMissionClearFunction)then
      this.systemCallbacks.CheckMissionClearFunction=callbacks.CheckMissionClearFunction
    end
    if IsTypeFunc(callbacks.OnReturnToMission)then
      this.systemCallbacks.OnReturnToMission=callbacks.OnReturnToMission
    end
    if IsTypeFunc(callbacks.OnAddStaffsFromTempBuffer)then
      this.systemCallbacks.OnAddStaffsFromTempBuffer=callbacks.OnAddStaffsFromTempBuffer
    end
    if IsTypeFunc(callbacks.CheckMissionClearOnRideOnFultonContainer)then
      this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer=callbacks.CheckMissionClearOnRideOnFultonContainer
    end
    if IsTypeFunc(callbacks.OnRecovered)then
      this.systemCallbacks.OnRecovered=callbacks.OnRecovered
    end
    if IsTypeFunc(callbacks.OnSetMissionFinalScore)then
      this.systemCallbacks.OnSetMissionFinalScore=callbacks.OnSetMissionFinalScore
    end
    if IsTypeFunc(callbacks.OnEndDeliveryWarp)then
      this.systemCallbacks.OnEndDeliveryWarp=callbacks.OnEndDeliveryWarp
    end
    if IsTypeFunc(callbacks.OnMissionGameEndFadeOutFinish)then
      this.systemCallbacks.OnMissionGameEndFadeOutFinish=callbacks.OnMissionGameEndFadeOutFinish
    end
    if IsTypeFunc(callbacks.OnFultonContainerMissionClear)then
      this.systemCallbacks.OnFultonContainerMissionClear=callbacks.OnFultonContainerMissionClear
    end
  end
end
function this.UpdateObjective(objectiveInfo)
  if not mvars.mis_missionObjectiveDefine then
    return
  end
  if mvars.mis_objectiveSetting then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
  local radio=objectiveInfo.radio
  local radioSecond=objectiveInfo.radioSecond
  local options=objectiveInfo.options
  mvars.mis_objectiveSetting=objectiveInfo.objectives
  mvars.mis_updateObjectiveRadioGroupName=nil
  if not IsTypeTable(mvars.mis_objectiveSetting)then
    return
  end
  local n
  if TppSequence.IsHelicopterStart()then
    if not TppPlayer.IsAlreadyDropped()then
      n=true
    end
  end
  if IsTypeTable(options)then
    if options.isForceHelicopterStart then
      n=true
    end
  end
  if n then
    mvars.mis_updateObjectiveOnHelicopterStart=true
  end
  local o=false
  for n,i in pairs(mvars.mis_objectiveSetting)do
    local n=not this.IsEnableMissionObjective(i)
    if n then
      n=not this.IsEnableAnyParentMissionObjective(i)
    end
    if n then
      o=true
      break
    end
  end
  if IsTypeTable(radio)then
    if o then
      if not n then
        mvars.mis_updateObjectiveRadioGroupName=TppRadio.GetRadioNameAndRadioIDs(radio.radioGroups)
      end
      local e=this.GetObjectiveRadioOption(radio)
      TppRadio.Play(radio.radioGroups,e)
    end
  end
  if IsTypeTable(radioSecond)then
    if o then
      local e=this.GetObjectiveRadioOption(radioSecond)
      if n then
        mvars.mis_updateObjectiveDoorOpenRadioGroups=radioSecond.radioGroups
        mvars.mis_updateObjectiveDoorOpenRadioOptions=e
      else
        e.isEnqueue=true
        TppRadio.Play(radioSecond.radioGroups,e)
      end
    end
  end
  if not IsTypeTable(radio)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.SetHelicopterDoorOpenTime(time)
  if not IsTypeNumber(time)then
    return
  end
  mvars.mis_helicopterDoorOpenTimerTimeSec=time
end
function this.UpdateCheckPoint(checkPointInfo)
  TppCheckPoint.Update(checkPointInfo)
end
function this.UpdateCheckPointAtCurrentPosition()
  TppCheckPoint.UpdateAtCurrentPosition()
end
function this.IsMatchStartLocation(missionCode)
  local locationId=TppPackList.GetLocationNameFormMissionCode(missionCode)
  if TppLocation.IsAfghan()then
    if TppDefine.LOCATION_ID[locationId]~=TppDefine.LOCATION_ID.AFGH then
      return false
    end
  elseif TppLocation.IsMiddleAfrica()then
    if TppDefine.LOCATION_ID[locationId]~=TppDefine.LOCATION_ID.MAFR then
      return false
    end
  elseif TppLocation.IsMotherBase()then
    if TppDefine.LOCATION_ID[locationId]~=TppDefine.LOCATION_ID.MTBS then
      return false
    end
  else
    return false
  end
  return true
end
function this.RegistDiscoveryGameOver()
  mvars.mis_isExecuteGameOverOnDiscoveryNotice=true
end
--tex NOTE GOTCHA these should now only be used for mission sequence scripts, otherwise just use the gvar directly
--this is to work around mission timers/setup not triggering on start-on foot because of heli traps not triggering
function this.IsStartFromHelispace()
  return gvars.mis_isStartFromHelispace and Ivars.mis_isGroundStart:Is(0)--tex WORKAROUND added ivar
end
function this.IsStartFromFreePlay()
  return gvars.mis_isStartFromFreePlay or Ivars.mis_isGroundStart:Is(1)--tex WORKAROUND added ivar
end
function this.AcceptMission(missionCode)
  if this.IsEmergencyMission(missionCode)then
    return
  end
  if not this.IsHelicopterSpace(vars.missionCode)then
    return
  end
  this.SetNextMissionCodeForMissionClear(missionCode)
  TppUiCommand.StartMissionPreparation()
end
function this.AcceptMissionOnFreeMission(missionCode,orderBoxBlockList,svarSet)
  if this.IsEmergencyMission(missionCode)then
    return
  end
  local isMatchStarLocation=this.IsMatchStartLocation(missionCode)
  if not isMatchStarLocation then
    return
  end
  local noOrderBoxMissionEnum=TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(missionCode)]
  if noOrderBoxMissionEnum then
    local noOrderFixHeliRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[missionCode]
    if noOrderFixHeliRoute then
      this.ReserveMissionClear{nextMissionId=missionCode,nextHeliRoute=noOrderFixHeliRoute,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    else
      this.ReserveMissionClear{nextMissionId=missionCode,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    end
    return
  end
  local normalMissionCode=missionCode
  if this.IsHardMission(normalMissionCode)then
    normalMissionCode=this.GetNormalMissionCodeFromHardMission(normalMissionCode)
  end
  local orderBoxBlock=orderBoxBlockList[normalMissionCode]
  if orderBoxBlock==nil then
    return
  end
  svars[svarSet]=missionCode
  TppScriptBlock.Load("orderBoxBlock",normalMissionCode,true)
  return true
end
function this.AcceptMissionOnMBFreeMission(missionCode,clusterGrade,mbHeliRouteTable)
  if this.IsEmergencyMission(missionCode)then
    return
  end
  local isMatchStartLocation=this.IsMatchStartLocation(missionCode)
  if not isMatchStartLocation then
    return
  end
  local fixedRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[missionCode]
  if missionCode==10115 then
    fixedRoute=mbHeliRouteTable[clusterGrade][1]
  end
  if fixedRoute then
    this.ReserveMissionClear{nextHeliRoute=fixedRoute,nextMissionId=missionCode,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
  else
    this.ReserveMissionClear{nextMissionId=missionCode,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
  end
end
function this.AcceptEmergencyMission(missionCode,nextLayoutCode,nextClusterId,nextMissionStartRoute)
  if not this.IsEmergencyMission(missionCode)then
    return
  end
  local currentLocationHeliMissionAndLocationCode=this.GetCurrentLocationHeliMissionAndLocationCode()
  if this.IsFOBMission(missionCode)==true then
    vars.returnStaffHeader=vars.playerStaffHeader
    vars.returnStaffSeeds=vars.playerStaffSeed
  end
  this.AbortMission{emergencyMissionId=missionCode,nextMissionId=currentLocationHeliMissionAndLocationCode,nextLayoutCode=nextLayoutCode,nextClusterId=nextClusterId,nextMissionStartRoute=nextMissionStartRoute,isNoSave=true,isInterrupt=true}
end
function this.AcceptStartFobSneaking(layout,cluster,missionId)
  this.SetNextMissionCodeForMissionClear(missionId)
  mvars.mis_nextLayoutCode=TppLocation.ModifyMbsLayoutCode(layout)
  mvars.mis_nextClusterId=cluster
end
function this.SelectNextMissionHeliStartRoute(missionCode,heliRoute,startFobSneaking)
  local isEmergencyMission
  if not startFobSneaking then
    isEmergencyMission=this.IsEmergencyMission(missionCode)
  end
  local noHeliRoute=TppDefine.NO_HELICOPTER_ROUTE_ENUM[tostring(missionCode)]
  if not noHeliRoute then
    local fixedRoute=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[missionCode]
    if fixedRoute then
      heliRoute=StrCode32(fixedRoute)
    end
  else
    heliRoute=0
  end
  if not noHeliRoute then
    if heliRoute==0 then
    end
  end
  if isEmergencyMission then
    gvars.mis_nextMissionCodeForEmergency=missionCode
  else
    this.SetNextMissionCodeForMissionClear(missionCode)
    gvars.heli_missionStartRoute=heliRoute
  end
end
function this.SetHelicopterMissionStartPosition(set,x,y,z)
  if set==1 then
    mvars.mis_helicopterMissionStartPosition={x,y,z}
  else
    mvars.mis_helicopterMissionStartPosition=nil
  end
end
function this.StartEmergencyMissionTimer(timerInfo)
  if not IsTypeTable(timerInfo)then
    return
  end
  local openTimer=timerInfo.openTimer
  if not IsTypeTable(openTimer)then
    return
  end
  local closeTimer=timerInfo.closeTimer
  if not IsTypeTable(closeTimer)then
    return
  end
  local openTimerName,openTimerHeli,openTimerLand=openTimer.name,openTimer.timeSecFromHeli,openTimer.timeSecFromLand
  local closeTimerName,closeTimerHeli,closeTimerLand=closeTimer.name,closeTimer.timeSecFromHeli,closeTimer.timeSecFromLand
  local timerTime
  timerTime=this._StartEmergencyMissionTimer(openTimerName,openTimerHeli,openTimerLand)
  if timerTime then
  else
    return
  end
  timerTime=this._StartEmergencyMissionTimer(closeTimerName,closeTimerHeli,closeTimerLand)
  if timerTime then
  else
    return
  end
end
function this._StartEmergencyMissionTimer(timerName,timeFromHeli,timeFromLand)
  if not IsTypeString(timerName)then
    return
  end
  if not IsTypeNumber(timeFromHeli)then
    return
  end
  if not IsTypeNumber(timeFromLand)then
    return
  end
  if gvars.mis_isStartFromHelispace then--tex was this.IsStartFromHelispace()
    TimerStart(timerName,timeFromHeli)
    return timeFromHeli
  else
    TimerStart(timerName,timeFromLand)
    return timeFromLand
  end
end
function this.Reload(loadInfo)
  local isNoFade,missionPackLabelName,locationCode,OnEndFadeOut,showLoadingTips,ignoreMtbsLoadLocationForce
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    missionPackLabelName=loadInfo.missionPackLabelName
    locationCode=loadInfo.locationCode
    showLoadingTips=loadInfo.showLoadingTips
    ignoreMtbsLoadLocationForce=loadInfo.ignoreMtbsLoadLocationForce
    mvars.mis_nextLayoutCode=loadInfo.layoutCode
    mvars.mis_nextClusterId=loadInfo.clusterId
    OnEndFadeOut=loadInfo.OnEndFadeOut
  end
  if showLoadingTips~=nil then
    mvars.mis_showLoadingTipsOnReload=showLoadingTips
  else
    mvars.mis_showLoadingTipsOnReload=true
  end
  if ignoreMtbsLoadLocationForce then
    mvars.mis_ignoreMtbsLoadLocationForce=true
  end
  if missionPackLabelName then
    mvars.mis_missionPackLabelName=missionPackLabelName
  end
  if locationCode then
    mvars.mis_nextLocationCode=locationCode
  end
  if OnEndFadeOut and IsTypeFunc(OnEndFadeOut)then
    mvars.mis_reloadOnEndFadeOut=OnEndFadeOut
  else
    mvars.mis_reloadOnEndFadeOut=nil
  end
  if isNoFade then
    this.ExecuteReload()
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReloadFadeOutFinish",nil,{setMute=true})
  end
end
function this.RestartMission(loadInfo)
  local isNoFade
  local isReturnToMission
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    isReturnToMission=loadInfo.isReturnToMission
  end
  TppMain.EnablePause()
  if isReturnToMission then
    mvars.mis_isReturnToMission=true
  end
  if this.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM)then
    TppNetworkUtil.SessionEnableAccept(false)
    TppNetworkUtil.SessionDisconnectPreparingMembers()
  end
  if isNoFade then
    this.ExecuteRestartMission(mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"RestartMissionFadeOutFinish",nil,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ExecuteRestartMission(isReturnToMission)
  InfLog.AddFlow("TppMission.ExecuteRestartMission")--tex
  this.SafeStopSettingOnMissionReload()
  TppQuest.OnMissionGameEnd()
  TppPlayer.ResetInitialPosition()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
  this.VarResetOnNewMission()
  local missionCallbackReturn
  if isReturnToMission then
    missionCallbackReturn=this.ExecuteOnReturnToMissionCallback()
    if(vars.missionCode==30050)then
      this.ResetMBFreeStartPositionToCommand()
    end
  end
  local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if locationName then
    local locationCode=TppDefine.LOCATION_ID[locationName]
    if locationCode then
      vars.locationCode=locationCode
    end
  end
  TppSave.VarSave()
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
  end
  local currentMissionCode=nil
  if isReturnToMission then
    this.ClearFobMode()
    currentMissionCode=vars.missionCode
  end
  local DoLoad=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      local loadOptions={force=true}
      if this.IsFOBMission(vars.missionCode)then
        loadOptions={force=true,waitOnLoadingTipsEnd=false}
      end
      this.RequestLoad(vars.missionCode,currentMissionCode,loadOptions)
    else
      this.Load(vars.missionCode,currentMissionCode,{force=true})
    end
  end
  if missionCallbackReturn then
    this.ShowAnnounceLogOnFadeOut(DoLoad)
  else
    DoLoad()
  end
end
function this.ContinueFromCheckPoint(loadInfo)
  local isNoFade
  local isReturnToMission
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    isReturnToMission=loadInfo.isReturnToMission
  end
  TppMain.EnablePause()
  if isReturnToMission then
    mvars.mis_isReturnToMission=true
  end
  if isNoFade then
    this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ContinueFromCheckPointFadeOutFinish",nil,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ReturnToMission(_loadInfo)
  local loadInfo=_loadInfo or{}
  loadInfo.isReturnToMission=true
  this.DisableInGameFlag()
  this.ResetEmegerncyMissionSetting()
  local missionHeroicPoint,missionOgrePoint=vars.missionHeroicPoint,vars.missionOgrePoint
  if(vars.missionCode==50050)then
    TppSave.VarRestoreOnContinueFromCheckPoint()
    if TppNetworkUtil.IsSessionConnect()then
      TppNetworkUtil.CloseSession()
    end
    if loadInfo.withServerPenalty then
      TppServerManager.AbortDefenseMotherBase()
    end
  else
    TppSave.VarRestoreOnMissionStart()
  end
  this.SetHeroicAndOgrePointInSlot(missionHeroicPoint,missionOgrePoint)
  this.RestartMission(loadInfo)
end
function this.ExecuteContinueFromCheckPoint(popupId,popupResult,RENdoMissionCallback)
  InfLog.AddFlow("TppMission.ExecuteContinueFromCheckPoint")--tex
  TppQuest.OnMissionGameEnd()
  TppWeather.OnEndMissionPrepareFunction()
  this.SafeStopSettingOnMissionReload()
  local usingNormalMissionSlot=gvars.usingNormalMissionSlot
  local currentMissionCode=vars.missionCode
  if not this.IsFOBMission(currentMissionCode)then
    this.IncrementRetryCount()
  end
  if gvars.usingNormalMissionSlot==false then
    this.ResetEmegerncyMissionSetting()
    TppSave.VarRestoreOnContinueFromCheckPoint()
  end
  if this.IsFOBMission(currentMissionCode)then
    TppSave.VarRestoreOnContinueFromCheckPoint()
  end
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars(true)--NMC: markerOnly
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT)
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppPlayer.StorePlayerDecoyInfos()
  TppRadioCommand.StoreRadioState()
  local showAnnounceLog
  if RENdoMissionCallback then
    showAnnounceLog=this.ExecuteOnReturnToMissionCallback()
  end
  if usingNormalMissionSlot then
    if popupResult==GameOverMenu.POPUP_RESULT_YES then
      if popupId==GameOverMenu.STEALTH_ASSIST_POPUP then
        svars.dialogPlayerDeadCount=0
      end
      if popupId==GameOverMenu.PERFECT_STEALTH_POPUP then
        svars.chickCapEnabled=true
      end
    end
    if this.IsHardMission(vars.missionCode)or Ivars.disableRetry:Is(1)then--tex
      TppPlayer.UnsetRetryFlag()
    else
      if svars.chickCapEnabled then
        TppPlayer.SetRetryFlagWithChickCap()
      elseif GameConfig.GetStealthAssistEnabled()then
        TppPlayer.SetRetryFlag()
      else
        TppPlayer.UnsetRetryFlag()
      end
    end
    TppSave.VarSaveOnRetry()
    if not this.IsFOBMission(vars.missionCode)then
      TppSave.SaveGameData(vars.missionCode,nil,nil,true)
    end
  end
  local DoLoad=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local loadOptions
    if this.IsFOBMission(currentMissionCode)then
      loadOptions={waitOnLoadingTipsEnd=false}
    end
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      this.RequestLoad(vars.missionCode,currentMissionCode,loadOptions)
    else
      this.Load(vars.missionCode,currentMissionCode,loadOptions)
    end
  end
  if showAnnounceLog then
    this.ShowAnnounceLogOnFadeOut(DoLoad)
  else
    DoLoad()
  end
end
function this.IncrementRetryCount()
  PlayRecord.RegistPlayRecord"MISSION_RETRY"
  Tpp.IncrementPlayData"totalRetryCount"
  TppSequence.IncrementContinueCount()
end
function this.ExecuteOnReturnToMissionCallback()
  local OnReturnToMission
  if this.systemCallbacks and this.systemCallbacks.OnReturnToMission then
    OnReturnToMission=this.systemCallbacks.OnReturnToMission
  end
  if OnReturnToMission then
    TppMain.DisablePause()
    Player.SetPause()
    TppUiStatusManager.ClearStatus"AnnounceLog"
    OnReturnToMission()
    TppTerminal.AddStaffsFromTempBuffer()
    TppSave.VarSave()
    TppSave.SaveGameData(nil,nil,nil,true)
  end
  return OnReturnToMission
end
function this.AbortMission(abortInfo)
  InfMain.AbortMissionTop(abortInfo)--tex
  local isNoFade
  local isNoSave
  local isInterrupt
  local isTitleMode
  local isExecMissionClear
  local emergencyMissionId
  local nextMissionId
  local nextLayoutCode
  local nextClusterId
  local nextMissionStartRoute
  local isAlreadyGameOver
  local delayTime,fadeDelayTime,fadeSpeed=0,0,TppUI.FADE_SPEED.FADE_NORMALSPEED
  local presentationFunction
  local playRadio
  if IsTypeTable(abortInfo)then
    isNoFade=abortInfo.isNoFade
    emergencyMissionId=abortInfo.emergencyMissionId
    nextMissionId=abortInfo.nextMissionId
    nextLayoutCode=abortInfo.nextLayoutCode
    nextClusterId=abortInfo.nextClusterId
    nextMissionStartRoute=abortInfo.nextMissionStartRoute
    isExecMissionClear=abortInfo.isExecMissionClear
    isNoSave=abortInfo.isNoSave
    isInterrupt=abortInfo.isInterrupt
    isAlreadyGameOver=abortInfo.isAlreadyGameOver
    if abortInfo.delayTime then
      delayTime=abortInfo.delayTime
    end
    if abortInfo.fadeDelayTime then
      fadeDelayTime=abortInfo.fadeDelayTime
    end
    if abortInfo.fadeSpeed then
      fadeSpeed=abortInfo.fadeSpeed
    end
    presentationFunction=abortInfo.presentationFunction
    isTitleMode=abortInfo.isTitleMode
    playRadio=abortInfo.playRadio
  end
  if not this.CheckMissionState(isExecMissionClear,true)then
    return
  end
  if mvars.mis_isAborting then
    return
  end
  if delayTime then
    mvars.mis_missionAbortDelayTime=delayTime
  end
  if fadeDelayTime then
    mvars.mis_missionAbortFadeDelayTime=fadeDelayTime
  end
  if fadeSpeed then
    mvars.mis_missionAbortFadeSpeed=fadeSpeed
  end
  mvars.mis_abortPresentationFunction=presentationFunction
  if isTitleMode then
    mvars.mis_abortIsTitleMode=isTitleMode
  end
  mvars.mis_abortWithPlayRadio=playRadio
  mvars.mis_emergencyMissionCode=emergencyMissionId
  mvars.mis_nextMissionCodeForAbort=nextMissionId
  mvars.mis_nextLayoutCodeForAbort=nextLayoutCode
  mvars.mis_nextClusterIdForAbort=nextClusterId
  mvars.mis_nextMissionStartRouteForAbort=nextMissionStartRoute
  if isNoSave then
    mvars.mis_abortWithSave=false
  else
    mvars.mis_abortWithSave=true
  end
  if isNoFade then
    mvars.mis_abortWithFade=false
  else
    mvars.mis_abortWithFade=true
  end
  if isInterrupt then
    mvars.mis_isInterruptMission=true
  end
  if not isAlreadyGameOver then
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA,true)
  else
    this.EstablishedMissionAbort()
  end
end
function this.ExecuteMissionAbort()
  this.VarSaveForMissionAbort()
  this.LoadForMissionAbort()
end
function this.VarSaveForMissionAbort()
  if this.IsFOBMission(vars.missionCode)then
    if(vars.fobSneakMode==FobMode.MODE_SHAM)then
      mvars.mis_abortWithSave=false
    else
      mvars.mis_abortWithSave=true
    end
  end
  if not mvars.mis_nextMissionCodeForAbort then
    Tpp.DEBUG_Fatal"Not defined next missionId!!"
    this.RestartMission()
    return
  end
  this.SafeStopSettingOnMissionReload()
  if TppServerManager.FobIsSneak()then
    TppServerManager.AbortSneakMotherBase()
  end
  this.UnsetFobSneakFlag(mvars.mis_nextMissionCodeForAbort)
  local missionCode=vars.missionCode
  if gvars.ini_isTitleMode then
    gvars.title_nextMissionCode=missionCode
    gvars.title_nextLocationCode=vars.locationCode
    TppVarInit.InitializeForNewMission{}
    Player.SetPause()
  end
  mvars.mis_missionAbortLoadingOption={}
  local isHeliSpace=this.IsHelicopterSpace(missionCode)
  local isFreeMission=this.IsFreeMission(missionCode)
  local nextIsHeliSpace=this.IsHelicopterSpace(mvars.mis_nextMissionCodeForAbort)
  local nextIsFreeMission=this.IsFreeMission(mvars.mis_nextMissionCodeForAbort)
  if mvars.mis_isInterruptMission then
    gvars.usingNormalMissionSlot=false
    if isHeliSpace then
      mvars.mis_missionAbortLoadingOption.showLoadingTips=false
    else
      mvars.mis_missionAbortLoadingOption.showLoadingTips=true
      mvars.mis_missionAbortLoadingOption.waitOnLoadingTipsEnd=false
    end
    if mvars.mis_emergencyMissionCode then
      gvars.mis_nextMissionCodeForEmergency=mvars.mis_emergencyMissionCode
    end
    if mvars.mis_nextLayoutCodeForAbort then
      gvars.mis_nextLayoutCodeForEmergency=mvars.mis_nextLayoutCodeForAbort
    end
    if mvars.mis_nextClusterIdForAbort then
      gvars.mis_nextClusterIdForEmergency=mvars.mis_nextClusterIdForAbort
    end
    if mvars.mis_nextMissionStartRouteForAbort then
      gvars.mis_nextMissionStartRouteForEmergency=mvars.mis_nextMissionStartRouteForAbort
    end
  end
  vars.missionCode=mvars.mis_nextMissionCodeForAbort
  mvars.mis_abortCurrentMissionCode=missionCode
  if this.IsFOBMission(vars.missionCode)then
    vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCodeForAbort)
    vars.mbClusterId=mvars.mis_nextClusterIdForAbort
    vars.locationCode=TppDefine.LOCATION_ID.MTBS
  else
    local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
    if locationName then
      local locationCode=TppDefine.LOCATION_ID[locationName]
      if locationCode then
        vars.locationCode=locationCode
      end
    end
  end
  TppTerminal.ClearStaffNewIcon(isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission)
  TppEnemy.ClearDDParameter()
  if(not this.IsFOBMission(missionCode)and not this.IsFreeMission(missionCode))and not this.IsHelicopterSpace(missionCode)then
    TppRevenge.ReduceRevengePointOnAbort(missionCode)
  end
  if mvars.mis_abortWithSave then
    if nextIsFreeMission then
      this.ReserveMissionStartRecoverSoundDemo()
    else
      this.ClearMissionStartRecoverSoundDemo()
    end
    if not mvars.mis_abortByRestartFromHelicopter then
      TppEnemy.FultonRecoverOnMissionGameEnd()
      TppHero.AnnounceMissionAbort()
    end
    if nextIsHeliSpace then
      TppPlaced.DeleteAllCaptureCage()
    else
      TppPlayer.SaveCaptureAnimal()
    end
    TppClock.SaveMissionStartClock()
    TppWeather.SaveMissionStartWeather()
    TppTerminal.AddStaffsFromTempBuffer()
    TppRevenge.OnMissionClearOrAbort(missionCode)
    TppRevenge.SaveMissionStartMineArea()
    if gvars.solface_groupNumber>=4294967295 then
      gvars.solface_groupNumber=0
    else
      gvars.solface_groupNumber=gvars.solface_groupNumber+1
    end
    gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
    TppPlayer.SavePlayerCurrentWeapons()
    local restored=TppPlayer.RestoreWeaponsFromUsingTemp()
    if not restored then
      TppPlayer.SavePlayerCurrentAmmoCount()
    end
    TppPlayer.SavePlayerCurrentItems()
    TppPlayer.RestoreItemsFromUsingTemp()
    TppPlayer.StoreSupplyCbox()
    TppPlayer.StoreSupportAttack()
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
    TppGimmick.DecrementCollectionRepopCount()
    this.ExecuteVehicleSaveCarryOnAbort()
    TppBuddyService.SetVarsMissionStart()
    this.KillDyingQuiet()
    --tex added dontOverrideFreeLoadout bypass
    if Ivars.dontOverrideFreeLoadout:Is(0) then
      if(not isHeliSpace)and nextIsFreeMission then
        TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
      end
    end
    if gvars.usingNormalMissionSlot then
      TppStory.FailedRetakeThePlatformIfOpened()
    end
    TppMotherBaseManagement.CheckMisogi()--RETAILPATCH 1070
  else
    if gvars.usingNormalMissionSlot then
      TppPlayer.RestoreWeaponsFromUsingTemp()
      TppPlayer.RestoreItemsFromUsingTemp()
      if not TppStory.IsAlwaysOpenRetakeThePlatform()then
        TppStory.CloseRetakeThePlatform()
      end
    end
    this.ClearMissionStartRecoverSoundDemo()
    TppPlayer.ResetMissionStartPosition()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  end
  if nextIsHeliSpace then
    TppUiCommand.LoadoutSetReturnHelicopter()
  end
  local unlockStaffTable={
    [10091]=TppMotherBaseManagement.UnlockedStaffsS10091,
    [10081]=TppMotherBaseManagement.UnlockedStaffS10081,
    [10115]=TppMotherBaseManagement.UnlockedStaffsS10115
  }
  local unlockStaff=unlockStaffTable[missionCode]
  if unlockStaff then
    if TppStory.IsMissionCleard(missionCode)then
      unlockStaff{crossMedal=false}
    end
  end
  TppBuddyService.BuddyMissionInit()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,mvars.mis_abortWithSave)
  TppWeather.OnEndMissionPrepareFunction()
  this.VarResetOnNewMission()
  gvars.mis_orderBoxName=0
  if gvars.ini_isTitleMode then
    mvars.mis_missionAbortLoadingOption.showLoadingTips=false
    gvars.ini_isReturnToTitle=true
  else
    TppTerminal.ReserveMissionStartMbSync()
    local abortWithSave=false
    if mvars.mis_abortWithSave then
      abortWithSave=true
    end
    TppSave.VarSave(missionCode,abortWithSave)
    TppSave.SaveGameData(missionCode,nil,nil,true,abortWithSave)
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,reserveNextMissionStart)--RETAILBUG: typo orphan
    end
  end
end
function this.LoadForMissionAbort()
  InfLog.AddFlow("TppMission.LoadForMissionAbort")--tex
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    this.RequestLoad(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
  else
    this.Load(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
  end
end
function this.ReturnToTitle()
  if TppException.isNowGoingToMgo then--RETAILPATCH 1070>
    return
  end--<
  if this.IsHelicopterSpace(vars.missionCode)then
    TppMotherBaseManagement.ProcessBeforeSync()
    TppMotherBaseManagement.StartSyncControl{}
    TppSave.SaveMBAndGlobal()
    this.CreateMbSaveCoroutine()
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    this.AbortMission{nextMissionId=10010,isNoSave=true,isTitleMode=true}
  else
    local nextMissionId,locationCode=this.GetCurrentLocationHeliMissionAndLocationCode()
    this.AbortMission{nextMissionId=nextMissionId,isNoSave=true,isTitleMode=true}
  end
end
function this.GameOverReturnToTitle()
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  gvars.ini_isTitleMode=true
  mvars.mis_abortWithSave=false
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    mvars.mis_nextMissionCodeForAbort=10010
  else
    mvars.mis_nextMissionCodeForAbort=this.GetCurrentLocationHeliMissionAndLocationCode()
  end
  this.ExecuteMissionAbort()
end
function this.ReserveGameOver(gameOverType,gameOverRadio,isAborting)
  if svars.mis_isDefiniteMissionClear then
    return false
  end
  if this.IsFOBMission(vars.missionCode)==true and TppServerManager.FobIsSneak()==true then
    TppMain.DisablePlayerPad()
    TppUiStatusManager.SetStatus("PauseMenu","INVALID")
  end
  mvars.mis_isAborting=isAborting
  mvars.mis_isReserveGameOver=true
  svars.mis_isDefiniteGameOver=true
  if type(gameOverType)=="number"and gameOverType<TppDefine.GAME_OVER_TYPE.MAX then
    svars.mis_gameOverType=gameOverType
  end
  if type(gameOverRadio)=="number"and gameOverRadio<TppDefine.GAME_OVER_RADIO.MAX then
    svars.mis_gameOverRadio=gameOverRadio
  end
  return true
end
function this.ReserveGameOverOnPlayerKillChild(gameId)
  if not mvars.mis_childGameObjectIdKilledPlayer then
    mvars.mis_childGameObjectIdKilledPlayer=gameId
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER,TppDefine.GAME_OVER_RADIO.PLAYER_KILL_CHILD_SOLDIER)
  end
end
function this.IsGameOver()
  return svars.mis_isDefiniteGameOver
end
function this.CanMissionClear(clearInfo)
  mvars.mis_needSetCanMissionClear=true
  if IsTypeTable(clearInfo)then
    if clearInfo.jingle then
      mvars.mis_canMissionClearNeedJingle=clearInfo.jingle
    else
      mvars.mis_canMissionClearNeedJingle=true
    end
  end
end
function this._SetCanMissionClear()
  mvars.mis_needSetCanMissionClear=false
  if svars.mis_canMissionClear then
    return
  end
  svars.mis_canMissionClear=true
  TppHelicopter.SetNoTakeOffTime()
end
function this.IsCanMissionClear()
  return svars.mis_canMissionClear
end
function this.OnCanMissionClear()
  if mvars.mis_canMissionClearNeedJingle~=false then
    TppSound.PostJingleOnCanMissionClear()
  end
  if IsHelicopter(vars.playerVehicleGameObjectId)then
    local heliRoute=GameObject.SendCommand({type="TppHeli2",index=0},{id="GetUsingRoute"})
    if TppLandingZone.IsAssaultDropLandingZone(heliRoute)then
      GameObject.SendCommand({type="TppHeli2",index=0},{id="PullOut"})
    end
  end
  TppUiCommand.ShowHotZone()
  local bgmList=mvars.snd_bgmList
  if bgmList and bgmList.bgm_escape then
    mvars.mis_needSetEscapeBgm=true
  end
end
function this.SetMissionClearState(missionClearState)
  if gvars.mis_missionClearState<missionClearState then
    gvars.mis_missionClearState=missionClearState
    return true
  else
    return false
  end
end
function this.ResetMissionClearState()
  gvars.mis_missionClearState=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET
end
function this.GetMissionClearState()
  return gvars.mis_missionClearState
end
function this.ReserveMissionClear(missionClearInfo)
  if svars.mis_isDefiniteGameOver then
    return false
  end
  if mvars.mis_isReserveMissionClear or svars.mis_isDefiniteMissionClear then
    return false
  end
  if this.IsFOBMission(vars.missionCode)==true and TppServerManager.FobIsSneak()==true then
    TppMain.DisablePlayerPad()
    TppUiStatusManager.SetStatus("PauseMenu","INVALID")
  end
  mvars.mis_isReserveMissionClear=true
  if missionClearInfo then
    if missionClearInfo.missionClearType then
      svars.mis_missionClearType=missionClearInfo.missionClearType
    end
    if missionClearInfo.nextMissionId then
      this.SetNextMissionCodeForMissionClear(missionClearInfo.nextMissionId)
    end
    if missionClearInfo.nextHeliRoute then
      mvars.heli_missionStartRoute=missionClearInfo.nextHeliRoute
    end
    if missionClearInfo.nextLayoutCode then
      mvars.mis_nextLayoutCode=missionClearInfo.nextLayoutCode
      vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
    end
    if missionClearInfo.nextClusterId then
      mvars.mis_nextClusterId=missionClearInfo.nextClusterId
      vars.mbClusterId=missionClearInfo.nextClusterId
    end
    if missionClearInfo.isInterruptMissionEnd then
      mvars.mis_isInterruptMissionEnd=true
    end
  end
  svars.mis_isDefiniteMissionClear=true
  return true
end
function this.MissionGameEnd(sequence)
  local delayTime=0
  local fadeDelayTime=0
  local fadeSpeed=TppUI.FADE_SPEED.FADE_NORMALSPEED
  if Tpp.IsTypeTable(sequence)then
    delayTime=sequence.delayTime or 0
    fadeSpeed=sequence.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    fadeDelayTime=sequence.fadeDelayTime or 0
    if sequence.loadStartOnResult~=nil then
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=sequence.loadStartOnResult
    else
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=false
    end
  end
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    this.SetNeedWaitMissionInitialize()
  else
    this.ResetNeedWaitMissionInitialize()
  end
  mvars.mis_missionGameEndDelayTime=delayTime
  this.FadeOutOnMissionGameEnd(fadeDelayTime,fadeSpeed,"MissionGameEndFadeOutFinish")
  PlayRecord.RegistPlayRecord"MISSION_CLEAR"
end
function this.FadeOutOnMissionGameEnd(fadeDelay,fadeSpeed,fadeId)
  if fadeDelay==0 then
    this._FadeOutOnMissionGameEnd(fadeSpeed,fadeId)
  else
    mvars.mis_missionGameEndFadeSpeed=fadeSpeed
    mvars.mis_missionGameEndFadeId=fadeId
    TimerStart("Timer_FadeOutOnMissionGameEndStart",fadeDelay)
  end
end
function this._FadeOutOnMissionGameEnd(faseSpeed,fadeId)
  TppUI.FadeOut(faseSpeed,fadeId,nil,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
end
function this.CheckGameOverDemo(e)
  if e>TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK then
    return false
  end
  if band(svars.mis_gameOverType,TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK)==e then
    return true
  else
    return false
  end
end
function this.ShowGameOverMenu(params)
  local delayTime
  if IsTypeTable(params)then
    if type(params.delayTime)=="number"then
      delayTime=params.delayTime
    end
  end
  if delayTime and delayTime>0 then
    TimerStart("Timer_GameOverPresentation",delayTime)
  else
    this.ExecuteShowGameOverMenu()
  end
end
function this.ShowStealthAssistPopup()
  if((vars.missionCode==10010)or(vars.missionCode==10240))or(vars.missionCode==10280)then
    return GameOverMenu.NO_POPUP
  end
  if this.IsHardMission(vars.missionCode)then
    return GameOverMenu.NO_POPUP
  end
  if mvars.mis_isGameOverReasonSuicide then
    return GameOverMenu.NO_POPUP
  end
  if svars.chickCapEnabled then
    return GameOverMenu.NO_POPUP
  end
  if GameConfig.GetStealthAssistEnabled()then
    if svars.dialogPlayerDeadCount>deathLimitToPerfectStealthPopup then
      if gvars.elapsedTimeSinceLastUseChickCap>=dayInSeconds then
        return GameOverMenu.PERFECT_STEALTH_POPUP
      else
        return GameOverMenu.NO_POPUP
      end
    else
      return GameOverMenu.NO_POPUP
    end
  else
    if svars.dialogPlayerDeadCount>deathLimitToStealthAssistPopup then
      return GameOverMenu.STEALTH_ASSIST_POPUP
    else
      return GameOverMenu.NO_POPUP
    end
  end
end
function this.ExecuteShowGameOverMenu()
  TppRadio.Stop()
  local e=this.ShowStealthAssistPopup()
  TppUiCommand.StartGameOver(e)
end
function this.ShowMissionGameEndAnnounceLog()
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END)
  if mvars.res_noResult then
    this.ShowAnnounceLogOnFadeOut(this.OnEndResultBlockLoad)
  else
    this.ShowAnnounceLogOnFadeOut(TppUiCommand.StartResultBlockLoad)
  end
end
function this.ShowAnnounceLogOnFadeOut(EndAnnounceLogFunc)
  if TppUiCommand.GetSuspendAnnounceLogNum()>0 then
    TppUiStatusManager.ClearStatus"AnnounceLog"
    mvars.mis_endAnnounceLogFunction=EndAnnounceLogFunc
  else
    EndAnnounceLogFunc()
  end
end
function this.OnEndResultBlockLoad()
  TppUiStatusManager.SetStatus("GmpInfo","INVALID")
  if this.systemCallbacks.OnDisappearGameEndAnnounceLog then
    this.systemCallbacks.OnDisappearGameEndAnnounceLog(svars.mis_missionClearType)
  end
end
function this.EnablePauseForShowResult()
  if not gvars.enableResultPause then
    TppPause.RegisterPause"ShowResult"
    gvars.enableResultPause=true
  end
end
function this.DisablePauseForShowResult()
  if gvars.enableResultPause then
    TppPause.UnregisterPause"ShowResult"
    gvars.enableResultPause=false
  end
end
function this.ShowMissionResult()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppRadio.Stop()
  TppSoundDaemon.SetMute"Loading"
  TppSoundDaemon.SetMute"Result"
  TppSound.EndJingleOnClearHeli()
  this.EnablePauseForShowResult()
  TppMotherBaseManagement.AddBonusPopupFromBonusPopupFlagStaffs()
  TppRadioCommand.SetEnableIgnoreGamePause(true)
  TppSound.PostJingleStartResultPresentation(svars.bestRank)
  TppUiCommand.CallMissionEndTelop()
  TppSound.SafeStopAndPostJingleOnShowResult()
  TppRadio.PlayResultRadio()
end
function this.ShowMissionReward()
  if TppReward.IsStacked()and(vars.missionCode~=50050)then
    TppReward.ShowAllReward()
  else
    this.OnEndMissionReward()
  end
end
function this.OnEndMissionReward()
  if gvars.needWaitMissionInitialize then
    this.ResetMissionClearState()
  else
    this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.REWARD_END)
  end
  if IsTypeFunc(this.systemCallbacks.OnEndMissionReward)then
    this.systemCallbacks.OnEndMissionReward()
  else
    if gvars.needWaitMissionInitialize==false then
      this.ExecuteMissionFinalize()
    end
  end
  this.ResetNeedWaitMissionInitialize()
end
--NMC: called from in sequence when decided mission is ended
function this.MissionFinalize(options)
  local isNoFade,isExecGameOver,showLoadingTips,setMute,isInterruptMissionEnd,ignoreMtbsLoadLocationForce
  if IsTypeTable(options)then
    isNoFade=options.isNoFade
    isExecGameOver=options.isExecGameOver
    showLoadingTips=options.showLoadingTips
    setMute=options.setMute
    isInterruptMissionEnd=options.isInterruptMissionEnd
    ignoreMtbsLoadLocationForce=options.ignoreMtbsLoadLocationForce
  end
  if showLoadingTips~=nil then
    mvars.mis_showLoadingTipsOnMissionFinalize=showLoadingTips
  else
    mvars.mis_showLoadingTipsOnMissionFinalize=true
  end
  if setMute then
    mvars.mis_setMuteOnMissionFinalize=setMute
  end
  if isInterruptMissionEnd then
    mvars.mis_isInterruptMissionEnd=true
  end
  if ignoreMtbsLoadLocationForce then
    mvars.mis_missionFinalizeIgnoreMtbsLoadLocationForce=true
  end
  if isNoFade then
    this.ExecuteMissionFinalize()
  else
    if isExecGameOver then
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeAtGameOverFadeOutFinish",nil,{setMute=true})
    else
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeFadeOutFinish",nil,{setMute=true})
    end
  end
end
function this.ExecuteMissionFinalize()
  InfLog.AddFlow("TppMission.ExecuteMissionFinalize "..vars.missionCode)--tex
  InfMain.ExecuteMissionFinalizeTop()--tex
  local nextLocationName=TppPackList.GetLocationNameFormMissionCode(gvars.mis_nextMissionCodeForMissionClear)
  if nextLocationName then
    mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[nextLocationName]
  end
  this.SafeStopSettingOnMissionReload{setMute=mvars.mis_setMuteOnMissionFinalize}
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_FINALIZED)
  this.UnsetFobSneakFlag(gvars.mis_nextMissionCodeForMissionClear)
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    if TppUiCommand.IsEndMissionTelop()then
    end
    this.ShowMissionReward()
    this.systemCallbacks.OnFinishBlackTelephoneRadio=nil
    this.systemCallbacks.OnEndMissionCredit=nil
  end
  local waitOnLoadingTipsEnd
  local currentMissionCode=vars.missionCode
  local currentLocationCode=vars.locationCode
  local isHeliSpace,nextIsHeliSpace
  local isFreeMission,nextIsFreeMission
  local isMotherBase--tex
  local isZoo--tex
  if not(mvars.mis_isInterruptMissionEnd or(not TppSave.CanSaveMbMangementData()))then--RETAILPATCH 1070
    TppMotherBaseManagement.CheckMisogi()
  end--<
  if this.IsFOBMission(gvars.mis_nextMissionCodeForMissionClear)then
    waitOnLoadingTipsEnd=false
    TppSave.VarSave(currentMissionCode,true)
    TppSave.SaveGameData(currentMissionCode,nil,nil,nil,true)
  end
  if gvars.mis_nextMissionCodeForMissionClear~=missionClearCodeNone then
    isHeliSpace=this.IsHelicopterSpace(vars.missionCode)
    isFreeMission=this.IsFreeMission(vars.missionCode)
    nextIsHeliSpace=this.IsHelicopterSpace(gvars.mis_nextMissionCodeForMissionClear)
    nextIsFreeMission=this.IsFreeMission(gvars.mis_nextMissionCodeForMissionClear)
    isMotherBase=TppLocation.IsMotherBase()--tex
    isZoo=vars.missionCode==30150
    if mvars.heli_missionStartRoute then
      if Tpp.IsTypeString(mvars.heli_missionStartRoute)then
        gvars.heli_missionStartRoute=StrCode32(mvars.heli_missionStartRoute)
      elseif Tpp.IsTypeNumber(mvars.heli_missionStartRoute)then
        gvars.heli_missionStartRoute=mvars.heli_missionStartRoute
      else
        return
      end
    end
    if mvars.mis_nextLayoutCode then
      vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
    else
      local layoutCode=TppDefine.STORY_MISSION_LAYOUT_CODE[gvars.mis_nextMissionCodeForMissionClear]
      if layoutCode then
        vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(layoutCode)
      end
    end
    if mvars.mis_nextClusterId then
      vars.mbClusterId=mvars.mis_nextClusterId
    end
    Ivars.prevMissionCode=vars.missionCode--tex added
    vars.locationCode=mvars.mis_nextLocationCode
    vars.missionCode=gvars.mis_nextMissionCodeForMissionClear
  else
    if not mvars.mis_isInterruptMissionEnd then
      Tpp.DEBUG_Fatal"Not defined next missionId!!"
      this.RestartMission()
      return
    end
  end
  TppTerminal.ClearStaffNewIcon(isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission)
  if isHeliSpace then
    TppClock.SetTimeFromHelicopterSpace(mvars.mis_selectedDeployTime,currentLocationCode,vars.locationCode)
    if TppSave.CanSaveMbMangementData()then
      TppTerminal.ReserveMissionStartMbSync()
    end
  end
  TppPlayer.SavePlayerCurrentWeapons()
  local restored=TppPlayer.RestoreWeaponsFromUsingTemp()
  TppPlayer.SavePlayerCurrentItems()
  TppPlayer.RestoreItemsFromUsingTemp()
  if not restored then
    TppPlayer.SavePlayerCurrentAmmoCount()
  end
  if currentMissionCode==10030 and TppSave.CanSaveMbMangementData(currentMissionCode)then--PATCHUP
    vars.items[2]=TppEquip.EQP_IT_TimeCigarette
    vars.items[3]=TppEquip.EQP_IT_Nvg
    vars.initItems[2]=TppEquip.EQP_IT_TimeCigarette
    vars.initItems[3]=TppEquip.EQP_IT_Nvg
    TppUiCommand.LoadoutSetItemEquipInfoInMission{slotIndex=2,equipId=TppEquip.EQP_IT_TimeCigarette,level=1}
    TppUiCommand.LoadoutSetItemEquipInfoInMission{slotIndex=3,equipId=TppEquip.EQP_IT_Nvg,level=1}
  end
  if(not isHeliSpace)then
    --tex added dontOverrideFreeLoadout bypass
    if Ivars.dontOverrideFreeLoadout:Is(0) then
      if this.IsMbFreeMissions(gvars.mis_nextMissionCodeForMissionClear)then
        TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()
      elseif nextIsFreeMission then
        TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
      end
    end
  end
  if not(isHeliSpace and nextIsFreeMission)then
    TppUiCommand.RemovedAllUserMarker()
  end
  if nextIsHeliSpace then
    TppUiCommand.LoadoutSetReturnHelicopter()
  end
  if not isHeliSpace and not isFreeMission then
    TppGimmick.DecrementCollectionRepopCount()
    Gimmick.StoreSaveDataPermanentGimmickForMissionClear()
    Gimmick.StoreSaveDataPermanentGimmickFromMissionAfterClear()
  end
  if isFreeMission then
    --tex cant check var.missionCode directly here because it's already been updated to mis_nextMissionCodeForMissionClear
    InfMain.ExecuteMissionFinalizeFree{--tex>
      currentMissionCode=currentMissionCode,
      currentLocationCode=currentLocationCode,
      isHeliSpace=isHeliSpace,
      nextIsHeliSpace=nextIsHeliSpace,
      isFreeMission=isFreeMission,
      nextIsFreeMission=nextIsFreeMission,
      isMotherBase=isMotherBase,
      isZoo=isZoo,
    }--<
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
  end
  local lockStaffForMission={
    [10091]=function()
      if TppMotherBaseManagement.CanOpenS10091()then
        TppMotherBaseManagement.LockedStaffsS10091()
      end
    end,
    [10081]=function()
      if TppMotherBaseManagement.CanOpenS10081()then
        TppMotherBaseManagement.LockedStaffS10081()
      end
    end,
    [10115]=function()
      if TppMotherBaseManagement.CanOpenS10115{section="Develop"}then
        TppMotherBaseManagement.LockedStaffsS10115{section="Develop"}
      end
    end
  }
  local LockStaff=lockStaffForMission[gvars.mis_nextMissionCodeForMissionClear]
  if LockStaff then
    if TppStory.IsMissionCleard(vars.missionCode)then
      LockStaff()
    end
  end
  if nextIsFreeMission then
    vars.requestFlagsAboutEquip=255
  end
  TppEnemy.ClearDDParameter()
  TppRevenge.OnMissionClearOrAbort(currentMissionCode,true)--tex add isAbort
  if gvars.solface_groupNumber>=4294967295 then
    gvars.solface_groupNumber=0
  else
    gvars.solface_groupNumber=gvars.solface_groupNumber+1
  end
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppRadioCommand.StoreRadioState()
  local RENoffline=false
  if vars.missionCode==10115 then
    RENoffline=true
  end
  local locationChange=(vars.locationCode~=currentLocationCode)
  if not isHeliSpace then
    TppTerminal.AddStaffsFromTempBuffer(nil,RENoffline)
  end
  TppClock.SaveMissionStartClock()
  TppWeather.SaveMissionStartWeather()
  TppBuddyService.SetVarsMissionStart()
  TppBuddyService.BuddyMissionInit()
  TppRevenge.SaveMissionStartMineArea()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,nil,locationChange)
  TppWeather.OnEndMissionPrepareFunction()
  this.VarResetOnNewMission()
  if not this.IsFOBMission(vars.missionCode)then
    local reserveNextMissionStartSave=true
    TppSave.VarSave(currentMissionCode,true)
    local i=false
    do
      i=true
    end
    if i and(not RENoffline)then
      TppSave.SaveGameData(currentMissionCode,nil,nil,reserveNextMissionStartSave,true)
    end
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,reserveNextMissionStartSave)
    end
  end
  if mvars.mis_isInterruptMissionEnd then
    local missionHeroicPoint,missionOgrePoint=vars.missionHeroicPoint,vars.missionOgrePoint
    this.ResetEmegerncyMissionSetting()
    TppSave.VarSaveMBAndGlobal()
    TppSave.VarRestoreOnContinueFromCheckPoint()
    TppPlayer.ResetInitialPosition()
    TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
    if(vars.missionCode==30050)then
      this.ResetMBFreeStartPositionToCommand()
    end
    this.VarResetOnNewMission()
    if(vars.missionCode==10240)then--RETAILPATCH: 1060 added
      local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
      if locationName then
        local locationCode=TppDefine.LOCATION_ID[locationName]
        if locationCode then
          vars.locationCode=locationCode
        end
      end
    end--
    TppSave.VarSave()
    this.SetHeroicAndOgrePointInSlot(missionHeroicPoint,missionOgrePoint)
    TppSave.SaveGameData(vars.missionCode)
  end
  if TppRadio.playingBlackTelInfo then
    mvars.mis_showLoadingTipsOnMissionFinalize=false
  end
  this.RequestLoad(vars.missionCode,currentMissionCode,{showLoadingTips=mvars.mis_showLoadingTipsOnMissionFinalize,waitOnLoadingTipsEnd=waitOnLoadingTipsEnd,ignoreMtbsLoadLocationForce=mvars.mis_missionFinalizeIgnoreMtbsLoadLocationForce})
end
--tex REWORKED
local shortTypeToLong={
  s="story",
  e="extra",
  f="free",
  h="heli",
}
function this.ParseMissionName(missionCodeName)
  local missionCode=string.sub(missionCodeName,2)
  missionCode=tonumber(missionCode)
  local missionTypeCode=string.sub(missionCodeName,1,1)
  local missionTypeCodeName=shortTypeToLong[missionTypeCode]
  return missionCode,missionTypeCodeName
end
--ORIG
--function this.ParseMissionName(missionCodeName)
--  local missionCode=string.sub(missionCodeName,2)
--  missionCode=tonumber(missionCode)
--  local missionTypeCode=string.sub(missionCodeName,1,1)
--  local missionTypeCodeName
--  if(missionTypeCode=="s")then
--    missionTypeCodeName="story"
--  elseif(missionTypeCode=="e")then
--    missionTypeCodeName="extra"
--  elseif(missionTypeCode=="f")then
--    missionTypeCodeName="free"
--  elseif(missionTypeCode=="h")then
--    missionTypeCodeName="heli"
--  end
--  return missionCode,missionTypeCodeName
--end
function this.IsStoryMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==1 then
    return true
  else
    return false
  end
end
function this.IsHelicopterSpace(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==4 then
    return true
  else
    return false
  end
end
function this.IsFreeMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==3 then
    return true
  else
    return false
  end
end
function this.IsMbFreeMissions(missionCode)
  local mbFreeMissions={[30050]=true,[30150]=true,[30250]=true}
  if mbFreeMissions[missionCode]then
    return true
  else
    return false
  end
end
function this.IsFOBMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==5 then
    return true
  else
    return false
  end
end
function this.IsHardMission(missionId)
  local n=math.floor(missionId/1e3)
  local e=math.floor(missionId/1e4)*10
  if(n-e)==1 then
    return true
  else
    return false
  end
end
--GOTCHA: looks like it would be easy to forget to check
function this.GetNormalMissionCodeFromHardMission(missionId)
  return missionId-1e3
end
function this.IsSubsistenceMission()
  if(vars.missionCode==11043)or(vars.missionCode==11044)then
    return true
  else
    return false
  end
end
function this.IsPerfectStealthMission()
  if(((vars.missionCode==11082)or(vars.missionCode==11033))or(vars.missionCode==11080))or(vars.missionCode==11121)then
    return true
  else
    return false
  end
end
function this.SetFOBMissionFlag()
  Mission.SetMissionFlags(bit.bor(Mission.MISSION_FLAGS_FOB,Mission.MISSION_FLAGS_MB))
end
function this.IsMissionStart()
  if gvars.sav_varRestoreForContinue then
    return false
  else
    return true
  end
end
function this.IsSysMissionId(n)
  local e
  for i,e in pairs(TppDefine.SYS_MISSION_ID)do
    if n==e then
      return true
    end
  end
  return false
end
function this.IsEmergencyMission(missionCode)
  if missionCode then
    if missionCode==50050 then
      if TppServerManager.FobIsSneak()then
        return false
      else
        return true
      end
    end
    if missionCode==10115 then
      if TppStory.IsAlwaysOpenRetakeThePlatform()then
        return false
      else
        return true
      end
    end
  else
    return not gvars.usingNormalMissionSlot
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="Dead",func=this.OnPlayerDead,option={isExecGameOver=true}},
      {msg="Exit",sender="outerZone",func=function()
        mvars.mis_isOutsideOfMissionArea=true
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="outerZone",func=function()
        mvars.mis_isOutsideOfMissionArea=false
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Exit",sender="innerZone",func=function()
        if mvars.mis_fobDisableAlertMissionArea==true then
          return
        end
        mvars.mis_isAlertOutOfMissionArea=true
        if not this.CheckMissionClearOnOutOfMissionArea()then
          this.EnableAlertOutOfMissionArea()
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="innerZone",func=function()
        mvars.mis_isAlertOutOfMissionArea=false
        this.DisableAlertOutOfMissionArea()
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Exit",sender="hotZone",func=function()
        mvars.mis_isOutsideOfHotZone=true
        this.ExitHotZone()
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="hotZone",func=function()
        mvars.mis_isOutsideOfHotZone=false
        if TppSequence.IsMissionPrepareFinished()then
          this.PlayCommonRadioOnInsideOfHotZone()
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="RideHelicopter",func=function()
        TimerStart("Timer_PlayCommonRadioOnRideHelicopter",1)
      end},
      {msg="OnInjury",func=function()
        TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOMMEND_CURE)
      end},
      {msg="PlayerFultoned",func=this.OnPlayerFultoned},
      {msg="FinishOpeningDemoOnHeli",func=function()
        TppSound.StopHelicopterStartSceneBGM()
        TppUiStatusManager.ClearStatus"EquipPanel"
        TppUiStatusManager.ClearStatus"HeadMarker"
        TppUiStatusManager.ClearStatus"WorldMarker"
        if this.IsFreeMission(vars.missionCode)or(this.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_VISIT))then
          TppUiStatusManager.ClearStatus"AnnounceLog"
        end
        InfMain.ClearMarkers()--tex
        if mvars.mis_updateObjectiveOnHelicopterStart then
          this.ShowUpdateObjective(mvars.mis_objectiveSetting)
          if mvars.mis_updateObjectiveDoorOpenRadioGroups then
            TppRadio.Play(mvars.mis_updateObjectiveDoorOpenRadioGroups,mvars.mis_updateObjectiveDoorOpenRadioOptions)
          end
        end
      end}
    },
    UI={
      {msg="EndTelopCast",func=function()
        if mvars.f30050_demoName=="NuclearEliminationCeremony"then
          return
        end
        TppUiStatusManager.ClearStatus"AnnounceLog"
      end},
      {msg="EndFadeOut",sender="MissionGameEndFadeOutFinish",func=this.OnMissionGameEndFadeOutFinish,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="EndFadeOut",sender="MissionFinalizeFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="EndFadeOut",sender="MissionFinalizeAtGameOverFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="EndFadeOut",sender="RestartMissionFadeOutFinish",func=function()
        this.ExecuteRestartMission(mvars.mis_isReturnToMission)
      end,option={isExecMissionClear=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="ContinueFromCheckPointFadeOutFinish",func=function()
        this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission)
      end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="ReloadFadeOutFinish",func=function()
        if mvars.mis_reloadOnEndFadeOut then
          mvars.mis_reloadOnEndFadeOut()
        end
        this.ExecuteReload()
      end,option={isExecMissionClear=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="AbortMissionFadeOutFinish",func=function()
        if mvars.mis_missionAbortDelayTime>0 then
          TimerStart("Timer_MissionAbort",mvars.mis_missionAbortDelayTime)
        else
          this.OnEndFadeOutMissionAbort()
        end
      end,option={isExecGameOver=true}},
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
        if TppSequence.IsHelicopterStart()then
          this.StartHelicopterDoorOpenTimer()
        end
        if TppSequence.IsLandContinue()then
          local isHeliSpace=this.IsHelicopterSpace(vars.missionCode)
          if((vars.missionCode~=10010)and(vars.missionCode~=10280))and(not isHeliSpace)then
            TppTerminal.ShowLocationAndBaseTelopForContinue()
          end
        end
        TppTerminal.GetFobStatus()
        this.ShowAnnounceLogOnGameStart()
      end},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()
        this.ShowAnnounceLogOnGameStart()
      end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()
        if(vars.missionCode==30050)then
          TppTerminal.GetFobStatus()
        end
      end},
      {msg="GameOverOpen",func=TppMain.DisableGameStatusOnGameOverMenu,option={isExecGameOver=true}},
      {msg="GameOverContinue",func=this.ExecuteContinueFromCheckPoint,option={isExecGameOver=true}},
      {msg="GameOverAbortMission",func=this.GameOverAbortMission,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverAbortMissionGoToAcc",func=this.GameOverAbortMission,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverReturnToMission",func=function()
        this.ReturnToMission{isNoFade=true}
      end,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverRestart",func=function()
        this.ExecuteRestartMission()
      end,option={isExecGameOver=true}},
      {msg="GameOverReturnToTitle",func=this.GameOverReturnToTitle,option={isExecGameOver=true}},
      {msg="GameOverRestartFromHelicopter",func=function()
        mvars.mis_abortByRestartFromHelicopter=true
        this.AbortForRideOnHelicopter{isNoSave=false,isAlreadyGameOver=true}
      end,option={isExecGameOver=true}},
      {msg="PauseMenuCheckpoint",func=this.ContinueFromCheckPoint},
      {msg="PauseMenuAbortMission",func=this.AbortMissionByMenu},
      {msg="PauseMenuAbortMissionGoToAcc",func=this.AbortMissionByMenu},
      {msg="PauseMenuFinishFobManualPlaecementMode",func=this.AbortMissionByMenu},--RETAILPATCH 1070
      {msg="PauseMenuRestart",func=this.RestartMission},
      {msg="PauseMenuReturnToTitle",func=this.ReturnToTitle},
      {msg="PauseMenuRestartFromHelicopter",func=function()
        mvars.mis_abortByRestartFromHelicopter=true
        this.AbortForRideOnHelicopter{isNoSave=false}
      end},
      {msg="PauseMenuReturnToMission",func=function()
        this.ReturnToMission{withServerPenalty=true}
      end},
      {msg="RequestPlayRecordClearInfo",func=this.SetPlayRecordClearInfo},
      {msg="EndMissionTelopDisplay",func=function()
        if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
          this.MissionFinalize{isNoFade=true,setMute="Result"}
        end
      end,option={isExecMissionClear=true,isExecGameOver=true}},
      {msg="EndAnnounceLog",func=function()
        if mvars.mis_endAnnounceLogFunction then
          mvars.mis_endAnnounceLogFunction()
          mvars.mis_endAnnounceLogFunction=nil
        end
      end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="EndResultBlockLoad",func=this.OnEndResultBlockLoad,option={isExecMissionClear=true,isExecGameOver=true,isExecDemoPlaying=true}},
      {msg="EndReloginSync",func=function()--RETAILPATCH 1090>
        if this.IsHelicopterSpace(vars.missionCode)then
          TppVarInit.InitializeOnlineChallengeTaskVarsForNewMission()
      end
      end},--<
    },
    Radio={{msg="Finish",func=this.OnFinishUpdateObjectiveRadio}},
    Timer={
      {msg="Finish",sender="Timer_OutsideOfHotZoneCount",func=this.OutsideOfHotZoneCount,nil},
      {msg="Finish",sender="Timer_OnEndReturnToTile",func=this.RestartMission,option={isExecGameOver=true},nil},
      {msg="Finish",sender="Timer_GameOverPresentation",func=this.ExecuteShowGameOverMenu,option={isExecGameOver=true},nil},
      {msg="Finish",sender="Timer_MissionGameEndStart",func=this.OnMissionGameEndFadeOutFinish2nd,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_MissionGameEndStart2nd",func=this.ShowMissionGameEndAnnounceLog,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_FadeOutOnMissionGameEndStart",func=function()
        this._FadeOutOnMissionGameEnd(mvars.mis_missionGameEndFadeSpeed,mvars.mis_missionGameEndFadeId)
      end,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_StartMissionAbortFadeOut",func=this.FadeOutOnMissionAbort,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_MissionAbort",func=this.OnEndFadeOutMissionAbort,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_PlayCommonRadioOnRideHelicopter",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
          this.PlayCommonRadioOnRideHelicopter()
        end
      end},
      {msg="Finish",sender="Timer_RemoveUserMarker",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
          TppUiCommand.RemovedAllUserMarker()
        end
      end},
      {msg="Finish",sender=Timer_outsideOfInnerZone,func=function()
        if(mvars.mis_isAlertOutOfMissionArea==false)then
          return
        end
        if this.CheckMissionClearOnOutOfMissionArea()then
          if mvars.mis_enableAlertOutOfMissionArea then
            this.DisableAlertOutOfMissionArea()
          end
        else
          if not mvars.mis_enableAlertOutOfMissionArea then
            this.EnableAlertOutOfMissionArea()
          end
        end
      end},
      {msg="Finish",sender="Timer_UpdateCheckPoint",func=function()
        TppStory.UpdateStorySequence{updateTiming="OnUpdateCheckPoint",isInGame=true}
      end},
      {msg="Finish",sender="Timer_MissionStartHeliDoorOpen",func=function()
        GameObject.SendCommand({type="TppHeli2",index=0},{id="RequestSnedDoorOpen"})
      end}
    },
    GameObject={
      {msg="ChangePhase",func=function(cpId,phase)
        if mvars.mis_isExecuteGameOverOnDiscoveryNotice then
          if phase==TppGameObject.PHASE_ALERT then
            this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ON_DISCOVERY,TppDefine.GAME_OVER_RADIO.OTHERS)
          end
        end
      end},
      {msg="HeliDoorClosed",sender="SupportHeli",func=this.MissionClearOrAbortOnHeliDoorClosed},
      {msg="CalledFromStandby",sender="SupportHeli",func=function()
        if this.GetMissionName()~="s10020"then
          TppUI.ShowAnnounceLog"callHeliRecieved"
          local gmp=TppSupportRequest.GetCallRescueHeliGmpCost()
          TppTerminal.UpdateGMP{gmp=-gmp,gmpCostType=TppDefine.GMP_COST_TYPE.CALL_HELLI}
          svars.supportGmpCost=svars.supportGmpCost+gmp
        end
        TppSound.ClearOnDecendingLandingZoneJingleFlag()
      end},
      {msg="DescendToLandingZone",func=function()
        local missionClearOnOutOfMissionArea=this.CheckMissionClearOnOutOfMissionArea()
        local canMissionClear=svars.mis_canMissionClear
        if missionClearOnOutOfMissionArea or canMissionClear then
          TppSound.PostJingleOnDecendingLandingZone()
        else
          TppSound.PostJingleOnDecendingLandingZoneWithOutCanMissionClear()
        end
      end},
      {msg="StartedPullingOut",func=function()TimerStart("Timer_RemoveUserMarker",1)end},
      {msg="LostControl",func=function(gameId,state,attackerId)
        local gameObjectType=GameObject.GetTypeIndex(gameId)
        if gameObjectType~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
          return
        end
        if state==StrCode32"Start"then
          TppHelicopter.SetNewestPassengerTable()
          local passengerList=TppHelicopter.GetPassengerlist()
          if IsTypeTable(passengerList)and next(passengerList)then
            TppUI.ShowAnnounceLog"extractionFailed"
          end
        end
        if state==StrCode32"End"then
          local rescueHeliCost=TppSupportRequest.GetCrashRescueHeliGmpCost()
          TppTerminal.UpdateGMP{gmp=-rescueHeliCost,gmpCostType=TppDefine.GMP_COST_TYPE.DESTROY_SUPPORT_HELI}
          if Tpp.IsPlayer(attackerId)then
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END)
          else
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END_ENEMY_ATTACK)
          end
          svars.supportGmpCost=svars.supportGmpCost+rescueHeliCost
        end
      end},
      {msg="Damage",func=function(gameId,attackId,attackerId)
        local typeIndex=GameObject.GetTypeIndex(gameId)
        if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
          return
        end
        if Tpp.IsPlayer(attackerId)and TppDamage.IsActiveByAttackId(attackId)then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER)
        end
      end},
      {msg="DisableTranslate",func=function(gameId)
        local soldierType=TppEnemy.GetSoldierType(gameId)
        if soldierType==EnemyType.TYPE_SOVIET then
          if not TppQuest.IsCleard"ruins_q19010"then
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN,true)
          end
        elseif soldierType==EnemyType.TYPE_PF then
          if not TppQuest.IsCleard"outland_q19011"then
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS,true)
          end
        end
      end}
    },
    Terminal={
      {msg="MbDvcActCallRescueHeli",func=function(n,e)
        do
          if e==2 then
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE)
          else
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME)
          end
        end
      end},
      {msg="MbDvcActSelectLandPointEmergency",func=this.AcceptEmergencyMission},
      {msg="MbDvcActAcceptMissionList",func=this.AcceptEmergencyMission},
      {msg="MbDvcActHeliLandStartPos",func=this.SetHelicopterMissionStartPosition}
    },
    MotherBaseManagement={
      {msg="UpSectionLv",func=function(n,i,e)
        TppUI.ShowAnnounceLog(TppTerminal.unitLvAnnounceLogTable[n].up,e)
      end},
      {msg="DownSectionLv",func=function(e,i,n)
        TppUI.ShowAnnounceLog(TppTerminal.unitLvAnnounceLogTable[e].down,n)
      end},
      {msg="CompletedPlatform",func=function(e,e,e)
        TppStory.UpdateStorySequence{updateTiming="OnCompletedPlatform",isInGame=true}
      end},
      {msg="RequestSaveMbManagement",func=function()
        if((TppSave.IsForbidSave()or(vars.missionCode==10030))or(vars.missionCode==10115))or(not this.CheckMissionState())then--RETAILPATCH 1070 IsForbidSave added
          TppMotherBaseManagement.SetRequestSaveResultFailure()
          return
        end
        TppSave.SaveOnlyMbManagement(TppSave.ReserveNoticeOfMbSaveResult)
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="RequestSavePersonal",func=function()
        TppSave.CheckAndSavePersonalData()
      end}
    },
    Trap={
      {msg="Enter",sender="trap_mission_failed_area",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
        else
          this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
        end
      end}
    }
  }
end
function this.MessagesWhileLoading()
  return Tpp.StrCode32Table{UI={
    {msg="EndMissionTelopFadeOut",func=function()
      this.DisablePauseForShowResult()
      if not gvars.needWaitMissionInitialize then
        if gvars.mis_missionClearState==TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
          return
        end
        this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.SHOW_CREDIT_END)
        if IsTypeFunc(this.systemCallbacks.OnEndMissionCredit)then
          this.systemCallbacks.OnEndMissionCredit()
        else
          if not TppRadio.playingBlackTelInfo then
            this.ShowMissionReward()
          end
        end
      end
    end},
    {msg="BonusPopupAllClose",func=this.OnEndMissionReward}},
  Radio={
    {msg="Finish",func=TppRadio.OnFinishBlackTelephoneRadio},
    nil},
  Video={
    {msg="VideoPlay",func=function(e)
      TppMovie.DoMessage(e,"onStart")
    end},
    {msg="VideoStopped",func=function(e)
      TppMovie.DoMessage(e,"onEnd")
    end}}}
end
local fallDeath=StrCode32"FallDeath"
local suicide=StrCode32"Suicide"
function this.OnPlayerDead(playerId,deathTypeStr32)
  if not TppNetworkUtil.IsHost()then
    return
  end
  local isFobMission=this.IsFOBMission(vars.missionCode)
  if(not isFobMission)or TppPlayer.IsSneakPlayerInFOB(playerId)then
    if deathTypeStr32==fallDeath then
      mvars.mis_isGameOverReasonSuicide=true
      this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
    else
      if deathTypeStr32==suicide then
        mvars.mis_isGameOverReasonSuicide=true
      end
      this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
    end
  else
    svars.mis_fobDefenceGameOver=TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.PLAYER_DEAD
  end
end
function this.OnEndMissionPreparation(deployTime,clusterId)
  mvars.mis_selectedDeployTime=deployTime
  if gvars.mis_nextMissionCodeForEmergency==0 then
    local missionStartRoute
    if gvars.heli_missionStartRoute==0 then
      missionStartRoute=mvars.heli_missionStartRoute
    end
    local nextClusterId=TppDefine.STORY_MISSION_CLUSTER_ID[gvars.mis_nextMissionCodeForMissionClear]
    if clusterId then
      nextClusterId=clusterId
    end
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,nextMissionId=gvars.mis_nextMissionCodeForMissionClear,nextHeliRoute=missionStartRoute,nextClusterId=nextClusterId}
  else
    gvars.usingNormalMissionSlot=false
    this.GoToEmergencyMission()
  end
end
function this.GetNextMissionCodeForEmergency()
  return(mvars.mis_emergencyMissionCode or gvars.mis_nextMissionCodeForEmergency)
end
function this.OnAbortMissionPreparation()
  this.SetNextMissionCodeForMissionClear(missionClearCodeNone)
  gvars.heli_missionStartRoute=0
end
function this.WaitFinishMissionEndPresentation()
  while(not TppUiCommand.IsEndMissionTelop())do
    if TppUiCommand.KeepMissionStartTelopBg then
      TppUiCommand.KeepMissionStartTelopBg(false)
    end
    coroutine.yield()
  end
  while(TppRadio.playingBlackTelInfo~=nil)do
    coroutine.yield()
  end
  TppUiCommand.StartResultBlockUnload()
  if gvars.needWaitMissionInitialize then
    TppMain.DisablePause()
  end
  while(gvars.needWaitMissionInitialize)do
    coroutine.yield()
  end
  TppMain.EnablePause()
end
function this.SetNeedWaitMissionInitialize()
  gvars.needWaitMissionInitialize=true
end
function this.ResetNeedWaitMissionInitialize()
  gvars.needWaitMissionInitialize=false
end
function this.CancelLoadOnResult()
  mvars.mis_doMissionFinalizeOnMissionTelopDisplay=nil
  this.ResetNeedWaitMissionInitialize()
end

function this.OnAllocate(missionTable)
  this.systemCallbacks={
    OnEstablishMissionClear=function()
      this.MissionGameEnd{loadStartOnResult=false}
    end,
    OnDisappearGameEndAnnounceLog=this.ShowMissionResult,
    OnEndMissionCredit=nil,
    OnEndMissionReward=nil,
    OnGameOver=nil,
    OnOutOfMissionArea=nil,
    OnUpdateWhileMissionPrepare=nil,
    OnFobDefenceGameOver=nil,
    OnFinishBlackTelephoneRadio=function()
      if not gvars.needWaitMissionInitialize then
        this.ShowMissionReward()
      end
    end,
    OnOutOfHotZone=nil,
    OnOutOfHotZoneMissionClear=nil,
    OnUpdateStorySequenceInGame=nil,
    CheckMissionClearFunction=nil,
    OnReturnToMission=nil,
    OnAddStaffsFromTempBuffer=nil,
    CheckMissionClearOnRideOnFultonContainer=nil,
    OnRecovered=nil,
    OnSetMissionFinalScore=nil,
    OnEndDeliveryWarp=nil,
    OnFultonContainerMissionClear=nil
  }
  this.RegisterMissionID()
  if missionTable.sequence then
    local objectiveDefine=missionTable.sequence.missionObjectiveDefine
    local ojectiveTree=missionTable.sequence.missionObjectiveTree
    local objectiveEnum=missionTable.sequence.missionObjectiveEnum
    if objectiveDefine and ojectiveTree then
      this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
    end
    if missionTable.sequence.missionStartPosition then
      if IsTypeTable(missionTable.sequence.missionStartPosition.orderBoxList)then
        mvars.mis_orderBoxList=missionTable.sequence.missionStartPosition.orderBoxList
      end
    end
    if missionTable.sequence.ENABLE_DEFAULT_HELI_MISSION_CLEAR then
      mvars.mis_enableDefaultHeliMisionClear=true
    end
    mvars.mis_helicopterDoorOpenTimerTimeSec=Ivars.defaultHeliDoorOpenTime:Get()--tex was 15, yeah a magic number
    if missionTable.sequence.HELICOPTER_DOOR_OPEN_TIME_SEC and Ivars.defaultHeliDoorOpenTime:IsDefault() then--tex allow override
      mvars.mis_helicopterDoorOpenTimerTimeSec=missionTable.sequence.HELICOPTER_DOOR_OPEN_TIME_SEC
    end
  end
  mvars.mis_isOutsideOfMissionArea=false
  mvars.mis_isOutsideOfHotZone=true
  this.MessageHandler={
    OnMessage=function(i,s,n,t,a,o)
      this.OnMessageWhileLoading(i,s,n,t,a,o)
    end
  }
  GameMessage.SetMessageHandler(this.MessageHandler,{"UI","Radio","Video","Network","Nt"})
end
function this.DisableInGameFlag()
  mvars.mis_missionStateIsNotInGame=true
end
function this.EnableInGameFlag(resetMute)
  if(not gvars.usingNormalMissionSlot)and this.IsHelicopterSpace(vars.missionCode)then
    resetMute=true
  end
  if gvars.mis_missionClearState<=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
    mvars.mis_missionStateIsNotInGame=false
    if not resetMute then
      TppSoundDaemon.ResetMute"Loading"
    end
  else
    mvars.mis_missionStateIsNotInGame=true
  end
end
function this.ExecuteSystemCallback(s,n)
  local e=this.systemCallbacks[s]
  if IsTypeFunc(e)then
    return e(n)
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  local isHeliSpace=this.IsHelicopterSpace(vars.missionCode)
  local isFreeMission=this.IsFreeMission(vars.missionCode)
  if((not isHeliSpace)and(not isFreeMission))and(not TppLocation.IsCyprus())then
    mvars.mis_isAlertOutOfMissionArea=true
  else
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10030 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10140 or vars.missionCode==11140 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10240 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==50050 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  if missionTable.sequence then
    local objectiveDefine=missionTable.sequence.missionObjectiveDefine
    local ojectiveTree=missionTable.sequence.missionObjectiveTree
    local objectiveEnum=missionTable.sequence.missionObjectiveEnum
    if objectiveDefine and ojectiveTree then
      this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
    end
  end
  local callBackNames={
    "OnEstablishMissionClear",
    "OnDisappearGameEndAnnounceLog",
    "OnEndMissionCredit",
    "OnEndMissionReward",
    "OnGameOver",
    "OnOutOfMissionArea",
    "OnUpdateWhileMissionPrepare",
    "OnFobDefenceGameOver",
    "OnFinishBlackTelephoneRadio",
    "OnOutOfHotZone",
    "OnOutOfHotZoneMissionClear",
    "OnUpdateStorySequenceInGame",
    "CheckMissionClearFunction",
    "OnReturnToMission",
    "OnAddStaffsFromTempBuffer",
    "CheckMissionClearOnRideOnFultonContainer",
    "OnRecovered",
    "OnMissionGameEndFadeOutFinish",
    "OnFultonContainerMissionClear"
  }
  for i,name in ipairs(callBackNames)do
    local systemCallbacks=_G.TppMission.systemCallbacks
    if systemCallbacks then
      local callback=systemCallbacks[name]
      this.systemCallbacks=this.systemCallbacks or{}
      this.systemCallbacks[name]=callback
    end
  end
end
function this.RegisterMissionID()
  mvars.mis_missionName=this._CreateMissionName(vars.missionCode)
end
function this.DeclareSVars()
  return{
    {name="mis_canMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,notify=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteGameOver",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverType",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverRadio",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_missionClearType",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_objectiveEnable",arraySize=maxObjective,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_fobDefenceGameOver",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="chickCapEnabled",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="dialogPlayerDeadCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    nil
  }
end
function this.CheckMessageOptionWhileLoading()
  return true
end
function this.OnMessageWhileLoading(sender,messageId,arg0,arg1,arg2,arg3)
  local n=Tpp.DEBUG_StrCode32ToString
  local strLogText
  Tpp.DoMessage(this.messageExecTableWhileLoading,this.CheckMessageOptionWhileLoading,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,this.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.CheckMessageOption(messages)
  local isExecMissionClear=false
  local isExecGameOver=false
  local isExecDemoPlaying=false
  local isExecMissionPrepare=false
  if messages and IsTypeTable(messages)then
    isExecMissionClear=messages[StrCode32"isExecMissionClear"]
    isExecGameOver=messages[StrCode32"isExecGameOver"]
    isExecDemoPlaying=messages[StrCode32"isExecDemoPlaying"]
    isExecMissionPrepare=messages[StrCode32"isExecMissionPrepare"]
  end
  return this.CheckMissionState(isExecMissionClear,isExecGameOver,isExecDemoPlaying,isExecMissionPrepare)
end
function this.CheckMissionState(checkMissionClear,checkGameOver,checkDemoPlaying,checkMissionPrepare)
  local mvars=mvars
  local svars=svars
  if svars==nil then
    return
  end
  local isMissionclear=mvars.mis_isReserveMissionClear or svars.mis_isDefiniteMissionClear
  local isGameOver=mvars.mis_isReserveGameOver or svars.mis_isDefiniteGameOver
  local demoIsNotPlayable=TppDemo.IsNotPlayable()
  local startSequence=false
  if svars.seq_sequence<=1 then
    startSequence=true
  end
  if isMissionclear and not checkMissionClear then
    return false
  elseif isGameOver and not checkGameOver then
    return false
  elseif demoIsNotPlayable and not checkDemoPlaying then
    return false
  elseif startSequence and not checkMissionPrepare then
    return false
  else
    return true
  end
end
function this.CheckMissionClearOnOutOfMissionArea()
  if this.systemCallbacks.CheckMissionClearFunction then
    return this.systemCallbacks.CheckMissionClearFunction()
  else
    return false
  end
end
function this.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  if mvars.mis_isAlertOutOfMissionArea then
    this.EnableAlertOutOfMissionArea()
  end
end
function this.IgnoreAlertOutOfMissionAreaForBossQuiet(e)
  if e==true then
    mvars.mis_ignoreAlertOfMissionArea=true
  else
    mvars.mis_ignoreAlertOfMissionArea=false
  end
end
function this.EnableAlertOutOfMissionArea()
  local ignoreAlert=false
  if mvars.mis_ignoreAlertOfMissionArea==true then
    ignoreAlert=true
  end
  if svars.mis_canMissionClear then
    return
  end
  if mvars.mis_missionStateIsNotInGame then
    return
  end
  if not IsHelicopter(vars.playerVehicleGameObjectId)then
    mvars.mis_enableAlertOutOfMissionArea=true
    TppUI.ShowAnnounceLog"closeOutOfMissionArea"
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA)
    if not ignoreAlert then
      TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",true,1)
      TppOutOfMissionRangeEffect.Enable(3)
    end
  end
end
function this.DisableAlertOutOfMissionArea()
  mvars.mis_enableAlertOutOfMissionArea=false
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.ExitHotZone()
  this.ExecuteSystemCallback"OnOutOfHotZone"
  if svars.mis_canMissionClear then
    TppUI.ShowAnnounceLog"leaveHotZone"
    if not IsNotAlert()and not IsHelicopter(vars.playerVehicleGameObjectId)then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT)
    else
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE)
    end
  end
end
function this.PlayCommonRadioOnInsideOfHotZone()
  if svars.mis_canMissionClear then
    local notInHeli=not IsHelicopter(vars.playerVehicleGameObjectId)
    if notInHeli then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RETURN_HOTZONE)
    end
  end
end
function this.OnChangeFobDefenceGameOver()
  if svars.mis_fobDefenceGameOver==TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.INIT then
    return
  end
  if TppNetworkUtil.IsHost()then
    return
  end
  if this.systemCallbacks.OnFobDefenceGameOver then
    this.systemCallbacks.OnFobDefenceGameOver(svars.mis_fobDefenceGameOver)
  end
end
function this.PlayCommonRadioOnRideHelicopter()
  if svars.mis_canMissionClear then
    this.StartJingleOnHelicopterClear()
  else
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.ABORT_BY_HELI)
  end
end
function this.StartJingleOnHelicopterClear()
  TppSound.StartJingleOnClearHeli()
  TppSoundDaemon.SetMute"HeliClosing"
end
function this.MissionClearOrAbortOnHeliDoorClosed()
  if not mvars.mis_enableDefaultHeliMisionClear then
    return
  end
  if svars.mis_canMissionClear then
    this.ReserveMissionClearOnRideOnHelicopter()
  else
    this.AbortForRideOnHelicopter{isNoSave=false}
  end
end
function this.ReserveMissionStartRecoverSoundDemo()
  if Tpp.IsEnemyWalkerGear(vars.playerVehicleGameObjectId)then
    gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.WALKER_GEAR
    TppTerminal.ReserveHelicopterSoundOnMissionGameEnd()
  elseif Tpp.IsVehicle(vars.playerVehicleGameObjectId)then
    gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.VEHICLE
  else
    this.ClearMissionStartRecoverSoundDemo()
  end
end
function this.ClearMissionStartRecoverSoundDemo()
  gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.NONE
end
function this.GetMissionStartRecoverDemoType()
  return gvars.mis_missionStartRecoverDemoType
end
function this.OutsideOfHotZoneCount()
  if mvars.mis_isOutsideOfHotZone then
    this.ReserveMissionClearOnOutOfHotZone()
  end
end
local function StopOutsideHotzoneTimer()
  if IsTimerActive"Timer_OutsideOfHotZoneCount"then
    TimerStop"Timer_OutsideOfHotZoneCount"
  end
end
function this.CheckMissionClearOnRideOnFultonContainer()
  if this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer then
    return this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer()
  else
    return false
  end
end
function this.OnPlayerFultoned()
  if this.IsFOBMission(vars.missionCode)then
    return
  end
  if this.IsCanMissionClear()or this.CheckMissionClearOnRideOnFultonContainer()then
    this.ReserveMissionClearOnRideOnFultonContainer()
  else
    this.AbortForRideFultonContainer()
  end
end
function this.Update()
  local mvars=mvars
  local svars=svars
  local missionName=this.GetMissionName()
  if mvars.mis_needSetCanMissionClear then
    this._SetCanMissionClear()
  end
  if mvars.mis_missionStateIsNotInGame then
    return
  end
  local isSyncDefMissionClear,isSyncMissionClearType,isSyncDefGameOver,isSyncGameOverType=this.GetSyncMissionStatus()
  local isAlertOutOfMissionArea=mvars.mis_isAlertOutOfMissionArea
  local isOutsideOfMissionArea=mvars.mis_isOutsideOfMissionArea
  local isOutsideOfHotZone=mvars.mis_isOutsideOfHotZone
  local canMissionClear=svars.mis_canMissionClear
  if isSyncDefMissionClear and isSyncMissionClearType then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    this.EstablishedMissionClear(svars.mis_missionClearType)
  elseif isSyncDefGameOver and isSyncGameOverType then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    if mvars.mis_isAborting then
      this.EstablishedMissionAbort()
    else
      this.EstablishedGameOver()
    end
  elseif canMissionClear then
    this.UpdateAtCanMissionClear(isOutsideOfHotZone,isOutsideOfMissionArea)
  else
    if isOutsideOfMissionArea then
      local notHeli=not IsHelicopter(vars.playerVehicleGameObjectId)
      if notHeli then
        if this.CheckMissionClearOnOutOfMissionArea()then
          this.ReserveMissionClearOnOutOfHotZone()
        else
          if this.systemCallbacks.OnOutOfMissionArea==nil then
            this.AbortForOutOfMissionArea{isNoSave=false}
          else
            this.systemCallbacks.OnOutOfMissionArea()
          end
        end
      end
    end
    if isAlertOutOfMissionArea then
      if not IsTimerActive(Timer_outsideOfInnerZone)then
        TimerStart(Timer_outsideOfInnerZone,outSideOfInnerZoneTime)
      end
    else
      if IsTimerActive(Timer_outsideOfInnerZone)then
        TimerStop(Timer_outsideOfInnerZone)
      end
    end
  end
  if TppSequence.IsMissionPrepareFinished()then
    RegistMissionTimerPlayRecord()
  end
  this.ResumeMbSaveCoroutine()
  if mvars.mis_needSetEscapeBgm then
    if missionName=="s10090"or missionName=="s11090"then
      TppSound.StartEscapeBGM()
    else
      if vars.playerPhase>TppEnemy.PHASE.SNEAK then
        TppSound.StartEscapeBGM()
      else
        TppSound.StopEscapeBGM()
      end
    end
  end
end
function this.UpdateForMissionLoad()
  if mvars.mis_loadRequest then
    this.LoadWithChunkCheck()
  end
end
function this.CreateMbSaveCoroutine()
  local function MBSave()
    while(not TppMotherBaseManagement.IsEndedSyncControl())do
      coroutine.yield()
    end
    if TppMotherBaseManagement.IsResultSuccessedSyncControl()then
      TppSave.SaveOnlyMbManagement()
    end
  end
  this.waitMbSyncAndSaveCoroutine=coroutine.create(MBSave)
end
function this.ResumeMbSaveCoroutine()
  if this.waitMbSyncAndSaveCoroutine then
    local n,n=coroutine.resume(this.waitMbSyncAndSaveCoroutine)
    if coroutine.status(this.waitMbSyncAndSaveCoroutine)=="dead"then
      this.waitMbSyncAndSaveCoroutine=nil
      return
    end
  end
end
function this.GetSyncMissionStatus()
  local mvars=mvars
  local svars=svars
  local isHost=TppNetworkUtil.IsHost()
  local isSessionConnect=TppNetworkUtil.IsSessionConnect()
  local isSyncDefMissionClear=false
  local isSyncMissionClearType=false
  local isSyncDefGameOver=false
  local isSyncGameOverType=false
  if isHost then
    isSyncDefMissionClear=svars.mis_isDefiniteMissionClear and SVarsIsSynchronized"mis_isDefiniteMissionClear"
    isSyncMissionClearType=SVarsIsSynchronized"mis_missionClearType"
    isSyncDefGameOver=svars.mis_isDefiniteGameOver and SVarsIsSynchronized"mis_isDefiniteGameOver"
    isSyncGameOverType=SVarsIsSynchronized"mis_gameOverType"
  else
    if isSessionConnect then
      isSyncDefMissionClear=svars.mis_isDefiniteMissionClear
      isSyncMissionClearType=true
      isSyncDefGameOver=svars.mis_isDefiniteGameOver
      isSyncGameOverType=svars.mis_gameOverType
    else
      isSyncDefMissionClear=mvars.mis_isReserveMissionClear
      isSyncMissionClearType=true
      isSyncDefGameOver=mvars.mis_isDefiniteGameOver
      isSyncGameOverType=true
    end
  end
  return isSyncDefMissionClear,isSyncMissionClearType,isSyncDefGameOver,isSyncGameOverType
end
function this.SeizeReliefVehicleOnAbort()
  if mvars.mis_abortIsTitleMode then
    return
  end
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local vehicleId=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(vehicleId,{id="IsAlive"})then
    return
  end
  if mvars.mis_abortWithSave and not mvars.mis_abortByRestartFromHelicopter then
    if vehicleId~=vars.playerVehicleGameObjectId then
      if Player.GetItemLevel(TppEquip.EQP_IT_Fulton_Cargo)>=2 or Player.GetItemLevel(TppEquip.EQP_IT_Fulton_WormHole)>=1 then
        local resourceId=GameObject.SendCommand(vehicleId,{id="GetResourceId"})
        local notHelicopter=not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)
        TppTerminal.OnFulton(vehicleId,nil,nil,resourceId,nil,notHelicopter,PlayerInfo.GetLocalPlayerIndex())
      end
    end
  else
    GameObject.SendCommand(vehicleId,{id="Seize",options={"Fulton","CheckFultonType","DirectAccount"}})
  end
end
function this.SeizeReliefVehicleOnClear()
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local vehicleId=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(vehicleId,{id="IsAlive"})then
    return
  end
  if vehicleId~=vars.playerVehicleGameObjectId then
    local i={"Fulton","CheckFultonType"}
    local s=this.GetMissionClearType()
    if not this.EvaluateReliefVehicleSeizable(s)then
      table.insert(i,"CheckFarFromPlayer")
    end
    GameObject.SendCommand(vehicleId,{id="Seize",options=i})
  end
end
function this.SeizeReliefVehicleOnForceGoToMb()
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local vehicleId=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(vehicleId,{id="IsAlive"})then
    return
  end
  GameObject.SendCommand(vehicleId,{id="Seize",options={"Fulton","CheckFultonType","DirectAccount"}})
end
function this.EvaluateReliefVehicleSeizable(missionClearType)
  if((missionClearType~=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO and missionClearType~=TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END)and missionClearType~=TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END)and missionClearType~=TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END then
    return true
  end
  return false
end
function this.EvaluateVehicleCarryOption(missionClearType)
  local options={}
  if this.EvaluateReliefVehicleSeizable(missionClearType)then
    table.insert(options,"Abandon")
  end
  return options
end
function this.ExecuteVehicleSaveCarryOnAbort()
  if mvars.mis_abortByRestartFromHelicopter then
    return
  end
  Vehicle.SaveCarry()
end
function this.ExecuteVehicleSaveCarryOnClear()
  local locationCode=vars.locationCode
  if locationCode~=TppDefine.LOCATION_ID.AFGH and locationCode~=TppDefine.LOCATION_ID.MAFR then
    return
  end
  local missionClearType=this.GetMissionClearType()
  local options=this.EvaluateVehicleCarryOption(missionClearType)
  local initialPos=nil
  local rotY=nil
  if missionClearType==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO then
    if mvars.mis_orderBoxList then
      if gvars.mis_orderBoxName~=0 then
        local orderBoxName=this.FindOrderBoxName(gvars.mis_orderBoxName)
        local boxLocPos,bosLocRot=this.GetOrderBoxLocator(orderBoxName)
        if boxLocPos then
          local adjustPos=Vector3(0,-.75,1.98)
          local vBoxLocPos=Vector3(boxLocPos[1],boxLocPos[2],boxLocPos[3])
          local adjustedPos=-Quat.RotationY(TppMath.DegreeToRadian(bosLocRot)):Rotate(adjustPos)
          initialPos=adjustedPos+vBoxLocPos
          rotY=bosLocRot
        end
      end
    end
  end
  Vehicle.SaveCarry{options=options,initialPosition=initialPos,initialRotY=rotY}
end
function this.EstablishedMissionAbort()
  this.SeizeReliefVehicleOnAbort()
  TppQuest.OnMissionGameEnd()
  if mvars.mis_abortWithPlayRadio then
    TppRadio.PlayGameOverRadio()
  end
  if mvars.mis_abortIsTitleMode then
    gvars.ini_isTitleMode=true
  end
  if mvars.mis_abortPresentationFunction then
    mvars.mis_abortPresentationFunction()
  end
  if mvars.mis_abortWithFade then
    if mvars.mis_missionAbortFadeDelayTime==0 then
      this.FadeOutOnMissionAbort()
    else
      TimerStart("Timer_StartMissionAbortFadeOut",mvars.mis_missionAbortFadeDelayTime)
    end
  else
    this.ExecuteMissionAbort()
  end
end
function this.FadeOutOnMissionAbort()
  local exceptGameStatus
  if mvars.mis_abortWithSave then
    TppHero.MissionAbort()
    exceptGameStatus={AnnounceLog="SUSPEND_LOG"}
  else
    exceptGameStatus={AnnounceLog="INVALID_LOG"}
  end
  TppUI.FadeOut(mvars.mis_missionAbortFadeSpeed,"AbortMissionFadeOutFinish",nil,{setMute=true,exceptGameStatus=exceptGameStatus})
end
function this.OnEndFadeOutMissionAbort()
  this.VarSaveForMissionAbort()
  this.ShowAnnounceLogOnFadeOut(this.LoadForMissionAbort)
end
function this.EstablishedGameOver()
  TppMusicManager.StopJingleEvent()
  local tipNames={}
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  for i=currentStorySequence,TppDefine.STORY_SEQUENCE.STORY_START,-1 do
    local tipsForStorySeq=TppDefine.CONTINUE_TIPS_TABLE[i]
    if tipsForStorySeq then
      for j,tipName in ipairs(tipsForStorySeq)do
        table.insert(tipNames,tipName)
      end
    end
  end
  if#tipNames>0 then
    local continueTipsCount=gvars.continueTipsCount
    if(continueTipsCount>#tipNames)then
      continueTipsCount=1
      gvars.continueTipsCount=1
    end
    local tipName=tipNames[continueTipsCount]
    local tipId
    if tipName then
      tipId=TppDefine.TIPS[tipName]
    end
    if Tpp.IsTypeNumber(tipId)then
      TppUiCommand.SeekLoadingTips(tostring(tipId))
      gvars.continueTipsCount=gvars.continueTipsCount+1
    end
  end
  local OnGameOver
  if this.systemCallbacks.OnGameOver then
    OnGameOver=this.systemCallbacks.OnGameOver()
  end
  if not mvars.mis_isGameOverReasonSuicide then
    svars.dialogPlayerDeadCount=svars.dialogPlayerDeadCount+1
  end
  if not OnGameOver then
    if this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)then
      TppPlayer.PlayFallDeadCamera()
      this.ShowGameOverMenu{delayTime=TppPlayer.PLAYER_FALL_DEAD_DELAY_TIME}
    else
      this.ShowGameOverMenu()
    end
  end
end
function this.UpdateAtCanMissionClear(n,o)
  if not n then
    mvars.mis_lastOutSideOfHotZoneButAlert=nil
    StopOutsideHotzoneTimer()
    return
  end
  local isNotAlert=IsNotAlert()
  local isPlayerStatusNormal=IsPlayerStatusNormal()
  local notHelicopter=not IsHelicopter(vars.playerVehicleGameObjectId)
  if o then
    if isPlayerStatusNormal and notHelicopter then
      StopOutsideHotzoneTimer()
      this.ReserveMissionClearOnOutOfHotZone()
    end
  else
    if(isNotAlert and isPlayerStatusNormal)and notHelicopter then
      if not IsTimerActive"Timer_OutsideOfHotZoneCount"then
        TimerStart("Timer_OutsideOfHotZoneCount",RENsomenumber)
      end
    else
      if not isNotAlert then
        mvars.mis_lastOutSideOfHotZoneButAlert=true
      end
      StopOutsideHotzoneTimer()
    end
  end
end
function this.ReserveMissionClearOnOutOfHotZone()
  if this.systemCallbacks.OnOutOfHotZoneMissionClear then
    this.systemCallbacks.OnOutOfHotZoneMissionClear()
    return
  end
  this._ReserveMissionClearOnOutOfHotZone()
end
function this._ReserveMissionClearOnOutOfHotZone()
  if mvars.mis_lastOutSideOfHotZoneButAlert then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK)
  end
  if TppLocation.IsAfghan()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  elseif TppLocation.IsMiddleAfrica()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE}
  else
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  end
end
function this.ReserveMissionClearOnRideOnHelicopter()
  if TppLocation.IsAfghan()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI}
  elseif TppLocation.IsMiddleAfrica()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_HELI}
  elseif TppLocation.IsMotherBase()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.MTBS_HELI}
  else
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI}
  end
end
function this.ReserveMissionClearOnRideOnFultonContainer()
  if this.systemCallbacks.OnFultonContainerMissionClear then
    this.systemCallbacks.OnFultonContainerMissionClear()
  else
    local nextMissionId=this.GetCurrentLocationHeliMissionAndLocationCode()
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER,nextMissionId=nextMissionId}
  end
end
function this.AbortMissionByMenu()
  if this.IsFOBMission(vars.missionCode)then
    TppSoundDaemon.PostEvent"env_wormhole_out"
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.FOB_ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
  else
    if gvars.mis_isStartFromHelispace then
      this.AbortForRideOnHelicopter()
    elseif gvars.mis_isStartFromFreePlay then
      this.AbortForOutOfMissionArea()
    else
      this.AbortForRideOnHelicopter()
    end
  end
end
function this.AbortForOutOfMissionArea(abortInfo)
  local isNoSave=true
  local presentationFunction
  local fadeDelayTime,fadeSpeed
  local playRadio
  if IsTypeTable(abortInfo)then
    if abortInfo.isNoSave then
      isNoSave=true
    else
      isNoSave=false
      fadeDelayTime=5.5
      fadeSpeed=TppUI.FADE_SPEED.FADE_HIGHSPEED
      presentationFunction=TppPlayer.PlayMissionAbortCamera
      playRadio=true
    end
  end
  if TppLocation.IsAfghan()then
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio}
  elseif TppLocation.IsMiddleAfrica()then
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio}
  else
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio}
  end
end
function this.AbortForRideOnHelicopter(abortInfo)
  local isNoSave=true
  local isAlreadyGameOver=false
  if IsTypeTable(abortInfo)then
    if abortInfo.isNoSave then
      isNoSave=true
    else
      isNoSave=false
    end
    if abortInfo.isAlreadyGameOver then
      isAlreadyGameOver=true
    end
  end
  if TppLocation.IsAfghan()then
    gvars.ini_isTitleMode=false
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI,isNoSave=isNoSave,isAlreadyGameOver=isAlreadyGameOver}
  elseif TppLocation.IsMiddleAfrica()then
    gvars.ini_isTitleMode=false
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_HELI,isNoSave=isNoSave,isAlreadyGameOver=isAlreadyGameOver}
  elseif TppLocation.IsMotherBase()then
    gvars.ini_isTitleMode=false
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MTBS_HELI,isNoSave=isNoSave,isAlreadyGameOver=isAlreadyGameOver}
  else
    gvars.ini_isTitleMode=false
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI,isNoSave=isNoSave,isAlreadyGameOver=isAlreadyGameOver}
  end
end
function this.AbortForRideFultonContainer(abortInfo)
  this.AbortForRideOnHelicopter{isNoSave=false}
end
function this.GameOverAbortMission()
  if gvars.mis_isStartFromHelispace then
    this.GameOverAbortForRideOnHelicopter()
  elseif gvars.mis_isStartFromFreePlay then
    this.GameOverAbortForOutOfMissionArea()
  else
    this.GameOverAbortForRideOnHelicopter()
  end
  this.ExecuteMissionAbort()
end
function this.GameOverAbortForOutOfMissionArea()
  if TppLocation.IsAfghan()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  elseif TppLocation.IsMiddleAfrica()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_FREE
  else
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  end
end
function this.GameOverAbortForRideOnHelicopter()
  if TppLocation.IsAfghan()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_HELI
  elseif TppLocation.IsMiddleAfrica()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_HELI
  elseif TppLocation.IsMotherBase()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MTBS_HELI
  elseif TppLocation.IsMBQF()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MTBS_HELI
  else
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_HELI
  end
end
function this.OnChangeSVars(name,key)
  if name=="mis_isDefiniteMissionClear"then
    if(svars.mis_isDefiniteMissionClear)then
      mvars.mis_isReserveMissionClear=true
    end
  end
  if name=="mis_isDefiniteGameOver"then
    if(svars.mis_isDefiniteGameOver)then
      mvars.mis_isDefiniteGameOver=true
    end
  end
  if name=="mis_fobDefenceGameOver"then
    this.OnChangeFobDefenceGameOver()
  end
  if name=="mis_canMissionClear"then
    if svars.mis_canMissionClear then
      this.OnCanMissionClear()
    end
    if mvars.mis_isAlertOutOfMissionArea then
      this.EnableAlertOutOfMissionArea()
    else
      this.DisableAlertOutOfMissionArea()
    end
    if mvars.mis_isOutsideOfHotZone then
      this.ExitHotZone()
    end
  end
end
function this.PostMissionOrderBoxPositionToBuddyDog()
  if(not this.IsFreeMission(vars.missionCode))then
    if mvars.mis_orderBoxList then
      local positions={}
      for i,boxName in pairs(mvars.mis_orderBoxList)do
        local pos,rot=this.GetOrderBoxLocatorByTransform(boxName)
        if pos then
          table.insert(positions,pos)
        end
      end
      TppBuddyService.SetMissionGroundStartPositions{positions=positions}
    else
      TppBuddyService.ResetDogLeakedInformation()
    end
  else
    TppBuddyService.ResetDogLeakedInformation()
  end
end
function this.SetIsStartFromHelispace()
  gvars.mis_isStartFromHelispace=true
end
function this.ResetIsStartFromHelispace()
  gvars.mis_isStartFromHelispace=false
end
function this.SetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=true
end
function this.ResetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=false
end
function this.CanMissionAbortByMenu()
  if gvars.mis_isStartFromHelispace or gvars.mis_isStartFromFreePlay then
    return true
  else
    return false
  end
end
function this.SetMissionOrderBoxPosition()
  if not mvars.mis_orderBoxList then
    return
  end
  if gvars.mis_orderBoxName==0 then
    return
  end
  local boxName=this.FindOrderBoxName(gvars.mis_orderBoxName)
  return this._SetMissionOrderBoxPosition(boxName)
end
function this._SetMissionOrderBoxPosition(boxName)
  local boxPosition,boxRotation=this.GetOrderBoxLocator(boxName)
  if boxPosition then
    local posOffset=Vector3(0,-.75,1.98)
    local fixedPos=Vector3(boxPosition[1],boxPosition[2],boxPosition[3])
    local rotQuat=-Quat.RotationY(TppMath.DegreeToRadian(boxRotation)):Rotate(posOffset)
    local position=rotQuat+fixedPos
    local positionVecTable=TppMath.Vector3toTable(position)
    local rotationDeg=boxRotation
    TppPlayer.SetInitialPosition(positionVecTable,rotationDeg)
    TppPlayer.SetMissionStartPosition(positionVecTable,rotationDeg)
    return true
  end
end
function this.FindOrderBoxName(orderBoxNameStr32)
  for i,orderBoxName in pairs(mvars.mis_orderBoxList)do
    if StrCode32(orderBoxName)==orderBoxNameStr32 then
      return orderBoxName
    end
  end
end
function this.GetOrderBoxLocator(orderBoxName)
  if not IsTypeString(orderBoxName)then
    return
  end
  return Tpp.GetLocator("OrderBoxIdentifier",orderBoxName)
end
function this.GetOrderBoxLocatorByTransform(orderBoxName)
  if not IsTypeString(orderBoxName)then
  end
  return Tpp.GetLocatorByTransform("OrderBoxIdentifier",orderBoxName)
end
function this.SetFobPlayerStartPoint()
  local clusterNames={"Command","Combat","Develop","Support","Medical","Spy","BaseDev"}
  local cluster=255
  if not MotherBaseStage.GetFirstCluster then
    cluster=MotherBaseStage.GetCurrentCluster()
  else
    cluster=MotherBaseStage.GetFirstCluster()
  end
  local clusterName=clusterNames[cluster+1]
  local clusterGrade=TppMotherBaseManagement.GetMbsClusterGrade{category=clusterName}
  if TppMotherBaseManagement.GetMbsClusterBuildStatus{category=clusterName}~="Completed"then
    clusterGrade=clusterGrade-1
  end
  local gradeByOne=clusterGrade-1
  if gradeByOne<0 then--NMC I would have though they would have wanted to kick up a fuss if this happened instead of silently returning
    return false
  end
  local locatorName=""
  if TppNetworkUtil.IsHost()==false then
    locatorName="player_locator_clst"..(cluster.."_plnt0_df0")
    local pos,rot=Tpp.GetLocator("MtbsStartPointIdentifier",locatorName)
    if pos then
      TppPlayer.SetInitialPosition(pos,rot)
      return true
    end
    return false
  end
end
function this.IsNeedSetMissionStartPositionToClusterPosition()
  if gvars.forcePlayerPositionDemoCenter then
    gvars.forcePlayerPositionDemoCenter=false
    return true
  end
  if not TppLocation.IsMotherBase()then
    return false
  end
  if this.IsSysMissionId(vars.missionCode)then
    return false
  end
  if TppPackList.GetLocationNameFormMissionCode(vars.missionCode)=="MTBS"then
    return false
  else
    return true
  end
end
function this.ReserveForcePlayerPositionToMbDemoCenter()
  gvars.forcePlayerPositionDemoCenter=true
end
function this.SetMissionStartPositionMtbsClusterPosition()
  if mtbs_cluster==nil then
    return
  end
  local firstCluster=MotherBaseStage.GetFirstCluster()
  local firstClusterName=mtbs_cluster.GetClusterName(MotherBaseStage.GetFirstCluster()+1)
  local demoCenter=MotherBaseStage.GetDemoCenter(firstCluster)
  local position=TppMath.Vector3toTable(demoCenter)
  TppPlayer.SetInitialPosition(position,0)
end
function this.EstablishedMissionClear()
  DemoDaemon.StopAll()
  GkEventTimerManager.StopAll()
  if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
    GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  end
  this.SeizeReliefVehicleOnClear()
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  TppHero.SetFirstMissionClearHeroPoint()
  if this.systemCallbacks.OnSetMissionFinalScore then
    this.systemCallbacks.OnSetMissionFinalScore(svars.mis_missionClearType)
  end
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.ESTABLISHED_CLEAR)
  if(svars.mis_missionClearType==TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER)then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"EstablishedMissionClearOnRideOnFultonContainer",nil,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
  end
  this.systemCallbacks.OnEstablishMissionClear(svars.mis_missionClearType)
end
function this.OnMissionGameEndFadeOutFinish()
  local nextIsHeliSpace=this.IsHelicopterSpace(gvars.mis_nextMissionCodeForMissionClear)
  if not nextIsHeliSpace then
    this.ReserveMissionStartRecoverSoundDemo()
  else
    this.ClearMissionStartRecoverSoundDemo()
  end
  TppEnemy.FultonRecoverOnMissionGameEnd()
  TppPlayer.SaveCaptureAnimal()
  TppTerminal.AddVolunteerStaffs()
  if Player.CallRemovingChickenCapSE~=nil then
    Player.CallRemovingChickenCapSE()
  end
  if this.systemCallbacks.OnMissionGameEndFadeOutFinish then
    this.systemCallbacks.OnMissionGameEndFadeOutFinish()
  end
  if(mvars.mis_missionGameEndDelayTime>.1)then
    TimerStart("Timer_MissionGameEndStart",mvars.mis_missionGameEndDelayTime)
  else
    TimerStart("Timer_MissionGameEndStart",.1)
  end
end
function this.OnMissionGameEndFadeOutFinish2nd()
  InfMain.OnMissionGameEndTop()--tex
  TppUiStatusManager.ClearStatus"GmpInfo"
  TppStory.UpdateStorySequence{updateTiming="OnMissionClear",missionId=this.GetMissionID()}
  TppResult.SetMissionFinalScore()
  this.KillDyingQuiet()
  TppTrophy.UnlockOnBuddyFriendlyMax()
  TppTrophy.UnlockOnAllMissionTaskCompleted()
  local r,a,i,s,o,n=TppStory.CheckAllMissionCleared()
  if r then
    TppStory.CompleteAllMissionCleared()
    TppTrophy.Unlock(12)
  end
  if a then
    TppStory.CompleteAllMissionSRankCleared()
    TppTrophy.Unlock(14)
  end
  if i then
    TppStory.CompleteAllNormalMissionCleared()
    TppEmblem.AcquireOnAllMissionCleared()
  end
  if s then
    TppStory.CompleteAllNormalMissionSRankCleared()
    TppEmblem.AcquireOnAllMissionSRankCleared()
  end
  if o then
    TppStory.CompleteAllHardMissionCleared()
  end
  if n then
    TppStory.CompleteAllHardMissionSRankCleared()
  end
  if vars.totalMarkingCount>=750 then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3020,pushReward=true}
  end
  if TppBuddyService.CanSortieBuddyType(BuddyType.DOG)then
    TppTrophy.Unlock(24,1e3,-1e3)
  end
  if TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)then
    TppTrophy.Unlock(25,1e3,-1e3)
  end
  if TppUiCommand.CheckMbTopMenuDHorseCustomizeOpen~=nil then
    if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.HORSE)>=100 then
      if TppUiCommand.CheckMbTopMenuDHorseCustomizeOpen()==false then
        TppUiCommand.SetMbTopMenuDHorseCustomizeOpen(true)
        this._PushReward(TppScriptVars.CATEGORY_MB_MANAGEMENT,"reward_403",TppReward.TYPE.COMMON)
      end
    end
    if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)>=100 then
      if TppUiCommand.CheckMbTopMenuDDogCustomizeOpen()==false then
        TppUiCommand.SetMbTopMenuDDogCustomizeOpen(true)
        this._PushReward(TppScriptVars.CATEGORY_MB_MANAGEMENT,"reward_404",TppReward.TYPE.COMMON)
      end
    end
  end
  TppQuest.OnMissionGameEnd()
  TppTerminal.OnEstablishMissionClear()
  TppTerminal.PushRewardOnMbSectionOpen()
  TppHero.UpdateHero()
  TppCassette.OnEstablishMissionClear()
  TppRanking.UpdateOpenRanking()
  local nukeWaste=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
  TppRanking.UpdateScore("NuclearDisposeCount",nukeWaste)
  TppRanking.SendCurrentRankingScore()
  do
    local missionCode=this.GetMissionID()
    local allowFree=(missionCode==30010 or missionCode==30020) and Ivars.disableNoStealthCombatRevengeMission:Is(1)--tex
    if(not this.IsFOBMission(missionCode)and (not this.IsFreeMission(missionCode) or allowFree))and not this.IsHelicopterSpace(missionCode)then--tex added allowFree
      TppRevenge.ReduceRevengePointOnMissionClear(missionCode)
    end
  end
  TppTutorial.OpenTipsOnCurrentStory()
  if gvars.usingNormalMissionSlot then
    TppStory.FailedRetakeThePlatformIfOpened()
  end
  local missionClearType=this.GetMissionClearType()
  if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO)or(missionClearType==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX)then
    if Ivars.dontOverrideFreeLoadout:Is(0) then--tex added bypass
      TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()
    end
  end
  TppHero.AnnounceFirstMissionClearHeroPoint()
  TppPlayer.AggregateCaptureAnimal()
  if not this.IsHelicopterSpace(this.GetMissionID())then
    TppTerminal.AddStaffsFromTempBuffer()
  end
  this.ExecuteVehicleSaveCarryOnClear()
  this.ForceGoToMbFreeIfExistMbDemo()
  if not this.IsFOBMission(gvars.mis_nextMissionCodeForMissionClear)then
    TppSave.EraseAllGameDataSaveRequest()--RETAILPATCH: 1060
    TppSave.VarSave()
  end
  TimerStart("Timer_MissionGameEndStart2nd",.1)
end
function this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
  mvars.mis_missionObjectiveDefine=objectiveDefine
  mvars.mis_missionObjectiveTree=ojectiveTree
  mvars.mis_missionObjectiveEnum=objectiveEnum
  if mvars.mis_missionObjectiveTree then
    for n,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
      for e,i in pairs(e)do
        local objectiveDefine=mvars.mis_missionObjectiveDefine[e]
        if objectiveDefine then
          objectiveDefine.parent=objectiveDefine.parent or{}
          objectiveDefine.parent[n]=true
        end
      end
    end
  end
  if mvars.mis_missionObjectiveTree and mvars.mis_missionObjectiveEnum==nil then
    return
  end
  if#mvars.mis_missionObjectiveEnum>maxObjective then
    return
  end
end
function this.OnFinishUpdateObjectiveRadio(radioGroupNameStr32)
  if radioGroupNameStr32==StrCode32(mvars.mis_updateObjectiveRadioGroupName)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
--mvars.mis_objectiveSetting
function this.ShowUpdateObjective(objectiveSetting)
  if not IsTypeTable(objectiveSetting)then
    return
  end
  local announceLogTable={}
  for n,s in pairs(objectiveSetting)do
    local objectiveDefine=mvars.mis_missionObjectiveDefine[s]
    local t=not this.IsEnableMissionObjective(s)
    if t then
      t=(not this.IsEnableAnyParentMissionObjective(s))
    end
    if objectiveDefine.packLabel then
      if not TppPackList.IsMissionPackLabelList(objectiveDefine.packLabel)then
        t=false
      end
    end
    if objectiveDefine and t then
      this.DisableChildrenObjective(s)
      this._ShowObjective(objectiveDefine,true)
      local announceInfo={isMissionAnnounce=false,subGoalId=nil}
      if objectiveDefine.announceLog then
        announceInfo.isMissionAnnounce=true
        if objectiveDefine.subGoalId then
          announceInfo.subGoalId=objectiveDefine.subGoalId
        end
        announceLogTable[objectiveDefine.announceLog]=announceInfo
      end
      this.SetMissionObjectiveEnable(s,true)
    end
  end
  if next(announceLogTable)then
    for i=1,#TppUI.ANNOUNCE_LOG_PRIORITY do
      local priority=TppUI.ANNOUNCE_LOG_PRIORITY[i]
      local announceLogInfo=announceLogTable[priority]
      if announceLogInfo then
        if announceLogInfo.isMissionAnnounce then
          TppUI.ShowAnnounceLog(priority)
          if announceLogInfo.subGoalId and announceLogInfo.subGoalId>0 then
            TppUI.ShowAnnounceLog("subGoalContent",nil,nil,nil,announceLogInfo.subGoalId)
          end
        end
        announceLogTable[priority]=nil
      end
    end
    if next(announceLogTable)then
      for announceId,n in pairs(announceLogTable)do
        TppUI.ShowAnnounceLog(announceId)
      end
    end
    TppSoundDaemon.PostEvent"sfx_s_terminal_data_fix"
  end
  mvars.mis_objectiveSetting=nil
  mvars.mis_updateObjectiveRadioGroupName=nil
  mvars.mis_updateObjectiveOnHelicopterStart=nil
end
function this._ShowObjective(objectiveDefine,RENAMEbool)
  if objectiveDefine.packLabel then
    if not TppPackList.IsMissionPackLabelList(objectiveDefine.packLabel)then
      return
    end
  end
  if objectiveDefine.setInterrogation==nil then
    objectiveDefine.setInterrogation=true
  end
  if objectiveDefine.gameObjectName then
    TppMarker.Enable(objectiveDefine.gameObjectName,objectiveDefine.visibleArea,objectiveDefine.goalType,objectiveDefine.viewType,objectiveDefine.randomRange,objectiveDefine.setImportant,objectiveDefine.setNew,objectiveDefine.mapRadioName,objectiveDefine.langId,objectiveDefine.goalLangId,objectiveDefine.setInterrogation)
  end
  if objectiveDefine.gimmickId then
    local i,gameObjectName=TppGimmick.GetGameObjectId(objectiveDefine.gimmickId)
    if i then
      TppMarker.Enable(gameObjectName,objectiveDefine.visibleArea,objectiveDefine.goalType,objectiveDefine.viewType,objectiveDefine.randomRange,objectiveDefine.setImportant,objectiveDefine.setNew,objectiveDefine.mapRadioName,objectiveDefine.langId,objectiveDefine.goalLangId,objectiveDefine.setInterrogation)
    end
  end
  if objectiveDefine.photoId then
    TppUI.EnableMissionPhoto(objectiveDefine.photoId,objectiveDefine.addFirst,objectiveDefine.addSecond,objectiveDefine.isComplete,objectiveDefine.photoRadioName)
  end
  if objectiveDefine.hudPhotoId then
    TppUiCommand.ShowPictureInfoHud(objectiveDefine.hudPhotoId,1,3)
  end
  if objectiveDefine.subGoalId then
    TppUI.EnableMissionSubGoal(objectiveDefine.subGoalId)
    if objectiveDefine.subGoalId>0 then
      if not objectiveDefine.announceLog then
        objectiveDefine.announceLog="updateMissionInfo"
      end
    end
  end
  if objectiveDefine.showEnemyRoutePoints then
    if TppUiCommand.ShowEnemyRoutePoints then
      local radioGroupName=objectiveDefine.showEnemyRoutePoints.radioGroupName
      if IsTypeString(radioGroupName)then
        objectiveDefine.showEnemyRoutePoints.radioGroupName=StrCode32(radioGroupName)
      end
      TppUiCommand.ShowEnemyRoutePoints(objectiveDefine.showEnemyRoutePoints)
    end
  end
  if objectiveDefine.targetBgmCp then
    TppEnemy.LetCpHasTarget(objectiveDefine.targetBgmCp,true)
  end
  if objectiveDefine.missionTask then
    TppUI.EnableMissionTask(objectiveDefine.missionTask,RENAMEbool)
  end
  if objectiveDefine.spySearch then
    TppUI.EnableSpySearch(objectiveDefine.spySearch)
  end
end
function this.RestoreShowMissionObjective()
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  for n,i in ipairs(mvars.mis_missionObjectiveEnum)do
    if not svars.mis_objectiveEnable[n]then
      local objectiveDefine=mvars.mis_missionObjectiveDefine[i]
      if objectiveDefine then
        this.DisableObjective(objectiveDefine)
      end
    end
  end
  for n,i in ipairs(mvars.mis_missionObjectiveEnum)do
    if svars.mis_objectiveEnable[n]then
      local objectiveDefine=mvars.mis_missionObjectiveDefine[i]
      if objectiveDefine then
        this._ShowObjective(objectiveDefine,false)
      end
    end
  end
end
function this.SetMissionObjectiveEnable(e,n)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local e=mvars.mis_missionObjectiveEnum[e]
  if not e then
    return
  end
  svars.mis_objectiveEnable[e]=n
end
function this.IsEnableMissionObjective(e)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local e=mvars.mis_missionObjectiveEnum[e]
  if not e then
    return
  end
  return svars.mis_objectiveEnable[e]
end
function this.GetParentObjectiveName(e)
  local objectiveDefine=mvars.mis_missionObjectiveDefine[e]
  if not objectiveDefine then
    return
  end
  return objectiveDefine.parent
end
function this.IsEnableAnyParentMissionObjective(n)
  local objectiveDefine=mvars.mis_missionObjectiveDefine[n]
  if not objectiveDefine then
    return
  end
  if not objectiveDefine.parent then
    return false
  end
  local i
  for n,s in pairs(objectiveDefine.parent)do
    if this.IsEnableMissionObjective(n)then
      return true
    else
      i=this.IsEnableAnyParentMissionObjective(n)
      if i then
        return true
      end
    end
  end
  return false
end
function this.DisableChildrenObjective(s)
  local n
  for i,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
    if i==s then
      n=e
      break
    end
  end
  if not n then
    return
  end
  for i,n in Tpp.BfsPairs(n)do
    local objectiveDefine=mvars.mis_missionObjectiveDefine[i]
    if objectiveDefine then
      this.SetMissionObjectiveEnable(i,false)
      this.DisableObjective(objectiveDefine)
    end
  end
end
function this.DisableObjective(objectiveDefine)
  if objectiveDefine.packLabel then
    if not TppPackList.IsMissionPackLabelList(objectiveDefine.packLabel)then
      return
    end
  end
  if objectiveDefine.gameObjectName then
    TppMarker.Disable(objectiveDefine.gameObjectName,objectiveDefine.mapRadioName)
  end
  if objectiveDefine.gimmickId then
    local n,i=TppGimmick.GetGameObjectId(objectiveDefine.gimmickId)
    if n then
      TppMarker.Disable(i,objectiveDefine.mapRadioName)
    end
  end
  if objectiveDefine.photoId then
    TppUI.DisableMissionPhoto(objectiveDefine.photoId,objectiveDefine.photoRadioName)
  end
  if objectiveDefine.showEnemyRoutePoints then
    local groupIndex=objectiveDefine.showEnemyRoutePoints.groupIndex
    if TppUiCommand.InitEnemyRoutePoints then
      TppUiCommand.InitEnemyRoutePoints(groupIndex)
    end
  end
  if objectiveDefine.targetBgmCp then
    TppEnemy.LetCpHasTarget(objectiveDefine.targetBgmCp,false)
  end
  if objectiveDefine.missionTask then
    TppUiCommand.DisableMissionTask(objectiveDefine.missionTask)
  end
  if objectiveDefine.spySearch then
    TppUI.DisableSpySearch(objectiveDefine.spySearch)
  end
end
function this.VarSaveOnUpdateCheckPoint(saveBusy)
  gvars.isNewGame=false
  TppTerminal.OnRecoverByHelicopterOnCheckPoint()
  TppTerminal.AddStaffsFromTempBuffer(true)
  TppSave.ReserveVarRestoreForContinue()
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars()
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppPlayer.StorePlayerDecoyInfos()
  if not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
    svars.ply_isUsedPlayerInitialAction=true
  end
  TppRadioCommand.StoreRadioState()
  if Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint then
    Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint()
  end
  TppMotherBaseManagement.CheckMisogi()--RETAILPATCH 1070
  TppSave.VarSave(vars.missionCode)
  if vars.missionCode==10115 then
    return
  end
  if not saveBusy then
    TppSave.SaveGameData(nil,nil,nil,nil,true)
    this.CreateMbSaveCoroutine()
  end
end
function this.SafeStopSettingOnMissionReload(parms)
  local setMute
  if parms and parms.setMute then
    setMute=parms.setMute
  end
  mvars.mis_missionStateIsNotInGame=true
  gvars.canExceptionHandling=false
  SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
  TppRadio.Stop()
  TppMusicManager.StopMusicPlayer(1)
  TppMusicManager.EndSceneMode()
  TppRadioCommand.SetEnableIgnoreGamePause(false)
  if TppBuddy2BlockController.Unload then
    TppBuddy2BlockController.Unload()
  end
  GkEventTimerManager.StopAll()
  if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
    GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  end
  if setMute then
    TppSoundDaemon.SetMute(setMute)
  else
    TppSound.SetMuteOnLoading()
  end
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.VarResetOnNewMission()
  TppScriptVars.InitForNewMission()
  TppCheckPoint.Reset()
  TppQuest.ResetQuestStatus()
  TppPackList.SetDefaultMissionPackLabelName()
  TppPlayer.UnsetRetryFlag()
  if GameConfig.GetStealthAssistEnabled()then
    mvars.mis_needSaveConfigOnNewMission=true
    GameConfig.SetStealthAssistEnabled(false)
  end
  TppPlayer.ResetStealthAssistCount()
  TppSave.ReserveVarRestoreForMissionStart()
  TppResult.ClearNewestPlayStyleHistory()
  this.SetNextMissionCodeForMissionClear(missionClearCodeNone)
  this.ResetMissionClearState()
end
function this.GetCurrentLocationHeliMissionAndLocationCode()
  if TppLocation.IsAfghan()then
    return TppDefine.SYS_MISSION_ID.AFGH_HELI,TppDefine.LOCATION_ID.AFGH
  elseif TppLocation.IsMiddleAfrica()then
    return TppDefine.SYS_MISSION_ID.MAFR_HELI,TppDefine.LOCATION_ID.MAFR
  elseif TppLocation.IsMotherBase()then
    return TppDefine.SYS_MISSION_ID.MTBS_HELI,TppDefine.LOCATION_ID.MTBS
  elseif TppLocation.IsMBQF()then
    return TppDefine.SYS_MISSION_ID.MTBS_HELI,TppDefine.LOCATION_ID.MTBS
  else
    return TppDefine.SYS_MISSION_ID.AFGH_HELI,TppDefine.LOCATION_ID.AFGH
  end
end
function this.ResetEmegerncyMissionSetting()
  gvars.usingNormalMissionSlot=true
  gvars.mis_nextMissionCodeForEmergency=0
  gvars.mis_nextLayoutCodeForEmergency=TppDefine.INVALID_LAYOUT_CODE
  gvars.mis_nextClusterIdForEmergency=TppDefine.INVALID_CLUSTER_ID
  gvars.mis_nextMissionStartRouteForEmergency=0
  vars.returnStaffHeader=0
  vars.returnStaffSeeds=0
end
function this.GoToEmergencyMission()
  local emergencyMissionCode=gvars.mis_nextMissionCodeForEmergency
  local startRoute
  if emergencyMissionCode~=TppDefine.SYS_MISSION_ID.FOB then
    if gvars.mis_nextMissionStartRouteForEmergency~=0 then
      startRoute=gvars.mis_nextMissionStartRouteForEmergency
    else
      return
    end
  end
  local mbLayoutCode
  if gvars.mis_nextLayoutCodeForEmergency~=TppDefine.INVALID_LAYOUT_CODE then
    mbLayoutCode=gvars.mis_nextLayoutCodeForEmergency
  else
    mbLayoutCode=TppDefine.STORY_MISSION_LAYOUT_CODE[vars.missionCode]or TppDefine.OFFLINE_MOHTER_BASE_LAYOUT_CODE--RETAILBUG: since day0, was TppDefine.STORY_MISSION_LAYOUT_CODE[missionCode]
  end
  local clusterId=2
  if gvars.mis_nextClusterIdForEmergency~=TppDefine.INVALID_CLUSTER_ID then
    clusterId=gvars.mis_nextClusterIdForEmergency
  end
  this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,nextMissionId=emergencyMissionCode,nextHeliRoute=startRoute,nextLayoutCode=mbLayoutCode,nextClusterId=clusterId}
end
function this.RequestLoad(nextMission,currentMission,options)
  InfLog.AddFlow("TppMission.RequestLoad next:"..nextMission.." current:"..tostring(currentMission))--tex
  if not mvars then
    return
  end
  if gvars.isLoadedInitMissionOnSignInUserChanged then
    return
  end
  TppMain.EnablePause()
  mvars.mis_loadRequest={nextMission=nextMission,currentMission=currentMission,options=options}
end
function this.LoadWithChunkCheck()
  InfLog.AddFlow("TppMission.LoadWithChunkCheck "..vars.missionCode)--tex
  local nextMission,currentMission,loadOptions=mvars.mis_loadRequest.nextMission,mvars.mis_loadRequest.currentMission,mvars.mis_loadRequest.options
  local chunkIndex=Tpp.GetChunkIndex(vars.locationCode)
  if this.IsChunkLoading(chunkIndex)then
    return
  end
  this.Load(nextMission,currentMission,loadOptions)
  mvars.mis_loadRequest=nil
end
function this.IsChunkLoading(chunkIndex)
  if Chunk.GetChunkState(chunkIndex)==Chunk.STATE_INSTALLED then
    if mvars.mis_isChunkLoading then
      Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
      mvars.mis_isChunkLoading=false
    end
    if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
      TppUiCommand.ErasePopup()
    end
    return false
  end
  if not mvars.mis_isChunkLoading then
    Chunk.PrefetchChunk(chunkIndex)
    Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
    mvars.mis_isChunkLoading=true
  end
  if SplashScreen.GetSplashScreenWithName"konamiLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"kjpLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"foxLogo"then
    return true
  end
  Tpp.ShowChunkInstallingPopup(chunkIndex,false)
  return true
end
function this.Load(nextMissionCode,currentMissionCode,loadSettings)
  InfLog.AddFlow("TppMission.Load nextMissionCode:"..tostring(nextMissionCode).." currentMissionCode:"..tostring(currentMissionCode))--tex
  InfMain.OnLoad(nextMissionCode,currentMissionCode)--tex
  local showLoadingTips
  if(loadSettings and loadSettings.showLoadingTips~=nil)then
    showLoadingTips=loadSettings.showLoadingTips
  else
    showLoadingTips=true
  end
  if(loadSettings and loadSettings.waitOnLoadingTipsEnd~=nil)then
    gvars.waitLoadingTipsEnd=loadSettings.waitOnLoadingTipsEnd
  else
    gvars.waitLoadingTipsEnd=true
  end
  TppMain.EnablePause()
  TppMain.EnableBlackLoading(showLoadingTips)
  if not TppEnemy.IsLoadedDefaultSoldier2CommonPackage()then
    TppEnemy.UnloadSoldier2CommonBlock()
  end
  if(currentMissionCode~=nextMissionCode)or(loadSettings and loadSettings.force)then
    local locationNameForMissionCode=TppPackList.GetLocationNameFormMissionCode(nextMissionCode)
    local renameLocationNameForSomeMissionCode=TppPackList.GetLocationNameFormMissionCode(currentMissionCode)
    local locationForce
    if locationNameForMissionCode=="MTBS"and renameLocationNameForSomeMissionCode=="MTBS"then
      if nextMissionCode~=TppDefine.SYS_MISSION_ID.MTBS_HELI then
        if not(loadSettings and loadSettings.ignoreMtbsLoadLocationForce)then
          locationForce={force=true}
        end
      end
    end
    if TppLocation.IsMotherBase()then
      local applyPlatformParamToMbStage=TppLocation.ApplyPlatformParamToMbStage(nextMissionCode,"MotherBase")
      local missionLayoutCode=TppDefine.STORY_MISSION_LAYOUT_CODE[nextMissionCode]
      if missionLayoutCode then
        if currentMissionCode==nil and nextMissionCode==30050 then
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(missionLayoutCode)
        end
      else
        if applyPlatformParamToMbStage then
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    if TppSystemUtility.GetCurrentGameMode()=="TPP"then
      TppEneFova.InitializeUniqueSetting()
      TppEnemy.PreMissionLoad(nextMissionCode,currentMissionCode)
    end
    Mission.LoadLocation(locationForce)
    Mission.LoadMission(loadSettings)
  else
    Mission.RequestToReload()
  end
  TppUI.ShowAccessIcon()
end
function this.ExecuteReload()
  InfLog.AddFlow("TppMission.ExecuteReload "..vars.missionCode)--tex
  if mvars.mis_nextLocationCode then
    vars.locationCode=mvars.mis_nextLocationCode
  end
  if mvars.mis_nextLayoutCode then
    vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
  end
  if mvars.mis_nextClusterId then
    vars.mbClusterId=mvars.mis_nextClusterId
  end
  this.SafeStopSettingOnMissionReload()
  TppPackList.SetMissionPackLabelName(mvars.mis_missionPackLabelName)
  TppPlayer.ForceSetAllInitialWeapon()
  TppSave.VarSave()
  TppSave.CheckAndSavePersonalData()
  this.RequestLoad(vars.missionCode,nil,{force=true,showLoadingTips=mvars.mis_showLoadingTipsOnReload,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
end
function this.CanStart()
  if mvars.mis_alwaysMissionCanStart then
    return true
  else
    return Mission.CanStart()
  end
end
function this.SetNextMissionCodeForMissionClear(missionCode)
  gvars.mis_nextMissionCodeForMissionClear=missionCode
end
function this.GetNextMissionCodeForMissionClear()
  return gvars.mis_nextMissionCodeForMissionClear
end
function this.AlwaysMissionCanStart()
  mvars.mis_alwaysMissionCanStart=true
end
function this.KillDyingQuiet()
  if TppBuddyService.BuddyProcessMissionEnd then
    TppBuddyService.BuddyProcessMissionEnd()
  else
    if TppBuddyService.IsQuietDeadFromDying and TppBuddyService.IsQuietDeadFromDying()then
      TppBuddyService.QuietDyingToDead()
    end
  end
end
function this.SetSortieBuddy()
  if TppDemo.IsPlayedMBEventDemo"DdogGoWithMe"then
    TppBuddyService.SetSortieBuddyType(BuddyType.DOG)
  end
  if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
  else
    if TppQuest.IsCleard"mtbs_q99011"then
      if TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)then
        if not TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)then
          TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION,TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_WITH_GO_MISSION)
        end
        TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
      end
    end
  end
end
function this.ResetQuietEquipIfUndevelop()--RETAILPATCH: 1060
  if vars.buddyQuietEquipType==4 then
    if not TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=6094}then
      TppBuddyService.SetVarsQuietWeaponType(0)
    end
end
end--
local mbMission={[30050]=true,[50050]=true}
local clearType={
  [TppDefine.MISSION_CLEAR_TYPE.ON_FOOT]=true,
  [TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER]=true,
  [TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_VEHILCE]=true,
  [TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER]=true
}
function this.ForceGoToMbFreeIfExistMbDemo()
  if mbMission[vars.missionCode]then
    return
  end
  local missionClearType=this.GetMissionClearType()
  if not clearType[missionClearType]then
    return
  end
  local forceDemoName=TppStory.GetForceMBDemoNameOrRadioList"forceMBDemo"
  if forceDemoName then
    TppDemo.SetNextMBDemo(forceDemoName)
    if TppDefine.MB_FREEPLAY_RIDEONHELI_DEMO_DEFINE[forceDemoName]~=nil then
      this.SetNextMissionStartHeliRoute"ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"
    end
    this.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MTBS_FREE)
    this.SeizeReliefVehicleOnForceGoToMb()
  end
  local n=TppStory.GetForceMBDemoNameOrRadioList("blackTelephone",{demoName=forceDemoName})
  if n then
    TppRadio.SaveRewardEndRadioList(n)
    if n[1]=="f6000_rtrg0310"then--PATCHUP:
      this.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MAFR_HELI)
    else
      this.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MTBS_FREE)
    end
  end
end
function this.ResetMBFreeStartPositionToCommand()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
  TppPlayer.ResetNoOrderBoxMissionStartPosition()
  this.ResetIsStartFromHelispace()
  this.ResetIsStartFromFreePlay()
  vars.mbClusterId=TppDefine.CLUSTER_DEFINE.Command
end
function this.SetNextMissionStartHeliRoute(heliRoute)
  mvars.heli_missionStartRoute=heliRoute
end
function this.ClearFobMode()
  vars.fobSneakMode=FobMode.MODE_NONE
  vars.fobIsPlaceMode=0--RETAILPATCH 1070
end
function this.UnsetFobSneakFlag(missionCode)
  if not this.IsFOBMission(missionCode)then
    if TppServerManager.FobIsSneak()then
      vars.fobIsSneak=0
    end
  end
end
function this.StartHelicopterDoorOpenTimer()
  local time=mvars.mis_helicopterDoorOpenTimerTimeSec
  GameObject.SendCommand({type="TppHeli2",index=0},{id="SetSendDoorOpenManually",enabled=true})
  TimerStart("Timer_MissionStartHeliDoorOpen",time)
end
function this.GetObjectiveRadioOption(n)
  local e={}
  if IsTypeTable(n.radioOptions)then
    for i,n in pairs(n.radioOptions)do
      e[i]=n
    end
  end
  if FadeFunction.IsFadeProcessing()then
    local delayTime=e.delayTime
    local fadeTime=TppUI.FADE_SPEED.FADE_NORMALSPEED+1.2
    if IsTypeString(delayTime)then
      e.delayTime=TppRadio.PRESET_DELAY_TIME[delayTime]+fadeTime
    elseif IsTypeNumber(delayTime)then
      e.delayTime=delayTime+fadeTime
    else
      e.delayTime=fadeTime
    end
  end
  return e
end
function this.OnMissionStart()
  if this.IsMissionStart()then
    gvars.mis_quietCallCountOnMissionStart=vars.buddyCallCount[BuddyType.QUIET]
    if vars.buddyType==BuddyType.QUIET then
      gvars.mis_quietCallCountOnMissionStart=gvars.mis_quietCallCountOnMissionStart-1
    end
  end
end
function this.SetPlayRecordClearInfo()
  local clearCount,allCount=TppStory.CalcAllMissionClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionClear",clearCount=clearCount,allCount=allCount}
  local clearCount,allCount=TppStory.CalcAllMissionTaskCompletedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionTaskClear",clearCount=clearCount,allCount=allCount}
  local clearCount,allCount=TppQuest.CalcQuestClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="SideOpsClear",clearCount=clearCount,allCount=allCount}
end
function this.IsBossBattle()
  if not mvars.mis_isBossBattle then
    return false
  end
  return true
end
function this.StartBossBattle()
  mvars.mis_isBossBattle=true
end
function this.FinishBossBattle()
  mvars.mis_isBossBattle=false
end
function this.ShowAnnounceLogOnGameStart()
  local missionCode,missionTypeCodeName=this.ParseMissionName(this.GetMissionName())
  if(missionTypeCodeName=="free"or missionTypeCodeName=="heli")then
    if gvars.mis_isExistOpenMissionFlag then
      TppUI.ShowAnnounceLog"missionListUpdate"
      TppUI.ShowAnnounceLog"missionAdd"
      gvars.mis_isExistOpenMissionFlag=false
    end
    TppQuest.ShowAnnounceLogQuestOpen()
  end
end
function this.SetHeroicAndOgrePointInSlot(missionHeroicPoint,missionOgrePoint)
  TppScriptVars.SetVarValueInSlot(TppDefine.SAVE_SLOT.MISSION_START,"vars","missionHeroicPoint",missionHeroicPoint)
  TppScriptVars.SetVarValueInSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,"vars","missionHeroicPoint",missionHeroicPoint)
  TppScriptVars.SetVarValueInSlot(TppDefine.SAVE_SLOT.MISSION_START,"vars","missionOgrePoint",missionOgrePoint)
  TppScriptVars.SetVarValueInSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,"vars","missionOgrePoint",missionOgrePoint)
end

--tex REWORKED
local idRangeToTypeCode={
  ["1"]="s",
  ["2"]="e",
  ["3"]="f",
  ["4"]="h",
  ["5"]="o",
}
function this._CreateMissionName(missionCode)
  local firstDigit=string.sub(tostring(missionCode),1,1)
  local missionTypeCode=idRangeToTypeCode[firstDigit]
  if missionTypeCode==nil then
    return nil
  end
  return missionTypeCode..tostring(missionCode)
end
--ORIG
--function this._CreateMissionName(missionCode)
--  local firstDigit=string.sub(tostring(missionCode),1,1)
--  local missionTypeCode
--  if(firstDigit=="1")then
--    missionTypeCode="s"
--  elseif(firstDigit=="2")then
--    missionTypeCode="e"
--  elseif(firstDigit=="3")then
--    missionTypeCode="f"
--  elseif(firstDigit=="4")then
--    missionTypeCode="h"
--  elseif(firstDigit=="5")then
--    missionTypeCode="o"
--  else
--    return nil
--  end
--  return missionTypeCode..tostring(missionCode)
--end
function this._PushReward(category,langId,rewardType)
  TppReward.Push{category=category,langId=langId,rewardType=rewardType}
end
return this

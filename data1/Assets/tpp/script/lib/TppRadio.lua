local this={}
local StrCode32=Fox.StrCode32
local TimerStart=GkEventTimerManager.Start
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local IsNumber=Tpp.IsTypeNumber
this.COMMON_GAME_OVER_RADIO_LIST={
  [TppDefine.GAME_OVER_RADIO.PLAYER_DEAD]="f8000_gmov0010",
  [TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA]="f8000_gmov0020",
  [TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA_HELI]="f8000_gmov0030",
  [TppDefine.GAME_OVER_RADIO.HELICOPTER_DESTROYED]="f8000_gmov0040",
  [TppDefine.GAME_OVER_RADIO.PLAYER_DESTROY_HELI]="f8000_gmov0050",
  [TppDefine.GAME_OVER_RADIO.RIDING_HELI_DESTROYED]="f8000_gmov0060",
  [TppDefine.GAME_OVER_RADIO.TARGET_DEAD]="f8000_gmov0110",
  [TppDefine.GAME_OVER_RADIO.PLAYER_KILL_TARGET]="f8000_gmov0120",
  [TppDefine.GAME_OVER_RADIO.PLAYER_KILL_TARGET_WOMAN]="f8000_gmov0123",
  [TppDefine.GAME_OVER_RADIO.PLAYER_KILL_CHILD_SOLDIER]="f8000_gmov0230",
  [TppDefine.GAME_OVER_RADIO.PLAYER_KILL_DD]="f8000_gmov2500",
  [TppDefine.GAME_OVER_RADIO.OTHERS]="f8000_gmov9090"
}
function this.IGNORE_COMMON_RADIO()
end
this.COMMON_RADIO_LIST={
  [TppDefine.COMMON_RADIO.ENEMY_RECOVERED]="f1000_rtrg0100",
  [TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED]="f1000_rtrg1550",
  [TppDefine.COMMON_RADIO.HOSTAGE_DEAD]="f1000_rtrg0110",
  [TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC]="f1000_rtrg0116",
  [TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE]="f1000_rtrg8050",
  [TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA]="f1000_rtrg0010",
  [TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT]="f1000_rtrg8040",
  [TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK]="f1000_rtrg8050",
  [TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE]="f1000_rtrg8030",
  [TppDefine.COMMON_RADIO.RETURN_HOTZONE]="f1000_rtrg8060",
  [TppDefine.COMMON_RADIO.ABORT_BY_HELI]="f1000_rtrg0030",
  [TppDefine.COMMON_RADIO.RECOMMEND_CURE]="f1000_rtrg0120",
  [TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN]="f1000_rtrg0130",
  [TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME]="f1000_rtrg0050",
  [TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE]="f1000_rtrg0070",
  [TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME]="f1000_rtrg0060",
  [TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]="f1000_rtrg0690",
  [TppDefine.COMMON_RADIO.RESULT_RANK_S]="f1000_rtrg9050",
  [TppDefine.COMMON_RADIO.RESULT_RANK_A]="f1000_rtrg9040",
  [TppDefine.COMMON_RADIO.RESULT_RANK_B]="f1000_rtrg9030",
  [TppDefine.COMMON_RADIO.RESULT_RANK_C]="f1000_rtrg9020",
  [TppDefine.COMMON_RADIO.RESULT_RANK_D]="f1000_rtrg9010",
  [TppDefine.COMMON_RADIO.RESULT_RANK_E]="f1000_rtrg9010",
  [TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED]="f1000_rtrg9020",
  [TppDefine.COMMON_RADIO.CALL_SUPPROT_BUDDY]="f1000_rtrg0060",
  [TppDefine.COMMON_RADIO.TARGET_MARKED]="f1000_rtrg2120",
  [TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED]="f1000_rtrg2171",
  [TppDefine.COMMON_RADIO.TARGET_RECOVERED]="f1000_rtrg1640",
  [TppDefine.COMMON_RADIO.TARGET_ELIMINATED]="f1000_rtrg1640",
  [TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT]="f1000_rtrg1680",
  [TppDefine.COMMON_RADIO.CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE]="f1000_rtrg4440",
  [TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE]="f1000_rtrg2020",
  [TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER]="f1000_rtrg5020",
  [TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI]="f1000_rtrg5021",
  [TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI]="f1000_rtrg3780",
  [TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END]="f1000_rtrg0090",
  [TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END_ENEMY_ATTACK]="f1000_rtrg1940",
  [TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER]="f1000_rtrg0080",
  [TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN]="f1000_rtrg1050",
  [TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS]="f1000_rtrg4520"}
this.COMMON_RADIO_DELAY_LIST={[TppDefine.COMMON_RADIO.ENEMY_RECOVERED]="long",
  [TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED]="long",
  [TppDefine.COMMON_RADIO.RECOMMEND_CURE]="mid",
  [TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN]="mid",
  [TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]="long",
  [TppDefine.COMMON_RADIO.TARGET_MARKED]="mid",
  [TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED]="mid",
  [TppDefine.COMMON_RADIO.TARGET_RECOVERED]="long",
  [TppDefine.COMMON_RADIO.TARGET_ELIMINATED]="long",
  [TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE]="long",
  [TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER]=8
}
function this.Messages()
  return Tpp.StrCode32Table{
    Radio={{msg="EspionageRadioPlay",func=this.DEBUG_PlayIntelRadio}},
    Timer={
      {msg="Finish",sender="debugRadioTimer",func=this._PlayDebugContinue},
      {msg="Finish",sender="debugRadioStartTimer",func=this._PlayDebugStart}
    },
    UI={{msg="GameOverOpen",func=this.PlayGameOverRadio,option={isExecGameOver=true}}},
    Terminal={{msg="MbDvcActSelectNonActiveMenu",func=this.PlaySelectBuddy}}}
end
this.SFXList={RadioStart="Play_sfx_s_codec_NPC_begin",RadioEnd="Play_sfx_s_codec_NPC_end"}
this.PRESET_DELAY_TIME={short=.5,mid=1.5,long=3}
function this.Play(radioGroups,playInfo)
  local playInfo=playInfo or{}
  local radioType=playInfo.radioType or"realtime"
  local isQue=playInfo.isEnqueue
  local preDelayTime=playInfo.delayTime
  local noiseType=playInfo.noiseType or"both"
  local priority=playInfo.priority
  local isPlayDebug=playInfo.playDebug
  local isOverwriteProtectionForSamePrio=playInfo.isOverwriteProtectionForSamePrio
  if IsString(preDelayTime)then
    preDelayTime=this.PRESET_DELAY_TIME[preDelayTime]
    if preDelayTime==nil then
      return
    end
  end
  if isPlayDebug then
    return
  end
  if TppStory.DEBUG_SkipDemoRadio then
    local stringOrTable=type(radioGroups)
    if stringOrTable=="table"then
      for n,radioName in pairs(radioGroups)do
        this.SetPlayedGlobalFlag(radioName)
      end
    elseif stringOrTable=="string"then
      this.SetPlayedGlobalFlag(radioGroups)
    end
    return
  end
  this.PlayCommon(radioGroups,radioType,isQue,isOverwriteProtectionForSamePrio,preDelayTime,noiseType,priority,isPlayDebug)
end
function this.SetOptionalRadio(e)
  if not IsString(e)then
    return
  end
  TppRadioCommand.RegisterRadioGroupSetOverwrite(e)
end
function this.SetTutorialOptionalRadio(e)
  if not IsString(e)then
    return
  end
  if TppRadioCommand.RegisterTutorialRadioGroupSet then
    TppRadioCommand.RegisterTutorialRadioGroupSet(e)
  end
end
function this.SetOverwriteByPhaseOptionalRadio(e)
  if not IsString(e)then
    return
  end
  if TppRadioCommand.RegisterOverwriteByPhaseRadioGroupSet then
    TppRadioCommand.RegisterOverwriteByPhaseRadioGroupSet(e)
  end
end
function this.UnsetTutorialOptionalRadio()
  if TppRadioCommand.UnregisterTutorialRadioGroupSet then
    TppRadioCommand.UnregisterTutorialRadioGroupSet()
  end
end
function this.UnsetOverwriteByPhaseOptionalRadio()
  if TppRadioCommand.UnregisterOverwriteByPhaseRadioGroupSet then
    TppRadioCommand.UnregisterOverwriteByPhaseRadioGroupSet()
  end
end
function this.ChangeIntelRadio(e)
  if not IsTable(e)then
    return
  end
  TppRadioCommand.RegisterEspionageRadioTable(e)
end
function this.RequestBlackTelephoneRadio(a)
  local a,i=this.GetRadioNameAndRadioIDs(a)
  SubtitlesCommand.SetIsEnabledUiPrioStrong(true)
  this.playingBlackTelInfo={radioGroups=i,radioName=a,[StrCode32(a)]=true}
end
function this.SetBlackTelephoneDisplaySetting(e)
  if not e then
    return
  end
  if not mvars.rad_blackTelephoneDisplaySetting then
    return
  end
  local e=mvars.rad_blackTelephoneDisplaySetting[e]
  if e then
    for a,e in ipairs(e)do
      TppUiCommand.BlackRadioCommand(e[1],e[2],e[3],e[4])
    end
  end
end
function this.DoEventOnRewardEndRadio()
  local e={}
  if(mvars.rad_rewardEndRadionList~=nil)then
    if Tpp.IsTypeTable(mvars.rad_rewardEndRadionList)then
      for n,a in ipairs(mvars.rad_rewardEndRadionList)do
        table.insert(e,a)
      end
    else
      return
    end
  end
  return e
end
function this.SaveRewardEndRadioList(e)
  mvars.rad_rewardEndRadionList=e
end
function this.IsPlayed(a)
  local a,n=this.GetRadioNameAndRadioIDs(a)
  local n
  if n then
    local e=this.DEBUG_GetRadioIndex(a)
    if e then
      return svars.rad_debugPlayedFlag[e]
    end
  else
    return TppRadioCommand.IsRadioGroupMarkAsRead(a)
  end
end
function this.SetPlayedLocalFlag(e)
  TppRadioCommand.EnableFlagIsMarkAsRead(e)
end
function this.UnsetPlayedLocalFlag(e)
  TppRadioCommand.DisableFlagIsMarkAsRead(e)
end
function this.SetPlayedGlobalFlag(e)
  if TppRadioCommand.EnableFlagIsMarkAsReadAndSaveToScriptVars~=nil then
    TppRadioCommand.EnableFlagIsMarkAsReadAndSaveToScriptVars(e)
  end
end
function this.UnsetPlayedGlobalFlag(e)
  if TppRadioCommand.DisableFlagIsMarkAsReadAndSaveToScriptVars~=nil then
    TppRadioCommand.DisableFlagIsMarkAsReadAndSaveToScriptVars(e)
  end
end
function this.IsRadioPlayable()
  local e=true
  if(SubtitlesCommand.IsPlayingSubtitles())then
    e=false
  end
  return e
end
function this.Stop()
  TppRadioCommand.StopDirect()SubtitlesCommand.StopAll()
end
function this.UnregisterRadioGroupSet()
  TppRadioCommand.UnregisterRadioGroupSetFromList()
end
function this.EnableCommonOptionalRadio(i)
  local r=TppStory.GetCurrentStorySequence()
  local a={
    [1]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,
    [2]=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,
    [3]=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO,
    [4]=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH
  }
  local n={
    [1]="Set_f1000_oprg0000",
    [2]="Set_f1000_oprg0000",
    [3]="Set_f1000_oprg0000",
    [4]="Set_f1000_oprg0000"
  }
  if(i)then
    for a,i in ipairs(a)do
      if(r>=i)then
        this.SetTutorialOptionalRadio(n[a])
      end
    end
  else
    this.UnsetTutorialOptionalRadio()
  end
end
function this.GetEspionageRadioTypeIndex(e)
  local a=-1
  if TppRadioCommand.GetEspionageRadioTypeIndex then
    return TppRadioCommand.GetEspionageRadioTypeIndex(e)
  end
  return-1
end
function this.PlayCommon(radioGroups,u_radioType,isQue,isOverwriteProtectionForSamePrio,preDelayTime,noiseType,u_priority,isPlayDebug)
  local mvars=mvars
  if not mvars.rad_radioPlayOnceList then
    return
  end
  local tableName,groupName=this.GetRadioNameAndRadioIDs(radioGroups)
  if mvars.rad_radioPlayOnceList[tableName]then
    if TppRadioCommand.IsRadioGroupMarkAsRead(tableName)then
      return
    end
  end
  if isPlayDebug then
    this.PlayDebug(groupName,preDelayTime)
    return
  end
  if isQue then
    TppRadioCommand.PlayDirectGroupTableEnqueue{tableName=tableName,groupName=groupName,preDelayTime=preDelayTime,noiseType=noiseType,isOverwriteProtectionForSamePrio=isOverwriteProtectionForSamePrio}
  else
    TppRadioCommand.PlayDirectGroupTable{tableName=tableName,groupName=groupName,preDelayTime=preDelayTime,noiseType=noiseType,isOverwriteProtectionForSamePrio=isOverwriteProtectionForSamePrio}
  end
end
function this.PlayDebug(a,n)
  local a,i=this.GetRadioNameAndRadioIDs(a)
  if(a==nil or mvars.rad_debugRadioLineTable[a]==nil)then
    return
  end
  if(GkEventTimerManager.IsTimerActive"debugRadioTimer"==true)then
    return
  end
  if(GkEventTimerManager.IsTimerActive"debugRadioStartTimer"==true)then
    return
  end
  mvars.rad_debugRadioGroupList=i
  mvars.rad_debugRadioGroupCount=1
  if n then
    TimerStart("debugRadioStartTimer",n)
  else
    this._PlayDebugStart()
  end
end
function this.PlayCommonRadio(r,o)
  if not IsNumber(r)then
    return
  end
  local n=this.GetPlayCommonTargetRadio(r)
  local r=this.GetCommonRadioDelay(r)or"short"local r={delayTime=r}
  if IsString(n)or IsTable(n)then
    if o then
      if this.IsPlayed(n)then
        return
      end
    end
    this.Play(n,r)
  elseif n==nil then
  end
end
function this.GetPlayCommonTargetRadio(e)
  local e=mvars.rad_commonRadioTable[e]
  local a=e
  if IsFunc(e)then
    a=e()
  end
  return a
end
function this.GetCommonRadioDelay(e)
  return mvars.rad_commonRadioDelayTable[e]
end
function this.CheckRadioGroupIsCommonRadio(n,a)
  local e=this.GetPlayCommonTargetRadio(TppDefine.COMMON_RADIO.CALL_SUPPROT_BUDDY)
  if not e then
    return
  end
  local a
  if Tpp.IsTypeTable(e)then
    a=Fox.StrCode32(e[1])
  else
    a=Fox.StrCode32(e)
  end
  if n==a then
    return true
  else
    return false
  end
end
function this.DeclareSVars()
  return{
    {name="rad_debugPlayedFlag",arraySize=200,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioReadFlagMissionScoped",arraySize=200,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_labelGroupReadFlagMissionScoped",arraySize=20,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioEspGmIdAssignInfoGmId",arraySize=260,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioEspGmIdAssignInfoGroupName",arraySize=260,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioEspEspTypeAssignInfoGroupName",arraySize=100,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptInsertInfoGroupSetName",arraySize=50,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptInsertInfoGroupName",arraySize=50,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptInsertInfoInsertIndex",arraySize=50,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptCurrentSetGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptCurrentTutorialGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rad_radioOptCurrentOverwriteByPhaseGroupSetName",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.OnAllocate(n)
  mvars.rad_subScripts=n
  mvars.rad_radioList={}
  mvars.rad_debugRadioLineTable={}
  mvars.rad_optionalRadioList={}
  mvars.rad_intelRadioList={}
  mvars.rad_gameOverRadioTable={}
  mvars.rad_commonRadioTable={}
  mvars.rad_commonRadioDelayTable={}
  for e,a in pairs(this.COMMON_GAME_OVER_RADIO_LIST)do
    mvars.rad_gameOverRadioTable[e]=a
  end
  for e,a in pairs(this.COMMON_RADIO_LIST)do
    mvars.rad_commonRadioTable[e]=a
  end
  for e,a in pairs(this.COMMON_RADIO_DELAY_LIST)do
    mvars.rad_commonRadioDelayTable[e]=a
  end
  local n=n.radio
  if not n then
    return
  end
  local i=n.gameOverRadioTable
  if i then
    for e,a in pairs(i)do
      mvars.rad_gameOverRadioTable[e]=a
    end
  end
  local i=n.debugRadioLineTable
  if i then
    for a,e in pairs(i)do
      mvars.rad_debugRadioLineTable[a]=e
    end
  end
  if IsTable(n.radioList)then
    this.RegisterRadioList(n.radioList)
  end
  if IsTable(n.optionalRadioList)then
    this.RegisterOptionalRadioList(n.optionalRadioList)
  end
  if IsTable(n.intelRadioList)then
    this.RegisterIntelRadioList(n.intelRadioList)
  end
  if n.USE_COMMON_RESULT_RADIO then
    mvars.rad_useCommonResultRadio=true
  end
  local i=n.blackTelephoneDisplaySetting
  if IsTable(i)then
    mvars.rad_blackTelephoneDisplaySetting={}
    for n,e in pairs(i)do
      if not IsTable(e.Japanese)then
      end
      if not IsTable(e.English)then
      end
      if TppGameSequence.GetTargetArea()=="Japan"then
        mvars.rad_blackTelephoneDisplaySetting[n]=e.Japanese
      else
        mvars.rad_blackTelephoneDisplaySetting[n]=e.English
      end
    end
  end
  local a=n.commonRadioTable
  if a then
    this.OverwriteCommonRadioTable(a)
  end
end
function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  TppTutorial.SetIntelRadio()
  if mvars.rad_intelRadioList then
    TppRadioCommand.RegisterEspionageRadioTable(mvars.rad_intelRadioList)
  end
  local noOptionalRadioTable={
    [10010]=true,[10020]=true,[10030]=true,[10050]=true,[10115]=true,[10140]=true,[10151]=true,[10230]=true,[10240]=true,[10260]=true,[10280]=true,
    [30050]=true,[30150]=true,[30250]=true,[40010]=true,[40020]=true,[40050]=true,[50050]=true,[6e4]=true}
  local a=noOptionalRadioTable[vars.missionCode]
  if a then
  else
    this.EnableCommonOptionalRadio(true)
  end
end
function this.OnReload(a)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.OnAllocate(a)
  local a=_G.TppRadio.playingBlackTelInfo
  if a then
    this.playingBlackTelInfo=a
  end
end
function this.CommonMakeRadioList(e)
  local t={}
  local d={}
  for r,e in pairs(e)do
    if type(r)=="number"then
      local r
      local o
      if IsTable(e)then
        if not IsString(e[1])then
        else
          r=e[1]o=e.playOnce
        end
      elseif IsString(e)then
        r=e
        o=false
      end
      t[StrCode32(r)]=r
      d[r]=o
    end
  end
  return t,d
end
function this.RegisterRadioList(o)
  for n,e in pairs(o)do
    if IsTable(e)then
      mvars.rad_radioList[n]={}
      for i,e in pairs(e)do
        local r=type(i)
        if r=="number"then
          mvars.rad_radioList[n]=e
        elseif r=="string"and IsTable(e)then
          mvars.rad_debugRadioLineTable[i]=e
        end
      end
    else
      mvars.rad_radioList[n]=e
    end
  end
  mvars.rad_radioInvList,mvars.rad_radioPlayOnceList=this.CommonMakeRadioList(o)
end
function this.AddDebugRadioLineTable(e)
  if not Tpp.IsTypeTable(e)then
    return
  end
  for e,a in pairs(e)do
    mvars.rad_debugRadioLineTable[e]=a
  end
end
function this.RegisterOptionalRadioList(a)
  for a,e in pairs(a)do
    mvars.rad_optionalRadioList[a]=e
  end
  mvars.rad_optionalRadioInvList,mvars.rad_optionalRadioPlayOnceList=this.CommonMakeRadioList(a)
end
function this.RegisterIntelRadioList(e)
  if next(e)==nil then
    return
  end
  for a,e in pairs(e)do
    mvars.rad_intelRadioList[a]=e
  end
end
function this.OverwriteCommonRadioTable(e)
  if not IsTable(e)then
    return
  end
  for n,e in pairs(e)do
    if(IsString(e)or IsTable(e))or IsFunc(e)then
      mvars.rad_commonRadioTable[n]=e
    end
  end
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.PlayGameOverRadio()
  local a
  local n
  if svars.mis_gameOverRadio>0 and TppDefine.GAME_OVER_RADIO.MAX then
    n=svars.mis_gameOverRadio
  end
  if n==nil then
    n=TppDefine.GAME_OVER_RADIO.OTHERS
  end
  a=mvars.rad_gameOverRadioTable[n]
  if a==nil then
    a=mvars.rad_gameOverRadioTable[TppDefine.GAME_OVER_RADIO.OTHERS]
  end
  SubtitlesCommand.SetIsEnabledUiPrioStrong(true)
  this.Play(a,{noiseType="none"})
end
local i={[TppDefine.MISSION_CLEAR_RANK.S]=TppDefine.COMMON_RADIO.RESULT_RANK_S,[TppDefine.MISSION_CLEAR_RANK.A]=TppDefine.COMMON_RADIO.RESULT_RANK_A,[TppDefine.MISSION_CLEAR_RANK.B]=TppDefine.COMMON_RADIO.RESULT_RANK_B,[TppDefine.MISSION_CLEAR_RANK.C]=TppDefine.COMMON_RADIO.RESULT_RANK_C,[TppDefine.MISSION_CLEAR_RANK.D]=TppDefine.COMMON_RADIO.RESULT_RANK_D,[TppDefine.MISSION_CLEAR_RANK.E]=TppDefine.COMMON_RADIO.RESULT_RANK_E,[TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED]=TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED}
function this.PlayResultRadio()
  local a=i[svars.bestRank]
  if not a then
    return
  end
  if svars.bestRank==TppDefine.MISSION_CLEAR_RANK.S then
    if svars.bestScoreKill>0 then
      a=i[TppDefine.MISSION_CLEAR_RANK.B]
    end
  end
  this.PlayCommonRadio(a)
end
function this.DEBUG_PlayIntelRadio(a)do
  return
end
local a=mvars.rad_radioInvList[a]
if a==nil then
  return
end
if mvars.rad_debugRadioLineTable[a]then
  this.Play(a)
end
end
function this.DEBUG_GetRadioIndex(n)
  if next(mvars.rad_radioList)==nil then
    return
  end
  for a,e in pairs(mvars.rad_radioList)do
    if n==e then
      return a
    end
  end
end
function this.OnFinishBlackTelephoneRadio(a)
  if not this.playingBlackTelInfo then
    return
  end
  if this.playingBlackTelInfo[a]then
    SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
    this.playingBlackTelInfo=nil
    TppMission.ExecuteSystemCallback"OnFinishBlackTelephoneRadio"
  end
end
function this.GetRadioNameAndRadioIDs(e)
  if type(e)=="string"then
    return e,{e}
  else
    return e[1],e
  end
end
function this._PlayDebugStart()
end
function this._PlayDebugContinue()
  do
    return
  end
  local a=mvars
  if(a.rad_debugRadioGroupLine<=#a.rad_debugRadioLineTable[a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]])then
    local i=a.rad_debugRadioLineTable[a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]][a.rad_debugRadioGroupLine]
    local n=math.ceil(string.len(i)*.333333333333333)*.2
    n=math.max(n,.8)
    this._PlayDebugLine(i,n)
    local e=.2
    TimerStart("debugRadioTimer",n+e)
    if a.rad_debugRadioGroupLine==1 then
      if WaveControl then
        local e="Z:/tpp/release/sound/ld_prepro_voice/"..(TppMission.GetMissionName().."/")
        local a=a.rad_debugRadioGroupList[a.rad_debugRadioGroupCount]..".wav"
        local e=e..a
        if Asset~=nil and Asset.Exists(e)then
          WaveControl.PlayWaveFile(e)
        end
      end
    end
    a.rad_debugRadioGroupLine=a.rad_debugRadioGroupLine+1
  elseif a.rad_debugRadioGroupCount<#a.rad_debugRadioGroupList then
    a.rad_debugRadioGroupCount=a.rad_debugRadioGroupCount+1
    a.rad_debugRadioGroupLine=1
    this._PlayDebugContinue()
  else
    if SoundCommand then
      SoundCommand.PostEvent(this.SFXList.RadioEnd)
    end
    local i=a.rad_debugRadioGroupList[1]a.rad_debugRadioGroupList=nil
    a.rad_debugRadioGroupCount=1
    local e=this.DEBUG_GetRadioIndex(i)
    if e then
      svars.rad_debugPlayedFlag[e]=true
    end
    local strLogText="sender:Radio messageId:Finish arg0:"..i
    TppSequence.OnMessage(StrCode32"Radio",StrCode32"Finish",StrCode32(i),nil,nil,nil,strLogText)
    TppMission.OnMessage(StrCode32"Radio",StrCode32"Finish",StrCode32(i),nil,nil,nil,strLogText)
    for r,o in pairs(a.rad_subScripts)do
      if a.rad_subScripts[r]._messageExecTable then
        Tpp.DoMessage(a.rad_subScripts[r]._messageExecTable,TppMission.CheckMessageOption,StrCode32"Radio",StrCode32"Finish",StrCode32(i),nil,nil,nil,strLogText)
      end
    end
    TppFreeHeliRadio.OnMessage(StrCode32"Radio",StrCode32"Finish",StrCode32(i),nil,nil,nil,strLogText)
  end
end
function this._PlayDebugLine(e,a)
  SubtitlesCommand.DisplayText(e,"Default",a*1e3)
end
function this.PlaySelectBuddy(a)
  if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_FORCE_HOSPITALIZE)then
    if(a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_SCOUT)or a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_ATTACK))or a==Fox.StrCode32(TppTerminal.MBDVCMENU.MSN_BUDDY_QUIET_DISMISS)then
      this.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE)
    end
  end
end
function this.SetGameOverRadio(a,e)
  mvars.rad_gameOverRadioTable[a]=e
end
return this

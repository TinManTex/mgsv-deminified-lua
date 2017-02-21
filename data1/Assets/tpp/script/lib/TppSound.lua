-- TppSound.lua
local this={}
local StrCode32=Fox.StrCode32
local n=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
this.ResultRankJingle={
  "Set_Switch_bgm_jingle_result_s",
  "Set_Switch_bgm_jingle_result_ab",
  "Set_Switch_bgm_jingle_result_ab",
  "Set_Switch_bgm_jingle_result_cd",
  "Set_Switch_bgm_jingle_result_cd",
  "Set_Switch_bgm_jingle_result_e"
}
this.ResultRankJingle[TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED]="Set_Switch_bgm_jingle_result_cd"
this.afghCommonEsacapeBgm={bgm_escape={start="Play_bgm_afgh_mission_escape",finish="Stop_bgm_afgh_mission_escape"}}
this.mafrCommonEsacapeBgm={bgm_escape={start="Play_bgm_mafr_mission_escape",finish="Stop_bgm_mafr_mission_escape"}}
this.commonHeliStartBgm={bgm_heliStart={start="Play_bgm_mission_start",finish="Stop_bgm_mafr_mission_escape"}}
function this.SetSceneBGM(a)
  if not IsTypeTable(mvars.snd_bgmList)then
    return
  end
  local n=mvars.snd_bgmList[a]
  if not n then
    return
  end
  local currentSceneBgmSetting=this.GetCurrentSceneBgmSetting()
  if currentSceneBgmSetting and currentSceneBgmSetting.finish then
    TppMusicManager.PostSceneSwitchEvent(currentSceneBgmSetting.finish)
  end
  if n.start then
    svars.snd_bgmSwitchNameHash=0
    svars.snd_bgmNameHash=StrCode32(a)
    TppMusicManager.StartSceneMode()
    TppMusicManager.PlaySceneMusic(n.start)
  end
end
function this.SetSceneBGMSwitch(e)
  if not mvars.snd_bgmSwitchTable[e]then
    return
  end
  svars.snd_bgmSwitchNameHash=StrCode32(e)
  TppMusicManager.PostSceneSwitchEvent(e)
end
function this.StopSceneBGM()
  local currentSceneBgmSetting=this.GetCurrentSceneBgmSetting()
  if not currentSceneBgmSetting then
    return
  end
  if currentSceneBgmSetting.finish then
    TppMusicManager.PostSceneSwitchEvent(currentSceneBgmSetting.finish)
  end
  this.HaltSceneBGM()
end
function this.RestoreSceneBGM()
  local n,s=this.GetCurrentSceneBgmSetting()
  if not n then
    return
  end
  local i=n.start
  if n.restore then
    s=n.restore
  end
  if i then
    TppMusicManager.StartSceneMode()
    TppMusicManager.PlaySceneMusic(i)
    if s then
      TppMusicManager.PostSceneSwitchEvent(s)
    end
  else
    this.HaltSceneBGM()
  end
end
function this.HaltSceneBGM()
  TppMusicManager.EndSceneMode()
  svars.snd_bgmNameHash=0
  svars.snd_bgmSwitchNameHash=0
end
function this.SetPhaseBGM(e)
  if not IsTypeString(e)then
    return
  end
  svars.snd_phaseBgmTagHash=StrCode32(e)
  TppMusicManager.ChangeParameter(e)
end
local n=0
function this.ResetPhaseBGM()
  TppMusicManager.ClearParameter()
  if svars and svars.snd_phaseBgmTagHash then
    svars.snd_phaseBgmTagHash=n
  end
end
function this.RestorePhaseBGM()
  if mvars.snd_noRestorePhaseBGM and mvars.snd_noRestorePhaseBGM[svars.snd_phaseBgmTagHash]then
    svars.snd_phaseBgmTagHash=n
  end
  if svars.snd_phaseBgmTagHash==n then
    TppMusicManager.ClearParameter()
  else
    TppMusicManager.ChangeParameterById(svars.snd_phaseBgmTagHash)
  end
end
function this.PostEventForFultonRecover()
  local e=TppMission.GetMissionStartRecoverDemoType()
  if(e==TppDefine.MISSION_START_RECOVER_DEMO_TYPE.WALKER_GEAR or e==TppDefine.MISSION_START_RECOVER_DEMO_TYPE.VEHICLE)or e==TppDefine.MISSION_START_RECOVER_DEMO_TYPE.NONE then
    TppSoundDaemon.PostEvent("sfx_m_fulton_heli_success","Loading")
  end
end
function this.SetHelicopterStartSceneBGM()
  mvars.snd_usingHelicopterStartBgm=true
  this.SetSceneBGM"bgm_heliStart"
end
function this.StopHelicopterStartSceneBGM()
  if mvars.snd_usingHelicopterStartBgm then
    mvars.snd_usingHelicopterStartBgm=nil
    this.StopSceneBGM()
  end
end
function this.StartEscapeBGM()
  if svars.snd_phaseBgmTagHash==n then
    this.SetPhaseBGM"bgm_chase_phase"
  end
end
function this.StopEscapeBGM()
  if svars.snd_phaseBgmTagHash==StrCode32"bgm_chase_phase"then
    this.ResetPhaseBGM()
  end
end
function this.SkipDecendingLandingZoneJingle()
  mvars.snd_skipDecendingLandingZoneClearJingle=true
end
function this.SkipDecendingLandingZoneWithOutCanMissionClearJingle()
  mvars.snd_skipDecendingLandingZoneWithOutCanMissionClearJingle=true
end
function this.Messages()
  return nil
end
function this.DeclareSVars()
  return{
    {name="snd_bgmNameHash",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="snd_bgmSwitchNameHash",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="snd_phaseBgmTagHash",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil}
end
function this.OnAllocate(missionTable)
  if(vars.missionCode==30010)or(vars.missionCode==30020)then
    mvars.snd_bgmList={}
    mvars.snd_bgmList.bgm_heliStart={start="Play_bgm_sideop_start",finish="Stop_bgm_sideop_start"}
  end
  local a={[30150]=true,[30250]=true}
  if a[vars.missionCode]then
    mvars.snd_bgmList={}
    mvars.snd_bgmList.bgm_heliStart={start="Play_bgm_mtbs_free_start",finish="Stop_bgm_mtbs_free_start"}
  end
  if not missionTable.sound then
    mvars.snd_startHeliClearJingleName="Play_bgm_mission_clear_heli"
    mvars.snd_finishHeliClearJingleName="Stop_bgm_mission_clear_heli"
    return
  end
  if IsTypeTable(missionTable.sound.bgmList)then
    mvars.snd_bgmList=missionTable.sound.bgmList
    if missionTable.sound.USE_COMMON_ESCAPE_BGM then
      if TppLocation.IsAfghan()then
        mvars.snd_bgmList.bgm_escape=this.afghCommonEsacapeBgm.bgm_escape
      elseif TppLocation.IsMiddleAfrica()then
        mvars.snd_bgmList.bgm_escape=this.mafrCommonEsacapeBgm.bgm_escape
      end
    end
    mvars.snd_bgmList.bgm_heliStart=mvars.snd_bgmList.bgm_heliStart or this.commonHeliStartBgm.bgm_heliStart
    mvars.snd_bgmSwitchTable={}
    for n,e in pairs(mvars.snd_bgmList)do
      local e=e.switch
      if IsTypeTable(e)then
        for n,e in ipairs(e)do
          local n=StrCode32(e)
          mvars.snd_bgmSwitchTable[n]=e
          mvars.snd_bgmSwitchTable[e]=n
        end
      end
    end
  end
  if IsTypeString(missionTable.sound.missionStartTelopJingleName)then
    mvars.snd_missionStartTelopJingleName=missionTable.sound.missionStartTelopJingleName
  end
  if IsTypeTable(missionTable.sound.noRestorePhaseBGMList)then
    mvars.snd_noRestorePhaseBGM={}
    for n,e in ipairs(missionTable.sound.noRestorePhaseBGMList)do
      mvars.snd_noRestorePhaseBGM[StrCode32(e)]=true
    end
  end
  if Tpp.IsTypeString(missionTable.sound.showCreditJingleName)then
    mvars.snd_showCreditJingle=missionTable.sound.showCreditJingleName
  else
    mvars.snd_showCreditJingle="Set_Switch_bgm_jingle_result_credit"
  end
  if Tpp.IsTypeString(missionTable.sound.heliDescentJingleName)then
    mvars.snd_heliDescentJingle=missionTable.sound.heliDescentJingleName
  else
    mvars.snd_heliDescentJingle="Play_bgm_mission_heli_descent"
  end
  if Tpp.IsTypeString(missionTable.sound.startHeliClearJingleName)then
    mvars.snd_startHeliClearJingleName=missionTable.sound.startHeliClearJingleName
  else
    mvars.snd_startHeliClearJingleName="Play_bgm_mission_clear_heli"
  end
  if Tpp.IsTypeString(missionTable.sound.finishHeliClearJingleName)then
    mvars.snd_finishHeliClearJingleName=missionTable.sound.finishHeliClearJingleName
  else
    mvars.snd_finishHeliClearJingleName="Stop_bgm_mission_clear_heli"
  end
end
function this.OnReload(missionTable)
  this.OnAllocate(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Init()
  this.RestoreSceneBGM()
  this.RestorePhaseBGM()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.GetCurrentSceneBgmSetting()
  local snd_bgmNameHash=svars.snd_bgmNameHash
  local snd_bgmSwitchNameHash=svars.snd_bgmSwitchNameHash
  local e
  local i,n
  if snd_bgmNameHash>0 then
    for n,a in pairs(mvars.snd_bgmList)do
      if snd_bgmNameHash==StrCode32(n)then
        e=n
        i=a
        break
      end
    end
    if not e then
      return
    end
  end
  if e and snd_bgmSwitchNameHash>0 then
    local switch=mvars.snd_bgmList[e].switch
    if switch then
      for i,e in pairs(switch)do
        if snd_bgmSwitchNameHash==StrCode32(e)then
          n=e
          break
        end
      end
      if not n then
      end
    else
      return
    end
  end
  return i,n
end
function this.SetMuteOnLoading()
  TppSoundDaemon.SetMute"Loading"
end
function this.PostJingleOnGameOver()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")
end
function this.PostJingleOnEstablishMissionClear()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")
end
function this.PostJingleOnCanMissionClear()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_achieved")
end
function this.ClearOnDecendingLandingZoneJingleFlag()
  mvars.snd_doneDecendingLandingZoneJingle=nil
  mvars.snd_doneDecendingLandingZoneJingleWithOutCanMissionClear=nil
end
function this.PostJingleOnDecendingLandingZone()
  local noJingleMissions={[30050]=true,[30150]=true,[30250]=true}
  if noJingleMissions[vars.missionCode]then
    return
  end
  if mvars.snd_doneDecendingLandingZoneJingle then
    return
  end
  if mvars.snd_skipDecendingLandingZoneClearJingle then
  else
    TppMusicManager.PostJingleEvent("SingleShot",mvars.snd_heliDescentJingle)
  end
  mvars.snd_doneDecendingLandingZoneJingle=true
end
function this.PostJingleOnDecendingLandingZoneWithOutCanMissionClear()
  local noJingleMissions={[30050]=true,[30150]=true,[30250]=true}
  if noJingleMissions[vars.missionCode]then
    return
  end
  if mvars.snd_doneDecendingLandingZoneJingleWithOutCanMissionClear then
    return
  end
  if mvars.snd_skipDecendingLandingZoneWithOutCanMissionClearJingle then
  else
    TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_mission_heli_descent_short")
  end
  mvars.snd_doneDecendingLandingZoneJingleWithOutCanMissionClear=true
end
function this.StartJingleOnClearHeli()
  if(mvars.snd_startHeliClearJingleName~="")and(not mvars.snd_playingHeliClearJingleName)then
    mvars.snd_playingHeliClearJingleName=true
    TppMusicManager.PostJingleEvent("MissionEnd",mvars.snd_startHeliClearJingleName)
  end
end
function this.SetStartHeliClearJingleName(e)
  if Tpp.IsTypeString(e)then
    mvars.snd_startHeliClearJingleName=e
  end
end
function this.EndJingleOnClearHeli()
  mvars.snd_playingHeliClearJingleName=nil
  TppMusicManager.PostJingleEvent("MissionEnd",mvars.snd_finishHeliClearJingleName)
end
function this.SetFinishHeliClearJingleName(jingleName)
  if Tpp.IsTypeString(jingleName)then
    mvars.snd_finishHeliClearJingleName=jingleName
  end
end
function this.PostEventOnForceGotMbHelicopter()
  TppSoundDaemon.PostEvent("sfx_m_heli_fly_return","Loading")
end
function this.PostJingleOnMissionStartTelop()
  if mvars.snd_missionStartTelopJingleName then
    TppMusicManager.PostJingleEvent("RegisterMissionStart",mvars.snd_missionStartTelopJingleName)
    return
  end
  if TppStory.IsMainMission()then
    TppMusicManager.PostJingleEvent("RegisterMissionStart","Play_bgm_common_jingle_op")
  elseif TppLocation.IsAfghan()then
    TppMusicManager.PostJingleEvent("RegisterMissionStart","Play_bgm_afgh_jingle_op")
  elseif TppLocation.IsMiddleAfrica()then
    TppMusicManager.PostJingleEvent("RegisterMissionStart","Play_bgm_mafr_jingle_op")
  else
    TppMusicManager.PostJingleEvent("RegisterMissionStart","Play_bgm_common_jingle_op")
  end
end
function this.SafeStopAndPostJingleOnShowResult()
  this.StopSceneBGM()
  TppMusicManager.StopMusicPlayer(1e3)
  TppMusicManager.StopHeliMusic()
  if vars.missionCode~=50050 then
    if vars.missionCode==10151 then
      TppMusicManager.PostJingleEvent("MissionEnd","Play_bgm_s10151_jingle_ed")
    else
      TppMusicManager.PostJingleEvent("MissionEnd","Play_bgm_common_jingle_ed")
    end
  end
  TppSoundDaemon.SetMute"Result"
end
function this.PostJingleStartResultPresentation(rank)
  if vars.missionCode==50050 then
    return
  end
  local jingleName=this.ResultRankJingle[rank]
  if jingleName==nil then
    jingleName=this.ResultRankJingle[TppDefine.MISSION_CLEAR_RANK.C]
  end
  if vars.missionCode~=10260 then
    TppMusicManager.PostJingleEvent("SingleShot",jingleName)
  end
  local radioGroups={}
  if TppRadio.playingBlackTelInfo and TppRadio.playingBlackTelInfo.radioGroups then
    radioGroups=TppRadio.playingBlackTelInfo.radioGroups
  end
  TppUiCommand.SetResultSound(mvars.snd_showCreditJingle,radioGroups[1],radioGroups[2],radioGroups[3],radioGroups[4])
  for index=1,4 do
    TppRadio.SetBlackTelephoneDisplaySetting(radioGroups[index])
  end
end
function this.PostJingleOnStartBlackTelephoneSequence()
  TppMusicManager.PostJingleEvent("SingleShot","Set_Switch_bgm_jingle_result_kaz")
end
function this.PostJingleOnEndBlackTelephoneSequence()
  TppMusicManager.PostJingleEvent("SingleShot","Stop_bgm_common_jingle_ed")
end
return this

local this={}
local t={"tp_m_10020_03","tp_m_10020_04","tp_m_10020_05","tp_m_10020_06","tp_m_10020_12","tp_m_10280_11","tp_c_00000_03"}
local missionClearTapes={}
missionClearTapes[10010]={"tp_m_10010_01","tp_m_10010_02","tp_m_10010_03","tp_m_10010_05","tp_m_10010_06","tp_m_10010_07","tp_m_10010_10","tp_m_10110_03","tp_bgm_11_32"}
missionClearTapes[10020]={"tp_m_10020_01","tp_m_10020_02","tp_m_10280_11"}
missionClearTapes[10030]={"tp_m_10010_04","tp_m_10010_08","tp_m_10010_09"}
missionClearTapes[10036]=t
missionClearTapes[10043]=t
missionClearTapes[10033]={"tp_m_10020_03","tp_m_10020_04","tp_m_10020_05","tp_m_10020_06","tp_m_10020_12","tp_m_10280_11","tp_c_00000_14","tp_c_00000_03"}
missionClearTapes[10040]={"tp_m_10040_03","tp_c_00000_12"}
missionClearTapes[10041]={}
missionClearTapes[10044]={}
missionClearTapes[10052]={}
missionClearTapes[10054]={}
missionClearTapes[10050]={}
missionClearTapes[10070]={"tp_m_10070_03","tp_m_10070_04","tp_m_10070_05","tp_m_10070_06","tp_m_10070_08"}
missionClearTapes[10080]={"tp_m_10070_01","tp_m_10070_02","tp_m_10070_07"}
missionClearTapes[10086]={}
missionClearTapes[10082]={}
missionClearTapes[10090]={"tp_m_10090_01","tp_c_00000_10"}
missionClearTapes[10195]={}
missionClearTapes[10091]={"tp_m_10090_02","tp_m_10090_03"}
missionClearTapes[10100]={}
missionClearTapes[10110]={"tp_m_10110_01","tp_m_10110_02"}
missionClearTapes[10121]={}
missionClearTapes[10115]={}
missionClearTapes[10120]={"tp_m_10120_03"}
missionClearTapes[10085]={}
missionClearTapes[10200]={}
missionClearTapes[10211]={}
missionClearTapes[10081]={}
missionClearTapes[10130]={"tp_m_10130_00"}
missionClearTapes[10140]={"tp_m_10140_01","tp_m_10140_02","tp_m_10140_03","tp_m_10140_04","tp_m_10140_07"}
missionClearTapes[10150]={}
missionClearTapes[10151]={"tp_m_10150_01","tp_m_10150_02","tp_m_10150_05","tp_m_10150_06","tp_m_10150_07","tp_m_10150_08","tp_m_10150_19","tp_m_10150_27","tp_c_00000_05"}
missionClearTapes[10045]={"tp_m_10150_03","tp_m_10150_04","tp_m_10150_10","tp_m_10150_18","tp_m_10150_26","tp_m_10150_31","tp_c_00001_01"}
missionClearTapes[10156]={"tp_m_10156_01","tp_m_10156_02","tp_m_10156_03","tp_c_00001_03"}
missionClearTapes[10093]={"tp_m_10093_01","tp_m_10093_02","tp_m_10093_03","tp_m_10093_04","tp_m_10093_05","tp_m_10150_14","tp_m_10150_28","tp_c_00001_02"}
missionClearTapes[10171]={"tp_c_00001_04","tp_m_10150_11","tp_m_10150_12"}
missionClearTapes[10240]={"tp_m_10240_01","tp_m_10240_02"}
missionClearTapes[10260]={"tp_m_10260_03"}
missionClearTapes[10280]={"tp_m_10150_13","tp_m_10280_02","tp_m_10280_03","tp_m_10280_08","tp_m_10280_09","tp_m_10280_10","tp_m_10280_12","tp_m_10280_13","tp_m_10280_14","tp_m_10280_15","tp_m_10280_16","tp_m_10280_17"}
missionClearTapes[10230]={}
local missionOpenTapes={}
missionOpenTapes[10010]={}
missionOpenTapes[10020]={}
missionOpenTapes[10030]={"tp_m_10030_00"}
missionOpenTapes[10036]={"tp_m_10036_00"}
missionOpenTapes[10043]={"tp_m_10043_00"}
missionOpenTapes[10033]={"tp_m_10033_00"}
missionOpenTapes[10040]={"tp_m_10040_00"}
missionOpenTapes[10041]={"tp_m_10041_00"}
missionOpenTapes[10044]={"tp_m_10044_00"}
missionOpenTapes[10052]={"tp_m_10052_00"}
missionOpenTapes[10054]={"tp_m_10054_00"}
missionOpenTapes[10050]={}
missionOpenTapes[10070]={"tp_m_10070_00"}
missionOpenTapes[10080]={"tp_m_10100_02"}
missionOpenTapes[10086]={"tp_m_10086_00"}
missionOpenTapes[10082]={"tp_m_10082_00"}
missionOpenTapes[10090]={"tp_m_10090_00"}
missionOpenTapes[10195]={"tp_m_10195_00"}
missionOpenTapes[10091]={"tp_m_10091_00"}
missionOpenTapes[10100]={"tp_m_10100_00"}
missionOpenTapes[10110]={"tp_m_10110_00"}
missionOpenTapes[10121]={"tp_m_10121_00"}
missionOpenTapes[10115]={"tp_m_10115_00"}
missionOpenTapes[10120]={"tp_m_10120_00"}
missionOpenTapes[10085]={"tp_m_10085_00"}
missionOpenTapes[10200]={"tp_m_10200_00"}
missionOpenTapes[10211]={"tp_m_10211_00"}
missionOpenTapes[10081]={"tp_m_10081_00"}
missionOpenTapes[10130]={"tp_m_10130_00"}
missionOpenTapes[10140]={"tp_m_10140_00"}
missionOpenTapes[10150]={"tp_m_10150_00"}
missionOpenTapes[10151]={"tp_m_10151_00"}
missionOpenTapes[10045]={"tp_m_10045_00"}
missionOpenTapes[10156]={"tp_m_10156_00"}
missionOpenTapes[10093]={"tp_m_10093_00"}
missionOpenTapes[10171]={"tp_m_10171_00"}
missionOpenTapes[10240]={"tp_m_10240_00"}
missionOpenTapes[10260]={"tp_m_10260_00"}
missionOpenTapes[10280]={}
missionOpenTapes[10230]={}
local buddyTapesAquire={
  [BuddyType.QUIET]=function()
    local cassetteList={"tp_c_00000_02"}
    local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)
    if t>60 then
      table.insert(cassetteList,"tp_sp_01_04")
    end
    this.Acquire{cassetteList=cassetteList,pushReward=true}
  end,
  [BuddyType.DOG]=function()
    this.Acquire{cassetteList={"tp_c_00000_01"},pushReward=true}
  end
}
function this.Acquire(t)
  local cassetteList,isShowAnnounceLog,pushReward
  if Tpp.IsTypeTable(t)then
    cassetteList=t.cassetteList
    isShowAnnounceLog=t.isShowAnnounceLog
    pushReward=t.pushReward
  end
  for e,t in ipairs(cassetteList)do
    if not TppMotherBaseManagement.IsGotCassetteTapeTrack(t)then
      TppMotherBaseManagement.AddCassetteTapeTrack(t)
      if pushReward then
        local langId=TppUiCommand.GetTapeLangIdByTrackId(t)
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.CASSET_TAPE,arg1=langId}
      end
      if isShowAnnounceLog then
        local delay
        if Tpp.IsTypeTable(isShowAnnounceLog)then
          delay=isShowAnnounceLog.delayTimeSec
        end
        TppUI.ShowAnnounceLog("get_tape",t,nil,delay)
      end
    end
  end
end
function this.AcquireOnMissionClear(t)
  local _=missionClearTapes[t]
  if _ then
    this.Acquire{cassetteList=_,pushReward=true}
  end
  local buddyTapes=buddyTapesAquire[vars.buddyType]
  if buddyTapes then
    buddyTapes()
  end
  if TppTerminal.IsReleaseSection"BaseDev"then
    this.Acquire{cassetteList={"tp_m_10020_07","tp_m_10020_08","tp_m_10020_09","tp_m_10020_10","tp_m_10020_11"},pushReward=true}
  end
end
function this.AcquireOnMissionOpen(missionCode)
  local tapes=missionOpenTapes[missionCode]
  if tapes then
    this.Acquire{cassetteList=tapes,pushReward=true}
  end
end
function this.AcquireOnPickUp(_)
  Gimmick.NotifyOfTakingCassette(_)
  TppMotherBaseManagement.AddCassetteTapeTrackByIndex(_)
  local _=TppUiCommand.GetTrackLangIdBySaveIndex(_)
  TppUI.ShowAnnounceLog("get_tape",_)
end
function this.OnEstablishMissionClear()
  local missionCode=TppMission.GetMissionID()
  if missionCode==10260 then
    local tapeName="tp_c_00000_16"
    if not TppMotherBaseManagement.IsGotCassetteTapeTrack(tapeName)then
      this.Acquire{cassetteList={tapeName},pushReward=true}
    end
  end
  if TppRadio.IsPlayed"f2000_rtrg8400"then
    local tapeName="tp_m_10190_04"
    if not TppMotherBaseManagement.IsGotCassetteTapeTrack(tapeName)and TppBuddy2BlockController.DidObtainBuddyType(BuddyType.DOG)then
      this.Acquire{cassetteList={tapeName},pushReward=true}
    end
  end
end
function this.OnEnterFreeHeliPlay()
  local _=TppStory.GetCurrentStorySequence()
  if TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_VISIT_MISSION)or TppQuest.IsCleard"mtbs_q99011"then
    this.Acquire{cassetteList={"tp_m_10050_02"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_06"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if _>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR then
    this.Acquire{cassetteList={"tp_c_00001_03"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if _>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER then
    this.Acquire{cassetteList={"tp_m_10120_01"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_m_10120_02"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if _>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    this.Acquire{cassetteList={"tp_m_10140_05"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_m_10140_06"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_04"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if TppStory.IsMissionOpen(10040)then
    this.Acquire{cassetteList={"tp_m_10040_01"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_m_10040_02"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if TppStory.IsMissionOpen(10080)then
    this.Acquire{cassetteList={"tp_c_00000_07"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_08"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_11"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_17"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if TppStory.IsMissionOpen(10082)then
    this.Acquire{cassetteList={"tp_m_10100_03"},isShowAnnounceLog={delayTimeSec=2}}
  end
  if TppStory.IsMissionOpen(10100)then
    this.Acquire{cassetteList={"tp_m_10100_01"},isShowAnnounceLog={delayTimeSec=2}}
    this.Acquire{cassetteList={"tp_c_00000_09"},isShowAnnounceLog={delayTimeSec=2}}
  end
end
return this

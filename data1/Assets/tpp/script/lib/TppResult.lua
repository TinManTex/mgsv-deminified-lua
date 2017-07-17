-- TppResult.lua
local this={}
local SendCommand=GameObject.SendCommand
local IsTypeTable=Tpp.IsTypeTable
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local MAX_32BIT_UINT=TppDefine.MAX_32BIT_UINT
this.PLAYSTYLE_HEAD_SHOT=.9
this.RANK_THRESHOLD={S=13e4,A=1e5,B=6e4,C=3e4,D=1e4,E=0}
this.RANK_BASE_SCORE={S=11e4,A=9e4,B=7e4,C=5e4,D=3e4,E=0}
this.RANK_BASE_SCORE_10054={S=1e4,A=9e3,B=7e3,C=5e3,D=3e3,E=0}
this.RANK_BASE_SCORE_10040={S=2e4,A=18e3,B=14e3,C=1e4,D=6e3,E=0}
this.RANK_BASE_SCORE_10130={S=5e4,A=45e3,B=35e3,C=25e3,D=2e4,E=0}
this.RANK_BASE_SCORE_10140={S=1e5,A=8e4,B=65e3,C=5e4,D=35e3,E=0}
this.RANK_BASE_GMP={S=28e3,A=23400,B=2e4,C=18e3,D=13500,E=9999}
this.COMMON_SCORE_PARAM={
  noReflexBonus=1e4,
  noAlertBonus=5e3,
  noKillBonus=5e3,
  noRetryBonus=5e3,
  perfectStealthNoKillBonus=2e4,
  noTraceBonus=1e5,
  firstSpecialBonus=5e3,
  secondSpecialBonus=5e3,
  alertCount={valueToScoreRatio=-5e3},
  rediscoveryCount={valueToScoreRatio=-500},
  takeHitCount={valueToScoreRatio=-100},
  tacticalActionPoint={valueToScoreRatio=1e3},
  hostageCount={valueToScoreRatio=5e3},
  markingCount={valueToScoreRatio=30},
  interrogateCount={valueToScoreRatio=150},
  headShotCount={valueToScoreRatio=1e3},
  neutralizeCount={valueToScoreRatio=200}
}
this.MISSION_GUARANTEE_GMP={
  [10010]=nil,
  [10020]=8e4,
  [10030]=nil,
  [10036]=9e4,
  [10043]=1e5,
  [10033]=1e5,
  [10040]=11e4,
  [10041]=11e4,
  [10044]=12e4,
  [10052]=12e4,
  [10054]=13e4,
  [10050]=13e4,
  [10070]=13e4,
  [10080]=15e4,
  [10082]=15e4,
  [10086]=15e4,
  [10090]=17e4,
  [10195]=17e4,
  [10091]=17e4,
  [10100]=17e4,
  [10110]=17e4,
  [10121]=17e4,
  [10115]=19e4,
  [10120]=19e4,
  [10085]=19e4,
  [10200]=19e4,
  [10211]=19e4,
  [10081]=19e4,
  [10130]=21e4,
  [10140]=21e4,
  [10150]=21e4,
  [10151]=21e4,
  [10045]=21e4,
  [10093]=25e4,
  [10156]=26e4,
  [10171]=28e4,
  [10240]=3e5,
  [10260]=6e5,
  [10280]=nil,
  [11043]=3e5,
  [11054]=42e4,
  [11082]=5e5,
  [11090]=5e5,
  [11033]=4e5,
  [11050]=52e4,
  [11140]=6e5,
  [11080]=6e5,
  [11121]=68e4,
  [11130]=68e4,
  [11044]=68e4,
  [11151]=82e4,
  [11041]=19e4,
  [11085]=35e4,
  [11036]=15e4,
  [11091]=31e4,
  [11195]=31e4,
  [11211]=35e4,
  [11200]=35e4,
  [11171]=43e4,
  [11115]=35e4,
  [10230]=23e4
}
this.MISSION_TASK_LIST={
  [10010]={0,1},
  [10020]={0,1,2,3,4,5},
  [10030]={0,1,2,3,4},
  [10036]={0,1,2,3,4},
  [10043]={0,1,2,3,4,5},
  [10033]={0,1,2,3,4},
  [10040]={0,1,2,3,4,5},
  [10041]={0,1,2,3,4,5,6},
  [10044]={0,2,3,4,5,6,7},
  [10050]={0,1,2,5},
  [10052]={1,2,3,4,5},
  [10054]={0,1,2,3,4,5,6,7},
  [10070]={0,1,2,3,4,5},
  [10080]={0,1,2,3,4,5},
  [10086]={0,1,2,3,4,5,6},
  [10082]={1,2,3,4,5},
  [10090]={0,1,2,3,4,5,6,7},
  [10195]={0,1,2,3,4,5,6},
  [10091]={1,3,4,5,6,7},
  [10100]={0,1,2,3,4,5,6,7},
  [10110]={0,1,2,3,4,5},
  [10121]={0,1,2,3,4,5,6,7},
  [10115]={0},
  [10120]={1,2,3,4,5},
  [10085]={0,1,2,3,4,5,6},
  [10200]={2,3,4,5,6,7},
  [10211]={0,2,3,4,5,6},
  [10081]={1,2,3},
  [10130]={0,1,2,3,4,5},
  [10140]={0,1,2,3},
  [10150]={0,1,2,3,4,5},
  [10151]={0,1,2},
  [10045]={1,2,3,4,5,6},
  [10156]={0,1,2,3,4},
  [10093]={0,2,3,4,5,6},
  [10171]={0,1,3,4,5,6,7},
  [10240]={0,1},
  [10260]={0,1,2,3,4},
  [10280]={0,1}
}
this.HARD_MISSION_LIST={11043,11041,11054,11085,11082,11090,11036,11033,11050,11091,11195,11211,11140,11200,11080,11171,11121,11115,11130,11044,11052,11151}
for a,missionCode in ipairs(this.HARD_MISSION_LIST)do
  local isMissingNumberMission=TppDefine.MISSING_NUMBER_MISSION_ENUM[tostring(missionCode)]
  if not isMissingNumberMission then
    this.MISSION_TASK_LIST[missionCode]=this.MISSION_TASK_LIST[missionCode-1e3]
  end
end
this.NO_SPECIAL_BONUS={[10030]=true,[10115]=true,[10240]=true}
function this.AcquireSpecialBonus(bonusInfo)
  if not IsTypeTable(bonusInfo)then
    return
  end
  if bonusInfo.first then
    if mvars.res_isExistFirstSpecialBonus then
      this._AcquireSpecialBonus(bonusInfo.first,"bestScoreBounus","bestScoreBounusScore",mvars.res_firstSpecialBonusMaxCount,this.COMMON_SCORE_PARAM.firstSpecialBonus,"isCompleteFirstBonus",mvars.res_firstBonusMissionTask,mvars.res_firstSpecialBonusPointList,"isAcquiredFirstBonusInPointList")
    end
  end
  if bonusInfo.second then
    if mvars.res_isExistSecondSpecialBonus then
      this._AcquireSpecialBonus(bonusInfo.second,"bestScoreBounus2","bestScoreBounusScore2",mvars.res_secondSpecialBonusMaxCount,this.COMMON_SCORE_PARAM.secondSpecialBonus,"isCompleteSecondBonus",mvars.res_secondBonusMissionTask,mvars.res_secondSpecialBonusPointList,"isAcquiredSecondBonusInPointList")
    end
  end
end
function this._AcquireSpecialBonus(taskInfo,bestScoreBonusType,bestScoreBonusScoreType,bonusMaxCount,commonScoreParam,isCompleteBonusType,bonusTask,bonusPointList,isAquiredBonusInPointListType)
  local isCompleted=taskInfo.isComplete
  if taskInfo.isComplete then
    isCompleted=true
    if(not bonusPointList)and(not bonusMaxCount)then
      svars[bestScoreBonusScoreType]=commonScoreParam
    end
  end
  if taskInfo.count then
    if not bonusMaxCount then
      return
    end
    if svars[bestScoreBonusType]<taskInfo.count then
      if taskInfo.count<=bonusMaxCount then
        svars[bestScoreBonusType]=taskInfo.count
      else
        svars[bestScoreBonusType]=bonusMaxCount
      end
      svars[bestScoreBonusScoreType]=(svars[bestScoreBonusType]/bonusMaxCount)*commonScoreParam
      if svars[bestScoreBonusType]==bonusMaxCount then
        isCompleted=true
      end
    end
  end
  if taskInfo.pointIndex then
    if not bonusPointList then
      return
    end
    local t=taskInfo.pointIndex
    if not Tpp.IsTypeNumber(t)then
      return
    end
    if t<1 then
      return
    end
    if t>#bonusPointList then
      return
    end
    svars[isAquiredBonusInPointListType][t]=true
    local e,t=this.CalcPoinListBonusScore(bonusPointList,isAquiredBonusInPointListType)
    svars[bestScoreBonusType]=e
    svars[bestScoreBonusScoreType]=t
    if svars[bestScoreBonusType]==#bonusPointList then
      isCompleted=true
    end
  end
  if isCompleted then
    this._CompleteBonus(isCompleteBonusType,bonusTask)
  else
    bonusTask.isHide=false
    TppUI.EnableMissionTask(bonusTask)
  end
end
function this.CalcPoinListBonusScore(a,s)
  local t=0
  local e=0
  for a,n in ipairs(a)do
    if svars[s][a]then
      t=t+1
      e=e+n
    end
  end
  return t,e
end
function this.SetSpecialBonusMaxCount(e)
  if not Tpp.IsTypeTable(e)then
    return
  end
  if e.first and e.first.maxCount then
    mvars.res_firstSpecialBonusMaxCount=e.first.maxCount
  end
  if e.second and e.second.maxCount then
    mvars.res_secondSpecialBonusMaxCount=e.second.maxCount
  end
end
function this._CompleteBonus(isCompleteSvar,bonusTask)
  local isComplete=true
  if svars[isCompleteSvar]then
    isComplete=false
  end
  svars[isCompleteSvar]=true
  if bonusTask then
    bonusTask.isComplete=true
    TppUI.EnableMissionTask(bonusTask,isComplete)
  end
end
function this.RegistNoMissionClearRank()
  mvars.res_noMissionClearRank=true
end
function this.SetMissionScoreTable(missionScoreTable)
  if not IsTypeTable(missionScoreTable)then
    return
  end
  mvars.res_missionScoreTable=missionScoreTable
end
function this.SetMissionFinalScore()
  if mvars.res_noResult then
    return
  end
  this.RegistUsedLimitedItemLangId()
  TppBuddyService.BuddyProcessMissionSuccess()
  this.SaveBestCount()
  local baseScore,clearRank=this.CalcBaseScore()
  this.CalcTimeScore(baseScore,clearRank)
  this.CalcEachScore()
  local totalScore=this.CalcTotalScore()
  local clearRank=this.DecideMissionClearRank()
  local updateGmpOnMissionClear
  if TppMission.IsFOBMission(vars.missionCode)then
    return
  end
  Tpp.IncrementPlayData"totalMissionClearCount"
  this.SetSpecialBonusResultScore()
  if clearRank~=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
    TppHero.MissionClear(clearRank)
  end
  if clearRank==TppDefine.MISSION_CLEAR_RANK.S then
    TppEmblem.AcquireOnSRankClear(vars.missionCode)
  end
  TppMotherBaseManagement.AwardedMeritMedalPointToPlayerStaff{clearRank=clearRank}
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
    if gvars.chickenCapClearCount<MAX_32BIT_UINT then
      gvars.chickenCapClearCount=gvars.chickenCapClearCount+1
    end
  end
  if(vars.playerType==PlayerType.DD_MALE or vars.playerType==PlayerType.DD_FEMALE)then
    TppTrophy.Unlock(11)
  end
  updateGmpOnMissionClear=this.UpdateGmpOnMissionClear(vars.missionCode,clearRank,totalScore)
  if vars.totalBatteryPowerAsGmp then
    TppUiCommand.SetResultBatteryGmp(vars.totalBatteryPowerAsGmp)--RETAILPATCH: 1060 added
    TppTerminal.UpdateGMP{gmp=vars.totalBatteryPowerAsGmp}
  end
  this.SetBestRank(vars.missionCode,clearRank)
  if updateGmpOnMissionClear then
    local size=this.CalcMissionClearHistorySize()
    this.SetMissionClearHistorySize(size)
    this.AddMissionClearHistory(vars.missionCode)
  end
  if vars.missionCode==10020 then
    if TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
      local gmp=TppMotherBaseManagement.GetGmp()
      gvars.firstRescueMillerClearedGMP=gmp
    end
  end
  if mvars.res_enablePlayStyle then
    this.SaveMissionClearPlayStyleParameter()
    svars.playStyle=this.DecidePlayStyle()
    TppEmblem.AcquireByPlayStyle(svars.playStyle)
    this.AddNewPlayStyleHistory()
  else
    svars.playStyle=0
    this.ClearNewestPlayStyleHistory()
  end
  if OnlineChallengeTask then--RETAILPATCH 1090>
    OnlineChallengeTask.DecideTaskFromResult()
  end--<
end
function this.IsUsedChickCap()
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICK_CAP)==PlayerPlayFlag.USE_CHICK_CAP then
    return true
  else
    return false
  end
end
function this.RegistUsedLimitedItemLangId()
  mvars.res_isUsedRankLimitedItem=false
  local rankRestrictionItems={
    {PlayerPlayFlag.USE_CHICKEN_CAP,"name_st_chiken"},
    {PlayerPlayFlag.USE_STEALTH,"name_it_12043"},
    {PlayerPlayFlag.USE_INSTANT_STEALTH,"name_it_12040"},
    {PlayerPlayFlag.USE_FULTON_MISSILE,"name_dw_31007"},
    {PlayerPlayFlag.USE_PARASITE_CAMO,"name_it_13050"},
    {PlayerPlayFlag.USE_MUGEN_BANDANA,"name_st_37002"},
    {PlayerPlayFlag.USE_HIGHGRADE_EQUIP,"result_spcialitem_etc"}--RETAILPATCH: 1060 higrade added
  }
  for i,itemInfo in ipairs(rankRestrictionItems)do
    local playFlag,langId=itemInfo[1],itemInfo[2]
    if playFlag then
      if bit.band(vars.playerPlayFlag,playFlag)==playFlag then
        mvars.res_isUsedRankLimitedItem=true
        TppUiCommand.SetResultScore(langId,"ranklimited")
      end
    end
  end
  if svars.isUsedSupportHelicopterAttack then
    if not mvars.res_rankLimitedSetting.permitSupportHelicopterAttack then
      mvars.res_isUsedRankLimitedItem=true
      TppUiCommand.SetResultScore("func_heli_attack","ranklimited")
    end
  end
  if svars.isUsedFireSupport then
    if not mvars.res_rankLimitedSetting.permitFireSupport then
      mvars.res_isUsedRankLimitedItem=true
      TppUiCommand.SetResultScore("func_spprt_battle","ranklimited")
    end
  end
end
function this.IsUsedRankLimitedItem()
  return mvars.res_isUsedRankLimitedItem
end
function this.DeclareSVars()
  return{
    {name="bestScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestRank",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="playCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="clearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="noAlertClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="noKillClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="stealthClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rankSClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="failedCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="timeParadoxCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="retryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="gameOverCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="scoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="playTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="squatTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="crawlTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="clearTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="shotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="hitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="headshotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="killCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="dyingCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="holdupCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="stunCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="sleepCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="interrogationCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="discoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="alertCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="oldTakeHitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="takeHitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="reflexCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="rediscoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="tacticalActionPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="traceCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="headshotCount2",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="neutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="shootNeutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="destroyVehicleCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="destroyHeriCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="ratCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="crowCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="useWeapon",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="hostageCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="soldierCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="markingEnemyCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mbTerminalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="externalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="externalScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="reinforceCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="stealthAssistCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="interrogateCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="supportGmpCost",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="heroicPointDiff",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="gmpDiamond",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="gmpAnimal",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreAlert",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreKill",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreHostage",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreGameOver",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreBounus",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreBounus2",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isAcquiredFirstBonusInPointList",type=TppScriptVars.TYPE_BOOL,value=false,save=true,arraySize=16,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isAcquiredSecondBonusInPointList",type=TppScriptVars.TYPE_BOOL,value=false,save=true,arraySize=16,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isCompleteFirstBonus",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isCompleteSecondBonus",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreRediscoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreTacticalActionPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreTimeScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreAlertScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreKillScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreHostageScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreGameOverScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreRediscoveryCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreTakeHitCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreTacticalActionPointScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreBounusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreBounusScore2",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreNoKillScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreNoRetryScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreNoReflexScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScorePerfectStealthNoKillBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreNoTraceBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreDeductScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreMarkingCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreInterrogateScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreHeadShotBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreNeutralizeBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="bestScoreHitRatioBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="gmpClear",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="gmpOutcome",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="playStyle",type=TppScriptVars.TYPE_INT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isUsedSupportHelicopterAttack",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="isUsedFireSupport",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="questScoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.Init(missionTable)
  this.SetRankTable(this.RANK_THRESHOLD)
  this.SetScoreTable(this.COMMON_SCORE_PARAM)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  if TppUiCommand.RegisterMbMissionListFunction then
    if TppUiCommand.IsTppUiReady()then
      TppUiCommand.RegisterMbMissionListFunction("TppResult","GetMbMissionListParameterTable")
    end
  end
  do
    for t,missionCode in ipairs{10043,11043}do
      local missionEnum=TppDefine.MISSION_ENUM[tostring(missionCode)]
      if gvars.res_bestRank[missionEnum]==TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
        gvars.res_bestRank[missionEnum]=TppDefine.MISSION_CLEAR_RANK.E+1
      end
    end
  end
  if missionTable.sequence then
    if missionTable.sequence.NO_TAKE_HIT_COUNT then
      mvars.res_noTakeHitCount=true
    end
    if missionTable.sequence.NO_TACTICAL_TAKE_DOWN then
      mvars.res_noTacticalTakeDown=true
    end
    if missionTable.sequence.NO_RESULT then
      mvars.res_noResult=true
      mvars.res_noTakeHitCount=true
      mvars.res_noTacticalTakeDown=true
    end
    if missionTable.sequence.NO_PLAY_STYLE then
      mvars.res_enablePlayStyle=false
    else
      mvars.res_enablePlayStyle=true
    end
    if missionTable.sequence.NO_AQUIRE_GMP then
      mvars.res_noAquireGmp=true
    end
    if missionTable.sequence.NO_MISSION_CLEAR_RANK then
      mvars.res_noMissionClearRank=true
    end
    if missionTable.sequence.specialBonus then
      local firstBonus=missionTable.sequence.specialBonus.first
      if firstBonus then
        mvars.res_isExistFirstSpecialBonus=true
        if firstBonus.maxCount then
          mvars.res_firstSpecialBonusMaxCount=firstBonus.maxCount
        end
        local missionTask=firstBonus.missionTask
        if missionTask then
          mvars.res_firstBonusMissionTask={}
          for t,e in pairs(missionTask)do
            mvars.res_firstBonusMissionTask[t]=e
          end
          mvars.res_firstBonusMissionTask.isFirstHide=true
        end
        if firstBonus.pointList then
          if Tpp.IsTypeTable(firstBonus.pointList)then
            mvars.res_firstSpecialBonusPointList=firstBonus.pointList
            mvars.res_firstSpecialBonusMaxCount=#firstBonus.pointList
          end
        end
      end
      local secondBonus=missionTable.sequence.specialBonus.second
      if secondBonus then
        mvars.res_isExistSecondSpecialBonus=true
        if secondBonus.maxCount then
          mvars.res_secondSpecialBonusMaxCount=secondBonus.maxCount
        end
        local missionTask=secondBonus.missionTask
        if missionTask then
          mvars.res_secondBonusMissionTask={}
          for e,t in pairs(missionTask)do
            mvars.res_secondBonusMissionTask[e]=t
          end
          mvars.res_secondBonusMissionTask.isFirstHide=true
        end
        if secondBonus.pointList then
          if Tpp.IsTypeTable(secondBonus.pointList)then
            mvars.res_secondSpecialBonusPointList=secondBonus.pointList
            mvars.res_secondSpecialBonusMaxCount=#secondBonus.pointList
          end
        end
      end
    end
    mvars.res_rankLimitedSetting={}
    if missionTable.sequence.rankLimitedSetting then
      mvars.res_rankLimitedSetting=missionTable.sequence.rankLimitedSetting
    end
    mvars.res_hitRatioBonusParam={hitRatioBaseScoreUnit=30,numOfBulletsPerNeutralizeCount=10,exponetHitRatio=6,limitHitRatioBonus=1e3,perfectBonusBase=3e4}
    if missionTable.sequence.hitRatioBonusParam then
      for e,t in pairs(missionTable.sequence.hitRatioBonusParam)do
        mvars.res_hitRatioBonusParam[e]=t
      end
    end
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)or TppMission.IsFreeMission(vars.missionCode)then
    mvars.res_noResult=true
  end
  if mvars.res_noResult then
    return
  end
  if missionTable.score and missionTable.score.missionScoreTable then
    this.SetMissionScoreTable(missionTable.score.missionScoreTable)
  else
    this.SetMissionScoreTable{baseTime={S=300,A=600,B=1800,C=5580,D=6480,E=8280},tacticalTakeDownPoint={countLimit=40},missionUniqueBonus={5e3,5e3}}
  end
  mvars.res_bonusMissionClearTimeRatio=mvars.res_missionScoreTable.baseTime.S/600
  if mvars.res_bonusMissionClearTimeRatio<1 then
    mvars.res_bonusMissionClearTimeRatio=1
  end
end
function this.OnReload(missionTable)
  this.Init(missionTable)
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.OnMissionCanStart()
  if mvars.res_firstBonusMissionTask then
    if svars.isCompleteFirstBonus then
      this._CompleteBonus("isCompleteFirstBonus",mvars.res_firstBonusMissionTask)
    else
      TppUI.EnableMissionTask(mvars.res_firstBonusMissionTask,false)
    end
  end
  if mvars.res_secondBonusMissionTask then
    if svars.isCompleteSecondBonus then
      this._CompleteBonus("isCompleteSecondBonus",mvars.res_secondBonusMissionTask)
    else
      TppUI.EnableMissionTask(mvars.res_secondBonusMissionTask,false)
    end
  end
end
function this.SetScoreTable(scoreTable)
  if not IsTypeTable(scoreTable)then
    return
  end
  mvars.res_scoreTable=scoreTable
end
function this.SetRankTable(tankTable)
  if not IsTypeTable(tankTable)then
    return
  end
  mvars.res_rankTable=tankTable
end
this.saveCountTable={{"bestScoreTime","scoreTime"},{"bestScoreAlert","alertCount"},{"bestScoreKill","killCount"},{"bestScoreHostage","hostageCount"},{"bestScoreGameOver","failedCount"},{"bestScoreGameOver","timeParadoxCount"},{"bestScoreTacticalActionPoint","tacticalActionPoint"}}
function this.SaveBestCount()
  local svars=svars
  for a,e in pairs(this.saveCountTable)do
    svars[e[1]]=0
  end
  for a,e in pairs(this.saveCountTable)do
    svars[e[1]]=svars[e[1]]+svars[e[2]]
  end
end
function this.DEBUG_Count()
  for e,e in pairs(this.saveCountTable)do
  end
end
local oneK=1e3
function this.CalcBaseScore()
  if not mvars.res_missionScoreTable then
    return
  end
  local svars=svars
  local clearRankN
  local clearRank,baseScore
  local missionName=TppMission.GetMissionName()
  local numClearRanks=#TppDefine.MISSION_CLEAR_RANK_LIST
  for n=1,numClearRanks do
    clearRankN=TppDefine.MISSION_CLEAR_RANK_LIST[n]
    local scoreTime=mvars.res_missionScoreTable.baseTime[clearRankN]*oneK
    if svars.bestScoreTime<=scoreTime then
      clearRank=n
      break
    end
  end
  if clearRank==nil then
    clearRank=numClearRanks
  end
  if missionName=="s10040"then
    baseScore=this.RANK_BASE_SCORE_10040[clearRankN]
  elseif missionName=="s10054"or missionName=="s11054"then
    baseScore=this.RANK_BASE_SCORE_10054[clearRankN]
  elseif missionName=="s10130"or missionName=="s11130"then
    baseScore=this.RANK_BASE_SCORE_10130[clearRankN]
  elseif missionName=="s10140"or missionName=="s11140"then
    baseScore=this.RANK_BASE_SCORE_10140[clearRankN]
  else
    baseScore=this.RANK_BASE_SCORE[clearRankN]
  end
  if this.IsUsedChickCap()then
    baseScore=0
    clearRank=TppDefine.MISSION_CLEAR_RANK.E
  end
  return baseScore,clearRank
end
local a=1/1e3
local minute=60
local max=(minute*60)*5
local s10054Max=(minute*60)*.25
local s10130Max=(minute*60)*1
local s10140Max=(minute*60)*4
local s10040Max=(minute*60)*.5
function this.CalcTimeScore(baseScore,clearRank)
  if not mvars.res_missionScoreTable then
    return
  end
  local svars=svars
  local rankEnum=TppDefine.MISSION_CLEAR_RANK_LIST[clearRank]
  local clearRankScoreTime=mvars.res_missionScoreTable.baseTime[rankEnum]
  local a=clearRankScoreTime-(svars.bestScoreTime*a)
  if a<0 then
    a=0
  end
  local timeScore=a*minute
  local missionName=TppMission.GetMissionName()
  if clearRank>TppDefine.MISSION_CLEAR_RANK.S then
    if missionName=="s10040"then
      if timeScore>s10040Max then
        timeScore=s10040Max
      end
    elseif missionName=="s10054"or missionName=="s11054"then
      if timeScore>s10054Max then
        timeScore=s10054Max
      end
    elseif missionName=="s10130"or missionName=="s11130"then
      if timeScore>s10130Max then
        timeScore=s10130Max
      end
    elseif missionName=="s10140"or missionName=="s11140"then
      if timeScore>s10140Max then
        timeScore=s10140Max
      end
    else
      if timeScore>max then
        timeScore=max
      end
    end
  end
  if this.IsUsedChickCap()then
    timeScore=0
    baseScore=0
  end
  svars.bestScoreTimeScore=timeScore+baseScore
end
this.calcScoreTable={
  bestScoreAlertScore={"alertCount","bestScoreAlert"},
  bestScoreHostageScore={"hostageCount","bestScoreHostage"},
  bestScoreTakeHitCountScore={"takeHitCount","takeHitCount"},
  bestScoreTacticalActionPointScore={"tacticalActionPoint","tacticalActionPoint","tacticalTakeDownPoint"},
  bestScoreMarkingCountScore={"markingCount",vars="playerMarkingCountInMission"},
  bestScoreInterrogateScore={"interrogateCount","interrogateCount"},
  bestScoreHeadShotBonusScore={"headShotCount","headshotCount2"},
  bestScoreNeutralizeBonusScore={"neutralizeCount","neutralizeCount"}
}
this.bonusScoreTable={
  bestScoreNoReflexScore={"reflexCount","noReflexBonus",nil},
  bestScoreAlertScore={"alertCount","noAlertBonus",true},
  bestScoreKillScore={"bestScoreKill","noKillBonus",nil},
  bestScoreNoRetryScore={"retryCount","noRetryBonus",true},
  bestScorePerfectStealthNoKillBonusScore={{"alertCount","bestScoreKill","reflexCount"},"perfectStealthNoKillBonus",true}
}
this.eachScoreLimit={bestScoreHeadShotBonusScore=100,bestScoreNeutralizeBonusScore=100,bestScoreMarkingCountScore=100,bestScoreInterrogateScore=100}--RETAILPATCH 1070
function this.CalcEachScore()
  local svars=svars
  for bestScoreCategory,varNames in pairs(this.calcScoreTable)do
    local s
    if varNames.vars then
      s=vars[varNames.vars]
    else
      s=svars[varNames[2]]
    end
    svars[bestScoreCategory]=this.CalcScore(s,mvars.res_scoreTable[varNames[1]],mvars.res_missionScoreTable[varNames[3]],this.eachScoreLimit[bestScoreCategory])--RETAILPATCH 1070 eachScoreLimit added
  end
  if not this.IsUsedChickCap()then
    for bestScoreCategory,varNames in pairs(this.bonusScoreTable)do
      local a
      if IsTypeTable(varNames[1])then
        a=varNames[1]
      else
        a={varNames[1]}
      end
      local s=true
      for a,e in ipairs(a)do
        if svars[e]>0 then
          s=false
          break
        end
      end
      local bonusMissionClearTimeRatio=1
      if varNames[3]then
        bonusMissionClearTimeRatio=mvars.res_bonusMissionClearTimeRatio
      end
      if s and(not isUsedChickCap)then--RETAILBUG: TODO:
        svars[bestScoreCategory]=mvars.res_scoreTable[varNames[2]]*bonusMissionClearTimeRatio
      end
    end
    svars.bestScoreHitRatioBonusScore=this.CalcHitRatioBonusScore(vars.shootHitCountInMission,vars.playerShootCountInMission,vars.shootHitCountEliminatedInMission,svars.shootNeutralizeCount,mvars.res_hitRatioBonusParam.hitRatioBaseScoreUnit,mvars.res_hitRatioBonusParam.numOfBulletsPerNeutralizeCount,mvars.res_hitRatioBonusParam.exponetHitRatio,mvars.res_hitRatioBonusParam.limitHitRatioBonus,mvars.res_hitRatioBonusParam.perfectBonusBase)
    if(bit.band(vars.playerPlayFlag,PlayerPlayFlag.FAILED_NO_TRACE_PLAY)==0)and(svars.bestScorePerfectStealthNoKillBonusScore>0)then--RETAILPATCH 1070 bestScorePerfectStealthNoKillBonusScore check added
      svars.bestScoreNoTraceBonusScore=mvars.res_scoreTable.noTraceBonus*mvars.res_bonusMissionClearTimeRatio
    end
  end
end
local maxScore=999999--tex TODO RENAME all of this
local minScore=-999999
--REF svars[n]=this.CalcScore(s,mvars.res_scoreTable[a[1]],mvars.res_missionScoreTable[a[3]],this.eachScoreLimit[n])--RETAILPATCH 1070 eachScoreLimit added
function this.CalcScore(p1,RENscoreTable,RENmissionScoreTable,scoreLimit)--RETAILPATCH 1070 scorelimit added
  local unitValue=RENscoreTable.unitValue or 1
  local l2=p1/unitValue
  local score=0
  local valueToScoreRatio=RENscoreTable.valueToScoreRatio or 1
  local limit=scoreLimit or 999999--RETAILPATCH 1070 scorelimit added
  if RENmissionScoreTable and RENmissionScoreTable.countLimit then
    limit=RENmissionScoreTable.countLimit
  end
  if l2>limit then
    l2=limit
  end
  score=l2*valueToScoreRatio
  if score<minScore then
    score=minScore
  elseif score>maxScore then
    score=maxScore
  end
  if this.IsUsedChickCap()then
    score=0
  end
  return score
end
function this.CalcHitRatioBonusScore(shootHitCountInMission,playerShootCountInMission,shootHitCountEliminatedInMission,shootNeutralizeCount,hitRatioBaseScoreUnit,numOfBulletsPerNeutralizeCount,exponetHitRatio,limitHitRatioBonus,perfectBonusBase)
  local hitRatio=playerShootCountInMission-shootHitCountEliminatedInMission
  if hitRatio<=0 then
    return 0
  end
  local _hitRatio=hitRatio
  local i=shootHitCountInMission/_hitRatio
  if shootNeutralizeCount<1 then
    shootNeutralizeCount=.5
  end
  local t=(((hitRatioBaseScoreUnit*2)*_hitRatio)/(shootNeutralizeCount*numOfBulletsPerNeutralizeCount))*(i^exponetHitRatio)
  local t=(hitRatioBaseScoreUnit+t)*shootHitCountInMission
  if t>(shootNeutralizeCount*limitHitRatioBonus)then
    t=shootNeutralizeCount*limitHitRatioBonus
  end
  local s
  if i>=1 then
    s=(((perfectBonusBase/2)*shootNeutralizeCount)/10)*(shootNeutralizeCount/_hitRatio)
    if s>perfectBonusBase then
      s=perfectBonusBase
    end
    t=t+s
  end
  t=math.ceil(t)
  return t
end
this.playScoreList={"bestScoreTimeScore","bestScoreTakeHitCountScore","bestScoreTacticalActionPointScore","bestScoreHeadShotBonusScore","bestScoreHitRatioBonusScore","bestScoreNeutralizeBonusScore","bestScoreMarkingCountScore","bestScoreInterrogateScore","bestScoreHostageScore"}
this.bounusScoreList={"bestScoreBounusScore","bestScoreBounusScore2","bestScoreNoRetryScore","bestScoreKillScore","bestScoreNoReflexScore","bestScoreAlertScore","bestScorePerfectStealthNoKillBonusScore","bestScoreNoTraceBonusScore"}
local maxScore=999999
local minScore=-999999
function this.CalcTotalScore()
  local totalScore=0
  local totalBonusScore=0
  for i,bestScoreSvarName in pairs(this.playScoreList)do
    local a=svars[bestScoreSvarName]
    totalScore=totalScore+svars[bestScoreSvarName]
  end
  for i,bonusScoreSvarName in pairs(this.bounusScoreList)do
    local s=svars[bonusScoreSvarName]totalScore=totalScore+svars[bonusScoreSvarName]
    totalBonusScore=totalBonusScore+svars[bonusScoreSvarName]
  end
  if totalScore>=maxScore then
    totalScore=maxScore
  elseif totalScore<=minScore then
    totalScore=minScore
  end
  if this.IsUsedChickCap()then
    totalScore=0
    totalBonusScore=0
  end
  svars.bestScore=totalScore
  if totalBonusScore>=maxScore then
    totalBonusScore=maxScore
  elseif totalBonusScore<=0 then
    totalBonusScore=0
  end
  local missionEnum=TppDefine.MISSION_ENUM[tostring(vars.missionCode)]
  if missionEnum then
    local isUsedRankLimitedItem=this.IsUsedRankLimitedItem()
    if isUsedRankLimitedItem then
      if totalScore>gvars.rnk_missionBestScoreUsedLimitEquip[missionEnum]then
        gvars.rnk_missionBestScoreUsedLimitEquip[missionEnum]=totalScore
      end
    else
      if totalScore>gvars.rnk_missionBestScore[missionEnum]then
        gvars.rnk_missionBestScore[missionEnum]=totalScore
      end
    end
    if not(((vars.missionCode==10043)or(vars.missionCode==11043))and mvars.res_noMissionClearRank)then
      TppRanking.RegistMissionClearRankingResult(isUsedRankLimitedItem,vars.missionCode,totalScore)
    end
  end
  return totalBonusScore
end
function this.DecideMissionClearRank()
  local bestRank
  local bestScore=svars.bestScore
  local numClearRanks=#TppDefine.MISSION_CLEAR_RANK_LIST
  if not mvars.res_noMissionClearRank then
    for n=1,numClearRanks do
      local rank=TppDefine.MISSION_CLEAR_RANK_LIST[n]
      if bestScore>=mvars.res_rankTable[rank]then
        bestRank=n
        break
      end
    end
    if bestRank==nil then
      bestRank=numClearRanks
    end
  else
    bestRank=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED
  end
  if this.IsUsedRankLimitedItem()then
    if bestRank==TppDefine.MISSION_CLEAR_RANK.S then
      bestRank=TppDefine.MISSION_CLEAR_RANK.A
    end
  end
  svars.bestRank=bestRank
  return svars.bestRank
end
function this.UpdateGmpOnMissionClear(missionCode,clearRank,totalScore)
  local guaranteeGmp=this.MISSION_GUARANTEE_GMP[missionCode]
  if not guaranteeGmp then
    return
  end
  if missionCode==10020 and(not TppStory.IsMissionCleard(missionCode))then
    return
  end
  local guaranteedGmp=this.GetMissionGuaranteeGMP(missionCode)
  svars.gmpClear=TppTerminal.CorrectGMP{gmp=guaranteedGmp}
  if clearRank~=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
    local missionClearGmp=this.GetMissionClearRankGMP(clearRank,missionCode)
    missionClearGmp=missionClearGmp+totalScore
    svars.gmpOutcome=TppTerminal.CorrectGMP{gmp=missionClearGmp}
  else
    svars.gmpOutcome=0
  end
  local gmp=svars.gmpClear+svars.gmpOutcome
  TppTerminal.UpdateGMP{gmp=gmp,withOutAnnouceLog=true}
  return gmp
end
function this.SetBestRank(missionCode,rank)
  local missionEnum=TppDefine.MISSION_ENUM[tostring(missionCode)]
  if not missionEnum then
    return
  end
  if(rank<TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED)or(rank>#TppDefine.MISSION_CLEAR_RANK_LIST)then
    return
  end
  if((missionCode==10043)or(missionCode==11043))and(rank==TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED)then
    return
  end
  if rank<gvars.res_bestRank[missionEnum]then
    gvars.res_bestRank[missionEnum]=rank
  end
end
function this.GetBestRank(missionCode)
  local missionEnum=TppDefine.MISSION_ENUM[tostring(missionCode)]
  if not missionEnum then
    return
  end
  return gvars.res_bestRank[missionEnum]
end
function this.GetMissionClearRankGMP(clearRank,missionCode)
  local bestRank=this.GetBestRank(missionCode)
  if not bestRank then
    return 0
  end
  local reduceRatio=this.GetRepeatPlayGMPReduceRatio(missionCode)
  local total=0
  local numRanks=#TppDefine.MISSION_CLEAR_RANK_LIST
  for i=numRanks,clearRank,-1 do
    local rank=TppDefine.MISSION_CLEAR_RANK_LIST[i]
    local baseGmp=this.RANK_BASE_GMP[rank]
    if i<bestRank then
      total=total+baseGmp
    else
      total=total+baseGmp*reduceRatio
    end
  end
  return total
end
function this.GetMbMissionListParameterTable()
  local missionListParameterTable={}
  for missionCodeStr,enum in pairs(TppDefine.MISSION_ENUM)do
    local missionCode=tonumber(missionCodeStr)
    local missionParameters={}
    missionParameters.missionId=missionCode
    if this.MISSION_GUARANTEE_GMP[missionCode]then
      missionParameters.baseGmp=this.MISSION_GUARANTEE_GMP[missionCode]
      missionParameters.currentGmp=this.GetMissionGuaranteeGMP(missionCode)
    end
    if this.MISSION_TASK_LIST[missionCode]then
      missionParameters.completedTaskNum=TppUI.GetTaskCompletedNumber(missionCode)
      missionParameters.maxTaskNum=#this.MISSION_TASK_LIST[missionCode]
      missionParameters.taskList=this.MISSION_TASK_LIST[missionCode]
    end
    table.insert(missionListParameterTable,missionParameters)
  end
  return missionListParameterTable
end
function this.GetMissionGuaranteeGMP(missionCode)
  local guaranteedGmp=this.MISSION_GUARANTEE_GMP[missionCode]
  local repeatPlayReduceRatio=this.GetRepeatPlayGMPReduceRatio(missionCode)
  local gmp
  if this.IsUsedChickCap()then
    gmp=(guaranteedGmp*repeatPlayReduceRatio)/2
  else
    gmp=guaranteedGmp*repeatPlayReduceRatio
  end
  return gmp
end
local a=.5
function this.GetRepeatPlayGMPReduceRatio(missionCode)
  local missionClearCount=this.GetMissionClearCountFromHistory(missionCode)
  local reduceRatio=a^missionClearCount
  return reduceRatio
end
local a=0
function this.AddMissionClearHistory(missionCode)
  local size=gvars.res_missionClearHistorySize-1
  for e=size,0,-1 do
    gvars.res_missionClearHistory[e+1]=gvars.res_missionClearHistory[e]
  end
  gvars.res_missionClearHistory[0]=missionCode
  this.ClearOverSizeHistory(gvars.res_missionClearHistorySize)
end
function this.GetMissionClearCountFromHistory(a)
  local e=0
  local t=gvars.res_missionClearHistorySize-1
  for t=0,t do
    if gvars.res_missionClearHistory[t]==a then
      e=e+1
    end
  end
  return e
end
local n=.6
function this.CalcMissionClearHistorySize()
  local t=TppStory.GetOpenMissionCount()
  local e
  if t<=1 then
    e=1
  else
    e=math.floor(t*n)
  end
  return e
end
function this.SetMissionClearHistorySize(t)
  if t>=TppDefine.MISSION_CLEAR_HISTORY_LIMIT then
    return
  end
  gvars.res_missionClearHistorySize=t
  this.ClearOverSizeHistory(t)
end
function this.ClearOverSizeHistory(e)
  for e=e,TppDefine.MISSION_CLEAR_HISTORY_LIMIT-1 do
    gvars.res_missionClearHistory[e]=a
  end
end
function this.SetSpecialBonusResultScore()
  if this.NO_SPECIAL_BONUS[vars.missionCode]then
    TppUiCommand.SetResultScore("invalid","bonus",0)
    TppUiCommand.SetResultScore("invalid","bonus",1)
    return
  end
  if mvars.res_isExistFirstSpecialBonus then
    this._SetSpecialBonusResultScore(0,"bestScoreBounus","bestScoreBounusScore",mvars.res_firstSpecialBonusMaxCount,this.COMMON_SCORE_PARAM.firstSpecialBonus,"isCompleteFirstBonus",mvars.res_firstBonusMissionTask)
  end
  if mvars.res_isExistSecondSpecialBonus then
    this._SetSpecialBonusResultScore(1,"bestScoreBounus2","bestScoreBounusScore2",mvars.res_secondSpecialBonusMaxCount,this.COMMON_SCORE_PARAM.secondSpecialBonus,"isCompleteSecondBonus",mvars.res_secondBonusMissionTask)
  end
end
function this._SetSpecialBonusResultScore(t,i,n,r,s,o,a)
  if not a.taskNo then
    TppUiCommand.SetResultScore("invalid","bonus",t)
    return
  end
  local taskLangId=this.MakeMissionTaskLangId(a.taskNo)
  local a=svars[i]
  if(not svars[o])and(a==0)then
    TppUiCommand.SetResultScore("invalid","bonus",t)
    return
  end
  local n=svars[n]
  local e=-1
  if a>0 then
    e=a
  end
  if e==-1 then
    TppUiCommand.SetResultScore(taskLangId,"bonus",t,e,n)
  else
    TppUiCommand.SetResultScore(taskLangId,"bonus_rate",t,e,r,n)
  end
end
function this.MakeMissionTaskLangId(taskNo)
  local missionCode=vars.missionCode
  if(missionCode>=11e3)and(missionCode<12e3)then
    missionCode=missionCode-1e3
  end
  return"task_mission_"..(string.format("%02d",vars.locationCode)..("_"..(tostring(missionCode)..("_"..string.format("%02d",taskNo)))))
end
function this.SaveMissionClearPlayStyleParameter()
  if svars.bestScorePerfectStealthNoKillBonusScore>0 then
    gvars.res_isPerfectStealth[0]=true
    Tpp.IncrementPlayData"totalPerfectStealthMissionClearCount"
  elseif svars.alertCount==0 then
    gvars.res_isStealth[0]=true
    Tpp.IncrementPlayData"totalStealthMissionClearCount"
  end
end
function this.DecidePlayStyle()
  local storySequence=TppStory.GetCurrentStorySequence()
  if storySequence<TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    return 1
  end
  if vars.playerPlayFlag then
    if(bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP)then
      return 2
    end
  end
  local isPerfectStealth=true
  for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    if gvars.res_isPerfectStealth[e]==false then
      isPerfectStealth=false
      break
    end
  end
  if isPerfectStealth then
    return 3
  end
  local isStealth=true
  for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    if gvars.res_isStealth[e]==false then
      isStealth=false
      break
    end
  end
  if isStealth then
    return 4
  end
  local totalHeadShotCount,totalNeutralizeCount=this.GetTotalHeadShotCount(),this.GetTotalNeutralizeCount()
  if totalNeutralizeCount<1 then
    totalNeutralizeCount=1
  end
  local headshotToNeutralize=totalHeadShotCount/totalNeutralizeCount
  if headshotToNeutralize>=this.PLAYSTYLE_HEAD_SHOT then
    return 6
  end
  return this.DecideNeutralizePlayStyle()
end
function this.DEBUG_Init()
  mvars.debug.showHitRatio=false;
  (nil).AddDebugMenu("LuaMission","RES.hitRatio","bool",mvars.debug,"showHitRatio")
  mvars.debug.showMissionClearHistory=false;
  (nil).AddDebugMenu("LuaMission","RES.clearHistory","bool",mvars.debug,"showMissionClearHistory")
  mvars.debug.showMissionScoreTable=false;
  (nil).AddDebugMenu("LuaMission","RES.scoreTable","bool",mvars.debug,"showMissionScoreTable")
  mvars.debug.showPlayData=false;
  (nil).AddDebugMenu("LuaMission","RES.showPlayData","bool",mvars.debug,"showPlayData")
  mvars.debug.showPlayStyleHistory=false;
  (nil).AddDebugMenu("LuaMission","showPlayStyleHistory","bool",mvars.debug,"showPlayStyleHistory")
  mvars.debug.showPlayDataNeutralizeCount=false;
  (nil).AddDebugMenu("LuaMission","showPlayDataNeutralizeCount","bool",mvars.debug,"showPlayDataNeutralizeCount")
  mvars.debug.doForceSetPlayStyle=false;
  (nil).AddDebugMenu("LuaMission","doForceSetStyle","bool",mvars.debug,"doForceSetPlayStyle")
  mvars.debug.playStyleHistory=0;
  (nil).AddDebugMenu("LuaMission","styleHistory","int32",mvars.debug,"playStyleHistory")
  mvars.debug.playStyleIsPerfectStealth=false;
  (nil).AddDebugMenu("LuaMission","styleIsPerfectStealth","bool",mvars.debug,"playStyleIsPerfectStealth")
  mvars.debug.playStyleIsStealth=false;
  (nil).AddDebugMenu("LuaMission","styleIsStealth","bool",mvars.debug,"playStyleIsStealth")
  mvars.debug.playStyleHeadShotCount=0;
  (nil).AddDebugMenu("LuaMission","styleHeadShotCount","int32",mvars.debug,"playStyleHeadShotCount")
  mvars.debug.playStyleSaveIndex=-1;
  (nil).AddDebugMenu("LuaMission","styleSaveIndex","int32",mvars.debug,"playStyleSaveIndex")
  mvars.debug.playStyleNeutralizeCount=0;
  (nil).AddDebugMenu("LuaMission","styleNeutralizeCount","int32",mvars.debug,"playStyleNeutralizeCount")
  mvars.debug.addNewPlayStyleHistory=false;
  (nil).AddDebugMenu("LuaMission","addNewPlayStyleHistory","bool",mvars.debug,"addNewPlayStyleHistory")
  mvars.debug.beforeMaxPlayRecord=false;
  (nil).AddDebugMenu("LuaMission","beforeMaxPlayRecord","bool",mvars.debug,"beforeMaxPlayRecord")
end
this.DEBUG_NEUTRALIZE_TYPE_TEXT={" HOLDUP","    CQC","NO_KILL","  KNIFE","HANDGUN","SUBMGUN","SHOTGUN","ASSAULT","MCH_GUN"," SNIPER","MISSILE","GRENADE","   MINE","  QUIET","  D_DOG","D_HORSE","D_WLKER","VEHICLE","SP_HELI"," ASSIST"}
function this.DebugUpdate()
  local n=5
  local s=svars
  local a=mvars
  local t=(nil).NewContext()
  if a.debug.showHitRatio then
    local e=vars.playerShootCountInMission-vars.shootHitCountEliminatedInMission
    local a=0
    if e>0 then
      a=vars.shootHitCountInMission/e
    end(nil).Print(t,{.5,.5,1},"LuaMission RES.hitRatio");
    (nil).Print(t,"vars.playerShootCountInMission = "..tostring(vars.playerShootCountInMission));
    (nil).Print(t,"vars.shootHitCountInMission = "..tostring(vars.shootHitCountInMission));
    (nil).Print(t,"vars.shootHitCountEliminatedInMission = "..tostring(vars.shootHitCountEliminatedInMission));
    (nil).Print(t,"valid shoot count = "..tostring(e));
    (nil).Print(t,"hitRatio = "..tostring(a));
    (nil).Print(t,"svars.headshotCount2 = "..tostring(s.headshotCount2));
    (nil).Print(t,"svars.neutralizeCount = "..tostring(s.neutralizeCount));
    (nil).Print(t,"svars.shootNeutralizeCount = "..tostring(s.shootNeutralizeCount))
  end
  if a.debug.showMissionClearHistory then(nil).Print(t,{.5,.5,1},"LuaMission RES.clearHistory");
    (nil).Print(t,"historySize = "..tostring(gvars.res_missionClearHistorySize))
    local a={}
    local s,e=0,1
    local r=gvars.res_missionClearHistorySize-1
    for t=0,r do
      e=math.floor(s/n)+1
      a[e]=a[e]or"   "a[e]=a[e]..(tostring(gvars.res_missionClearHistory[t])..", ")s=s+1
    end
    for e=1,e do(nil).Print(t,a[e])
    end
  end
  if a.debug.showMissionScoreTable and a.res_missionScoreTable then(nil).Print(t,{.5,.5,1},"LuaMission RES.scoreTable");
    (nil).Print(t,"baseTime")
    for s,e in ipairs(TppDefine.MISSION_CLEAR_RANK_LIST)do
      local a=a.res_missionScoreTable.baseTime[e];
      (nil).Print(t,"rank = "..(tostring(e)..(": baseTime = "..(tostring(a).."[s]."))))
    end
    if a.res_missionScoreTable.tacticalTakeDownPoint then(nil).Print(t,"tacticalTakeDownPoint : countLimit = "..tostring(a.res_missionScoreTable.tacticalTakeDownPoint.countLimit))
    else(nil).Print(t,"cannot find tacticalTakeDown param")
    end
  end
  if a.debug.showPlayData then
    (nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayData");
    (nil).Print(t,"gvars.totalMissionClearCount = "..tostring(gvars.totalMissionClearCount));
    (nil).Print(t,"gvars.totalPerfectStealthMissionClearCount = "..tostring(gvars.totalPerfectStealthMissionClearCount));
    (nil).Print(t,"gvars.totalStealthMissionClearCount = "..tostring(gvars.totalStealthMissionClearCount));
    (nil).Print(t,"gvars.totalRetryCount = "..tostring(gvars.totalRetryCount));
    (nil).Print(t,"gvars.totalNeutralizeCount = "..tostring(gvars.totalNeutralizeCount));
    (nil).Print(t,"gvars.totalKillCount = "..tostring(gvars.totalKillCount));
    (nil).Print(t,"gvars.totalHelicopterDestoryCount = "..tostring(gvars.totalHelicopterDestoryCount));
    (nil).Print(t,"gvars.totalBreakVehicleCount = "..tostring(gvars.totalBreakVehicleCount));
    (nil).Print(t,"gvars.totalBreakPlacedGimmickCount = "..tostring(gvars.totalBreakPlacedGimmickCount));
    (nil).Print(t,"gvars.totalBreakBurglarAlarmCount = "..tostring(gvars.totalBreakBurglarAlarmCount));
    (nil).Print(t,"gvars.totalWalkerGearDestoryCount = "..tostring(gvars.totalWalkerGearDestoryCount));
    (nil).Print(t,"gvars.totalMineRemoveCount = "..tostring(gvars.totalMineRemoveCount));
    (nil).Print(t,"gvars.totalAnnihilateOutPostCount = "..tostring(gvars.totalAnnihilateOutPostCount));
    (nil).Print(t,"gvars.totalAnnihilateBaseCount = "..tostring(gvars.totalAnnihilateBaseCount));
    (nil).Print(t,"gvars.totalInterrogateCount = "..tostring(gvars.totalInterrogateCount));
    (nil).Print(t,"gvars.totalRescueCount = "..tostring(gvars.totalRescueCount));
    (nil).Print(t,"vars.totalMarkingCount = "..tostring(vars.totalMarkingCount))
  end
  if a.debug.showPlayStyleHistory then(nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayStyleHistory");
    (nil).Print(t,{.5,1,.5},"gvars.res_neutralizeHistorySize = "..tostring(gvars.res_neutralizeHistorySize));
    (nil).Print(t,{.5,1,.5}," history = 0         | history = 1          | history = 2        ");
    (nil).Print(t,{.5,1,.5},"isPerfectStealth");
    (nil).Print(t,"( "..(tostring(gvars.res_isPerfectStealth[0])..(" ) | ( "..(tostring(gvars.res_isPerfectStealth[1])..(" ) | ( "..(tostring(gvars.res_isPerfectStealth[2]).." )"))))));
    (nil).Print(t,{.5,1,.5},"isStealth");
    (nil).Print(t,"( "..(tostring(gvars.res_isStealth[0])..(" ) | ( "..(tostring(gvars.res_isStealth[1])..(" ) | ( "..(tostring(gvars.res_isStealth[2]).." )"))))));
    (nil).Print(t,{.5,1,.5},"Head shot count");
    (nil).Print(t,string.format("( %07d ) | ( %07d ) | ( %07d )",gvars.res_headShotCount[0],gvars.res_headShotCount[1],gvars.res_headShotCount[2]));
    (nil).Print(t,{.5,1,.5},"( historyIndex, neutralizeType, count )")
    for s=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
      local a=""
      local n=this.DEBUG_NEUTRALIZE_TYPE_TEXT[s+1]
      for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
        local e=string.format("( %02d, %s, %03d ) | ",e,n,gvars.res_neutralizeCount[e*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+s])a=a..e
      end(nil).Print(t,a)
    end
  end
  if a.debug.showPlayDataNeutralizeCount then
    (nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayDataNeutralizeCount");
    (nil).Print(t,{.5,1,.5},"( neutralizeType, count )")
    for a=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
      local e=this.DEBUG_NEUTRALIZE_TYPE_TEXT[a+1]
      local e=string.format("( %s, %016d ) | ",e,gvars.res_neutralizeCountForPlayData[a]);
      (nil).Print(t,e)
    end
  end
  if a.debug.doForceSetPlayStyle then
    a.debug.doForceSetPlayStyle=false
    local e=a.debug.playStyleHistory
    if e<0 then
      e=0
      a.debug.playStyleHistory=0
    end
    if e>2 then
      e=2
      a.debug.playStyleHistory=2
    end
    gvars.res_isPerfectStealth[e]=a.debug.playStyleIsPerfectStealth
    gvars.res_isStealth[e]=a.debug.playStyleIsStealth
    if a.debug.playStyleHeadShotCount>0 then
      gvars.res_headShotCount[e]=a.debug.playStyleHeadShotCount
    end
    local t=a.debug.playStyleSaveIndex
    if t<0 then
      a.debug.playStyleSaveIndex=0
      t=0
    end
    if t>=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX then
      a.debug.playStyleSaveIndex=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1
      t=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1
    end
    if a.debug.playStyleNeutralizeCount>0 then
      gvars.res_neutralizeCount[e*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+t]=a.debug.playStyleNeutralizeCount
    end
  end
  if a.debug.addNewPlayStyleHistory then
    a.debug.addNewPlayStyleHistory=false
    this.AddNewPlayStyleHistory()
  end
  if a.debug.beforeMaxPlayRecord then
    a.debug.beforeMaxPlayRecord=false
    local e=999999997
    local t={"totalMissionClearCount","totalPerfectStealthMissionClearCount","totalStealthMissionClearCount","totalRetryCount","totalNeutralizeCount","totalKillCount","totalBreakVehicleCount","totalHelicopterDestoryCount","totalWalkerGearDestoryCount","totalBreakPlacedGimmickCount","totalBreakBurglarAlarmCount","totalMineRemoveCount","totalAnnihilateOutPostCount","totalAnnihilateBaseCount","totalMarkingCount","totalInterrogateCount","totalRescueCount","totalheadShotCount","rnk_TotalTacticalTakeDownCount"}
    for a,t in ipairs(t)do
      gvars[t]=e
    end
    for t=0,19 do
      gvars.res_neutralizeCountForPlayData[t]=e
    end
    gvars.chickenCapClearCount=e
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={{msg="PlayerDamaged",func=this.IncrementTakeHitCount}},
    GameObject={
      {msg="Dead",func=function(gameId,attackerId,phase,deadMessageFlag)
        if not Tpp.IsLocalPlayer(attackerId)then
          return
        end
        if Tpp.IsEnemyWalkerGear(gameId)then
          Tpp.IncrementPlayData"totalWalkerGearDestoryCount"
        end
      end},
      {msg="TapHeadShotFar",func=function(gameId)--RETAILPATCH 1070 params added to all OnTacticalActionPoint calls-v-
        this.OnTacticalActionPoint(gameId,"TapHeadShotFar")
      end},
      {msg="TapRocketArm",func=function(gameId)
        this.OnTacticalActionPoint(gameId,"TapRocketArm")
      end},
      {msg="TapHoldup",func=function(gameId)
        this.OnTacticalActionPoint(gameId,"TapHoldup")
      end},
      {msg="TapCqc",func=function(gameId)
        this.OnTacticalActionPoint(gameId,"TapCqc")
      end},
      {msg="HeadShot",func=this.OnHeadShot},
      {msg="Neutralize",func=this.OnNeutralize},
      {msg="InterrogateSetMarker",func=this.IncrementInterrogateCount},
      {msg="BreakGimmickBurglarAlarm",func=function(attackerId)
        if not Tpp.IsLocalPlayer(attackerId)then
          return
        end
        Tpp.IncrementPlayData"totalBreakBurglarAlarmCount"
      end}
    }
  }
end
local unk1=MAX_32BIT_UINT
local unk2=MAX_32BIT_UINT
local unk3=true
local unk4=false
function this.IncrementInterrogateCount()
  Tpp.IncrementPlayData"totalInterrogateCount"
  TppChallengeTask.RequestUpdate"PLAY_RECORD"--RETAILPATCH 1070
  if svars.interrogateCount<MAX_32BIT_UINT then
    svars.interrogateCount=svars.interrogateCount+1
  end
end
function this.IncrementTakeHitCount()
  if mvars.res_noTakeHitCount then
    return
  end
  if svars.oldTakeHitCount<svars.takeHitCount then
    svars.oldTakeHitCount=svars.takeHitCount
    this.CallCountAnnounce("result_hit",svars.takeHitCount,unk3)
  end
end
--RETAILPATCH 1070 tacticalTakedownType added
function this.OnTacticalActionPoint(gameId,tacticalTakedownType)
  if SendCommand(gameId,tacticalTakedownType,{id="IsDoneTacticalTakedown"})then
  else
    SendCommand(gameId,tacticalTakedownType,{id="SetTacticalTakedown"})
    this.AddTacticalActionPoint{isSneak=true,gameObjectId=gameId,tacticalTakeDownType=tacticalTakedownType}--RETAILPATCH 1070 params added
  end
end
function this.GetTacticalActionPoint(e)--RETAILPATCH 1070>
  if e then
    return svars.tacticalActionPoint
else
  if vars.missionCode~=50050 then
    return 0
  end
  return svars.tacticalActionPointClient
end
end--<
--RETAILPATCH 1070 reworked>
function this.AddTacticalActionPoint(takedownInfo)
  if mvars.res_noTacticalTakeDown then
    return
  end
  local function SetSvar(t,actionPoint)
    if t then
      svars.tacticalActionPoint=actionPoint
    else
      if vars.missionCode~=50050 then
        return
      end
      svars.tacticalActionPointClient=actionPoint
    end
  end
  local a=true
  if takedownInfo and(takedownInfo.isSneak==false)then
    a=false
  end
  local s=this.GetTacticalActionPoint(a)
  if a then
    Tpp.IncrementPlayData"rnk_TotalTacticalTakeDownCount"
    TppChallengeTask.RequestUpdate"PLAY_RECORD"
    TppUI.UpdateOnlineChallengeTask{detectType=31,diff=1}--RETAILPATCH 1090
  end
  if s>=mvars.res_missionScoreTable.tacticalTakeDownPoint.countLimit then
    return
  end
  SetSvar(a,s+1)
  if a then
    this.CallCountAnnounce("result_tactical_takedown",svars.tacticalActionPoint,n)
    TppTutorial.DispGuide("TAKE_DOWN",TppTutorial.DISPLAY_OPTION.TIPS)
    local e=takedownInfo and takedownInfo.tacticalTakeDownType
    if e then
      Mission.SendMessage("Mission","OnAddTacticalActionPoint",takedownInfo.gameObjectId,takedownInfo.tacticalTakeDownType)
    end
  end
end
function this.CallCountAnnounce(langId,count,unk3Bool)
  TppUiCommand.CallCountAnnounce(langId,count,unk3Bool)
end
this.PLAYER_CAUSE_TO_SAVE_INDEX={
  [NeutralizeCause.CQC]=1,
  [NeutralizeCause.NO_KILL]=2,
  [NeutralizeCause.NO_KILL_BULLET]=2,
  [NeutralizeCause.CQC_KNIFE]=3,
  [NeutralizeCause.HANDGUN]=4,
  [NeutralizeCause.SUBMACHINE_GUN]=5,
  [NeutralizeCause.SHOTGUN]=6,
  [NeutralizeCause.ASSAULT_RIFLE]=7,
  [NeutralizeCause.MACHINE_GUN]=8,
  [NeutralizeCause.SNIPER_RIFLE]=9,
  [NeutralizeCause.MISSILE]=10,
  [NeutralizeCause.GRENADE]=11,
  [NeutralizeCause.MINE]=12}
this.NPC_CAUSE_TO_SAVE_INDEX={
  [NeutralizeCause.QUIET]=13,
  [NeutralizeCause.D_DOG]=14,
  [NeutralizeCause.D_HORSE]=15,
  [NeutralizeCause.D_WALKER_GEAR]=16,
  [NeutralizeCause.VEHICLE]=17,
  [NeutralizeCause.SUPPORT_HELI]=18,
  [NeutralizeCause.ASSIST]=19}
this.NEUTRALIZE_PLAY_STYLE_ID={7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28}
--gameId,sourceId,neutralizeType,neutralizeCause)
function this.GetPlayStyleSaveIndex(gameId,attackerId,neutralizeType,neutralizeCause)
  if neutralizeType==NeutralizeType.INVALID then
    return
  end
  local saveUndex=this.NPC_CAUSE_TO_SAVE_INDEX[neutralizeCause]
  if saveUndex then
    return saveUndex
  end
  if neutralizeType==NeutralizeType.HOLDUP then
    return 0
  end
  if Tpp.IsPlayer(attackerId)then
    local shootCauses={[NeutralizeCause.NO_KILL_BULLET]=true,[NeutralizeCause.HANDGUN]=true,[NeutralizeCause.SUBMACHINE_GUN]=true,[NeutralizeCause.SHOTGUN]=true,[NeutralizeCause.ASSAULT_RIFLE]=true,[NeutralizeCause.MACHINE_GUN]=true,[NeutralizeCause.SNIPER_RIFLE]=true,[NeutralizeCause.MISSILE]=true}
    if shootCauses[neutralizeCause]then
      if svars.shootNeutralizeCount<MAX_32BIT_UINT then
        svars.shootNeutralizeCount=svars.shootNeutralizeCount+1
      end
    end
    local saveIndex=this.PLAYER_CAUSE_TO_SAVE_INDEX[neutralizeCause]
    if saveIndex then
      return saveIndex
    else
      return
    end
  end
end
function this.OnNeutralize(gameId,attackerId,neutralizeType,neutralizeCause)
  local playStyleSaveIndex=this.GetPlayStyleSaveIndex(gameId,attackerId,neutralizeType,neutralizeCause)
  if not playStyleSaveIndex then
    return
  end
  this.IncrementPlayDataNeutralizeCount(playStyleSaveIndex)
  if mvars.res_noResult then
    return
  end
  if svars.neutralizeCount<MAX_32BIT_UINT then
    svars.neutralizeCount=svars.neutralizeCount+1
  end
  local neutralizeCount=gvars.res_neutralizeCount[playStyleSaveIndex]
  if neutralizeCount>=255 then
    return
  end
  gvars.res_neutralizeCount[playStyleSaveIndex]=neutralizeCount+1
end
function this.IncrementPlayDataNeutralizeCount(e)
  Tpp.IncrementPlayData"totalNeutralizeCount"
  if gvars.res_neutralizeCountForPlayData[e]<MAX_32BIT_UINT then
    gvars.res_neutralizeCountForPlayData[e]=gvars.res_neutralizeCountForPlayData[e]+1
  end
end
function this.OnHeadShot(gameObjectId,attackId,attackerObjectId,flag)
  if not Tpp.IsPlayer(attackerObjectId)then
    return
  end
  local isCountUpHeadShot=this.IsCountUpHeadShot(flag)--RETAILPATCH 1070 stuff shifted into function
  if isCountUpHeadShot then
    Tpp.IncrementPlayData"totalheadShotCount"
    TppChallengeTask.RequestUpdate"PLAY_RECORD"--RETAILPATCH 1070
    TppUI.UpdateOnlineChallengeTask{detectType=29,diff=1}--RETAILPATCH 1090
  end
  if mvars.res_noResult then
    return
  end
  if isCountUpHeadShot then
    if svars.headshotCount2<MAX_32BIT_UINT then
      svars.headshotCount2=svars.headshotCount2+1
      TppUiCommand.CallCountAnnounce("playdata_playing_headshot",svars.headshotCount2,false)
    end
    if gvars.res_headShotCount[0]<255 then
      gvars.res_headShotCount[0]=gvars.res_headShotCount[0]+1
    end
  end
end
function this.IsCountUpHeadShot(headshotMessageFlag)
  local countUpHeadshot=false
  if bit.band(headshotMessageFlag,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)==HeadshotMessageFlag.IS_JUST_UNCONSCIOUS then
    if HeadshotMessageFlag.NEUTRALIZE_DONE==nil then
      countUpHeadshot=true
    else
      if bit.band(headshotMessageFlag,HeadshotMessageFlag.NEUTRALIZE_DONE)~=HeadshotMessageFlag.NEUTRALIZE_DONE then
        countUpHeadshot=true
      end
    end
  end
  return countUpHeadshot
end
function this.AddNewPlayStyleHistory()
  if gvars.res_neutralizeHistorySize<TppDefine.PLAYSTYLE_HISTORY_MAX then
    gvars.res_neutralizeHistorySize=gvars.res_neutralizeHistorySize+1
  end
  for t=(TppDefine.PLAYSTYLE_HISTORY_MAX-1),0,-1 do
    for e=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
      gvars.res_neutralizeCount[(t+1)*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+e]=gvars.res_neutralizeCount[t*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+e]
    end
    gvars.res_headShotCount[(t+1)]=gvars.res_headShotCount[t]
    gvars.res_isStealth[(t+1)]=gvars.res_isStealth[t]
    gvars.res_isPerfectStealth[(t+1)]=gvars.res_isPerfectStealth[t]
  end
  this.ClearNewestPlayStyleHistory()
end
function this.ClearNewestPlayStyleHistory()
  for e=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
    gvars.res_neutralizeCount[e]=0
  end
  gvars.res_headShotCount[0]=0
  gvars.res_isStealth[0]=false
  gvars.res_isPerfectStealth[0]=false
end
function this.GetTotalHeadShotCount()
  local e=0
  for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    e=e+gvars.res_headShotCount[t]
  end
  return e
end
function this.GetTotalNeutralizeCount()
  local e=0
  for a=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    for t=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
      e=e+gvars.res_neutralizeCount[a*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+t]
    end
  end
  return e
end
function this.IsTotalPlayStyleStealth()
  local e=true
  for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    if gvars.res_isStealth[t]==false then
      e=false
      break
    end
  end
  return e
end
function this.GetNeutralizeCountBySaveIndex(a)
  local e=0
  for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
    e=e+gvars.res_neutralizeCount[t*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+a]
  end
  return e
end
function this.DecideNeutralizePlayStyle()
  local t
  local r
  local s=-1
  for a=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
    local n=this.GetNeutralizeCountBySaveIndex(a)
    if s<n then
      t=false
      r=a
      s=n
    elseif s==this.GetNeutralizeCountBySaveIndex(a)then
      t=true
    end
  end
  if t then
    return 28
  else
    local e=this.NEUTRALIZE_PLAY_STYLE_ID[r+1]
    if e then
      return e
    else
      return
    end
  end
end
return this

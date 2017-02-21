--RETAILPATCH 1070 bunch of stuff
local this={}
--NMC indexed by RANKING_ENUM
this.IS_ONCE={false,true,true,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false}
--NMC indexed by RANKING_ENUM
this.UPDATE_ORDER={true,false,false,false,false,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true}
this.ANNOUNCE_LOG_TYPE={NONE=0,TIME=1,DISTANCE=2,NUMBER=3}
this.SHOW_ANNOUNCE_LOG={this.ANNOUNCE_LOG_TYPE.NONE,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.DISTANCE,this.ANNOUNCE_LOG_TYPE.NONE,this.ANNOUNCE_LOG_TYPE.DISTANCE,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.NONE,this.ANNOUNCE_LOG_TYPE.NONE,this.ANNOUNCE_LOG_TYPE.NONE,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME,this.ANNOUNCE_LOG_TYPE.TIME}
this.OPEN_CONDITION={
  true,
  10043,10036,10033,10041,10044,10054,10052,10086,
  function()
    if gvars.rnk_isOpen[TppDefine.RANKING_ENUM.XRocketArmNeutralizeTime]then
      return true
    end
    if vars.handEquip==TppEquip.EQP_HAND_STUN_ROCKET then
      return true
    else
      return false
    end
  end,
  10115,10115,10151,
  TppQuest.ShootingPracticeOpenCondition.Command,
  TppQuest.ShootingPracticeOpenCondition.Develop,
  TppQuest.ShootingPracticeOpenCondition.Support,
  TppQuest.ShootingPracticeOpenCondition.BaseDev,
  TppQuest.ShootingPracticeOpenCondition.Medical,
  TppQuest.ShootingPracticeOpenCondition.Spy,
  TppQuest.ShootingPracticeOpenCondition.Combat
}
local freeRoamMissions={[30010]=true,[30020]=true,[30050]=true}
--NMC: indexed by TppDefine.RANKING_ENUM
this.EXCLUDE_MISSION_LIST={
  false,--"TotalTacticalTakeDownCount",
  freeRoamMissions,--"XPersonMarkingTime",
  freeRoamMissions,--"FirstHeadShotTime",
  freeRoamMissions,--"FirstHeadShotTimeTranq",
  freeRoamMissions,--"FirstCommandPostAnnihilateTime",
  false,--"CboxGlidingDistance",
  false,--"MechaNeutralizeCount",
  false,--"LongestBirdShotDistance",
  freeRoamMissions,--"XPersonPerfectStealthCQCNeutralizeTime",
  freeRoamMissions,--"XRocketArmNeutralizeTime",
  false,--"FobSneakingGoalCount",
  false,--"FobDefenceSucceedCount",
  false,--"NuclearDisposeCount",
  false,--"mtbs_q42010",
  false,--"mtbs_q42020",
  false,--"mtbs_q42030",
  false,--"mtbs_q42040",
  false,--"mtbs_q42050",
  false,--"mtbs_q42060",
  false,--"mtbs_q42070"
}
function this.GetScore(rankingCategory)
  local rankGvarName="rnk_"..rankingCategory
  local score=gvars[rankGvarName]
  if score==nil then
    return
  end
  return score
end
function this.IncrementScore(rankingCategory)
  local currentScore=this.GetScore(rankingCategory)
  if currentScore then
    this.UpdateScore(rankingCategory,currentScore+1)
  end
end
function this.UpdateScore(rankingCategory,score)
  local rankingCategoryEnum=TppDefine.RANKING_ENUM[rankingCategory]
  if not rankingCategoryEnum then
    return
  end
  if not Tpp.IsTypeNumber(score)then
    return
  end
  if not gvars.rnk_isOpen[rankingCategoryEnum]then
    return
  end
  local excludeMission=this.CheckExcludeMission(rankingCategoryEnum,vars.missionCode)
  if excludeMission then
    return
  end
  local rankGvarName="rnk_"..rankingCategory
  if gvars[rankGvarName]==nil then
    return
  end
  local isOnce=this.IS_ONCE[rankingCategoryEnum]
  if(svars.rnk_isUpdated[rankingCategoryEnum]==false)or(isOnce==false)then
    svars.rnk_isUpdated[rankingCategoryEnum]=true
    local updateOrder=this.UPDATE_ORDER[rankingCategoryEnum]
    local updateScore
    if updateOrder then
      if gvars[rankGvarName]<score then
        updateScore=true
      else
        updateScore=false
      end
    else
      if gvars[rankGvarName]>score then
        updateScore=true
      else
        updateScore=false
      end
    end
    if updateScore then
      this.ShowUpdateScoreAnnounceLog(rankingCategoryEnum,score)
      gvars[rankGvarName]=score
    end
  else
    if isOnce then
    end
  end
end
function this.ShowUpdateScoreAnnounceLog(rankingCategoryEnum,score)
  local announceLogType=this.SHOW_ANNOUNCE_LOG[rankingCategoryEnum]
  if announceLogType==this.ANNOUNCE_LOG_TYPE.NONE then
    return
  end
  this._ShowCommonUpdateScoreAnnounceLog(rankingCategoryEnum)
  if announceLogType==this.ANNOUNCE_LOG_TYPE.TIME then
    this._ShowScoreTimeAnnounceLog(score)
  end
  if announceLogType==this.ANNOUNCE_LOG_TYPE.DISTANCE then
    this._ShowScoreDistanceAnnounceLog(score)
  end
  if announceLogType==this.ANNOUNCE_LOG_TYPE.NUMBER then
    this._ShowScoreNumberAnnounceLog(score)
  end
end
function this.GetRankingLangId(rankingCategoryEnum)
  return string.format("ranking_name_%02d",rankingCategoryEnum)
end
function this._ShowCommonUpdateScoreAnnounceLog(rankingCategoryEnum)
  TppUI.ShowAnnounceLog"trial_update"
  local rankingLangId=this.GetRankingLangId(rankingCategoryEnum)
  TppUiCommand.AnnounceLogViewLangId(rankingLangId)
end
function this._ShowScoreTimeAnnounceLog(scoreTime)
  local e=math.floor(scoreTime/6e4)
  local a=math.floor((scoreTime-e*6e4)/1e3)
  local n=(scoreTime-e*6e4)-a*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_time",e,a,n)
end
function this._ShowScoreDistanceAnnounceLog(scoreDistance)
  local e=math.floor(scoreDistance)
  local n=(scoreDistance-e)*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_length",e,n)
end
function this._ShowScoreNumberAnnounceLog(score)
  TppUiCommand.AnnounceLogViewLangId("announce_trial_num",score)
end
function this.UpdateOpenRanking()
  for key,value in pairs(this.OPEN_CONDITION)do
    local rnk_isOpen=gvars.rnk_isOpen[key]
    local isOpen=false
    if value==true then
      isOpen=true
    elseif Tpp.IsTypeNumber(value)then
      isOpen=TppStory.IsMissionCleard(value)
    elseif Tpp.IsTypeFunc(value)then
      isOpen=value()
    end
    if(((key==11)or(key==12))or(key==13))and(not rnk_isOpen)then
      if isOpen then
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.RANKING,arg1=key}
      end
    end
    gvars.rnk_isOpen[key]=isOpen
  end
end
function this.RegistMissionClearRankingResult(usedRankLimitedItem,missionCode,totalScore)
  local missionBoardId
  if usedRankLimitedItem then
    missionBoardId=RecordRanking.GetMissionLimitBordId(missionCode)
  else
    missionBoardId=RecordRanking.GetMissionBordId(missionCode)
  end
  if missionBoardId==RankingBordId.NONE then
    return
  end
  mvars.rnk_missionClearRankingResult={missionBoardId,totalScore}
end
function this.SendCurrentRankingScore()
  if RecordRanking.IsRankingBusy()then
    return
  end
  local rankingTable={}
  for rankingCategory=1,(TppDefine.RANKING_MAX-1)do
    if svars.rnk_isUpdated[rankingCategory]then
      --RETAILBUG: WTF, RANKING_ENUM takes string ranking category, but above is just an enum (but not ranking enum since ENUM indexes from 0
      local rankingCategoryEnum=TppDefine.RANKING_ENUM[rankingCategory]
      local currentScore=this.GetScore(rankingCategoryEnum)
      table.insert(rankingTable,{rankingCategory,currentScore})
    end
  end
  if mvars.rnk_missionClearRankingResult then
    table.insert(rankingTable,mvars.rnk_missionClearRankingResult)
  end
  RecordRanking.RegistRanking(rankingTable)
end
--CALLER: UpdateScore
function this.CheckExcludeMission(rankingCategoryEnum,missionCode)
  local excludeMissions=this.EXCLUDE_MISSION_LIST[rankingCategoryEnum]
  if excludeMissions then
    return excludeMissions[missionCode]
  end
  return false
end
function this.UpdateScoreTime(rankingCategory)
  this.UpdateScore(rankingCategory,svars.scoreTime)
end
function this.UpdateShootingPracticeClearTime(rankingCategory,scoreTime)
  this.UpdateScore(rankingCategory,scoreTime)
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={{msg="CBoxSlideEnd",func=this.OnCBoxSlideEnd}},
    GameObject={
      {msg="Neutralize",func=this.OnNeutralize},
      {msg="HeadShot",func=this.OnHeadShot}}
  }
end
function this.Init(missionTable)
  TppChallengeTask.RegisterCheckerFunction("PLAY_RECORD","TppRanking","CheckPlayRecordChallengeTask")
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
local n={2250,2260,2270,2280,2290,2300,2310,2320,2330,2340}
function this.CheckPlayRecordChallengeTask()
  local IsEqualOrMoreTotalFultonCount=TppTerminal.IsEqualOrMoreTotalFultonCount
  local r={IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,IsEqualOrMoreTotalFultonCount,TppResult.IsEqualOrMoreCboxGlidingDistance}
  local o={100,200,300,400,500,600,700,800,900,150}
  local t={true,2250,2260,2270,2280,2290,2300,2310,2320,true}
  local tasks={}
  for n,taskId in ipairs(n)do
    local o,t,completedTaskIdForVisible=r[n],o[n],t[n]
    local isCompleted=o(t)
    if completedTaskIdForVisible==true then
      table.insert(tasks,{taskId=taskId,isVisible=true,isCompleted=isCompleted})
    else
      table.insert(tasks,{taskId=taskId,completedTaskIdForVisible=completedTaskIdForVisible,isCompleted=isCompleted})
    end
  end
  return tasks
end
function this.OnReload(missionTable)
  this.Init(missionTable)
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.OnNeutralize(gameId,sourceId,neutralizeType,neutralizeCause)
  if neutralizeType==NeutralizeType.HOLDUP then
    PlayRecord.RegistPlayRecord"PLAYER_HOLDUP"
  end
end
function this.OnHeadShot(gameId,attackId,attackerObjectId,flag)
  if not Tpp.IsPlayer(attackerObjectId)then
    return
  end
  if bit.band(flag,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)~=HeadshotMessageFlag.IS_JUST_UNCONSCIOUS then
    return
  end
  if bit.band(flag,HeadshotMessageFlag.IS_TRANQ_HANDGUN)==HeadshotMessageFlag.IS_TRANQ_HANDGUN then
    PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT_STUN"
  else
    PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT"
  end
end
function this.OnCBoxSlideEnd(n,distance)
  local scoreDistance=distance/10
  PlayRecord.RegistPlayRecord("CBOX_SLIDING",scoreDistance)
  if(scoreDistance>gvars.rnk_CboxGlidingDistance)then
    gvars.rnk_CboxGlidingDistance=scoreDistance
    TppChallengeTask.RequestUpdate"PLAY_RECORD"
  end
end
function TppResult.IsEqualOrMoreCboxGlidingDistance(distance)
  if gvars.rnk_CboxGlidingDistance>=distance then
    return true
  else
    return false
  end
end
function this.DeclareSVars()
  return{{name="rnk_isUpdated",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION}}
end
return this

--RETAILPATCH 1070 bunch of stuff
local this={}
this.IS_ONCE={false,true,true,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false}
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
local n={[30010]=true,[30020]=true,[30050]=true}
this.EXCLUDE_MISSION_LIST={false,n,n,n,n,false,false,false,n,n,false,false,false,false,false,false,false,false,false,false}
function this.GetScore(e)
  local e="rnk_"..e
  local e=gvars[e]
  if e==nil then
    return
  end
  return e
end
function this.IncrementScore(a)
  local n=this.GetScore(a)
  if n then
    this.UpdateScore(a,n+1)
  end
end
function this.UpdateScore(a,t)
  local n=TppDefine.RANKING_ENUM[a]
  if not n then
    return
  end
  if not Tpp.IsTypeNumber(t)then
    return
  end
  if not gvars.rnk_isOpen[n]then
    return
  end
  local o=this.CheckExcludeMission(n,vars.missionCode)
  if o then
    return
  end
  local o="rnk_"..a
  if gvars[o]==nil then
    return
  end
  local r=this.IS_ONCE[n]
  if(svars.rnk_isUpdated[n]==false)or(r==false)then
    svars.rnk_isUpdated[n]=true
    local r=this.UPDATE_ORDER[n]
    local a
    if r then
      if gvars[o]<t then
        a=true
      else
        a=false
      end
    else
      if gvars[o]>t then
        a=true
      else
        a=false
      end
    end
    if a then
      this.ShowUpdateScoreAnnounceLog(n,t)
      gvars[o]=t
    end
  else
    if r then
    end
  end
end
function this.ShowUpdateScoreAnnounceLog(t,a)
  local n=this.SHOW_ANNOUNCE_LOG[t]
  if n==this.ANNOUNCE_LOG_TYPE.NONE then
    return
  end
  this._ShowCommonUpdateScoreAnnounceLog(t)
  if n==this.ANNOUNCE_LOG_TYPE.TIME then
    this._ShowScoreTimeAnnounceLog(a)
  end
  if n==this.ANNOUNCE_LOG_TYPE.DISTANCE then
    this._ShowScoreDistanceAnnounceLog(a)
  end
  if n==this.ANNOUNCE_LOG_TYPE.NUMBER then
    this._ShowScoreNumberAnnounceLog(a)
  end
end
function this.GetRankingLangId(e)
  return string.format("ranking_name_%02d",e)
end
function this._ShowCommonUpdateScoreAnnounceLog(n)
  TppUI.ShowAnnounceLog"trial_update"local e=this.GetRankingLangId(n)
  TppUiCommand.AnnounceLogViewLangId(e)
end
function this._ShowScoreTimeAnnounceLog(n)
  local e=math.floor(n/6e4)
  local a=math.floor((n-e*6e4)/1e3)
  local n=(n-e*6e4)-a*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_time",e,a,n)
end
function this._ShowScoreDistanceAnnounceLog(n)
  local e=math.floor(n)
  local n=(n-e)*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_length",e,n)
end
function this._ShowScoreNumberAnnounceLog(e)
  TppUiCommand.AnnounceLogViewLangId("announce_trial_num",e)
end
function this.UpdateOpenRanking()
  for k,v in pairs(this.OPEN_CONDITION)do
    local rnk_isOpen=gvars.rnk_isOpen[k]
    local n=false
    if v==true then
      n=true
    elseif Tpp.IsTypeNumber(v)then
      n=TppStory.IsMissionCleard(v)
    elseif Tpp.IsTypeFunc(v)then
      n=v()
    end
    if(((k==11)or(k==12))or(k==13))and(not rnk_isOpen)then
      if n then
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.RANKING,arg1=k}
      end
    end
    gvars.rnk_isOpen[k]=n
  end
end
function this.RegistMissionClearRankingResult(a,n,t)
  local e
  if a then
    e=RecordRanking.GetMissionLimitBordId(n)
  else
    e=RecordRanking.GetMissionBordId(n)
  end
  if e==RankingBordId.NONE then
    return
  end
  mvars.rnk_missionClearRankingResult={e,t}
end
function this.SendCurrentRankingScore()
  if RecordRanking.IsRankingBusy()then
    return
  end
  local n={}
  for a=1,(TppDefine.RANKING_MAX-1)do
    if svars.rnk_isUpdated[a]then
      local t=TppDefine.RANKING_ENUM[a]
      local e=this.GetScore(t)
      table.insert(n,{a,e})
    end
  end
  if mvars.rnk_missionClearRankingResult then
    table.insert(n,mvars.rnk_missionClearRankingResult)
  end
  RecordRanking.RegistRanking(n)
end
function this.CheckExcludeMission(a,n)
  local e=this.EXCLUDE_MISSION_LIST[a]
  if e then
    return e[n]
  end
  return false
end
function this.UpdateScoreTime(n)
  this.UpdateScore(n,svars.scoreTime)
end
function this.UpdateShootingPracticeClearTime(n,a)
  this.UpdateScore(n,a)
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
  local e=TppTerminal.IsEqualOrMoreTotalFultonCount
  local r={e,e,e,e,e,e,e,e,e,TppResult.IsEqualOrMoreCboxGlidingDistance}
  local o={100,200,300,400,500,600,700,800,900,150}
  local t={true,2250,2260,2270,2280,2290,2300,2310,2320,true}
  local e={}
  for n,a in ipairs(n)do
    local o,t,n=r[n],o[n],t[n]
    local t=o(t)
    if n==true then
      table.insert(e,{taskId=a,isVisible=true,isCompleted=t})
    else
      table.insert(e,{taskId=a,completedTaskIdForVisible=n,isCompleted=t})
    end
  end
  return e
end
function this.OnReload(n)
  this.Init(n)
end
function this.OnMessage(r,t,n,o,a,i,s)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,t,n,o,a,i,s)
end
function this.OnNeutralize(n,n,e,n)
  if e==NeutralizeType.HOLDUP then
    PlayRecord.RegistPlayRecord"PLAYER_HOLDUP"
  end
end
function this.OnHeadShot(a,a,n,e)
  if not Tpp.IsPlayer(n)then
    return
  end
  if bit.band(e,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)~=HeadshotMessageFlag.IS_JUST_UNCONSCIOUS then
    return
  end
  if bit.band(e,HeadshotMessageFlag.IS_TRANQ_HANDGUN)==HeadshotMessageFlag.IS_TRANQ_HANDGUN then
    PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT_STUN"
  else
    PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT"
  end
end
function this.OnCBoxSlideEnd(n,e)
  local e=e/10
  PlayRecord.RegistPlayRecord("CBOX_SLIDING",e)
  if(e>gvars.rnk_CboxGlidingDistance)then
    gvars.rnk_CboxGlidingDistance=e
    TppChallengeTask.RequestUpdate"PLAY_RECORD"
  end
end
function TppResult.IsEqualOrMoreCboxGlidingDistance(e)
  if gvars.rnk_CboxGlidingDistance>=e then
    return true
  else
    return false
  end
end
function this.DeclareSVars()
  return{{name="rnk_isUpdated",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION}}
end
return this

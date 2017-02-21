local this={}
local r=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
this.TYPE=Tpp.Enum{"MIN","COMMON","CASSET_TAPE","KEY_ITEM","BLUE_PRINT","EMBLEM","ANIMAL","RANKING","MAX"}
this.REWARD_FIRST_LANG={
  [this.TYPE.COMMON]=nil,
  [this.TYPE.CASSET_TAPE]=nil,
  [this.TYPE.KEY_ITEM]="announce_find_keyitem",
  [this.TYPE.BLUE_PRINT]="announce_get_blueprint",
  [this.TYPE.EMBLEM]=nil,
  [this.TYPE.ANIMAL]="announce_extract_animal",
  [this.TYPE.RANKING]="reward_607"}
this.REWARD_MAX={[TppScriptVars.CATEGORY_MISSION]=TppDefine.REWARD_MAX.MISSION,[TppScriptVars.CATEGORY_MB_MANAGEMENT]=TppDefine.REWARD_MAX.MB_MANAGEMENT,[TppScriptVars.CATEGORY_QUEST]=TppDefine.REWARD_MAX.QUEST}
this.LANG_ENUM={[TppScriptVars.CATEGORY_MISSION]=Tpp.Enum{"reward_fob_goal_staff","reward_fob_goal_resources","reward_fob_goal_herbs","reward_fob_goal_wormhole"},[TppScriptVars.CATEGORY_MB_MANAGEMENT]=Tpp.Enum{"key_item_3013","key_item_3003","key_item_3008","reward_100","reward_101","reward_102","reward_103","reward_104","reward_105","reward_106","reward_107","reward_108","reward_109","reward_110","reward_111","reward_112","reward_113","reward_300","reward_301","reward_302","reward_303","reward_304","reward_305","reward_306","reward_400","reward_401","reward_402","reward_403","reward_404","reward_405","reward_406","reward_500","reward_501","reward_502","reward_503","reward_504","reward_600","reward_601","reward_602","reward_603","reward_604","reward_605","reward_606","reward_607","dummy","reward_114","reward_115","key_item_3014","key_item_3015","key_item_3016","key_item_3017","key_item_3018","key_item_3019","key_item_3007","reward_307","key_item_3010","key_item_3020"},[TppScriptVars.CATEGORY_QUEST]=Tpp.Enum{"dummy"}}
this.GVARS_NAME={[TppScriptVars.CATEGORY_MISSION]={langEnumName="rwd_missionRewardLangEnum",stackSizeName="rwd_missionRewardStackSize",paramName="rwd_missionRewardParam"},[TppScriptVars.CATEGORY_MB_MANAGEMENT]={langEnumName="rwd_mbManagementRewardLangEnum",stackSizeName="rwd_mbManagementRewardStackSize",paramName="rwd_mbManagementRewardParam"},[TppScriptVars.CATEGORY_QUEST]={langEnumName="rwd_questRewardLangEnum",stackSizeName="rwd_questRewardStackSize",paramName="rwd_questRewardParam"}}
this.RADIO_GROUP_NAME={[5]="f6000_rtrg2010",[6]="f6000_rtrg2020",[7]="f6000_rtrg2030",[8]="f6000_rtrg2040",[10]="f6000_rtrg2050",[11]="f6000_rtrg2060",[20]="f6000_rtrg2130",[22]="f6000_rtrg2140",[30]="f6000_rtrg2150",[25]="f6000_rtrg2160",[55]="f6000_rtrg2270"}
function this.Push(rewardInfo)
  if not IsTable(rewardInfo)then
    return
  end
  if this.DEBUG_IgnorePush then
    if this.DEBUG_isIgnorePushReward then
      return
    end
  end
  local category=rewardInfo.category
  local langId=rewardInfo.langId
  local rewardType=rewardInfo.rewardType
  local arg1=rewardInfo.arg1 or 0
  local arg2=rewardInfo.arg2 or 0
  if not(((rewardType)and(rewardType>this.TYPE.MIN))and(rewardType<this.TYPE.MAX))then
    return
  end
  local stackSizeName=this.GVARS_NAME[category].stackSizeName
  local langEnumName=this.GVARS_NAME[category].langEnumName
  local paramName=this.GVARS_NAME[category].paramName
  if not stackSizeName then
    return
  end
  local langEnum=this.LANG_ENUM[category][langId]
  if not langEnum then
    return
  end
  local _stackSize=gvars[stackSizeName]
  local n=this.REWARD_MAX[category]
  local stackSize=_stackSize
  if(rewardType==this.TYPE.CASSET_TAPE)then
    if mvars then
      mvars.rwd_cassetTapeLangIdRegisted=mvars.rwd_cassetTapeLangIdRegisted or{}
      if mvars.rwd_cassetTapeLangIdRegisted[arg1]then
        return
      else
        mvars.rwd_cassetTapeLangIdRegisted[arg1]=true
      end
    end
  elseif(rewardType==this.TYPE.EMBLEM)then
  elseif(rewardType==this.TYPE.RANKING)then
  else
    for e=0,_stackSize do
      local r=gvars[langEnumName][e]
      if r==langEnum then
        stackSize=e
        break
      end
    end
  end
  if stackSize>n then
    return
  end
  if stackSize==_stackSize then
    gvars[stackSizeName]=_stackSize+1
  end
  gvars[langEnumName][stackSize]=langEnum
  this.SetParameters(paramName,stackSize,rewardType,arg1,arg2)
end
function this.PushBluePrintReward(e)
end
function this.ShowAllReward()
  for r,a in pairs(this.GVARS_NAME)do
    this.ShowReward(r)
  end
  if TppUiCommand.GetBonusPopupRegist"animal">0 then
    TppUiCommand.ShowBonusPopupRegist"animal"
    end
  if TppUiCommand.GetBonusPopupRegist"staff">0 then
    TppUiCommand.ShowBonusPopupRegist"staff"
    end
  local e=TppRadio.DoEventOnRewardEndRadio()
  if next(e)then
    TppUiCommand.SetBonusPopupAfterRadio(e[1])
  end
end
function this.IsStacked()
  for r,e in pairs(this.GVARS_NAME)do
    local e=e.stackSizeName
    local e=gvars[e]
    if e>0 then
      return true
    end
  end
  if TppUiCommand.GetBonusPopupRegist"animal">0 then
    return true
  end
  if TppUiCommand.GetBonusPopupRegist"staff">0 then
    return true
  end
  if#TppRadio.DoEventOnRewardEndRadio()>0 then
    return true
  end
  return false
end
function this.ShowReward(r)
  local a=this.GVARS_NAME[r].stackSizeName
  local t=this.GVARS_NAME[r].langEnumName
  local i=this.GVARS_NAME[r].paramName
  if not a then
    return
  end
  local n=gvars[a]
  if n<=0 then
    return
  end
  local o=gvars[t]
  for a=0,(n-1)do
    local n,t,i=this.GetParameters(i,a)
    this.ShowBonusPopup(r,n,o[a],t,i)
  end
  gvars[a]=0
end
function this.ShowBonusPopup(i,r,t,o,d)
  local a=this.LANG_ENUM[i][t]
  if not a then
    return
  end
  local n=this.REWARD_FIRST_LANG[r]
  if r==this.TYPE.COMMON then
    TppUiCommand.ShowBonusPopupCommon(a)
    this.ShowBonusPopupCategory(r,a,t)
    if i==TppScriptVars.CATEGORY_MB_MANAGEMENT then
      local e=this.RADIO_GROUP_NAME[t]
      if e then
        TppUiCommand.SetBonusPopupRadio(a,e)
      end
    end
  elseif r==this.TYPE.CASSET_TAPE then
    TppUiCommand.ShowBonusPopupItemTape(o)
  elseif r==this.TYPE.EMBLEM then
    TppUiCommand.ShowBonusPopupEmblem(o,d)
  elseif r==this.TYPE.RANKING then
    local a=TppRanking.GetRankingLangId(o)
    TppUiCommand.ShowBonusPopupCommon(n,a)
    this.ShowBonusPopupCategory(r,n,t)
  elseif n then
    TppUiCommand.ShowBonusPopupCommon(n,a)
    this.ShowBonusPopupCategory(r,n,t)
  end
end
function this.SetParameters(r,a,o,i,t)
  local n,e,a=this.GetParameterOffsets(a)
  gvars[r][n]=o
  gvars[r][e]=i
  gvars[r][a]=t
end
function this.GetParameters(r,a)
  local a,e,n=this.GetParameterOffsets(a)
  local a=gvars[r][a]
  local e=gvars[r][e]
  local r=gvars[r][n]
  return a,e,r
end
function this.GetParameterOffsets(e)
  local e=e*TppDefine.REWARD_PARAM.MAX
  local r=e+TppDefine.REWARD_PARAM.TYPE
  local a=e+TppDefine.REWARD_PARAM.ARG1
  local e=e+TppDefine.REWARD_PARAM.ARG2
  return r,a,e
end
function this.ShowBonusPopupCategory(r,a,n)
  if r==this.TYPE.COMMON then
    this.ShowBonusPopupCategoryCommon(a,n)
  elseif r==this.TYPE.CASSET_TAPE then
  elseif r==this.TYPE.KEY_ITEM then
    TppUiCommand.SetBonusPopupCategory(a,"keyitem")
  elseif r==this.TYPE.BLUE_PRINT then
    TppUiCommand.SetBonusPopupCategory(a,"devfile")
  elseif r==this.TYPE.EMBLEM then
  elseif r==this.TYPE.ANIMAL then
  elseif r==this.TYPE.RANKING then
    TppUiCommand.SetBonusPopupCategory(a,"trial")
  end
end
function this.GetBonusPopupCategory(e)
  if e<4 then
    return"keyitem"elseif e<18 then
    return"motherbase"elseif e<25 then
    return"develop"elseif e<32 then
    return"custom"elseif e<37 then
    return"callmenu"elseif e==37 then
  elseif e==38 then
    return"devfile"elseif e==39 then
    return"keyitem"elseif e<43 then
  elseif e==43 then
  elseif e==44 then
    return"trial"elseif e==45 then
  elseif e<48 then
    return"motherbase"elseif e<55 then
    return"keyitem"elseif e==55 then
    return"develop"elseif e<58 then
    return"keyitem"end
  return nil
end
function this.ShowBonusPopupCategoryCommon(r,a)
  local e=this.GetBonusPopupCategory(a)
  if e~=nil then
    TppUiCommand.SetBonusPopupCategory(r,e)
  end
end
return this

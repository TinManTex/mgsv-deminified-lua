-- DOBUILD: 1
local this={}
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
function this._Random(min,max)
  local revRandomVal=gvars.rev_revengeRandomValue
  if min>max then
    local e=min
    min=max
    max=e
  end
  local E=(max-min)+1
  return(revRandomVal%E)+min
end
this.NO_REVENGE_MISSION_LIST={
  [10010]=true,--prologue
  [10030]=true,--diamond dogd
  [10050]=true,--cloaked in silence
  [11050]=true,--cloaked extr
  [10120]=true,--white mambe
  [10140]=true,--metallic archaea
  [11140]=true,--archaea extr
  [10151]=true,--sahel
  [10230]=true,--???
  [10240]=true,--shining lights
  [10280]=true,--man who sold the world
  [30050]=true,--mb free
  [40010]=true,--helispace
  [40020]=true,--helispace
  [40050]=true,--helispace
  [50050]=true--fob
}
this.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST={[30010]=true,[30020]=true,[30050]=true,[30150]=true}
this.USE_SUPER_REINFORCE_VEHICLE_MISSION={[10036]=true,[11036]=true,[10093]=true}
this.CANNOT_USE_ALL_WEAPON_MISSION={
  [10030]=true,--Mission 2 - Flashback Diamond Dogs
  [10070]=true,--Mission 12 - Hellbound
  [10080]=true,--Mission 13 - Pitch Dark
  [11080]=true,
  [10090]=true,--Mission 16 - Traitors Caravan
  [11090]=true,
  [10151]=true,--Mission 31 - Sahelanthropus
  [11151]=true,--
  [10211]=true,--Mission 26 - Hunting Down
  [11211]=true,--Hunting down hard?
  [30050]=true--mbfree
}
this.REVENGE_TYPE_NAME={"STEALTH","NIGHT_S","COMBAT","NIGHT_C","LONG_RANGE","VEHICLE","HEAD_SHOT","TRANQ","FULTON","SMOKE","M_STEALTH","M_COMBAT","DUMMY","DUMMY2","DUMMY3","DUMMY4","MAX"}
this.REVENGE_TYPE=TppDefine.Enum(this.REVENGE_TYPE_NAME)
this.REVENGE_LV_LIMIT_RANK_MAX=6
this.REVENGE_LV_MAX={
  [this.REVENGE_TYPE.STEALTH]={0,1,2,3,4,5},
  [this.REVENGE_TYPE.NIGHT_S]={0,1,1,2,3,3},
  [this.REVENGE_TYPE.COMBAT]={0,1,2,3,4,5},
  [this.REVENGE_TYPE.NIGHT_C]={0,1,1,1,1,1},
  [this.REVENGE_TYPE.LONG_RANGE]={0,1,1,2,2,2},
  [this.REVENGE_TYPE.VEHICLE]={0,1,1,2,3,3},
  [this.REVENGE_TYPE.HEAD_SHOT]={0,1,2,3,5,7},
  [this.REVENGE_TYPE.TRANQ]={0,1,1,1,1,1},
  [this.REVENGE_TYPE.FULTON]={0,1,2,2,3,3},
  [this.REVENGE_TYPE.SMOKE]={0,1,1,2,3,3},
  [this.REVENGE_TYPE.M_STEALTH]={9,9,9,9,9,9},
  [this.REVENGE_TYPE.M_COMBAT]={9,9,9,9,9,9}
}
this.REVENGE_POINT_OVER_MARGINE=100-1
this.REVENGE_POINT_PER_LV=100
this.REDUCE_REVENGE_POINT=10
this.REDUCE_TENDENCY_POINT_TABLE={
  [this.REVENGE_TYPE.STEALTH]={-20,-20,-20,-20,-25,-50},
  [this.REVENGE_TYPE.COMBAT]={-20,-20,-20,-20,-25,-50}
}
this.REDUCE_POINT_TABLE={
  [this.REVENGE_TYPE.NIGHT_S]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},
  [this.REVENGE_TYPE.NIGHT_C]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},
  [this.REVENGE_TYPE.SMOKE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},
  [this.REVENGE_TYPE.LONG_RANGE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},
  [this.REVENGE_TYPE.VEHICLE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50}
}
this.REVENGE_TRIGGER_TYPE={
  HEAD_SHOT=1,
  ELIMINATED_IN_STEALTH=2,
  ELIMINATED_IN_COMBAT=3,
  FULTON=4,
  SMOKE=5,
  KILLED_BY_HELI=6,
  ANNIHILATED_IN_STEALTH=7,
  ANNIHILATED_IN_COMBAT=8,
  WAKE_A_COMRADE=9,
  DISCOVERY_AT_NIGHT=10,
  ELIMINATED_AT_NIGHT=11,
  SNIPED=12,
  KILLED_BY_VEHICLE=13,
  WATCH_SMOKE=14
}
this.BLOCKED_TYPE={GAS_MASK=0,HELMET=1,CAMERA=2,DECOY=3,MINE=4,NVG=5,SHOTGUN=6,MG=7,SOFT_ARMOR=8,SHIELD=9,ARMOR=10,GUN_LIGHT=11,SNIPER=12,MISSILE=13,MAX=14}
this.BLOCKED_FOR_MISSION_COUNT=3
this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST={
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]=this.BLOCKED_TYPE.GAS_MASK,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]=this.BLOCKED_TYPE.HELMET,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]=this.BLOCKED_TYPE.CAMERA,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]=this.BLOCKED_TYPE.DECOY,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]=this.BLOCKED_TYPE.MINE,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]=this.BLOCKED_TYPE.NVG,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]=this.BLOCKED_TYPE.SHOTGUN,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]=this.BLOCKED_TYPE.MG,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]=this.BLOCKED_TYPE.SOFT_ARMOR,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]=this.BLOCKED_TYPE.SHIELD,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]=this.BLOCKED_TYPE.ARMOR,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]=this.BLOCKED_TYPE.GUN_LIGHT,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]=this.BLOCKED_TYPE.SNIPER,
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]=this.BLOCKED_TYPE.MISSILE
}
this.DEPLOY_REVENGE_MISSION_CONDITION_LIST={
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]={revengeType=this.REVENGE_TYPE.SMOKE,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]={revengeType=this.REVENGE_TYPE.HEAD_SHOT,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]={revengeType=this.REVENGE_TYPE.STEALTH,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]={revengeType=this.REVENGE_TYPE.STEALTH,lv=2},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]={revengeType=this.REVENGE_TYPE.STEALTH,lv=3},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]={revengeType=this.REVENGE_TYPE.NIGHT_S,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]={revengeType=this.REVENGE_TYPE.COMBAT,lv=2},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]={revengeType=this.REVENGE_TYPE.COMBAT,lv=3},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]={revengeType=this.REVENGE_TYPE.NIGHT_C,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]={revengeType=this.REVENGE_TYPE.LONG_RANGE,lv=1},
  [TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]={revengeType=this.REVENGE_TYPE.VEHICLE,lv=1}
}
this.REVENGE_POINT_TABLE={
  [this.REVENGE_TRIGGER_TYPE.HEAD_SHOT]=              {[this.REVENGE_TYPE.HEAD_SHOT]= 5},
  [this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH]=  {[this.REVENGE_TYPE.M_STEALTH]= 5},
  [this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT]=   {[this.REVENGE_TYPE.M_COMBAT]=  5},
  [this.REVENGE_TRIGGER_TYPE.FULTON]=                 {[this.REVENGE_TYPE.FULTON]=    15},
  [this.REVENGE_TRIGGER_TYPE.SMOKE]=                  {[this.REVENGE_TYPE.SMOKE]=     15},
  [this.REVENGE_TRIGGER_TYPE.WATCH_SMOKE]=            {[this.REVENGE_TYPE.SMOKE]=     15},
  [this.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI]=         {[this.REVENGE_TYPE.VEHICLE]=   10},
  [this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH]= {[this.REVENGE_TYPE.M_STEALTH]= 15},
  [this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT]=  {[this.REVENGE_TYPE.M_COMBAT]=  15},
  [this.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE]=         {[this.REVENGE_TYPE.TRANQ]=     5},
  [this.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT]=     {[this.REVENGE_TYPE.NIGHT_S]=   15},
  [this.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT]=    {[this.REVENGE_TYPE.NIGHT_C]=   10},
  [this.REVENGE_TRIGGER_TYPE.SNIPED]=                 {[this.REVENGE_TYPE.LONG_RANGE]=30},
  [this.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE]=      {[this.REVENGE_TYPE.VEHICLE]=   10}
}
this.MISSION_TENDENCY_POINT_TABLE={
  STEALTH={STEALTH={25,25,25,25,50,50}, COMBAT={0,0,-5,-10,-50,-50}},
  DRAW=   {STEALTH={20,20,20,0,-25,-10},COMBAT={20,20,20,0,-25,-10}},
  COMBAT= {STEALTH={0,0,-5,-10,-50,-50},COMBAT={25,25,25,25,50,50}}
}
this.revengeDefine={
  HARD_MISSION={IGNORE_BLOCKED=true},
  _ENABLE_CAMERA_LV=1,
  _ENABLE_DECOY_LV=2,
  _ENABLE_MINE_LV=3,
  STEALTH_0={
    STEALTH_LOW=true,
    HOLDUP_LOW=true
  },
  STEALTH_1={
    CAMERA="100%",
    HOLDUP_LOW=true
  },
  STEALTH_2={
    DECOY="100%",
    CAMERA="100%"
  },
  STEALTH_3={
    DECOY="100%",
    MINE="100%",
    CAMERA="100%",
    STEALTH_HIGH=true
  },
  STEALTH_4={
    DECOY="100%",
    MINE="100%",
    CAMERA="100%",
    STEALTH_HIGH=true,
    HOLDUP_HIGH=true,
    ACTIVE_DECOY=true,
    GUN_CAMERA=true},
  STEALTH_5={
    DECOY="100%",
    MINE="100%",
    CAMERA="100%",
    STEALTH_SPECIAL=true,
    HOLDUP_HIGH=true,
    ACTIVE_DECOY=true,
    GUN_CAMERA=true},
  NIGHT_S_1={NVG="25%"},
  NIGHT_S_2={NVG="50%"},
  NIGHT_S_3={NVG="75%"},
  _ENABLE_SOFT_ARMOR_LV=1,
  _ENABLE_SHOTGUN_LV=1,
  _ENABLE_MG_LV=1,
  _ENABLE_SHIELD_LV=2,
  _ENABLE_ARMOR_LV=3,
  COMBAT_0={COMBAT_LOW=true},
  --tex added MG_OR_SHOTGUN to all-v-
  COMBAT_1={
    {SOFT_ARMOR="25%",SHOTGUN=2,MG_OR_SHOTGUN=2},
    {SOFT_ARMOR="25%",MG=2,MG_OR_SHOTGUN=2}
  },
  COMBAT_2={
    {SOFT_ARMOR="50%",SHOTGUN=2,MG_OR_SHOTGUN=2,SHIELD=1},
    {SOFT_ARMOR="50%",MG=2,MG_OR_SHOTGUN=2,SHIELD=1}
  },
  COMBAT_3={
    {SOFT_ARMOR="75%",SHOTGUN=2,MG_OR_SHOTGUN=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true},
    {SOFT_ARMOR="75%",MG=2,MG_OR_SHOTGUN=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true}
  },
  COMBAT_4={
    {SOFT_ARMOR="100%",SHOTGUN=4,MG_OR_SHOTGUN=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2},
    {SOFT_ARMOR="100%",MG=4,MG_OR_SHOTGUN=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2}
  },
  COMBAT_5={
    {SOFT_ARMOR="100%",SHOTGUN=4,MG_OR_SHOTGUN=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3},
    {SOFT_ARMOR="100%",MG=4,MG_OR_SHOTGUN=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3}
  },
  NIGHT_C_1={GUN_LIGHT="75%"},
  LONG_RANGE_1={SNIPER=2},
  LONG_RANGE_2={
    SNIPER=2,
    STRONG_SNIPER=true
  },
  VEHICLE_1={MISSILE=2},
  VEHICLE_2={
    MISSILE=2,
    STRONG_MISSILE=true
  },
  VEHICLE_3={
    MISSILE=4,
    STRONG_MISSILE=true
  },
  HEAD_SHOT_1={HELMET="10%"},
  HEAD_SHOT_2={HELMET="20%"},
  HEAD_SHOT_3={HELMET="30%"},
  HEAD_SHOT_4={HELMET="40%"},
  HEAD_SHOT_5={HELMET="50%"},
  HEAD_SHOT_6={HELMET="60%"},
  HEAD_SHOT_7={HELMET="70%"},
  HEAD_SHOT_8={HELMET="80%"},
  HEAD_SHOT_9={HELMET="90%"},
  HEAD_SHOT_10={HELMET="100%"},
  TRANQ_1={STRONG_NOTICE_TRANQ=true},
  FULTON_0={},
  FULTON_1={FULTON_LOW=true},
  FULTON_2={FULTON_HIGH=true},
  FULTON_3={FULTON_SPECIAL=true},--RETAILBUG: fulton was 0 low 1 blank 2 high,now 0 blank 1 low 2 high
  SMOKE_1={GAS_MASK="25%"},
  SMOKE_2={GAS_MASK="50%"},
  SMOKE_3={GAS_MASK="75%"},
  FOB_NoKill={NO_KILL_WEAPON=true},
  FOB_EquipGrade_1={EQUIP_GRADE_LIMIT=1},
  FOB_EquipGrade_2={EQUIP_GRADE_LIMIT=2},
  FOB_EquipGrade_3={EQUIP_GRADE_LIMIT=3},
  FOB_EquipGrade_4={EQUIP_GRADE_LIMIT=4},
  FOB_EquipGrade_5={EQUIP_GRADE_LIMIT=5},
  FOB_EquipGrade_6={EQUIP_GRADE_LIMIT=6},
  FOB_EquipGrade_7={EQUIP_GRADE_LIMIT=7},
  FOB_EquipGrade_8={EQUIP_GRADE_LIMIT=8},
  FOB_EquipGrade_9={EQUIP_GRADE_LIMIT=9},
  FOB_EquipGrade_10={EQUIP_GRADE_LIMIT=10},
  FOB_ShortRange={SHOTGUN="30%",SHIELD="60%",SMG="100%"},
  FOB_MiddleRange={MG="40%",MISSILE="15%"},
  FOB_LongRange={SNIPER="50%"},
  FOB_ShortRange_1={},
  FOB_ShortRange_2={SHOTGUN="10%"},
  FOB_ShortRange_3={SHOTGUN="10%"},
  FOB_ShortRange_4={SMG="10%",SHOTGUN="10%",SHIELD="10%"},
  FOB_ShortRange_5={SMG="10%",SHOTGUN="10%",SHIELD="10%"},
  FOB_ShortRange_6={SMG="20%",SHOTGUN="10%",SHIELD="20%"},
  FOB_ShortRange_7={SMG="20%",SHOTGUN="20%",SHIELD="20%"},
  FOB_ShortRange_8={STRONG_WEAPON=true,SMG="20%",SHOTGUN="20%",SHIELD="20%"},
  FOB_ShortRange_9={STRONG_WEAPON=true,SMG="20%",SHOTGUN="25%",SHIELD="20%"},
  FOB_ShortRange_10={STRONG_WEAPON=true,SMG="30%",SHOTGUN="30%",SHIELD="30%"},
  FOB_MiddleRange_1={},
  FOB_MiddleRange_2={MG="10%"},
  FOB_MiddleRange_3={MG="10%"},
  FOB_MiddleRange_4={MG="20%"},
  FOB_MiddleRange_5={MG="20%"},
  FOB_MiddleRange_6={STRONG_WEAPON=true,MG="20%"},
  FOB_MiddleRange_7={STRONG_WEAPON=true,MG="30%"},
  FOB_MiddleRange_8={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%"},
  FOB_MiddleRange_9={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%",MISSILE="10%"},
  FOB_MiddleRange_10={STRONG_WEAPON=true,MG="40%",SHOTGUN="10%",SNIPER="10%",MISSILE="10%"},
  FOB_LongRange_1={},
  FOB_LongRange_2={SNIPER="10%"},
  FOB_LongRange_3={SNIPER="10%"},
  FOB_LongRange_4={SNIPER="15%"},
  FOB_LongRange_5={STRONG_SNIPER=true,SNIPER="15%"},
  FOB_LongRange_6={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},
  FOB_LongRange_7={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},
  FOB_LongRange_8={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="20%",MISSILE="10%"},
  FOB_LongRange_9={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="25%",MISSILE="10%"},
  FOB_LongRange_10={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="30%",MISSILE="20%",MG="10%"}
}
function this.SelectRevengeType()
  local missionCode=TppMission.GetMissionID()
  if (this.IsNoRevengeMission(missionCode)or missionCode==10115) and Ivars.disableNoRevengeMissions:Is(0) then--tex added disable --NMC retake the platform, not revenge mission because mb/ddogs use different system?
    if missionCode~=30050 or Ivars.revengeModeForMb:Is()<=Ivars.revengeModeForMb.enum.FOB then --tex added check
      return{}
  end
  end
  local isHardMission=TppMission.IsHardMission(missionCode)
  local revengeTypes={}
  for typeIndex=0,this.REVENGE_TYPE.MAX-1 do
    local revengeLevel=this.GetRevengeLv(typeIndex)--tex moved if ishard getlv max else getlv into getlv itself
    if revengeLevel>=0 then
      local revengeTypeName=this.REVENGE_TYPE_NAME[typeIndex+1]..("_"..tostring(revengeLevel))
      local category=this.revengeDefine[revengeTypeName]
      if category then
        table.insert(revengeTypes,revengeTypeName)
      end
    end
  end
  if isHardMission then
    table.insert(revengeTypes,"HARD_MISSION")
  end
  return revengeTypes
end
--ORIG:
--function e.SelectRevengeType()
--  local n=TppMission.GetMissionID()
--  if e.IsNoRevengeMission(n)or n==10115 then
--    return{}
--  end
--  local r=TppMission.IsHardMission(n)
--  local t={}
--  for E=0,e.REVENGE_TYPE.MAX-1 do
--    local n
--    if r then
--      n=e.GetRevengeLvMax(E,REVENGE_LV_LIMIT_RANK_MAX)
--    else
--      n=e.GetRevengeLv(E)
--    end
--    if n>=0 then
--      local n=e.REVENGE_TYPE_NAME[E+1]..("_"..tostring(n))
--      local e=e.revengeDefine[n]
--      if e then
--        table.insert(t,n)
--      end
--    end
--  end
--  if r then
--    table.insert(t,"HARD_MISSION")
--  end
--  return t
--end

--SINGLE CASE: revengeType ==mtbs_enemy._GetEquipTable > DecideRevenge > revenge_forceRevengeType
function this.SetForceRevengeType(revengeType)
  if not Tpp.IsTypeTable(revengeType)then
    revengeType={revengeType}
  end
  mvars.revenge_forceRevengeType=revengeType
end
function this.IsNoRevengeMission(missionCode)
  if missionCode==nil then
    return false
  end
  local e=this.NO_REVENGE_MISSION_LIST[missionCode]
  if e==nil then
    return false
  end
  return e
end
function this.IsNoStealthCombatRevengeMission(missionCode)
  if missionCode==nil then
    return false
  end
  local e=this.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST[missionCode]
  if e==nil then
    return false
  end
  return e
end
function this.GetEquipGradeLimit()
  return mvars.revenge_revengeConfig.EQUIP_GRADE_LIMIT
end
function this.IsUsingNoKillWeapon()
  return mvars.revenge_revengeConfig.NO_KILL_WEAPON
end
function this.IsUsingStrongWeapon()
  return mvars.revenge_revengeConfig.STRONG_WEAPON
end
function this.IsUsingStrongMissile()
  return mvars.revenge_revengeConfig.STRONG_MISSILE
end
function this.IsUsingStrongSniper()
  return mvars.revenge_revengeConfig.STRONG_SNIPER
end
function this.IsUsingSuperReinforce()
  if Ivars.forceSuperReinforce:Is"FORCE_CONFIG" then--tex
    return true
  end--

  if not mvars.revenge_isEnabledSuperReinforce then--NMC: as far as I can see only quest heli setup sets this false
    return false
  end
  return mvars.revenge_revengeConfig.SUPER_REINFORCE
end
function this.IsUsingBlackSuperReinforce()
  return mvars.revenge_revengeConfig.BLACK_SUPER_REINFORCE
end
function this.GetReinforceCount()
  --  if not Ivars.reinforceCount:IsDefault() then--tex>--CULL
  --    return Ivars.reinforceCount:Get()
  --  end--<

  local count=mvars.revenge_revengeConfig.REINFORCE_COUNT
  if count then
    return count+0
  end
  return 1
end
function this.CanUseArmor(soldierSubType)
  if TppEneFova==nil then
    return false
  end
  local missionId=TppMission.GetMissionID()
  if TppEneFova.IsNotRequiredArmorSoldier(missionId)then
    return false
  end
  if soldierSubType then
    return TppEneFova.CanUseArmorType(missionId,soldierSubType)
  end
  return true
end
local RateFromCategoryString=function(categoryString)
  if categoryString==nil then
    return 0
  end
  return(categoryString:sub(1,-2)+0)/100
end
function this.GetMineRate()
  return RateFromCategoryString(mvars.revenge_revengeConfig.MINE)
end
function this.GetDecoyRate()
  return RateFromCategoryString(mvars.revenge_revengeConfig.DECOY)
end
function this.IsUsingActiveDecoy()
  return mvars.revenge_revengeConfig.ACTIVE_DECOY
end
function this.GetCameraRate()
  return RateFromCategoryString(mvars.revenge_revengeConfig.CAMERA)
end
function this.IsUsingGunCamera()
  return mvars.revenge_revengeConfig.GUN_CAMERA
end
function this.GetPatrolRate()
  if mvars.revenge_revengeConfig.STRONG_PATROL then
    return 1
  else
    return 0
  end
end
function this.IsIgnoreBlocked()
  return mvars.revenge_revengeConfig.IGNORE_BLOCKED
end
function this.IsBlocked(category)
  --  if Ivars.revengeMode:Is"MAX" or Ivars.revengeModeForMissions:Is"MAX" then--tex revengemax--CULL
  --    return false
  --  end--
  if category==nil then
    return false
  end
  return gvars.rev_revengeBlockedCount[category]>0
end
function this.SetEnabledSuperReinforce(enabled)
  mvars.revenge_isEnabledSuperReinforce=enabled
end
function this.SetHelmetAll()
  mvars.revenge_revengeConfig.HELMET="100%"
end
function this.RegisterMineList(n,E)
  if not mvars.rev_usingBase then
    return
  end
  mvars.rev_mineBaseTable={}
  for n,e in ipairs(n)do
    if mvars.rev_usingBase[e]then
      mvars.rev_mineBaseTable[e]=n-1
    end
  end
  mvars.rev_mineBaseList=n
  mvars.rev_mineBaseCountMax=#n
  this.RegisterCommonMineList(E)
end
function this.RegisterCommonMineList(E)
  mvars.rev_mineTrapTable={}
  for n,e in pairs(E)do
    if mvars.rev_usingBase[n]then
      for E,e in ipairs(e)do
        local e=e.trapName
        local n={areaIndex=E,trapName=e,baseName=n}
        mvars.rev_mineTrapTable[Fox.StrCode32(e)]=n
      end
    end
  end
  mvars.rev_revengeMineList={}
  for n,E in pairs(E)do
    if mvars.rev_usingBase[n]then
      mvars.rev_revengeMineList[n]={}
      if Tpp.IsTypeTable(E)then
        if next(E)then
          for E,t in ipairs(E)do
            mvars.rev_revengeMineList[n][E]={}
            this._CopyRevengeMineArea(mvars.rev_revengeMineList[n][E],t,n,E)
          end
          local e=E.decoyLocatorList
          if e then
            mvars.rev_revengeMineList[n].decoyLocatorList={}
            for E,e in ipairs(e)do
              table.insert(mvars.rev_revengeMineList[n].decoyLocatorList,e)
            end
          end
        end
      end
    end
  end
end
function this.RegisterMissionMineList(n)
  for n,E in pairs(n)do
    this.AddBaseMissionMineList(n,E)
  end
end
function this.AddBaseMissionMineList(e,n)
  local mineListForAreas=mvars.rev_revengeMineList[e]
  if not mineListForAreas then
    return
  end
  if not Tpp.IsTypeTable(n)then
    return
  end
  local E=n.decoyLocatorList
  if E then
    local n=mvars.rev_revengeMineList[e].decoyLocatorList
    mvars.rev_revengeMineList[e].decoyLocatorList=mvars.rev_revengeMineList[e].decoyLocatorList or{}
    for E,n in ipairs(E)do
      table.insert(mvars.rev_revengeMineList[e].decoyLocatorList,n)
    end
  end
  for t,r in pairs(n)do
    local e=mvars.rev_mineTrapTable[Fox.StrCode32(t)]
    if e then
      local areaIndex=e.areaIndex
      local mineList=mineListForAreas[areaIndex]
      local mineLocatorList=r.mineLocatorList
      if mineLocatorList then
        mineList.mineLocatorList=mineList.mineLocatorList or{}
        for E,n in ipairs(mineLocatorList)do
          table.insert(mineList.mineLocatorList,n)
        end
      end
      if not E then
        local n=r.decoyLocatorList
        if n then
          mineList.decoyLocatorList=mineList.decoyLocatorList or{}
          for E,n in ipairs(n)do
            table.insert(mineList.decoyLocatorList,n)
          end
        end
      end
    else
      if t~="decoyLocatorList"then
      end
    end
  end
end
function this._CopyRevengeMineArea(e,n,E,E)
  local trapName=n.trapName
  if trapName then
    e.trapName=trapName
  else
    return
  end
  local mineLocatorList=n.mineLocatorList
  if mineLocatorList then
    e.mineLocatorList={}
    for E,n in ipairs(mineLocatorList)do
      e.mineLocatorList[E]=n
    end
  end
  local decoyLocatorList=n.decoyLocatorList
  if decoyLocatorList then
    e.decoyLocatorList={}
    for n,E in ipairs(decoyLocatorList)do
      e.decoyLocatorList[n]=E
    end
  end
end
function this.OnEnterRevengeMineTrap(n)
  if not mvars.rev_mineTrapTable then
    return
  end
  local n=mvars.rev_mineTrapTable[n]
  if not n then
    return
  end
  local areaIndex,baseName,trapName=n.areaIndex,n.baseName,n.trapName
  this.UpdateLastVisitedMineArea(baseName,areaIndex,trapName)
end
function this.ClearLastRevengeMineBaseName()
  gvars.rev_lastUpdatedBaseName=0
end
function this.UpdateLastVisitedMineArea(n,t,e)
  local e=mvars.rev_LastVisitedMineAreaVarsName
  if not e then
    return
  end
  local E=Fox.StrCode32(n)
  if gvars.rev_lastUpdatedBaseName==E then
    return
  else
    gvars.rev_lastUpdatedBaseName=E
  end
  local n=mvars.rev_mineBaseTable[n]
  gvars[e][n]=t
end
function this.SaveMissionStartMineArea()
  local e,E=mvars.rev_missionStartMineAreaVarsName,mvars.rev_LastVisitedMineAreaVarsName
  if not e then
    return
  end
  for n=0,(TppDefine.REVENGE_MINE_BASE_MAX-1)do
    gvars[e][n]=gvars[E][n]
  end
end
function this.SetUpRevengeMine()
  if TppMission.IsMissionStart()then
    this._SetUpRevengeMine()
  end
end
function this._SetUpRevengeMine()
  local missionStartMineAreaVarsName=mvars.rev_missionStartMineAreaVarsName
  if not missionStartMineAreaVarsName then
    return
  end
  if not mvars.rev_mineBaseTable then
    return
  end
  local addMines,addDecoys=false,false
  if this.GetMineRate()>.5 then
    addMines=true
  else
    addMines=false
  end
  if this.GetDecoyRate()>.5 then
    addDecoys=true
  else
    addDecoys=false
  end
  for a,o in pairs(mvars.rev_mineBaseTable)do
    local revengeMineList=mvars.rev_revengeMineList[a]
    local RENAMEsomenum=gvars[missionStartMineAreaVarsName][o]
    if RENAMEsomenum==0 and#revengeMineList>0 then
      RENAMEsomenum=math.random(1,#revengeMineList)
      gvars[missionStartMineAreaVarsName][o]=RENAMEsomenum
    end
    local o=revengeMineList.decoyLocatorList
    local t=false
    for r,i in ipairs(revengeMineList)do
      local T=i.mineLocatorList
      if T then
        local e=addMines and(r==RENAMEsomenum)
        if e then
          t=false
        end
        for E,n in ipairs(T)do
          TppPlaced.SetEnableByLocatorName(n,e)
        end
      end
      local decoyLocatorList=i.decoyLocatorList
      if o then
        this._EnableDecoy(a,o,addDecoys)
        if addDecoys then
          t=false
        end
      end
      if decoyLocatorList then
        local n=addDecoys and(r==RENAMEsomenum)
        this._EnableDecoy(a,decoyLocatorList,n)
        if n then
          t=false
        end
      end
    end
    if t then
    end
  end
end
function this._GetDecoyType(cpName)
  local pfType={PF_A=1,PF_B=2,PF_C=3}
  local cpId=GetGameObjectId(cpName)
  local cpSubType=TppEnemy.GetCpSubType(cpId)
  return pfType[cpSubType]
end
function this._EnableDecoy(_cpName,locatorList,enable)
  local cpName=_cpName.."_cp"
  local decoyType=this._GetDecoyType(cpName)
  local isUsingActiveDecoy=this.IsUsingActiveDecoy()
  for t,locatorName in ipairs(locatorList)do
    if decoyType then
      TppPlaced.SetCorrelationValueByLocatorName(locatorName,decoyType)
    end
    if isUsingActiveDecoy then
      TppPlaced.ChangeEquipIdByLocatorName(locatorName,TppEquip.EQP_SWP_ActiveDecoy)
    end
    TppPlaced.SetEnableByLocatorName(locatorName,enable)
  end
end
function this._SetupCamera()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSecurityCamera2"then
    return
  end
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    return
  end
  local enable=false
  if this.GetCameraRate()>.5 then
    enable=true
  else
    enable=false
  end
  GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetEnabled",enabled=enable})
  if this.IsUsingGunCamera()then
    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetGunCamera"})
  else
    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetNormalCamera"})
  end
end
function this.OnAllocate(missionTable)
  mvars.revenge_isEnabledSuperReinforce=true
  this.SetUpMineAreaVarsName()
  if missionTable.sequence then
    local baseList=missionTable.sequence.baseList
    if baseList then
      local locationName=TppLocation.GetLocationName()
      mvars.rev_usingBase={}
      for E,baseName in ipairs(baseList)do
        local e=locationName..("_"..baseName)
        mvars.rev_usingBase[e]=true
      end
    end
  end
end
function this.SetUpMineAreaVarsName()
  if TppLocation.IsAfghan()then
    mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaAfgh"
    mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaAfgh"
  elseif TppLocation.IsMiddleAfrica()then
    mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaMafr"
    mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaMafr"
  else
    return
  end
end
function this.DecideRevenge(missionTable)
  this._SetUiParameters()
  mvars.revenge_revengeConfig=mvars.revenge_revengeConfig or{}
  mvars.revenge_revengeType=mvars.revenge_forceRevengeType
  if mvars.revenge_revengeType==nil then
    mvars.revenge_revengeType=this.SelectRevengeType()
  end
  mvars.revenge_revengeConfig=this._CreateRevengeConfig(mvars.revenge_revengeType)
  if(missionTable.enemy and missionTable.enemy.soldierDefine)or vars.missionCode>6e4 then
    this._AllocateResources(mvars.revenge_revengeConfig)
  end
end
function this.SetUpEnemy()
  if mvars.ene_soldierDefine==nil then
    return
  end
  if mvars.ene_soldierIDList==nil then
    return
  end
  this._SetMbInterrogate()
  local reinforceCount=this.GetReinforceCount()
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforceCount",count=reinforceCount})
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    TppEnemy.SetUpDDParameter()
  end
  this._SetupCamera()
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
    else
      if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
        for plant=0,3 do
          this._ApplyRevengeToCp(cpId,mvars.revenge_revengeConfig,plant)
        end
      else
        this._ApplyRevengeToCp(cpId,mvars.revenge_revengeConfig)
      end
    end
  end
end
function this.GetRevengeLvLimitRank()
  local e=gvars.str_storySequence
  if e<TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    return 1
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    return 2
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
    return 3
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
    return 4
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    return 5
  else
    return 6
  end
  return 6
end
function this.GetRevengeLv(revengeType)
  local missionId=TppMission.GetMissionID()
  if TppMission.IsHardMission(missionId) then --CULL or Ivars.revengeMode:Is"MAX" or Ivars.revengeModeForMissions:Is"MAX" then--tex added
    return this.GetRevengeLvMax(revengeType,this.REVENGE_LV_LIMIT_RANK_MAX)--RETAILBUG: was just REVENGE_LV_LIMIT_RANK_MAX, the limit on REVE is max rank anyway which GetRevengeLvMax defaults to
  else
    return gvars.rev_revengeLv[revengeType]
  end
end
function this.GetActualRevengeLv(revengeType)--tex ORIG: GetRevengeLv
  return gvars.rev_revengeLv[revengeType]
end
function this.GetRevengeLvMax(revengeType,limitMaxRank)
  local maxRank=limitMaxRank or this.GetRevengeLvLimitRank()
  local maxLevel=this.REVENGE_LV_MAX[revengeType]
  if Tpp.IsTypeTable(maxLevel)then
    local maxLevel=maxLevel[maxRank]
    return maxLevel or 0
  end
  return 0
end
function this.GetRevengePoint(e)
  return gvars.rev_revengePoint[e]
end
function this.AddRevengePoint(n,E)
  this.SetRevengePoint(n,gvars.rev_revengePoint[n]+E)
end
function this.GetRevengeTriggerName(n)
  for e,E in pairs(this.REVENGE_TRIGGER_TYPE)do
    if E==n then
      return e
    end
  end
  return""
end
function this.AddRevengePointByTriggerType(revengeTriggerType)
  local missionCode=TppMission.GetMissionID()
  if this.IsNoRevengeMission(missionCode)then
    return
  end
  --NMC ORPHAN local debugText="###REVENGE### "..(tostring(missionCode)..(" / AddRevengePointBy ["..(this.GetRevengeTriggerName(revengeTriggerType).."] : ")))
  local revTypePoint=this.REVENGE_POINT_TABLE[revengeTriggerType]
  for revType,revPoint in pairs(revTypePoint)do
    revType=revType+0
    revPoint=revPoint+0
    --NMC ORPHAN local currentRevengePoints=gvars.rev_revengePoint[revType]
    this.SetRevengePoint(revType,gvars.rev_revengePoint[revType]+revPoint)
    local newPoints=gvars.rev_revengePoint[revType]
    --NMC ORPHAN debugText=debugText..(this.REVENGE_TYPE_NAME[revType+1]..(":"..(tostring(currentRevengePoints)..("->"..(tostring(newPoints).." ")))))
  end
  --InfMenu.DebugPrint(debugText)--tex might as well use their helpfully created string
end
function this.SetRevengePoint(revengeType,points)
  local maxLevel=this.GetRevengeLvMax(revengeType)
  local nextLevel=maxLevel*this.REVENGE_POINT_PER_LV+this.REVENGE_POINT_OVER_MARGINE
  if points<0 then
    points=0
  end
  if points>nextLevel then
    points=nextLevel
  end
  gvars.rev_revengePoint[revengeType]=points
end
function this.ResetRevenge()
  for n=0,this.REVENGE_TYPE.MAX-1 do
    this.SetRevengePoint(n,0)
  end
  this.UpdateRevengeLv()
end
function this.UpdateRevengeLv(missionId)
  if missionId==nil then
    missionId=TppMission.GetMissionID()
  end
  for revengeTypeIndex=0,this.REVENGE_TYPE.MAX-1 do
    local lvlMax=this.GetRevengeLvMax(revengeTypeIndex)
    local points=this.GetRevengePoint(revengeTypeIndex)
    local newLevel=math.floor(points/100)
    if newLevel>lvlMax then
      newLevel=lvlMax
    end
    gvars.rev_revengeLv[revengeTypeIndex]=newLevel
  end
  this._SetEnmityLv()
end
function this._GetUiParameterValue(revengeLevel)
  local rankLimitForUi2=4
  local rankLimitForUi3=5
  local currentLevel=this.GetRevengeLv(revengeLevel)
  if currentLevel>=this.GetRevengeLvMax(revengeLevel,rankLimitForUi3)then
    return 3
  elseif currentLevel>=this.GetRevengeLvMax(revengeLevel,rankLimitForUi2)then
    return 2
  elseif currentLevel>=1 then
    return 1
  end
  return 0
end
function this._SetUiParameters()
  local doCustom=Ivars.revengeMode:Is"CUSTOM" or Ivars.revengeModeForMissions:Is"CUSTOM" or Ivars.revengeModeForMb:Is"CUSTOM"--tex>
  if doCustom then
    InfMain.SetCustomRevengeUiParameters()
    return
  end--<

  local fulton=this._GetUiParameterValue(this.REVENGE_TYPE.FULTON)
  local headShot=this._GetUiParameterValue(this.REVENGE_TYPE.HEAD_SHOT)
  local stealth=this._GetUiParameterValue(this.REVENGE_TYPE.STEALTH)
  local combat=this._GetUiParameterValue(this.REVENGE_TYPE.COMBAT)
  local night=math.min(3,math.max(this.GetRevengeLv(this.REVENGE_TYPE.NIGHT_S),this.GetRevengeLv(this.REVENGE_TYPE.NIGHT_C)))
  local longRange=this._GetUiParameterValue(this.REVENGE_TYPE.LONG_RANGE)
  TppUiCommand.RegisterEnemyRevengeParameters{fulton=fulton,headShot=headShot,stealth=stealth,combat=combat,night=night,longRange=longRange}
end
function this._SetMbInterrogate()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  local enableMask=0
  local interrogateRevengeList={
    {MbInterrogate.FULUTON,   this.REVENGE_TYPE.FULTON,     1},
    {MbInterrogate.GAS,       this.REVENGE_TYPE.SMOKE,      1,                                        this.BLOCKED_TYPE.GAS_MASK},
    {MbInterrogate.MET,       this.REVENGE_TYPE.HEAD_SHOT,  1,                                        this.BLOCKED_TYPE.HELMET},
    {MbInterrogate.FLASH,     this.REVENGE_TYPE.NIGHT_C,    1,                                        this.BLOCKED_TYPE.GUN_LIGHT},
    {MbInterrogate.SNIPER,    this.REVENGE_TYPE.LONG_RANGE, 1,                                        this.BLOCKED_TYPE.SNIPER},
    {MbInterrogate.MISSILE,   this.REVENGE_TYPE.VEHICLE,    1,                                        this.BLOCKED_TYPE.MISSILE},
    {MbInterrogate.NIGHT,     this.REVENGE_TYPE.NIGHT_S,    1,                                        this.BLOCKED_TYPE.NVG},
    {MbInterrogate.CAMERA,    this.REVENGE_TYPE.STEALTH,    this.revengeDefine._ENABLE_CAMERA_LV,     this.BLOCKED_TYPE.CAMERA},
    {MbInterrogate.DECOY,     this.REVENGE_TYPE.STEALTH,    this.revengeDefine._ENABLE_DECOY_LV,      this.BLOCKED_TYPE.DECOY},
    {MbInterrogate.MINE,      this.REVENGE_TYPE.STEALTH,    this.revengeDefine._ENABLE_MINE_LV,       this.BLOCKED_TYPE.MINE},
    {MbInterrogate.SHOTGUN,   this.REVENGE_TYPE.COMBAT,     this.revengeDefine._ENABLE_SHOTGUN_LV,    this.BLOCKED_TYPE.SHOTGUN},
    {MbInterrogate.MACHINEGUN,this.REVENGE_TYPE.COMBAT,     this.revengeDefine._ENABLE_MG_LV,         this.BLOCKED_TYPE.MG},
    {MbInterrogate.BODY,      this.REVENGE_TYPE.COMBAT,     this.revengeDefine._ENABLE_SOFT_ARMOR_LV, this.BLOCKED_TYPE.SOFT_ARMOR},
    {MbInterrogate.SHIELD,    this.REVENGE_TYPE.COMBAT,     this.revengeDefine._ENABLE_SHIELD_LV,     this.BLOCKED_TYPE.SHIELD},
    {MbInterrogate.ARMOR,     this.REVENGE_TYPE.COMBAT,     this.revengeDefine._ENABLE_ARMOR_LV,      this.BLOCKED_TYPE.ARMOR}
  }
  for t,table in ipairs(interrogateRevengeList)do
    local interrogateType=table[1]
    local revengeType=table[2]
    local minLevel=table[3]
    local blockedType=table[4]
    if blockedType and this.IsBlocked(blockedType)then
    elseif this.GetRevengeLv(revengeType)>=minLevel then
      enableMask=bit.bor(enableMask,interrogateType)
    end
  end
  GameObject.SendCommand({type="TppSoldier2"},{id="SetMbInterrogate",enableMask=enableMask})
end
function this._SetEnmityLv()
  local revengeStealth=this.GetRevengePoint(this.REVENGE_TYPE.STEALTH)
  local revengeCombat=this.GetRevengePoint(this.REVENGE_TYPE.COMBAT)
  local maxRevengePoints=math.max(revengeStealth,revengeCombat)
  local enmityLevels={
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_NONE,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_10,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_20,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_30,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_40,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_50,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_60,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_70,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_80,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_90,
    TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_100
  }
  local n=500
  local numLevels=#enmityLevels
  local enmityLevel=math.floor((maxRevengePoints*(numLevels-1))/n)+1
  if enmityLevel>=numLevels then
    enmityLevel=#enmityLevels
  end
  local staffEnmityLv=enmityLevels[enmityLevel]
  TppMotherBaseManagement.SetStaffInitEnmityLv{lv=staffEnmityLv}
end
function this.OnMissionClearOrAbort(missionId)
  gvars.rev_revengeRandomValue=math.random(0,2147483647)
  this.ApplyMissionTendency(missionId)
  this._ReduceRevengePointByChickenCap(missionId)
  this._ReduceBlockedCount(missionId)
  this._ReceiveClearedDeployRevengeMission()
  this.UpdateRevengeLv(missionId)
  this._AddDeployRevengeMission()
end
function this._ReduceBlockedCount(missionId)
  if not TppMission.IsHelicopterSpace(missionId)then
    return
  end
  for n=0,this.BLOCKED_TYPE.MAX-1 do
    local blockedCount=gvars.rev_revengeBlockedCount[n]
    if blockedCount>0 then
      gvars.rev_revengeBlockedCount[n]=blockedCount-1
    end
  end
end
function this._GetBlockedName(blockedId)
  for blockedName,blockedEnum in pairs(this.BLOCKED_TYPE)do
    if blockedEnum==blockedId then
      return blockedName
    end
  end
  return"unknown"
end
function this._ReceiveClearedDeployRevengeMission()
  if not TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag then
    return
  end
  for deployMissionId,blockedType in pairs(this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST)do
    local clearedDeployRevengeMissionFlag=TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag{deployMissionId=deployMissionId}
    if clearedDeployRevengeMissionFlag then
      gvars.rev_revengeBlockedCount[blockedType]=Ivars.revengeBlockForMissionCount:Get()--tex was this.BLOCKED_FOR_MISSION_COUNT
      TppMotherBaseManagement.UnsetClearedDeployRevengeMissionFlag{deployMissionId=deployMissionId}
    end
  end
end
function this._AddDeployRevengeMission()
  for deployMissionId,revengeInfo in pairs(this.DEPLOY_REVENGE_MISSION_CONDITION_LIST)do
    local blockedId=this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST[deployMissionId]
    if not this.IsBlocked(blockedId)and this.GetRevengeLv(revengeInfo.revengeType)>=revengeInfo.lv then
      local e=TppMotherBaseManagement.RequestAddDeployRevengeMission{deployMissionId=deployMissionId}
    else
      if not TppMotherBaseManagement.RequestDeleteDeployRevengeMission then
        return
      end
      TppMotherBaseManagement.RequestDeleteDeployRevengeMission{deployMissionId=deployMissionId}
    end
  end
end
function this._ReduceRevengePointStealthCombat()
  for revengeType,pointTable in pairs(this.REDUCE_TENDENCY_POINT_TABLE)do
    local revengePoints=this.GetRevengePoint(revengeType)
    local revengeLevel=this.GetRevengeLv(revengeType)
    local pointsForLevel=pointTable[revengeLevel+1]
    this.SetRevengePoint(revengeType,(revengePoints+pointsForLevel))
  end
end
function this._ReduceRevengePointOther()
  local dontReduceTypes={[this.REVENGE_TYPE.STEALTH]=true,[this.REVENGE_TYPE.COMBAT]=true,[this.REVENGE_TYPE.M_STEALTH]=true,[this.REVENGE_TYPE.M_COMBAT]=true}
  for revengeType=0,this.REVENGE_TYPE.MAX-1 do
    local revengePoints=this.GetRevengePoint(revengeType)
    local revengeLevel=this.GetRevengeLv(revengeType)
    local reduction=0
    if dontReduceTypes[revengeType]then
      reduction=0
    elseif bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
      reduction=100
    elseif this.REDUCE_POINT_TABLE[revengeType]then
      reduction=this.REDUCE_POINT_TABLE[revengeType][revengeLevel+1]
      if reduction==nil then
        reduction=50
      else
        reduction=-reduction
      end
    else
      reduction=this.REDUCE_REVENGE_POINT*(revengeLevel+1)
      if reduction>50 then
        reduction=50
      end
    end
    this.SetRevengePoint(revengeType,revengePoints-reduction)
  end
end
function this.ReduceRevengePointOnMissionClear(missionId)
  if missionId==nil then
    missionId=TppMission.GetMissionID()
  end
  if this.IsNoRevengeMission(missionId)then
    return
  end
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
    return
  end
  this._ReduceRevengePointOther()
end
function this._ReduceRevengePointByChickenCap(missionId)
  if missionId==nil then
    missionId=TppMission.GetMissionID()
  end
  if this.IsNoRevengeMission(missionId)then
    return
  end
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
    this._ReduceRevengePointStealthCombat()
    this._ReduceRevengePointOther()
  end
end
function this.ReduceRevengePointOnAbort(e)
end
function this._GetMissionTendency(missionId)
  local mStealth=this.GetRevengePoint(this.REVENGE_TYPE.M_STEALTH)
  local mCombat=this.GetRevengePoint(this.REVENGE_TYPE.M_COMBAT)
  if mStealth==0 and mCombat==0 then
    return"STEALTH"end
  if mCombat==0 then
    return"STEALTH"end
  if mStealth==0 then
    return"COMBAT"end
  local tendencyDifference=mStealth-mCombat
  local r=.3
  local maxLevel=10--VERIFY: name
  local e=(mStealth+mCombat)*r
  if e<maxLevel then
    e=maxLevel
  end
  local tendency="DRAW"
  if tendencyDifference>=e then
    tendency="STEALTH"
  elseif tendencyDifference<=-e then
    tendency="COMBAT"
  end
  return tendency
end
function this.ApplyMissionTendency(missionId)
  if missionId==nil then
    missionId=TppMission.GetMissionID()
  end
  if(not this.IsNoRevengeMission(missionId)and not this.IsNoStealthCombatRevengeMission(missionId))and bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)~=PlayerPlayFlag.USE_CHICKEN_CAP then
    local missionTendancy=this._GetMissionTendency(missionId)
    local missionTendancyPoint=this.MISSION_TENDENCY_POINT_TABLE[missionTendancy]
    if missionTendancyPoint then
      local nextStealthLevel=this.GetRevengeLv(this.REVENGE_TYPE.STEALTH)+1
      local nextCombatLevel=this.GetRevengeLv(this.REVENGE_TYPE.COMBAT)+1
      if nextStealthLevel>#missionTendancyPoint.STEALTH then
        nextStealthLevel=#missionTendancyPoint.STEALTH
      end
      if nextCombatLevel>#missionTendancyPoint.COMBAT then
        nextCombatLevel=#missionTendancyPoint.COMBAT
      end
      this.AddRevengePoint(this.REVENGE_TYPE.STEALTH,missionTendancyPoint.STEALTH[nextStealthLevel])
      this.AddRevengePoint(this.REVENGE_TYPE.COMBAT,missionTendancyPoint.COMBAT[nextCombatLevel])
    end
  end
  this.SetRevengePoint(this.REVENGE_TYPE.M_STEALTH,0)
  this.SetRevengePoint(this.REVENGE_TYPE.M_COMBAT,0)
end
function this.CanUseReinforceVehicle()
  if Ivars.forceSuperReinforce:Is()>0 then--tex
    return true
  end--
  local missionId=TppMission.GetMissionID()
  return this.USE_SUPER_REINFORCE_VEHICLE_MISSION[missionId]
end
function this.CanUseReinforceHeli()
  return not GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"
end
function this.SelectReinforceType()
  if mvars.reinforce_reinforceType==TppReinforceBlock.REINFORCE_TYPE.HELI then
    --InfMenu.DebugPrint("SelectReinforceType already heli")
    return TppReinforceBlock.REINFORCE_TYPE.HELI
  end
  if not this.IsUsingSuperReinforce()then
    --InfMenu.DebugPrint("SelectReinforceType not superreinforce")
    return TppReinforceBlock.REINFORCE_TYPE.NONE
  end
  local reinforceVehicleTypes={}
  local canuseReinforceVehicle=this.CanUseReinforceVehicle()
  if canuseReinforceVehicle and Ivars.forceSuperReinforce:Is()>0 then--tex
    canuseReinforceVehicle=not(vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE)--tex TODO: can't use reinforce vehicle in free mode till I figure out why it doesn't work vs missions
  end--
  local canUseReinforceHeli=this.CanUseReinforceHeli() and mvars.revenge_isEnabledSuperReinforce--tex added isEnabledSuper, which is only set by quest heli and shouldnt stop other vehicle
  if canuseReinforceVehicle then
    --InfMenu.DebugPrint("SelectReinforceType canuseReinforceVehicle")
    local reinforceVehiclesForLocation={
      AFGH={TppReinforceBlock.REINFORCE_TYPE.EAST_WAV,TppReinforceBlock.REINFORCE_TYPE.EAST_TANK},
      MAFR={TppReinforceBlock.REINFORCE_TYPE.WEST_WAV,TppReinforceBlock.REINFORCE_TYPE.WEST_WAV_CANNON,TppReinforceBlock.REINFORCE_TYPE.WEST_TANK}
    }
    if TppLocation.IsAfghan()then
      reinforceVehicleTypes=reinforceVehiclesForLocation.AFGH
    elseif TppLocation.IsMiddleAfrica()then
      reinforceVehicleTypes=reinforceVehiclesForLocation.MAFR
    end
  end
  if canUseReinforceHeli then
    --InfMenu.DebugPrint("SelectReinforceType canuseReinforceHeli")
    table.insert(reinforceVehicleTypes,TppReinforceBlock.REINFORCE_TYPE.HELI)
  end
  if#reinforceVehicleTypes==0 then
    --InfMenu.DebugPrint("SelectReinforceType #reinforceVehicleTypes==0")--DEBUG
    return TppReinforceBlock.REINFORCE_TYPE.NONE
  end
  local randomVehicleType=math.random(1,#reinforceVehicleTypes)
  --InfMenu.DebugPrint("SelectReinforceType randomVehicleType: "..TppReinforceBlock.REINFORCE_TYPE_NAME[reinforceVehicleTypes[randomVehicleType]+1])--DEBUG
  return reinforceVehicleTypes[randomVehicleType]
end
function this.ApplyPowerSettingsForReinforce(soldierIds)
  for n,soldierId in ipairs(soldierIds)do
    GameObject.SendCommand(soldierId,{id="RegenerateStaffIdForReinforce"})
  end
  local loadout={}
  do
    local headShotLevel=this.GetRevengeLv(this.REVENGE_TYPE.HEAD_SHOT)
    local helmetLimit=headShotLevel/10
    if math.random()<helmetLimit and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.HELMET))then
      table.insert(loadout,"HELMET")
    end
  end
  if this.IsUsingStrongWeapon()then
    table.insert(loadout,"STRONG_WEAPON")
  end
  if this.IsUsingNoKillWeapon()then
    table.insert(loadout,"NO_KILL_WEAPON")
  end
  do
    local combatLimit=0
    local combatLevel=this.GetRevengeLv(this.REVENGE_TYPE.COMBAT)
    if combatLevel>=4 then
      combatLimit=99
    elseif combatLevel>=3 then
      combatLimit=.75
    elseif combatLevel>=1 then
      combatLimit=.5
    end
    if math.random()<combatLimit and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.SOFT_ARMOR))then
      table.insert(loadout,"SOFT_ARMOR")
    end
    if math.random()<combatLimit then
      if mvars.revenge_loadedEquip.SHOTGUN and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.SHOTGUN))then
        table.insert(loadout,"SHOTGUN")
      elseif mvars.revenge_loadedEquip.MG and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.MG))then
        table.insert(loadout,"MG")
      end
    end
  end
  for E,soldierId in ipairs(soldierIds)do
    TppEnemy.ApplyPowerSetting(soldierId,loadout)
  end
end

--NMC: revengeTypes ==mvars.revenge_revengeType == (mvars.revenge_forceRevengeType(via mtbs_enemy) or this.SelectRevengeType())
function this._CreateRevengeConfig(revengeTypes)
  local revengeConfig={}
  local disablePowerSettings=mvars.ene_disablePowerSettings

  do
    local requiredPowerSettings=mvars.ene_missionRequiresPowerSettings--NMC: TppEnemy.SetUpPowerSettings>ene_missionRequiresPowerSettings
    local revengeComboExclusionList={MISSILE={"SHIELD"},SHIELD={"MISSILE"},SHOTGUN={"MG"},MG={"SHOTGUN"}}
    for powerType,E in pairs(requiredPowerSettings)do
      local exclusionList=revengeComboExclusionList[powerType]
      if exclusionList then
        for n,powerType in ipairs(exclusionList)do
          if not mvars.ene_missionRequiresPowerSettings[powerType]then
            disablePowerSettings[powerType]=true
          end
        end
      end
    end
  end

  --tex>customrevengeconfig
  local doCustom=Ivars.revengeMode:Is"CUSTOM" or Ivars.revengeModeForMissions:Is"CUSTOM" or Ivars.revengeModeForMb:Is"CUSTOM"
  if doCustom then
    revengeConfig=InfMain.CreateCustomRevengeConfig()
    for powerType,setting in pairs(revengeConfig)do
      mvars.ene_missionRequiresPowerSettings[powerType]=setting
    end
    mvars.ene_disablePowerSettings={}
    disablePowerSettings={}
    --<
  else
    --NMC: actually add stuff to revengeConfig
    for n,revengeType in ipairs(revengeTypes)do
      local category=this.revengeDefine[revengeType]
      if category~=nil then
        if category[1]~=nil then
          local rnd=this._Random(1,#category)
          category=category[rnd]
        end
        for powerType,powerSetting in pairs(category)do
          if disablePowerSettings[powerType]then
          else
            revengeConfig[powerType]=powerSetting
          end
        end
      end
    end--for revengetypes
  end

  if not revengeConfig.IGNORE_BLOCKED then
    for powerType,powerSetting in pairs(revengeConfig)do
      if this.IsBlocked(this.BLOCKED_TYPE[powerType])then
        revengeConfig[powerType]=nil
      end
    end
  end
  --NMC: downgrade armor to shield
  if Tpp.IsTypeNumber(revengeConfig.ARMOR)and not this.CanUseArmor() then
    if not disablePowerSettings.SHIELD then
      local shieldCount=revengeConfig.SHIELD or 0
      if Ivars.disableConvertArmorToShield:Is(0) or shieldCount==0 then--tex added disable/0 check
        if Tpp.IsTypeNumber(shieldCount)then
          revengeConfig.SHIELD=shieldCount+revengeConfig.ARMOR
      end
      end
    end
    revengeConfig.ARMOR=nil
  end
  local revengeComboExclusionNonRequire={NO_KILL_WEAPON={"MG"}}
  if not mvars.ene_missionRequiresPowerSettings.SHIELD then
    revengeComboExclusionNonRequire.MISSILE={"SHIELD"}
  end
  if not mvars.ene_missionRequiresPowerSettings.MG then
    revengeComboExclusionNonRequire.SHOTGUN={"MG"}
  end
  local doExcludePower={}
  for powerType,excludePowers in pairs(revengeComboExclusionNonRequire)do
    if revengeConfig[powerType]and not doExcludePower[powerType]then
      for n,powerType in ipairs(excludePowers)do
        doExcludePower[powerType]=true
      end
    end
  end
  if not doCustom then--tex added bypass if custom--DEBUGNOW remove, test
    for powerType,bool in pairs(doExcludePower)do
      revengeConfig[powerType]=nil
  end
  end
  local missionId=TppMission.GetMissionID()
  if TppMission.IsFOBMission(missionId)or InfMain.IsDDEquip(missionId) then--tex
    local weaponTable=TppEnemy.weaponIdTable.DD
    if revengeConfig.NO_KILL_WEAPON and weaponTable then
      local normalTable=weaponTable.NORMAL
      if normalTable and normalTable.IS_NOKILL then
        if not normalTable.IS_NOKILL.SHOTGUN then
          revengeConfig.SHOTGUN=nil
        end
        if not normalTable.IS_NOKILL.MISSILE then
          revengeConfig.MISSILE=nil
        end
        if not normalTable.IS_NOKILL.SNIPER then
          revengeConfig.SNIPER=nil
        end
        if not normalTable.IS_NOKILL.SMG then
          revengeConfig.SHIELD=nil
          revengeConfig.MISSILE=nil
        end
      end
    end
  end
  return revengeConfig
end
--INPUT: mvars.revenge_revengeConfig < _CreateRevengeConfig
function this._AllocateResources(config)
  mvars.revenge_loadedEquip={}
  local missionRequiresSettings=mvars.ene_missionRequiresPowerSettings
  local loadWeaponIds={}
  local nullId=NULL_ID
  local defaultSoldierType=TppEnemy.GetSoldierType(nullId)
  local defaultSubType=TppEnemy.GetSoldierSubType(nullId)
  local weaponIdTable=TppEnemy.GetWeaponIdTable(defaultSoldierType,defaultSubType)
  if weaponIdTable==nil then
    TppEnemy.weaponIdTable.DD={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,ASSAULT=TppEquip.EQP_WP_West_ar_040}}
    weaponIdTable=TppEnemy.weaponIdTable.DD
  end
  local disablePowerSettings=mvars.ene_disablePowerSettings
  local missionId=TppMission.GetMissionID()
  local useAllWeapons=true
  if this.CANNOT_USE_ALL_WEAPON_MISSION[missionId]then
    useAllWeapons=false
  end
  --tex>
  if (Ivars.disableMissionsWeaponRestriction:Is(1) and vars.missionCode~=30050)or(Ivars.disableMotherbaseWeaponRestriction:Is(1) and vars.missionCode==30050) then--WIP
    useAllWeapons=true
  end--<
  local restrictWeaponTable={}
  if not useAllWeapons then
    if not config.SHIELD or config.MISSILE then
      if not missionRequiresSettings.SHIELD then
        restrictWeaponTable.SHIELD=true
        disablePowerSettings.SHIELD=true
      end
    else
      if not missionRequiresSettings.MISSILE then
        restrictWeaponTable.MISSILE=true
        disablePowerSettings.MISSILE=true
      end
    end
    if defaultSoldierType~=EnemyType.TYPE_DD then
      if config.SHOTGUN then
        if not missionRequiresSettings.MG then
          restrictWeaponTable.MG=true
          disablePowerSettings.MG=true
        end
      else
        if not missionRequiresSettings.SHOTGUN then
          restrictWeaponTable.SHOTGUN=true
          disablePowerSettings.SHOTGUN=true
        end
      end
    end
  end
  for powerType,n in pairs(missionRequiresSettings)do
    restrictWeaponTable[powerType]=nil
    disablePowerSettings[powerType]=nil
  end

  do
    local basePowerTypes={HANDGUN=true,SMG=true,ASSAULT=true,SHOTGUN=true,MG=true,SHIELD=true}
    local baseWeaponIdTable=weaponIdTable.NORMAL
    if this.IsUsingStrongWeapon()and weaponIdTable.STRONG then
      baseWeaponIdTable=weaponIdTable.STRONG
    end
    if Tpp.IsTypeTable(baseWeaponIdTable)then
      for powerType,weaponId in pairs(baseWeaponIdTable)do
        if not basePowerTypes[powerType]then
        elseif disablePowerSettings[powerType]then
        elseif restrictWeaponTable[powerType]then
        else
          loadWeaponIds[weaponId]=true
          mvars.revenge_loadedEquip[powerType]=weaponId
        end
      end
    end
  end

  if not disablePowerSettings.MISSILE and not restrictWeaponTable.MISSILE then
    local missileIdTable={}
    if this.IsUsingStrongMissile()and weaponIdTable.STRONG then
      missileIdTable=weaponIdTable.STRONG
    else
      missileIdTable=weaponIdTable.NORMAL
    end
    local missileId=missileIdTable.MISSILE
    if missileId then
      loadWeaponIds[missileId]=true
      mvars.revenge_loadedEquip.MISSILE=missileId
    end
  end
  if not disablePowerSettings.SNIPER and not restrictWeaponTable.SNIPER then
    local sniperIdTable={}
    if this.IsUsingStrongSniper()and weaponIdTable.STRONG then
      sniperIdTable=weaponIdTable.STRONG
    else
      sniperIdTable=weaponIdTable.NORMAL
    end
    local sniperId=sniperIdTable.SNIPER
    if sniperId then
      loadWeaponIds[sniperId]=true
      mvars.revenge_loadedEquip.SNIPER=sniperId
    end
  end

  do
    local primary,secondary,tertiary=TppEnemy.GetWeaponId(NULL_ID,{})
    TppSoldier2.SetDefaultSoldierWeapon{primary=primary,secondary=secondary,tertiary=tertiary}
  end
  local equipLoadTable={}
  for weaponId,bool in pairs(loadWeaponIds)do
    table.insert(equipLoadTable,weaponId)
  end
  if missionId==10080 or missionId==11080 then
    table.insert(equipLoadTable,TppEquip.EQP_WP_Wood_ar_010)
  end
  if TppEquip.RequestLoadToEquipMissionBlock then
    TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)


    if InfMain.IsWildCardEnabled(missionId) then--tex> TODO: pare it down to actual used
      local equipLoadTable={}
      for weaponType,weaponId in pairs(TppEnemy.weaponIdTable.WILDCARD.NORMAL)do
        table.insert(equipLoadTable,weaponId)
      end
      TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
    end--<
  end
end
function this._GetSettingSoldierCount(power,powerSetting,soldierCount)
  local abilities={
    NO_KILL_WEAPON=true,
    STRONG_WEAPON=true,
    STRONG_PATROL=true,
    STRONG_NOTICE_TRANQ=true,
    STEALTH_SPECIAL=true,
    STEALTH_HIGH=true,
    STEALTH_LOW=true,
    COMBAT_SPECIAL=true,
    COMBAT_HIGH=true,
    COMBAT_LOW=true,
    FULTON_SPECIAL=true,
    FULTON_HIGH=true,
    FULTON_LOW=true,
    HOLDUP_SPECIAL=true,
    HOLDUP_HIGH=true,
    HOLDUP_LOW=true
  }
  if abilities[power]then
    return soldierCount
  end
  local settingSoldierCount=0
  if Tpp.IsTypeNumber(powerSetting)then
    settingSoldierCount=powerSetting
  elseif Tpp.IsTypeString(powerSetting)then
    if powerSetting:sub(-1)=="%"then
      local percentage=powerSetting:sub(1,-2)+0
      settingSoldierCount=math.ceil(soldierCount*(percentage/100))
    end
  end
  if settingSoldierCount>soldierCount then
    settingSoldierCount=soldierCount
  end
  do
    local max={ARMOR=4}
    local maxArmor=max[power]
    if maxArmor and settingSoldierCount>maxArmor then
      settingSoldierCount=maxArmor
    end
  end
  return settingSoldierCount
end

--tex broken out from _ApplyRevengeToCp and reworked
local function CreateCpConfig(revengeConfig,totalSoldierCount,powerComboExclusionList,powerElimOrChildSoldierTable,isOuterBaseCp,isLrrpCp,abilitiesList,unfulfilledPowers,addConfigFlags,cpConfig,cpId)--tex now function, added unfulfilledPowers
  InfMain.SetLevelRandomSeed()--tex added
  for r,powerType in ipairs(TppEnemy.POWER_SETTING)do
    local powerSetting=revengeConfig[powerType]
    if powerSetting then
      local settingSoldierCount=this._GetSettingSoldierCount(powerType,powerSetting,totalSoldierCount)
      if unfulfilledPowers[powerType]~=nil then--tex>
        settingSoldierCount=unfulfilledPowers[powerType]
      end--<
      --      if Ivars.selectedCp:Is()==cpId then--tex DEBUG
      --        InfMenu.DebugPrint(mvars.ene_cpList[cpId].." powerType:"..powerType.."="..tostring(powerSetting).." settingSoldierCount="..settingSoldierCount.." of "..totalSoldierCount)--DEBUG
      --      end--
      local comboExcludeList=powerComboExclusionList[powerType]or{}
      local soldierCount=settingSoldierCount
      local soldierConfigId=0--tex added
      --soldierConfigId=math.random(totalSoldierCount)--tex WIP DEBUGNOW random start pos to shake up distribution, the default does in order so it means ARMOR will get the good weapons, which is actually good, could have a seperate filter for what powertypes get a random distribution, mainly its weapons and headgear and rest shouldnt have random start?
      --WAS for soldierConfigId=1,totalSoldierCount do
      for count=1,totalSoldierCount do
        soldierConfigId=soldierConfigId+1--tex>
        if soldierConfigId>totalSoldierCount then
          soldierConfigId=1
        end
        --<

        local isPowerElimOrChild=powerElimOrChildSoldierTable[soldierConfigId]
        local isAbility=abilitiesList[powerType]--tex reworked to save mental gymnastics, original game allows ability set for outerbase and lrrp
        local doOuterBase=isOuterBaseCp and (isAbility or Ivars.applyPowersToOuterBase:Is(1))
        local doLrrp=isLrrpCp and (isAbility or Ivars.applyPowersToLrrp:Is(1))
        local isMainBase=(not isPowerElimOrChild) and (not isOuterBaseCp) and (not isLrrpCp)
        if soldierCount>0 and (isMainBase or doOuterBase or doLrrp) then
          local setPower=true
          if cpConfig[soldierConfigId][powerType]then
            soldierCount=soldierCount-1
            setPower=false
          end

          if setPower then
            for m,excludePower in ipairs(comboExcludeList)do
              if cpConfig[soldierConfigId][excludePower]then
                setPower=false
              end
            end
          end

          if setPower then
            soldierCount=soldierCount-1
            cpConfig[soldierConfigId][powerType]=true
            if powerType=="MISSILE"and this.IsUsingStrongMissile()then
              cpConfig[soldierConfigId].STRONG_MISSILE=true
            end
            if powerType=="SNIPER"and this.IsUsingStrongSniper()then
              cpConfig[soldierConfigId].STRONG_SNIPER=true
            end
            --tex>
            if addConfigFlags~=nil then
              for name,setting in pairs(addConfigFlags)do
                cpConfig[soldierConfigId][name]=setting
              end
            end
            --<
          end

        end--if applythisshit
      end--for soldiers

      unfulfilledPowers[powerType]=soldierCount--tex
    end--if configPower
  end--for TppEnemy.POWER_SETTINGS
  InfMain.ResetTrueRandom()--tex added
  return cpConfig
end

--CALLER: SetUpEnemy
--INPUT: mvars.revenge_revengeConfig < _CreateRevengeConfig
function this._ApplyRevengeToCp(cpId,revengeConfig,plant)
  local revengeConfigCp={}--tex> -v- all changed from using revengeConfig to revengeConfigCp, GOTCHA: be wary of what you're modifying since other stuff reads the original revengeconfig and your changes wont be reflected
  for k,v in pairs(revengeConfig)do
    revengeConfigCp[k]=v
  end--<

  local soldierIds=mvars.ene_soldierIDList[cpId]
  local soldierIdForConfigIdTable={}
  local totalSoldierCount=0
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    local r=0
    local cpName=mvars.ene_cpList[cpId]
    if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
      local clusterIdList=mtbs_enemy.cpNameToClsterIdList[cpName]
      if clusterIdList then
        soldierIds={}
        local soldierLocators=mvars.mbSoldier_enableSoldierLocatorList[clusterIdList]
        for n,soldierName in ipairs(soldierLocators)do
          local soldierPlant=tonumber(string.sub(soldierName,-6,-6))
          if soldierPlant~=nil and soldierPlant==plant then
            local soldierId=GameObject.GetGameObjectId("TppSoldier2",soldierName)
            soldierIds[soldierId]=r
          end
        end
      end
    end
  end
  if soldierIds==nil then
    return
  end

  local missionPowerSoldiers={}
  for soldierName,missionPowerSetting in pairs(mvars.ene_missionSoldierPowerSettings)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    missionPowerSoldiers[soldierId]=missionPowerSetting
  end
  local missionAbilitySoldiers={}
  for soldierName,missionAbilitySetting in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    missionAbilitySoldiers[soldierId]=missionAbilitySetting
  end

  local isOuterBaseCp=mvars.ene_outerBaseCpList[cpId]
  local isLrrpCp=mvars.ene_lrrpTravelPlan[cpId]--tex added, was below
  local powerElimOrChildSoldierTable={}
  local outerBaseSoldierTable={}
  local lrrpSoldierTable={}--tex added, was combined with above

  for soldierId,E in pairs(soldierIds)do
    table.insert(soldierIdForConfigIdTable,soldierId)
    totalSoldierCount=totalSoldierCount+1
    if missionPowerSoldiers[soldierId]then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif mvars.ene_eliminateTargetList[soldierId]then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif TppEnemy.GetSoldierType(soldierId)==EnemyType.TYPE_CHILD then
      powerElimOrChildSoldierTable[totalSoldierCount]=true
    elseif isOuterBaseCp then
      outerBaseSoldierTable[totalSoldierCount]=true
    elseif isLrrpCp then
      --outerBaseSoldierTable[totalSoldierCount]=true--tex was
      lrrpSoldierTable[totalSoldierCount]=true--tex was combined in above outerBase table
    end
  end

  if totalSoldierCount==0 then--tex> early out
    return
  end--<

  local cpConfig={}--NMC: the main point of the function
  for soldierConfigId=1,totalSoldierCount do
    if isOuterBaseCp then
      cpConfig[soldierConfigId]={OB=true}
    elseif isLrrpCp then--tex>
      cpConfig[soldierConfigId]={LRRP=true}
    else--<
      cpConfig[soldierConfigId]={}
    end
  end
  local powerComboExclusionList={
    ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},
    SOFT_ARMOR={"ARMOR"},
    SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},
    SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},
    MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},
    SMG={"SNIPER","SHOTGUN","MG"},
    MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},
    SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},
    HELMET={"ARMOR","GAS_MASK","NVG"},
    GAS_MASK={"ARMOR","HELMET","NVG"},
    NVG={"ARMOR","HELMET","GAS_MASK"},
    GUN_LIGHT={"SNIPER","MG"}
  }
  local abilitiesList={
    STEALTH_LOW=true,
    STEALTH_HIGH=true,
    STEALTH_SPECIAL=true,
    COMBAT_LOW=true,
    COMBAT_HIGH=true,
    COMBAT_SPECIAL=true,
    HOLDUP_LOW=true,
    HOLDUP_HIGH=true,
    HOLDUP_SPECIAL=true,
    FULTON_LOW=true,
    FULTON_HIGH=true,
    FULTON_SPECIAL=true
  }

  if Ivars.allowMissileWeaponsCombo:Is(1) then--tex>
    local weaponBalanceComboExclusionList={
      MISSILE={"ARMOR","SHIELD","SNIPER"},
      SHOTGUN={"SNIPER","MG","SHIELD","SMG"},
    --MG={"SNIPER","SHOTGUN","GUN_LIGHT","SHIELD","SMG"},
    }
  for powerType,excludeList in pairs(weaponBalanceComboExclusionList) do
    powerComboExclusionList[powerType]=excludeList
  end
  end--<

  if Ivars.enableMgVsShotgunVariation:Is(1) then--tex>
    local setting=revengeConfigCp.MG_OR_SHOTGUN or 0
    if setting~=0 then
      InfMain.SetLevelRandomSeed()
      local mgShottyLoadouts={
        {MG=setting,SHOTGUN=nil},
        {MG=nil,SHOTGUN=setting},
        {MG=math.floor(setting/2),SHOTGUN=math.floor(setting/2)},
      }
      local powerTable=mgShottyLoadouts[math.random(1,3)]
      for powerType,setting in pairs(powerTable)do
        revengeConfigCp[powerType]=setting
      end

      InfMain.ResetTrueRandom()
    end
  end--<


  local smallCpBalanceLimit=5--tex> WIP TODO magic number
  if Ivars.randomizeSmallCpPowers:Is(1) and totalSoldierCount <= smallCpBalanceLimit then
    --powertype={min,max}
    local smallCpBallanceList={
      ARMOR={0,totalSoldierCount},
      SNIPER={0,1},
      SHIELD={0,totalSoldierCount},--totalSoldierCount/2},
      MISSILE={0,totalSoldierCount},
      MG={0,totalSoldierCount},
      SHOTGUN={0,totalSoldierCount},
    }
    InfMain.SetLevelRandomSeed()
    for powerType,range in pairs(smallCpBallanceList) do
      if revengeConfigCp[powerType] then
        local currentSetting=revengeConfigCp[powerType]
        if not Tpp.IsTypeNumber(currentSetting)then
          currentSetting=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
        end

        revengeConfigCp[powerType]=math.random(range[1],math.min(currentSetting,range[2]))
        if revengeConfigCp[powerType]==0 then
          revengeConfigCp[powerType]=nil
        end
      end
    end
    InfMain.ResetTrueRandom()
  end--<

  if Ivars.balanceWeaponPowers:Is(1) then--tex WIP
    local balanceWeaponTypes={--tex>
      "SNIPER",
      "SHOTGUN",
      "MG",
      "SMG",
      "ASSAULT",
    }

  --tex TODO: need a way to account for the shield force applying SMGs when smgs is also set?? or does this not actually happen
  --      local smgTypes={
  --        --"SMG",
  --        "SHIELD",--tex this is forced in TppEnemy.ApplyPowerSetting
  --        --"MISSILE",--TODO: need to include if allowMissileWeaponsCombo is off
  --      }
  --      local totalSmgs=0
  --      for n, powerType in ipairs(smgTypes) do
  --        totalSmgs=totalSmgs+this._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
  --      end
  local powerType="SMG"
  local totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)

  local smgForced=revengeConfigCp.SHIELD and revengeConfigCp.SMG==nil
  if smgForced then
    local powerType="SHIELD"
    totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
    revengeConfigCp.SMG=totalSmgs
    --    elseif revengeConfigCp.MISSILE and not revengeConfigCp.SMG then
    --      local powerType="MISSILE"
    --      local totalSmgs=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
    --      revengeConfigCp.SMG=totalSmgs
    --
    --      if Ivars.allowMissileWeaponsCombo:Is(0) then
    --        smgForced=true
    --      end
  end

  local wantedWeapons={}
  for n,powerType in pairs(balanceWeaponTypes)do
    wantedWeapons[powerType]=0
  end

  local totalWanted=0
  for n,powerType in pairs(balanceWeaponTypes)do
    local wanted=TppRevenge._GetSettingSoldierCount(powerType,revengeConfigCp[powerType],totalSoldierCount)
    totalWanted=totalWanted+wanted
    wantedWeapons[powerType]=wanted
  end

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG
  --      InfMenu.DebugPrint("totalSoldierCount:" .. totalSoldierCount.." totalWanted weapons:"..totalWanted)
  --      local ins=InfInspect.Inspect(wantedWeapons)--DEBUG
  --      InfMenu.DebugPrint(ins)
  --    end--

  --    if revengeConfigCp.SMG==nil then
  --      revengeConfigCp.SMG=1
  --    end
  --
  --    local numTypes=0
  --    for n,powerType in pairs(balanceWeaponTypes)do
  --      numTypes=numTypes+1
  --    end

  revengeConfigCp.ASSAULT="10%"

  local originalWeaponSettings={}
  local sumBalance=0
  local numBalance=0
  numBalance,sumBalance,originalWeaponSettings=InfMain.GetSumBalance(balanceWeaponTypes,revengeConfigCp,totalSoldierCount,originalWeaponSettings)

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG>
  --      local ins=InfInspect.Inspect(originalWeaponSettings)
  --      InfMenu.DebugPrint(ins)
  --    end--<

  if numBalance>0 and sumBalance>Ivars.balanceWeaponPowers.balanceWeaponsThreshold then
    local reservePercent=0--tex TODO: reserve some for assault? or handle that
    revengeConfigCp=InfMain.BalancePowers(numBalance,reservePercent,originalWeaponSettings,revengeConfigCp)
  end

  if smgForced then
    revengeConfigCp.SHIELD=revengeConfigCp.SMG
    revengeConfigCp.SMG=nil--tex don't want CreateCpConfig to actually assign since these will be forced in TppEnemy.ApplyPowerSetting
  end

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG>
  --      InfMenu.DebugPrint("revengeConfig")
  --      local ins=InfInspect.Inspect(revengeConfig)
  --      InfMenu.DebugPrint(ins)
  --      InfMenu.DebugPrint("revengeConfigCp")
  --      local ins=InfInspect.Inspect(revengeConfigCp)
  --      InfMenu.DebugPrint(ins)
  --    end--<
  end--balanceWeaponPowers

  local originalHeadGearSettings={}--tex
  local sumBalance=0
  local numBalance=0
  if (Ivars.allowHeadGearCombo:Is(1) or Ivars.balanceHeadGear:Is(1)) then
    local balanceGearTypes={--tex>
      "ARMOR",
      "HELMET",
      "NVG",
      "GAS_MASK",
    }

    numBalance,sumBalance,originalHeadGearSettings=InfMain.GetSumBalance(balanceGearTypes,revengeConfigCp,totalSoldierCount,originalHeadGearSettings)
  end

  if (Ivars.balanceHeadGear:Is(1) and sumBalance>Ivars.balanceHeadGear.balanceHeadGearThreshold) then--tex> only need to balance if oversubscribed
    local reservePercent=0
    revengeConfigCp=InfMain.BalancePowers(numBalance,reservePercent,originalHeadGearSettings,revengeConfigCp)
  end--<

  local unfulfilledPowers={}--tex>
  local addConfigFlags={}

  if Ivars.allowMissileWeaponsCombo:Is(1) then
    addConfigFlags={MISSILE_COMBO=true}
  end--<

  cpConfig=CreateCpConfig(revengeConfigCp,totalSoldierCount,powerComboExclusionList,powerElimOrChildSoldierTable,isOuterBaseCp,isLrrpCp,abilitiesList,unfulfilledPowers,addConfigFlags,cpConfig,cpId)--tex now function

  --tex> rerun CreateCpConfig without headgear restrictions
  if (Ivars.allowHeadGearCombo:Is(1) and sumBalance>Ivars.allowHeadGearCombo.allowHeadGearComboThreshold) then
    if vars.missionCode~=30050 then
      local headGearComboExclusions={
        HELMET={"ARMOR"},
        GAS_MASK={"ARMOR","NVG"},
        NVG={"ARMOR","GAS_MASK"},
      }
      for powerType,excludeList in pairs(headGearComboExclusions) do
        powerComboExclusionList[powerType]=excludeList
      end
    else
      local headGearComboExclusionsDD={
        HELMET={"ARMOR"},
        GAS_MASK={"ARMOR"},
        NVG={"ARMOR"},
      }
      for powerType,excludeList in pairs(headGearComboExclusionsDD) do
        powerComboExclusionList[powerType]=excludeList
      end
    end

    local gearConfigFlags={
      HEADGEAR_COMBO=true
    }
    cpConfig=CreateCpConfig(revengeConfigCp,totalSoldierCount,powerComboExclusionList,powerElimOrChildSoldierTable,isOuterBaseCp,isLrrpCp,abilitiesList,unfulfilledPowers,gearConfigFlags,cpConfig,cpId)--tex now function
  end--<

  --    if Ivars.selectedCp:Is()==cpId then--tex DEBUG
  --      --if not InfMain.IsTableEmpty(unfulfilledPowers) then
  --      InfMenu.DebugPrint"unfulfilledPowers:"
  --      local instr=InfInspect.Inspect(unfulfilledPowers)
  --      InfMenu.DebugPrint(instr)
  --      --end--
  --    end--<
  --
  --  if Ivars.selectedCp:Is()==cpId then--tex DEBUG
  --    local instr=InfInspect.Inspect(cpConfig)
  --    InfMenu.DebugPrint(instr)
  --  end--<

  for soldierConfigId,soldierConfig in ipairs(cpConfig)do
    local soldierId=soldierIdForConfigIdTable[soldierConfigId]
    TppEnemy.ApplyPowerSetting(soldierId,soldierConfig)
    if missionAbilitySoldiers[soldierId]==nil then
      local personalAbilitySettings={}
      do
        local abilityLevel
        if soldierConfig.STEALTH_SPECIAL then
          abilityLevel="sp"
        elseif soldierConfig.STEALTH_HIGH then
          abilityLevel="high"
        elseif soldierConfig.STEALTH_LOW then
          abilityLevel="low"
        end
        personalAbilitySettings.notice=abilityLevel
        personalAbilitySettings.cure=abilityLevel
        personalAbilitySettings.reflex=abilityLevel
      end
      do
        local abilityLevel
        if soldierConfig.COMBAT_SPECIAL then
          abilityLevel="sp"
        elseif soldierConfig.COMBAT_HIGH then
          abilityLevel="high"
        elseif soldierConfig.COMBAT_LOW then
          abilityLevel="low"
        end
        personalAbilitySettings.shot=abilityLevel
        personalAbilitySettings.grenade=abilityLevel
        personalAbilitySettings.reload=abilityLevel
        personalAbilitySettings.hp=abilityLevel
      end
      do
        local abilityLevel
        if soldierConfig.STEALTH_SPECIAL or soldierConfig.COMBAT_SPECIAL then
          abilityLevel="sp"
        elseif soldierConfig.STEALTH_HIGH or soldierConfig.COMBAT_HIGH then
          abilityLevel="high"
        elseif soldierConfig.STEALTH_LOW or soldierConfig.COMBAT_LOW then
          abilityLevel="low"
        end
        personalAbilitySettings.speed=abilityLevel
      end
      do
        local abilitiyLevel
        if soldierConfig.FULTON_SPECIAL then
          abilitiyLevel="sp"
        elseif soldierConfig.FULTON_HIGH then
          abilitiyLevel="high"
        elseif soldierConfig.FULTON_LOW then
          abilitiyLevel="low"
        end
        personalAbilitySettings.fulton=abilitiyLevel
      end
      do
        local abilityLevel
        if soldierConfig.HOLDUP_SPECIAL then
          abilityLevel="sp"
        elseif soldierConfig.HOLDUP_HIGH then
          abilityLevel="high"
        elseif soldierConfig.HOLDUP_LOW then
          abilityLevel="low"
        end
        personalAbilitySettings.holdup=abilityLevel
      end
      TppEnemy.ApplyPersonalAbilitySettings(soldierId,personalAbilitySettings)
    end
  end
end
--ORIG
--function this._ApplyRevengeToCp(cpId,revengeConfig,RENsomeMBcounter)
--  local GetGameObjectId=GameObject.GetGameObjectId
--
--  local soldierIds=mvars.ene_soldierIDList[cpId]
--  local soldierIdForConfigIdTable={}
--  local totalSoldierCount=0
--  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
--    local r=0
--    local cpName=mvars.ene_cpList[cpId]
--    if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
--      local clusterIdList=mtbs_enemy.cpNameToClsterIdList[cpName]
--      if clusterIdList then
--        soldierIds={}
--        local soldierLocators=mvars.mbSoldier_enableSoldierLocatorList[clusterIdList]
--        for n,soldierName in ipairs(soldierLocators)do
--          local RENsomeMbSomethingId=tonumber(string.sub(soldierName,-6,-6))
--          if RENsomeMbSomethingId~=nil and RENsomeMbSomethingId==RENsomeMBcounter then
--            local soldierId=GameObject.GetGameObjectId("TppSoldier2",soldierName)
--            soldierIds[soldierId]=r
--          end
--        end
--      end
--    end
--  end
--  if soldierIds==nil then
--    return
--  end
--
--  local missionPowerSoldiers={}
--  for soldierName,missionPowerSetting in pairs(mvars.ene_missionSoldierPowerSettings)do
--    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
--    missionPowerSoldiers[soldierId]=missionPowerSetting
--  end
--  local missionAbilitySoldiers={}
--  for soldierName,e in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
--    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
--    missionAbilitySoldiers[soldierId]=e
--  end
--
--  local isOuterBaseCp=mvars.ene_outerBaseCpList[cpId]
--  local powerElimOrChildSoldierTable={}
--  local outerBaseOrLrrpSoldierTable={}
--  for soldierId,E in pairs(soldierIds)do
--    table.insert(soldierIdForConfigIdTable,soldierId)
--    totalSoldierCount=totalSoldierCount+1
--    if missionPowerSoldiers[soldierId]then
--      powerElimOrChildSoldierTable[totalSoldierCount]=true
--    elseif mvars.ene_eliminateTargetList[soldierId]then
--      powerElimOrChildSoldierTable[totalSoldierCount]=true
--    elseif TppEnemy.GetSoldierType(soldierId)==EnemyType.TYPE_CHILD then
--      powerElimOrChildSoldierTable[totalSoldierCount]=true
--    elseif isOuterBaseCp then
--      outerBaseOrLrrpSoldierTable[totalSoldierCount]=true
--    elseif mvars.ene_lrrpTravelPlan[cpId]then
--      outerBaseOrLrrpSoldierTable[totalSoldierCount]=true
--    end
--  end
--
--  local cpConfig={}--NMC: the main point of the function
--
--  for soldierConfigId=1,totalSoldierCount do
--    if isOuterBaseCp then
--      cpConfig[soldierConfigId]={OB=true}
--    else
--      cpConfig[soldierConfigId]={}
--    end
--  end
--
--  local powerComboExclusionList={
--    ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},
--    SOFT_ARMOR={"ARMOR"},SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},
--    SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},
--    MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},
--    SMG={"SNIPER","SHOTGUN","MG"},
--    MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},
--    SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},
--    HELMET={"ARMOR","GAS_MASK","NVG"},
--    GAS_MASK={"ARMOR","HELMET","NVG"},
--    NVG={"ARMOR","HELMET","GAS_MASK"},
--    GUN_LIGHT={"SNIPER","MG"}
--  }
--  local abilitiesList={STEALTH_LOW=true,STEALTH_HIGH=true,STEALTH_SPECIAL=true,COMBAT_LOW=true,COMBAT_HIGH=true,COMBAT_SPECIAL=true,HOLDUP_LOW=true,HOLDUP_HIGH=true,HOLDUP_SPECIAL=true,FULTON_LOW=true,FULTON_HIGH=true,FULTON_SPECIAL=true}
--
--  --MNC: create cp config
--  for r,powerType in ipairs(TppEnemy.POWER_SETTING)do
--    local powerSetting=revengeConfig[powerType]
--    if powerSetting then
--      local settingSoldierCount=this._GetSettingSoldierCount(powerType,powerSetting,totalSoldierCount)
--      local comboExcludeList=powerComboExclusionList[powerType]or{}
--      local soldierCount=settingSoldierCount
--      for soldierConfigId=1,totalSoldierCount do
--        local isPowerElimOrChild=powerElimOrChildSoldierTable[soldierConfigId]
--        local nonAbilityNonBaseSoldier=(not abilitiesList[powerType])and outerBaseOrLrrpSoldierTable[soldierConfigId]
--        if(not isPowerElimOrChild and not nonAbilityNonBaseSoldier)and soldierCount>0 then
--          local setPower=true
--          if cpConfig[soldierConfigId][powerType]then
--            soldierCount=soldierCount-1
--            setPower=false
--          end
--          if setPower then
--            for n,excludePower in ipairs(comboExcludeList)do
--              if cpConfig[soldierConfigId][excludePower]then
--                setPower=false
--              end
--            end
--          end
--          if setPower then
--            soldierCount=soldierCount-1
--            cpConfig[soldierConfigId][powerType]=true
--            if powerType=="MISSILE"and this.IsUsingStrongMissile()then
--              cpConfig[soldierConfigId].STRONG_MISSILE=true
--            end
--            if powerType=="SNIPER"and this.IsUsingStrongSniper()then
--              cpConfig[soldierConfigId].STRONG_SNIPER=true
--            end
--          end
--        end
--      end
--    end
--  end
--
--  for soldierConfigId,soldierConfig in ipairs(cpConfig)do
--    local soldierId=soldierIdForConfigIdTable[soldierConfigId]
--    TppEnemy.ApplyPowerSetting(soldierId,soldierConfig)
--    if missionAbilitySoldiers[soldierId]==nil then
--      local personalAbilitySettings={}
--      do
--        local stealth
--        if soldierConfig.STEALTH_SPECIAL then
--          stealth="sp"
--        elseif soldierConfig.STEALTH_HIGH then
--          stealth="high"
--        elseif soldierConfig.STEALTH_LOW then
--          stealth="low"
--        end
--        personalAbilitySettings.notice=stealth
--        personalAbilitySettings.cure=stealth
--        personalAbilitySettings.reflex=stealth
--      end
--      do
--        local combat
--        if soldierConfig.COMBAT_SPECIAL then
--          combat="sp"
--        elseif soldierConfig.COMBAT_HIGH then
--          combat="high"
--        elseif soldierConfig.COMBAT_LOW then
--          combat="low"
--        end
--        personalAbilitySettings.shot=combat
--        personalAbilitySettings.grenade=combat
--        personalAbilitySettings.reload=combat
--        personalAbilitySettings.hp=combat
--      end
--      do
--        local speed
--        if soldierConfig.STEALTH_SPECIAL or soldierConfig.COMBAT_SPECIAL then
--          speed="sp"
--        elseif soldierConfig.STEALTH_HIGH or soldierConfig.COMBAT_HIGH then
--          speed="high"
--        elseif soldierConfig.STEALTH_LOW or soldierConfig.COMBAT_LOW then
--          speed="low"
--        end
--        personalAbilitySettings.speed=speed
--      end
--      do
--        local fulton
--        if soldierConfig.FULTON_SPECIAL then
--          fulton="sp"
--        elseif soldierConfig.FULTON_HIGH then
--          fulton="high"
--        elseif soldierConfig.FULTON_LOW then
--          fulton="low"
--        end
--        personalAbilitySettings.fulton=fulton
--      end
--      do
--        local holdup
--        if soldierConfig.HOLDUP_SPECIAL then
--          holdup="sp"
--        elseif soldierConfig.HOLDUP_HIGH then
--          holdup="high"
--        elseif soldierConfig.HOLDUP_LOW then
--          holdup="low"
--        end
--        personalAbilitySettings.holdup=holdup
--      end
--      TppEnemy.ApplyPersonalAbilitySettings(soldierId,personalAbilitySettings)
--    end
--  end
--end
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="HeadShot",func=this._OnHeadShot},
      {msg="Dead",func=this._OnDead},
      {msg="Unconscious",func=this._OnUnconscious},
      {msg="ComradeFultonDiscovered",func=this._OnComradeFultonDiscovered},
      {msg="CommandPostAnnihilated",func=this._OnAnnihilated},
      {msg="ChangePhase",func=this._OnChangePhase},
      {msg="Damage",func=this._OnDamage},
      {msg="AntiSniperNoticed",func=this._OnAntiSniperNoticed},
      {msg="SleepingComradeRecoverd",func=this._OnSleepingComradeRecoverd},
      {msg="SmokeDiscovered",func=this._OnSmokeDiscovered},
      {msg="ReinforceRespawn",func=this._OnReinforceRespawn}},
    Trap={{msg="Enter",func=this._OnEnterTrap}}
  }
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
local AttackIsVehicle=function(attackId)--RETAILBUG: seems like attackid must be a typo and f
  if(((((((((((((attackId==TppDamage.ATK_VehicleHit
    or attackId==TppDamage.ATK_Tankgun_20mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_105mmRifledBoreGun)
    or attackId==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Wav1)
    or attackId==TppDamage.ATK_WavCannon)
    or attackId==TppDamage.ATK_TankCannon)
    or attackId==TppDamage.ATK_WavRocket)
    or attackId==TppDamage.ATK_HeliMiniGun)
    or attackId==TppDamage.ATK_HeliChainGun)
    or attackId==TppDamage.ATK_WalkerGear_BodyAttack
then
  return true
end
return false
end
--ORIG: RETAILBUG: --RETAILBUG: seems like attackid must be a typo (unless they randomly decided to use one Global and stop using camelCase
--local AttackedByVehicle=function(e)--RETAILBUG: seems like attackid must be a typo and f
--  if(((((((((((((attackid==TppDamage.ATK_VehicleHit or e==TppDamage.ATK_Tankgun_20mmAutoCannon)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Tankgun_105mmRifledBoreGun)or e==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Wav1)or e==TppDamage.ATK_WavCannon)or e==TppDamage.ATK_TankCannon)or e==TppDamage.ATK_WavRocket)or e==TppDamage.ATK_HeliMiniGun)or e==TppDamage.ATK_HeliChainGun)or attackid==TppDamage.ATK_WalkerGear_BodyAttack then
--    return true
--  end
--  return false
--end

function this._OnReinforceRespawn(soldierIds)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppEnemy.AddPowerSetting(soldierIds,{})
    o50050_enemy.AssignAndSetupRespawnSoldier(soldierIds)
  else
    this.ApplyPowerSettingsForReinforce{soldierIds}
  end
end
function this._OnHeadShot(E,t,t,n)
  if GetTypeIndex(E)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if bit.band(n,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)==0 then
    return
  end
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.HEAD_SHOT)
end
local AddRevengePointByEliminationType=function(playerPhase)
  if playerPhase==nil then
    playerPhase=vars.playerPhase
  end
  if playerPhase~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT)
  else
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH)
  end
  if TppClock.GetTimeOfDay()=="night"then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT)
  end
end
function this._OnDead(gameId,attackerId,phase,damageFlag)-- gameObjectId, attakerId, attackId )
  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
end
local attackerIsPlayerVehicle=(Tpp.IsVehicle(vars.playerVehicleGameObjectId)or Tpp.IsEnemyWalkerGear(vars.playerVehicleGameObjectId))or Tpp.IsPlayerWalkerGear(vars.playerVehicleGameObjectId)
local attackedByVehicle=AttackIsVehicle(attackId)--RETAILBUG: but then this has expected camelCase but is also orphaned by the minifier? they've changed the parameters of the function at some point from something similar to OnDamage to the wtf damageFlag
local attackerIsWalkerGear=Tpp.IsEnemyWalkerGear(attackerId)or Tpp.IsPlayerWalkerGear(attackerId)
local attackerIsPlayer=(attackerId==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
if(attackerIsWalkerGear or attackedByVehicle)or(attackerIsPlayer and attackerIsPlayerVehicle)then
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE)
end
AddRevengePointByEliminationType(phase)
if GetTypeIndex(attackerId)==TppGameObject.GAME_OBJECT_TYPE_HELI2 then
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI)
end
end
function this._OnUnconscious(gameId,t,playerPhase)
  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  local lifeStatus=GameObject.SendCommand(gameId,{id="GetLifeStatus"})
  if lifeStatus==TppGameObject.NPC_LIFE_STATE_DYING or lifeStatus==TppGameObject.NPC_LIFE_STATE_DEAD then
    return
  end
  AddRevengePointByEliminationType(playerPhase)
end
function this._OnAnnihilated(E,playerPhase,t)
  if t==0 then
    if TppEnemy.IsBaseCp(E)or TppEnemy.IsOuterBaseCp(E)then
      if playerPhase==nil then
        playerPhase=vars.playerPhase
      end
      if playerPhase~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
        this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT)
      else
        this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH)
      end
    end
  end
end
function this._OnChangePhase(cpId,phase)
  if phase~=TppGameObject.PHASE_ALERT then
    return
  end
  if TppClock.GetTimeOfDay()=="night"then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT)
  end
end
function this._OnComradeFultonDiscovered(n,n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.FULTON)
end
local AttackIsSmokeOrGas=function(attackId)
  if((((((((((((
    attackId==TppDamage.ATK_Smoke
    or attackId==TppDamage.ATK_SmokeOccurred)
    or attackId==TppDamage.ATK_SleepGus)
    or attackId==TppDamage.ATK_SleepGusOccurred)
    or attackId==TppDamage.ATK_SupportHeliFlareGrenade)
    or attackId==TppDamage.ATK_SupplyFlareGrenade)
    or attackId==TppDamage.ATK_SleepingGusGrenade)
    or attackId==TppDamage.ATK_SleepingGusGrenade_G1)
    or attackId==TppDamage.ATK_SleepingGusGrenade_G2)
    or attackId==TppDamage.ATK_SmokeAssist)
    or attackId==TppDamage.ATK_SleepGusAssist)
    or attackId==TppDamage.ATK_Grenader_Smoke)
    or attackId==TppDamage.ATK_Grenader_Sleep)
    or attackId==TppDamage.ATK_SmokeGrenade
  then
    return true
  end
  return false
end
function this._OnDamage(gameId,attackId,attackerID)
  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if AttackIsSmokeOrGas(attackId)then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.SMOKE)
  end
end
function this._OnSmokeDiscovered(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.WATCH_SMOKE)
end
function this._OnAntiSniperNoticed(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.SNIPED)
end
function this._OnSleepingComradeRecoverd(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE)
end
function this._OnEnterTrap(n)
  this.OnEnterRevengeMineTrap(n)
end
return this

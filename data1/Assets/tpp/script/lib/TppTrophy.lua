local this={}
this.MISSION_CLEAR={[10010]=1,[10020]=2,[10040]=3,[10070]=4,[10090]=5,[10110]=6,[10140]=7,[10151]=8,[10260]=9,[10280]=10}
this.BUDDY_FRIENDLY_MAX={[BuddyFriendlyType.HORSE]=26,[BuddyFriendlyType.DOG]=27,[BuddyFriendlyType.QUIET]=28}
local dominationTargetCpList={
  afgh={
    "afgh_field_cp",
    "afgh_remnants_cp",
    "afgh_tent_cp",
    "afgh_fieldEast_ob",
    "afgh_fieldWest_ob",
    "afgh_remnantsNorth_ob",
    "afgh_tentEast_ob",
    "afgh_tentNorth_ob",
    "afgh_village_cp",
    "afgh_slopedTown_cp",
    "afgh_commFacility_cp",
    "afgh_enemyBase_cp",
    "afgh_commWest_ob",
    "afgh_ruinsNorth_ob",
    "afgh_slopedWest_ob",
    "afgh_villageEast_ob",
    "afgh_villageNorth_ob",
    "afgh_villageWest_ob",
    "afgh_enemyEast_ob",
    "afgh_bridge_cp",
    "afgh_fort_cp",
    "afgh_cliffTown_cp",
    "afgh_bridgeNorth_ob",
    "afgh_bridgeWest_ob",
    "afgh_cliffEast_ob",
    "afgh_cliffSouth_ob",
    "afgh_cliffWest_ob",
    "afgh_enemyNorth_ob",
    "afgh_fortSouth_ob",
    "afgh_fortWest_ob",
    "afgh_slopedEast_ob",
    "afgh_powerPlant_cp",
    "afgh_sovietBase_cp",
    "afgh_plantWest_ob",
    "afgh_sovietSouth_ob",
    "afgh_waterwayEast_ob",
    "afgh_citadel_cp",
    "afgh_citadelSouth_ob"
  },
  mafr={
    "mafr_outland_cp",
    "mafr_outlandEast_ob",
    "mafr_outlandNorth_ob",
    "mafr_flowStation_cp",
    "mafr_swamp_cp",
    "mafr_pfCamp_cp",
    "mafr_savannah_cp",
    "mafr_swampEast_ob",
    "mafr_swampWest_ob",
    "mafr_swampSouth_ob",
    "mafr_pfCampEast_ob",
    "mafr_pfCampNorth_ob",
    "mafr_savannahEast_ob",
    "mafr_savannahWest_ob",
    "mafr_chicoVilWest_ob",
    "mafr_hillSouth_ob",
    "mafr_banana_cp",
    "mafr_diamond_cp",
    "mafr_hill_cp",
    "mafr_savannahNorth_ob",
    "mafr_bananaEast_ob",
    "mafr_bananaSouth_ob",
    "mafr_hillNorth_ob",
    "mafr_hillWest_ob",
    "mafr_hillWestNear_ob",
    "mafr_factorySouth_ob",
    "mafr_diamondNorth_ob",
    "mafr_diamondSouth_ob",
    "mafr_diamondWest_ob",
    "mafr_factoryWest_ob",
    "mafr_lab_cp",
    "mafr_labWest_ob"
  }
}
this.DOMINATION_TARGET_CP_COUNT={afgh=#dominationTargetCpList.afgh,mafr=#dominationTargetCpList.mafr}
this.DOMINATION_TARGET_CP_NAME_LIST={}
for o,cpName in ipairs(dominationTargetCpList.afgh)do
  this.DOMINATION_TARGET_CP_NAME_LIST[cpName]=true
end
for o,cpName in ipairs(dominationTargetCpList.mafr)do
  this.DOMINATION_TARGET_CP_NAME_LIST[cpName]=true
end
if TppCommandPost2.SetDominationTargetCpList then
  TppCommandPost2.SetDominationTargetCpList{afgh=dominationTargetCpList.afgh,mafr=dominationTargetCpList.mafr}
end
function this.Unlock(a,heroicPoint,_)
  if not(TppMission.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM))then
    if not gvars.trp_isGot[a]then
      if heroicPoint then
        local ogrePoint=0
        if _ then
          ogrePoint=_
        end
        TppHero.SetAndAnnounceHeroicOgrePoint{heroicPoint=heroicPoint,ogrePoint=ogrePoint}
      end
    end
    gvars.trp_isGot[a]=true
  end
  Trophy.TrophyUnlock(a)
  local a=true
  for _=1,47 do
    if not gvars.trp_isGot[_]then
      a=false
      break
    end
  end
  if a then
    if not gvars.trp_isGot[0]then
      gvars.trp_isGot[0]=true
    end
  end
end
function this.UnlockOnMissionClear(_)
  local _=this.MISSION_CLEAR[_]
  if _ then
    this.Unlock(_)
  end
end
function this.UnlockOnBuddyFriendlyMax()
  for _,o in pairs(this.BUDDY_FRIENDLY_MAX)do
    if TppBuddyService.GetFriendlyPoint(_)>=100 then
      this.Unlock(o,5e3,-5e3)
    end
  end
end
function this.UnlockOnAllMissionTaskCompleted()
  local _=true
  for a,o in pairs(TppResult.MISSION_TASK_LIST)do
    if not TppUI.IsAllTaskCompleted(a)then
      _=false
      break
    end
  end
  if _ then
    this.Unlock(13,3e4)
  end
end
function this.UnlockOnAllQuestClear()
  this.Unlock(17)
end
return this

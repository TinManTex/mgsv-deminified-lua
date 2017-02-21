local this={}
local StrCode32=Fox.StrCode32
local srankClearEmblems={[10010]="front32",[10020]="front61",[10036]="front27",[10043]="front31",[10033]="front1",[10040]={"front42","front48"},[10041]="front2",[10044]="front3",[10052]="front53",[10054]="front13",[10050]="front21",[10070]="front37",[10080]="front38",[10086]="front4",[10082]="front12",[10090]="front39",[10195]="front65",[10091]="front52",[10100]="front44",[10110]="front33",[10121]={"front5","front64"},[10120]="front19",[10085]="front6",[10200]="front60",[10211]="front45",[10081]="front50",[10130]="front66",[10140]="front23",[10150]="front51",[10151]="front25",[10045]="front29",[10156]="front81",[10093]="front80",[10171]="front14",[10260]="front35",[10280]="front67"}
local missionClearEmblems={[10050]={"word47","word147"},[10070]={"front68","word96","word109"},[10120]="word149",[10195]={"word157","word158"},[10121]={"word155","word156"},[10130]={"word159","word160","word161"},[10140]={"word150","word151","word162"},[10150]={"word133","word134","word135","word136"},[10151]={"front17","front69","word97","word110","word152"},[10240]={"front36","front43"},[10260]={"front70","word98","word111","word114","word115"},[10280]={"front72","front73","word4","word5","word18","word19","word35","word36","word102"}}
local allTaskClearEmblems={[10020]="base43",[10030]="base20",[10036]="base39",[10043]="base40",[10033]="base2",[10040]="base4",[10041]="base5",[10044]="base7",[10052]="base8",[10054]="base9",[10050]="base36",[10070]="base14",[10080]="base10",[10086]="base12",[10082]="base13",[10090]="base21",[10195]="base47",[10091]="base22",[10100]="base24",[10110]="base25",[10121]="base46",[10115]="base17",[10120]="base35",[10085]="base26",[10200]="base27",[10211]="base33",[10081]="base28",[10130]="base48",[10140]="base37",[10150]="base15",[10151]="base38",[10045]="base34",[10156]="base29",[10093]="base30",[10171]="base31",[10240]="base45",[10260]="base11",[10280]="base49"}
local eliminateCpEmblems={afgh_citadelSouth_ob="word6",afgh_sovietSouth_ob="word7",afgh_plantWest_ob="word8",afgh_waterwayEast_ob="word9",afgh_tentNorth_ob="word10",afgh_enemyNorth_ob="word11",afgh_cliffWest_ob="word12",afgh_tentEast_ob="word13",afgh_cliffEast_ob="word23",afgh_slopedWest_ob="word24",afgh_remnantsNorth_ob="word25",afgh_cliffSouth_ob="word26",afgh_field_cp="word27",afgh_fortWest_ob="word28",afgh_enemyEast_ob="word29",afgh_slopedEast_ob="word30",afgh_fortSouth_ob="word31",afgh_villageNorth_ob="word32",afgh_commWest_ob="word33",afgh_bridgeWest_ob="word34",afgh_enemyBase_cp="word43",afgh_cliffTown_cp="word49",afgh_bridgeNorth_ob="word52",afgh_citadel_cp="word53",afgh_slopedTown_cp="word54",afgh_fieldWest_ob="word55",afgh_remnants_cp="word59",afgh_bridge_cp="word60",afgh_fort_cp="word61",afgh_commFacility_cp="word62",afgh_villageEast_ob="word63",afgh_powerPlant_cp="word64",afgh_sovietBase_cp="word65",afgh_tent_cp="word66",afgh_village_cp="word67",afgh_ruinsNorth_ob="word68",afgh_fieldEast_ob="word69",afgh_villageWest_ob="word70",mafr_swampWest_ob="word71",mafr_diamondNorth_ob="word72",mafr_bananaEast_ob="word73",mafr_bananaSouth_ob="word76",mafr_savannahWest_ob="word104",mafr_hill_cp="word90",mafr_savannah_cp="word92",mafr_banana_cp="word93",mafr_pfCamp_cp="word94",mafr_outlandNorth_ob="word95",mafr_diamondWest_ob="word100",mafr_diamond_cp="word101",mafr_labWest_ob="word103",mafr_savannahNorth_ob="word77",mafr_swampEast_ob="word105",mafr_outland_cp="word106",mafr_outlandEast_ob="word107",mafr_swampSouth_ob="word108",mafr_diamondSouth_ob="word113",mafr_swamp_cp="word116",mafr_lab_cp="word117",mafr_pfCampNorth_ob="word118",mafr_savannahEast_ob="word119",mafr_hillNorth_ob="word120",mafr_pfCampEast_ob="word121",mafr_hillWest_ob="word130",mafr_factorySouth_ob="word132",mafr_flowStation_cp="word137",mafr_factoryWest_ob="word163",mafr_hillWestNear_ob="word164",mafr_chicoVilWest_ob="word165",mafr_hillSouth_ob="word166"}
local playStyleEmblems={false,5002,5003,5004,false,5005,5006,5007,5008,5009,5010,5011,5012,5013,5014,5015,5016,5017,5018,5019,5020,5021,5022,5023,false,5025,5026,5027}
function this.AcquireOnSRankClear(a)
  this._AcquireByMissionCode(srankClearEmblems,a)
end
function this.AcquireOnMissionClear(r)
  this._AcquireByMissionCode(missionClearEmblems,r)
end
function this.AcquireOnAllMissionTaskComleted(r)
  this._AcquireByMissionCode(allTaskClearEmblems,r)
end
function this.AcquireOnAllMissionCleared()
  local r={"word3","word38","word39"}
  for a,r in ipairs(r)do
    this.Add(r,true)
  end
end
function this.AcquireOnAllMissionSRankCleared()
  local r={"word56","word57","front83","front84"}
  for a,r in ipairs(r)do
    this.Add(r,true)
  end
end
function this._AcquireByMissionCode(a,r)
  local r=a[r]
  if not r then
    return
  end
  if Tpp.IsTypeString(r)then
    this.Add(r,true)
  elseif Tpp.IsTypeTable(r)then
    for a,r in ipairs(r)do
      this.Add(r,true)
    end
  end
end
function this.SetUpCpEmblemTag(cpName,cpId)
  mvars.emb_cpAnihilateEmblemTag=mvars.emb_cpAnihilateEmblemTag or{}
  local o=eliminateCpEmblems[cpName]
  if o then
    mvars.emb_cpAnihilateEmblemTag[cpId]=o
  end
end
function this.AcquireOnCommandPostAnnihilated(r)
  if not mvars.emb_cpAnihilateEmblemTag then
    return
  end
  local r=mvars.emb_cpAnihilateEmblemTag[r]
  if r then
    this.Add(r,false,true)
  end
end
function this.AcquireByPlayStyle(r)
  local r=playStyleEmblems[r]
  if r then
    local a=string.format("front%04d",r)
    local r=string.format("word%04d",r)
    this.Add(a,true)
    this.Add(r,true)
  end
end
function this.Add(o,e,a)
  if TppUiCommand.HasEmblemTexture(o)then
    return
  end
  TppUiCommand.AddEmblemTexture(o)
  local r=TppUiCommand.GetEmblemPartsType(o)
  if e then
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.EMBLEM,arg1=StrCode32(o),arg2=r}
  end
  if a then
    local o=TppUiCommand.GetEmblemLangId(o)
    local r=TppUI.EMBLEM_ANNOUNCE_LOG_TYPE[r]
    TppUI.ShowAnnounceLog(r,o)
  end
  return true
end
function this.Remove(o)
  if not TppUiCommand.HasEmblemTexture(o)then
    return
  end
  TppUiCommand.RemoveEmblemTexture(o)
  return true
end
return this

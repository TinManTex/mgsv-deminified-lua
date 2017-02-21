-- DOBUILD: 1
local this={}
local IsTypeTable=Tpp.IsTypeTable
local SendCommand=GameObject.SendCommand
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local recoverReward1RecoverCount=500
local recoverReward2RecoverCount=1e3
local budyIdLimit=4
this.GMP_POSTER=500
this.FOB_TUTORIAL_STATE={INIT=0,INTRODUCTION_CONSTRUCT_FOB=1,CONSTRUCT_FOB=2,INTRODUCTION_FOB_MISSIONS=3,FOB_MISSIONS=4,FINISH=127}
this.unitLvAnnounceLogTable={
  [Fox.StrCode32"Combat"]={up="unitLvUpCombat",down="unitLvDownCombat"},
  [Fox.StrCode32"Develop"]={up="unitLvUpRd",down="unitLvDownRd"},
  [Fox.StrCode32"Support"]={up="unitLvUpSupport",down="unitLvDownSupport"},
  [Fox.StrCode32"Medical"]={up="unitLvUpMedical",down="unitLvDownMedical"},
  [Fox.StrCode32"Spy"]={up="unitLvUpIntel",down="unitLvDownIntel"},
  [Fox.StrCode32"PrantDev"]={up="unitLvUpBaseDev",down="unitLvDownBaseDev"},
  [Fox.StrCode32"Security"]={up="unitLvUpSecurity",down="unitLvDownSecurity"}
}
this.keyItemAnnounceLogTable={
  [TppMotherBaseManagementConst.DESIGN_3011]="key_item_3011",
  [TppMotherBaseManagementConst.DESIGN_3012]="key_item_3012",
  [TppMotherBaseManagementConst.DESIGN_3006]="key_item_3006",
  [TppMotherBaseManagementConst.DESIGN_3005]="key_item_3005",
  [TppMotherBaseManagementConst.DESIGN_3000]="key_item_3000",
  [TppMotherBaseManagementConst.DESIGN_3009]="key_item_3009",
  [TppMotherBaseManagementConst.DESIGN_3002]="key_item_3002",
  [TppMotherBaseManagementConst.DESIGN_3007]="key_item_3007",
  [TppMotherBaseManagementConst.DESIGN_3001]="key_item_3001"}
this.keyItemRewardTable={
  [TppMotherBaseManagementConst.DESIGN_3013]="key_item_3013",
  [TppMotherBaseManagementConst.DESIGN_3003]="key_item_3003",
  [TppMotherBaseManagementConst.DESIGN_3008]="key_item_3008",
  [TppMotherBaseManagementConst.DESIGN_3014]="key_item_3014",
  [TppMotherBaseManagementConst.DESIGN_3015]="key_item_3015",
  [TppMotherBaseManagementConst.DESIGN_3016]="key_item_3016",
  [TppMotherBaseManagementConst.DESIGN_3017]="key_item_3017",
  [TppMotherBaseManagementConst.DESIGN_3018]="key_item_3018",
  [TppMotherBaseManagementConst.DESIGN_3019]="key_item_3019",
  [TppMotherBaseManagementConst.DESIGN_3007]="key_item_3007",
  [TppMotherBaseManagementConst.DESIGN_3010]="key_item_3010",
  [TppMotherBaseManagementConst.DESIGN_3020]="key_item_3020"}
this.parasiteSquadFultonResouceId={
  [Fox.StrCode32"Cam"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_CAMOFLA,5},
  [Fox.StrCode32"Fog"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_FOG,5},
  [Fox.StrCode32"Metal"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_CURING,5}
}
this.MOTHER_BASE_SECTION_LIST={"Combat","BaseDev","Spy","Medical","Security","Hospital","Prison","Separation"}
local MBMConst=TppMotherBaseManagementConst or{}
local sectionFunctionIdTable={
  Combat={
    DispatchSoldier=MBMConst.SECTION_FUNC_ID_COMBAT_DEPLOY,
    DispatchFobDefence=MBMConst.SECTION_FUNC_ID_COMBAT_DEFENCE},
  Develop={
    Weapon=MBMConst.SECTION_FUNC_ID_DEVELOP_WEAPON,
    SupportHelicopter=MBMConst.SECTION_FUNC_ID_DEVELOP_HELI,
    Quiet=MBMConst.SECTION_FUNC_ID_DEVELOP_QUIET,
    D_Dog=MBMConst.SECTION_FUNC_ID_DEVELOP_D_DOG,
    D_Horse=MBMConst.SECTION_FUNC_ID_DEVELOP_D_HORSE,
    D_Walker=MBMConst.SECTION_FUNC_ID_DEVELOP_D_WALKER,
    BattleGear=MBMConst.SECTION_FUNC_ID_DEVELOP_BATTLE_GEAR,
    SecurityDevice=MBMConst.SECTION_FUNC_ID_DEVELOP_SECURITY_DEVICE},
  BaseDev={
    Mining=MBMConst.SECTION_FUNC_ID_BASE_DEV_RESOURCE_MINING,
    Processing=MBMConst.SECTION_FUNC_ID_BASE_DEV_RESOURCE_PROCESSING,
    Extention=MBMConst.SECTION_FUNC_ID_BASE_DEV_PLATFORM_EXTENTION,
    Construct=MBMConst.SECTION_FUNC_ID_BASE_DEV_FOB_CONSTRUCT,
    NuclearDevelop=MBMConst.SECTION_FUNC_ID_BASE_DEV_NUCLEAR_DEVELOP},
  Support={
    Fulton=MBMConst.SECTION_FUNC_ID_SUPPORT_FULTON,
    Supply=MBMConst.SECTION_FUNC_ID_SUPPORT_SUPPLY,
    Battle=MBMConst.SECTION_FUNC_ID_SUPPORT_BATTLE,
    BattleArtillery=MBMConst.SECTION_FUNC_ID_SUPPORT_STRIKE,
    BattleSmoke=MBMConst.SECTION_FUNC_ID_SUPPORT_SMOKE,
    BattleSleepGas=MBMConst.SECTION_FUNC_ID_SUPPORT_SLEEP_GAS,
    BattleChaff=MBMConst.SECTION_FUNC_ID_SUPPORT_CHAFF,
    BattleWeather=MBMConst.SECTION_FUNC_ID_SUPPORT_WEATHER,
    TranslationRussian=MBMConst.SECTION_FUNC_ID_SUPPORT_RUSSIAN_TRANSLATE,
    TranslationAfrikaans=MBMConst.SECTION_FUNC_ID_SUPPORT_AFRIKAANS_TRANSLATE,
    TranslationKikongo=MBMConst.SECTION_FUNC_ID_SUPPORT_KIKONGO_TRANSLATE,
    TranslationPashto=MBMConst.SECTION_FUNC_ID_SUPPORT_PASHTO_TRANSLATE},
  Spy={
    Information=MBMConst.SECTION_FUNC_ID_SPY_MISSION_INFO_COLLECTING,
    Scouting=MBMConst.SECTION_FUNC_ID_SPY_ENEMY_SEARCH,
    SearchResource=MBMConst.SECTION_FUNC_ID_SPY_RESOURCE_SEARCH,
    WeatherInformation=MBMConst.SECTION_FUNC_ID_SPY_WEATHER_INFO},
  Medical={
    Emergency=MBMConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY,
    Treatment=MBMConst.SECTION_FUNC_ID_MEDICAL_STAFF_TREATMENT,
    AntiReflex=MBMConst.SECTION_FUNC_ID_MEDICAL_ANTI_REFLEX},--RETAILPATCH: 1060
  Security={
    BaseDefence=MBMConst.SECTION_FUNC_ID_SECURITY_BASE_DEFENCE_STAFF,
    MachineDefence=MBMConst.SECTION_FUNC_ID_SECURITY_BASE_DEFENCE_MACHINE,
    BaseBlockade=MBMConst.SECTION_FUNC_ID_SECURITY_BASE_BLOCKADE,
    SecurityInfo=MBMConst.SECTION_FUNC_ID_SPY_SECURITY_INFO
  }
}
this.setUpMenuList={}
this.MBDVCMENU={
  ALL="all",
  MBM="MBM",
  MBM_REWORD="MBM_REWORD",
  MBM_CUSTOM="MBM_CUSTOM",
  MBM_CUSTOM_WEAPON="MBM_CUSTOM_WEAPON",
  MBM_CUSTOM_ARMS="MBM_CUSTOM_ARMS",
  MBM_CUSTOM_ARMS_HELI="MBM_CUSTOM_ARMS_HELI",
  MBM_CUSTOM_ARMS_VEHICLE="MBM_CUSTOM_ARMS_VEHICLE",
  MBM_CUSTOM_BUDDY="MBM_CUSTOM_BUDDY",
  MBM_CUSTOM_BUDDY_HORSE="MBM_CUSTOM_BUDDY_HORSE",
  MBM_CUSTOM_BUDDY_DOG="MBM_CUSTOM_BUDDY_DOG",
  MBM_CUSTOM_BUDDY_QUIET="MBM_CUSTOM_BUDDY_QUIET",
  MBM_CUSTOM_BUDDY_WALKER="MBM_CUSTOM_BUDDY_WALKER",
  MBM_CUSTOM_BUDDY_BATTLE="MBM_CUSTOM_BUDDY_BATTLE",
  MBM_CUSTOM_DESIGN="MBM_CUSTOM_DESIGN",
  MBM_CUSTOM_DESIGN_EMBLEM="MBM_CUSTOM_DESIGN_EMBLEM",
  MBM_CUSTOM_DESIGN_BASE="MBM_CUSTOM_DESIGN_BASE",
  MBM_CUSTOM_AVATAR="MBM_CUSTOM_AVATAR",
  MBM_DEVELOP="MBM_DEVELOP",
  MBM_DEVELOP_WEAPON="MBM_DEVELOP_WEAPON",
  MBM_DEVELOP_ARMS="MBM_DEVELOP_ARMS",
  MBM_RESOURCE="MBM_RESOURCE",
  MBM_STAFF="MBM_STAFF",
  MBM_COMBAT="MBM_COMBAT",
  MBM_BASE="MBM_BASE",
  MBM_BASE_SECURITY="MBM_BASE_SECURITY",
  MBM_BASE_EXPANTION="MBM_BASE_EXPANTION",
  MBM_DB="MBM_DB",
  MBM_DB_ENCYCLOPEDIA="MBM_DB_ENCYCLOPEDIA",
  MBM_DB_KEYITEM="MBM_DB_KEYITEM",
  MBM_DB_CASSETTE="MBM_DB_CASSETTE",
  MBM_DB_PFRATING="MBM_DB_PFRATING",
  MBM_LOG="MBM_LOG",
  MSN="MSN",
  MSN_EMERGENCIE_N="MSN_EMERGENCIE_N",
  MSN_EMERGENCIE_F="MSN_EMERGENCIE_F",
  MSN_DROP="MSN_DROP",
  MSN_DROP_BULLET="MSN_DROP_BULLET",
  MSN_DROP_WEAPON="MSN_DROP_WEAPON",
  MSN_DROP_LOADOUT="MSN_DROP_LOADOUT",
  MSN_DROP_VEHICLE="MSN_DROP_VEHICLE",
  MSN_BUDDY="MSN_BUDDY",
  MSN_BUDDY_HORSE="MSN_BUDDY_HORSE",
  MSN_BUDDY_HORSE_DISMISS="MSN_BUDDY_HORSE_DISMISS",
  MSN_BUDDY_DOG="MSN_BUDDY_DOG",
  MSN_BUDDY_DOG_DISMISS="MSN_BUDDY_DOG_DISMISS",
  MSN_BUDDY_QUIET_SCOUT="MSN_BUDDY_QUIET_SCOUT",
  MSN_BUDDY_QUIET_ATTACK="MSN_BUDDY_QUIET_ATTACK",
  MSN_BUDDY_QUIET_DISMISS="MSN_BUDDY_QUIET_DISMISS",
  MSN_BUDDY_WALKER="MSN_BUDDY_WALKER",
  MSN_BUDDY_WALKER_DISMISS="MSN_BUDDY_WALKER_DISMISS",
  MSN_BUDDY_BATTLE="MSN_BUDDY_BATTLE",
  MSN_BUDDY_BATTLE_DISMISS="MSN_BUDDY_BATTLE_DISMISS",
  MSN_BUDDY_EQUIP="MSN_BUDDY_EQUIP",
  MSN_ATTACK="MSN_ATTACK",
  MSN_ATTACK_ARTILLERY="MSN_ATTACK_ARTILLERY",
  MSN_ATTACK_SMOKE="MSN_ATTACK_SMOKE",
  MSN_ATTACK_SLEEP="MSN_ATTACK_SLEEP",
  MSN_ATTACK_CHAFF="MSN_ATTACK_CHAFF",
  MSN_ATTACK_WEATHER="MSN_ATTACK_WEATHER",
  MSN_ATTACK_WEATHER_SANDSTORM="MSN_ATTACK_WEATHER_SANDSTORM",
  MSN_ATTACK_WEATHER_STORM="MSN_ATTACK_WEATHER_STORM",
  MSN_ATTACK_WEATHER_CLEAR="MSN_ATTACK_WEATHER_CLEAR",
  MSN_HELI="MSN_HELI",
  MSN_HELI_RENDEZVOUS="MSN_HELI_RENDEZVOUS",
  MSN_HELI_ATTACK="MSN_HELI_ATTACK",
  MSN_HELI_DISMISS="MSN_HELI_DISMISS",
  MSN_MISSIONLIST="MSN_MISSIONLIST",
  MSN_SIDEOPSLIST="MSN_SIDEOPSLIST",
  MSN_CHALLENGE="MSN_CHALLENGE",--RETAILPATCH 1070
  MSN_LOCATION="MSN_LOCATION",
  MSN_RETURNMB="MSN_RETURNMB",
  MSN_FOB="MSN_FOB",
  MSN_FRIEND="MSN_FRIEND",
  MSN_LOG="MSN_LOG"
}
this.BUDDY_MB_DVC_MENU={
  [BuddyType.QUIET]={
    {menu=this.MBDVCMENU.MSN_BUDDY_QUIET_SCOUT,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_QUIET_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_QUIET_DISMISS,active=true}
  },
  [BuddyType.DOG]={
    {menu=this.MBDVCMENU.MSN_BUDDY_DOG,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_DOG_DISMISS,active=true}
  },
  [BuddyType.HORSE]={
    {menu=this.MBDVCMENU.MSN_BUDDY_HORSE,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_HORSE_DISMISS,active=true}
  },
  [BuddyType.WALKER_GEAR]={
    {menu=this.MBDVCMENU.MSN_BUDDY_WALKER,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_WALKER_DISMISS,active=true}
  },
  [BuddyType.BATTLE_GEAR]={
    {menu=this.MBDVCMENU.MSN_BUDDY_BATTLE,active=true},
    {menu=this.MBDVCMENU.MSN_BUDDY_BATTLE_DISMISS,active=true}
  }
}
this.RESOURCE_INFORMATION_TABLE={
  [TppCollection.TYPE_MATERIAL_CM_0]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_1]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_2]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_3]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_4]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_5]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_6]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_CM_7]={resourceName="CommonMetal",count=100},
  [TppCollection.TYPE_MATERIAL_MM_0]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_1]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_2]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_3]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_4]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_5]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_6]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_MM_7]={resourceName="MinorMetal",count=50},
  [TppCollection.TYPE_MATERIAL_PM_0]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_1]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_2]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_3]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_4]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_5]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_6]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_PM_7]={resourceName="PreciousMetal",count=10},
  [TppCollection.TYPE_MATERIAL_FR_0]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_1]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_2]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_3]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_4]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_5]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_6]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_FR_7]={resourceName="FuelResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_0]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_1]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_2]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_3]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_4]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_5]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_6]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_MATERIAL_BR_7]={resourceName="BioticResource",count=100},
  [TppCollection.TYPE_HERB_G_CRESCENT]={resourceName="Plant2000",count=10},
  [TppCollection.TYPE_HERB_A_PEACH]={resourceName="Plant2001",count=10},
  [TppCollection.TYPE_HERB_DIGITALIS_P]={resourceName="Plant2002",count=10},
  [TppCollection.TYPE_HERB_DIGITALIS_R]={resourceName="Plant2003",count=10},
  [TppCollection.TYPE_HERB_B_CARROT]={resourceName="Plant2004",count=10},
  [TppCollection.TYPE_HERB_WORM_WOOD]={resourceName="Plant2005",count=10},
  [TppCollection.TYPE_HERB_TARRAGON]={resourceName="Plant2006",count=10},
  [TppCollection.TYPE_HERB_HAOMA]={resourceName="Plant2007",count=10},
  [TppCollection.TYPE_POSTER_SOL_AFGN]={resourceName="Poster1000",count=1},
  [TppCollection.TYPE_POSTER_SOL_MAFR]={resourceName="Poster1001",count=1},
  [TppCollection.TYPE_POSTER_SOL_ZRS]={resourceName="Poster1002",count=1},
  [TppCollection.TYPE_POSTER_GRAVURE_V]={resourceName="Poster1003",count=1},
  [TppCollection.TYPE_POSTER_GRAVURE_H]={resourceName="Poster1004",count=1},
  [TppCollection.TYPE_POSTER_MOE_V]={resourceName="Poster1005",count=1},
  [TppCollection.TYPE_POSTER_MOE_H]={resourceName="Poster1006",count=1}
}
this.BLUE_PRINT_LOCATOR_TABLE={col_develop_Revolver_Shotgun=MBMConst.DESIGN_2002,col_develop_Highprecision_SMG=MBMConst.DESIGN_2006,col_develop_HighprecisionAR=MBMConst.DESIGN_2007,col_develop_HighprecisionAR_s10033_0000=MBMConst.DESIGN_2007,col_develop_BullpupAR=MBMConst.DESIGN_2008,col_develop_LongtubeShotgun=MBMConst.DESIGN_2009,col_develop_RevolverGrenade0001=MBMConst.DESIGN_2011,col_develop_RevolverGrenade0002=MBMConst.DESIGN_2011,col_develop_RevolverGrenade0003=MBMConst.DESIGN_2011,col_develop_RevolverGrenade0004=MBMConst.DESIGN_2011,col_develop_Semiauto_SR=MBMConst.DESIGN_2013,col_develop_Semiauto_SR_s10070_0000=MBMConst.DESIGN_2013,col_develop_Antimaterial=MBMConst.DESIGN_2015,col_develop_EuropeSMG0001=MBMConst.DESIGN_2016,col_develop_EuropeSMG0002=MBMConst.DESIGN_2016,col_develop_EuropeSMG0003=MBMConst.DESIGN_2016,col_develop_EuropeSMG0004=MBMConst.DESIGN_2016,col_develop_Stungrenade=MBMConst.DESIGN_2019,col_develop_Stungun=MBMConst.DESIGN_2020,col_develop_Infraredsensor=MBMConst.DESIGN_2021,col_develop_Theftprotection=MBMConst.DESIGN_2022,col_develop_Emergencyrescue=MBMConst.DESIGN_3001,col_develop_FLamethrower=MBMConst.DESIGN_2026,col_develop_Shield=MBMConst.DESIGN_2025,col_develop_Shield0000=MBMConst.DESIGN_2025,col_develop_Shield0001=MBMConst.DESIGN_2025,col_develop_Shield0002=MBMConst.DESIGN_2025,col_develop_GunCamera=MBMConst.DESIGN_2023,col_develop_UAV=MBMConst.DESIGN_2024,col_develop_q60115=MBMConst.DESIGN_2027}
this.BLUE_PRINT_LANG_ID={[MBMConst.DESIGN_2002]="key_bprint_2002",[MBMConst.DESIGN_2006]="key_bprint_2006",[MBMConst.DESIGN_2007]="key_bprint_2007",[MBMConst.DESIGN_2008]="key_bprint_2008",[MBMConst.DESIGN_2009]="key_bprint_2009",[MBMConst.DESIGN_2011]="key_bprint_2011",[MBMConst.DESIGN_2013]="key_bprint_2013",[MBMConst.DESIGN_2015]="key_bprint_2015",[MBMConst.DESIGN_2016]="key_bprint_2016",[MBMConst.DESIGN_2019]="key_bprint_2019",[MBMConst.DESIGN_2020]="key_bprint_2020",[MBMConst.DESIGN_2021]="key_bprint_2021",[MBMConst.DESIGN_2022]="key_bprint_2022",[MBMConst.DESIGN_2023]="key_bprint_2023",[MBMConst.DESIGN_2024]="key_bprint_2024",[MBMConst.DESIGN_2025]="key_bprint_2025",[MBMConst.DESIGN_2026]="key_bprint_2026",[MBMConst.DESIGN_2027]="key_bprint_2027",[MBMConst.DESIGN_3001]="key_item_3001"}
this.EMBLEM_LOCATOR_TABLE={["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0000"]="front8",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0001"]="front10",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0002"]="front15",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0003"]="front16",["ly003_cl04_collct0000|cl04pl0_uq_0040_collct|col_emblem_quiet"]="front9",col_develop_MTBS_30150_0000="front11",col_develop_MTBS_30250_0000="front7"}
local gmpCostNames={}
if TppDefine.GMP_COST_TYPE then
  gmpCostNames[TppDefine.GMP_COST_TYPE.FULTON]="gmpCostFulton"
  gmpCostNames[TppDefine.GMP_COST_TYPE.SUPPORT_SUPPLY]="gmpCostSupply"
  gmpCostNames[TppDefine.GMP_COST_TYPE.SUPPORT_ATTACK]="gmpCostAttack"
  gmpCostNames[TppDefine.GMP_COST_TYPE.CALL_HELLI]="gmpCostHeli"
  gmpCostNames[TppDefine.GMP_COST_TYPE.BUDDY]="gmpCostOps"
  gmpCostNames[TppDefine.GMP_COST_TYPE.CLEAR_SIDE_OPS]="gmpGet"
  gmpCostNames[TppDefine.GMP_COST_TYPE.DESTROY_SUPPORT_HELI]="add_alt_machine"
end
function this.UpdateGMP(info)
  if not TppMotherBaseManagement.AddGmp then
    return
  end
  if not IsTypeTable(info)then
    return
  end
  local gmp=info.gmp
  local absGmp=math.abs(gmp)
  local withoutAnnounceLog=info.withOutAnnouceLog
  if gmp>0 then
    TppMotherBaseManagement.AddGmp{gmp=gmp}
  else
    TppMotherBaseManagement.SubGmp{gmp=absGmp}
  end
  if not withoutAnnounceLog then
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER and info.gmpCostType then
      local gmpCostName=gmpCostNames[info.gmpCostType]
      if gmpCostName then
        TppUI.ShowAnnounceLog(gmpCostName,absGmp)
      end
    end
  end
end
function this.CorrectGMP(gmpInfo)
  if not TppMotherBaseManagement.CorrectGmp then
    return
  end
  if not IsTypeTable(gmpInfo)then
    return
  end
  local gmp=gmpInfo.gmp
  if not gmp then
    return gmp
  end
  return TppMotherBaseManagement.CorrectGmp{gmp=gmp}
end
function this.ClearStaffNewIcon(isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission)
  if TppMission.IsEmergencyMission()then
    return
  end
  if isHeliSpace or isFreeMission then
    if(not nextIsHeliSpace)and(not nextIsFreeMission)then
      TppMotherBaseManagement.ClearAllStaffNew()
    end
  end
end
function this.AddStaffsFromTempBuffer(readOnly,RENoffline)
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return
  end
  local gotTranslater=TppMotherBaseManagement.IsExistTempStaff{skill="TranslateRussian"}
  local hasTranslater=TppMotherBaseManagement.IsExistStaff{skill="TranslateRussian"}
  if gotTranslater and not hasTranslater then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER)
  end
  for buddyId=0,(budyIdLimit-1)do
    if svars.trm_isBuddyRecovered[buddyId]then
      TppBuddyService.SetObtainedBuddyType(buddyId)
      if buddyId==BuddyType.QUIET then
      end
      if buddyId==BuddyType.DOG then
        TppEmblem.Add("word146",false,true)
        if(TppBuddyService.IsBuddyDogGot()==false)then
          TppBuddyService.SetBuddyDogGot()
        elseif(TppBuddyService.IsBuddyDogSecondGot()==false)then
          TppBuddyService.IsBuddyDogSecondGot()
        end
        TppBuddyService.UnsetDeadBuddyType(BuddyType.DOG)
      end
    end
  end
  if mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer then
    TppSound.PostEventForFultonRecover()
  end
  mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=false
  TppMotherBaseManagement.AddStaffsFromTempStaffBuffer()
  if not RENoffline then
    if readOnly then
      TppMotherBaseManagement.StartSyncControl{readOnly=readOnly}
    else
      this.ReserveMissionStartMbSync()
    end
  end
  TppUiCommand.AddAnimalEmblemTextureByDataBase()
end
function this.ReserveMissionStartMbSync()
  gvars.reservedMissionStartMbSync=true
end
function this.StartSyncMbManagementOnMissionStart()
  if gvars.reservedMissionStartMbSync then
    TppMotherBaseManagement.ProcessBeforeSync()
    TppMotherBaseManagement.StartSyncControl{}
    TppSave.SaveGameData(nil,nil,nil,true)
  end
end
function this.VarSaveMbMissionStartSyncEnd()
  if gvars.reservedMissionStartMbSync then
    gvars.reservedMissionStartMbSync=false
    TppSave.VarSaveMbMangement()
  end
end
function this.AcquireKeyItem(params)
  local dataBaseId=params.dataBaseId
  local isShowAnnounceLog=params.isShowAnnounceLog
  local pushReward=params.pushReward
  if(TppMotherBaseManagement.IsGotDataBase{dataBaseId=dataBaseId}==false)then
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=dataBaseId,isNew=true}
    if isShowAnnounceLog then
      local announce=this.keyItemAnnounceLogTable[dataBaseId]
      if announce then
        TppUI.ShowAnnounceLog("find_keyitem",announce)
      end
    elseif pushReward then
      local langId=this.keyItemRewardTable[dataBaseId]
      if langId then
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=langId,rewardType=TppReward.TYPE.KEY_ITEM}
      end
    end
  end
end
function this.ReserveHelicopterSoundOnMissionGameEnd()
  mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=true
end
function this.AddVolunteerStaffs()
  local storySequence=TppStory.GetCurrentStorySequence()
  if storySequence<TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    return
  end
  local noAddStaffMissions={[10010]=true,[10030]=true,[10240]=true,[10280]=true,[30050]=true,[30150]=true,[30250]=true,[50050]=true}
  if noAddStaffMissions[vars.missionCode]then
    return
  end
  local isHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)
  if isHeliSpace then
    return
  end
  local killCount=svars.killCount
  local clearTimeMinute=(svars.scoreTime/1e3)/60
  local missionResult={missionId=vars.missionCode,clearTimeMinute=clearTimeMinute,killCount=killCount}
  if(vars.missionCode~=30010)and(vars.missionCode~=30020)then
    TppMotherBaseManagement.AddVolunteerStaffs(missionResult)
  else
    TppMotherBaseManagement.AddOgreUserVolunteerStaffs(missionResult)
  end
  if TppMotherBaseManagement.AddMinimumSecurityStaffs then
    TppMotherBaseManagement.AddMinimumSecurityStaffs()
  end
end
function this.UnSetUsageRestriction(enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_REWORD,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DEVELOP,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_STAFF,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_COMBAT,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE_EXPANTION,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE_SECURITY,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_RESOURCE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB_PFRATING,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB_CASSETTE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_CUSTOM,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_EMERGENCIE_F,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_EMERGENCIE_N,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_SIDEOPSLIST,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_LOCATION,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_RETURNMB,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_DROP,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_BUDDY,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_ATTACK,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_HELI,enable)
end
function this.UnSetUsageRestrictionOnFOB(enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_REWORD,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DEVELOP,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_STAFF,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_COMBAT,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE_EXPANTION,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_BASE_SECURITY,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_RESOURCE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB_PFRATING,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_DB_CASSETTE,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MBM_CUSTOM,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_EMERGENCIE_F,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_EMERGENCIE_N,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_SIDEOPSLIST,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_CHALLENGE,enable)--RETAILPATCH 1070 added
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_LOCATION,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_RETURNMB,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_DROP,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_BUDDY,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_ATTACK,enable)
  TppUiCommand.SetMbTopMenuItemActive(this.MBDVCMENU.MSN_HELI,enable)
end
function this.SetDevelpedByDevelopIdList(developedIdList)
  for t,equipDevelopID in ipairs(developedIdList)do
    TppMotherBaseManagement.SetEquipDeveloped{equipDevelopID=equipDevelopID}
  end
end
function this.IsNeedPlayPandemicTutorialRadio()
  if gvars.trm_donePandemicEvent then
    return false
  end
  if gvars.trm_donePandemicTutorial then
    return false
  end
  if(not TppMission.IsHelicopterSpace(vars.missionCode))then
    return false
  end
  return this.PandemicTutorialStoryCondition()
end
function this.PandemicTutorialStoryCondition()
  if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_WHITE_MAMBA then
    return true
  end
  return false
end
function this.StartPandemicEvent()
  if gvars.trm_donePandemicEvent then
    return
  end
  if not TppMotherBaseManagement.IsPandemicEventMode()then
    TppUiCommand.RequestMbDvcOpenCondition{isTopModeMotherBase=true}
    TppMotherBaseManagement.StartPandemicEventMode()
  end
end
function this.IsNeedStartPandemicTutorial()
  if not TppMotherBaseManagement.IsPandemicEventMode()then
    return false
  end
  if gvars.trm_donePandemicEvent then
    return false
  end
  if gvars.trm_donePandemicTutorial then
    return false
  end
  return true
end
function this.FinishPandemicTutorial()
  if gvars.trm_donePandemicTutorial then
    return
  end
  gvars.trm_donePandemicTutorial=true
end
function this.IsPandemicTutorialFinished()
  return gvars.trm_donePandemicTutorial
end
function this.CheckPandemicEventFinish()
  if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    return true
  end
end
function this.FinishPandemicEvent()
  TppMotherBaseManagement.DisableKikongoFirst()
  if gvars.trm_donePandemicEvent then
    return
  end
  if TppMotherBaseManagement.IsPandemicEventMode()then
    TppMotherBaseManagement.EndPandemicEventMode()
    gvars.trm_donePandemicEvent=true
  end
end
function this.UpdatePandemicEventBingoCount()
  local pandemicBingoCount,pandemicRestCount=TppMotherBaseManagement.GetPandemicBingoCount()
  gvars.trm_lastPandemicBingoCount=gvars.trm_currentPandemicBingoCount
  gvars.trm_currentPandemicBingoCount=pandemicBingoCount
  gvars.trm_currentPandemicRestCount=pandemicRestCount
end
function this.GetPandemicBingoCount()
  local lastPandemicBingoCount=gvars.trm_lastPandemicBingoCount
  if lastPandemicBingoCount<1 then
    lastPandemicBingoCount=1
  end
  local t=gvars.trm_currentPandemicBingoCount/lastPandemicBingoCount
  local e=gvars.trm_currentPandemicBingoCount+gvars.trm_currentPandemicRestCount
  if e<1 then
    e=1
  end
  local e=gvars.trm_currentPandemicBingoCount/e
  return gvars.trm_currentPandemicBingoCount,t,e
end
local privilegeStaff={
  GROUP_A={
    storySequence=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,
    missionList={10033,10043,10036},
    proceedCount=1,
    privilegeNameList={"RESCUE_HOSTAGE_E20010_001","RESCUE_HOSTAGE_E20010_002","RESCUE_HOSTAGE_E20010_003","RESCUE_HOSTAGE_E20010_004","RESCUE_FRIENDMAN"},
    dlcItem={STAFF_STAFF1_FOX={"STAFF_STAFF1_FOX_01","STAFF_STAFF1_FOX_02"}}
  },
  GROUP_B={
    storySequence=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,
    privilegeNameList={"RESCUE_SP_HOSTAGE","RESCUE_HOSTAGE_E20020_000","RESCUE_HOSTAGE_E20020_001","RESCUE_ENEMY_US_MISSION_TARGET_CENTER000","RESCUE_ENEMY_US_MISSION_TARGET_SQUAD000"},
    dlcItem={STAFF_STAFF2_MSF={"STAFF_STAFF2_MSF_01","STAFF_STAFF2_MSF_02"}}
  },
  GROUP_C={
    storySequence=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,
    missionList={10041,10044,10052,10054},
    proceedCount=2,
    privilegeNameList={"RESCUE_HOSTAGE_E20030_000","RESCUE_HOSTAGE_E20030_001","RESCUE_HOSTAGE_E20030_002","RESCUE_E20030_BETRAYER","RESCUE_E20030_MASTERMIND"},
    dlcItem={STAFF_STAFF3_DD={"STAFF_STAFF3_DD_01","STAFF_STAFF3_DD_02"}}
  },
  GROUP_D={
    storySequence=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,
    privilegeNameList={"RESCUE_HOSTAGE_E20050_000","RESCUE_HOSTAGE_E20050_001","RESCUE_HOSTAGE_E20050_002","RESCUE_HOSTAGE_E20050_003","RESCUE_GENOME_SOILDER_SAVE"},
    dlcItem={STAFF_STAFF4_FOX_HOUND={"STAFF_STAFF4_FOX_HOUND_01","STAFF_STAFF4_FOX_HOUND_02"}}
  }
}
function this.AcquirePrivilegeStaff()
  if(vars.missionCode==10030)or(TppMission.IsFOBMission(vars.missionCode))then
    return
  end
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  for group,conditions in pairs(privilegeStaff)do
    if conditions.storySequence<=currentStorySequence then
      local aquireStaff=true
      local missionList=conditions.missionList
      if missionList then
        local clearedMissionCount=TppStory.GetClearedMissionCount(missionList)
        if clearedMissionCount<conditions.proceedCount then
          aquireStaff=false
        end
      end
      if aquireStaff then
        for n,t in ipairs(conditions.privilegeNameList)do
          this.AcquireGzPrivilege(t,this._AcquireGzPrivilegeStaff)
        end
        for t,n in pairs(conditions.dlcItem)do
          local t=DlcItem[t]
          if t then
            this.AcquireDlcItem(t,this._AcquireDlcItemStaff,n)
          end
        end
      end
    end
  end
  gvars.mb_isRecoverd_dlc_staffs=true--RETAILPATCH: 1060
end
function this._AcquireGzPrivilegeStaff(uniqueStaffType)
  return this._AcquirePrivilegeStaff(uniqueStaffType,"fromGZ")
end
function this._AcquireDlcItemStaff(n,t)
  for n,uniqueStaffType in ipairs(t)do
    local e=this._AcquirePrivilegeStaff(uniqueStaffType,"fromExtra")
    if not e then
      return
    end
  end
  return true
end
function this._AcquirePrivilegeStaff(uniqueStaffType,n)
  local staffId=TppDefine.UNIQUE_STAFF_TYPE_ID[uniqueStaffType]
  if not staffId then
    return
  end
  return this._AddUniqueVolunteerStaff(staffId,n)
end
function this.AcquirePrivilegeInTitleScreen()
  this.AcquireGzPrivilegeKeyItem()
  this.AcquireDlcItemKeyItem()
  this.AcquireDlcItemEmblem()
end
function this.AcquireGzPrivilegeKeyItem()
  local t={SAVEDATA_EXIST=MBMConst.EXTRA_4011,CLEAR_MISSION_20060=MBMConst.EXTRA_4012}
  local function n(e)
    local e=t[e]
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=e,isNew=true}
    return true
  end
  for t,a in pairs(t)do
    this.AcquireGzPrivilege(t,n)
  end
end
function this.AcquireDlcItemKeyItem()
  local dlcList={
    WEAPON_MACHT_P5_WEISS=MBMConst.EXTRA_4000,
    WEAPON_RASP_SB_SG_GOLD=MBMConst.EXTRA_4001,
    WEAPON_PB_SHIELD_SIL=MBMConst.EXTRA_4002,
    WEAPON_PB_SHIELD_OD=MBMConst.EXTRA_4003,
    WEAPON_PB_SHIELD_WHT=MBMConst.EXTRA_4004,
    WEAPON_PB_SHIELD_GLD=MBMConst.EXTRA_4005,
    ITEM_CBOX_APD=MBMConst.EXTRA_4006,
    ITEM_CBOX_RT=MBMConst.EXTRA_4007,
    ITEM_CBOX_WET=MBMConst.EXTRA_4008,
    SUIT_FATIGUES_APD=MBMConst.EXTRA_4015,
    SUIT_FATIGUES_GRAY_URBAN=MBMConst.EXTRA_4016,
    SUIT_FATIGUES_BLUE_URBAN=MBMConst.EXTRA_4017,
    SUIT_FATIGUES_BLACK_OCELOT=MBMConst.EXTRA_4018,
    WEAPON_ADAM_SKA_SP=MBMConst.EXTRA_4024,
    WEAPON_WU_S333_CB_SP=MBMConst.EXTRA_4025,
    SUIT_MGS3_NORMAL=MBMConst.EXTRA_4019,
    SUIT_MGS3_SNEAK=MBMConst.EXTRA_4022,
    SUIT_MGS3_TUXEDO=MBMConst.EXTRA_4023,
    SUIT_THE_BOSS=MBMConst.EXTRA_4026,
    SUIT_EVA=MBMConst.EXTRA_4027,
    HORSE_WESTERN=MBMConst.EXTRA_4028,
    HORSE_PARADE=MBMConst.EXTRA_4009
  }
  local function funcAdd(n,e)
    local dataBaseId=dlcList[e]
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=dataBaseId,isNew=true}
    return true
  end
  local function funcRemove(a,e)--RETAILPATCH: 1060
    local platform=Fox.GetPlatformName()
    local dataBaseId=dlcList[e]
    if platform=="Xbox360"or platform=="XboxOne"then
      if((dataBaseId==NULL_ID.EXTRA_4025)or(dataBaseId==NULL_ID.EXTRA_4003))or(dataBaseId==NULL_ID.EXTRA_4008)then
        return false
      end
    end
    TppMotherBaseManagement.DirectRemoveDataBase{dataBaseId=dataBaseId}
    return true
  end--
  for n,t in pairs(dlcList)do
    local t=DlcItem[n]
    if t then
      this.EraseDlcItem(t,funcRemove,n)--RETAILPATCH: 1.0.4.1
      this.AcquireDlcItem(t,funcAdd,n)
    end
  end
end
function this.AcquireDlcItemEmblem()
  local emblemList={EMBLEM_FRONT_VENOM_SNAKE="front85"}
  local function funcAdd(t,e)
    return TppEmblem.Add(e)
  end
  local function funcRemove(t,e)--RETAILPATCH: 1.0.4.1
    return TppEmblem.Remove(e)
  end--
  for emblemId,emblemName in pairs(emblemList)do
    local dlcItem=DlcItem[emblemId]
    if dlcItem then
      this.EraseDlcItem(dlcItem,funcRemove,emblemName)--RETAILPATCH: 1.0.4.1
      this.AcquireDlcItem(dlcItem,funcAdd,emblemName)
    end
  end
end
function this.AcquireGzPrivilege(e,t)
  if not TppUiCommand.CheckGzSaveDataFlag(e)then
    return
  end
  if TppUiCommand.CheckGzPrivilegeAcquiredFlag(e)and gvars.mb_isRecoverd_dlc_staffs then--RETAILPATCH 1060 gvar added
    return
  end
  if not Tpp.IsTypeFunc(t)then
    return
  end
  local t=t(e)
  if t then
    TppUiCommand.SetGzPrivilegeAcquired(e)
  end
end
function this.AcquireDlcItem(e,t,n)
  if not TppUiCommand.CheckDlcFlag(e)then
    return
  end
  if TppUiCommand.CheckDlcAcquiredFlag(e)then
    return
  end
  if not Tpp.IsTypeFunc(t)then
    return
  end
  local t=t(e,n)
  if t then
    TppUiCommand.SetDlcAcquired(e)
  end
end
function this.EraseDlcItem(e,t,n)
  if not TppUiCommand.CheckDlcAcquiredFlag(e)then
    return
  end
  if TppUiCommand.CheckDlcFlag(e)then
    return
  end
  if not Tpp.IsTypeFunc(t)then
    return
  end
  local t=true--RETAILPATCH: 1060 was t(e,n)
  if t then
    TppUiCommand.ResetDlcAcquired(e)
  end
end
local uniqueCharacterStaffStoryStage={
  [MBMConst.STAFF_UNIQUE_TYPE_ID_OCELOT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,
  [MBMConst.STAFF_UNIQUE_TYPE_ID_MILLER]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,
  [MBMConst.STAFF_UNIQUE_TYPE_ID_HEUY]=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,
  [MBMConst.STAFF_UNIQUE_TYPE_ID_CODE_TALKER]=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA}
function this.AddUniqueCharactor()
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  for uniqueId,characterStage in pairs(uniqueCharacterStaffStoryStage)do
    if characterStage<=currentStorySequence then
      local staffId=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=uniqueId}
      if not TppMotherBaseManagement.IsExistStaff{staffId=staffId}then
        TppMotherBaseManagement.DirectAddStaff{staffId=staffId}
      end
    end
  end
end
function this.GetFobStatus()
  if gvars.ini_isTitleMode then
    return
  end
  TppServerManager.GetFobStatus()
end
function this.OnNoticeFobSneaked(fobMode,n)
  if this.IsDisableNoticeFobSneaked()then
    return
  end
  local announceLogTypesForFobMode={
    [FobMode.MODE_ACTUAL]="fobNoticeIntruder",
    [FobMode.MODE_SHAM]="fobReqPractice",
    [FobMode.MODE_VISIT]="fobVisitFob"
  }
  local announceLogType=announceLogTypesForFobMode[fobMode]
  if announceLogType then
    TppMotherBaseManagement.SetMyFobEmergency{emergency=true}
    this.ShowNoticeFobSneaked(announceLogType)
  end
end
function this.OnNoticeSupporterFobSneaked()
  if this.IsDisableNoticeFobSneaked()then
    return
  end
  TppMotherBaseManagement.SetFollowerFobEmergency{emergency=true}
  this.ShowNoticeFobSneaked"fobReqHelp"
end
function this.IsDisableNoticeFobSneaked()
  local isDisable=false
  local missionTable={[10010]=true,[10030]=true,[10115]=true,[10150]=true,[10151]=true,[10240]=true,[10260]=true,[10280]=true,[11151]=true}
  local missionCode=vars.missionCode
  if missionTable[missionCode]and(not TppStory.IsMissionCleard(missionCode))then
    isDisable=true
  end
  if TppMission.IsFOBMission(missionCode)then
    isDisable=true
  end
  if gvars.ini_isTitleMode then
    isDisable=true
  end
  return isDisable
end
function this.ShowNoticeFobSneaked(announceLogType)
  TppUI.ShowEmergencyAnnounceLog(true)
  TppUiCommand.ShowMissionIcon("urgent_time",6,TppUI.ANNOUNCE_LOG_TYPE[announceLogType])
end
function this.OnAllocate(e)
  mvars.trm_fultonInfo={}
end
function this.Init(missionTable)
  TppClock.RegisterClockMessage("TerminalVoiceOnSunSet",TppClock.DAY_TO_NIGHT)
  TppClock.RegisterClockMessage("TerminalVoiceOnSunRise",TppClock.NIGHT_TO_DAY)
  TppClock.RegisterClockMessage("WolfHowl","00:00:00")
  if missionTable.sequence then
    if missionTable.sequence.ALLWAYS_DIRECT_ADD_STAFF then
      mvars.trm_isAlwaysDirectAddStaff=true
    end
    if missionTable.sequence.SKIP_ADD_STAFF_TO_TEMP_BUFFER then
      mvars.trm_isAlwaysDirectAddStaff=true
    end
    if missionTable.sequence.SKIP_ADD_RESOURCE_TO_TEMP_BUFFER then
      mvars.trm_isSkipAddResourceToTempBuffer=true
    end
    if vars.missionCode==30150 or vars.missionCode==30250 then
      mvars.trm_isAlwaysDirectAddStaff=true
      mvars.trm_isSkipAddResourceToTempBuffer=true
    end
  end
  mvars.trm_voiceDisabled=mvars.trm_voiceDisabled or false
  this.SetUp()
  this.ReleaseMbSection()
  this.ReleaseFunctionOfMbSection()
  this.ReleaseFreePlay()
  this.InitNuclearAbolitionCount()
  this.RemoveStaffsAfterS10240()
  TppUiCommand.SetTutorialMode(false)
  TppUiCommand.SetAllInvalidMbSoundControllerVoice(false)
  mvars.trm_EmblemLocatorIdTable={}
  for emblemLocator,emblemName in pairs(this.EMBLEM_LOCATOR_TABLE)do
    local emblemId=TppCollection.GetUniqueIdByLocatorName(emblemLocator)
    mvars.trm_EmblemLocatorIdTable[emblemId]=emblemName
  end
  TppUiCommand.ClearMbDvcOpenConditionRequest()
end
function this.MakeMessage()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(t)
  this.Init(t)
  this.MakeMessage()
end
function this.OnMissionGameStart(e)
  if not mvars.trm_currentIntelCpName then
    TppUiCommand.DeactivateSpySearchForCP()
    TppUiCommand.ActivateSpySearchForField()
  end
end
function this.DeclareSVars()
  return{
    {name="trm_missionFultonCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},
    {name="trm_isBuddyRecovered",type=TppScriptVars.TYPE_BOOL,arraySize=budyIdLimit,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},
    nil
  }
end
function this.Messages()
  local cpIntelTrapTable=TppEnemy.GetCpIntelTrapTable()
  local messages
  if cpIntelTrapTable and next(cpIntelTrapTable)then
    messages={}
    for t,sender in pairs(cpIntelTrapTable)do
      local msg={msg="Enter",sender=sender,func=function(n,n)
        this.OnEnterCpIntelTrap(t)
        if TppSequence.IsMissionPrepareFinished()then
          this.ShowLocationAndBaseTelop()
        end
      end,
      option={isExecMissionPrepare=true}
      }
      table.insert(messages,msg)
      local msg={msg="Exit",sender=sender,func=function(n,n)
        this.OnExitCpIntelTrap(t)
      end,
      option={isExecMissionPrepare=true}
      }
      table.insert(messages,msg)
    end
    table.insert(messages,{msg="Enter",sender="trap_intel_afgh_waterway_cp",func=function(t,t)
      this.SetBaseTelopName"afgh_waterWay_cp"
      if TppSequence.IsMissionPrepareFinished()then
        this.ShowLocationAndBaseTelop()
      end
    end,
    option={isExecMissionPrepare=true}})
    table.insert(messages,{msg="Exit",sender="trap_intel_afgh_waterway_cp",func=function(t,t)
      this.ClearBaseTelopName()
    end,
    option={isExecMissionPrepare=true}})
    table.insert(messages,{msg="Enter",sender="trap_intel_afgh_ruins_cp",func=function(t,t)
      this.SetBaseTelopName"afgh_ruins_cp"
      if TppSequence.IsMissionPrepareFinished()then
        this.ShowLocationAndBaseTelop()
      end
    end,
    option={isExecMissionPrepare=true}})
    table.insert(messages,{msg="Exit",sender="trap_intel_afgh_ruins_cp",func=function(t,t)
      this.ClearBaseTelopName()
    end,
    option={isExecMissionPrepare=true}})
  end
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Fulton",func=function(n,a,r,t)
        if not TppMission.IsFOBMission(vars.missionCode)then
          this.OnFultonMessage(n,a,r,t)
        end
      end,
      option={isExecMissionClear=true,isExecDemoPlaying=true}
      },
      {msg="FultonInfo",func=function(a,n,t)
        if not TppMission.IsFOBMission(vars.missionCode)then
          this.OnFultonInfoMessage(a,n,t)
        end
      end,
      option={isExecMissionClear=true,isExecDemoPlaying=true}
      },
      {msg="FultonFailedEnd",func=this.OnFultonFailedEnd},
      {msg="HeliDoorClosed",func=this.OnRecoverByHelicopter,option={isExecDemoPlaying=true}},
      {msg="Returned",func=this.OnRecoverByHelicopter,option={isExecDemoPlaying=true}}
    },
    MotherBaseManagement={
      {msg="AssignedStaff",func=function(e,n)
        if(e==MBMConst.SECTION_SEPARATION)and(n>0)then
          gvars.trm_doneIsolateByManual=true
          if(TppMission.IsFreeMission(vars.missionCode)or TppMission.IsHelicopterSpace(vars.missionCode))and TppRadio.IsRadioPlayable()then
            TppFreeHeliRadio._PlayRadio(TppFreeHeliRadio.PANDEMIC_RADIO.ON_ISOLATE_STAFF)
          end
        end
      end}
    },
    Weather={
      {msg="WeatherForecast",func=this.TerminalVoiceWeatherForecast},
      {msg="Clock",sender="TerminalVoiceOnSunSet",func=this.TerminalVoiceOnSunSet},
      {msg="Clock",sender="TerminalVoiceOnSunRise",func=this.TerminalVoiceOnSunRise},
      {msg="Clock",sender="WolfHowl",func=function()
        if TppLocation.GetLocationName()=="afgh"then
          if not TppMission.IsHelicopterSpace(vars.missionCode)then
            TppSoundDaemon.PostEvent"sfx_s_mdnt_date_cng"
          end
        end
      end}
    },
    Terminal={
      {msg="MbDvcActCallBuddy",func=function(buddyType,t)
        TppUI.SetSupportCallBuddyType(buddyType)
        TppUI.ShowCallSupportBuddyAnnounceLog()
      end}
    },
    Trap=messages,
    Network={
      {msg="NoticeSneakMotherBase",func=this.OnNoticeFobSneaked},
      {msg="NoticeSneakSupportedMotherBase",func=this.OnNoticeSupporterFobSneaked}
    }
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.OnFultonMessage(gameId,t,a,stafforResourceId)
  mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}
  mvars.trm_fultonInfo[gameId]={gameId,t,a,stafforResourceId}
end
function this.OnFultonInfoMessage(n,playerIndex,r)
  mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}
  local fultonInfo=mvars.trm_fultonInfo[n]
  if fultonInfo then
    this.OnFulton(fultonInfo[1],fultonInfo[2],fultonInfo[3],fultonInfo[4],nil,nil,playerIndex,r)
    mvars.trm_fultonInfo[n]=nil
  end
  mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
  local fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo[n]
  if fultonFaileEndInfo then
    this._OnFultonFailedEnd(fultonFaileEndInfo[1],fultonFaileEndInfo[2],fultonFaileEndInfo[3],fultonFaileEndInfo[4],playerIndex)
    mvars.trm_fultonFaileEndInfo[n]=nil
  end
end
function this.SetUp()
  if gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    local t=TppMission.IsHelicopterSpace(vars.missionCode)
    if t then
      this.SetUpStoryBeforeCleardRescueMillerOnHelicopter()
    else
      this.SetUpStoryBeforeCleardRescueMiller()
    end
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    this.SetUpStoryCleardRescueMiller()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    this.SetUpStoryCleardToMotherBase()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    this.SetUpStoryCleardHoneyBee()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    this.SetUpStoryCleardPitchDark()
  else
    this.SetUpStoryAfterCleardPitchDark()
  end
  if this.IsReleaseSection"Combat"then
    this.EnableDvcMenuByList{{menu=this.MBDVCMENU.MBM_COMBAT,active=true}}
  end
  if this.IsReleaseSection"Security"then
    TppUiStatusManager.UnsetStatus("MbOceanAreaSell","INVALID")
  else
    TppUiStatusManager.SetStatus("MbOceanAreaSell","INVALID")
  end
  if TppStory.IsMissionCleard(10033)then
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_ARTIFICIAL_ARM_TAB")
  else
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_ARTIFICIAL_ARM_TAB")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    TppUiStatusManager.SetStatus("MbMotherBaseInfo","INVALID")
    TppUiStatusManager.SetStatus("MbTop","BLOCK_FULTON_VIEW")
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_ANIMAL_TAB")
    TppUiStatusManager.SetStatus("MbPauseHelp","IS_KAZ_MISSION")
  else
    TppUiStatusManager.UnsetStatus("MbMotherBaseInfo","INVALID")
    TppUiStatusManager.UnsetStatus("MbTop","BLOCK_FULTON_VIEW")
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_ANIMAL_TAB")
    TppUiStatusManager.UnsetStatus("MbPauseHelp","IS_KAZ_MISSION")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_MAFR_TAB")
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_RESOURCE_WALKER_GEAR_TAB")
  else
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_MAFR_TAB")
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_RESOURCE_WALKER_GEAR_TAB")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_PARASITE_TAB")
    TppUiStatusManager.SetStatus("MbMap","BLOCK_OKB_ZERO")
  else
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_PARASITE_TAB")
    TppUiStatusManager.UnsetStatus("MbMap","BLOCK_OKB_ZERO")
  end
  this.SetUpArmsMBDVCMenu()
  this.SetUpBuddyMBDVCMenu()
  this.SetUpCustomWeaponMBDVCMenu()

  --tex> reworked, disable various support menus
  local isActual=TppMission.IsActualSubsistenceMission()
  for n, ivar in ipairs(Ivars.disableMenuIvars) do
    if isActual or ivar:Is(1) then
      this.EnableDvcMenuByList{{menu=ivar.menuId,active=false}}
    end
  end

  if isActual or Ivars.disableSupportMenu:Is(1) then
    TppUiStatusManager.SetStatus("Subjective","SUPPORT_NO_USE")
  else
    TppUiStatusManager.UnsetStatus("Subjective","SUPPORT_NO_USE")
  end
  --<
  --ORIG
  --  if TppMission.IsSubsistenceMission() then
  --    local dvcMenu={
  --      {menu=this.MBDVCMENU.MSN_DROP,active=false},
  --      {menu=this.MBDVCMENU.MSN_BUDDY,active=false},
  --      {menu=this.MBDVCMENU.MSN_ATTACK,active=false},
  --      {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=false}
  --    }
  --    this.EnableDvcMenuByList(dvcMenu)
  --    TppUiStatusManager.SetStatus("Subjective","SUPPORT_NO_USE")
  --  else
  --    TppUiStatusManager.UnsetStatus("Subjective","SUPPORT_NO_USE")
  --  end
end
function this.SetUpArmsMBDVCMenu()
  if this.IsOpenMBDvcArmsMenu()then
    this.EnableDvcMenuByList{
      {menu=this.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},
      {menu=this.MBDVCMENU.MBM_CUSTOM,active=true},
      {menu=this.MBDVCMENU.MBM_CUSTOM_ARMS,active=true},
      {menu=this.MBDVCMENU.MBM_CUSTOM_ARMS_HELI,active=true},
      {menu=this.MBDVCMENU.MBM_CUSTOM_ARMS_VEHICLE,active=true}
    }
  end
end
function this.SetUpCustomWeaponMBDVCMenu()
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    return
  end
  do
    this.EnableDvcMenuByList{{menu=this.MBDVCMENU.MBM_CUSTOM_WEAPON,active=true}}
  end
end
function this.SetUpBuddyMBDVCMenu()
  if gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    return
  end
  this.EnableDvcMenuByList{{menu=this.MBDVCMENU.MSN_BUDDY,active=true}}
  this.EnableDvcMenuByList{{menu=this.MBDVCMENU.MSN_BUDDY_EQUIP,active=true}}
  local buddyTypes={HORSE=BuddyType.HORSE,DDOG=BuddyType.DOG,QUIET=BuddyType.QUIET,WALKER_GEAR=BuddyType.WALKER_GEAR,BATTLE_GEAR=BuddyType.BATTLE_GEAR}
  for n,buddyType in pairs(buddyTypes)do
    local canSortieBuddy=TppBuddyService.CanSortieBuddyType(buddyType) or (TppMission.IsMbFreeMissions(vars.missionCode) and Ivars.mbEnableBuddies:Is(1))
    if canSortieBuddy then
      local buddyMenu=this.BUDDY_MB_DVC_MENU[buddyType]
      if buddyMenu then
        this.EnableDvcMenuByList(buddyMenu)
      end
    end
  end
end
function this.DoFuncByFultonTypeSwitch(gameId,RENAMEanimalId,n,staffOrResourceId,recoveredByHeli,playerIndex,RENAMEmysteryPatchvar,OnFultonSoldier,OnFultonVolgin,OnFultonHostage,OnFultonVehicle,OnFultonContainer,OnFultonGimmickCommon,OnFultonBuddy,OnFultonEnemyWalkerGear,OnFultonAnimal,OnFultonBossQuiet,OnFultonParasiteSquad)
  if Tpp.IsSoldier(gameId)then
    return OnFultonSoldier(gameId,RENAMEanimalId,n,staffOrResourceId,recoveredByHeli,playerIndex)
  elseif Tpp.IsVolgin(gameId)then
    return OnFultonVolgin(gameId)
  elseif Tpp.IsHostage(gameId)then
    return OnFultonHostage(gameId,RENAMEanimalId,n,staffOrResourceId,recoveredByHeli,playerIndex)
  elseif Tpp.IsVehicle(gameId)then
    return OnFultonVehicle(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex)
  elseif Tpp.IsFultonContainer(gameId)then
    return OnFultonContainer(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex,RENAMEmysteryPatchvar)
  elseif Tpp.IsFultonableGimmick(gameId)then
    return OnFultonGimmickCommon(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex)
  elseif Tpp.IsEnemyWalkerGear(gameId)then
    return OnFultonEnemyWalkerGear(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex)
  elseif Tpp.IsAnimal(gameId)then
    return OnFultonAnimal(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex)
  elseif Tpp.IsBossQuiet(gameId)then
    return OnFultonBossQuiet(gameId,RENAMEanimalId,n,staffOrResourceId,recoveredByHeli,playerIndex)
  elseif Tpp.IsParasiteSquad(gameId)then
    return OnFultonParasiteSquad(gameId,RENAMEanimalId,n,staffOrResourceId,nil,playerIndex)
  else
    local buddyType=Tpp.GetBuddyTypeFromGameObjectId(gameId)
    if buddyType then
      return OnFultonBuddy(gameId,RENAMEanimalId,n,staffOrResourceId,buddyType,playerIndex)
    end
  end
end
function this.OnFulton(someGameId,a,o,staffOrResourceId,someBool,possiblyNotHelicopter,playerIndex,i)--RENAME:
  if possiblyNotHelicopter then
    mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=true
end
TppEnemy.SetRecovered(someGameId)
TppEnemy.ExecuteOnRecoveredCallback(someGameId,a,o,staffOrResourceId,someBool,possiblyNotHelicopter,playerIndex)
if Tpp.IsLocalPlayer(playerIndex)then
  TppEnemy._OnFulton(someGameId,a,o,staffOrResourceId)
end
this.DoFuncByFultonTypeSwitch(someGameId,a,o,staffOrResourceId,someBool,playerIndex,i,this.OnFultonSoldier,this.OnFultonVolgin,this.OnFultonHostage,this.OnFultonVehicle,this.OnFultonContainer,this.OnFultonGimmickCommon,this.OnFultonBuddy,this.OnFultonEnemyWalkerGear,this.OnFultonAnimal,this.OnFultonBossQuiet,this.OnFultonParasiteSquad)
end
function this.IncrementFultonCount()
  svars.trm_missionFultonCount=svars.trm_missionFultonCount+1
end
function this.GetMissionHumanFultonCount()
  return svars.trm_missionFultonCount
end
function this.IncrementRecoveredSoldierCount()
  gvars.trm_recoveredSoldierCount=gvars.trm_recoveredSoldierCount+1
  this.GetFultonCountKeyItem()
  TppChallengeTask.RequestUpdate"PLAY_RECORD"--RETAILPATCH 1070
end
function this.GetRecoveredSoldierCount()
  return gvars.trm_recoveredSoldierCount
end
function this.IncrementRecoveredHostageCount()
  gvars.trm_recoveredHostageCount=gvars.trm_recoveredHostageCount+1
  this.GetFultonCountKeyItem()
  TppChallengeTask.RequestUpdate"PLAY_RECORD"--RETAILPATCH 1070
end
function this.GetRecoveredHostageCount()
  return gvars.trm_recoveredHostageCount
end
function this.GetFultonCountKeyItem()
  local recoveredCount=gvars.trm_recoveredSoldierCount+gvars.trm_recoveredHostageCount
  if recoveredCount>=recoverReward1RecoverCount then
    this.AcquireKeyItem{dataBaseId=MBMConst.DESIGN_3006,isShowAnnounceLog=true}
  end
  if recoveredCount>=recoverReward2RecoverCount then
    this.AcquireKeyItem{dataBaseId=MBMConst.DESIGN_3005,isShowAnnounceLog=true}
  end
end
function this.IsEqualOrMoreTotalFultonCount(fultonCount)--RETAILPATCH 1070>
  local totalFultonCount=gvars.trm_recoveredSoldierCount+gvars.trm_recoveredHostageCount
  if(totalFultonCount>=fultonCount)then
    return true
  else
    return false
  end
end--<
function this.OnFultonSoldier(gameId,a,a,staffId,recoveredByHeli,fultonedPlayer)
  if recoveredByHeli then
    local command={id="SetToHeliRecoveredComplete"}
    GameObject.SendCommand(gameId,command)
  end
  local tempStaffStatus=TppMotherBaseManagement.GetTempStaffStatusFromGameObject{gameObjectId=gameId}
  local staff
  if staffId then
    staff=staffId
  else
    staff=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=gameId}
  end
  if Tpp.IsLocalPlayer(fultonedPlayer)then
    TppHero.OnFultonSoldier(gameId,recoveredByHeli)
    this.IncrementFultonCount()
    if not recoveredByHeli then
      this.IncrementRecoveredSoldierCount()
      local soldierType=TppEnemy.GetSoldierType(gameId)
      if soldierType~=EnemyType.TYPE_DD then
        TppTrophy.Unlock(29)
      end
    end
    PlayRecord.RegistPlayRecord"SOLDIER_RESCUE"
    Tpp.IncrementPlayData"totalRescueCount"
  end
  this.AddTempStaffFulton{staffId=staff,gameObjectId=gameId,tempStaffStatus=tempStaffStatus,fultonedPlayer=fultonedPlayer}
end
function this.OnFultonVolgin(gameId)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  TppMotherBaseManagement.AddTempCorpse()
end
function this.OnFultonHostage(gameId,n,n,staffId,recoveredByHeli,fultonedPlayer)
  local tempStaffStatus=TppMotherBaseManagement.GetTempStaffStatusFromGameObject{gameObjectId=gameId}
  local staff
  if staffId then
    staff=staffId
  else
    staff=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=gameId}
  end
  if Tpp.IsLocalPlayer(fultonedPlayer)then
    TppHero.OnFultonHostage(gameId,recoveredByHeli)
    this.IncrementFultonCount()
    if not recoveredByHeli then
      this.IncrementRecoveredHostageCount()
    end
    PlayRecord.RegistPlayRecord"HOSTAGE_RESCUE"
    Tpp.IncrementPlayData"totalRescueCount"
    local isFemale=GameObject.SendCommand(gameId,{id="IsFemale"})
    if isFemale then
      TppTrophy.Unlock(31)
    end
  end
  this.AddTempStaffFulton{staffId=staff,gameObjectId=gameId,tempStaffStatus=tempStaffStatus,fultonedPlayer=fultonedPlayer}
end
function this.OnFultonVehicle(gameId,a,a,resourceId,a,playerIndex)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  this.AddTempResource(resourceId,nil,playerIndex)
end
function this.OnFultonContainer(gameId,t,n,staffOrResourceId,M,playerIndex,RENAMEmysterypatchvar)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  if TppMission.IsFOBMission(vars.missionCode)then
    if not this.CheckAddTempBuffer(playerIndex)then
      return
    end
    local resourceId,visual,owner=MotherBaseConstructConnector.GetContainerResourceId(t,n)
    if resourceId==nil then
      resourceId=0
    end
    TppMotherBaseManagement.AddTempResource{resourceId=resourceId,count=1,visual=visual,owner=owner}
  else
    local gimmickName=TppGimmick.GetGimmickID(gameId,t,n)
    if not gimmickName then
      gimmickName="commFacility_cntn001"
    end
    local isReduceAmount=false
    if(RENAMEmysterypatchvar==1)then
      isReduceAmount=true
    end
    Gimmick.CallFindContainerResourceLog(gimmickName,isReduceAmount)--RETAILPATCH: 1.0.4.0 last param added, same with below
    TppMotherBaseManagement.AddTempGimmickResource{gimmickName=gimmickName,reduceAmount=isReduceAmount}
  end
end
this.GIMMICK_RESOURCE_ID_TABLE={
  [1845465265]=MBMConst.RESOURCE_ID_EMPLACEMENT_GUN_EAST,
  [2207998916]=MBMConst.RESOURCE_ID_EMPLACEMENT_GUN_WEST,
  [1187982616]=MBMConst.RESOURCE_ID_MORTAR_NORMAL,
  [3601635493]=MBMConst.RESOURCE_ID_ANTI_AIR_GATLING_GUN_EAST,
  [20562949]=MBMConst.RESOURCE_ID_ANTI_AIR_GATLING_GUN_WEST
}
function this.OnFultonGimmickCommon(gameId,t,t,resource,t,playerIndex)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  local resourceId=this.GIMMICK_RESOURCE_ID_TABLE[resource]
  if resourceId then
    this.AddTempResource(resourceId,nil,playerIndex)
  else
    this.AddTempResource(resource,nil,playerIndex)
  end
end
function this.OnFultonBuddy(gameId,t,t,t,buddyType,t)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  svars.trm_isBuddyRecovered[buddyType]=true
  if buddyType==BuddyType.QUIET then
    TppMotherBaseManagement.AddTempBuddy()
  end
  if buddyType==BuddyType.DOG then
    TppMotherBaseManagement.AddTempPuppy()
  end
end
function this.OnFultonEnemyWalkerGear(gameId,n,n,resourceId,n,n)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  this.AddTempResource(resourceId)
end
function this.OnFultonAnimal(gameId,animalId)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  local databastId=TppAnimal.GetDataBaseIdFromAnimalId(animalId)
  if this.IsAnimalDog(databastId)then
    this.AddAnimalRecoverHistory(MBMConst.ANIMAL_TYPE_DOG)
  elseif this.IsAnimalHorse(databastId)then
    this.AddAnimalRecoverHistory(MBMConst.ANIMAL_TYPE_HORSE)
  elseif this.IsAnimalBear(databastId)then
    this.AddAnimalRecoverHistory(MBMConst.ANIMAL_TYPE_BEAR)
  elseif this.IsAnimalGoat(databastId)then
    this.AddAnimalRecoverHistory(MBMConst.ANIMAL_TYPE_GOAT)
  else
    local t=0
    this.AddAnimalRecoverHistory(t)
  end
  local a=TppMotherBaseManagement.DataBaseIdToAnimalGroup{dataBaseId=databastId}
  if(a==MBMConst.ANIMAL_GROUP_1900)or(a==MBMConst.ANIMAL_GROUP_1920)then
    gvars.trm_recoveredAfghGoatCount=gvars.trm_recoveredAfghGoatCount+1
  elseif(a==MBMConst.ANIMAL_GROUP_1940)or(a==MBMConst.ANIMAL_GROUP_1960)then
    gvars.trm_recoveredMafrGoatCount=gvars.trm_recoveredMafrGoatCount+1
  elseif(databastId==MBMConst.ANIMAL_200)then
    gvars.trm_recoveredDonkeyCount=gvars.trm_recoveredDonkeyCount+1
  elseif(databastId==MBMConst.ANIMAL_210)then
    gvars.trm_recoveredZebraCount=gvars.trm_recoveredZebraCount+1
  elseif(databastId==MBMConst.ANIMAL_220)then
    gvars.trm_recoveredOkapiCount=gvars.trm_recoveredOkapiCount+1
  end
  PlayRecord.RegistPlayRecord"ANIMAL_RESCUE"this.AddTempDataBaseAnimal(databastId,tostring(mvars.animalBlockAreaName))
end
function this.GetRecoveredAfghGoatCount()
  return gvars.trm_recoveredAfghGoatCount
end
function this.GetRecoveredMafrGoatCount()
  return gvars.trm_recoveredMafrGoatCount
end
function this.GetRecoveredDonkeyCount()
  return gvars.trm_recoveredDonkeyCount
end
function this.GetRecoveredZebraCount()
  return gvars.trm_recoveredZebraCount
end
function this.GetRecoveredOkapiCount()
  return gvars.trm_recoveredOkapiCount
end
function this.IsRecoveredCompleatedGoat()
  return(((((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1900}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1901})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1902})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1903})and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1910}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1911})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1912})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1913}))and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1920}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1921})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1922})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1923}))and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1930}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1931})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1932})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1933}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1940}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1941})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1942})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1943})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1944})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1945})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1946})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1947}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1950}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1951})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1952})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1953})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1954})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1955})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1956})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1957}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1960}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1961})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1962})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1963})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1964})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1965})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1966})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1967}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1970}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1971})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1972})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1973})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1974})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1975})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1976})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_1977})
end
function this.IsRecoveredCompleatedHorse()
  return(TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_200}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_210})and TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_220}
end
function this.IsRecoveredCompleatedDog()
  return(TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_100}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_110})and TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_120}
end
function this.IsRecoveredCompleatedBear()
  return TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_600}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=MBMConst.ANIMAL_610}
end
function this.GetAnimalTypeCountFromRecoveredHistory(n)
  local e=0
  for t=0,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
    if gvars.trm_animalRecoverHistory[t]==n then
      e=e+1
    end
  end
  return e
end
function this.AddAnimalRecoverHistory(t)
  local e=gvars.trm_animalRecoverHistorySize
  if e<TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE then
    gvars.trm_animalRecoverHistory[e]=t
    gvars.trm_animalRecoverHistorySize=e+1
  else
    for e=1,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
      gvars.trm_animalRecoverHistory[e-1]=gvars.trm_animalRecoverHistory[e]
    end
    gvars.trm_animalRecoverHistory[TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1]=t
    gvars.trm_animalRecoverHistorySize=TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE
  end
end
function this.OnFultonBossQuiet(t,t,t,t)
  local command=SendCommand({type="TppBossQuiet2"},{id="GetQuietType"})
  local reourceId=this.parasiteSquadFultonResouceId[command]
  if reourceId then
    this._OnFultonParasiteSquad(reourceId)
  end
end
function this.OnFultonParasiteSquad(gameId,n,n,n)
  local parasiteType=SendCommand(gameId,{id="GetParasiteType"})
  local resourceId=this.parasiteSquadFultonResouceId[parasiteType]
  if resourceId then
    this._OnFultonParasiteSquad(resourceId)
  end
end
function this._OnFultonParasiteSquad(resourceIdList)
  local n,t=resourceIdList[1],resourceIdList[2]
  this.AddTempResource(n,t)
  TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.FULTON_PARASITE)
end
function this.IsAnimalDog(dataBaseId)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=dataBaseId,animalType=MBMConst.ANIMAL_TYPE_DOG}
end
function this.IsAnimalHorse(dataBaseId)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=dataBaseId,animalType=MBMConst.ANIMAL_TYPE_HORSE}
end
function this.IsAnimalBear(dataBaseId)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=dataBaseId,animalType=MBMConst.ANIMAL_TYPE_BEAR}
end
function this.IsAnimalGoat(dataBaseId)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=dataBaseId,animalType=MBMConst.ANIMAL_TYPE_GOAT}
end
function this.OnRecoverByHelicopter()
  TppHelicopter.SetNewestPassengerTable()
  this.OnRecoverByHelicopterAlreadyGetPassengerList()
  TppHelicopter.ClearPassengerTable()
end
function this.OnRecoverByHelicopterOnCheckPoint()
  TppHelicopter.SetNewestPassengerTable()
  local t=TppHelicopter.GetPassengerlist()
  if t then
    TppHelicopter.ForcePullOut()
  end
  this.OnRecoverByHelicopterAlreadyGetPassengerList()
  TppHelicopter.ClearPassengerTable()
end
function this.OnRecoverByHelicopterAlreadyGetPassengerList()
  local passengerList=TppHelicopter.GetPassengerlist()
  if passengerList==nil then
    TppHelicopter.ClearPassengerTable()
    return
  end
  for n,gameId in ipairs(passengerList)do
    if not Tpp.IsPlayer(gameId)then
      this.OnFulton(gameId,nil,nil,nil,true,false,PlayerInfo.GetLocalPlayerIndex())
    end
  end
end
function this.CheckAddTempBuffer(playerIndex)
  if TppMission.IsFOBMission(vars.missionCode)then
    if TppServerManager.FobIsSneak()then
      if playerIndex==0 then
        return true
      else
        return false
      end
    else
      return false
    end
  else
    return true
  end
end
function this.AddTempStaffFulton(staffInfo)
  if mvars.trm_isAlwaysDirectAddStaff~=true then
    local fultonedPlayer=staffInfo.fultonedPlayer or 0
    if this.CheckAddTempBuffer(fultonedPlayer)then
      TppMotherBaseManagement.AddTempStaffFulton(staffInfo)
    end
  end
end
function this.AddTempResource(resourceId,count,playerIndex)
  local playerIndex=playerIndex or 0
  if not this.CheckAddTempBuffer(playerIndex)then
    return
  end
  local count=count or 1
  TppMotherBaseManagement.AddTempResource{resourceId=resourceId,count=count}
end
function this.AddTempDataBase(dataBaseId)
  TppMotherBaseManagement.AddTempDataBase{dataBaseId=dataBaseId}
end
function this.AddTempDataBaseAnimal(dataBaseId,areaName)
  TppMotherBaseManagement.AddTempDataBaseAnimal{dataBaseId=dataBaseId,areaName=areaName}
end
local n=4
local RENAMEsomeConst=1.67
function this.AddPickedUpResourceToTempBuffer(resourceType,langId)
  if not this.RESOURCE_INFORMATION_TABLE[resourceType]then
    return
  end
  local resourceName=this.RESOURCE_INFORMATION_TABLE[resourceType].resourceName
  local resourceCount=this.RESOURCE_INFORMATION_TABLE[resourceType].count
  if TppCollection.IsHerbByType(resourceType)then
    local getHerbRate=Player.GetRateOfGettingHarb()
    resourceCount=resourceCount*getHerbRate
    TppUI.ShowAnnounceLog("find_plant",langId,resourceCount)
  end
  if resourceType>=TppCollection.TYPE_POSTER_SOL_AFGN and resourceType<=TppCollection.TYPE_POSTER_MOE_H then
    TppMotherBaseManagement.DirectAddResource{resource=resourceName,count=resourceCount,isNew=true}
  else
    TppMotherBaseManagement.AddTempResource{resource=resourceName,count=resourceCount}
  end
end
function this.SetUpOnHelicopterSpace()
  this.SetUp()
end
function this.SetUpStoryBeforeCleardRescueMiller()
  this._SetUpDvcMenu{{menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true}
  }
end
function this.SetUpStoryBeforeCleardRescueMillerOnHelicopter()
  this._SetUpDvcMenu{
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true}
  }
end
function this.SetUpStoryCleardRescueMiller()
  this._SetUpDvcMenu{
    {menu=this.MBDVCMENU.MBM,active=true},
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_STAFF,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MBM_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_DROP,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_BULLET,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_LOADOUT,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_VEHICLE,active=true},
    {menu=this.MBDVCMENU.MSN_HELI,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_LOCATION,active=true},
    {menu=this.MBDVCMENU.MSN_RETURNMB,active=true},
    {menu=this.MBDVCMENU.MBM_DB,active=true},
    {menu=this.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},
    {menu=this.MBDVCMENU.MBM_DB_KEYITEM,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true}
  }
end
function this.SetUpStoryCleardToMotherBase()
  local t={
    {menu=this.MBDVCMENU.MBM,active=true},
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_STAFF,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MBM_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_BASE_EXPANTION,active=true},
    {menu=this.MBDVCMENU.MBM_RESOURCE,active=true},
    {menu=this.MBDVCMENU.MBM_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_DROP,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_BULLET,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_LOADOUT,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_VEHICLE,active=true},
    {menu=this.MBDVCMENU.MSN_HELI,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_MISSIONLIST,active=true},
    {menu=this.MBDVCMENU.MSN_SIDEOPSLIST,active=TppQuest.CanOpenSideOpsList()},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_LOCATION,active=true},
    {menu=this.MBDVCMENU.MSN_RETURNMB,active=true},
    {menu=this.MBDVCMENU.MBM_DB,active=true},
    {menu=this.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},
    {menu=this.MBDVCMENU.MBM_DB_KEYITEM,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}
  }
  this._SetUpDvcMenu(t)
end
function this.IsOpenMBDvcArmsMenu()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE)and(TppStory.GetClearedMissionCount{10033,10036,10043}>=1)then
    return true
  else
    return false
  end
end
function this.SetUpStoryCleardHoneyBee()
  local t={
    {menu=this.MBDVCMENU.MBM,active=true},
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_STAFF,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},
    {menu=this.MBDVCMENU.MBM_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_BASE_EXPANTION,active=true},
    {menu=this.MBDVCMENU.MBM_RESOURCE,active=true},
    {menu=this.MBDVCMENU.MBM_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_DROP,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_BULLET,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_LOADOUT,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_VEHICLE,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},
    {menu=this.MBDVCMENU.MSN_HELI,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_MISSIONLIST,active=true},
    {menu=this.MBDVCMENU.MSN_SIDEOPSLIST,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_LOCATION,active=true},
    {menu=this.MBDVCMENU.MSN_RETURNMB,active=true},
    {menu=this.MBDVCMENU.MBM_DB,active=true},
    {menu=this.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},
    {menu=this.MBDVCMENU.MBM_DB_KEYITEM,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}
  }
  this._SetUpDvcMenu(t)
end
function this.SetUpStoryCleardPitchDark()
  this._SetUpDvcMenu{
    {menu=this.MBDVCMENU.MBM,active=true},
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_STAFF,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},
    {menu=this.MBDVCMENU.MBM_COMBAT,active=true},
    {menu=this.MBDVCMENU.MBM_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_BASE_EXPANTION,active=true},
    {menu=this.MBDVCMENU.MBM_RESOURCE,active=true},
    {menu=this.MBDVCMENU.MBM_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_DROP,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_BULLET,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_LOADOUT,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_VEHICLE,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},
    {menu=this.MBDVCMENU.MSN_HELI,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_MISSIONLIST,active=true},
    {menu=this.MBDVCMENU.MSN_SIDEOPSLIST,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_LOCATION,active=true},
    {menu=this.MBDVCMENU.MSN_RETURNMB,active=true},
    {menu=this.MBDVCMENU.MBM_DB,active=true},
    {menu=this.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},
    {menu=this.MBDVCMENU.MBM_DB_KEYITEM,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}
  }
end
function this.SetUpStoryAfterCleardPitchDark()
  this._SetUpDvcMenu{
    {menu=this.MBDVCMENU.MBM,active=true},
    {menu=this.MBDVCMENU.MSN,active=true},
    {menu=this.MBDVCMENU.MBM_REWORD,active=true},
    {menu=this.MBDVCMENU.MBM_STAFF,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},
    {menu=this.MBDVCMENU.MBM_COMBAT,active=true},
    {menu=this.MBDVCMENU.MBM_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_BASE_SECURITY,active=true},
    {menu=this.MBDVCMENU.MBM_BASE_EXPANTION,active=true},
    {menu=this.MBDVCMENU.MBM_RESOURCE,active=true},
    {menu=this.MBDVCMENU.MBM_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_DROP,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_BULLET,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_WEAPON,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_LOADOUT,active=true},
    {menu=this.MBDVCMENU.MSN_DROP_VEHICLE,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_SMOKE,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_SLEEP,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_CHAFF,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_WEATHER,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_WEATHER_SANDSTORM,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_WEATHER_STORM,active=true},
    {menu=this.MBDVCMENU.MSN_ATTACK_WEATHER_CLEAR,active=true},
    {menu=this.MBDVCMENU.MSN_HELI,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_ATTACK,active=true},
    {menu=this.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_N,active=true},
    {menu=this.MBDVCMENU.MSN_EMERGENCIE_F,active=true},
    {menu=this.MBDVCMENU.MSN_MISSIONLIST,active=true},
    {menu=this.MBDVCMENU.MSN_SIDEOPSLIST,active=true},
    {menu=this.MBDVCMENU.MSN_FOB,active=true},
    {menu=this.MBDVCMENU.MSN_FRIEND,active=true},
    {menu=this.MBDVCMENU.MSN_LOG,active=true},
    {menu=this.MBDVCMENU.MSN_LOCATION,active=true},
    {menu=this.MBDVCMENU.MSN_RETURNMB,active=true},
    {menu=this.MBDVCMENU.MBM_DB,active=true},
    {menu=this.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},
    {menu=this.MBDVCMENU.MBM_DB_KEYITEM,active=true},
    {menu=this.MBDVCMENU.MBM_DB_CASSETTE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY_HORSE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY_DOG,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY_QUIET,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY_WALKER,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_BUDDY_BATTLE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},
    {menu=this.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}
  }
end
function this.StopChangeDayTerminalAnnounce()
  mvars.trm_stopChangeDayTerminalAnnounce=true
end
function this.StartChangeDayTerminalAnnounce()
  mvars.trm_stopChangeDayTerminalAnnounce=nil
end
function this.TerminalVoiceWeatherForecast(n)
  local t={[TppDefine.WEATHER.SUNNY]="VOICE_WEATHER_CLAER",[TppDefine.WEATHER.CLOUDY]=nil,[TppDefine.WEATHER.RAINY]=nil,[TppDefine.WEATHER.SANDSTORM]="VOICE_WEATHER_SANDSTORM",[TppDefine.WEATHER.FOGGY]=nil}
  local a={[TppDefine.WEATHER.SUNNY]="weather_sunny",[TppDefine.WEATHER.CLOUDY]="weather_cloudy",[TppDefine.WEATHER.RAINY]="weather_rainy",[TppDefine.WEATHER.SANDSTORM]="weather_sandstorm",[TppDefine.WEATHER.FOGGY]="weather_foggy"}
  local t=t[n]
  local n=a[n]
  if t then
    this.PlayTerminalVoice(t)
  end
  if n then
    TppUI.ShowAnnounceLog(n)
  end
end
function this.TerminalVoiceOnSunSet()
  if mvars.trm_stopChangeDayTerminalAnnounce then
    return
  end
  this.PlayTerminalVoice"VOICE_SUN_SET"
  TppUI.ShowAnnounceLog"sunset"
  TppTutorial.DispGuide_Comufrage()
end
function this.TerminalVoiceOnSunRise()
  if mvars.trm_stopChangeDayTerminalAnnounce then
    return
  end
  this.PlayTerminalVoice"VOICE_SUN_RISE"
  TppUI.ShowAnnounceLog"sunrise"
  TppTutorial.DispGuide_DayAndNight()
end
function this.TerminalVoiceOnSupportFireIncoming()
  this.PlayTerminalVoice"VOICE_SUPPORT_FIRE_INCOMING"end
function this.SetBaseTelopName(e)
  mvars.trm_baseTelopCpName=e
end
function this.ClearBaseTelopName()
  mvars.trm_baseTelopCpName=nil
end
function this.GetLocationAndBaseTelop()
  return mvars.trm_currentIntelCpName or mvars.trm_baseTelopCpName
end
function this.ShowLocationAndBaseTelop()
  if TppUiCommand.IsStartTelopCast and TppUiCommand.IsStartTelopCast()then
    return
  end
  TppUiCommand.RegistInfoTypingText("location",1)
  local e=this.GetLocationAndBaseTelop()
  if e then
    TppUiCommand.RegistInfoTypingText("cpname",2,e)
  end
  TppUiCommand.ShowInfoTypingText()
end
function this.ShowLocationAndBaseTelopForStartFreePlay()
  TppUiCommand.RegistInfoTypingText("gametime",1)
  TppUiCommand.RegistInfoTypingText("location",2)
  local e=this.GetLocationAndBaseTelop()
  if e then
    TppUiCommand.RegistInfoTypingText("cpname",3,e)
  end
  TppUiCommand.ShowInfoTypingText()
end
function this.ShowLocationAndBaseTelopForContinue()
  if TppMission.IsFreeMission(vars.missionCode)then
    this.ShowLocationAndBaseTelopForStartFreePlay()
  else
    TppUiCommand.RegistInfoTypingText("episode",1)
    TppUiCommand.RegistInfoTypingText("mission",2)
    TppUiCommand.RegistInfoTypingText("gametime",3)
    TppUiCommand.RegistInfoTypingText("location",4)
    local e=this.GetLocationAndBaseTelop()
    if e then
      TppUiCommand.RegistInfoTypingText("cpname",5,e)
    end
    TppUiCommand.ShowInfoTypingText()
  end
end
function this.OnEnterCpIntelTrap(e)
  mvars.trm_currentIntelCpName=e
  TppUiCommand.ActivateSpySearchForCP{cpName=e}
  TppUiCommand.DeactivateSpySearchForField()
  TppFreeHeliRadio.OnEnterCpIntelTrap(e)
  if Player.OnEnterBase~=nil then
    Player.OnEnterBase()
  end
end
function this.OnExitCpIntelTrap(e)
  mvars.trm_currentIntelCpName=nil
  TppUiCommand.DeactivateSpySearchForCP()
  TppUiCommand.ActivateSpySearchForField()
  TppFreeHeliRadio.OnExitCpIntelTrap(e)
  TppRevenge.ClearLastRevengeMineBaseName()
  if Player.OnExitBase~=nil then
    Player.OnExitBase()
  end
end
function this.IsReleaseMedicalSection()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=1)then
    return true
  else
    return false
  end
end
this.SectionOpenCondition={Combat=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=2)then
    return true
  else
    return false
  end
end,BaseDev=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE)and(TppStory.GetClearedMissionCount{10033,10036,10043}>=2)then
    return true
  else
    return false
  end
end,Spy=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)then
    return true
  else
    return false
  end
end,Medical=this.IsReleaseMedicalSection,Security=function()
  if this.IsCleardRetakeThePlatform()then
    return true
  else
    return false
  end
end,Hospital=function()
  if this.IsReleaseMedicalSection()then
    return TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform()
  else
    return false
  end
end,Prison=function()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    return true
  else
    return false
  end
end,Separation=function()
  if gvars.trm_isPushRewardSeparationPlatform and(not this.CheckPandemicEventFinish())then
    return true
  else
    return false
  end
end}
function this.IsReleaseSection(t)
  local e=this.SectionOpenCondition[t]
  if e then
    return e()
  end
end
function this.ReleaseMbSection()
  for n,t in ipairs(this.MOTHER_BASE_SECTION_LIST)do
    local e=this.IsReleaseSection(t)
    if e~=nil then
      TppMotherBaseManagement.OpenedSection{section=t,opened=e}
    end
  end
end
function this.OpenAllSection()
  for t,e in ipairs(this.MOTHER_BASE_SECTION_LIST)do
    TppMotherBaseManagement.OpenedSection{section=e,opened=true}
  end
end
function this.OnEstablishMissionClear()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=1)then
    local clusterGrade=1
    this.ForceStartBuildPlatform("Medical",clusterGrade)
    this.ForceStartBuildPlatform("Develop",clusterGrade)
  end
  this.PushRewardOnMbSectionOpen()
  if this.IsBuiltAnimalPlatform()and(not gvars.trm_isPushRewardAnimalPlatform)then
    gvars.trm_isPushRewardAnimalPlatform=true
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_107",rewardType=TppReward.TYPE.COMMON}
  end
  if this.IsReleaseSection"Security"then
    if not gvars.trm_isPushRewardOpenFob then
      gvars.trm_isPushRewardOpenFob=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_109",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if this.IsConstructedFirstFob()then
    if not gvars.trm_isPushConstructedFirstFob then
      gvars.trm_isPushConstructedFirstFob=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_110",rewardType=TppReward.TYPE.COMMON}
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_111",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppStory.IsMissionCleard(10033)then
    if not gvars.trm_isPushRewardCanDevArm then
      gvars.trm_isPushRewardCanDevArm=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_300",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if this.IsOpenMBDvcArmsMenu()and(not gvars.trm_isPushRewardOpenMBDvcArmsMenu)then
    gvars.trm_isPushRewardOpenMBDvcArmsMenu=true
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_301",rewardType=TppReward.TYPE.COMMON}
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_302",rewardType=TppReward.TYPE.COMMON}
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_401",rewardType=TppReward.TYPE.COMMON}
  end
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    if not gvars.trm_isPushRewardCanDevParasiteSuit then
      gvars.trm_isPushRewardCanDevParasiteSuit=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_307",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if vars.mbmMasterGunsmithSkill==1 then
    if not gvars.trm_isPushRewardOpenWeaponCustomize then
      gvars.trm_isPushRewardOpenWeaponCustomize=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_400",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if not gvars.trm_isPushRewardCanCustomVehicle then
    if this.HasVehicle()==true then
      gvars.trm_isPushRewardCanCustomVehicle=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_402",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    TppBuddyService.SetObtainedBuddyType(BuddyType.WALKER_GEAR)
    TppBuddyService.SetSortieBuddyType(BuddyType.WALKER_GEAR)
    if not gvars.trm_isPushRewardCanDevDWalker then
      gvars.trm_isPushRewardCanDevDWalker=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_305",rewardType=TppReward.TYPE.COMMON}
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_405",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppStory.CanPlayDemoOrRadio"CompliteDevelopBattleGear"or TppStory.GetBattleGearDevelopLevel()==5 then
    if not gvars.trm_isPushRewardBattleGearDevelopComplete then
      gvars.trm_isPushRewardBattleGearDevelopComplete=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_115",rewardType=TppReward.TYPE.COMMON}
      TppMotherBaseManagement.SetDeployableBattleGear{deployable=true}
    end
  end
  if this.PandemicTutorialStoryCondition()then
    if not gvars.trm_isPushRewardSeparationPlatform then
      gvars.trm_isPushRewardSeparationPlatform=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_112",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    if not gvars.trm_isPushRewardCanDevNuclear then
      gvars.trm_isPushRewardCanDevNuclear=true
      vars.mbmIsEnableNuclearDevelop=1
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_113",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppQuest.IsCleard"mtbs_q99011"then
    if not gvars.trm_isPushRewardCanDevQuietEquip then
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_304",rewardType=TppReward.TYPE.COMMON}
      gvars.trm_isPushRewardCanDevQuietEquip=true
    end
    TppEmblem.Add("front9",true,false)
  end
  local buddyCommands={BuddyCommand.HORSE_SHIT,BuddyCommand.DOG_BARKING,BuddyCommand.QUIET_AIM_TARGET,BuddyCommand.QUIET_COMBAT_START,BuddyCommand.QUIET_SHOOT_THIS}
  local commandRewardLangIds={"reward_500","reward_501","reward_502","reward_503","reward_504"}
  for i,commandEnabled in ipairs(buddyCommands)do
    if TppBuddyService.IsEnableBuddyCommand(commandEnabled)then
      local e=i-1
      if not gvars.trm_isPushRewardBuddyCommand[e]then
        gvars.trm_isPushRewardBuddyCommand[e]=true
        local langId=commandRewardLangIds[i]
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=langId,rewardType=TppReward.TYPE.COMMON}
      end
    end
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    TppMotherBaseManagement.EnableStaffInitLangKikongo()
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    local t={MBMConst.DEPLOY_MISSION_ID_SEQ_1001,MBMConst.DEPLOY_MISSION_ID_SEQ_1002,MBMConst.DEPLOY_MISSION_ID_SEQ_1003,MBMConst.DEPLOY_MISSION_ID_SEQ_1004,MBMConst.DEPLOY_MISSION_ID_SEQ_1005,MBMConst.DEPLOY_MISSION_ID_SEQ_1006,MBMConst.DEPLOY_MISSION_ID_SEQ_1007}
    this.OpenDeployMission(t)
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    local t={MBMConst.DEPLOY_MISSION_ID_SEQ_1008,MBMConst.DEPLOY_MISSION_ID_SEQ_1009,MBMConst.DEPLOY_MISSION_ID_SEQ_1010,MBMConst.DEPLOY_MISSION_ID_SEQ_1011}
    this.OpenDeployMission(t)
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
    local t={MBMConst.DEPLOY_MISSION_ID_SEQ_1012}
    this.OpenDeployMission(t)
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY then
    local t={MBMConst.DEPLOY_MISSION_ID_SEQ_1013,MBMConst.DEPLOY_MISSION_ID_SEQ_1014}
    this.OpenDeployMission(t)
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
    if not gvars.trm_doneUpdatePandemicLimit then
      gvars.trm_doneUpdatePandemicLimit=true
      TppMotherBaseManagement.UpdatePandemicEventLimit()
    end
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    local t={MBMConst.DEPLOY_MISSION_ID_SEQ_1015,MBMConst.DEPLOY_MISSION_ID_SEQ_1016,MBMConst.DEPLOY_MISSION_ID_SEQ_1017,MBMConst.DEPLOY_MISSION_ID_SEQ_1018,MBMConst.DEPLOY_MISSION_ID_SEQ_1019,MBMConst.DEPLOY_MISSION_ID_SEQ_1020}
    this.OpenDeployMission(t)
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    TppServerManager.StartFobPickup()
  end
  if currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
    vars.isAvatarPlayerEnable=1
  end
  this.AddUniqueCharactor()
end
function this.AddUniqueVolunteerStaff(missionId)
  local staffIdsTable={{186},{209},{210,211},{212},{213},{214},{215},{216,217},{218},{187},{185},{188,189,190,191,192,193},{194,195,196,197,198,199}}
  local idsIndexForMission={[10033]=1,[10036]=1,[10043]=1,[10080]=2,[10086]=3,[10082]=4,[10091]=5,[10195]=6,[10100]=7,[10110]=8,[10121]=9,[10070]=10,[10090]=11,[10151]=12,[10280]=13}
  local index=idsIndexForMission[missionId]
  if index then
    local staffIds=staffIdsTable[index]
    for n,staffId in ipairs(staffIds)do
      this._AddUniqueVolunteerStaff(staffId)
    end
  end
end
function this._AddUniqueVolunteerStaff(uniqueTypeId,t)
  if TppMotherBaseManagement.IsExistStaff{uniqueTypeId=uniqueTypeId}then
    return
  end
  local specialContract=false
  if t~=nil then
    specialContract=true
  end
  local staffId=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=uniqueTypeId}
  TppMotherBaseManagement.DirectAddStaff{staffId=staffId,section="Wait",isNew=true,specialContract=specialContract}
  TppUiCommand.ShowBonusPopupStaff(staffId,t)
  return true
end
function this.ForceStartBuildPlatform(category,clusterGrade)
  local currentGrade=TppMotherBaseManagement.GetClusterGrade{base="MotherBase",category=category}
  if currentGrade<clusterGrade then
    local buildStatus=TppMotherBaseManagement.GetClusterBuildStatus{base="MotherBase",category=category}
    if buildStatus=="Completed"then
      TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category=category,grade=0,buildStatus="Building",timeMinute=0,isNew=true}
    end
  end
end
function this.OpenDeployMission(deployMissionIds)
  for n,deployMissionId in ipairs(deployMissionIds)do
    TppMotherBaseManagement.SetSequentialMissionIdLimit{deployMissionId=deployMissionId}
  end
end
this.RewardLangIdTable={
  Combat={"reward_105","reward_106"},
  BaseDev={"reward_100","reward_101"},
  Spy={"reward_102"},
  Medical={"reward_103"},
  Security={"reward_108"},
  Hospital={"reward_104"}
}
function this.PushRewardOnMbSectionOpen()
  for a,section in ipairs(this.MOTHER_BASE_SECTION_LIST)do
    local rewardLangIdTable=this.RewardLangIdTable[section]
    local isReleaseSection=this.IsReleaseSection(section)
    if isReleaseSection~=nil and rewardLangIdTable then
      if isReleaseSection then
        if not gvars.trm_isPushRewardOpenSection[a]then
          gvars.trm_isPushRewardOpenSection[a]=true
          for t,langId in ipairs(rewardLangIdTable)do
            TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=langId,rewardType=TppReward.TYPE.COMMON}
          end
        end
      end
    end
  end
end
function this.IsCleardRetakeThePlatform()
  return TppStory.IsMissionCleard(10115)
end
function this.IsFailedRetakeThePlatform()
  local e=TppStory.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.FAILED_RETAKE_THE_PLATFORM)
  if e==TppDefine.ELAPSED_MISSION_COUNT.INIT then
    return false
  else
    return true
  end
end
function this.CanConstructFirstFob()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY then
    if this.IsCleardRetakeThePlatform()then
      return true
    end
  end
  return false
end
function this.IsConstructedFirstFob()
  if Ivars.setFirstFobBuilt:Is(1) then--tex
    return true
  end--
  if TppMotherBaseManagement.IsBuiltFirstFob then
    return TppMotherBaseManagement.IsBuiltFirstFob()
  else
    return true
  end
end
function this.IsReleaseFunctionBattle()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    return true
  else
    return false
  end
end
function this.IsReleaseFunctionNuclearDevelop()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    return true
  else
    return false
  end
end
this.SectionFuncOpenCondition={
  Combat={
    DispatchSoldier=true,
    DispatchFobDefence=this.IsCleardRetakeThePlatform
  },
  Develop={
    Weapon=true,
    SupportHelicopter=this.IsOpenMBDvcArmsMenu,
    Quiet=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
    end,
    D_Dog=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    end,
    D_Horse=this.IsOpenMBDvcArmsMenu,
    D_Walker=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.WALKER_GEAR)
    end,
    BattleGear=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.BATTLE_GEAR)
    end,
    SecurityDevice=this.IsConstructedFirstFob
  },
  BaseDev={
    Mining=true,
    Processing=true,
    Extention=true,
    Construct=this.IsCleardRetakeThePlatform,
    NuclearDevelop=this.IsReleaseFunctionNuclearDevelop
  },
  Support={
    Fulton=true,
    Supply=true,
    Battle=this.IsReleaseFunctionBattle,
    BattleArtillery=this.IsReleaseFunctionBattle,
    BattleSmoke=this.IsReleaseFunctionBattle,
    BattleSleepGas=this.IsReleaseFunctionBattle,
    BattleChaff=this.IsReleaseFunctionBattle,
    BattleWeather=this.IsReleaseFunctionBattle
  },
  Spy={
    Information=true,
    Scouting=true,
    SearchResource=true,
    WeatherInformation=true
  },
  Medical={
    Emergency=true,
    Treatment=true,
    AntiReflex=this.IsConstructedFirstFob--RETAILPATCH: 1060 antireflex added
  },
  Security={
    BaseDefence=true,
    MachineDefence=this.IsConstructedFirstFob,
    BaseBlockade=this.IsConstructedFirstFob,
    SecurityInfo=this.IsConstructedFirstFob
  }
}
function this.ReleaseFunctionOfMbSection()
  local openedSectionFunc=TppMotherBaseManagement.OpenedSectionFunc
  for section,sectionFunction in pairs(sectionFunctionIdTable)do
    for n,sectionFuncId in pairs(sectionFunction)do
      local releaseSectionFunction
      if this.SectionFuncOpenCondition[section]then
        releaseSectionFunction=this.SectionFuncOpenCondition[section][n]
      end
      if(releaseSectionFunction==true)then
        openedSectionFunc{sectionFuncId=sectionFuncId,opened=true}
      elseif releaseSectionFunction then
        if releaseSectionFunction(section)then
          openedSectionFunc{sectionFuncId=sectionFuncId,opened=true}
        else
          openedSectionFunc{sectionFuncId=sectionFuncId,opened=false}
        end
      end
    end
  end
end
function this.ReleaseFreePlay()
  TppUiCommand.ClearAllChangeLocationMenu()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    TppUiCommand.EnableChangeLocationMenu{locationId=10,missionId=30010}
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    TppUiCommand.EnableChangeLocationMenu{locationId=20,missionId=30020}
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30050}
  end
  if this.IsBuiltAnimalPlatform()then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30150}
  end
  if gvars.trm_isPushRewardSeparationPlatform then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30250}
  end
end
function this.IsBuiltAnimalPlatform()
  local e=gvars.trm_animalRecoverHistorySize
  if((gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=3))and(e>5)then
    return true
  else
    return false
  end
end
function this.InitNuclearAbolitionCount()
  if not gvars.f30050_isInitNuclearAbolitionCount then
    if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
      local e=TppServerManager.GetNuclearAbolitionCount()
      if e>=0 then
        gvars.f30050_NuclearAbolitionCount=e
        gvars.f30050_isInitNuclearAbolitionCount=true
      end
    end
  end
end
function this.RemoveStaffsAfterS10240()
  if TppStory.IsMissionCleard(10240)then
    TppMotherBaseManagement.RemoveStaffsS10240()
  end
end
function this.PickUpBluePrint(a,n)
  local t=nil
  if n then
    t=n
  else
    t=mvars.trm_bluePrintLocatorIdTable[a]
  end
  if not t then
    return
  end
  this.AddTempDataBase(t)
  local e=this.BLUE_PRINT_LANG_ID[t]
  TppUI.ShowAnnounceLog("get_blueprint",e)
end
function this.InitializeBluePrintLocatorIdTable()
  mvars.trm_bluePrintLocatorIdTable={}
  for e,t in pairs(this.BLUE_PRINT_LOCATOR_TABLE)do
    local e=TppCollection.GetUniqueIdByLocatorName(e)
    mvars.trm_bluePrintLocatorIdTable[e]=t
  end
end
function this.GetBluePrintKeyItemId(e)
  return mvars.trm_bluePrintLocatorIdTable[e]
end
function this.PickUpEmblem(e)
  local e=mvars.trm_EmblemLocatorIdTable[e]
  if not e then
    return
  end
  TppEmblem.Add(e,false,true)
end
function this.EnableTerminalVoice(e)
  mvars.trm_voiceDisabled=not e
end
function this.PlayTerminalVoice(n,e,t)
  if mvars.trm_voiceDisabled and e~=false then
    return
  end
  TppUiCommand.RequestMbSoundControllerVoice(n,e,t)
end
function this.OnFultonFailedEnd(e,t,n,a)
  mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
  mvars.trm_fultonFaileEndInfo[e]={e,t,n,a}
end
function this._OnFultonFailedEnd(fultonFailedInfo1,fultonFailedInfo2,fultonFailedInfo3,fultonFailedInfo4,playerIndex)
  if Tpp.IsLocalPlayer(playerIndex)then
    TppUI.ShowAnnounceLog"extractionFailed"
  end
end
function this.HasVehicle()
  local e=TppMotherBaseManagement.GetTempResourceBufferVehicleIncrementCount()
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="4wdEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="4wdWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TruckEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TruckWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="ArmoredVehicleEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="ArmoredVehicleWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="WheeledArmoredVehicleWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TankEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TankWest"}
  if e>0 then
    return true
  end
  return false
end
function this._SetUpDvcMenu(menu)
  if not Tpp.IsTypeTable(menu)then
    return
  end
  TppUiCommand.InitAllMbTopMenuItemVisible(false)
  TppUiCommand.InitAllMbTopMenuItemActive(true)
  this.EnableDvcMenuByList(menu)
end
function this.EnableDvcMenuByList(menus)
  for n=1,table.getn(menus)do
    if menus[n]==nil then
      return
    else
      TppUiCommand.SetMbTopMenuItemVisible(menus[n].menu,true)
      if menus[n].active~=nil then
        TppUiCommand.SetMbTopMenuItemActive(menus[n].menu,menus[n].active)
      end
    end
  end
end
function this.SetUpDvcMenuAll()
  TppUiCommand.InitAllMbTopMenuItemVisible(true)
  TppUiCommand.InitAllMbTopMenuItemActive(true)
end
function this.SetActiveTerminalMenu(menus)
  if not Tpp.IsTypeTable(menus)then
    return
  end
  if menus[1]==this.MBDVCMENU.ALL then
    TppUiCommand.InitAllMbTopMenuItemActive(true)
  else
    TppUiCommand.InitAllMbTopMenuItemActive(false)
    for e=1,table.getn(menus)do
      if menus[e]==nil then
        return
      else
        TppUiCommand.SetMbTopMenuItemActive(menus[e],true)
      end
    end
  end
end
return this

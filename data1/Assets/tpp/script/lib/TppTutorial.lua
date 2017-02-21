local this={}
local StrCode32=Fox.StrCode32
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local ENEMY_HELI_NAME="EnemyHeli"
this.TipsExceptTime={[TppDefine.TIPS.CQC_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.HOLD_UP_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.FULTON_CLASS_FUNCTION_STOP]={isOnceThisGame=true,isAlways=false},[TppDefine.TIPS.HORSE_HIDEACTION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.ACTION_MAKENOISE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.WEAPON_RANGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.RADIO_ESPIONAGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.COMOF_STANCE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.BINO_MARKING]={isOnceThisGame=false,isAlways=true}}
this.ControlExceptTime={[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.RIDE_HORSE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]={isOnceThisGame=true,isAlways=false}}
this.TipsAllPhase={[TppDefine.TIPS.HOLD_UP]=true,[TppDefine.TIPS.SNIPER_RIFLE]=true,[TppDefine.TIPS.UNDER_BARREL]=true,[TppDefine.TIPS.BULLET_REFILL]=true,[TppDefine.TIPS.COMMUNICATOR]=true,[TppDefine.TIPS.SUPPRESSOR]=true,[TppDefine.TIPS.SUPPORT_HELI]=true,[TppDefine.TIPS.BULLET_PENETRATE]=true,[TppDefine.TIPS.BULLET_PENETRATE_FAIL]=true,[TppDefine.TIPS.CQC_INTERROGATION]=true,[TppDefine.TIPS.HOLD_UP_INTERROGATION]=true,[TppDefine.TIPS.RELOAD]=true,[TppDefine.TIPS.COVER]=true,[TppDefine.TIPS.HORSE_HIDEACTION]=true,[TppDefine.TIPS.ACTION_MAKENOISE]=true,[TppDefine.TIPS.WEAPON_RANGE]=true,[TppDefine.TIPS.RADIO_ESPIONAGE]=true,[TppDefine.TIPS.COMOF_STANCE]=true,[TppDefine.TIPS.BINO_MARKING]=true}
this.ControlAllPhase={[TppDefine.CONTROL_GUIDE.RELOAD]=true,[TppDefine.CONTROL_GUIDE.MACHINEGUN]=true,[TppDefine.CONTROL_GUIDE.MORTAR]=true,[TppDefine.CONTROL_GUIDE.ANTI_AIRCRAFT]=true,[TppDefine.CONTROL_GUIDE.SHIELD]=true,[TppDefine.CONTROL_GUIDE.C4_EXPLODING]=true,[TppDefine.CONTROL_GUIDE.BOOSTER_SCOPE]=true,[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]=true,[TppDefine.CONTROL_GUIDE.UNDER_BARREL]=true,[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]=true,[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]=true,[TppDefine.CONTROL_GUIDE.RIDE_HORSE]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]=true}
this.TipsStoryFlag={[TppDefine.TIPS.STEALTH_MODE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ROLLING]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.REFLEX_MODE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TRASH]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TOILET]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TRANQUILIZER]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TAKE_DOWN]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.GUN_LIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.CRACK_CLIMB]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ELUDE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.LOG]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.THROW_EQUIP]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.CARRY_WEAPON_LIMIT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.HOLD_UP]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SNIPER_RIFLE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.UNDER_BARREL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BULLET_REFILL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SAVE_ANIMAL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.PLANT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_CONTAINER]=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,[TppDefine.TIPS.MATERIAL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.DIAMOND]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.DEV_DOCUMENT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.EMBLEM]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BOX_MOVE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_HORSE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_DOG]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_QUIET]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_WALKER]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.COMMUNICATOR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.ELECTRICITY]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.RADAR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.TACTICAL_BUDDY]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SUPPRESSOR]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.COMOF_NIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.DAY_NIGHT_SHIFT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.SAND_STORM]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FOG]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.RAIN]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.PHANTOM_CIGAR_TOILET]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FREE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.SUPPORT_HELI]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BULLET_PENETRATE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BUDDY_COMMAND]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SEARCH_LIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FULTON_MACHINEGUN]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_MORTAR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_ANTI_AIRCRAFT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.PHANTOM_CIGAR_TRASH]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FULTON_COMMON_VEHICLE]=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,[TppDefine.TIPS.BULLET_PENETRATE_FAIL]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.MORALE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.ANIMAL_CAGE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.CQC_INTERROGATION]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.HOLD_UP_INTERROGATION]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SHOWER_ROOM]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_CLASS_FUNCTION_STOP]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.HORSE_HIDEACTION]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ACTION_MAKENOISE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.WEAPON_RANGE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.RADIO_ESPIONAGE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.COMOF_STANCE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BINO_MARKING]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ACTIVE_SONAR]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FOB_WORM_HOLE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL}
this.ControlStoryFlag={TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL}
this.IgnoredTipsGuideInMission={[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.FOG]={[10020]=true,[10040]=true,[10090]=true,[10110]=true,[10130]=true,[10140]=true},[TppDefine.TIPS.MATERIAL]={[10020]=true},[TppDefine.TIPS.DEV_DOCUMENT]={[10020]=true},[TppDefine.TIPS.DIAMOND]={[10020]=true},[TppDefine.TIPS.PLANT]={[10020]=true},[TppDefine.TIPS.CRACK_CLIMB]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true},[TppDefine.TIPS.LOG]={[10020]=true},[TppDefine.TIPS.SUPPORT_HELI]={[10020]=true},[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.ANIMAL_CAGE]={[10020]=true},[TppDefine.TIPS.FULTON_CONTAINER]={[10020]=true},[TppDefine.TIPS.FULTON_COMMON_VEHICLE]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true,[10115]=true,[11043]=true,[11044]=true,[10280]=true,[50050]=true}}
this.IgnoredControlGuideInMission={}
this.NoGuideMission={[10030]=true,[10050]=true,[11050]=true,[11151]=true,[10140]=true,[11140]=true,[10150]=true,[10151]=true,[10240]=true,[50050]=true}
this.NoIntelRadioMission={[10010]=true,[11151]=true,[10150]=true,[10151]=true,[10240]=true,[10280]=true,[50050]=true}
function this._CheckLocation_AFGH_MAFR()
  if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
    return true
  end
  return false
end
function this._CheckLocation_MTBS()
  return TppLocation.IsMotherBase()
end
function this._IsEnabledToShowTipsFOB()
  if not TppMission.IsFOBMission(vars.missionCode)then
    return true
  end
  if vars.fobSneakMode==FobMode.MODE_VISIT then
    return true
  end
  return false
end
function this._IsEnabledPlayTutorialRadioFOB()
  if vars.fobSneakMode==FobMode.MODE_VISIT then
    return false
  end
  return true
end
this.TipsLocation={[TppDefine.TIPS.SAND_STORM]=this._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.FOG]=this._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.RAIN]=this._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.COMOF_NIGHT]=this._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.DAY_NIGHT_SHIFT]=TppLocation.IsAfghan,[TppDefine.TIPS.MORALE]=this._CheckLocation_MTBS}
this.TipsAvailableInHeli={LOG=true,SUPPORT_HELI=true,BUDDY_HORSE=true,BUDDY_DOG=true,BUDDY_COMMAND=true,BUDDY_QUIET=true,TACTICAL_BUDDY=true,FREE=true,ACTIVE_SONAR=true,BUDDY_WALKER=true}
this.ControlGuideAvailableInHeli={MOVE_IN_HELI=true}
this.WeatherTipsGuideMatchTable={[TppDefine.WEATHER.SANDSTORM]="SAND_STORM",[TppDefine.WEATHER.FOGGY]="FOG",[TppDefine.WEATHER.RAINY]="RAIN"}
this.FultonTipsGuideMatchTable={[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]="FULTON_CONTAINER",[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]="FULTON_MACHINEGUN",[TppGameObject.GAME_OBJECT_TYPE_MORTAR]="FULTON_MORTAR",[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]="FULTON_ANTI_AIRCRAFT",[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]="FULTON_COMMON_VEHICLE"}
this.AttackVehicleTable={
  [Vehicle.type.EASTERN_TRACKED_TANK]=true,
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=true,
  [Vehicle.type.WESTERN_TRACKED_TANK]=true,
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=true
}
this.DISPLAY_OPTION={TIPS=1,CONTROL=2,TIPS_CONTROL=3,PAUSE_CONTROL=4,TIPS_IGONORE_RADIO=5,CONTROL_IGONORE_RADIO=6,TIPS_IGONORE_DISPLAY=7}
this.DISPLAY_TIME={DEFAULT=15,LONG=9,LONGER=11}
this.TipsGuideRadioList={[TppDefine.TIPS.DAY_NIGHT_SHIFT]="f1000_rtrg0160",[TppDefine.TIPS.COMOF_NIGHT]="f1000_rtrg2980",[TppDefine.TIPS.RAIN]="f1000_rtrg0180",[TppDefine.TIPS.FOG]="f1000_rtrg0190",[TppDefine.TIPS.SAND_STORM]="f1000_rtrg0210",[TppDefine.TIPS.CRACK_CLIMB]="f1000_rtrg4470",[TppDefine.TIPS.PHANTOM_CIGAR_TOILET]="f1000_rtrg4480",[TppDefine.TIPS.PHANTOM_CIGAR_TRASH]="f1000_rtrg4480",[TppDefine.TIPS.BULLET_REFILL]="f1000_rtrg4490",[TppDefine.TIPS.DEV_DOCUMENT]="f1000_rtrg4080",[TppDefine.TIPS.TRASH]="f1000_rtrg4500",[TppDefine.TIPS.TOILET]="f1000_rtrg4510",[TppDefine.TIPS.DIAMOND]="f1000_rtrg0560",[TppDefine.TIPS.SAVE_ANIMAL]="f1000_rtrg0615",[TppDefine.TIPS.ELECTRICITY]="f1000_rtrg4530",[TppDefine.TIPS.FULTON_CONTAINER]="f1000_rtrg0570",[TppDefine.TIPS.MATERIAL]="f1000_rtrg0580",[TppDefine.TIPS.PLANT]="f1000_rtrg4090",[TppDefine.TIPS.BULLET_PENETRATE]="f1000_rtrg3640",[TppDefine.TIPS.BULLET_PENETRATE_FAIL]="f1000_rtrg3650",[TppDefine.TIPS.ANIMAL_CAGE]={"f1000_rtrg0615","f1000_rtrg0625"}}
this.IntelRadioSetting={type_translate="f1000_esrg1110",type_antenna="f1000_esrg1110",type_eleGenerator="f1000_esrg2200",type_switchboard="f1000_esrg2200",type_searchradar="f1000_esrg1180",type_redSensor="f1000_esrg2140",type_burglar_alarm="f1000_esrg2450",type_gunMount="f1000_esrg1120",type_mortar="f1000_esrg0040",type_antiAirGun="f1000_esrg0990",type_searchlight="f1000_esrg0950",type_trash="f1000_esrg1070",type_drumcan="f1000_esrg1000",type_toilet="f1000_esrg2210",type_shower="f1000_esrg2460",type_camera="f1000_esrg2150",type_gun_camera="f1000_esrg2160",type_uav="f1000_esrg2170",type_light_vehicle="f1000_esrg1010",type_truck="f1000_esrg1020",type_armored_vehicle="f1000_esrg1030",type_tank="f1000_esrg1040",type_walkergear="f1000_esrg0070",type_walkergear_used="f1000_esrg0060",type_enemy_soviet="f1000_esrg0420",type_enemy_cfa="f1000_esrg0730",type_enemy_coyote="f1000_esrg0740",type_enemy_security="f1000_esrg0460",type_enemy_xof="f1000_esrg2410",type_garbillinae="f1000_esrg0150",type_hamiechinus="f1000_esrg0160",type_ochotona_rufescens="f1000_esrg0170",type_raven="f1000_esrg0080",type_hornbill="f1000_esrg0100",type_ciconia_nigra="f1000_esrg0110",type_jehuty="f1000_esrg0120",type_gyps_fulvus="f1000_esrg0130",type_torgos_tracheliotos="",type_polemaetus_bellicosus="f1000_esrg0140",type_goat="f1000_esrg0190",type_sheep="f1000_esrg0180",type_nubian="f1000_esrg0200",type_bore="f1000_esrg0210",type_donkey="f1000_esrg0220",type_zebra="f1000_esrg0230",type_okapi="f1000_esrg0240",type_wolf="f1000_esrg0250",type_lycaon="f1000_esrg0260",type_jackal="f1000_esrg0270",type_anubis="f1000_esrg0280",type_ursus_arctos="f1000_esrg0290",type_kashmiri_ursus_arctos="f1000_esrg0290"}
this.IntelTypeTipsMatchTable={type_translate="COMMUNICATOR",type_antenna="COMMUNICATOR",type_searchradar="RADAR",type_eleGenerator="ELECTRICITY",type_switchboard="ELECTRICITY"}
this.RadioTipsMatchTable={[StrCode32"f1000_esrg2190"]="COMMUNICATOR",[StrCode32"f1000_esrg2440"]="RADAR",[StrCode32"f1000_esrg2200"]="ELECTRICITY",[StrCode32"f1000_oprg1600"]="LOG",[StrCode32"f1000_oprg1320"]="HOLD_UP",[StrCode32"f1000_oprg1610"]="SUPPORT_HELI",[StrCode32"f1000_oprg1460"]="BUDDY_HORSE",[StrCode32"f2000_rtrg1410"]="BUDDY_DOG",[StrCode32"f1000_rtrg4570"]="BUDDY_COMMAND",[StrCode32"f1000_rtrg4590"]="BUDDY_QUIET",[StrCode32"f1000_rtrg4560"]="TACTICAL_BUDDY",[StrCode32"f2000_rtrg0010"]="FREE",[StrCode32"f1000_rtrg4550"]="ACTIVE_SONAR",[StrCode32"f1000_oprg1470"]="BUDDY_WALKER",[StrCode32(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN])]="SUPPRESSOR"}
this.ControlGuideRadioList={[TppDefine.CONTROL_GUIDE.PIPE_UP]="f1000_rtrg4630"}
this.PlantRadioMatchTable={[TppCollection.TYPE_HERB_G_CRESCENT]="f1000_rtrg5010",[TppCollection.TYPE_HERB_A_PEACH]="f1000_rtrg5012",[TppCollection.TYPE_HERB_DIGITALIS_P]="f1000_rtrg5013",[TppCollection.TYPE_HERB_DIGITALIS_R]="f1000_rtrg5013",[TppCollection.TYPE_HERB_B_CARROT]="f1000_rtrg5016",[TppCollection.TYPE_HERB_WORM_WOOD]="f1000_rtrg5014",[TppCollection.TYPE_HERB_TARRAGON]="f1000_rtrg5015",[TppCollection.TYPE_HERB_HAOMA]="f1000_rtrg5011"}
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="FinishReflexMode",func=function()
        this.DispGuide("REFLEX_MODE",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="IconCrawlStealthShown",func=function()
        this.DispGuide("STEALTH_MODE",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="IconClimbOnShown",func=this.OnIconClimbOnShown},
      {msg="IconSwitchShown",func=this.OnIconSwitchShown},
      {msg="OnPlayerElude",func=function()
        this.DispGuide("ELUDE",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="OnPlayerMachineGun",func=function()
        this.DispGuide("MACHINEGUN",this.DISPLAY_OPTION.CONTROL)
      end},
      {msg="OnPlayerMortar",func=function()
        this.DispGuide("MORTAR",this.DISPLAY_OPTION.CONTROL)
      end},
      {msg="OnPlayerGatling",func=function()
        this.DispGuide("ANTI_AIRCRAFT",this.DISPLAY_OPTION.CONTROL)
      end},
      {msg="OnPlayerSearchLight",func=function()
        this.DispGuide("SEARCH_LIGHT",this.DISPLAY_OPTION.TIPS_CONTROL)
      end},
      {msg="IconFultonShown",func=this.OnIconFultonShown},
      {msg="IconTBoxOnShown",func=function()
        this.DispGuide("TRASH",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="IconToiletOnShown",func=function()
        this.DispGuide("TOILET",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="OnVehicleDrive",func=this.OnVehicleDrive},
      {msg="OnWalkerGearDrive",func=function()
        this.DispGuide("DRIVE_WALKER_GEAR",this.DISPLAY_OPTION.PAUSE_CONTROL)
      end},
      {msg="OnCrawl",func=function()
        this.DispGuide("ROLLING",this.DISPLAY_OPTION.TIPS_CONTROL)
      end},
      {msg="StartCarryIdle",func=this.OnStartCarryIdle},
      {msg="OnPickUpCollection",func=this.OnPickUpCollection},
      {msg="PlayerHoldWeapon",func=this.OnPlayerHoldWeapon},
      {msg="OnPlayerUseBoosterScope",func=this.OnPlayerUseBoosterScope},
      {msg="OnEquipItem",func=this.OnEquipItem},
      {msg="OnEquipHudClosed",func=this.OnEquipHudClosed},
      {msg="OnAmmoLessInMagazine",func=function()
        this.DispGuide("RELOAD",this.DISPLAY_OPTION.TIPS_CONTROL)
      end},
      {msg="WeaponPutPlaced",func=this.OnWeaponPutPlaced},
      {msg="OnAmmoStackEmpty",func=this.OnAmmoStackEmpty},
      {msg="OnPlayerHeliHatchOpen",func=function()
        this.DispGuide("MOVE_IN_HELI",this.DISPLAY_OPTION.CONTROL)
      end},
      {msg="OnPlayerPipeAction",func=function()
        this.DispGuide("PIPE_UP",this.DISPLAY_OPTION.CONTROL)
      end},
      {msg="OnPlayerToilet",func=function()
        this.DispGuide_PhatomCigar("PHANTOM_CIGAR_TOILET",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="OnPlayerTrashBox",func=function()
        this.DispGuide_PhatomCigar("PHANTOM_CIGAR_TRASH",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="PlayerHeliGetOff",func=this.OnPlayerHeliGetOff},
      {msg="NotHaveStaffToReceiveFulton",func=function()
        this.DispGuide("FULTON_CLASS_FUNCTION_STOP",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="SuppressorIsBroken",func=this.OnSuppressorIsBroken},
      {msg="IconWormholeOnShown",func=function()
        this.DispGuide("FOB_WORM_HOLE",this.DISPLAY_OPTION.TIPS)
      end}},
    GameObject={
      {msg="StartInvestigate",func=this.StartInvestigate},
      {msg="EndInvestigate",func=this.EndInvestigate},
      {msg="BulletGuardArmor",func=this.OnBulletGuardArmor},
      {msg="Fulton",func=this.OnFultonRecovered},
      {msg="SaluteRaiseMorale",func=function()
        this.DispGuide("MORALE",this.DISPLAY_OPTION.TIPS)
      end},
      {msg="InAnimalLocator",func=this.InAnimalLocator},
      {msg="DiscoveredBySniper",func=this.OnDiscoveredBySniper},
      {msg="DiscoveredObject",func=this.OnDiscoveredObject},
      {msg="PlayerIsWithinRange",func=this.OnPlayerIsWithinRange}},
    Trap={
      {msg="Enter",sender="trap_Tips_CarryOverThrow_swamp",func=this.DispGuide_TrapCarryThrow},
      {msg="Enter",sender="trap_Tips_CarryOverThrow_tent0001",func=this.DispGuide_TrapCarryThrow},
      {msg="Enter",sender="trap_Tips_CarryOverThrow_tent0002",func=this.DispGuide_TrapCarryThrow},
      {msg="Enter",sender="trap_Tips_CarryOverThrow_tent0003",func=this.DispGuide_TrapCarryThrow},
      {msg="Enter",sender="trap_Tips_CarryOverThrow_tent0004",func=this.DispGuide_TrapCarryThrow},
      {msg="Enter",sender="trap_Tips_CarryOverThrow_tent0005",func=this.DispGuide_TrapCarryThrow}},
    Marker={{msg="ChangeToEnable",func=this.OnMarking}},
    Weather={{msg="ChangeWeather",func=this.DispGuide_Weather}},
    Radio={
      {msg="EspionageRadioPlay",func=this._UnregisterIntelRadioAfterPlayed},
      {msg="Start",func=this.OnRadioStart}},
    nil}
end
function this.DispGuide_TrapCarryThrow()
  if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
    local e=TppDefine.CONTROL_GUIDE.SHOULDER_THROW
    local e=TppDefine.CONTROL_GUIDE_LANG_ID_LIST[e]
    TppUiCommand.CallButtonGuide(e)
  end
end
function this.DispGuide(n,i,_)
  local T=TppStory.GetCurrentStorySequence()
  local isNotAlert=not Tpp.IsNotAlert()
  if i==this.DISPLAY_OPTION.TIPS then
    this.DispTipsGuide(n,T,isNotAlert,_)
  elseif i==this.DISPLAY_OPTION.CONTROL then
    this.DispControlGuide(n,T,isNotAlert,_)
  elseif i==this.DISPLAY_OPTION.TIPS_CONTROL then
    this.DispControlGuide(n,T,isNotAlert)
    this.DispTipsGuide(n,T,isNotAlert)
  elseif i==this.DISPLAY_OPTION.PAUSE_CONTROL then
    this.DispControlGuide(n,T,isNotAlert,nil,true)
  elseif i==this.DISPLAY_OPTION.TIPS_IGONORE_RADIO then
    this.DispTipsGuide(n,T,isNotAlert,_,false,true)
  elseif i==this.DISPLAY_OPTION.CONTROL_IGONORE_RADIO then
    this.DispControlGuide(n,T,isNotAlert,_,false,true)
  elseif i==this.DISPLAY_OPTION.TIPS_IGONORE_DISPLAY then
    this.DispTipsGuide(n,T,isNotAlert,_,false,false,true)
  end
end
function this.DispTipsGuide(n,i,S,O,T,_,p)
  local T=TppDefine.TIPS[n]
  if not T then
    return
  end
  local E=this.TipsStoryFlag[T]
  if E then
    if i<E then
      return
    end
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    if not this.TipsAvailableInHeli[n]then
      return
    end
  else
    if this._CheckLocation_MTBS()then
      if not this._IsEnabledToShowTipsFOB()then
        return
      end
    end
    local E=this.TipsLocation[T]
    if E then
      if not E()then
        return
      end
    end
    if not TppMission.IsFreeMission(vars.missionCode)then
      if this.NoGuideMission[vars.missionCode]then
        return
      end
      local n=this.IgnoredTipsGuideInMission[T]
      if n then
        for e,T in pairs(n)do
          if vars.missionCode==e then
            return
          end
        end
      end
      if TppMission.IsBossBattle()then
        if not this.TipsAllPhase[T]then
          return
        end
      end
    end
    if S then
      if not this.TipsAllPhase[T]then
        return
      end
    end
    if this.IsRideHelicopter()and not this.TipsAvailableInHeli[n]then
      return
    end
  end
  local i=true
  local E=false
  local e=this.TipsExceptTime[T]
  if e then
    i=e.isOnce
    E=e.isOnceThisGame
  end
  local e=O
  TppUI.ShowTipsGuide{contentName=n,isOnce=i,isOnceThisGame=E,time=e,ignoreRadio=_,ignoreDisplay=p}
end
function this.DispControlGuide(n,_,i,p,O,S)
  local T=TppDefine.CONTROL_GUIDE[n]
  if not T then
    return
  end
  local E=this.ControlStoryFlag[T]
  if E then
    if _<E then
      return
    end
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    if not this.ControlGuideAvailableInHeli[n]then
      return
    end
  else
    if this._CheckLocation_MTBS()then
      if not this._IsEnabledToShowTipsFOB()then
        return
      end
    end
    if not TppMission.IsFreeMission(vars.missionCode)then
      if this.NoGuideMission[vars.missionCode]then
        return
      end
      local n=this.IgnoredControlGuideInMission[T]
      if n then
        for e,T in pairs(n)do
          if vars.missionCode==e then
            return
          end
        end
      end
      if TppMission.IsBossBattle()then
        if not this.ControlAllPhase[T]then
          return
        end
      end
    end
    if i then
      if not this.ControlAllPhase[T]then
        return
      end
    end
    if this.IsRideHelicopter()and not this.ControlGuideAvailableInHeli[n]then
      return
    end
  end
  local i=true
  local E=false
  local e=this.ControlExceptTime[T]
  if e then
    i=e.isOnce
    E=e.isOnceThisGame
  end
  local e=p
  TppUI.ShowControlGuide{actionName=n,isOnce=i,isOnceThisGame=E,time=e,pauseControl=O,ignoreRadio=S}
end
function this.IsRideHelicopter()
  if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
    return true
  end
  return false
end
function this.OnIconFultonShown(E,T,n)
  local T=GameObject.GetTypeIndex(T)
  if this.FultonTipsGuideMatchTable[T]then
    if T~=TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER then
      this.DispGuide(this.FultonTipsGuideMatchTable[T],this.DISPLAY_OPTION.TIPS)
    else
      if n==1 then
        this.DispGuide(this.FultonTipsGuideMatchTable[T],this.DISPLAY_OPTION.TIPS)
      end
    end
  end
end
function this.OnVehicleDrive(n,T)
  local T=GameObject.SendCommand(T,{id="GetVehicleType"})
  if this.AttackVehicleTable[T]then
    this.DispGuide("ATTACK_VEHICLE_SHOOT",this.DISPLAY_OPTION.CONTROL)
    this.DispGuide("ATTACK_VEHICLE_CAMERA",this.DISPLAY_OPTION.CONTROL)
  end
  this.DispGuide("DRIVE_COMMON_VEHICLE",this.DISPLAY_OPTION.PAUSE_CONTROL)
end
function this.OnStartCarryIdle()
  this.DispGuide("SHOULDER",this.DISPLAY_OPTION.CONTROL)
  this.DispGuide("SHOULDER_THROW",this.DISPLAY_OPTION.CONTROL)
  this.DispGuide("CARRY_WEAPON_LIMIT",this.DISPLAY_OPTION.TIPS)
end
function this.OnPickUpCollection(playerId,resourceId,resourceType,langId)
  if resourceType==TppCollection.TYPE_DIAMOND_SMALL or resourceType==TppCollection.TYPE_DIAMOND_LARGE then
    this.DispGuide("DIAMOND",this.DISPLAY_OPTION.TIPS)
  elseif TppCollection.IsHerbByType(resourceType)then
    this.DispGuide("PLANT",this.DISPLAY_OPTION.TIPS)
    if not TppUiCommand.IsDispGuide"TipsGuide"then
      local T=this.PlantRadioMatchTable[resourceType]
      if T then
        this.PlayTutorialRadioOnly(T,{delayTime="mid"})
      end
    end
  elseif resourceType==TppCollection.TYPE_DEVELOPMENT_FILE then
    this.DispGuide("DEV_DOCUMENT",this.DISPLAY_OPTION.TIPS)
  elseif resourceType==TppCollection.TYPE_EMBLEM then
    this.DispGuide("EMBLEM",this.DISPLAY_OPTION.TIPS)
  elseif resourceType==TppCollection.TYPE_SHIPPING_LABEL then
    this.DispGuide("BOX_MOVE",this.DISPLAY_OPTION.TIPS)
  elseif resourceType>=TppCollection.TYPE_MATERIAL_CM_0 and resourceType<=TppCollection.TYPE_MATERIAL_BR_7 then
    this.DispGuide("MATERIAL",this.DISPLAY_OPTION.TIPS)
  end
end
local UnkFunc1IsSomeEquipId=function(findEquipId)
  local unk1SomeEuipIds={TppEquip.EQP_WP_10101,TppEquip.EQP_WP_10102,TppEquip.EQP_WP_10103,TppEquip.EQP_WP_10104,TppEquip.EQP_WP_10105,TppEquip.EQP_WP_10107,TppEquip.EQP_WP_10116,TppEquip.EQP_WP_10125,TppEquip.EQP_WP_10134,TppEquip.EQP_WP_10136,TppEquip.EQP_WP_10214,TppEquip.EQP_WP_10216,TppEquip.EQP_WP_60013,TppEquip.EQP_WP_60015,TppEquip.EQP_WP_60016,TppEquip.EQP_WP_60114,TppEquip.EQP_WP_60115,TppEquip.EQP_WP_60116,TppEquip.EQP_WP_60117,TppEquip.EQP_WP_60325,TppEquip.EQP_WP_60326,TppEquip.EQP_WP_60327}
  for i,equipId in pairs(unk1SomeEuipIds)do
    if equipId==findEquipId then
      return true
    end
  end
end
--msg output PlayerHoldWeapon arg0: 687, arg1: 1, arg2: 1, arg3: 0, 
function this.OnPlayerHoldWeapon(equipId,equipType,unk3HasGunLight,unk4IsSheild)
  if unk4IsSheild==1 then
    this.DispGuide("SHIELD",this.DISPLAY_OPTION.CONTROL)
  end
  if equipType==TppEquip.EQP_TYPE_Sniper then
    this.DispGuide("SNIPER_RIFLE",this.DISPLAY_OPTION.TIPS_CONTROL)
  end
  if UnkFunc1IsSomeEquipId(equipId)then
    this.DispGuide("TRANQUILIZER",this.DISPLAY_OPTION.TIPS)
  end
  if unk3HasGunLight==1 then
    this.DispGuide("GUN_LIGHT",this.DISPLAY_OPTION.TIPS)
  end
end
function this.OnPlayerUseBoosterScope()
  this.DispGuide("BOOSTER_SCOPE",this.DISPLAY_OPTION.CONTROL)
end
function this.OnEquipItem(e,e)
end
function this.OnEquipHudClosed(n,weapons,T)
  if T==TppEquip.EQP_TYPE_Throwing then
    this.DispGuide("THROW_EQUIP",this.DISPLAY_OPTION.TIPS)
  elseif T==TppEquip.EQP_TYPE_Placed then
    local T=TppEquip.GetSupportWeaponTypeId(weapons)
    if T==TppEquip.SWP_TYPE_CaptureCage then
      this.DispGuide("ANIMAL_CAGE",this.DISPLAY_OPTION.TIPS)
    end
  else
    local ammoId
    local ammoInWeapon
    local defaultAmmo
    local altAmmoId
    local altAmmoInWeapon
    local altDefaultAmmo
    ammoId,ammoInWeapon,defaultAmmo,altAmmoId,altAmmoInWeapon,altDefaultAmmo=TppEquip.GetAmmoInfo(weapons)
    if ammoId~=0 and altAmmoId~=0 then
      this.DispGuide("UNDER_BARREL",this.DISPLAY_OPTION.TIPS_CONTROL)
    end
  end
end
function this.OnWeaponPutPlaced(n,T)
  local T=TppEquip.GetSupportWeaponTypeId(T)
  if T==TppEquip.SWP_TYPE_C4 then
    this.DispGuide("C4_EXPLODING",this.DISPLAY_OPTION.CONTROL)
  end
end
function this.OnAmmoStackEmpty(n,n,T)
  if Player.IsEnableAmmoSupply(T)then
    this.DispGuide("BULLET_REFILL",this.DISPLAY_OPTION.TIPS)
  end
end
function this.OnPlayerHeliGetOff()
  if not this._IsMBFree()then
    return
  end
  this.DispGuide("SHOWER_ROOM",this.DISPLAY_OPTION.TIPS)
end
function this.OnSuppressorIsBroken()
  if TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON<=TppStory.GetCurrentStorySequence()then
    return
  end
  if this._IsMBFree()then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN,true)
end
function this.StartInvestigate(n,T,n)
  if T==0 then
    return
  end
  this.PlayTutorialRadioOnly("f1000_rtrg4450",{delayTime="long"})
end
function this.EndInvestigate(n,T,n)
  if T==0 then
    return
  end
  this.PlayTutorialRadioOnly("f1000_rtrg4460",{delayTime="long"})
end
function this._IsMBFree()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.MTBS_FREE then
    return true
  end
  return false
end
local n=function(T)
  local e=PlayerConstants.ITEM_COUNT-1
  for e=0,e do
    if vars.items[e]==T then
      return true
    end
  end
  return false
end
function this.DispGuide_PhatomCigar(T)
  if not n(TppEquip.EQP_IT_TimeCigarette)then
    return
  end
  if vars.playerPhase<TppGameObject.PHASE_ALERT and vars.playerPhase>TppGameObject.PHASE_SNEAK then
    this.DispGuide(T,this.DISPLAY_OPTION.TIPS)
  end
end
function this.DispGuide_Weather(T)
  if this.WeatherTipsGuideMatchTable[T]then
    this.DispGuide(this.WeatherTipsGuideMatchTable[T],this.DISPLAY_OPTION.TIPS)
  end
end
function this.DispGuide_Comufrage()
  if Tpp.IsVehicle(vars.playerVehicleGameObjectId)then
    this.DispGuide("VEHICLE_LIGHT",this.DISPLAY_OPTION.CONTROL)
  end
  this.DispGuide("COMOF_NIGHT",this.DISPLAY_OPTION.TIPS)
end
function this.DispGuide_DayAndNight()
  this.DispGuide("DAY_NIGHT_SHIFT",this.DISPLAY_OPTION.TIPS)
end
function this.InAnimalLocator()
  this.DispGuide("SAVE_ANIMAL",this.DISPLAY_OPTION.TIPS)
end
function this.OnDiscoveredBySniper()
  if this.IsRideHelicopter()then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER,true)
end
function this.OnDiscoveredObject(T,n)
  if this.IsRideHelicopter()then
    return
  end
  if T~=GameObject.GetGameObjectId(ENEMY_HELI_NAME)then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI,true)
end
function this.OnPlayerIsWithinRange(T,n)
  if this.IsRideHelicopter()then
    return
  end
  if T~=GameObject.GetGameObjectId(ENEMY_HELI_NAME)then
    return
  end
  TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI,true)
end
function this.SetEnemyHeliMessageWithinRange()
  local e=GameObject.GetGameObjectId(ENEMY_HELI_NAME)
  if e~=GameObject.NULL_ID then
    GameObject.SendCommand(e,{id="SetMessagePlayerIsWithinRange",name="CheckRange400",enabled=true,range=400})
  end
end
function this.OnIconSwitchShown(i,E,T,n)
  local T=TppGimmick.GetGimmickID(E,T,n)
  if not T then
    return
  end
  local T=mvars.gim_connectPowerCutAreaTable[T]
  if T then
    this.DispGuide("ELECTRICITY",this.DISPLAY_OPTION.TIPS)
  end
end
function this.OnIconClimbOnShown(n,T)
  if T==1 then
    this.DispGuide("CRACK_CLIMB",this.DISPLAY_OPTION.TIPS)
  end
end
function this.OnBulletGuardArmor(n,i,n,T)
  if BulletGuardArmorMessageFlag==nil then
    return
  end
  local n=BulletGuardArmorMessageFlag.BROKEN_HELMET
  local E=BulletGuardArmorMessageFlag.IS_HIT_ARMOR
  if bit.band(T,n)==n then
    this.DispGuide("BULLET_PENETRATE",this.DISPLAY_OPTION.TIPS)
  elseif bit.band(T,E)==E then
    if not TppDamage.IsActiveByAttackId(i)then
      this.DispGuide("BULLET_PENETRATE_FAIL",this.DISPLAY_OPTION.TIPS)
    end
  end
end
function this.OnMarking(instanceName,makerType,gameObjectId,identificationCode)
  if identificationCode~=StrCode32"Player"then
    return
  end
  if Tpp.IsSecurityCamera(gameObjectId)then
    if Tpp.IsGunCamera(gameObjectId)then
      this.PlayTutorialRadioOnly"f1000_rtrg4610"
      else
      this.PlayTutorialRadioOnly"f1000_rtrg4600"
      end
  elseif Tpp.IsUAV(gameObjectId)then
    this.PlayTutorialRadioOnly"f1000_rtrg4620"
    end
end
function this.OnFultonRecovered(gameId)
  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex==TppGameObject.GAME_OBJECT_TYPE_VEHICLE then
    if gameId~=GameObject.CreateGameObjectId("TppVehicle2",0)then
      this.PlayTutorialRadioOnly("f1000_rtrg4540",{delayTime="long"})
    end
  end
end
function this.OnRadioStart(T)
  local T=this.RadioTipsMatchTable[T]
  if T then
    this.DispGuide(T,this.DISPLAY_OPTION.TIPS_IGONORE_RADIO)
  end
end
function this._UnregisterIntelRadioAfterPlayed(E)
  if TppMission.IsFreeMission(vars.missionCode)then
    return
  end
  for n,e in pairs(this.IntelRadioSetting)do
    if StrCode32(e)==E then
      local e={}
      e[n]="Invalid"
      TppRadio.ChangeIntelRadio(e)
      break
    end
  end
end
function this.OpenTipsOnStory(E)
  if not Tpp.IsTypeNumber(E)then
    return
  end
  local T=1
  local e=true
  for n=0,#TppDefine.STORY_SEQUENCE_LIST do
    if n<=E then
      e=true
    else
      e=false
    end
    T=tostring(n)
    TppUiCommand.EnableTipsGroup(T,e)
  end
end
function this.OpenTipsOnCurrentStory()
  local T=TppStory.GetCurrentStorySequence()
  this.OpenTipsOnStory(T)
end
function this.SetIgnoredControlGuideInMission(n,T,E)
  local T=TppDefine.CONTROL_GUIDE[T]
  if not T then
    return
  end
  if E then
    if not this.IgnoredControlGuideInMission[T]then
      this.IgnoredControlGuideInMission[T]={}
    end
    this.IgnoredControlGuideInMission[T][n]=true
  else
    if this.IgnoredControlGuideInMission[T]and this.IgnoredControlGuideInMission[T][n]then
      this.IgnoredControlGuideInMission[T][n]=nil
    end
  end
end
function this.SetIgnoredGuideInMission(T,n,E)
  if not IsTypeNumber(T)or not IsTypeString(n)then
    return
  end
  this.SetIgnoredTipsGuideInMission(T,n,E)
  this.SetIgnoredControlGuideInMission(T,n,E)
end
function this.SetNoGuideMission(T,n)
  if not IsTypeNumber(T)then
    return
  end
  if n then
    this.NoGuideMission[T]=true
  else
    if this.NoGuideMission[T]then
      this.NoGuideMission[T]=nil
    end
  end
end
function this.SetIgnoredTipsGuideInMission(n,T,E)
  local T=TppDefine.TIPS[T]
  if not T then
    return
  end
  if E then
    if not this.IgnoredTipsGuideInMission[T]then
      this.IgnoredTipsGuideInMission[T]={}
    end
    this.IgnoredTipsGuideInMission[T][n]=true
  else
    if this.IgnoredTipsGuideInMission[T]and this.IgnoredTipsGuideInMission[T][n]then
      this.IgnoredTipsGuideInMission[T][n]=nil
    end
  end
end
function this.PlayTutorialRadioOnly(T,n)
  if not TppUI.IsEnableToShowGuide()then
    return
  end
  if this.NoGuideMission[vars.missionCode]then
    return
  end
  if not this._IsEnabledPlayTutorialRadioFOB()then
    return
  end
  this.PlayRadio(T,n)
end
function this.PlayRadio(e,n)
  local T={delayTime="short"}
  if n then
    T=n
  end
  if IsTypeTable(e)then
    local n={}
    for T,e in pairs(e)do
      if not TppRadio.IsPlayed(e)then
        table.insert(n,e)
      end
    end
    TppRadio.Play(n,T)
  else
    if not TppRadio.IsPlayed(e)then
      TppRadio.Play(e,T)
    end
  end
end
function this.SetIntelRadio()
  if this.NoIntelRadioMission[vars.missionCode]or not this._IsEnabledPlayTutorialRadioFOB()then
    return
  end
  local e=this.IntelRadioSetting
  if not TppMission.IsFreeMission(vars.missionCode)then
    for T,n in pairs(e)do
      if TppRadio.IsPlayed(n)then
        table.remove(e,T)
      end
    end
  end
  TppRadio.ChangeIntelRadio(e)
end
function this.MakeMessageExecTable()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.MakeMessageExecTable()
  this.OpenTipsOnCurrentStory()
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Init(missionTable)
  this.MakeMessageExecTable()
  this.OpenTipsOnCurrentStory()
  this.SetEnemyHeliMessageWithinRange()
end
return this

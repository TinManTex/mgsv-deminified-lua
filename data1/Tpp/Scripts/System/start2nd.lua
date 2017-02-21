-- DOBUILD: 1
-- start2nd.lua
local function YieldFrame()
  coroutine.yield()
end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"
YieldFrame()
local e=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
  dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"
end
YieldFrame()
dofile"/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2InitializeScript.lua"
YieldFrame()
if Script.LoadLibrary then
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting20BaseResSec.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting30Deploy.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting40RewardDeploy.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting50RewardFob.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting60DbPfLang.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MotherBaseWeaponSpecSetting.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua"
  YieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua"
  YieldFrame()

--tex messy, but lets user still use MbmCommonSetting/EquipDevelopConstSetting/EquipDevelopFlowSetting mods
--MbmCommonSetting
TppMotherBaseManagement.RegisterMissionBaseStaffTypes{missionId=30050,staffTypes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}}--tex to give proper stats/skills spread on MB invasion
--EquipDevelopConstSetting
TppMotherBaseManagement.RegCstDev{p00=900,p01=TppEquip.EQP_None,p02=TppMbDev.EQP_DEV_TYPE_Handgun,p03=0,p04=0,p05=65535,p06="cmmn_wp_none",p07="cmmn_wp_none",p08="/Assets/tpp/ui/texture/EquipIcon/ui_dev_dummy_alp",p09=TppMbDev.EQP_DEV_GROUP_WEAPON_010,p10="cmmn_wp_none",p30="cmmn_wp_none",p31=0,p32=0,p33=0,p34=0,p35=0,p36=0}
TppMotherBaseManagement.RegCstDev{p00=901,p01=TppEquip.EQP_None,p02=TppMbDev.EQP_DEV_TYPE_Assault,p03=0,p04=0,p05=65535,p06="cmmn_wp_none",p07="cmmn_wp_none",p08="/Assets/tpp/ui/texture/EquipIcon/ui_dev_dummy_alp",p09=TppMbDev.EQP_DEV_GROUP_WEAPON_010,p10="cmmn_wp_none",p30="cmmn_wp_none",p31=0,p32=0,p33=0,p34=0,p35=0,p36=0}
--EquipDevelopFlowSetting
--tex SYNC p50 to last EquipDevelopFlowSetting entry p50 +1, or to 0 - but that gives a 'Development requirements met' message each startup, even if item is developed.
TppMotherBaseManagement.RegFlwDev{p50=876,p51=0,p52=1,p53=0,p54=0,p55=0,p56=0,p57=0,p58="",p59=0,p60="",p61=0,p62=1,p63=0,p64=0,p65="",p66=0,p67="",p68=0,p69=0,p70=0,p71=0,p72=0,p73=0,p74=1}
TppMotherBaseManagement.RegFlwDev{p50=877,p51=0,p52=1,p53=0,p54=0,p55=0,p56=0,p57=0,p58="",p59=0,p60="",p61=0,p62=1,p63=0,p64=0,p65="",p66=0,p67="",p68=0,p69=0,p70=0,p71=0,p72=0,p73=0,p74=1}
--<
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end

InfMain.LoadLibraries()--tex 

InfLog.AddFlow"start2nd.lua done"--tex

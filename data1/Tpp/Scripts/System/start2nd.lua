-- DOBUILD: 1
local function yieldFrame()
  coroutine.yield()
end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"
yieldFrame()
local e=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
  dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"
end
yieldFrame()
dofile"/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2InitializeScript.lua"
yieldFrame()
if Script.LoadLibrary then
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting.lua"
  
  TppMotherBaseManagement.RegisterMissionBaseStaffTypes{missionId=30050,staffTypes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}}--tex
  
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting20BaseResSec.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting30Deploy.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting40RewardDeploy.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting50RewardFob.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting60DbPfLang.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MotherBaseWeaponSpecSetting.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua"
  yieldFrame()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua"
  yieldFrame()
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end

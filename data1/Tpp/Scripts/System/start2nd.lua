-- DOBUILD: 1
-- start2nd.lua
InfCore.Log("start2nd.lua start")--tex DEBUG

local dofile=InfCore.DoFile--tex allow external alternate
local LoadLibrary=InfCore.LoadLibrary --tex allow external alternate, was Script.LoadLibrary

local function YieldFrame()
  --InfCore.Log("start2nd.lua yeilding")--tex DEBUG
  coroutine.yield()
end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"
YieldFrame()
local subtitlesDaemon=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
  dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"
end
YieldFrame()
dofile"/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2InitializeScript.lua"
YieldFrame()
if Script.LoadLibrary then
  InfCore.LogFlow"Loading mother base settings"--tex
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting20BaseResSec.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting30Deploy.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting40RewardDeploy.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting50RewardFob.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting60DbPfLang.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/MotherBaseWeaponSpecSetting.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua"
  YieldFrame()
  LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua"
  YieldFrame()

  InfMainTpp.MBManagementSettings()--tex
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end

InfCore.PCallDebug(InfMain.LoadLibraries)--tex

InfCore.Log"start2nd.lua done"--tex

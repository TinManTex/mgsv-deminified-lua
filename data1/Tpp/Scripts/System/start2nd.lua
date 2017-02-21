-- DOBUILD: 1
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

  TppMotherBaseManagement.RegisterMissionBaseStaffTypes{missionId=30050,staffTypes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}}--tex

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
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end
--tex> modelInfo luas
if Script.LoadLibrary then

  local plpartsPacks={--tex SYNC: InfFova
    "plparts_avatar_man",
    "plparts_battledress",
    "plparts_ddf_battledress",
    "plparts_ddf_parasite",
    "plparts_ddf_venom",
    "plparts_ddm_battledress",
    "plparts_ddm_parasite",
    "plparts_ddm_venom",
    "plparts_dd_female",
    "plparts_dd_male",
    "plparts_gold",
    "plparts_gz_suit",
    "plparts_hospital",
    "plparts_leather",
    "plparts_mgs1",
    "plparts_naked",
    "plparts_ninja",
    "plparts_normal",
    "plparts_normal_scarf",
    "plparts_parasite",
    "plparts_raiden",
    "plparts_silver",
    "plparts_sneaking_suit",
    "plparts_venom",
  }

  local path="/Assets/tpp/pack/player/parts/"
  local suffix="_modelInfo"
  local extension=".lua"
  local sucess, err = pcall(function()
    for n,packName in ipairs(plpartsPacks) do
      Script.LoadLibrary(path..packName..suffix..extension)
    end
  end)
end--<

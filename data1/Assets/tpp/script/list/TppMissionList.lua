-- DOBUILD: 1
-- TppMissionList.lua
local this={}

--tex moved from local to this
this.locationPackTable={
  [TppDefine.LOCATION_ID.INIT]={"/Assets/tpptest/pack/location/empty/empty.fpk"},
  [TppDefine.LOCATION_ID.AFGH]={"/Assets/tpp/pack/location/afgh/afgh.fpk"},
  [TppDefine.LOCATION_ID.MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"},
  [TppDefine.LOCATION_ID.CYPR]={"/Assets/tpp/pack/location/cypr/cypr.fpk"},
  [TppDefine.LOCATION_ID.GNTN]={"/Assets/tpp/pack/location/gntn/gntn.fpk"},
  [TppDefine.LOCATION_ID.OMBS]={"/Assets/tpp/pack/location/ombs/ombs.fpk"},
  [TppDefine.LOCATION_ID.MTBS]={"/Assets/tpp/pack/location/mtbs/mtbs.fpk"},
  [TppDefine.LOCATION_ID.HLSP]={"/Assets/tpp/pack/location/hlsp/hlsp.fpk"},
  [TppDefine.LOCATION_ID.MBQF]={"/Assets/tpp/pack/location/mbqf/mbqf.fpk"},
  [TppDefine.LOCATION_ID.FLYK]={"/Assets/tpp/pack/location/flyk/flyk.fpk"},
  [TppDefine.LOCATION_ID.SAND_AFGH]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_afgh.fpk"},
  [TppDefine.LOCATION_ID.SAND_MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"},
  [TppDefine.LOCATION_ID.SAND_MTBS]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_mtbs.fpk"},
}

--tex moved from local to this
this.missionPackTable={}
this.missionPackTable[1]={"/Assets/tpp/pack/ui/gz/gz_pause_key_setting_data.fpk","/Assets/tpp/pack/mission2/init/init.fpk"}
this.missionPackTable[5]=function(missionCode)
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/init/title.fpk"
end
this.missionPackTable[10010]=function(missionCode)
  if TppPackList.IsMissionPackLabel"afterMissionClearMovie"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_SCRIPT)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10010/s10010_l02.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddLocationCommonScriptPack(missionCode)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10010/s10010_l01.fpk"
    TppHostage2.SetHostageType{gameObjectType="TppHostageUnique",hostageType="Ishmael"}
    if TppHostage2.SetHostageType then
      TppHostage2.SetHostageType{gameObjectType="TppHostage2",hostageType="MobCyprus"}
      TppHostage2.SetHostageType{gameObjectType="TppHostageUnique2",hostageType="MobCyprus"}
    end
    if TppHostage2.SetUniquePartsPath then
      local uniquePartsTable={
        awake_doctor="/Assets/tpp/parts/chara/dct/dct1_main0_def_v00.parts",
        dct_p21_010410_0000="/Assets/tpp/parts/chara/dct/dct0_main0_def_v00.parts",
        dct_p21_010410_0001="/Assets/tpp/parts/chara/dct/dct0_main0_def_v00.parts",
        awake_nurse="/Assets/tpp/parts/chara/nrs/nrs2_main0_def_v00.parts",
        nrs_p21_010360_0000="/Assets/tpp/parts/chara/nrs/nrs0_main0_def_v00.parts",
        nrs_p21_010410_0000="/Assets/tpp/parts/chara/nrs/nrs0_main0_def_v00.parts",
        nrs_p21_010410_0001="/Assets/tpp/parts/chara/nrs/nrs0_main0_def_v00.parts",
        nrs_p21_010410_0002="/Assets/tpp/parts/chara/nrs/nrs0_main0_def_v00.parts"
      }
      for locatorName,parts in pairs(uniquePartsTable)do
        TppHostage2.SetUniquePartsPath{gameObjectType="TppHostageUnique2",locatorName=locatorName,parts=parts}
      end
      local uniquePartsTableIshmael={ish_p21_010410_0000="/Assets/tpp/parts/chara/ish/ish0_main0_def_v00.parts"}
      for locatorName,parts in pairs(uniquePartsTableIshmael)do
        TppHostage2.SetUniquePartsPath{gameObjectType="TppHostage2",locatorName=locatorName,parts=parts}
      end
    end
    local faceTable={{636,0,0,1}}
    local bodyTable={
      --patients
      {300,1},
      {301,1},
      {302,1},
      {303,1},
      {304,1},
      {305,1},
      {306,1},
      {307,1},
      {308,1},
      {309,1},
      {310,1},
      {311,1},
      {312,1},
      {313,1},
      {314,1},
      {315,1},
      {316,1},
      {317,1},
      {318,1},
      {319,1},
      {320,1},
      {321,1},
      {322,1},
      {323,1},
      {324,1},
      {325,1},
      {326,1},
      {327,1},
      {328,1},
      {329,1},
      {330,1},
      {331,1},
      {332,1},
      {333,1},
      {334,1},
      --RETAILBUG body ids not defined?
      {337,1},
      {338,1},
      {339,1},
      --nurses
      {340,1},
      {341,1},
      {342,1},
      {343,1},
      {344,1},
      {345,1},
      {346,1},
      {347,1},
      --doctors
      {348,1},
      {349,1},
      --ishmael
      {380,1},
      {381,1}
    }
    TppEneFova.AddUniquePackage{type="hostage",face=faceTable,body=bodyTable}
  end
end
this.missionPackTable[10020]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  if TppPackList.IsMissionPackLabel"afterMissionClearMovie"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10020/s10020_area02.fpk"
  else
    TppPackList.AddLocationCommonMissionAreaPack(missionCode)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_MATERIAL)
    TppPackList.AddDefaultMissionAreaPack(missionCode)
    local bodyTable={{TppEnemyBodyId.oce0_main0_v00,1},{TppEnemyBodyId.oce0_main0_v01,1}}
    TppEneFova.AddUniquePackage{type="hostage",body=bodyTable}
    do
      local settings={{type="enemy",name="sol_enemyBase_0014",faceId=635,bodyId=273}}
      TppEneFova.AddUniqueSettingPackage(settings)
    end
  end
end
this.missionPackTable[10030]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.OCELOT)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MILLER)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  local body={{TppEnemyBodyId.oce0_main0_v00,1}}
  TppEneFova.AddUniquePackage{type="hostage",body=body}
end
this.missionPackTable[10033]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="hostage",name="hos_s10033_0000",faceId=602,bodyId=110}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10036]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="enemy",name="sol_vip_0000",faceId=600,bodyId=TppEnemyBodyId.svs0_unq_v010}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10040]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="enemy",name="sol_s10040_0000",faceId=603,bodyId=TppEnemyBodyId.svs0_unq_v040},
      {type="enemy",name="sol_s10040_0001",faceId=604,bodyId=TppEnemyBodyId.svs0_unq_v050},
      {type="enemy",name="sol_s10040_0002",faceId=605,bodyId=TppEnemyBodyId.svs0_unq_v060}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10041]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="enemy",name="sol_vip_field",faceId=637,bodyId=268},
      {type="enemy",name="sol_vip_village",faceId=638,bodyId=269},
      {type="enemy",name="sol_vip_enemyBase",faceId=639,bodyId=270}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10043]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_MATERIAL)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10044]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_WAV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local s={{606,1,1,0}}
    local p={{258,1},{TppEnemyBodyId.svs0_unq_v080,1}}
    if TppSoldierFace.OverwriteMissionFovaData~=nil then
      TppSoldierFace.OverwriteMissionFovaData{face=s,body=p}
    end
  end
end
this.missionPackTable[10052]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_WAV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="hostage",name="hos_target_0000",faceId=607,bodyId=200},
      {type="enemy",name="sol_s10052_transportVehicle_0000",faceId=608,bodyId=263}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10054]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_AMMUNITION)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_MATERIAL)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TANK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_WAV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_WAV_ROCKET)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="hostage",name="hos_s10054_0002",faceId="female",bodyId=113},
      {type="hostage",name="hos_s10054_0004",faceId="female",bodyId=113}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10070]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  if TppPackList.IsMissionPackLabel"beforeMotherBaseDemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.OCELOT)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MILLER)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HUEY)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10070/s10070_area04.fpk"
  elseif TppPackList.IsMissionPackLabel"beforeSahelanAttackDemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HUEY)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SAHELAN)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MANTIS)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10070/s10070_area03.fpk"
  elseif TppPackList.IsMissionPackLabel"afterSahelanTestDemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_MISSION_AREA)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_DECOY)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10070/s10070_area02.fpk"
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HUEY)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SKULLFACE)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TRUCK)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10070/s10070_area01.fpk"
  end
end
this.missionPackTable[10080]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  if TppPackList.IsMissionPackLabel"afterPumpStopDemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10080/s10080_area02.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10080/s10080_area01.fpk"
  end
end
this.missionPackTable[10086]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE_WOMAN)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="hostage",name="hos_mis_0000",faceId=610,bodyId=111},
      {type="hostage",name="hos_mis_0001",faceId=611,bodyId=111},
      {type="hostage",name="hos_mis_0002",faceId=612,bodyId=111},
      {type="hostage",name="hos_mis_0003",faceId="female",bodyId=113},
      {type="enemy",name="sol_interpreter",faceId=609,bodyId=255},
      {type="enemy",name="sol_interrogator",faceId=629,bodyId=TppEnemyBodyId.pfs0_unq_v155}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10082]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK_ITEMBOX)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10090]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK_HOOD)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_MACHINE_GUN)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10121]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="enemy",name="sol_pfCamp_vip_0001",faceId=617,bodyId=TppEnemyBodyId.pfa0_v00_b},
      {type="enemy",name="sol_pfCamp_vip_guard",faceId=618,bodyId=254}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10091]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.RAVEN)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.JACKAL)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK_CONTAINER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="hostage",name="hos_s10091_0001",faceId="dd",bodyId=176},
      {type="hostage",name="hos_s10091_0000",faceId="dd",bodyId=143}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10100]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_DECOY)
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local INVALID_FOVA_VALUE=EnemyFova.INVALID_FOVA_VALUE
    local settings={
      {type="enemy",name="sol_target_0000",faceId=616,bodyId=251},
      {type="hostage",name="hos_diamond_0000",faceId=INVALID_FOVA_VALUE,bodyId=130},
      {type="hostage",name="hos_diamond_0001",faceId=INVALID_FOVA_VALUE,bodyId=131},
      {type="hostage",name="hos_diamond_0002",faceId=INVALID_FOVA_VALUE,bodyId=132},
      {type="hostage",name="hos_diamond_0003",faceId=INVALID_FOVA_VALUE,bodyId=133},
      {type="hostage",name="hos_diamond_0004",faceId=INVALID_FOVA_VALUE,bodyId=134}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostageUnique",hostageType="MovingChild"}
end
this.missionPackTable[10110]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  if TppPackList.IsMissionPackLabel"AfterVolginDemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MANTIS)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.VOLGIN)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10110/s10110_area02.fpk"
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_MISSION_AREA)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.RAVEN)
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostageUnique",hostageType="Naedoko"}
  TppHostage2.SetUniquePartsPath{gameObjectType="TppHostageUnique",locatorName="TppHostage2GameObjectLocator",parts="/Assets/tpp/parts/chara/plh/plh3_main0_def_v00.parts"}
  TppHostage2.SetUniquePartsPath{gameObjectType="TppHostageUnique",locatorName="TppHostage2GameObjectLocator0000",parts="/Assets/tpp/parts/chara/plh/plh2_main0_def_v00.parts"}
  local p={"TppHostage2GameObjectLocator0001","TppHostage2GameObjectLocator0002","TppHostage2GameObjectLocator0003","TppHostage2GameObjectLocator0004","TppHostage2GameObjectLocator0005","TppHostage2GameObjectLocator0006","TppHostage2GameObjectLocator0007","TppHostage2GameObjectLocator0008","TppHostage2GameObjectLocator0009","TppHostage2GameObjectLocator0010"}
  for p,s in ipairs(p)do
    TppHostage2.SetUniquePartsPath{gameObjectType="TppHostageUnique",locatorName=s,parts="/Assets/tpp/parts/chara/plh/plh0_main0_def_v00.parts"}
  end
end
this.missionPackTable[10195]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={
      {type="enemy",name="sol_dealer",faceId=614,bodyId=250},
      {type="enemy",name="sol_vip",faceId=615,bodyId=256}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10115]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_DECOY)
  TppPackList.AddFOBLayoutPack(missionCode)
  do
    local settings={
      {type="hostage",name="hos_s10115_0000",faceId="dd",bodyId=143},
      {type="hostage",name="hos_s10115_0001",faceId="dd",bodyId=143},
      {type="hostage",name="hos_s10115_0002",faceId="dd",bodyId=143},
      {type="hostage",name="hos_s10115_0003",faceId="dd",bodyId=143},
      {type="hostage",name="hos_s10115_0004",faceId="dd",bodyId=143},
      {type="hostage",name="hos_s10115_0005",faceId="dd",bodyId=143}
    }
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10120]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CHILD_SOLDIER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.LIQUID)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE_WOMAN)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="hostage",name="hos_mis_woman",faceId="female",bodyId=113}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10085]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE_WOMAN)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local hostage1Settings={{type="hostage",name="hos_target_0000",faceId=642,bodyId=111}}
    local hostage2Settings={{type="hostage",name="hos_target_0001",faceId=643,bodyId=113}}
    TppEneFova.AddUniqueSettingPackage(hostage1Settings)
    TppEneFova.AddUniqueSettingPackage(hostage2Settings)
  end
end
this.missionPackTable[10211]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="enemy",name="sol_mis_0000",faceId=620,bodyId=253}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10200]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CHILD_SOLDIER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local p="sol_hillNorth_0004"
    local settings={{type="hostage",name="hos_hillNorth_0000",faceId=619,bodyId=201}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10081]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TRUCK_ITEMBOX)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="hostage",name="hos_spy",faceId="dd",bodyId=201}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10130]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CODETALKER)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.RED))
  if TppPackList.IsMissionPackLabel"CamoParasiteAllKill"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10130/s10130_area02.fpk"
  elseif TppPackList.IsMissionPackLabel"CodeTalkerClearDemo"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10130/s10130_area03.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
end
this.missionPackTable[10140]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  if TppPackList.IsMissionPackLabel"MBdemo"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MILLER)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HUEY)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.OCELOT)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10140/s10140_area01.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30050/f30050_Buddy.fpk"
  elseif TppPackList.IsMissionPackLabel"AfterClear"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.OCELOT)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CODETALKER)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10140/s10140_area00.fpk"
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CODETALKER)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
end
this.missionPackTable[10150]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.XOF_SOLDIER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  if TppPackList.IsMissionPackLabel"SkullFaceAppearance"then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SKULLFACE)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10150/s10150_area02.fpk"
  elseif TppPackList.IsMissionPackLabel"StartingSahelan"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10150/s10150_area03.fpk"
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MANTIS)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10150/s10150_area01.fpk"
  end
end
this.missionPackTable[10151]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  if TppPackList.IsMissionPackLabel"OkbEnding"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10151/s10151_area02.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10151/s10151_area01.fpk"
  end
  local p={{375,1},{376,1}}
  TppEneFova.AddUniquePackage{type="hostage",body=p}
end
this.missionPackTable[10045]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WALKERGEAR)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local p="sol_executioner_0000"
    local settings={{type="hostage",name="hos_vip_0000",faceId=644,bodyId=271}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10156]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.RAVEN)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10093]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_LV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  do
    local settings={{type="enemy",name="sol_vip_0000",faceId=649,bodyId=272}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10171]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_MACHINE_GUN)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.WEST_TANK)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  do
    local settings={{type="enemy",name="sol_pfCamp_vip",faceId=645,bodyId=267}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[10230]=function(missionCode)
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10240]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  if TppPackList.IsMissionPackLabel"InQuarantineFacility"then
    TppSoldier2.DisableMarkerModelEffect()
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10240/s10240_area02.fpk"
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10240/s10240_area.fpk"
  end
end
this.missionPackTable[10050]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.QUIET)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.RAVEN)
  if TppPackList.IsMissionPackLabel"MotherBaseDemo"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s10050/s10050_area01.fpk"
  else
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
end
this.missionPackTable[10260]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ENEMY_HELI)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TANK)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_WAV)
  TppPackList.AddMissionPack(TppHelicopter.GetEnemyColoringPack(TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK))
  TppPackList.AddDefaultMissionAreaPack(missionCode)
end
this.missionPackTable[10280]=this.missionPackTable[10010]
this.missionPackTable[11043]=this.missionPackTable[10043]
this.missionPackTable[11041]=this.missionPackTable[10041]
this.missionPackTable[11054]=this.missionPackTable[10054]
this.missionPackTable[11085]=this.missionPackTable[10085]
this.missionPackTable[11082]=this.missionPackTable[10082]
this.missionPackTable[11090]=this.missionPackTable[10090]
this.missionPackTable[11036]=this.missionPackTable[10036]
this.missionPackTable[11033]=this.missionPackTable[10033]
this.missionPackTable[11050]=this.missionPackTable[10050]
this.missionPackTable[11091]=this.missionPackTable[10091]
this.missionPackTable[11195]=this.missionPackTable[10195]
this.missionPackTable[11211]=this.missionPackTable[10211]
this.missionPackTable[11140]=this.missionPackTable[10140]
this.missionPackTable[11200]=this.missionPackTable[10200]
this.missionPackTable[11080]=this.missionPackTable[10080]
this.missionPackTable[11171]=this.missionPackTable[10171]
this.missionPackTable[11121]=this.missionPackTable[10121]
this.missionPackTable[11115]=this.missionPackTable[10115]
this.missionPackTable[11130]=this.missionPackTable[10130]
this.missionPackTable[11044]=this.missionPackTable[10044]
this.missionPackTable[11052]=this.missionPackTable[10052]
this.missionPackTable[11151]=this.missionPackTable[10151]
this.missionPackTable[30010]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ORDER_BOX)
  if TppPackList.IsMissionPackLabel"recoverVolginDemo"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30010/f30011.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30010/f30010.fpk"
  end
end
this.missionPackTable[30020]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddLocationCommonMissionAreaPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ORDER_BOX)
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30020/f30020.fpk"
end
this.missionPackTable[30050]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_MISSION_AREA)

  if Ivars.mbZombies:Is(1)then--tex>
    TppSoldierFace.SetUseZombieFova{enabled=true}
  end--<

  do
    if TppPackList.IsMissionPackLabel"AfterDemo"or TppPackList.IsMissionPackLabel"BattleHanger"or TppPackList.IsMissionPackLabel"Interior"then--tex added Interior check
      TppDemo.SetNextMBDemo(nil)
    else
      if not TppPackList.IsMissionPackLabel"USE_USER_SETTING"and TppDemo.CanUpdateMBDemo()then
        TppDemo.UpdateMBDemo()
        local mbDemoName=TppDemo.GetMBDemoName()
        if TppDemo.IsQuestStart()and(not TppDemo.IsSortieMBDemo(mbDemoName))then
          TppDemo.SetNextMBDemo(nil)
        end
      end
    end
    local isUseMBDemoStage=TppDemo.IsUseMBDemoStage(TppDemo.GetMBDemoName())
    if TppPackList.IsMissionPackLabel"DemoStage"then
      isUseMBDemoStage=true
      TppDemo.SetNextMBDemo(nil)
    end
    --tex INTERIOR>
    if TppPackList.IsMissionPackLabel"Interior" then
      InfInterior.AddInteriorMissionPacks(missionCode)    
      gvars.f30050_missionPackIndex=3--tex f30050_sequence STAGE_PACK_INDEX.INTERIOR
    --<
    elseif TppPackList.IsMissionPackLabel"BattleHanger"or TppDemo.IsBattleHangerDemo(TppDemo.GetMBDemoName())then  
      local battleHangarPackPath=string.format("/Assets/tpp/pack/mission2/free/f30050/f30050_hanger_btg%.2d.fpk",TppStory.GetBattleGearDevelopLevel())
      TppPackList.AddMissionPack(battleHangarPackPath)
      do
        local bodyId=378
        if TppStory.HueyHasKantokuGrass()then
          bodyId=379
        end
        local settings={{type="hostage",name="TppHuey2GameObjectLocator",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=bodyId}}
        TppEneFova.AddUniqueSettingPackage(settings)
      end
      gvars.f30050_missionPackIndex=2
    elseif isUseMBDemoStage then
      TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30050/f30051.fpk"
      TppPackList.SetMissionPackLabelName"DemoStage"
      gvars.f30050_missionPackIndex=1
    else
      do
        TppEneFova.AddUniquePackage{type="hostage",body={{371,1}}}
      end
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
      TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30050/f30050.fpk"
      TppPackList.AddFOBLayoutPack(missionCode)
      gvars.f30050_missionPackIndex=0
    end
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostageUnique",hostageType="Paz"}
end
this.missionPackTable[30150]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30150/f30150.fpk"
end
this.missionPackTable[30250]=function(missionCode)
  TppPackList.AddLocationCommonScriptPack(missionCode)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30250/f30250.fpk"
  if TppHostage2.SetHostageType then
    TppHostage2.SetHostageType{gameObjectType="TppHostageUnique",hostageType="Volgin"}
    TppHostage2.SetHostageType{gameObjectType="TppHostage2",hostageType="Parasite"}
  end
  if TppHostage2.SetUniquePartsPath then
    local uniquePartsPath={
      hos_wmu00_0000="/Assets/tpp/parts/chara/wmu/wmu0_main0_def_v00.parts",
      hos_wmu00_0001="/Assets/tpp/parts/chara/wmu/wmu0_main0_def_v00.parts",
      hos_wmu01_0000="/Assets/tpp/parts/chara/wmu/wmu1_main0_def_v00.parts",
      hos_wmu01_0001="/Assets/tpp/parts/chara/wmu/wmu1_main0_def_v00.parts",
      hos_wmu03_0000="/Assets/tpp/parts/chara/wmu/wmu3_main0_def_v00.parts",
      hos_wmu03_0001="/Assets/tpp/parts/chara/wmu/wmu3_main0_def_v00.parts"
    }
    for locatorName,parts in pairs(uniquePartsPath)do
      TppHostage2.SetUniquePartsPath{gameObjectType="TppHostage2",locatorName=locatorName,parts=parts}
    end
  end

  if Ivars.mbZombies:Is(1)then--tex>
    TppSoldierFace.SetUseZombieFova{enabled=true}
  end--<
end
this.missionPackTable[40010]=function(missionCode)
  if gvars.ini_isTitleMode then
    TppPackList.SetDefaultMissionPackLabelName()
  end
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_common_script.fpk"
  if TppPackList.IsMissionPackLabel"PS3Store"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/helispace_ps3store.fpk"
  elseif TppPackList.IsMissionPackLabel"avatarEdit"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddAvatarEditPack()
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/h40010/h40010_avatar.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_ui.fpk"
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddLocationCommonScriptPack(missionCode)
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostage2",hostageType="Mob"}
end
this.missionPackTable[40020]=function(missionCode)
  if gvars.ini_isTitleMode then
    TppPackList.SetDefaultMissionPackLabelName()
  end
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_common_script.fpk"
  if TppPackList.IsMissionPackLabel"PS3Store"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/helispace_ps3store.fpk"
  elseif TppPackList.IsMissionPackLabel"avatarEdit"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddAvatarEditPack()
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/h40020/h40020_avatar.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_ui.fpk"
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddLocationCommonScriptPack(missionCode)
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostage2",hostageType="Mob"}
end
this.missionPackTable[40050]=function(missionCode)
  if gvars.ini_isTitleMode then
    TppPackList.SetDefaultMissionPackLabelName()
  end
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_common_script.fpk"
  if TppPackList.IsMissionPackLabel"PS3Store"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/helispace_ps3store.fpk"
  elseif TppPackList.IsMissionPackLabel"avatarEdit"then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddAvatarEditPack()
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/h40050/h40050_avatar.fpk"
  else
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/title_sequence.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/heli/heli_ui.fpk"
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddLocationCommonScriptPack(missionCode)
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
  TppHostage2.SetHostageType{gameObjectType="TppHostage2",hostageType="Mob"}
end
this.missionPackTable[65020]={"/Assets/tpp/pack/show/e3_2014/s65020/s65020_area.fpk","/Assets/tpp/pack/location/afgh/pack_common/afgh_script.fpk"}
this.missionPackTable[65030]={"/Assets/tpp/pack/show/e3_2014/s65030/s65030_area.fpk"}
this.missionPackTable[65050]={"/Assets/tpp/pack/show/e3_2014/s65050/s65050_area.fpk"}
this.missionPackTable[65414]={"/Assets/tpp/pack/show/gc_2014/s65414/s65414_area.fpk"}
this.missionPackTable[65060]=function(missionCode)
  TppPackList.AddMissionPack"/Assets/tpp/pack/show/tgs_2014/s65060/s65060_area.fpk"
  TppPackList.AddLocationCommonScriptPack(missionCode)
  do
    local settings={{type="hostage",name="hos_s65060_0000",faceId=621,bodyId=111}}
    TppEneFova.AddUniqueSettingPackage(settings)
  end
end
this.missionPackTable[65415]={"/Assets/tpp/pack/show/tgs_2014/s65415/s65415_area.fpk"}
this.missionPackTable[65416]={"/Assets/tpp/pack/show/tgs_2014/s65416/s65416_area.fpk"}
this.missionPackTable[50050]=function(missionCode)
  local ddSuit=TppEnemy.GetDDSuit()
  --RETAILPATCH 1.0.11>
  if TppMotherBaseManagement.GetMbsClusterSecurityIsEquipSwimSuit()then
    local swimsuitInfo=TppMotherBaseManagement.GetMbsClusterSecuritySwimSuitInfo()
    local packPath
    if swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_1 then
      packPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT
    elseif swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_2 then
      packPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT2
    elseif swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_3 then
      packPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT3
    end
    TppPackList.AddMissionPack(packPath)
    --<
  elseif ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING)
  elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS)
  elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR)
  else
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER)
  end
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
  TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_DECOY)
  if TppEnemy.IsHostageEventFOB()then
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.FOB_HOSTAGE)
    do
      local settings={
        {type="hostage",name="hos_o50050_event5_0000",faceId=621,bodyId=143},
        {type="hostage",name="hos_o50050_event5_0001",faceId=640,bodyId=143},
        {type="hostage",name="hos_o50050_event5_0002",faceId=641,bodyId=143},
        {type="hostage",name="hos_o50050_event5_0003",faceId=646,bodyId=143}
      }
      TppEneFova.AddUniqueSettingPackage(settings)
    end
  end
  if TppEnemy.IsZombieEventFOB()then--RETAILPATCH: 1070>
    TppSoldierFace.SetUseZombieFova{enabled=true}
  end
  if TppEnemy.IsParasiteMetalEventFOB()then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/online/o50050/o50055_parasite_metal.fpk"
  end--<
  TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/online/o50050/o50050_additional.fpk"
  TppPackList.AddLocationCommonScriptPack(missionCode)--RETAILPATCH: 1070>
  if TppEnemy.IsSpecialEventFOB()then
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/online/o50050/o50055_area.fpk"
  else--<
    TppPackList.AddDefaultMissionAreaPack(missionCode)
  end
  TppPackList.AddFOBLayoutPack(missionCode)
end
--CALLER: engine during Mission.LoadMission, set via SetLocationPackagePathFunc -v-
function this.GetLocationPackagePath(locationId)
  InfCore.LogFlow("TppMissionList.GetLocationPackagePath "..locationId)--tex
  local packPath=this.locationPackTable[locationId]
  if packPath then
  end
  TppLocation.SetBuddyBlock(locationId)
  InfCore.PrintInspect(packPath,"locationPackPaths")--tex DEBUG
  return packPath
end
--CALLER: engine during Mission.LoadMission, set via SetMissionPackagePathFunc -v-
function this.GetMissionPackagePath(missionCode)
  InfCore.LogFlow("TppMissionList.GetMissionPackagePath "..missionCode)--tex
  TppPackList.SetUseDdEmblemFova(missionCode)
  local packPaths
  if this.missionPackTable[missionCode]==nil then
    packPaths=TppPackList.MakeMissionPackList(missionCode,TppPackList.MakeDefaultMissionPackList)
  elseif Tpp.IsTypeFunc(this.missionPackTable[missionCode])then
    packPaths=TppPackList.MakeMissionPackList(missionCode,this.missionPackTable[missionCode])
  elseif Tpp.IsTypeTable(this.missionPackTable[missionCode])then
    packPaths=this.missionPackTable[missionCode]
  end
  InfCore.PCallDebug(InfMain.AddMissionPacks,missionCode,packPaths)--tex DEBUGNOW
  InfCore.PrintInspect(packPaths,"missionPackPaths")--tex DEBUG
  return packPaths
end
--EXEC
if Mission.SetLocationPackagePathFunc then
  Mission.SetLocationPackagePathFunc(this.GetLocationPackagePath)
end
if Mission.SetMissionPackagePathFunc then
  Mission.SetMissionPackagePathFunc(this.GetMissionPackagePath)
end
function this.IsStartHeliToMB()
end
return this

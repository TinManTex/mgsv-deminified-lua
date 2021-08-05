-- DOBUILD: 1
--tex REWORKED
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
--tex the state of the antiairradar gimmicks controls whether the assaultLz is available
this.aacrGimmickInfo={--tex was local
  cliffTown_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/cliffTown/afgh_cliffTown_gimmick.fox2"},
  commFacility_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/commFacility/afgh_commFacility_asset.fox2"},
  enemyBase_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/enemyBase/afgh_enemyBase_gimmick.fox2"},
  field_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/field/afgh_field_gimmick.fox2"},
  fort_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0002|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/fort/afgh_fort_asset.fox2"},
  powerPlant_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/powerPlant/afgh_powerPlant_gimmick.fox2"},
  remnants_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_gimmick.fox2"},
  slopedTown_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/slopedTown/afgh_slopedTown_gimmick.fox2"},
  sovietBase_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/sovietBase/afgh_sovietBase_asset.fox2"},
  tent_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0001|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/afgh/block_large/tent/afgh_tent_asset.fox2"},
  banana_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/banana/mafr_banana_asset.fox2"},
  diamond_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/diamond/mafr_diamond_gimmick.fox2"},
  flowStation_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/flowStation/mafr_flowStation_gimmick.fox2"},
  hill_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/hill/mafr_hill_gimmick.fox2"},
  pfCamp_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/pfCamp/mafr_pfCamp_gimmick.fox2"},
  savannah_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/savannah/mafr_savannah_gimmick.fox2"},
  swamp_aacr001={type=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,locatorName="afgh_antn006_gim_n0000|srt_afgh_antn006",dataSetName="/Assets/tpp/level/location/mafr/block_large/swamp/mafr_swamp_gimmick.fox2"}
}
--tex as nasanhak points out some of these var names are misleading
--aprLandingZoneName is the lz name (TppLandingZoneData entity name), which uses approach route by default,
--drpLandingZoneName is the drop route (fancy route from mission start) for the same lz
--mbdvs_map_mission_parameter also referenced the drpLandingZoneName

--routes seem to be named consistently enough so you can derive them from lz name
--ex: lz_cliffTown_I0000|lz_cliffTown_I_0000
--drop tag is drp - route name is lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000
--approach tag is arp - route name is lz_commFacility_S0000|rt_apr_commFacility_S_0000 (note first section isn't tagged, only last, where drop has both tagged)
--return tag is rtn - route name is lz_commFacility_S0000|rt_rtn_commFacility_S_0000 (as above)
--reference to approach and return can be seen in TppLandingZoneData entity in <mission id>_heli.fox2s

--ConnectLandingZoneTable keys via aa radar gimmick name to its lz, aka 'assaultLz'
--MissionLandingZoneTable are the rest of the non assault lzs, along with missionList for allowing lz for mission
local afghLZTable={}
afghLZTable.ConnectLandingZoneTable={
  cliffTown_aacr001={aprLandingZoneName={"lz_cliffTown_I0000|lz_cliffTown_I_0000"},drpLandingZoneName={"lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000"}},
  commFacility_aacr001={aprLandingZoneName={"lz_commFacility_I0000|lz_commFacility_I_0000"},drpLandingZoneName={"lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000"}},
  enemyBase_aacr001={aprLandingZoneName={"lz_enemyBase_I0000|lz_enemyBase_I_0000"},drpLandingZoneName={"lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000"}},
  field_aacr001={aprLandingZoneName={"lz_field_I0000|lz_field_I_0000"},drpLandingZoneName={"lz_drp_field_I0000|rt_drp_field_I_0000"}},
  fort_aacr001={aprLandingZoneName={"lz_fort_I0000|lz_fort_I_0000"},drpLandingZoneName={"lz_drp_fort_I0000|rt_drp_fort_I_0000"}},
  powerPlant_aacr001={aprLandingZoneName={"lz_powerPlant_E0000|lz_powerPlant_E_0000"},drpLandingZoneName={"lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000"}},
  remnants_aacr001={aprLandingZoneName={"lz_remnants_I0000|lz_remnants_I_0000"},drpLandingZoneName={"lz_drp_remnants_I0000|rt_drp_remnants_I_0000"}},
  slopedTown_aacr001={aprLandingZoneName={"lz_slopedTown_I0000|lz_slopedTown_I_0000"},drpLandingZoneName={"lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000"}},
  sovietBase_aacr001={aprLandingZoneName={"lz_sovietBase_E0000|lz_sovietBase_E_0000"},drpLandingZoneName={"lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000"}},
  tent_aacr001={aprLandingZoneName={"lz_tent_I0000|lz_tent_I_0000"},drpLandingZoneName={"lz_drp_tent_I0000|rt_drp_tent_I_0000"}}
}
afghLZTable.MissionLandingZoneTable={
  {aprLandingZoneName="lz_bridge_S0000|lz_bridge_S_0000",drpLandingZoneName="lz_drp_bridge_S0000|rt_drp_bridge_S_0000",missionList={10040}},
  {aprLandingZoneName="lz_citadelSouth_S0000|lz_citadelSouth_S_0000",drpLandingZoneName="lz_drp_citadelSouth_S0000|rt_drp_citadelSouth_S_0000",missionList={10045}},
  {aprLandingZoneName="lz_cliffTown_N0000|lz_cliffTown_N_0000",drpLandingZoneName="lz_drp_cliffTown_N0000|rt_drp_clifftown_N_0000",missionList={10044}},
  {aprLandingZoneName="lz_cliffTown_S0000|lz_cliffTown_S_0000",drpLandingZoneName="lz_drp_cliffTown_S0000|rt_drp_cliffTown_S_0000",missionList={10044}},
  {aprLandingZoneName="lz_cliffTownWest_S0000|lz_clifftownWest_S_0000",drpLandingZoneName="lz_drp_cliffTownWest_S0000|rt_drp_cliffTownWest_S_0000",missionList={10044}},
  {aprLandingZoneName="lz_commFacility_N0000|lz_commFacility_N_0000",drpLandingZoneName="lz_drp_commFacility_N0000|rt_drp_commFacility_N_0000",missionList={10043}},
  {aprLandingZoneName="lz_commFacility_S0000|lz_commFacility_S_0000",drpLandingZoneName="lz_drp_commFacility_S0000|rt_drp_commFacility_S_0000",missionList={10020,10043}},
  {aprLandingZoneName="lz_commFacility_W0000|lz_commFacility_W_0000",drpLandingZoneName="lz_drp_commFacility_W0000|rt_drp_commFacility_W_0000",missionList={10020,10041,10043}},
  {aprLandingZoneName="lz_enemyBase_N0000|lz_enemyBase_N_0000",drpLandingZoneName="lz_drp_enemyBase_N0000|rt_drp_enemyBase_N_0000",missionList={10020,10033,10041}},
  {aprLandingZoneName="lz_enemyBase_S0000|lz_enemyBase_S_0000",drpLandingZoneName="lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000",missionList={10020,10033,10041,10054}},
  {aprLandingZoneName="lz_field_N0000|lz_field_N_0000",drpLandingZoneName="lz_drp_field_N0000|rt_drp_field_N_0000",missionList={10036,10041,10045}},
  {aprLandingZoneName="lz_field_W0000|lz_field_W_0000",drpLandingZoneName="lz_drp_field_W0000|rt_drp_field_W_0000",missionList={10036,10041}},
  {aprLandingZoneName="lz_fieldWest_S0000|lz_fieldWest_S_0000",drpLandingZoneName="lz_drp_fieldWest_S0000|rt_drp_fiieldWest_S_0000",missionList={10036}},
  {aprLandingZoneName="lz_fort_E0000|lz_fort_E_0000",drpLandingZoneName="lz_drp_fort_E0000|rt_drp_fort_E_0000",missionList={10040}},
  {aprLandingZoneName="lz_fort_W0000|lz_fort_W_0000",drpLandingZoneName="lz_drp_fort_W0000|rt_drp_fort_W_0000",missionList={10040,10044}},
  {aprLandingZoneName="lz_powerPlant_S0000|lz_powerPlant_S_0000",drpLandingZoneName="lz_drp_powerPlant_S0000|rt_drp_powerPlant_S_0000",missionList={10080}},
  {aprLandingZoneName="lz_remnants_S0000|lz_remnants_S_0000",drpLandingZoneName="lz_drp_remnants_S0000|rt_drp_remnants_S_0000",missionList={10045,10052}},
  {aprLandingZoneName="lz_remnantsNorth_N0000|lz_remnantsNorth_N_0000",drpLandingZoneName="lz_drp_remnantsNorth_N0000|rt_drp_remnantsNorth_N_0000",missionList={10045,10052,10054}},
  {aprLandingZoneName="lz_remnantsNorth_S0000|lz_remnantsNorth_S_0000",drpLandingZoneName="lz_drp_remnantsNorth_S0000|rt_drp_remnantsNorth_S_0000",missionList={10052}},
  {aprLandingZoneName="lz_ruins_S0000|lz_ruins_S_0000",drpLandingZoneName="lz_drp_ruins_S0000|rt_drp_ruins_S_0000",missionList={10041,10156}},
  {aprLandingZoneName="lz_ruinsNorth_S0000|lz_ruinsNorth_S_0000",drpLandingZoneName="lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",missionList={10020,10041,10043,10156}},
  {aprLandingZoneName="lz_slopedTown_E0000|lz_slopedTown_E_0000",drpLandingZoneName="lz_drp_slopedTown_E0000|rt_drp_slopedTown_E_0000",missionList={10020,10041}},
  {aprLandingZoneName="lz_slopedTown_W0000|lz_slopedTown_W_0000",drpLandingZoneName="lz_drp_slopedTown_W0000|rt_drp_slopedTown_W_0000",missionList={10020,10041}},
  {aprLandingZoneName="lz_slopedTownEast_E0000|lz_slopedTownEast_E_0000",drpLandingZoneName="lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000",missionList={10040}},
  {aprLandingZoneName="lz_sovietBase_N0000|lz_sovietBase_N_0000",drpLandingZoneName="lz_drp_sovietBase_N0000|rt_drp_sovietBase_N_0000",missionList={10080}},
  {aprLandingZoneName="lz_sovietBase_S0000|lz_sovietBase_S_0000",drpLandingZoneName="lz_drp_sovietBase_S0000|rt_drp_sovietBase_S_0000",missionList={10080}},
  {aprLandingZoneName="lz_sovietSouth_S0000|lz_sovietSouth_S_0000",drpLandingZoneName="lz_drp_sovietSouth_S0000|rt_drp_sovietSouth_S_0000",missionList={10080}},
  {aprLandingZoneName="lz_tent_E0000|lz_tent_E_0000",drpLandingZoneName="lz_drp_tent_E0000|rt_drp_tent_E_0000",missionList={10052,10054}},
  {aprLandingZoneName="lz_tent_N0000|lz_tent_N_0000",drpLandingZoneName="lz_drp_tent_N0000|rt_drp_tent_N_0000",missionList={10052}},
  {aprLandingZoneName="lz_village_N0000|lz_village_N_0000",drpLandingZoneName="lz_drp_village_N0000|rt_drp_village_N_0000",missionList={10041,10043}},
  {aprLandingZoneName="lz_village_W0000|lz_village_W_0000",drpLandingZoneName="lz_drp_village_W0000|rt_drp_village_W_0000",missionList={10020,10041,10043}},
  {aprLandingZoneName="lz_waterway_I0000|lz_waterway_I_0000",drpLandingZoneName="lz_drp_waterway_I0000|rt_drp_waterway_I_0000",missionList={10050}},
}

local mafrLZTable={}
mafrLZTable.ConnectLandingZoneTable={
  banana_aacr001={aprLandingZoneName={"lz_banana_I0000|lz_banana_I_0000"},drpLandingZoneName={"lz_drp_banana_I0000|rt_drp_banana_I_0000"}},
  diamond_aacr001={aprLandingZoneName={"lz_diamond_I0000|lz_diamond_I_0000"},drpLandingZoneName={"lz_drp_diamond_I0000|rt_drp_diamond_I_0000"}},
  flowStation_aacr001={aprLandingZoneName={"lz_flowStation_I0000|lz_flowStation_I_0000"},drpLandingZoneName={"lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000"}},
  hill_aacr001={aprLandingZoneName={"lz_hill_I0000|lz_hill_I_0000"},drpLandingZoneName={"lz_drp_hill_I0000|rt_drp_hill_I_0000"}},
  pfCamp_aacr001={aprLandingZoneName={"lz_pfCamp_I0000|lz_pfCamp_I_0000"},drpLandingZoneName={"lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000"}},
  savannah_aacr001={aprLandingZoneName={"lz_savannah_I0000|lz_savannah_I_0000"},drpLandingZoneName={"lz_drp_savannah_I0000|rt_drp_savannah_I_0000"}},
  swamp_aacr001={aprLandingZoneName={"lz_swamp_I0000|lz_swamp_I_0000"},drpLandingZoneName={"lz_drp_swamp_I0000|rt_drp_swamp_I_0000"}}
}
mafrLZTable.MissionLandingZoneTable={
  {aprLandingZoneName="lz_bananaSouth_N0000|lz_bananaSouth_N",drpLandingZoneName="lz_drp_bananaSouth_N0000|rt_drp_bananaSouth_N_0000",missionList={10211}},
  {aprLandingZoneName="lz_diamond_N0000|lz_diamond_N_0000",drpLandingZoneName="lz_drp_diamond_N0000|rt_drp_diamond_N_0000",missionList={10100}},
  {aprLandingZoneName="lz_diamondSouth_S0000|lz_diamondSouth_S_0000",drpLandingZoneName="lz_drp_diamondSouth_S0000|lz_drp_diamondSouth_S_0000",missionList={10195}},
  {aprLandingZoneName="lz_diamondSouth_W0000|lz_diamondSouth_W_0000",drpLandingZoneName="lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000",missionList={10081}},
  {aprLandingZoneName="lz_diamondWest_S0000|lz_diamondWest_S_0000",drpLandingZoneName="lz_drp_diamondWest_S0000|lz_drp_diamondWest_S_0000",missionList={10081}},
  {aprLandingZoneName="lz_factory_N0000|lz_factory_N_0000",drpLandingZoneName="lz_drp_factory_N0000|rt_drp_factory_N_0000",missionList={10140}},
  {aprLandingZoneName="lz_factoryWest_S0000|lz_factoryWest_S_0000",drpLandingZoneName="lz_drp_factoryWest_S0000|lz_drp_factoryWest_S_0000",missionList={10085,10110}},
  {aprLandingZoneName="lz_flowStation_E0000|lz_flowStation_E_0000",drpLandingZoneName="lz_drp_flowStation_E0000|lz_drp_flowStation_E_0000",missionList={10080,10090,10091}},
  {aprLandingZoneName="lz_hill_E0000|lz_hill_E_0000",drpLandingZoneName="lz_drp_hill_E0000|lz_drp_hill_E_0000",missionList={10085,10110}},
  {aprLandingZoneName="lz_hill_N0000|lz_hill_N_0000",drpLandingZoneName="lz_drp_hill_N0000|lz_drp_hill_N_0000",missionList={10085,10110,10200}},
  {aprLandingZoneName="lz_hillNorth_N0000|lz_hillNorth_N_0000",drpLandingZoneName="lz_drp_hillNorth_N0000|rt_drp_hillNorth_N_0000",missionList={10200}},
  {aprLandingZoneName="lz_hillNorth_W0000|lz_hillNorth_W_0000",drpLandingZoneName="lz_drp_hillNorth_W0000|rt_drp_hillNorth_W_0000",missionList={10085}},
  {aprLandingZoneName="lz_hillSouth_W0000|lz_hillSouth_W_0000",drpLandingZoneName="lz_drp_hillSouth_W0000|lz_drp_hillSouth_W_0000",missionList={10121}},
  {aprLandingZoneName="lz_hillWest_S0000|lz_hillWest_S_0000",drpLandingZoneName="lz_drp_hillWest_S0000|lz_drp_hillWest_S_0000",missionList={10085,10110}},
  {aprLandingZoneName="lz_lab_S0000|lz_lab_S_0000",drpLandingZoneName="lz_drp_lab_S0000|rt_drp_lab_S_0000",missionList={10140}},
  {aprLandingZoneName="lz_lab_W0000|lz_lab_W_0000",drpLandingZoneName="lz_drp_lab_W0000|rt_drp_lab_W_0000",missionList={10140}},
  {aprLandingZoneName="lz_labWest_W0000|lz_labWest_W_0000",drpLandingZoneName="lz_drp_labWest_W0000|rt_drp_labWest_W_0000",missionList={10140}},
  {aprLandingZoneName="lz_outland_N0000|lz_outland_N_0000",drpLandingZoneName="lz_drp_outland_N0000|rt_drp_outland_N_0000",missionList={10080}},
  {aprLandingZoneName="lz_outland_S0000|lz_outland_S_0000",drpLandingZoneName="lz_drp_outland_S0000|rt_drp_outland_S_0000",missionList={10080}},
  {aprLandingZoneName="lz_pfCamp_N0000|lz_pfCamp_N_0000",drpLandingZoneName="lz_drp_pfCamp_N0000|rt_drp_pfcamp_N_0000",missionList={10090,10121,10171}},
  {aprLandingZoneName="lz_pfCamp_S0000|lz_pfCamp_S_0000",drpLandingZoneName="lz_drp_pfCamp_S0000|lz_drp_pfCamp_S_0000",missionList={10121}},
  {aprLandingZoneName="lz_pfCampNorth_S0000|lz_pfCampNorth_S_0000",drpLandingZoneName="lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000",missionList={10082,10090}},
  {aprLandingZoneName="lz_savannahEast_N0000|lz_savannahEast_N_0000",drpLandingZoneName="lz_drp_savannahEast_N0000|rt_drp_savannahEast_N_0000",missionList={10090,10195,10200,10211}},
  {aprLandingZoneName="lz_savannahEast_S0000|lz_savannahEast_S_0000",drpLandingZoneName="lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000",missionList={10082,10090,10171,10195,10211}},
  {aprLandingZoneName="lz_savannahWest_N0000|lz_savannahWest_N_0000",drpLandingZoneName="lz_drp_savannahWest_N0000|lz_drp_savannahWest_N_0000",missionList={10100,10211}},
  {aprLandingZoneName="lz_swamp_N0000|lz_swamp_N_0000",drpLandingZoneName="lz_drp_swamp_N0000|lz_drp_swamp_N_0000",missionList={10086,10091,10211}},
  {aprLandingZoneName="lz_swamp_S0000|lz_swamp_S_0000",drpLandingZoneName="lz_drp_swamp_S0000|rt_drp_swamp_S_0000",missionList={10086,10090,10211}},
  {aprLandingZoneName="lz_swamp_W0000|lz_swamp_W_0000",drpLandingZoneName="lz_drp_swamp_W0000|lz_drp_swamp_W_0000",missionList={10080,10086,10090,10091,10211}},
  {aprLandingZoneName="lz_swampEast_N0000|lz_swampEast_N_0000",drpLandingZoneName="lz_drp_swampEast_N0000|lz_drp_swampEast_N_0000",missionList={10082,10086,10091,10211}}
}

--TABLESETUP
--tex> drp/route to apr/lz used for IH features
--keyed by locationName={aprLzName=drpLzName,...},
this.assaultLzs={
  afgh={},
  mafr={},
}
this.missionLzs={
  afgh={},
  mafr={},
}
--tex replaces use of the seperate afghanistanLZTable/middleAfricaLZTable in vanilla functions
--ADDON: InfMission DEBUGNOW
this.locInfo={
  afgh={
    ConnectLandingZoneTable=afghLZTable.ConnectLandingZoneTable,
    MissionLandingZoneTable=afghLZTable.MissionLandingZoneTable
  },
  mafr={
    ConnectLandingZoneTable=mafrLZTable.ConnectLandingZoneTable,
    MissionLandingZoneTable=mafrLZTable.MissionLandingZoneTable
  },
}
function this.BuildConnectLzTable()
  InfCore.LogFlow("TppLandingZone.BuildConnectLzTable")
  for location,locationInfo in pairs(this.locInfo)do
    local assaultLocLzs=this.assaultLzs[location] or {}
    for aaName,lzInfo in pairs(locationInfo.ConnectLandingZoneTable) do
      assaultLocLzs[lzInfo.drpLandingZoneName[1]]=lzInfo.aprLandingZoneName[1]
    end
    this.assaultLzs[location]=assaultLocLzs
  end
  if this.debugModule then
    InfCore.PrintInspect(this.assaultLzs,"assaultLzs")
  end
end--BuildConnectLzTable
function this.BuildMissionLzTable()
  InfCore.LogFlow("TppLandingZone.BuildMissionLzTable")
  for location,locationInfo in pairs(this.locInfo)do
    local missionLocLzs=this.missionLzs[location] or {}
    for j=1,#locationInfo.MissionLandingZoneTable do
      local lzInfo=locationInfo.MissionLandingZoneTable[j]
      missionLocLzs[lzInfo.drpLandingZoneName]=lzInfo.aprLandingZoneName
    end
    this.missionLzs[location]=missionLocLzs
  end
  if this.debugModule then
    InfCore.PrintInspect(this.missionLzs,"missionLzs")
  end
end--BuildMissionLzTable
--EXEC
this.BuildConnectLzTable()
this.BuildMissionLzTable()
--<

function this.OnInitialize()
  local connectLZTable={}
  for location,lzTables in pairs(this.locInfo)do
    Tpp.MergeTable(connectLZTable,lzTables.ConnectLandingZoneTable)
  end--for locInfo
  TppGimmick.SetUpConnectLandingZoneTable(connectLZTable)
  mvars.ldz_assaultDropLandingZoneTable={}
  local drpLandingZones={}
  local aprLandingZones={}
  for aacrName,assaultLz in pairs(connectLZTable)do
    local drpLandingZone=assaultLz.drpLandingZoneName
    local aprLandingZone=assaultLz.aprLandingZoneName
    table.insert(drpLandingZones,drpLandingZone[1])
    table.insert(aprLandingZones,aprLandingZone[1])
  end
  if TppUiCommand.RegisterDangerLandPointTable~=nil then
    TppUiCommand.RegisterDangerLandPointTable(drpLandingZones)
  end
  if TppUiCommand.RegisterDangerLandingZoneTable~=nil then
    TppUiCommand.RegisterDangerLandingZoneTable(aprLandingZones)
  end
end
function this.OnMissionCanStart()
  --tex REWORKED
  local locationName=TppLocation.GetLocationName()
  if this.locInfo[locationName] or TppLocation.IsMotherBase()then
    local missionNumber,missionTypeCodeName=TppMission.ParseMissionName(TppMission.GetMissionName())
    if missionTypeCodeName=="heli"or missionTypeCodeName=="free"then
      TppUiCommand.ClearAllDisabledLandPoints()
      for locationName,lzTable in pairs(this.locInfo)do
        this.DisableLandingZoneForMission(lzTable.MissionLandingZoneTable,missionTypeCodeName)
      end
    end
    for locationName,lzTable in pairs(this.locInfo)do
      --tex broken out from seperate (but identical) afgh/mafrLzTable function
      for aacrName,connectLZTableForAacr in pairs(lzTable.ConnectLandingZoneTable)do
        if not this.IsBrokenGimmick(aacrName) then
          this.DisableAssaultLandingZones(connectLZTableForAacr,missionTypeCodeName)
        end
        this.RegisterAssaultDropLandingZone(connectLZTableForAacr.drpLandingZoneName)
      end  
    end
    if TppQuest.IsActive"waterway_q99010"then--PATCHUP:
      this.DisableAssaultLandingZones(this.locInfo.afgh.ConnectLandingZoneTable.sovietBase_aacr001,"heli")
      this.DisableAssaultLandingZones(this.locInfo.afgh.ConnectLandingZoneTable.powerPlant_aacr001,"heli")
    end
    InfQuest.DisableLandingZones()--tex
  end
end--OnMissionCanStart
--tex called in helispace or free mission to disable lzs if havent reached that mission yet
function this.DisableLandingZoneForMission(missionLZTable,missionTypeCodeName)
  local lzType
  local DisableFunc
  if missionTypeCodeName=="heli"then
    lzType="drpLandingZoneName"
    DisableFunc=TppUiCommand.AddDisabledLandPoint
  else
    lzType="aprLandingZoneName"
    DisableFunc=this.GroundDisableLandingZone
  end
  for i,lzInfo in ipairs(missionLZTable)do
    local doDisable=true
    if not lzInfo.missionList then
      doDisable=true
    else
      for j,missionCode in ipairs(lzInfo.missionList)do
        if TppStory.IsMissionOpen(missionCode)then
          doDisable=false
        end
      end
    end
    if doDisable then
      DisableFunc(lzInfo[lzType])
    end
  end
end--DisableLandingZoneForMission
--tex broken out from seperate (but identical) afgh/mafrLzTable function
function this.DisableAssaultLandingZones(connectLZTableForAacr,missionTypeCodeName)
  local lzType
  local DisableFunc
  if missionTypeCodeName=="heli"then
    lzType="drpLandingZoneName"
    DisableFunc=TppUiCommand.AddDisabledLandPoint
  else
    lzType="aprLandingZoneName"
    DisableFunc=this.GroundDisableLandingZone
  end
  local lzs=connectLZTableForAacr[lzType]--tex NMC DEBUGNOW don't know why this is list (since the just have one entry), or why its being iterated via pairs instead of ipairs
  if lzs then
    for n,lzName in pairs(lzs)do
      DisableFunc(lzName)
    end
  end
end--DisableAssaultLandingZones
--tex broken out from seperate (but identical) afgh/mafrLzTable function
function this.GroundDisableLandingZone(lzName)
  if TppHelicopter.GetLandingZoneExists{landingZoneName=lzName}then
    TppHelicopter.SetDisableLandingZone{landingZoneName=lzName}
  end
end
function this.DisableUnlockLandingZoneOnMission(bool)
  mvars.ldz_isDisableUnlockLandingZone=bool
end
function this.IsDisableUnlockLandingZoneOnMission()
  return mvars.ldz_isDisableUnlockLandingZone
end
function this.RegisterAssaultDropLandingZone(drpLandingZoneNames)
  for i,lzn in ipairs(drpLandingZoneNames)do
    local lzS32=StrCode32(lzn)
    mvars.ldz_assaultDropLandingZoneTable[lzS32]=true
  end
end
function this.IsAssaultDropLandingZone(heliRouteS32)
  if not mvars.ldz_assaultDropLandingZoneTable then
    return
  end
  local drpLz=mvars.ldz_assaultDropLandingZoneTable[heliRouteS32]
  return drpLz
end
--IsAACRGimmickBroken
function this.IsBrokenGimmick(gimmickId)
  local gimmickInfo=this.aacrGimmickInfo[gimmickId]
  if gimmickInfo==nil then
    return
  end
  return Gimmick.IsBrokenGimmick(gimmickInfo.type,gimmickInfo.locatorName,gimmickInfo.dataSetName)
end
function this.OverwriteBuddyVehiclePosForALZ()
  local posTable={
    cliffTown={
      [StrCode32"lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(784.236,435.562,-1237.65),TppMath.DegreeToRadian(-4.08)},
        [EntryBuddyType.BUDDY]={Vector3(783.114,435.136,-1246.231),-4.08}}},
    commFacility={
      [StrCode32"lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(1345.682,357.239,434.999),TppMath.DegreeToRadian(30.64)},
        [EntryBuddyType.BUDDY]={Vector3(1340.923,358.53,438.866),42.41}}},
    enemyBase={
      [StrCode32"lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-407.628,315.992,482.41),TppMath.DegreeToRadian(1.8)},
        [EntryBuddyType.BUDDY]={Vector3(-410.208,316.399,508.065),176.17}}},
    field={
      [StrCode32"lz_drp_field_I0000|rt_drp_field_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(368.004,278.145,2361.91),TppMath.DegreeToRadian(116.9)},
        [EntryBuddyType.BUDDY]={Vector3(367.974,279.287,2355.952),102.35}}},
    fort={
      [StrCode32"lz_drp_fort_I0000|rt_drp_fort_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(2041.735,479.324,-1594.738),TppMath.DegreeToRadian(140.63)},
        [EntryBuddyType.BUDDY]={Vector3(2044.589,478.915,-1588.505),151.95}}},
    powerPlant={
      [StrCode32"lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-830.87,511.191,-1243.93),TppMath.DegreeToRadian(-144.68)},
        [EntryBuddyType.BUDDY]={Vector3(-829.978,511.451,-1236.262),-150.97}}},
    remnants={
      [StrCode32"lz_drp_remnants_I0000|rt_drp_remnants_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-709.726,289.695,1735.643),TppMath.DegreeToRadian(-49.07)},
        [EntryBuddyType.BUDDY]={Vector3(-702.429,289.014,1740.65),-38.93}}},
    slopedTown={
      [StrCode32"lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(495.854,333.515,232.89),TppMath.DegreeToRadian(111.55)},
        [EntryBuddyType.BUDDY]={Vector3(496.236,334.679,237.834),108.72}}},
    sovietBase={
      [StrCode32"lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-2006.886,425.727,-1127.261),TppMath.DegreeToRadian(-5.26)},
        [EntryBuddyType.BUDDY]={Vector3(-2003.57,426.474,-1128.173),-5.26}}},
    tent={
      [StrCode32"lz_drp_tent_I0000|rt_drp_tent_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-1883.463,323.868,746.783),TppMath.DegreeToRadian(44.64)},
        [EntryBuddyType.BUDDY]={Vector3(-1873.108,323.846,736.65),35.82}}},
    banana={
      [StrCode32"lz_drp_banana_I0000|rt_drp_banana_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(394.645,60.24,-1318.929),TppMath.DegreeToRadian(-40.98)},
        [EntryBuddyType.BUDDY]={Vector3(390.86,59.935,-1321.727),-40.98}}},
    diamond={
      [StrCode32"lz_drp_diamond_I0000|rt_drp_diamond_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(1196.886,143.309,-1639.064),TppMath.DegreeToRadian(51.3)},
        [EntryBuddyType.BUDDY]={Vector3(1199.647,143.293,-1645.311),51.3}}},
    flowStation={
      [StrCode32"lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(-1090.728,-12.305,-45.368),TppMath.DegreeToRadian(-172.81)},
        [EntryBuddyType.BUDDY]={Vector3(-1083.825,-12.284,-44.864),-178.15}}},
    hill={
      [StrCode32"lz_drp_hill_I0000|rt_drp_hill_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(1962.906,44.372,356.735),TppMath.DegreeToRadian(83.13)},
        [EntryBuddyType.BUDDY]={Vector3(1961.012,43.662,364.622),83.13}}},
    pfCamp={
      [StrCode32"lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(659.712,-11.962,1016.94),TppMath.DegreeToRadian(93.6)},
        [EntryBuddyType.BUDDY]={Vector3(657.349,-11.296,1010.927),93.6}}},
    svannah={
      [StrCode32"lz_drp_savannah_I0000|rt_drp_savannah_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(1025.44,18.729,-295.689),TppMath.DegreeToRadian(-71.73)},
        [EntryBuddyType.BUDDY]={Vector3(1026.319,18.662,-302.596),-71.73}}},
    swamp={
      [StrCode32"lz_drp_swamp_I0000|rt_drp_swamp_I_0000"]={
        [EntryBuddyType.VEHICLE]={Vector3(6.412,-5.952,294.757),TppMath.DegreeToRadian(-153.76)},
        [EntryBuddyType.BUDDY]={Vector3(2.113,-5.436,299.302),-153.76}}}
  }
  for area,posForLz in pairs(posTable)do
    TppEnemy.NPCEntryPointSetting(posForLz)
  end
end

return this

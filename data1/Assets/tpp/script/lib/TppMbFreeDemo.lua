-- DOBUILD: 1
local this={}
--ORPHAN local StrCode32=Fox.StrCode32
--ORPHAN local StrCode32Table=Tpp.StrCode32Table
local telopStartOnDemoTime=2
local quietFpk="/Assets/tpp/pack/mission2/free/f30050/f30050_mbQuiet.fpk"
local buddyFpk="/Assets/tpp/pack/mission2/free/f30050/f30050_Buddy.fpk"
this.demoList={
  EntrustDdog="p51_010010",
  DdogComeToGet="p51_010020_000_final",
  DdogGoWithMe="p51_010030",
  LongTimeNoSee_DDSoldier="p51_010060_000_final",
  LongTimeNoSee_DdogPup="p51_010050_000_final",
  LongTimeNoSee_DdogLowLikability="p51_010053_000_final",
  LongTimeNoSee_DdogHighLikability="p51_010057_000_final",
  LongTimeNoSee_DdogSuperHighLikability="p51_010059_000_final",
  AttackedFromOtherPlayer_KnowWhereFrom="p51_010150_000_final",
  AttackedFromOtherPlayer_UnknowWhereFrom="p51_010150_001_final",
  MoraleOfMBIsLow="p51_010040_000_final",
  OcelotIsPupilOfSnake="p51_010350_000_final",
  HappyBirthDay="p51_010270_000",
  HappyBirthDayWithQuiet="p51_010270_001",
  QuietOnHeliInRain="p51_010300_000_final",
  QuietHasFriendshipWithChild="p51_010310_000",
  QuietWishGoMission="p51_010330_000_final",
  QuietReceivesPersecution="p51_010360_000",
  SnakeHasBadSmell_WithoutQuiet="p51_010160_000_final",
  SnakeHasBadSmell_000="p51_010165_000_final",
  SnakeHasBadSmell_001="p51_010165_001_final",
  EliLookSnake="p51_010220_000_final",
  LiquidAndChildSoldier="p51_010340_000_final",
  InterrogateQuiet="p51_010210",
  AnableDevBattleGear="p51_010140_000_final",
  DevelopedBattleGear1="p51_010145_001",
  DevelopedBattleGear2="p51_010145_002",
  DevelopedBattleGear4="p51_010145_004",
  DevelopedBattleGear5="p51_010145_005",
  CodeTalkerSunBath="p51_010170_000_final",
  ParasiticWormCarrierKill="p51_070010_000_final",
  GoToMotherBaseAfterQuietBattle="p31_030210",
  ArrivedMotherBaseAfterQuietBattle="p31_030220_000_final",
  ArrivedMotherBaseLiquid="p41_010050_000_final",
  ArrivedMotherBaseFromDeathFactory="p41_040200_000_final",
  ArrivedMotherBaseChildren="p41_020050_000_final",
  NuclearEliminationCeremony="p51_020010_000_final",
  DetailsNuclearDevelop="p51_020030_01movie",
  ForKeepNuclearElimination="p51_020020_000_final",
  SacrificeOfNuclearElimination="p51_020040_000_final",
  EndingSacrificeOfNuclear="p51_020030_02movie",
  TheGreatEscapeLiquid="p61_010030_000_final",
  VisitQuiet="p31_030020_001_final",
  DecisionHuey="p31_060030_000_final",
  PazPhantomPain1="p51_080010_000_final",
  PazPhantomPain2="p51_080020",
  PazPhantomPain4="p51_080040",
  PazPhantomPain4_jp="p51_080041",
  LiquidQuest="p51_010550_000_final"
}
this.demoBlockList={
  EntrustDdog={"/Assets/tpp/pack/mission2/free/f30050/f30050_d070.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  DdogComeToGet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d071.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  DdogGoWithMe={"/Assets/tpp/pack/mission2/free/f30050/f30050_d072.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  LongTimeNoSee_DDSoldier={"/Assets/tpp/pack/mission2/free/f30050/f30050_d001.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  LongTimeNoSee_DdogPup={"/Assets/tpp/pack/mission2/free/f30050/f30050_d073.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  LongTimeNoSee_DdogLowLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d074.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  LongTimeNoSee_DdogHighLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d075.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  LongTimeNoSee_DdogSuperHighLikability={"/Assets/tpp/pack/mission2/free/f30050/f30050_d076.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  AttackedFromOtherPlayer_KnowWhereFrom={"/Assets/tpp/pack/mission2/free/f30050/f30050_d010.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  AttackedFromOtherPlayer_UnknowWhereFrom={"/Assets/tpp/pack/mission2/free/f30050/f30050_d011.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  MoraleOfMBIsLow={"/Assets/tpp/pack/mission2/free/f30050/f30050_d000.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  OcelotIsPupilOfSnake={"/Assets/tpp/pack/mission2/free/f30050/f30050_d002.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  HappyBirthDay={"/Assets/tpp/pack/mission2/free/f30050/f30050_d030.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  HappyBirthDayWithQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d031.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  QuietOnHeliInRain={"/Assets/tpp/pack/mission2/free/f30050/f30050_d100.fpk"},
  QuietHasFriendshipWithChild={"/Assets/tpp/pack/mission2/free/f30050/f30050_d040.fpk"},
  QuietWishGoMission={"/Assets/tpp/pack/mission2/free/f30050/f30050_d050.fpk"},
  QuietReceivesPersecution={"/Assets/tpp/pack/mission2/free/f30050/f30050_d101.fpk"},
  SnakeHasBadSmell_WithoutQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d020.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  SnakeHasBadSmell_000={"/Assets/tpp/pack/mission2/free/f30050/f30050_d021.fpk"},
  SnakeHasBadSmell_001={"/Assets/tpp/pack/mission2/free/f30050/f30050_d022.fpk",quietFpk},
  EliLookSnake={"/Assets/tpp/pack/mission2/free/f30050/f30050_d080.fpk"},
  LiquidAndChildSoldier={"/Assets/tpp/pack/mission2/free/f30050/f30050_d060.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  InterrogateQuiet={"/Assets/tpp/pack/mission2/free/f30050/f30050_d090.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  AnableDevBattleGear={"/Assets/tpp/pack/mission2/free/f30050/f30050_d120.fpk"},
  CodeTalkerSunBath={"/Assets/tpp/pack/mission2/free/f30050/f30050_d110.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  ParasiticWormCarrierKill={"/Assets/tpp/pack/mission2/free/f30050/f30050_d700.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  GoToMotherBaseAfterQuietBattle={"/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk"},
  ArrivedMotherBaseAfterQuietBattle={"/Assets/tpp/pack/mission2/story/s10050/s10050_d02.fpk"},
  ArrivedMotherBaseLiquid={"/Assets/tpp/pack/mission2/story/s10120/s10120_d04.fpk"},
  ArrivedMotherBaseFromDeathFactory={"/Assets/tpp/pack/mission2/story/s10110/s10110_d03.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  ArrivedMotherBaseChildren={"/Assets/tpp/pack/mission2/story/s10100/s10100_d02.fpk"},
  NuclearEliminationCeremony={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1000.fpk"},
  DetailsNuclearDevelop={"/Assets/tpp/pack/mission2/free/f30050/f30050_m20030.fpk"},
  ForKeepNuclearElimination={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1010.fpk"},
  SacrificeOfNuclearElimination={"/Assets/tpp/pack/mission2/free/f30050/f30050_d1020.fpk"},
  EndingSacrificeOfNuclear={"/Assets/tpp/pack/mission2/free/f30050/f30050_m20031.fpk"},
  TheGreatEscapeLiquid={"/Assets/tpp/pack/mission2/free/f30050/f30050_d600.fpk"},
  DecisionHuey={"/Assets/tpp/pack/mission2/free/f30050/f30050_d300.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk"},
  PazPhantomPain1={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8010.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},
  PazPhantomPain2={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8020.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},
  PazPhantomPain3={"/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_dEmpty.fpk"},
  PazPhantomPain4={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8040.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},
  PazPhantomPain4_jp={"/Assets/tpp/pack/mission2/free/f30050/f30050_d8041.fpk","/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk"},
  Empty={"/Assets/tpp/pack/mission2/free/f30050/f30050_dEmpty.fpk"}
}
this._PazPhantomPain4Settings={
  OnEnter=function()
    TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
    TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
    TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
    TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
    TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
  end,
  OnEnd=function()
    if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
    TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,"mtbs_q99060")
  end,
  time="17:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"
}


this.demoOptions={
  EntrustDdog={
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET,TppDefine.INIT_ELAPSED_MISSION_COUNT.D_DOG_COME_TO_GET)
      TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME,TppDefine.INIT_ELAPSED_MISSION_COUNT.D_DOG_GO_WITH_ME)
    end,
    time="10:20:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    isUseGrassOcelot=true},
  DdogComeToGet={
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET)
      TppBuddyService.SetBuddyPuppyMBDemoPlayed()
    end,
    time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010020_0000"}},
    enableOcelotDemoEnd=true},
  DdogGoWithMe={
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then--tex skip demo onend>
        TppBuddyService.SetSortieBuddyType(BuddyType.DOG)
        Player.SetPause()
        vars.buddyType=BuddyType.DOG
        if f30050_sequence then
          f30050_sequence.ReserveMissionClear()
        end
      else--<
        TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
        TppBuddyService.SetSortieBuddyType(BuddyType.DOG)
        TppEmblem.Add("front63",true)
        Player.SetPause()
        vars.buddyType=BuddyType.DOG
        if f30050_sequence then
          f30050_sequence.ReserveMissionClear()
        end
        if mvars.mbDemo_isFirstPlay then
          TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_303",rewardType=TppReward.TYPE.COMMON}
        end
        local questIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
        gvars.qst_questRepopFlag[questIndex]=false
        gvars.qst_questClearedFlag[questIndex]=true
        TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])--MtbsCommand
      end
    end,
    isFinishFadeOut=true,heliEnableAfterDemo=true},
  LongTimeNoSee_DDSoldier={time="14:30:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,
    OnEnter=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      local dataSetName="/Assets/tpp/level/mission2/free/f30050/f30050_gimmick_target.fox2"
      local t="mtbs_bord001_vrtn003_gim_n0000|srt_mtbs_bord001_vrtn003"
      local n="mtbs_bord001_vrtn003_gim_n0001|srt_mtbs_bord001_vrtn003"
      local o="mtbs_bord001_vrtn003_gim_n0002|srt_mtbs_bord001_vrtn003"
      local l="mtbs_bord001_vrtn003_gim_n0003|srt_mtbs_bord001_vrtn003"
      Gimmick.InvisibleGimmick(-1,t,dataSetName,true)
      Gimmick.InvisibleGimmick(-1,n,dataSetName,true)
      Gimmick.InvisibleGimmick(-1,o,dataSetName,true)
      Gimmick.InvisibleGimmick(-1,l,dataSetName,true)
      gvars.elapsedTimeSinceLastPlay=0
    end,
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},
    enableOcelotDemoEnd=true,demoSoldierLocator={},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005"},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003"}},
  LongTimeNoSee_DdogPup={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppBuddyService.SetBuddyPuppyMBDemoPlayed()
      gvars.elapsedTimeSinceLastPlay=0
    end,
    heliEnableAfterDemo=true,demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0000"}},
    isUseGrassOcelot=true,enableOcelotDemoEnd=true},
  LongTimeNoSee_DdogLowLikability={time="12:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,
    OnEnd=function()
      gvars.elapsedTimeSinceLastPlay=0
    end,
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},
    enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},
  LongTimeNoSee_DdogHighLikability={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,
    OnEnd=function()
      gvars.elapsedTimeSinceLastPlay=0
    end,
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},
    enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},
  LongTimeNoSee_DdogSuperHighLikability={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,
    OnEnd=function()
      gvars.elapsedTimeSinceLastPlay=0
    end,
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010060_0000"}},
    enableOcelotDemoEnd=true,isUseGrassOcelot=true,loadBuddyBlock=true,forceEnableBuddyType=BuddyType.DOG},
  AttackedFromOtherPlayer_KnowWhereFrom={time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppUiCommand.RequestMbDvcOpenCondition{isDisableTutorial=true}
      Player.RequestToOpenMBTerminal()
    end,
    heliEnableAfterDemo=true,
    demoSoldierLocator={
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003"
    },
    forceMaleLocator={
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004",
      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000"
    },
    forceBalaclavaLocator={}},
  AttackedFromOtherPlayer_UnknowWhereFrom={time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppUiCommand.RequestMbDvcOpenCondition{isDisableTutorial=true}
      Player.RequestToOpenMBTerminal()
    end,
    heliEnableAfterDemo=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003"},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000"},
    forceBalaclavaLocator={}},
  MoraleOfMBIsLow={time="20:00:00",weather=TppDefine.WEATHER.RAINY,heliEnableAfterDemo=true,
    OnEnter=function()
      TppPlayer.Refresh()
      TppMotherBaseManagement.IncrementAllStaffMorale{morale=1}
    end,
    telopLangIdList={"area_demo_mb","platform_main"},
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010040_0002"}},
    enableOcelotDemoEnd=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000"},
    forceMaleLocator={},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000"}},
  OcelotIsPupilOfSnake={time="13:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,
    demoEndRouteList={
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0000"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0002"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010350_0004"}},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},
    enableOcelotDemoEnd=true},
  HappyBirthDay={
    GetNextDemoNameOrNil=function()
      local n=TppStory.IsMissionCleard(10086)
      local e=TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)
      local l=not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
      local t=not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)
      if((n and e)and l)and t then
        return"HappyBirthDayWithQuiet"
      end
      return nil
    end,
    OnEnd=function()
      gvars.isPlayedHappyBirthDayToday=true
    end,
    time="18:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"birthday","area_demo_mb","platform_main"}},
  HappyBirthDayWithQuiet={time="19:00:00",weather=TppDefine.WEATHER.SUNNY,
    OnEnter=function()
      local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"
      local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))
      Gimmick.PauseSharedAnim(e,t,true,0)
    end,
    OnEnd=function()
      local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"
      local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))
      Gimmick.PauseSharedAnim(e,t,false)
    end},
  QuietOnHeliInRain={weather=TppDefine.WEATHER.RAINY,time="12:00:00",
    OnEnter=function()
      local e="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"
      local t="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))
      Gimmick.PauseSharedAnim(e,t,true,0)
    end,
    OnEnd=function()
      local t="ly003_cl00_item0000|cl00pl0mb_fndt_plnt_gimmick2_nowep0000|mtbs_cran001_vrtn002_gim_n0000|srt_mtbs_cran001_vrtn002"
      local e="/Assets/tpp/level/location/mtbs/block_area/ly00"..(tostring(vars.mbLayoutCode)..("/cl00/mtbs_ly00"..(tostring(vars.mbLayoutCode).."_cl00_item.fox2")))
      Gimmick.PauseSharedAnim(t,e,false)
      Player.OnPlayerRefresh()
    end},
  QuietHasFriendshipWithChild={plntName="plnt1",clusterName="Medical",time="19:00:00",weather=TppDefine.WEATHER.SUNNY,isFinishFadeOut=true,
    OnPrevPlayRequest=function()
      svars.isCollect_Injury=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Injury]
      svars.isCollect_YellowHood=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]
      svars.isCollect_Aflo=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Aflo]
      svars.isCollect_ShortAflo=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]
      svars.isCollect_BlackCoat=gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        TppBuddyService.QuietHospitalized()
      end
      local pos={8.647,.8,-28.748}
      local rotY=-25
      pos,rotY=mtbs_cluster.GetPosAndRotY("Medical","plnt0",pos,rotY)
      TppPlayer.Warp{pos=pos,rotY=rotY}
      TppPlayer.SetInitialPosition(pos,rotY)
      mvars.f30050_isOverwriteDemoEndPos=true
      Player.RequestToSetCameraRotation{rotX=0,rotY=rotY}
    end,
    telopLangIdList={"area_demo_mb","platform_medical"}},
  QuietWishGoMission={
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION)
        TppCassette.Acquire{cassetteList={"tp_c_00000_13"},isShowAnnounceLog=true}
        TppCassette.Acquire{cassetteList={"tp_m_10050_03"},isShowAnnounceLog=true}
      end
      Player.SetPause()
      if f30050_sequence then
        f30050_sequence.ReserveMissionClear()
      end
    end,
    isFinishFadeOut=true,heliEnableAfterDemo=true,demoSoldierLocator={},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005"},
    forceBalaclavaLocator={}},
  QuietReceivesPersecution={time="13:00:00",weather=TppDefine.WEATHER.SUNNY,
    OnEnter=function()
      TppPlayer.Refresh()
    end,
    OnEnd=function()
      local pos={8.647,.8,-28.748}
      local rotY=-25
      pos,rotY=mtbs_cluster.GetPosAndRotY("Medical","plnt0",pos,rotY)
      TppPlayer.Warp{pos=pos,rotY=rotY}
      Player.RequestToSetCameraRotation{rotX=0,rotY=rotY}
      TppPlayer.SetInitialPosition(pos,rotY)
      mvars.f30050_isOverwriteDemoEndPos=true
      mtbs_enemy.OnDeactivateDemoBlock(mtbs_cluster.GetCurrentClusterId())
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        svars.isPlayedAfterDeathFactory=true
      end
    end,
    telopLangIdList={"area_demo_mb","platform_main"},
    demoSoldierLocator={},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004"},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0004"},
    isFinishFadeOut=true},
  SnakeHasBadSmell_WithoutQuiet={time="20:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,
    OnEnd=function()
      Player.OnPlayerRefresh()
    end,
    demoEndRouteList={
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010160_0000"}},
    enableOcelotDemoEnd=true,
    demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},
    loadBuddyBlock=true},
  SnakeHasBadSmell_000={
    GetNextDemoNameOrNil=function()
      return"SnakeHasBadSmell_001"
    end,
    time="20:00:00",weather=TppDefine.WEATHER.CLOUDY,
    demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002"},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001"},
    isVisibleCurrentBudy=true},
  SnakeHasBadSmell_001={clusterName="Medical",weather=TppDefine.WEATHER.CLOUDY,time="20:00:00",
    OnEnd=function()Player.OnPlayerRefresh()end,
    demoSoldierLocator={},
    forceMaleLocator={"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0000","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0003","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0001"},
    forceBalaclavaLocator={"ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0000","ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|sol_plnt0_0003"}},
  EliLookSnake={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,isVisibleCurrentBudy=true,telopLangIdList={"area_demo_mb","platform_main"},
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0001"}},
    loadBuddyBlock=true,disableBuddyAfterDemo=true,demoSoldierLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0003"},
    forceMaleLocator={},
    forceBalaclavaLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001"}},
  LiquidAndChildSoldier={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    demoEndRouteList={{locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0001"},
      {locatorName="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",routeName="ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_p51_010340_0000"}},
    enableOcelotDemoEnd=true,demoSoldierLocator={},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0001"},
    forceBalaclavaLocator={}},
  InterrogateQuiet={weather=TppDefine.WEATHER.SUNNY,time="00:00:00",
    OnEnter=function()
      TppPlayer.Refresh()
    end,
    OnEnd=function()
      TppPlayer.SetInitialPosition({10.762,0,-6.521},90)
      mvars.f30050_isOverwriteDemoEndPos=true
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3015,pushReward=true}
      end
    end,
    telopLangIdList={"area_demo_mb","area_demo_room101"},
    isShowReward=true},
  AnableDevBattleGear={weather=TppDefine.WEATHER.SUNNY,time="00:00:00",isShowReward=true,
    OnEnter=function()
      TppPlayer.Refresh()
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        vars.mbmBipedalismWeaponDevelopmentSkill=1
      end
      if f30050_sequence then
        local warpInfo={pos={-30,-7.4,6.35},rotY=-90}
        TppPlayer.Warp(warpInfo)
        if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
          TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_114",rewardType=TppReward.TYPE.COMMON}
          f30050_sequence.EnableBattleHangerMarker()
        end
      end
    end,
    telopLangIdList={"area_demo_mb","area_demo_room101"}},
  DevelopedBattleGear1={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,
    OnEnter=function()
      local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,true)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_190602_103","btg01_demo_hide_group",false,false)
    end,
    OnEnd=function()
      local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,false)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_190602_103","btg01_demo_hide_group",true,false)
    end,
    telopLangIdList={"area_demo_mb","area_demo_battle_gear"}},
  DevelopedBattleGear2={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,
    OnEnter=function()
      local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_191810_465","btg02_demo_hide_group",false,false)
    end,
    OnEnd=function()
      local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,false)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_191810_465","btg02_demo_hide_group",true,false)
    end},
  DevelopedBattleGear4={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,
    OnEnter=function()
      local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_192737_376","btg04_demo_hide_group",false,false)
    end,
    OnEnd=function()
      local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,false)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_192737_376","btg04_demo_hide_group",true,false)
    end},
  DevelopedBattleGear5={weather=TppDefine.WEATHER.SUNNY,noUseDemoBlock=true,noHeli=true,
    OnEnter=function()
      local e="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local t="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,t,e,true)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_193056_215","btg05_demo_hide_group",false,false)
    end,
    OnEnd=function()
      local t="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
      local e="mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
      Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,e,t,false)
      TppDataUtility.SetVisibleDataFromIdentifier("id_20150225_193056_215","btg05_demo_hide_group",true,false)
    end,
    telopLangIdList={"area_demo_mb","area_demo_battle_gear"}},
  CodeTalkerSunBath={time="12:00:00",weather=TppDefine.WEATHER.SUNNY,heliEnableAfterDemo=true},
  ParasiticWormCarrierKill={time="07:00:00",weather=TppDefine.WEATHER.CLOUDY,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        TppStory.MissionOpen(10240)
        TppUI.ShowAnnounceLog"missionListUpdate"
        TppUI.ShowAnnounceLog"missionAdd"
      end
      if f30050_sequence then
        f30050_sequence.ReserveMissionClear()
      end
    end,
    heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"}},
  GoToMotherBaseAfterQuietBattle={noHeli=true,outOfCluster=true,
    GetNextDemoNameOrNil=function()
      return"ArrivedMotherBaseAfterQuietBattle"
    end,
    weather=TppDefine.WEATHER.SUNNY,time="14:30:00",enableWaitBlockLoadOnDemoSkip=false,
    OnEnter=function()
      TppEffectUtility.SetOceanBaseHeight(-27)
      TppEffectUtility.SetOceanProjectionScale(64)
      TppEffectUtility.SetOceanBlendEnd(384)
      TppEffectUtility.SetOceanFarProjectionAmplitude(0)
      TppEffectUtility.SetOceanSpecularIntensity(0)
      TppEffectUtility.SetOceanVelocity(20)
      TppEffectUtility.SetOceanDisplacementStrength(.001)
      TppEffectUtility.SetOceanWaveAmplitude(.5)
      TppEffectUtility.SetOceanWindDirection(-.04,-.1)
    end,
    OnEnd=function()
      TppEffectUtility.RestoreOceanParameters()
    end,
    loadBuddyBlock=true,telopLangIdList={"area_demo_quiet_01","area_demo_quiet_02"}},
  ArrivedMotherBaseAfterQuietBattle={noHeli=true,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterQuietBattle]=false
        local e=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=TppMotherBaseManagementConst.STAFF_UNIQUE_TYPE_ID_QUIET}
        TppMotherBaseManagement.DirectAddStaff{staffId=e}
      end
      if f30050_sequence and(not mvars.mbDemo_isFirstPlay)then
        f30050_sequence.ReserveMissionClear()
      end
    end,
    time="14:00:00",weather=TppDefine.WEATHER.CLOUDY,heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    loadBuddyBlock=true},
  ArrivedMotherBaseLiquid={time="20:00:00",weather=TppDefine.WEATHER.SUNNY,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterWhiteMamba]=false
    end,
    heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0005","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0000","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003"}},
  ArrivedMotherBaseFromDeathFactory={weather=TppDefine.WEATHER.SUNNY,time="18:00:00",heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    OnPrevPlayRequest=function()
      svars.isCollect_Injury=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_Injury]
      svars.isCollect_YellowHood=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]
      svars.isCollect_Aflo=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_Aflo]
      svars.isCollect_ShortAflo=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]
      svars.isCollect_BlackCoat=gvars.s10100_boyEscape[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Injury]=svars.isCollect_Injury
      gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]=svars.isCollect_YellowHood
      gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_Aflo]=svars.isCollect_Aflo
      gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]=svars.isCollect_ShortAflo
      gvars.quietHasFriendshipWithChildFlag[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]=svars.isCollect_BlackCoat
      gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterDethFactory]=false
    end,
    demoSoldierLocator={},
    forceMaleLocator={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt1_0001","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt2_0002","ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002"},
    forceBalaclavaLocator={}},
  ArrivedMotherBaseChildren={weather=TppDefine.WEATHER.SUNNY,time="11:00:00",heliEnableAfterDemo=true,telopLangIdList={"area_demo_mb","platform_main"},
    OnEnter=function()
      TppSoundDaemon.ResetMute"Outro"
    end,
    OnPrevPlayRequest=function()
      svars.isCollect_Injury=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_Injury]
      svars.isCollect_YellowHood=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_YellowHood]
      svars.isCollect_Aflo=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_Aflo]
      svars.isCollect_ShortAflo=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_ShortAflo]
      svars.isCollect_BlackCoat=gvars.s10100_boyEscapeCurrentPlay[TppDefine.S10100_BOY_ENUM.Collect_BlackCoat]
    end},
  NuclearEliminationCeremony={weather=TppDefine.WEATHER.SUNNY,time="17:20:00",
    GetNextDemoNameOrNil=function()
      if TppMotherBaseManagement.IsNuclearDeveloped()then
        return"DetailsNuclearDevelop"
      elseif TppMotherBaseManagement.IsNuclearDiscarded()then
        return"ForKeepNuclearElimination"
      else
        return"SacrificeOfNuclearElimination"
      end
    end,
    OnEnter=function()
      TppPlayer.Refresh()
      PlatformConfiguration.SetShareScreenEnabled(false)
      function f30050_sequence.FinishNuclearAbolitionEndint()
        TppUiStatusManager.UnsetStatus("AnnounceLog","INVALID_LOG")
        PlatformConfiguration.SetShareScreenEnabled(true)
        TppSoundDaemon.ResetMute"Result"
        f30050_sequence.ReserveMissionClear()
        local e=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
        if gvars.f30050_discardNuclearCountFromLastAbolition<e then
          TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.NuclearAbolition,nil,"announce_nuclear_zero")
        end
        gvars.f30050_discardNuclearCountFromLastAbolition=e
      end
    end,
    telopLangIdList={"area_demo_mb","platform_main"}},
  ForKeepNuclearElimination={weather=TppDefine.WEATHER.SUNNY,time="17:45:00",
    GetNextDemoNameOrNil=function()
      return"SacrificeOfNuclearElimination"
    end,
    clusterName="Medical",
    OnEnter=function()
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_AssetIdentifier","mtbs_antn001_0001",false,false)
    end,
    OnEnd=function()
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_AssetIdentifier","mtbs_antn001_0001",true,false)
    end},
  SacrificeOfNuclearElimination={weather=TppDefine.WEATHER.SUNNY,time="10:00:00",clusterName="Develop",
    GetNextDemoNameOrNil=function()
      return"EndingSacrificeOfNuclear"
    end,
    OnEnter=function()
      Player.SetPause()
      TppDataUtility.SetVisibleDataFromIdentifier("MtbsCommon","sahelan_spl",false,false)
    end,
    OnEnd=function()
      TppSoundDaemon.SetMute"Result"
    end},
  DetailsNuclearDevelop={isMovie=true,
    OnEnter=function()
      TppSoundDaemon.SetMute"Result"
    end,
    GetNextDemoNameOrNil=function()
      if TppMotherBaseManagement.IsNuclearDiscarded()then
        return"ForKeepNuclearElimination"
      else
        return"SacrificeOfNuclearElimination"
      end
    end},
  EndingSacrificeOfNuclear={isMovie=true,
    OnEnter=function()
      TppSound.SetSceneBGM"bgm_nuclear_ending"
      TppUiCommand.NukeCountDownText("set","cmmn_nuclear_weapon_num",5,166666,15)
    end,
    OnEnd=function()
      local e=TppServerManager.GetNuclearAbolitionCount()
      if e>0 then
        gvars.f30050_NuclearAbolitionCount=e
      end
      TppUiCommand.NukeCountDownText"reset"
    end},
  TheGreatEscapeLiquid={
    OnEnter=function()
      TppPlayer.Refresh()
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.THE_GREAT_ESCAPE_LIQUID,TppDefine.INIT_ELAPSED_MISSION_COUNT.THE_GREAT_ESCAPE_LIQUID)
      TppCassette.Acquire{cassetteList={"tp_m_10160_04"},pushReward=true}
      svars.isVisibleBrokenHanger=true
      TppClock.SetTime"20:00:00"
      mvars.f30050_isOverwriteDemoEndPos=true
      TppEmblem.Add("front71",true)
      TppEmblem.Add("word1",true)
      TppEmblem.Add("word40",true)
      TppEmblem.Add("word45",true)
      TppEmblem.Add("word58",true)
      TppEmblem.Add("word99",true)
      TppEmblem.Add("word112",true)
    end,
    time="15:45:00",weather=TppDefine.WEATHER.SUNNY,telopLangIdList={"area_demo_mb","area_demo_room101"},
    isShowReward=true},
  DecisionHuey={
    OnEnter=function()
      TppPlayer.Refresh()
      TppDataUtility.SetVisibleDataFromIdentifier("cp05_off_AssetIdentifier","mtbs_antn001_0001",false,false)
      TppEffectUtility.SetOceanDisplacementStrength(.0115)
      TppEffectUtility.SetOceanWindDirection(-.8,.5)
      TppEffectUtility.SetOceanWaveAmplitude(.4)
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(0) then--tex skip demo onend
        TppStory.SetDoneElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY)
        TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3007,pushReward=true}
        TppCassette.Acquire{cassetteList={"tp_m_10190_05","tp_m_10190_06","tp_m_10240_03","tp_m_10240_04"},pushReward=true}
        TppEmblem.Add("front82",true,false)
        TppEmblem.Add("word37",true,false)
        TppEmblem.Add("word127",true,false)
        TppEmblem.Add("word128",true,false)
        TppEmblem.Add("word129",true,false)
        vars.mbmBanHeuy=1
      end
      TppEffectUtility.RestoreOceanParameters()
      if f30050_sequence then
        f30050_sequence.ReserveMissionClear()
      end
    end,
    time="07:10:00",weather=TppDefine.WEATHER.CLOUDY,telopLangIdList={"area_demo_mb","area_demo_room101"}},
  PazPhantomPain1={
    OnEnter=function()
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_bed_AssetIdentifier","paz_room_bed",true,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
      TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
      TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
      TppPaz.SetDemoEndType(TppPaz.DEMO_END_TYPE_SIT)
      TppPaz.OnDemoEnter()
    end,
    OnEnd=function()
    end,
    time="00:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"
  },
  PazPhantomPain2={
    OnEnter=function()
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom",true,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_real",false,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_bed_AssetIdentifier","paz_room_bed",true,false)
      TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier","paz_room_phantom_door",false,false)
      local photos={"photo01","photo02","photo03","photo04","photo05","photo06","photo07","photo08","photo09","photo10"}
      for i=1,gvars.pazLookedPictureCount do
        TppDataUtility.SetVisibleDataFromIdentifier("uq_0040_paz_room_AssetIdentifier",photos[i],true,false)
      end
      TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Probe_PazRoom",true,false)
      TppDataUtility.SetEnableDataFromIdentifier("mtbs_uni0040_155641_587","Trap_PazRoom",true,false)
      TppPaz.SetDemoEndType(TppPaz.DEMO_END_TYPE_DOWN)
      TppPaz.OnDemoEnter()
    end,
    OnEnd=function()
      if Ivars.mbDemoSelection:Is(1) then return end--tex skip demo onend
      f30050_sequence.SetPazDone()
    end,
    time="17:00:00",weather=TppDefine.WEATHER.SUNNY,clusterName="Medical"
  },
  PazPhantomPain4=this._PazPhantomPain4Settings,
  PazPhantomPain4_jp=this._PazPhantomPain4Settings
}
function this.PlayMtbsEventDemo(params)
  if not Tpp.IsTypeTable(params)then
  end
  local demoName=params.demoName
  if not this.demoList[demoName]then
    return
  end
  Player.UnsetPause()
  mvars.mbDemo_isFirstPlay=not TppDemo.IsPlayedMBEventDemo(demoName)
  local hasNextDemo=false
  local ParamsOnEnd=params.onEnd
  local DemoOnEnd=nil
  local DemoOnEnter=nil
  local demoOptions=this.demoOptions[demoName]
  local weather,demoTime=nil,nil
  local nextDemo=this.GetNextDemo(demoName)
  local outOfCluster=nil
  local heliEnableAfterDemo=nil
  local isMovie=false
  local isVisibleCurrentBudy=false
  local useDemoBlock=true
  local noHeli=false
  local isShowReward=false
  local telopLangIdList={}
  local demoEndRouteList=nil
  local enableOcelotDemoEnd=false
  local buddyType1=vars.buddyType
  local buddyType2=vars.buddyType
  local RENAMEsetBuddyType2=false
  local enableWaitBlockLoadOnDemoSkip=nil
  local isFinishFadeOut=false
  local isUseGlassesOcelot=false
  if demoOptions then
    DemoOnEnter=demoOptions.OnEnter
    DemoOnEnd=demoOptions.OnEnd
    weather=demoOptions.weather
    if Ivars.mbDemoOverrideWeather:Is"CURRENT" then--tex>
      weather=nil
    elseif Ivars.mbDemoOverrideWeather:Is()>Ivars.mbDemoOverrideWeather.enum.CURRENT then
      weather=Ivars.mbDemoOverrideWeather:Get()-(Ivars.mbDemoOverrideWeather.enum.CURRENT+1)
    end--<
    outOfCluster=demoOptions.outOfCluster
    heliEnableAfterDemo=demoOptions.heliEnableAfterDemo
    isMovie=demoOptions.isMovie
    isVisibleCurrentBudy=demoOptions.isVisibleCurrentBudy
    demoEndRouteList=demoOptions.demoEndRouteList
    enableOcelotDemoEnd=demoOptions.enableOcelotDemoEnd
    if demoOptions.noUseDemoBlock then
      useDemoBlock=false
    end
    if nextDemo then
      hasNextDemo=true
      demoTime=this.GetDemoTime(nextDemo)
    end
    isShowReward=demoOptions.isShowReward
    telopLangIdList=demoOptions.telopLangIdList
    noHeli=demoOptions.noHeli
    if demoOptions.OnPrevPlayRequest then
      demoOptions.OnPrevPlayRequest()
    end
    enableWaitBlockLoadOnDemoSkip=demoOptions.enableWaitBlockLoadOnDemoSkip
    isFinishFadeOut=demoOptions.isFinishFadeOut
    isUseGlassesOcelot=demoOptions.isUseGrassOcelot--NMC: actually glasses, not grass lol
  end
  local finishFadeOut=((hasNextDemo or mvars.f30050_needReload)or isShowReward)or isFinishFadeOut
  local demoFuncs={
    onInit=function()
      TppBuddyService.SetIgnoreDisableNpc(true)
      if weather then
        TppWeather.ForceRequestWeather(weather,0)
      end
      local pos,rotQuat
      if outOfCluster then
        pos=Vector3(5e3,0,5e3)
        rotQuat=Quat.RotationY(0)
      else
        local cluster,plant=this.GetDemoPlayCluster(demoName)
        pos,rotQuat=mtbs_cluster.GetDemoCenter(cluster,plant)
      end
      DemoDaemon.SetDemoTransform(f30050_demo.demoList[demoName],rotQuat,pos)
      if not noHeli then
        if heliEnableAfterDemo then
          GameObject.SendCommand({type="TppHeli2",index=0},{id="SetDemoToAfterDropEnabled",enabled=true,route="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_tkof",isTakeOff=true})
        else
          GameObject.SendCommand({type="TppHeli2",index=0},{id="SetDemoToAfterDropEnabled",enabled=false,route="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_tkof"})
        end
      end
      if isUseGlassesOcelot then
        local tppOcelot={type="TppOcelot2",index=0}
        local command={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=371}
        GameObject.SendCommand(tppOcelot,command)
      end
      this.SetInvisibleUniqueCharacter(isVisibleCurrentBudy)
      GkEventTimerManager.Start("TelopStartOnDemo",telopStartOnDemoTime)
      mvars.f30050_demoTelopLangIdList=telopLangIdList
    end,
    onStart=function()
      if demoEndRouteList then
        this.SetupDemoEndRoute(demoEndRouteList)
      end
      if DemoOnEnter then
        DemoOnEnter()
      end
    end,
    onEnd=function()
      this.DisableBuddyForForceRealized(demoName)
      vars.buddyType=mvars.f30050_buddyTypeOnMissionStart
      TppBuddyService.SetIgnoreDisableNpc(false)
      local demoEnum=TppDefine.MB_FREEPLAY_DEMO_ENUM[demoName]
      if demoEnum and Ivars.mbDemoSelection:Is(0) then--tex added bypass, otherwise causes issues if demo played before triggered in course of normal game
        gvars.mbFreeDemoPlayedFlag[demoEnum]=true
      end

      if DemoOnEnd then
        DemoOnEnd()
      end

      if ParamsOnEnd then
        ParamsOnEnd()
      end

      if not enableOcelotDemoEnd then
        this.DisableOcelot()
      end

      if RENAMEsetBuddyType2 then
        vars.buddyType=buddyType2
      end
      if nextDemo then
        Player.SetPause()
        this.ChangeBlock(demoName,nextDemo)
        if demoTime then
          TppClock.SetTime(demoTime)
        end
      end

      if not nextDemo then
        local e,t=TppStory.GetForceMBDemoNameOrRadioList("afterMBDemo",{demoName=demoName})
        if e then
          svars.requestPlayAfterDemoRadioIndex=t
        end
      end
      TppWeather.CancelForceRequestWeather()
      TppBuddyService.SetVarsMissionStart()
      TppDemoUtility.SetInvisibleUniqueCharacter{invisible={}}
      if isShowReward then
        this.ShowMissionRewardAfterDemo()
        mvars.dem_resereveEnableInGameFlag=false
      end
    end
  }
  local options={useDemoBlock=useDemoBlock,finishFadeOut=finishFadeOut,startNoFadeIn=true,exceptGameStatus=params.exceptGameStatus,waitBlockLoadEndOnDemoSkip=enableWaitBlockLoadOnDemoSkip}
  if TppStory.DEBUG_SkipDemoRadio then
    demoFuncs.onEnd()
    return
  end
  if isMovie then
    local videoName=this.demoList[demoName]
    TppMovie.Play{videoName=videoName,onStart=demoFuncs.onStart,onEnd=demoFuncs.onEnd,memoryPool=videoName}--RETAILBUG: was onEnd=demoFuncs.onend VERIFY: any movies actually use an onEnd ?
  else
    TppDemo.Play(demoName,demoFuncs,options)
  end
end
function this.DisableBuddyForForceRealized(demoName)
  if vars.buddyType~=BuddyType.QUIET and vars.buddyType~=BuddyType.DOG then
    return
  end
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and(demoOptions.forceEnableBuddyType or (demoOptions.disableBuddyAfterDemo and Ivars.mbDontDemoDisableBuddy:Is(0)))then--tex added override
    local command={id="SetEnabled",enabled=false}
    local buddyId={type="TppBuddyDog2",index=0}
    if vars.buddyType==BuddyType.QUIET then
      buddyId={type="TppBuddyQuiet2",index=0}
    end
    GameObject.SendCommand(buddyId,command)
  end
end
function this.SetupDemoEndRoute(demoEndRouteList)
  for n,endRoute in ipairs(demoEndRouteList)do
    local gameId=GameObject.GetGameObjectId(endRoute.locatorName)
    local command={id="SetSneakRoute",route=endRoute.routeName}
    GameObject.SendCommand(gameId,command)
  end
end
function this.SetInvisibleUniqueCharacter(isVisibleCurrentBudy)
  local setInvisibleTable={}
  if not TppStory.CanArrivalLiquidInMB()then
    table.insert(setInvisibleTable,"Liquid")
  end
  if not TppStory.CanArrivalHueyInMB()then
    table.insert(setInvisibleTable,"Huey")
  end
  if not TppStory.CanArrivalCodeTalkerInMB()then
    table.insert(setInvisibleTable,"CodeTalker")
  end
  if not TppStory.CanArrivalSahelanInMB()then
    table.insert(setInvisibleTable,"Sahelan")
  end

  if isVisibleCurrentBudy then
    if vars.buddyType~=BuddyType.QUIET then
      table.insert(setInvisibleTable,"Quiet")
    end
    if vars.buddyType~=BuddyType.DOG then
      table.insert(setInvisibleTable,"Dog")
    end
  else
    if not TppStory.CanArrivalQuietInMB()then
      table.insert(setInvisibleTable,"Quiet")
    end
    if not TppStory.CanArrivalDDogInMB()then
      table.insert(setInvisibleTable,"Dog")
    end
  end
  for e,e in ipairs(setInvisibleTable)do
  end
  TppDemoUtility.SetInvisibleUniqueCharacter{invisible=setInvisibleTable}
end
function this.DisableOcelot()
  local gameId=GameObject.GetGameObjectId"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator"
  local command={id="SetEnabled",enabled=false}
  if gameId~=GameObject.NULL_ID then
    GameObject.SendCommand(gameId,command)
  end
end
function this.ChangeBlock(currentDemoName,nextDemoName)
  local currentDemoFpkList=this.demoBlockList[currentDemoName]
  local nextDemoFpkList=this.demoBlockList[nextDemoName]
  local differentBlockList=#currentDemoFpkList~=#nextDemoFpkList
  if not differentBlockList then
    for i=1,#currentDemoFpkList do
      if currentDemoFpkList[i]~=buddyFpk then
        if currentDemoFpkList[i]~=nextDemoFpkList[i]then
          differentBlockList=true
          break
        end
      end
    end
  end
  if differentBlockList then
    local clusterName=f30050_demo.GetDemoPlayCluster(nextDemoName)
    local clusterId=TppDefine.CLUSTER_DEFINE[clusterName]
    f30050_sequence.RegisterFovaFpk(clusterId)
    this.UpdatePackList(nextDemoName)
    TppScriptBlock.LoadDemoBlock(nextDemoName,true)
  end
end
function this.GetNextDemo(demoName)
  local nextDemo=nil
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.GetNextDemoNameOrNil then
    nextDemo=demoOptions.GetNextDemoNameOrNil()
  end
  return nextDemo
end
function this.GetDemoPlayCluster(demoName)
  local clusterName="Command"
  local plntName="plnt0"
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.clusterName then
    clusterName=demoOptions.clusterName
  end
  if demoOptions and demoOptions.plntName then
    plntName=demoOptions.plntName
  end
  return clusterName,plntName
end
function this.HasPlant(demoName)
  local clusterName,plntName=this.GetDemoPlayCluster(demoName)
  return mtbs_cluster.HasPlant(clusterName,plntName)
end
function this.GetDemoTime(demoName)
  local time=nil
  if Ivars.mbDemoOverrideTime:Is"CURRENT" then--tex>
    return nil
  elseif Ivars.mbDemoOverrideTime:Is"CUSTOM" then
    return string.format("%02d:%02d:00",Ivars.mbDemoHour:Get(),Ivars.mbDemoMinute:Get())
  end--<

  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.time then
    time=demoOptions.time
  end
  return time
end
function this.UpdatePackList(demoName)
  if not demoName then
    return
  end
  local packList={}
  packList[demoName]={}
  local hasQuestPacks=false
  if this.demoBlockList[demoName]then
    Tpp.ApendArray(packList[demoName],this.demoBlockList[demoName])
    local demoOptions=this.demoOptions[demoName]
    if demoOptions and demoOptions.loadBuddyBlock then
      table.insert(packList[demoName],buddyFpk)
    end
  elseif TppQuestList.questPackList[demoName]then
    hasQuestPacks=true
    Tpp.ApendArray(packList[demoName],TppQuestList.questPackList[demoName])
  end
  if hasQuestPacks or demoName=="Empty"then
    Tpp.ApendArray(packList[demoName],this.GetPackListForStorySequence())
  end
  if mvars.f30050demo_fovaPackList then
    Tpp.ApendArray(packList[demoName],mvars.f30050demo_fovaPackList)
  end
  if#packList[demoName]~=0 then
    TppQuest.RegisterQuestPackList(packList,"demo_block")
  end
end
function this.RegisterFovaPack(packList)
  mvars.f30050demo_fovaPackList=packList
end
function this.GetPackListForStorySequence()
  mvars.f30050_isSetLiquid=false
  mvars.f30050_isSetCodeTalker=false
  local packList={}
  local cluster=MotherBaseStage.GetCurrentCluster()
  if cluster>#TppDefine.CLUSTER_NAME then
    cluster=MotherBaseStage.GetFirstCluster()
  end
  if cluster==TppDefine.CLUSTER_DEFINE.Medical then
    if TppStory.CanArrivalQuietInMB(false)or TppQuest.IsActive"mtbs_q99011"then
      table.insert(packList,quietFpk)
    end
  elseif cluster==TppDefine.CLUSTER_DEFINE.Develop then
    if TppStory.CanArrivalSahelanInMB() then
      local packPath="/Assets/tpp/pack/mission2/free/f30050/f30050_ly00"..(tostring(vars.mbLayoutCode).."_sahelan.fpk")
      table.insert(packList,packPath)
    end
    if TppStory.CanArrivalAIPodInMB() then
      local packPath="/Assets/tpp/pack/mission2/free/f30050/f30050_ly00"..(tostring(vars.mbLayoutCode).."_aipod.fpk")
      table.insert(packList,packPath)
    end
  elseif cluster==TppDefine.CLUSTER_DEFINE.Command then
    if TppStory.CanArrivalLiquidInMB()and(not TppQuest.IsActive"mtbs_q99050") then
      local packPath="/Assets/tpp/pack/mission2/free/f30050/f30050_command_liquid.fpk"
      table.insert(packList,packPath)
      mvars.f30050_isSetLiquid=true
    end
    if TppStory.CanArrivalCodeTalkerInMB() then
      local packPath="/Assets/tpp/pack/mission2/free/f30050/f30050_command_codeTalker.fpk"
      table.insert(packList,packPath)
      mvars.f30050_isSetCodeTalker=true
    end
  end
  if(vars.buddyType==BuddyType.DOG)or(vars.buddyType==BuddyType.QUIET)or(TppMission.IsMbFreeMissions(vars.missionCode) and Ivars.mbEnableBuddies:Is(1))then--tex
    table.insert(packList,buddyFpk)
    mvars.f30050_needLoadBuddyController=true
  end
  return packList
end
function this.ShowMissionRewardAfterDemo()
  TppMission.ShowMissionReward()
  mvars.f30050_showMissionRewardAfterDemo=true
end
function this.GetSoldierListInDemo(demoName)
  local soldierList={}
  local demoOptions=this.demoOptions[demoName]
  if demoOptions then
    if demoOptions.forceMaleLocator then
      Tpp.ApendArray(soldierList,demoOptions.forceMaleLocator)
    end
    if demoOptions.demoSoldierLocator then
      Tpp.ApendArray(soldierList,demoOptions.demoSoldierLocator)
    end
  end
  return soldierList
end
function this.GetForceMaleSoldierList(demoName)
  local forceMaleLocator={}
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.forceMaleLocator then
    forceMaleLocator=demoOptions.forceMaleLocator
  end
  return forceMaleLocator
end
function this.SetupEnemy(t)
  local l=this.GetDemoPlayCluster(t)
  local l=TppDefine.CLUSTER_DEFINE[l]+1
  local e=this.GetSoldierListInDemo(t)
  mtbs_enemy.SetSoldierForDemo(l,e)
end
function this.IsBalaclava(demoName,l)
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.forceBalaclavaLocator then
    for t,e in ipairs(demoOptions.forceBalaclavaLocator)do
      if e==l then
        return true
      end
    end
  end
  return false
end
function this.NeedLoadBuddyBlock(demoName)
  local demoOptions=this.demoOptions[demoName]
  if demoOptions and demoOptions.loadBuddyBlock then
    if demoOptions.forceEnableBuddyType then
      return true
    end
    if demoOptions.disableBuddyType~=vars.buddyType and vars.buddyType==BuddyType.DOG then
      return true
    end
  end
  return false
end
function this.SetupBuddy(demoName)
  if this.NeedLoadBuddyBlock(demoName)then
    local demoOptions=this.demoOptions[demoName]
    if demoOptions and demoOptions.forceEnableBuddyType then
      vars.buddyType=demoOptions.forceEnableBuddyType
    end
    TppBuddy2BlockController.Load()
    TppBuddy2BlockController.ReserveCallBuddy(vars.buddyType,BuddyInitStatus.RIDE,Vector3(0,0,0),0)
  end
end
function this.IsShowReward(demoName)
  local demoOptions=this.demoOptions[demoName]
  if demoOptions then
    return demoOptions.isShowReward
  end
  return false
end
return this

-- DOBUILD: 1
--start.lua
--local splash=SplashScreen.Create("startstart","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_fox_logo_clp_nmp.ftex",640,640)--tex
--SplashScreen.Show(splash,.2,1,.2)--tex

local function yield()
  coroutine.yield()
end
FoxFadeIo.FadeOut(0)
TppUiStatusManager.SetStatus("PauseMenu","INVALID")
TppUiCommand.SetLoadIndicatorVisible(true)
if(TppSystemUtility.GetCurrentGameMode()~="MGO"and TppGameSequence.GetTargetArea()=="Japan")and not SignIn.PresetUserIdExists()then
  local e=SplashScreen.Create("cesa","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_cesa_logo_clp_nmp.ftex",1280,640)
  SplashScreen.Show(e,.5,4,.5)
end
if TppPlayLog and TppSystemUtility.GetCurrentGameMode()=="MGO"then
  TppPlayLog.SetPlayLogEnabled(true)
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  Mission.StartSystemMenuPause()
end
GameConfig.Reset()
UiDaemon.SetPrefetchTexture"/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_logo_mini_nmp.ftex"
AssetConfiguration.RegisterExtensionInfo{extensions={"tetl","tmss","tmsl","tlsp","tmsu","tmsf","twpf","adm","tevt","vpc","ends","spch","mbl"},categories={"Target"}}
if TppGameSequence and TppPhaseController then
  local e=TppGameSequence:GetInstance()
  e:SetPhaseController(TppPhaseController.Create())
end
local e=CheckpointDaemon{name="CheckpointDaemon"}
if GkNoiseSystem then
  GkNoiseSystem.InitNoiseSet"Tpp/Scripts/Noises/TppNoiseDefinitions.lua"
end
if ChVoiceTaskOrganizer then
  ChVoiceTaskOrganizer.PrepareTaskPool("Player",1)
  ChVoiceTaskOrganizer.PrepareTaskPool("Enemy",8)
  ChVoiceTaskOrganizer.PrepareTaskPool("HqSquad",1)
end
if ChVoiceTaskOrganizer2 then
  ChVoiceTaskOrganizer2.PrepareTaskPool("Player",1)
  ChVoiceTaskOrganizer2.PrepareTaskPool("Enemy",8)
  ChVoiceTaskOrganizer2.PrepareTaskPool("HqSquad",1)
end
if Editor then
  if Preference then
    local e=Preference.GetPreferenceEntity"EdRailPreference"
    if not Entity.IsNull(e)and Fox.GetPlatformName()=="Windows"then
      if e.railSystemScript==""then
        e.railSystemScript="/Assets/tpp/editor_scripts/fox/rail/TppRailSystem.lua"
      end
    end
  end
  do
    local e=Preference.GetPreferenceEntity"EdRoutePreference"
    if not Entity.IsNull(e)and e.characterType=="Soldier"then
      e.characterType="Soldier2"
    end
  end
  EdRouteDataNodeEvent.SetEventDefinitionPath("Soldier2","Tpp/Scripts/RouteEvents/AiRtEvSoldier2.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Soldier2","Tpp/Scripts/RouteEvents/AiRtEvSoldier2.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Hostage2","Tpp/Scripts/RouteEvents/AiRtEvHostage2.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Hostage2","Tpp/Scripts/RouteEvents/AiRtEvHostage2.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Uav","Tpp/Scripts/RouteEvents/AiRtEvUav.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Uav","Tpp/Scripts/RouteEvents/AiRtEvUav.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Sahelan2","Tpp/Scripts/RouteEvents/AiRtEvSahelan2.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Sahelan2","Tpp/Scripts/RouteEvents/AiRtEvSahelan2.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Volgin2","Tpp/Scripts/RouteEvents/AiRtEvVolgin2.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Volgin2","Tpp/Scripts/RouteEvents/AiRtEvVolgin2.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Liquid2","Tpp/Scripts/RouteEvents/AiRtEvLiquid2.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Liquid2","Tpp/Scripts/RouteEvents/AiRtEvLiquid2.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Heli","Tpp/Scripts/RouteEvents/AiRtEvHeli.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Heli","Tpp/Scripts/RouteEvents/AiRtEvHeli.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Animal","Tpp/Scripts/RouteEvents/AiRtEvAnimal.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Animal","Tpp/Scripts/RouteEvents/AiRtEvAnimal.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("BossQuiet","Tpp/Scripts/RouteEvents/AiRtEvBossQuiet.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("BossQuiet","Tpp/Scripts/RouteEvents/AiRtEvBossQuiet.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("MbQuiet","Tpp/Scripts/RouteEvents/AiRtEvMbQuiet.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("MbQuiet","Tpp/Scripts/RouteEvents/AiRtEvMbQuiet.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("BuppyPuppy","Tpp/Scripts/RouteEvents/AiRtEvBuddyPuppy.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("BuppyPuppy","Tpp/Scripts/RouteEvents/AiRtEvBuddyPuppy.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("Horse2forVr","Tpp/Scripts/RouteEvents/AiRtEvHorse2forVr.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("Horse2forVr","Tpp/Scripts/RouteEvents/AiRtEvHorse2forVr.lua")
  EdRouteDataNodeEvent.SetEventDefinitionPath("AimTarget","Tpp/Scripts/RouteEvents/AiRtEvAimTarget.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("AimTarget","Tpp/Scripts/RouteEvents/AiRtEvAimTarget.lua")
  EdRouteDataNodeEvent.SetEventList"Soldier2"
  EdRouteDataEdgeEvent.SetEventList"Soldier2"
  if Preference then
    local e=Preference.GetPreferenceEntity"EdRoutePreference"
    if not Entity.IsNull(e)and Fox.GetPlatformName()=="Windows"then
      if e.routeSystemScript==""then
        e.routeSystemScript="/Assets/tpp/editor_scripts/fox/route/TppRouteSystem.lua"
      end
    end
  end
end
if TppCoverPointProvider then
  TppCoverPointProvider.Create()
end
NavTactical.SetTacticalActionSystemScript"/Assets/tpp/editor_scripts/fox/tactical_action/TppTacticalActionSystem.lua"
local enableWindowsDX11Texture=true
if not AssetConfiguration.IsDiscOrHddImage()then
  enableWindowsDX11Texture=AssetConfiguration.GetConfigurationFromAssetManager"EnableWindowsDX11Texture"
end
if GrDaemon then
  local platformName=Fox.GetPlatformName()
  local deviceName=""
  if GrTools then
    deviceName=GrTools.GetDeviceName()
  end
  if platformName=="Windows"then
    if deviceName=="directx9"then
      GrTools.LoadShaderPack"shaders/win32/TppShaders_win32.fsop"
      if enableWindowsDX11Texture then
        dofile"shaders/win32/TppShadersNoLnm_win32.lua"
      else
        dofile"shaders/win32/TppShaders_win32.lua"
      end
    end
    if deviceName=="directx11"then
      GrTools.LoadShaderPack"shaders/dx11/TppShaders_dx11.fsop"
      if enableWindowsDX11Texture then
        dofile"shaders/dx11/TppShadersNoLnm_dx11.lua"
      else
        dofile"shaders/dx11/TppShaders_dx11.lua"
      end
    end
  elseif platformName=="Xbox360"then
    GrTools.LoadShaderPack"shaders\\xbox360\\TppShaders_x360.fsop"
    dofile"shaders/xbox360/TppShaders_x360.lua"
  elseif platformName=="PS3"then
    GrTools.LoadShaderPack"shaders/ps3/TppShaders_ps3.fsop.sdat"
    dofile"shaders/ps3/TppShaders_ps3.lua"
  elseif platformName=="XboxOne"then
    GrTools.LoadShaderPack"shaders/xboxone/TppShaders_xone.fsop"
    dofile"shaders/xboxone/TppShadersNoLnm_xone.lua"
  elseif platformName=="PS4"then
    GrTools.LoadShaderPack"shaders/ps4/TppShaders_ps4.fsop"
    dofile"shaders/ps4/TppShadersNoLnm_ps4.lua"
  end
end
TppFadeOutEffectHolder.Create()
TppEffectUtility.SetEnableWindowsDirectX11Textures(enableWindowsDX11Texture)
TppEffectUtility.InitThermalReactionObjectUnionMaterial()
if Preference then
  local fxEditorPreferenceEntity=Preference.GetPreferenceEntity"FxEditorSetting"
  if not Entity.IsNull(fxEditorPreferenceEntity)and Fox.GetPlatformName()=="Windows"then
    if#fxEditorPreferenceEntity.defineFiles==0 then
      Command.AddPropertyElement{entity=fxEditorPreferenceEntity,property="defineFiles"}
    end
    fxEditorPreferenceEntity.defineFiles[1]="../../Tpp/Tpp/Fox/LevelEditor/Fx/tppFxModuleDefines.xml"
  end
end
if FxDaemon then
  FxDaemon:InitializeReserveObject"TppShaderPool"
  FxDaemon:InitializeReserveObject"TppTexturePoolManager"
  if Fox.GetPlatformName()=="Windows"then
    FxSystemConfig.SetLimitInstanceMemorySize((1024*1024)*24)
    FxSystemConfig.SetLimitInstanceMemoryDefaultSize((1024*1024)*24)
  else
    FxSystemConfig.SetLimitInstanceMemorySize((1024*1024)*9)
    FxSystemConfig.SetLimitInstanceMemoryDefaultSize((1024*1024)*9)
  end
end
AssetConfiguration.SetLanguageGroupExtention{group={"Sound"},extensions={"mas","fsm","sbp","wem","evf","sani","sad","stm"}}
local langCode="jpn"
do
  if(TppGameSequence.GetTargetArea()~="Japan")then
    langCode="eng"
  end
end
AssetConfiguration.SetDefaultCategory("Language",langCode)
if langCode=="jpn"then
  AssetConfiguration.SetGroupCurrentLanguage("Sound","jpn")
else
  AssetConfiguration.SetGroupCurrentLanguage("Sound","eng")
end
if langCode=="jpn"then
  SubtitlesDaemon.SetDefaultVoiceLanguage"jpn"
  SubtitlesCommand.SetVoiceLanguage"jpn"
else
  SubtitlesDaemon.SetDefaultVoiceLanguage"eng"
  SubtitlesCommand.SetVoiceLanguage"eng"
end
SubtitlesCommand.SetLanguage(langCode)
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  SoundCoreDaemon.SetAssetPath"/Assets/mgo/sound/asset/"
else
  if LuaUnitTest then
    SoundCoreDaemon.SetAssetPath"/Assets/tpp/sound/asset/"
  else
    SoundCoreDaemon.SetAssetPath"/Assets/tpp/sound/asset/"
  end
end
SoundCoreDaemon.SetInterferenceRTPCName("obstruction_rtpc","occlusion_rtpc")
SoundCoreDaemon.SetDopplerRTPCName"doppler"
SoundCoreDaemon.SetRearParameter("rear_rtpc",5)
if TppSoundDaemon then
  local e=TppSoundDaemon{}
  if TppSoundEditorDaemon then
    local e=TppSoundEditorDaemon{}
  end
end
TppRadioCommand.CreateSoundControl()
TppRadioCommand.RegisterTppCommonConditionCheckFunc()
VoiceCommand:SetVoiceTypePriority(1,1,0)
VoiceCommand:SetVoiceTypePriority(2,1,1)
VoiceCommand:SetVoiceTypePriority(4,12,12)
VoiceCommand:SetVoiceTypePriority(5,1,1)
VoiceCommand:SetVoiceTypePriority(6,6,6)
VoiceCommand:SetVoiceTypePriority(7,10,10)
VoiceCommand:SetVoiceTypePriority(8,10,10)
VoiceCommand:SetVoiceTypePriority(10,17,17)
VoiceCommand:SetVoiceTypePriority(11,17,17)
VoiceCommand:SetVoiceTypePriority(12,11,11)
VoiceCommand:SetVoiceTypePriority(13,9,9)
VoiceCommand:SetVoiceTypePriority(15,14,14)
VoiceCommand:SetVoiceEventType(6,"DD_Intelmen")
VoiceCommand:SetVoiceEventType(5,"DD_RTR")
VoiceCommand:SetVoiceEventType(5,"DD_OPR")
VoiceCommand:SetVoiceEventType(5,"DD_TUTR")
VoiceCommand:SetVoiceEventType(6,"DD_Ishmael")
VoiceCommand:SetVoiceEventType(6,"DD_Ocelot")
VoiceCommand:SetVoiceEventType(6,"DD_Miller")
VoiceCommand:SetVoiceEventType(6,"DD_Huey")
VoiceCommand:SetVoiceEventType(6,"DD_CodeTalker")
VoiceCommand:SetVoiceEventType(6,"DD_Quiet")
VoiceCommand:SetVoiceEventType(6,"DD_SkullFace")
VoiceCommand:SetVoiceEventType(6,"DD_conversation_s10150")
VoiceCommand:SetVoiceEventType(10,"DD_MammalPod")
VoiceCommand:SetVoiceEventType(6,"DD_Paz")
VoiceCommand:SetVoiceEventType(5,"DD_missionUQ")
VoiceCommand:SetVoiceEventType(4,"DD_vox_SH_radio")
VoiceCommand:SetVoiceEventType(4,"DD_vox_SH_voice")
VoiceCommand:SetVoiceEventType(7,"DD_vox_ene_ld")
VoiceCommand:SetVoiceEventType(7,"DD_vox_cp_radio")
VoiceCommand:SetVoiceEventType(10,"DD_hostage")
VoiceCommand:SetVoiceEventType(10,"DD_chsol")
VoiceCommand:SetVoiceEventType(10,"DD_hostage")
VoiceCommand:SetVoiceEventType(10,"DD_hostage_fml")
VoiceCommand:SetVoiceEventType(10,"DD_hostage_ru")
VoiceCommand:SetVoiceEventType(10,"DD_hostage_ps")
VoiceCommand:SetVoiceEventType(10,"DD_hostage_af")
VoiceCommand:SetVoiceEventType(10,"DD_hostage_kg")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10052")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10085")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10033")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10081")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10091")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10115")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10200")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10211")
VoiceCommand:SetVoiceEventType(10,"DD_conversation_s10054")
VoiceCommand:SetVoiceEventType(10,"DD_vox_kaz_rt_ld")
VoiceCommand:SetVoiceEventType(10,"DD_Ishmael")
VoiceCommand:SetVoiceEventType(13,"DD_vox_ene_conversation")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10036")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10043")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10041")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10052")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10045")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10195")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10086")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10090")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10121")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10085")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10110")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10200")
VoiceCommand:SetVoiceEventType(13,"DD_conversation_s10120")
VoiceCommand:SetVoiceEventType(13,"CHSOL_conversation_s10120")
VoiceCommand:SetVoiceEventType(13,"CHSOL_conversation_s10200")
VoiceCommand:SetVoiceEventType(13,"CH_conversation_s10120")
VoiceCommand:SetVoiceEventType(13,"CH_conversation_s10200")
if TppGadgetManager then
  TppGadgetManager.InitSound()
end
if Bush then
  Bush.SetParameters{rotSpeedMax=foxmath.DegreeToRadian(1),alphaDistanceMin=1,alphaDistanceMax=3}
end
local platformName=Fox.GetPlatformName()
if platformName~="Windows"or not Editor then
  Fox.SetActMode"GAME"
end
GeoPathService.RegisterPathTag("Elude",0)
GeoPathService.RegisterPathTag("Jump",1)
GeoPathService.RegisterPathTag("Fence",2)
GeoPathService.RegisterPathTag("StepOn",3)
GeoPathService.RegisterPathTag("Behind",4)
GeoPathService.RegisterPathTag("Urgent",5)
GeoPathService.RegisterPathTag("Pipe",6)
GeoPathService.RegisterPathTag("Climb",7)
GeoPathService.RegisterPathTag("Rail",8)
GeoPathService.RegisterPathTag("ForceFallDown",9)
GeoPathService.RegisterPathTag("DontFallWall",10)
GeoPathService.RegisterPathTag("Move",11)
GeoPathService.RegisterEdgeTag("Stand",0)
GeoPathService.RegisterEdgeTag("Squat",1)
GeoPathService.RegisterEdgeTag("BEHIND_LOW",2)
GeoPathService.RegisterEdgeTag("FenceElude",3)
GeoPathService.RegisterEdgeTag("Elude",4)
GeoPathService.RegisterEdgeTag("Jump",5)
GeoPathService.RegisterEdgeTag("Fence",6)
GeoPathService.RegisterEdgeTag("StepOn",7)
GeoPathService.RegisterEdgeTag("Behind",8)
GeoPathService.RegisterEdgeTag("Urgent",9)
GeoPathService.RegisterEdgeTag("NoEnd",10)
GeoPathService.RegisterEdgeTag("NoStart",11)
GeoPathService.RegisterEdgeTag("FenceJump",12)
GeoPathService.RegisterEdgeTag("Wall",13)
GeoPathService.RegisterEdgeTag("NoWall",14)
GeoPathService.RegisterEdgeTag("ToIdle",15)
GeoPathService.RegisterEdgeTag("EnableFall",16)
GeoPathService.RegisterEdgeTag("NoFreeFall",17)
GeoPathService.RegisterEdgeTag("Fulton",18)
GeoPathService.RegisterEdgeTag("BEHIND_SNAP",19)
GeoPathService.RegisterEdgeTag("LineCheck",20)
GeoPathService.RegisterEdgeTag("FallNear",21)
GeoPathService.RegisterEdgeTag("FenceToStepOn",22)
GeoPathService.RegisterEdgeTag("ForceFallCatch",23)
GeoPathService.RegisterEdgeTag("Window",24)
GeoPathService.RegisterEdgeTag("AimIsBack",25)
GeoPathService.RegisterNodeTag("Edge",0)
GeoPathService.RegisterNodeTag("Cover",1)
GeoPathService.RegisterNodeTag("BEHIND_LOOK_IN",2)
GeoPathService.RegisterNodeTag("CHANGE_TO_60",3)
GeoPathService.RegisterNodeTag("NoTurn",4)
GeoPathService.RegisterNodeTag("BEHIND_STOP",5)
GeoPathService.RegisterNodeTag("NoOut",6)
GeoPathService.RegisterNodeTag("NoStart",7)
GeoPathService.RegisterNodeTag("EludeToElude",8)
GeoPathService.BindNodeTag("Elude","EludeToElude")
GeoPathService.BindEdgeTag("Elude","Wall")
GeoPathService.BindEdgeTag("Elude","NoWall")
GeoPathService.BindEdgeTag("Elude","NoEnd")
GeoPathService.BindEdgeTag("Elude","Urgent")
GeoPathService.BindEdgeTag("Elude","FenceElude")
GeoPathService.BindEdgeTag("Elude","EnableFall")
GeoPathService.BindEdgeTag("Elude","LineCheck")
GeoPathService.BindEdgeTag("Elude","ForceFallCatch")
GeoPathService.BindEdgeTag("Urgent","Wall")
GeoPathService.BindEdgeTag("Urgent","NoEnd")
GeoPathService.BindEdgeTag("Urgent","Urgent")
GeoPathService.BindEdgeTag("Urgent","FenceElude")
GeoPathService.BindEdgeTag("Urgent","LineCheck")
GeoPathService.BindEdgeTag("Urgent","ForceFallCatch")
GeoPathService.BindNodeTag("Behind","BEHIND_LOOK_IN")
GeoPathService.BindNodeTag("Behind","BEHIND_STOP")
GeoPathService.BindEdgeTag("Behind","BEHIND_LOW")
GeoPathService.BindEdgeTag("Behind","BEHIND_SNAP")
GeoPathService.BindEdgeTag("Behind","LineCheck")
GeoPathService.BindEdgeTag("Behind","AimIsBack")
GeoPathService.BindEdgeTag("Jump","FenceJump")
GeoPathService.BindEdgeTag("Jump","NoFreeFall")
GeoPathService.BindEdgeTag("Jump","LineCheck")
GeoPathService.BindNodeTag("Climb","Edge")
GeoPathService.BindNodeTag("Pipe","NoTurn")
GeoPathService.BindNodeTag("Pipe","NoOut")
GeoPathService.BindNodeTag("Pipe","NoStart")
GeoPathService.BindEdgeTag("Pipe","NoEnd")
GeoPathService.BindEdgeTag("Pipe","NoStart")
GeoPathService.BindEdgeTag("Fence","ToIdle")
GeoPathService.BindEdgeTag("Fence","EnableFall")
GeoPathService.BindEdgeTag("Fence","LineCheck")
GeoPathService.BindEdgeTag("Fence","FallNear")
GeoPathService.BindEdgeTag("Fence","FenceToStepOn")
GeoPathService.BindEdgeTag("Fence","Window")
GeoPathService.BindEdgeTag("StepOn","Fulton")
GeoPathService.BindEdgeTag("StepOn","LineCheck")
GeoPathService.BindEdgeTag("StepOn","Window")
local phDaemon=PhDaemon.GetInstance()
if platformName=="Xbox360"then
  PhDaemon.SetMemorySize(1792,1024,768)
elseif platformName=="PS3"then
  PhDaemon.SetMemorySize(1792,1024,768)
elseif platformName=="Windows"then
  if Editor then
    PhDaemon.SetMemorySize(5120,3072,2048)
  else
    PhDaemon.SetMemorySize(2560,1536,1024)
  end
else
  PhDaemon.SetMemorySize(2560,1536,1024)
end
PhDaemon.SetUpdateDtMax(1/15)
PhDaemon.SetWorldMin(Vector3(-4200,-1e3,-4200))
PhDaemon.SetWorldMax(Vector3(4200,3e3,4200))
phDaemon.SetCollisionGroupState(1,3,false)
phDaemon.SetCollisionGroupState(1,4,true)
phDaemon.SetCollisionGroupState(1,6,true)
phDaemon.SetCollisionGroupState(3,3,true)
phDaemon.SetCollisionGroupState(3,4,true)
phDaemon.SetCollisionGroupState(3,5,true)
phDaemon.SetCollisionGroupState(6,3,false)
phDaemon.SetCollisionGroupState(6,9,false)
phDaemon.SetCollisionGroupState(7,1,false)
phDaemon.SetCollisionGroupState(7,2,false)
phDaemon.SetCollisionGroupState(7,3,false)
phDaemon.SetCollisionGroupState(7,4,false)
phDaemon.SetCollisionGroupState(7,5,false)
phDaemon.SetCollisionGroupState(7,6,false)
phDaemon.SetCollisionGroupState(7,8,false)
phDaemon.SetCollisionGroupState(7,9,false)
phDaemon.SetCollisionGroupState(7,10,false)
phDaemon.SetCollisionGroupState(9,3,false)
phDaemon.SetCollisionGroupState(9,10,false)
phDaemon.SetCollisionGroupState(10,9,false)
phDaemon.SetCollisionGroupState(11,3,true)
phDaemon.SetCollisionGroupState(11,4,true)
phDaemon.SetCollisionGroupState(11,5,true)
phDaemon.SetCollisionGroupState(12,3,true)
phDaemon.SetCollisionGroupState(12,4,true)
phDaemon.SetCollisionGroupState(12,5,true)
dofile"Tpp/Scripts/Ui/TppUiBootInit.lua"
TppCassetteTapeInfo.Setup()
if Editor then
  package.path=package.path..";/Assets/tpp/editor_scripts/?.lua"
end
if Editor then
  local application=Application:GetInstance()
  local mainGame=application:GetMainGame()
  local mainScene=application:GetScene"MainScene"
  local setupBucket=mainGame:CreateBucket("SetupBucket",mainScene)
  setupBucket:LoadProjectFile"/Assets/tpp/level/location/SetupLocation2.fxp"
end
if platformName=="Windows"then
  if TppLightCapture then
    TppLightCapture.InitInstance()
  end
end
local systemBlockSize=(.73*1024)*1024
systemBlockSize=systemBlockSize+258*1024
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  systemBlockSize=635*1024
end
if platformName=="Xbox360"then
  systemBlockSize=systemBlockSize+20*1024
end
if platformName=="Windows"then
  systemBlockSize=((systemBlockSize+450*1024)+400*1024)+100*1024
elseif platformName=="XboxOne"then
  systemBlockSize=((systemBlockSize+450*1024)+400*1024)+100*1024
elseif platformName=="PS4"then
  systemBlockSize=((systemBlockSize+450*1024)+400*1024)+100*1024
end
TppGameSequence.SetSystemBlockSize(systemBlockSize,(40.5*1024)*1024)
TppGameSequence.LoadResidentBlock"/Assets/tpp/pack/resident/resident00.fpk"
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  Player.CreateResidentMotionBlock{size=((6*1024)*1024-8*1024)-(.55*1024)*1024}
  Player.CreateResidentPartsBlock{count=1,size=(1.45*1024)*1024+32*1024}
  Player.RegisterCommonMotionPackagePath("DefaultCommonMotion","/Assets/tpp/pack/player/motion/player2_resident_motion.fpk","/Assets/tpp/motion/motion_graph/player2/TppPlayer2_layers.mog")
  Player.RegisterCommonMtarPath("/Assets/tpp/motion/mtar/player2/player2_resident.mtar","/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar")
else
  Player.CreateResidentMotionBlock{size=12068883}
  Player.CreateResidentPartsBlock{count=16,size=1126*1024}
  vars.playerType=PlayerType.MGO_MALE
  vars.playerCamoType=PlayerCamoType.NONE
  vars.playerPartsType=PlayerPartsType.NORMAL
  vars.playerHandType=PlayerHandType.NONE
  local e=false
  if e then
    Player.RegisterCommonMotionPackagePath("DefaultCommonMotion","/Assets/tpp/pack/player/motion/player2_resident_motion.fpk","/Assets/tpp/motion/motion_graph/player2/TppPlayer2_layers.mog")
    Player.RegisterCommonMotionPackagePath("MgoCommonMotion","/Assets/tpp/pack/player/motion/player2_resident_motion.fpk","/Assets/tpp/motion/motion_graph/player2/TppPlayer2_layers.mog")
    Player.RegisterCommonMtarPath("/Assets/tpp/motion/mtar/player2/player2_resident.mtar","/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar")
  else
    Player.RegisterCommonMotionPackagePath("DefaultCommonMotion","/Assets/mgo/pack/player/motion/mgo_player_resident_motion.fpk","/Assets/mgo/motion/motion_graph/player/MgoPlayer_layers.mog")
    Player.RegisterCommonMotionPackagePath("MgoCommonMotion","/Assets/mgo/pack/player/motion/mgo_player_resident_motion.fpk","/Assets/mgo/motion/motion_graph/player/MgoPlayer_layers.mog")
    Player.RegisterCommonMtarPath("/Assets/mgo/motion/mtar/player/mgoplayer_resident.mtar","/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar")
  end
end
Player.RegisterCameraCaarPath"/Assets/tpp/motion/mtar/player2/player2_camera_anim.caar"
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  Player.RegisterPartsPackagePath("PLTypeNormal","/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeNormalScarf","/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk","/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeSneakingSuit","/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk","/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeHospital","/Assets/tpp/pack/player/parts/plparts_hospital.fpk","/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeMGS1","/Assets/tpp/pack/player/parts/plparts_mgs1.fpk","/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeRaiden","/Assets/tpp/pack/player/parts/plparts_raiden.fpk","/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts")
  Player.RegisterPartsPackagePath("PLTypeNinja","/Assets/tpp/pack/player/parts/plparts_ninja.fpk","/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts")
end
if TppSoldier2CommonBlockController then
  TppSoldier2CommonBlockController.CreateCommonMotionBlockGroup(9559*1024)
  TppSoldier2CommonBlockController.SetPackagePathWithPrerequisites{path="/Assets/tpp/pack/soldier/common/Soldier2Common.fpk"}
end
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  TppEquip.CreateResidentBlockGroups{commonBlockSize=(12*1024)*1024}
  TppEquip.LoadCommonBlock"/Assets/mgo/pack/collectible/common/col_common_mgo.fpk"
else
  TppEquip.CreateResidentBlockGroups{commonBlockSize=(1.9*1024)*1024,primary1BlockSize=(.55*1024)*1024,primary2BlockSize=(.55*1024)*1024,secondaryBlockSize=(.34*1024)*1024}
  TppEquip.LoadCommonBlock"/Assets/tpp/pack/collectible/common/col_common_tpp.fpk"
end
if TppSystemUtility.GetCurrentGameMode()=="MGO"and MgoActorBlockControllerService then
  MgoActorBlockControllerService:SetBlockInfo(MgoActor.MGO_ACTOR_BLOCK_PARTS,"/Assets/mgo/pack/actor/actor_parts.fpk",2048)
end
if Editor then
  TppEdMissionListEditInfo.SetConverterScriptPath"Tpp/Scripts/Classes/TppEdMissionConverterCaller.lua"
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    EdDemoEditBlockController.AddToolsBlockPath"/Assets/mgo/demo/event/info/MgoEdDemoEditTools.fpk"
  end
  EdDemoEditBlockController.AddToolsBlockPath"/Assets/tpp/demo/event/info/TppEdDemoEditTools.fpk"
end
if NavWorldDaemon then
  NavWorldDaemon.AddWorld{
    sceneName="MainScene",
    worldName="",
    maxLoadFileCount=64,
    maxChunkCountPerFile=7,
    maxGraphBounderCount=30,
    maxTacticalActionCount=120,
    navigationGraphDynamicLinkContainerInfo={maxArrayCount=810,extendCount=2},
    segmentGraphDynamicLinkContainerInfo={maxArrayCount=675,extendCount=2},
    segmentGraphDynamicPortalContainerInfo={maxArrayCount=635,extendCount=2},
    islandGraphDynamicLinkContainerInfo={maxArrayCount=360,extendCount=2}
  }
  NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="sky",maxLoadFileCount=1,maxChunkCountPerFile=5}
  NavWorldDaemon.AddWorld{sceneName="MainScene",worldName="sahelan",maxLoadFileCount=2,maxChunkCountPerFile=6}
end
TppMarker2System.CreateMarker2System()
local e=false
if TPP_MISSION_MANAGER_ENABLED then
  if e==false then
    TppGameSequence.RequestGameSetup()
  end
end
if TppNewCollectibleModule then
  TppNewCollectibleModule.InitializeWhenStartLua()
end
yield()
TppMotherBaseManagement.SetMbsClusterParam{category="Command",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="Combat",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="Develop",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="BaseDev",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="Support",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="Spy",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsClusterParam{category="Medical",grade=4,buildStatus="Completed"}
TppMotherBaseManagement.SetMbsContainerParam{commonMetalContainerCount=12,minorMetalContainerCount=5,preciousMetalContainerCount=9,fuelResourceContainerCount=14,bioticResourceCount=3}
TppMotherBaseManagement.SetMbsClusterSecurityParam{isNoKillMode=false,securitySoldierRank="C",securitySoldierEquipGrade=5,securitySoldierEquipRange=1}
TppMotherBaseManagement.SetMbsPlatformSecurityParam{platform="Special",soldierQuantity="Middle",irSensorQuantity="Small",cameraQuantity="Large",decoyQuantity="Middle",mineQuantity="Large",uavQuantity="Small",importantCautionAreas={false,true,true,false,false,true,true,false}}
TppMotherBaseManagement.SetMbsPlatformSecurityParam{platform="Common1",soldierQuantity="Middle",irSensorQuantity="Small",cameraQuantity="Large",decoyQuantity="Middle",mineQuantity="Large",uavQuantity="Small",importantCautionAreas={false,true,true,false,false,true,true,false}}
TppMotherBaseManagement.SetMbsPlatformSecurityParam{platform="Common2",soldierQuantity="Middle",irSensorQuantity="Small",cameraQuantity="Large",decoyQuantity="Middle",mineQuantity="Large",uavQuantity="Small",importantCautionAreas={false,true,true,false,false,true,true,false}}
TppMotherBaseManagement.SetMbsPlatformSecurityParam{platform="Common3",soldierQuantity="Middle",irSensorQuantity="Small",cameraQuantity="Large",decoyQuantity="Middle",mineQuantity="Large",uavQuantity="Small",importantCautionAreas={false,true,true,false,false,true,true,false}}
yield()
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/mission2/story/s10150/s10150_block01.fox2",1)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/slopedTown/afgh_slopedTown_gimmick.fox2",2)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/fort/afgn_fort_gimmick.fox2",17)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/field/afgh_field_gimmick.fox2",4)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/bridge/afgh_bridge_gimmick.fox2",5)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/cliffTown/afgh_cliffTown_gimmick.fox2",6)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/powerPlant/afgh_powerPlant_gimmick.fox2",7)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/tent/afgh_tent_gimmick.fox2",8)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_small/124/124_144/afgh_124_144_gimmick.fox2",9)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_gimmick.fox2",10)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/enemyBase/afgh_enemyBase_gimmick.fox2",11)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/commFacility/afgh_commFacility_gimmick.fox2",12)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/village/afgh_village_gimmick.fox2",13)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_large/sovietBase/afgh_sovietBase_asset.fox2",14)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/hill/mafr_hill_gimmick.fox2",15)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/diamond/mafr_diamond_gimmick.fox2",16)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/pfCamp/mafr_pfCamp_gimmick.fox2",3)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",18)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/banana/mafr_banana_gimmick.fox2",19)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/savannah/mafr_savannah_gimmick.fox2",20)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/swamp/mafr_swamp_gimmick.fox2",30)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/flowStation/mafr_flowStation_gimmick.fox2",27)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_large/outland/mafr_outland_gimmick.fox2",23)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_small/146/146_138/mafr_146_138_gimmick.fox2",24)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_small/144/144_127/mafr_144_127_gimmick.fox2",25)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mafr/block_small/149/149_116/mafr_149_116_gimmick.fox2",26)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_small/141/141_129/afgh_141_129_gimmick.fox2",22)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_small/136/136_138/afgh_136_138_gimmick.fox2",28)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_small/147/147_123/afgh_147_123_gimmick.fox2",29)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/afgh/block_small/141/141_147/afgh_141_147_gimmick.fox2",21)
Gimmick.RegisterCassetteToRadio("afgh_radi001_csst001_gim_n0000|srt_afgh_radi001_csst001","/Assets/tpp/level/location/mtbs/block_large/mtbs_qrntnFacility_gimmick.fox2",31)
yield()
if Script.LoadLibrary then
  local tppOrMgoPath
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    tppOrMgoPath="/Assets/mgo/"
  else
    tppOrMgoPath="/Assets/tpp/"
  end
  local e
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    e="/Assets/mgo/level_asset/weapon/ParameterTables/EquipIdTable.lua"
  else
    e="Tpp/Scripts/Equip/EquipIdTable.lua"
  end
  Script.LoadLibraryAsync(e)
  while Script.IsLoadingLibrary(e)do
    yield()
  end
  local e=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipParameters.lua"
  if TppEquip.IsExistFile(e)then
    Script.LoadLibrary(e)
  else
    Script.LoadLibrary"Tpp/Scripts/Equip/EquipParameters.lua"
  end
  yield()
  local e=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipMotionDataForChimera.lua"
  if TppEquip.IsExistFile(e)then
    Script.LoadLibrary(e)
  end
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceId.lua"
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyBodyId.lua"
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerProgression.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/ChimeraPartsPackageTable.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/EquipConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/WeaponParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/RulesetConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/SafeSpawnConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/SoundtrackConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/PresetRadioConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/player/Stats/StatTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/PointOfInterestConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/damage/ParameterTables/DamageParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipMotionData.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/MgoWeaponParameters.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/GearConfig.lua"
  else
    yield()
    Script.LoadLibrary"Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/damage/ParameterTables/DamageParameterTables.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2ParameterTables.lua"
    Script.LoadLibrary"Tpp/Scripts/Equip/EquipMotionData.lua"
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroupId.lua"
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroup.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2FaceAndBodyData.lua"
    yield()
  end
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
  else
    Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
  end
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/script/lib/Overrides.lua"
  end
  Script.LoadLibraryAsync"/Assets/tpp/script/lib/Tpp.lua"
  while Script.IsLoadingLibrary"/Assets/tpp/script/lib/Tpp.lua"do
    yield()
  end
  Script.LoadLibrary"/Assets/tpp/script/lib/TppDefine.lua"
  Script.LoadLibrary"/Assets/tpp/script/lib/TppVarInit.lua"
  Script.LoadLibrary"/Assets/tpp/script/lib/TppGVars.lua"
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/script/utils/SaveLoad.lua"
    Script.LoadLibrary"/Assets/mgo/script/lib/PostTppOverrides.lua"
    Script.LoadLibrary"/Assets/mgo/script/lib/MgoMain.lua"
    Script.LoadLibrary"Tpp/Scripts/System/Block/Overflow.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/TppMissionList.lua"
    Script.LoadLibrary"/Assets/mgo/script/utils/Utils.lua"
    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterGear.lua"
    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterConnectPointFiles.lua"
    Script.LoadLibrary"/Assets/mgo/script/player/PlayerResources.lua"
    Script.LoadLibrary"/Assets/mgo/script/player/PlayerDefaults.lua"
    Script.LoadLibrary"/Assets/mgo/script/Matchmaking.lua"
  else
    Script.LoadLibrary"/Assets/tpp/script/list/TppMissionList.lua"
    Script.LoadLibrary"/Assets/tpp/script/list/TppQuestList.lua"
    if platformName=="PS3"then
      Script.LoadLibrary"/Assets/tpp/script/list/TppMissionPrxList.lua"
    end
  end
end
yield()
pcall(dofile,"/Assets/tpp/ui/Script/UiRegisterInfo.lua")
yield()
if TppSystemUtility.GetCurrentGameMode()=="TPP"then
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/player/game_object/player2_camouf_param.lua"
end
yield()
if Editor then
  TppGeoMaterial.EDIT_CheckWastedMaterialNames()
end
if Game.DEBUG_AddScript then
  local ok,err=pcall(function()
    local e=io.open("tmp/my_debug_script.lua","r")
    if e then
      local e=e:read"*a"
      local t=Application.GetInstance()
      local t=t:GetMainGame()
      t:DEBUG_AddScript(e)
    end
  end)
  if not ok then
  end
end
if Game.DEBUG_AddScript then
  local e=io.open("Tpp/tmp/release_test_script.lua","r")
  if e then
    local t=e:read"*a"
    local e=Application.GetInstance()
    local e=e:GetMainGame()
    e:DEBUG_AddScript(t)
    Script.LoadLibrary"/Assets/tpp/editor_scripts/tpp_editor_menu2.lua"
    Script.LoadLibrary"/Assets/tpp/script/entry/MissionEntry.lua"
    Script.LoadLibrary"/Assets/tpptest/script/lib/MissionTest.lua"
  end
end
math.randomseed(os.time())
yield()
GrTools.SetSunLightReflectionMapShader"TPPSunLightReflectMap"
GrTools.SetEnvironmentSpecularCubeTexture"/Assets/tpp/effect/gr_pic/gr_cub01_sm_SkySpecCommon.ftex"
GrTools.SetEnableLocalReflection(true)
GrTools.SetLightingColorScale(1.8)
yield()
do
  local e=coroutine.create(loadfile"Tpp/Scripts/System/start2nd.lua")
  repeat
    coroutine.yield()
    local a,t=coroutine.resume(e)
    if not a then
      error(t)
    end
  until coroutine.status(e)=="dead"
end
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
  dofile"Tpp/Scripts/System/start3rd.lua"
end
yield()
while SplashScreen.GetSplashScreenWithName"cesa"do
  yield()
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil,{setMute=true})
TppVarInit.InitializeOnStartTitle()
TppVarInit.StartInitMission()
TppUiCommand.SetLoadIndicatorVisible(false)

--local splash=SplashScreen.Create("startend","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)--tex

--SplashScreen.Show(splash,.2,1,.2)--tex

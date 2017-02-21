local platform=Fox.GetPlatformName()
local deviceName=""
if GrTools then
  deviceName=GrTools.GetDeviceName()
end
local enableWindowsDX11Texture=true
if not AssetConfiguration.IsDiscOrHddImage()then
  enableWindowsDX11Texture=AssetConfiguration.GetConfigurationFromAssetManager"EnableWindowsDX11Texture"
end
if platform=="Windows"then
  AssetConfiguration.SetDefaultTargetDirectory"#Win"
  if enableWindowsDX11Texture then
    AssetConfiguration.SetTargetDirectory("ftex","#windx11")
    AssetConfiguration.SetTargetDirectory("ftexs","#windx11")
    AssetConfiguration.SetTargetDirectory("pftxs","#windx11")
    AssetConfiguration.SetTargetDirectory("fpk","#windx11")
    AssetConfiguration.SetTargetDirectory("fpkd","#windx11")
  else
    AssetConfiguration.SetTargetDirectory("ftex","#Win")
    AssetConfiguration.SetTargetDirectory("ftexs","#Win")
  end
elseif platform=="Xbox360"then
  AssetConfiguration.SetDefaultTargetDirectory"#Xbox"
elseif platform=="PS3"then
  AssetConfiguration.SetDefaultTargetDirectory"#PS3"
elseif platform=="XboxOne"then
  AssetConfiguration.SetDefaultTargetDirectory"#Win"
  AssetConfiguration.SetTargetDirectory("ftex","#windx11")
  AssetConfiguration.SetTargetDirectory("ftexs","#windx11")
  AssetConfiguration.SetTargetDirectory("ffnt","#windx11")
  AssetConfiguration.SetTargetDirectory("fnt","#windx11")
  AssetConfiguration.SetTargetDirectory("pftxs","#xone")
  AssetConfiguration.SetTargetDirectory("fpk","#xone")
  AssetConfiguration.SetTargetDirectory("fpkd","#xone")
  AssetConfiguration.SetTargetDirectory("bnk","#xone")
  AssetConfiguration.SetTargetDirectory("sbp","#xone")
  AssetConfiguration.SetTargetDirectory("fsm","#Win")
  AssetConfiguration.SetTargetDirectory("mas","#Win")
elseif platform=="PS4"then
  AssetConfiguration.SetDefaultTargetDirectory"#Win"
  AssetConfiguration.SetTargetDirectory("ftex","#windx11")
  AssetConfiguration.SetTargetDirectory("ftexs","#windx11")
  AssetConfiguration.SetTargetDirectory("ffnt","#windx11")
  AssetConfiguration.SetTargetDirectory("fnt","#windx11")
  AssetConfiguration.SetTargetDirectory("pftxs","#ps4")
  AssetConfiguration.SetTargetDirectory("fpk","#ps4")
  AssetConfiguration.SetTargetDirectory("fpkd","#ps4")
  AssetConfiguration.SetTargetDirectory("bnk","#ps4")
  AssetConfiguration.SetTargetDirectory("sbp","#ps4")
  AssetConfiguration.SetTargetDirectory("fsm","#Win")
  AssetConfiguration.SetTargetDirectory("mas","#Win")
elseif platform=="Android"then
  AssetConfiguration.SetDefaultTargetDirectory"#Android"
elseif platform=="iOS"then
  AssetConfiguration.SetDefaultTargetDirectory"#iOS"
end
AssetConfiguration.SetDefaultCategory("Language","jpn")
if SubtitlesDaemon then
  SubtitlesDaemon.SetDefaultVoiceLanguage"jpn"
end
AssetConfiguration.RegisterExtensionInfo{
  extensions={"bnk","col","demo","demox","dfrm","evb","fclo","fcnp","fdes","fmdl","fmdlb","info","fpk","fpkd","frdv","frig","fstb","ftex","ftexs","gani","lani","mtar","mtard","caar","geom","gskl","nav","nav2","sani","sand","mog","fv2","cani","fmtt","lpsh","ffnt","fova","pftxs","frl","frld","frt","atsh","pcsp","uia","uif","uilb","uigb","fnt","rdf","nta","subp","lba","ladb","lng"},
  categories={"Target"}
  }
AssetConfiguration.RegisterExtensionInfo{extensions={"sad","evfl"},categories={"Language"}}
AssetConfiguration.RegisterExtensionInfo{extensions={"sbp","stm","mas","wem","fsm"},categories={"Target","Language"}}
if GrDaemon then
  if platform=="Windows"then
    if deviceName=="directx9"then
      GrTools.LoadShaderPack"shaders/win32/GrSystemShaders_win32.fsop"
      GrTools.LoadShaderPack"shaders/win32/GrModelShaders_win32.fsop"
      GrTools.LoadShaderPack"shaders/win32/FxShaders_win32.fsop"
    end
    if deviceName=="directx11"then
      GrTools.LoadShaderPack"shaders/dx11/GrSystemShaders_dx11.fsop"
      GrTools.LoadShaderPack"shaders/dx11/GrModelShaders_dx11.fsop"
      GrTools.LoadShaderPack"shaders/dx11/FxShaders_dx11.fsop"
    end
  elseif platform=="Xbox360"then
    GrTools.LoadShaderPack"shaders\\xbox360\\GrSystemShaders_x360.fsop"
    GrTools.LoadShaderPack"shaders\\xbox360\\GrModelShaders_x360.fsop"
    GrTools.LoadShaderPack"shaders\\xbox360\\FxShaders_x360.fsop"
  elseif platform=="XboxOne"then
    GrTools.LoadShaderPack"shaders\\xboxone\\GrSystemShaders_xone.fsop"
    GrTools.LoadShaderPack"shaders\\xboxone\\GrModelShaders_xone.fsop"
    GrTools.LoadShaderPack"shaders\\xboxone\\FxShaders_xone.fsop"
  elseif platform=="PS3"then
    GrTools.LoadShaderPack"shaders/ps3/GrSystemShaders_ps3.fsop.sdat"
    GrTools.LoadShaderPack"shaders/ps3/GrModelShaders_ps3.fsop.sdat"
    GrTools.LoadShaderPack"shaders/ps3/FxShaders_ps3.fsop.sdat"
  elseif platform=="PS4"then
    GrTools.LoadShaderPack"shaders/ps4/GrSystemShaders_ps4.fsop"
    GrTools.LoadShaderPack"shaders/ps4/GrModelShaders_ps4.fsop"
    GrTools.LoadShaderPack"shaders/ps4/FxShaders_ps4.fsop"
  end
  GrTools.SetupSystemShaderResources()
end
if GrDaemon then
  GrTools():EnableTextureStreaming()
  if(platform=="Windows"or platform=="XboxOne")or platform=="PS4"then
    GrTools.FontSystemInit((((1024*1024)*2)+(1024*500)))--RETAILPATCH: 1006 was *200
  else
    GrTools.FontSystemInit((((1024*1024)*1)+(1024*700)))
  end
  GrTools.FontSystemLoad("FontSystem_DebugFont","/Assets/fox/font/DebugFont.ffnt")
  if platform=="Windows"then
    if deviceName=="directx9"then
      dofile"Fox/Scripts/Gr/gr_init.lua"
      GrTools.SetEnablePackedSmallTextureStreaming(true)
    end
    if deviceName=="directx11"then
      dofile"Fox/Scripts/Gr/gr_init_dx11.lua"
      if Editor then
        GrTools.SetEnablePackedSmallTextureStreaming(false)
      else
        GrTools.SetEnablePackedSmallTextureStreaming(true)
      end
    end
  elseif platform=="Xbox360"then
    dofile"Fox/Scripts/Gr/gr_init_x360.lua"
    GrTools.SetEnablePackedSmallTextureStreaming(true)
  elseif platform=="XboxOne"then
    dofile"Fox/Scripts/Gr/gr_init_xone.lua"
    GrTools.SetEnablePackedSmallTextureStreaming(true)
  elseif platform=="PS3"then
    dofile"Fox/Scripts/Gr/gr_init_ps3.lua"
    GrTools.SetEnablePackedSmallTextureStreaming(true)
  elseif platform=="PS4"then
    dofile"Fox/Scripts/Gr/gr_init_ps4.lua"
    GrTools.SetEnablePackedSmallTextureStreaming(true)
  end
  GrTools.SetTextureStreamingLoadRateBaseCount(512)
  if enableWindowsDX11Texture then
    GrTools.SetEnableLnmForTerrainNormal(false)
    GrTools.SetEnableLnmForDecalNormal(false)
  else
    GrTools.SetEnableLnmForTerrainNormal(true)
    GrTools.SetEnableLnmForDecalNormal(true)
  end
  if platform=="XboxOne"or platform=="PS4"then
    GrTools.SetEnableLnmForTerrainNormal(false)
    GrTools.SetEnableLnmForDecalNormal(false)
  end
  if platform=="Xbox360"or platform=="PS3"then
    GrTools.SetEnableLnmForTerrainNormal(true)
    GrTools.SetEnableLnmForDecalNormal(true)
  end
end
local mainApplication=Application{name="MainApplication"}
local game
local editor
if Editor then
  game=Editor{name="MainEditor"}
  editor=game
elseif EditorBase then
  game=EditorBase{name="MainEditor"}
  editor=game
else
  game=Game{name="MainGame"}
end
mainApplication:AddGame(game)
mainApplication:SetMainGame(game)
local mainScene=game:CreateScene"MainScene"
local mainBucket=game:CreateBucket("MainBucket",mainScene)
game:SetMainBucket(mainBucket)
PathMapper.Add("AiSampleGame","Fox/Tests/Scripts/Character")
if EditableBlockPackage then
  EditableBlockPackage.RegisterPackageExtensionInfo{
    {"fmdl",false},
    {"geom",false},
    {"gskl",false},
    {"fcnp",false},
    {"frdv",false},
    {"fdes",false},
    {"gani",false},
    {"lani",false},
    {"sani",false},
    {"sand",false},
    {"evb",false},
    {"mtar",false},
    {"mtard",false},
    {"caar",false},
    {"uif",false},
    {"uia",false},
    {"uilb",false},
    {"uigb",false},
    {"mog",false},
    {"fclo",false},
    {"rdf",false},
    {"lba",false},
    {"dmy",false},
    {"pcsp",false},
    {"ladb",false},
    {"lua",true},
    {"sdf",true},
    {"fsd",true},
    {"lad",true},
    {"sim",true},
    {"ph",true},
    {"phsd",true},
    {"tgt",true},
    {"bnd",true},
    {"des",true},
    {"path",true},
    {"veh",true},
    {"clo",true},
    {"fcnpx",true},
    {"vfxlf",true},
    {"vfx",true},
    {"parts",true},
    {"evf",true},
    {"fsml",true},
    {"fage",true},
    {"fago",true},
    {"fag",true},
    {"fagx",true},
    {"aibc",true},
    {"aib",true},
    {"uil",true},
    {"uig",true},
    {"testd",true},
    {"fox2",true},
    {"fxp2",true}
  }
end
if GrDaemon then
  local grDaemon=GrDaemon{name="GrDaemon"}
end
if GrDaemon then
  if platform=="Windows"then
    if deviceName=="directx9"then
      if enableWindowsDX11Texture then
        dofile"shaders/win32/GrSystemShadersNoLnm_win32.lua"
        dofile"shaders/win32/GrModelShadersNoLnm_win32.lua"
        dofile"shaders/win32/FxShadersNoLnm_win32.lua"
      else
        dofile"shaders/win32/GrSystemShaders_win32.lua"
        dofile"shaders/win32/GrModelShaders_win32.lua"
        dofile"shaders/win32/FxShaders_win32.lua"
      end
    end
    if deviceName=="directx11"then
      if enableWindowsDX11Texture then
        dofile"shaders/dx11/GrSystemShadersNoLnm_dx11.lua"
        dofile"shaders/dx11/GrModelShadersNoLnm_dx11.lua"
        dofile"shaders/dx11/FxShadersNoLnm_dx11.lua"
      else
        dofile"shaders/dx11/GrSystemShaders_dx11.lua"
        dofile"shaders/dx11/GrModelShaders_dx11.lua"
        dofile"shaders/dx11/FxShaders_dx11.lua"
      end
    end
  elseif platform=="Xbox360"then
    dofile"shaders/xbox360/GrSystemShaders_x360.lua"
    dofile"shaders/xbox360/GrModelShaders_x360.lua"
    dofile"shaders/xbox360/FxShaders_x360.lua"
  elseif platform=="XboxOne"then
    dofile"shaders/xboxone/GrSystemShadersNoLnm_xone.lua"
    dofile"shaders/xboxone/GrModelShadersNoLnm_xone.lua"
    dofile"shaders/xboxone/FxShadersNoLnm_xone.lua"
  elseif platform=="PS3"then
    dofile"shaders/ps3/GrSystemShaders_ps3.lua"
    dofile"shaders/ps3/GrModelShaders_ps3.lua"
    dofile"shaders/ps3/FxShaders_ps3.lua"
  elseif platform=="PS4"then
    dofile"shaders/ps4/GrSystemShadersNoLnm_ps4.lua"
    dofile"shaders/ps4/GrModelShadersNoLnm_ps4.lua"
    dofile"shaders/ps4/FxShadersNoLnm_ps4.lua"
  end
end
if SoundCoreDaemon then
  SoundCoreDaemon.Create()
  if SoundDaemon then
    SoundDaemon.Create()
    if SoundEditorDaemon then
      local e=SoundEditorDaemon{}
    end
  end
end
if LipSyncDaemon then
  LipSyncDaemon.Create()
end
if EdRbCommand then
  EdRbCommand{}
end
if CameraPriority then
  CameraPriority.RegisterPriorities{"Debug","Editor","Demo","Game","GameWeakest"}
end
if CameraSelector then
  local e=CameraSelector{name="MainCameraSelector",scene="MainScene",viewport="MainViewport",priorities={"Debug","Editor","Demo","Game","GameWeakest"},listener="MainListener",rumble={0,1,2,3}}
  e:SetMainListener()
  CameraSelector.SetMainInstance(e)
end
if editor then
  editor:Setup()
  if Editor then
    Editor.Setting(editor)
  end
  local editableBucket=editor:CreateNewEditableBucket"NewBucket"
  editor:SetCurrentEditableBucket(editableBucket)
  if platform=="Windows"then
    Fox.ExportSerializeInfo()
  end
end
if FxDaemon then
  FxDaemon.Initialize()
  FxDaemon.InitializeReserveObject"FxShaderPool"
  FxDaemon.InitializeReserveObject"FxMaterialManager"
  FxDaemon.InitializeReserveObject"FxTextureManager"
  FxDaemon.InitializeReserveObject"FxDecalSurfaceManager"
  FxDaemon.InitializeReserveObject"FxBlowOutEffectManager"
end
if Pad2 then
  Pad2.Init{logCount=60}
end
if Pad then
  Pad.ConfigDefaultAssigns()
end
if PadMapping then
  local e=PadMapping()
end
if ReplayService then
  ReplayService.Boot()
end
if NavWorldDaemon then
  NavWorldDaemon.AddScene"MainScene"
end
if PhDaemon then
  PhDaemon.SetMemorySize(2560,1536,1024)
  PhDaemon.SetMaxRigidBodyNum(500)
  local e=PhDaemon()
end
if SimDaemon then
  local e=SimDaemon()
  e.defaultViewPort="MainViewport"
end
if DesDaemon then
  local e=DesDaemon()
end
if NtDaemon then
  NtDaemon.Create()
end
if FoxTestLuaActor then
  if FoxTestLuaActor then
    FoxTestLuaActor.ExecGlobal'dofile("script/luaunit.lua")'
  end
end
if UiDaemon then
  local e=UiDaemon{name="UiDaemon"}
end
if LangDaemon then
  local e=LangDaemon{name="LangDaemon"}
end
if SubtitlesDaemon then
  local e=SubtitlesDaemon{name="SubtitlesDaemon"}
end
if SubtitlesCommand then
  local e=SubtitlesDaemon.GetDefaultVoiceLanguage()
  SubtitlesCommand.SetVoiceLanguage(e)
  local e=AssetConfiguration.GetDefaultCategory"Language"
  SubtitlesCommand.SetLanguage(e)
end
if PreviewDaemon then
  local e=PreviewDaemon{}
end
if EnvironmentDaemon then
  local e=EnvironmentDaemon{}
  if WindManager then
    local e=WindManager{}
  end
end
local e=Fox.GetPlatformName()
if GrDaemon then
  if e=="Windows"then
    local e=""
    if GrTools then
      e=GrTools.GetDeviceName()
    end
    if e=="directx11"then
      FoxGameFrame.SetGameFrameWaitType"VirtualVsyncDx11"
    else
      FoxGameFrame.SetGameFrameWaitType"VirtualVsync"
    end
  end
  if e=="Xbox360"then
    FoxGameFrame.SetGameFrameWaitType"ExternalVsyncOffset"
  end
  if e=="PS3"then
    FoxGameFrame.SetGameFrameWaitType"ExternalWait"
  end
  if e=="XboxOne"then
    FoxGameFrame.SetGameFrameWaitType"ExternalWait"
  end
  if e=="PS4"then
    FoxGameFrame.SetGameFrameWaitType"VirtualVsyncDx11"
  end
end
if PerformanceViewer then
  local e=PerformanceViewer{name="PerformanceViewer"}
  e:Invisible()
  mainScene:AddActor(e)
end
if MemoryViewer then
  local e=MemoryViewer{name="MemoryViewer"}
  e:Invisible()
  mainScene:AddActor(e)
end
if MiniPerfView then
  MiniPerfView.SetEnable(true)
end
if BlockSizeView then
  BlockSizeView.SetEnable(true)
end
if SyncEditor then
  if e=="Windows"then
    SyncEditor{name="syncEditor",scene="MainScene"}
  end
end
if ConnectionPrintInfo then
  ConnectionPrintInfo{name="ConnectionPrintInfo"}
end
if SoundCommand then
  local e=SoundCommand{}
end
if Editor then
  Fox.SetActMode"EDIT"
end
if e=="Windows"then
  if GrxLightCapture then
    GrxLightCapture():InitInstance()
  end
end
if FoxFadeIo then
  FoxFadeIo.Create()
end
if Editor then
  package.path=package.path..";/Assets/fox/editor_scripts/?.lua"
  package.path=package.path..";/Assets/mgo/editor_scripts/?.lua"
end
if Editor then
  EdDemoEditBlockController.AddToolsBlockPath"/Assets/fox/demo/event/info/EdDemoEditTools.fpk"
  EdDemoEditBlockController.AddToolsBlockPath"/Assets/fox/demo/event/info/EdProceduralDemoEditTools.fpk"
end
if EdRouteDataNodeEvent then
  EdRouteDataNodeEvent.SetEventDefinitionPath("DummyRoute","Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua")
  EdRouteDataEdgeEvent.SetEventDefinitionPath("DummyRoute","Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua")
end
Fox.SetBreakIgnore(true)

do
  return{}
end
local this={}
function this.SetPlayLogEnabled(enable)
  if TppPlayLog then
    TppPlayLog.SetPlayLogEnabled(enable)
  end
end
function this.RequestResetPlayLog()
  if TppPlayLog then
    TppPlayLog.RequestResetPlayLog()
  end
end
function this.RequestUploadPlayLog()
  if TppPlayLog then
    TppPlayLog.RequestUploadPlayLog()
  end
end
function this.ExportSavedPlayLog()
  if TppPlayLog and TppPlayLog.ExportSavedPlayLog then
    TppPlayLog.ExportSavedPlayLog()
  end
end
this.PERF_CHECK_TYPE=Tpp.Enum{"OnUpdate","OnMessage","OnEnter"}
local perfCheckTimes={}
local unk2Table={}
local perfCheckTimesStrings={}
local unk4Num=2
local unk5Num=0
local unk6Num=0
local ApendArray=Tpp.ApendArray
local IsTypeTable=Tpp.IsTypeTable
local IsTimerActive=GkEventTimerManager.IsTimerActive
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
this.Colors={
  black=Color(0,0,0,1),
  white=Color(1,1,1,1),
  red=Color(1,0,0,1),
  green=Color(0,1,0,1),
  blue=Color(0,0,1,1),
  yellow=Color(1,1,0,1),
  magenta=Color(1,0,1,1),
  cyan=Color(0,1,1,1),
  darkRed=Color(.5,0,0,1),
  darkGreen=Color(0,.5,0,1),
  darkBlue=Color(0,0,.5,1),
  darkYellow=Color(.5,.5,0,1),
  purple=Color(.5,0,.5,1),
  darkCyan=Color(0,.5,.5,1)
}
function this.DEBUG_SetSVars(setList)
  if not IsTypeTable(setList)then
    return
  end
  for name,value in pairs(setList)do
    Tpp._DEBUG_svars[name]=value
  end
end
function this.DEBUG_SetGVars(setList)
  if not IsTypeTable(setList)then
    return
  end
  for name,value in pairs(setList)do
    Tpp._DEBUG_gvars[name]=value
  end
end
function this.DEBUG_RestoreSVars()
  if next(Tpp._DEBUG_svars)then
    for name,value in pairs(Tpp._DEBUG_svars)do
      svars[name]=value
    end
    TppSave.VarSave()
  end
end
function this.DEBUG_SetOrderBoxPlayerPosition()
  if next(Tpp._DEBUG_gvars)then
    if Tpp._DEBUG_gvars.mis_orderBoxName then
      TppMission.SetMissionOrderBoxPosition(Tpp._DEBUG_gvars.mis_orderBoxName)
      TppSave.VarSave()
    end
  end
end
function this.DEBUG_SVarsClear()
  if next(Tpp._DEBUG_svars)then
    for name,value in pairs(Tpp._DEBUG_svars)do
      if name=="dbg_seq_sequenceName"then
        TppSave.ReserveVarRestoreForContinue()
      end
    end
    Tpp._DEBUG_svars={}
    TppSave.VarSave()
  end
end
function this.DEBUG_GetSysVarsLog()
  local svars=svars or{}
  local mvars=mvars or{}
  local svarsLog={
    "missionName = "..(tostring(mvars.mis_missionName)..(", vars.missionCode = "..(tostring(vars.missionCode)..(", vars.locationCode = "..tostring(vars.locationCode))))),
    "mvars.mis_missionStateIsNotInGame = "..tostring(mvars.mis_missionStateIsNotInGame),
    "missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]),
    "gvars.pck_missionPackLabelName = "..tostring(gvars.pck_missionPackLabelName),
    "gvars.mis_orderBoxName = "..tostring(gvars.mis_orderBoxName),
    "gvars.heli_missionStartRoute = "..tostring(gvars.heli_missionStartRoute),
    "gvars.mis_nextMissionCodeForMissionClear = "..tostring(gvars.mis_nextMissionCodeForMissionClear),
    "gvars.mis_nextMissionCodeForEmergency = "..tostring(gvars.mis_nextMissionCodeForEmergency),
    "vars.mbLayoutCode = "..(tostring(vars.mbLayoutCode)..(", mvars.mis_nextLayoutCode = "..tostring(mvars.mis_nextLayoutCode))),
    "vars.mbClusterId = "..(tostring(vars.mbClusterId)..(", mvars.mis_nextClusterId = "..tostring(mvars.mis_nextClusterId))),
    "mvars.mis_isOutsideOfMissionArea = "..tostring(mvars.mis_isOutsideOfMissionArea),
    "svars.mis_isDefiniteGameOver = "..(tostring(svars.mis_isDefiniteGameOver)..(", svars.mis_isDefiniteMissionClear = "..tostring(svars.mis_isDefiniteMissionClear))),
    "gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize),
    "gvars.canExceptionHandling = "..tostring(gvars.canExceptionHandling),
    "vars.playerVehicleGameObjectId = "..tostring(vars.playerVehicleGameObjectId),
    "TppServerManager.FobIsSneak() = "..tostring(TppServerManager.FobIsSneak()),
    "svars.scoreTime = "..tostring(svars.scoreTime)}
  return svarsLog
end
function this.DEBUG_WarpHelicopter(RENHeliName,route,position,point,setRoute)
  if not IsTypeTable(soldierNameTable)then--RETAILBUG orphan
    soldierNameTable={soldierNameTable}
  end
  local GetGameObjectId=GameObject.GetGameObjectId
  local SendCommand=GameObject.SendCommand
  if not point then
    point=0
  end
  for k,soldierName in pairs(soldierNameTable)do
    local soldierId=GetGameObjectId(soldierName)
    SendCommand(soldierId,{id="SetEnabled",enabled=false})
    SendCommand(soldierId,{id="SetSneakRoute",route=route,point=point})
    SendCommand(soldierId,{id="SetCautionRoute",route=route,point=point})
    if setRoute then
      SendCommand(soldierId,{id="SetAlertRoute",enabled=true,route=route,point=point})
    else
      SendCommand(soldierId,{id="SetAlertRoute",enabled=false,route="",point=point})
    end
    SendCommand(soldierId,{id="SetEnabled",enabled=true})
  end
  local heliId=GetGameObjectId(RENHeliName)
  SendCommand(heliId,{id="SetPosition",position=position,rotY=0})
end
function this.DEBUG_WarpVehicleAndSoldier(soldierNameTable,vehiclename,route,position,point,setRoute)
  if not IsTypeTable(soldierNameTable)then
    soldierNameTable={soldierNameTable}
  end
  local GetGameObjectId=GameObject.GetGameObjectId
  local SendCommand=GameObject.SendCommand
  if not point then
    point=0
  end
  for k,soldierName in pairs(soldierNameTable)do
    local soldierId=GetGameObjectId(soldierName)
    SendCommand(soldierId,{id="SetEnabled",enabled=false})
    SendCommand(soldierId,{id="SetSneakRoute",route=route,point=point})
    SendCommand(soldierId,{id="SetCautionRoute",route=route,point=point})
    if setRoute then
      SendCommand(soldierId,{id="SetAlertRoute",enabled=true,route=route,point=point})
    else
      SendCommand(soldierId,{id="SetAlertRoute",enabled=false,route="",point=point})
    end
    SendCommand(soldierId,{id="SetEnabled",enabled=true})
  end
  local vehicleId=GetGameObjectId(vehiclename)
  SendCommand(vehicleId,{id="SetPosition",position=position,rotY=0})
end
this.DEBUG_SkipOnChangeSVarsLog={timeLimitforSneaking=true,timeLimitforNonAbort=true}
function this.DEBUG_AddSkipLogSVarsName(svarName)
  this.DEBUG_SkipOnChangeSVarsLog[svarName]=true
end
function this.DEBUG_FobGPU()
  local Debug_setupfob=function(topologyType)
    math.randomseed(os.time())
    TppMotherBaseManagement.SetGmp{gmp=1e6}
    local staffCount=300
    if TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs then
      TppMotherBaseManagement.DEBUG_DirectAddRandomStaffs{count=staffCount}
    end
    do
      local resources={CommonMetal=100,MinorMetal=100,PreciousMetal=100,FuelResource=100,BioticResource=100}
      for resourceId,count in pairs(resources)do
        TppMotherBaseManagement.SetResourceSvars{resource=resourceId,usableCount=count,processingCount=count,got=true,isNew=false}
      end
      local plants={Plant2000=100,Plant2001=100,Plant2002=100,Plant2003=100,Plant2004=100,Plant2005=100,Plant2006=100,Plant2007=100,Plant2008=100}
      for plantId,count in pairs(plants)do
        TppMotherBaseManagement.SetResourceSvars{resource=plantId,usableCount=count,processingCount=0,got=true,isNew=false}
      end
    end
    do
      local colors={"Orange","Blue","Black","Blick","Gray","Od","Pink","Sand"}
      local randomColor=math.random(1,#colors)
      TppMotherBaseManagement.SetFobSvars{fob="Fob1",got=true,oceanAreaId=70,topologyType=topologyType,color=colors[randomColor]}
      local categories={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
      for e,category in ipairs(categories)do
        local grade=math.random(4,4)
        TppMotherBaseManagement.SetClusterSvars{base="Fob1",category=category,grade=grade,buildStatus="Completed",timeMinute=0,isNew=false}
      end
      for a,category in ipairs(categories)do
        local grade=math.random(1,1)
        TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category=category,grade=grade,buildStatus="Completed",timeMinute=0,isNew=false}
      end
    end
    TppSave.VarSave(40010,true)
    TppSave.VarSaveOnRetry()
    TppSave.SaveGameData()
  end
  Debug_setupfob(90)
end
function this.DEBUG_SetFobPlayerSneak()
  vars.avatarFaceRaceIndex=0
  vars.avatarAcceFlag=0
  vars.avatarFaceTypeIndex=1
  vars.avatarFaceVariationIndex=1
  vars.avatarFaceColorIndex=0
  vars.avatarHairStyleIndex=0
  vars.avatarRightEyeColorIndex=0
  vars.avatarRightEyeBrightnessIndex=0
  vars.avatarLeftEyeColorIndex=1
  vars.avatarLeftEyeBrightnessIndex=0
  vars.avatarHairColor=1
  vars.avatarBerdStyle=0
  vars.avatarBerdLength=1
  vars.avatarEbrwStyle=3
  vars.avatarEbrwWide=1
  vars.avatarGashOrTatoVariationIndex=0
  vars.avatarTatoColorIndex=0
  vars.avatarMotionFrame[0]=4
  vars.avatarMotionFrame[1]=9
  vars.avatarMotionFrame[2]=5
  vars.avatarMotionFrame[3]=5
  vars.avatarMotionFrame[4]=7
  vars.avatarMotionFrame[5]=1
  vars.avatarMotionFrame[6]=7
  vars.avatarMotionFrame[7]=4
  vars.avatarMotionFrame[8]=4
  vars.avatarMotionFrame[9]=5
  vars.avatarMotionFrame[10]=5
  vars.avatarMotionFrame[11]=6
  vars.avatarMotionFrame[12]=5
  vars.avatarMotionFrame[13]=10
  vars.avatarMotionFrame[14]=8
  vars.avatarMotionFrame[15]=4
  vars.avatarMotionFrame[16]=6
  vars.avatarMotionFrame[17]=10
  vars.avatarMotionFrame[18]=0
  vars.avatarMotionFrame[19]=5
  vars.avatarMotionFrame[20]=5
  vars.avatarMotionFrame[21]=7
  vars.avatarMotionFrame[22]=3
  vars.avatarMotionFrame[23]=3
  vars.avatarMotionFrame[24]=6
  vars.avatarMotionFrame[25]=10
  vars.avatarMotionFrame[26]=8
  vars.avatarMotionFrame[27]=6
  vars.avatarMotionFrame[28]=6
  vars.avatarMotionFrame[29]=8
  vars.avatarMotionFrame[30]=2
  vars.avatarMotionFrame[31]=5
  vars.avatarMotionFrame[32]=2
  vars.avatarMotionFrame[33]=1
  vars.avatarMotionFrame[34]=5
  vars.avatarMotionFrame[35]=5
  vars.avatarMotionFrame[36]=4
  vars.avatarMotionFrame[37]=7
  vars.avatarMotionFrame[38]=6
  vars.avatarMotionFrame[39]=9
  vars.avatarMotionFrame[40]=4
  vars.avatarMotionFrame[41]=7
  vars.avatarMotionFrame[42]=6
  vars.avatarMotionFrame[43]=5
  vars.avatarMotionFrame[44]=1
  vars.avatarMotionFrame[45]=4
  vars.avatarMotionFrame[46]=2
  vars.avatarMotionFrame[47]=7
  vars.avatarMotionFrame[48]=8
  vars.avatarMotionFrame[49]=5
  vars.avatarMotionFrame[50]=8
  vars.avatarMotionFrame[51]=6
  vars.avatarMotionFrame[52]=7
  vars.avatarMotionFrame[53]=4
  vars.avatarMotionFrame[54]=7
  vars.avatarMotionFrame[55]=4
  vars.avatarMotionFrame[56]=5
  vars.avatarMotionFrame[57]=9
  vars.avatarMotionFrame[58]=3
  vars.avatarMotionFrame[59]=5
  vars.avatarSaveIsValid=1
  vars.playerType=PlayerType.AVATAR
  vars.playerCamoType=PlayerCamoType.BATTLEDRESS
  vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
  vars.playerFaceEquipId=1
  vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
  local chimeraInfo={
    {
      equipId=TppEquip.EQP_WP_30105,
      partsInfo={
        barrel=TppEquip.BA_30124,
        ammo=TppEquip.AM_30125,
        stock=TppEquip.SK_60304,
        muzzle=TppEquip.MZ_30105,
        muzzleOption=TppEquip.MO_30102,
        rearSight=TppEquip.ST_30305,
        frontSight=TppEquip.ST_30306,
        option1=TppEquip.LT_30105,
        option2=TppEquip.LS_40034,
        underBarrel=TppEquip.UB_50102,
        underBarrelAmmo=TppEquip.AM_40102
      }
    },
    {
      equipId=TppEquip.EQP_WP_60206,
      partsInfo={
        barrel=TppEquip.BA_60205,
        ammo=TppEquip.AM_30055,
        stock=TppEquip.SK_60203,
        muzzle=TppEquip.MZ_60203,
        muzzleOption=TppEquip.MO_60204,
        rearSight=TppEquip.ST_30204,
        frontSight=TppEquip.ST_20205,
        option1=TppEquip.LT_30025,
        option2=TppEquip.LS_30104,
        underBarrel=TppEquip.UB_40144,
        underBarrelAmmo=TppEquip.AM_40102
      }
    },
    {
      equipId=TppEquip.EQP_WP_20004,
      partsInfo={
        ammo=TppEquip.AM_20105,
        stock=TppEquip.SK_20002,
        muzzleOption=TppEquip.MO_10101,
        rearSight=TppEquip.ST_30114,
        option1=TppEquip.LT_10104
      }
    }
  }
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=chimeraInfo})
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})
end
function this.DEBUG_SetFobPlayerDefence()
  vars.avatarFaceRaceIndex=0
  vars.avatarAcceFlag=0
  vars.avatarFaceTypeIndex=1
  vars.avatarFaceVariationIndex=1
  vars.avatarFaceColorIndex=0
  vars.avatarHairStyleIndex=0
  vars.avatarRightEyeColorIndex=0
  vars.avatarRightEyeBrightnessIndex=0
  vars.avatarLeftEyeColorIndex=1
  vars.avatarLeftEyeBrightnessIndex=0
  vars.avatarHairColor=1
  vars.avatarBerdStyle=0
  vars.avatarBerdLength=1
  vars.avatarEbrwStyle=3
  vars.avatarEbrwWide=1
  vars.avatarGashOrTatoVariationIndex=0
  vars.avatarTatoColorIndex=0
  vars.avatarMotionFrame[0]=4
  vars.avatarMotionFrame[1]=9
  vars.avatarMotionFrame[2]=5
  vars.avatarMotionFrame[3]=5
  vars.avatarMotionFrame[4]=7
  vars.avatarMotionFrame[5]=1
  vars.avatarMotionFrame[6]=7
  vars.avatarMotionFrame[7]=4
  vars.avatarMotionFrame[8]=4
  vars.avatarMotionFrame[9]=5
  vars.avatarMotionFrame[10]=5
  vars.avatarMotionFrame[11]=6
  vars.avatarMotionFrame[12]=5
  vars.avatarMotionFrame[13]=10
  vars.avatarMotionFrame[14]=8
  vars.avatarMotionFrame[15]=4
  vars.avatarMotionFrame[16]=6
  vars.avatarMotionFrame[17]=10
  vars.avatarMotionFrame[18]=0
  vars.avatarMotionFrame[19]=5
  vars.avatarMotionFrame[20]=5
  vars.avatarMotionFrame[21]=7
  vars.avatarMotionFrame[22]=3
  vars.avatarMotionFrame[23]=3
  vars.avatarMotionFrame[24]=6
  vars.avatarMotionFrame[25]=10
  vars.avatarMotionFrame[26]=8
  vars.avatarMotionFrame[27]=6
  vars.avatarMotionFrame[28]=6
  vars.avatarMotionFrame[29]=8
  vars.avatarMotionFrame[30]=2
  vars.avatarMotionFrame[31]=5
  vars.avatarMotionFrame[32]=2
  vars.avatarMotionFrame[33]=1
  vars.avatarMotionFrame[34]=5
  vars.avatarMotionFrame[35]=5
  vars.avatarMotionFrame[36]=4
  vars.avatarMotionFrame[37]=7
  vars.avatarMotionFrame[38]=6
  vars.avatarMotionFrame[39]=9
  vars.avatarMotionFrame[40]=4
  vars.avatarMotionFrame[41]=7
  vars.avatarMotionFrame[42]=6
  vars.avatarMotionFrame[43]=5
  vars.avatarMotionFrame[44]=1
  vars.avatarMotionFrame[45]=4
  vars.avatarMotionFrame[46]=2
  vars.avatarMotionFrame[47]=7
  vars.avatarMotionFrame[48]=8
  vars.avatarMotionFrame[49]=5
  vars.avatarMotionFrame[50]=8
  vars.avatarMotionFrame[51]=6
  vars.avatarMotionFrame[52]=7
  vars.avatarMotionFrame[53]=4
  vars.avatarMotionFrame[54]=7
  vars.avatarMotionFrame[55]=4
  vars.avatarMotionFrame[56]=5
  vars.avatarMotionFrame[57]=9
  vars.avatarMotionFrame[58]=3
  vars.avatarMotionFrame[59]=5
  vars.avatarSaveIsValid=1
  vars.playerType=PlayerType.AVATAR
  vars.playerCamoType=PlayerCamoType.BATTLEDRESS
  vars.handEquip=TppEquip.EQP_HAND_KILL_ROCKET
  vars.playerFaceEquipId=1
  vars.itemLevels[TppEquip.EQP_SUIT-TppEquip.EQP_IT_InstantStealth]=1
  local chimeraInfo={
    {
      equipId=TppEquip.EQP_WP_30235,
      partsInfo={
        barrel=TppEquip.BA_30214,
        ammo=TppEquip.AM_30232,
        stock=TppEquip.SK_30205,
        muzzle=TppEquip.MZ_30232,
        muzzleOption=TppEquip.MO_30235,
        rearSight=TppEquip.ST_30202,
        frontSight=TppEquip.ST_30114,
        option1=TppEquip.LT_40103,
        option2=TppEquip.LS_30104,
        underBarrel=TppEquip.UB_50002,
        underBarrelAmmo=TppEquip.AM_50002
      }
    },
    {
      equipId=TppEquip.EQP_WP_60317,
      partsInfo={barrel=TppEquip.BA_30044,
        ammo=TppEquip.AM_30102,
        stock=TppEquip.SK_60205,
        muzzle=TppEquip.MZ_30213,
        muzzleOption=TppEquip.MO_30105,
        rearSight=TppEquip.ST_50303,
        option1=TppEquip.LT_30025,
        option2=TppEquip.LS_30104,
        underBarrel=TppEquip.UB_40043,
        underBarrelAmmo=TppEquip.AM_40001
      }
    },
    {
      equipId=TppEquip.EQP_WP_20215,
      partsInfo={ammo=TppEquip.AM_20106,
        stock=TppEquip.SK_20216,
        muzzleOption=TppEquip.MO_20205,
        rearSight=TppEquip.ST_60102,
        option1=TppEquip.LS_10415
      }
    }
  }
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=chimeraInfo})
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET})
end
function this.QARELEASE_DEBUG_Init()
  local e
  do
    return
  end
  e.AddDebugMenu("LuaSystem","showSysVars","bool",gvars,"DEBUG_showSysVars")
  e.AddDebugMenu("LuaSystem","gameStatus","bool",gvars,"DEBUG_showGameStatus")
  mvars.qaDebug.forceCheckPointSave=false
  e.AddDebugMenu("LuaSystem","ForceCheckPointSave","bool",mvars.qaDebug,"forceCheckPointSave")
  mvars.qaDebug.showWeaponVars=false
  e.AddDebugMenu("LuaSystem","ShowWeaponVars","bool",mvars.qaDebug,"showWeaponVars")
  mvars.qaDebug.showPlayerPartsType=false
  e.AddDebugMenu("LuaSystem","ShowPlayerPartsType","bool",mvars.qaDebug,"showPlayerPartsType")
  mvars.qaDebug.setFobForGPU=false
  e.AddDebugMenu("LuaSystem","setFobForGPU","bool",mvars.qaDebug,"setFobForGPU")
  mvars.qaDebug.showEventTask=false
  e.AddDebugMenu("LuaUI","showEventTask","bool",mvars.qaDebug,"showEventTask")
  mvars.qaDebug.showOnlineChallengeTask=0--RETAILPATCH 1090
  e.AddDebugMenu("LuaUI","showOnlineChallengeTask","int32",mvars.qaDebug,"showOnlineChallengeTask")
  mvars.qaDebug.showOnTaskVersion=false
  e.AddDebugMenu("LuaUI","showOnTaskVersion","bool",mvars.qaDebug,"showOnTaskVersion")--<
end
function this.QAReleaseDebugUpdate()
  local svars=svars
  local mvars=mvars
  local Print=(nil).Print
  local newContext=(nil).NewContext()
  if mvars.seq_doneDumpCanMissionStartRefrainIds then
    Print(newContext,{1,0,0},"TppSequence: Mission.CanStart() wait is time out!\nPlease screen shot [Mission > ViewStartRefrain > true] , [Pause > ShowFlags > true] and [Pause > ShowInstances > true]")
  end
  if(gvars.usingNormalMissionSlot==false)and(not(((vars.missionCode==10115)or(vars.missionCode==50050))or(TppMission.IsHelicopterSpace(vars.missionCode))))then
    Print(newContext,{1,.5,.5},"Now gvars.usingNormalMissionSlot is false, but not emergency mission. Call scripter!!!!!!")
  end
  if(vars.fobSneakMode==FobMode.MODE_SHAM)and(not((vars.missionCode==50050)or(TppMission.IsHelicopterSpace(vars.missionCode))))then
    Print(newContext,{1,.5,.5},"Now vars.fobSneakMode isFobMode.MODE_SHAM, but not fob mission. Call scripter!!!!!!")
  end
  if TppSave.DEBUG_EraseAllGameDataCounter then--RETAILPATCH: 1060
    if TppSave.DEBUG_EraseAllGameDataCounter>0 then
      Print(newContext,{1,.5,.5},"TppSave.EraseAllGameDataSaveRequest : erase game data save request!")
      TppSave.DEBUG_EraseAllGameDataCounter=TppSave.DEBUG_EraseAllGameDataCounter-Time.GetFrameTime()
  else
    TppSave.DEBUG_EraseAllGameDataCounter=nil
  end
  end--
  if mvars.qaDebug.forceCheckPointSave then
    mvars.qaDebug.forceCheckPointSave=false
    TppMission.UpdateCheckPoint{ignoreAlert=true,atCurrentPosition=true}
  end
  if gvars.DEBUG_showSysVars then
    local a=this.DEBUG_GetSysVarsLog()
    Print(newContext,{.5,.5,1},"LuaSystem showSysVars")
    for o,a in ipairs(a)do
      Print(newContext,a)
    end
    local a={[FobMode.MODE_ACTUAL]="MODE_ACTUAL",[FobMode.MODE_SHAM]="MODE_SHAM",[FobMode.MODE_VISIT]="MODE_VISIT",[FobMode.MODE_NONE]="MODE_NONE"}
    Print(newContext,"vars.fobSneakMode = "..tostring(a[vars.fobSneakMode]))
    local a=TppScriptVars.GetVarValueInSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,"vars","mbmTppGmp",0)
    Print(newContext,"GMP(inSlot) = "..tostring(a))
    local a=TppScriptVars.GetVarValueInSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,"vars","mbmTppHeroicPoint",0)
    Print(newContext,"HeroicPoint(inSlot) = "..tostring(a))
    Print(newContext,"killCount = "..tostring(svars.killCount))
    Print(newContext,"totalKillCount = "..tostring(gvars.totalKillCount))
  end
  if gvars.DEBUG_showGameStatus then
    Print(newContext,"")
    Print(newContext,{.5,.5,1},"LuaSystem gameStatus")
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local isSet=TppGameStatus.IsSet("TppMain.lua",gameStatusName)
      if isSet then
        Print(newContext," statusType = "..(tostring(gameStatusName)..(", IsSet = "..tostring(isSet))))
      end
    end
    local a=TppGameStatus.IsSet("TppMain.lua","S_IS_BLACK_LOADING")
    if a then
      Print(newContext," statusType = "..(tostring"S_IS_BLACK_LOADING"..(", IsSet = "..tostring(a))))
    end
    Print(newContext,"UIStatus")
    local statuses={
      {CallMenu="INVALID"},
      {PauseMenu="INVALID"},
      {EquipHud="INVALID"},
      {EquipPanel="INVALID"},
      {CqcIcon="INVALID"},
      {ActionIcon="INVALID"},
      {AnnounceLog="SUSPEND_LOG"},
      {AnnounceLog="INVALID_LOG"},
      {BaseName="INVALID"},
      {Damage="INVALID"},
      {Notice="INVALID"},
      {HeadMarker="INVALID"},
      {WorldMarker="INVALID"},
      {HudText="INVALID"},
      {GmpInfo="INVALID"},
      {AtTime="INVALID"},
      {InfoTypingText="INVALID"},
      {ResourcePanel="SHOW_IN_HELI"}
    }
    for o,status in pairs(statuses)do
      for name,statusType in pairs(status)do
        if(TppUiStatusManager.CheckStatus(name,statusType)==true)then
          Print(newContext,string.format(" UI = %s, Status = %s",name,statusType))
        end
      end
    end
  end
  if mvars.qaDebug.showWeaponVars then
    local slots={"PRIMARY_HIP","PRIMARY_BACK","SECONDARY"}
    Print(newContext,{.5,.5,1},"LuaSystem WeaponVars")
    for n,slotName in ipairs(slots)do
      local slotId=TppDefine.WEAPONSLOT[slotName]
      Print(newContext,string.format("Slot:%16s : vars.initWeapons = %04d, vars.weapons = %04d",slotName,vars.initWeapons[slotId],vars.weapons[slotId]))
    end
    for i=0,7 do
      Print(newContext,string.format("Slot:%d : vars.supportWeapons = %04d, vars.initSupportWeapons = %04d, gvars.ply_lastWeaponsUsingTemp = %04d",i,vars.supportWeapons[i],vars.initSupportWeapons[i],gvars.ply_lastWeaponsUsingTemp[i+TppDefine.WEAPONSLOT.SUPPORT_0]))
    end
    for i=0,7 do
      Print(newContext,string.format("Slot:%d : vars.items = %04d, vars.initItems = %04d, gvars.ply_lastItemsUsingTemp = %04d",i,vars.items[i],vars.initItems[i],gvars.ply_lastItemsUsingTemp[i]))
    end
  end
  if mvars.qaDebug.showPlayerPartsType then
    Print(newContext,{.5,.5,1},"LuaSystem ShowPlayerPartsType")
    Print(newContext,"gvars.ply_isUsingTempPlayerType = "..tostring(gvars.ply_isUsingTempPlayerType))
    Print(newContext,string.format("vars.playerPartsType = %04d, gvars.ply_lastPlayerPartsTypeUsingTemp = %04d",vars.playerPartsType,gvars.ply_lastPlayerPartsTypeUsingTemp))
    Print(newContext,string.format("vars.playerCamoType = %04d, gvars.ply_lastPlayerCamoTypeUsingTemp = %04d",vars.playerCamoType,gvars.ply_lastPlayerCamoTypeUsingTemp))
    Print(newContext,string.format("vars.playerType = %04d, gvars.ply_lastPlayerTypeUsingTemp = %04d",vars.playerType,gvars.ply_lastPlayerTypeUsingTemp))
  end
  if mvars.qaDebug.gotFobStatusCount then
    Print(newContext,{.5,.5,1},">> Done TppServerManager.GetFobStatus()")
    mvars.qaDebug.gotFobStatusCount=mvars.qaDebug.gotFobStatusCount+1
    if mvars.qaDebug.gotFobStatusCount>120 then
      mvars.qaDebug.gotFobStatusCount=nil
    end
  end
  if mvars.qaDebug.setFobForGPU then
    mvars.qaDebug.setFobForGPU=false
    this.DEBUG_FobGPU()
  end
  if mvars.qaDebug.showEventTask then
    if not mvars.ui_eventTaskDefine then
      mvars.qaDebug.showEventTask=false
      return
    end
    Print(newContext,{.5,.5,1},"LuaUI ShowEventTask")
    local function s(t,a,i)
      local n
      if FobUI.IsCompleteEventTask(a,i)then
        n=" o "
      else
        n=" x "
      end
      local s=t[a]and t[a].detectType
      if s then
        local o=mvars.qaDebug.debugEventTaskTextTable and mvars.qaDebug.debugEventTaskTextTable[s]
        if not o then
          o="threshold is"
        end
        Print(newContext,string.format("   Task %1d : [%s] %s %06.2f : ( Current %06.2f )",a,n,o,t[a].threshold,FobUI.GetCurrentEventTaskValue(a,i)))
      end
    end
    Print(newContext,{.5,1,.5},"FobSneak eventTask")
    for a=0,7 do
      local e=mvars.ui_eventTaskDefine.sneak
      if e and e[a]then
        s(e,a,true)
      end
    end
    Print(newContext,{.5,1,.5},"FobDefence eventTask")
    for a=0,7 do
      local e=mvars.ui_eventTaskDefine.defence
      if e and e[a]then
        s(e,a,false)
      end
    end
  end
  --RETAILPATCH 1090>
  if(mvars.qaDebug.showOnlineChallengeTask>0)then
    Print(newContext,{.5,.5,1},"LuaUI ShowOnlineChallengeTask")
    if not OnlineChallengeTask then
      Print(newContext,"OnlineChallengeTask.lua is not loaded now. Go to mission!")
    elseif TppGameMode.GetUserMode()~=TppGameMode.U_KONAMI_LOGIN then
      Print(newContext,"Now off-line mode, please connect online!")
    elseif not mvars.ui_onlineChallengeTaskDefine then
      Print(newContext,"Not defined online challenge task!")
    else
      local t=mvars.qaDebug.debugOnlineChallengeTaskMissionList[mvars.qaDebug.showOnlineChallengeTask]
      if not t then
        mvars.qaDebug.showOnlineChallengeTask=0
        return
      end
      local function i(n,o)
        local t
        if TppChallengeTask.IsCompletedOnlineTask(o)then
          t=" o "
        else
          t=" x "
        end
        local s=n[o]and n[o].detectType
        if s then
          local r=mvars.qaDebug.debugOnlineChallengeTaskTextTable and mvars.qaDebug.debugOnlineChallengeTaskTextTable[s]
          if not r then
            r="threshold is"
          end
          Print(newContext,string.format("   Task %02d : [%s] %s %06.2f : ( Current %06.2f )",o,t,r,n[o].threshold,OnlineChallengeTask.GetCurrentTaskValue(o)))
        end
      end
      Print(newContext,string.format("missionCode = %05d",t))
      for a=0,23 do
        local e=mvars.ui_onlineChallengeTaskDefine
        if e[a]and(e[a].missionCode==t)then
          i(e,a,true)
        end
      end
    end
  end
  if mvars.qaDebug.showOnTaskVersion then
    Print(newContext,{.5,.5,1},"LuaUI ShowOnlineChallengeTaskVersion")
    Print(newContext,string.format("   ServerVersion : %d",TppNetworkUtil.GetOnlineChallengeTaskVersion()))
    Print(newContext,string.format("    LocalVersion : %d",gvars.localOnlineChallengeTaskVersion))
  end
  --<
end
function this.Print2D(e)
  if(e==nil)then
    return
  end
  local t=e.showTime or(3*30)
  local o=e.xPos or 25
  local n=e.yPos or 425
  local s=e.size or 20
  local r=e.color or"white"
  local e=e.text or""
  r=this._GetColor(r)
  GrxDebug.Print2D{life=t,x=o,y=n,size=s,color=r,args={e}}
end
function this.DEBUG_MakeUserSVarList(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.dbg_userSaveVarList={}
  for a,e in pairs(e)do
    table.insert(mvars.dbg_userSaveVarList,e.name)
  end
end
function this.AddReturnToSelector(e)
  e:AddItem("< return",DebugSelector.Pop)
end
function this.DEBUG_Init()
  mvars.debug.returnSelect=false;(nil).AddDebugMenu(" Select","Return select","bool",mvars.debug,"returnSelect")
  mvars.debug.showSVars=false;(nil).AddDebugMenu("LuaMission","DBG.showSVars","bool",mvars.debug,"showSVars")
  mvars.debug.showMVars=false;(nil).AddDebugMenu("LuaMission","DBG.showMVars","bool",mvars.debug,"showMVars")
  mvars.debug.showMissionArea=false;(nil).AddDebugMenu("LuaMission","MIS.missionArea","bool",mvars.debug,"showMissionArea")
  mvars.debug.showClearState=false;(nil).AddDebugMenu("LuaMission","MIS.clearState","bool",mvars.debug,"showClearState")
  mvars.debug.openEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.openEmergencyTimer","bool",mvars.debug,"openEmergencyTimer")
  mvars.debug.closeEmergencyTimer=false;(nil).AddDebugMenu("LuaMission","MIS.closeEmergencyTimer","bool",mvars.debug,"closeEmergencyTimer")
  mvars.debug.showDebugPerfCheck=false;(nil).AddDebugMenu("LuaSystem","DBG.showPerf","bool",mvars.debug,"showDebugPerfCheck")
  mvars.debug.showSysSVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysSVars","bool",mvars.debug,"showSysSVars")
  mvars.debug.showSysMVars=false;(nil).AddDebugMenu("LuaSystem","DBG.showSysMVars","bool",mvars.debug,"showSysMVars")
  mvars.debug.AnimalBlock=false;(nil).AddDebugMenu("LuaSystem","DBG.AnimalBlock","bool",mvars.debug,"AnimalBlock")
  mvars.debug.ply_rotCheck=0;(nil).AddDebugMenu("LuaSystem","PLY.rotCheck","int32",mvars.debug,"ply_rotCheck")
  mvars.debug.ply_intelTrap=false;(nil).AddDebugMenu("LuaSystem","PLY.intelTrap","bool",mvars.debug,"ply_intelTrap")
  mvars.debug.enableAllMessageLog=false;(nil).AddDebugMenu("LuaMessage","enableAllMessageLog","bool",mvars.debug,"enableAllMessageLog")
  mvars.debug.showSubscriptMessageTable=0;(nil).AddDebugMenu("LuaMessage","subScripts","int32",mvars.debug,"showSubscriptMessageTable")
  mvars.debug.showSequenceMessageTable=0;(nil).AddDebugMenu("LuaMessage","sequence","int32",mvars.debug,"showSequenceMessageTable")
  mvars.debug.showLocationMessageTable=0;(nil).AddDebugMenu("LuaMessage","location","int32",mvars.debug,"showLocationMessageTable")
  mvars.debug.showLibraryMessageTable=0;(nil).AddDebugMenu("LuaMessage","library","int32",mvars.debug,"showLibraryMessageTable")
  mvars.debug.showWeaponSelect=false;(nil).AddDebugMenu("LuaWeapon","showWeaponSelect","bool",mvars.debug,"showWeaponSelect")
  mvars.debug.weaponCategory=1;(nil).AddDebugMenu("LuaWeapon","category","int32",mvars.debug,"weaponCategory")
  mvars.debug.weaponCategoryList={
    {"Develop:Hundgan",8,{"EQP_WP_1"}},
    {"Develop:Submachingun",8,{"EQP_WP_2"}},
    {"Develop:AssaultRifle",8,{"EQP_WP_3"}},
    {"Develop:Shotgun",8,{"EQP_WP_4"}},
    {"Develop:Granader",8,{"EQP_WP_5"}},
    {"Develop:SniperRifle",8,{"EQP_WP_6"}},
    {"Develop:MachineGun",8,{"EQP_WP_7"}},
    {"Develop:Missile",8,{"EQP_WP_8"}},
    {"EnemyWeapon",8,{"EQP_WP_W","EQP_WP_E","EQP_WP_Q","EQP_WP_C"}},
    {"SupportWeapon",7,{"EQP_SWP"}},
    {"Equipment",7,{"EQP_IT_"}}
  }
  mvars.debug.selectedWeaponId=0;(nil).AddDebugMenu("LuaWeapon","weaponSelect","int32",mvars.debug,"selectedWeaponId")
  mvars.debug.enableWeaponChange=false;(nil).AddDebugMenu("LuaWeapon","enableWeaponChange","bool",mvars.debug,"enableWeaponChange")
end
function this.DEBUG_OnReload(missionTable)
  perfCheckTimes={}
  unk2Table={}
  perfCheckTimesStrings={}
  unk5Num=0
  unk6Num=0
  this.PERF_CHECK_TYPE=Tpp.Enum(this.PERF_CHECK_TYPE)
  local strCode32List={}
  Tpp.ApendArray(strCode32List,TppDbgStr32.DEBUG_strCode32List)
  for name,module in pairs(missionTable)do
    if module.DEBUG_strCode32List then
      Tpp.ApendArray(strCode32List,module.DEBUG_strCode32List)
    end
  end
  TppDbgStr32.DEBUG_RegisterStrcode32invert(strCode32List)
end
---
function this.DebugUpdate()
  local svars=svars
  local mvars=mvars
  local mvarsDebug=mvars.debug
  local Print=(nil).Print
  local newContext=(nil).NewContext()
  if(not TppUiCommand.IsEndMissionTelop())then
    Print(newContext,{.5,.5,1},"Now showing result.")
  end
  if gvars.needWaitMissionInitialize then
    Print(newContext,{.5,.5,1},"Now neew wait mission initialize.")
  end
  if mvarsDebug.returnSelect then
    TppUI.FadeOut(0)
    TppSave.ReserveVarRestoreForMissionStart()
    TppMission.SafeStopSettingOnMissionReload()
    tpp_editor_menu2.StartTestStage(6e4)
    mvarsDebug.returnSelect=false
  end
  if mvarsDebug.showSVars then
    Print(newContext,"")
    Print(newContext,{.5,.5,1},"LuaMission DBG.showSVars")
    for a,e in pairs(mvars.dbg_userSaveVarList)do
      Print(newContext,string.format(" %s = %s",tostring(e),tostring(svars[e])))
    end
  end
  if mvarsDebug.showMVars then
    Print(newContext,{.5,.5,1},"LuaMission DBG.showMVars")
    for a,e in pairs(mvars)do
      Print(newContext,string.format(" %s = %s",tostring(a),tostring(e)))
    end
  end
  if mvarsDebug.showMissionArea then
    Print(newContext,{.5,.5,1},"LuaMission MIS.missionArea")
    local a
    if mvars.mis_isOutsideOfMissionArea then
      a="Outside"
    else
      a="Inside"
    end
    Print(newContext,"outerZone : "..a)
    if mvars.mis_isAlertOutOfMissionArea then
      a="Outside"
    else
      a="Inside"
    end
    Print(newContext,"innerZone : "..a)
    if mvars.mis_isOutsideOfHotZone then
      a="Outside"
    else
      a="Inside"
    end
    Print(newContext,"hotZone : "..a)
    Print(newContext,"hotZone clear check : isNotAlert = "..(tostring(mvars.debug.notHotZone_isNotAlert)..(", isPlayerStatusNormal = "..(tostring(mvars.debug.notHotZone_isPlayerStatusNormal)..(", isNotHelicopter = "..tostring(mvars.debug.notHotZone_isNotHelicopter))))))
    Print(newContext,"Mission clear timer: "..tostring(IsTimerActive"Timer_OutsideOfHotZoneCount"))
    Print(newContext,{.5,1,.5},"Recent all target status")
    local e=mvars.debug.checkedTargetStatus or{}
    for a,e in pairs(e)do
      Print(newContext,"  TargetName = "..(a..(" : "..e)))
    end
  end
  if mvars.debug.showClearState then
    Print(newContext,{.5,.5,1},"LuaMission MIS.showClearState")
    Print(newContext,"missionClearState = "..tostring(TppDefine.MISSION_CLEAR_STATE_LIST[gvars.mis_missionClearState+1]))
  end
  if mvars.debug.openEmergencyTimer then
    mvars.debug.openEmergencyTimer=false
    if mvars.mis_openEmergencyMissionTimerName then
      GkEventTimerManager.Stop(mvars.mis_openEmergencyMissionTimerName)
      GkEventTimerManager.Start(mvars.mis_openEmergencyMissionTimerName,1)
    end
  end
  if mvars.debug.closeEmergencyTimer then
    mvars.debug.closeEmergencyTimer=false
    if mvars.mis_closeEmergencyMissionTimerName then
      GkEventTimerManager.Stop(mvars.mis_closeEmergencyMissionTimerName)
      GkEventTimerManager.Start(mvars.mis_closeEmergencyMissionTimerName,1)
    end
  end
  if mvarsDebug.showSysSVars then
    Print(newContext,"")
    Print(newContext,{.5,.5,1},"LuaSystem DBG.showSysSVars")
    for e,a in pairs(svars.__as)do
      if(a<=1)then
        Print(newContext,string.format(" %s = %s",tostring(e),tostring(svars[e])))
      else
        Print(newContext,string.format(" %s = %s",tostring(e),tostring(a)))
        for a=0,(a-1)do
          Print(newContext,string.format("   %s[%d] = %s",tostring(e),a,tostring(svars[e][a])))
        end
      end
    end
  end
  if mvarsDebug.showDebugPerfCheck then
    Print(newContext,{.5,.5,1},"LuaSystem DBG.showPerf")
    for t,e in pairs(perfCheckTimesStrings)do
      Print(newContext," perf["..(this.PERF_CHECK_TYPE[t]..("] = "..e)))
    end
  end
  if mvars.debug.AnimalBlock then
    Print(newContext,{.5,.5,1},"LuaSystem DBG.AnimalBlock")
    local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()
    Print(newContext,string.format("current block position (x,y) = (%03d, %03d)",blockIndexX,blockIndexY))
    Print(newContext,"Load animal block area = "..tostring(mvars.animalBlockAreaName))
    local animalBlockId=ScriptBlock.GetScriptBlockId"animal_block"
    local animalBlockState
    if animalBlockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
      animalBlockState=ScriptBlock.GetScriptBlockState(animalBlockId)
    end
    local animalBlockStateString
    if animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
      animalBlockStateString="SCRIPT_BLOCK_STATE_EMPTY"
    elseif animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING then
      animalBlockStateString="SCRIPT_BLOCK_STATE_PROCESSING"
    elseif animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
      animalBlockStateString="SCRIPT_BLOCK_STATE_INACTIVE"
    elseif animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
      animalBlockStateString="SCRIPT_BLOCK_STATE_ACTIVE"
    end
    Print(newContext,"animal block state : "..tostring(animalBlockStateString))
    if mvars.animalBlockScript then
      Print(newContext,"animalBlockScript exist")
      local t=""
      if mvars.animalBlockScript.OnMessage then
        t="exist"
      else
        t="  not"
      end
      local n=""
      if mvars.animalBlockScript.OnReload then
        n="exist"
      else
        n="  not"
      end
      Print(newContext,"OnMessage "..(tostring(t)..(" OnReload "..tostring(n))))
      this.ShowMessageTable(newContext,"MessageTable",mvars.animalBlockScript.messageExecTable)
    else
      if animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or animalBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
        Print(newContext,{1,0,0},"this data is invalid!!!! please check data!!!")
      else
        Print(newContext,"animalBlockScript   not")
      end
    end
  end
  if mvars.debug.ply_intelTrap then
    Print(newContext,{.5,.5,1},"LuaSystem PLY.intelTrap")
    for e,a in pairs(mvars.ply_intelTrapInfo)do
      if Tpp.IsTypeString(e)then
        Print(newContext,{.5,1,.5},"intelName = "..tostring(e))
        for e,a in pairs(a)do
          Print(newContext,tostring(e)..(" = "..tostring(a)))
        end
      end
    end
  end
  if(mvarsDebug.showSubscriptMessageTable>0)then
    Print(newContext,{.5,.5,1},"LuaMessage subScripts")
    local o={"sequence","enemy","demo","radio","sound"}
    local o=o[mvars.debug.showSubscriptMessageTable]
    if o then
      local missionName=TppMission.GetMissionName()..("_"..o)
      if mvars.rad_subScripts[o]then
        local e=mvars.rad_subScripts[o]._messageExecTable
        this.ShowMessageTable(newContext,missionName,e)
      end
    end
  end
  if(mvarsDebug.showSequenceMessageTable>0)then
    Print(newContext,{.5,.5,1},"LuaMessage sequence")
    local o=TppSequence.GetSequenceNameWithIndex(mvars.debug.showSequenceMessageTable)
    if mvars.seq_sequenceTable then
      local e=mvars.seq_sequenceTable[o]
      if e then
        local e=e._messageExecTable
        this.ShowMessageTable(newContext,o,e)
      end
    end
  end
  if(mvarsDebug.showLocationMessageTable>0)then
    Print(newContext,{.5,.5,1},"LuaMessage location")
  end
  if(mvarsDebug.showLibraryMessageTable>0)then
    Print(newContext,{.5,.5,1},"LuaMessage library")
    local e=Tpp._requireList[mvarsDebug.showLibraryMessageTable]
    local o=_G[e].messageExecTable
    this.ShowMessageTable(newContext,e,o)
  end
  if mvars.debug.showWeaponSelect then
    Print(newContext,{.5,.5,1},"LuaWeapon")
    if mvars.debug.weaponCategory<1 then
      mvars.debug.weaponCategory=1
    end
    if mvars.debug.weaponCategory>#mvars.debug.weaponCategoryList then
      mvars.debug.weaponCategory=#mvars.debug.weaponCategoryList
    end
    local weaponCategory=mvars.debug.weaponCategory
    local weaponCategoryList=mvars.debug.weaponCategoryList[mvars.debug.weaponCategory]
    Print(newContext,{.5,1,.5},"Current weapon category : "..weaponCategoryList[1])
    local equipId,RENwhatIsThis
    local currentWeaponId,selectedWeaponId,max=0,1,5
    if mvars.debug.selectedWeaponId>0 then
      selectedWeaponId=mvars.debug.selectedWeaponId
    end
    for k,v in pairs(TppEquip)do
      local categoryId=string.sub(k,1,weaponCategoryList[2])
      local isInCurrentCategory=false
      for a,listCategoryId in ipairs(weaponCategoryList[3])do
        if categoryId==listCategoryId then
          isInCurrentCategory=true
        end
      end
      if isInCurrentCategory then
        currentWeaponId=currentWeaponId+1
        if(selectedWeaponId-currentWeaponId)<=max then
          if currentWeaponId==selectedWeaponId then
            equipId=v
            RENwhatIsThis=k
            Print(newContext,{.5,1,.5},"> EquipId = TppEquip."..k)
          else
            Print(newContext,"  EquipId = TppEquip."..k)
          end
        end
        if currentWeaponId==(selectedWeaponId+max)then
          break
        end
      end
    end
    if mvars.debug.enableWeaponChange then
      GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="DEBUG_ChangeEquip",equipId={equipId}})
      mvars.debug.enableWeaponChange=false
    end
  end
end
function this.ShowMessageTable(r,o,a)
  local DebugPrint=(nil).Print
  DebugPrint(r,{.5,1,.5},o)
  if a==nil then
    return
  end
  for o,a in pairs(a)do
    local o=DEBUG_StrCode32ToString(o)
    if a then
      for t,a in pairs(a)do
        local t=DEBUG_StrCode32ToString(t)
        if a.func then
          DebugPrint(r,{1,1,1},o..(" : "..(t..(" : "..tostring(a.func)))))
        end
        local a=a.sender
        if a then
          for n,a in pairs(a)do
            DebugPrint(r,{1,1,1},o..(" : "..(t..(" : Sender = "..(DEBUG_StrCode32ToString(n)..(" : "..tostring(a)))))))
          end
        end
      end
    end
  end
end
function this.PerfCheckStart(perCheckTypeEnum)
  local this=this
  if((perCheckTypeEnum<=0)and(perCheckTypeEnum>#this.PERF_CHECK_TYPE))then
    return
  end
  if(perCheckTypeEnum==this.PERF_CHECK_TYPE.OnUpdate)then
    if(perfCheckTimes[this.PERF_CHECK_TYPE.OnUpdate]~=nil)then
      unk5Num=unk5Num+(os.clock()-perfCheckTimes[this.PERF_CHECK_TYPE.OnUpdate])
    end
  end
  perfCheckTimes[perCheckTypeEnum]=os.clock()
end
function this.PerfCheckEnd(perCheckTypeEnum,r)
  local mvars=mvars
  local this=this
  if((perCheckTypeEnum<=0)and(perCheckTypeEnum>#this.PERF_CHECK_TYPE))then
    return
  end
  local p=r or""
  local r=0
  local perfDelta=os.clock()-perfCheckTimes[perCheckTypeEnum]
  if(perCheckTypeEnum==this.PERF_CHECK_TYPE.OnUpdate)then
    if(unk5Num<unk4Num)then
      if(perfDelta>unk6Num)then
        unk6Num=perfDelta
      end
    else
      unk5Num=0
      unk6Num=perfDelta
    end
    r=unk6Num
  else
    r=perfDelta
  end
  perfCheckTimesStrings[perCheckTypeEnum]=string.format("%4.2f",r*1e3)..("ms."..p)
  if mvars.debug and mvars.debug.showDebugPerfCheck then
    if(r>1/60)then
    else
      if(perCheckTypeEnum~=this.PERF_CHECK_TYPE.OnUpdate)then
      end
    end
  end
end
function this.ErrorNotSupportYet(e)
end
function this._GetColor(name)
  local color=this.Colors[name]
  if(color==nil)then
    return nil
  end
  return color
end
return this

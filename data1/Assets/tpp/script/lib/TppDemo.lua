-- DOBUILD: 1
-- TppDemo.lua
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local FindDemoBody=DemoDaemon.FindDemoBody
local IsDemoPlaying=DemoDaemon.IsDemoPlaying
local IsPlayingDemoId=DemoDaemon.IsPlayingDemoId
local IsDemoPaused=DemoDaemon.IsDemoPaused
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId
local lastPlayTooLongAgoTime=((5*24)*60)*60--5 days?
this.MOVET_TO_POSITION_RESULT={[StrCode32"success"]="success",[StrCode32"failure"]="failure",[StrCode32"timeout"]="timeout"}
this.messageExecTable={}
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="DemoSkipped",func=this.OnDemoSkipAndBlockLoadEnd,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="DemoSkipStart",func=this.EnableWaitBlockLoadOnDemoSkip,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishInterpCameraToDemo",func=this.OnEndGameCameraInterp,option={isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishMovingToPosition",sender="DemoStartMoveToPosition",
        func=function(str32Name,moveResultStr32)
          local moveResult=this.MOVET_TO_POSITION_RESULT[moveResultStr32]
          mvars.dem_waitingMoveToPosition=nil
        end,
        option={isExecMissionClear=true,isExecGameOver=true}}
    },
    Demo={
      {msg="PlayInit",func=this._OnDemoInit,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Play",func=this._OnDemoPlay,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Finish",func=this._OnDemoEnd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Interrupt",func=this._OnDemoInterrupt,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Skip",func=this._OnDemoSkip,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Disable",func=this._OnDemoDisable},
      {msg="StartMissionTelop",
        func=function()
          if mvars.dm_doneStartMissionTelop then
            return
          end
          local missionCodeForClear=TppMission.GetNextMissionCodeForMissionClear()
          TppUI.StartMissionTelop(missionCodeForClear)
          mvars.dm_doneStartMissionTelop=true
        end,
        option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopLeft",func=function()TppTelop.StartCastTelop"LEFT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopRight",func=function()TppTelop.StartCastTelop"RIGHT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      nil
    },
    UI={
      {msg="EndFadeOut",sender="DemoPlayFadeIn",func=function(n,demoIdStr32)
        local demoName=mvars.dem_invScdDemolist[demoIdStr32]
      end,
      option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="DemoPauseSkip",func=this.FadeOutOnSkip,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}}
    },
    Timer={
      {msg="Finish",sender="p31_080110_000_showLocationTelop",func=function()
        TppUiCommand.RegistInfoTypingText("location",1)
        TppUiCommand.RegistInfoTypingText("cpname",2,"platform_isolation")
        TppUiCommand.RegistInfoTypingText("disptime",2)
        TppUiCommand.ShowInfoTypingText()
      end,
      option={isExecDemoPlaying=true}}
    }
  }
end
this.PLAY_REQUEST_START_FUNC={
  missionStateCheck=function(demoId,demoFlags)
    local isExecMissionClear=demoFlags.isExecMissionClear
    local isExecGameOver=demoFlags.isExecGameOver
    local isExecDemoPlaying=demoFlags.isExecDemoPlaying
    if not TppMission.CheckMissionState(isExecMissionClear,isExecGameOver,isExecDemoPlaying,false)then
      return false
    end
    return true
  end,
  gameCameraInterpedToDemo=function(demoId)
    if not FindDemoBody(demoId)then
      return
    end
    if mvars.dem_gameCameraInterpWaitingDemoName~=nil then
      return false
    end
    mvars.dem_gameCameraInterpWaitingDemoName=demoId
    Player.RequestToInterpCameraToDemo(demoId,1,2,Vector3(.4,.6,-1),true)
    return true
  end,
  playerModelReloaded=function(demoId)
    if mvars.dem_tempPlayerInfo~=nil then
      return false
    end
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
    mvars.dem_tempPlayerInfo={}
    mvars.dem_tempPlayerInfo.playerType=vars.playerType
    mvars.dem_tempPlayerInfo.playerPartsType=vars.playerPartsType
    mvars.dem_tempPlayerInfo.playerCamoType=vars.playerCamoType
    mvars.dem_tempPlayerInfo.playerFaceId=vars.playerFaceId
    mvars.dem_tempPlayerInfo.playerFaceEquipId=vars.playerFaceEquipId
    mvars.dem_tempPlayerSuitLevel=Player.GetItemLevel(TppEquip.EQP_SUIT)--RETAILPATCH 1.10
    local forceSnake=true--tex>
    if Ivars.useSoldierForDemos:Is(1) then
      if vars.playerType~=PlayerType.DD_FEMALE or not InfMain.noSkipIsSnakeOnly[demoId] then
        forceSnake=false
      end
    end
    if forceSnake then--tex bypass--<
      TppPlayer.ForceChangePlayerToSnake(true)
    end
    mvars.dem_tempPlayerReloadCounter={}
    mvars.dem_tempPlayerReloadCounter.start=0
    mvars.dem_tempPlayerReloadCounter.finish=0
    return true
  end,
  demoBlockLoaded=function(demoId)
    TppScriptBlock.RequestActivate"demo_block"
    return true
  end,
  playerActionAllowed=function(e)
    return true
  end,
  playerMoveToPosition=function(demoId,demoFlags)
    if mvars.dem_waitingMoveToPosition then
      return false
    end
    local playerMoveToPosition=demoFlags.playerMoveToPosition
    if not playerMoveToPosition.position then
      return false
    end
    if not playerMoveToPosition.direction then
      return false
    end
    Player.RequestToSetTargetStance(PlayerStance.STAND)
    Player.RequestToMoveToPosition{name="DemoStartMoveToPosition",position=playerMoveToPosition.position,direction=playerMoveToPosition.direction,onlyInterpPosition=true,timeout=10}
    mvars.dem_waitingMoveToPosition=true
    return true
  end,
  waitTextureLoadOnDemoPlay=function(demoId)
    mvars.dem_setTempCamera=false
    mvars.dem_textureLoadWaitOnDemoPlayEndTime=nil
    return true
  end
}
this.PLAY_REQUEST_START_CHECK_FUNC={
  missionStateCheck=function(demoId)
    return true
  end,
  gameCameraInterpedToDemo=function(demoId)
    if mvars.dem_gameCameraInterpWaitingDemoName then
      return false
    else
      return true
    end
  end,
  demoBlockLoaded=function(demoId)
    local findDemoBuddy=FindDemoBody(demoId)
    if not findDemoBuddy then
      TppUI.ShowAccessIconContinue()
    end
    return findDemoBuddy
  end,
  playerModelReloaded=function(demoId)
    if mvars.dem_tempPlayerReloadCounter==nil then
      return false
    end
    if mvars.dem_tempPlayerReloadCounter.start<10 then
      mvars.dem_tempPlayerReloadCounter.start=mvars.dem_tempPlayerReloadCounter.start+1
      return false
    end
    if PlayerInfo.OrCheckStatus{PlayerStatus.PARTS_ACTIVE}then
      return true
    else
      return false
    end
  end,
  playerActionAllowed=function(demoId)
    local canPlayDemo=Player.CanPlayDemo(0)--NMC: what is up with the param? I guess it internally just checks current demo, it's called the same way in 10115
    if canPlayDemo==false then
    end
    return canPlayDemo
  end,
  playerMoveToPosition=function(demoId)
    if mvars.dem_waitingMoveToPosition then
      return false
    else
      return true
    end
  end,
  waitTextureLoadOnDemoPlay=function(demoId)
    local findDemoBody=FindDemoBody(demoId)
    if not findDemoBody then
      TppUI.ShowAccessIconContinue()
      return false
    end
    if not mvars.dem_setTempCamera then
      mvars.dem_setTempCamera=true
      Demo.EnableTempCamera(demoId)
    end
    if not mvars.dem_textureLoadWaitOnDemoPlayEndTime then
      mvars.dem_textureLoadWaitOnDemoPlayEndTime=Time.GetRawElapsedTimeSinceStartUp()+10
    end
    local waitTime=mvars.dem_textureLoadWaitOnDemoPlayEndTime-Time.GetRawElapsedTimeSinceStartUp()
    local textureLoadedRate=Mission.GetTextureLoadedRate()
    if(waitTime<=0)then
      return true
    else
      TppUI.ShowAccessIconContinue()
      return false
    end
  end
}
this.FINISH_WAIT_START_FUNC={
  waitBlockLoadEndOnDemoSkip=function(demoId)
    mvars.dem_enableWaitBlockLoadOnDemoSkip=true
    TppGameStatus.Set("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
    return true
  end,
  waitTextureLoadOnDemoEnd=function(demoId)
    return true
  end,
  playerModelReloaded=function(demoId)
    if mvars.dem_tempPlayerInfo==nil then
      return
    end
    if mvars.dem_donePlayerRestoreFadeOut==nil then
      mvars.dem_donePlayerRestoreFadeOut=true
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
    end
    for varName,value in pairs(mvars.dem_tempPlayerInfo)do
      vars[varName]=value
    end
    --RETAILPATCH 1.10
    if mvars.dem_tempPlayerSuitLevel then
      Player.SetItemLevel(TppEquip.EQP_SUIT,mvars.dem_tempPlayerSuitLevel)
      mvars.dem_tempPlayerSuitLevel=nil
    end
    --<
    mvars.dem_tempPlayerInfo=nil
    return true
  end
}
this.FINISH_WAIT_CHECK_FUNC={
  waitBlockLoadEndOnDemoSkip=function(demoId)
    if mvars.dem_enableWaitBlockLoadOnDemoSkip then
      TppUI.ShowAccessIconContinue()
      return false
    else
      TppGameStatus.Reset("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
      return true
    end
  end,
  waitTextureLoadOnDemoEnd=function(demoId)
    if mvars.dem_enableWaitBlockLoadOnDemoSkip then
      return false
    end
    if not mvars.dem_textureLoadWaitEndTime then
      mvars.dem_textureLoadWaitEndTime=Time.GetRawElapsedTimeSinceStartUp()+30
    end
    local loadWaitDelta=mvars.dem_textureLoadWaitEndTime-Time.GetRawElapsedTimeSinceStartUp()
    local textureLoadedRate=Mission.GetTextureLoadedRate()
    if(textureLoadedRate>.35)or(loadWaitDelta<=0)then
      return true
    else
      TppUI.ShowAccessIconContinue()
      return false
    end
  end,
  playerModelReloaded=function(demoId)
    if mvars.dem_donePlayerRestoreFadeOut then
      mvars.dem_donePlayerRestoreFadeOut=nil
      return false
    end
    if mvars.dem_tempPlayerReloadCounter==nil then
      return false
    end
    if mvars.dem_tempPlayerReloadCounter.finish<10 then
      mvars.dem_tempPlayerReloadCounter.finish=mvars.dem_tempPlayerReloadCounter.finish+1
      return false
    end
    if PlayerInfo.OrCheckStatus{PlayerStatus.PARTS_ACTIVE}then
      return true
    else
      return false
    end
  end
}
function this.Play(demoName,demoFuncs,demoFlags)
  InfCore.Log("TppDemo.Play "..demoName)--tex DEBUG
  InfCore.PrintInspect(demoFuncs,{varName="demoFuncs"})
  InfCore.PrintInspect(demoFlags,{varName="demoFlags"})--<

  local demoId=mvars.dem_demoList[demoName]
  if(demoId==nil)then
    return
  end
  mvars.dem_enableWaitBlockLoadOnDemoSkip=false
  mvars.dem_demoFuncs[demoName]=demoFuncs
  demoFlags=demoFlags or{}

  if Ivars.forceDemoAllowAction:Is(1) then--tex>
    demoFlags.isInGame=true
    demoFlags.isNotAllowedPlayerAction=false
  end--<

  if demoFlags.isInGame then
    if demoFlags.waitBlockLoadEndOnDemoSkip==nil then
      demoFlags.waitBlockLoadEndOnDemoSkip=false
    end
  else
    if demoFlags.isSnakeOnly==nil then
      demoFlags.isSnakeOnly=true
    end
    if demoFlags.waitBlockLoadEndOnDemoSkip==nil then
      demoFlags.waitBlockLoadEndOnDemoSkip=true
    end
  end
  if demoId=="p31_040010_000_final"then--PATCHUP: s10070 Demo_SahelanTest
    demoFlags.waitBlockLoadEndOnDemoSkip=false
    mvars.dem_resereveEnableInGameFlag=false
  end
  if(demoId=="p51_070020_000_final")or(demoId=="p21_020010")then--PATCHUP: s10240 Demo_Opening, s10010 escapeFromHospital
    mvars.dem_resereveEnableInGameFlag=false
  end
  --tex> force snake off for demo
  if Ivars.useSoldierForDemos:Is(1) then
    if vars.playerType~=PlayerType.DD_FEMALE or not InfMain.noSkipIsSnakeOnly[demoName] then
      demoFlags.isSnakeOnly=false
    end
  end--<
  mvars.dem_demoFlags[demoName]=demoFlags
  return this.AddPlayReqeustInfo(demoId,demoFlags)
end
function this.EnableGameStatus(target,_except)
  local except=_except or{}
  local overrideGameStatus=TppUI.GetOverrideGameStatus()
  if overrideGameStatus then
    for a,n in pairs(overrideGameStatus)do
      except[a]=n
    end
  end
  Tpp.SetGameStatus{target=target,except=except,enable=true,scriptName="TppDemo.lua"}
end
function this.DisableGameStatusOnPlayRequest(isInGame)
  if not isInGame then
    Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppDemo.lua"}
  end
end
function this.DisableGameStatusOnPlayStart()
  if this.IsNotPlayable()then
    HighSpeedCamera.RequestToCancel()
    Tpp.SetGameStatus{target="all",enable=false,scriptName="TppDemo.lua"}
  end
end
function this.OnEndGameCameraInterp()
  if mvars.dem_gameCameraInterpWaitingDemoName==nil then
  end
  mvars.dem_gameCameraInterpWaitingDemoName=nil
end
function this.PlayOnDemoBlock()
  this.ProcessPlayRequest(mvars.demo_playRequestInfo.demoBlock)
end
function this.FinalizeOnDemoBlock()
  if IsDemoPlaying()then
    DemoDaemon.SkipAll()
  end
end


function this.SetDemoTransform(demoName,setInfo)
  local demoId=mvars.dem_demoList[demoName]
  if(demoId==nil)then
    return
  end
  if(IsTypeTable(setInfo)==false)then
    return
  end
  local position
  local demoRotQuat
  if(setInfo.usePlayer==true)then
    position=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
    demoRotQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
  elseif(setInfo.identifier and setInfo.locatorName)then
    position,demoRotQuat=Tpp.GetLocatorByTransform(setInfo.identifier,setInfo.locatorName)
  else
    return
  end
  if position==nil then
    return
  end
  DemoDaemon.SetDemoTransform(demoId,demoRotQuat,position)
end
function this.GetDemoStartPlayerPosition(demoName)
  local demoId=mvars.dem_demoList[demoName]
  if(demoId==nil)then
    return
  end
  local n,position,rotQuat=DemoDaemon.GetStartPosition(demoId,"Player")
  if not n then
    return
  end
  local rotation=Tpp.GetRotationY(rotQuat)
  local posRot={position=position,direction=rotation}
  return posRot
end
function this.PlayOpening(demoFuncs,_demoFlags)
  local demoFlags=_demoFlags or{}
  demoFlags.isSnakeOnly=false
  local demoName="_openingDemo"
  local demoId="p31_020000"
  local openings={"p31_020000","p31_020001","p31_020002"}
  local rnd=math.random(#openings)
  demoId=openings[rnd]
  this.AddDemo(demoName,demoId)
  local demoPosition,demoRotQuat
  local pos,rot
  local playerPosition=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local adjustPos=Vector3(0,0,1.98)
  local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
  if gvars.mis_orderBoxName~=0 and mvars.mis_orderBoxList~=nil then
    local orderBoxName=TppMission.FindOrderBoxName(gvars.mis_orderBoxName)
    if orderBoxName~=nil then
      pos,rot=TppMission.GetOrderBoxLocatorByTransform(orderBoxName)
    end
  end
  if pos then
    local e=-rot:Rotate(adjustPos)
    demoPosition=e+pos
    demoRotQuat=rot
  else
    local e=-rotYQuat:Rotate(adjustPos)
    demoPosition=e+playerPosition
    demoRotQuat=rotYQuat
  end
  TppMusicManager.StopMusicPlayer(1)
  DemoDaemon.SetDemoTransform(demoId,demoRotQuat,demoPosition)
  this.Play(demoName,demoFuncs,demoFlags)
end
function this.PlayGetIntelDemo(demoFuncs,identifier,key,_demoFlags,t)
  local demoFlags=_demoFlags or{}
  demoFlags.isSnakeOnly=false
  local demoId,demoId2
  if t then
    demoId,demoId2="p31_010026","p31_010026_001"
  else
    demoId,demoId2="p31_010025","p31_010025_001"
  end
  local demoName="_getInteldemo"
  local demoName2="_getInteldemo02"
  this.AddDemo(demoName,demoId)
  this.AddDemo(demoName2,demoId2)
  local pos,rotQuat=Tpp.GetLocatorByTransform(identifier,key)
  --ORPHAN local rotY=Tpp.GetRotationY(rotQuat)
  Player.RequestToSetTargetStance(PlayerStance.STAND)
  if pos~=nil then
    DemoDaemon.SetDemoTransform(demoId,rotQuat,pos)
    this.Play(demoName,demoFuncs,demoFlags)
    TppUI.ShowAnnounceLog"getIntel"
  end
end
function this.IsNotPlayable()
  if IsDemoPlaying()or IsDemoPaused()then
    local playingDemoId=GetPlayingDemoId()
    for n,demoId in ipairs(playingDemoId)do
      local demoName=mvars.dem_invDemoList[demoId]
      if demoName then
        local demoFlags=mvars.dem_demoFlags[demoName]or{}
        if not demoFlags.isInGame then
          return true
        end
      end
    end
    return false
  else
    return false
  end
end
function this.ReserveEnableInGameFlag()
  mvars.dem_resereveEnableInGameFlag=true
end
function this.EnableInGameFlagIfResereved()
  if mvars.dem_resereveEnableInGameFlag then
    mvars.dem_resereveEnableInGameFlag=false
    TppMission.EnableInGameFlag()
  end
end
function this.ReserveInTheBackGround(demoFlags)
  if not IsTypeTable(demoFlags)then
    return
  end
  local demoName=demoFlags.demoName
  local demoId=mvars.dem_demoList[demoName]
  if not demoId then
    return
  end
  mvars.dem_reservedDemoId=demoId
  mvars.dem_reservedDemoLoadPosition=demoFlags.position
  local playerPause=true
  if demoFlags.playerPause then
    playerPause=demoFlags.playerPause
  end
  if playerPause then
    mvars.dem_reservedPlayerWarpAndPause=true
    this.SetPlayerPause()
  end
end
function this.ExecuteBackGroundLoad(demoId)
  if mvars.dem_reservedDemoLoadPosition then
    this.SetStageBlockLoadPosition(mvars.dem_reservedDemoLoadPosition)
    this.SetPlayerWarpAndPause(mvars.dem_reservedDemoLoadPosition)
    mvars.dem_DoneBackGroundLoading=true
  else
    local a,position,rotQuat=DemoDaemon.GetStartPosition(demoId,"Player")
    if not a then
      mvars.dem_DoneBackGroundLoading=true
      return
    end
    this.SetStageBlockLoadPosition(position)
    this.SetPlayerWarp(position,rotQuat)
    mvars.dem_DoneBackGroundLoading=true
  end
end
function this.SetStageBlockLoadPosition(position)
  TppGameStatus.Set("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
  mvars.dem_isSetStageBlockPosition=true
  StageBlockCurrentPositionSetter.SetEnable(true)
  StageBlockCurrentPositionSetter.SetPosition(position:GetX(),position:GetZ())
end
function this.SetPlayerPause()
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
end
function this.SetPlayerWarp(position,rotationY)
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
  local playerId={type="TppPlayer2",index=0}
  local command={id="WarpAndWaitBlock",pos={position:GetX(),position:GetY(),position:GetZ()},rotY=rotationY}
  GameObject.SendCommand(playerId,command)
end
function this.UnsetStageBlockLoadPosition()
  TppGameStatus.Reset("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
  if mvars.dem_isSetStageBlockPosition then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  mvars.dem_isSetStageBlockPosition=false
end
function this.UnsetPlayerPause()
  if mvars.dem_isPlayerPausing then
    Player.UnsetPause()
  end
  mvars.dem_isPlayerPausing=false
end
function this.ClearReserveInTheBackGround()
  mvars.dem_reservedDemoId=nil
  mvars.dem_reservedDemoLoadPosition=nil
end
function this.CheckEventDemoDoor(doorId,n,e)
  local position=TppPlayer.GetPosition()
  local range=30
  if doorId==nil then
    return false
  end
  if Tpp.IsTypeTable(n)then
    position=n
  elseif n==nil then
  end
  if Tpp.IsTypeNumber(e)and e>0 then
    range=e
  elseif e==nil then
  end
  local isNgIcon=0
  local i,l=0,1
  local isNotAlert=Tpp.IsNotAlert()
  local a=TppEnemy.IsActiveSoldierInRange(position,range)
  local e
  if isNotAlert==true and a==false then
    isNgIcon=i
    e=true
  else
    isNgIcon=l
    e=false
  end
  Player.SetEventLockDoorIcon{doorId=doorId,isNgIcon=isNgIcon}
  return e,isNotAlert,(not a)
end
function this.SpecifyIgnoreNpcDisable(e)
  local n
  if Tpp.IsTypeString(e)then
    n={e}
  elseif IsTypeTable(e)then
    n=e
  else
    return
  end
  mvars.dem_npcDisableList=mvars.dem_npcDisableList or{}
  for n,e in ipairs(n)do
    local n=TppEnemy.SetIgnoreDisableNpc(e,true)
    if n then
      table.insert(mvars.dem_npcDisableList,e)
    end
  end
end
function this.ClearIgnoreNpcDisableOnDemoEnd()
  if not mvars.dem_npcDisableList then
    return
  end
  for n,e in ipairs(mvars.dem_npcDisableList)do
    TppEnemy.SetIgnoreDisableNpc(e,false)
  end
  mvars.dem_npcDisableList=nil
end
function this.IsPlayedMBEventDemo(demoName)
  local demoEnum=TppDefine.MB_FREEPLAY_DEMO_ENUM[demoName]
  if demoEnum then
    return gvars.mbFreeDemoPlayedFlag[demoEnum]
  end
end
function this.ClearPlayedMBEventDemoFlag(demoName)
  local demoEnum=TppDefine.MB_FREEPLAY_DEMO_ENUM[demoName]
  if demoEnum then
    gvars.mbFreeDemoPlayedFlag[demoEnum]=false
  end
end
function this.OnAllocate(missionTable)
  mvars.dem_demoList={}
  mvars.dem_invDemoList={}
  mvars.dem_invScdDemolist={}
  mvars.dem_demoFuncs={}
  mvars.dem_demoFlags={}
  mvars.dem_playedList={}
  mvars.dem_isSkipped={}
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  mvars.demo_playRequestInfo={}
  mvars.demo_playRequestInfo={missionBlock={},demoBlock={}}
  mvars.demo_finishWaitRequestInfo={}
  local demo=missionTable.demo
  if demo and IsTypeTable(demo.demoList)then
    this.Register(demo.demoList)
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.OnAllocate(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Update()
  local mvars=mvars
  local thisLocal=this--NMC: tihs pattern is used in two functions in other files. why? is it that really performant?
  if mvars.dem_reservedDemoId then
    if FindDemoBody(mvars.dem_reservedDemoId)then
      if not mvars.dem_DoneBackGroundLoading then
        thisLocal.ExecuteBackGroundLoad(mvars.dem_reservedDemoId)
      end
    end
  end
  thisLocal.ProcessPlayRequest(mvars.demo_playRequestInfo.missionBlock)
  thisLocal.ProcessFinishWaitRequestInfo()
end

--REF
--this.demoList = {
--  Demo_RecoverReptilePod  = "p31_060010",
function this.Register(list)
  mvars.dem_demoList=list
  for demoName,demoId in pairs(list)do
    mvars.dem_invDemoList[demoId]=demoName
    mvars.dem_invScdDemolist[StrCode32(demoId)]=demoName
  end
end
function this.AddDemo(demoName,demoId)
  mvars.dem_demoList[demoName]=demoId
  mvars.dem_invDemoList[demoId]=demoName
  mvars.dem_invScdDemolist[StrCode32(demoId)]=demoName
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.FadeOutOnSkip()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
end
function this.OnDemoPlay(demoName,t)
  if mvars.dem_playedList[demoName]==nil then
    return
  end
  local demoFlags=mvars.dem_demoFlags[demoName]or{}
  if not demoFlags.startNoFadeIn then
    local fadeSpeed=demoFlags.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    TppUI.FadeIn(fadeSpeed,"DemoPlayFadeIn",t)
  end
  if demoFlags.useDemoBlock then
    mvars.dem_startedDemoBlockDemo=false
  end
  if mvars.dem_resereveEnableInGameFlag then
    if TppMission.GetMissionClearState()<=TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END then
      TppSoundDaemon.ResetMute"Loading"
    end
  end
  local n=mvars.dem_demoList[demoName]
  if(n=="p31_080110_000_final")then
    GkEventTimerManager.Start("p31_080110_000_showLocationTelop",12+(34/60))
  end
  this.UnsetStageBlockLoadPosition()
  this.UnsetPlayerPause()
end
function this.OnDemoEnd(demoName)
  if mvars.dem_playedList[demoName]==nil then
    return
  end
  local demoFlags=mvars.dem_demoFlags[demoName]or{}
  local demoId=mvars.dem_demoList[demoName]
  local muteDemos={p31_070050_001_final=true}
  if muteDemos[demoId]then
    TppSound.SetMuteOnLoading()
  end
  if mvars.dem_tempPlayerInfo then
    this.AddFinishWaitRequestInfo(demoId,demoFlags,"playerModelReloaded")
  end
  if demoFlags.waitTextureLoadOnDemoEnd then
    this.AddFinishWaitRequestInfo(demoId,demoFlags,"waitTextureLoadOnDemoEnd")
  end
  this.AddFinishWaitRequestInfo(demoId,demoFlags)
end
function this.OnDemoInterrupt(demoName)
  if mvars.dem_playedList[demoName]==nil then
    return
  end
  this.OnDemoEnd(demoName)
end
function this.OnDemoSkip(demoName,demoIdStr32)
  local demoId=mvars.dem_demoList[demoName]
  local demoFlags=mvars.dem_demoFlags[demoName]or{}
  local muteDemos={p31_010010=true,p41_030005_000_final=true,p51_070020_000_final=true,p31_050026_000_final=true}
  if muteDemos[demoId]then
    TppSoundDaemon.SetMuteInstant"Loading"
  end
  if(demoId=="p31_080110_000_final")then
    if GkEventTimerManager.IsTimerActive"p31_080110_000_showLocationTelop"then
      GkEventTimerManager.Stop"p31_080110_000_showLocationTelop"
    end
    TppUiCommand.HideInfoTypingText()
  end
  mvars.dem_isSkipped[demoId]=true
  mvars.dem_currentSkippedDemoName=demoName
  mvars.dem_currentSkippedScdDemoID=demoIdStr32
  if mvars.dem_playedList[demoName]==nil then
    return
  end
end
function this.EnableWaitBlockLoadOnDemoSkip()
  local demoName=mvars.dem_currentSkippedDemoName
  if not demoName then
    return
  end
  local demoFlags=mvars.dem_demoFlags[demoName]or{}
  local demoId=mvars.dem_demoList[demoName]
  if demoFlags.waitBlockLoadEndOnDemoSkip then
    this.AddFinishWaitRequestInfo(demoId,demoFlags,"waitBlockLoadEndOnDemoSkip")
    if not demoFlags.finishFadeOut then
      this.AddFinishWaitRequestInfo(demoId,demoFlags,"waitTextureLoadOnDemoEnd")
    end
  end
end
function this.OnDemoSkipAndBlockLoadEnd()
  if mvars.dem_enableWaitBlockLoadOnDemoSkip~=nil then
    mvars.dem_enableWaitBlockLoadOnDemoSkip=nil
  end
end
function this.DoOnEndMessage(demoName,r,exceptGameStatus,t,a)
  if(not r)then
    local skipFadeIn=true
    if t and(not a)then
      skipFadeIn=false
    end
    if skipFadeIn then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"DemoSkipFadeIn",mvars.dem_currentSkippedScdDemoID,{exceptGameStatus=exceptGameStatus})
    end
  end
  this._DoMessage(demoName,"onEnd")
  mvars.dem_currentSkippedDemoName=nil
  mvars.dem_currentSkippedScdDemoID=nil
  this.EnableInGameFlagIfResereved()
  this.EnableNpc(demoName)
end
function this.OnDemoDisable(demoName)
  if mvars.dem_playedList[demoName]==nil then
    return
  end
  this.OnDemoEnd(demoName)
end
function this.AddPlayReqeustInfo(demoId,demoFlags)
  local playRequestInfo=this.MakeNewPlayRequestInfo(demoFlags)

  InfCore.Log("AddPlayReqeustInfo:")--tex DEBUG>
  InfCore.PrintInspect(demoFlags,{varName="demoFlags"})
  InfCore.PrintInspect(playRequestInfo,{varName="playRequestInfo"})--<

  for functionName,use in pairs(playRequestInfo)do
    local requestStart=true
    local PlayRequestStart=this.PLAY_REQUEST_START_FUNC[functionName]
    if PlayRequestStart then
      requestStart=PlayRequestStart(demoId,demoFlags)
    else
      if PlayRequestStart==nil then
        playRequestInfo[functionName]=nil
        requestStart=true
      end
    end
    if not requestStart then
      return false
    end
  end
  if not demoFlags.isInGame then
    TppRadio.Stop()
  end
  this.DisableGameStatusOnPlayRequest(demoFlags.isInGame)
  if demoFlags and demoFlags.useDemoBlock then
    mvars.demo_playRequestInfo.demoBlock[demoId]=playRequestInfo
  else
    mvars.demo_playRequestInfo.missionBlock[demoId]=playRequestInfo
  end
  return true
end
function this.MakeNewPlayRequestInfo(demoFlags)
  if demoFlags==nil then
    return{}
  end
  local gameCameraInterpedToDemo
  if demoFlags.interpGameToDemo then
    gameCameraInterpedToDemo=false
  end
  local demoBlockLoaded
  if demoFlags.useDemoBlock then
    demoBlockLoaded=false
  end
  local playerModelReloaded
  if demoFlags.isSnakeOnly then
    if(vars.playerType==PlayerType.DD_MALE or vars.playerType==PlayerType.DD_FEMALE)then
      playerModelReloaded=false
    end
  end
  local playerActionAllowed
  if(not demoFlags.isInGame)or(demoFlags.isNotAllowedPlayerAction)then
    playerActionAllowed=false
  end
  local playerMoveToPosition
  if demoFlags.playerMoveToPosition then
    playerMoveToPosition=false
  end
  local waitTextureLoadOnDemoPlay
  if demoFlags.waitTextureLoadOnDemoPlay then
    waitTextureLoadOnDemoPlay=false
  end
  local playRequestInfo={missionStateCheck=false,gameCameraInterpedToDemo=gameCameraInterpedToDemo,demoBlockLoaded=demoBlockLoaded,playerModelReloaded=playerModelReloaded,playerActionAllowed=playerActionAllowed,playerMoveToPosition=playerMoveToPosition,waitTextureLoadOnDemoPlay=waitTextureLoadOnDemoPlay}
  return playRequestInfo
end
function this.DeletePlayRequestInfo(demoId,demoFlags)
  if demoFlags and demoFlags.useDemoBlock then
    mvars.demo_playRequestInfo.demoBlock[demoId]=nil
  else
    mvars.demo_playRequestInfo.missionBlock[demoId]=nil
  end
end
function this.ProcessPlayRequest(playRequestInfoDemoBlock)
  if not next(playRequestInfoDemoBlock)then
    return
  end
  InfCore.Log"ProcessPlayRequest:"--tex DEBUG>
  InfCore.PrintInspect(playRequestInfoDemoBlock,{varName="playRequestInfoDemoBlock"})--<
  for demoId,startCheckFunctions in pairs(playRequestInfoDemoBlock)do
    local canStartPlay=this.CanStartPlay(demoId,startCheckFunctions)
    InfCore.Log(demoId.." canStartPlay:"..tostring(canStartPlay))
    if canStartPlay then
      if not IsDemoPaused()then
        if not IsPlayingDemoId(demoId)then
          local demoName=mvars.dem_invDemoList[demoId]
          local demoFlags=mvars.dem_demoFlags[demoName]
          this._Play(demoName,demoId)
          this.DeletePlayRequestInfo(demoId,demoFlags)
        end
      end
    end
  end
end
function this.CanStartPlay(demoId,startCheckFuncions)
  local canStart=true
  for funcName,funcPasses in pairs(startCheckFuncions)do
    if funcPasses==false then
      local checkPassed=this.PLAY_REQUEST_START_CHECK_FUNC[funcName](demoId)
      InfCore.Log("CanStartPlay "..demoId.." check "..funcName.." "..tostring(checkPassed))--tex DEBUG
      if checkPassed then
        startCheckFuncions[funcName]=true
      else
        canStart=false
      end
    end
  end
  return canStart
end
function this.AddFinishWaitRequestInfo(demoId,demoFlags,finishWaitFuncName)
  local FinishWaitStartFunc
  local done=true
  if finishWaitFuncName then
    FinishWaitStartFunc=this.FINISH_WAIT_START_FUNC[finishWaitFuncName]
    if FinishWaitStartFunc then
      done=FinishWaitStartFunc(demoId)
    else
      return
    end
  end
  local finishWaitRequestInfo
  finishWaitRequestInfo=mvars.demo_finishWaitRequestInfo[demoId]or{}
  if(done==true)then
    if finishWaitFuncName then
      finishWaitRequestInfo[finishWaitFuncName]=false
    end
  else
    return
  end
  mvars.demo_finishWaitRequestInfo[demoId]=finishWaitRequestInfo
end
function this.ProcessFinishWaitRequestInfo()
  local finishWaitRequestInfo=mvars.demo_finishWaitRequestInfo
  if not next(finishWaitRequestInfo)then
    return
  end
  for demoId,n in pairs(finishWaitRequestInfo)do
    local canFinishPlay=this.CanFinishPlay(demoId,n)
    if canFinishPlay then
      local demoName=mvars.dem_invDemoList[demoId]
      local demoFlags=mvars.dem_demoFlags[demoName]or{}
      mvars.demo_finishWaitRequestInfo[demoId]=nil
      this.DoOnEndMessage(demoName,demoFlags.finishFadeOut,demoFlags.exceptGameStatus,demoFlags.isInGame,mvars.dem_isSkipped[demoId])
      if(not demoFlags.finishFadeOut)and(not demoFlags.isInGame)then
        TppTerminal.GetFobStatus()
      end
    end
  end
end
function this.CanFinishPlay(demoId,t)
  local canFinishPlay=true
  for funcName,r in pairs(t)do
    if r==false then
      local e=this.FINISH_WAIT_CHECK_FUNC[funcName](demoId)
      if e then
        t[funcName]=true
      else
        canFinishPlay=false
      end
    end
  end
  return canFinishPlay
end
function this._Play(demoName,demoId)
  InfCore.LogFlow("TppDemo._Play "..demoName.." "..demoId)--tex DEBUG
  mvars.dem_playedList[demoName]=true
  this.ClearReserveInTheBackGround()
  DemoDaemon.Play(demoId)
end
function this._OnDemoInit(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this._DoMessage(demoName,"onInit")
  end
end
function this._OnDemoPlay(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this.DisableGameStatusOnPlayStart()
    this.OnDemoPlay(demoName,demoIdStr32)
    this._DoMessage(demoName,"onStart")
  end
end
function this._OnDemoEnd(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this.OnDemoEnd(demoName)
    mvars.dem_playedList[demoName]=nil
  end
end
function this._OnDemoInterrupt(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this.OnDemoInterrupt(demoName)
    this._DoMessage(demoName,"onInterrupt")
  end
end
function this._OnDemoSkip(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this.OnDemoSkip(demoName,demoIdStr32)
    this._DoMessage(demoName,"onSkip")
  end
end
function this._OnDemoDisable(demoIdStr32)
  local demoName=mvars.dem_invScdDemolist[demoIdStr32]
  if demoName then
    this.OnDemoDisable(demoName)
    this._DoMessage(demoName,"onDisable")
    mvars.dem_playedList[demoName]=nil
  end
end
function this._DoMessage(demoName,functionName)
  if((mvars.dem_demoFuncs==nil or mvars.dem_demoFuncs[demoName]==nil)or mvars.dem_demoFuncs[demoName][functionName]==nil)then
    return
  end
  mvars.dem_demoFuncs[demoName][functionName]()
end
this.mtbsPriorityFuncList={
  TheGreatEscapeLiquid=function()
    return false
  end,
  NuclearEliminationCeremony=function()
    if not gvars.f30050_isInitNuclearAbolitionCount then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
    local e=TppServerManager.GetNuclearAbolitionCount()
    local a=e>=0
    local e=gvars.f30050_NuclearAbolitionCount<e
    if(a and n)and e then
      if vars.mbmIsNuclearDeveloping==0 and TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWeapon"}==0 then
        return true
      else
        gvars.f30050_needUpdateNuclearFlag=true
        return false
      end
    end
    return false
  end,
  ForKeepNuclearElimination=function()
    return false
  end,
  SacrificeOfNuclearElimination=function()
    return false
  end,
  GoToMotherBaseAfterQuietBattle=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterQuietBattle]
  end,
  ArrivedMotherBaseLiquid=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterWhiteMamba]
  end,
  ArrivedMotherBaseFromDeathFactory=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterDethFactory]
  end,
  EntrustDdog=function()
    if this.IsPlayedMBEventDemo"EntrustDdog"then
      return false
    end
    if TppBuddyService.DidObtainBuddyType(BuddyType.DOG)then
      return true
    else
      return false
    end
  end,
  DdogComeToGet=function()
    if this.IsPlayedMBEventDemo"DdogComeToGet"then
      return false
    end
    local n=TppStory.GetClearedMissionCount{10036,10043,10033}>=2
    local t=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
    local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET)
    return((n and t)and a)and e
  end,
  DdogGoWithMe=function()
    local a=TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=3
    local n=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
    return(a and n)and e
  end,
  LongTimeNoSee_DDSoldier=function()
    local n=TppStory.IsMissionCleard(10030)
    local e=gvars.elapsedTimeSinceLastPlay>=lastPlayTooLongAgoTime
    return n and e
  end,
  LongTimeNoSee_DdogPup=function()
    local e=gvars.elapsedTimeSinceLastPlay>=lastPlayTooLongAgoTime
    local n=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
    local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    return(e and n)and a
  end,
  LongTimeNoSee_DdogLowLikability=function()
    local e=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=lastPlayTooLongAgoTime
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<25
    return((e and n)and a)and t
  end,
  LongTimeNoSee_DdogHighLikability=function()
    local e=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=lastPlayTooLongAgoTime
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local t=25<=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)and TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<75
    return((e and n)and a)and t
  end,
  LongTimeNoSee_DdogSuperHighLikability=function()
    local o=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=lastPlayTooLongAgoTime
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)>=75
    return((o and n)and a)and e
  end,
  AttackedFromOtherPlayer_KnowWhereFrom=function()
    if this.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or this.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
    local e=vars.mbmDemoAttackedFromOtherPlayerKnowWhereFrom~=0
    return n and e
  end,
  AttackedFromOtherPlayer_UnknowWhereFrom=function()
    if this.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or this.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
      return false
    end
    local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
    local n=vars.mbmRequestDemoAttackedFromOtherPlayer~=0
    return e and n
  end,
  MoraleOfMBIsLow=function()
    if this.IsPlayedMBEventDemo"MoraleOfMBIsLow"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
    local e=TppMotherBaseManagement.GetGmp()<0
    return n and e
  end,
  OcelotIsPupilOfSnake=function()
    if this.IsPlayedMBEventDemo"OcelotIsPupilOfSnake"then
      return false
    end
    local n=TppStory.IsMissionCleard(10040)
    local e=0
    for n=TppMotherBaseManagementConst.SECTION_COMBAT,TppMotherBaseManagementConst.SECTION_SECURITY do
      e=e+#TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=n}
    end
    local e=e>=3
    return n and e
  end,
  HappyBirthDay=function()
    if this.IsPlayedMBEventDemo"HappyBirthDay"then
      return false
    end
    local a=TppUiCommand.IsBirthDay()
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
    local e=TppStory.GetClearedMissionCount{10036,10043,10033}>=1
    return(a and n)and e
  end,
  HappyBirthDayWithQuiet=function()
    return false
  end,
  QuietOnHeliInRain=function()
    if this.IsPlayedMBEventDemo"QuietOnHeliInRain"then
      return false
    else
      local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
      local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=80
      local a=(vars.buddyType==BuddyType.QUIET)
      local e=TppStory.CanArrivalQuietInMB(false)
      return((n and t)and a)and e
    end
  end,
  QuietHasFriendshipWithChild=function()
    if this.IsPlayedMBEventDemo"QuietHasFriendshipWithChild"then
      return false
    else
      local t=TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Medical+1)>=2
      local a=TppStory.CanArrivalQuietInMB(true)
      local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
      local e=not(TppQuest.IsOpen"outland_q20913"or TppQuest.IsOpen"lab_q20914")
      return((t and a)and n)and e
    end
  end,
  QuietWishGoMission=function()
    if this.IsPlayedMBEventDemo"QuietWishGoMission"then
      return false
    end
    if TppStory.CanArrivalQuietInMB(false)then
      if TppQuest.IsOpen"mtbs_q99011"then
        return TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION)
      else
        return true
      end
    end
  end,
  QuietReceivesPersecution=function()
    return false
  end,
  SnakeHasBadSmell_WithoutQuiet=function()
    if this.IsPlayedMBEventDemo"SnakeHasBadSmell_WithoutQuiet"then
      return false
    end
    local e=TppStory.IsMissionCleard(10040)
    local n=Player.GetSmallFlyLevel()>=1
    return e and n
  end,
  SnakeHasBadSmell_000=function()
    if this.IsPlayedMBEventDemo"SnakeHasBadSmell_000"then
      return false
    end
    local n=TppStory.IsMissionCleard(10086)
    local e=TppStory.CanArrivalQuietInMB(false)
    local a=Player.GetSmallFlyLevel()>=1
    local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=60
    return((n and e)and a)and t
  end,
  SnakeHasBadSmell_001=function()
    return false
  end,
  EliLookSnake=function()
    if this.IsPlayedMBEventDemo"EliLookSnake"then
      return false
    end
    return false
  end,
  LiquidAndChildSoldier=function()
    if this.IsPlayedMBEventDemo"LiquidAndChildSoldier"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
    local e=TppQuest.IsOpen"sovietBase_q99030"
    return n and not e
  end,
  InterrogateQuiet=function()
    if this.IsPlayedMBEventDemo"InterrogateQuiet"then
      return false
    else
      local n=TppStory.CanArrivalQuietInMB(true)
      local e=TppQuest.IsOpen"sovietBase_q99030"
      local a=not TppRadio.IsPlayed"f2000_rtrg8290"
      return(n and e)and a
    end
  end,
  AnableDevBattleGear=function()
    if this.IsPlayedMBEventDemo"AnableDevBattleGear"then
      return false
    end
    return TppRadio.IsPlayed"f2000_rtrg8175"and(TppStory.GetClearedMissionCount{10085,10200}==0)
  end,
  CodeTalkerSunBath=function()
    if this.IsPlayedMBEventDemo"CodeTalkerSunBath"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
    local e=TppStory.IsMissionCleard(10130)
    return n and e
  end,
  ParasiticWormCarrierKill=function()
    return false
  end,
  DecisionHuey=function()
    if this.IsPlayedMBEventDemo"DecisionHuey"then
      return false
    end
    if TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY)and TppRadio.IsPlayed"f2000_rtrg8410"then
      return true
    else
      return false
    end
  end,
  DetailsNuclearDevelop=function()
    return false
  end,
  EndingSacrificeOfNuclear=function()
    return false
  end
}
function this.UpdateHappyBirthDayFlag()
  if this.IsPlayedMBEventDemo"HappyBirthDay"then
    if TppUiCommand.IsBirthDay()then
      if gvars.elapsedTimeSinceLastPlay>(24*60)*60 and(not gvars.isPlayedHappyBirthDayToday)then
        this.ClearPlayedMBEventDemoFlag"HappyBirthDay"
      end
    else
      this.ClearPlayedMBEventDemoFlag"HappyBirthDay"
      gvars.isPlayedHappyBirthDayToday=false
    end
  end
end
function this.GetMBDemoName()
  return TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST[gvars.mbFreeDemoPlayNextIndex]
end
function this.UpdateMBDemo()
  this.UpdateHappyBirthDayFlag()
  gvars.mbFreeDemoPlayNextIndex=0
  if Ivars.mbDemoSelection:Is"DISABLED" then--tex> disable mb demo
    return
  elseif Ivars.mbDemoSelection:Is"PLAY" then
    gvars.mbFreeDemoPlayNextIndex=Ivars.mbSelectedDemo:Get()+1--tex TODO: sanity check
    return
  end--<
  for n,demoName in ipairs(TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST)do
    local canRunDemo=this.mtbsPriorityFuncList[demoName]
    if canRunDemo and canRunDemo()then
      gvars.mbFreeDemoPlayNextIndex=n
      return
    end
  end
end
function this.IsUseMBDemoStage(demoName)
  if not TppMission.IsMissionStart()then
    return false
  end
  if demoName then
    for n,demoStageDemoName in pairs(TppDefine.MB_FREEPLAY_LARGEDEMO)do
      if demoStageDemoName==demoName then
        return true
      end
    end
  end
  return false
end
function this.SetNextMBDemo(demoName)
  local demoEnum=TppDefine.MB_FREEPLAY_DEMO_ENUM[demoName]
  if demoName and demoEnum then
    gvars.mbFreeDemoPlayNextIndex=demoEnum+1
  else
    gvars.mbFreeDemoPlayNextIndex=0
  end
end
function this.CanUpdateMBDemo()
  for n,e in pairs(TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE)do
    if gvars.mbFreeDemoPlayRequestFlag[e]then
      return true
    end
  end
  if not TppMission.IsStartFromHelispace()then
    return false
  end
  return true
end
function this.IsQuestStart()
  if not TppMission.IsStartFromHelispace()then
    return false
  end
  if TppQuest.IsActive"mtbs_q99050"and MotherBaseStage.GetFirstCluster()==TppDefine.CLUSTER_DEFINE.Develop then
    return true
  end
  if TppQuest.IsActive"mtbs_q99011"and MotherBaseStage.GetFirstCluster()==TppDefine.CLUSTER_DEFINE.Medical then
    return true
  end
  return false
end
function this.IsSortieMBDemo(demoName)
  if TppDefine.MB_FREEPLAY_RIDEONHELI_DEMO_DEFINE[demoName]then
    return true
  else
    return false
  end
end
function this.IsBattleHangerDemo(demoName)
  local hangarDemoNames={"DevelopedBattleGear1","DevelopedBattleGear2","DevelopedBattleGear4","DevelopedBattleGear5"}
  for a,hangarDemoName in ipairs(hangarDemoNames)do
    if hangarDemoName==demoName then
      return true
    end
  end
  return false
end
function this.EnableNpc(demoName)
  local demoFlags=mvars.dem_demoFlags[demoName]or{}
  if not demoFlags.isInGame then
    local targetStatus="all"
    local demoId=mvars.dem_demoList[demoName]
    if demoFlags.finishFadeOut or mvars.dem_isSkipped[demoId]then
      targetStatus={}
      for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
        targetStatus[gameStatusName]=statusType
      end
    end
    this.EnableGameStatus(targetStatus,demoFlags.exceptGameStatus)
  end
  this.ClearIgnoreNpcDisableOnDemoEnd()
end
function this.UpdateNuclearAbolitionFlag()
  if gvars.f30050_needUpdateNuclearFlag then
    gvars.f30050_NuclearAbolitionCount=TppServerManager.GetNuclearAbolitionCount()
    gvars.f30050_discardNuclearCountFromLastAbolition=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
    gvars.f30050_needUpdateNuclearFlag=false
  end
end
return this

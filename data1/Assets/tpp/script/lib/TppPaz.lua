-- TppPaz.lua
local this={}
local StrCode32=Fox.StrCode32
local SendCommand=GameObject.SendCommand
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
this.START_TYPE_NO_PICTURE=0
this.START_TYPE_PICTURE=1
this.START_TYPE_DOWN=2
this.DEMO_END_TYPE_NONE=0
this.DEMO_END_TYPE_SIT=1
this.DEMO_END_TYPE_DOWN=2
local pazLocator="mtbs_uq0040_plnt0000|uq_00400000|uq_0040_asset|TppPazLocator"
local paz1_q_book_idl={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_book_idl.gani"}
local paz1_q_sit_idl={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl.gani"}
local paz1_q_sit_idl_2={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_2.gani"}
local paz1_q_sit_idl_ver2={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_ver2.gani"}
local paz1_q_sit_idl_3_st={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_st.gani"}
local paz1_q_sit_idl_3_lp={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_lp.gani"}
local paz1_q_sit_idl_3_ed={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_ed.gani"}
local paz1_q_take_pic={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic.gani"}
local paz1_q_take_pic2={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic2.gani"}
local paz1_q_take_pic1={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic1.gani"}
local paz1_q_pic_idl={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_pic_idl.gani"}
local paz1_q_come_snk={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_come_snk.gani"}
local paz1_q_bed_dwn={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_bed_dwn.gani"}
local paz1_p_idl1={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl1.gani"}
local paz1_p_idl2={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl2.gani"}
local paz1_q_drop_book={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_drop_book.gani"}
local paz1_q_take_book={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_book.gani"}
local statePaz_q_sit_idl={"PlayState","statePaz_q_sit_idl"}
local statePaz_q_sit_idl_f={"PlayState","statePaz_q_sit_idl_f"}
local statePaz_q_sit_idl_ver2={"PlayState","statePaz_q_sit_idl_ver2"}
local statePaz_q_come_snk={"PlayState","statePaz_q_come_snk"}
local statePaz_q_drop_book={"PlayState","statePaz_q_drop_book"}
local statePaz_q_take_pic1={"PlayState","statePaz_q_take_pic1"}
local statePaz_q_take_pic2={"PlayState","statePaz_q_take_pic2"}
local statePaz_q_pic_idl_f={"PlayState","statePaz_q_pic_idl_f"}
local snappaz_give_bookGani="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_book.gani"
local snappaz_give_picGani="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_pic.gani"
local bookIdleAnims={paz1_q_book_idl}
local sitIdle2Anims={paz1_q_sit_idl_2}
local sitIdle3Anims={paz1_q_sit_idl_3_st}
local actionsTable={
  paz1_q_book_idl,
  paz1_q_sit_idl,
  paz1_q_sit_idl_2,
  paz1_q_sit_idl_ver2,
  paz1_q_sit_idl_3_st,
  paz1_q_sit_idl_3_lp,
  paz1_q_sit_idl_3_ed,
  paz1_q_take_pic,
  paz1_q_take_pic2,
  paz1_q_take_pic1,
  paz1_q_pic_idl,
  paz1_q_come_snk,
  paz1_q_bed_dwn,
  paz1_p_idl1,
  paz1_p_idl2,
  paz1_q_drop_book,
  paz1_q_take_book,
  statePaz_q_sit_idl,
  statePaz_q_sit_idl_f,
  statePaz_q_sit_idl_ver2,
  statePaz_q_come_snk,
  statePaz_q_drop_book,
  statePaz_q_take_pic1,
  statePaz_q_take_pic2,
  statePaz_q_pic_idl_f
}
local paz_koiT={"paz_koi01","paz_koi02"}
local paz_roomT={"paz_room01","paz_room03"}
local paz_room02="paz_room02"
local paz_room04="paz_room04"
local paz_misete01T={"paz_misete01"}
local paz_misete02="paz_misete02"
local paz_atamaT={"paz_atama01","paz_atama02","paz_atama03","paz_atama04"}
local unk4={"paz_misete01","paz_atama01","paz_atama03","paz_atama04"}
local photoNames={"paz_photo01","paz_photo02","paz_photo03","paz_photo04","paz_photo05","paz_photo06","paz_photo07","paz_photo08","paz_photo09","paz_photo10"}
local paz_room_book01="paz_room_book01"
local paz_room_book02="paz_room_book02"
local photoAfter4="paz_photo_after04"
local photoAfterT={"paz_photo_after01","paz_photo_after02","paz_photo_after03"}
local negoto={"paz_negoto01","paz_negoto02","paz_negoto03","paz_negoto04"}
local matane={"paz_matane01","paz_matane02"}
local PazTimerSenderEnableSeeYou="PazTimerSenderEnableSeeYou"
local PazTimerSenderEnableShowMe="PazTimerSenderEnableShowMe"
local PazTimerSenderPhotoAfter="PazTimerSenderPhotoAfter"
local PazTimerSenderDown="PazTimerSenderDown"
local PazTimerSenderHumming="PazTimerSenderHumming"
local PazTimerSenderPerceive="PazTimerSenderPerceive"
local PazTimerSenderSleep="PazTimerSenderSleep"
local PazTimerSenderConfusionOutAngle="PazTimerSenderConfusionOutAngle"
local PazTimerSenderAimDefault="PazTimerSenderAimDefault"
local PazTimerSenderCheckIdleAction="PazTimerSenderCheckIdleAction"
local PazTimerSenderEnableIdleAction="PazTimerSenderEnableIdleAction"
local PazTimerSenderIdleMonologue="PazTimerSenderIdleMonologue"
local PazTimerSenderEnableIdleMonologue="PazTimerSenderEnableIdleMonologue"
local PazClockSenderEndWait="PazClockSenderEndWait"
function this.ActiveMessages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="SpecialActionEnd",sender=pazLocator,func=this.OnSpecialActionEnd},
      {msg="PazShowIcon",sender=pazLocator,func=this.OnPazShowIcon},
      {msg="PazHideIcon",sender=pazLocator,func=this.OnPazHideIcon},
      {msg="PazPerceiveSnake",sender=pazLocator,func=this.OnPazPerceiveSnake},
      {msg="MonologueEnd",sender=pazLocator,func=this.OnMonologueEnd},
      {msg="PazHasAimedDefault",sender=pazLocator,func=this.OnPazHasAimedDefault},
      {msg="PazRelaxEndTiming",sender=pazLocator,func=this.OnPazRelaxEndTiming},
      {msg="PazOutAngle",sender=pazLocator,func=this.OnPazOutAngle},
      {msg="PazInAngle",sender=pazLocator,func=this.OnPazInAngle},
      {msg="PazSnakeIsStopping",sender=pazLocator,func=this.OnPazSnakeIsStopping},
      {msg="PazSnakeIsMoving",sender=pazLocator,func=this.OnPazSnakeIsMoving}
    },
    Player={
      {msg="IconOk",func=this.OnIconOk},
      {msg="IconSwitchShown",func=this.OnIconSwitchShown}},
    Timer={
      {msg="Finish",sender=PazTimerSenderEnableSeeYou,func=function()
        this.OnFinishTimer(PazTimerSenderEnableSeeYou)
      end},
      {msg="Finish",sender=PazTimerSenderEnableShowMe,func=function()
        this.OnFinishTimer(PazTimerSenderEnableShowMe)
      end},
      {msg="Finish",sender=PazTimerSenderPhotoAfter,func=function()
        this.OnFinishTimer(PazTimerSenderPhotoAfter)
      end},
      {msg="Finish",sender=PazTimerSenderDown,func=function()
        this.OnFinishTimer(PazTimerSenderDown)
      end},
      {msg="Finish",sender=PazTimerSenderHumming,func=function()
        this.OnFinishTimer(PazTimerSenderHumming)
      end},
      {msg="Finish",sender=PazTimerSenderPerceive,func=function()
        this.OnFinishTimer(PazTimerSenderPerceive)
      end},
      {msg="Finish",sender=PazTimerSenderSleep,func=function()
        this.OnFinishTimer(PazTimerSenderSleep)
      end},
      {msg="Finish",sender=PazTimerSenderConfusionOutAngle,func=function()
        this.OnFinishTimer(PazTimerSenderConfusionOutAngle)
      end},
      {msg="Finish",sender=PazTimerSenderAimDefault,func=function()
        this.OnFinishTimer(PazTimerSenderAimDefault)
      end},
      {msg="Finish",sender=PazTimerSenderCheckIdleAction,func=function()
        this.OnFinishTimer(PazTimerSenderCheckIdleAction)
      end},
      {msg="Finish",sender=PazTimerSenderEnableIdleAction,func=function()
        this.OnFinishTimer(PazTimerSenderEnableIdleAction)
      end},
      {msg="Finish",sender=PazTimerSenderIdleMonologue,func=function()
        this.OnFinishTimer(PazTimerSenderIdleMonologue)
      end},
      {msg="Finish",sender=PazTimerSenderEnableIdleMonologue,func=function()
        this.OnFinishTimer(PazTimerSenderEnableIdleMonologue)
      end}}}
end
function this.InactiveMessages()
  return Tpp.StrCode32Table{
    Weather={
      {msg="Clock",sender=PazClockSenderEndWait,func=function()
        this.OnClock(PazClockSenderEndWait)
      end
      }
    }
  }
end
function this.OnAllocate(missionTable)
end
function this.Init(missionTable)
end
function this.OnReload()
  if mvars.paz_isActive then
    this.messageExecTable=Tpp.MakeMessageExecTable(this.ActiveMessages())
  else
    this.messageExecTable=Tpp.MakeMessageExecTable(this.InactiveMessages())
  end
  this.GetPazGameObjectId()
  if mvars.paz_currentAction~=nil then
    for n,action in ipairs(actionsTable)do
      if action[2]==mvars.paz_currentAction[2]then
        mvars.paz_currentAction=action
        break
      end
    end
  end
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.SetDemoEndType(demoEndType)
  mvars.paz_demoEndType=demoEndType
end
function this.GetDemoEndType()
  if not mvars.paz_demoEndType then
    mvars.paz_demoEndType=this.DEMO_END_TYPE_NONE
  end
  return mvars.paz_demoEndType
end
function this.SetStartType(pazMode)
  mvars.paz_startType=pazMode
end
function this.GetStartType()
  if not mvars.paz_startType then
    mvars.paz_startType=this.START_TYPE_RANDOM
  end
  return mvars.paz_startType
end
function this.OnDemoEnter()
  mvars.paz_isActive=true
  local action=nil
  local commandId=nil
  local demoEndType=this.GetDemoEndType()
  if demoEndType==this.DEMO_END_TYPE_SIT then
    action=statePaz_q_sit_idl
    commandId="Book"
  elseif demoEndType==this.DEMO_END_TYPE_DOWN then
    action=paz1_p_idl2
    commandId="Blood"
  end
  if action~=nil then
    this.SendCommandSpecialAction(action,commandId)
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.ActiveMessages())
  this.InitUi()
  this.InitMusic()
end
function this.OnEnter(isSkipPlayerInit)
  mvars.paz_isActive=true
  mvars.paz_lastMonologueLabel=""
  mvars.paz_takeActionPath=paz1_q_take_pic
  mvars.paz_giveActionPath=snappaz_give_picGani
  mvars.paz_isSeeYouMonologueEnabled=false
  mvars.paz_isShowMeMonologueEnabled=true
  mvars.paz_isIdleActionEnabled=false
  mvars.paz_isIdleMonologueEnabled=false
  mvars.paz_isSpeeching=false
  mvars.paz_hasDroppedBook=false
  this.InitTimer()
  local paz_startPosition=this.GetPosition()
  local paz_startRotationY=this.GetRotationY()
  local demoEndType=this.GetDemoEndType()
  local startType=this.GetStartType()
  local animationTable=nil
  local doWarp=false
  local postionOffset=nil
  local rotationOffset=nil
  local paz_doesSnakeHasPicture=false
  if demoEndType==this.DEMO_END_TYPE_SIT then
    paz_doesSnakeHasPicture=true
  elseif demoEndType==this.DEMO_END_TYPE_DOWN then
  else
    if startType==this.START_TYPE_NO_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        animationTable=statePaz_q_sit_idl
      else
        animationTable=this.GetItemInTableAtRandom(bookIdleAnims)
      end
    elseif startType==this.START_TYPE_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        animationTable=statePaz_q_sit_idl
      else
        animationTable=this.GetItemInTableAtRandom(sitIdle2Anims)
      end
      paz_doesSnakeHasPicture=true
    elseif startType==this.START_TYPE_DOWN then
      animationTable=paz1_p_idl1
    end
  end
  if animationTable~=nil then
    local heightAdjust=0
    if this.IsReal()then
      heightAdjust=.8
    end
    if animationTable[2]==paz1_q_sit_idl_2[2]or animationTable[2]==statePaz_q_come_snk[2]then
      postionOffset=Vector3(.05535,.48294+heightAdjust,-.1489)
      rotationOffset=-foxmath.PI*.5
      doWarp=true
    elseif animationTable[2]==paz1_p_idl1[2]then
      postionOffset=Vector3(-.2,.5033+heightAdjust,-.2)
      rotationOffset=-foxmath.PI*.5
      doWarp=true
    end
    if doWarp then
      local position=paz_startPosition+Quat.RotationY(paz_startRotationY-foxmath.PI*.5):Rotate(postionOffset)
      local rotation=paz_startRotationY+rotationOffset
      this.Warp(position,rotation)
    end
    this.SendCommandSpecialAction(animationTable)
  end
  if animationTable==statePaz_q_sit_idl then
    if gvars.pazLookedPictureCount<7 then
      this.SendCommandCallMonologue(paz_roomT)
    else
      this.SendCommandCallMonologue(paz_room02)
    end
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.ActiveMessages())
  GkEventTimerManager.Start(PazTimerSenderEnableSeeYou,30)
  GkEventTimerManager.Start(PazTimerSenderCheckIdleAction,2)
  GkEventTimerManager.Start(PazTimerSenderEnableIdleAction,10)
  mvars.paz_startPosition=paz_startPosition
  mvars.paz_startRotationY=paz_startRotationY
  mvars.paz_doesSnakeHasPicture=paz_doesSnakeHasPicture
  mvars.paz_demoEndType=this.DEMO_END_TYPE_NONE
  this.InitUi()
  if not isSkipPlayerInit then
    this.InitPlayer()
  end
  this.InitMusic()
  TppRadio.Stop()
  this.UpdateIcon()
end
function this.OnLeave()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.InactiveMessages())
  TppClock.RegisterClockMessage(PazClockSenderEndWait,TppClock.GetTime"number"+(1*60)*60)
  mvars.paz_isActive=false
  mvars.paz_isIconEnabled=false
  this.InitTimer()
  this.UpdateIcon()
  this.TermMusic()
  this.TermPlayer()
  this.TermUi()
end
function this.NeedsToWaitLeave()
  return mvars.paz_isSpeeching and this.IsInTable(mvars.paz_lastMonologueLabel,matane)
end
function this.OnSpecialActionEnd(gameId,actionId,commandId)
  if commandId==StrCode32(statePaz_q_come_snk[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
    this.SendCommandCallMonologue(paz_misete01T[math.random(#paz_misete01T)])
  elseif commandId==StrCode32(paz1_q_take_pic[2])then
    this.SendCommandSpecialAction(paz1_q_pic_idl)
    this.SendCommandCallMonologue(photoNames[gvars.pazLookedPictureCount])
  elseif commandId==StrCode32(paz1_q_take_pic2[2])or commandId==StrCode32(statePaz_q_take_pic2[2])then
    this.SendCommandSpecialAction(paz1_q_pic_idl)
  elseif commandId==StrCode32(paz1_q_take_pic1[2])or commandId==StrCode32(statePaz_q_take_pic1[2])then
    this.SendCommandSpecialAction(paz1_q_pic_idl)
  elseif commandId==StrCode32(statePaz_q_drop_book[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
    mvars.paz_takeActionPath=paz1_q_take_book
    mvars.paz_giveActionPath=snappaz_give_bookGani
  elseif commandId==StrCode32(paz1_q_take_book[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
    this.SendCommandCallMonologue(paz_room_book02)
  elseif commandId==StrCode32(paz1_q_bed_dwn[2])then
    this.SendCommandSpecialAction(paz1_p_idl1)
  elseif commandId==StrCode32(paz1_q_sit_idl_3_st[2])then
    this.SendCommandSpecialAction(paz1_q_sit_idl_3_lp)
    this.SendCommandCallMonologue(paz_koiT)
  elseif commandId==StrCode32(paz1_q_sit_idl_3_ed[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
  elseif commandId==StrCode32(paz1_q_sit_idl_ver2[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
  elseif commandId==StrCode32(statePaz_q_sit_idl_ver2[2])then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
  end
end
function this.OnMonologueEnd(GameObjectId,speechLabel,isSuccess)
  if this.IsMonologuePhotoSpeech(speechLabel)then
    if gvars.pazLookedPictureCount<7 then
      GkEventTimerManager.Start(PazTimerSenderDown,2+foxmath.FRnd()*2)
    else
      GkEventTimerManager.Start(PazTimerSenderPhotoAfter,2+foxmath.FRnd()*2)
    end
  elseif this.IsInTable(speechLabel,paz_roomT)then
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,60)
  elseif speechLabel==StrCode32(paz_room02)then
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,60)
  elseif speechLabel==StrCode32(paz_room04)then
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,60)
  elseif speechLabel==StrCode32(paz_misete02)then
    GkEventTimerManager.Stop(PazTimerSenderEnableIdleMonologue)
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif speechLabel==StrCode32(paz_room_book02)then
    GkEventTimerManager.Stop(PazTimerSenderEnableIdleMonologue)
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif this.IsInTable(speechLabel,matane)then
    GkEventTimerManager.Stop(PazTimerSenderEnableIdleMonologue)
    GkEventTimerManager.Start(PazTimerSenderEnableIdleMonologue,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif this.IsInTable(speechLabel,paz_koiT)then
    GkEventTimerManager.Start(PazTimerSenderHumming,5+foxmath.FRnd()*5)
  elseif speechLabel==StrCode32(photoAfter4)then
    GkEventTimerManager.Start(PazTimerSenderDown,2+foxmath.FRnd()*2)
  elseif this.IsInTable(speechLabel,negoto)then
    GkEventTimerManager.Start(PazTimerSenderSleep,10+foxmath.FRnd()*10)
  elseif this.IsInTable(speechLabel,paz_atamaT)then
    GkEventTimerManager.Start(PazTimerSenderAimDefault,2+foxmath.FRnd()*2)
  end
  if isSuccess~=0 then
    mvars.paz_isSpeeching=false
  end
end
function this.OnFinishTimer(timerName)
  if timerName==PazTimerSenderPhotoAfter then
    this.SendCommandCallMonologue(photoAfter4)
  elseif timerName==PazTimerSenderDown then
    this.SendCommandSpecialAction(paz1_q_bed_dwn)
  elseif timerName==PazTimerSenderHumming then
    if not mvars.paz_hasPerceivedSnake then
      this.SendCommandCallMonologue(paz_koiT)
    elseif mvars.paz_currentAction==paz1_q_sit_idl_3_lp then
      this.SendCommandCallMonologue(paz_koiT)
    end
  elseif timerName==PazTimerSenderPerceive then
    if mvars.paz_currentAction==paz1_q_sit_idl_2 then
      this.SendCommandSpecialAction(statePaz_q_come_snk)
    elseif mvars.paz_currentAction==paz1_q_book_idl then
      this.SendCommandSpecialAction(statePaz_q_drop_book)
    end
  elseif timerName==PazTimerSenderSleep then
    if mvars.paz_currentAction==paz1_p_idl1 or mvars.paz_currentAction==paz1_p_idl2 then
      this.SendCommandCallMonologue(negoto)
    end
  elseif timerName==PazTimerSenderEnableSeeYou then
    mvars.paz_isSeeYouMonologueEnabled=true
  elseif timerName==PazTimerSenderEnableShowMe then
    mvars.paz_isShowMeMonologueEnabled=true
  elseif timerName==PazTimerSenderConfusionOutAngle then
    if mvars.paz_isOutAngle and mvars.paz_currentAction==statePaz_q_sit_idl_f then
      this.SendCommandSpecialAction(statePaz_q_sit_idl)
      this.SendCommandCallMonologue(paz_atamaT)
    end
  elseif timerName==PazTimerSenderAimDefault then
    if mvars.paz_isOutAngle then
      this.SendCommandSpecialAction(statePaz_q_sit_idl_f)
    end
  elseif timerName==PazTimerSenderCheckIdleAction then
    GkEventTimerManager.Start(PazTimerSenderCheckIdleAction,2)
    if mvars.paz_isIdleActionEnabled and mvars.paz_currentAction==statePaz_q_sit_idl then
      local playerPosition=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
      local n=this.GetPosition()
      if(playerPosition-n):GetLengthSqr()>3*3 then
        this.SendCommandSpecialAction(statePaz_q_sit_idl_ver2)
        GkEventTimerManager.Start(PazTimerSenderEnableIdleAction,10+foxmath.FRnd()*5)
        mvars.paz_isIdleActionEnabled=false
      end
    end
  elseif timerName==PazTimerSenderEnableIdleAction then
    mvars.paz_isIdleActionEnabled=true
  elseif timerName==PazTimerSenderIdleMonologue then
    if not mvars.paz_isSpeeching then
      if mvars.paz_isSnakeStopping then
        if mvars.paz_currentAction==statePaz_q_sit_idl then
          this.SendCommandSpecialAction(statePaz_q_sit_idl_f)
        end
      elseif mvars.paz_isOutAngle then
      else
        if mvars.paz_isIdleMonologueEnabled then
          if mvars.paz_currentAction==statePaz_q_sit_idl or mvars.paz_currentAction==statePaz_q_sit_idl_ver2 then
            this.SendCommandCallMonologue(unk4)
          end
        end
      end
    end
    GkEventTimerManager.Start(PazTimerSenderIdleMonologue,10+foxmath.FRnd()*10)
  elseif timerName==PazTimerSenderEnableIdleMonologue then
    mvars.paz_isIdleMonologueEnabled=true
    GkEventTimerManager.Stop(PazTimerSenderIdleMonologue)
    GkEventTimerManager.Start(PazTimerSenderIdleMonologue,2+foxmath.FRnd()*2)
  end
end
function this.OnPazPerceiveSnake()
  if mvars.paz_currentAction==paz1_q_sit_idl_2 then
    this.SendCommandSpecialAction(statePaz_q_come_snk)
  elseif mvars.paz_currentAction==paz1_q_book_idl then
    this.SendCommandSpecialAction(statePaz_q_drop_book)
  end
end
function this.OnPazHasAimedDefault()
  if mvars.paz_idleActionSameCount==nil then
    mvars.paz_idleActionSameCount=0
  end
  if mvars.paz_isSnakeStopping then
    local action=nil
    if mvars.paz_idleActionSameCount>=1 then
      action=this.GetItemInTableAtRandom(sitIdle3Anims)
    else
      action=this.GetItemInTableAtRandom(sitIdle3Anims)
    end
    if action==mvars.pazLastIdleAction then
      mvars.paz_idleActionSameCount=mvars.paz_idleActionSameCount+1
    else
      mvars.paz_idleActionSameCount=0
    end
    this.SendCommandSpecialAction(action)
    mvars.pazLastIdleAction=action
  elseif mvars.paz_isOutAngle then
    GkEventTimerManager.Start(PazTimerSenderConfusionOutAngle,2+foxmath.FRnd()*5)
  else
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
  end
end
function this.OnPazShowIcon()
  mvars.paz_isIconEnabled=true
  this.UpdateIcon()
end
function this.OnPazHideIcon()
  mvars.paz_isIconEnabled=false
  this.UpdateIcon()
end
function this.OnIconOk()
  this.SendCommandSpecialAction(mvars.paz_takeActionPath)
  this.PlayPlayerMotion(mvars.paz_giveActionPath)
  if mvars.paz_takeActionPath[2]==paz1_q_take_book[2]then
    mvars.paz_isSeeYouMonologueEnabled=true
  end
end
function this.OnIconSwitchShown()
  if((((((mvars.paz_currentAction~=paz1_p_idl1 and mvars.paz_currentAction~=paz1_p_idl2)and mvars.paz_currentAction~=paz1_q_bed_dwn)and mvars.paz_currentAction~=paz1_q_pic_idl)and mvars.paz_currentAction~=paz1_q_take_pic)and mvars.paz_currentAction~=paz1_q_take_pic1)and mvars.paz_currentAction~=paz1_q_take_pic2)and mvars.paz_isSeeYouMonologueEnabled then
    this.SendCommandCallMonologue(matane)
    GkEventTimerManager.Stop(PazTimerSenderEnableSeeYou)
    GkEventTimerManager.Start(PazTimerSenderEnableSeeYou,30)
    GkEventTimerManager.Stop(PazTimerSenderEnableShowMe)
    GkEventTimerManager.Start(PazTimerSenderEnableShowMe,30)
    mvars.paz_isSeeYouMonologueEnabled=false
    mvars.paz_isShowMeMonologueEnabled=false
  end
end
function this.OnPazRelaxEndTiming()
  if not mvars.paz_isOutAngle and not mvars.paz_isSnakeStopping then
    this.SendCommandSpecialAction(paz1_q_sit_idl_3_ed)
    if mvars.paz_isSpeeching and this.IsInTable(mvars.paz_lastMonologueLabel,paz_koiT)then
      this.SendCommandCallMonologue""
    end
  end
end
function this.OnPazOutAngle()
  mvars.paz_isOutAngle=true
  if mvars.paz_currentAction==statePaz_q_sit_idl then
    this.SendCommandSpecialAction(statePaz_q_sit_idl_f)
  end
end
function this.OnPazInAngle()
  mvars.paz_isOutAngle=false
  if mvars.paz_currentAction==statePaz_q_sit_idl_f then
    this.SendCommandSpecialAction(statePaz_q_sit_idl)
  end
end
function this.OnPazSnakeIsStopping()
  mvars.paz_isSnakeStopping=true
  if mvars.paz_currentAction==statePaz_q_sit_idl and not mvars.paz_isSpeeching then
    this.SendCommandSpecialAction(statePaz_q_sit_idl_f)
  end
end
function this.OnPazSnakeIsMoving()
  mvars.paz_isSnakeStopping=false
end
function this.OnClock(e)
  if e==PazClockSenderEndWait then
    mvars.paz_hasPerceivedSnake=false
    TppClock.UnregisterClockMessage(PazClockSenderEndWait)
  end
end
function this.IsReal()
  return GameObject.SendCommand(this.GetPazGameObjectId(),{id="IsReal"})
end
function this.Warp(position,rotationY)
  GameObject.SendCommand(this.GetPazGameObjectId(),{id="Warp",position=position,rotationY=rotationY})
end
function this.SendCommandSpecialAction(action,commandId)
  local path=action[2]
  if not commandId then
    commandId=path
  end
  local interpFrame=8
  if action[3]~=nil then
    interpFrame=action[3]
  end
  SendCommand(this.GetPazGameObjectId(),{id="SpecialAction",action=action[1],path=path,state=path,autoFinish=false,enableMessage=true,commandId=StrCode32(commandId),enableGravity=false,enableCollision=false,interpFrame=interpFrame})
  mvars.paz_currentAction=action
  if path==statePaz_q_sit_idl[2]then
    mvars.paz_hasPerceivedSnake=true
  elseif path==paz1_q_sit_idl_2[2]then
    if foxmath.FRnd()<.5 then
      this.SendCommandCallMonologue(this.GetItemInTableAtRandom(paz_koiT))
    else
      GkEventTimerManager.Start(PazTimerSenderPerceive,.5+foxmath.FRnd()*.5)
    end
  elseif path==paz1_q_book_idl[2]then
    if foxmath.FRnd()<.5 then
      this.SendCommandCallMonologue(this.GetItemInTableAtRandom(paz_koiT))
    else
      GkEventTimerManager.Start(PazTimerSenderPerceive,.5+foxmath.FRnd()*.5)
    end
  elseif path==statePaz_q_come_snk[2]then
    local n=false
    for a,e in ipairs(paz_koiT)do
      if e==mvars.paz_lastMonologueLabel then
        n=true
        break
      end
    end
    if n then
      this.SendCommandCallMonologue(paz_room04)
    else
      if gvars.pazLookedPictureCount<7 then
        this.SendCommandCallMonologue(paz_roomT)
      else
        this.SendCommandCallMonologue(paz_room02)
      end
    end
    mvars.paz_hasPerceivedSnake=true
  elseif path==statePaz_q_drop_book[2]then
    mvars.paz_hasDroppedBook=true
    this.SendCommandCallMonologue(paz_room_book01)
    mvars.paz_hasPerceivedSnake=true
  elseif path==paz1_q_take_book[2]then
    mvars.paz_hasDroppedBook=false
  elseif path==paz1_q_take_pic[2]then
    mvars.paz_doesSnakeHasPicture=false
  elseif path==paz1_q_bed_dwn[2]then
    this.SendCommandCallMonologue(photoAfterT[math.random(#photoAfterT)])
  elseif path==paz1_p_idl1[2]then
    GkEventTimerManager.Start(PazTimerSenderSleep,10+foxmath.FRnd()*10)
  elseif path==paz1_p_idl2[2]then
    GkEventTimerManager.Start(PazTimerSenderSleep,10+foxmath.FRnd()*10)
  end
  this.UpdateIcon()
end
function this.SendCommandCallMonologue(label)
  if not mvars.paz_monologueSameCount then
    mvars.paz_monologueSameCount=0
  end
  if type(label)=="table"then
    local a=#label
    if a==1 then
      label=this.GetItemInTableAtRandom(label)
    elseif a==2 then
      if mvars.paz_monologueSameCount==0 then
        label=this.GetItemInTableAtRandom(label)
      else
        label=this.GetItemInTableAtRandom(label,mvars.paz_lastMonologueLabel)
      end
    else
      label=this.GetItemInTableAtRandom(label,mvars.paz_lastMonologueLabel)
    end
  end
  SendCommand(this.GetPazGameObjectId(),{id="CallMonologue",label=label,reset=true})
  if label==mvars.paz_lastMonologueLabel then
    mvars.paz_monologueSameCount=mvars.paz_monologueSameCount+1
  else
    mvars.paz_monologueSameCount=0
  end
  mvars.paz_lastMonologueLabel=label
  if label==""then
    mvars.paz_isSpeeching=false
  else
    mvars.paz_isSpeeching=true
  end
end
function this.GetPosition()
  return GameObject.SendCommand(this.GetPazGameObjectId(),{id="GetPosition"})
end
function this.GetRotationY()
  return GameObject.SendCommand(this.GetPazGameObjectId(),{id="GetRotationY"})
end
function this.InitTimer()
  GkEventTimerManager.Stop(PazTimerSenderEnableSeeYou)
  GkEventTimerManager.Stop(PazTimerSenderEnableShowMe)
  GkEventTimerManager.Stop(PazTimerSenderPhotoAfter)
  GkEventTimerManager.Stop(PazTimerSenderDown)
  GkEventTimerManager.Stop(PazTimerSenderHumming)
  GkEventTimerManager.Stop(PazTimerSenderPerceive)
  GkEventTimerManager.Stop(PazTimerSenderSleep)
  GkEventTimerManager.Stop(PazTimerSenderConfusionOutAngle)
  GkEventTimerManager.Stop(PazTimerSenderAimDefault)
  GkEventTimerManager.Stop(PazTimerSenderCheckIdleAction)
  GkEventTimerManager.Stop(PazTimerSenderEnableIdleAction)
  GkEventTimerManager.Stop(PazTimerSenderIdleMonologue)
  GkEventTimerManager.Stop(PazTimerSenderEnableIdleMonologue)
end
function this.InitUi()
  TppUI.OverrideFadeInGameStatus{EquipHud=false,EquipPanel=false,AnnounceLog=false}
  TppUiCommand.SetAllInvalidMbSoundControllerVoice()
end
function this.TermUi()
  TppUI.UnsetOverrideFadeInGameStatus()
  TppUiCommand.SetAllInvalidMbSoundControllerVoice(false)
  TppUiStatusManager.UnsetStatus("EquipHud","INVALID")
  TppUiStatusManager.UnsetStatus("EquipPanel","INVALID")
  TppUiStatusManager.UnsetStatus("AnnounceLog","INVALID_LOG")
  TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")
end
function this.InitPlayer()
  Player.SetAroundCameraManualMode(true)
  Player.SetAroundCameraManualModeParams{offset=Vector3(-.2,.7,0),distance=1.2,focalLength=21,focusDistance=8.175,target=Vector3(2,10,10),targetInterpTime=.2,targetIsPlayer=true,ignoreCollisionGameObjectName="Player",rotationLimitMinX=-50,rotationLimitMaxX=50,alphaDistance=.5}
  Player.UpdateAroundCameraManualModeParams()
  Player.RequestToSetCameraStock{direction="right"}
  Player.SetCurrentItemIndex{itemIndex=0}
  Player.RequestToSetTargetStance(PlayerStance.STAND)
end
function this.TermPlayer()
  Player.SetAroundCameraManualMode(false)
end
function this.InitMusic()
  TppMusicManager.StopMusicPlayer(500)
  TppMusicManager.StopHeliMusic()
  if TppMusicManager.DisableHeliNewPlay~=nil then
    TppMusicManager.DisableHeliNewPlay()
  end
end
function this.TermMusic()
  if TppMusicManager.EnableHeliNewPlay~=nil then
    TppMusicManager.EnableHeliNewPlay()
  end
end
function this.GetPazGameObjectId()
  if(not mvars.paz_gameObject)or(mvars.paz_gameObject==NULL_ID)then
    mvars.paz_gameObject=GetGameObjectId(pazLocator)
  end
  return mvars.paz_gameObject
end
function this.GetStartPosition()
  return mvars.paz_startPosition
end
function this.GetStartRotationY()
  return mvars.paz_startRotationY
end
function this.UpdateIcon()
  if(mvars.paz_isIconEnabled and mvars.paz_currentAction==statePaz_q_sit_idl)and(mvars.paz_doesSnakeHasPicture or mvars.paz_hasDroppedBook)then
    if not mvars.paz_isIconVisible then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=StrCode32"IconOk",messageArg=""}
      mvars.paz_isIconVisible=true
      if((mvars.paz_doesSnakeHasPicture and mvars.paz_isShowMeMonologueEnabled)and not mvars.paz_isSpeeching)and mvars.paz_lastMonologueLabel~=paz_misete02 then
        this.SendCommandCallMonologue(paz_misete02)
        GkEventTimerManager.Start(PazTimerSenderEnableShowMe,30)
        mvars.paz_isShowMeMonologueEnabled=false
      end
    end
  else
    if mvars.paz_isIconVisible then
      Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}
      mvars.paz_isIconVisible=false
    end
  end
end
function this.PlayPlayerMotion(actionPath)
  Player.RequestToPlayDirectMotion{"handBookToPaz",{actionPath,false,pazLocator,"Move","MTP_GLOBAL_C",false}}
end
function this.PlayCameraAnimation()
  Player.RequestToPlayCameraNonAnimation{
    characterId=this.GetPazGameObjectId(),
    isFollowPos=true,
    isFollowRot=true,
    followTime=6,
    followDelayTime=.5,
    candidateRots={{-10,110}},
    skeletonNames={"SKL_002_CHEST"},
    skeletonCenterOffsets={Vector3(0,0,0)},
    skeletonBoundings={Vector3(.1,.1,.1)},
    offsetTarget=Vector3(0,.5,.5),
    offsetPos=Vector3(0,0,-1),
    focalLength=21,
    aperture=4,
    timeToSleep=6,
    interpTimeAtStart=1,
    fitOnCamera=false,
    timeToStartToFitCamera=1,
    fitCameraInterpTime=.3,
    diffFocalLengthToReFitCamera=16,
    isCollisionCheck=false
  }
  Player.RequestToSetCameraRotation{rotX=10,rotY=45,interpTime=1}
end
function this.IsMonologuePhotoSpeech(speechLable)
  for i,photoName in ipairs(photoNames)do
    if StrCode32(photoName)==speechLable then
      return true
    end
  end
  return false
end
function this.GetItemInTableAtRandom(table,t)
  if t==nil then
    return table[math.random(#table)]
  else
    local n={}
    local a=0
    for k,v in ipairs(table)do
      if v~=t then
        a=a+1
        n[a]=v
      end
    end
    return n[math.random(#n)]
  end
end
function this.IsInTable(item,t)
  for k,v in ipairs(t)do
    if type(item)=="number"then
      if StrCode32(v)==item then
        return true
      end
    else
      if v==item then
        return true
      end
    end
  end
  return false
end
return this

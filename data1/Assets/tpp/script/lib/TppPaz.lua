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
local b={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_book_idl.gani"}
local t={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl.gani"}
local S={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_2.gani"}
local U={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_ver2.gani"}
local q={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_st.gani"}
local y={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_lp.gani"}
local F={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_sit_idl_3_ed.gani"}
local I={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic.gani"}
local R={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic2.gani"}
local G={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_pic1.gani"}
local E={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_pic_idl.gani"}
local m={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_come_snk.gani"}
local P={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_bed_dwn.gani"}
local s={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl1.gani"}
local A={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_p_idl2.gani"}
local l={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_drop_book.gani"}
local C={"PlayMotion","/Assets/tpp/motion/SI_game/fani/bodies/paz1/paz1/paz1_q_take_book.gani"}
local a={"PlayState","statePaz_q_sit_idl"}
local r={"PlayState","statePaz_q_sit_idl_f"}
local O={"PlayState","statePaz_q_sit_idl_ver2"}
local _={"PlayState","statePaz_q_come_snk"}
local k={"PlayState","statePaz_q_drop_book"}
local w={"PlayState","statePaz_q_take_pic1"}
local j={"PlayState","statePaz_q_take_pic2"}
local i={"PlayState","statePaz_q_pic_idl_f"}
local re="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_book.gani"
local oe="/Assets/tpp/motion/SI_game/fani/bodies/snap/snappaz/snappaz_give_pic.gani"
local te={b}
local le={S}
local B={q}
local se={b,t,S,U,q,y,F,I,R,G,E,m,P,s,A,l,C,a,r,O,_,k,w,j,i}
local i={"paz_koi01","paz_koi02"}
local L={"paz_room01","paz_room03"}
local N="paz_room02"
local J="paz_room04"
local H={"paz_misete01"}
local x="paz_misete02"
local K={"paz_atama01","paz_atama02","paz_atama03","paz_atama04"}
local ie={"paz_misete01","paz_atama01","paz_atama03","paz_atama04"}
local W={"paz_photo01","paz_photo02","paz_photo03","paz_photo04","paz_photo05","paz_photo06","paz_photo07","paz_photo08","paz_photo09","paz_photo10"}
local ae="paz_room_book01"
local Z="paz_room_book02"
local Q="paz_photo_after04"
local X={"paz_photo_after01","paz_photo_after02","paz_photo_after03"}
local V={"paz_negoto01","paz_negoto02","paz_negoto03","paz_negoto04"}
local D={"paz_matane01","paz_matane02"}
local p="PazTimerSenderEnableSeeYou"
local m="PazTimerSenderEnableShowMe"
local v="PazTimerSenderPhotoAfter"
local u="PazTimerSenderDown"
local h="PazTimerSenderHumming"
local f="PazTimerSenderPerceive"
local l="PazTimerSenderSleep"
local T="PazTimerSenderConfusionOutAngle"
local g="PazTimerSenderAimDefault"
local z="PazTimerSenderCheckIdleAction"
local c="PazTimerSenderEnableIdleAction"
local d="PazTimerSenderIdleMonologue"
local t="PazTimerSenderEnableIdleMonologue"
local M="PazClockSenderEndWait"
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
      {msg="Finish",sender=p,func=function()
        this.OnFinishTimer(p)
      end},
      {msg="Finish",sender=m,func=function()
        this.OnFinishTimer(m)
      end},
      {msg="Finish",sender=v,func=function()
        this.OnFinishTimer(v)
      end},
      {msg="Finish",sender=u,func=function()
        this.OnFinishTimer(u)
      end},
      {msg="Finish",sender=h,func=function()
        this.OnFinishTimer(h)
      end},
      {msg="Finish",sender=f,func=function()
        this.OnFinishTimer(f)
      end},
      {msg="Finish",sender=l,func=function()
        this.OnFinishTimer(l)
      end},
      {msg="Finish",sender=T,func=function()
        this.OnFinishTimer(T)
      end},
      {msg="Finish",sender=g,func=function()
        this.OnFinishTimer(g)
      end},
      {msg="Finish",sender=z,func=function()
        this.OnFinishTimer(z)
      end},
      {msg="Finish",sender=c,func=function()
        this.OnFinishTimer(c)
      end},
      {msg="Finish",sender=d,func=function()
        this.OnFinishTimer(d)
      end},
      {msg="Finish",sender=t,func=function()
        this.OnFinishTimer(t)
      end}}}
end
function this.InactiveMessages()
  return Tpp.StrCode32Table{
    Weather={
      {msg="Clock",sender=M,func=function()
        this.OnClock(M)
      end
      }
    }
  }
end
function this.OnAllocate(e)
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
    for n,e in ipairs(se)do
      if e[2]==mvars.paz_currentAction[2]then
        mvars.paz_currentAction=e
        break
      end
    end
  end
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.SetDemoEndType(e)
  mvars.paz_demoEndType=e
end
function this.GetDemoEndType()
  if not mvars.paz_demoEndType then
    mvars.paz_demoEndType=this.DEMO_END_TYPE_NONE
  end
  return mvars.paz_demoEndType
end
function this.SetStartType(e)
  mvars.paz_startType=e
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
  local t=nil
  local demoEndType=this.GetDemoEndType()
  if demoEndType==this.DEMO_END_TYPE_SIT then
    action=a
    t="Book"
  elseif demoEndType==this.DEMO_END_TYPE_DOWN then
    action=A
    t="Blood"
  end
  if action~=nil then
    this.SendCommandSpecialAction(action,t)
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.ActiveMessages())
  this.InitUi()
  this.InitMusic()
end
function this.OnEnter(f)
  mvars.paz_isActive=true
  mvars.paz_lastMonologueLabel=""
  mvars.paz_takeActionPath=I
  mvars.paz_giveActionPath=oe
  mvars.paz_isSeeYouMonologueEnabled=false
  mvars.paz_isShowMeMonologueEnabled=true
  mvars.paz_isIdleActionEnabled=false
  mvars.paz_isIdleMonologueEnabled=false
  mvars.paz_isSpeeching=false
  mvars.paz_hasDroppedBook=false
  this.InitTimer()
  local u=this.GetPosition()
  local l=this.GetRotationY()
  local d=this.GetDemoEndType()
  local i=this.GetStartType()
  local n=nil
  local o=false
  local t=nil
  local r=nil
  local m=false
  if d==this.DEMO_END_TYPE_SIT then
    m=true
  elseif d==this.DEMO_END_TYPE_DOWN then
  else
    if i==this.START_TYPE_NO_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        n=a
      else
        n=this.GetItemInTableAtRandom(te)
      end
    elseif i==this.START_TYPE_PICTURE then
      if mvars.paz_hasPerceivedSnake then
        n=a
      else
        n=this.GetItemInTableAtRandom(le)
      end
      m=true
    elseif i==this.START_TYPE_DOWN then
      n=s
    end
  end
  if n~=nil then
    local a=0
    if this.IsReal()then
      a=.8
    end
    if n[2]==S[2]or n[2]==_[2]then
      t=Vector3(.05535,.48294+a,-.1489)r=-foxmath.PI*.5
      o=true
    elseif n[2]==s[2]then
      t=Vector3(-.2,.5033+a,-.2)r=-foxmath.PI*.5
      o=true
    end
    if o then
      local a=u+Quat.RotationY(l-foxmath.PI*.5):Rotate(t)
      local n=l+r
      this.Warp(a,n)
    end
    this.SendCommandSpecialAction(n)
  end
  if n==a then
    if gvars.pazLookedPictureCount<7 then
      this.SendCommandCallMonologue(L)
    else
      this.SendCommandCallMonologue(N)
    end
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.ActiveMessages())GkEventTimerManager.Start(p,30)GkEventTimerManager.Start(z,2)GkEventTimerManager.Start(c,10)
  mvars.paz_startPosition=u
  mvars.paz_startRotationY=l
  mvars.paz_doesSnakeHasPicture=m
  mvars.paz_demoEndType=this.DEMO_END_TYPE_NONE
  this.InitUi()
  if not f then
    this.InitPlayer()
  end
  this.InitMusic()
  TppRadio.Stop()
  this.UpdateIcon()
end
function this.OnLeave()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.InactiveMessages())
  TppClock.RegisterClockMessage(M,TppClock.GetTime"number"+(1*60)*60)
  mvars.paz_isActive=false
  mvars.paz_isIconEnabled=false
  this.InitTimer()
  this.UpdateIcon()
  this.TermMusic()
  this.TermPlayer()
  this.TermUi()
end
function this.NeedsToWaitLeave()
  return mvars.paz_isSpeeching and this.IsInTable(mvars.paz_lastMonologueLabel,D)
end
function this.OnSpecialActionEnd(o,o,t)
  if t==StrCode32(_[2])then
    this.SendCommandSpecialAction(a)
    this.SendCommandCallMonologue(H[math.random(#H)])
  elseif t==StrCode32(I[2])then
    this.SendCommandSpecialAction(E)
    this.SendCommandCallMonologue(W[gvars.pazLookedPictureCount])
  elseif t==StrCode32(R[2])or t==StrCode32(j[2])then
    this.SendCommandSpecialAction(E)
  elseif t==StrCode32(G[2])or t==StrCode32(w[2])then
    this.SendCommandSpecialAction(E)
  elseif t==StrCode32(k[2])then
    this.SendCommandSpecialAction(a)
    mvars.paz_takeActionPath=C
    mvars.paz_giveActionPath=re
  elseif t==StrCode32(C[2])then
    this.SendCommandSpecialAction(a)
    this.SendCommandCallMonologue(Z)
  elseif t==StrCode32(P[2])then
    this.SendCommandSpecialAction(s)
  elseif t==StrCode32(q[2])then
    this.SendCommandSpecialAction(y)
    this.SendCommandCallMonologue(i)
  elseif t==StrCode32(F[2])then
    this.SendCommandSpecialAction(a)
  elseif t==StrCode32(U[2])then
    this.SendCommandSpecialAction(a)
  elseif t==StrCode32(O[2])then
    this.SendCommandSpecialAction(a)
  end
end
function this.OnMonologueEnd(s,a,o)
  if this.IsMonologuePhotoSpeech(a)then
    if gvars.pazLookedPictureCount<7 then
      GkEventTimerManager.Start(u,2+foxmath.FRnd()*2)
    else
      GkEventTimerManager.Start(v,2+foxmath.FRnd()*2)
    end
  elseif this.IsInTable(a,L)then
    GkEventTimerManager.Start(t,60)
  elseif a==StrCode32(N)then
    GkEventTimerManager.Start(t,60)
  elseif a==StrCode32(J)then
    GkEventTimerManager.Start(t,60)
  elseif a==StrCode32(x)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif a==StrCode32(Z)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif this.IsInTable(a,D)then
    GkEventTimerManager.Stop(t)
    GkEventTimerManager.Start(t,30)
    mvars.paz_isIdleMonologueEnabled=false
  elseif this.IsInTable(a,i)then
    GkEventTimerManager.Start(h,5+foxmath.FRnd()*5)
  elseif a==StrCode32(Q)then
    GkEventTimerManager.Start(u,2+foxmath.FRnd()*2)
  elseif this.IsInTable(a,V)then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  elseif this.IsInTable(a,K)then
    GkEventTimerManager.Start(g,2+foxmath.FRnd()*2)
  end
  if o~=0 then
    mvars.paz_isSpeeching=false
  end
end
function this.OnFinishTimer(n)
  if n==v then
    this.SendCommandCallMonologue(Q)
  elseif n==u then
    this.SendCommandSpecialAction(P)
  elseif n==h then
    if not mvars.paz_hasPerceivedSnake then
      this.SendCommandCallMonologue(i)
    elseif mvars.paz_currentAction==y then
      this.SendCommandCallMonologue(i)
    end
  elseif n==f then
    if mvars.paz_currentAction==S then
      this.SendCommandSpecialAction(_)
    elseif mvars.paz_currentAction==b then
      this.SendCommandSpecialAction(k)
    end
  elseif n==l then
    if mvars.paz_currentAction==s or mvars.paz_currentAction==A then
      this.SendCommandCallMonologue(V)
    end
  elseif n==p then
    mvars.paz_isSeeYouMonologueEnabled=true
  elseif n==m then
    mvars.paz_isShowMeMonologueEnabled=true
  elseif n==T then
    if mvars.paz_isOutAngle and mvars.paz_currentAction==r then
      this.SendCommandSpecialAction(a)
      this.SendCommandCallMonologue(K)
    end
  elseif n==g then
    if mvars.paz_isOutAngle then
      this.SendCommandSpecialAction(r)
    end
  elseif n==z then
    GkEventTimerManager.Start(z,2)
    if mvars.paz_isIdleActionEnabled and mvars.paz_currentAction==a then
      local playerPosition=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
      local n=this.GetPosition()
      if(playerPosition-n):GetLengthSqr()>3*3 then
        this.SendCommandSpecialAction(O)
        GkEventTimerManager.Start(c,10+foxmath.FRnd()*5)
        mvars.paz_isIdleActionEnabled=false
      end
    end
  elseif n==c then
    mvars.paz_isIdleActionEnabled=true
  elseif n==d then
    if not mvars.paz_isSpeeching then
      if mvars.paz_isSnakeStopping then
        if mvars.paz_currentAction==a then
          this.SendCommandSpecialAction(r)
        end
      elseif mvars.paz_isOutAngle then
      else
        if mvars.paz_isIdleMonologueEnabled then
          if mvars.paz_currentAction==a or mvars.paz_currentAction==O then
            this.SendCommandCallMonologue(ie)
          end
        end
      end
    end
    GkEventTimerManager.Start(d,10+foxmath.FRnd()*10)
  elseif n==t then
    mvars.paz_isIdleMonologueEnabled=true
    GkEventTimerManager.Stop(d)GkEventTimerManager.Start(d,2+foxmath.FRnd()*2)
  end
end
function this.OnPazPerceiveSnake()
  if mvars.paz_currentAction==S then
    this.SendCommandSpecialAction(_)
  elseif mvars.paz_currentAction==b then
    this.SendCommandSpecialAction(k)
  end
end
function this.OnPazHasAimedDefault()
  if mvars.paz_idleActionSameCount==nil then
    mvars.paz_idleActionSameCount=0
  end
  if mvars.paz_isSnakeStopping then
    local n=nil
    if mvars.paz_idleActionSameCount>=1 then
      n=this.GetItemInTableAtRandom(B)
    else
      n=this.GetItemInTableAtRandom(B)
    end
    if n==mvars.pazLastIdleAction then
      mvars.paz_idleActionSameCount=mvars.paz_idleActionSameCount+1
    else
      mvars.paz_idleActionSameCount=0
    end
    this.SendCommandSpecialAction(n)
    mvars.pazLastIdleAction=n
  elseif mvars.paz_isOutAngle then
    GkEventTimerManager.Start(T,2+foxmath.FRnd()*5)
  else
    this.SendCommandSpecialAction(a)
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
  if mvars.paz_takeActionPath[2]==C[2]then
    mvars.paz_isSeeYouMonologueEnabled=true
  end
end
function this.OnIconSwitchShown()
  if((((((mvars.paz_currentAction~=s and mvars.paz_currentAction~=A)and mvars.paz_currentAction~=P)and mvars.paz_currentAction~=E)and mvars.paz_currentAction~=I)and mvars.paz_currentAction~=G)and mvars.paz_currentAction~=R)and mvars.paz_isSeeYouMonologueEnabled then
    this.SendCommandCallMonologue(D)
    GkEventTimerManager.Stop(p)
    GkEventTimerManager.Start(p,30)
    GkEventTimerManager.Stop(m)
    GkEventTimerManager.Start(m,30)
    mvars.paz_isSeeYouMonologueEnabled=false
    mvars.paz_isShowMeMonologueEnabled=false
  end
end
function this.OnPazRelaxEndTiming()
  if not mvars.paz_isOutAngle and not mvars.paz_isSnakeStopping then
    this.SendCommandSpecialAction(F)
    if mvars.paz_isSpeeching and this.IsInTable(mvars.paz_lastMonologueLabel,i)then
      this.SendCommandCallMonologue""end
  end
end
function this.OnPazOutAngle()
  mvars.paz_isOutAngle=true
  if mvars.paz_currentAction==a then
    this.SendCommandSpecialAction(r)
  end
end
function this.OnPazInAngle()
  mvars.paz_isOutAngle=false
  if mvars.paz_currentAction==r then
    this.SendCommandSpecialAction(a)
  end
end
function this.OnPazSnakeIsStopping()
  mvars.paz_isSnakeStopping=true
  if mvars.paz_currentAction==a and not mvars.paz_isSpeeching then
    this.SendCommandSpecialAction(r)
  end
end
function this.OnPazSnakeIsMoving()
  mvars.paz_isSnakeStopping=false
end
function this.OnClock(e)
  if e==M then
    mvars.paz_hasPerceivedSnake=false
    TppClock.UnregisterClockMessage(M)
  end
end
function this.IsReal()
  return GameObject.SendCommand(this.GetPazGameObjectId(),{id="IsReal"})
end
function this.Warp(a,n)
  GameObject.SendCommand(this.GetPazGameObjectId(),{id="Warp",position=a,rotationY=n})
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
  if path==a[2]then
    mvars.paz_hasPerceivedSnake=true
  elseif path==S[2]then
    if foxmath.FRnd()<.5 then
      this.SendCommandCallMonologue(this.GetItemInTableAtRandom(i))
    else
      GkEventTimerManager.Start(f,.5+foxmath.FRnd()*.5)
    end
  elseif path==b[2]then
    if foxmath.FRnd()<.5 then
      this.SendCommandCallMonologue(this.GetItemInTableAtRandom(i))
    else
      GkEventTimerManager.Start(f,.5+foxmath.FRnd()*.5)
    end
  elseif path==_[2]then
    local n=false
    for a,e in ipairs(i)do
      if e==mvars.paz_lastMonologueLabel then
        n=true
        break
      end
    end
    if n then
      this.SendCommandCallMonologue(J)
    else
      if gvars.pazLookedPictureCount<7 then
        this.SendCommandCallMonologue(L)
      else
        this.SendCommandCallMonologue(N)
      end
    end
    mvars.paz_hasPerceivedSnake=true
  elseif path==k[2]then
    mvars.paz_hasDroppedBook=true
    this.SendCommandCallMonologue(ae)
    mvars.paz_hasPerceivedSnake=true
  elseif path==C[2]then
    mvars.paz_hasDroppedBook=false
  elseif path==I[2]then
    mvars.paz_doesSnakeHasPicture=false
  elseif path==P[2]then
    this.SendCommandCallMonologue(X[math.random(#X)])
  elseif path==s[2]then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  elseif path==A[2]then
    GkEventTimerManager.Start(l,10+foxmath.FRnd()*10)
  end
  this.UpdateIcon()
end
function this.SendCommandCallMonologue(n)
  if not mvars.paz_monologueSameCount then
    mvars.paz_monologueSameCount=0
  end
  if type(n)=="table"then
    local a=#n
    if a==1 then
      n=this.GetItemInTableAtRandom(n)
    elseif a==2 then
      if mvars.paz_monologueSameCount==0 then
        n=this.GetItemInTableAtRandom(n)
      else
        n=this.GetItemInTableAtRandom(n,mvars.paz_lastMonologueLabel)
      end
    else
      n=this.GetItemInTableAtRandom(n,mvars.paz_lastMonologueLabel)
    end
  end
  SendCommand(this.GetPazGameObjectId(),{id="CallMonologue",label=n,reset=true})
  if n==mvars.paz_lastMonologueLabel then
    mvars.paz_monologueSameCount=mvars.paz_monologueSameCount+1
  else
    mvars.paz_monologueSameCount=0
  end
  mvars.paz_lastMonologueLabel=n
  if n==""then
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
  GkEventTimerManager.Stop(p)
  GkEventTimerManager.Stop(m)
  GkEventTimerManager.Stop(v)
  GkEventTimerManager.Stop(u)
  GkEventTimerManager.Stop(h)
  GkEventTimerManager.Stop(f)
  GkEventTimerManager.Stop(l)
  GkEventTimerManager.Stop(T)
  GkEventTimerManager.Stop(g)
  GkEventTimerManager.Stop(z)
  GkEventTimerManager.Stop(c)
  GkEventTimerManager.Stop(d)
  GkEventTimerManager.Stop(t)
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
  if(mvars.paz_isIconEnabled and mvars.paz_currentAction==a)and(mvars.paz_doesSnakeHasPicture or mvars.paz_hasDroppedBook)then
    if not mvars.paz_isIconVisible then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"IconOk",messageArg=""}
      mvars.paz_isIconVisible=true
      if((mvars.paz_doesSnakeHasPicture and mvars.paz_isShowMeMonologueEnabled)and not mvars.paz_isSpeeching)and mvars.paz_lastMonologueLabel~=x then
        this.SendCommandCallMonologue(x)GkEventTimerManager.Start(m,30)
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
function this.PlayPlayerMotion(e)
Player.RequestToPlayDirectMotion{"handBookToPaz",{e,false,pazLocator,"Move","MTP_GLOBAL_C",false}}
end
function this.PlayCameraAnimation()
Player.RequestToPlayCameraNonAnimation{characterId=this.GetPazGameObjectId(),isFollowPos=true,isFollowRot=true,followTime=6,followDelayTime=.5,candidateRots={{-10,110}},skeletonNames={"SKL_002_CHEST"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(.1,.1,.1)},offsetTarget=Vector3(0,.5,.5),offsetPos=Vector3(0,0,-1),focalLength=21,aperture=4,timeToSleep=6,interpTimeAtStart=1,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,isCollisionCheck=false}
Player.RequestToSetCameraRotation{rotX=10,rotY=45,interpTime=1}
end
function this.IsMonologuePhotoSpeech(a)
  for t,e in ipairs(W)do
    if StrCode32(e)==a then
      return true
    end
  end
  return false
end
function this.GetItemInTableAtRandom(e,t)
  if t==nil then
    return e[math.random(#e)]
  else
    local n={}
    local a=0
    for o,e in ipairs(e)do
      if e~=t then
        a=a+1
        n[a]=e
      end
    end
    return n[math.random(#n)]
  end
end
function this.IsInTable(e,a)
  for t,a in ipairs(a)do
    if type(e)=="number"then
      if StrCode32(a)==e then
        return true
      end
    else
      if a==e then
        return true
      end
    end
  end
  return false
end
return this

TppPlayer2CallbackScript={
  StartCameraAnimation=function(e,t,r,n,n,n,n,n,a,n,n)
    TppPlayer2CallbackScript._StartCameraAnimation(e,t,a,true,false,r,false,true)
  end,
  StartCameraAnimationNoRecover=function(e,t,a,n,n,n,n,n,r,n,n)
    TppPlayer2CallbackScript._StartCameraAnimation(e,t,r,false,false,a,true)
  end,
  StartCameraAnimationNoRecoverNoCollsion=function(t,r,e,n,n,n,n,n,a,n,n)
    TppPlayer2CallbackScript._StartCameraAnimation(t,r,a,false,true,e)
  end,
  StartCameraAnimationForSnatchWeapon=function(e,e,e,e,e,e,e,e,e,e,e)
  end,
  StopCameraAnimation=function(a,a,a,a,a,a,a,a,fileSet,a,a)
    Player.RequestToStopCameraAnimation{fileSet=fileSet}
  end,
  StartCureDemoEffectStart=function(e,e,e,e,e,e,e,e,e,e,e)
  end,
  SetCameraNoise=function(t,t,t,t,t,e,a,t,t,t,t)
    TppPlayer2CallbackScript._SetCameraNoise(e,e,a)
  end,
  SetCameraNoiseLadder=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
  end,
  SetCameraNoiseElude=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
  end,
  SetCameraNoiseDamageBend=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
  end,
  SetCameraNoiseDamageBlow=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
  end,
  SetCameraNoiseDamageDeadStart=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.45,.45,.52)
  end,
  SetCameraNoiseFallDamage=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(1,.4,.5)
  end,
  SetCameraNoiseDashToWallStop=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
  end,
  SetCameraNoiseStepOn=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.3,.3,.1)
  end,
  SetCameraNoiseStepDown=function(e,e,e,e,e,t,e,e,e,e,e)
    local a=0
    local e=0
    if(t>0)then
      a=t
      e=t*.25
    else
      a=.225
      e=.057
    end
    TppPlayer2CallbackScript._SetCameraNoise(a,e,.11)
  end,
  SetCameraNoiseStepJumpEnd=function(a,a,a,a,a,e,a,a,a,a,a)
    local a=0
    local t=0
    if(e>0)then
      a=e
      t=e*.25
    else
      a=.225
      t=.057
    end
    TppPlayer2CallbackScript._SetCameraNoise(a,t,.2)
  end,
  SetCameraNoiseStepJumpToElude=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.4,.4,.4)
  end,
  SetCameraNoiseVehicleCrash=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
  end,
  SetCameraNoiseCqcHit=function(e,e,e,e,e,e,e,e,e,e,e)
    TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.4)
  end,
  SetCameraNoiseEndCarry=function(e,e,e,e,e,e,e,e,e,e,e)
    local r=.25
    local t=.25
    local e=.15
    local a=.05
    Player.RequestToSetCameraNoise{levelX=r,levelY=t,time=e,decayRate=a}
  end,
  SetCameraNoiseOnMissileFire=function(e,e,e,e,e,e,e,e,e,e,e)
    local levelX=.5
    local levelY=.5
    local time=.75
    local decayRate=.08
    Player.RequestToSetCameraNoise{levelX=levelX,levelY=levelY,time=time,decayRate=decayRate}
  end,
  SetCameraNoiseOnRideOnAntiAircraftGun=function(e,e,e,e,e,e,e,e,e,e,e)
    local levelX=.2
    local levelY=.2
    local time=.3
    local decayRate=.08
    Player.RequestToSetCameraNoise{levelX=levelX,levelY=levelY,time=time,decayRate=decayRate}
  end,
  SetNonAnimationCutInCameraFallDeath=function()
  end,
  SetHighSpeeCameraOnCQCDirectThrow=function()
  end,
  SetHighSpeeCameraOnCQCComboFinish=function()
    TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"
    TppPlayer2CallbackScript._SetHighSpeedCamera(.6,.03)
  end,
  SetHighSpeeCameraAtCQCSnatchWeapon=function()
    TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"
    TppPlayer2CallbackScript._SetHighSpeedCamera(1,.1)
  end,
  defaultStopPlayingByCollision=false,
  defaultEnableCamera={PlayerCamera.Around,PlayerCamera.Vehicle},
  defaultInterpTimeToRecoverOrientation=.24,
  defaultStopRecoverInterpByPadOperation=true,
  defaultInterpType=2,
  _StartCameraAnimation=function(r,a,fileSet,t,ignoreCollisionCheckOnStart,l,isRiding,o)
    local startFrame=(a-r)+l
    local recoverPreOrientation=t
    if(((StringId.IsEqual(fileSet,"CureGunShotWoundBodyLeft")or StringId.IsEqual(fileSet,"CureGunShotWoundBodyRight"))or StringId.IsEqual(fileSet,"CureGunShotWoundBodyCrawl"))or StringId.IsEqual(fileSet,"CureGunShotWoundBodySupine"))then
      Player.SetFocusParamForCameraAnimation{aperture=3,focusDistance=.6}
    end
    Player.RequestToPlayCameraAnimation{fileSet=fileSet,startFrame=startFrame,ignoreCollisionCheckOnStart=ignoreCollisionCheckOnStart,recoverPreOrientation=recoverPreOrientation,isRiding=isRiding,stopPlayingByCollision=true,enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,interpType=TppPlayer2CallbackScript.defaultInterpType}
  end,
  _StartCameraAnimationUseFileSetName=function(t,n,fileSetName,a,ignoreCollisionCheckOnStart)
    local startFrame=n-t
    local recoverPreOrientation=a
    if(fileSetName=="CqcSnatchAssaultRight"or fileSetName=="CqcSnatchAssaultLeft")then
      Player.SetFocusParamForCameraAnimation{aperture=20}
    end
    Player.RequestToPlayCameraAnimation{fileSetName=fileSetName,startFrame=startFrame,ignoreCollisionCheckOnStart=ignoreCollisionCheckOnStart,recoverPreOrientation=recoverPreOrientation,stopPlayingByCollision=TppPlayer2CallbackScript.defaultStopPlayingByCollision,enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,interpType=TppPlayer2CallbackScript.defaultInterpType}
  end,
  _SetCameraNoise=function(levelX,levelY,time)
    local _levelX=levelX
    local _levelY=levelY
    local _time=time
    local decayRate=.15
    Player.RequestToSetCameraNoise{levelX=_levelX,levelY=_levelY,time=_time,decayRate=decayRate}
  end,
  _SetHighSpeedCamera=function(decayRate,timeRate)
    HighSpeedCamera.RequestEvent{continueTime=decayRate,worldTimeRate=timeRate,localPlayerTimeRate=timeRate,timeRateInterpTimeAtStart=0,timeRateInterpTimeAtEnd=0,cameraSetUpTime=0}
  end
}

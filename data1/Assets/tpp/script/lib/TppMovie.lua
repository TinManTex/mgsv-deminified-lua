local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
this.CallbackFunctionTable={}
function this.Play(demoFlags)
  local targetSuffix
  if TppGameSequence.GetTargetArea()=="Japan"then
    targetSuffix="_jp"
    else
    targetSuffix="_en"
    end
  if not IsTypeTable(demoFlags)then
    return
  end
  local videoName=demoFlags.videoName
  if not IsTypeString(videoName)then
    return
  end
  videoName=videoName..targetSuffix
  local subTitleName=demoFlags.subtitleName or""
  local a=false
  if demoFlags.isLoop then
    a=true
  end
  local onStart=demoFlags.onStart
  if onStart then
    if not IsTypeFunc(onStart)then
      return
    end
  end
  local onEnd=demoFlags.onEnd
  if onEnd then
    if not IsTypeFunc(onEnd)then
      return
    end
  end
  local memoryPool=demoFlags.memoryPool
  if not memoryPool then
  end
  local n=StrCode32(videoName)
  this.CallbackFunctionTable[n]={videoName=videoName,onStart=onStart,onEnd=onEnd}
  local o=TppVideoPlayer.LoadVideo{VideoName=videoName,SubtitleName=subTitleName,MemoryPool=memoryPool}
  if not o then
    TppVideoPlayer.PlayVideo()
  else
    this.DoMessage(n,"onStart")
    this.DoMessage(n,"onEnd")
  end
end
this.CommonDoMessage={}
function this.CommonDoMessage.onStart()
  local exceptGameStatus={}
  for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    exceptGameStatus[gameStatusName]=false
  end
  for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    exceptGameStatus[uiName]=false
  end
  exceptGameStatus.PauseMenu=nil
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT,"FadeInForMovieStart",nil,{exceptGameStatus=exceptGameStatus})
  TppUiStatusManager.ClearStatus"PauseMenu"
  Player.SetPause()
end
function this.CommonDoMessage.onEnd()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
  Player.UnsetPause()
end
function this.DoMessage(n,functionName)
  local functionTable=this.CallbackFunctionTable[n]
  if not functionTable then
    return
  end
  local videoName=functionTable.videoName
  this.CommonDoMessage[functionName]()
  local Func=functionTable[functionName]
  if Func then
    Func()
  end
end
return this

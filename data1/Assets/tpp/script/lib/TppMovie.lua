local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
this.CallbackFunctionTable={}
function this.Play(demoFlags)
  local a
  if TppGameSequence.GetTargetArea()=="Japan"then
    a="_jp"
    else
    a="_en"
    end
  if not IsTypeTable(demoFlags)then
    return
  end
  local o=demoFlags.videoName
  if not IsTypeString(o)then
    return
  end
  o=o..a
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
  local t=demoFlags.memoryPool
  if not t then
  end
  local n=StrCode32(o)
  this.CallbackFunctionTable[n]={videoName=o,onStart=onStart,onEnd=onEnd}
  local o=TppVideoPlayer.LoadVideo{VideoName=o,SubtitleName=subTitleName,MemoryPool=t}
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
  TppUiStatusManager.ClearStatus"PauseMenu"Player.SetPause()
end
function this.CommonDoMessage.onEnd()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
  Player.UnsetPause()
end
function this.DoMessage(n,o)
  local n=this.CallbackFunctionTable[n]
  if not n then
    return
  end
  local a=n.videoName
  this.CommonDoMessage[o]()
  local e=n[o]
  if e then
    e()
  end
end
return this

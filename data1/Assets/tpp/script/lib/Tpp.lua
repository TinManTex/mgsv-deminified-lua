-- DOBUILD: 1
local this={}
local StrCode32=Fox.StrCode32
local type=type
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local GAME_OBJECT_TYPE_PLAYER2=TppGameObject.GAME_OBJECT_TYPE_PLAYER2
local GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local GAME_OBJECT_TYPE_COMMAND_POST2=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2
local GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local GAME_OBJECT_TYPE_HOSTAGE_UNIQUE=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE
local GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2
local GAME_OBJECT_TYPE_HELI2=TppGameObject.GAME_OBJECT_TYPE_HELI2
local GAME_OBJECT_TYPE_ENEMY_HELI=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI
local GAME_OBJECT_TYPE_HORSE2=TppGameObject.GAME_OBJECT_TYPE_HORSE2
local GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local GAME_OBJECT_TYPE_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2
local GAME_OBJECT_TYPE_COMMON_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2
local GAME_OBJECT_TYPE_VOLGIN2=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2
local GAME_OBJECT_TYPE_MARKER2_LOCATOR=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR
local GAME_OBJECT_TYPE_BOSSQUIET2=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local GAME_OBJECT_TYPE_SECURITYCAMERA2=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2
local GAME_OBJECT_TYPE_UAV=TppGameObject.GAME_OBJECT_TYPE_UAV
local GetUserMode=TppGameMode.GetUserMode--RETAILPATCH 1081>
local U_KONAMI_LOGIN=TppGameMode.U_KONAMI_LOGIN
local GetOnlineChallengeTaskVersion=TppNetworkUtil.GetOnlineChallengeTaskVersion--<
local PHASE_ALERT=TppGameObject.PHASE_ALERT
local NULL_ID=GameObject.NULL_ID
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor
this.requires={
  "/Assets/tpp/script/lib/TppDefine.lua",
  "/Assets/tpp/script/lib/TppMath.lua",
  "/Assets/tpp/script/lib/TppSave.lua",
  "/Assets/tpp/script/lib/TppLocation.lua",
  "/Assets/tpp/script/lib/TppSequence.lua",
  "/Assets/tpp/script/lib/TppWeather.lua",
  "/Assets/tpp/script/lib/TppDbgStr32.lua",
  "/Assets/tpp/script/lib/TppDebug.lua",
  "/Assets/tpp/script/lib/TppClock.lua",
  "/Assets/tpp/script/lib/TppUI.lua",
  "/Assets/tpp/script/lib/TppResult.lua",
  "/Assets/tpp/script/lib/TppSound.lua",
  "/Assets/tpp/script/lib/TppTerminal.lua",
  "/Assets/tpp/script/lib/TppMarker.lua",
  "/Assets/tpp/script/lib/TppRadio.lua",
  "/Assets/tpp/script/lib/TppPlayer.lua",
  "/Assets/tpp/script/lib/TppHelicopter.lua",
  "/Assets/tpp/script/lib/TppScriptBlock.lua",
  "/Assets/tpp/script/lib/TppMission.lua",
  "/Assets/tpp/script/lib/TppStory.lua",
  "/Assets/tpp/script/lib/TppDemo.lua",
  "/Assets/tpp/script/lib/TppEnemy.lua",
  "/Assets/tpp/script/lib/TppGeneInter.lua",
  "/Assets/tpp/script/lib/TppInterrogation.lua",
  "/Assets/tpp/script/lib/TppGimmick.lua",
  "/Assets/tpp/script/lib/TppMain.lua",
  "/Assets/tpp/script/lib/TppDemoBlock.lua",
  "/Assets/tpp/script/lib/TppAnimalBlock.lua",
  "/Assets/tpp/script/lib/TppCheckPoint.lua",
  "/Assets/tpp/script/lib/TppPackList.lua",
  "/Assets/tpp/script/lib/TppQuest.lua",
  "/Assets/tpp/script/lib/TppTrap.lua",
  "/Assets/tpp/script/lib/TppReward.lua",
  "/Assets/tpp/script/lib/TppRevenge.lua",
  "/Assets/tpp/script/lib/TppReinforceBlock.lua",
  "/Assets/tpp/script/lib/TppEneFova.lua",
  "/Assets/tpp/script/lib/TppFreeHeliRadio.lua",
  "/Assets/tpp/script/lib/TppHero.lua",
  "/Assets/tpp/script/lib/TppTelop.lua",
  "/Assets/tpp/script/lib/TppRatBird.lua",
  "/Assets/tpp/script/lib/TppMovie.lua",
  "/Assets/tpp/script/lib/TppAnimal.lua",
  "/Assets/tpp/script/lib/TppException.lua",
  "/Assets/tpp/script/lib/TppTutorial.lua",
  "/Assets/tpp/script/lib/TppLandingZone.lua",
  "/Assets/tpp/script/lib/TppCassette.lua",
  "/Assets/tpp/script/lib/TppEmblem.lua",
  "/Assets/tpp/script/lib/TppDevelopFile.lua",
  "/Assets/tpp/script/lib/TppPaz.lua",
  "/Assets/tpp/script/lib/TppRanking.lua",
  "/Assets/tpp/script/lib/TppTrophy.lua",
  "/Assets/tpp/script/lib/TppMbFreeDemo.lua",
  "/Assets/tpp/script/lib/Ivars.lua",--tex>
  "/Assets/tpp/script/lib/InfLang.lua",
  "/Assets/tpp/script/lib/InfButton.lua",
  "/Assets/tpp/script/lib/InfMain.lua",
  "/Assets/tpp/script/lib/InfMenuCommands.lua",
  "/Assets/tpp/script/lib/InfMenuDefs.lua",
  "/Assets/tpp/script/lib/InfMenu.lua",
  "/Assets/tpp/script/lib/InfEneFova.lua",
  --OFF "/Assets/tpp/script/lib/InfEquip.lua",
  --OFF "/Assets/tpp/script/lib/InfSplash.lua",
  "/Assets/tpp/script/lib/InfVehicle.lua",
  "/Assets/tpp/script/lib/InfRevenge.lua",
  --OFF "/Assets/tpp/script/lib/InfReinforce.lua",
  "/Assets/tpp/script/lib/InfCamera.lua",
  "/Assets/tpp/script/lib/InfUserMarker.lua",
  --CULL"/Assets/tpp/script/lib/InfPatch.lua",
  "/Assets/tpp/script/lib/InfEnemyPhase.lua",
  "/Assets/tpp/script/lib/InfHelicopter.lua",
  "/Assets/tpp/script/lib/InfNPC.lua",
  "/Assets/tpp/script/lib/InfNPCHeli.lua",
  "/Assets/tpp/script/lib/InfWalkerGear.lua",
  "/Assets/tpp/script/lib/InfInterrogation.lua",
  "/Assets/tpp/script/lib/InfSoldierParams.lua",
  "/Assets/tpp/script/lib/InfInspect.lua",
  "/Assets/tpp/script/lib/InfFova.lua",
  "/Assets/tpp/script/lib/InfLZ.lua",
  "/Assets/tpp/script/lib/InfHooks.lua",--<
}
function this.IsTypeFunc(e)
  return type(e)=="function"
end
local IsTypeFunc=this.IsTypeFunc
function this.IsTypeTable(e)
  return type(e)=="table"
end
local IsTypeTable=this.IsTypeTable
function this.IsTypeString(e)
  return type(e)=="string"
end
local IsTypeString=this.IsTypeString
function this.IsTypeNumber(e)
  return type(e)=="number"
end
local IsTypeNumber=this.IsTypeNumber

function this.Enum(nameTable)
  if nameTable==nil then
    return
  end
  if#nameTable==0 then
    return nameTable
  end
  for n=1,#nameTable do
    nameTable[nameTable[n]]=n
  end
  return nameTable
end

function this.IsMaster()
  do
    return true
  end
end
function this.IsQARelease()
  return(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)
end
function this.SplitString(e,l)
  local t={}
  local n
  local e=e
  while true do
    n=string.find(e,l)
    if(n==nil)then
      table.insert(t,e)
      break
    else
      local l=string.sub(e,0,n-1)
      table.insert(t,l)
      e=string.sub(e,n+1)
    end
  end
  return t
end
function this.StrCode32Table(table)
  local strCode32Table={}
  for k,v in pairs(table)do
    local n=k
    if type(n)=="string"then
      n=StrCode32(n)
    end
    if type(v)=="table"then
      strCode32Table[n]=this.StrCode32Table(v)
    else
      strCode32Table[n]=v
    end
  end
  return strCode32Table
end
function this.ApendArray(e,n)
  for t,n in pairs(n)do
    e[#e+1]=n
  end
end
function this.MergeTable(table1,table2,n)
  local mergedTable=table1
  for e,l in pairs(table2)do
    if table1[e]==nil then
      mergedTable[e]=l
    else
      mergedTable[e]=l
    end
  end
  return mergedTable
end
function this.IsOnlineMode()--RETAILPATCH 1081
  return(GetUserMode()==U_KONAMI_LOGIN)
end
function this.IsValidLocalOnlineChallengeTaskVersion()
  return(GetOnlineChallengeTaskVersion()==gvars.localOnlineChallengeTaskVersion)
end--<
function this.BfsPairs(r)
  local i,t,l={r},1,1
  local function p(n,e)
    local n,e=e,nil
    while true do
      n,e=next(i[t],n)
      if IsTypeTable(e)then
        l=l+1
        i[l]=e
      end
      if n then
        return n,e
      else
        t=t+1
        if t>l then
          return
        end
      end
    end
  end
  return p,r,nil
end
this._DEBUG_svars={}
this._DEBUG_gvars={}
--IN: messages table from various lua .Messages() func
function this.MakeMessageExecTable(messages)
  if messages==nil then
    return
  end
  if next(messages)==nil then
    return
  end
  local n={}
  local s32_msg=StrCode32"msg"
  local s32_func=StrCode32"func"
  local s32_sender=StrCode32"sender"
  local s32_option=StrCode32"option"
  for e,l in pairs(messages)do
    n[e]=n[e]or{}
    for l,r in pairs(l)do
      local l,s,d,o=l,nil,nil,nil
      if IsTypeFunc(r)then
        d=r
      elseif IsTypeTable(r)and IsTypeFunc(r[s32_func])then
        l=StrCode32(r[s32_msg])
        local n={}
        if(type(r[s32_sender])=="string")or(type(r[s32_sender])=="number")then
          n[1]=r[s32_sender]
        elseif IsTypeTable(r[s32_sender])then
          n=r[s32_sender]
        end
        s={}
        for l,n in pairs(n)do
          if type(n)=="string"then
            if e==StrCode32"GameObject"then
              s[l]=GetGameObjectId(n)
              if msgSndr==NULL_ID then--RETAILBUG not defined
              end
            else
              s[l]=StrCode32(n)
            end
          elseif type(n)=="number"then
            s[l]=n
          end
        end
        d=r[s32_func]
        o=r[s32_option]
      end
      if d then
        n[e][l]=n[e][l]or{}
        if next(s)~=nil then
          for r,t in pairs(s)do
            n[e][l].sender=n[e][l].sender or{}
            n[e][l].senderOption=n[e][l].senderOption or{}
            if n[e][l].sender[t]then
            end
            n[e][l].sender[t]=d
            if o and IsTypeTable(o)then
              n[e][l].senderOption[t]=o
            end
          end
        else
          if n[e][l].func then
          end
          n[e][l].func=d
          if o and IsTypeTable(o)then
            n[e][l].option=o
          end
        end
      end
    end
  end
  return n
end
function this.DoMessage(messageExecTable,CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if not messageExecTable then
    return
  end
  local senderRecievers=messageExecTable[sender]
  if not senderRecievers then
    return
  end
  local messageIdRecievers=senderRecievers[messageId]
  if not messageIdRecievers then
    return
  end
  local t=true
  this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText,t)
end
function this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText)
  if messageIdRecievers.func then
    if CheckMessageOption(messageIdRecievers.option)then
      messageIdRecievers.func(arg0,arg1,arg2,arg3)
    end
  end
  local sender=messageIdRecievers.sender
  if sender and sender[arg0]then
    if CheckMessageOption(messageIdRecievers.senderOption[arg0])then
      sender[arg0](arg0,arg1,arg2,arg3)
    end
  end
end
function this.GetRotationY(rotQuat)
  if not rotQuat then
    return
  end
  if(type(rotQuat.Rotate)=="function")then
    local rotVec=rotQuat:Rotate(Vector3(0,0,1))
    local rotRadian=foxmath.Atan2(rotVec:GetX(),rotVec:GetZ())
    return TppMath.RadianToDegree(rotRadian)
  end
end
function this.GetLocator(identifier,key)
  local pos,rotQuat=this.GetLocatorByTransform(identifier,key)
  if pos~=nil then
    return TppMath.Vector3toTable(pos),this.GetRotationY(rotQuat)
  else
    return nil
  end
end
function this.GetLocatorByTransform(identifier,key)
  local transFormData=this.GetDataWithIdentifier(identifier,key,"TransformData")
  if transFormData==nil then
    return
  end
  local worldTransform=transFormData.worldTransform
  return worldTransform.translation,worldTransform.rotQuat
end
function this.GetDataWithIdentifier(identifier,key,typeName)
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  --GOTCHA: NULL seems to be a valid return, likely used as SQL NULL - https://www.exasol.com/support/browse/SOL-129
  --either way the game relies on this value in a couple of calls, but this makes me worried with stuff like above testing for this function returning nil
  if data==NULL then
    return
  end
  if(data:IsKindOf(typeName)==false)then
    return
  end
  return data
end
function this.GetDataBodyWithIdentifier(identifier,key,typeName)
  local dataBody=DataIdentifier.GetDataBodyWithIdentifier(identifier,key)
  if(dataBody.data==nil)then
    return
  end
  if(dataBody.data:IsKindOf(typeName)==false)then
    return
  end
  return dataBody
end
function this.SetGameStatus(status)
  if not IsTypeTable(status)then
    return
  end
  local enable=status.enable
  local scriptName=status.scriptName
  local target=status.target
  local except=status.except
  if enable==nil then
    return
  end
  if target=="all"then
    target={}
    for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      target[uiName]=statusType
    end
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      target[gameStatusName]=statusType
    end
  elseif IsTypeTable(target)then
    target=target
  else
    return
  end
  if IsTypeTable(except)then
    for t,n in pairs(except)do
      target[t]=n
    end
  end
  if enable then
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      if target[gameStatusName]then
        TppGameStatus.Reset(scriptName,gameStatusName)
      end
    end
    for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local t=target[uiName]
      local unsetUiSetting=mvars.ui_unsetUiSetting
      if (Ivars.disableHeadMarkers:Is(1) and uiName=="HeadMarker") or (Ivars.disableWorldMarkers:Is(1) and uiName=="WorldMarker")then--tex> bit of a kludge implementation, but lua doesnt support continue in for loops--TODO more testing
        t=nil
        unsetUiSetting=nil
      end--<
      if IsTypeTable(unsetUiSetting)and unsetUiSetting[uiName]then
        TppUiStatusManager.UnsetStatus(uiName,unsetUiSetting[uiName])
      else
        if t then
          TppUiStatusManager.ClearStatus(uiName)
        end
      end
    end
  else
    for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local e=target[uiName]
      if e then
        TppUiStatusManager.SetStatus(uiName,e)
      else
        TppUiStatusManager.ClearStatus(uiName)
      end
    end
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local e=target[gameStatusName]
      if e then
        TppGameStatus.Set(scriptName,gameStatusName)
      end
    end
  end
end
function this.GetAllDisableGameStatusTable()
  local statusTable={}
  for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    statusTable[uiName]=false
  end
  for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    statusTable[gameStatusName]=false
  end
  return statusTable
end
function this.GetHelicopterStartExceptGameStatus()
  local status={}
  status.EquipPanel=false
  status.AnnounceLog=false
  status.HeadMarker=false
  status.WorldMarker=false
  return status
end
local function IsGameObjectType(gameObject,checkType)
  if gameObject==nil then
    return
  end
  if gameObject==NULL_ID then
    return
  end
  local e=GetTypeIndex(gameObject)
  if e==checkType then
    return true
  else
    return false
  end
end
function this.IsPlayer(gameId)
  return IsGameObjectType(gameId,GAME_OBJECT_TYPE_PLAYER2)
end
function this.IsLocalPlayer(playerIndex)
  if playerIndex==PlayerInfo.GetLocalPlayerIndex()then
    return true
  else
    return false
  end
end
function this.IsSoldier(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_SOLDIER2)
end
function this.IsCommandPost(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_COMMAND_POST2)
end
function this.IsHostage(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.HOSTAGE_GM_TYPE[e]
end
function this.IsVolgin(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_VOLGIN2)
end
function this.IsHelicopter(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_HELI2)
end
function this.IsEnemyHelicopter(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_ENEMY_HELI)
end
function this.IsHorse(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_HORSE2)
end
function this.IsVehicle(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_VEHICLE)
end
function this.IsPlayerWalkerGear(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_WALKERGEAR2)
end
function this.IsEnemyWalkerGear(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_COMMON_WALKERGEAR2)
end
function this.IsUav(e)--RETAILBUG well not really, just that there's two identical functions with different cap, IsUav and IsUAV
  return IsGameObjectType(e,GAME_OBJECT_TYPE_UAV)
end
function this.IsFultonContainer(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER)
end
function this.IsMortar(e)--RETAILPATCH 1070
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_MORTAR)
end
function this.IsGatlingGun(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN)
end
function this.IsMachineGun(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN)
end--<
function this.IsFultonableGimmick(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.FULTONABLE_GIMMICK_TYPE[e]
end
function this.GetBuddyTypeFromGameObjectId(gameObjectType)
  if gameObjectType==nil then
    return
  end
  if gameObjectType==NULL_ID then
    return
  end
  local typeIndex=GetTypeIndex(gameObjectType)
  return TppDefine.BUDDY_GM_TYPE_TO_BUDDY_TYPE[typeIndex]
end
function this.IsMarkerLocator(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_MARKER2_LOCATOR)
end
function this.IsAnimal(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.ANIMAL_GAMEOBJECT_TYPE[e]
end
function this.IsBossQuiet(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_BOSSQUIET2)
end
function this.IsParasiteSquad(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_PARASITE2)
end
function this.IsSecurityCamera(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_SECURITYCAMERA2)
end
function this.IsGunCamera(gameId)
  if gameId==NULL_ID then
    return false
  end
  local command={id="IsGunCamera"}
  local isGunCamera=false
  isGunCamera=GameObject.SendCommand(gameId,command)
  return isGunCamera
end
function this.IsUAV(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_UAV)
end
function this.IncrementPlayData(e)
  if gvars[e]==nil then
    return
  end
  if gvars[e]<TppDefine.MAX_32BIT_UINT then
    gvars[e]=gvars[e]+1
  end
end
function this.IsNotAlert()
  if vars.playerPhase<PHASE_ALERT then
    return true
  else
    return false
  end
end
function this.IsPlayerStatusNormal()
  local vars=vars
  if vars.playerLife>0 and vars.playerStamina>0 then
    return true
  else
    return false
  end
end
function this.AreaToIndices(e)
  local l,t,n,r=e[1],e[2],e[3],e[4]
  local e={}
  for n=l,n do
    for t=t,r do
      table.insert(e,{n,t})
    end
  end
  return e
end
function this.CheckBlockArea(e,t,n)
  local l,e,r,i=e[1],e[2],e[3],e[4]
  if(((t>=l)and(t<=r))and(n>=e))and(n<=i)then
    return true
  end
  return false
end
function this.FillBlockArea(n,e,i,t,r,l)
  for e=e,t do
    n[e]=n[e]or{}
    for t=i,r do
      n[e][t]=l
    end
  end
end
function this.GetCurrentStageSmallBlockIndex()
  local e=2
  local n,t=StageBlock.GetCurrentMinimumSmallBlockIndex()
  return(n+e),(t+e)
end
function this.IsLoadedSmallBlock(n,t)
  local l=4
  local e,r=StageBlock.GetCurrentMinimumSmallBlockIndex()
  local i=e+l
  local l=e+l
  return((e<=n and i>=n)and r<=t)and l>=t
end
function this.IsLoadedLargeBlock(e)
  local n=StrCode32(e)
  local e=StageBlock.GetLoadedLargeBlocks(0)
  for t,e in pairs(e)do
    if e==n then
      return true
    end
  end
  return false
end
function this.GetLoadedLargeBlock()
  local e=StageBlock.GetLoadedLargeBlocks(0)
  for n,e in pairs(e)do
    return e
  end
  return nil
end
function this.GetChunkIndex(t,n)
  local e
  if n then
    e=Chunk.INDEX_MGO
  else
    e=TppDefine.LOCATION_CHUNK_INDEX_TABLE[t]
    if e==nil then
    end
    return e
  end
  return e
end
function this.StartWaitChunkInstallation(n)
  Chunk.PrefetchChunk(n)
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  this.ClearChunkInstallPopupUpdateTime()
end
local r=1
local n=0
function this.ShowChunkInstallingPopup(t,l)
  local e=Time.GetFrameTime()
  n=n-e
  if n>0 then
    return
  end
  n=n+r
  if n<0 then
    n=0
  end
  local n=Fox.GetPlatformName()
  local e=Chunk.GetChunkInstallationEta(t)
  if e and n=="PS4"then
    if e>86400 then
      e=86400
    end
    TppUiCommand.SetErrorPopupParam(e)
  end
  local e=Chunk.GetChunkInstallationRate(t)
  if e and n=="XboxOne"then
    TppUiCommand.SetErrorPopupParam(e*1e4,"None",2)
  end
  local e
  if l then
    e=Popup.TYPE_ONE_CANCEL_BUTTON
  else
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
  end
  TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLING,e)
end
function this.ClearChunkInstallPopupUpdateTime()n=0
end
function this.GetFormatedStorageSizePopupParam(t)
  local n=1024
  local e=1024*n
  local l=1024*e
  local l,r,i=t/l,t/e,t/n
  local n=0
  local e=""
  if l>=1 then
    n=l*100
    e="G"
  elseif r>=1 then
    n=r*100
    e="M"
  elseif i>=1 then
    n=i*100
    e="K"
  else
    return t,"",0
  end
  local n=math.ceil(n)
  return n,e,2
end
function this.PatchDlcCheckCoroutine(p1,p2,p3,p4)--RETAILPATCH 1070 reworked
  if p4==nil then
    p4=PatchDlc.PATCH_DLC_TYPE_MGO_DATA
end
local n={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=true,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=true}
if not n[p4]then
  Fox.Hungup"Invalid dlc type."return false
end
local function RENf1(e)
end
local function RENf2()
  if TppUiCommand.IsShowPopup()then
    TppUiCommand.ErasePopup()
    while TppUiCommand.IsShowPopup()do
      RENf1"waiting popup closed..."
      coroutine.yield()
    end
  end
end
local function RENf3()
  while TppSave.IsSaving()do
    RENf1"waiting saving end..."
    coroutine.yield()
  end
end
RENf3()
PatchDlc.StartCheckingPatchDlc(p4)
if PatchDlc.IsCheckingPatchDlc()then
  if not p3 then
    RENf2()
    local n={[PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=5100,[PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=5150}
    local e=n[p4]
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
    TppUiCommand.ShowErrorPopup(e)
  end
  while PatchDlc.IsCheckingPatchDlc()do
    RENf1"waiting checking PatchDlc end..."
    coroutine.yield()
    TppUI.ShowAccessIconContinue()
  end
end
RENf2()
if PatchDlc.DoesExistPatchDlc(p4)then
  if p1 then
    p1()
  end
  return true
else
  if p2 then
    p2()
  end
  return false
end
end
function this.IsPatchDlcValidPlatform(n)--RETAILPATCH 1070
  local e={
    [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]={Xbox360=true,PS3=true,PS4=true},--RETAILPATCH 1090 X360 added
    [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]={Xbox360=true,PS3=true,PS4=true}
  }
local e=e[n]
if not e then
  Fox.Hungup"Invalid dlc type."return false
end
local n=Fox.GetPlatformName()
if e[n]then
  return true
else
  return false
end
end--<
function this.ClearDidCancelPatchDlcDownloadRequest()
  if(vars.didCancelPatchDlcDownloadRequest==1)then
    vars.didCancelPatchDlcDownloadRequest=0
    vars.isPersonalDirty=1
    TppSave.CheckAndSavePersonalData()
  end
end
function this.DEBUG_DunmpBlockArea(t,l,n)
  local e="       "for n=1,n do
    e=e..string.format("%02d,",n)
  end
  for l=1,l do
    local e=""for n=1,n do
      e=e..string.format("%02d,",t[l][n])
    end
  end
end
function this.DEBUG_DumpTable(l,n)
  if n==nil then
  end
  if(type(l)~="table")then
    return
  end
  local r=""
  if n then
    for e=0,n do
      r=r.." "
    end
  end
  for r,l in pairs(l)do
    if type(l)=="table"then
      local n=n or 0
      n=n+1
      this.DEBUG_DumpTable(l,n)
    else
      if type(l)=="number"then
      end
    end
  end
end
function this.DEBUG_Where(stackLevel)
  local stackInfo=debug.getinfo(stackLevel+1)
  if stackInfo then
    return stackInfo.short_src..(":"..stackInfo.currentline)
  end
  return"(unknown)"
end
function this.DEBUG_StrCode32ToString(str32string)
  if str32string~=nil then
    local originalString
    if(TppDbgStr32)then
      originalString=TppDbgStr32.DEBUG_StrCode32ToString(str32string)
    end
    if originalString then
      return originalString
    else
      if type(str32string)=="string"then
      end
      return tostring(str32string)
    end
  else
    return"nil"
  end
end
function this.DEBUG_Fatal(e,e)
end
function this.DEBUG_SetPreference(entityName,property,value)
  local entity=Preference.GetPreferenceEntity(entityName)
  if(entity==nil)then
    return
  end
  if(entity[property]==nil)then
    return
  end
  Command.SetProperty{entity=entity,property=property,value=value}
end
this._requireList={}
do
  for t,libPath in ipairs(this.requires)do
    local split=this.SplitString(libPath,"/")
    local libName=string.sub(split[#split],1,#split[#split]-4)
    local disallow={TppMain=true,TppDemoBlock=true,mafr_luxury_block_list=true}
    if not disallow[libName]then
      this._requireList[#this._requireList+1]=libName
    end
  end
end
return this

-- DOBUILD: 1
-- Tpp.lua
InfCore.LogFlow"Load Tpp.lua"--tex
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
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
local InfCore=InfCore--tex
this.requires={
  "/Assets/tpp/script/lib/InfRequiresStart.lua",--tex
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
--  "/Assets/tpp/script/lib/InfButton.lua",--tex>--CULL
--  "/Assets/tpp/script/lib/InfModules.lua",
--  "/Assets/tpp/script/lib/InfMain.lua",--<
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

--NMC GOTCHA TppDefine.Enum indexed from 0, Tpp.Enum indexed from one. silly.
--GOTCHA this also adds to input table instead of giving new TODO review in light of this
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
function this.SplitString(string,delim)
  local splitStringTable={}
  local splitIndex
  local splitString=string
  while true do
    splitIndex=string.find(splitString,delim)
    if(splitIndex==nil)then
      table.insert(splitStringTable,splitString)
      break
    else
      local subString=string.sub(splitString,0,splitIndex-1)
      table.insert(splitStringTable,subString)
      splitString=string.sub(splitString,splitIndex+1)
    end
  end
  return splitStringTable
end
function this.StrCode32Table(table)
  local strCode32Table={}
  for k,v in pairs(table)do
    local key=k
    if type(key)=="string"then
      key=StrCode32(key)
    end
    if type(v)=="table"then
      strCode32Table[key]=this.StrCode32Table(v)
    else
      strCode32Table[key]=v
    end
  end
  return strCode32Table
end
function this.ApendArray(destTable,sourceTable)
  for k,v in pairs(sourceTable)do
    destTable[#destTable+1]=v
  end
end
function this.MergeTable(table1,table2,unk3)
  local mergedTable=table1
  for k,v in pairs(table2)do
    --NMC uhhh, both the same?
    if table1[k]==nil then
      mergedTable[k]=v
    else
      mergedTable[k]=v
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
--IN: messages (str32)table from various module .Messages() func
--OUT: messageExecTable[messageClassS32][messageNameS32].func=objectMessageFunc
--or messageExecTable[messageClassS32][messageNameS32].sender[senderId]=objectMessageFunc --tex NMC senderId is either str32 of original sender or gameId
--In most cases table is output to some <module>.messageExecTable
function this.MakeMessageExecTable(messagesS32)
  if messagesS32==nil then
    return
  end
  if next(messagesS32)==nil then
    return
  end
  local messageExecTable={}
  local s32_msg=StrCode32"msg"
  local s32_func=StrCode32"func"
  local s32_sender=StrCode32"sender"
  local s32_option=StrCode32"option"
  for messageClassS32,classMessages in pairs(messagesS32)do
    messageExecTable[messageClassS32]=messageExecTable[messageClassS32]or{}
    for i,messageInfo in pairs(classMessages)do--tex TODO: re analyse
      local messageNameS32,senderIds,classMessageFunc,options=i,nil,nil,nil
      if IsTypeFunc(messageInfo)then
        classMessageFunc=messageInfo
      elseif IsTypeTable(messageInfo)and IsTypeFunc(messageInfo[s32_func])then
        messageNameS32=StrCode32(messageInfo[s32_msg])
        local messageSenders={}
        if(type(messageInfo[s32_sender])=="string")or(type(messageInfo[s32_sender])=="number")then
          messageSenders[1]=messageInfo[s32_sender]
        elseif IsTypeTable(messageInfo[s32_sender])then
          messageSenders=messageInfo[s32_sender]
        end
        senderIds={}
        --NMC could probably be changed to ipairs
        for k,senderId in pairs(messageSenders)do
          if type(senderId)=="string"then
            if messageClassS32==StrCode32"GameObject"then
              senderIds[k]=GetGameObjectId(senderId)
              --RETAILBUG msgSndr not defined, moot, no executing code, commented out anyway
              --              if msgSndr==NULL_ID then
              --              end
            else
              senderIds[k]=StrCode32(senderId)
            end
          elseif type(senderId)=="number"then
            senderIds[k]=senderId
          end
        end
        classMessageFunc=messageInfo[s32_func]
        options=messageInfo[s32_option]
      end
      if classMessageFunc then
        messageExecTable[messageClassS32][messageNameS32]=messageExecTable[messageClassS32][messageNameS32]or{}
        if next(senderIds)~=nil then
          for k,senderId in pairs(senderIds)do
            messageExecTable[messageClassS32][messageNameS32].sender=messageExecTable[messageClassS32][messageNameS32].sender or{}
            messageExecTable[messageClassS32][messageNameS32].senderOption=messageExecTable[messageClassS32][messageNameS32].senderOption or{}
            if messageExecTable[messageClassS32][messageNameS32].sender[senderId]then
            end
            messageExecTable[messageClassS32][messageNameS32].sender[senderId]=classMessageFunc
            if options and IsTypeTable(options)then
              messageExecTable[messageClassS32][messageNameS32].senderOption[senderId]=options
            end
          end
        else
          if messageExecTable[messageClassS32][messageNameS32].func then
          end
          messageExecTable[messageClassS32][messageNameS32].func=classMessageFunc
          if options and IsTypeTable(options)then
            messageExecTable[messageClassS32][messageNameS32].option=options
          end
        end
      end
    end
  end
  return messageExecTable
end
--tex NMC CheckMessageOption seems to always be TppMission.CheckMessageOption
function this.DoMessage(messageExecTable,CheckMessageOption,messageClass,messageId,arg0,arg1,arg2,arg3,strLogText)
  if not messageExecTable then
    return
  end
  local classMessages=messageExecTable[messageClass]
  if not classMessages then
    return
  end
  local messageIdRecievers=classMessages[messageId]
  if not messageIdRecievers then
    return
  end
  local unkBool=true
  if InfCore.debugMode and Ivars.debugMessages:Get()==1 then--tex> wrap in pcall
    InfCore.PCall(this.DoMessageAct,messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText,unkBool)
  else--<
    this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText,unkBool)
  end
end
function this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText)
  if messageIdRecievers.func then
    if CheckMessageOption(messageIdRecievers.option)then
      messageIdRecievers.func(arg0,arg1,arg2,arg3)
    end
  end
  local senders=messageIdRecievers.sender--tex NMC actually recievers at this point
  if senders and senders[arg0]then
    if CheckMessageOption(messageIdRecievers.senderOption[arg0])then
      senders[arg0](arg0,arg1,arg2,arg3)
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
    for statusName,set in pairs(except)do
      target[statusName]=set
    end
  end
  if enable then
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      if target[gameStatusName]then
        TppGameStatus.Reset(scriptName,gameStatusName)
      end
    end
    for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local status=target[uiName]
      local unsetUiSetting=mvars.ui_unsetUiSetting
      if (Ivars.disableHeadMarkers:Is(1) and uiName=="HeadMarker") or (Ivars.disableWorldMarkers:Is(1) and uiName=="WorldMarker")then--tex> bit of a kludge implementation, but lua doesnt support continue in for loops--TODO more testing
        status=nil
        unsetUiSetting=nil
      end--<
      if IsTypeTable(unsetUiSetting)and unsetUiSetting[uiName]then
        TppUiStatusManager.UnsetStatus(uiName,unsetUiSetting[uiName])
      else
        if status then
          TppUiStatusManager.ClearStatus(uiName)
        end
      end
    end
  else
    for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local status=target[uiName]
      if status then
        TppUiStatusManager.SetStatus(uiName,status)
      else
        TppUiStatusManager.ClearStatus(uiName)
      end
    end
    for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local set=target[gameStatusName]
      if set then
        TppGameStatus.Set(scriptName,gameStatusName)
      end
    end
  end
  --tex TODO switch to a diffent mode, only useful if blackloading -- if Ivars.debugMode:Is()>0 or InfCore.doneStartup==false then--tex> TODO: this doesn't seem to catch all cases of announcelog being disabled, during Load on return from MB for example
  if InfCore.doneStartup==false then--tex allows announcelog during game startup
    TppUiStatusManager.ClearStatus("AnnounceLog")
  end--<
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
  local typeIndex=GetTypeIndex(gameObject)
  if typeIndex==checkType then
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
function this.IsAnimal(gameId)
  if gameId==nil then
    return
  end
  if gameId==NULL_ID then
    return
  end
  local typeIndex=GetTypeIndex(gameId)
  return TppDefine.ANIMAL_GAMEOBJECT_TYPE[typeIndex]
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
function this.IncrementPlayData(gvarName)
  if gvars[gvarName]==nil then
    return
  end
  if gvars[gvarName]<TppDefine.MAX_32BIT_UINT then
    gvars[gvarName]=gvars[gvarName]+1
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
function this.AreaToIndices(areaExtents)
  local xMin,yMin,xMax,yMax=areaExtents[1],areaExtents[2],areaExtents[3],areaExtents[4]
  local areaIndicies={}
  for x=xMin,xMax do
    for y=yMin,yMax do
      table.insert(areaIndicies,{x,y})
    end
  end
  return areaIndicies
end
function this.CheckBlockArea(areaExtents,blockIndexX,blockIndexY)
  local xMin,yMin,xMax,yMax=areaExtents[1],areaExtents[2],areaExtents[3],areaExtents[4]
  if(((blockIndexX>=xMin)and(blockIndexX<=xMax))and(blockIndexY>=yMin))and(blockIndexY<=yMax)then
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
  local halfBlockSize=2
  local x,y=StageBlock.GetCurrentMinimumSmallBlockIndex()
  return(x+halfBlockSize),(y+halfBlockSize)
end
function this.IsLoadedSmallBlock(blockIndexX,blockIndexY)
  local blockSize=4
  local minX,minY=StageBlock.GetCurrentMinimumSmallBlockIndex()
  local maxX=minX+blockSize
  local maxY=minY+blockSize--RETAILBUG: was minX+blockSize (is fixed in SSD), but function isn't used anywhere?
  return((minX<=blockIndexX and maxX>=blockIndexX)and minY<=blockIndexY)and maxY>=blockIndexY
end
function this.IsLoadedLargeBlock(blockName)
  local checkBlockNameStr32=StrCode32(blockName)
  local largeBlocks=StageBlock.GetLoadedLargeBlocks(0)
  for i,blockNameStr32 in pairs(largeBlocks)do
    if blockNameStr32==checkBlockNameStr32 then
      return true
    end
  end
  return false
end
function this.GetLoadedLargeBlock()
  local largeBlocks=StageBlock.GetLoadedLargeBlocks(0)
  for i,blockNameStr32 in pairs(largeBlocks)do
    return blockNameStr32
  end
  return nil
end
function this.GetChunkIndex(locationId,isMGO)--tex VERIFY, ssd param2 is missioncode
  local chunkIndex
  if isMGO then
    chunkIndex=Chunk.INDEX_MGO
  else
    chunkIndex=TppDefine.LOCATION_CHUNK_INDEX_TABLE[locationId]--tex TODO: ssd has hang call on nil locationchunkindex
    if chunkIndex==nil then
    end
    return chunkIndex
  end
  return chunkIndex
end
function this.StartWaitChunkInstallation(chunkIndex)
  Chunk.PrefetchChunk(chunkIndex)
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  this.ClearChunkInstallPopupUpdateTime()
end
local r=1
local chunkInstallPopupUpdateTime=0
function this.ShowChunkInstallingPopup(chunkId,useOneCancelButtonPopup)
  local frameTime=Time.GetFrameTime()
  chunkInstallPopupUpdateTime=chunkInstallPopupUpdateTime-frameTime
  if chunkInstallPopupUpdateTime>0 then
    return
  end
  chunkInstallPopupUpdateTime=chunkInstallPopupUpdateTime+r
  if chunkInstallPopupUpdateTime<0 then
    chunkInstallPopupUpdateTime=0
  end
  local platform=Fox.GetPlatformName()
  local installEta=Chunk.GetChunkInstallationEta(chunkId)
  if installEta and platform=="PS4"then
    if installEta>86400 then
      installEta=86400
    end
    TppUiCommand.SetErrorPopupParam(installEta)
  end
  local installRate=Chunk.GetChunkInstallationRate(chunkId)
  if installRate and platform=="XboxOne"then
    TppUiCommand.SetErrorPopupParam(installRate*1e4,"None",2)
  end
  local popupType
  if useOneCancelButtonPopup then
    popupType=Popup.TYPE_ONE_CANCEL_BUTTON
  else
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
  end
  TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLING,popupType)
end
function this.ClearChunkInstallPopupUpdateTime()
  chunkInstallPopupUpdateTime=0
end
function this.GetFormatedStorageSizePopupParam(neededSpace)
  local toKb=1024
  local toMb=1024*toKb
  local toGb=1024*toMb
  local gb,mg,kb=neededSpace/toGb,neededSpace/toMb,neededSpace/toKb
  local size=0
  local unitLetter=""
  if gb>=1 then
    size=gb*100
    unitLetter="G"
  elseif mg>=1 then
    size=mg*100
    unitLetter="M"
  elseif kb>=1 then
    size=kb*100
    unitLetter="K"
  else
    return neededSpace,"",0
  end
  local sizeValue=math.ceil(size)
  return sizeValue,unitLetter,2
end
--RETAILPATCH 1070 reworked>
function this.PatchDlcCheckCoroutine(OnPatchExist,OnPatchNotExist,skipDlcTypeCheck,dlcType)
  if dlcType==nil then
    dlcType=PatchDlc.PATCH_DLC_TYPE_MGO_DATA
  end
  local validTypes={
  [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=true,
  [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=true
  }
  if not validTypes[dlcType]then
    Fox.Hungup"Invalid dlc type."
    return false
  end
  local function DebugPrint(message)
  end
  local function ClosePopupYield()
    if TppUiCommand.IsShowPopup()then
      TppUiCommand.ErasePopup()
      while TppUiCommand.IsShowPopup()do
        DebugPrint"waiting popup closed..."
        coroutine.yield()
      end
    end
  end
  local function YeildWhileSaving()
    while TppSave.IsSaving()do
      DebugPrint"waiting saving end..."
      coroutine.yield()
    end
  end
  YeildWhileSaving()
  PatchDlc.StartCheckingPatchDlc(dlcType)
  if PatchDlc.IsCheckingPatchDlc()then
    if not skipDlcTypeCheck then
      ClosePopupYield()
      local errorIds={
      [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=5100,
      [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=5150
      }
      local errorId=errorIds[dlcType]
      TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
      TppUiCommand.ShowErrorPopup(errorId)
    end
    while PatchDlc.IsCheckingPatchDlc()do
      DebugPrint"waiting checking PatchDlc end..."
      coroutine.yield()
      TppUI.ShowAccessIconContinue()
    end
  end
  ClosePopupYield()
  if PatchDlc.DoesExistPatchDlc(dlcType)then
    if OnPatchExist then
      OnPatchExist()
    end
    return true
  else
    if OnPatchNotExist then
      OnPatchNotExist()
    end
    return false
  end
end
--RETAILPATCH 1070>
function this.IsPatchDlcValidPlatform(dlcId)
  local platformsForDlc={
    [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]={Xbox360=true,PS3=true,PS4=true},--RETAILPATCH 1090 X360 added
    [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]={Xbox360=true,PS3=true,PS4=true}
  }
  local platforms=platformsForDlc[dlcId]
  if not platforms then
    Fox.Hungup"Invalid dlc type."
    return false
  end
  local platform=Fox.GetPlatformName()
  if platforms[platform]then
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
  local e="       "
  for n=1,n do
    e=e..string.format("%02d,",n)
  end
  for l=1,l do
    local e=""
    for n=1,n do
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
--NMC _requirelist adds a number of calls from TppMain on the libs
--DeclareSVars, Init, OnReload, OnChangeSVars, OnMessage
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
InfCore.LogFlow"Tpp.lua done"--tex
return this

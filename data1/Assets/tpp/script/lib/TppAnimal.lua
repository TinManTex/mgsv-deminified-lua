-- TppAnimal.lua
local this={}
local StrCode32=Fox.StrCode32
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local IsNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local GetGameObjectIdByIndex=GameObject.GetGameObjectIdByIndex
local GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
this.AnimalExtraId={UNIQUE_ANIMAL_00=TppAnimalId.COUNT+0,UNIQUE_ANIMAL_01=TppAnimalId.COUNT+1,UNIQUE_ANIMAL_02=TppAnimalId.COUNT+2,UNIQUE_ANIMAL_03=TppAnimalId.COUNT+3}
this.AnimalIdTable={
  [this.AnimalExtraId.UNIQUE_ANIMAL_00]=TppMotherBaseManagementConst.ANIMAL_1900,
  [this.AnimalExtraId.UNIQUE_ANIMAL_01]=TppMotherBaseManagementConst.ANIMAL_610,
  [this.AnimalExtraId.UNIQUE_ANIMAL_02]=TppMotherBaseManagementConst.ANIMAL_130,
  [this.AnimalExtraId.UNIQUE_ANIMAL_03]=TppMotherBaseManagementConst.ANIMAL_2250
}
function this.Messages()
  return
end
function this.OnAllocate(e)
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  mvars.ani_questTargetList={}
  mvars.ani_questGameObjectIdList={}
  mvars.ani_isQuestSetup=false
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.GetDataBaseIdFromAnimalId(n)
  if n<TppAnimalId.COUNT then
    return TppAnimalSystem.GetDataBaseIdFromAnimalId(n)
  else
    return this.AnimalIdTable[n]
  end
end
function this.SetEnabled(type,name,enabled)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetEnabled",name=name,enabled=enabled}
  GameObject.SendCommand(gameId,command)
end
function this.SetRoute(type,name,route)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetRoute",name=name,route=route}
  GameObject.SendCommand(gameId,command)
end
function this.SetHerdRoute(type,name,route)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetHerdEnabledCommand",type="Route",name=name,instanceIndex=0,route=route}
  GameObject.SendCommand(gameId,command)
end
function this.SetKind(type,name,fv2Index)
  if fv2Index==nil then
    return
  end
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetKind",name=name,fv2Index=fv2Index}
  GameObject.SendCommand(gameId,command)
end
function this.SetFova(type,name,color,seed)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command=nil
  if seed==nil then
    command={id="SetFovaInfo",name=name,color=color,isMale=true,isSetAll=true}
  else
    command={id="SetFovaInfo",name=name,seed=seed}
  end
  GameObject.SendCommand(gameId,command)
end
function this.SetNotice(type,name,enabled)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetNoticeEnabled",name=name,enabled=enabled}
  GameObject.SendCommand(gameId,command)
end
function this.SetIgnoreNotice(type,name,enable)
  local animalId={type=type,index=0}
  if animalId==NULL_ID then
    return
  end
  local command={id="SetIgnoreNotice",isPlayer=enable,isSoldier=enable}
  GameObject.SendCommand(animalId,command)
end
function this.SetSleep(type,name,enable)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetStatus",status="Sleep",set=enable}
  GameObject.SendCommand(gameId,command)
end
function this.SetAnimalId(type,name,animalId)
  local gameId={type=type,index=0}
  if gameId==NULL_ID then
    return
  end
  local command={id="SetAnimalId",name=name,animalId=animalId}
  GameObject.SendCommand(gameId,command)
end
function this.SetBird(birdList)
  for n,birdInfo in ipairs(birdList)do
    local birdGameId={type=birdInfo.birdType,index=0}
    local setEnabledCommand={id="SetEnabled",name=birdInfo.name,birdIndex=0,enabled=true}
    GameObject.SendCommand(birdGameId,setEnabledCommand)
    if(birdInfo.center and birdInfo.radius)and birdInfo.height then
      local changeFlyingZoneCommand={id="ChangeFlyingZone",name=birdInfo.name,center=birdInfo.center,radius=birdInfo.radius,height=birdInfo.height}
      GameObject.SendCommand(birdGameId,changeFlyingZoneCommand)
      local setLandingPointCommand=nil
      if birdInfo.ground then
        setLandingPointCommand={id="SetLandingPoint",birdIndex=0,name=birdInfo.name,groundPos=birdInfo.ground}
        GameObject.SendCommand(birdGameId,setLandingPointCommand)
      elseif birdInfo.perch then
        setLandingPointCommand={id="SetLandingPoint",birdIndex=0,name=birdInfo.name,perchPos=birdInfo.perch}
        GameObject.SendCommand(birdGameId,setLandingPointCommand)
      end
      local setAutoLandingCommand={id="SetAutoLanding",name=birdInfo.name}
      GameObject.SendCommand(birdGameId,setAutoLandingCommand)
    end
  end
end
--RETAILBUG tex I dont get why it's overriding TppRatBird enablebirds (which it is because of the order in Tpp.requires). I do see TppRatBird enablebirds has a bug, were they sidestepping that, otherwise how are the birds set up?
function TppRatBird._EnableBirds(e)
  for i,birdInfo in ipairs(mvars.rat_bird_birdList)do
  end
end
--IN: quest script .QUEST_TABLE
function this.OnActivateQuest(questTable)
  if mvars.ani_isQuestSetup==false then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
  end
  local addedAnimal=false
  if(questTable.animalList and Tpp.IsTypeTable(questTable.animalList))and next(questTable.animalList)then
    for i,animalInfo in pairs(questTable.animalList)do
      if animalInfo.animalName then
        if animalInfo.colorId then
          this.SetFova(animalInfo.animalType,animalInfo.animalName,animalInfo.colorId)
          addedAnimal=true
        end
        if animalInfo.animalId then
          this.SetAnimalId(animalInfo.animalType,animalInfo.animalName,animalInfo.animalId)
          addedAnimal=true
        end
        if animalInfo.kindId then
          this.SetKind(animalInfo.animalType,animalInfo.animalName,animalInfo.kindId)
          addedAnimal=true
        end
        if animalInfo.routeName then
          if animalInfo.animalType=="TppBear"then
            this.SetRoute(animalInfo.animalType,animalInfo.animalName,animalInfo.routeName)
          else
            this.SetHerdRoute(animalInfo.animalType,animalInfo.animalName,animalInfo.routeName)
          end
          addedAnimal=true
        end
        if animalInfo.isNotice then
          this.SetNotice(animalInfo.animalType,animalInfo.animalName,false)addedAnimal=true
        end
        if animalInfo.isIgnoreNotice then
          this.SetIgnoreNotice(animalInfo.animalType,animalInfo.animalName,true)addedAnimal=true
        end
        if animalInfo.isSleep then
          this.SetSleep(animalInfo.animalType,animalInfo.animalName,animalInfo.isSleep)addedAnimal=true
        end
      end
      if animalInfo.birdList then
        this.SetBird(animalInfo.birdList)
        addedAnimal=true
      end
    end
  end
  local animalId={messageId="None",idType="animalId"}
  local databaseId={messageId="None",idType="databaseId"}
  if mvars.ani_isQuestSetup==false then
    if(questTable.targetAnimalList and Tpp.IsTypeTable(questTable.targetAnimalList))and next(questTable.targetAnimalList)then
      local targetAnimalList=questTable.targetAnimalList
      if targetAnimalList.markerList then
        for n,animalName in pairs(targetAnimalList.markerList)do
          TppMarker.SetQuestMarker(animalName)
          local animalGameId=GetGameObjectId(animalName)
          TppBuddyService.SetTargetAnimalId(animalGameId)
          table.insert(mvars.ani_questGameObjectIdList,animalGameId)
        end
      end
      if targetAnimalList.animalIdList then
        for n,animalId in pairs(targetAnimalList.animalIdList)do
          mvars.ani_questTargetList[animalId]=animalId
          addedAnimal=true
        end
      end
      if targetAnimalList.dataBaseIdList then
        for n,animalId in pairs(targetAnimalList.dataBaseIdList)do
          mvars.ani_questTargetList[animalId]=databaseId
          addedAnimal=true
        end
      end
    end
  end
  if addedAnimal==true then
    mvars.ani_isQuestSetup=true
  end
end
function this.OnDeactivateQuest(n)
  if mvars.ani_isQuestSetup==true then
    if(n.animalList and Tpp.IsTypeTable(n.animalList))and next(n.animalList)then
      for a,n in pairs(n.animalList)do
        if n.animalName then
          if n.isNotice then
            this.SetNotice(n.animalType,n.animalName,true)
          end
          if n.isIgnoreNotice then
            this.SetIgnoreNotice(n.animalType,n.animalName,false)
          end
        end
      end
    end
  end
end
function this.OnTerminateQuest(e)
  TppBuddyService.RemoveTargetAnimalId()
  if mvars.ani_isQuestSetup==true then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
    mvars.ani_isQuestSetup=false
  end
end
function this.CheckQuestAllTarget(d,a,n,animalId)
  if not Tpp.IsAnimal(n)then
    return
  end
  local questClearType=TppDefine.QUEST_CLEAR_TYPE.NONE
  local databaseId=this.GetDataBaseIdFromAnimalId(animalId)
  local t=animalId
  local currentQuestName=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(currentQuestName)then
    return questClearType
  end
  for n,targetInfo in pairs(mvars.ani_questTargetList)do
    if targetInfo.idType=="animalId"then
      if n==t then
        targetInfo.messageId=a or"None"
        end
    elseif targetInfo.idType=="databaseId"then
      if n==databaseId then
        targetInfo.messageId=a or"None"
        end
    end
  end
  local i=0
  local a=0
  local e=0
  local t=0
  for n,targetInfo in pairs(mvars.ani_questTargetList)do
    if targetInfo.messageId~="None"then
      if targetInfo.messageId=="Fulton"then
        i=i+1
      elseif targetInfo.messageId=="Dead"then
        t=t+1
      elseif targetInfo.messageId=="FultonFailed"then
        a=a+1
      end
    end
  end
  local e=0
  for n,n in pairs(mvars.ani_questTargetList)do
    e=e+1
  end
  if e>0 then
    if d==TppDefine.QUEST_TYPE.ANIMAL_RECOVERED then
      if i>=e then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif a>0 or t>0 then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      end
    end
  end
  return questClearType
end
function this.IsQuestTarget(e)
  if mvars.ani_isQuestSetup==false then
    return false
  end
  if not next(mvars.ani_questGameObjectIdList)then
    return false
  end
  for a,n in pairs(mvars.ani_questGameObjectIdList)do
    if e==n then
      return true
    end
  end
  return false
end
return this

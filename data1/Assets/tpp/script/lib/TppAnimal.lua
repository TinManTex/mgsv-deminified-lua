-- DOBUILD: 1
-- TppAnimal.lua
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local IsNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local GetGameObjectIdByIndex=GameObject.GetGameObjectIdByIndex
local GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
--ORPHAN local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
this.AnimalExtraId={
  UNIQUE_ANIMAL_00=TppAnimalId.COUNT+0,
  UNIQUE_ANIMAL_01=TppAnimalId.COUNT+1,
  UNIQUE_ANIMAL_02=TppAnimalId.COUNT+2,
  UNIQUE_ANIMAL_03=TppAnimalId.COUNT+3,
}
this.AnimalIdTable={
  [this.AnimalExtraId.UNIQUE_ANIMAL_00]=TppMotherBaseManagementConst.ANIMAL_1900,
  [this.AnimalExtraId.UNIQUE_ANIMAL_01]=TppMotherBaseManagementConst.ANIMAL_610,
  [this.AnimalExtraId.UNIQUE_ANIMAL_02]=TppMotherBaseManagementConst.ANIMAL_130,
  [this.AnimalExtraId.UNIQUE_ANIMAL_03]=TppMotherBaseManagementConst.ANIMAL_2250
}
function this.Messages()
  return
end
function this.OnAllocate(missionTable)
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
function this.GetDataBaseIdFromAnimalId(animalId)
  if animalId<TppAnimalId.COUNT then
    return TppAnimalSystem.GetDataBaseIdFromAnimalId(animalId)
  else
    return this.AnimalIdTable[animalId]
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
function TppRatBird._EnableBirds(enable)
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
        --NMC are these the wrong way round?
        if animalInfo.isNotice then
          this.SetNotice(animalInfo.animalType,animalInfo.animalName,false)
          addedAnimal=true
        end
        if animalInfo.isIgnoreNotice then
          this.SetIgnoreNotice(animalInfo.animalType,animalInfo.animalName,true)
          addedAnimal=true
        end
        if animalInfo.isSleep then
          this.SetSleep(animalInfo.animalType,animalInfo.animalName,animalInfo.isSleep)
          addedAnimal=true
        end
      end
      if animalInfo.birdList then
        this.SetBird(animalInfo.birdList)
        addedAnimal=true
      end
    end
  end
  --ORPHAN due to RETAILBUG fix local animalIdEntry={messageId="None",idType="animalId"}
  --ORPHAN due to RETAILBUG fix local databaseIdEntry={messageId="None",idType="databaseId"}
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
        for i,animalId in pairs(targetAnimalList.animalIdList)do
          --RETAILBUG: assigning them all to the exact same table runs into issues when trying to assign different
          --message id to them in CheckQuestAllTarget
          --wasn't an issue in retail since there's no quests with more than one animal
          --ORIG mvars.ani_questTargetList[animalId]=animalIdEntry
          mvars.ani_questTargetList[animalId]={messageId="None",idType="animalId"}--tex fix for above
          addedAnimal=true
        end
      end
      if targetAnimalList.dataBaseIdList then
        for i,animalId in pairs(targetAnimalList.dataBaseIdList)do
          --ORIG mvars.ani_questTargetList[animalId]=databaseIdEntry--RETAILBUG: as above
          mvars.ani_questTargetList[animalId]={messageId="None",idType="databaseId"}--tex fix for above
          addedAnimal=true
        end
      end
      --tex>
       if targetAnimalList.nameList then
        for i,animalId in pairs(targetAnimalList.nameList)do
          mvars.ani_questTargetList[animalId]={messageId="None",idType="targetName"}
          addedAnimal=true
        end
      end
      --<
    end
  end
  if addedAnimal==true then
    mvars.ani_isQuestSetup=true
  end
end
--<quest script>.QUEST_TABLE
function this.OnDeactivateQuest(questTable)
  if mvars.ani_isQuestSetup==true then
    if(questTable.animalList and Tpp.IsTypeTable(questTable.animalList))and next(questTable.animalList)then
      for i,animalDef in pairs(questTable.animalList)do
        if animalDef.animalName then
          if animalDef.isNotice then
            this.SetNotice(animalDef.animalType,animalDef.animalName,true)
          end
          if animalDef.isIgnoreNotice then
            this.SetIgnoreNotice(animalDef.animalType,animalDef.animalName,false)
          end
        end
      end
    end
  end
end
function this.OnTerminateQuest(questTable)
  TppBuddyService.RemoveTargetAnimalId()
  if mvars.ani_isQuestSetup==true then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
    mvars.ani_isQuestSetup=false
  end
end
--tex REWORKED
function this.CheckQuestAllTarget(questType,messageId,checkGameId,checkAnimalId)
  if not Tpp.IsAnimal(checkGameId)then
    return
  end
  local questClearType=TppDefine.QUEST_CLEAR_TYPE.NONE
  local databaseId=this.GetDataBaseIdFromAnimalId(checkAnimalId)
  local currentQuestName=TppQuest.GetCurrentQuestName()
  
 
  if TppQuest.IsEnd(currentQuestName)then
    return questClearType
  end
  
  InfCore.Log("TppAnimal.CheckQuestAllTarget "..currentQuestName.." messageId:"..tostring(messageId).." checkGameId:"..tostring(checkGameId).." checkAnimalId:"..tostring(checkAnimalId).." databaseId:"..tostring(databaseId) )--tex DEBUG 
  for animalId,targetInfo in pairs(mvars.ani_questTargetList)do
    if targetInfo.idType=="animalId"then
      if animalId==checkAnimalId then
        targetInfo.messageId=messageId or"None"
      end
    elseif targetInfo.idType=="databaseId"then
      if animalId==databaseId then
        targetInfo.messageId=messageId or"None"
      end
    elseif targetInfo.idType=="targetName"then--tex added, game object name>
      local animalGameId=GetGameObjectId(animalId)
      if animalGameId==checkGameId then
        targetInfo.messageId=messageId or"None"
      end
    --<
    end
  end

  local stateCounts=this.GetQuestCount()
--  InfCore.Log("TppAnimal.CheckQuestAllTarget:")--tex DEBUG
--  InfCore.PrintInspect(stateCounts)
--  InfCore.PrintInspect(mvars.ani_questTargetList)
  --<
  if questType==TppDefine.QUEST_TYPE.ANIMAL_RECOVERED then
    if stateCounts.total==1 then
      if stateCounts.Fulton>=stateCounts.total then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif stateCounts.FultonFailed>0 or stateCounts.Dead>0 then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      end
      --tex added support for update
    elseif stateCounts.total>1 then
      if stateCounts.Fulton>=stateCounts.total then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif stateCounts.FultonFailed>0 or stateCounts.Dead>0 then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      elseif stateCounts.Fulton>0 then
        questClearType=TppDefine.QUEST_CLEAR_TYPE.UPDATE
      end
    end
  end
  return questClearType
end
--ORIG
--function this.CheckQuestAllTarget(questType,messageId,gameId,animalId)
--  if not Tpp.IsAnimal(gameId)then
--    return
--  end
--  local questClearType=TppDefine.QUEST_CLEAR_TYPE.NONE
--  local databaseId=this.GetDataBaseIdFromAnimalId(animalId)
--  local _animalId=animalId
--  local currentQuestName=TppQuest.GetCurrentQuestName()
--  if TppQuest.IsEnd(currentQuestName)then
--    return questClearType
--  end
--  for animalId,targetInfo in pairs(mvars.ani_questTargetList)do
--    if targetInfo.idType=="animalId"then
--      if animalId==_animalId then
--        targetInfo.messageId=messageId or"None"
--      end
--    elseif targetInfo.idType=="databaseId"then
--      if animalId==databaseId then
--        targetInfo.messageId=messageId or"None"
--      end
--    end
--  end
--  local numFulton=0
--  local numFultonFailed=0
--  --ORPHAN local unk1=0
--  local numDead=0
--  for animalId,targetInfo in pairs(mvars.ani_questTargetList)do
--    if targetInfo.messageId~="None"then
--      if targetInfo.messageId=="Fulton"then
--        numFulton=numFulton+1
--      elseif targetInfo.messageId=="Dead"then
--        numDead=numDead+1
--      elseif targetInfo.messageId=="FultonFailed"then
--        numFultonFailed=numFultonFailed+1
--      end
--    end
--  end
--  local numTargets=0
--  for animalId,targetInfo in pairs(mvars.ani_questTargetList)do
--    numTargets=numTargets+1
--  end
--  if numTargets>0 then
--    if questType==TppDefine.QUEST_TYPE.ANIMAL_RECOVERED then
--      if numFulton>=numTargets then
--        questClearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
--      elseif numFultonFailed>0 or numDead>0 then
--        questClearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
--      end
--    end
--  end
--  return questClearType
--end
--tex Added for UPDATE support>
function this.GetQuestCount()
  local stateCounts={
    None=0,
    Fulton=0,
    FultonFailed=0,
    Dead=0,
    total=0,
  }
  for animalId,targetInfo in pairs(mvars.ani_questTargetList)do
    stateCounts[targetInfo.messageId]=stateCounts[targetInfo.messageId]+1
    stateCounts.total=stateCounts.total+1
  end
  stateCounts.changed=math.abs(stateCounts.None-stateCounts.total)
  return stateCounts
end
--<
function this.IsQuestTarget(gameId)
  if mvars.ani_isQuestSetup==false then
    return false
  end
  if not next(mvars.ani_questGameObjectIdList)then
    return false
  end
  for i,animalGameId in pairs(mvars.ani_questGameObjectIdList)do
    if gameId==animalGameId then
      return true
    end
  end
  return false
end
return this

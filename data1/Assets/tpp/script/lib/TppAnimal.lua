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
function this.SetEnabled(e,t,a)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetEnabled",name=t,enabled=a}
  GameObject.SendCommand(e,n)
end
function this.SetRoute(e,t,a)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetRoute",name=t,route=a}
  GameObject.SendCommand(e,n)
end
function this.SetHerdRoute(e,a,t)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetHerdEnabledCommand",type="Route",name=a,instanceIndex=0,route=t}
  GameObject.SendCommand(e,n)
end
function this.SetKind(e,t,a)
  if a==nil then
    return
  end
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetKind",name=t,fv2Index=a}
  GameObject.SendCommand(e,n)
end
function this.SetFova(e,a,d,t)
  local i={type=e,index=0}
  if i==NULL_ID then
    return
  end
  local e=nil
  if t==nil then
    e={id="SetFovaInfo",name=a,color=d,isMale=true,isSetAll=true}
  else
    e={id="SetFovaInfo",name=a,seed=t}
  end
  GameObject.SendCommand(i,e)
end
function this.SetNotice(e,a,t)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetNoticeEnabled",name=a,enabled=t}
  GameObject.SendCommand(e,n)
end
function this.SetIgnoreNotice(a,t,e)
  local a={type=a,index=0}
  if a==NULL_ID then
    return
  end
  local e={id="SetIgnoreNotice",isPlayer=e,isSoldier=e}
  GameObject.SendCommand(a,e)
end
function this.SetSleep(e,t,a)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetStatus",status="Sleep",set=a}
  GameObject.SendCommand(e,n)
end
function this.SetAnimalId(e,a,t)
  local e={type=e,index=0}
  if e==NULL_ID then
    return
  end
  local n={id="SetAnimalId",name=a,animalId=t}
  GameObject.SendCommand(e,n)
end
function this.SetBird(e)
  for n,e in ipairs(e)do
    local n={type=e.birdType,index=0}
    local a={id="SetEnabled",name=e.name,birdIndex=0,enabled=true}
    GameObject.SendCommand(n,a)
    if(e.center and e.radius)and e.height then
      local a={id="ChangeFlyingZone",name=e.name,center=e.center,radius=e.radius,height=e.height}
      GameObject.SendCommand(n,a)
      local a=nil
      if e.ground then
        a={id="SetLandingPoint",birdIndex=0,name=e.name,groundPos=e.ground}
        GameObject.SendCommand(n,a)
      elseif e.perch then
        a={id="SetLandingPoint",birdIndex=0,name=e.name,perchPos=e.perch}
        GameObject.SendCommand(n,a)
      end
      local e={id="SetAutoLanding",name=e.name}
      GameObject.SendCommand(n,e)
    end
  end
end
function TppRatBird._EnableBirds(e)
  for e,e in ipairs(mvars.rat_bird_birdList)do
  end
end
function this.OnActivateQuest(t)
  if mvars.ani_isQuestSetup==false then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
  end
  local a=false
  if(t.animalList and Tpp.IsTypeTable(t.animalList))and next(t.animalList)then
    for t,n in pairs(t.animalList)do
      if n.animalName then
        if n.colorId then
          this.SetFova(n.animalType,n.animalName,n.colorId)a=true
        end
        if n.animalId then
          this.SetAnimalId(n.animalType,n.animalName,n.animalId)a=true
        end
        if n.kindId then
          this.SetKind(n.animalType,n.animalName,n.kindId)a=true
        end
        if n.routeName then
          if n.animalType=="TppBear"then
            this.SetRoute(n.animalType,n.animalName,n.routeName)
          else
            this.SetHerdRoute(n.animalType,n.animalName,n.routeName)
          end
          a=true
        end
        if n.isNotice then
          this.SetNotice(n.animalType,n.animalName,false)a=true
        end
        if n.isIgnoreNotice then
          this.SetIgnoreNotice(n.animalType,n.animalName,true)a=true
        end
        if n.isSleep then
          this.SetSleep(n.animalType,n.animalName,n.isSleep)a=true
        end
      end
      if n.birdList then
        this.SetBird(n.birdList)
        a=true
      end
    end
  end
  local animalId={messageId="None",idType="animalId"}
  local databaseId={messageId="None",idType="databaseId"}
  if mvars.ani_isQuestSetup==false then
    if(t.targetAnimalList and Tpp.IsTypeTable(t.targetAnimalList))and next(t.targetAnimalList)then
      local e=t.targetAnimalList
      if e.markerList then
        for n,e in pairs(e.markerList)do
          TppMarker.SetQuestMarker(e)
          local e=GetGameObjectId(e)
          TppBuddyService.SetTargetAnimalId(e)
          table.insert(mvars.ani_questGameObjectIdList,e)
        end
      end
      if e.animalIdList then
        for n,e in pairs(e.animalIdList)do
          mvars.ani_questTargetList[e]=animalId
          a=true
        end
      end
      if e.dataBaseIdList then
        for t,e in pairs(e.dataBaseIdList)do
          mvars.ani_questTargetList[e]=databaseId
          a=true
        end
      end
    end
  end
  if a==true then
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
  for n,e in pairs(mvars.ani_questTargetList)do
    if e.idType=="animalId"then
      if n==t then
        e.messageId=a or"None"
        end
    elseif e.idType=="databaseId"then
      if n==databaseId then
        e.messageId=a or"None"
        end
    end
  end
  local i=0
  local a=0
  local e=0
  local t=0
  for n,e in pairs(mvars.ani_questTargetList)do
    if e.messageId~="None"then
      if e.messageId=="Fulton"then
        i=i+1
      elseif e.messageId=="Dead"then
        t=t+1
      elseif e.messageId=="FultonFailed"then
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

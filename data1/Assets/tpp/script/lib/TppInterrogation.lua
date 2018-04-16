--TppInterrogation.lua
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
local IsTypeTable=Tpp.IsTypeTable
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
--ORPHAN local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Interrogate",func=this._OnInterrogation},
      {msg="InterrogateEnd",func=this._OnInterrogationEnd},
      {msg="MapUpdate",func=this._OnMapUpdate}
    }
  }
end
function this.DeclareSVars()
  return{
    {name="InterrogationNormal",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="InterrogationHigh",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.MakeFlagHigh(cpId)
  if cpId==NULL_ID then
    return
  end
  if mvars.interTable[cpId]==nil then
    return
  end
  local index=mvars.interTable[cpId].index
  for i,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
    if interrInfo.name~=0 then
      local svarBitfield=svars.InterrogationHigh[index]
      local bitshift=bit.lshift(1,i-1)
      svars.InterrogationHigh[index]=bit.bor(svarBitfield,bitshift)
    end
  end
end
function this.ResetFlagHigh(cpId)
  if cpId==NULL_ID then
    return
  end
  if mvars.interTable[cpId]==nil then
    return
  end
  local index=mvars.interTable[cpId].index
  svars.InterrogationHigh[index]=0
end
function this.ResetFlagNormal(cpId)
  if cpId==NULL_ID then
    return
  end
  if mvars.interTable[cpId]==nil then
    return
  end
  local index=mvars.interTable[cpId].index
  svars.InterrogationNormal[index]=bit.bnot(0)
end
function this.UniqueInterrogationWithVoice(cpId,soundParameterId)
  if cpId==NULL_ID then
    return
  end
  local index=0
  for i,interrInfo in pairs(mvars.uniqueInterTable.unique)do
    if soundParameterId==interrInfo.name then
      index=i
    end
  end
  if index==0 then
  else
    index=index+64
  end
  SendCommand(cpId,{id="AssignInterrogationWithVoice",soundParameterId=soundParameterId,index=index})
end
function this.UniqueInterrogation(cpId,messageId)
  if cpId==NULL_ID then
    return
  end
  local index=0
  for i,interrInfo in pairs(mvars.uniqueInterTable.unique)do
    if messageId==interrInfo.name then
      index=i
    end
  end
  if index==0 then
  else
    index=index+64
  end
  SendCommand(cpId,{id="AssignInterrogation",messageId=messageId,index=index})
end
function this.QuestInterrogation(cpId,messageId)
  if cpId==NULL_ID then
    return
  end
  local index=0
  for i,interrInfo in pairs(mvars.questTable.unique)do
    if messageId==interrInfo.name then
      index=i
    end
  end
  if index==0 then
  else
    index=index+96
  end
  SendCommand(cpId,{id="AssignInterrogation",messageId=messageId,index=index})
end
function this.SetQuestHighIntTable(cpId,interrTable)
  if cpId==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[cpId].layer.high)==false then
    return
  end
  local highCount=1
  for i,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
    highCount=highCount+1
  end
  for i,addInterrInfo in pairs(interrTable)do
    local index=highCount
    if highCount>32 then
      return
    end
    for j,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if addInterrInfo.name==0 then
        index=j
        break
      end
    end
    if index==highCount then
      highCount=highCount+1
      mvars.interTable[cpId].layer.high[index]={name=0,func=0}
    end
    mvars.interTable[cpId].layer.high[index].name=addInterrInfo.name
    mvars.interTable[cpId].layer.high[index].func=addInterrInfo.func
    local cpInterrIndex=mvars.interTable[cpId].index
    local svarBitfield=svars.InterrogationHigh[cpInterrIndex]
    local bitShift=bit.lshift(1,index-1)
    svars.InterrogationHigh[cpInterrIndex]=bit.bor(svarBitfield,bitShift)
  end
end
function this.RemoveQuestHighIntTable(cpId,interrTable)
  if cpId==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[cpId].layer.high)==false then
    return
  end
  for i,addInterrInfo in pairs(interrTable)do
    for j,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if addInterrInfo.name==interrInfo.name then
        mvars.interTable[cpId].layer.high[j]={name=0,func=0}
        local index=mvars.interTable[cpId].index
        local svarBitfield=svars.InterrogationHigh[index]
        local bitshift=bit.lshift(1,j-1)
        svars.InterrogationHigh[index]=bit.band(svarBitfield,bit.bnot(bitshift))
        break
      end
    end
  end
end
function this.AddHighInterrogation(cpId,interrTable)
  if cpId==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[cpId].layer.high)==false then
    return
  end
  for i,addInterrInfo in pairs(interrTable)do
    for j,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if addInterrInfo.name==interrInfo.name then
        if addInterrInfo.func==interrInfo.func then
          local index=mvars.interTable[cpId].index
          local svarBitfield=svars.InterrogationHigh[index]
          local bitshift=bit.lshift(1,j-1)
          svars.InterrogationHigh[index]=bit.bor(svarBitfield,bitshift)
        end
      end
    end
  end
end
function this.RemoveHighInterrogation(cpId,interrInfo)
  if cpId==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[cpId].layer.high)==false then
    return
  end
  for i,addInterrInfo in pairs(interrInfo)do
    for j,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if addInterrInfo.name==interrInfo.name then
        if addInterrInfo.func==interrInfo.func then
          local index=mvars.interTable[cpId].index
          local svarBitfield=svars.InterrogationHigh[index]
          local bitshift=bit.lshift(1,j-1)
          svars.InterrogationHigh[index]=bit.band(svarBitfield,bit.bnot(bitshift))
        end
      end
    end
  end
end
function this.InitUniqueInterrogation(interrogationTable)
  mvars.uniqueInterTable={uniqueChara={},unique={}}
  for interrType,interrTable in pairs(interrogationTable)do
    mvars.uniqueInterTable[interrType]={}
    for i,interrInfo in pairs(interrTable)do
      mvars.uniqueInterTable[interrType][i]={name=0,func=0}
      mvars.uniqueInterTable[interrType][i].name=interrInfo.name
      mvars.uniqueInterTable[interrType][i].func=interrInfo.func
    end
  end
end
function this.ResetQuestTable()
  if mvars.questTable==nil then
    mvars.questTable={uniqueChara={},unique={}}
  end
  for k,v in pairs(mvars.questTable)do
    for l,w in pairs(v)do
      mvars.questTable[k][l]={name=0,func=0}
    end
  end
end

function this.AddQuestTable(interrTable)
  if mvars.questTable==nil then
    mvars.questTable={uniqueChara={},unique={}}
    this.ResetQuestTable()
  end
  for category,interrInfoTable in pairs(interrTable)do
    mvars.questTable[category]={}
    for i,interrInfo in pairs(interrInfoTable)do
      mvars.questTable[category][i]={name=0,func=0}
      mvars.questTable[category][i].name=interrInfo.name
      mvars.questTable[category][i].func=interrInfo.func
    end
  end
end
--missionTable.enemy.interrogation
function this.InitInterrogation(interrogationTable)
  mvars.interTable={}
  local index=0
  for cpName,layerTable in pairs(interrogationTable)do
    index=index+1
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
    else
      mvars.interTable[cpId]={index=index,layer={normal={},high={},uniqueChara={}}}
      for layerName,interrogations in pairs(layerTable)do
        mvars.interTable[cpId].layer[layerName]={}
        for i,interrInfo in pairs(interrogations)do
          mvars.interTable[cpId].layer[layerName][i]={name=0,func=0}
          mvars.interTable[cpId].layer[layerName][i].name=interrInfo.name
          mvars.interTable[cpId].layer[layerName][i].func=interrInfo.func
        end
      end
    end
  end
end
function this._AddGene(cpId)
  if cpId==NULL_ID then
    return
  end
  if mvars.interTable[cpId]==nil then
    local index=0
    for a,interrInfo in pairs(mvars.interTable)do
      if index>interrInfo.index then
        index=interrInfo.index
      end
    end
    index=index+1
    mvars.interTable[cpId]={index=index,layer={normal={},high={},uniqueChara={}}}
  end
end
function this.AddGeneInter(cpList)
  for cpName,useGeneInter in pairs(cpList)do
    if useGeneInter then
      local cpId=GetGameObjectId(cpName)
      if cpId==NULL_ID then
      else
        this._AddGene(cpId)
      end
    end
  end
end
function this._OnMapUpdate()
  TppUI.ShowAnnounceLog"updateMap"
end
function this._OnInterrogation(soldierId,cpId,allowCollectionInterr)
  if allowCollectionInterr>0 then
  end
  if mvars.questTable~=nil then
    for i,interrInfo in pairs(mvars.questTable.uniqueChara)do
      if soldierId==GetGameObjectId(interrInfo.name)then
        if interrInfo.func(soldierId,cpId)then
          return
        end
      end
    end
  end
  if mvars.uniqueInterTable~=nil then
    for n,interrInfo in pairs(mvars.uniqueInterTable.uniqueChara)do
      if soldierId==GetGameObjectId(interrInfo.name)then
        if interrInfo.func(soldierId,cpId)then
          return
        end
      end
    end
  end
  local interrInfo=this._SelectInterrogation(cpId,allowCollectionInterr)
  if interrInfo==nil then
    return
  end
  this._AssignInterrogation(cpId,interrInfo.name,interrInfo.index)
end
function this._OnInterrogationEnd(soldierId,cpId,strCodeName,index)
  if index==0 then
    return
  end
  local rangedIndex=index
  if rangedIndex>96 then
    rangedIndex=rangedIndex-96
    local interrName=false
    for i,interrInfo in pairs(mvars.questTable.unique)do
      if strCodeName==StrCode32(interrInfo.name)then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.questTable.unique[rangedIndex].func(soldierId,cpId,interrName)
      return
    end
  end
  if rangedIndex>64 then
    rangedIndex=rangedIndex-64
    local interrName=false
    for i,interrInfo in pairs(mvars.uniqueInterTable.unique)do
      if strCodeName==StrCode32(interrInfo.name)then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.uniqueInterTable.unique[rangedIndex].func(soldierId,cpId,interrName)
      return
    end
  end
  if mvars.interTable[cpId]==nil then
    return
  end
  local cpInterrIndex=mvars.interTable[cpId].index
  if rangedIndex>32 then
    rangedIndex=rangedIndex-32
    local interrName=false
    for i,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if i==rangedIndex then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.interTable[cpId].layer.high[rangedIndex].func(soldierId,cpId,interrName)
    end
    local svarBitField=svars.InterrogationHigh[rangedIndex]
    svars.InterrogationHigh[rangedIndex]=bit.band(svarBitField,bit.bnot(bit.lshift(1,rangedIndex-1)))
  else
    local interrName=false
    for i,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
      if i==rangedIndex then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.interTable[cpId].layer.normal[rangedIndex].func(soldierId,cpId,interrName)
    end
    local svarBitField=svars.InterrogationNormal[cpInterrIndex]
    svars.InterrogationNormal[cpInterrIndex]=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.bnot(bit.lshift(1,rangedIndex-1)))
  end
end
function this._AssignInterrogation(cpId,messageId,index)
  SendCommand(cpId,{id="AssignInterrogation",messageId=messageId,index=index})
end
function this._AssignInterrogationCollection(cpId)
  SendCommand(cpId,{id="AssignInterrogationCollection"})
end
function this._SelectInterrogation(cpId,allowCollectionInterr)
  if mvars.interTable==nil then
    if allowCollectionInterr>0 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
    return{index=0,name=0}
  end
  if mvars.interTable[cpId]==nil then
    if allowCollectionInterr>0 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
    return{index=0,name=0}
  end
  local cpInterrIndex=mvars.interTable[cpId].index
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
    local bandDone=bit.band(svars.InterrogationHigh[cpInterrIndex],bit.lshift(1,index-1))
    if bandDone~=0 then
      return{index=index+32,name=interrInfo.name}
    end
  end
  if allowCollectionInterr>0 then
    local rnd=math.random(1,10)
    if rnd>=5 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
  end
  local maxNormal=1
  for i,n in pairs(mvars.interTable[cpId].layer.normal)do
    maxNormal=i
  end
  local rnd=math.random(1,maxNormal)
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
    if index>=rnd then
      local bandDone=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.lshift(1,index-1))
      if bandDone~=0 then
        return{index=index,name=interrInfo.name}
      end
    end
  end
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
    local bandDone=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.lshift(1,index-1))
    if bandDone~=0 then
      return{index=index,name=interrInfo.name}
    end
  end
  if allowCollectionInterr>0 then
    this._AssignInterrogationCollection(cpId)
    return nil
  end
  return{index=0,name=0}
end
return this

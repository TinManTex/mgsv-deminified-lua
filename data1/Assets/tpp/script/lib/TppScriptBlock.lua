local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local GetCurrentScriptBlockId=ScriptBlock.GetCurrentScriptBlockId
local GetScriptBlockState=ScriptBlock.GetScriptBlockState
local blockArraySize=8
--ORPHAN local RENsomeValue=-127
function this.DeclareSVars()
  return{
    {name="sbl_scriptBlockName",type=TppScriptVars.TYPE_UINT32,arraySize=blockArraySize,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="sbl_scriptBlockPack",type=TppScriptVars.TYPE_UINT32,arraySize=blockArraySize,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="sbl_isActive",type=TppScriptVars.TYPE_BOOL,arraySize=blockArraySize,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil}
end
function this.GetCurrentPackListName(blockName)
  local blockId=ScriptBlock.GetScriptBlockId(blockName)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    local packList=mvars.sbl_scriptBlockPackList[blockName]
    if not packList then
      return
    end
    local currentPackNameStr32=svars.sbl_scriptBlockPack[blockId]
    if currentPackNameStr32==0 then
      return
    end
    for packName,packPath in pairs(packList)do
      if currentPackNameStr32==Fox.StrCode32(packName)then
        return packName
      end
    end
  else
    return false
  end
end
function this.OnAllocate(missionTable)
  mvars.sbl_scriptBlockPackList={}
  mvars.sbl_scriptBlockStrCode32PackList={}
  mvars.sbl_scriptBlockState={}
  mvars.sbl_preloadRequestTable={}
  if missionTable.demo and missionTable.demo.demoBlockList then
    this.RegisterCommonBlockPackList("demo_block",missionTable.demo.demoBlockList)
  end
end
function this.RegisterCommonBlockPackList(blockName,blockPackList)
  if type(blockName)~="string"then
    return
  end
  if IsTypeTable(blockPackList)then
    mvars.sbl_scriptBlockPackList[blockName]={}
    mvars.sbl_scriptBlockStrCode32PackList[blockName]={}
    for packName,packPath in pairs(blockPackList)do
      mvars.sbl_scriptBlockPackList[blockName][packName]=packPath
    end
  else
    return
  end
end
function this.InitScriptBlockState(blockId)
  this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.ALLOCATED)
end
function this.FinalizeScriptBlockState(blockId)
  this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.EMPTY)
end
function this.ActivateScriptBlockState(blockId)
  local activated=this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.ACTIVATED)
  if activated then
    svars.sbl_isActive[blockId]=true
    ScriptBlock.Activate(blockId)
  end
end
function this.DeactivateScriptBlockState(blockId)
  local deactivated=this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.INITIALIZED)
  if deactivated then
    svars.sbl_isActive[blockId]=false
    ScriptBlock.Deactivate(blockId)
  end
end
function this.RequestActivate(blockName)
  local blockId=ScriptBlock.GetScriptBlockId(blockName)
  this.RequestActivateByBlockId(blockId)
end
function this.RequestActivateByBlockId(blockId)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    local blockState=ScriptBlock.GetScriptBlockState(blockId)
    if blockState<=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
      return
    end
    if mvars.sbl_scriptBlockState[blockId]<TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED then
      this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED)
    end
  end
end
function this.IsRequestActivate(_blockId)
  local blockId=_blockId or GetCurrentScriptBlockId()
  if mvars.sbl_scriptBlockState[blockId]==TppDefine.SCRIPT_BLOCK_STATE.ACTIVATE_REQUESTED then
    return true
  else
    return false
  end
end
function this.SetScriptBlockState(_blockId,blockState)
  local blockId=_blockId or GetCurrentScriptBlockId()
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return false
  end
  if blockId>=blockArraySize then
    return false
  end
  if(blockState>=TppDefine.SCRIPT_BLOCK_STATE.MIN)or(blockState<TppDefine.SCRIPT_BLOCK_STATE.MAX)then
    mvars.sbl_scriptBlockState[blockId]=blockState
    return true
  else
    return false
  end
end
function this.LoadDemoBlock(packName,load)
  this.Load("demo_block",packName,true,load)
end
function this.Load(blockName,packName,doActivate,load)
  local doLoad=true
  if load==false then
    doLoad=false
  end
  local blockId=ScriptBlock.GetScriptBlockId(blockName)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    this.SaveScriptBlockId(blockName,blockId)
    local packPath=this.FindPackList(blockName,packName)
    if packPath then
      svars.sbl_scriptBlockPack[blockId]=StrCode32(packName)
      if doLoad then
        ScriptBlock.Load(blockId,packPath)
      end
      if doActivate then
        this.ActivateScriptBlockState(blockId)
      end
    else
      return false
    end
  else
    return false
  end
end
function this.Unload(blockName)
  local blockId=ScriptBlock.GetScriptBlockId(blockName)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    svars.sbl_scriptBlockPack[blockId]=0
    ScriptBlock.Load(blockId,"")
  else
    return false
  end
end
function this.SaveScriptBlockId(blockName,blockId)
  local blockNameStr32=Fox.StrCode32(blockName)
  svars.sbl_scriptBlockName[blockId]=blockNameStr32
end
function this.FindPackList(blockName,packName)
  if Tpp.IsTypeTable(mvars.sbl_scriptBlockPackList)then
    if mvars.sbl_scriptBlockPackList[blockName]then
      return mvars.sbl_scriptBlockPackList[blockName][packName]
    end
  end
end

--REF param = {{ demo_block = "Demo_ArrivalInAfghanistan" },}
function this.PreloadRequestOnMissionStart(params)
  if not IsTypeTable(params)then
    return
  end
  local preloadRequestTable=mvars.sbl_preloadRequestTable
  for n,request in pairs(params)do
    local blockName,packName=next(request)
    local preloadRequest={}
    preloadRequest[blockName]=packName
    table.insert(preloadRequestTable,preloadRequest)
  end
end
function this.DEBUG_PreloadRequest(t)
  if not IsTypeTable(t)then
    return
  end
  this.DEBUG_preloadRequestTable=t
end
function this.DEBUG_ClearPreloadRequest()
  this.DEBUG_preloadRequestTable=nil
end
function this.PreloadSettingOnMissionStart()
  local preloadRequestTable=mvars.sbl_preloadRequestTable
  if not next(preloadRequestTable)then
    return
  end
  for n,request in pairs(preloadRequestTable)do
    if next(request)then
      for blockName,packName in pairs(request)do
        local blockId=ScriptBlock.GetScriptBlockId(blockName)
        if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
          svars.sbl_scriptBlockPack[blockId]=StrCode32(packName)
          svars.sbl_isActive[blockId]=true
        end
      end
    end
  end
end
function this.ReloadScriptBlock()
  mvars.sbl_currentScriptBlockPackInfo={}
  for blockId=0,(blockArraySize-1)do
    this.ResolveSavedScriptBlockInfo(blockId)
  end
  for blockId,scriptBlockPackInfo in pairs(mvars.sbl_currentScriptBlockPackInfo)do
    svars.sbl_scriptBlockPack[blockId]=scriptBlockPackInfo.packListKeyHash
    svars.sbl_scriptBlockName[blockId]=scriptBlockPackInfo.scriptBlockNameHash
  end
  for blockName,packList in pairs(mvars.sbl_scriptBlockPackList)do
    local blockId=ScriptBlock.GetScriptBlockId(blockName)
    if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
      mvars.sbl_scriptBlockStrCode32PackList[blockId]={}
      for packName,packPath in pairs(packList)do
        mvars.sbl_scriptBlockStrCode32PackList[blockId][StrCode32(packName)]=packPath
      end
    end
  end
  for blockId=0,(blockArraySize-1)do
    local packNameStr32=svars.sbl_scriptBlockPack[blockId]
    if packNameStr32>0 then
      if mvars.sbl_scriptBlockStrCode32PackList[blockId]then
        local packPath=mvars.sbl_scriptBlockStrCode32PackList[blockId][packNameStr32]
        if packPath then
          ScriptBlock.Load(blockId,packPath)
          if svars.sbl_isActive[blockId]then
            this.ActivateScriptBlockState(blockId)
          end
        end
      end
    end
  end
end
function this.ResolveSavedScriptBlockInfo(blockId)
  local scriptBlockNameHash=svars.sbl_scriptBlockName[blockId]
  local packListKeyHash=svars.sbl_scriptBlockPack[blockId]
  if scriptBlockNameHash==0 then
    return
  end
  if packListKeyHash==0 then
    return
  end
  local currentBlockName
  for blockName,packList in pairs(mvars.sbl_scriptBlockPackList)do
    if Fox.StrCode32(blockName)==scriptBlockNameHash then
      currentBlockName=blockName
      break
    end
  end
  if not currentBlockName then
    this.ClearSavedScriptBlockInfo(blockId)
    return
  end
  local blockId=ScriptBlock.GetScriptBlockId(currentBlockName)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    mvars.sbl_currentScriptBlockPackInfo[blockId]={scriptBlockNameHash=scriptBlockNameHash,packListKeyHash=packListKeyHash}
  else
    this.ClearSavedScriptBlockInfo(blockId,currentBlockName)
  end
end
function this.ClearSavedScriptBlockInfo(blockId,blockName)
  svars.sbl_scriptBlockName[blockId]=0
  svars.sbl_scriptBlockPack[blockId]=0
end
return this

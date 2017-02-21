local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local GetCurrentScriptBlockId=ScriptBlock.GetCurrentScriptBlockId
local GetScriptBlockState=ScriptBlock.GetScriptBlockState
local blockArraySize=8
local c=-127
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
    local t=mvars.sbl_scriptBlockPackList[blockName]
    if not t then
      return
    end
    local e=svars.sbl_scriptBlockPack[blockId]
    if e==0 then
      return
    end
    for t,c in pairs(t)do
      if e==Fox.StrCode32(t)then
        return t
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
function this.RegisterCommonBlockPackList(e,t)
  if type(e)~="string"then
    return
  end
  if IsTypeTable(t)then
    mvars.sbl_scriptBlockPackList[e]={}
    mvars.sbl_scriptBlockStrCode32PackList[e]={}
    for t,c in pairs(t)do
      mvars.sbl_scriptBlockPackList[e][t]=c
    end
  else
    return
  end
end
function this.InitScriptBlockState(t)
  this.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.ALLOCATED)
end
function this.FinalizeScriptBlockState(t)
  this.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.EMPTY)
end
function this.ActivateScriptBlockState(blockId)
  local e=this.SetScriptBlockState(blockId,TppDefine.SCRIPT_BLOCK_STATE.ACTIVATED)
  if e then
    svars.sbl_isActive[blockId]=true
    ScriptBlock.Activate(blockId)
  end
end
function this.DeactivateScriptBlockState(t)
  local e=this.SetScriptBlockState(t,TppDefine.SCRIPT_BLOCK_STATE.INITIALIZED)
  if e then
    svars.sbl_isActive[t]=false
    ScriptBlock.Deactivate(t)
  end
end
function this.RequestActivate(blockName)
  local blockId=ScriptBlock.GetScriptBlockId(blockName)
  this.RequestActivateByBlockId(blockId)
end
function this.RequestActivateByBlockId(blockId)
  if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    local c=ScriptBlock.GetScriptBlockState(blockId)
    if c<=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
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
function this.SetScriptBlockState(_blockId,c)
  local blockId=_blockId or GetCurrentScriptBlockId()
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return false
  end
  if blockId>=blockArraySize then
    return false
  end
  if(c>=TppDefine.SCRIPT_BLOCK_STATE.MIN)or(c<TppDefine.SCRIPT_BLOCK_STATE.MAX)then
    mvars.sbl_scriptBlockState[blockId]=c
    return true
  else
    return false
  end
end
function this.LoadDemoBlock(t,c)
  this.Load("demo_block",t,true,c)
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
function this.SaveScriptBlockId(t,e)
  local t=Fox.StrCode32(t)
  svars.sbl_scriptBlockName[e]=t
end
function this.FindPackList(blockName,packName)
  if Tpp.IsTypeTable(mvars.sbl_scriptBlockPackList)then
    if mvars.sbl_scriptBlockPackList[blockName]then
      return mvars.sbl_scriptBlockPackList[blockName][packName]
    end
  end
end
function this.PreloadRequestOnMissionStart(e)
  if not IsTypeTable(e)then
    return
  end
  local r=mvars.sbl_preloadRequestTable
  for t,e in pairs(e)do
    local c,t=next(e)
    local e={}e[c]=t
    table.insert(r,e)
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
  local e=mvars.sbl_preloadRequestTable
  if not next(e)then
    return
  end
  for t,e in pairs(e)do
    if next(e)then
      for e,t in pairs(e)do
        local e=ScriptBlock.GetScriptBlockId(e)
        if e~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
          svars.sbl_scriptBlockPack[e]=StrCode32(t)svars.sbl_isActive[e]=true
        end
      end
    end
  end
end
function this.ReloadScriptBlock()
  mvars.sbl_currentScriptBlockPackInfo={}
  for t=0,(blockArraySize-1)do
    this.ResolveSavedScriptBlockInfo(t)
  end
  for e,scriptBlockPackInfo in pairs(mvars.sbl_currentScriptBlockPackInfo)do
    svars.sbl_scriptBlockPack[e]=scriptBlockPackInfo.packListKeyHash
    svars.sbl_scriptBlockName[e]=scriptBlockPackInfo.scriptBlockNameHash
  end
  for blockName,t in pairs(mvars.sbl_scriptBlockPackList)do
    local blockId=ScriptBlock.GetScriptBlockId(blockName)
    if blockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
      mvars.sbl_scriptBlockStrCode32PackList[blockId]={}
      for t,c in pairs(t)do
        mvars.sbl_scriptBlockStrCode32PackList[blockId][StrCode32(t)]=c
      end
    end
  end
  for blockId=0,(blockArraySize-1)do
    local c=svars.sbl_scriptBlockPack[blockId]
    if c>0 then
      if mvars.sbl_scriptBlockStrCode32PackList[blockId]then
        local packPath=mvars.sbl_scriptBlockStrCode32PackList[blockId][c]
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
function this.ResolveSavedScriptBlockInfo(t)
  local r=svars.sbl_scriptBlockName[t]
  local i=svars.sbl_scriptBlockPack[t]
  if r==0 then
    return
  end
  if i==0 then
    return
  end
  local c
  for e,t in pairs(mvars.sbl_scriptBlockPackList)do
    if Fox.StrCode32(e)==r then
      c=e
      break
    end
  end
  if not c then
    this.ClearSavedScriptBlockInfo(t)
    return
  end
  local l=ScriptBlock.GetScriptBlockId(c)
  if l~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    mvars.sbl_currentScriptBlockPackInfo[l]={scriptBlockNameHash=r,packListKeyHash=i}
  else
    this.ClearSavedScriptBlockInfo(t,c)
  end
end
function this.ClearSavedScriptBlockInfo(e,t)svars.sbl_scriptBlockName[e]=0
  svars.sbl_scriptBlockPack[e]=0
end
return this

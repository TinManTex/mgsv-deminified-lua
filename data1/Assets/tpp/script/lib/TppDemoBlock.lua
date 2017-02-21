--TppDemoBlock.lua
local this={}
local GetCurrentScriptBlockId=ScriptBlock.GetCurrentScriptBlockId
local GetScriptBlockState=ScriptBlock.GetScriptBlockState
this.isAllocatedMtbsEnemy=false
function this.OnAllocate()
  TppScriptBlock.InitScriptBlockState()
  this.isAllocatedMtbsEnemy=false
  if vars.missionCode==30050 then
    this.isAllocatedMtbsEnemy=true
    mtbs_enemy.OnAllocateDemoBlock()
  end
end
function this.OnInitialize()
end
function this.OnUpdate()
  local blockId=GetCurrentScriptBlockId()
  local blockState=GetScriptBlockState(blockId)
  if blockState==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    TppDemo.PlayOnDemoBlock()
    return
  end
  if TppScriptBlock.IsRequestActivate(blockId)then
    TppScriptBlock.ActivateScriptBlockState(blockId)
  end
end
function this.OnTerminate()
  TppDemo.FinalizeOnDemoBlock()
  TppScriptBlock.FinalizeScriptBlockState()
  if this.isAllocatedMtbsEnemy then
    mtbs_enemy.OnTerminateDemoBlock()
  end
end
return this

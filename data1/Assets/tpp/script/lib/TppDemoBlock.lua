local this={}
local c=ScriptBlock.GetCurrentScriptBlockId
local t=ScriptBlock.GetScriptBlockState
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
  local e=c()
  local t=t(e)
  if t==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    TppDemo.PlayOnDemoBlock()
    return
  end
  if TppScriptBlock.IsRequestActivate(e)then
    TppScriptBlock.ActivateScriptBlockState(e)
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

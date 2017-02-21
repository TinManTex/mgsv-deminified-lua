-- DOBUILD: 1
local this={}
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
this.REINFORCE_TYPE_NAME={"NONE","EAST_WAV","EAST_WAV_ROCKET","WEST_WAV","WEST_WAV_CANNON","EAST_TANK","WEST_TANK","HELI"}
this.REINFORCE_TYPE=TppDefine.Enum(this.REINFORCE_TYPE_NAME)
this.REINFORCE_FPK={
  [this.REINFORCE_TYPE.NONE]="",
  [this.REINFORCE_TYPE.EAST_WAV]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav.fpk",
  [this.REINFORCE_TYPE.EAST_WAV_ROCKET]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav_roc.fpk",
  [this.REINFORCE_TYPE.WEST_WAV]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_c.fpk"
  },
  [this.REINFORCE_TYPE.WEST_WAV_CANNON]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_c.fpk"
  },
  [this.REINFORCE_TYPE.EAST_TANK]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",
  [this.REINFORCE_TYPE.WEST_TANK]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_c.fpk"
  },
  [this.REINFORCE_TYPE.HELI]={
    AFGH={
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
    },
    MAFR={
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
    },
    MTBS={--tex>
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
    }--<
  }
}
this.REINFORCE_VEHICLE_NAME="reinforce_vehicle_0000"
this.REINFORCE_DRIVER_SOLDIER_NAME="reinforce_soldier_driver"
this.REINFORCE_SOLDIER_NAMES={"reinforce_soldier_0000","reinforce_soldier_0001","reinforce_soldier_0002","reinforce_soldier_0003"}
this.REINFORCE_HELI_NAME="EnemyHeli"
function this.GetReinforceBlockId()
  return ScriptBlock.GetScriptBlockId(mvars.reinforce_reinforceBlockName)
end
function this.GetReinforceBlockState()
  return ScriptBlock.GetScriptBlockState(this.GetReinforceBlockId())
end
function this.IsLoaded()
  return this.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
end
function this.IsProcessing()
  return this.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
end
function this.GetFpk(reinforceType,pfcType,coloringType)--NMC: basically parses REINFORCE_FPK
  local fpkTableForReinforceType=this.REINFORCE_FPK[reinforceType]
  if Tpp.IsTypeTable(fpkTableForReinforceType)then
    local locationString=""
    if TppLocation.IsAfghan()then
      locationString="AFGH"
    elseif TppLocation.IsMiddleAfrica()then
      locationString="MAFR"
    elseif TppLocation.IsMotherBase() or TppLocation.IsMBQF() then--tex>
      locationString="MTBS"--<
    end
    local fpkPath=fpkTableForReinforceType[pfcType]or fpkTableForReinforceType[locationString]
    if Tpp.IsTypeTable(fpkPath)then
      coloringType=coloringType or"_DEFAULT"
      if fpkPath[coloringType]then
        fpkPath=fpkPath[coloringType]
      else
        fpkPath=nil
      end
    end
    if fpkPath then
      fpkTableForReinforceType=fpkPath
    else
      local r=""
      for i,n in pairs(fpkTableForReinforceType)do
        if r==""then
          r=n
        end
      end
      fpkTableForReinforceType=r
    end
  end
  if not fpkTableForReinforceType then
    return""
  end
  return fpkTableForReinforceType
end
function this.SetUpReinforceBlock()
  mvars.reinforce_reinforceBlockName="reinforce_block"
  local hasReinforceBlock=false
  local reinforceBlockId=this.GetReinforceBlockId()
  hasReinforceBlock=(reinforceBlockId~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID)
  mvars.reinforce_hasReinforceBlock=hasReinforceBlock

  if not mvars.reinforce_hasReinforceBlock then
--    InfMenu.DebugPrint"not reinforce_hasReinforceBlock"--DEBUG
    return
  end
  --InfMenu.DebugPrint"SetUpReinforceBlock"--DEBUG
  for n,soldierName in ipairs(this.REINFORCE_SOLDIER_NAMES)do
    this._SetEnabledSoldier(soldierName,false)
  end
  this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,false)
  mvars.reinforce_reinforceType=this.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=NULL_ID
  mvars.reinforce_activated=false
end
function this.LoadReinforceBlock(reinforceType,reinforceCpId,reinforceColoringType)
--  InfMenu.DebugPrint"LoadReinforceBlock"--DEBUG
  if mvars.reinforce_activated then
--    InfMenu.DebugPrint"LoadReinforceBlock reinforce_activated already true, aborting"--DEBUG
    return
  end
  if mvars.reinforce_reinforceCpId~=NULL_ID and mvars.reinforce_reinforceCpId~=reinforceCpId then
--    InfMenu.DebugPrint("LoadReinforceBlock cpId:"..tostring(reinforceCpId).." doesnt match reinforce_reinforceCpId:"..tostring(mvars.reinforce_reinforceCpId)..", aborting")--DEBUG
    return
  end
  if not mvars.reinforce_hasReinforceBlock then
--    InfMenu.DebugPrint"LoadReinforceBlock no reinforceblock"--DEBUG
    return
  end
  if reinforceType==this.REINFORCE_TYPE.HELI and GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"then
--    InfMenu.DebugPrint"LoadReinforceBlock reinforcetype heli, has TppEnemyHeli"--DEBUG
    return
  end
  local reinforceBlockId=this.GetReinforceBlockId()
  local cpSubType=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
  local fpk=this.GetFpk(reinforceType,cpSubType,reinforceColoringType)
  if fpk==nil then
    reinforceType=this.REINFORCE_TYPE.NONE
    fpk=""
  end
  --InfMenu.DebugPrint("LoadReinforceBlock fpk: "..tostring(fpk))--DEBUG
  ScriptBlock.Load(reinforceBlockId,fpk)
  mvars.reinforce_reinforceType=reinforceType
  mvars.reinforce_reinforceColoringType=reinforceColoringType
  if reinforceType~=this.REINFORCE_TYPE.NONE then
--    InfMenu.DebugPrint"LoadReinforceBlock SetReinforceEnable"--DEBUG
    SendCommand({type="TppCommandPost2"},{id="SetReinforceEnable"})
    mvars.reinforce_reinforceCpId=reinforceCpId
    local hasVehicle=this._HasVehicle()
    local hasSoldier=this._HasSoldier()
    local vehicleId,driverId
    local reinforceSoldiers={}
    if hasSoldier then
      for n,soldierName in ipairs(this.REINFORCE_SOLDIER_NAMES)do
        reinforceSoldiers[n]=GameObject.GetGameObjectId("TppSoldier2",soldierName)
      end
    end
    if hasVehicle then
--      InfMenu.DebugPrint"LoadReinforceBlock hasvehicle"--DEBUG
      vehicleId=GameObject.GetGameObjectId("TppVehicle2",this.REINFORCE_VEHICLE_NAME)
      driverId=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_DRIVER_SOLDIER_NAME)
    end
--    InfMenu.DebugPrint"LoadReinforceBlock SetNominateList"--DEBUG
    SendCommand({type="TppCommandPost2"},{id="SetNominateList",driver=driverId,vehicle=vehicleId,sol01=reinforceSoldiers[1],sol02=reinforceSoldiers[2],sol03=reinforceSoldiers[3],sol04=reinforceSoldiers[4]})
  else
--    InfMenu.DebugPrint"reinforceType==this.REINFORCE_TYPE.NONE"--DEBUG
    mvars.reinforce_reinforceCpId=NULL_ID
  end
end
function this.UnloadReinforceBlock(cpId)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if((cpId~=nil and cpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=cpId then
    return
  end
  local reinforceBlockId=this.GetReinforceBlockId()
  if this.GetReinforceBlockState()>ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
    this.ReinforceBlockOnDeactivate()
  end
  ScriptBlock.Load(reinforceBlockId,"")
  mvars.reinforce_reinforceType=this.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=NULL_ID
end
function this.StartReinforce(cpId)
  if not mvars.reinforce_hasReinforceBlock then
--    InfMenu.DebugPrint"StartReinforce not reinforce_hasReinforceBlock"--DEBUG
    return
  end
  if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.NONE then
--    InfMenu.DebugPrint"StartReinforce REINFORCE_TYPE.NONE"--DEBUG
    return
  end
  --NMC: cpid mismatch is usually due to a quest heli aleady being set up
  if(cpId~=nil and cpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=cpId then
--    InfMenu.DebugPrint"StartReinforce cpId doesnt match, aborting"--DEBUG
    return
  end
  --  InfMenu.DebugPrint"StartReinforce do ScriptBlock.Activate"--DEBUG
  local reinforceBlockId=this.GetReinforceBlockId()
  ScriptBlock.Activate(reinforceBlockId)
  mvars.reinforce_activated=true
end
function this.FinishReinforce(cpId)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if(cpId~=nil and cpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=cpId then
    return
  end
  local reinforceBlockId=this.GetReinforceBlockId()
  ScriptBlock.Deactivate(reinforceBlockId)
  mvars.reinforce_activated=false
  mvars.reinforce_reinforceCpId=NULL_ID
end
function this.ReinforceBlockOnInitialize()
  mvars.reinforce_lastReinforceBlockState=this.GetReinforceBlockState()
  mvars.reinforce_isEnabledVehicle=false
  mvars.reinforce_isEnabledSoldiers=false
end
function this.ReinforceBlockOnUpdate()
  local reinforceBlockState=this.GetReinforceBlockState()
  if reinforceBlockState==nil then
    return
  end
  local ScriptBlock=ScriptBlock
  local mvars=mvars
  local lastReinforceBlockState=mvars.reinforce_lastReinforceBlockState
  local SCRIPT_BLOCK_STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
  local SCRIPT_BLOCK_STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  if reinforceBlockState==SCRIPT_BLOCK_STATE_INACTIVE then
    if lastReinforceBlockState==SCRIPT_BLOCK_STATE_ACTIVE then
      this.ReinforceBlockOnDeactivate()
    end
    mvars.reinforce_lastReinforceInactiveToActive=false
  elseif reinforceBlockState==SCRIPT_BLOCK_STATE_ACTIVE then
    if mvars.reinforce_lastReinforceInactiveToActive then
      mvars.reinforce_lastReinforceInactiveToActive=false
      this.ReinforceBlockOnActivate()
    end
    if(not lastReinforceBlockState)or lastReinforceBlockState<=SCRIPT_BLOCK_STATE_INACTIVE then
      mvars.reinforce_lastReinforceInactiveToActive=true
    end
  end
  mvars.reinforce_lastReinforceBlockState=reinforceBlockState
end
function this.ReinforceBlockOnActivate()
  this._ActivateReinforce()
end
function this.ReinforceBlockOnDeactivate()
  this._DeactivateReinforce()
end
function this.ReinforceBlockOnTerminate()
end
function this._HasSoldier()
  if Ivars.enableSoldiersWithVehicleReinforce:Is(1) then--tex>
    return true
  end--<

  if((mvars.reinforce_reinforceType==this.REINFORCE_TYPE.HELI or
    mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET)or
    mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_TANK)or
    mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_TANK then
    return false
  end
  return true
end
function this._HasVehicle()
  if((((mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV
    or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET)
    or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV)
    or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV_CANNON)
    or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_TANK)
    or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_TANK then
    --InfMenu.DebugPrint("_HasVehicle reinforce_reinforceType="..mvars.reinforce_reinforceType.."="..this.REINFORCE_TYPE_NAME[mvars.reinforce_reinforceType+1] )
    return true
  end
  --InfMenu.DebugPrint("_HasVehicle false")
  return false
end
function this._HasHeli()
  if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.HELI then
    return true
  end
  return false
end
function this._GetHeliRoute(e)
  return"reinforce_heli_route_0000"
end
function this._SetEnabledSoldier(soldierName,enabled)
  local soldierId=GameObject.GetGameObjectId(soldierName)
  if soldierId==NULL_ID then
    return
  end
--  TppMarker.Enable(soldierId,0,"moving","all",0,true,false)--tex DEBUG
  SendCommand(soldierId,{id="SetEnabled",enabled=enabled})
end
function this._SetEnabledVehicle(name,enable)
  local vehicleId=GameObject.GetGameObjectId(name)
  if vehicleId==NULL_ID then
    return
  end
  if enable then
    local subType
    if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET then
      subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY
    elseif mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV then
      subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN
    elseif mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV_CANNON then
      subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON
    end
    local cpSubType=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
    local paintType=Vehicle.paintType.NONE
    if(cpSubType=="PF_A"or cpSubType=="PF_B")or cpSubType=="PF_C"then
      paintType=Vehicle.paintType.FOVA_0
    end
    local class=nil
    if mvars.reinforce_reinforceColoringType then
      class=mvars.reinforce_reinforceColoringType
    end
    local command={id="Respawn",name=name,type=9,subType=subType,paintType=paintType,class=class}
    SendCommand(vehicleId,command)
  else
    SendCommand(vehicleId,{id="Despawn",name=name,type=9})
  end
end
function this._ActivateReinforce()
  --InfMenu.DebugPrint("_ActivateReinforce")--DEBUG
  local hasVehicle=this._HasVehicle()
  local hasSoldier=this._HasSoldier()
  local hasHeli=this._HasHeli()
  --InfMenu.DebugPrint("ActRein: hasVehicle:"..tostring(hasVehicle).." hasHeli:"..tostring(hasHeli))--DEBUG
  local vehicleId,driverId,soldier1Id,soldier2Id,soldier3Id,soldier4Id
  local reinforceSoldiers={}
  if hasSoldier and (Ivars.forceSuperReinforce:Is(0) or not mvars.reinforce_isEnabledSoldiers) then--tex added conditions
--    InfMenu.DebugPrint("_ActivateReinforce hassoldier, enabling")--DEBUG
    mvars.reinforce_isEnabledSoldiers=true
    for n,soldierName in ipairs(this.REINFORCE_SOLDIER_NAMES)do
      this._SetEnabledSoldier(soldierName,true)
    end
    soldier1Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[1])
    soldier2Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[2])
    soldier3Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[3])
    soldier4Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[4])
    table.insert(reinforceSoldiers,soldier1Id)
    table.insert(reinforceSoldiers,soldier2Id)
    table.insert(reinforceSoldiers,soldier3Id)
    table.insert(reinforceSoldiers,soldier4Id)
  end
  if hasVehicle then
--    InfMenu.DebugPrint("_ActivateReinforce hasvehicle")--DEBUG
    mvars.reinforce_isEnabledVehicle=true
    this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,true)
    this._SetEnabledSoldier(this.REINFORCE_DRIVER_SOLDIER_NAME,true)
    vehicleId=GameObject.GetGameObjectId("TppVehicle2",this.REINFORCE_VEHICLE_NAME)
    driverId=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_DRIVER_SOLDIER_NAME)
    table.insert(reinforceSoldiers,driverId)
--    TppMarker.Enable(vehicleId,0,"moving","all",0,true,false)--tex DEBUG
--    TppMarker.Enable(driverId,0,"moving","all",0,true,false)--tex DEBUG
  end
  if hasHeli then
--    InfMenu.DebugPrint("_ActivateReinforce hasheli")--DEBUG
    local heliId=GameObject.GetGameObjectId(this.REINFORCE_HELI_NAME)
    --ORPHAN local heliRoute=this._GetHeliRoute(mvars.reinforce_cpId)
    local cp=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
    SendCommand(heliId,{id="RequestReinforce",toCp=cp})
    SendCommand(heliId,{id="SetCommandPost",cp=cp})--tex i think this is the cause of the heli ! sound on reinforce (because the cp is already at alert when it's assigned), don't know how to supress it, disabling or shifting order prevents reinforce from happening
    if Ivars.disableReinforceHeliPullOut:Is(1) then--tex
      SendCommand(heliId,{id="DisablePullOut"})
    end
    if mvars.reinforce_reinforceColoringType then
      TppHelicopter.SetEnemyColoring(mvars.reinforce_reinforceColoringType)
    end
  end
--  InfMenu.DebugPrint("_ActivateReinforce >> ApplyPowerSettingsForReinforce")--DEBUG
  TppRevenge.ApplyPowerSettingsForReinforce(reinforceSoldiers)
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
end
function this._DeactivateReinforce()
  if mvars.reinforce_isEnabledSoldiers then
    local leaveSoldiers=this._HasSoldier and Ivars.forceSuperReinforce:Is()>0--tex
    if not leaveSoldiers then--tex added check
      mvars.reinforce_isEnabledSoldiers=false
      for n,soldierName in ipairs(this.REINFORCE_SOLDIER_NAMES)do
        this._SetEnabledSoldier(soldierName,false)
      end
    end
  end
  if mvars.reinforce_isEnabledVehicle then
    mvars.reinforce_isEnabledVehicle=false
    this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,false)
    this._SetEnabledSoldier(this.REINFORCE_DRIVER_SOLDIER_NAME,false)
  end
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetNominateList"})
end
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="RequestLoadReinforce",func=this._OnRequestLoadReinforce},
      {msg="RequestAppearReinforce",func=this._OnRequestAppearReinforce},
      {msg="CancelReinforce",func=this._OnCancelReinforce}
    }
  }
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this._OnRequestLoadReinforce(reinforceCpId)--NMC game message "RequestLoadReinforce"
--  InfMenu.DebugPrint"_OnRequestLoadReinforce"--DEBUG
  local reinforceType=TppRevenge.SelectReinforceType()
  local reinforceColoringType
  if TppRevenge.IsUsingBlackSuperReinforce()then
    if reinforceType==this.REINFORCE_TYPE.HELI then
      reinforceColoringType=TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK
    else
      reinforceColoringType=Vehicle.class.DARK_GRAY
    end
  end
  this.LoadReinforceBlock(reinforceType,reinforceCpId,reinforceColoringType)

  --tex WORKAROUND just force this shit, in vanilla missions that use super reinforce this is called via "RequestAppearReinforce"/_OnRequestAppearReinforce via engine, however in free mode this doesnt seem fire consistantly suggesting there's some condition stopping it
  --it does however break normal vehicle reinforcements (so they're blocked in SelectReinforceType for free roam)
  local isFree=vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE
  if Ivars.forceReinforceRequest:Is(1) or isFree then
    if reinforceType==this.REINFORCE_TYPE.HELI then
--      InfMenu.DebugPrint"_OnRequestLoadReinforce forcing StartReinforce"--DEBUG
      this.StartReinforce(reinforceCpId)
    end
  end
end
function this._OnRequestAppearReinforce(cpId)
--  InfMenu.DebugPrint"_OnRequestAppearReinforce"--DEBUG
  this.StartReinforce(cpId)
end
function this._OnCancelReinforce(cpId)
--  InfMenu.DebugPrint"_OnCancelReinforce"--DEBUG
  if mvars.reinforce_activated then
    return
  end
  this.FinishReinforce(cpId)
end
return this

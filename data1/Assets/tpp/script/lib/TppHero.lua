-- DOBUILD: 1
local this={}
local StrCode32=Fox.StrCode32
local Code32Table=Tpp.Code32Table
local SendCommand=GameObject.SendCommand
local band=bit.band
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local IsTypeString=Tpp.IsTypeString
this.MISSION_ABORT={heroicPoint=-50,ogrePoint=0}
this.MISSION_CLEAR={
  S={heroicPoint=1600,ogrePoint=0},
  A={heroicPoint=800,ogrePoint=0},
  B={heroicPoint=400,ogrePoint=0},
  C={heroicPoint=200,ogrePoint=0},
  D={heroicPoint=100,ogrePoint=0},
  E={heroicPoint=50,ogrepoint=0}
}
this.ALL_MISSION_CLEAR={heroicPoint=1e4,ogrePoint=0}
this.ALL_MISSION_S_RANK_CLEAR={heroicPoint=5e4,ogrePoint=0}
this.QUEST_CLEAR={
  [TppDefine.QUEST_RANK.S]={heroicPoint=500,ogrePoint=0},
  [TppDefine.QUEST_RANK.A]={heroicPoint=400,ogrePoint=0},
  [TppDefine.QUEST_RANK.B]={heroicPoint=400,ogrePoint=0},
  [TppDefine.QUEST_RANK.C]={heroicPoint=300,ogrePoint=0},
  [TppDefine.QUEST_RANK.D]={heroicPoint=300,ogrePoint=0},
  [TppDefine.QUEST_RANK.E]={heroicPoint=200,ogrePoint=0},
  [TppDefine.QUEST_RANK.F]={heroicPoint=200,ogrePoint=0},
  [TppDefine.QUEST_RANK.G]={heroicPoint=100,ogrePoint=0},
  [TppDefine.QUEST_RANK.H]={heroicPoint=100,ogrePoint=0},
  [TppDefine.QUEST_RANK.I]={heroicPoint=0,ogrePoint=0}
}
this.QUEST_ALL_CLEAR={heroicPoint=3e4,ogrePoint=0}
this.MINE_QUEST_ALL_CLEAR={heroicPoint=5e3,ogrePoint=-5e3}
this.ENEMY_HOLD_UP={heroicPoint=5,ogrePoint=0}
this.ENEMY_INTERROGATE={heroicPoint=5,ogrePoint=0}
this.PLAYER_ON_INJURY={heroicPoint=-10,ogrePoint=0}
this.PLAYER_DEAD={heroicPoint=-30,ogrePoint=0}
this.STARTED_COMBAT={heroicPoint=-10,ogrePoint=0}
this.FULTON_DYING_ENEMY={heroicPoint=30,ogrePoint=-30}
this.FULTON_HOSTAGE={heroicPoint=60,ogrePoint=-60}
this.FULTON_PARASITE={heroicPoint=30,ogrePoint=-30}
this.ON_HELI_DYING_ENEMY={heroicPoint=60,ogrePoint=-60}
this.ON_HELI_HOSTAGE={heroicPoint=120,ogrePoint=-120}
this.ON_HELI_LIQUID={heroicPoint=240,ogrePoint=-240}
this.FIRE_KILL_SOLDIER={heroicPoint=0,ogrePoint=120}
this.FIRE_KILL_SOLDIER_FOB_SNEAK={heroicPoint="HEROIC_POINT_FIRE_KILL_SOLDIER_FOB_SNEAK",ogrePoint="OGRE_POINT_FIRE_KILL_SOLDIER_FOB_SNEAK"}
this.KILL_SOLDIER={heroicPoint=0,ogrePoint=60}
this.KILL_SOLDIER_FOB_SNEAK={heroicPoint="HEROIC_POINT_KILL_SOLDIER_FOB_SNEAK",ogrePoint="OGRE_POINT_KILL_SOLDIER_FOB_SNEAK"}
this.KILL_HOSTAGE={heroicPoint=-60,ogrePoint=100}
this.FIRE_KILL_HOSTAGE={heroicPoint=-90,ogrePoint=200}
this.FIRE_KILL_DD_HOSTAGE={heroicPoint=-90,ogrePoint=180}
this.FIRE_KILL_DD_SOLDIER={heroicPoint=-90,ogrePoint=180}
this.KILL_DD_SOLDIER={heroicPoint=-60,ogrePoint=180}
this.KILL_DD_HOSTAGE={heroicPoint=-60,ogrePoint=90}
this.DEAD_HOSTAGE={heroicPoint=-30,ogrePoint=0}
this.DEAD_DD_SOLDIER={heroicPoint=-30,ogrePoint=0}
this.DYING_SOLDIER={heroicPoint=0,ogrePoint=30}
this.RECOVERED_SOLDIER={heroicPoint=0,ogrePoint=-30}
this.VEHICLE_BROKEN={
  [Vehicle.type.EASTERN_LIGHT_VEHICLE]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.EASTERN_TRUCK]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.WESTERN_TRUCK]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.EASTERN_TRACKED_TANK]={heroicPoint=0,ogrePoint=0},
  [Vehicle.type.WESTERN_TRACKED_TANK]={heroicPoint=0,ogrePoint=0}
}
this.BREAK_GIMMICK={
  [TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]={heroicPoint=0,ogrePoint=0},
  [TppGameObject.GAME_OBJECT_TYPE_MORTAR]={heroicPoint=0,ogrePoint=0},
  [TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]={heroicPoint=0,ogrePoint=0}
}
this.BREAK_GIMMICK_BY_TYPE={
  [TppGimmick.GIMMICK_TYPE.ANTN]={heroicPoint=0,ogrePoint=0},
  [TppGimmick.GIMMICK_TYPE.MCHN]={heroicPoint=0,ogrePoint=0},
  [TppGimmick.GIMMICK_TYPE.CMMN]={heroicPoint=0,ogrePoint=0},
  [TppGimmick.GIMMICK_TYPE.GNRT]={heroicPoint=0,ogrePoint=0},
  [TppGimmick.GIMMICK_TYPE.SWTC]={heroicPoint=0,ogrePoint=0},
  [TppGimmick.GIMMICK_TYPE.AACR]={heroicPoint=0,ogrePoint=0}
}
this.SUPPORT_HELI_LOST_CONTROLE={heroicPoint=-60,ogrePoint=150}
this.BREAK_SUPPORT_HELI={heroicPoint=-30,ogrePoint=0}
this.ENEMY_HELI_LOST_CONTROLE={heroicPoint=0,ogrePoint=120}
this.ON_ANNIHILATE_BASE={heroicPoint=300,ogrePoint=0}
this.ON_ANNIHILATE_OUTER_BASE={heroicPoint=30,ogrePoint=0}
this.CONSTRUCT_FIRST_FOB={heroicPoint=1e3,ogrePoint=0}
this.CONSTRUCT_SECOND_FOB={heroicPoint=2e3,ogrePoint=0}
this.CONSTRUCT_THIRD_FOB={heroicPoint=3e3,ogrePoint=0}
this.CONSTRUCT_FOURTH_FOB={heroicPoint=4e3,ogrePoint=0}
this.HORSE_RIDED={heroicPoint=-5,ogrePoint=0}
this.BREAK_MINE={heroicPoint=30,ogrePoint=0}
this.BREAK_DECOY={heroicPoint=5,ogrePoint=0}
this.PICK_UP_MINE={heroicPoint=30,ogrePoint=0}
this.BREAK_SECURITY_CAMERA={heroicPoint=0,ogrePoint=0}
this.BREAK_SECURITY_UAV={heroicPoint=0,ogrePoint=0}
this.DYING_PARASITE={heroicPoint=60,ogrePoint=0}
this.NuclearAbolition={heroicPoint=5e4,ogrePoint=-5e5}
this.STARTED_COMBAT_ON_FOB={heroicPoint="HEROIC_POINT_STARTED_COMBAT_ON_FOB",ogrePoint=0}
this.STARTED_COMBAT_ON_FOB_HERO={heroicPoint="HEROIC_POINT_STARTED_COMBAT_ON_FOB_HERO",ogrePoint=0}
this.DISCOVER_ATTACKER={heroicPoint="HEROIC_POINT_DISCOVER_ATTACKER",ogrePoint=0}
this.OFFENCE_WIN_ON_FOB={heroicPoint="HEROIC_POINT_OFFENSE_WIN",ogrePoint=0}
this.OFFENCE_LOSE_ON_FOB={heroicPoint="HEROIC_POINT_OFFENSE_LOSE",ogrePoint=0}
this.DEFENCE_WIN_ELIMINATE={heroicPoint="HEROIC_POINT_DEFENSE_WIN_ELIMINATE",ogrePoint=0}
this.DEFENCE_WIN_ABORT={heroicPoint="HEROIC_POINT_DEFENSE_WIN_ABORT",ogrePoint=0}
this.DEFENCE_LOSE={heroicPoint="HEROIC_POINT_DEFENSE_LOSE",ogrePoint=0}
this.DEFENCE_FULTON_OFFENCE={heroicPoint="HEROIC_POINT_FULTONED_PLAYER",ogrePoint="OGRE_POINT_FULTONED_PLAYER"}
this.OFFENCE_FULTONED_BY_DEFENCE={heroicPoint="HEROIC_POINT_FULTONED",ogrePoint=0}
this.RETAKE_STAFF_FROM_FOB={heroicPoint="HEROIC_POINT_RETAKE_STAFF_FROM_FOB",ogrePoint=0}
this.KILLED_PLAYER={heroicPoint=0,ogrePoint="OGRE_POINT_KILLED_PLAYER"}
this.OFFENCE_WIN_ON_FOB_FOR_FRIEND={heroicPoint="HEROIC_POINT_OFFENSE_WIN_ON_FOB_FOR_FRIEND",ogrePoint=0}
this.DEFENCE_WIN_FOR_FRIEND={heroicPoint="HEROIC_POINT_DEFENSE_WIN_FOR_FRIEND",ogrePoint=0}
this.BREAK_PTW_MACHINEGUN={heroicPoint="HEROIC_POINT_BREAK_PTW_MACHINEGUN",ogrePoint="OGRE_POINT_BREAK_PTW_MACHINEGUN"}
this.BREAK_PTW_MORTAR={heroicPoint="HEROIC_POINT_BREAK_PTW_MORTAR",ogrePoint="OGRE_POINT_BREAK_PTW_MORTAR"}
this.BREAK_PTW_ANTIAIR={heroicPoint="HEROIC_POINT_BREAK_PTW_ANTIAIR",ogrePoint="OGRE_POINT_BREAK_PTW_ANTIAIR"}
this.FULTON_SUPPORTER_CONTAINER={heroicPoint="HEROIC_POINT_FULTON_CONTAINER",ogrePoint="OGRE_POINT_FULTON_CONTAINER"}
this.NOTICE_CRIME={heroicPoint="HEROIC_POINT_NOTICE_CRIME",ogrePoint=0}
this.KILLED_DDS={heroicPoint="HEROIC_POINT_KILLED_DDS",ogrePoint="OGRE_POINT_KILLED_DDS"}
this.FOB_ABORT_BY_MENU={heroicPoint="HEROIC_POINT_FOB_ABORT_BY_MENU",ogrePoint=0}
function this.IsHero()
  return gvars.isHero
end
function this.AddTargetLifesavingHeroicPoint(isChild,recoveredByHeli)
  if recoveredByHeli then
    if isChild then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=240,subOgrePoint=240}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
    end
  else
    if isChild then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=60,subOgrePoint=60}
    end
  end
end
function this.OnFultonSoldier(gameId,recoveredByHeli)
  local stateFlag=SendCommand(gameId,{id="GetStateFlag"})
  local isZombieOrMsf=SendCommand(gameId,{id="IsZombieOrMsf"})
  local isChild=SendCommand(gameId,{id="IsChild"})
  if isZombieOrMsf then
    if recoveredByHeli then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=60,subOgrePoint=60}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=30,subOgrePoint=30}
    end
  elseif isChild then
    this.AddTargetLifesavingHeroicPoint(isChild,recoveredByHeli)
  else
    if band(stateFlag,StateFlag.DYING_LIFE)~=0 then
      if recoveredByHeli then
        this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_DYING_ENEMY)
      else
        if((not TppMission.IsFOBMission(vars.missionCode))or TppServerManager.FobIsSneak())then
          this.SetAndAnnounceHeroicOgrePoint(this.FULTON_DYING_ENEMY)
        else
          this.SetAndAnnounceHeroicOgrePoint{heroicPoint="HEROIC_POINT_FULTONED_DYING_STAFF",ogrePoint="OGRE_POINT_FULTONED_DYING_STAFF"}
        end
      end
    else
      this.SetAndAnnounceHeroicOgrePoint(this.RECOVERED_SOLDIER)
    end
  end
end
function this.OnFultonHostage(gameId,recoveredByHeli)
  local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  local isChild=SendCommand(gameId,{id="IsChild"})
  if lifeStatus~=TppEnemy.LIFE_STATUS.DEAD then
    local stateFlag=SendCommand(gameId,{id="GetStateFlag"})
    if recoveredByHeli then
      if TppEnemy.IsRescueTarget(gameId)then
        this.AddTargetLifesavingHeroicPoint(isChild,recoveredByHeli)
      else
        this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_HOSTAGE)
      end
    else
      if TppEnemy.IsRescueTarget(gameId)then
        this.AddTargetLifesavingHeroicPoint(isChild,recoveredByHeli)
      else
        this.SetAndAnnounceHeroicOgrePoint(this.FULTON_HOSTAGE)
      end
    end
  end
end
function this.OnFultonEli(n,e)
  if e then
    TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=240,subOgrePoint=240}
  else
    TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
  end
end
function this.GetFobServerParameter(_name)
  local parameter,name
  if IsTypeString(_name)then
    name=_name
    parameter=TppNetworkUtil.GetFobServerParameterByName(_name)
  else
    parameter=_name
  end
  return parameter,name
end
function this.SetHeroicPoint(n)
  local e,n=this.GetFobServerParameter(n)
  if e<0 then
    TppMotherBaseManagement.SubHeroicPoint{heroicPoint=-e}
  elseif e>0 then
    TppMotherBaseManagement.AddHeroicPoint{heroicPoint=e}
  end
  return e
end
function this.SetOgrePoint(ogrePoint)
  local amount,n=this.GetFobServerParameter(ogrePoint)
  if amount<0 then
    TppMotherBaseManagement.SubOgrePoint{ogrePoint=-amount}
  elseif amount>0 then
    TppMotherBaseManagement.AddOgrePoint{ogrePoint=amount}
  end
  svars.her_missionOgrePoint=svars.her_missionOgrePoint+amount
end
function this.GetMissionOgrePoint()
  return svars.her_missionOgrePoint
end
function this.AnnounceHeroicPoint(pointTable,downLangId,upLangId)
  local subLangId=downLangId or"heroicPointDown"
  local addLangId=upLangId or"heroicPointUp"
  if vars.missionCode>=6e4 then
    return
  end
  local amount=this.GetFobServerParameter(pointTable.heroicPoint)
  if amount<0 then
    TppUI.ShowAnnounceLog(subLangId,-amount)
  elseif amount>0 then
    TppUI.ShowAnnounceLog(addLangId,amount)
  end
end
function this.SetAndAnnounceHeroicOgrePoint(pointTable,downLangId,upLangId)
  if TppMission.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return
  end
  this.SetHeroicPoint(pointTable.heroicPoint)
  this.AnnounceHeroicPoint(pointTable,downLangId,upLangId)
  this.SetOgrePoint(pointTable.ogrePoint)
end
function this.AnnounceMissionAbort()
  this.AnnounceHeroicPoint(this.MISSION_ABORT)
end
function this.MissionAbort()
  this.SetHeroicPoint(this.MISSION_ABORT.heroicPoint)
end
function this.MissionClear(n)
  local n=this.MISSION_CLEAR[TppDefine.MISSION_CLEAR_RANK_LIST[n]].heroicPoint
  this.SetHeroicPoint(n)
  svars.her_missionHeroPoint=n
end
function this.SetFirstMissionClearHeroPoint()
  if TppStory.IsMissionCleard(vars.missionCode)==false then
    mvars.her_reserveFirstMissionClear=true
  end
end
function this.AnnounceFirstMissionClearHeroPoint()
  if mvars.her_reserveFirstMissionClear then
  end
end
function this.AnnounceVehicleBroken(o)
  local n=SendCommand(o,{id="GetVehicleType"})
  local n=this.VEHICLE_BROKEN[n]
  if n then
    PlayRecord.RegistPlayRecord"VEHICLE_DESTROY"
    Tpp.IncrementPlayData"totalBreakVehicleCount"
    this.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function this.AnnounceBreakGimmick(n,i,i,o)
  if not Tpp.IsLocalPlayer(o)then
    return
  end
  local n=GetTypeIndex(n)
  local n=this.BREAK_GIMMICK[n]
  if n then
    Tpp.IncrementPlayData"totalBreakPlacedGimmickCount"
    this.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function this.AnnounceBreakGimmickByGimmickType(n)
  local n=this.BREAK_GIMMICK_BY_TYPE[n]
  if n then
    this.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function this.OnHelicopterLostControl(gameId,attackerId)
  local gameObjectType=GetTypeIndex(gameId)
  local isLocalPlayer=Tpp.IsLocalPlayer(attackerId)
  if gameObjectType==TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    if isLocalPlayer then
      this.SetAndAnnounceHeroicOgrePoint(this.SUPPORT_HELI_LOST_CONTROLE,"destroyed_support_heli")
    else
      this.SetAndAnnounceHeroicOgrePoint(this.BREAK_SUPPORT_HELI,"destroyed_support_heli")
    end
  elseif isLocalPlayer then
    PlayRecord.RegistPlayRecord"HERI_DESTROY"
    Tpp.IncrementPlayData"totalHelicopterDestoryCount"
    this.SetAndAnnounceHeroicOgrePoint(this.ENEMY_HELI_LOST_CONTROLE)
  end
end
function this.SetAndAnnounceHeroicOgrePointForAnnihilateCp(i,o)
  local n
  if o then
    n="outpost_neutralize"else
    n="guradpost_neutralize"end
  this.SetAndAnnounceHeroicOgrePoint(i,nil,n)
end
function this.SetAndAnnounceHeroicOgrePointForQuestClear(n)
  local n=this.QUEST_CLEAR[n]
  if n then
    this.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function this.HorseRided(n)
  if not Tpp.IsLocalPlayer(n)then
    return
  end
  this.SetAndAnnounceHeroicOgrePoint(this.HORSE_RIDED)
end
function this.OnBreakPlaced(o,n,t,i)
  if vars.missionCode==50050 then
    return
  end
  if not Tpp.IsLocalPlayer(o)then
    return
  end
  if i==1 then
    return
  end
  if TppPlayer.IsDecoy(n)then
    this.SetAndAnnounceHeroicOgrePoint(this.BREAK_DECOY,nil,"disposal_decoy")
  end
  if TppPlayer.IsMine(n)then
    Tpp.IncrementPlayData"totalMineRemoveCount"
    this.SetAndAnnounceHeroicOgrePoint(this.BREAK_MINE,nil,"disposal_mine")
  end
end
function this.OnPickUpPlaced(i,o,t,n)
  if vars.missionCode==50050 then
    return
  end
  if not Tpp.IsLocalPlayer(i)then
    return
  end
  if n==1 then
    return
  end
  if TppPlayer.IsMine(o)then
    Tpp.IncrementPlayData"totalMineRemoveCount"
    this.SetAndAnnounceHeroicOgrePoint(this.PICK_UP_MINE,nil,"disposal_mine")
  end
end
function this._RideOnHeli(gameId)
  if Tpp.IsSoldier(gameId)then
    local stateFlag=SendCommand(gameId,{id="GetStateFlag"})
    if bit.band(stateFlag,StateFlag.DYING_LIFE)~=0 then
      this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_DYING_ENEMY)
    end
  elseif Tpp.IsHostage(gameId)then
    local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
    if lifeStatus~=TppEnemy.LIFE_STATUS.DEAD then
      if TppEnemy.IsRescueTarget(gameId)then
        this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_RESCUE_TARGET)
      else
        this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_HOSTAGE)
      end
    end
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Holdup",func=function(o)
        if o then
          if not SendCommand(o,{id="IsDoneHoldup"})then
            this.SetAndAnnounceHeroicOgrePoint(this.ENEMY_HOLD_UP)
            SendCommand(o,{id="SetDoneHoldup"})
          end
        end
      end},
      {msg="InterrogateUpHero",func=function()
        this.SetAndAnnounceHeroicOgrePoint(this.ENEMY_INTERROGATE)
      end},
      {msg="ChangePhase",func=function(cpId,phase)
        if(vars.missionCode==50050)and(not TppServerManager.FobIsSneak())then
          return
        end
        if(phase==TppGameObject.PHASE_ALERT)and Tpp.IsCommandPost(cpId)then
          if not Ivars.phaseUpdate:Is(1) then --and Ivars.minPhase:Is()>TppGameObject.PHASE_CAUTION) then--tex added check to filter out phasemod from heroicpoint TODO, cant get this to work right with specfic setting, so disable outright if phasemod
          this.SetAndAnnounceHeroicOgrePoint(this.STARTED_COMBAT)
          end
        end
      end},
      {msg="Dead",func=function(gameId,attackerId,arg2,deadMessageFlag)
        if attackerId and Tpp.IsLocalPlayer(attackerId)then
          if Tpp.IsHostage(gameId)then
            if SendCommand(gameId,{id="IsDD"})and(not TppMission.IsFOBMission(vars.missionCode))then
              if(deadMessageFlag~=nil)and(band(deadMessageFlag,DeadMessageFlag.FIRE)~=0)then
                this.SetAndAnnounceHeroicOgrePoint(this.FIRE_KILL_DD_HOSTAGE,"mbstaff_died")
              else
                this.SetAndAnnounceHeroicOgrePoint(this.KILL_DD_HOSTAGE,"mbstaff_died")
              end
            else
              if not SendCommand(gameId,{id="IsChild"})then
                if(deadMessageFlag~=nil)and(band(deadMessageFlag,DeadMessageFlag.FIRE)~=0)then
                  this.SetAndAnnounceHeroicOgrePoint(this.FIRE_KILL_HOSTAGE,"hostage_died")
                else
                  this.SetAndAnnounceHeroicOgrePoint(this.KILL_HOSTAGE,"hostage_died")
                end
              end
            end
          elseif Tpp.IsSoldier(gameId)then
            if(deadMessageFlag==nil)then--RETAILPATCH 1070 check added
              Tpp.IncrementPlayData"totalKillCount"
            else--RETAILPATCH 1070>
              if(band(deadMessageFlag,DeadMessageFlag.NOT_DAMAGE_DEAD)==0)and(band(deadMessageFlag,DeadMessageFlag.INDIRECTLY_TARGET)==0)then
                Tpp.IncrementPlayData"totalKillCount"
              end
            end--<
          
            local soldierType=TppEnemy.GetSoldierType(gameId)
            if(SendCommand(gameId,{id="IsDD"})) and not (vars.missionCode==30050 and Ivars.mbNonStaff:Is(1))then--tex added nonstaff
              if(deadMessageFlag~=nil)and(band(deadMessageFlag,DeadMessageFlag.FIRE)~=0)then
                this.SetAndAnnounceHeroicOgrePoint(this.FIRE_KILL_DD_SOLDIER,"mbstaff_died")
              else
                this.SetAndAnnounceHeroicOgrePoint(this.KILL_DD_SOLDIER,"mbstaff_died")
              end
            else
              if(soldierType~=EnemyType.TYPE_CHILD)then
                local checkDeadFlag=DeadMessageFlag.FIRE
                if DeadMessageFlag.FIRE_OR_DYING~=nil then
                  checkDeadFlag=DeadMessageFlag.FIRE_OR_DYING
                end
                local isFobSneak=TppMission.IsFOBMission(vars.missionCode)and TppServerManager.FobIsSneak()
                local stateFlag=SendCommand(gameId,{id="GetStateFlag"})--RETAILPATCH 1070
                if(deadMessageFlag~=nil)and(band(deadMessageFlag,checkDeadFlag)~=0)then
                  if not isFobSneak then
                    if not (vars.missionCode==30050 and Ivars.mbNonStaff:Is(1))then--tex added nonstaff
                    this.SetAndAnnounceHeroicOgrePoint(this.FIRE_KILL_SOLDIER)
                    end
                  else
                    if band(stateFlag,StateFlag.ZOMBIE)~=StateFlag.ZOMBIE then--RETAILPATCH 1070 check added
                      this.SetAndAnnounceHeroicOgrePoint(this.FIRE_KILL_SOLDIER_FOB_SNEAK)
                    end
                  end
                else
                  if not isFobSneak then
                    if (vars.missionCode==30050 and Ivars.mbNonStaff:Is(1))then--tex added nonstaff
                    this.SetAndAnnounceHeroicOgrePoint(this.KILL_SOLDIER)
                    end
                  else
                    if band(stateFlag,StateFlag.ZOMBIE)~=StateFlag.ZOMBIE then--RETAILPATCH 1070 check added
                      this.SetAndAnnounceHeroicOgrePoint(this.KILL_SOLDIER_FOB_SNEAK)
                    end
                  end
                end--if deadmessageflag
              end--not child
            end--if dd or not
          end--if issoldier
          if Tpp.IsAnimal(gameId)then
            if(deadMessageFlag~=nil)and(band(deadMessageFlag,DeadMessageFlag.FIRE)~=0)then
              this.SetAndAnnounceHeroicOgrePoint{heroicPoint=0,ogrePoint=40}
            else
              this.SetAndAnnounceHeroicOgrePoint{heroicPoint=0,ogrePoint=20}
            end
          end
        else
          if Tpp.IsHostage(gameId)then
            if SendCommand(gameId,{id="IsDD"})and(not TppMission.IsFOBMission(vars.missionCode))then
              this.SetAndAnnounceHeroicOgrePoint(this.DEAD_DD_SOLDIER,"mbstaff_died")
            else
              if not SendCommand(gameId,{id="IsChild"})then
                this.SetAndAnnounceHeroicOgrePoint(this.DEAD_HOSTAGE,"hostage_died")
              end
            end
          elseif Tpp.IsSoldier(gameId)then
            if(deadMessageFlag~=nil)and(band(deadMessageFlag,DeadMessageFlag.FROM_PLAYER_ORDER)~=0)then--RETAILPATCH 1070
              Tpp.IncrementPlayData"totalKillCount"
            end--<
            if TppMission.IsFOBMission(vars.missionCode)then
            else
              if(SendCommand(gameId,{id="IsDD"}))and not (vars.missionCode==30050 and Ivars.mbNonStaff:Is(1))then--tex added nonstaff
                this.SetAndAnnounceHeroicOgrePoint(this.DEAD_DD_SOLDIER,"mbstaff_died")
              end
            end
          end
        end
      end},
      {msg="Dying",func=function(soldierId,i)
        if Tpp.IsSoldier(soldierId)then
          if not SendCommand(soldierId,{id="IsDD"}) and not (vars.missionCode==30050 and Ivars.mbNonStaff:Is(1))then--tex added nonstaff
            this.SetAndAnnounceHeroicOgrePoint(this.DYING_SOLDIER)
          end
        elseif Tpp.IsParasiteSquad(soldierId)then
          this.SetAndAnnounceHeroicOgrePoint(this.DYING_PARASITE,"destroyed_skull","destroyed_skull")
        elseif Tpp.IsBossQuiet(soldierId)then
          local n=SendCommand({type="TppBossQuiet2"},{id="GetQuietType"})
          if n==Fox.StrCode32"Cam"then
            this.SetAndAnnounceHeroicOgrePoint(this.DYING_PARASITE,"destroyed_skull","destroyed_skull")
          end
        end
      end},
      {msg="BreakGimmick",func=this.AnnounceBreakGimmick},
      {msg="VehicleBroken",func=function(vehicleId,state)
        if state==StrCode32"Start"then
          this.AnnounceVehicleBroken(vehicleId)
        end
      end},
      {msg="LostControl",func=function(gameId,state,attackerId)
        if state==StrCode32"Start"then
          this.OnHelicopterLostControl(gameId,attackerId)
        end
      end},
      {msg="CommandPostAnnihilated",func=function(n,o,i)
        local o=false
        if mvars.ene_cpList then
          local e=mvars.ene_cpList[n]o=TppTrophy.DOMINATION_TARGET_CP_NAME_LIST[e]
        end
        if i==0 then
          if TppEnemy.IsBaseCp(n)then
            if o then
              PlayRecord.RegistPlayRecord"BASE_SUPPRESSION"
              this.SetAndAnnounceHeroicOgrePointForAnnihilateCp(this.ON_ANNIHILATE_BASE,true)
              TppTrophy.Unlock(18)
              Tpp.IncrementPlayData"totalAnnihilateBaseCount"
              TppChallengeTask.RequestUpdate"ENEMY_BASE"--RETAILPATCH 1070
              end
            TppEmblem.AcquireOnCommandPostAnnihilated(n)
          elseif TppEnemy.IsOuterBaseCp(n)then
            if o then
              this.SetAndAnnounceHeroicOgrePointForAnnihilateCp(this.ON_ANNIHILATE_OUTER_BASE,false)
              TppChallengeTask.RequestUpdate"ENEMY_BASE"--RETAILPATCH 1070
              Tpp.IncrementPlayData"totalAnnihilateOutPostCount"
              TppTrophy.Unlock(18)
            end
            TppEmblem.AcquireOnCommandPostAnnihilated(n)
          end
        end
        if TppCommandPost2.SetCpDominated then
          local e=TppLocation.GetLocationName()
          if e=="afgh"or e=="mafr"then
            local n=mvars.ene_cpList[n]
            local i=TppCommandPost2.SetCpDominated{cpName=n,type=e}
            local n=TppCommandPost2.GetDominatedCpCount{type=e}
            local o=TppTrophy.DOMINATION_TARGET_CP_COUNT[e]
            if i then
            end
            if n==o then
              local n={afgh=19,mafr=20}
              TppTrophy.Unlock(n[e])
            end
          end
        end
      end}},
    Player={
      {msg="OnInjury",func=function()
        this.SetAndAnnounceHeroicOgrePoint(this.PLAYER_ON_INJURY)
      end},
      {msg="DogBiteConnect",func=this.HorseRided},
      {msg="ZombBiteConnect",func=this.HorseRided},
      {msg="OnPickUpPlaced",func=this.OnPickUpPlaced},
      {msg="LiquidPutInHeli",func=function(n)
        this.SetAndAnnounceHeroicOgrePoint(this.ON_HELI_LIQUID)
      end}},
    Placed={{msg="OnBreakPlaced",func=this.OnBreakPlaced}}}
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.DeclareSVars()
  return{
    {name="her_missionOgrePoint",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},
    {name="her_missionHeroPoint",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.UpdateHero()
  local n=gvars.isHero
  local e=TppMotherBaseManagement.GetHeroicPoint()
  if(e>=vars.mbmHeroThreshold)then
    gvars.isHero=true
  end
  if(e<vars.mbmNotHeroThreshold)then
    gvars.isHero=false
  end
  if(TppStory.GetCurrentStorySequence()<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO)then
    gvars.isHero=false
  end
  if(not n)and gvars.isHero then
    TppUI.ShowAnnounceLog"get_hero"
    end
  if n and(not gvars.isHero)then
    TppUI.ShowAnnounceLog"lost_hero"
    end
  if gvars.isHero then
    TppTrophy.Unlock(46,3e4)
    local e={"word80","word81","word82","word83","word84","word85","word86","word88","word89","front40","front41"}
    for n,e in ipairs(e)do
      TppEmblem.Add(e,true)
    end
  end
end
return this

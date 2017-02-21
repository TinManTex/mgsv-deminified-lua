-- DOBUILD: 1
local this={}
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local StrCode32=Fox.StrCode32
local TimerStart=GkEventTimerManager.Start
local TimerStop=GkEventTimerManager.Stop
local GetTypeIndex=GameObject.GetTypeIndex
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndexWithTypeName=GameObject.GetTypeIndexWithTypeName
--ORPHAN local n=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
--ORPHAN local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
this.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
this.MISSION_CLEAR_CAMERA_DELAY_TIME=0
this.PLAYER_FALL_DEAD_DELAY_TIME=.2
this.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}
this.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}
this.CageRandomTableG1={{1,20},{0,80}}
this.CageRandomTableG2={{2,15},{1,20},{0,65}}
this.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}
this.RareLevelList={"N","NR","R","SR","SSR"}
function this.RegisterCallbacks(callBacks)
  if IsTypeFunc(callBacks.OnFultonIconDying)then
    mvars.ply_OnFultonIconDying=callBacks.OnFultonIconDying
  end
end
function this.SetStartStatus(status)
  if(status>TppDefine.INITIAL_PLAYER_STATE.MIN)and(status<TppDefine.INITIAL_PLAYER_STATE.MAX)then
    gvars.ply_initialPlayerState=status
  end
end
function this.SetStartStatusRideOnHelicopter()
  this.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
  this.ResetInitialPosition()
  this.ResetMissionStartPosition()
end
function this.ResetDisableAction()
  vars.playerDisableActionFlag=PlayerDisableAction.NONE
end
function this.GetPosition()
  return{vars.playerPosX,vars.playerPosY,vars.playerPosZ}
end
function this.GetRotation()
  return vars.playerRotY
end
function this.Warp(info)
  if not IsTypeTable(info)then
    return
  end
  local pos=info.pos
  if not IsTypeTable(pos)or(#pos~=3)then
    return
  end
  local rotY=foxmath.NormalizeRadian(foxmath.DegreeToRadian(info.rotY or 0))
  local playerId
  if info.fobRespawn==true then
    playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
  else
    playerId={type="TppPlayer2",index=0}
  end
  local command={id="WarpAndWaitBlock",pos=pos,rotY=rotY}
  GameObject.SendCommand(playerId,command)
end
function this.SetForceFultonPercent(gameId,percentage)
  if not Tpp.IsTypeNumber(gameId)then
    return
  end
  if not Tpp.IsTypeNumber(percentage)then
    return
  end
  if(gameId<0)or(gameId>=NULL_ID)then
    return
  end
  if(percentage<0)or(percentage>100)then
    return
  end
  mvars.ply_forceFultonPercent=mvars.ply_forceFultonPercent or{}
  mvars.ply_forceFultonPercent[gameId]=percentage
end
function this.ForceChangePlayerToSnake(basic)
  if Ivars.useSoldierForDemos:Is(1) then--tex catch more cases the isSnakeOnly in demo didn't catch
    if not TppMission.IsFOBMission(vars.missionCode) then--tex 50050 sequence calls this a couple of times, I can't reason it out as being a meaningful change but I don't want to change default behaviour
      if not (vars.missionCode==10240) then-- and DemoDaemon.IsDemoPlaying()) then--tex demo not actually playing at that point aparently --tex PATCHUP: stop stupid sexy snake player body/snake head for shining lights funeral scene
        return
    end
  end
  end--
  vars.playerType=PlayerType.SNAKE
  if basic then
    vars.playerPartsType=PlayerPartsType.NORMAL
    vars.playerCamoType=PlayerCamoType.OLIVEDRAB
    vars.playerFaceEquipId=0
  else
    vars.playerPartsType=vars.sortiePrepPlayerSnakePartsType
    vars.playerCamoType=vars.sortiePrepPlayerSnakeCamoType
    vars.playerFaceEquipId=vars.sortiePrepPlayerSnakeFaceEquipId
  end
  Player.SetItemLevel(TppEquip.EQP_SUIT,vars.sortiePrepPlayerSnakeSuitLevel)
end
function this.CheckRotationSetting(a)
  if not IsTypeTable(a)then
    return
  end
  local e=mvars
  e.ply_checkDirectionList={}
  e.ply_checkRotationResult={}
  local function n(a,t,e)
    if e>=-180 and e<180 then
      a[t]=e
    end
  end
  for t,a in pairs(a)do
    if IsTypeFunc(a.func)then
      e.ply_checkDirectionList[t]={}
      e.ply_checkDirectionList[t].func=a.func
      local o=a.directionX or 0
      local i=a.directionY or 0
      local r=a.directionRangeX or 0
      local a=a.directionRangeY or 0
      n(e.ply_checkDirectionList[t],"directionX",o)
      n(e.ply_checkDirectionList[t],"directionY",i)
      n(e.ply_checkDirectionList[t],"directionRangeX",r)
      n(e.ply_checkDirectionList[t],"directionRangeY",a)
    else
      return
    end
  end
end
function this.CheckRotation()
  local mvars=mvars
  if mvars.ply_checkDirectionList==nil then
    return
  end
  for n,t in pairs(mvars.ply_checkDirectionList)do
    local e=this._CheckRotation(t.directionX,t.directionRangeX,t.directionY,t.directionRangeY,n)
    if e~=mvars.ply_checkRotationResult[n]then
      mvars.ply_checkRotationResult[n]=e
      mvars.ply_checkDirectionList[n].func(e)
    end
  end
end
function this.IsDeliveryWarping()
  if mvars.ply_deliveryWarpState then
    return true
  else
    return false
  end
end
function this.GetStationUniqueId(e)
  if not IsTypeString(e)then
    return
  end
  local e="col_stat_"..e
  return TppCollection.GetUniqueIdByLocatorName(e)
end
function this.SetMissionStartPositionToCurrentPosition()
  gvars.ply_useMissionStartPos=true
  gvars.ply_missionStartPos[0]=vars.playerPosX
  gvars.ply_missionStartPos[1]=vars.playerPosY+.5
  gvars.ply_missionStartPos[2]=vars.playerPosZ
  gvars.ply_missionStartRot=vars.playerRotY
  gvars.mis_orderBoxName=0
  this.SetInitialPositionFromMissionStartPosition()
end
function this.SetNoOrderBoxMissionStartPosition(pos,rotY)
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=pos[1]
  gvars.ply_missionStartPosForNoOrderBox[1]=pos[2]
  gvars.ply_missionStartPosForNoOrderBox[2]=pos[3]
  gvars.ply_missionStartRotForNoOrderBox=rotY
end
function this.SetNoOrderBoxMissionStartPositionToCurrentPosition()
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=vars.playerPosX
  gvars.ply_missionStartPosForNoOrderBox[1]=vars.playerPosY+.5
  gvars.ply_missionStartPosForNoOrderBox[2]=vars.playerPosZ
  gvars.ply_missionStartRotForNoOrderBox=vars.playerRotY
end
function this.SetMissionStartPosition(pos,rotY)
  gvars.ply_useMissionStartPos=true
  gvars.ply_missionStartPos[0]=pos[1]
  gvars.ply_missionStartPos[1]=pos[2]
  gvars.ply_missionStartPos[2]=pos[3]
  gvars.ply_missionStartRot=rotY
end
function this.ResetMissionStartPosition()
  gvars.ply_useMissionStartPos=false
  gvars.ply_missionStartPos[0]=0
  gvars.ply_missionStartPos[1]=0
  gvars.ply_missionStartPos[2]=0
  gvars.ply_missionStartRot=0
end
function this.ResetNoOrderBoxMissionStartPosition()
  gvars.ply_useMissionStartPosForNoOrderBox=false
  gvars.ply_missionStartPosForNoOrderBox[0]=0
  gvars.ply_missionStartPosForNoOrderBox[1]=0
  gvars.ply_missionStartPosForNoOrderBox[2]=0
  gvars.ply_missionStartRotForNoOrderBox=0
end
function this.SetMissionStartPositionFromNoOrderBoxPosition()
  if gvars.ply_useMissionStartPosForNoOrderBox then
    gvars.ply_useMissionStartPos=true
    gvars.ply_missionStartPos[0]=gvars.ply_missionStartPosForNoOrderBox[0]
    gvars.ply_missionStartPos[1]=gvars.ply_missionStartPosForNoOrderBox[1]
    gvars.ply_missionStartPos[2]=gvars.ply_missionStartPosForNoOrderBox[2]
    gvars.ply_missionStartRot=gvars.ply_missionStartRotForNoOrderBox
    this.ResetNoOrderBoxMissionStartPosition()
  end
end
function this.DEBUG_CheckNearMissionStartPositionToRealizePosition()
  if gvars.ply_useMissionStartPos then
    local e
    if TppLocation.IsMotherBase()then
      e=1e3*1e3
    else
      e=64*64
    end
    local a=gvars.ply_missionStartPos[0]-vars.playerPosX
    local t=gvars.ply_missionStartPos[2]-vars.playerPosZ
    local a=(a*a)+(t*t)
    if(a>e)then
      return true
    else
      return false
    end
  else
    return false
  end
end
function this.SetInitialPositionToCurrentPosition()
  vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
  vars.initialPlayerPosX=vars.playerPosX
  vars.initialPlayerPosY=vars.playerPosY+.5
  vars.initialPlayerPosZ=vars.playerPosZ
  vars.initialPlayerRotY=vars.playerRotY
end
function this.SetInitialPosition(position,rotation)
  vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
  vars.initialPlayerPosX=position[1]
  vars.initialPlayerPosY=position[2]
  vars.initialPlayerPosZ=position[3]
  vars.initialPlayerRotY=rotation
end
function this.SetInitialPositionFromMissionStartPosition()
  if gvars.ply_useMissionStartPos then
    vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
    vars.initialPlayerPosX=gvars.ply_missionStartPos[0]
    vars.initialPlayerPosY=gvars.ply_missionStartPos[1]
    vars.initialPlayerPosZ=gvars.ply_missionStartPos[2]
    vars.initialPlayerRotY=gvars.ply_missionStartRot
    vars.playerCameraRotation[0]=0
    vars.playerCameraRotation[1]=gvars.ply_missionStartRot
  end
end
function this.ResetInitialPosition()
  vars.initialPlayerFlag=0
  vars.initialPlayerPosX=0
  vars.initialPlayerPosY=0
  vars.initialPlayerPosZ=0
  vars.initialPlayerRotY=0
end
function this.FailSafeInitialPositionForFreePlay()--RETAILPATCH: 1060
  if not((vars.missionCode==30010)or(vars.missionCode==30020))then
    return
end
if vars.initialPlayerFlag~=PlayerFlag.USE_VARS_FOR_INITIAL_POS then
  return
end
if(((vars.initialPlayerPosX>3500)or(vars.initialPlayerPosX<-3500))or(vars.initialPlayerPosZ>3500))or(vars.initialPlayerPosZ<-3500)then
  local e={[30010]={1448.61,337.787,1466.4},[30020]={-510.73,5.09,1183.02}}
  local e=e[vars.missionCode]
  vars.initialPlayerPosX,vars.initialPlayerPosY,vars.initialPlayerPosZ=e[1],e[2],e[3]
end
end--
function this.RegisterTemporaryPlayerType(playerSetting)
  if Ivars.useSoldierForDemos:Is(1) then--tex allow player character for the few missions that override it
    if vars.missionCode==10030 or vars.missionCode==10240 then
      return
  end
  end--
  if not IsTypeTable(playerSetting)then
    return
  end
  mvars.ply_isExistTempPlayerType=true
  local camoType=playerSetting.camoType
  local partsType=playerSetting.partsType
  local playerType=playerSetting.playerType
  local handEquip=playerSetting.handEquip
  local faceEquipId=playerSetting.faceEquipId
  if partsType then
    mvars.ply_tempPartsType=partsType
  end
  if camoType then
    mvars.ply_tempCamoType=camoType
  end
  if playerType then
    mvars.ply_tempPlayerType=playerType
  end
  if handEquip then
    mvars.ply_tempPlayerHandEquip=handEquip
  end
  if faceEquipId then
    mvars.ply_tempPlayerFaceEquipId=faceEquipId
  end
end
function this.SaveCurrentPlayerType()
  if not gvars.ply_isUsingTempPlayerType then
    gvars.ply_lastPlayerPartsTypeUsingTemp=vars.playerPartsType
    gvars.ply_lastPlayerCamoTypeUsingTemp=vars.playerCamoType
    gvars.ply_lastPlayerHandTypeUsingTemp=vars.handEquip
    gvars.ply_lastPlayerTypeUsingTemp=vars.playerType
    gvars.ply_lastPlayerFaceIdUsingTemp=vars.playerFaceId
    gvars.ply_lastPlayerFaceEquipIdUsingTemp=vars.playerFaceEquipId
  end
  gvars.ply_isUsingTempPlayerType=true
end
function this.ApplyTemporaryPlayerType()
  if mvars.ply_tempPartsType then
    vars.playerPartsType=mvars.ply_tempPartsType
  end
  if mvars.ply_tempCamoType then
    vars.playerCamoType=mvars.ply_tempCamoType
  end
  if mvars.ply_tempPlayerType then
    vars.playerType=mvars.ply_tempPlayerType
  end
  if mvars.ply_tempPlayerHandEquip then
    vars.handEquip=mvars.ply_tempPlayerHandEquip
  end
  if mvars.ply_tempPlayerFaceEquipId then
    vars.playerFaceEquipId=mvars.ply_tempPlayerFaceEquipId
  end
end
function this.RestoreTemporaryPlayerType()
  if gvars.ply_isUsingTempPlayerType then
    vars.playerPartsType=gvars.ply_lastPlayerPartsTypeUsingTemp
    vars.playerCamoType=gvars.ply_lastPlayerCamoTypeUsingTemp
    vars.playerType=gvars.ply_lastPlayerTypeUsingTemp
    vars.playerFaceId=gvars.ply_lastPlayerFaceIdUsingTemp
    vars.playerFaceEquipId=gvars.ply_lastPlayerFaceEquipIdUsingTemp
    vars.handEquip=gvars.ply_lastPlayerHandTypeUsingTemp
    gvars.ply_lastPlayerPartsTypeUsingTemp=PlayerPartsType.NORMAL_SCARF
    gvars.ply_lastPlayerCamoTypeUsingTemp=PlayerCamoType.OLIVEDRAB
    gvars.ply_lastPlayerTypeUsingTemp=PlayerType.SNAKE
    gvars.ply_lastPlayerFaceIdUsingTemp=0
    gvars.ply_lastPlayerFaceEquipIdUsingTemp=0
    gvars.ply_isUsingTempPlayerType=false
    gvars.ply_lastPlayerHandTypeUsingTemp=TppEquip.EQP_HAND_NORMAL
  end
end
function this.SetWeapons(weaponTable)
  this._SetWeapons(weaponTable,"weapons")
end
function this.SetInitWeapons(weaponTable)
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    this.SaveWeaponsToUsingTemp(weaponTable)
  end
  this._SetWeapons(weaponTable,"initWeapons")
end
function this._SetWeapons(weaponTable,category)
  if not IsTypeTable(weaponTable)then
    return
  end
  local slotNum=TppDefine.WEAPONSLOT.SUPPORT_0-1
  local slotType,slotName,magazine,ammo,underBarrelAmmo
  for idx,weaponInfo in pairs(weaponTable)do
    slotType,slotNum,slotName,magazine,ammo,underBarrelAmmo=this.GetWeaponSlotInfoFromWeaponSet(weaponInfo,slotNum)
    local equipment=TppEquip[slotName]
    if equipment==nil then
    else
      local ammoId,ammoInWeapon,defaultAmmo,altAmmoId,altAmmoInWeapon,T=TppEquip.GetAmmoInfo(equipment)
      if slotType then
        vars[category][slotType]=equipment
        local ammoCount,altAmmoCount
        if magazine then
          ammoCount=magazine*ammoInWeapon
        elseif ammo then
          ammoCount=ammo
        else
          ammoCount=defaultAmmo
        end
        gvars.initAmmoStockIds[slotType]=ammoId
        gvars.initAmmoStockCounts[slotType]=ammoCount
        gvars.initAmmoInWeapons[slotType]=ammoInWeapon
        if(altAmmoId~=TppEquip.BL_None)then
          if underBarrelAmmo then
            altAmmoCount=underBarrelAmmo
          else
            altAmmoCount=T
          end
          gvars.initAmmoStockIds[slotType+TppDefine.WEAPONSLOT.MAX]=altAmmoId
          gvars.initAmmoStockCounts[slotType+TppDefine.WEAPONSLOT.MAX]=altAmmoCount
          gvars.initAmmoSubInWeapons[slotType]=altAmmoInWeapon
        end
        if category=="initWeapons"then
          vars.isInitialWeapon[slotType]=1
        end
      elseif slotNum>=TppDefine.WEAPONSLOT.SUPPORT_0 and slotNum<=TppDefine.WEAPONSLOT.SUPPORT_7 then
        local supportSlotNum=slotNum-TppDefine.WEAPONSLOT.SUPPORT_0
        vars.initSupportWeapons[supportSlotNum]=equipment
        gvars.initAmmoStockIds[slotNum]=ammoId
        local ammoCount
        if ammo then
          ammoCount=ammo
        else
          ammoCount=defaultAmmo
        end
        gvars.initAmmoStockCounts[slotNum]=ammoCount
      end
    end
  end
end
function this.GetWeaponSlotInfoFromWeaponSet(weaponInfo,slotNum)
  local slotType,slotName,magazine,ammo,underBarrelAmmo
  if weaponInfo.primaryHip then
    slotType=TppDefine.WEAPONSLOT.PRIMARY_HIP
    slotName=weaponInfo.primaryHip
    magazine=weaponInfo.magazine
    ammo=weaponInfo.ammo
    underBarrelAmmo=weaponInfo.underBarrelAmmo
  elseif weaponInfo.primaryBack then
    slotType=TppDefine.WEAPONSLOT.PRIMARY_BACK
    slotName=weaponInfo.primaryBack
    magazine=weaponInfo.magazine
    ammo=weaponInfo.ammo
  elseif weaponInfo.secondary then
    slotType=TppDefine.WEAPONSLOT.SECONDARY
    slotName=weaponInfo.secondary
    magazine=weaponInfo.magazine
    ammo=weaponInfo.ammo
  elseif weaponInfo.support then
    slotNum=slotNum+1
    slotName=weaponInfo.support
    ammo=weaponInfo.ammo
  end
  return slotType,slotNum,slotName,magazine,ammo,underBarrelAmmo
end
function this.SaveWeaponsToUsingTemp(n)
  if gvars.ply_isUsingTempWeapons then
    return
  end
  if not IsTypeTable(n)then
    return
  end
  for e=0,11 do
    gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
  end
  local t
  local a=TppDefine.WEAPONSLOT.SUPPORT_0-1
  for r,n in pairs(n)do
    t,a=this.GetWeaponSlotInfoFromWeaponSet(n,a)
    if t then
      gvars.ply_lastWeaponsUsingTemp[t]=vars.initWeapons[t]
    elseif a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
      local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
      gvars.ply_lastWeaponsUsingTemp[a]=vars.initSupportWeapons[e]
    end
  end
  gvars.ply_isUsingTempWeapons=true
end
function this.RestoreWeaponsFromUsingTemp()
  if not gvars.ply_isUsingTempWeapons then
    return
  end
  for a=0,11 do
    if gvars.ply_lastWeaponsUsingTemp[a]~=TppEquip.EQP_None then
      if a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
        local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
        vars.initSupportWeapons[e]=gvars.ply_lastWeaponsUsingTemp[a]
      else
        vars.initWeapons[a]=gvars.ply_lastWeaponsUsingTemp[a]
      end
      local i,o,l,n,r,t=TppEquip.GetAmmoInfo(gvars.ply_lastWeaponsUsingTemp[a])
      this.SupplyAmmoByBulletId(i,l)
      gvars.initAmmoInWeapons[a]=o
      this.SupplyAmmoByBulletId(n,t)
      gvars.initAmmoSubInWeapons[a]=r
    end
  end
  for e=0,11 do
    gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
  end
  gvars.ply_isUsingTempWeapons=false
  return true
end
function this.SetItems(itemNames)
  if not IsTypeTable(itemNames)then
    return
  end
  for t,equipName in ipairs(itemNames)do
    if TppEquip[equipName]==nil then
      return
    end
  end
  this._SetItems(itemNames,"items")
end
function this.SetInitItems(itemNames)
  if not IsTypeTable(itemNames)then
    return
  end
  for a,equipName in ipairs(itemNames)do
    if TppEquip[equipName]==nil then
      return
    end
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    this.SaveItemsToUsingTemp(itemNames)
  end
  this._SetItems(itemNames,"initItems")
end
function this._SetItems(itemNames,e)
  vars[e][0]=TppEquip.EQP_None
  for a,equipName in pairs(itemNames)do
    vars[e][a]=TppEquip[equipName]
  end
end
function this.SaveItemsToUsingTemp(e)
  if gvars.ply_isUsingTempItems then
    return
  end
  for e=0,7 do
    gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
  end
  for e,a in pairs(e)do
    if e<8 then
      gvars.ply_lastItemsUsingTemp[e]=vars.initItems[e]
    end
  end
  gvars.ply_isUsingTempItems=true
end
function this.RestoreItemsFromUsingTemp()
  if not gvars.ply_isUsingTempItems then
    return
  end
  for e=1,7 do
    if gvars.ply_lastItemsUsingTemp[e]~=TppEquip.EQP_None then
      vars.initItems[e]=gvars.ply_lastItemsUsingTemp[e]
    end
  end
  for e=0,7 do
    gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
  end
  gvars.ply_isUsingTempItems=false
end
function this.InitItemStockCount()
  if TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT==nil then
    return
  end
  for e=AmmoStockIndex.ITEM,AmmoStockIndex.ITEM_END-1 do
    vars.ammoStockIds[e]=0
    vars.ammoStockCounts[e]=0
  end
end
function this.GetBulletNum(e)
  for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    if(e~=nil and e==vars.ammoStockIds[a])then
      return vars.ammoStockCounts[a]
    end
  end
  return 0
end
function this.SavePlayerCurrentWeapons()
  if not vars.initWeapons then
    return
  end
  vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]
  if TppDefine.HONEY_BEE_EQUIP_ID~=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]then
    vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]
  else
    vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=TppEquip.EPQ_None
  end
  vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]
  vars.initHandEquip=vars.handEquip
  for a=0,7 do
    vars.initSupportWeapons[a]=vars.supportWeapons[a]
  end
  this.SaveChimeraWeaponParameter()
end
function this.RestorePlayerWeaponsOnMissionStart()
  if not vars.initWeapons then
    return
  end
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]
  vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]
  vars.handEquip=vars.initHandEquip
  for e=0,7 do
    vars.supportWeapons[e]=vars.initSupportWeapons[e]
  end
end
function this.SaveChimeraWeaponParameter()
  if not vars.initCustomizedWeapon then
    return
  end
  for e=0,2 do
    vars.initCustomizedWeapon[e]=vars.customizedWeapon[e]
  end
  for e=0,32 do
    vars.initChimeraParts[e]=vars.chimeraParts[e]
  end
end
function this.RestoreChimeraWeaponParameter()
  if not vars.initCustomizedWeapon then
    return
  end
  for e=0,2 do
    vars.customizedWeapon[e]=vars.initCustomizedWeapon[e]
  end
  for e=0,32 do
    vars.chimeraParts[e]=vars.initChimeraParts[e]
  end
end
function this.SavePlayerCurrentItems()
  for e=0,7 do
    vars.initItems[e]=vars.items[e]
  end
end
function this.RestorePlayerItemsOnMissionStart()
  for e=0,7 do
    vars.items[e]=vars.initItems[e]
  end
end
function this.ForceSetAllInitialWeapon()
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
end
function this.SupplyAllAmmoFullOnMissionFinalize()
  local a={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for t,a in ipairs(a)do
    this.SupplyWeaponAmmoFull(a)
  end
  for a=0,3 do
    local a=vars.initSupportWeapons[a]
    if a~=TppEquip.EQP_None then
      this.SupplySupportWeaponAmmoFull(a)
    end
  end
end
function this.SupplyWeaponAmmoFull(a)
  local t=vars.initWeapons[a]
  if t==TppEquip.EQP_None then
    return
  end
  local n,t,r,i,o,l=TppEquip.GetAmmoInfo(t)
  this.SupplyAmmoByBulletId(n,r)
  gvars.initAmmoInWeapons[a]=t
  this.SupplyAmmoByBulletId(i,l)
  gvars.initAmmoSubInWeapons[a]=o
end
function this.SupplySupportWeaponAmmoFull(a)
  local t,n,a,n,n,n=TppEquip.GetAmmoInfo(a)
  this.SupplyAmmoByBulletId(t,a)
end
function this.SupplyAmmoByBulletId(t,n)
  if t==TppEquip.BL_None then
    return
  end
  local e
  for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    if gvars.initAmmoStockIds[a]==t then
      e=a
      break
    end
  end
  if not e then
    for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
      if gvars.initAmmoStockIds[a]==TppEquip.BL_None then
        gvars.initAmmoStockIds[a]=t
        e=a
        break
      end
    end
  end
  if not e then
    return
  end
  gvars.initAmmoStockCounts[e]=n
end
function this.SavePlayerCurrentAmmoCount()
  for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    gvars.initAmmoStockIds[e]=vars.ammoStockIds[e]
    gvars.initAmmoStockCounts[e]=vars.ammoStockCounts[e]
  end
  local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for a,e in ipairs(e)do
    gvars.initAmmoInWeapons[e]=vars.ammoInWeapons[e]
    gvars.initAmmoSubInWeapons[e]=vars.ammoSubInWeapons[e]
  end
end
function this.SetMissionStartAmmoCount()
  for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    vars.ammoStockIds[e]=gvars.initAmmoStockIds[e]
    vars.ammoStockCounts[e]=gvars.initAmmoStockCounts[e]
  end
  local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for a,e in ipairs(e)do
    vars.ammoInWeapons[e]=gvars.initAmmoInWeapons[e]
    vars.ammoSubInWeapons[e]=gvars.initAmmoSubInWeapons[e]
  end
end
function this.SetEquipMissionBlockGroupSize()
  local size=mvars.ply_equipMissionBlockGroupSize
  if size>0 then
    TppEquip.CreateEquipMissionBlockGroup{size=size}
  end
end
function this.SetMaxPickableLocatorCount()
  if mvars.ply_maxPickableLocatorCount>0 then
    TppPickable.OnAllocate{locators=mvars.ply_maxPickableLocatorCount,svarsName="ply_pickableLocatorDisabled"}
  end
end
function this.SetMaxPlacedLocatorCount()
  if mvars.ply_maxPlacedLocatorCount>0 then
    TppPlaced.OnAllocate{locators=mvars.ply_maxPlacedLocatorCount,svarsName="ply_placedLocatorDisabled"}
  end
end
function this.IsDecoy(e)
  local e=TppEquip.GetSupportWeaponTypeId(e)
  local a={[TppEquip.SWP_TYPE_Decoy]=true,[TppEquip.SWP_TYPE_ActiveDecoy]=true,[TppEquip.SWP_TYPE_ShockDecoy]=true}
  if a[e]then
    return true
  else
    return false
  end
end
function this.IsMine(e)
  local supportWeaponTypeId=TppEquip.GetSupportWeaponTypeId(e)
  local mineTypes={[TppEquip.SWP_TYPE_DMine]=true,[TppEquip.SWP_TYPE_SleepingGusMine]=true,[TppEquip.SWP_TYPE_AntitankMine]=true,[TppEquip.SWP_TYPE_ElectromagneticNetMine]=true}
  if mineTypes[supportWeaponTypeId]then
    return true
  else
    return false
  end
end
function this.AddTrapSettingForIntel(t)
  local trapName=t.trapName
  local direction=t.direction or 0
  local directionRange=t.directionRange or 60
  local intelName=t.intelName
  local autoIcon=t.autoIcon
  local gotFlagName=t.gotFlagName
  local markerTrapName=t.markerTrapName
  local markerObjectiveName=t.markerObjectiveName
  local identifierName=t.identifierName
  local locatorName=t.locatorName
  if not IsTypeString(trapName)then
    return
  end
  mvars.ply_intelTrapInfo=mvars.ply_intelTrapInfo or{}
  if intelName then
    mvars.ply_intelTrapInfo[intelName]={trapName=trapName}
  else
    return
  end
  mvars.ply_intelNameReverse=mvars.ply_intelNameReverse or{}
  mvars.ply_intelNameReverse[StrCode32(intelName)]=intelName
  mvars.ply_intelFlagInfo=mvars.ply_intelFlagInfo or{}
  if gotFlagName then
    mvars.ply_intelFlagInfo[intelName]=gotFlagName
    mvars.ply_intelFlagInfo[StrCode32(intelName)]=gotFlagName
    mvars.ply_intelTrapInfo[intelName].gotFlagName=gotFlagName
  end
  mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}
  if markerObjectiveName then
    mvars.ply_intelMarkerObjectiveName[intelName]=markerObjectiveName
    mvars.ply_intelMarkerObjectiveName[StrCode32(intelName)]=markerObjectiveName
    mvars.ply_intelTrapInfo[intelName].markerObjectiveName=markerObjectiveName
  end
  mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}
  mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}
  if markerTrapName then
    table.insert(mvars.ply_intelMarkerTrapList,markerTrapName)
    mvars.ply_intelMarkerTrapInfo[StrCode32(markerTrapName)]=intelName
    mvars.ply_intelTrapInfo[intelName].markerTrapName=markerTrapName
  end
  mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}
  if autoIcon then
    table.insert(mvars.ply_intelTrapList,trapName)
    mvars.ply_intelTrapInfo[StrCode32(trapName)]=intelName
    mvars.ply_intelTrapInfo[intelName].autoIcon=true
  end
  if identifierName and locatorName then
    local pos,rot=Tpp.GetLocator(identifierName,locatorName)
    if pos and rot then
      direction=rot
    end
  end
  mvars.ply_intelTrapInfo[intelName].direction=direction
  mvars.ply_intelTrapInfo[intelName].directionRange=directionRange
  Player.AddTrapDetailCondition{trapName=trapName,condition=PlayerTrap.FINE,action=(PlayerTrap.NORMAL+PlayerTrap.BEHIND),stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=direction,directionRange=directionRange}
end
function this.ShowIconForIntel(e,t)
  if not IsTypeString(e)then
    return
  end
  local n
  if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[e]then
    n=mvars.ply_intelTrapInfo[e].trapName
  end
  local a=mvars.ply_intelFlagInfo[e]
  if a then
    if svars[a]~=nil then
      t=svars[a]
    end
  end
  if not t then
    if Tpp.IsNotAlert()then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
    elseif n then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG,message=Fox.StrCode32"NGIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
      if not TppRadio.IsPlayed(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT])then
        TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT)
      end
    end
  end
end
function this.GotIntel(a)
  local e=mvars.ply_intelFlagInfo[a]
  if not e then
    return
  end
  if svars[e]~=nil then
    svars[e]=true
  end
  local e=mvars.ply_intelMarkerObjectiveName[a]
  if e then
    local a=TppMission.GetParentObjectiveName(e)
    local e={}
    for a,t in pairs(a)do
      table.insert(e,a)
    end
    TppMission.UpdateObjective{objectives=e}
  end
end
function this.HideIconForIntel()
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG}
end
function this.AddTrapSettingForQuest(quest)
  local trapName=quest.trapName
  local direction=quest.direction or 0
  local directionRange=quest.directionRange or 180
  local questName=quest.questName
  if not IsTypeString(trapName)then
    return
  end
  mvars.ply_questStartTrapInfo=mvars.ply_questStartTrapInfo or{}
  if questName then
    mvars.ply_questStartTrapInfo[questName]={trapName=trapName}
  else
    return
  end
  mvars.ply_questNameReverse=mvars.ply_questNameReverse or{}
  mvars.ply_questNameReverse[StrCode32(questName)]=questName
  mvars.ply_questStartFlagInfo=mvars.ply_questStartFlagInfo or{}
  mvars.ply_questStartFlagInfo[questName]=false
  mvars.ply_questTrapList=mvars.ply_questTrapList or{}
  table.insert(mvars.ply_questTrapList,trapName)
  mvars.ply_questStartTrapInfo[StrCode32(trapName)]=questName
  Player.AddTrapDetailCondition{trapName=trapName,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=direction,directionRange=directionRange}
end
function this.ShowIconForQuest(e,a)
  if not IsTypeString(e)then
    return
  end
  local t
  if mvars.ply_questStartTrapInfo and mvars.ply_questStartTrapInfo[e]then
    t=mvars.ply_questStartTrapInfo[e].trapName
  end
  if mvars.ply_questStartFlagInfo[e]~=nil then
    a=mvars.ply_questStartFlagInfo[e]
  end
  if not a then
    Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING,message=Fox.StrCode32"QuestStarted",messageInDisplay=Fox.StrCode32"QuestIconInDisplay",messageArg=e}
  end
end
function this.QuestStarted(a)
  local a=mvars.ply_questNameReverse[a]
  if mvars.ply_questStartFlagInfo[a]~=nil then
    mvars.ply_questStartFlagInfo[a]=true
  end
  this.HideIconForQuest()
end
function this.HideIconForQuest()
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING}
end
function this.ResetIconForQuest(e)
  mvars.ply_questStartFlagInfo.ShootingPractice=false
end
function this.AppearHorseOnMissionStart(identifier,key)
  local pos,rot=Tpp.GetLocator(identifier,key)
  if pos then
    vars.buddyType=BuddyType.HORSE
    vars.initialBuddyPos[0]=pos[1]
    vars.initialBuddyPos[1]=pos[2]
    vars.initialBuddyPos[2]=pos[3]
  end
end
function this.StartGameOverCamera(t,a,e)
  if mvars.ply_gameOverCameraGameObjectId~=nil then
    return
  end
  mvars.ply_gameOverCameraGameObjectId=t
  mvars.ply_gameOverCameraStartTimerName=a
  mvars.ply_gameOverCameraAnnounceLog=e
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppSound.PostJingleOnGameOver()
  TppSoundDaemon.PostEvent"sfx_s_force_camera_out"
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  TimerStart("Timer_StartGameOverCamera",.25)
end
function this._StartGameOverCamera(e,e)
  TppUiStatusManager.ClearStatus"AnnounceLog"
  FadeFunction.SetFadeColor(64,0,0,255)
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,nil,{exceptGameStatus={AnnounceLog=false}})
  Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}
end
function this.PrepareStartGameOverCamera()
  FadeFunction.ResetFadeColor()
  local exceptGameStatus={}
  for gameStatusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    exceptGameStatus[gameStatusName]=false
  end
  for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    exceptGameStatus[uiName]=false
  end
  exceptGameStatus.S_DISABLE_NPC=nil
  exceptGameStatus.AnnounceLog=nil
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,nil,nil,{exceptGameStatus=exceptGameStatus})
  Player.RequestToStopCameraAnimation{}
  if mvars.ply_gameOverCameraAnnounceLog then
    TppUiStatusManager.ClearStatus"AnnounceLog"
    TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)
  end
end
function this.FOBStartGameOverCamera(e,t,a)
  if mvars.ply_gameOverCameraGameObjectId~=nil then
    return
  end
  mvars.ply_gameOverCameraGameObjectId=e
  mvars.ply_gameOverCameraStartTimerName=t
  mvars.ply_gameOverCameraAnnounceLog=a
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  TimerStart("Timer_StartGameOverCamera",.25)
end
function this.SetTargetDeadCamera(r)
  local l
  local a
  local o
  if IsTypeTable(r)then
    l=r.gameObjectName or""a=r.gameObjectId
    o=r.announceLog or"target_extract_failed"end
  a=a or GetGameObjectId(l)
  if a==NULL_ID then
    return
  end
  this.StartGameOverCamera(a,"EndFadeOut_StartTargetDeadCamera",o)
end
function this._SetTargetDeadCamera()
  this.PrepareStartGameOverCamera()
  Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}
end
function this.SetTargetHeliCamera(r)
  local l
  local a
  local o
  if IsTypeTable(r)then
    l=r.gameObjectName or""
    a=r.gameObjectId
    o=r.announceLog or"target_eliminate_failed"
  end
  a=a or GetGameObjectId(l)
  if a==NULL_ID then
    return
  end
  this.StartGameOverCamera(a,"EndFadeOut_StartTargetHeliCamera",o)
end
function this._SetTargetHeliCamera()
  this.PrepareStartGameOverCamera()
  Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0}},skeletonNames={"SKL_011_RLWDOOR"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function this.SetTargetTruckCamera(r)
  local l
  local a
  local o
  if IsTypeTable(r)then
    l=r.gameObjectName or""
    a=r.gameObjectId
    o=r.announceLog or"target_extract_failed"
  end
  a=a or GetGameObjectId(l)
  if a==NULL_ID then
    return
  end
  this.StartGameOverCamera(a,"EndFadeOut_StartTargetTruckCamera",o)
end
function this._SetTargetTruckCamera(a)
  this.PrepareStartGameOverCamera()
  Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},StartCameraAnimation={"SKL_005_WIPERC"},skeletonCenterOffsets={Vector3(0,-.75,-2)},skeletonBoundings={Vector3(1.5,2,4)},offsetPos=Vector3(2.5,3,7.5),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function this.SetPlayerKilledChildCamera()
  if mvars.mis_childGameObjectIdKilledPlayer then
    local a=nil
    if not TppEnemy.IsRescueTarget(mvars.mis_childGameObjectIdKilledPlayer)then
      a="boy_died"end
    this.SetTargetDeadCamera{gameObjectId=mvars.mis_childGameObjectIdKilledPlayer,announceLog=a}
  end
end
function this.SetPressStartCamera()
  local e=GetGameObjectId"Player"
  if e==NULL_ID then
    return
  end
  Player.RequestToStopCameraAnimation{}
  Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetTitleCamera()
  local e=GetGameObjectId"Player"
  if e==NULL_ID then
    return
  end
  Player.RequestToStopCameraAnimation{}
  Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetSearchTarget(targetGameObjectName,gameObjectType,name,skeletonName,offset,targetFox2Name,doDirectionCheck,wideCheckRange)
  if(targetGameObjectName==nil or gameObjectType==nil)then
    return
  end
  local targetGameObjectTypeIndex=GetTypeIndexWithTypeName(gameObjectType)
  if targetGameObjectTypeIndex==NULL_ID then
    return
  end
  if doDirectionCheck==nil then--RETAILBUG: ? not sure if intended, this actually isnt used in searchtarget below
    doDirectionCheck=true
  end
  if offset==nil then
    offset=Vector3(0,.25,0)
  end
  if wideCheckRange==nil then
    wideCheckRange=.03
  end
  local searchTarget={name=name,targetGameObjectTypeIndex=targetGameObjectTypeIndex,targetGameObjectName=targetGameObjectName,offset=offset,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=wideCheckRange,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}
  if(skeletonName~=nil)then
    searchTarget.skeletonName=skeletonName
  end
  if(targetFox2Name~=nil)then
    searchTarget.targetFox2Name=targetFox2Name
  end
  Player.AddSearchTarget(searchTarget)
end
function this.IsSneakPlayerInFOB(playerIndex)
  if playerIndex==0 then
    return true
  else
    return false
  end
end
function this.PlayMissionClearCamera()
  local e=this.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  TimerStart("Timer_StartPlayMissionClearCameraStep1",.25)
end
function this.SetPlayerStatusForMissionEndCamera()
  Player.SetPadMask{settingName="MissionClearCamera",except=true}
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  return true
end
function this.ResetMissionEndCamera()
  Player.ResetPadMask{settingName="MissionClearCamera"}
  Player.RequestToStopCameraAnimation{}
end
function this.PlayCommonMissionEndCamera(i,r,s,l,t,n)
  local a
  local vehicleId=vars.playerVehicleGameObjectId
  if Tpp.IsHorse(vehicleId)then
    GameObject.SendCommand(vehicleId,{id="HorseForceStop"})
    a=i(vehicleId,t,n)
  elseif Tpp.IsVehicle(vehicleId)then
    local o=GameObject.SendCommand(vehicleId,{id="GetVehicleType"})
    GameObject.SendCommand(vehicleId,{id="ForceStop",enabled=true})
    local r=r[o]
    if r then
      a=r(vehicleId,t,n)
    end
  elseif(Tpp.IsPlayerWalkerGear(vehicleId)or Tpp.IsEnemyWalkerGear(vehicleId))then
    GameObject.SendCommand(vehicleId,{id="ForceStop",enabled=true})
    a=s(vehicleId,t,n)
  elseif Tpp.IsHelicopter(vehicleId)then
  else
    a=l(t,n)
  end
  if a then
    local timerName="Timer_StartPlayMissionClearCameraStep"..tostring(t+1)
    TimerStart(timerName,a)
  end
end
function this._PlayMissionClearCamera(playJingle,t)
  if playJingle==1 then
    TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")
  end
  this.PlayCommonMissionEndCamera(this.PlayMissionClearCameraOnRideHorse,this.VEHICLE_MISSION_CLEAR_CAMERA,this.PlayMissionClearCameraOnWalkerGear,this.PlayMissionClearCameraOnFoot,playJingle,t)
end
function this.RequestMissionClearMotion()
  Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}
end
function this.PlayMissionClearCameraOnFoot(p,c)
  if PlayerInfo.AndCheckStatus{PlayerStatus.NORMAL_ACTION}then
    if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT}then
      if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
        mvars.ply_requestedMissionClearCameraCarryOff=true
        GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
      else
        this.RequestMissionClearMotion()
      end
    end
  end
  local skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
  local skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0)}
  local skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local offsetPos=Vector3(0,0,-4.5)
  local interpTimeAtStart=.3
  local s
  local callSeOfCameraInterp=false
  local timeToSleep=20
  local useLastSelectedIndex=false
  if p==1 then
    skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
    skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-1.5)
    interpTimeAtStart=.3
    s=1
    callSeOfCameraInterp=true
  elseif c then
    skeletonNames={"SKL_004_HEAD"}
    skeletonCenterOffsets={Vector3(0,0,.05)}
    skeletonBoundings={Vector3(.1,.125,.1)}
    offsetPos=Vector3(0,-.5,-3.5)
    interpTimeAtStart=3
    timeToSleep=4
  else
    skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-3.2)
    interpTimeAtStart=3
    useLastSelectedIndex=true
  end
  Player.RequestToPlayCameraNonAnimation{
    characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),
    isFollowPos=true,
    isFollowRot=true,
    followTime=4,
    followDelayTime=.1,
    candidateRots={{1,168},{1,-164}},
    skeletonNames=skeletonNames,
    skeletonCenterOffsets=skeletonCenterOffsets,
    skeletonBoundings=skeletonBoundings,
    offsetPos=offsetPos,
    focalLength=28,
    aperture=1.875,
    timeToSleep=timeToSleep,
    interpTimeAtStart=interpTimeAtStart,
    fitOnCamera=false,
    timeToStartToFitCamera=1,
    fitCameraInterpTime=.3,
    diffFocalLengthToReFitCamera=16,
    callSeOfCameraInterp=callSeOfCameraInterp,
    useLastSelectedIndex=useLastSelectedIndex
  }
  return s
end
function this.PlayMissionClearCameraOnRideHorse(e,c,p)
  local skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
  local skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0)}
  local skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local offsetPos=Vector3(0,0,-3.2)
  local t=.2
  local o
  local i=false
  local l=20
  local s=false
  if p then
    l=4
  end
  if c==1 then
    skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
    skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-3.2)t=.2
    o=1
    i=true
  else
    skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-4.5)t=3
    s=true
  end
  Player.RequestToPlayCameraNonAnimation{
    characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),
    isFollowPos=true,
    isFollowRot=true,
    followTime=4,
    followDelayTime=.1,
    candidateRots={{0,160},{0,-160}},
    skeletonNames=skeletonNames,
    skeletonCenterOffsets={
      Vector3(0,-.125,.05),
      Vector3(.15,-.125,0),
      Vector3(-.15,-.125,0)
    },
    skeletonBoundings={
      Vector3(.1,.125,.1),
      Vector3(.15,.1,.05),
      Vector3(.15,.1,.05)
    },
    skeletonCenterOffsets=skeletonCenterOffsets,
    skeletonBoundings=skeletonBoundings,
    offsetPos=offsetPos,
    focalLength=28,
    aperture=1.875,
    timeToSleep=l,
    interpTimeAtStart=t,
    fitOnCamera=false,
    timeToStartToFitCamera=1,
    fitCameraInterpTime=.3,
    diffFocalLengthToReFitCamera=16,
    callSeOfCameraInterp=i,
    useLastSelectedIndex=s
  }
  return o
end
function this.PlayMissionClearCameraOnRideLightVehicle(e,l,s)
  local t=Vector3(-.35,.6,.7)
  local e=Vector3(0,0,-2.25)
  local a=.2
  local r
  local n=false
  local i=20
  local o=false
  if s then
    i=4
  end
  if l==1 then
    t=Vector3(-.35,.6,.7)
    e=Vector3(0,0,-2.25)
    a=.2
    r=.5
    n=true
  else
    t=Vector3(-.35,.4,.7)
    e=Vector3(0,0,-4)
    a=.75
    o=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=i,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=n,useLastSelectedIndex=o}
  return r
end
function this.PlayMissionClearCameraOnRideTruck(e,s,l)
  local t=Vector3(-.35,1.3,1)
  local a=Vector3(0,0,-2)
  local e=.2
  local n
  local r=false
  local o=20
  local i=false
  if l then
    o=4
  end
  if s==1 then
    t=Vector3(-.35,1.3,1)
    a=Vector3(0,0,-3)
    e=.2
    n=.5
    r=true
  else
    t=Vector3(-.35,1,1)
    a=Vector3(0,0,-6)
    e=.75
    i=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=i}
  return n
end
function this.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,s,e,RENisQuest)
  local offsetTarget=Vector3(.05,-.5,-2.2)
  if e==1 then
    offsetTarget=Vector3(.05,-.5,-2.2)
  else
    offsetTarget=Vector3(-.05,-1,0)
  end
  local offsetPos=Vector3(0,0,-7.5)
  local interpTimeAtStart=.2
  local r
  local callSeOfCameraInterp=false
  local timeToSleep=20
  local useLastSelectedIndex=false
  if RENisQuest then
    timeToSleep=4
  end
  if s==1 then
    offsetPos=Vector3(0,0,-7.5)
    interpTimeAtStart=.2
    r=.5
    callSeOfCameraInterp=true
  else
    offsetPos=Vector3(0,0,-13.25)
    interpTimeAtStart=.75
    useLastSelectedIndex=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=offsetTarget,offsetPos=offsetPos,focalLength=28,aperture=1.875,timeToSleep=timeToSleep,interpTimeAtStart=interpTimeAtStart,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=callSeOfCameraInterp,useLastSelectedIndex=useLastSelectedIndex}
  return r
end
function this.PlayMissionClearCameraOnRideEasternArmoredVehicle(t,n,r)
  local a
  a=this.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,1,r)
  return a
end
function this.PlayMissionClearCameraOnRideWesternArmoredVehicle(t,n)
  local a
  a=this.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,2,isQuest)--RETAILBUG:
  return a
end
function this.PlayMissionClearCameraOnRideTank(e,l,i)
  local e=Vector3(0,0,-6.5)
  local a=.2
  local n
  local r=false
  local o=20
  local t=false
  if i then
    o=4
  end
  if l==1 then
    e=Vector3(0,0,-6.5)
    a=.2
    n=.5
    r=true
  else
    e=Vector3(0,0,-9)
    a=.75
    t=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=t}
  return n
end
function this.PlayMissionClearCameraOnWalkerGear(a,p,s)
  local n=Vector3(0,.55,.35)
  local a=Vector3(0,0,-3.65)
  local t=.2
  local l
  local i=false
  local o=20
  local r=false
  if s then
    o=4
  end
  if p==1 then
    n=Vector3(0,.55,.35)
    a=Vector3(0,0,-3.65)
    t=.2
    l=1
    i=true
  else
    n=Vector3(0,.4,.35)
    a=Vector3(0,0,-4.95)
    t=3
    r=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=n,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=r}
  return l
end
this.VEHICLE_MISSION_CLEAR_CAMERA={
  [Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayMissionClearCameraOnRideLightVehicle,
  [Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayMissionClearCameraOnRideTank,
  [Vehicle.type.EASTERN_TRUCK]=this.PlayMissionClearCameraOnRideTruck,
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionClearCameraOnRideEasternArmoredVehicle,
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayMissionClearCameraOnRideLightVehicle,
  [Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayMissionClearCameraOnRideTank,
  [Vehicle.type.WESTERN_TRUCK]=this.PlayMissionClearCameraOnRideTruck,
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionClearCameraOnRideWesternArmoredVehicle
}
function this.FOBPlayMissionClearCamera()
  local e=this.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  TimerStart("Timer_FOBStartPlayMissionClearCameraStep1",.25)
end
function this._FOBPlayMissionClearCamera(a)
  this.FOBPlayCommonMissionEndCamera(this.FOBPlayMissionClearCameraOnFoot,a)
end
function this.FOBPlayCommonMissionEndCamera(t,a)
  local e
  e=t(a)
  if e then
    local a="Timer_FOBStartPlayMissionClearCameraStep"..tostring(a+1)TimerStart(a,e)
  end
end
function this.FOBRequestMissionClearMotion()
  Player.RequestToPlayDirectMotion{"missionClearMotionFob",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani",false,"","","",false}}
end
function this.FOBPlayMissionClearCameraOnFoot(l)
  Player.SetCurrentSlot{slotType=PlayerSlotType.ITEM,subIndex=0}
  if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
    if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
      mvars.ply_requestedMissionClearCameraCarryOff=true
      GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
    elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
      Player.RequestToSetTargetStance(PlayerStance.STAND)
      TimerStart("Timer_FOBWaitStandStance",1)
    else
      this.FOBRequestMissionClearMotion()
    end
  end
  local skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
  local skeletonCenterOffsets={Vector3(0,.1,0),Vector3(0,-.05,0)}
  local skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local offsetPos=Vector3(0,0,-4.5)
  local interpTimeAtStart=.3
  local i
  local callSeOfCameraInterp=false
  if l==1 then
    skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
    skeletonCenterOffsets={Vector3(0,.25,0),Vector3(0,-.05,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}
    offsetPos=Vector3(0,0,-1)
    interpTimeAtStart=.3
    i=1
    callSeOfCameraInterp=true
  else
    skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
    skeletonCenterOffsets={Vector3(0,.15,0),Vector3(0,-.05,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}
    offsetPos=Vector3(0,0,-1.5)
    interpTimeAtStart=3
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{-10,170},{-10,-170}},skeletonNames=skeletonNames,skeletonCenterOffsets=skeletonCenterOffsets,skeletonBoundings=skeletonBoundings,offsetPos=offsetPos,focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=interpTimeAtStart,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=callSeOfCameraInterp}
  return i
end
function this.PlayMissionAbortCamera()
  local e=this.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  TimerStart("Timer_StartPlayMissionAbortCamera",.25)
end
function this._PlayMissionAbortCamera()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")
  this.PlayCommonMissionEndCamera(this.PlayMissionAbortCameraOnRideHorse,this.VEHICLE_MISSION_ABORT_CAMERA,this.PlayMissionAbortCameraOnWalkerGear,this.PlayMissionAbortCameraOnFoot)
end
function this.PlayMissionAbortCameraOnFoot()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,10},{6,-10}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideHorse(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,20},{6,-20}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideLightVehicle(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{10,30},{10,-30}},offsetTarget=Vector3(-.35,.3,0),offsetPos=Vector3(0,0,-4),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideTruck(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,75},{8,-55}},offsetTarget=Vector3(-.35,1,1),offsetPos=Vector3(0,0,-5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(e,a)
  local e=Vector3(.05,-.5,-2.2)
  if a==1 then
    e=Vector3(.05,-.5,-2.2)
  else
    e=Vector3(-.65,-1,0)
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,30},{8,-30}},offsetTarget=e,offsetPos=Vector3(0,0,-9),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideEasternArmoredVehicle(a)
  this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,1)
end
function this.PlayMissionAbortCameraOnRideWesternArmoredVehicle(a)
  this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,2)
end
function this.PlayMissionAbortCameraOnRideTank(e)
  local e=Vector3(0,-.5,0)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,25},{8,-25}},offsetTarget=e,offsetPos=Vector3(0,0,-10),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnWalkerGear(a)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,15},{7,-15}},offsetTarget=Vector3(0,.8,0),offsetPos=Vector3(0,.5,-3.5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
this.VEHICLE_MISSION_ABORT_CAMERA={
  [Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayMissionAbortCameraOnRideLightVehicle,
  [Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayMissionAbortCameraOnRideTank,
  [Vehicle.type.EASTERN_TRUCK]=this.PlayMissionAbortCameraOnRideTruck,
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionAbortCameraOnRideEasternArmoredVehicle,
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayMissionAbortCameraOnRideLightVehicle,
  [Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayMissionAbortCameraOnRideTank,
  [Vehicle.type.WESTERN_TRUCK]=this.PlayMissionAbortCameraOnRideTruck,
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionAbortCameraOnRideWesternArmoredVehicle}
function this.PlayFallDeadCamera(a)
  mvars.ply_fallDeadCameraTimeToSleep=20
  if a and Tpp.IsTypeNumber(a.timeToSleep)then
    mvars.ply_fallDeadCameraTimeToSleep=a.timeToSleep
  end
  mvars.ply_fallDeadCameraTargetPlayerIndex=PlayerInfo.GetLocalPlayerIndex()
  HighSpeedCamera.RequestEvent{continueTime=.03,worldTimeRate=.1,localPlayerTimeRate=.1}
  this.PlayCommonMissionEndCamera(this.PlayFallDeadCameraOnRideHorse,this.VEHICLE_FALL_DEAD_CAMERA,this.PlayFallDeadCameraOnWalkerGear,this.PlayFallDeadCameraOnFoot)
end
function this.SetLimitFallDeadCameraOffsetPosY(e)
  mvars.ply_fallDeadCameraPosYLimit=e
end
function this.ResetLimitFallDeadCameraOffsetPosY()
  mvars.ply_fallDeadCameraPosYLimit=nil
end
function this.GetFallDeadCameraOffsetPosY()
  local a=vars.playerPosY
  local e=.5
  if mvars.ply_fallDeadCameraPosYLimit then
    local t=a+e
    if t<mvars.ply_fallDeadCameraPosYLimit then
      e=mvars.ply_fallDeadCameraPosYLimit-a
    end
  end
  return e
end
function this.PlayFallDeadCameraOnFoot()
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideHorse(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideLightVehicle(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTruck(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideArmoredVehicle(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTank(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnWalkerGear(a)
  local a=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(a+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
this.VEHICLE_FALL_DEAD_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayFallDeadCameraOnRideLightVehicle,
  [Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayFallDeadCameraOnRideTank,
  [Vehicle.type.EASTERN_TRUCK]=this.PlayFallDeadCameraOnRideTruck,
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayFallDeadCameraOnRideArmoredVehicle,
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayFallDeadCameraOnRideLightVehicle,
  [Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayFallDeadCameraOnRideTank,
  [Vehicle.type.WESTERN_TRUCK]=this.PlayFallDeadCameraOnRideTruck,
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayFallDeadCameraOnRideArmoredVehicle
}
function this.Messages()
  local messageTable=Tpp.StrCode32Table{
    Player={
      {msg="CalcFultonPercent",func=function(t,gameId,o,a,staffOrResourceId)
        this.MakeFultonRecoverSucceedRatio(t,gameId,o,a,staffOrResourceId,false)
      end},
      {msg="CalcDogFultonPercent",func=function(r,gameId,o,a,staffOrResourceId)
        this.MakeFultonRecoverSucceedRatio(r,gameId,o,a,staffOrResourceId,true)
      end},
      {msg="RideHelicopter",func=this.SetHelicopterInsideAction},
      {msg="PlayerFulton",func=this.OnPlayerFulton},
      {msg="OnPickUpCollection",func=this.OnPickUpCollection},
      {msg="OnPickUpPlaced",func=this.OnPickUpPlaced},
      {msg="OnPickUpWeapon",func=this.OnPickUpWeapon},
      {msg="WarpEnd",func=this.OnEndWarpByCboxDelivery},
      {msg="LandingFromHeli",func=function()
        this.UpdateCheckPointOnMissionStartDrop()
      end},
      {msg="EndCarryAction",func=function()
        if mvars.ply_requestedMissionClearCameraCarryOff then
          if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
            this.RequestMissionClearMotion()
          end
        end
      end,
      option={isExecMissionClear=true}},
      {msg="IntelIconInDisplay",func=this.OnIntelIconDisplayContinue},
      {msg="QuestIconInDisplay",func=this.OnQuestIconDisplayContinue},
      {msg="PlayerShowerEnd",func=function()
        TppUI.ShowAnnounceLog"refresh"end}},
    GameObject={{msg="RideHeli",func=this.QuietRideHeli}},
    UI={{msg="EndFadeOut",sender="OnSelectCboxDelivery",func=this.WarpByCboxDelivery},
      {msg="EndFadeIn",sender="OnEndWarpByCboxDelivery",func=this.OnEndFadeInWarpByCboxDelivery},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=this._SetTargetDeadCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetHeliCamera",func=this._SetTargetHeliCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetTruckCamera",func=this._SetTargetTruckCamera,option={isExecGameOver=true}}},
    Terminal={{msg="MbDvcActSelectCboxDelivery",func=this.OnSelectCboxDelivery}},
    Timer={{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()
      this._PlayMissionClearCamera(1)
    end,
    option={isExecMissionClear=true}},
    {msg="Finish",sender="Timer_StartPlayMissionClearCameraStep2",func=function()
      this._PlayMissionClearCamera(2)
    end,
    option={isExecMissionClear=true}},
    {msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep1",func=function()
      this._FOBPlayMissionClearCamera(1)
    end,
    option={isExecMissionClear=true}},
    {msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep2",func=function()
      this._FOBPlayMissionClearCamera(2)
    end,
    option={isExecMissionClear=true}},
    {msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=this._PlayMissionAbortCamera,option={isExecGameOver=true}},
    {msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=this.OnDeliveryWarpSoundCannotCancel},
    {msg="Finish",sender="Timer_StartGameOverCamera",func=this._StartGameOverCamera,option={isExecGameOver=true}},
    {msg="Finish",sender="Timer_FOBWaitStandStance",func=function()
      this.FOBRequestMissionClearMotion()
    end,
    option={isExecMissionClear=true}}},
    Trap={{msg="Enter",sender="trap_TppSandWind0000",func=function()
      TppEffectUtility.SetSandWindEnable(true)
    end,
    option={isExecMissionPrepare=true}},
    {msg="Exit",sender="trap_TppSandWind0000",func=function()
      TppEffectUtility.SetSandWindEnable(false)
    end,
    option={isExecMissionPrepare=true}},
    {msg="Enter",sender="fallDeath_camera",func=function()
      this.SetLimitFallDeadCameraOffsetPosY(-18)
    end,
    option={isExecMissionPrepare=true}},
    {msg="Exit",sender="fallDeath_camera",func=this.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}}}
  if IsTypeTable(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
    messageTable[StrCode32"Trap"]=messageTable[StrCode32"Trap"]or{}
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=this.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})
  end
  if IsTypeTable(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
    messageTable[StrCode32"Trap"]=messageTable[StrCode32"Trap"]or{}
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=this.OnEnterIntelTrap})
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=this.OnExitIntelTrap})
  end
  return messageTable
end
function this.DeclareSVars()
  return{
    {name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.OnAllocate(missionTable)
  if(missionTable and missionTable.sequence)and missionTable.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE then
    mvars.ply_equipMissionBlockGroupSize=missionTable.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE
  else
    mvars.ply_equipMissionBlockGroupSize=TppDefine.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE
  end
  if(missionTable and missionTable.sequence)and missionTable.sequence.MAX_PICKABLE_LOCATOR_COUNT then
    mvars.ply_maxPickableLocatorCount=missionTable.sequence.MAX_PICKABLE_LOCATOR_COUNT
  else
    mvars.ply_maxPickableLocatorCount=TppDefine.PICKABLE_MAX
  end
  if(missionTable and missionTable.sequence)and missionTable.sequence.MAX_PLACED_LOCATOR_COUNT then
    mvars.ply_maxPlacedLocatorCount=missionTable.sequence.MAX_PLACED_LOCATOR_COUNT
  else
    mvars.ply_maxPlacedLocatorCount=TppDefine.PLACED_MAX
  end
end
function this.SetInitialPlayerState(missionTable)
  local helicopterRouteList
  if(missionTable.sequence and missionTable.sequence.missionStartPosition)and missionTable.sequence.missionStartPosition.helicopterRouteList then
    if not Tpp.IsTypeFunc(missionTable.sequence.missionStartPosition.IsUseRoute)or missionTable.sequence.missionStartPosition.IsUseRoute()then
      helicopterRouteList=missionTable.sequence.missionStartPosition.helicopterRouteList
    end
  end
  if helicopterRouteList==nil then
    if gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
    end
    this.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  end
end
function this.MissionStartPlayerTypeSetting()
  if not mvars.ply_isExistTempPlayerType then
    this.RestoreTemporaryPlayerType()
  end
  if TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL and Ivars.useSoldierForDemos:Is(0)then--tex added override
    vars.playerType=PlayerType.SNAKE
    vars.playerPartsType=PlayerPartsType.NORMAL_SCARF
    vars.playerCamoType=PlayerCamoType.TIGERSTRIPE
    vars.playerHandType=PlayerHandType.NORMAL
  end
  if mvars.ply_isExistTempPlayerType then
    this.SaveCurrentPlayerType()
    this.ApplyTemporaryPlayerType()
  end
  if(vars.missionCode~=10010)and(vars.missionCode~=10280)then
    if vars.playerCamoType==PlayerCamoType.HOSPITAL then
      vars.playerCamoType=PlayerCamoType.OLIVEDRAB
    end
    if vars.playerPartsType==PlayerPartsType.HOSPITAL then
      vars.playerPartsType=PlayerPartsType.NORMAL
    end
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  if gvars.ini_isTitleMode then
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
  end
  if missionTable.sequence and missionTable.sequence.ALLWAYS_100_PERCENT_FULTON then
    mvars.ply_allways_100percent_fulton=true
  end
  if TppMission.IsMissionStart()then
    local initialHandEquip
    if missionTable.sequence and missionTable.sequence.INITIAL_HAND_EQUIP then
      initialHandEquip=missionTable.sequence.INITIAL_HAND_EQUIP
    end
    if initialHandEquip then
    end
    local initialCameraRotation
    if missionTable.sequence and missionTable.sequence.INITIAL_CAMERA_ROTATION then
      initialCameraRotation=missionTable.sequence.INITIAL_CAMERA_ROTATION
    end
    if initialCameraRotation then
      vars.playerCameraRotation[0]=initialCameraRotation[1]
      vars.playerCameraRotation[1]=initialCameraRotation[2]
    end
  end
  
  local blackDiamond=true--tex>
  if Ivars.enableFovaMod:Is(1) then
  local fovaTable,fovaDescription,noBlackDiamond=InfFova.GetCurrentFovaTable()
  blackDiamond=not noBlackDiamond
  end--<
  
  if gvars.s10240_isPlayedFuneralDemo and blackDiamond then--tex added nodiamond
    Player.SetUseBlackDiamondEmblem(true)
  else
    Player.SetUseBlackDiamondEmblem(false)
  end
  local currentItemIndex=0
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    vars.currentItemIndex=currentItemIndex
    vars.initialPlayerAction=PlayerInitialAction.HELI_SPACE
    return
  end
  if TppMission.IsMissionStart()then
    if((vars.missionCode==30010)or(vars.missionCode==30020))and(Player.IsVarsCurrentItemCBox())then
    else
      vars.currentItemIndex=currentItemIndex
    end
  end
  if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
    local heliId=GetGameObjectId("TppHeli2","SupportHeli")
    if heliId~=NULL_ID then
      vars.initialPlayerAction=PlayerInitialAction.FROM_HELI_SPACE
      vars.initialPlayerPairGameObjectId=heliId
    end
  else
    if TppMission.IsMissionStart()then
      local initialPlayerAction
      if missionTable.sequence and missionTable.sequence.MISSION_START_INITIAL_ACTION then
        initialPlayerAction=missionTable.sequence.MISSION_START_INITIAL_ACTION
      end
      if initialPlayerAction then
        vars.initialPlayerAction=initialPlayerAction
      end
    end
  end
  mvars.ply_locationStationTable={}
  mvars.ply_stationLocatorList={}
  local locationName=TppLocation.GetLocationName()
  if locationName=="afgh"or locationName=="mafr"then
    local stations=TppDefine.STATION_LIST[locationName]
    if stations and TppCollection.GetUniqueIdByLocatorName then
      for n,stationName in ipairs(stations)do
        local collectionLocator="col_labl_"..stationName
        local collectionName="col_stat_"..stationName
        local collectionId=TppCollection.GetUniqueIdByLocatorName(collectionLocator)
        mvars.ply_locationStationTable[collectionId]=collectionName
        if TppCollection.RepopCountOperation("GetAt",collectionLocator)>0 then
          TppCollection.SetValidStation(collectionName)
        end
      end
    end
    local stations=TppDefine.STATION_LIST[locationName]
    if stations then
      for n,stationName in ipairs(stations)do
        local collectionLocator="col_labl_"..stationName
        table.insert(mvars.ply_stationLocatorList,collectionLocator)
      end
    end
  end
  TppEffectUtility.SetSandWindEnable(false)
end

function this.SetSelfSubsistenceOnHardMission()--tex heavily reworked, see below for original
  local isActual=TppMission.IsActualSubsistenceMission()
  if isActual and Ivars.ospWeaponProfile:Is"DEFAULT" or (Ivars.primaryWeaponOsp:Is(1) and Ivars.secondaryWeaponOsp:Is(1) and Ivars.tertiaryWeaponOsp:Is(1)) then
    Ivars.ospWeaponProfile:Set("PURE",true,true)--tex don't want to save due to normal subsistence missions
  end

  if Ivars.ospWeaponProfile:Is()>0 then
    this.SetInitWeapons(Ivars.primaryWeaponOsp:GetTable())
    this.SetInitWeapons(Ivars.secondaryWeaponOsp:GetTable())
    this.SetInitWeapons(Ivars.tertiaryWeaponOsp:GetTable())
  end

  if isActual or Ivars.clearSupportItems:Is(1) then
    this.SetInitWeapons(Ivars.clearSupportItems.settingsTable)
  end
  if isActual or Ivars.clearItems:Is(1) then
    this.SetInitItems(Ivars.clearItems.settingsTable)
  end

  if isActual or Ivars.setSubsistenceSuit:Is(1) then
    local playerSettings={partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}
    this.RegisterTemporaryPlayerType(playerSettings)
  end
  if isActual or Ivars.setDefaultHand:Is(1) then
    mvars.ply_isExistTempPlayerType=true
    mvars.ply_tempPlayerHandEquip={handEquip=TppEquip.EQP_HAND_NORMAL}
  end
  if Ivars.disableFulton:Is(1) then--tex
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+PlayerDisableAction.FULTON--tex RETRY:, may have to replace instances with a SetPlayerDisableActionFlag if this doesn't stick
  end

  if Ivars.handLevelProfile:Is()>0 then
    for i, itemIvar in ipairs(Ivars.handLevelProfile.ivarTable()) do
      --TODO: check against developed
      --local currentLevel=Player.GetItemLevel(equip)
      Player.SetItemLevel(itemIvar.equipId,itemIvar.setting)
    end
  end

  if Ivars.fultonLevelProfile:Is()>0 then
    for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
      --TODO: check against developed
      --REF local currentLevel=Player.GetItemLevel(equip)
      Player.SetItemLevel(itemIvar.equipId,itemIvar.setting)
    end
  end
end
--function e.SetSelfSubsistenceOnHardMission()--tex ORIG:
--  if TppMission.IsSubsistenceMission()then
--    e.SetInitWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
--    e.SetInitItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
--    e.RegisterTemporaryPlayerType{partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}
--  end
--end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Update()
  this.UpdateDeliveryWarp()
end
local fultonWeatherSuccessTable={
  [TppDefine.WEATHER.SUNNY]=0,
  [TppDefine.WEATHER.CLOUDY]=-10,
  [TppDefine.WEATHER.RAINY]=-30,
  [TppDefine.WEATHER.FOGGY]=-50,
  [TppDefine.WEATHER.SANDSTORM]=-70
}
this.mbSectionRankSuccessTable={--NMC: tex was in MakeFultonRecoverSucceedRatio, was local
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,
  [TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0
}
function this.MakeFultonRecoverSucceedRatio(t,_gameId,RENAMEanimalId,r,staffOrResourceId,isDogFultoning)
  local gameId=_gameId
  local percentage=0
  local baseLine=100
  local doFuncSuccess=0
  --RETAILPATCH: 1.0.4.4, was: -v- guess they missed updating this call when they added the param last patch CULL:
  --TppTerminal.DoFuncByFultonTypeSwitch(t,p,r,l,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
  doFuncSuccess=TppTerminal.DoFuncByFultonTypeSwitch(gameId,RENAMEanimalId,r,staffOrResourceId,nil,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
  if doFuncSuccess==nil then
    doFuncSuccess=100
  end
  local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
  local mbSectionSuccess=this.mbSectionRankSuccessTable[mbFultonRank]or 0
  if Ivars.fultonNoMbSupport:Is(1) then--tex>
    mbSectionSuccess=0
  end--<

  local successMod=fultonWeatherSuccessTable[vars.weather]or 0
  successMod=successMod+mbSectionSuccess
  if successMod>0 then
    successMod=0
  end
  percentage=(baseLine+doFuncSuccess)+successMod

  --  if Tpp.IsSoldier(gameId)then--tex fulton success variation WIP
  --    if gvars.fultonSoldierVariationRange>0 then--tex
  --      local frequency=0.1
  --      local rate=gvars.fultonVariationInvRate/gvars.clockscale
  --      local t=math.fmod(vars.clock/rate,2*math.pi)--tex mod to sine range
  --      local amplitude=gvars.fultonSoldierVariationRange*0.5
  --      local bias=-amplitude
  --      local variationMod=amplitude*math.sin(t)+bias
  --
  --      --percentage=math.random(percentage-gvars.fultonVariationRange,percentage)
  --      percentage=percentage+variationMod
  --    end
  --  else
  --    if gvars.fultonOtherVariationRange>0 then--tex
  --      --TODO
  --    end
  --  end--

  if mvars.ply_allways_100percent_fulton then
    percentage=100
  end
  if TppEnemy.IsRescueTarget(gameId)then
      percentage=100
  end    
  if Tpp.IsHostage(gameId) then--tex>
    if Ivars.fultonHostageHandling:Is"ZERO" then
      percentage=0
    end
  end--< 
  if InfMain.IsWildCardEnabled() and Tpp.IsSoldier(gameId) then--tex>
    local soldierType=TppEnemy.GetSoldierType(gameId)
    local soldierSubType=TppEnemy.GetSoldierSubType(gameId,soldierType)
    if soldierSubType=="SOVIET_WILDCARD" or soldierSubType=="PF_WILDCARD" then
      percentage=0
    end
  end--<
  if Ivars.mbWarGamesProfile:Is"INVASION" then--tex> WORKAROUND something weird happening with fuledtempstaff on map exit, disabling for now
    percentage=0
  end--<
  if Tpp.IsFultonContainer(gameId) and vars.missionCode==30050 and Ivars.mbCollectionRepop:Is(1)then--tex> more weirdness
    percentage=0
  end--<
  
  local forcePercent
  if mvars.ply_forceFultonPercent then
    forcePercent=mvars.ply_forceFultonPercent[gameId]
  end
  if forcePercent then
    percentage=forcePercent
  end
  if isDogFultoning then
    Player.SetDogFultonIconPercentage{percentage=percentage,targetId=gameId}
  else
    Player.SetFultonIconPercentage{percentage=percentage,targetId=gameId}
  end
end
function this.GetSoldierFultonSucceedRatio(gameId)
  local successMod=0
  local holdupSuccessMod=0
  local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  local stateFlag=GameObject.SendCommand(gameId,{id="GetStateFlag"})
  local dying=bit.band(stateFlag,StateFlag.DYING_LIFE)~=0
  if(dying)then
    successMod=-(Ivars.fultonDyingPenalty:Get())--tex was -70
  elseif(lifeStatus==TppGameObject.NPC_LIFE_STATE_SLEEP)or(lifeStatus==TppGameObject.NPC_LIFE_STATE_FAINT)then
    successMod=-(Ivars.fultonSleepPenalty:Get())--tex was 0
    if mvars.ply_OnFultonIconDying then
      mvars.ply_OnFultonIconDying()
    end
  elseif(lifeStatus==TppGameObject.NPC_LIFE_STATE_DEAD)then
    return
  end
  --tex OFF, using this.mbSectionRankSuccessTable instead
  --  local mbSectionRankSuccessTable={
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,
  --    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0
  --  }
  local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
  local mbSectionSuccess=this.mbSectionRankSuccessTable[mbFultonRank]or 0--tex changed from table local to function to in module
  if Ivars.fultonNoMbMedical:Is(1) then--tex>
    mbSectionSuccess=0
  end
  if Ivars.fultonDontApplyMbMedicalToSleep:Is(1) and not dying then--tex don't apply medical bonus to sleeping
    mbSectionSuccess=0
  end--<
  successMod=successMod+mbSectionSuccess
  if successMod>0 then
    successMod=0
  end
  local status=SendCommand(gameId,{id="GetStatus"})
  if status==EnemyState.STAND_HOLDUP then
    holdupSuccessMod=-(Ivars.fultonHoldupPenalty:Get())--tex was -10
  end
  return(successMod+holdupSuccessMod)
end
function this.GetDefaultSucceedRatio(e)
  return 0
end
function this.GetVolginFultonSucceedRatio(e)
  return 100
end
function this.SetHelicopterInsideAction()
  Player.SetHeliToInsideParam{canClearMission=svars.mis_canMissionClear}
end
function this.OnPlayerFulton(playerIndex,gameId)
  if playerIndex~=PlayerInfo.GetLocalPlayerIndex()then
    return
  end
  local defaultGmp=300
  local gearGmp=1e4
  local midGmp=1e4
  local lowGmp=5e3
  local gmpForFultonedObject={
    [TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2]=gearGmp,
    [TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2]=gearGmp,
    [TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR]=gearGmp,
    [TppGameObject.GAME_OBJECT_TYPE_VEHICLE]=midGmp,
    [TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]=midGmp,
    [TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]=midGmp,
    [TppGameObject.GAME_OBJECT_TYPE_MORTAR]=lowGmp,
    [TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]=lowGmp
  }
  local gmpAmount
  local typeIndex=GameObject.GetTypeIndex(gameId)
  gmpAmount=gmpForFultonedObject[typeIndex]or defaultGmp
  TppTerminal.UpdateGMP{gmp=-gmpAmount,gmpCostType=TppDefine.GMP_COST_TYPE.FULTON}
  svars.supportGmpCost=svars.supportGmpCost+gmpAmount
end
function this.QuietRideHeli(gameId)
  if gameId==GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2",0)then
    Player.RequestToPlayCameraNonAnimation{characterId=gameId,isFollowPos=false,isFollowRot=false,followTime=1,followDelayTime=.1,candidateRots={{-4,45},{-4,-45},{-8,0}},offsetPos=Vector3(0,-.2,-2.5),offsetTarget=Vector3(0,2,0),focalLength=21,aperture=1.875,timeToSleep=2,enableOverride=true}
  end
end
function this.SetRetryFlag()
  vars.playerRetryFlag=PlayerRetryFlag.RETRY
end
function this.SetRetryFlagWithChickCap()
  vars.playerRetryFlag=PlayerRetryFlag.RETRY_WITH_CHICK_CAP
end
function this.UnsetRetryFlag()
  vars.playerRetryFlag=0
end
function this.ResetStealthAssistCount()
  vars.stealthAssistLeftCount=0
end
function this.OnPickUpCollection(i,resourceId,resourceType,langId)
  local i=255
  TppCollection.RepopCountOperation("SetAt",resourceId,i)
  TppTerminal.AddPickedUpResourceToTempBuffer(resourceType,langId)
  local posterNames={[TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",[TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",[TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",[TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",[TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",[TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}
  local posterName=posterNames[resourceType]
  if posterName~=nil then
    TppUI.ShowAnnounceLog("getPoster",posterName,TppTerminal.GMP_POSTER)
  end
  local resourceCount
  if TppTerminal.RESOURCE_INFORMATION_TABLE[resourceType]and TppTerminal.RESOURCE_INFORMATION_TABLE[resourceType].count then
    resourceCount=TppTerminal.RESOURCE_INFORMATION_TABLE[resourceType].count
  end
  if TppCollection.IsHerbByType(resourceType)then
    local gameId=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
    if gameId~=NULL_ID then
      SendCommand(gameId,{id="GetPlant",uniqueId=resourceId})
    end
  end
  if TppCollection.IsMaterialByType(resourceType)then
    TppUI.ShowAnnounceLog("find_processed_res",langId,resourceCount)
  end
  if resourceType==TppCollection.TYPE_DIAMOND_SMALL then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)
  end
  if resourceType==TppCollection.TYPE_DIAMOND_LARGE then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)
  end
  local locationStationTable=mvars.ply_locationStationTable[resourceId]
  if locationStationTable then
    TppUI.ShowAnnounceLog"get_invoice"
    TppUI.ShowAnnounceLog"add_delivery_point"
    TppCollection.SetValidStation(locationStationTable)
    this.CheckAllStationPickedUp()
  end
  TppTerminal.PickUpBluePrint(resourceId)
  TppTerminal.PickUpEmblem(resourceId)
end
function this.CheckAllStationPickedUp()
  local e=true
  for t,a in ipairs(mvars.ply_stationLocatorList)do
    local a=TppCollection.RepopCountOperation("GetAt",a)
    if a then
      if a<1 then
        e=false
        break
      end
    end
  end
  if e then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3011,isShowAnnounceLog=true}
    if TppLocation.IsAfghan()then
      gvars.ply_isAllGotStation_Afgh=true
    elseif TppLocation.IsMiddleAfrica()then
      gvars.ply_isAllGotStation_Mafr=true
    end
    if gvars.ply_isAllGotStation_Afgh and gvars.ply_isAllGotStation_Mafr then
      TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3012,isShowAnnounceLog=true}
    end
  end
end
function this.OnPickUpPlaced(e,e,itemIndex)
  local gameId=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
  if gameId~=NULL_ID then
    SendCommand(gameId,{id="GetPlacedItem",index=itemIndex})
  end
end
function this.OnPickUpWeapon(t,equipType,e)
  if equipType==TppEquip.EQP_IT_Cassette then
    TppCassette.AcquireOnPickUp(e)
  end
end
function this.RestoreSupplyCbox()
  if this.IsExistSupplyCboxSystem()then
    local e={type="TppSupplyCboxSystem"}
    SendCommand(e,{id="RestoreRequest"})
  end
end
function this.StoreSupplyCbox()
  if this.IsExistSupplyCboxSystem()then
    local e={type="TppSupplyCboxSystem"}
    SendCommand(e,{id="StoreRequest"})
  end
end
function this.IsExistSupplyCboxSystem()
  if GameObject.GetGameObjectIdByIndex("TppSupplyCboxSystem",0)~=NULL_ID then
    return true
  else
    return false
  end
end
function this.RestoreSupportAttack()
  if this.IsExistSupportAttackSystem()then
    local e={type="TppSupportAttackSystem"}
    SendCommand(e,{id="RestoreRequest"})
  end
end
function this.StoreSupportAttack()
  if this.IsExistSupportAttackSystem()then
    local e={type="TppSupportAttackSystem"}
    SendCommand(e,{id="StoreRequest"})
  end
end
function this.IsExistSupportAttackSystem()
  if GameObject.GetGameObjectIdByIndex("TppSupportAttackSystem",0)~=NULL_ID then
    return true
  else
    return false
  end
end
function this.StorePlayerDecoyInfos()
  if this.IsExistDecoySystem()then
    local command={type="TppDecoySystem"}
    SendCommand(command,{id="StorePlayerDecoyInfos"})
  end
end
function this.IsExistDecoySystem()
  if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=NULL_ID then
    return true
  else
    return false
  end
end
local t=7.5
local a=3.5
this.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}
function this.OnSelectCboxDelivery(a)
  Player.SetPadMask{settingName="CboxDelivery",except=true}
  mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_FADE_OUT
  mvars.ply_selectedCboxDeliveryUniqueId=a
  mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectCboxDelivery",nil,{setMute=true})
end
function this.WarpByCboxDelivery()
  if not mvars.ply_selectedCboxDeliveryUniqueId then
    return
  end
  TppGameStatus.Set("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    TppQuest.DeactivateCurrentQuestBlock()
    TppQuest.ClearBlockStateRequest()
  end
  mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_WARP
  TimerStart("Timer_DeliveryWarpSoundCannotCancel",t)
  local a={type="TppPlayer2",index=0}
  local e={id="WarpToStation",stationId=mvars.ply_selectedCboxDeliveryUniqueId}
  GameObject.SendCommand(a,e)
end
function this.OnEndWarpByCboxDelivery()
  if mvars.ply_deliveryWarpState==this.DELIVERY_WARP_STATE.START_WARP then
    mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.END_WARP
  end
end
function this.OnDeliveryWarpSoundCannotCancel()
  mvars.ply_deliveryWarpSoundCannotCancel=true
end
function this.UpdateDeliveryWarp()
  if not mvars.ply_deliveryWarpState then
    return
  end
  if(mvars.ply_deliveryWarpState==this.DELIVERY_WARP_STATE.START_WARP)then
    TppUI.ShowAccessIconContinue()
  end
  if(mvars.ply_deliveryWarpState~=this.DELIVERY_WARP_STATE.END_WARP)then
    return
  end
  if not TppMission.CheckMissionState()then
    mvars.ply_playingDeliveryWarpSoundHandle=nil
    mvars.ply_selectedCboxDeliveryUniqueId=nil
    mvars.ply_deliveryWarpState=nil
    mvars.ply_deliveryWarpSoundCannotCancel=nil
    TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")
    TimerStop"Timer_DeliveryWarpSoundCannotCancel"
    return
  end
  if mvars.ply_playingDeliveryWarpSoundHandle then
    local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)
    if(e==false)then
      TppSoundDaemon.ResetMute"Loading"mvars.ply_playingDeliveryWarpSoundHandle=nil
    else
      TppUI.ShowAccessIconContinue()
    end
  end
  if(mvars.ply_playingDeliveryWarpSoundHandle and(not mvars.ply_deliveryWarpSoundCannotCancel))and(bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.STANCE)==PlayerPad.STANCE)then
    mvars.ply_deliveryWarpSoundCannotCancel=true
    TppSoundDaemon.ResetMute"Loading"
    TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")
  end
  if(not mvars.ply_playingDeliveryWarpSoundHandle)then
    mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_FADE_IN
    TppSoundDaemon.ResetMute"Loading"
    TppGameStatus.Reset("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
    if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
      TppQuest.InitializeQuestLoad()
      TppQuest.InitializeQuestActiveStatus()
    end
    TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedCboxDeliveryUniqueId)
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByCboxDelivery")
  end
end
function this.OnEndFadeInWarpByCboxDelivery()
  mvars.ply_selectedCboxDeliveryUniqueId=nil
  mvars.ply_deliveryWarpState=nil
  mvars.ply_deliveryWarpSoundCannotCancel=nil
  TimerStop"Timer_DeliveryWarpSoundCannotCancel"
  Player.ResetPadMask{settingName="CboxDelivery"}
end
function this.OnEnterIntelMarkerTrap(e,a)
  local e=mvars.ply_intelMarkerTrapInfo[e]
  local a=mvars.ply_intelFlagInfo[e]
  if a then
    if svars[a]then
      return
    end
  else
    return
  end
  local e=mvars.ply_intelMarkerObjectiveName[e]
  if e then
    TppMission.UpdateObjective{objectives={e}}
  end
end
function this.OnEnterIntelTrap(a,t)
  local a=mvars.ply_intelTrapInfo[a]
  this.ShowIconForIntel(a)
end
function this.OnExitIntelTrap(a,a)
  this.HideIconForIntel()
end
function this.OnIntelIconDisplayContinue(a,t,t)
  local a=mvars.ply_intelNameReverse[a]
  this.ShowIconForIntel(a)
end
function this.OnEnterQuestTrap(a,t)
  local a=mvars.ply_questStartTrapInfo[a]
  this.ShowIconForQuest(a)
  local e=mvars.ply_questStartFlagInfo[a]
  if e~=nil and e==false then
    TppSoundDaemon.PostEvent"sfx_s_ifb_mbox_arrival"
  end
end
function this.OnExitQuestTrap(a,a)
  this.HideIconForQuest()
end
function this.OnQuestIconDisplayContinue(a,t,t)
  local a=mvars.ply_questNameReverse[a]
  this.ShowIconForQuest(a)
end
function this.UpdateCheckPointOnMissionStartDrop()
  if not TppSequence.IsHelicopterStart()then
    return
  end
  if TppMission.IsEmergencyMission()then
    return
  end
  if not mvars.ply_doneUpdateCheckPointOnMissionStartDrop then
    TppMission.UpdateCheckPointAtCurrentPosition()
    mvars.ply_doneUpdateCheckPointOnMissionStartDrop=true
  end
end
function this.IsAlreadyDropped()
  return mvars.ply_doneUpdateCheckPointOnMissionStartDrop
end
function this.SaveCaptureAnimal()
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  local cageInfo=TppPlaced.GetCaptureCageInfo()
  for t,a in pairs(cageInfo)do
    local a,e,t,t=this.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
    if e~=0 then
      CaptureCage.RegisterCaptureAnimal(e,a)
    end
  end
  TppPlaced.DeleteAllCaptureCage()
end
function this.AggregateCaptureAnimal()
  local heroicPoint=0
  local gmp=0
  local animalList=CaptureCage.GetCaptureAnimalList()
  for t,n in pairs(animalList)do
    local animalId=n.animalId
    local areaName=n.areaName
    TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=animalId,areaNameHash=areaName,isNew=true}
    local n,r=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=animalId}
    heroicPoint=heroicPoint+n
    gmp=gmp+r
    TppUiCommand.ShowBonusPopupAnimal(animalId,"regist")
  end
  if heroicPoint>0 or gmp>0 then
    TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=heroicPoint,gmp=gmp,isAnnounce=true}
  end
end
function this.CheckCaptureCage(n,r)
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  if n<2 or n>4 then
    return
  end
  local t={}
  local count=5
  local o=r/count
  for r=1,o do
    if n==2 then
      Player.DEBUG_PlaceAround{radius=5,count=count,equipId=TppEquip.EQP_SWP_CaptureCage}
    elseif n==3 then
      Player.DEBUG_PlaceAround{radius=5,count=count,equipId=TppEquip.EQP_SWP_CaptureCage_G01}
    elseif n==4 then
      Player.DEBUG_PlaceAround{radius=5,count=count,equipId=TppEquip.EQP_SWP_CaptureCage_G02}
    end
    for e=1,count do
      coroutine.yield()
    end
    local a=TppPlaced.GetCaptureCageInfo()
    for n,a in pairs(a)do
      local areaName,animalId,r,e=this.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
      if animalId~=0 then
        TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=animalId,areaName=areaName,isNew=true}
        if t[e]==nil then
          t[e]=1
        else
          t[e]=t[e]+1
        end
      end
    end
    TppPlaced.DeleteAllCaptureCage()
  end
  for a,e in pairs(t)do
    local e=(e/r)*100
  end
end
function this.GetCaptureAnimalSE(t)
  local e="sfx_s_captured_nom"local a=mvars.loc_locationAnimalSettingTable
  if a==nil then
    return e
  end
  local a=a.animalRareLevel
  if a[t]==nil then
    return e
  end
  local a=a[t]
  if a==TppMotherBaseManagementConst.ANIMAL_RARE_SR then
    e="sfx_s_captured_super"elseif a==TppMotherBaseManagementConst.ANIMAL_RARE_R then
    e="sfx_s_captured_rare"else
    e="sfx_s_captured_nom"end
  return e
end
function this._IsStartStatusValid(a)
  if(this.StartStatusList[a]==nil)then
    return false
  end
  return true
end
function this._IsAbilityNameValid(name)
  if(this.DisableAbilityList[name]==nil)then
    return false
  end
  return true
end
function this._IsControlModeValid(a)
  if(this.ControlModeList[a]==nil)then
    return false
  end
  return true
end
function this._CheckRotation(x,rangeX,y,rangeY,e)
  --ORPHAN local mvars=mvars
  local rotX=vars.playerCameraRotation[0]
  local rotY=vars.playerCameraRotation[1]
  local deltaX=foxmath.DegreeToRadian(rotX-x)
  deltaX=foxmath.NormalizeRadian(deltaX)
  local deltaXRad=foxmath.RadianToDegree(deltaX)
  local deltaY=foxmath.DegreeToRadian(rotY-y)
  deltaY=foxmath.NormalizeRadian(deltaY)
  local deltaYRad=foxmath.RadianToDegree(deltaY)
  if(foxmath.Absf(deltaXRad)<rangeX)and(foxmath.Absf(deltaYRad)<rangeY)then
    return true
  else
    return false
  end
end
local function RandomFromCageTable(cageTable)
  local rnd=math.random(0,99)
  local e=0
  local t=-1
  for r,a in pairs(cageTable)do
    e=e+a[2]
    if rnd<e then
      t=a[1]
      break
    end
  end
  return t
end
local function RENdoesMatch(e,a)
  for t,e in pairs(e)do
    if e==a then
      return true
    end
  end
  return false
end
function this.EvaluateCaptureCage(i,a,grade,material)
  local mvars=mvars
  local loc_locationAnimalSettingTable=mvars.loc_locationAnimalSettingTable
  local captureCageAnimalAreaSetting=loc_locationAnimalSettingTable.captureCageAnimalAreaSetting
  local t="wholeArea"
  for n,e in pairs(captureCageAnimalAreaSetting)do
    if((i>=e.activeArea[1]and i<=e.activeArea[3])and a>=e.activeArea[2])and a<=e.activeArea[4]then
      t=e.areaName
      break
    end
  end
  local a=0
  if grade==2 then
    a=RandomFromCageTable(this.CageRandomTableG3)
  elseif grade==1 then
    a=RandomFromCageTable(this.CageRandomTableG2)
  else
    a=RandomFromCageTable(this.CageRandomTableG1)
  end
  local captureAnimalList=loc_locationAnimalSettingTable.captureAnimalList
  local animalRareLevel=loc_locationAnimalSettingTable.animalRareLevel
  local animalInfoList=loc_locationAnimalSettingTable.animalInfoList
  local n={}
  if captureAnimalList[t]==nil then
    t="wholeArea"end
  local i=false
  for t,dataBaseId in pairs(captureAnimalList[t])do
    local t=animalRareLevel[dataBaseId]
    if t>=TppMotherBaseManagementConst.ANIMAL_RARE_SR and grade==2 then
      if not TppMotherBaseManagement.IsGotDataBase{dataBaseId=dataBaseId}then
        table.insert(n,dataBaseId)
        a=t
        i=true
        break
      end
    end
  end
  if not i then
    local r=a
    while a>=0 do
      for t,e in pairs(captureAnimalList[t])do
        if animalRareLevel[e]==a then
          table.insert(n,e)
        end
      end
      if table.maxn(n)>0 then
        break
      end
      a=a-1
    end
    if a<0 then
      a=r
      t="wholeArea"
      while a>=0 do
        for t,e in pairs(captureAnimalList[t])do
          if animalRareLevel[e]==a then
            table.insert(n,e)
          end
        end
        if table.maxn(n)>0 then
          break
        end
        a=a-1
      end
    end
  end
  local animalMaterial=loc_locationAnimalSettingTable.animalMaterial
  local o={}
  local r=a
  if animalMaterial~=nil then
    while r>=0 do
      for a,e in pairs(captureAnimalList.wholeArea)do
        if animalMaterial[e]==nil and animalRareLevel[e]==r then
          table.insert(o,e)
        end
      end
      if table.maxn(o)>0 then
        break
      end
      r=r-1
    end
  end
  local e=0
  local l=table.maxn(n)
  if l==1 then
    e=n[1]
  elseif l>1 then
    local a=math.random(1,l)
    e=n[a]
  end
  if#o==0 then
    local n=""
    return t,e,a,n
  end
  if animalMaterial~=nil then
    local t=animalMaterial[e]
    if t~=nil then
      if RENdoesMatch(t,material)==false then
        local t=math.random(1,#o)
        e=o[t]
        a=r
      end
    end
  end
  local n=""
  if animalInfoList~=nil then
    if e~=0 then
      n=animalInfoList[e].name
    end
  end
  return t,e,a,n
end
function this.Refresh(e)
  if e then
    Player.ResetDirtyEffect()
  end
  vars.passageSecondsSinceOutMB=0
end
return this

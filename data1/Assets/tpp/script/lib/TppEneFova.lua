-- DOBUILD: 1
-- TppEneFova.lua
local this={}
local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT--==255
local RENlang0=0
local RENlang1=1
local RENlang2=2
local RENlang3=3
local RENlang4=4
local RENlang5=5
local RENlang6=6
--RETAILPATCH 1.10>
local securitySwimSuitBodies={
  female={
    TppEnemyBodyId.dlf_enef0_def,
    TppEnemyBodyId.dlf_enef1_def,
    TppEnemyBodyId.dlf_enef2_def,
    TppEnemyBodyId.dlf_enef3_def,
    TppEnemyBodyId.dlf_enef4_def,
    TppEnemyBodyId.dlf_enef5_def,
    TppEnemyBodyId.dlf_enef6_def,
    TppEnemyBodyId.dlf_enef7_def,
    TppEnemyBodyId.dlf_enef8_def,
    TppEnemyBodyId.dlf_enef9_def,
    TppEnemyBodyId.dlf_enef10_def,
    TppEnemyBodyId.dlf_enef11_def,
    --RETAILPATCH 1.0.11>
    TppEnemyBodyId.dlg_enef0_def,
    TppEnemyBodyId.dlg_enef1_def,
    TppEnemyBodyId.dlg_enef2_def,
    TppEnemyBodyId.dlg_enef3_def,
    TppEnemyBodyId.dlg_enef4_def,
    TppEnemyBodyId.dlg_enef5_def,
    TppEnemyBodyId.dlg_enef6_def,
    TppEnemyBodyId.dlg_enef7_def,
    TppEnemyBodyId.dlg_enef8_def,
    TppEnemyBodyId.dlg_enef9_def,
    TppEnemyBodyId.dlg_enef10_def,
    TppEnemyBodyId.dlg_enef11_def,
    TppEnemyBodyId.dlh_enef0_def,
    TppEnemyBodyId.dlh_enef1_def,
    TppEnemyBodyId.dlh_enef2_def,
    TppEnemyBodyId.dlh_enef3_def,
    TppEnemyBodyId.dlh_enef4_def,
    TppEnemyBodyId.dlh_enef5_def,
    TppEnemyBodyId.dlh_enef6_def,
    TppEnemyBodyId.dlh_enef7_def,
    TppEnemyBodyId.dlh_enef8_def,
    TppEnemyBodyId.dlh_enef9_def,
    TppEnemyBodyId.dlh_enef10_def,
    TppEnemyBodyId.dlh_enef11_def,
  --<
  },
  male={
    TppEnemyBodyId.dlf_enem0_def,
    TppEnemyBodyId.dlf_enem1_def,
    TppEnemyBodyId.dlf_enem2_def,
    TppEnemyBodyId.dlf_enem3_def,
    TppEnemyBodyId.dlf_enem4_def,
    TppEnemyBodyId.dlf_enem5_def,
    TppEnemyBodyId.dlf_enem6_def,
    TppEnemyBodyId.dlf_enem7_def,
    TppEnemyBodyId.dlf_enem8_def,
    TppEnemyBodyId.dlf_enem9_def,
    TppEnemyBodyId.dlf_enem10_def,
    TppEnemyBodyId.dlf_enem11_def,
    --RETAILPTACH 1.11
    TppEnemyBodyId.dlg_enem0_def,
    TppEnemyBodyId.dlg_enem1_def,
    TppEnemyBodyId.dlg_enem2_def,
    TppEnemyBodyId.dlg_enem3_def,
    TppEnemyBodyId.dlg_enem4_def,
    TppEnemyBodyId.dlg_enem5_def,
    TppEnemyBodyId.dlg_enem6_def,
    TppEnemyBodyId.dlg_enem7_def,
    TppEnemyBodyId.dlg_enem8_def,
    TppEnemyBodyId.dlg_enem9_def,
    TppEnemyBodyId.dlg_enem10_def,
    TppEnemyBodyId.dlg_enem11_def,
    TppEnemyBodyId.dlh_enem0_def,
    TppEnemyBodyId.dlh_enem1_def,
    TppEnemyBodyId.dlh_enem2_def,
    TppEnemyBodyId.dlh_enem3_def,
    TppEnemyBodyId.dlh_enem4_def,
    TppEnemyBodyId.dlh_enem5_def,
    TppEnemyBodyId.dlh_enem6_def,
    TppEnemyBodyId.dlh_enem7_def,
    TppEnemyBodyId.dlh_enem8_def,
    TppEnemyBodyId.dlh_enem9_def,
    TppEnemyBodyId.dlh_enem10_def,
    TppEnemyBodyId.dlh_enem11_def,
  }
}
--<RETAILPATCH 1.10
local prs2_main0_def_v00PartsAfghan="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts"
local prs5_main0_def_v00PartsAfrica="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts"
local prs3_main0_def_v00PartsAfghanFree="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
local prs6_main0_def_v00PartsAfricaFree="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts"
local dds5_main0_def_v00Parts="/Assets/tpp/parts/chara/dds/dds5_main0_def_v00.parts"
this.noArmorForMission={--tex made module local
  [10010]=1,
  [10020]=1,
  [10030]=1,
  [10054]=1,
  [11054]=1,
  [10070]=1,
  [10080]=1,
  [11080]=1,
  [10100]=1,
  [10110]=1,
  [10120]=1,
  [10130]=1,
  [11130]=1,
  [10140]=1,
  [11140]=1,
  [10150]=1,
  [10200]=1,
  [11200]=1,
  [10280]=1,
  [30010]=1,
  [30020]=1
}
local missionArmorType={
  [10081]={TppDefine.AFR_ARMOR.TYPE_RC},
  [10082]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11082]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10085]={TppDefine.AFR_ARMOR.TYPE_RC},
  [11085]={TppDefine.AFR_ARMOR.TYPE_RC},
  [10086]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10090]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11090]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10091]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11091]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10093]={TppDefine.AFR_ARMOR.TYPE_ZRS},
  [10121]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11121]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10171]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11171]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10195]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11195]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [10211]={TppDefine.AFR_ARMOR.TYPE_CFA},
  [11211]={TppDefine.AFR_ARMOR.TYPE_CFA}
}
local missionHostageInfos={
  [10020]={count=0},
  [10030]={count=0},
  [10033]={count=1,lang=RENlang2},
  [11033]={count=1,lang=RENlang2},
  [10036]={count=0},
  [11036]={count=0},
  [10040]={count=1,lang=RENlang4},
  [10041]={count=2,lang=RENlang2},
  [11041]={count=2,lang=RENlang2},
  [10043]={count=2,lang=RENlang4},
  [11043]={count=2,lang=RENlang4},
  [10044]={count=1,lang=RENlang2,overlap=true},
  [11044]={count=1,lang=RENlang2,overlap=true},
  [10045]={count=2,lang=RENlang2},
  [10050]={count=0},
  [11050]={count=0},
  [10052]={count=6,lang=RENlang6,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},
  [11052]={count=6,lang=RENlang6,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},
  [10054]={count=4,lang=RENlang1,overlap=true},
  [11054]={count=4,lang=RENlang1,overlap=true},
  [10070]={count=0},
  [10080]={count=0},
  [11080]={count=0},
  [10081]={count=0},
  [10082]={count=2,lang=RENlang5,overlap=true},
  [11082]={count=2,lang=RENlang5,overlap=true},
  [10085]={count=0},
  [11085]={count=0},
  [10086]={count=0},
  [10090]={count=0},
  [11090]={count=0},
  [10091]={count=1,lang=RENlang1,useHair=true,overlap=true},
  [11091]={count=1,lang=RENlang1,useHair=true,overlap=true},
  [10093]={count=0},
  [10100]={count=0},
  [10110]={count=0},
  [10115]={count=0},
  [11115]={count=0},
  [10120]={count=1,lang=RENlang1,overlap=true},
  [10121]={count=0},
  [11121]={count=0},
  [10130]={count=0},
  [11130]={count=0},
  [10140]={count=0},
  [11140]={count=0},
  [10145]={count=0},
  [10150]={count=0},
  [10151]={count=0},
  [11151]={count=0},
  [10171]={count=0},
  [11171]={count=0},
  [10156]={count=1,lang=RENlang2,overlap=true},
  [10195]={count=1,lang=RENlang5},
  [11195]={count=1,lang=RENlang5},
  [10200]={count=1,lang=RENlang5},
  [11200]={count=1,lang=RENlang5},
  [10240]={count=0},
  [10211]={count=4,lang=RENlang3,overlap=true},
  [11211]={count=4,lang=RENlang4,overlap=true},
  [10260]={count=0},
  [10280]={count=0}
}
this.S10030_FaceIdList={78,200,283,30,88,124,138,169,213,222,243,264,293,322,343}
this.S10030_useBalaclavaNum=3
this.S10240_FemaleFaceIdList={394,351,373,456,463,455,511,502}
this.S10240_MaleFaceIdList={195,144,214,6,217,83,273,60,87,71,256,201,290,178,102,255,293,165,85,18,228,12,65,134,31,132,161,342,107,274,184,226,153,247,344,242,56,183,54,126,223}

local fovaSetupFuncs={}
this.fovaSetupFuncs=fovaSetupFuncs--tex expose to other modules

--NMC an addaption of switch / case from Case method on http://lua-users.org/wiki/SwitchStatement
--mostly used for PreMissionLoad, but also in some of the fovaSetupFuncs[missionId] funcs to run the area fova func
--why they didn't just call those functions directly I'm not sure. Maybe it just started as a select on missionId and passing missionId as a parameter
--but then broke down when they decided to add area fova funcs.
--my rework of PreMissionLoad is skips it's use entirely
local function Select(switchTable)
  function switchTable:case(key,missionCode)
    local fovaFunc=self[key]or self.default
    if fovaFunc then
      fovaFunc(key,missionCode)
    end
  end
  return switchTable
end
function this.IsNotRequiredArmorSoldier(missionCode)
  if InfEneFova.ForceArmor(missionCode) then--tex >
    return false
  end--<
  if this.noArmorForMission[missionCode]~=nil then
    return true
  end
  return false
end
local pfArmorTypes={PF_A=TppDefine.AFR_ARMOR.TYPE_CFA,PF_B=TppDefine.AFR_ARMOR.TYPE_ZRS,PF_C=TppDefine.AFR_ARMOR.TYPE_RC}--tex made local to module so GetArmorTypeTable can use it
function this.CanUseArmorType(missionCode,soldierSubType)
  --tex ORIG OFF local pfArmorTypes={PF_A=TppDefine.AFR_ARMOR.TYPE_CFA,PF_B=TppDefine.AFR_ARMOR.TYPE_ZRS,PF_C=TppDefine.AFR_ARMOR.TYPE_RC}
  local pfArmorType=pfArmorTypes[soldierSubType]
  if pfArmorType==nil then
    return true
  end
  local armorTypeTable=this.GetArmorTypeTable(missionCode)
  for mission,armorType in ipairs(armorTypeTable)do
    if armorType==pfArmorType then
      return true
    end
  end
  return false
end
function this.GetHostageCountAtMissionId(missionCode)
  local default=0
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.count~=nil then
        return hostagesInfo.count
      else
        return default
      end
    else
      return default
    end
  end
  return default
end
function this.GetHostageLangAtMissionId(missionCode)
  local default=RENlang1
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.lang~=nil then
        return hostagesInfo.lang
      end
    end
  end
  return default
end
function this.GetHostageUseHairAtMissionId(missionInfo)
  local default=false
  if missionHostageInfos[missionInfo]~=nil then
    local hostagesInfo=missionHostageInfos[missionInfo]
    if hostagesInfo~=nil then
      if hostagesInfo.useHair~=nil then
        return hostagesInfo.useHair
      end
    end
  end
  return default
end
function this.GetHostageIsFaceModelOverlap(missionCode)
  local default=false
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.overlap~=nil then
        return hostagesInfo.overlap
      end
    end
  end
  return default
end
function this.GetHostageFaceModelCount(missionCode)
  local default=2
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.modelNum~=nil then
        return hostagesInfo.modelNum
      end
    end
  end
  return default
end
function this.GetHostageIgnoreFaceList(missionCode)
  local default={}
  if missionHostageInfos[missionCode]~=nil then
    local hostagesInfo=missionHostageInfos[missionCode]
    if hostagesInfo~=nil then
      if hostagesInfo.ignoreList~=nil then
        return hostagesInfo.ignoreList
      end
    end
  end
  return default
end
--tex reworked
function this.GetArmorTypeTable(missionCode)
  if this.IsNotRequiredArmorSoldier(missionCode)then
    return{}
  end
  if not TppLocation.IsMiddleAfrica()then
    return{}
  end
  local default={TppDefine.AFR_ARMOR.TYPE_ZRS}

  local armorType=missionArmorType[missionCode]
  if armorType~=nil then
    return armorType
  else
    --tex>
    if InfEneFova.ForceArmor(missionCode) then
      --tex would like to be soldiersubtypespecific but fova setup isnt that granular
      return {pfArmorTypes.PF_A,pfArmorTypes.PF_B,pfArmorTypes.PF_C}
    end
    --<
  end
  return default
end
--ORIG
--function this.GetArmorTypeTable(missionCode)
--  if this.IsNotRequiredArmorSoldier(missionCode)then
--    return{}
--  end
--  if not TppLocation.IsMiddleAfrica()then
--    return{}
--  end
--  local default={TppDefine.AFR_ARMOR.TYPE_ZRS}
--  if missionArmorType[missionCode]~=nil then
--    local armorType=missionArmorType[missionCode]
--    if armorType~=nil then
--      return armorType
--    end
--  end
--  return default
--end
function this.SetHostageFaceTable(missionId)
  local hostageCount=this.GetHostageCountAtMissionId(missionId)
  local hostageLang=this.GetHostageLangAtMissionId(missionId)
  local raceHalfMode=0
  if hostageCount>0 then
    local race={}
    if hostageLang==RENlang1 then
      table.insert(race,3)
      local e=bit.rshift(gvars.hosface_groupNumber,8)%100
      if e<40 then
        table.insert(race,0)
      end
    elseif hostageLang==RENlang2 then
      table.insert(race,0)
    elseif hostageLang==RENlang5 then
      table.insert(race,2)
      local e=bit.rshift(gvars.hosface_groupNumber,8)%100
      if e<10 then
        table.insert(race,0)
      end
    elseif hostageLang==RENlang6 then
      table.insert(race,0)
      table.insert(race,1)
      raceHalfMode=1
    elseif hostageLang==RENlang4 then
      table.insert(race,1)
    elseif hostageLang==RENlang3 then
      table.insert(race,2)
    else
      if TppLocation.IsAfghan()then
        table.insert(race,0)
      elseif TppLocation.IsMiddleAfrica()then
        table.insert(race,2)
      elseif TppLocation.IsMotherBase()then
        table.insert(race,0)
      elseif TppLocation.IsMBQF()then
        table.insert(race,0)
      elseif TppLocation.IsCyprus()then
        table.insert(race,0)
      end
    end
    local hostageIsFaceModelOverlap=this.GetHostageIsFaceModelOverlap(missionId)
    local hostageIgnoreFaceList=this.GetHostageIgnoreFaceList(missionId)
    local hostageFaceModelCount=this.GetHostageFaceModelCount(missionId)
    local faceTable=TppSoldierFace.CreateFaceTable{race=race,needCount=hostageCount,maxUsedFovaCount=hostageFaceModelCount,faceModelOverlap=hostageIsFaceModelOverlap,ignoreFaceList=hostageIgnoreFaceList,raceHalfMode=raceHalfMode}
    if faceTable~=nil then
      local face={}
      local hostageFace={}
      local numTableFaces=#faceTable
      local facePosition=MAX_REALIZED_COUNT
      if hostageCount<=numTableFaces then
        facePosition=1
      end
      if(numTableFaces>0)and(numTableFaces<hostageCount)then
        facePosition=math.floor(hostageCount/numTableFaces)+1
      end
      if facePosition<=0 then
        facePosition=MAX_REALIZED_COUNT
      end
      for n,value in ipairs(faceTable)do
        table.insert(face,{value,0,0,facePosition})
        table.insert(hostageFace,value)
      end
      local e=#hostageFace
      if e>0 then
        local hosface_groupNumber=gvars.hosface_groupNumber
        TppSoldierFace.SetPoolTable{hostageFace=hostageFace,randomSeed=hosface_groupNumber}
      end
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    else
      local face={}
      local n=gvars.hosface_groupNumber%9
      if hostageLang==RENlang1 then
        table.insert(face,{25+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==RENlang2 then
        table.insert(face,{100+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==RENlang5 then
        table.insert(face,{210+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==RENlang4 then
        table.insert(face,{9+n,0,0,MAX_REALIZED_COUNT})
      elseif hostageLang==RENlang3 then
        table.insert(face,{260+n,0,0,MAX_REALIZED_COUNT})
      else
        table.insert(face,{55+n,0,0,MAX_REALIZED_COUNT})
      end
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
    local hostageUseHair=this.GetHostageUseHairAtMissionId(missionId)
    if hostageUseHair==true then
      TppSoldierFace.SetHostageUseHairFova(true)
    end
  end
end
function this.GetFaceGroupTableAtGroupType(faceGroupType)
  local faceGroupTable=TppEnemyFaceGroup.GetFaceGroupTable(faceGroupType)
  local faces={}
  local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT
  for n,faceId in pairs(faceGroupTable)do
    table.insert(faces,{faceId,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
  end
  return faces
end

fovaSetupFuncs[10200]=function(locationName,missionId)
  this.SetHostageFaceTable(missionId)
  local bodies={
    {TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs5_main0_def_v00PartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
fovaSetupFuncs[11200]=fovaSetupFuncs[10200]
fovaSetupFuncs[10120]=function(locationName,missionId)
  this.SetHostageFaceTable(missionId)
  local bodies={
    {TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs5_main0_def_v00PartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
fovaSetupFuncs[10040]=function(locationName,missionId)
  --tex ORIG:>
  --  local fovaSetupFuncs=Select(fovaSetupFuncs)
  --  fovaSetupFuncs:case("Afghan",missionId)
  --<
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[10045]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  local possibleFaces={}
  for faceId=0,9 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=20,39 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=50,81 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=93,199 do
    table.insert(possibleFaces,faceId)
  end
  local numFaces=#possibleFaces
  local selectedFaceIndex=gvars.hosface_groupNumber%numFaces
  local specialFace=possibleFaces[selectedFaceIndex]
  local faces={{TppEnemyFaceId.svs_balaclava,1,1,0},{specialFace,1,1,0}}
  TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}
  local svs0_unq_v421=274
  TppSoldierFace.SetSpecialFovaId{face={specialFace},body={svs0_unq_v421}}
  local bodyIds={{svs0_unq_v421,1}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodyIds,additionalMode=true}
end
fovaSetupFuncs[10052]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetSplitRaceForHostageRandomFaceId{enabled=true}
end
fovaSetupFuncs[11052]=fovaSetupFuncs[10052]
fovaSetupFuncs[10090]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11090]=fovaSetupFuncs[10090]
fovaSetupFuncs[10091]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  local possibleFaces={}
  for faceId=0,9 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=20,39 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=50,81 do
    table.insert(possibleFaces,faceId)
  end
  for faceId=93,199 do
    table.insert(possibleFaces,faceId)
  end
  local numFaces=#possibleFaces
  local selectedFaceIndex1=gvars.solface_groupNumber%numFaces
  local selectedFaceIndex2=gvars.hosface_groupNumber%numFaces
  if selectedFaceIndex1==selectedFaceIndex2 then
    selectedFaceIndex2=(selectedFaceIndex2+1)%numFaces
  end
  local specialFace1=possibleFaces[selectedFaceIndex1]
  local specialFace2=possibleFaces[selectedFaceIndex2]
  local faces={{TppEnemyFaceId.pfs_balaclava,2,2,0},{specialFace1,1,1,0},{specialFace2,1,1,0}}
  TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}
  local pfs0_uniq0_v08=265
  local pfs0_uniq0_v09=266
  TppSoldierFace.SetSpecialFovaId{face={specialFace1,specialFace2},body={pfs0_uniq0_v08,pfs0_uniq0_v09}}
  local bodies={{pfs0_uniq0_v08,1},{pfs0_uniq0_v09,1}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}
end
fovaSetupFuncs[11091]=fovaSetupFuncs[10091]
fovaSetupFuncs[10080]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  if TppPackList.IsMissionPackLabel"afterPumpStopDemo"then
  else
    TppSoldier2.SetExtendPartsInfo{type=2,path="/Assets/tpp/parts/chara/chd/chd0_main0_def_v00.parts"}
    local bodies={{TppEnemyBodyId.chd0_v00,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v01,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v02,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v03,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v04,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v05,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v06,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v07,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v08,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v09,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v10,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.chd0_v11,MAX_REALIZED_COUNT}}
    TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  end
end
fovaSetupFuncs[11080]=fovaSetupFuncs[10080]
fovaSetupFuncs[10115]=function(locationName,missionId)
  local faces={}
  for faceId=0,9 do
    table.insert(faces,faceId)
  end
  for faceId=20,39 do
    table.insert(faces,faceId)
  end
  for faceId=50,81 do
    table.insert(faces,faceId)
  end
  for faceId=93,199 do
    table.insert(faces,faceId)
  end
  local randomSeed=gvars.hosface_groupNumber
  TppSoldierFace.SetPoolTable{face=faces,randomSeed=randomSeed}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  local bodies={{TppEnemyBodyId.dds0_main1_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds0_main1_v01,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds5_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.dds5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=dds5_main0_def_v00Parts,bodyId=TppEnemyBodyId.dds5_main0_v00}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
end
fovaSetupFuncs[11115]=fovaSetupFuncs[10115]
fovaSetupFuncs[10130]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11130]=fovaSetupFuncs[10130]
fovaSetupFuncs[10140]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetUseZombieFova{enabled=true}
end
fovaSetupFuncs[11140]=fovaSetupFuncs[10140]
fovaSetupFuncs[10150]=function(locationName,missionId)
  local faces={}
  for faceId=0,9 do
    table.insert(faces,faceId)
  end
  for faceId=20,39 do
    table.insert(faces,faceId)
  end
  for faceId=50,81 do
    table.insert(faces,faceId)
  end
  for faceId=93,199 do
    table.insert(faces,faceId)
  end
  local randomSeed=gvars.hosface_groupNumber
  TppSoldierFace.SetPoolTable{face=faces,randomSeed=randomSeed}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  local bodies={{TppEnemyBodyId.wss4_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
end
fovaSetupFuncs[10151]=function(locationName,missionId)
end
fovaSetupFuncs[11151]=fovaSetupFuncs[10151]
fovaSetupFuncs[30010]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetUseZombieFova{enabled=true}
  local body={{TppEnemyBodyId.prs3_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs3_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs3_main0_def_v00PartsAfghanFree,bodyId=TppEnemyBodyId.prs3_main0_v00}
end
fovaSetupFuncs[30020]=function(locationName,missionId)
  fovaSetupFuncs[locationName](locationName,missionId)--tex REWORKED, see fovaSetupFuncs[10040]
  TppSoldierFace.SetUseZombieFova{enabled=true}
  local body={{TppEnemyBodyId.prs6_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=body}
  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs6_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs6_main0_def_v00PartsAfricaFree,bodyId=TppEnemyBodyId.prs6_main0_v00}
end
function fovaSetupFuncs.afgh(locationName,missionId)
  if missionId==10010 then
    return
  end

  local moreVariationMode=0
  if TppSoldierFace.IsMoreVariationMode~=nil then
    moreVariationMode=TppSoldierFace.IsMoreVariationMode()
  end
  local MAX_AFGAN_GRP=15
  local n=gvars.solface_groupNumber%MAX_AFGAN_GRP
  local faceGroupType=TppEnemyFaceGroupId.AFGAN_GRP_00+n
  local faceGroupTable=this.GetFaceGroupTableAtGroupType(faceGroupType)
  TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
  if moreVariationMode>0 then
    for e=1,2 do
      n=n+2
      local e=(n%MAX_AFGAN_GRP)*2
      local faceGroupType=TppEnemyFaceGroupId.AFGAN_GRP_00+(e)
      local faceGroupTable=this.GetFaceGroupTableAtGroupType(faceGroupType)
      TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
    end
  end
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
  this.SetHostageFaceTable(missionId)

  local bodyInfo=InfEneFova.GetMaleBodyInfo(missionId)--tex>
  if bodyInfo then
    local faces={}
    --TODO: dont add headgear if bodyInfo is non ddheadgear (check both genders)
    for faceId, faceInfo in pairs(InfEneFova.ddHeadGearInfo) do
      table.insert(faces,{TppEnemyFaceId[faceId],MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end
    TppSoldierFace.OverwriteMissionFovaData{face=faces}--,additionalMode=true}

    local bodies={}
    InfEneFova.SetupBodies(bodyInfo,bodies)
    if #bodies>0 then
      TppSoldierFace.OverwriteMissionFovaData{body=bodies}
    end

    if bodyInfo.partsPath then
      TppSoldier2.SetDefaultPartsPath(bodyInfo.partsPath)
    end
    --<
  else
    --NMC all svs0 main bodies
    local bodies={
      {0,MAX_REALIZED_COUNT},
      {1,MAX_REALIZED_COUNT},
      {2,MAX_REALIZED_COUNT},
      {5,MAX_REALIZED_COUNT},
      {6,MAX_REALIZED_COUNT},
      {7,MAX_REALIZED_COUNT},
      {10,MAX_REALIZED_COUNT},
      {11,MAX_REALIZED_COUNT},
      {20,MAX_REALIZED_COUNT},
      {21,MAX_REALIZED_COUNT},
      {22,MAX_REALIZED_COUNT},
      {25,MAX_REALIZED_COUNT},
      {26,MAX_REALIZED_COUNT},
      {27,MAX_REALIZED_COUNT},
      {30,MAX_REALIZED_COUNT},
      {31,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}
    }

    local isNotRequiredArmorSoldier=this.IsNotRequiredArmorSoldier(missionId)
    if not this.IsNotRequiredArmorSoldier(missionId)then
      local body={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}
      table.insert(bodies,body)
    end
    TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  end

  if Ivars.enableWildCardFreeRoam:EnabledForMission(missionId) then--tex>
    local faces={}
    InfCore.PCallDebug(InfEneFova.WildCardFovaFaces,faces)
    TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}
    local bodies={}
    InfCore.PCallDebug(InfEneFova.WildCardFovaBodies,bodies)
    TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}
  end--<

  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs2_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs2_main0_def_v00PartsAfghan,bodyId=TppEnemyBodyId.prs2_main0_v00}
end
function fovaSetupFuncs.mafr(locationName,missionId)
  local isMoreVariationMode=0
  if TppSoldierFace.IsMoreVariationMode~=nil then
    isMoreVariationMode=TppSoldierFace.IsMoreVariationMode()
  end
  local MAX_AFRICA_GRP=30
  local solface_groupNumber=gvars.solface_groupNumber
  local faceGroup=(solface_groupNumber%MAX_AFRICA_GRP)*2--NMC *2 because each group has _B and _W
  local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_B+(faceGroup)
  local faceGroupTable=this.GetFaceGroupTableAtGroupType(faceGroupType)
  TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
  if isMoreVariationMode>0 then
    for e=1,2 do
      solface_groupNumber=solface_groupNumber+2
      local faceGroup=(solface_groupNumber%MAX_AFRICA_GRP)*2
      local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_B+(faceGroup)
      local face=this.GetFaceGroupTableAtGroupType(faceGroupType)
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
  end
  MAX_AFRICA_GRP=30
  solface_groupNumber=gvars.solface_groupNumber
  faceGroup=(solface_groupNumber%MAX_AFRICA_GRP)*2
  faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_W+(faceGroup)
  local faceGroupTable=this.GetFaceGroupTableAtGroupType(faceGroupType)
  TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
  if isMoreVariationMode>0 then
    for e=1,2 do
      solface_groupNumber=solface_groupNumber+2
      local faceGroup=(solface_groupNumber%MAX_AFRICA_GRP)*2
      local faceGroupType=TppEnemyFaceGroupId.AFRICA_GRP000_W+(faceGroup)
      local face=this.GetFaceGroupTableAtGroupType(faceGroupType)
      TppSoldierFace.OverwriteMissionFovaData{face=face}
    end
  end
  this.SetHostageFaceTable(missionId)
  TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true,raceSplit=60}

  local bodyInfo=InfEneFova.GetMaleBodyInfo(missionId)--tex>
  if bodyInfo then
    local faces={}
    --TODO: dont add headgear if bodyInfo is non ddheadgear (check both genders)
    for faceId, faceInfo in pairs(InfEneFova.ddHeadGearInfo) do
      table.insert(faces,{TppEnemyFaceId[faceId],MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end
    TppSoldierFace.OverwriteMissionFovaData{face=faces}--,additionalMode=true}

    local bodies={}
    InfEneFova.SetupBodies(bodyInfo,bodies)
    if #bodies>0 then
      TppSoldierFace.OverwriteMissionFovaData{body=bodies}
    end

    if bodyInfo.partsPath then
      TppSoldier2.SetDefaultPartsPath(bodyInfo.partsPath)
    end
    --<
  else
    --NMC all pfs0 main bodies
    local bodies={
      {50,MAX_REALIZED_COUNT},
      {51,MAX_REALIZED_COUNT},
      {55,MAX_REALIZED_COUNT},
      {60,MAX_REALIZED_COUNT},
      {61,MAX_REALIZED_COUNT},
      {70,MAX_REALIZED_COUNT},
      {71,MAX_REALIZED_COUNT},
      {75,MAX_REALIZED_COUNT},
      {80,MAX_REALIZED_COUNT},
      {81,MAX_REALIZED_COUNT},
      {90,MAX_REALIZED_COUNT},
      {91,MAX_REALIZED_COUNT},
      {95,MAX_REALIZED_COUNT},
      {100,MAX_REALIZED_COUNT},
      {101,MAX_REALIZED_COUNT},
      {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}
    }
    local armorTypeTable=this.GetArmorTypeTable(missionId)
    if armorTypeTable~=nil then
      local numArmorTypes=#armorTypeTable
      if numArmorTypes>0 then
        for t,armorType in ipairs(armorTypeTable)do
          if armorType==TppDefine.AFR_ARMOR.TYPE_ZRS then
            table.insert(bodies,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
          elseif armorType==TppDefine.AFR_ARMOR.TYPE_CFA then
            table.insert(bodies,{TppEnemyBodyId.pfa0_v00_b,MAX_REALIZED_COUNT})
          elseif armorType==TppDefine.AFR_ARMOR.TYPE_RC then
            table.insert(bodies,{TppEnemyBodyId.pfa0_v00_c,MAX_REALIZED_COUNT})
          else
            table.insert(bodies,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
          end
        end
      end
    end
    TppSoldierFace.OverwriteMissionFovaData{body=bodies}
  end
  if Ivars.enableWildCardFreeRoam:EnabledForMission(missionId) then--tex>
    local faces={}
    InfCore.PCallDebug(InfEneFova.WildCardFovaFaces,faces)
    TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}
    local bodies={}
    InfCore.PCallDebug(InfEneFova.WildCardFovaBodies,bodies)
    TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}
  end--<

  TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
  TppHostage2.SetDefaultBodyFovaId{parts=prs5_main0_def_v00PartsAfrica,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
function fovaSetupFuncs.mbqf(locationName,missionId)
  TppSoldierFace.SetSoldierOutsideFaceMode(false)
  TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  local faces={}
  local faceCounts={}
  if TppStory.GetCurrentStorySequence()<TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    local staffIds,staffIds2=TppMotherBaseManagement.GetStaffsS10240()
    for n,staffId in pairs(staffIds)do
      local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
      if faceCounts[faceId]==nil then
        faceCounts[faceId]=2
      else
        faceCounts[faceId]=faceCounts[faceId]+1
      end
    end
    for n,staffId in pairs(staffIds2)do
      local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
      if faceCounts[faceId]==nil then
        faceCounts[faceId]=2
      else
        faceCounts[faceId]=faceCounts[faceId]+1
      end
    end
  else
    for i,faceId in ipairs(this.S10240_MaleFaceIdList)do
      local faceId=this.S10240_MaleFaceIdList[i]--NMC: wut, why the doublework?
      if faceCounts[faceId]==nil then
        faceCounts[faceId]=2
      else
        faceCounts[faceId]=faceCounts[faceId]+1
      end
    end
    for i,faceId in ipairs(this.S10240_FemaleFaceIdList)do
      local faceId=this.S10240_FemaleFaceIdList[i]--NMC: wut, why the doublework?
      if faceCounts[faceId]==nil then
        faceCounts[faceId]=2
      else
        faceCounts[faceId]=faceCounts[faceId]+1
      end
    end
  end
  for faceId,faceCount in pairs(faceCounts)do
    table.insert(faces,{faceId,faceCount,faceCount,0})
  end
  table.insert(faces,{623,1,1,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava2,10,10,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava6,2,2,0})
  table.insert(faces,{TppEnemyFaceId.dds_balaclava7,2,2,0})

  local bodies={
    {146,MAX_REALIZED_COUNT},
    {147,MAX_REALIZED_COUNT},
    {148,MAX_REALIZED_COUNT},
    {149,MAX_REALIZED_COUNT},
    {150,MAX_REALIZED_COUNT},
    {151,1},
    {152,MAX_REALIZED_COUNT},
    {153,MAX_REALIZED_COUNT},
    {154,MAX_REALIZED_COUNT},
    {155,MAX_REALIZED_COUNT},
    {156,MAX_REALIZED_COUNT},
    {157,MAX_REALIZED_COUNT},
    {158,MAX_REALIZED_COUNT}
  }
  TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00.parts"}
  TppSoldierFace.OverwriteMissionFovaData{face=faces,body=bodies}
  TppSoldierFace.SetSoldierUseHairFova(true)
end


--tex REWORKED
local mtbsFaceSetupFuncs={}

--tex broken out from fovaSetupFuncs.mtbs
--GOTCHA: original code is if IsFOBMission, but there arent any other 50k range missions
mtbsFaceSetupFuncs[50050]=function(faces)
  local ddSuit=TppEnemy.GetDDSuit()

  local fobStaff=TppMotherBaseManagement.GetStaffsFob()
  local FACE_SOLDIER_NUM=36--NAMEGUESS: from mtbs_enemy.lua
  local maxSolNum=100--NAMEGUESS: from mtbs_enemy again
  local faceCountTable={}--RENAME:
  local hasFaceTable={}--NAMEGUESS:
  do
    for i,staffId in pairs(fobStaff)do
      local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
      if faceCountTable[faceId]==nil then
        faceCountTable[faceId]=1
      else
        faceCountTable[faceId]=faceCountTable[faceId]+1
      end
      if i==FACE_SOLDIER_NUM then
        break
      end
    end--for fobstaff
    if#fobStaff==0 then
      for i=1,FACE_SOLDIER_NUM do
        faceCountTable[i]=1
      end
    end
    for faceId,numUsed in pairs(faceCountTable)do
      table.insert(faces,{faceId,numUsed,numUsed,0})
    end
  end--do
  do
    for i=FACE_SOLDIER_NUM+1,FACE_SOLDIER_NUM+maxSolNum do
      local staffId=fobStaff[i]
      if staffId==nil then
        break
      end
      local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
      if faceCountTable[faceId]==nil then
        hasFaceTable[faceId]=1
      end
      if i==maxSolNum then
        break
      end
    end
    for faceId,hasFace in pairs(hasFaceTable)do
      table.insert(faces,{faceId,0,0,0})
    end
  end--do

  --tex seperated out from below TODO: revert, no longer usng this branch
  if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
    TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts"
  elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
    TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts"
  elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
    TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts"
  else
    TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts"
  end

  local balaclavas={}
  if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava12,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
  elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava12,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
  elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
  else
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    table.insert(balaclavas,{TppEnemyFaceId.dds_balaclava5,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
  end

  if this.IsUseGasMaskInFOB()then
    balaclavas={
      {TppEnemyFaceId.dds_balaclava8,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {TppEnemyFaceId.dds_balaclava9,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {TppEnemyFaceId.dds_balaclava10,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {TppEnemyFaceId.dds_balaclava11,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {TppEnemyFaceId.dds_balaclava13,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
      {TppEnemyFaceId.dds_balaclava15,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0}
    }
  end
  --RETAILPATCH 1.0.11>
  if TppMotherBaseManagement.GetMbsClusterSecurityIsEquipSwimSuit()then
    local swimsuitInfo=TppMotherBaseManagement.GetMbsClusterSecuritySwimSuitInfo()
    local partsPath
    if swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_1 then
      partsPath="/Assets/tpp/parts/chara/dlf/dlf1_enem0_def_v00.parts"
    elseif swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_2 then
      partsPath="/Assets/tpp/parts/chara/dlg/dlg1_enem0_def_v00.parts"
    elseif swimsuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_3 then
      partsPath="/Assets/tpp/parts/chara/dlh/dlh1_enem0_def_v00.parts"
    end
    TppSoldier2.SetDefaultPartsPath(partsPath)
  end
  --<
  for i,faceDef in ipairs(balaclavas)do
    table.insert(faces,faceDef)
  end
end

--tex mbqf, broken out from fovaSetupFuncs.mtbs
--tex NMC normal mb faces are set up by f30050_sequence SetupStaffList / RegisterFovaFpk
mtbsFaceSetupFuncs[30250]=function(faces)
  local securityStaff=TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=TppMotherBaseManagementConst.SECTION_SECURITY}
  --local e=#securityStaff
  local numSoldiers=7--tex shifted constant from below, number of soldiers on ward (see f30250_enemy.lua)
  local faceCounts={}
  for n,staffId in pairs(securityStaff)do
    local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
    if faceCounts[faceId]==nil then
      faceCounts[faceId]=1
    else
      faceCounts[faceId]=faceCounts[faceId]+1
    end
    if n==numSoldiers then
      break
    end
  end
  for faceId,faceCount in pairs(faceCounts)do
    table.insert(faces,{faceId,faceCount,faceCount,0})
  end
  table.insert(faces,{TppEnemyFaceId.dds_balaclava6,numSoldiers,numSoldiers,0})
end

--Mission 43: shining lights
mtbsFaceSetupFuncs[10240]=function(faces)
  faces={
    {1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {3,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {4,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {5,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {6,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {7,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {8,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {9,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {14,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {15,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {16,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {17,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0},
    {18,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0}
  }
  table.insert(faces,{TppEnemyFaceId.dds_balaclava6,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
end

--Mission 2: Diamond Dogs
mtbsFaceSetupFuncs[10030]=function(faces)
  for i,faceId in ipairs(this.S10030_FaceIdList)do
    table.insert(faces,{faceId,1,1,0})
  end
  table.insert(faces,{TppEnemyFaceId.dds_balaclava0,this.S10030_useBalaclavaNum,this.S10030_useBalaclavaNum,0})
end

function fovaSetupFuncs.mtbs(locationName,missionId)
  if TppMission.IsHelicopterSpace(missionId)then
    return
  end

  if missionId==10240 then--tex WORKAROUND>
    fovaSetupFuncs.mbqf(locationName,missionId)
  end--<

  --face setup
  TppSoldierFace.SetSoldierOutsideFaceMode(false)
  local faces={}
  local ddSuit=TppEnemy.GetDDSuit()

  --tex> ddsuit headgear
  if IvarProc.EnabledForMission("customSoldierType",missionId) then
    for faceId, faceInfo in pairs(InfEneFova.ddHeadGearInfo) do
      table.insert(faces,{TppEnemyFaceId[faceId],MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end

    if missionId==30250 then
      mtbsFaceSetupFuncs[missionId](faces)
    end
    --<
  else
    --tex REWORKED r195
    if mtbsFaceSetupFuncs[missionId] then
      mtbsFaceSetupFuncs[missionId](faces)
    else
      for faceId=0,35 do
        table.insert(faces,{faceId,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      end
      table.insert(faces,{TppEnemyFaceId.dds_balaclava0,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(faces,{TppEnemyFaceId.dds_balaclava1,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
      table.insert(faces,{TppEnemyFaceId.dds_balaclava2,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
    end
  end-- face stuff

  TppSoldierFace.OverwriteMissionFovaData{face=faces}
  local bodies={}
  --tex> ddsuit bodies
  if IvarProc.EnabledForMission("customSoldierType",missionId) then
    local bodyInfo=InfEneFova.GetMaleBodyInfo(missionId)
    if bodyInfo and bodyInfo.partsPath then
      TppSoldier2.SetDefaultPartsPath(bodyInfo.partsPath)
    end

    --tex manage body limit (see InfBodyInfo GOTCHA)
    local maxBodies=InfMain.MAX_STAFF_NUM_ON_CLUSTER
    local halfMax=maxBodies/2
    local maleBodyCount=0
    local femaleBodyCount=0
    local maleBodyInfo=InfEneFova.GetMaleBodyInfo(missionId)
    local femaleBodyInfo=InfEneFova.GetFemaleBodyInfo(missionId)
    if maleBodyInfo and maleBodyInfo.bodyIds then
      maleBodyCount=#maleBodyInfo.bodyIds
    end
    if femaleBodyInfo and femaleBodyInfo.bodyIds then
      femaleBodyCount=#femaleBodyInfo.bodyIds
    end

    local maleBodyMax=maleBodyCount
    local femaleBodyMax=femaleBodyCount
    --ASSUMPTION: maxbodies is even
    if maleBodyCount+femaleBodyCount>maxBodies then
      maleBodyMax=math.min(maleBodyCount,halfMax)
      femaleBodyMax=math.min(femaleBodyCount,halfMax)
      if maleBodyMax<halfMax then
        local underFlow=halfMax-maleBodyCount
        femaleBodyMax=femaleBodyMax+underFlow
      end
      if femaleBodyMax<halfMax then
        local underFlow=halfMax-femaleBodyCount
        maleBodyMax=maleBodyMax+underFlow
      end
    end

    if maleBodyInfo then
      InfEneFova.SetupBodies(maleBodyInfo,bodies,maleBodyMax)
    end
    if femaleBodyInfo then
      InfEneFova.SetupBodies(femaleBodyInfo,bodies,femaleBodyMax)
    end

    if this.debugModule then
      InfCore.Log("maxBodies:"..maxBodies.." halfMax:"..halfMax)
      InfCore.Log("maleBodyCount:"..maleBodyCount.." femaleBodyCount:"..femaleBodyCount)
      InfCore.Log("maleBodyMax:"..maleBodyMax.." femaleBodyMax:"..femaleBodyMax)
      InfCore.PrintInspect(InfEneFova.bodiesForMap,"InfEneFova.bodiesForMap")
    end
    --<
  elseif TppMission.IsFOBMission(missionId) then
    if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
      bodies={{TppEnemyBodyId.dds4_enem0_def,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds4_enef0_def,MAX_REALIZED_COUNT}}
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      bodies={{TppEnemyBodyId.dds5_enem0_def,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds5_enef0_def,MAX_REALIZED_COUNT}}
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      bodies={{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT}}
    else
      bodies={{TppEnemyBodyId.dds5_main0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds6_main0_v00,MAX_REALIZED_COUNT}}
    end
    --RETAILPATCH 1.10>
    if TppMotherBaseManagement.GetMbsClusterSecurityIsEquipSwimSuit()then
      local securitySwimSuitGrade=TppMotherBaseManagement.GetMbsClusterSecuritySwimSuitGrade()
      bodies={{securitySwimSuitBodies.female[securitySwimSuitGrade],MAX_REALIZED_COUNT},{securitySwimSuitBodies.male[securitySwimSuitGrade],MAX_REALIZED_COUNT}}
    end
    --<
  else
    bodies={{TppEnemyBodyId.dds3_main0_v00,MAX_REALIZED_COUNT},{TppEnemyBodyId.dds8_main0_v00,MAX_REALIZED_COUNT}}
  end
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}

  --tex> dd suit SetExtendPartsInfo
  if IvarProc.EnabledForMission("customSoldierType",missionId) then
    --tex only female uses extendparts
    local bodyInfo=InfEneFova.GetFemaleBodyInfo()
    if bodyInfo and bodyInfo.partsPath then
      TppSoldier2.SetExtendPartsInfo{type=1,path=bodyInfo.partsPath}
    end
    --<
    --not ddogs, shining lights
  elseif not(missionId==10030 or missionId==10240)then
    if TppMission.IsFOBMission(missionId) then
      if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts"}
      elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts"}
      elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      else
        TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts"}
      end
      --RETAILPATCH 1.0.11>
      if TppMotherBaseManagement.GetMbsClusterSecurityIsEquipSwimSuit()then
        local swimSuitInfo=TppMotherBaseManagement.GetMbsClusterSecuritySwimSuitInfo()
        local partsPath
        if swimSuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_1 then
          partsPath="/Assets/tpp/parts/chara/dlf/dlf0_enem0_def_f_v00.parts"
        elseif swimSuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_2 then
          partsPath="/Assets/tpp/parts/chara/dlg/dlg0_enem0_def_f_v00.parts"
        elseif swimSuitInfo==TppMotherBaseManagementConst.SWIM_SUIT_TYPE_3 then
          partsPath="/Assets/tpp/parts/chara/dlh/dlh0_enem0_def_f_v00.parts"
        end
        TppSoldier2.SetExtendPartsInfo{type=1,path=partsPath}
      end
      --<
      --not M22 retake platform
    elseif missionId~=10115 and missionId~=11115 then
      TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts"}
    end
  end
  TppSoldierFace.SetSoldierUseHairFova(true)
end

--tex >ASSUMPTION customSoldierType true WIP
function fovaSetupFuncs.mtbsCustomBody(locationName,missionId)
  if TppMission.IsHelicopterSpace(missionId)then
    return
  end

  if missionId==10240 then--tex WORKAROUND>
    fovaSetupFuncs.mbqf(locationName,missionId)
  end--<

  --face setup
  TppSoldierFace.SetSoldierOutsideFaceMode(false)
  TppSoldierFace.SetSoldierUseHairFova(true)

  local faces={}
  --tex headgear, faces on mb are handled by f30050_sequence.RegisterFovaFpk
  --TODO: dont add headgear if bodyInfo is non ddheadgear (check both genders)
  for faceId, faceInfo in pairs(InfEneFova.ddHeadGearInfo) do
    table.insert(faces,{TppEnemyFaceId[faceId],MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,0})
  end

  if missionId==30250 then
    mtbsFaceSetupFuncs[missionId](faces)
  end
  TppSoldierFace.OverwriteMissionFovaData{face=faces}

  --tex bodies
  local bodies={}
  local bodyInfo=InfEneFova.GetMaleBodyInfo(missionId)
  if bodyInfo then
    InfEneFova.SetupBodies(bodyInfo,bodies,InfMain.MAX_STAFF_NUM_ON_CLUSTER)
    if bodyInfo.partsPath then
      TppSoldier2.SetDefaultPartsPath(bodyInfo.partsPath)
    end
  end

  local bodyInfo=InfEneFova.GetFemaleBodyInfo()
  if bodyInfo then
    InfEneFova.SetupBodies(bodyInfo,bodies,InfMain.MAX_STAFF_NUM_ON_CLUSTER)
    --tex only female uses extendparts
    if bodyInfo.partsPath then
      TppSoldier2.SetExtendPartsInfo{type=1,path=bodyInfo.partsPath}
    end
  end
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
end
--<
function fovaSetupFuncs.cypr(locationName,missionId)
  local faces={}
  for e=0,5 do
    table.insert(faces,e)
  end
  TppSoldierFace.SetPoolTable{face=faces}
  TppSoldierFace.SetSoldierNoFaceResourceMode(true)
  local bodies={{TppEnemyBodyId.wss0_main0_v00,MAX_REALIZED_COUNT}}
  TppSoldierFace.OverwriteMissionFovaData{body=bodies}
end
function fovaSetupFuncs.default(locationName,missionId)
  TppSoldierFace.SetMissionFovaData{face={},body={}}
  if missionId>6e4 then
    local face={{30,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT,MAX_REALIZED_COUNT}}
    TppSoldierFace.OverwriteMissionFovaData{face=face}
  end
end
function this.AddTakingOverHostagePack()
  local settings={}
  for n,name in ipairs(TppEnemy.TAKING_OVER_HOSTAGE_LIST)do
    local takingOverHostageCount=n-1
    if takingOverHostageCount>=gvars.ene_takingOverHostageCount then
      break
    end
    local entry={type="hostage",name=name,faceId=gvars.ene_takingOverHostageFaceIds[takingOverHostageCount]}
    table.insert(settings,entry)
  end
  this.AddUniqueSettingPackage(settings)
end
function this.PreMissionLoad(missionId,currentMissionId)
  TppSoldier2.SetEnglishVoiceIdTable{voice={}}
  TppSoldierFace.SetMissionFovaData{face={},body={}}
  TppSoldierFace.ResetForPreMissionLoad()
  TppSoldier2.SetDisableMarkerModelEffect{enabled=false}
  TppSoldier2.SetDefaultPartsPath()
  TppSoldier2.SetExtendPartsInfo{}
  TppHostage2.ClearDefaultBodyFovaId()
  --NMC: don't know why this isn't in TppEnemy.PreMissionLoad
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF() then
    local soldierEquipGrade=TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local isNoKillMode=TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
    TppEnemy.PrepareDDParameter(soldierEquipGrade,isNoKillMode)
  end
  --tex REWORKED>
  --tex the respective area name fova functions have been renamed to match locationName output (ex fovaSetupFuncs.Afghan to fovaSetupFuncs.afgh)
  local locationName=InfUtil.GetLocationName()
  local fovaFuncName="default"
  if fovaSetupFuncs[missionId] then
    fovaFuncName=missionId
  elseif fovaSetupFuncs[locationName] then
    fovaFuncName=locationName
  end

  InfCore.LogFlow("TppEneFova.PreMissionLoad locationName:"..tostring(locationName).." missionId:"..tostring(missionId))--tex DEBUG
  --tex 1st parameter wasn't actually used in vanilla, only for the switch/case, might as well repurpose it
  InfCore.PCallDebug(fovaSetupFuncs[fovaFuncName],locationName,missionId)

  InfMain.PreMissionLoad(missionId,currentMissionId)--tex added
  --<
  --ORIG
  --  local _fovaSetupFuncs=Select(fovaSetupFuncs)
  --  if fovaSetupFuncs[missionId]==nil then
  --    if TppMission.IsHelicopterSpace(missionId)then
  --      _fovaSetupFuncs:case("default",missionId)
  --    elseif TppLocation.IsAfghan()then
  --      _fovaSetupFuncs:case("Afghan",missionId)
  --    elseif TppLocation.IsMiddleAfrica()then
  --      _fovaSetupFuncs:case("Africa",missionId)
  --    elseif TppLocation.IsMBQF()then
  --      _fovaSetupFuncs:case("Mbqf",missionId)
  --    elseif TppLocation.IsMotherBase()then
  --      _fovaSetupFuncs:case("Mb",missionId)
  --    elseif TppLocation.IsCyprus()then
  --      _fovaSetupFuncs:case("Cyprus",missionId)
  --    else
  --      _fovaSetupFuncs:case("default",missionId)
  --    end
  --  else
  --    _fovaSetupFuncs:case(missionId,missionId)
  --  end
end

local l_uniqueSettings={}
local l_uniqueFaceFovas={}
local l_uniqueBodyFovas={}
local l_hostageBodyIds={}
local ddHostageIndex=0
local femaleHostageIndex=0
local maleHostageIndex=0--tex
local faceIdS10081=0
local faceIdS10091_0=0
local faceIdS10091_1=0
local RENddIndexFlagMax=15
local ddHostageFlag=16
local femaleHostageFlag=32
local maleHostageFlag=64--tex
local defaultMaleFaceId=0

function this.InitializeUniqueSetting()
  InfCore.LogFlow"TppEneFova.InitializeUniqueSetting"--tex DEBUG
  l_uniqueSettings={}
  l_uniqueFaceFovas={}
  l_uniqueBodyFovas={}
  l_hostageBodyIds={}
  ddHostageIndex=0
  femaleHostageIndex=0
  faceIdS10081=0
  faceIdS10091_0=0
  faceIdS10091_1=0
  local NULL_ID=GameObject.NULL_ID
  local NOT_USED_FOVA_VALUE=EnemyFova.NOT_USED_FOVA_VALUE
  for i=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
    gvars.ene_fovaUniqueTargetIds[i]=NULL_ID
    gvars.ene_fovaUniqueFaceIds[i]=NOT_USED_FOVA_VALUE
    gvars.ene_fovaUniqueBodyIds[i]=NOT_USED_FOVA_VALUE
    gvars.ene_fovaUniqueBodyIds[i]=NOT_USED_FOVA_VALUE
    if gvars.ene_fovaUniqueFlags then
      gvars.ene_fovaUniqueFlags[i]=0
    end
  end
end
function this.GetStaffIdForDD(missionId,ddIndex)
  local staffId=defaultMaleFaceId
  if missionId==10081 then
    staffId=TppMotherBaseManagement.GetStaffS10081()
  elseif missionId==10091 or missionId==11091 then
    local setStaffsS10091=TppMotherBaseManagement.GetStaffsS10091()
    if setStaffsS10091 and ddIndex<#setStaffsS10091 then
      staffId=setStaffsS10091[ddIndex+1]
    end
  elseif missionId==10115 or missionId==11115 then
    local staffsS10115=TppMotherBaseManagement.GetStaffsS10115()
    if staffsS10115 and ddIndex<#staffsS10115 then
      staffId=staffsS10115[ddIndex+1]
    end
  end
  return staffId
end
function this.GetFaceIdForDdHostage(missionId)
  local facegroupIndex=ddHostageIndex
  ddHostageIndex=ddHostageIndex+1
  local staffId=this.GetStaffIdForDD(missionId,facegroupIndex)
  local ddIndexFlagged=bit.bor(ddHostageFlag,facegroupIndex)
  if staffId~=defaultMaleFaceId then
    local faceId=TppMotherBaseManagement.StaffIdToFaceId{staffId=staffId}
    if missionId==10081 then
      faceIdS10081=faceId
    elseif missionId==10091 or missionId==11091 then
      if facegroupIndex>0 then
        faceIdS10091_1=faceId
      else
        faceIdS10091_0=faceId
      end
    end
    return faceId,ddIndexFlagged
  end
  local faceGroupIndex=(gvars.hosface_groupNumber+facegroupIndex)%30
  local randomFaceId=50+faceGroupIndex
  if TppSoldierFace.GetRandomFaceId~=nil then
    local useIndex=gvars.solface_groupNumber+facegroupIndex
    randomFaceId=TppSoldierFace.GetRandomFaceId{race={0,2,3},gender=0,useIndex=useIndex}
  end
  if missionId==10081 then
    faceIdS10081=randomFaceId
  elseif missionId==10091 or missionId==11091 then
    if facegroupIndex>0 then
      faceIdS10091_1=randomFaceId
    else
      faceIdS10091_0=randomFaceId
    end
  end
  return randomFaceId,ddIndexFlagged
end
function this.GetFaceId_s10081()
  return faceIdS10081
end
function this.GetFaceId_s10091_0()
  return faceIdS10091_0
end
function this.GetFaceId_s10091_1()
  return faceIdS10091_1
end
function this.GetFaceIdForFemaleHostage(missionCode)
  local flag=femaleHostageFlag
  if missionCode==10086 then
    return 613,flag
  end
  local facegroupIndex=femaleHostageIndex
  femaleHostageIndex=femaleHostageIndex+1
  local race={}
  table.insert(race,0)
  if TppLocation.IsAfghan()then
    table.insert(race,3)
  elseif TppLocation.IsMiddleAfrica()then
    table.insert(race,2)
    table.insert(race,3)
  end
  local useIndex=gvars.solface_groupNumber+facegroupIndex
  local faceId=EnemyFova.INVALID_FOVA_VALUE
  if TppSoldierFace.GetRandomFaceId~=nil then
    faceId=TppSoldierFace.GetRandomFaceId{race=race,gender=1,useIndex=useIndex}
    if faceId~=EnemyFova.INVALID_FOVA_VALUE then
      return faceId,flag
    else
      local faceGroup=(gvars.hosface_groupNumber+facegroupIndex)%50
      faceId=350+faceGroup
    end
  else
    local faceGroup=(gvars.hosface_groupNumber+facegroupIndex)%50
    faceId=350+faceGroup
  end
  return faceId,flag
end
--tex>
function this.GetFaceIdForMaleHostage(missionCode)
  local flag=maleHostageFlag
  local facegroupIndex=maleHostageIndex
  maleHostageIndex=maleHostageIndex+1
  local race={}
  table.insert(race,0)
  if TppLocation.IsAfghan()then
    table.insert(race,3)
  elseif TppLocation.IsMiddleAfrica()then
    table.insert(race,2)
    table.insert(race,3)
  end
  local useIndex=gvars.solface_groupNumber+facegroupIndex
  local faceId=EnemyFova.INVALID_FOVA_VALUE
  if TppSoldierFace.GetRandomFaceId~=nil then
    faceId=TppSoldierFace.GetRandomFaceId{race=race,gender=0,useIndex=useIndex}
    if faceId~=EnemyFova.INVALID_FOVA_VALUE then
      return faceId,flag
    else
      local faceGroup=(gvars.hosface_groupNumber+facegroupIndex)%50
      faceId=350+faceGroup
    end
  else
    local faceGroup=(gvars.hosface_groupNumber+facegroupIndex)%50
    faceId=350+faceGroup
  end
  return faceId,flag
end
--<
function this.GetFaceIdAndFlag(fovaType,faceId)
  local NOT_USED_FOVA_VALUE=EnemyFova.NOT_USED_FOVA_VALUE
  if faceId=="female"then
    if fovaType=="hostage"then
      return this.GetFaceIdForFemaleHostage(vars.missionCode)
    else
      return NOT_USED_FOVA_VALUE,0
    end
  elseif faceId=="male"then--tex>
    if fovaType=="hostage"then
      return this.GetFaceIdForMaleHostage(vars.missionCode)
  else
    return NOT_USED_FOVA_VALUE,0
  end
  --<
  elseif faceId=="dd"then
    if fovaType=="hostage"then
      return this.GetFaceIdForDdHostage(vars.missionCode)
    else
      return NOT_USED_FOVA_VALUE,0
    end
  end
  return faceId,0
end
function this.RegisterUniqueSetting(uniqueType,name,faceId,bodyId)
  local NOT_USED_FOVA_VALUE=EnemyFova.NOT_USED_FOVA_VALUE
  local faceId,flag=this.GetFaceIdAndFlag(uniqueType,faceId)
  if faceId==nil then
    faceId=NOT_USED_FOVA_VALUE
  end
  if bodyId==nil then
    bodyId=NOT_USED_FOVA_VALUE
  end
  table.insert(l_uniqueSettings,{name=name,faceId=faceId,bodyId=bodyId,flag=flag})
  do
    local faceIdEntryIdx=1
    local eneFaceCountEntryIdx=2
    local eneFaceCountEntryIdx2=3
    local hosFaceCountEntryIdx=4
    local faceFova=nil
    for i,_faceFova in ipairs(l_uniqueFaceFovas)do
      if _faceFova[faceIdEntryIdx]==faceId then
        faceFova=_faceFova
      end
    end
    if not faceFova then
      faceFova={faceId,0,0,0}
      table.insert(l_uniqueFaceFovas,faceFova)
    end
    if uniqueType=="enemy"then
      faceFova[eneFaceCountEntryIdx]=faceFova[eneFaceCountEntryIdx]+1
      faceFova[eneFaceCountEntryIdx2]=faceFova[eneFaceCountEntryIdx2]+1
    elseif uniqueType=="hostage"then
      faceFova[hosFaceCountEntryIdx]=faceFova[hosFaceCountEntryIdx]+1
    end
  end
  do
    local bodyIdx1=1
    local bodyIdx2=2
    local bodyFova=nil
    for i,_bodyFova in ipairs(l_uniqueBodyFovas)do
      if _bodyFova[bodyIdx1]==bodyId then
        bodyFova=_bodyFova
      end
    end
    if not bodyFova then
      bodyFova={bodyId,0}
      table.insert(l_uniqueBodyFovas,bodyFova)
    end
    bodyFova[bodyIdx2]=bodyFova[bodyIdx2]+1
    if uniqueType=="hostage"then
      local hostageBodyId=bodyId
      for i,_bodyId in ipairs(l_hostageBodyIds)do
        if _bodyId==bodyId then
          hostageBodyId=nil
          break
        end
      end
      if hostageBodyId then
        table.insert(l_hostageBodyIds,hostageBodyId)
      end
    end
  end
end
function this.AddUniqueSettingPackage(uniqueSettings)
  if uniqueSettings and type(uniqueSettings)=="table"then
    for n,uniqueSetting in ipairs(uniqueSettings)do
      this.RegisterUniqueSetting(uniqueSetting.type,uniqueSetting.name,uniqueSetting.faceId,uniqueSetting.bodyId,uniqueSetting.missionCode)
    end
  end
  TppSoldierFace.OverwriteMissionFovaData{face=l_uniqueFaceFovas,body=l_uniqueBodyFovas,additionalMode=true}
  if#l_hostageBodyIds>0 then
    TppSoldierFace.SetBodyFovaUserType{hostage=l_hostageBodyIds}
  end
end
function this.AddUniquePackage(uniqueSettings)
  TppSoldierFace.OverwriteMissionFovaData{face=uniqueSettings.face,body=uniqueSettings.body,additionalMode=true}
  if uniqueSettings.body and uniqueSettings.type=="hostage"then
    local hostageFaceFova={}
    for i,setting in ipairs(uniqueSettings.body)do
      table.insert(hostageFaceFova,setting[1])
    end
    if#hostageFaceFova>0 then
      TppSoldierFace.SetBodyFovaUserType{hostage=hostageFaceFova}
    end
  end
end
function this.ApplyUniqueSetting()
  InfCore.LogFlow("ApplyUniqueSetting: #"..#l_uniqueSettings.. " UniqueSettings")--tex DEBUG
  local NULL_ID=GameObject.NULL_ID
  local NOT_USED_FOVA_VALUE=EnemyFova.NOT_USED_FOVA_VALUE
  if gvars.ene_fovaUniqueTargetIds[0]==NULL_ID then
    local i=0
    for n,uniqueSetting in ipairs(l_uniqueSettings)do
      local soldierId=GameObject.GetGameObjectId(uniqueSetting.name)

      if soldierId~=NULL_ID then
        if i<TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT then
          gvars.ene_fovaUniqueTargetIds[i]=soldierId
          gvars.ene_fovaUniqueFaceIds[i]=uniqueSetting.faceId
          gvars.ene_fovaUniqueBodyIds[i]=uniqueSetting.bodyId
          if gvars.ene_fovaUniqueFlags then
            gvars.ene_fovaUniqueFlags[i]=uniqueSetting.flag
          end
        end
        i=i+1
      end
    end
  end
  local band=bit.band
  for n=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
    local soldierId=gvars.ene_fovaUniqueTargetIds[n]
    if soldierId==NULL_ID then
      break
    end
    local faceId=gvars.ene_fovaUniqueFaceIds[n]--tex>
    local isFemale=InfEneFova.IsFemaleFace(faceId)
    InfEneFova.SetFemaleSoldier(soldierId,isFemale)--<
    local command={id="ChangeFova",faceId=gvars.ene_fovaUniqueFaceIds[n],bodyId=gvars.ene_fovaUniqueBodyIds[n]}
    GameObject.SendCommand(soldierId,command)
    local fovaUniqueFlag=0
    if gvars.ene_fovaUniqueFlags then
      fovaUniqueFlag=gvars.ene_fovaUniqueFlags[n]
    end
    if band(fovaUniqueFlag,ddHostageFlag)~=0 then
      local missionId=vars.missionCode
      local ddIndex=band(fovaUniqueFlag,RENddIndexFlagMax)
      local staffId=this.GetStaffIdForDD(missionId,ddIndex)
      if staffId~=defaultMaleFaceId then
        local command={id="SetStaffId",staffId=staffId}
        GameObject.SendCommand(soldierId,command)
      end
      local command={id="SetHostage2Flag",flag="dd",on=true}
      GameObject.SendCommand(soldierId,command)
    elseif band(fovaUniqueFlag,maleHostageFlag)~=0 then--tex>
      local command={id="SetHostage2Flag",flag="dd",on=true}
      GameObject.SendCommand(soldierId,command)
      --<
    elseif band(fovaUniqueFlag,femaleHostageFlag)~=0 then
      local command={id="SetHostage2Flag",flag="female",on=true}
      GameObject.SendCommand(soldierId,command)
    end
  end
end
function this.ApplyMTBSUniqueSetting(soldierId,faceId,useBalaclava,forceNoBalaclava)
  --InfCore.Log("ApplyMTBSUniqueSetting: start:"..soldierId)--tex DEBUG
  local bodyId=0
  local balaclavaFaceId=EnemyFova.INVALID_FOVA_VALUE
  local ddSuit=TppEnemy.GetDDSuit()
  local function IsFemale(faceId)
    local faceTypeList=TppSoldierFace.CheckFemale{face={faceId}}
    return faceTypeList and faceTypeList[1]==1
  end
  local isFemale=IsFemale(faceId)--tex>
  InfEneFova.SetFemaleSoldier(soldierId,isFemale)--<
  --tex set bodyid >
  if IvarProc.EnabledForMission("customSoldierType") then
    local powerSettings=mvars.ene_soldierPowerSettings[soldierId]
    --DEBUG
    if not powerSettings then
      InfCore.Log("ApplyMTBSUniqueSetting: No powersettings for soldierId:"..soldierId)
    end
    local bodyInfo=nil
    if isFemale then
      bodyInfo=InfEneFova.GetFemaleBodyInfo()
    else
      bodyInfo=InfEneFova.GetMaleBodyInfo()
    end
    if bodyInfo then
      GameObject.SendCommand(soldierId,{id="UseExtendParts",enabled=isFemale})

      if bodyId==0 or bodyId==nil then--tex dont set body, rely on GetBodyId
        local soldierType=TppEnemy.GetSoldierType(soldierId)
        local subTypeName=TppEnemy.GetSoldierSubType(soldierId,soldierType)
        powerSettings=powerSettings or {}
        bodyId=TppEnemy.GetBodyId(soldierId,soldierType,subTypeName,powerSettings)
        --InfCore.Log("bodyid:".. tostring(bodyId))--tex DEBUG
      end

      if bodyInfo.hasFace then
        faceId=EnemyFova.NOT_USED_FOVA_VALUE
      end

      InfEneFova.ApplyCustomBodyPowers(soldierId,powerSettings)

      if not bodyInfo.helmetOnly then
        if this.IsUseGasMaskInFOB() then
          TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
        end
        --tex TEST: I'm guessing this would return 0/1 like the rest of the TppMotherBaseManagement grades when in mbfree so not much point
        --      if((TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS and TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS>=3)and TppMotherBaseManagement.GetMbsNvgBattleLevel)and TppMotherBaseManagement.GetMbsNvgBattleLevel()>0 then
        --        TppEnemy.AddPowerSetting(soldierId,{"NVG"})
        --      end
      end
      --if is customSoldierType<
    end

    if Ivars.mbDDHeadGear:Is(0) then
      if powerSettings then
        powerSettings.HELMET=nil
        powerSettings.GAS_MASK=nil
        powerSettings.NVG=nil
      end
    end

    --tex -v-gasmask trumps force head-^- like vanilla RETHINK
    if this.IsUseGasMaskInMBFree()then
      TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
    end

    if Ivars.mbDDHeadGear:Is(1) then
      local powerSettings=mvars.ene_soldierPowerSettings[soldierId]
      local wantHeadgear = useBalaclava or powerSettings and (powerSettings.HELMET or powerSettings.GAS_MASK or powerSettings.NVG)
      if wantHeadgear and bodyInfo and bodyInfo.useDDHeadgear then
        powerSettings=powerSettings or {}

        local isFemale=InfEneFova.IsFemaleFace(faceId)
        local validHeadGearIds=InfEneFova.GetHeadGearForPowers(powerSettings,isFemale,bodyInfo)
        if #validHeadGearIds>0 then
          local rnd=math.random(#validHeadGearIds)--tex random seed management outside the function since it's called in a loop
          balaclavaFaceId=TppEnemyFaceId[ validHeadGearIds[rnd] ]
        end
      end
      if balaclavaFaceId==nil or balaclavaFaceId==EnemyFova.INVALID_FOVA_VALUE then
        if bodyInfo.hasFace then
          balaclavaFaceId=EnemyFova.NOT_USED_FOVA_VALUE
        else
          balaclavaFaceId=nil
        end
      end
    end
    --<
  elseif TppMission.IsFOBMission(vars.missionCode) then
    if ddSuit==TppEnemy.FOB_DD_SUIT_SNEAKING then
      if((TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT and TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT>=3)
        and TppMotherBaseManagement.GetMbsNvgSneakingLevel)and TppMotherBaseManagement.GetMbsNvgSneakingLevel()>0 then
        TppEnemy.AddPowerSetting(soldierId,{"NVG"})
      end
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds4_enef0_def
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava14
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava4
        end
      else
        bodyId=TppEnemyBodyId.dds4_enem0_def
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava12
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava1
        end
      end
    elseif ddSuit==TppEnemy.FOB_DD_SUIT_BTRDRS then
      if((TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS and TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS>=3)and TppMotherBaseManagement.GetMbsNvgBattleLevel)and TppMotherBaseManagement.GetMbsNvgBattleLevel()>0 then
        TppEnemy.AddPowerSetting(soldierId,{"NVG"})
      end
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds5_enef0_def
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava14
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          end
        elseif useBalaclava then
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava4
        end
      else
        bodyId=TppEnemyBodyId.dds5_enem0_def
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava12
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
          end
        elseif useBalaclava then
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava1
        end
      end
    elseif ddSuit==TppEnemy.FOB_PF_SUIT_ARMOR then
      if not IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.pfa0_v00_a
        local command={id="UseExtendParts",enabled=false}
        GameObject.SendCommand(soldierId,command)
        TppEnemy.AddPowerSetting(soldierId,{"ARMOR"})
      end
    else-- no special suit
      if IsFemale(faceId)==true then
        bodyId=TppEnemyBodyId.dds6_main0_v00
        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(soldierId,command)
        if useBalaclava then
          if TppEnemy.IsHelmet(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava3
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava5
          end
        end
    else
      bodyId=TppEnemyBodyId.dds5_main0_v00
      local command={id="UseExtendParts",enabled=false}
      GameObject.SendCommand(soldierId,command)
      if useBalaclava then
        if TppEnemy.IsHelmet(soldierId)then
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava0
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava2
        end
      end
    end
    end--if fob suits/body
    --RETAILPATCH 1.10>
    if TppMotherBaseManagement.GetMbsClusterSecurityIsEquipSwimSuit()then
      local securitySwimsuitGrade=TppMotherBaseManagement.GetMbsClusterSecuritySwimSuitGrade()
      if IsFemale(faceId)then
        bodyId=securitySwimSuitBodies.female[securitySwimsuitGrade]
      else
        bodyId=securitySwimSuitBodies.male[securitySwimsuitGrade]
      end
    end
    --<
    if this.IsUseGasMaskInFOB()and ddSuit~=TppEnemy.FOB_PF_SUIT_ARMOR then
      if IsFemale(faceId)then
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava15
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava11
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava10
        end
      else
        if TppEnemy.IsHelmet(soldierId)then
          if TppEnemy.IsNVG(soldierId)then
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava13
          else
            balaclavaFaceId=TppEnemyFaceId.dds_balaclava9
          end
        else
          balaclavaFaceId=TppEnemyFaceId.dds_balaclava8
        end
      end
      TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
    end
    -- not fob
  else
    if IsFemale(faceId)then
      bodyId=TppEnemyBodyId.dds8_main0_v00
      local command={id="UseExtendParts",enabled=true}
      GameObject.SendCommand(soldierId,command)
      if useBalaclava then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava5
      end
      if this.IsUseGasMaskInMBFree()then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava7
        TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
      end
    else
      bodyId=TppEnemyBodyId.dds3_main0_v00
      local command={id="UseExtendParts",enabled=false}
      GameObject.SendCommand(soldierId,command)
      if useBalaclava then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava2
      end
      if this.IsUseGasMaskInMBFree()then
        balaclavaFaceId=TppEnemyFaceId.dds_balaclava6
        TppEnemy.AddPowerSetting(soldierId,{"GAS_MASK"})
      end
    end--if gender
  end

  if forceNoBalaclava then
    balaclavaFaceId=EnemyFova.NOT_USED_FOVA_VALUE
  end
  local command={id="ChangeFova",faceId=faceId,bodyId=bodyId,balaclavaFaceId=balaclavaFaceId}
  GameObject.SendCommand(soldierId,command)
end
function this.IsUseGasMaskInMBFree(e)
  local isPandemic=TppMotherBaseManagement.IsPandemicEventMode()
  local isNotCommand=mvars.f30050_currentFovaClusterId~=TppDefine.CLUSTER_DEFINE.Command
  return isPandemic and isNotCommand
end
function this.IsUseGasMaskInFOB()
  local setUav,uavType,isNLUav=this.GetUavSetting()
  return isNLUav
end
function this.GetUavSetting()--RETAILPATCH: 1060 reworked
  local uavLevel=TppMotherBaseManagement.GetMbsUavLevel{}
  local uavSmokeLevel=TppMotherBaseManagement.GetMbsUavSmokeGrenadeLevel{}
  local uavSleepingLevel=TppMotherBaseManagement.GetMbsUavSleepingGusGrenadeLevel{}
  local soldierEquipGrade=InfMain.GetMbsClusterSecuritySoldierEquipGrade()--tex was TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  local isNoKillMode=InfMain.GetMbsClusterSecurityIsNoKillMode()--tex was TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
  local uavType=TppUav.DEVELOP_LEVEL_LMG_0
  local setUav=false
  local isNLUav=false
  local defaultUavType=100--RETAILPATCH 1080, following was 0, now defaultUavType
  local lethalUavType=defaultUavType
  local nonLethalUavType=defaultUavType
  local sleepUavType=defaultUavType

  --ORPHAN:
  --  local r=7
  --  local r=4
  --  local r=3
  --  local r=3
  --  local r=3
  local minEquipGrade=3
  local lmgLv1EquipGrade=6
  local lmgLv2EquipGrade=7
  if soldierEquipGrade<minEquipGrade then
    lethalUavType=defaultUavType
  elseif uavLevel>0 then
    if uavLevel==1 then
      lethalUavType=TppUav.DEVELOP_LEVEL_LMG_0
    elseif uavLevel==2 then
      if soldierEquipGrade>=lmgLv1EquipGrade then
        lethalUavType=TppUav.DEVELOP_LEVEL_LMG_1
      else
        lethalUavType=TppUav.DEVELOP_LEVEL_LMG_0
      end
    elseif uavLevel==3 then
      if soldierEquipGrade>=lmgLv2EquipGrade then
        lethalUavType=TppUav.DEVELOP_LEVEL_LMG_2
      elseif soldierEquipGrade>=lmgLv1EquipGrade then
        lethalUavType=TppUav.DEVELOP_LEVEL_LMG_1
      else
        lethalUavType=TppUav.DEVELOP_LEVEL_LMG_0
      end
    end
  end
  local minNLEquipGrade=4
  local smokeLv1EquipGrade=6
  local smokeLv2EquipGrade=7
  if soldierEquipGrade<minNLEquipGrade then
    nonLethalUavType=defaultUavType
  elseif uavLevel>0 then
    if uavSmokeLevel==1 then
      nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_0
    elseif uavSmokeLevel==2 then
      if soldierEquipGrade>=smokeLv1EquipGrade then
        nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_1
      else
        nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_0
      end
    elseif uavSmokeLevel==3 then
      if soldierEquipGrade>=smokeLv2EquipGrade then
        nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_2
      elseif soldierEquipGrade>=smokeLv1EquipGrade then
        nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_1
      else
        nonLethalUavType=TppUav.DEVELOP_LEVEL_SMOKE_0
      end
    end
  end
  local sleepEquipGrade=8
  if soldierEquipGrade<sleepEquipGrade then
    sleepUavType=defaultUavType
  else
    if uavSleepingLevel==1 then
      sleepUavType=TppUav.DEVELOP_LEVEL_SLEEP_0
    end
  end
  if uavLevel==0 then
    setUav=false
  else
    if isNoKillMode==true then
      if sleepUavType~=defaultUavType then
        uavType=sleepUavType
        setUav=true
        isNLUav=true
      elseif nonLethalUavType~=defaultUavType then
        uavType=nonLethalUavType
        setUav=true
        isNLUav=true
      elseif lethalUavType~=defaultUavType then
        uavType=lethalUavType
        setUav=true
      else
        setUav=false
      end
    else
      if lethalUavType~=defaultUavType then
        uavType=lethalUavType
        setUav=true
      else
        setUav=false
      end
    end
  end
  return setUav,uavType,isNLUav
end
--<
--RETAILPATCH 1090>
function this.GetUavCombatGradeAndEmpLevel(p1,p2,p3,p4)
  if p1<9 then
    return nil,0
  end
  local d={
    [9]={4,2},
    [10]={5,3},
    [11]={6,4}
  }
  local n,e
  if p2 then
    e=2
    n=p4
  else
    e=1
    n=p3
  end
  local a
  for t,d in pairs(d)do
    if d[e]==n then
      a=t
    end
  end
  if not a then
    if n>d[11][e]then
    end
    return nil,0
  end
  local e,n
  if p1<=a then
    e=p1
  else
    e=a
  end
  n=e-8
  return e,n
end
--<
function this.GetUniqueSettings()--tex>
  return l_uniqueSettings
end--<
return this

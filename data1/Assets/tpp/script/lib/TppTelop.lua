-- DOBUILD: 1
local this={}
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local RENsomeNumber=3
local RENsomeNumber2=6
local RENsomeNumber3=1
local sideStartInfo={
  CAST_MODE={
    LEFT_START={"LeftCenter","RightCenter","LeftUp","RightUp"},
    RIGHT_START={"RightCenter","LeftCenter","RightUp","LeftUp"}
  },
  STAFF_MODE={
    LEFT_START={"LeftCenter","LeftUp","RightCenter","RightUp"},
    RIGHT_START={"RightCenter","RightUp","LeftCenter","LeftUp"}
  }
}
function this.GetRandomStartSide()
  if mvars.tlp_startSide then
    return mvars.tlp_startSide
  end
  if(os.time()%2)==0 then
    return"LEFT_START"
  else
    return"RIGHT_START"
  end
end
function this.GetTelopPosition(e,a,t)
  local e=sideStartInfo[e][a]
  local t=t%4+1
  return e[t]
end
function this.GetFirstLangId(t,e)
  if t==1 then
    return e
  else
    return""
  end
end
function this.GetLangIdTable(e)
  if IsTable(e)then
    return e
  elseif IsString(e)then
    return{e}
  else
    return{}
  end
end
function this.StartCastTelop(startSide)
  if TppSequence.GetContinueCount()>0 then
    return
  end
  if startSide then
    mvars.tlp_startSide=startSide
  end
  if Ivars.telopMode:Is(0) then--tex cast telop bypass
    this.PostMainCharacters(mvars.tlp_mainCharacters)
    this.PostEnemyCombatants(mvars.tlp_enemyCombatants)
    this.PostGuestCharacters(mvars.tlp_guestCharacters)
    this.PostSpecialMechanics(mvars.tlp_specialMechanics)
    this.PostLevelDesign(mvars.tlp_levelDesigners)
    this.PostWrittenBy(mvars.tlp_writers)
    this.PostCreativeProducers()
    this.PostDirectedBy()
  end
  this.PostMissionObjective(vars.locationCode,vars.missionCode)
  TppUiCommand.StartTelopCast()
end
function this.StartMissionObjective()
  if TppSequence.GetContinueCount()>0 then
    return
  end
  this.PostMissionObjective(vars.locationCode,vars.missionCode)
  TppUiCommand.StartTelopCast()
end
function this.PostMainCharacters(characters)
  if not next(characters)then
    return
  end
  local s=this.GetRandomStartSide()
  for a,n in ipairs(characters)do
    local i=this.GetFirstLangId(a,"post_starring")
    local a=this.GetTelopPosition("CAST_MODE",s,a-1)
    local e=this.GetLangIdTable(n)
    TppUiCommand.RegistTelopCast(a,RENsomeNumber,i,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function this.PostGuestCharacters(a)
  if not next(a)then
    return
  end
  local s=this.GetRandomStartSide()
  for a,i in ipairs(a)do
    local n=this.GetFirstLangId(a,"post_guest_characters")
    local a=this.GetTelopPosition("CAST_MODE",s,a-1)
    local e=this.GetLangIdTable(i)
    TppUiCommand.RegistTelopCast(a,RENsomeNumber,n,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function this.PostEnemyCombatants(a)
  if not next(a)then
    return
  end
  local s=this.GetRandomStartSide()
  for a,i in ipairs(a)do
    local n=this.GetFirstLangId(a,"post_Enemy_Combatants")
    local a=this.GetTelopPosition("CAST_MODE",s,a-1)
    local e=this.GetLangIdTable(i)
    TppUiCommand.RegistTelopCast(a,RENsomeNumber,n,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function this.PostSpecialMechanics(a)
  if not next(a)then
    return
  end
  local s=this.GetRandomStartSide()
  for a,n in ipairs(a)do
    local i=this.GetFirstLangId(a,"post_special_mechanic")
    local a=this.GetTelopPosition("CAST_MODE",s,a-1)
    local e=this.GetLangIdTable(n)
    TppUiCommand.RegistTelopCast(a,RENsomeNumber,i,e[1],e[2],e[3],e[4])
    TppUiCommand.RegistTelopCast("PageBreak",1)
  end
end
function this.PostLevelDesign(a)
  if not next(a)then
    return
  end
  local n=this.GetRandomStartSide()
  local e=this.GetTelopPosition("STAFF_MODE",n,1)
  TppUiCommand.RegistTelopCast(e,RENsomeNumber,"post_level_design",a[1],a[2])
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function this.PostWrittenBy(e)
  if not next(e)then
    return
  end
  TppUiCommand.RegistTelopCast("LeftUp",RENsomeNumber,"post_wrriten_by",e[1],e[2])
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function this.PostCreativeProducers()
  TppUiCommand.RegistTelopCast("RightUp",RENsomeNumber,"post_Creative_Producers","staff_yoshikazu_matsuhana","staff_yuji_korekado")
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function this.PostDirectedBy()
  TppUiCommand.RegistTelopCast("RightCenter",RENsomeNumber,"post_Created_and_Directed_by","staff_hideo_kojima")
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function this.PostMissionObjective(locationCode,missionCode)
  if(missionCode>=11e3)and(missionCode<12e3)then
    missionCode=missionCode-1e3
  end
  local t=string.format("obj_mission_%2d_%5d_00",locationCode,missionCode)
  local e=string.format("obj_mission_en_%2d_%5d_00",locationCode,missionCode)
  if AssetConfiguration.GetDefaultCategory"Language"=="jpn"then
    TppUiCommand.RegistTelopCast("CenterLarge",RENsomeNumber2,t,e)
  else
    TppUiCommand.RegistTelopCast("CenterLarge",RENsomeNumber2,t)
  end
  TppUiCommand.RegistTelopCast("PageBreak",1)
end
function this.Init(missionTable)
  TppUiCommand.AllResetTelopCast()
  mvars.tlp_mainCharacters={"cast_venom_snake","cast_sharashka_ocelot","cast_kazuhira_miller"}
  mvars.tlp_guestCharacters={}
  mvars.tlp_enemyCombatants={}
  mvars.tlp_specialMechanics={}
  mvars.tlp_levelDesigners={"staff_tsuyoshi_osada","staff_satoshi_matsuno"}
  mvars.tlp_writers={"staff_shuyo_murata"}
  if not missionTable.telop then
    return
  end
  local telop=missionTable.telop
  mvars.tlp_mainCharacters=telop.mainCharacterLangList
  if telop.cfaLangList then
    mvars.tlp_cfa=telop.cfaLangList
  end
  if telop.guestCharacterLangList then
    mvars.tlp_guestCharacters=telop.guestCharacterLangList
  end
  if telop.enemyCombatantsLangList then
    mvars.tlp_enemyCombatants=telop.enemyCombatantsLangList
  end
  if telop.specialMechanicLangList then
    mvars.tlp_specialMechanics=telop.specialMechanicLangList
  end
  mvars.tlp_levelDesigners=telop.missionLevelDesigner
  mvars.tlp_writers=telop.missionWriter
end
return this

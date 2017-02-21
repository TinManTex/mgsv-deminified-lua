local this={}
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
this.saveQueueDepth=0
this.saveQueueList={}
local function SetRequestSaveResult(requestSuccess)
  if gvars.sav_isReservedMbSaveResultNotify then
    gvars.sav_isReservedMbSaveResultNotify=false
    if requestSuccess then
      TppMotherBaseManagement.SetRequestSaveResultSuccess()
    else
      TppMotherBaseManagement.SetRequestSaveResultFailure()
    end
  end
end
this.SAVE_RESULT_FUNCTION={
  [Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)
  end,
  [Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)
    if e==false then
      return
    end
    if(vars.isPersonalDirty==1)then
      vars.isPersonalDirty=0
    end
  end,
  [Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=SetRequestSaveResult,
  [Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=SetRequestSaveResult
}
function this.GetSaveFileVersion(category)
  return(TppDefine.SAVE_FILE_INFO[category].version+TppDefine.PROGRAM_SAVE_FILE_VERSION[category]*TppDefine.PROGRAM_SAVE_FILE_VERSION_OFFSET)
end
function this.IsExistConfigSaveFile()
  return TppScriptVars.FileExists(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function this.IsExistPersonalSaveFile()
  return TppScriptVars.FileExists(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function this.ForbidSave()
  gvars.permitGameSave=false
end
function this.IsForbidSave()--RETAILPATCH 1070>
  return(not gvars.permitGameSave)
end--<
function this.NeedWaitSavingErrorCheck()
  if gvars.sav_SaveResultCheckFileName==0 then
    return false
  else
    return true
  end
end
function this.IsSaving()
  if TppScriptVars.IsSavingOrLoading()then
    return true
  end
  if this.IsEnqueuedSaveData()then
    return true
  end
  if(gvars.sav_SaveResultCheckFileName~=0)then
    return true
  end
  return false
end
function this.IsSavingWithFileName(fileName)
  if gvars.sav_SaveResultCheckFileName==Fox.StrCode32(fileName)then
    return true
  else
    return false
  end
end
function this.HasQueue(fileName)
  if(this.GetSaveRequestFromQueue(fileName)~=nil)then
    return true
  else
    return false
  end
end
function this.GetSaveRequestFromQueue(fileName)
  for i=1,this.saveQueueDepth do
    if this.saveQueueList[i].fileName==fileName then
      return i,this.saveQueueList[i]
    end
  end
end
function this.EraseAllGameDataSaveRequest()
  local index,saveInfo
  repeat
    index,saveInfo=this.GetSaveRequestFromQueue(this.GetGameSaveFileName())
    if index then
      if(saveInfo.doSaveFunc==this.ReserveNoticeOfMbSaveResult)then
        TppMotherBaseManagement.SetRequestSaveResultFailure()
      end
      this.DequeueSave(index)
    end
  until(index==nil)
end
function this.IsEnqueuedSaveData()
  if this.saveQueueDepth>0 then
    return true
  else
    return false
  end
end
local IsEnqueuedSaveData=this.IsEnqueuedSaveData
function this.RegistCompositSlotSize(size)
  this.COMPOSIT_SLOT_SIZE=size
end
function this.SetUpCompositSlot()
  if this.COMPOSIT_SLOT_SIZE then
    TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,this.COMPOSIT_SLOT_SIZE)
  end
end
function this.SaveGameData(missionCode,needIcon,doSaveFunc,reserveNextMissionStartSave,isCheckPoiunt)
  if reserveNextMissionStartSave then
    this.ReserveNextMissionStartSave(this.GetGameSaveFileName(),isCheckPoiunt)
  else
    local saveInfo=this.GetSaveGameDataQueue(missionCode,needIcon,doSaveFunc,isCheckPoiunt)
    this.EnqueueSave(saveInfo)
  end
  this.CheckAndSavePersonalData(reserveNextMissionStartSave)
end
function this.GetSaveGameDataQueue(missionCode,needIcon,doSaveFunc,isCheckPoint)
  local gameSavefileName=this.GetGameSaveFileName()
  local saveInfo=this.GetIntializedCompositSlotSaveQueue(gameSavefileName,needIcon,doSaveFunc,isCheckPoint)--(fileName,needIcon,doSaveFunc,isCheckPoint)
  saveInfo=this._SaveGlobalData(saveInfo)
  saveInfo=this._SaveMissionData(saveInfo)
  saveInfo=this._SaveMissionRestartableData(saveInfo)
  saveInfo=this._SaveRetryData(saveInfo)
  saveInfo=this._SaveMbManagementData(saveInfo,missionCode)
  saveInfo=this._SaveQuestData(saveInfo)
  return saveInfo
end
function this.SaveConfigData(needIcon,doSave,reserveNextMissionStart)
  if doSave then
    local saveInfo=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,needIcon)
    return this.DoSave(saveInfo,true)
  elseif reserveNextMissionStart then
    this.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,needIcon)
  end
end
function this.SaveMGOData()
  this.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.SavePersonalData(needIcon,doSave,reserveNextMissionStartSave)
  if doSave then
    local saveInfo=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,needIcon)
    return this.DoSave(saveInfo,true)
  elseif reserveNextMissionStartSave then
    this.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,needIcon)
  end
end
function this.CheckAndSavePersonalData(reserveNextMissionStartSave)
  local fileName=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
  if this.IsSavingWithFileName(fileName)or this.HasQueue(fileName)then
    return
  end
  if(vars.isPersonalDirty==1)then
    this.VarSavePersonalData()
    this.SavePersonalData(nil,nil,reserveNextMissionStartSave)
  end
end
function this.SaveAvatarData()
  Player.SetEnableUpdateAvatarInfo(true)
  this.VarSavePersonalData()
  this.SavePersonalData()
end
function this.SaveOnlyMbManagement(doSaveFunc)
  local missionCode=vars.missionCode
  this.VarSaveMbMangement(missionCode)
  this.SaveGameData(missionCode,nil,doSaveFunc)
end
function this.ReserveNoticeOfMbSaveResult()
  gvars.sav_isReservedMbSaveResultNotify=true
end
function this.SaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  this.SaveGameData(vars.missionCode)
end
function this.SaveGzPrivilege()
  this.SaveMBAndGlobal()
end
function this.SaveMBAndGlobal()
  this.VarSaveMBAndGlobal()
  --this.SaveGameData(currentMissionCode)--RETAILBUG: orphan, variable isn't actually used though
  this.SaveGameData(vars.missionCode)
end
function this.VarSaveMBAndGlobal()
  local a=vars.missionCode
  this.VarSaveMbMangement(a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
this.DO_RESERVE_SAVE_FUNCTION={
  [TppDefine.CONFIG_SAVE_FILE_NAME]=this.SaveConfigData,
  [TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=this.SavePersonalData,
  [TppDefine.GAME_SAVE_FILE_NAME]=this.SaveGameData,
  [TppDefine.GAME_SAVE_FILE_NAME_TMP]=this.SaveGameData
}
function this.ReserveNextMissionStartSave(saveFileName,isCheckPoint)
  if not this.DO_RESERVE_SAVE_FUNCTION[saveFileName]then
    return
  end
  this.missionStartSaveFilePool=this.missionStartSaveFilePool or{}
  local missionStartSaveFile=this.missionStartSaveFilePool[saveFileName]or{}
  if missionStartSaveFile and isCheckPoint then
    missionStartSaveFile.isCheckPoint=isCheckPoint
  end
  this.missionStartSaveFilePool[saveFileName]=missionStartSaveFile
end
function this.DoReservedSaveOnMissionStart()
  if not this.missionStartSaveFilePool then
    return
  end
  local platform=Fox.GetPlatformName()
  if platform=="Xbox360"or platform=="XboxOne"then
    if not SignIn.IsSignedIn()then
      this.missionStartSaveFilePool=nil
      return
    end
  end
  for n,a in pairs(this.missionStartSaveFilePool)do
    local ReserveSaveFunc=this.DO_RESERVE_SAVE_FUNCTION[n]
    ReserveSaveFunc(nil,nil,nil,nil,a.isCheckPoint)
  end
  this.missionStartSaveFilePool=nil
end
function this._SaveGlobalData(saveInfo)
  if TppScriptVars.StoreUtcTimeToScriptVars then
    TppScriptVars.StoreUtcTimeToScriptVars()
  end
  return this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this._SaveMissionData(saveInfo)
  return this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function this._SaveRetryData(saveInfo)
  return this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function this.CanSaveMbMangementData(missionCode)
  local missionId=missionCode or vars.missionCode
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return false
  end
  return(missionId~=10030)or(not gvars.isMissionClearedS10030)
end
function this._SaveMbManagementData(saveInfo,missionCode)
  return this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function this._SaveQuestData(saveInfo)
  return this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)
end
function this._SaveMissionRestartableData(saveInfo)
  saveInfo=this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  saveInfo=this.AddSlotToSaveQueue(saveInfo,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  return saveInfo
end
function this.MakeNewGameSaveData(acquirePrivilegeInTitleScreen)
  TppVarInit.InitializeOnNewGameAtFirstTime()
  TppVarInit.InitializeOnNewGame()
  if acquirePrivilegeInTitleScreen then
    TppTerminal.AcquirePrivilegeInTitleScreen()
  end
  this.VarSave(vars.missionCode,true)
  this.VarSaveOnRetry()
  local saveInfo,saveResult=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    saveInfo=this.GetSaveGameDataQueue(vars.missionCode)
    saveResult=this.DoSave(saveInfo,true)
  end
  if acquirePrivilegeInTitleScreen then
    this.CheckAndSavePersonalData()
  end
  return saveResult
end
function this.SaveImportedGameData()
  local saveInfo,saveResult=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    saveInfo=this.GetSaveGameDataQueue(vars.missionCode)
    saveResult=this.DoSave(saveInfo,true)
  end
  return saveResult
end
function this.GetIntializedCompositSlotSaveQueue(fileName,needIcon,doSaveFunc,isCheckPoint)
  return{fileName=fileName,needIcon=needIcon,doSaveFunc=doSaveFunc,isCheckPoint=isCheckPoint}
end
function this.AddSlotToSaveQueue(saveInfo,slot,savingSlot,category)
  if slot==nil then
    return
  end
  if savingSlot==nil then
    return
  end
  if category==nil then
    return
  end
  local returnSaveInfo=saveInfo or{}
  returnSaveInfo.savingSlot=savingSlot
  returnSaveInfo.slot=returnSaveInfo.slot or{}
  returnSaveInfo.category=returnSaveInfo.category or{}
  local n=#returnSaveInfo.slot+1
  returnSaveInfo.slot[n]=slot
  returnSaveInfo.category[n]=category
  return returnSaveInfo
end
function this.EnqueueSave(saveInfoOrType,slot,category,fileName,needIcon)
  if saveInfoOrType==nil then
    return
  end
  if(gvars.isLoadedInitMissionOnSignInUserChanged or TppException.isLoadedInitMissionOnSignInUserChanged)or TppException.isNowGoingToMgo then
    return
  end
  local saveInfo
  if Tpp.IsTypeTable(saveInfoOrType)then
    saveInfo=saveInfoOrType
  else
    if slot==nil then
      return
    end
    if category==nil then
      return
    end
  end
  if gvars.permitGameSave==false then
    return
  end
  this.saveQueueDepth=this.saveQueueDepth+1
  if saveInfo then
    this.saveQueueList[this.saveQueueDepth]=saveInfo
  else
    this.saveQueueList[this.saveQueueDepth]=this.MakeNewSaveQueue(saveInfoOrType,slot,category,fileName,needIcon)
  end
end
function this.MakeNewSaveQueue(slot,savingSlot,category,fileName,needIcon,saveFunc)
  local saveInfo={}
  saveInfo.slot=slot
  saveInfo.savingSlot=savingSlot
  saveInfo.category=category
  saveInfo.fileName=fileName
  saveInfo.needIcon=needIcon
  saveInfo.doSaveFunc=saveFunc
  return saveInfo
end
function this.DequeueSave(index)
  if(index==nil)then
    index=1
  end
  for i=index,(this.saveQueueDepth-1)do
    this.saveQueueList[i]=this.saveQueueList[i+1]
  end
  if(this.saveQueueDepth<=0)then
    return
  end
  this.saveQueueList[this.saveQueueDepth]=nil
  this.saveQueueDepth=this.saveQueueDepth-1
end
function this.ProcessSaveQueue()
  if not IsEnqueuedSaveData()then
    return false
  end
  local saveParams=this.saveQueueList[1]
  if saveParams then
    local saveResult=this.DoSave(saveParams)
    if saveResult~=nil then
      this.DequeueSave()
      if saveResult==TppScriptVars.WRITE_FAILED then
        if(gvars.sav_SaveResultCheckFileName~=0)then
          local CheckFileName=this.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
          if CheckFileName then
            CheckFileName(false)
          end
          gvars.sav_SaveResultCheckFileName=0
        end
        TppException.ShowSaveErrorPopUp(TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON)
      end
    end
  end
end
function this.DoSave(saveParams,n)
  local r=true
  if n then
    r=false
  end
  local category
  local saveFileVersion
  local fileName
  local needIcon
  local doSaveFunc
  local isCheckPoint
  if Tpp.IsTypeTable(saveParams.slot)then
    this.SetUpCompositSlot()
    fileName=saveParams.fileName
    needIcon=saveParams.needIcon
    doSaveFunc=saveParams.doSaveFunc
    isCheckPoint=saveParams.isCheckPoint
    for S,t in ipairs(saveParams.slot)do
      category=saveParams.category[S]
      saveFileVersion=this.GetSaveFileVersion(category)
      TppScriptVars.CopySlot({saveParams.savingSlot,t},t)
    end
  else
    category=saveParams.category
    if category then
      saveFileVersion=this.GetSaveFileVersion(category)
      fileName=saveParams.fileName
      needIcon=saveParams.needIcon
      doSaveFunc=saveParams.doSaveFunc
      TppScriptVars.CopySlot(saveParams.savingSlot,saveParams.slot)
    else
      return false
    end
  end
  if doSaveFunc then
    doSaveFunc()
  end
  local saveResult=TppScriptVars.WriteSlotToFile(saveParams.savingSlot,fileName,needIcon)
  if r then
    gvars.sav_SaveResultCheckFileName=Fox.StrCode32(fileName)
    if isCheckPoint then
      gvars.sav_isCheckPointSaving=true
    end
  end
  return saveResult
end
function this.Update()
  if(not IsSavingOrLoading())then
    if(gvars.sav_SaveResultCheckFileName~=0)then
      local success=true
      local lastResult=TppScriptVars.GetLastResult()
      local errorId,popupId=this.GetSaveResultErrorMessage(lastResult)
      if errorId then
        success=false
        TppUiCommand.ShowErrorPopup(errorId,popupId)
      end
      local SaveResultFunc=this.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
      if SaveResultFunc then
        SaveResultFunc(success)
      end
      gvars.sav_SaveResultCheckFileName=0
      gvars.sav_isCheckPointSaving=false
    end
    if not PatchDlc.IsCheckingPatchDlc()then
      if this.IsEnqueuedSaveData()then
        this.ProcessSaveQueue()
      end
    end
  end
  if IsSavingOrLoading()then
    local saveState=TppScriptVars.GetSaveState()
    if saveState==TppScriptVars.STATE_SAVING then
      if gvars.sav_isCheckPointSaving then
        TppUI.ShowSavingIcon"checkpoint"
      else
        TppUI.ShowSavingIcon()
      end
    end
    if saveState==TppScriptVars.STATE_LOADING then
      TppUI.ShowLoadingIcon()
    end
    if saveState==TppScriptVars.STATE_PROCESSING then
      TppUI.ShowLoadingIcon()
    end
  end
end
this.SaveErrorMessageIdTable={[TppScriptVars.RESULT_ERROR_INVALID_STORAGE]={TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,Popup.TYPE_ONE_BUTTON}}
function this.GetSaveResultErrorMessage(result)
  if result==TppScriptVars.RESULT_OK then
    return
  end
  local errorInfo=this.SaveErrorMessageIdTable[result]
  if errorInfo then
    return errorInfo[1],errorInfo[2]
  else
    return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Messages()
  return Tpp.StrCode32Table{
    UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,
      func=function()
        this.ForbidSave()
      end}}}
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.WaitingAllEnqueuedSaveOnStartMission()
  while IsSavingOrLoading()do
    this.CoroutineYieldWithShowSavingIcon()
  end
  while IsEnqueuedSaveData()do
    this.ProcessSaveQueue()
    while IsSavingOrLoading()do
      this.CoroutineYieldWithShowSavingIcon()
    end
  end
end
function this.CoroutineYieldWithShowSavingIcon()
  TppUI.ShowSavingIcon()
  coroutine.yield()
end
function this.SaveVarsToSlot(slot,group,category)
  local saveFileVersion=this.GetSaveFileVersion(category)
  TppScriptVars.SaveVarsToSlot(slot,group,category,saveFileVersion)
end
function this.VarSaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this.VarSave(a,n)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if n then
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    else
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
  end
  if this.CanSaveMbMangementData(a)then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveOnRetry()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveMbMangement(a,n)
  if this.CanSaveMbMangementData(a)or n then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
end
function this.VarSaveQuest(missionCode)
  if this.CanSaveMbMangementData(missionCode)then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
end
function this.VarSaveConfig()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
end
function this.VarSaveMGO()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MGO,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MGO)
end
function this.VarSavePersonalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_PERSONAL)
end
function this.LoadFromSaveFile(slot,area,fileName)
  if not fileName then
    return TppScriptVars.ReadSlotFromFile(slot,area)
  else
    return TppScriptVars.ReadSlotFromAreaFile(slot,fileName,area)
  end
end
function this.GetGameSaveFileName()
  do
    if TppSystemUtility.GetCurrentGameMode()=="MGO"then
      return TppDefine.MGO_MAIN_SAVE_FILE_NAME
    else
      return TppDefine.GAME_SAVE_FILE_NAME
    end
  end
end
function this.DEBUG_IsUsingTemporarySaveData()
  do
    return false
  end
  return gvars.DEBUG_usingTemporarySaveData
end
function this.LoadGameDataFromSaveFile(area)
  local fileName=this.GetGameSaveFileName()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,fileName,area)
end
local categories={
  TppScriptVars.CATEGORY_GAME_GLOBAL,
  TppScriptVars.CATEGORY_MISSION,
  TppScriptVars.CATEGORY_RETRY,
  TppScriptVars.CATEGORY_MB_MANAGEMENT,
  TppScriptVars.CATEGORY_QUEST,
  TppDefine.CATEGORY_MISSION_RESTARTABLE
}
function this.CheckGameDataVersion()
  for n,category in ipairs(categories)do
    local slot=TppDefine.SAVE_FILE_INFO[category].slot
    local result=this.CheckSlotVersion(category,TppDefine.SAVE_SLOT.SAVING)
    if result~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      return result
    end
    if TppDefine.SAVE_FILE_INFO[category].missionStartSlot then
      local checkSlotResult=this.CheckSlotVersion(category,TppDefine.SAVE_SLOT.SAVING,true)
      if checkSlotResult~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
        return checkSlotResult
      end
    end
  end
  return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function this.CopyGameDataFromSavingSlot()
  for n,category in ipairs(categories)do
    local slot=TppDefine.SAVE_FILE_INFO[category].slot
    TppScriptVars.CopySlot(slot,{TppDefine.SAVE_SLOT.SAVING,slot})
    local slot=TppDefine.SAVE_FILE_INFO[category].missionStartSlot
    if slot then
      TppScriptVars.CopySlot(slot,{TppDefine.SAVE_SLOT.SAVING,slot})
    end
  end
end
function this.LoadMGODataFromSaveFile()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.LoadConfigDataFromSaveFile(area)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,area)
end
function this.LoadPersonalDataFromSaveFile(area)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,area)
end
function this.CheckSlotVersion(category,n,useMissionStartSlot)
  local saveFileVersion=this.GetSaveFileVersion(category)
  local slot=TppDefine.SAVE_FILE_INFO[category].slot
  if useMissionStartSlot then
    slot=TppDefine.SAVE_FILE_INFO[category].missionStartSlot
  end
  if n then
    slot={n,slot}
  end
  local scriptVersionFromSlot=TppScriptVars.GetScriptVersionFromSlot(slot)
  if scriptVersionFromSlot==nil then
    return TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
  end
  if scriptVersionFromSlot<=saveFileVersion then
    return TppDefine.SAVE_FILE_LOAD_RESULT.OK
  else
    return TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
  end
end
function this.CheckSlotVersionConfigData()
  return this.CheckSlotVersion(TppScriptVars.CATEGORY_CONFIG)
end
function this.IsReserveVarRestoreForContinue()
  return gvars.sav_varRestoreForContinue
end
function this.ReserveVarRestoreForContinue()
  gvars.sav_varRestoreForContinue=true
end
function this.ReserveVarRestoreForMissionStart()
  gvars.sav_varRestoreForContinue=false
end
function this.VarRestoreOnMissionStart()
  if not TppMission.IsFOBMission(vars.missionCode)then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_GAME_GLOBAL)
    if gvars.usingNormalMissionSlot then
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MISSION)
      if TppSystemUtility.GetCurrentGameMode()~="MGO"then
        TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MISSION_START,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      end
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_RETRY)
    end
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MB_MANAGEMENT)
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_QUEST)
  end
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MGO,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MGO)
  end
  gvars.sav_varRestoreForContinue=false
end
function this.VarRestoreOnContinueFromCheckPoint()
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if TppSystemUtility.GetCurrentGameMode()~="MGO"then
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
  end
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MGO,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MGO)
  end
end
function this.DeleteGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME)
end
function this.DeleteTemporaryGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME_TMP)
end
function this.DeleteConfigSaveFile()
  TppScriptVars.DeleteFile(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function this.DeletePersonalDataSaveFile()
  TppScriptVars.DeleteFile(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function this.DeleteMGOSaveFile()
  TppScriptVars.DeleteFile(TppDefine.MGO_SAVE_FILE_NAME)
end
function this.IsNewGame()
  return gvars.isNewGame
end
function this.IsGameDataLoadResultOK()
  if(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK)or(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP)then
    return true
  else
    return false
  end
end
this.SAVE_FILE_OK_RESULT_TABLE={
  [TppScriptVars.RESULT_OK]=TppDefine.SAVE_FILE_LOAD_RESULT.OK,
  [TppScriptVars.RESULT_ERROR_LOAD_BACKUP]=TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP
}
function this.CheckGameSaveDataLoadResult()
  local lastResult=TppScriptVars.GetLastResult()
  local loadResult=this.SAVE_FILE_OK_RESULT_TABLE[lastResult]
  if loadResult then
    local gameDataVersion=this.CheckGameDataVersion()
    if gameDataVersion~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      gvars.gameDataLoadingResult=gameDataVersion
    else
      gvars.gameDataLoadingResult=loadResult
    end
  else
    if lastResult==TppScriptVars.RESULT_ERROR_NOSPACE then
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
    else
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
    end
  end
end
function this.GetGameDataLoadingResult()
  return gvars.gameDataLoadingResult
end
return this

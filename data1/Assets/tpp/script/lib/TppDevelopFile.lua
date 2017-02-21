local this={}
function this.OnMissionCanStart()
  if TppLocation.IsAfghan()then
    if TppQuest.IsActive"sovietBase_q60110"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_Stungun",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_Stungun",1)
    end
    if TppQuest.IsActive"sovietBase_q60111"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_UAV",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_UAV",1)
    end
    if TppQuest.IsActive"citadel_q60112"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_Infraredsensor",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_Infraredsensor",1)
    end
    if TppQuest.IsActive"ruins_q60115"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_q60115",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_q60115",1)
    end
  elseif TppLocation.IsMiddleAfrica()then
    if TppQuest.IsActive"outland_q60113"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_Theftprotection",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_Theftprotection",1)
    end
    if TppQuest.IsActive"pfCamp_q60114"==true then
      TppCollection.RepopCountOperation("SetAt","col_develop_GunCamera",0)
    else
      TppCollection.RepopCountOperation("SetAt","col_develop_GunCamera",1)
    end
  end
end
return this

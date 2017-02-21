if TppRadioCommand then
local e={0,30,40,50,60,70,80,90,98,255,55,255,255,255,255,255}
TppRadioCommand.RegisterPriorityTable(e)
local e={0,1,5,10,15,20,25,30,0,0,0,0,0,0,0,0}
TppRadioCommand.RegisterInvalidTimeTable(e)
local e={400,100,200,300,600,750,900,1100,1500,2e3,2500,3e3,500,4e3,5e3,6e3}
if TppRadioCommand.RegisterIntervalNextLabelTable then
TppRadioCommand.RegisterIntervalNextLabelTable(e)
end
if TppRadioCommand.RegisterWaitTimeForNoise then
local e={waitTimeAfterStartNoise=0,waitTimeBeforeEndNoise=400}
TppRadioCommand.RegisterWaitTimeForNoise(e)
end
end

-- DOBUILD: 1
local this={}
local maxSteps=256
local defaultStepNumber=0
local questNameNone=0
local defaultQuestBlockName="quest_block"
local questStepClear="QStep_Clear"
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local questBlockStatus=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}
local missionTypes=TppDefine.Enum{"MISSION","FREE","HELI"}
local QUEST_STATUS_TYPES=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}
local afgAreaList={"tent","field","ruins","waterway","cliffTown","commFacility","sovietBase","fort","citadel"}
local mafrAreaList={"outland","pfCamp","savannah","hill","banana","diamond","lab"}
local shootingPracticeMarkers={
  Command="ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|Marker_shootingPractice",
  Develop="ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|Marker_shootingPractice",
  Support="ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|Marker_shootingPractice",
  BaseDev="ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|Marker_shootingPractice",
  Medical="ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|Marker_shootingPractice",
  Spy="ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|Marker_shootingPractice",
  Combat="ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|Marker_shootingPractice"
}
this.prevMissionType=missionTypes.HELI
local sideOpsTable={
  --[[001--]]{questName="ruins_q19010",questId="ruins_q19010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1622.974,322.257,1062.973),radius=5},
  --[[XXX--]]{questName="commFacility_q19013",questId="commFacility_q19013",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1589.157,352.634,47.628),radius=5},
  --[[XXX--]]{questName="outland_q19011",questId="outland_q19011",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(222.113,20.445,-930.962),radius=5},
  --[[XXX--]]{questName="hill_q19012",questId="hill_q19012",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1910.658,59.872,-231.274),radius=5},
  --[[XXX--]]{questName="ruins_q60115",questId="quest_q60115",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(501.702,321.852,1194.651),radius=4.5},
  --[[XXX--]]{questName="sovietBase_q60110",questId="quest_q60110",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-719.57,536.851,-1571.775),radius=4.5},
  --[[XXX--]]{questName="citadel_q60112",questId="quest_q60112",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(785.013,473.162,-916.954),radius=4.5},
  --[[XXX--]]{questName="outland_q60113",questId="quest_q60113",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-281.612,-8.36,751.687),radius=4.5},
  --[[XXX--]]{questName="pfCamp_q60114",questId="quest_q60114",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(712.931,-3.225,1221.926),radius=4.5},
  --[[010--]]{questName="sovietBase_q60111",questId="quest_q60111",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-2330.799,438.515,-1568.261),radius=4.5},
  --[[XXX--]]{questName="tent_q10010",questId="tent_q10010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1426.164,319.449,1053.029),radius=5.5},
  --[[XXX--]]{questName="field_q10020",questId="field_q10020",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(574.394,320.805,1091.39),radius=5},
  --[[XXX--]]{questName="fort_q10080",questId="fort_q10080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2144.585,459.984,-1764.566),radius=5},
  --[[XXX--]]{questName="cliffTown_q10050",questId="cliffTown_q10050",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(545.646,339.103,7.983),radius=5},
  --[[XXX--]]{questName="waterway_q10040",questId="waterway_q10040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1200,399,-660),radius=5},
  --[[XXX--]]{questName="commFacility_q10060",questId="commFacility_q10060",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1580.025,346.609,47.889),radius=5},
  --[[XXX--]]{questName="pfCamp_q10200",questId="pfCamp_q10200",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1830.153,-12.065,1217.415),radius=5},
  --[[XXX--]]{questName="outland_q10100",questId="outland_q10100",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-1117,-22,-250),radius=5},
  --[[XXX--]]{questName="savannah_q10300",questId="savannah_q10300",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(352.291,-5.991,.927),radius=5},
  --[[020--]]{questName="banana_q10500",questId="banana_q10500",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(846.97,36.452,-917.762),radius=5},
  --[[XXX--]]{questName="hill_q10400",questId="hill_q10400",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2155.126,56.012,392.11),radius=5},
  --[[XXX--]]{questName="diamond_q10600",questId="diamond_q10600",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1611.429,128.189,-848.904),radius=5},
  --[[XXX--]]{questName="ruins_q10030",questId="ruins_q10030",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1301.97,331.741,1746.641),radius=5},
  --[[XXX--]]{questName="sovietBase_q10070",questId="sovietBase_q10070",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-2081.274,436.152,-1532.619),radius=5},
  --[[XXX--]]{questName="lab_q10700",questId="lab_q10700",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2695.907,154.625,-2304.778),radius=5},
  --[[XXX--]]{questName="citadel_q10090",questId="citadel_q10090",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1258.72,598.68,-3055.925),radius=5},
  --[[XXX--]]{questName="quest_q20065",questId="quest_q20065",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1481.748,359.7492,467.3845),radius=4.5},
  --[[XXX--]]{questName="quest_q20025",questId="quest_q20025",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(419.7284,270.3819,2206.412),radius=4.5},
  --[[XXX--]]{questName="quest_q20075",questId="quest_q20075",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-2200.667,443.142,-1632.121),radius=5},
  --[[030--]]{questName="quest_q20805",questId="quest_q20805",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1876.726,321.956,-426.263),radius=4.5},
  --[[XXX--]]{questName="quest_q20905",questId="quest_q20905",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1807.693,468.119,-1232.137),radius=4.5},
  --[[XXX--]]{questName="quest_q20305",questId="quest_q20305",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(303.023,-5.295,401.582),radius=5},
  --[[XXX--]]{questName="quest_q20035",questId="quest_q20035",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1444.029,332.4536,1493.478),radius=4.5},
  --[[XXX--]]{questName="quest_q23005",questId="quest_q23005",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(269.693,43.457,-1208.378),radius=4.5},
  --[[XXX--]]{questName="quest_q20045",questId="quest_q20045",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1721.014,349.7935,-300.9322),radius=4.5},
  --[[XXX--]]{questName="quest_q21005",questId="quest_q21005",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-902.816,288.046,1905.899),radius=4.5},
  --[[XXX--]]{questName="quest_q20105",questId="quest_q20105",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-318.246,-13.006,1078.101),radius=4},
  --[[XXX--]]{questName="quest_q24005",questId="quest_q24005",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2527.301,71.168,-817.188),radius=4.5},
  --[[XXX--]]{questName="quest_q20505",questId="quest_q20505",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(592.412,52.144,-955.067),radius=4},
  --[[040--]]{questName="quest_q20605",questId="quest_q20605",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1532.148,127.692,-1296.662),radius=5},
  --[[XXX--]]{questName="quest_q25005",questId="quest_q25005",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(967.334,-11.938,1269.883),radius=4.5},
  --[[XXX--]]{questName="quest_q27005",questId="quest_q27005",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2073.421,51.254,355.372),radius=4.5},
  --[[XXX--]]{questName="quest_q26005",questId="quest_q26005",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1728.982,155.168,-1869.883),radius=4.5},
  --[[XXX--]]{questName="quest_q20055",questId="quest_q20055",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(784.1397,474.0518,-1008.116),radius=4},
  --[[XXX--]]{questName="quest_q22005",questId="quest_q22005",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1326.552,598.564,-3041.07),radius=4.5},
  --[[XXX--]]{questName="quest_q20405",questId="quest_q20405",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2172.657,56.106,377.634),radius=4},
  --[[XXX--]]{questName="field_q30010",questId="field_q30010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(516.088,321.572,1065.328),radius=5},
  --[[XXX--]]{questName="waterway_q39010",questId="waterway_q39010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-473.987,417.258,-496.137),radius=7},
  --[[XXX--]]{questName="lab_q39011",questId="lab_q39011",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2656.23,144.117,-2173.246),radius=7},
  --[[050--]]{questName="pfCamp_q39012",questId="pfCamp_q39012",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1367.551,-3.12,1892.457),radius=7},
  --[[XXX--]]{questName="commFacility_q80060",questId="commFacility_q80060",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1385.748,368,-23.469),radius=5},
  --[[XXX--]]{questName="field_q80020",questId="field_q80020",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(482.031,286.844,2474.655),radius=5},
  --[[XXX--]]{questName="outland_q80100",questId="outland_q80100",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-454.016,3.955,977.738),radius=5},
  --[[XXX--]]{questName="pfCamp_q80200",questId="pfCamp_q80200",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(338.505,1.002,1746.528),radius=5},
  --[[XXX--]]{questName="diamond_q80600",questId="diamond_q80600",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1460.408,121.347,-1411.282),radius=5},
  --[[XXX--]]{questName="hill_q80400",questId="hill_q80400",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2566.009,68,-200.753),radius=5},
  --[[XXX--]]{questName="tent_q80010",questId="tent_q80010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1396.746,286.758,1009.375),radius=5},
  --[[XXX--]]{questName="lab_q80700",questId="lab_q80700",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2702.945,127.026,-1972.265),radius=5},
  --[[XXX--]]{questName="fort_q80080",questId="fort_q80080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1408.371,500.486,-1300.667),radius=5},
  --[[060--]]{questName="waterway_q80040",questId="waterway_q80040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1839.279,358.371,-339.326),radius=5},
  --[[XXX--]]{questName="quest_q20015",questId="quest_q20015",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1764.669,311.1947,805.5405),radius=4.5},--61 - Unlucky Dog 01>
  --[[XXX--]]{questName="quest_q20085",questId="quest_q20085",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2154.21,458.245,-1782.244),radius=4.5},
  --[[XXX--]]{questName="quest_q20205",questId="quest_q20205",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(911.094,-3.444,1072.21),radius=6},
  --[[XXX--]]{questName="quest_q20705",questId="quest_q20705",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2643.892,143.728,-2179.943),radius=7},
  --[[XXX--]]{questName="quest_q20095",questId="quest_q20095",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1216.737,609.074,-3102.734),radius=5.5},--65 - Unlucky Dog 05<
  --[[XXX--]]{questName="tent_q11010",questId="tent_q11010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1058.028,290.648,1472.578),radius=5},
  --[[XXX--]]{questName="tent_q11020",questId="tent_q11020",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1143.261,322.876,839.478),radius=5},
  --[[XXX--]]{questName="waterway_q11030",questId="waterway_q11030",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1347.736,397.481,-729.448),radius=5},
  --[[XXX--]]{questName="cliffTown_q11040",questId="cliffTown_q11040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(369.861,413.892,-905.375),radius=5},
  --[[070--]]{questName="savannah_q11400",questId="savannah_q11400",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1200.66,7.889,113.637),radius=5},
  --[[XXX--]]{questName="pfCamp_q11200",questId="pfCamp_q11200",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1555.195,-12.034,1790.219),radius=5},
  --[[XXX--]]{questName="commFacility_q11080",questId="commFacility_q11080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1475.388,344.972,13.41),radius=5},
  --[[XXX--]]{questName="fort_q11060",questId="fort_q11060",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1812.198,465.938,-1241.909),radius=5},
  --[[XXX--]]{questName="outland_q11090",questId="outland_q11090",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-386.984,9.648,762.663),radius=5},
  --[[XXX--]]{questName="banana_q11600",questId="banana_q11600",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(563.844,77.95,-1070.378),radius=5},
  --[[XXX--]]{questName="cliffTown_q11050",questId="cliffTown_q11050",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2383.08,86.157,-1125.214),radius=5},
  --[[XXX--]]{questName="hill_q11500",questId="hill_q11500",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2342.049,68.132,-104.587),radius=5},
  --[[XXX--]]{questName="savannah_q11300",questId="savannah_q11300",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(965.708,-4.035,287.023),radius=5},
  --[[XXX--]]{questName="banana_q11700",questId="banana_q11700",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(713.795,33.409,-904.592),radius=5},
  --[[080--]]{questName="fort_q11070",questId="fort_q11070",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2194.519,429.075,-1284.068),radius=5},
  --[[XXX--]]{questName="outland_q11100",questId="outland_q11100",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-552.513,-.011,-197.752),radius=5},
  --[[XXX--]]{questName="sovietBase_q99020",questId="sovietBase_q99020",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-716.5531,536.7278,-1485.517),radius=5,isImportant=true},
  --[[XXX--]]{questName="ruins_q60010",questId="ruins_q60010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1331.732,295.46,2164.405),radius=4},
  --[[XXX--]]{questName="tent_q60011",questId="tent_q60011",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-513.1647,372.9764,1148.782),radius=5},
  --[[XXX--]]{questName="outland_q60024",questId="outland_q60024",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-1205.26,-21.20666,129.0079),radius=5},
  --[[XXX--]]{questName="fort_q60013",questId="fort_q60013",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1921.452,456.3248,-1253.83),radius=4},
  --[[XXX--]]{questName="hill_q60021",questId="hill_q60021",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2151.132,70.83097,-116.7761),radius=4.5},
  --[[XXX--]]{questName="pfCamp_q60020",questId="pfCamp_q60020",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1555.736,-8.822165,1725.071),radius=4},
  --[[XXX--]]{questName="cliffTown_q60012",questId="cliffTown_q60012",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(369.4612,412.6812,-844.1393),radius=4},
  --[[090--]]{questName="banana_q60023",questId="banana_q60023",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(646.064,103.2225,-1122.37),radius=4},
  --[[XXX--]]{questName="sovietBase_q60014",questId="sovietBase_q60014",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1440.167,415.0882,-1282.796),radius=4},
  --[[XXX--]]{questName="lab_q60022",questId="lab_q60022",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2658.126,139.3819,-2146.524),radius=4},
  --[[XXX--]]{questName="quest_q52030",questId="quest_q52030",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1889.494,332.666,546.761),radius=5},
  --[[XXX--]]{questName="quest_q52010",questId="quest_q52010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1388.719,299.004,1976.527),radius=6},
  --[[XXX--]]{questName="quest_q52040",questId="quest_q52040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1589.128,511.561,-2113.037),radius=5},
  --[[XXX--]]{questName="quest_q52020",questId="quest_q52020",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-380.063,-2.53,490.478),radius=5},
  --[[XXX--]]{questName="quest_q52050",questId="quest_q52050",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(672.542,-3.727,108.875),radius=6},
  --[[XXX--]]{questName="quest_q52070",questId="quest_q52070",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2364.716,56.688,314.611),radius=5},
  --[[XXX--]]{questName="quest_q52060",questId="quest_q52060",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1156.773,-12.097,1524.507),radius=5},
  --[[100--]]{questName="quest_q52080",questId="quest_q52080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(793.002,347.536,255.957),radius=5},
  --[[XXX--]]{questName="quest_q52090",questId="quest_q52090",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1722.589,152.294,-2079.907),radius=5},
  --[[XXX--]]{questName="quest_q52100",questId="quest_q52100",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(810.898,-11.701,1194.177),radius=5},
  --[[XXX--]]{questName="quest_q52130",questId="quest_q52130",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1836.664,358.543,-326.481),radius=6},
  --[[XXX--]]{questName="quest_q52110",questId="quest_q52110",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-1007.882,-14.2,-231.401),radius=5},
  --[[XXX--]]{questName="quest_q52120",questId="quest_q52120",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(840.141,4.947,-130.741),radius=5},
  --[[XXX--]]{questName="quest_q52140",questId="quest_q52140",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-608.622,278.374,1694.876),radius=5},
  --[[XXX--]]{questName="outland_q99071",questId="quest_q99071",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-648.583,-18.483,1032.586),radius=5},
  --[[XXX--]]{questName="sovietBase_q99070",questId="quest_q99070",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-2127.887,436.594,-1564.366),radius=5},
  --[[XXX--]]{questName="tent_q99072",questId="quest_q99072",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1761.536,310.333,806.76),radius=5},
  --[[110--]]{questName="outland_q40010",questId="outland_q40010",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(222.904,20.496,-932.784),radius=5},
  --[[XXX--]]{questName="mtbs_q99011",questId="mtbs_q99011",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Medical,plntId=TppDefine.PLNT_DEFINE.Special,isImportant=true},
  --[[XXX--]]{questName="cliffTown_q99080",questId="cliffTown_q99080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(530.911,335.119,29.67),radius=5},
  --[[XXX--]]{questName="mtbs_q99050",questId="mtbs_q99050",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Develop,plntId=TppDefine.PLNT_DEFINE.Common1,isImportant=true},
  --[[XXX--]]{questName="quest_q52035",questId="quest_q52035",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(730.943,320.818,88.148),radius=5},
  --[[XXX--]]{questName="quest_q52025",questId="quest_q52025",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-608.622,278.374,1694.876),radius=5},
  --[[XXX--]]{questName="quest_q52015",questId="quest_q52015",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1836.664,358.543,-326.481),radius=6},
  --[[XXX--]]{questName="quest_q52075",questId="quest_q52075",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1349.26,11.259,285.945),radius=5},
  --[[XXX--]]{questName="quest_q52065",questId="quest_q52065",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(811.036,-11.657,1193.033),radius=5},
  --[[XXX--]]{questName="quest_q52045",questId="quest_q52045",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1722.589,152.294,-2079.907),radius=5},
  --[[120--]]{questName="quest_q52055",questId="quest_q52055",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-350.247,-2.555,-190.417),radius=5},
  --[[XXX--]]{questName="quest_q52095",questId="quest_q52095",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2429.92,61.019,189.081),radius=6},
  --[[XXX--]]{questName="quest_q52085",questId="quest_q52085",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1898.048,316.223,610.601),radius=5},
  --[[XXX--]]{questName="quest_q52105",questId="quest_q52105",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(672.542,-3.727,108.875),radius=5},
  --[[XXX--]]{questName="quest_q52135",questId="quest_q52135",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(1393.775,299.887,1910.528),radius=5},
  --[[XXX--]]{questName="quest_q52115",questId="quest_q52115",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-775.086,-3.786,563.539),radius=6},
  --[[XXX--]]{questName="quest_q52125",questId="quest_q52125",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1156.773,-12.097,1524.507),radius=6},
  --[[XXX--]]{questName="quest_q52145",questId="quest_q52145",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1589.128,511.561,-2113.037),radius=5},
  --[[XXX--]]{questName="tent_q71010",questId="quest_q71010",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1759.032,310.695,806.245),radius=5},
  --[[XXX--]]{questName="savannah_q71300",questId="quest_q71300",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(803.255,-11.806,1225.636),radius=5},
  --[[130--]]{questName="field_q71020",questId="quest_q71020",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(421.778,269.679,2207.088),radius=5},
  --[[XXX--]]{questName="lab_q71600",questId="quest_q71600",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2522.474,100.128,-896.065),radius=5},
  --[[XXX--]]{questName="tent_q71030",questId="quest_q71030",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-859.822,301.749,1954.213),radius=5},
  --[[XXX--]]{questName="sovietBase_q71070",questId="quest_q71070",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-675.085,533.228,-1482.026),radius=5},
  --[[XXX--]]{questName="cliffTown_q71050",questId="quest_q71050",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(527.023,328.63,50),radius=5},
  --[[XXX--]]{questName="lab_q71700",questId="quest_q71700",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2746.635,200.042,-2401.35),radius=5},
  --[[XXX--]]{questName="field_q71090",questId="quest_q71090",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(474.7,322.281,1062.864),radius=5},
  --[[XXX--]]{questName="waterway_q71040",questId="quest_q71040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1490.294,396.138,-792.581),radius=5},
  --[[XXX--]]{questName="fort_q71080",questId="quest_q71080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2080.718,456.726,-1927.582),radius=5},
  --[[XXX--]]{questName="cliffTown_q71060",questId="quest_q71060",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(782.651,463.722,-1027.08),radius=5},
  --[[140--]]{questName="diamond_q71500",questId="quest_q71500",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(1518,145,-2115),radius=5},
  --[[XXX--]]{questName="banana_q71400",questId="quest_q71400",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(278.127,42.996,-1232.378),radius=5},
  --[[XXX--]]{questName="outland_q71200",questId="quest_q71200",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-594.489,-17.482,1095.318),radius=5},
  --[[XXX--]]{questName="sovietBase_q99030",questId="sovietBase_q99030",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-2199.997,456.352,-1581.944),radius=6,isImportant=true},
  --[[XXX--]]{questName="tent_q99040",questId="tent_q99040",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1762.503,310.288,802.482),radius=5,isImportant=true},
  --[[XXX--]]{questName="outland_q20913",questId="quest_q20913",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(-958.532,-14.1,-224.044),radius=5,isImportant=true},
  --[[XXX--]]{questName="lab_q20914",questId="quest_q20914",locationId=TppDefine.LOCATION_ID.MAFR,iconPos=Vector3(2747.504,200.042,-2401.418),radius=5,isImportant=true},
  --[[XXX--]]{questName="sovietBase_q20912",questId="quest_q20912",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1573.917,369.848,-321.113),radius=5,isImportant=true},
  --[[XXX--]]{questName="tent_q20910",questId="quest_q20910",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-865.471,300.445,1949.157),radius=5,isImportant=true},
  --[[XXX--]]{questName="fort_q20911",questId="quest_q20911",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2181.73,470.912,-1815.881),radius=5,isImportant=true},
  --[[150--]]{questName="waterway_q99012",questId="waterway_q99012",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(-1335.904,398.264,-739.165),radius=5,isImportant=true},
  --[[XXX--]]{questName="mtbs_q42010",questId="mtbs_q42010",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Command,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42020",questId="mtbs_q42020",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Develop,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42030",questId="mtbs_q42030",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Support,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42040",questId="mtbs_q42040",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.BaseDev,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42060",questId="mtbs_q42060",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Spy,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42050",questId="mtbs_q42050",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Medical,plntId=TppDefine.PLNT_DEFINE.Special},
  --[[XXX--]]{questName="mtbs_q42070",questId="mtbs_q42070",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Combat,plntId=TppDefine.PLNT_DEFINE.Special}
}
this.questNameForUiIndex={}--tex>
for index,questInfo in ipairs(sideOpsTable) do
  this.questNameForUiIndex[index]=questInfo.questName
end--<
local questRadioList={
  ruins_q19010={radioNameFirst="f1000_rtrg0700"},
  outland_q19011={radioNameFirst="f1000_rtrg4380"},
  hill_q19012={radioNameFirst="f1000_rtrg4390"},
  commFacility_q19013={radioNameFirst="f1000_rtrg4370"},
  tent_q20910={radioNameFirst="f2000_rtrg8320",radioNameSecond="f2000_rtrg1560"},
  fort_q20911={radioNameFirst="f2000_rtrg8320",radioNameSecond="f2000_rtrg1560"},
  sovietBase_q20912={radioNameFirst="f2000_rtrg8320",radioNameSecond="f2000_rtrg1560"},
  outland_q20913={radioNameFirst="f2000_rtrg8320",radioNameSecond="f2000_rtrg1560"},
  lab_q20914={radioNameFirst="f2000_rtrg8320",radioNameSecond="f2000_rtrg1560"},
  cliffTown_q99080={radioNameFirst="f2000_rtrg1561"}
}
local questCompleteLangIds={
  tent_q10010="quest_extract_elite",
  field_q10020="quest_extract_elite",
  ruins_q10030="quest_extract_elite",
  waterway_q10040="quest_extract_elite",
  cliffTown_q10050="quest_extract_elite",
  commFacility_q10060="quest_extract_elite",
  sovietBase_q10070="quest_extract_elite",
  fort_q10080="quest_extract_elite",
  citadel_q10090="quest_extract_elite",
  outland_q10100="quest_extract_elite",
  pfCamp_q10200="quest_extract_elite",
  savannah_q10300="quest_extract_elite",
  hill_q10400="quest_extract_elite",
  banana_q10500="quest_extract_elite",
  diamond_q10600="quest_extract_elite",
  lab_q10700="quest_extract_elite",
  tent_q11010="quest_defeat_armor",
  tent_q11020="quest_defeat_armor",
  waterway_q11030="quest_defeat_armor",
  cliffTown_q11040="quest_defeat_armor",
  cliffTown_q11050="quest_defeat_armor",
  fort_q11060="quest_defeat_armor",
  fort_q11070="quest_defeat_armor",
  commFacility_q11080="quest_defeat_armor",
  outland_q11090="quest_defeat_armor",
  outland_q11100="quest_defeat_armor",
  pfCamp_q11200="quest_defeat_armor",
  savannah_q11300="quest_defeat_armor",
  savannah_q11400="quest_defeat_armor",
  hill_q11500="quest_defeat_armor",
  banana_q11600="quest_defeat_armor",
  banana_q11700="quest_defeat_armor",
  tent_q71010="quest_defeat_zombie",
  field_q71020="quest_defeat_zombie",
  tent_q71030="quest_defeat_zombie",
  waterway_q71040="quest_defeat_zombie",
  cliffTown_q71050="quest_defeat_zombie",
  cliffTown_q71060="quest_defeat_zombie",
  sovietBase_q71070="quest_defeat_zombie",
  fort_q71080="quest_defeat_zombie",
  field_q71090="quest_defeat_zombie",
  outland_q71200="quest_defeat_zombie",
  savannah_q71300="quest_defeat_zombie",
  banana_q71400="quest_defeat_zombie",
  diamond_q71500="quest_defeat_zombie",
  lab_q71600="quest_defeat_zombie",
  lab_q71700="quest_defeat_zombie",
  quest_q20015="quest_extract_hostage",
  quest_q20025="quest_extract_hostage",
  quest_q20035="quest_extract_hostage",
  quest_q20045="quest_extract_hostage",
  quest_q20055="quest_extract_hostage",
  quest_q20065="quest_extract_hostage",
  quest_q20075="quest_extract_hostage",
  quest_q20085="quest_extract_hostage",
  quest_q20095="quest_extract_hostage",
  quest_q20105="quest_extract_hostage",
  quest_q20205="quest_extract_hostage",
  quest_q20305="quest_extract_hostage",
  quest_q20405="quest_extract_hostage",
  quest_q20505="quest_extract_hostage",
  quest_q20605="quest_extract_hostage",
  quest_q20705="quest_extract_hostage",
  quest_q20805="quest_extract_hostage",
  quest_q20905="quest_extract_hostage",
  quest_q21005="quest_extract_hostage",
  quest_q22005="quest_extract_hostage",
  quest_q23005="quest_extract_hostage",
  quest_q24005="quest_extract_hostage",
  quest_q25005="quest_extract_hostage",
  quest_q26005="quest_extract_hostage",
  quest_q27005="quest_extract_hostage",
  quest_q52010="quest_defeat_armor_vehicle",
  quest_q52020="quest_defeat_armor_vehicle",
  quest_q52030="quest_defeat_armor_vehicle",
  quest_q52040="quest_defeat_armor_vehicle",
  quest_q52050="quest_defeat_armor_vehicle",
  quest_q52060="quest_defeat_armor_vehicle",
  quest_q52070="quest_defeat_armor_vehicle",
  quest_q52080="quest_defeat_armor_vehicle",
  quest_q52090="quest_defeat_armor_vehicle",
  quest_q52100="quest_defeat_armor_vehicle",
  quest_q52110="quest_defeat_armor_vehicle",
  quest_q52120="quest_defeat_armor_vehicle",
  quest_q52130="quest_defeat_armor_vehicle",
  quest_q52140="quest_defeat_armor_vehicle",
  quest_q52015="quest_defeat_tunk",
  quest_q52025="quest_defeat_tunk",
  quest_q52035="quest_defeat_tunk",
  quest_q52045="quest_defeat_tunk",
  quest_q52055="quest_defeat_tunk",
  quest_q52065="quest_defeat_tunk",
  quest_q52075="quest_defeat_tunk",
  quest_q52085="quest_defeat_tunk",
  quest_q52095="quest_defeat_tunk",
  quest_q52105="quest_defeat_tunk",
  quest_q52115="quest_defeat_tunk",
  quest_q52125="quest_defeat_tunk",
  quest_q52135="quest_defeat_tunk",
  quest_q52145="quest_defeat_tunk",
  mtbs_q42020="quest_target_eliminate",
  mtbs_q42030="quest_target_eliminate",
  mtbs_q42040="quest_target_eliminate",
  mtbs_q42050="quest_target_eliminate",
  mtbs_q42060="quest_target_eliminate",
  mtbs_q42070="quest_target_eliminate",
  mtbs_q42010="quest_target_eliminate"
}
local keyItems={
  tent_q80010=TppMotherBaseManagementConst.PHOTO_1006,
  field_q80020=TppMotherBaseManagementConst.PHOTO_1007,
  waterway_q80040=TppMotherBaseManagementConst.PHOTO_1009,
  commFacility_q80060=TppMotherBaseManagementConst.PHOTO_1000,
  fort_q80080=TppMotherBaseManagementConst.PHOTO_1008,
  outland_q80100=TppMotherBaseManagementConst.PHOTO_1002,
  pfCamp_q80200=TppMotherBaseManagementConst.PHOTO_1003,
  hill_q80400=TppMotherBaseManagementConst.PHOTO_1005,
  diamond_q80600=TppMotherBaseManagementConst.PHOTO_1004,
  lab_q80700=TppMotherBaseManagementConst.PHOTO_1001,
  sovietBase_q99030=TppMotherBaseManagementConst.DESIGN_3009,
  tent_q99040=TppMotherBaseManagementConst.DESIGN_3002,
  mtbs_q99050=TppMotherBaseManagementConst.DESIGN_3000
}
local questPhotos={
  tent_q80010="key_photo_1006",
  field_q80020="key_photo_1007",
  waterway_q80040="key_photo_1009",
  commFacility_q80060="key_photo_1000",
  fort_q80080="key_photo_1008",
  outland_q80100="key_photo_1002",
  pfCamp_q80200="key_photo_1003",
  hill_q80400="key_photo_1005",
  diamond_q80600="key_photo_1004",
  lab_q80700="key_photo_1001"
}
local questEmblems={
  mtbs_q99060={"base44","front62"},
  sovietBase_q99020={"word14","word15","word51","front49"},
  sovietBase_q99030={"word122","word123","word124","word125","word126"},
  tent_q99040={"word78","word79","word87","word91"}
}
local RENsetLockedTanQuests={"quest_q20015","quest_q20085","quest_q20205","quest_q20705","quest_q20095"}
local canOpenQuestChecks={}
function canOpenQuestChecks.waterway_q99010()
  return TppStory.IsOccuringBossQuiet()
end
function canOpenQuestChecks.waterway_q99012()
  return TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
end
function canOpenQuestChecks.sovietBase_q99020()
  return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON
end
function canOpenQuestChecks.sovietBase_q99030()
  return TppStory.CanPlayDemoOrRadio"OpenSideOpsAiPod"
end
function canOpenQuestChecks.tent_q99040()
  return this.IsCleard"sovietBase_q99030"
end
function canOpenQuestChecks.cliffTown_q99080()
  return TppStory.IsMissionCleard(10091)
end
function canOpenQuestChecks.field_q30010()
  return this.IsCleard"ruins_q60115"
end
function this.OpenChildSoldier_1()
  local t=this.IsCleard"mtbs_q99050"
  local n=this.IsNowOccurringElapsed()
  local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE)
  local a=TppStory.IsMissionCleard(10093)
  return((e or n)and t)and a
end
function this.OpenChildSoldier_2()
  return this.IsCleard"outland_q20913"and this.IsCleard"lab_q20914"
end
function canOpenQuestChecks.outland_q20913()
  return this.OpenChildSoldier_1()
end
function canOpenQuestChecks.lab_q20914()
  return this.OpenChildSoldier_1()
end
function canOpenQuestChecks.tent_q20910()
  return this.OpenChildSoldier_2()
end
function canOpenQuestChecks.fort_q20911()
  return this.OpenChildSoldier_2()
end
function canOpenQuestChecks.sovietBase_q20912()
  return this.OpenChildSoldier_2()
end
function canOpenQuestChecks.waterway_q39010()
  return TppStory.IsMissionCleard(10054)
end
function canOpenQuestChecks.lab_q39011()
  return TppStory.IsMissionCleard(10151)
end
function canOpenQuestChecks.pfCamp_q39012()
  return TppStory.IsMissionCleard(10151)
end
function canOpenQuestChecks.ruins_q19010()
  return true
end
function canOpenQuestChecks.commFacility_q19013()
  return this.IsCleard"quest_q20065"
end
function canOpenQuestChecks.outland_q19011()
  return TppStory.IsMissionCleard(10086)
end
function canOpenQuestChecks.hill_q19012()
  return TppStory.IsMissionCleard(10100)
end
function canOpenQuestChecks.outland_q99071()
  return TppStory.IsMissionCleard(10080)
end
function canOpenQuestChecks.sovietBase_q99070()
  return this.IsCleard"outland_q99071"
end
function canOpenQuestChecks.tent_q99072()
  return this.IsCleard"sovietBase_q99070"
end
function canOpenQuestChecks.outland_q40010()
  return TppStory.IsMissionCleard(10080)
end
function canOpenQuestChecks.sovietBase_q60110()
  return TppStory.IsOccuringBossQuiet()
end
function canOpenQuestChecks.sovietBase_q60111()
  return TppStory.IsMissionCleard(10121)
end
function canOpenQuestChecks.citadel_q60112()
  return TppStory.IsMissionCleard(10121)
end
function canOpenQuestChecks.outland_q60113()
  return TppStory.IsMissionCleard(10121)
end
function canOpenQuestChecks.pfCamp_q60114()
  return TppStory.IsMissionCleard(10121)
end
function canOpenQuestChecks.ruins_q60115()
  return this.IsCleard"ruins_q19010"
end
function canOpenQuestChecks.tent_q10010()
  return true
end
function canOpenQuestChecks.field_q10020()
  local t=this.IsCleard"ruins_q60115"
  local e=this.IsCleard"tent_q10010"
  return t and e
end
function canOpenQuestChecks.ruins_q10030()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"commFacility_q10060"
  return t and e
end
function canOpenQuestChecks.waterway_q10040()
  local t=TppStory.IsMissionCleard(10044)
  local e=this.IsCleard"cliffTown_q10050"
  return t and e
end
function canOpenQuestChecks.cliffTown_q10050()
  local t=TppStory.IsMissionCleard(10041)
  local e=this.IsCleard"fort_q10080"
  return t and e
end
function canOpenQuestChecks.commFacility_q10060()
  local t=TppStory.IsMissionCleard(10080)
  local e=this.IsCleard"waterway_q10040"
  return t and e
end
function canOpenQuestChecks.sovietBase_q10070()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"ruins_q10030"
  return t and e
end
function canOpenQuestChecks.fort_q10080()
  local t=TppStory.IsMissionCleard(10040)
  local e=this.IsCleard"field_q10020"
  return t and e
end
function canOpenQuestChecks.citadel_q10090()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"sovietBase_q10070"
  return t and e
end
function canOpenQuestChecks.outland_q10100()
  local t=TppStory.IsMissionCleard(10090)
  local e=this.IsCleard"pfCamp_q10200"
  return t and e
end
function canOpenQuestChecks.pfCamp_q10200()
  return TppStory.IsMissionCleard(10086)
end
function canOpenQuestChecks.savannah_q10300()
  local t=TppStory.IsMissionCleard(10195)
  local e=this.IsCleard"outland_q10100"
  return t and e
end
function canOpenQuestChecks.hill_q10400()
  local t=TppStory.IsMissionCleard(10110)
  local e=this.IsCleard"banana_q10500"
  return t and e
end
function canOpenQuestChecks.banana_q10500()
  local t=TppStory.IsMissionCleard(10100)
  local e=this.IsCleard"savannah_q10300"
  return t and e
end
function canOpenQuestChecks.diamond_q10600()
  local t=TppStory.IsMissionCleard(10120)
  local e=this.IsCleard"hill_q10400"
  return t and e
end
function canOpenQuestChecks.lab_q10700()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"diamond_q10600"
  return t and e
end
function canOpenQuestChecks.quest_q20015()
  return TppStory.IsMissionCleard(10040)
end
function canOpenQuestChecks.quest_q20025()
  return this.IsCleard"quest_q20065"
end
function canOpenQuestChecks.quest_q20035()
  local t=TppStory.IsMissionCleard(10080)
  local e=this.IsCleard"quest_q20905"
  return t and e
end
function canOpenQuestChecks.quest_q20045()
  local t=TppStory.IsMissionCleard(10091)
  local e=this.IsCleard"quest_q20035"
  return t and e
end
function canOpenQuestChecks.quest_q20055()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q21005"
  return t and e
end
function canOpenQuestChecks.quest_q20065()
  return this.IsCleard"ruins_q60115"
end
function canOpenQuestChecks.quest_q20075()
  local t=TppStory.IsMissionCleard(10044)
  local e=this.IsCleard"quest_q20025"
  return t and e
end
function canOpenQuestChecks.quest_q20085()
  local t=TppStory.IsMissionCleard(10041)
  local e=this.IsCleard"quest_q20015"
  return t and e
end
function canOpenQuestChecks.quest_q20095()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q20705"
  return t and e
end
function canOpenQuestChecks.quest_q20105()
  local t=TppStory.IsMissionCleard(10100)
  local e=this.IsCleard"quest_q23005"
  return t and e
end
function canOpenQuestChecks.quest_q20205()
  local t=TppStory.IsMissionCleard(10195)
  local e=this.IsCleard"quest_q20085"
  return t and e
end
function canOpenQuestChecks.quest_q20305()
  return TppStory.IsMissionCleard(10080)
end
function canOpenQuestChecks.quest_q20405()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"quest_q27005"
  return t and e
end
function canOpenQuestChecks.quest_q20505()
  local t=TppStory.IsMissionCleard(10110)
  local e=this.IsCleard"quest_q24005"
  return t and e
end
function canOpenQuestChecks.quest_q20605()
  local t=TppStory.IsMissionCleard(10121)
  local e=this.IsCleard"quest_q20505"
  return t and e
end
function canOpenQuestChecks.quest_q20705()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q20205"
  return t and e
end
function canOpenQuestChecks.quest_q20805()
  local t=TppStory.IsMissionCleard(10054)
  local e=this.IsCleard"quest_q20075"
  return t and e
end
function canOpenQuestChecks.quest_q20905()
  local t=TppStory.IsMissionCleard(10052)
  local e=this.IsCleard"quest_q20805"
  return t and e
end
function canOpenQuestChecks.quest_q21005()
  local t=TppStory.IsMissionCleard(10091)
  local e=this.IsCleard"quest_q20045"
  return t and e
end
function canOpenQuestChecks.quest_q22005()
  local t=TppStory.IsMissionCleard(10045)
  local e=this.IsCleard"quest_q21005"
  return t and e
end
function canOpenQuestChecks.quest_q23005()
  local t=TppStory.IsMissionCleard(10090)
  local e=this.IsCleard"quest_q20305"
  return t and e
end
function canOpenQuestChecks.quest_q24005()
  local t=TppStory.IsMissionCleard(10110)
  local e=this.IsCleard"quest_q20105"
  return t and e
end
function canOpenQuestChecks.quest_q25005()
  local t=TppStory.IsMissionCleard(10120)
  local e=this.IsCleard"quest_q20605"
  return t and e
end
function canOpenQuestChecks.quest_q26005()
  local t=TppStory.IsMissionCleard(10211)
  local e=this.IsCleard"quest_q27005"
  return t and e
end
function canOpenQuestChecks.quest_q27005()
  local t=TppStory.IsMissionCleard(10211)
  local e=this.IsCleard"quest_q25005"
  return t and e
end
function canOpenQuestChecks.tent_q11010()
  return TppStory.IsMissionCleard(10041)
end
function canOpenQuestChecks.tent_q11020()
  local t=TppStory.IsMissionCleard(10054)
  local e=this.IsCleard"tent_q11010"
  return t and e
end
function canOpenQuestChecks.waterway_q11030()
  local t=TppStory.IsMissionCleard(10052)
  local e=this.IsCleard"tent_q11020"
  return t and e
end
function canOpenQuestChecks.cliffTown_q11040()
  local t=TppStory.IsMissionCleard(10080)
  local e=this.IsCleard"waterway_q11030"
  return t and e
end
function canOpenQuestChecks.cliffTown_q11050()
  local t=TppStory.IsMissionCleard(10121)
  local e=this.IsCleard"banana_q11600"
  return t and e
end
function canOpenQuestChecks.fort_q11060()
  local t=TppStory.IsMissionCleard(10091)
  local e=this.IsCleard"commFacility_q11080"
  return t and e
end
function canOpenQuestChecks.fort_q11070()
  local t=TppStory.IsMissionCleard(10156)
  local e=this.IsCleard"fort_q11060"
  return t and e
end
function canOpenQuestChecks.commFacility_q11080()
  local t=TppStory.IsMissionCleard(10080)
  local e=this.IsCleard"cliffTown_q11040"
  return t and e
end
function canOpenQuestChecks.outland_q11090()
  local t=TppStory.IsMissionCleard(10195)
  local e=this.IsCleard"pfCamp_q11200"
  return t and e
end
function canOpenQuestChecks.outland_q11100()
  local t=TppStory.IsMissionCleard(10171)
  local e=this.IsCleard"banana_q11700"
  return t and e
end
function canOpenQuestChecks.pfCamp_q11200()
  local t=TppStory.IsMissionCleard(10100)
  local e=this.IsCleard"savannah_q11400"
  return t and e
end
function canOpenQuestChecks.savannah_q11300()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"hill_q11500"
  return t and e
end
function canOpenQuestChecks.savannah_q11400()
  return TppStory.IsMissionCleard(10086)
end
function canOpenQuestChecks.hill_q11500()
  local t=TppStory.IsMissionCleard(10120)
  local e=this.IsCleard"cliffTown_q11050"
  return t and e
end
function canOpenQuestChecks.banana_q11600()
  local t=TppStory.IsMissionCleard(10110)
  local e=this.IsCleard"outland_q11090"
  return t and e
end
function canOpenQuestChecks.banana_q11700()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"savannah_q11300"
  return t and e
end
function canOpenQuestChecks.tent_q71010()
  return TppStory.IsMissionCleard(10045)
end
function canOpenQuestChecks.field_q71020()
  local t=TppStory.IsMissionCleard(10156)
  local e=this.IsCleard"tent_q71010"
  return t and e
end
function canOpenQuestChecks.tent_q71030()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"field_q71020"
  return t and e
end
function canOpenQuestChecks.waterway_q71040()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"sovietBase_q71070"
  return t and e
end
function canOpenQuestChecks.cliffTown_q71050()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"tent_q71030"
  return t and e
end
function canOpenQuestChecks.cliffTown_q71060()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"sovietBase_q71070"
  return t and e
end
function canOpenQuestChecks.sovietBase_q71070()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"tent_q71030"
  return t and e
end
function canOpenQuestChecks.fort_q71080()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"sovietBase_q71070"
  return t and e
end
function canOpenQuestChecks.field_q71090()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"sovietBase_q71070"
  return t and e
end
function canOpenQuestChecks.outland_q71200()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"lab_q71600"
  return t and e
end
function canOpenQuestChecks.savannah_q71300()
  return TppStory.IsMissionCleard(10093)
end
function canOpenQuestChecks.banana_q71400()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"lab_q71600"
  return t and e
end
function canOpenQuestChecks.diamond_q71500()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"lab_q71600"
  return t and e
end
function canOpenQuestChecks.lab_q71600()
  local t=TppStory.IsMissionCleard(10171)
  local e=this.IsCleard"savannah_q71300"
  return t and e
end
function canOpenQuestChecks.lab_q71700()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"lab_q71600"
  return t and e
end
function canOpenQuestChecks.commFacility_q80060()
  return TppStory.IsMissionCleard(10040)
end
function canOpenQuestChecks.field_q80020()
  local t=TppStory.IsMissionCleard(10044)
  local e=this.IsCleard"commFacility_q80060"
  return t and e
end
function canOpenQuestChecks.outland_q80100()
  local t=TppStory.IsMissionCleard(10090)
  local e=this.IsCleard"field_q80020"
  return t and e
end
function canOpenQuestChecks.pfCamp_q80200()
  local t=TppStory.IsMissionCleard(10110)
  local e=this.IsCleard"outland_q80100"
  return t and e
end
function canOpenQuestChecks.diamond_q80600()
  local t=TppStory.IsMissionCleard(10120)
  local e=this.IsCleard"pfCamp_q80200"
  return t and e
end
function canOpenQuestChecks.hill_q80400()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"diamond_q80600"
  return t and e
end
function canOpenQuestChecks.tent_q80010()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"hill_q80400"
  return t and e
end
function canOpenQuestChecks.lab_q80700()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"tent_q80010"
  if t==true and e==true then
    return true
  end
  return false
end
function canOpenQuestChecks.fort_q80080()
  local t=TppStory.IsMissionCleard(10156)
  local e=this.IsCleard"lab_q80700"
  return t and e
end
function canOpenQuestChecks.waterway_q80040()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"fort_q80080"
  return t and e
end
function canOpenQuestChecks.quest_q52010()
  local t=TppStory.IsMissionCleard(10054)
  local e=this.IsCleard"quest_q52030"
  return t and e
end
function canOpenQuestChecks.quest_q52020()
  return TppStory.IsMissionCleard(10086)
end
function canOpenQuestChecks.quest_q52030()
  return TppStory.IsMissionCleard(10044)
end
function canOpenQuestChecks.quest_q52040()
  local t=TppStory.IsMissionCleard(10052)
  local e=this.IsCleard"quest_q52010"
  return t and e
end
function canOpenQuestChecks.quest_q52050()
  local t=TppStory.IsMissionCleard(10100)
  local e=this.IsCleard"quest_q52020"
  return t and e
end
function canOpenQuestChecks.quest_q52060()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q52070"
  return t and e
end
function canOpenQuestChecks.quest_q52070()
  local t=TppStory.IsMissionCleard(10120)
  local e=this.IsCleard"quest_q52050"
  return t and e
end
function canOpenQuestChecks.quest_q52080()
  local t=this.IsCleard"tent_q99040"
  local e=this.IsCleard"quest_q52040"
  return t and e
end
function canOpenQuestChecks.quest_q52090()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"quest_q52060"
  return t and e
end
function canOpenQuestChecks.quest_q52100()
  local t=TppStory.IsMissionCleard(10171)
  local e=this.IsCleard"quest_q52090"
  return t and e
end
function canOpenQuestChecks.quest_q52110()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52100"
  return t and e
end
function canOpenQuestChecks.quest_q52120()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52110"
  return t and e
end
function canOpenQuestChecks.quest_q52130()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52080"
  return t and e
end
function canOpenQuestChecks.quest_q52140()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52130"
  return t and e
end
function canOpenQuestChecks.quest_q52015()
  local t=TppStory.IsMissionCleard(10080)
  local e=this.IsCleard"quest_q52025"
  return t and e
end
function canOpenQuestChecks.quest_q52025()
  local t=TppStory.IsMissionCleard(10052)
  local e=this.IsCleard"quest_q52035"
  return t and e
end
function canOpenQuestChecks.quest_q52035()
  return TppStory.IsMissionCleard(10054)
end
function canOpenQuestChecks.quest_q52045()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q52065"
  return t and e
end
function canOpenQuestChecks.quest_q52055()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"quest_q52045"
  return t and e
end
function canOpenQuestChecks.quest_q52065()
  local t=TppStory.IsMissionCleard(10211)
  local e=this.IsCleard"quest_q52075"
  return t and e
end
function canOpenQuestChecks.quest_q52075()
  return TppStory.IsMissionCleard(10090)
end
function canOpenQuestChecks.quest_q52085()
  local t=TppStory.IsMissionCleard(10151)
  local e=this.IsCleard"quest_q52015"
  return t and e
end
function canOpenQuestChecks.quest_q52095()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"quest_q52055"
  return t and e
end
function canOpenQuestChecks.quest_q52105()
  local t=TppStory.IsMissionCleard(10171)
  local e=this.IsCleard"quest_q52095"
  return t and e
end
function canOpenQuestChecks.quest_q52115()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52105"
  return t and e
end
function canOpenQuestChecks.quest_q52125()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52115"
  return t and e
end
function canOpenQuestChecks.quest_q52135()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52085"
  return t and e
end
function canOpenQuestChecks.quest_q52145()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"quest_q52135"
  return t and e
end
function canOpenQuestChecks.ruins_q60010()
  return TppStory.IsMissionCleard(10054)
end
function canOpenQuestChecks.tent_q60011()
  local t=TppStory.IsMissionCleard(10052)
  local e=this.IsCleard"ruins_q60010"
  return t and e
end
function canOpenQuestChecks.cliffTown_q60012()
  local t=this.IsCleard"tent_q99040"
  local e=this.IsCleard"fort_q60013"
  return t and e
end
function canOpenQuestChecks.fort_q60013()
  local t=TppStory.IsMissionCleard(10091)
  local e=this.IsCleard"tent_q60011"
  return t and e
end
function canOpenQuestChecks.sovietBase_q60014()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"cliffTown_q60012"
  return t and e
end
function canOpenQuestChecks.pfCamp_q60020()
  local t=TppStory.IsMissionCleard(10211)
  local e=this.IsCleard"hill_q60021"
  return t and e
end
function canOpenQuestChecks.hill_q60021()
  local t=TppStory.IsMissionCleard(10121)
  local e=this.IsCleard"outland_q60024"
  return t and e
end
function canOpenQuestChecks.lab_q60022()
  local t=TppStory.IsMissionCleard(10280)
  local e=this.IsCleard"banana_q60023"
  return t and e
end
function canOpenQuestChecks.banana_q60023()
  local t=TppStory.IsMissionCleard(10093)
  local e=this.IsCleard"pfCamp_q60020"
  return t and e
end
function canOpenQuestChecks.outland_q60024()
  return TppStory.IsMissionCleard(10086)
end
function canOpenQuestChecks.Mtbs_SmokingSoldierCommand()
  return true
end
function canOpenQuestChecks.Mtbs_SmokingSoldierCombat()
  return true
end
function canOpenQuestChecks.Mtbs_child_dog()
  if TppDemo.IsPlayedMBEventDemo"EntrustDdog"then
    return true
  end
end
function canOpenQuestChecks.Mtbs_ddog_walking()
  return false
end
function canOpenQuestChecks.mtbs_q99050()
  local e=TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Develop+1)>=2
  local t=TppStory.IsMissionCleard"10211"
  return t and e
end
function canOpenQuestChecks.mtbs_q99011()
  local n=TppBuddy2BlockController.DidObtainBuddyType(BuddyType.QUIET)
  local t=TppStory.IsMissionCleard(10086)
  local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_VISIT_MISSION)
  return(n and t)and e
end
function canOpenQuestChecks.mtbs_wait_quiet()
  return false
end
function canOpenQuestChecks.mtbs_return_quiet()
  return false
end
function canOpenQuestChecks.mtbs_q101210()
  return true
end
function canOpenQuestChecks.mtbs_q101220()
  return true
end
function canOpenQuestChecks.mtbs_q99060()
  return TppDemo.IsPlayedMBEventDemo"PazPhantomPain1"
end
function canOpenQuestChecks.mtbs_q42010()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Command+1)>=4
end
function canOpenQuestChecks.mtbs_q42020()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Develop+1)>0
end
function canOpenQuestChecks.mtbs_q42030()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Support+1)>0
end
function canOpenQuestChecks.mtbs_q42040()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.BaseDev+1)>0
end
function canOpenQuestChecks.mtbs_q42050()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Medical+1)>0
end
function canOpenQuestChecks.mtbs_q42060()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Spy+1)>0
end
function canOpenQuestChecks.mtbs_q42070()
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Combat+1)>0
end

this.ShootingPracticeOpenCondition={
  Command=canOpenQuestChecks.mtbs_q42010,
  Develop=canOpenQuestChecks.mtbs_q42020,
  Support=canOpenQuestChecks.mtbs_q42030,
  BaseDev=canOpenQuestChecks.mtbs_q42040,
  Medical=canOpenQuestChecks.mtbs_q42050,
  Spy=canOpenQuestChecks.mtbs_q42060,
  Combat=canOpenQuestChecks.mtbs_q42070
}
function this.GetSideOpsListTable()
  local n={}
  if this.CanOpenSideOpsList()then
    for i,t in ipairs(sideOpsTable)do
      local o=t.questName
      local s=this.IsActiveOnMBTerminal(t)
      local a=this.IsCleard(o)
      if t and(s or a)then
        t.index=i
        t.isActive=s
        t.isCleard=a
        t.gmp=this.GetBounusGMP(o)table.insert(n,t)
      end
    end
  end
  table.insert(n,{allSideOpsNum=#sideOpsTable})
  return n
end
function this.GetBounusGMP(e)
  local e=TppDefine.QUEST_RANK_TABLE[TppDefine.QUEST_INDEX[e]]
  if e then
    return TppDefine.QUEST_BONUS_GMP[e]
  end
  return 0
end
function this.RegisterForceDeactiveOnMBTerminal(e)
  mvars.qst_forceDeactiveOnMBTerminal=e
end
function this.RegisterClusterForceDeactiveOnMBTerminal(e)
  mvars.qst_forceDeactiveClusterOnMBTerminal=e
end
function this.UnregisterForceDeactiveOnMBTerminal()
  mvars.qst_forceDeactiveOnMBTerminal={}
end
function this.UnregisterClusterForceDeactiveOnMBTerminal()
  mvars.qst_forceDeactiveClusterOnMBTerminal=nil
end
function this.IsActiveOnMBTerminal(n)
  local t=n.questName
  if mvars.qst_forceDeactiveOnMBTerminal then
    for n,e in ipairs(mvars.qst_forceDeactiveOnMBTerminal)do
      if e==t then
        return false
      end
    end
  end
  if mvars.qst_forceDeactiveClusterOnMBTerminal then
    if mvars.qst_forceDeactiveClusterOnMBTerminal==n.clusterId then
      return false
    end
  end
  return this.IsActive(t)
end
function this.IsOpenLocation(e)
  if e==TppDefine.LOCATION_ID.MAFR then
    return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY
  elseif e==TppDefine.LOCATION_ID.MTBS then
    return true
  end
  return true
end
local checkQuestFuncs={}
function checkQuestFuncs.mtbs_wait_quiet()
  return TppStory.CanArrivalQuietInMB()
end
function checkQuestFuncs.Mtbs_child_dog()
  if Ivars.mbEnablePuppy:Is()>0 and Ivars.mbWarGamesProfile:Is(0) then--tex>
    return true
  end--<
  local canSortieDDog=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
  local notDDogGoWithMe=not TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
  return(not canSortieDDog)and notDDogGoWithMe
end
function checkQuestFuncs.Mtbs_ddog_walking()
  local e=TppBuddyService.IsDeadBuddyType(BuddyType.DOG)
  return(not e)
end
function checkQuestFuncs.cliffTown_q99080()
  local t=TppMotherBaseManagement.IsExistStaff{uniqueTypeId=110}
  local e=TppStory.IsMissionCleard(10240)
  return t or e
end
function this.SpecialMissionStartSetting(missionClearType)
  if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END)then
    TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppPlayer.SetNoOrderBoxMissionStartPosition({-1868.27,343.22,-84.6095},160.651)
    TppMission.ResetIsStartFromHelispace()
    TppMission.SetIsStartFromFreePlay()
  elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END)then
    gvars.heli_missionStartRoute=Fox.StrCode32"drp_s10260"
    TppPlayer.SetStartStatusRideOnHelicopter()
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    TppPlayer.ResetNoOrderBoxMissionStartPosition()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
  elseif(missionClearType==TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END)then
    TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppPlayer.SetNoOrderBoxMissionStartPosition({-855.6097,515.6722,-1250.411},160.651)
    TppMission.ResetIsStartFromHelispace()
    TppMission.SetIsStartFromFreePlay()
  end
end
function this.RegisterCanActiveQuestListInMission(e)
  mvars.qst_canActiveQuestList=e
end
function this.RegisterQuestStepList(e)
  if not IsTypeTable(e)then
    return
  end
  local t=#e
  if t==0 then
    return
  end
  if t>=maxSteps then
    return
  end
  table.insert(e,questStepClear)
  mvars.qst_questStepList=Tpp.Enum(e)
end
function this.RegisterQuestStepTable(e)
  if not IsTypeTable(e)then
    return
  end
  e[questStepClear]={}
  mvars.qst_questStepTable=e
  if mtbs_enemy and vars.missionCode==30050 then
    mtbs_enemy.OnAllocateDemoBlock()
  end
end
function this.RegisterQuestSystemCallbacks(n)
  if not IsTypeTable(n)then
    return
  end
  mvars.qst_systemCallbacks=mvars.qst_systemCallbacks or{}
  local function SetCallBack(t,e)
    if IsTypeFunc(t[e])then
      mvars.qst_systemCallbacks[e]=t[e]
    end
  end
  local callBackNames={"OnActivate","OnOutOfAcitveArea","OnDeactivate","OnTerminate"}
  for t=1,#callBackNames do
    SetCallBack(n,callBackNames[t])
  end
end
function this.SetNextQuestStep(questStep)
  if not mvars.qst_questStepTable then
    return
  end
  if not mvars.qst_questStepList then
    return
  end
  local questStepTable=mvars.qst_questStepTable[questStep]
  local stepNumber=mvars.qst_questStepList[questStep]
  if questStepTable==nil then
    return
  end
  if stepNumber==nil then
    return
  end
  if this.IsInvoking()then
    local e=this.GetQuestStepTable(gvars.qst_currentQuestStepNumber)
    local OnLeave=e.OnLeave
    if IsTypeFunc(OnLeave)then
      OnLeave(e)
    end
  end
  gvars.qst_currentQuestStepNumber=stepNumber
  --OFF ORPHAN local n=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  local blockState=this.GetQuestBlockState()
  if mvars.qst_allocated then
    local OnEnter=questStepTable.OnEnter
    if IsTypeFunc(OnEnter)then
      OnEnter(questStepTable)
    end
  end
end
function this.ClearWithSave(clearType,questName)
  if not questName then
    questName=this.GetCurrentQuestName()
  end
  local questIndex=this.GetQuestIndex(questName)
  if clearType==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR or clearType==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY then
    this.OnFinishShootingPractice(clearType)
  end
  if clearType==TppDefine.QUEST_CLEAR_TYPE.CLEAR or clearType==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
    if clearType~=TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
      this.AddStaffsFromTempBuffer()
    end
    this.Clear(questName)
    if clearType~=TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
      this.Save()
    end
  elseif clearType==TppDefine.QUEST_CLEAR_TYPE.FAILURE then
    this.AddStaffsFromTempBuffer()
    this.Failure(questName)
    this.Save()
  elseif clearType==TppDefine.QUEST_CLEAR_TYPE.UPDATE then
    this.Update(questName)
  elseif clearType==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY then
    this.Retry(questName)
    this.SetRetryShootingPracticeStartUi()
  end
end
function this.ClearWithSaveMtbsDDQuest()
  local questName=this.GetCurrentQuestName()
  local questIndex=this.GetQuestIndex(questName)
  this.UpdateClearFlag(questIndex,true)
  this.UpdateRepopFlag(questIndex)
  this.Save()
end
function this.Clear(questName)
  if questName==nil then
    questName=this.GetCurrentQuestName()
    if questName==nil then
      return
    end
  end
  local questIndex=this.GetQuestIndex(questName)
  if questIndex==nil then
    return
  end
  this.SetNextQuestStep(questStepClear)
  this.ShowAnnounceLog(QUEST_STATUS_TYPES.CLEAR,questName)
  this.CheckClearBounus(questIndex,questName)
  this.UpdateClearFlag(questIndex,true)
  this.UpdateRepopFlag(questIndex)
  this.CheckAllClearBounus()
  this.CheckAllClearMineQuest()
  if not TppLocation.IsMotherBase()then
    this.DecreaseElapsedClearCount(questName)
  end
  TppStory.UpdateStorySequence{updateTiming="OnSideOpsClear"}
  if not this.PlayClearRadio(questName)then
    this.GoToMBAfterClear(questName)
  end
  this.GetClearKeyItem(questName)
  this.GetClearCassette(questName)
  this.GetClearEmblem(questName)
  if this.GetSideOpsInfo(questName)then
    TppTrophy.Unlock(15)
  end
  TppMission.SetPlayRecordClearInfo()--RETAILPATCH 1070
  TppChallengeTask.RequestUpdate"SIDEOPS"--RETAILPATCH 1070
  TppUiCommand.SetSideOpsListUpdate()
  for n,name in ipairs(RENsetLockedTanQuests)do
    if questName==name then
      TppMotherBaseManagement.SetLockedTanFlag{locked=false}
      return
    end
  end
end
function this.GoToMBAfterClear(e)
  if not Tpp.IsNotAlert()then
    return
  end
  if not TppMission.IsFreeMission(vars.missionCode)then
    return
  end
  if vars.missionCode==30050 then
    return
  end
  local forceDemoName=TppStory.GetForceMBDemoNameOrRadioList("clearSideOpsForceMBDemo",{clearSideOpsName=e})
  if forceDemoName then
    TppMission.ReserveMissionClear{nextMissionId=TppDefine.SYS_MISSION_ID.MTBS_FREE,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR}
    TppDemo.SetNextMBDemo(forceDemoName)
    mvars.qst_currentClearQuestName=e
  end
end
function this.Failure(questName)
  if questName==nil then
    questName=this.GetCurrentQuestName()
    if questName==nil then
      return
    end
  end
  local questIndex=this.GetQuestIndex(questName)
  if questIndex==nil then
    return
  end
  this.UpdateClearFlag(questIndex,false)
  this.SetNextQuestStep(questStepClear)
  this.ShowAnnounceLog(QUEST_STATUS_TYPES.FAILURE,questName)
  TppUiCommand.SetSideOpsListUpdate()
  for e=0,9,1 do
    if gvars.qst_failedIndex[e]==-1 then
      gvars.qst_failedIndex[e]=questIndex
      break
    end
  end
end
function this.Update(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local n=this.GetQuestIndex(t)
  if n==nil then
    return
  end
  local o,i=TppEnemy.GetQuestCount()
  local n,a=TppGimmick.GetQuestShootingPracticeCount()
  if o>0 and i>1 then
    this.ShowAnnounceLog(QUEST_STATUS_TYPES.UPDATE,t,o,i)
  elseif n>0 and a>1 then
    this.UpdateShootingPracticeUi()
    this.ShowAnnounceLog(QUEST_STATUS_TYPES.UPDATE,t,n,a)
  end
end
function this.Retry(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local n=this.GetQuestIndex(t)
  if n==nil then
    return
  end
  this.ShowAnnounceLog(QUEST_STATUS_TYPES.FAILURE,t)
end
function this.AddStaffsFromTempBuffer()
  local e=TppEnemy.IsQuestInHelicopter()
  if e then
    TppTerminal.OnRecoverByHelicopterOnCheckPoint()
  end
  TppTerminal.AddStaffsFromTempBuffer(true)
end
function this.Save()
  TppSave.VarSaveQuest(vars.missionCode)
  TppSave.SaveGameData(vars.missionCode)
end
function this.SetClearFlag(e)
  if e==nil then
    return
  end
  local t=TppDefine.QUEST_INDEX[e]
  if gvars.qst_questClearedFlag[e]then
    gvars.qst_questClearedFlag[t]=true
  end
end
function this.ReserveOpenQuestDynamicUpdate()
  mvars.qst_reserveDynamicQuestOpen=true
end
function this.FadeOutAndDeativateQuestBlock()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnOutOfMissionArea")
end
function this.SetQuestBlockName(blockName)
  mvars.qst_blockName=blockName
end
function this.GetQuestBlockName(e)
  return mvars.qst_blockName
end
function this.OnAllocate(t)
  this.SetDefaultQuestBlock()
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(t)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Messages()
  local o=this.DeactiveQuestAreaTrapMessages()
  return StrCode32Table{
    Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=this.OnUpdateSmallBlockIndex}},
    UI={
      {msg="EndFadeOut",sender="FadeOutOnOutOfMissionArea",
        func=function()
          mvars.qst_blockStateRequest=questBlockStatus.DEACTIVATE
          TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED)
        end},
      {msg="QuestAreaAnnounceText",
        func=function(t)
          this.OnQuestAreaAnnounceText(t)
        end}
    },
    Marker={
      {msg="ChangeToEnable",
        func=function(a,s,n,t)
          this._ChangeToEnable(a,s,n,t)
        end}
    },
    Timer={
      {msg="Finish",sender="TimerShootingPracticeStart",
        func=function()
          this.StartShootingPractice()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true}},
      {msg="Finish",sender="TimerShootingPracticeEnd",
        func=function()
          this.OnQuestShootingTimerEnd()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true}},
      {msg="Finish",sender="TimerShootingPracticeRetryConfirm",
        func=function()
          TppGimmick.SetQuestShootingPracticeTargetInvisible()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true}
      }
    },
    Trap=o}
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  local questScriptBlockMessageExecTable=mvars.qst_questScriptBlockMessageExecTable
  if questScriptBlockMessageExecTable then
    local logText=strLogText
    local r
    Tpp.DoMessage(questScriptBlockMessageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,logText)
  end
  if this.IsInvoking()and mvars.qst_questStepList then
    local currentQuestStepNumber=gvars.qst_currentQuestStepNumber
    local questStepTable=this.GetQuestStepTable(currentQuestStepNumber)
    if questStepTable then
      local questStepMessageExecTable=questStepTable._messageExecTable
      if questStepMessageExecTable then
        local logText=strLogText
        local l
        Tpp.DoMessage(questStepMessageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,logText)
      end
    end
  end
end
function this.OnDeactivate(t)
  if t.questType==TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE then
    this.OnFinishShootingPractice()
    this.ShootingPracticeStopAllTimer()
    this.OnQuestShootingTimerEnd()
    this.OnDeactivateShootingPracticeForUi()
    this.ClearShootingPracticeMvars()
  end
end
function this.RegisterQuestList(questList)
  if not IsTypeTable(questList)then
    return
  end
  local numQuests=#questList
  if numQuests==0 then
    return
  end
  for n=1,numQuests do
    if not IsTypeTable(questList[n])then
      return
    end
    local infoList=questList[n].infoList
    if not IsTypeTable(infoList)then
      Tpp.DEBUG_DumpTable(questList,2)
      return
    end
    if#infoList==0 then
      return
    end
    for t,questInfo in ipairs(infoList)do
      if not IsTypeString(questInfo.name)then
        return
      end
      if not IsTypeString(questInfo.invokeStepName)then
        return
      end
    end
    if not questList[n].clusterName then
      if not IsTypeTable(questList[n].loadArea)then
        return
      end
      if not IsTypeTable(questList[n].activeArea)then
        return
      end
      if not IsTypeTable(questList[n].invokeArea)then
        return
      end
    end
  end
  mvars.qst_questList=questList
  for n=1,numQuests do
    for n,questInfo in ipairs(questList[n].infoList)do
      local questName=questInfo.name
      if StrCode32(questName)==gvars.qst_currentQuestName then
        this.SetCurrentQuestName(questName)
      end
    end
  end
  return mvars.qst_questList
end
function this.RegisterQuestPackList(questPackList,blockName)
  if not IsTypeTable(questPackList)then
    return
  end
  blockName=blockName or defaultQuestBlockName
  local isMotherBase=TppLocation.IsMotherBase()
  local fpkList={}
  for questName,n in pairs(questPackList)do
    fpkList[questName]={}
    for listType,fova in pairs(n)do
      if type(fova)=="number"then
        table.insert(fpkList[questName],fova)
      elseif listType=="faceIdList"then
        local faceFpkFileCodeList=TppSoldierFace.GetFaceFpkFileCodeList{face=fova,useHair=isMotherBase}
        if faceFpkFileCodeList~=nil then
          for n,e in ipairs(faceFpkFileCodeList)do
            table.insert(fpkList[questName],e)
          end
        end
      elseif listType=="bodyIdList"then
        local e=TppSoldierFace.GetBodyFpkFileCodeList{body=fova}
        if e~=nil then
          for n,e in ipairs(e)do
            table.insert(fpkList[questName],e)
          end
        end
      elseif listType=="randomFaceList"then
        if this.IsRandomFaceQuestName(questName)then
          if fova.race and fova.gender then
            if TppMission.IsMissionStart()then
              local seed=(math.random(0,65535)*65536)+math.random(1,65535)
              local faceTable=TppSoldierFace.CreateFaceTable{race=fova.race,gender=fova.gender,needCount=1,maxUsedFovaCount=1,seed=seed}
              if faceTable~=nil then
                for a,faceId in ipairs(faceTable)do
                  this.SetRandomFaceId(questName,faceId)
                end
              else
                if fova.gender==TppDefine.QUEST_GENDER_TYPE.MAN then
                  this.SetRandomFaceId(questName,TppDefine.QUEST_FACE_ID_LIST.DEFAULT_MAN)
                elseif fova.gender==TppDefine.QUEST_GENDER_TYPE.WOMAN then
                  this.SetRandomFaceId(questName,TppDefine.QUEST_FACE_ID_LIST.DEFAULT_WOMAN)
                end
              end
            end
            local faceId=this.GetRandomFaceId(questName)
            local faceTable={faceId}
            local faceFpkFileCodeList=TppSoldierFace.GetFaceFpkFileCodeList{face=faceTable}
            if faceFpkFileCodeList==nil then
              if fova.gender==TppDefine.QUEST_GENDER_TYPE.MAN then
                this.SetRandomFaceId(questName,TppDefine.QUEST_FACE_ID_LIST.DEFAULT_MAN)
              elseif fova.gender==TppDefine.QUEST_GENDER_TYPE.WOMAN then
                this.SetRandomFaceId(questName,TppDefine.QUEST_FACE_ID_LIST.DEFAULT_WOMAN)
              end
              faceId=this.GetRandomFaceId(questName)
              faceTable={faceId}
              faceFpkFileCodeList=TppSoldierFace.GetFaceFpkFileCodeList{face=faceTable}
            end
            if faceFpkFileCodeList~=nil then
              for n,e in ipairs(faceFpkFileCodeList)do
                table.insert(fpkList[questName],e)
              end
            end
          end
        end
      else
        table.insert(fpkList[questName],fova)
      end
    end
  end
  TppScriptBlock.RegisterCommonBlockPackList(blockName,fpkList)
end
function this.SetDefaultQuestBlock()
  mvars.qst_blockName=defaultQuestBlockName
end
function this.InitializeQuestLoad(clusterIndex)
  local blockState=this.GetQuestBlockState()
  if blockState==nil then
    return
  end
  if vars.missionCode==30050 and clusterIndex==nil then
    return
  end
  local n,a=Tpp.GetCurrentStageSmallBlockIndex()
  this.UpdateQuestBlockStateAtNotLoaded(n,a,clusterIndex)
end
function this.InitializeQuestActiveStatus(questActiveCluster)
  local questBlockState=this.GetQuestBlockState()
  if questBlockState==nil then
    return
  end
  if questBlockState==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    return
  end
  mvars.qst_requestInitializeQuestActiveStatus=false
  mvars.qst_requestInitializeQuestActiveCluster=nil
  if questBlockState<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or not this._CanActivateQuest()then
    mvars.qst_requestInitializeQuestActiveStatus=true
    mvars.qst_requestInitializeQuestActiveCluster=questActiveCluster
    return
  end
  local currentQuestTable=this.GetCurrentQuestTable()
  if currentQuestTable==nil then
    return
  end
  local a,s=Tpp.GetCurrentStageSmallBlockIndex()
  if this.IsInsideArea("activeArea",currentQuestTable,a,s,questActiveCluster)then
    this.ActivateCurrentQuestBlock()
  end
  if not this.IsInvoking()then
    if this.IsInsideArea("invokeArea",currentQuestTable,a,s,questActiveCluster)then
      this.Invoke()
    end
  else
    gvars.qst_currentQuestStepNumber=1
    local questStep=mvars.qst_questStepList[gvars.qst_currentQuestStepNumber]
    this.SetNextQuestStep(questStep)
  end
end
function this.DEBUG_Init()
  mvars.debug.showCurrentQuest=false;(nil).AddDebugMenu("LuaQuest","showCurrentQuest","bool",mvars.debug,"showCurrentQuest")
  mvars.debug.showQuestStatus=false;(nil).AddDebugMenu("LuaQuest","showQuestStatus","bool",mvars.debug,"showQuestStatus")
  mvars.debug.selectQuest=1;(nil).AddDebugMenu("LuaQuest","selectQuest","int32",mvars.debug,"selectQuest")
  mvars.debug.selectQuestIndex=1;(nil).AddDebugMenu("LuaQuest","selectQuestIndex","int32",mvars.debug,"selectQuestIndex")
  mvars.debug.historyQuestStep={}
  mvars.debug.showHistoryQuestStep=false;(nil).AddDebugMenu("LuaQuest","historyQuestStep","bool",mvars.debug,"showHistoryQuestStep")
  mvars.debug.updateActiveQuest=false;(nil).AddDebugMenu("LuaQuest","updateActiveQuest","bool",mvars.debug,"updateActiveQuest")
  mvars.debug.applyDebugFlags=false;(nil).AddDebugMenu("LuaQuest","applyDebugFlags","bool",mvars.debug,"applyDebugFlags")
  mvars.debug.updateOpenFlagSelectQuest=false;(nil).AddDebugMenu("LuaQuest"," dbgSetOpenFlag","bool",mvars.debug,"updateOpenFlagSelectQuest")
  mvars.debug.updateClearFlagSelectQuest=false;(nil).AddDebugMenu("LuaQuest"," dbgSetClearFlag","bool",mvars.debug,"updateClearFlagSelectQuest")
  mvars.debug.updateActiveFlagSelectQuest=false;(nil).AddDebugMenu("LuaQuest"," dbgSetActiveFlag","bool",mvars.debug,"updateActiveFlagSelectQuest")
end
function this.DebugUpdate()
  local mvars=mvars
  local a=(nil).Print
  local t=(nil).NewContext()
  if mvars.debug.showCurrentQuest then
    a(t,"")a(t,{.5,.5,1},"LuaQuest showCurrentQuest")
    a(t,"Current Area Name : "..tostring(this.GetCurrentAreaName()))
    a(t,"Current Quest Name : "..tostring(this.GetCurrentQuestName()))
    local i=this.GetQuestBlockState()
    local scriptBlockStateNames={}
    scriptBlockStateNames[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"
    scriptBlockStateNames[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"
    scriptBlockStateNames[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"
    scriptBlockStateNames[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"
    a(t,"Quest block state : "..tostring(scriptBlockStateNames[i]))
    a(t,"gvars.qst_currentQuestName : "..tostring(gvars.qst_currentQuestName))
    a(t,"gvars.qst_currentQuestStepNumber : "..tostring(gvars.qst_currentQuestStepNumber))
    do
      local o={0,1,0}
      local r={1,0,0}
      local s="OK"local o=o
      if not this.GetCurrentAreaName()or i<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
        s="---"elseif not mvars.qst_questStepTable then
        s="No register quest step table! Please Check quest script!"
        o=r
      end
      a(t,o,"scriptStatus : "..s)
    end
  end
  if mvars.debug.showQuestStatus then
    a(t,"")a(t,{.5,.5,1},"LuaQuest showQuestStatus")
    local s=mvars.debug.selectQuest
    local o=mvars.debug.selectQuestIndex
    if s>0 and o>0 then
      local s=mvars.qst_questList[s]
      if s then
        a(t,string.format("AreaName = %s",s.areaName))
        local n=s.infoList[o]
        if n then
          a(t,string.format("name = %s",n.name))
          a(t,string.format("invokeStepName = %s",n.invokeStepName))
          if n.clusterName then
            DebutTextPrint(t,string.format("clusterName  =%s",n.clusterName))
          else
            local function a(t,n,e)
              local a=(nil).Print
              a(t,string.format("%s = { %03d, %03d, %03d, %03d }",n,e[1],e[2],e[3],e[4]))
            end
            local e={"loadArea","activeArea","invokeArea"}
            for n=1,#e do
              local n=e[n]
              local e=s[n]
              if e then
                a(t,n,e)
              end
            end
          end
          a(t,"IsOpen : "..tostring(this.IsOpen(n.name)))
          a(t,"IsCleard : "..tostring(this.IsCleard(n.name)))
          a(t,"IsRepop : "..tostring(this.IsRepop(n.name)))
          a(t,"IsActive : "..tostring(this.IsActive(n.name)))
        else
          a(t,"No define quest. index: "..tostring(o))
        end
      end
    end
  end
  if mvars.debug.showHistoryQuestStep then
    a(t,"")a(t,{.5,.5,1},"LuaQuest historyQuestStep")
    local e=#mvars.debug.historyQuestStep
    for e=1,e do
      a(t,string.format("%03d: %s",e,mvars.debug.historyQuestStep[e]))
    end
  end
  if mvars.debug.updateActiveQuest then
    this.UpdateActiveQuest{debugUpdate=true}
    this.OnUpdateSmallBlockIndex(Tpp.GetCurrentStageSmallBlockIndex())
    mvars.debug.updateActiveQuest=false
  end
  if mvars.debug.applyDebugFlags then
    local e=mvars.debug.selectQuest
    local s=mvars.debug.selectQuestIndex
    if e>0 and s>0 then
      local o=mvars.qst_questList[e]
      if o then
        local i=o.infoList[s]
        if i then
          local questIndex=TppDefine.QUEST_INDEX[i.name]
          gvars.qst_questOpenFlag[questIndex]=mvars.debug.updateOpenFlagSelectQuest
          gvars.qst_questClearedFlag[questIndex]=mvars.debug.updateClearFlagSelectQuest
          gvars.qst_questActiveFlag[questIndex]=mvars.debug.updateActiveFlagSelectQuest
          if mvars.debug.updateActiveFlagSelectQuest then
            for t,e in pairs(o.infoList)do
              if e.name~=i.name then
                local questIndex=TppDefine.QUEST_INDEX[e.name]
                gvars.qst_questActiveFlag[questIndex]=false
              end
            end
          end
        else
          a(t,"No define quest. index: "..tostring(s))
        end
      end
    end
    mvars.debug.applyDebugFlags=false
  end
  if mvars.debug.updateOpenFlagSelectQuest then
  end
  if mvars.debug.updateClearFlagSelectQuest then
  end
  if mvars.debug.updateActiveFlagSelectQuest then
  end
end
function this.ShowAnnounceLogQuestOpen()
  if mvars.qst_isQuestNewOpenFlag==true then
    mvars.qst_isQuestNewOpenFlag=false
    this.ShowAnnounceLog(QUEST_STATUS_TYPES.OPEN)
  end
end
function this.OnUpdateSmallBlockIndex(a,n,clusterIndex)
  local blockState=this.GetQuestBlockState()
  if blockState==nil then
    return
  end
  local STATE_EMPTY=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
  local STATE_PROCESSING=ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
  local STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
  local STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  mvars.qst_invokeReserveOnActivate=false
  if(blockState==STATE_EMPTY)or(blockState==STATE_PROCESSING)then
    if mvars.qst_reserveDynamicQuestOpen then
      this.UpdateOpenQuest()
      mvars.qst_reserveDynamicQuestOpen=false
    end
    this.UpdateQuestBlockStateAtNotLoaded(a,n,clusterIndex)
  elseif(blockState==STATE_INACTIVE)then
    this.UpdateQuestBlockStateAtInactive(a,n,clusterIndex)
  elseif(blockState==STATE_ACTIVE)then
    this.UpdateQuestBlockStateAtActive(a,n)
  end
end
function this.OnUpdateClusterIndex(clusterIndex)
  local blockState=this.GetQuestBlockState()
  if blockState==nil then
    return
  end
  if mvars.qst_reserveDynamicQuestOpen then
    this.UpdateOpenQuest()
    mvars.qst_reserveDynamicQuestOpen=false
  end
  local questForArea=this.UpdateQuestBlockStateAtNotLoaded(0,0,clusterIndex)
  mvars.qst_skipTerminateFlag=questForArea
  return questForArea
end
function this.UpdateQuestBlockStateAtNotLoaded(t,a,clusterIndex)
  if not mvars.qst_questList then
    return
  end
  local currentQuestName=this.GetCurrentQuestName()
  local questForArea=this.SearchQuestFromAllSpecifiedArea("loadArea",t,a,clusterIndex)
  if questForArea==nil then
    this.UnloadCurrentQuestBlock()
    this.ClearCurrentQuestName()
    this.ResetQuestStatus()
  end
  if currentQuestName then
    local blockState=this.GetQuestBlockState()
    local SCRIPT_BLOCK_STATE_EMPTY=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
    if questForArea then
      if(blockState==SCRIPT_BLOCK_STATE_EMPTY or currentQuestName~=questForArea)then
        this.SetNewQuestAndLoadQuestBlock(questForArea)
      end
      if(blockState~=SCRIPT_BLOCK_STATE_EMPTY)and(currentQuestName==questForArea)then
        mvars.qst_currentQuestTable=this.GetQuestTable(questForArea)
      end
    end
  else
    if questForArea then
      this.SetNewQuestAndLoadQuestBlock(questForArea)
    end
  end
  return questForArea
end
function this.UpdateQuestBlockStateAtInactive(a,n)
  local questAreaTable=this.GetCurrentQuestTable()
  if not this.IsInsideArea("loadArea",questAreaTable,a,n)then
    this.UnloadCurrentQuestBlock()
    return
  end
  if this.IsInsideArea("activeArea",questAreaTable,a,n)then
    if not this.IsInvoking()then
      if this.IsInsideArea("invokeArea",questAreaTable,a,n)then
        mvars.qst_invokeReserveOnActivate=true
      end
    end
    mvars.qst_blockStateRequest=questBlockStatus.ACTIVATE
    return
  end
end
function this.UpdateQuestBlockStateAtActive(t,n)
  local questAreaTable=this.GetCurrentQuestTable()
  if not this.IsInsideArea("activeArea",questAreaTable,t,n)then
    if mvars.qst_blockStateRequest~=questBlockStatus.DEACTIVATING then
      mvars.qst_blockStateRequest=questBlockStatus.DEACTIVATING
      local e=this.ExecuteSystemCallback"OnOutOfAcitveArea"if not e then
        mvars.qst_blockStateRequest=questBlockStatus.DEACTIVATE
      end
    end
    return
  end
  if not this.IsInvoking()then
    if this.IsInsideArea("invokeArea",questAreaTable,t,n)then
      this.Invoke()
    end
  end
end
function this.QuestBlockOnInitialize(t)
  local t=t.Messages
  if IsTypeFunc(t)then
    local e=t()
    mvars.qst_questScriptBlockMessageExecTable=Tpp.MakeMessageExecTable(e)
  end
  this.MakeQuestStepMessageExecTable()
  mvars.qst_skipTerminateFlag=nil
  mvars.qst_isRadioTarget=false
end
function this.QuestBlockOnTerminate()
  this.ExecuteSystemCallback"OnTerminate"
  mvars.qst_systemCallbacks=nil
  mvars.qst_lastQuestBlockState=nil
  mvars.qst_questStepList=nil
  mvars.qst_questStepTable=nil
  mvars.qst_isRadioTarget=false
  gvars.qst_currentQuestStepNumber=defaultStepNumber
  if mtbs_enemy and vars.missionCode==30050 then
    mtbs_enemy.OnTerminateDemoBlock()
  end
  if not mvars.qst_skipTerminateFlag then
    mvars.qst_currentQuestTable=nil
    this.ClearCurrentQuestName()
    local blockId=ScriptBlock.GetScriptBlockId(mvars.qst_blockName)
    TppScriptBlock.FinalizeScriptBlockState(blockId)
  end
end
function this._CanActivateQuest()
  if mvars.ene_isQuestHeli then
    return not TppReinforceBlock.IsProcessing()
  end
  return true
end
function this.QuestBlockOnUpdate()
  local thisLocal=this--NMC: tihs pattern is used in two functions in other files. why? is it that really performant?
  local questBlockState=thisLocal.GetQuestBlockState()
  if questBlockState==nil then
    return
  end
  local ScriptBlock=ScriptBlock
  local mvars=mvars
  local lastQuestBlockState=mvars.qst_lastQuestBlockState
  local SCRIPT_BLOCK_STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
  local SCRIPT_BLOCK_STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  if mvars.qst_requestInitializeQuestActiveStatus then
    thisLocal.InitializeQuestActiveStatus(mvars.qst_requestInitializeQuestActiveCluster)
    return
  end
  if questBlockState==SCRIPT_BLOCK_STATE_INACTIVE then
    if lastQuestBlockState==SCRIPT_BLOCK_STATE_ACTIVE then
      thisLocal._DoDeactivate()
    end
    if mvars.qst_blockStateRequest==questBlockStatus.ACTIVATE then
      if thisLocal._CanActivateQuest()then
        thisLocal.ActivateCurrentQuestBlock()
        thisLocal.ClearBlockStateRequest()
      end
    end
    mvars.qst_lastInactiveToActive=false
  elseif questBlockState==SCRIPT_BLOCK_STATE_ACTIVE then
    if not thisLocal._CanActivateQuest()then
      return
    end
    local questStepTable
    if thisLocal.IsInvoking()then
      questStepTable=thisLocal.GetQuestStepTable(gvars.qst_currentQuestStepNumber)
    end
    if mvars.qst_lastInactiveToActive then
      mvars.qst_lastInactiveToActive=false
      mvars.qst_deactivated=false
      thisLocal.ExecuteSystemCallback"OnActivate"
      mvars.qst_allocated=true
      if mvars.qst_invokeReserveOnActivate then
        mvars.qst_invokeReserveOnActivate=false
        thisLocal.Invoke()
        questStepTable=thisLocal.GetQuestStepTable(gvars.qst_currentQuestStepNumber)
      end
      if questStepTable and IsTypeFunc(questStepTable.OnEnter)then
        questStepTable.OnEnter(questStepTable)
      end
    end
    if(not lastQuestBlockState)or lastQuestBlockState<=SCRIPT_BLOCK_STATE_INACTIVE then
      mvars.qst_lastInactiveToActive=true
    end
    if questStepTable and IsTypeFunc(questStepTable.OnUpdate)then
      questStepTable.OnUpdate(questStepTable)
    end
    if mvars.qst_blockStateRequest==questBlockStatus.DEACTIVATE then
      thisLocal.DeactivateCurrentQuestBlock()
      thisLocal.ClearBlockStateRequest()
    end
  else
    mvars.qst_lastInactiveToActive=false
    thisLocal.ClearBlockStateRequest()
  end
  mvars.qst_lastQuestBlockState=questBlockState
end
function this.OnMissionGameEnd()
  local blockState=this.GetQuestBlockState()
  mvars.qst_isMissionEnd=true
  if blockState==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    this._DoDeactivate()
  end
end
function this.ClearBlockStateRequest()
  mvars.qst_blockStateRequest=questBlockStatus.NONE
end
function this.Invoke()
  local currentQuestName=this.GetCurrentQuestName()
  local areaQuestTable,questInfo=this.GetQuestTable(currentQuestName)
  local invokeStepName=questInfo.invokeStepName
  this.SetNextQuestStep(invokeStepName)
end
function this.SetNewQuestAndLoadQuestBlock(questName)
  if TppLocation.IsMotherBase()then
    f30050_demo.UpdatePackList(questName)
  end

  local loaded=TppScriptBlock.Load(mvars.qst_blockName,questName)
  if loaded==false then
    return
  end
  this.ResetQuestStatus()
  this.SetCurrentQuestName(questName)
  mvars.qst_currentQuestTable=this.GetQuestTable(questName)
end
function this.GetCurrentQuestName()
  return mvars.qst_currentQuestName
end
function this.GetCurrentAreaName()
  local questAreaTable=this.GetCurrentQuestTable()
  if questAreaTable then
    return questAreaTable.areaName
  else
    return nil
  end
end
function this.SetCurrentQuestName(e)
  mvars.qst_currentQuestName=e
  gvars.qst_currentQuestName=Fox.StrCode32(e)
end
function this.ClearCurrentQuestName()
  mvars.qst_currentQuestName=nil
  gvars.qst_currentQuestName=questNameNone
end
function this.ResetQuestStatus()
  gvars.qst_currentQuestName=questNameNone
  gvars.qst_currentQuestStepNumber=defaultStepNumber
end
function this.UnloadCurrentQuestBlock()
  TppScriptBlock.Unload(mvars.qst_blockName)
end
function this.ActivateCurrentQuestBlock()
  local blockId=ScriptBlock.GetScriptBlockId(mvars.qst_blockName)
  TppScriptBlock.ActivateScriptBlockState(blockId)
end
function this.DeactivateCurrentQuestBlock()
  local blockId=ScriptBlock.GetScriptBlockId(mvars.qst_blockName)
  TppScriptBlock.DeactivateScriptBlockState(blockId)
end
function this.SearchQuestFromAllSpecifiedArea(areaName,a,o,clusterIndex)
  local numAreas=#mvars.qst_questList
  for i=1,numAreas do
    local locationAreaQuestTable=mvars.qst_questList[i]--TppQuestList .questList
    if this.IsInsideArea(areaName,locationAreaQuestTable,a,o,clusterIndex)then
      --OFF ORPHAN local n={}
      for n,questInfo in ipairs(locationAreaQuestTable.infoList)do
        local questForArea=questInfo.name
        if this.IsActive(questForArea)then
          return questForArea
        end
      end
    end
  end
end
function this.IsInsideArea(areaName,locationAreaQuestTable,s,a,clusterId)
  do
    local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
    local locationId=TppDefine.LOCATION_ID[locationName]
    if locationAreaQuestTable.locationId~=locationId then
      return false
    end
  end
  if locationAreaQuestTable.clusterName then
    return TppDefine.CLUSTER_NAME[clusterId]==locationAreaQuestTable.clusterName
  else
    --OFF ORPHAN local t=e.areaName
    local e=locationAreaQuestTable[areaName]
    if e==nil then
      return
    end
    return Tpp.CheckBlockArea(e,s,a)
  end
end
function this.GetCurrentQuestTable()
  return mvars.qst_currentQuestTable
end
function this.GetQuestTable(questName)
  local numQuests=#mvars.qst_questList
  for e=1,numQuests do
    local areaQuestTable=mvars.qst_questList[e]
    for a,questInfo in ipairs(areaQuestTable.infoList)do
      if questInfo.name==questName then
        return areaQuestTable,questInfo
      end
    end
  end
end
function this.GetQuestIndex(e)
  local e=TppDefine.QUEST_INDEX[e]
  if e then
    return e
  else
    return
  end
end
function this.GetSideOpsInfo(questName)
  for n,sideOpInfo in ipairs(sideOpsTable)do
    if sideOpInfo.questName==questName then
      return sideOpInfo
    end
  end
  return nil
end
function this.IsShowSideOpsList(t)
  return this.GetSideOpsInfo()~=nil
end
function this.GetQuestNameLangId(questName)
  local sideOpInfo=this.GetSideOpsInfo(questName)
  if sideOpInfo then
    local langId="name_"..string.sub(sideOpInfo.questId,-6)
    return langId
  end
  return false
end
function this.GetQuestNameId(questName)
  local sideOpInfo=this.GetSideOpsInfo(questName)
  if sideOpInfo then
    local nameId=string.sub(sideOpInfo.questId,-6)
    return nameId
  end
  return false
end
function this.GetQuestName(n)
  for t,e in ipairs(sideOpsTable)do
    local t=tonumber(string.sub(e.questId,-5))
    if n==t then
      return e.questName
    end
  end
end
function this.ExecuteSystemCallback(e)
  if mvars.qst_systemCallbacks==nil then
    return
  end
  local e=mvars.qst_systemCallbacks[e]
  if e then
    return e()
  end
end
function this.IsInvoking()
  if gvars.qst_currentQuestStepNumber~=defaultStepNumber then
    return true
  else
    return false
  end
end
function this.UpdateOpenQuest()
  mvars.qst_isQuestNewOpenFlag=false
  for questName,questIndex in pairs(TppDefine.QUEST_INDEX) do
    local CanOpenQuestFunc=canOpenQuestChecks[questName]
    if CanOpenQuestFunc and CanOpenQuestFunc() then
      if gvars.qst_questOpenFlag[questIndex]==false then
        mvars.qst_isQuestNewOpenFlag=true
      end
      gvars.qst_questOpenFlag[questIndex]=true
    end
  end
end
function this.UpdateActiveQuest(debugUpdate)
  if not mvars.qst_questList then
    return
  end

  local unlockedName=nil--tex unlockSideOpNumber>
  local unlockedArea=nil
  if Ivars.unlockSideOpNumber:Is()>0 then--tex find name and area for unlocksideop SANITY:
    unlockedName=sideOpsTable[Ivars.unlockSideOpNumber:Get()].questName--tex
    if unlockedName ~= nil then
      unlockedArea=TppQuestList.questAreaTable[unlockedName]
    end
  end--<unlockSideOpNumber

  if this.NeedUpdateActiveQuest(debugUpdate)then
    this.UpdateOpenQuest()
    for n,areaQuests in ipairs(mvars.qst_questList)do
      local n={}
      local storyQuests={}
      local nonStoryQuests={}
      local repopQuests={}
      --tex unlockSideOpNumber>  add quest then skip area that unlocked op is in. lack of a continue op is annoying lua.
      if unlockedArea and areaQuests.areaName==unlockedArea then
        for t,info in ipairs(areaQuests.infoList)do--tex still gotta clear
          local questName=info.name
          local questIndex=TppDefine.QUEST_INDEX[questName]
          if questIndex then
            gvars.qst_questActiveFlag[questIndex]=false
          end
        end
        gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[unlockedName]]=true
        --<unlockSideOpNumber
      else
        for t,info in ipairs(areaQuests.infoList)do
          local questName=info.name
          local questIndex=TppDefine.QUEST_INDEX[questName]
          if questIndex then
            gvars.qst_questActiveFlag[questIndex]=false
            --NMC: -v- some list of conditions, not as big as the 't' list
            local CheckQuestFunc=checkQuestFuncs[questName]
            if this.IsOpen(questName)and(not CheckQuestFunc or CheckQuestFunc())and(not InfMain.BlockQuest(questName)) then--tex added blockQuest
              if not this.IsCleard(questName)then
                if info.isStory then
                  table.insert(storyQuests,questName)
                else
                  table.insert(nonStoryQuests,questName)
                end
              elseif this.IsRepop(questName)then
                table.insert(repopQuests,questName)
              end
              --<quest open
            end
            --<questindex
          end
          --<for infolist
        end

        local questName=nil
        local list=nil--tex reworked, choose which quest to activate per area
        local index=1
        if #storyQuests > 0 then--tex broken into lists to manage priority
          list=storyQuests
        elseif #nonStoryQuests > 0 then
          list=nonStoryQuests
        elseif #repopQuests > 0 then
          list=repopQuests
        end
        if list ~= nil then
          --        if gvars.unlockSideOps == Ivars.unlockSideOps.enum.FIRST then
          --          index=1
          --        elseif gvars.unlockSideOps == Ivars.unlockSideOps.enum.LAST then
          --          index=#list
          --        elseif gvars.unlockSideOps == Ivars.unlockSideOps.enum.RANDOM then
          --          index=math.random(#list)
          --        end
          if Ivars.unlockSideOps:Is() > 0 then
            index=math.random(#list)
          end
          questName=list[index]
        end--
        --tex ORIG:
        --for n,t in ipairs{storyQuests,nonStoryQuests,repopQuests}do
        --  if not questName then
        --    questName=t[1]
        --  end
        -- end
        if questName then
          gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[questName]]=true
        end
      end--unlockedArea switch
    end-- for questlist
  elseif TppMission.IsStoryMission(vars.missionCode)then
    for n,questName in ipairs(TppDefine.QUEST_DEFINE)do
      if not this.CanActiveQuestInMission(vars.missionCode,questName) then
        gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[questName]]=false
      end
    end
  else
    for i=0,9,1 do
      if gvars.qst_failedIndex[i]~=-1 then
        local failedIndex=gvars.qst_failedIndex[i]
        gvars.qst_questActiveFlag[failedIndex]=true
        gvars.qst_failedIndex[i]=-1
      end
    end
  end
  for i=0,9,1 do
    gvars.qst_failedIndex[i]=-1
  end
  TppUiCommand.SetSideOpsListUpdate()
  for i,questName in ipairs(RENsetLockedTanQuests)do
    if gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[questName]]==true then
      TppMotherBaseManagement.SetLockedTanFlag{locked=true}
      return
    end
  end
end
--function e.UpdateActiveQuest(t)--tex ORIG:
--  if not mvars.qst_questList then
--    return
--  end
--  if e.NeedUpdateActiveQuest(t)then
--    e.UpdateOpenQuest()
--    for n,t in ipairs(mvars.qst_questList)do
--      local n=nil
--      local n={}
--      local a={}
--      local s={}
--      local i={}
--      for t,o in ipairs(t.infoList)do
--        local t=o.name
--        local n=TppDefine.QUEST_INDEX[t]
--        if n then
--          gvars.qst_questActiveFlag[n]=false
--          local n=r[t]
--          if e.IsOpen(t)and(not n or n())then
--            if not e.IsCleard(t)then
--              if o.isStory then
--                table.insert(a,t)
--              else
--                table.insert(s,t)
--              end
--            elseif e.IsRepop(t)then
--              table.insert(i,t)
--            end
--          end
--        end
--      end
--      local e=nil
--      for n,t in ipairs{a,s,i}do
--        if not e then
--          e=t[1]
--        end
--      end
--      if e then
--        gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[e] ]=true
--      end
--    end
--  elseif TppMission.IsStoryMission(vars.missionCode)then
--    for n,t in ipairs(TppDefine.QUEST_DEFINE)do
--      if not e.CanActiveQuestInMission(vars.missionCode,t)then
--        gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[t] ]=false
--      end
--    end
--  else
--    for e=0,9,1 do
--      if gvars.qst_failedIndex[e]~=-1 then
--        local t=gvars.qst_failedIndex[e]
--        gvars.qst_questActiveFlag[t]=true
--        gvars.qst_failedIndex[e]=-1
--      end
--    end
--  end
--  for e=0,9,1 do
--    gvars.qst_failedIndex[e]=-1
--  end
--  TppUiCommand.SetSideOpsListUpdate()
--  for t,e in ipairs(m)do
--    if gvars.qst_questActiveFlag[TppDefine.QUEST_INDEX[e] ]==true then
--      TppMotherBaseManagement.SetLockedTanFlag{locked=true}
--      return
--    end
--  end
--end
function this.CanActiveQuestInMission(e,t)
  if(not TppMission.IsStoryMission(e))then
    return true
  else
    if mvars.qst_canActiveQuestList then
      for n,e in ipairs(mvars.qst_canActiveQuestList)do
        if e==t then
          return true
        end
      end
    end
    return false
  end
end
function this.IsImportant(t)
  local e=this.GetSideOpsInfo(t)
  if e then
    return e.isImportant
  end
  return false
end
local specialQuestList={waterway_q99012="waterway",tent_q99040="tent",tent_q20910="tent",sovietBase_q20912="waterway",fort_q20911="fort"}
function this.OpenAndActivateSpecialQuest(questNames)
  local n=true
  for a,questName in ipairs(questNames)do
    if this.CanOpenAndActivateSpecialQuest(questName)then
      this.OpenQuestForce(questName)
      this.SwitchActiveQuest(questName)
      this.AddStaffsFromTempBuffer()
      this.Save()
    else
      n=false
    end
  end
  if n then
    this.ShowAnnounceLog(QUEST_STATUS_TYPES.OPEN)
  end
  return n
end
function this.OpenQuestForce(e)
  local questIndex=TppDefine.QUEST_INDEX[e]
  if questIndex then
    gvars.qst_questOpenFlag[questIndex]=true
  end
end
function this.CanOpenAndActivateSpecialQuest(questName)
  local areaName=specialQuestList[questName]
  if not areaName then
    return false
  end
  for a,areaQuests in ipairs(TppQuestList.questList)do
    if areaQuests.areaName==areaName then
      local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
      local locationId=TppDefine.LOCATION_ID[locationName]
      if areaQuests.locationId~=locationId then
        return true
      end
      local a,n=Tpp.GetCurrentStageSmallBlockIndex()
      if not this.IsInsideArea("loadArea",areaQuests,a,n)then
        return true
      end
    end
  end
  return false
end
function this.SwitchActiveQuest(questName)
  local t=specialQuestList[questName]
  if not t then
    return
  end
  for a,areaQuests in ipairs(TppQuestList.questList)do
    if areaQuests.areaName==t then
      for t,info in ipairs(areaQuests.infoList)do
        local _questName=info.name
        local questIndex=TppDefine.QUEST_INDEX[_questName]
        if questIndex then
          gvars.qst_questActiveFlag[questIndex]=(_questName==questName)
        end
      end
    end
  end
end
function this.IsRepop(questName)
  local questIndex=TppDefine.QUEST_INDEX[questName]
  if questIndex then
    return gvars.qst_questRepopFlag[questIndex]
  end
end
function this.IsOpen(questName)
  --tex just force this here, don't want to touch the actual flag as it's saved/cant be easily reversed
  if Ivars.unlockSideOps:Is"OPEN" then
    return true
  end
  local questIndex=TppDefine.QUEST_INDEX[questName]
  if questIndex then
    return gvars.qst_questOpenFlag[questIndex]
  end
end
function this.IsActive(questName)
  local questIndex=TppDefine.QUEST_INDEX[questName]
  if questIndex then
    return gvars.qst_questActiveFlag[questIndex]
  end
end
function this.IsCleard(questName)
  local questIndex=TppDefine.QUEST_INDEX[questName]
  if questIndex then
    return gvars.qst_questClearedFlag[questIndex]
  end
end
function this.IsEnd(questName)
  if questName==nil then
    questName=this.GetCurrentQuestName()
    if questName==nil then
      return
    end
  end
  if mvars.qst_questStepList[gvars.qst_currentQuestStepNumber]==questStepClear then
    return true
  end
  return false
end
function this._DoDeactivate()
  mvars.qst_deactivated=true
  this.ExecuteSystemCallback"OnDeactivate"
  mvars.qst_allocated=false
end
function this.MakeQuestStepMessageExecTable()
  if not IsTypeTable(mvars.qst_questStepTable)then
    return
  end
  for t,e in pairs(mvars.qst_questStepTable)do
    local t=e.Messages
    if IsTypeFunc(t)then
      local t=t(e)
      e._messageExecTable=Tpp.MakeMessageExecTable(t)
    end
  end
end
function this.GetQuestStepTable(questStep)
  if mvars.qst_questStepList==nil then
    return
  end
  local e=mvars.qst_questStepList[questStep]
  if e==nil then
    return
  end
  local e=mvars.qst_questStepTable[e]
  if e~=nil then
    return e
  else
    return
  end
end
function this.GetQuestBlockState()
  local blockId=ScriptBlock.GetScriptBlockId(mvars.qst_blockName)
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(blockId)
end
function this.CheckClearBounus(questIndex,t)
  local questRank=TppDefine.QUEST_RANK_TABLE[questIndex]
  local gmp=TppDefine.QUEST_BONUS_GMP[questRank]
  if questRank then
    TppHero.SetAndAnnounceHeroicOgrePointForQuestClear(questRank)
    TppTerminal.UpdateGMP{gmp=gmp,gmpCostType=TppDefine.GMP_COST_TYPE.CLEAR_SIDE_OPS}
  end
end
function this.UpdateClearFlag(questIndex,clear)
  if clear then
    gvars.qst_questClearedFlag[questIndex]=true
  end
  gvars.qst_questActiveFlag[questIndex]=false
end
function this.UpdateRepopFlag(questIndex)
  gvars.qst_questRepopFlag[questIndex]=false
  local questAreaTable=this.GetCurrentQuestTable()
  if not questAreaTable then
    return
  end
  this.UpdateRepopFlagImpl(questAreaTable)
end
function this.UpdateRepopFlagImpl(locationQuests)
  local numOpen=0
  for n,questInfo in ipairs(locationQuests.infoList)do
    local questName=questInfo.name
    if this.IsOpen(questName)then
      if not questInfo.isOnce then
        numOpen=numOpen+1
      end
      if this.IsRepop(questName)or not this.IsCleard(questName)then
        local CheckQuestFunc=checkQuestFuncs[questName]
        if(CheckQuestFunc==nil)or CheckQuestFunc()then
          return
        end
      end
    end
  end
  if numOpen<=1 and(not TppLocation.IsMotherBase())then
    return
  end
  for n,questInfo in ipairs(locationQuests.infoList)do
    if this.IsCleard(questInfo.name)and (not questInfo.isOnce or Ivars.unlockSideOps:Get()~=0) then--tex added issub
      gvars.qst_questRepopFlag[TppDefine.QUEST_INDEX[questInfo.name]]=true
    end
    local CheckQuestFunc=checkQuestFuncs[questInfo.name]
    if CheckQuestFunc and(not CheckQuestFunc())then--and Ivars.unlockSideOps:Is(0) then --tex
      gvars.qst_questRepopFlag[TppDefine.QUEST_INDEX[questInfo.name]]=false
    end
  end
end
function this.CheckAllClearBounus()
  if gvars.qst_allQuestCleared then
    TppTrophy.UnlockOnAllQuestClear()
    return
  end
  local allCleared=true
  for n,questInfo in ipairs(sideOpsTable)do
    local questName=questInfo.questName
    local questIndex=TppDefine.QUEST_INDEX[questName]
    if not gvars.qst_questClearedFlag[questIndex]then
      allCleared=false
      break
    end
  end
  if allCleared then
    gvars.qst_allQuestCleared=true
    TppTrophy.UnlockOnAllQuestClear()
    TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.QUEST_ALL_CLEAR)
  end
end
function this.CalcQuestClearedCount()
  local clearedCount=0
  local totalCount=0
  for n,questInfo in ipairs(sideOpsTable)do
    local questName=questInfo.questName
    local questIndex=TppDefine.QUEST_INDEX[questName]
    if gvars.qst_questClearedFlag[questIndex]then
      clearedCount=clearedCount+1
    end
    totalCount=totalCount+1
  end
  return clearedCount,totalCount
end
function this.CheckAllClearMineQuest()
  if gvars.qst_allQuestCleared then
    TppTrophy.Unlock(16)
    return
  end
  local allCleared=true
  for t,n in pairs(TppDefine.REMOVAL_TROPHY_QUEST)do
    local isCleared=gvars.qst_questClearedFlag[TppDefine.QUEST_INDEX[t]]
    if not isCleared then
      allCleared=false
      break
    end
  end
  if allCleared then
    TppTrophy.Unlock(16,TppHero.MINE_QUEST_ALL_CLEAR.heroicPoint,TppHero.MINE_QUEST_ALL_CLEAR.ogrePoint)
  end
end
function this.NeedUpdateActiveQuest(t)
  if not this.CanOpenSideOpsList()then
    return false
  end
  if not TppMission.IsMissionStart()then
    return false
  end
  return not TppMission.IsStoryMission(vars.missionCode)
end
function this.CanOpenSideOpsList()
  if TppMission.IsFOBMission(vars.missionCode)then
    return false
  end
  local e={10033,10036,10043}
  return(TppStory.GetClearedMissionCount(e)>=1)or(gvars.str_storySequence>TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE)
end
function this.StartElapsedEvent(e)
  gvars.qst_elapseCount=e
end
function this.GetElapsedCount()--RETAILPATCH: 1060
  return gvars.qst_elapseCount
end--
function this.IsNowOccurringElapsed()
  return gvars.qst_elapseCount==TppDefine.ELAPSED_QUEST_COUNT.NOW_OCCURRING
end
function this.SetDoneElapsed()
  gvars.qst_elapseCount=TppDefine.ELAPSED_QUEST_COUNT.DONE_EVENT
end
local t={waterway_q99010=true,waterway_q99012=true,sovietBase_q99020=true}
function this.DecreaseElapsedClearCount(e)
  if gvars.qst_elapseCount<=1 then
    if not Tpp.IsNotAlert()then
      return
    end
    if not TppMission.IsFreeMission(vars.missionCode)then
      return
    end
  end
  if t[e]then
    return
  end
  if gvars.qst_elapseCount>TppDefine.ELAPSED_QUEST_COUNT.NOW_OCCURRING then
    gvars.qst_elapseCount=gvars.qst_elapseCount-1
  end
end
function this.PlayClearRadio(clearSideOpsName)
  if Tpp.IsNotAlert()then
    local e=TppStory.GetForceMBDemoNameOrRadioList("clearSideOps",{clearSideOpsName=clearSideOpsName})
    if e then
      TppRadio.Play(e)
      return true
    end
  end
  return false
end
function this.GetClearKeyItem(t)
  for e,dataBaseId in pairs(keyItems)do
    if e==t then
      TppTerminal.AcquireKeyItem{dataBaseId=dataBaseId,isShowAnnounceLog=true}
      for t,n in pairs(questPhotos)do
        if e==t then
          TppUI.ShowAnnounceLog("quest_get_photo",n)
        end
      end
    end
  end
end
function this.GetClearEmblem(e)
  local e=questEmblems[e]
  if e then
    for t,e in ipairs(e)do
      TppEmblem.Add(e,false,true)
    end
  end
end
function this.GetClearCassette(t)
  local n={"outland_q20913","lab_q20914","tent_q20910","sovietBase_q20912","fort_q20911"}
  local a={{"tp_m_10160_06"},{"tp_m_10160_07"},{"tp_m_10160_08"},{"tp_m_10160_09","tp_m_10160_10"}}
  if(((t=="outland_q20913"or t=="lab_q20914")or t=="tent_q20910")or t=="sovietBase_q20912")or t=="fort_q20911"then
    local t=0
    for a,n in ipairs(n)do
      if this.IsCleard(n)then
        t=t+1
      end
    end
    local cassetteList=a[t]
    if cassetteList then
      TppCassette.Acquire{cassetteList=cassetteList,isShowAnnounceLog=true}
    end
  elseif t=="sovietBase_q99030"then
    TppCassette.Acquire{cassetteList={"tp_m_10150_20","tp_m_10150_29","tp_m_10150_30"},isShowAnnounceLog=true}
  elseif t=="tent_q99040"then
    TppCassette.Acquire{cassetteList={"tp_m_10150_21","tp_m_10150_22","tp_m_10150_24","tp_m_10150_25"},isShowAnnounceLog=true}
  end
end
function this.ShowAnnounceLog(status,questName,u,l)
  if not status then
    return
  end
  if status==QUEST_STATUS_TYPES.OPEN then
    TppUI.ShowAnnounceLog"quest_list_update"
    TppUI.ShowAnnounceLog"quest_add"
  elseif status==QUEST_STATUS_TYPES.CLEAR then
    if not questName then
      return
    end
    local a=this.GetQuestNameLangId(questName)
    if a~=false then
      local showAnnounceLogId=questCompleteLangIds[questName]
      local s,r=TppEnemy.GetQuestCount()
      local o,i=TppGimmick.GetQuestShootingPracticeCount()
      if showAnnounceLogId then
        if s>1 then
          TppUI.ShowAnnounceLog(showAnnounceLogId,s,r)
        elseif o>1 then
          TppUI.ShowAnnounceLog(showAnnounceLogId,o,i)
        end
      end
      TppUI.ShowAnnounceLog"quest_list_update"
      TppUI.ShowAnnounceLog("quest_complete",a)
      local e=this.GetQuestNameId(questName)
      if(e~=false)and(e~="q99012")then
        TppUiCommand.ShowSideFobInfo("end",string.format("name_%s",e),"hud_quest_finish")
        TppSoundDaemon.PostEvent"sfx_s_sideops_sted"
      end
    end
  elseif status==QUEST_STATUS_TYPES.FAILURE then
    if not questName then
      return
    end
    local e=this.GetQuestNameLangId(questName)
    if e~=false then
      TppUI.ShowAnnounceLog"quest_list_update"
      TppUI.ShowAnnounceLog("quest_delete",e)
    end
  elseif status==QUEST_STATUS_TYPES.UPDATE then
    if not questName then
      return
    end
    local showAnnounceLogId=questCompleteLangIds[questName]
    if showAnnounceLogId then
      TppUI.ShowAnnounceLog(showAnnounceLogId,u,l)
    end
  end
end
function this.IsRandomFaceQuestName(questName)
  if questName==nil then
    questName=this.GetCurrentQuestName()
    if questName==nil then
      return
    end
  end
  local e=TppDefine.QUEST_RANDOM_FACE_INDEX[questName]
  if e then
    return true
  end
  return false
end
function this.GetRandomFaceId(questName)
  if questName==nil then
    questName=this.GetCurrentQuestName()
    if questName==nil then
      return
    end
  end
  local faceIndex=TppDefine.QUEST_RANDOM_FACE_INDEX[questName]
  if faceIndex then
    return gvars.qst_randomFaceId[faceIndex]
  end
end
function this.SetRandomFaceId(questName,faceId)
  local e=TppDefine.QUEST_RANDOM_FACE_INDEX[questName]
  if e then
    gvars.qst_randomFaceId[e]=faceId
  end
end
function this.OnQuestAreaAnnounceText(t)
  local n=this.GetQuestName(t)
  local t
  if n then
    for a,e in pairs(questRadioList)do
      if a==n then
        if e.radioNameFirst then
          if e.radioNameSecond then
            if TppRadio.IsPlayed(e.radioNameFirst)then
              t=e.radioNameSecond
            else
              t=e.radioNameFirst
            end
          else
            t=e.radioNameFirst
          end
        end
      end
    end
    if t~=nil then
      TppRadio.Play(t,{delayTime="mid"})
    end
    TppSoundDaemon.PostEvent"sfx_s_sideops_sted"
  end
end
function this.IsActiveQuestHeli()
  for n,questName in ipairs(TppDefine.QUEST_HELI_DEFINE)do
    if this.IsActive(questName)then
      return true
    end
  end
  return false
end
function this.DeactiveQuestAreaTrapMessages()
  local deactiveQuestAreaTrapMessages={}
  local arealList={}
  local missionCode=TppMission.GetMissionID()
  if missionCode==30010 then
    arealList=afgAreaList
  elseif missionCode==30020 then
    arealList=mafrAreaList
  else
    return
  end
  for a,t in ipairs(arealList)do
    local trapName=this.GetTrapName(t)
    local message={msg="Exit",sender=trapName,
      func=function(e,e)
        TppEnemy.CheckDeactiveQuestAreaForceFulton()
      end}
    table.insert(deactiveQuestAreaTrapMessages,message)
  end
  return deactiveQuestAreaTrapMessages
end
function this.GetTrapName(e)
  return"trap_preDeactiveQuestArea_"..e
end
function this._ChangeToEnable(a,a,t,n)
  if n==Fox.StrCode32"Player"and this.IsInvoking()then
    local a=TppEnemy.IsQuestTarget(t)
    local n=TppGimmick.IsQuestTarget(t)
    local t=TppAnimal.IsQuestTarget(t)
    if(a or n)or t then
      TppSoundDaemon.PostEvent"sfx_s_enemytag_quest_tgt"
      if mvars.qst_isRadioTarget==false then
        local e=this.GetCurrentQuestName()
        if(((e=="tent_q20910"or e=="fort_q20911")or e=="sovietBase_q20912")or e=="outland_q20913")or e=="lab_q20914"then
          TppRadio.Play("f2000_rtrg8330",{delayTime="short"})
        else
          TppRadio.Play("f1000_rtrg2180",{delayTime="short"})
        end
        mvars.qst_isRadioTarget=true
      end
    end
  end
end
function this.SetQuestShootingPractice()
  TppSoundDaemon.PostEvent"sfx_s_training_ready_go"
  GkEventTimerManager.Start("TimerShootingPracticeStart",3.5)
  this.StopTimer"TimerShootingPracticeRetryConfirm"
  this.HideShootingPracticeStartUi()
  mvars.qst_isShootingPracticeStarted=true
  GameObject.SendCommand({type="TppHeli2",index=0},{id="PullOut"})
end
function this.StartShootingPractice()
  this.UpdateShootingPracticeUi()
  TppUiCommand.StartDisplayTimer(mvars.gim_questDisplayTimeSec,mvars.gim_questCautionTimeSec)
  TppGimmick.StartQuestShootingPractice()
  TppGimmick.SetQuestSootingTargetInvincible(false)
  f30050_sound.SetScene_ShootingRange()
  TppSoundDaemon.PostEvent"sfx_m_tra_tgt_get_up_alot"
  Player.SetInfiniteAmmoFromScript(true)
end
function this.OnFinishShootingPractice(t,n)
  if t or n then
    this.ProcessFinishShootingPractice(t,n)
  end
  Player.SetInfiniteAmmoFromScript(false)
  mvars.qst_isShootingPracticeStarted=false
end
function this.IsShootingPracticeStarted()
  if not mvars.qst_isShootingPracticeStarted then
    return false
  end
  return true
end
function this.IsShootingPracticeActivated()
  if not mvars.isShootingPracticeQuestActivated then
    return false
  end
  return true
end
function this.ProcessFinishShootingPractice(t,n)
  this.UpdateShootingPracticeUi()
  TppUiStatusManager.SetStatus("DisplayTimer","STOP_VISIBLE")
  this.StartSafeTimer("TimerShootingPracticeEnd",8)
  TppSound.StopSceneBGM()
  if mvars.isShootingPracticeInMedicalStopMusicFromQuietRoom==true then
    f30050_sequence.PlayMusicFromQuietRoom()
    mvars.isShootingPracticeInMedicalStopMusicFromQuietRoom=false
  end
  if n then
    TppGimmick.EndQuestShootingPractice(TppDefine.QUEST_CLEAR_TYPE.SHOOTING_RETRY)
    TppGimmick.SetQuestShootingPracticeTargetInvisible()
  else
    TppGimmick.EndQuestShootingPractice(t)
    if mvars.qst_deactivated==false then
      if vars.playerVehicleGameObjectId==GameObject.NULL_ID then
        TppPlayer.PlayMissionClearCameraOnFoot(2,true)
      end
      if t==TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
        TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_training_jingle_clear")
        TppGimmick.SetQuestShootingPracticeTargetInvisible()
      else
        TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_training_jingle_failed")
        this.StartSafeTimer("TimerShootingPracticeRetryConfirm",60)
        TppGimmick.SetQuestSootingTargetInvincible(true)
      end
    end
  end
end
function this.CancelShootingPractice()
  local t=this.GetCurrentQuestName()
  this.ShowAnnounceLog(QUEST_STATUS_TYPES.FAILURE,t)
  this.OnFinishShootingPractice(nil,true)
  this.ShootingPracticeStopAllTimer()
  this.OnQuestShootingTimerEnd()
  this.SetCancelShootingPracticeStartUi()
end
function this.StartSafeTimer(t,n)
  this.StopTimer(t)
  GkEventTimerManager.Start(t,n)
end
function this.StopTimer(e)
  if GkEventTimerManager.IsTimerActive(e)then
    GkEventTimerManager.Stop(e)
  end
end
function this.ShootingPracticeStopAllTimer()
  this.StopTimer"TimerShootingPracticeEnd"
  this.StopTimer"TimerShootingPracticeRetryConfirm"
  this.StopTimer"TimerShootingPracticeStart"
end
function this.OnQuestShootingTimerEnd()
  TppUiStatusManager.UnsetStatus("DisplayTimer","STOP_VISIBLE")
  TppUiCommand.EraseDisplayTimer()
end
function this.ShowShootingPracticeStartUi(t,n)
  this.ShowShootingPracticeGroundUi(t,n)
  this.ShowShootingPracticeMarker(t)
end
function this.ShowShootingPracticeGroundUi(e,t)
  mvars.qst_shootingPracticeStartUiPos=t or mvars.qst_shootingPracticeStartUiPos
  mvars.qst_shootingPracticeOffsetType=e or mvars.qst_shootingPracticeOffsetType
  local e,t=mtbs_cluster.GetPosAndRotY(mvars.qst_shootingPracticeOffsetType,"plnt0",mvars.qst_shootingPracticeStartUiPos,0)
  TppUiCommand.SetMbStageSpot("show",Vector3(e[1],e[2],e[3]))
end
function this.ShowShootingPracticeMarker(t)
  if t then
    for n,e in pairs(shootingPracticeMarkers)do
      if n~=t then
        TppMarker.Disable(e)
      else
        mvars.qst_shootingPracticeMarkerName=e or mvars.qst_shootingPracticeMarkerName
      end
    end
  end
  if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
    return
  end
  if mvars.qst_shootingPracticeMarkerName then
    TppMarker.Enable(mvars.qst_shootingPracticeMarkerName)
  end
end
function this.HideShootingPracticeStartUi()
  TppUiCommand.SetMbStageSpot"hide"
  this.HideShootingPracticeMarker()
end
function this.HideShootingPracticeMarker()
  if mvars.qst_shootingPracticeMarkerName then
    TppMarker.Disable(mvars.qst_shootingPracticeMarkerName)
  end
end
function this.OnDeactivateShootingPracticeForUi()
  this.HideAllShootingPracticeForUi()
end
function this.ClearShootingPracticeMvars()
  mvars.qst_shootingPracticeStartUiPos=nil
  mvars.qst_shootingPracticeOffsetType=nil
  mvars.qst_shootingPracticeMarkerName=nil
  mvars.qst_isShootingPracticeStarted=false
end
function this.HideAllShootingPracticeForUi()
  for t,e in pairs(shootingPracticeMarkers)do
    local t=GameObject.GetGameObjectId(e)
    if t~=GameObject.NULL_ID then
      TppMarker.Disable(e)
    end
  end
end
function this.SetRetryShootingPracticeStartUi()
  this.ShowShootingPracticeStartUi()
  TppPlayer.ResetIconForQuest"ShootingPractice"end
function this.SetCancelShootingPracticeStartUi()
  this.ShowShootingPracticeGroundUi()
  TppPlayer.ResetIconForQuest"ShootingPractice"end
function this.UpdateShootingPracticeUi()
  local t,e=TppGimmick.GetQuestShootingPracticeCount()
  TppUiCommand.SetDisplayTimerText("time_quest",t,e)
end
--RETAILPATCH: 1060 big additions to below
local designAquireInfo={
  ruins_q60115=TppMotherBaseManagementConst.DESIGN_2027,
  sovietBase_q60110=TppMotherBaseManagementConst.DESIGN_2020,
  citadel_q60112=TppMotherBaseManagementConst.DESIGN_2021,
  outland_q60113=TppMotherBaseManagementConst.DESIGN_2022,
  pfCamp_q60114=TppMotherBaseManagementConst.DESIGN_2023,
  sovietBase_q60111=TppMotherBaseManagementConst.DESIGN_2024
}
local animalAquireInfo={
  pfCamp_q39012={dataBaseId=TppMotherBaseManagementConst.ANIMAL_130},
  waterway_q39010={dataBaseId=TppMotherBaseManagementConst.ANIMAL_610},
  lab_q39011={dataBaseId=TppMotherBaseManagementConst.ANIMAL_2250}
}
function this.AcquireKeyItemOnMissionStart()
  for questName,dataBaseId in pairs(keyItems)do
    if this.IsCleard(questName)then
      TppTerminal.AcquireKeyItem{dataBaseId=dataBaseId,isShowAnnounceLog=true}
    end
  end
  if TppStory.IsMissionCleard(11050)then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3014,pushReward=true}
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3015,pushReward=true}
  end
  if TppDemo.IsPlayedMBEventDemo"DecisionHuey"then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3007,pushReward=true}
  end
  if TppStory.IsMissionCleard(10280)then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3008,pushReward=true}
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3010,pushReward=true}
  end
  if TppStory.IsMissionCleard(10100)then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3013,pushReward=true}
  end
  if this.IsCleard"mtbs_q99060"then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.PHOTO_1010,pushReward=true}
  end
  for questName,dataBaseId in pairs(designAquireInfo)do
    if this.IsCleard(questName)then
      TppTerminal.AcquireKeyItem{dataBaseId=dataBaseId,isShowAnnounceLog=true}
    end
  end
  for questName,info in pairs(animalAquireInfo)do
    if this.IsCleard(questName)and not TppMotherBaseManagement.IsGotDataBase{dataBaseId=info.dataBaseId}then
      TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=info.dataBaseId,areaName=info.areaName,isNew=true}
    end
  end
  if TppUiCommand.HasEmblemTexture"front5019"then
    TppTerminal.AcquireKeyItem{dataBaseId=428,isShowAnnounceLog=true}
  end
  if this.IsCleard"ruins_q19010"then
    vars.isRussianTranslatable=1
  end
  if this.IsCleard"outland_q19011"then
    vars.isAfrikaansTranslatable=1
  end
  if this.IsCleard"hill_q19012"then
    vars.isKikongoTranslatable=1
  end
  if this.IsCleard"commFacility_q19013"then
    vars.isPashtoTranslatable=1
  end
  if this.IsCleard"tent_q99072"then
    vars.mbmMasterGunsmithSkill=1
  end
  do
    local cassetteAquireInfo={
      {questName="mtbs_q99060",cassetteList={"tp_m_99060_01","tp_m_99060_02","tp_m_99060_03","tp_m_99060_04","tp_m_99060_05","tp_sp_01_03"}},
      {questName="sovietBase_q99030",cassetteList={"tp_m_10150_20","tp_m_10150_29","tp_m_10150_30"}},
      {questName="tent_q99040",cassetteList={"tp_m_10150_21","tp_m_10150_22","tp_m_10150_24","tp_m_10150_25"}},
      {questName="mtbs_q99011",cassetteList={"tp_c_00000_13","tp_m_10050_03"}},
      {storySequence=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,cassetteList={"tp_m_10050_01"}},
      {storySequence=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR,cassetteList={"tp_m_10160_06","tp_m_10160_07","tp_m_10160_08","tp_m_10160_09","tp_m_10160_10","tp_m_10160_05"}},
      {storySequence=TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS,cassetteList={"tp_m_10160_11","tp_m_10160_04","tp_c_00000_18","tp_m_10240_05","tp_m_10190_02","tp_m_10190_03"}},
      {demoName="DecisionHuey",cassetteList={"tp_m_10190_05","tp_m_10190_06","tp_m_10240_03","tp_m_10240_04","tp_m_10190_01"}}
    }
    for i,info in pairs(cassetteAquireInfo)do
      if((info.questName and this.IsCleard(info.questName))
        or(info.storySequence and(TppStory.GetCurrentStorySequence()>=info.storySequence)))
        or(info.demoName and TppDemo.IsPlayedMBEventDemo(info.demoName))then
        TppCassette.Acquire{cassetteList=info.cassetteList,isShowAnnounceLog=true}
      end
    end
  end
  do
    local uniqueTypeId=110
    if this.IsCleard"cliffTown_q99080"and not TppMotherBaseManagement.IsExistStaff{uniqueTypeId=uniqueTypeId}then
      local staffId=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=uniqueTypeId}
      TppMotherBaseManagement.DirectAddStaff{staffId=staffId}
    end
    local uniqueTypeId=111
    if this.IsCleard"quest_q20095"and not TppMotherBaseManagement.IsExistStaff{uniqueTypeId= uniqueTypeId}then
      local staffId=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=uniqueTypeId}
      TppMotherBaseManagement.DirectAddStaff{staffId=staffId}
      TppMotherBaseManagement.SetLockedTanFlag{locked=false}
    end
  end
  do
    for questName,emblems in pairs(questEmblems)do
      if this.IsCleard(questName)then
        this.GetClearEmblem(questName)
      end
    end
  end
end
return this

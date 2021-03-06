-- Soldier2ParameterTables.lua
local this={}
this.parameterTables={
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=35,verticalAngle=60,horizontalAngle=60},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}
    },
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}
    },
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}
    },
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}
    },
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}
    },
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight={distanceRate=.6,angleRate=.8},
    rainSight={distanceRate=1,angleRate=1},
    cloudySight={distanceRate=1,angleRate=1},
    foggySight={distanceRate=.5,angleRate=.6}
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  --notes from bipbop/
  -- speed notes ignore ss (Sneak Suit)
  hearingRangeParameter={ -- values are distance in meters
    normal={
       -- vehicle slow, cbox slide, and any "silent" noise like prone movement and supressors
      zero=0,
      -- playerSpeed >=11.6 and <14.8 km/h?; cbox crouch mid [11.6 km/h], DW crouch slow [18 km/h]
      ss=4.5, 
      -- playerSpeed >=14.8?; same as ss, maybe hard coded; jogging (ss) [17 km/h], crouch walk fast [14.8 km/h]
      hs=5.5, 
      -- playerSpeed >=14 and <=22 km/h?; magazine, tranq dart, water bullet, running (ss) [36 km/h], horse walk [14 km/h], jogging [22 km/h], dive, cbox crouch fast [14.8 km/h]
      s=9,
      -- playerSpeed >=22 km/h and <58 km/h?; sonar, knock, whistle, rubber/lethal bullet impact, running [36 km/h], horse jog [22 km/h], DW walk [29.9 km/h], DW crouch fast [60 km/h], weapon throw, NL/chaff fire support, kicking guards awake, supply drop
      m=15,
      -- playerSpeed >= 58 km/h?; vehicle fast [max 60 km/h], horse run [58 km/h], active decoy, fulton, thrown body
      l=30,
      -- fultoning concious soldier with balloon fulton
      hll=60,
      -- unsuppressed gun discharge, explosion, artillery support
      ll=160,
      -- probably every sound other than char movement when CP issues combat alert phase
      alert=160,

      special=500
    },
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable={
    maxLife=2600,--nasanhak Life points you want enemies to have. Do not set below 550 else they will die instantly
    maxStamina=3000,--nasanhak Stamina is purely for STN/ZZZ weapons. Everybody including the player seems to have 3,000 stamina. Set to 1 to have soldiers be easy to KO
    maxLimbLife=1500,--nasanhak Life points for arms and legs. Do not set below 550 else they will die instantly, maxLife takes priority, so no point setting maxLimbLife above it
    maxArmorLife=7500,--nasanhak This determines ARMORED soldier's torso health only
    maxHelmetLife=500,--nasanhak Damage required to pop off the helmets
    sleepRecoverSec=300,--nasanhak Set to -1 (negative one) for infinite sleep
    faintRecoverSec=50,--nasanhak Changes to this make absolutely no difference, STN recovery times are controlled somewhere else
    dyingSec=60--nasanhak Set to -1 to never have bleeding soldiers die
  },
  zombieParameterTable={highHeroicValue=1e3}
}
TppSoldier2.ReloadSoldier2ParameterTables(this.parameterTables)
return this

-- DOBUILD: 0 --DEBUGWIP --DEBUGNOW
--NMC: referenced in exe, only GetTapeInfo seems to be called? Others are legacy?
-- See also lib/TppCassete.lua
--Tape files are .wem files in \chunk1_dat\Assets\tpp\sound\external\tape\
--lng entries in \chunk0_dat\Assets\tpp\pack\ui\lang\lang_default_data_<lang>_fpk\Assets\tpp\lang\ui\tpp_cassette.<lang>.lng2
--subtitles in \data1_dat\Assets\tpp\ui\Subtitles\subp\EngVoice\EngText\tape.subp
InfCore.LogFlow("PreinstallTape start:")--tex DEBUG 
PreinstallTape={
  --NMC: called during 2nd yield in start.lua, nothing seemingly related to cassets between it and prior yield, 
  --would have expected it to be during prior yeild since that's the first since TppCassetteTapeInfo.Setup() which sounds like a more likely candidate
  GetTapeInfo=function()
    InfCore.LogFlow("PreinstallTape.GetTapeInfo:")--tex DEBUG 
    return{
      albums={
        {albumId="tp_mission_01",langId="tp_mission_01",type="PREINSTALL_MISSION_INFO"},--Mission Info
        {albumId="tp_bgm_10",langId="tape_tp_bgm_10",type="PREINSTALL_MUSIC"},--Music Tape 1
        {albumId="tp_bgm_11",langId="tape_tp_bgm_11",type="PREINSTALL_BASE"},--Music Tape 2
        {albumId="tp_etc_0010",langId="tape_tp_etc_0010",type="PREINSTALL_BRIEFING"},--Ocelot's Briefing [1]
        {albumId="tp_etc_0012",langId="tape_tp_etc_0012",type="PREINSTALL_BRIEFING"},--Ocelot's Briefing [2]
        {albumId="tp_etc_0011",langId="tape_tp_etc_0011",type="PREINSTALL_BRIEFING"},--Ocelot's Briefing [3]
        {albumId="tp_etc_0020",langId="tape_tp_etc_0020",type="PREINSTALL_BRIEFING"},--Afghanistan Today [1]
        {albumId="tp_etc_0070",langId="tape_tp_etc_0070",type="PREINSTALL_BRIEFING"},--Afghanistan Today [2]
        {albumId="tp_etc_0071",langId="tape_tp_etc_0071",type="PREINSTALL_BRIEFING"},--Afghanistan Today [3]
        {albumId="tp_etc_0022",langId="tape_tp_etc_0022",type="PREINSTALL_BRIEFING"},--At Mother Base [1]
        {albumId="tp_etc_0023",langId="tape_tp_etc_0023",type="PREINSTALL_BRIEFING"},--At Mother Base [2]
        {albumId="tp_etc_9000",langId="tape_tp_etc_9000",type="PREINSTALL_BRIEFING"},--At Mother Base [3]
        {albumId="tp_etc_9001",langId="tape_tp_etc_9001",type="PREINSTALL_BRIEFING"},--At Mother Base [4]
        {albumId="tp_etc_9002",langId="tape_tp_etc_9002",type="PREINSTALL_BRIEFING"},--At Mother Base [5]
        {albumId="tp_etc_9004",langId="tape_tp_etc_9004",type="PREINSTALL_BRIEFING"},--At Mother Base [Supplemental 1]
        {albumId="tp_etc_9003",langId="tape_tp_etc_9003",type="PREINSTALL_BRIEFING"},--At Mother Base [Supplemental 2]
        {albumId="tp_etc_0021",langId="tape_tp_etc_0021",type="PREINSTALL_BRIEFING"},--What Happened to Old Mother Base Members
        {albumId="tp_etc_0120",langId="tape_tp_etc_0120",type="PREINSTALL_BRIEFING"},--Quiet [1]
        {albumId="tp_etc_0121",langId="tape_tp_etc_0121",type="PREINSTALL_BRIEFING"},--Quiet [2]
        {albumId="tp_etc_0122",langId="tape_tp_etc_0122",type="PREINSTALL_BRIEFING"},--Quiet [3]
        {albumId="tp_etc_0123",langId="tape_tp_etc_0123",type="PREINSTALL_BRIEFING"},--Quiet [4]
        {albumId="tp_etc_0124",langId="tape_tp_etc_0124",type="PREINSTALL_BRIEFING"},--Quiet [5]
        {albumId="tp_etc_0125",langId="tape_tp_etc_0125",type="PREINSTALL_BRIEFING"},--Quiet [6]
        {albumId="tp_etc_0126",langId="tape_tp_etc_0126",type="PREINSTALL_BRIEFING"},--Quiet [7]
        {albumId="tp_etc_1010",langId="tape_tp_etc_1010",type="PREINSTALL_BRIEFING"},--Questioning Huey [1]
        {albumId="tp_etc_1016",langId="tape_tp_etc_1016",type="PREINSTALL_BRIEFING"},--Questioning Huey [2]
        {albumId="tp_etc_1011",langId="tape_tp_etc_1011",type="PREINSTALL_BRIEFING"},--Questioning Huey [3]
        {albumId="tp_etc_1012",langId="tape_tp_etc_1012",type="PREINSTALL_BRIEFING"},--Questioning Huey [4]
        {albumId="tp_etc_1013",langId="tape_tp_etc_1013",type="PREINSTALL_BRIEFING"},--Questioning Huey [5]
        {albumId="tp_etc_1015",langId="tape_tp_etc_1015",type="PREINSTALL_BRIEFING"},--Questioning Huey [6]
        {albumId="tp_etc_1014",langId="tape_tp_etc_1014",type="PREINSTALL_BRIEFING"},--Questioning Huey [7]
        {albumId="tp_etc_0170",langId="tape_tp_etc_0170",type="PREINSTALL_BRIEFING"},--Cipher's Cargo [1]
        {albumId="tp_etc_0171",langId="tape_tp_etc_0171",type="PREINSTALL_BRIEFING"},--Cipher's Cargo [2]
        {albumId="tp_etc_0200",langId="tape_tp_etc_0200",type="PREINSTALL_BRIEFING"},--Africa Today [1]
        {albumId="tp_etc_0201",langId="tape_tp_etc_0201",type="PREINSTALL_BRIEFING"},--Africa Today [2]
        {albumId="tp_etc_0203",langId="tape_tp_etc_0203",type="PREINSTALL_BRIEFING"},--Africa Today [3]
        {albumId="tp_etc_0202",langId="tape_tp_etc_0202",type="PREINSTALL_BRIEFING"},--Africa Today [4]
        {albumId="tp_etc_0210",langId="tape_tp_etc_0210",type="PREINSTALL_BRIEFING"},--The Factory of the Dead
        {albumId="tp_etc_0211",langId="tape_tp_etc_0211",type="PREINSTALL_BRIEFING"},--The Man on Fire [1]
        {albumId="tp_etc_0212",langId="tape_tp_etc_0212",type="PREINSTALL_BRIEFING"},--The Man on Fire [2]
        {albumId="tp_etc_0213",langId="tape_tp_etc_0213",type="PREINSTALL_BRIEFING"},--The Man on Fire [3]
        {albumId="tp_etc_0240",langId="tape_tp_etc_0240",type="PREINSTALL_BRIEFING"},--The White Mamba [1]
        {albumId="tp_etc_0241",langId="tape_tp_etc_0241",type="PREINSTALL_BRIEFING"},--The White Mamba [2]
        {albumId="tp_etc_0242",langId="tape_tp_etc_0242",type="PREINSTALL_BRIEFING"},--The White Mamba [3]
        {albumId="tp_etc_0300",langId="tape_tp_etc_0300",type="PREINSTALL_BRIEFING"},--Vocal Cord Parasites [1]
        {albumId="tp_etc_0320",langId="tape_tp_etc_0320",type="PREINSTALL_BRIEFING"},--Vocal Cord Parasites [2]
        {albumId="tp_etc_0330",langId="tape_tp_etc_0330",type="PREINSTALL_BRIEFING"},--"Vocal Cord Parasites [3]
        {albumId="tp_etc_0331",langId="tape_tp_etc_0331",type="PREINSTALL_BRIEFING"},--Sahelanthropus [1]
        {albumId="tp_etc_0325",langId="tape_tp_etc_0325",type="PREINSTALL_BRIEFING"},--Sahelanthropus [2]
        {albumId="tp_etc_0326",langId="tape_tp_etc_0326",type="PREINSTALL_BRIEFING"},--Sahelanthropus [3]
        {albumId="tp_etc_0301",langId="tape_tp_etc_0301",type="PREINSTALL_BRIEFING"},--Metallic Archaea [1]
        {albumId="tp_etc_0303",langId="tape_tp_etc_0303",type="PREINSTALL_BRIEFING"},--Metallic Archaea [2]
        {albumId="tp_etc_0304",langId="tape_tp_etc_0304",type="PREINSTALL_BRIEFING"},--Metallic Archaea [3]
        {albumId="tp_etc_0302",langId="tape_tp_etc_0302",type="PREINSTALL_BRIEFING"},--Metallic Archaea [4]
        {albumId="tp_etc_0321",langId="tape_tp_etc_0321",type="PREINSTALL_BRIEFING"},--Code Talker and His Research [1]
        {albumId="tp_etc_0332",langId="tape_tp_etc_0332",type="PREINSTALL_BRIEFING"},--Code Talker and His Research [2]
        {albumId="tp_etc_0333",langId="tape_tp_etc_0333",type="PREINSTALL_BRIEFING"},--Code Talker and His Research [3]
        {albumId="tp_etc_0322",langId="tape_tp_etc_0322",type="PREINSTALL_BRIEFING"},--Code Talker and His Research [4]
        {albumId="tp_etc_0323",langId="tape_tp_etc_0323",type="PREINSTALL_BRIEFING"},--Code Talker and His Research [5]
        {albumId="tp_etc_0327",langId="tape_tp_etc_0327",type="PREINSTALL_BRIEFING"},--Skull Face's Objective [1]
        {albumId="tp_etc_0334",langId="tape_tp_etc_0334",type="PREINSTALL_BRIEFING"},--Skull Face's Objective [2]
        {albumId="tp_etc_0328",langId="tape_tp_etc_0328",type="PREINSTALL_BRIEFING"},--Skull Face's Objective [3]
        {albumId="tp_etc_0329",langId="tape_tp_etc_0329",type="PREINSTALL_BRIEFING"},--Skull Face's Objective [4]
        {albumId="tp_etc_0335",langId="tape_tp_etc_0335",type="PREINSTALL_BRIEFING"},--Skull Face's Objective [5]
        {albumId="tp_etc_1000",langId="tape_tp_etc_1000",type="PREINSTALL_BRIEFING"},--The Children Escape [1]
        {albumId="tp_etc_1001",langId="tape_tp_etc_1001",type="PREINSTALL_BRIEFING"},--The Children Escape [2]
        {albumId="tp_etc_1002",langId="tape_tp_etc_1002",type="PREINSTALL_BRIEFING"},--The Children Escape [3]
        {albumId="tp_etc_1003",langId="tape_tp_etc_1003",type="PREINSTALL_BRIEFING"},--The Children Escape [4]
        {albumId="tp_etc_1004",langId="tape_tp_etc_1004",type="PREINSTALL_BRIEFING"},--The Children Escape [5]
        {albumId="tp_etc_1005",langId="tape_tp_etc_1005",type="PREINSTALL_BRIEFING"},--The Children Escape [6]
        {albumId="tp_etc_0340",langId="tape_tp_etc_0340",type="PREINSTALL_BRIEFING"},--Informant's Report
        {albumId="tp_etc_0370",langId="tape_tp_etc_0370",type="PREINSTALL_BRIEFING"},--What Happened in the Laboratory [1]
        {albumId="tp_etc_0371",langId="tape_tp_etc_0371",type="PREINSTALL_BRIEFING"},--What Happened in the Laboratory [2]
        {albumId="tp_etc_0372",langId="tape_tp_etc_0372",type="PREINSTALL_BRIEFING"},--What Happened in the Laboratory [3]
        {albumId="tp_etc_1100",langId="tape_tp_etc_1100",type="PREINSTALL_BRIEFING"},--Paz's Diary (Continued) [1]
        {albumId="tp_etc_1101",langId="tape_tp_etc_1101",type="PREINSTALL_BRIEFING"},--Paz's Diary (Continued) [2]
        {albumId="tp_etc_1102",langId="tape_tp_etc_1102",type="PREINSTALL_BRIEFING"},--Paz's Diary (Continued) [3]
        {albumId="tp_etc_1103",langId="tape_tp_etc_1103",type="PREINSTALL_BRIEFING"},--Paz's Diary (Continued) [4]
        {albumId="tp_etc_1104",langId="tape_tp_etc_1104",type="PREINSTALL_BRIEFING"},--Paz's Diary (Continued) [5]
        {albumId="tp_etc_9010",langId="tape_tp_etc_9010",type="PREINSTALL_BRIEFING"},--The Hamburgers of Kazuhira Miller [1]
        {albumId="tp_etc_9011",langId="tape_tp_etc_9011",type="PREINSTALL_BRIEFING"},--The Hamburgers of Kazuhira Miller [2]
        {albumId="tp_etc_9012",langId="tape_tp_etc_9012",type="PREINSTALL_BRIEFING"},--The Hamburgers of Kazuhira Miller [3]
        {albumId="tp_etc_9013",langId="tape_tp_etc_9013",type="PREINSTALL_BRIEFING"},--The Hamburgers of Kazuhira Miller [4]
        {albumId="tp_etc_0390",langId="tape_tp_etc_0390",type="PREINSTALL_BRIEFING"},--Truth Records
        {albumId="tp_sp_01_01",langId="tape_tp_sp_01_01",type="PREINSTALL_SPECIAL"},--Afghanistan Music
        {albumId="tp_sp_01_02",langId="tape_tp_sp_01_02",type="PREINSTALL_SPECIAL"},--Central Africa Music"
        {albumId="tp_sp_01_03",langId="tape_tp_sp_01_03",type="PREINSTALL_SPECIAL"},--Paz's Humming
        {albumId="tp_sp_01_04",langId="tape_tp_sp_01_04",type="PREINSTALL_SPECIAL"},--Quiet's Humming
        {albumId="tp_sp_01_05",langId="tape_tp_sp_01_05",type="PREINSTALL_SPECIAL"},--Afghanistan Soviet Soldier
        {albumId="tp_sp_01_06",langId="tape_tp_sp_01_06",type="PREINSTALL_SPECIAL"},--Central Africa PF Soldier
        {albumId="tp_sp_01_07",langId="tape_tp_sp_01_07",type="PREINSTALL_SPECIAL"},--Soldier with Stomachache
        {albumId="tp_sp_01_08",langId="tape_tp_sp_01_08",type="PREINSTALL_SPECIAL"},--Bird
        {albumId="tp_sp_01_09",langId="tape_tp_sp_01_09",type="PREINSTALL_SPECIAL"},--Goat
        {albumId="tp_sp_01_10",langId="tape_tp_sp_01_10",type="PREINSTALL_SPECIAL"},--Horse
        {albumId="tp_sp_01_11",langId="tape_tp_sp_01_11",type="PREINSTALL_SPECIAL"},--Wolf
        {albumId="tp_sp_01_12",langId="tape_tp_sp_01_12",type="PREINSTALL_SPECIAL"},--Bear
      },--albums
      tracks={
      --max saveIndex 207
        {albumId="tp_etc_0010",saveIndex=34,langId="tp_m_10010_01",dataTimeJp=54e3,dataTimeEn=45e3,important=1,special=0,fileName="tp_m_10010_01"},--British Sovereign Base Area - Dhekelia
        {albumId="tp_etc_0010",saveIndex=35,langId="tp_m_10010_02",dataTimeJp=94e3,dataTimeEn=92e3,important=0,special=0,fileName="tp_m_10010_02"},--Cyprus, a Nation Divided
        {albumId="tp_etc_0010",saveIndex=43,langId="tp_m_10010_10",dataTimeJp=83e3,dataTimeEn=82e3,important=0,special=0,fileName="tp_m_10010_10"},--The Route to Afghanistan
        {albumId="tp_etc_0010",saveIndex=36,langId="tp_m_10010_03",dataTimeJp=154e3,dataTimeEn=147e3,important=0,special=0,fileName="tp_m_10010_03"},--World Affairs Over the 9 Years
        {albumId="tp_etc_0010",saveIndex=38,langId="tp_m_10010_05",dataTimeJp=119e3,dataTimeEn=92e3,important=1,special=0,fileName="tp_m_10010_05"},--What Happened in the Caribbean 9 Years Ago
        {albumId="tp_etc_0010",saveIndex=39,langId="tp_m_10010_06",dataTimeJp=158e3,dataTimeEn=143e3,important=1,special=0,fileName="tp_m_10010_06"},--The Strike Force: After the Attack
        {albumId="tp_etc_0010",saveIndex=40,langId="tp_m_10010_07",dataTimeJp=101e3,dataTimeEn=87e3,important=1,special=0,fileName="tp_m_10010_07"},--After-Effects of Snake's Coma
        {albumId="tp_etc_0012",saveIndex=125,langId="tp_m_10280_11",dataTimeJp=207e3,dataTimeEn=189e3,important=0,special=0,fileName="tp_m_10280_11"},--The Moniker Shalashaska
        {albumId="tp_etc_0011",saveIndex=37,langId="tp_m_10010_04",dataTimeJp=77e3,dataTimeEn=78e3,important=0,special=0,fileName="tp_m_10010_04"},--SALT II
        {albumId="tp_etc_0011",saveIndex=41,langId="tp_m_10010_08",dataTimeJp=158e3,dataTimeEn=146e3,important=0,special=0,fileName="tp_m_10010_08"},--Meeting Ocelot, and the Formation of a Certain Organization
        {albumId="tp_etc_0011",saveIndex=42,langId="tp_m_10010_09",dataTimeJp=105e3,dataTimeEn=1e5,important=0,special=0,fileName="tp_m_10010_09"},--Where is Zero?
        {albumId="tp_etc_0020",saveIndex=46,langId="tp_m_10020_01",dataTimeJp=81e3,dataTimeEn=9e4,important=0,special=0,fileName="tp_m_10020_01"},--The Soviet Invasion of Afghanistan
        {albumId="tp_etc_0020",saveIndex=47,langId="tp_m_10020_02",dataTimeJp=65e3,dataTimeEn=69e3,important=0,special=0,fileName="tp_m_10020_02"},--The Soviet Army's Scorched Earth Operation
        {albumId="tp_etc_0070",saveIndex=48,langId="tp_m_10040_01",dataTimeJp=6e4,dataTimeEn=62e3,important=0,special=0,fileName="tp_m_10040_01"},--The Threat of Soviet Gunships
        {albumId="tp_etc_0070",saveIndex=49,langId="tp_m_10040_02",dataTimeJp=85e3,dataTimeEn=83e3,important=0,special=0,fileName="tp_m_10040_02"},--
        {albumId="tp_etc_0071",saveIndex=50,langId="tp_m_10040_03",dataTimeJp=72e3,dataTimeEn=65e3,important=0,special=0,fileName="tp_m_10040_03"},--
        {albumId="tp_etc_0022",saveIndex=56,langId="tp_m_10020_05",dataTimeJp=125e3,dataTimeEn=119e3,important=1,special=0,fileName="tp_m_10020_05"},--
        {albumId="tp_etc_0022",saveIndex=57,langId="tp_m_10020_06",dataTimeJp=87e3,dataTimeEn=79e3,important=0,special=0,fileName="tp_m_10020_06"},--
        {albumId="tp_etc_0022",saveIndex=54,langId="tp_m_10020_03",dataTimeJp=17e4,dataTimeEn=166e3,important=0,special=0,fileName="tp_m_10020_03"},--
        {albumId="tp_etc_0022",saveIndex=55,langId="tp_m_10020_04",dataTimeJp=95e3,dataTimeEn=9e4,important=0,special=0,fileName="tp_m_10020_04"},--
        {albumId="tp_etc_0022",saveIndex=45,langId="tp_c_00000_03",dataTimeJp=89e3,dataTimeEn=91e3,important=0,special=0,fileName="tp_c_00000_03"},--Whaling Ship &quot;Heiwa Maru&quot;
        {albumId="tp_etc_0022",saveIndex=60,langId="tp_m_10020_12",dataTimeJp=39e3,dataTimeEn=33e3,important=0,special=0,fileName="tp_m_10020_12"},--Origins of &quot;Diamond&quot;
        {albumId="tp_etc_0023",saveIndex=58,langId="tp_m_10020_07",dataTimeJp=171e3,dataTimeEn=165e3,important=1,special=0,fileName="tp_m_10020_07"},--
        {albumId="tp_etc_0023",saveIndex=59,langId="tp_m_10020_08",dataTimeJp=83e3,dataTimeEn=73e3,important=0,special=0,fileName="tp_m_10020_08"},--
        {albumId="tp_etc_9000",saveIndex=63,langId="tp_c_00000_14",dataTimeJp=85e3,dataTimeEn=89e3,important=0,special=0,fileName="tp_c_00000_14"},--
        {albumId="tp_etc_9001",saveIndex=62,langId="tp_c_00000_12",dataTimeJp=94e3,dataTimeEn=98e3,important=0,special=0,fileName="tp_c_00000_12"},--
        {albumId="tp_etc_9002",saveIndex=61,langId="tp_c_00000_01",dataTimeJp=89e3,dataTimeEn=88e3,important=0,special=0,fileName="tp_c_00000_01"},--
        {albumId="tp_etc_9004",saveIndex=201,langId="tp_c_00000_18",dataTimeJp=91e3,dataTimeEn=88e3,important=0,special=0,fileName="tp_c_00000_18"},--
        {albumId="tp_etc_9003",saveIndex=64,langId="tp_c_00000_16",dataTimeJp=122e3,dataTimeEn=131e3,important=1,special=0,fileName="tp_c_00000_16"},--
        {albumId="tp_etc_0021",saveIndex=51,langId="tp_m_10020_09",dataTimeJp=45e3,dataTimeEn=5e4,important=0,special=0,fileName="tp_m_10020_09"},--
        {albumId="tp_etc_0021",saveIndex=52,langId="tp_m_10020_10",dataTimeJp=71e3,dataTimeEn=67e3,important=0,special=0,fileName="tp_m_10020_10"},--
        {albumId="tp_etc_0021",saveIndex=53,langId="tp_m_10020_11",dataTimeJp=76e3,dataTimeEn=71e3,important=0,special=0,fileName="tp_m_10020_11"},--
        {albumId="tp_etc_0120",saveIndex=65,langId="tp_m_10050_01",dataTimeJp=126e3,dataTimeEn=121e3,important=0,special=0,fileName="tp_m_10050_01"},--
        {albumId="tp_etc_0121",saveIndex=154,langId="tp_c_00000_06",dataTimeJp=62e3,dataTimeEn=6e4,important=0,special=0,fileName="tp_c_00000_06"},--
        {albumId="tp_etc_0121",saveIndex=66,langId="tp_m_10050_02",dataTimeJp=137e3,dataTimeEn=121e3,important=1,special=0,fileName="tp_m_10050_02"},--
        {albumId="tp_etc_0122",saveIndex=67,langId="tp_m_10050_03",dataTimeJp=72e3,dataTimeEn=62e3,important=0,special=0,fileName="tp_m_10050_03"},--
        {albumId="tp_etc_0123",saveIndex=155,langId="tp_c_00000_13",dataTimeJp=137e3,dataTimeEn=149e3,important=0,special=0,fileName="tp_c_00000_13"},--
        {albumId="tp_etc_0124",saveIndex=153,langId="tp_c_00000_02",dataTimeJp=78e3,dataTimeEn=71e3,important=0,special=0,fileName="tp_c_00000_02"},--
        {albumId="tp_etc_0125",saveIndex=150,langId="tp_m_10260_01",dataTimeJp=135e3,dataTimeEn=136e3,important=1,special=0,fileName="tp_m_10260_01"},--
        {albumId="tp_etc_0126",saveIndex=152,langId="tp_m_10260_03",dataTimeJp=63e3,dataTimeEn=63e3,important=0,special=0,fileName="tp_m_10260_03"},--
        {albumId="tp_etc_1010",saveIndex=166,langId="tp_m_10070_03",dataTimeJp=196e3,dataTimeEn=186e3,important=1,special=0,fileName="tp_m_10070_03"},--
        {albumId="tp_etc_1010",saveIndex=167,langId="tp_m_10070_04",dataTimeJp=121e3,dataTimeEn=123e3,important=0,special=0,fileName="tp_m_10070_04"},--
        {albumId="tp_etc_1010",saveIndex=168,langId="tp_m_10070_05",dataTimeJp=211e3,dataTimeEn=222e3,important=0,special=0,fileName="tp_m_10070_05"},--
        {albumId="tp_etc_1010",saveIndex=169,langId="tp_m_10070_06",dataTimeJp=46e3,dataTimeEn=42e3,important=0,special=0,fileName="tp_m_10070_06"},--
        {albumId="tp_etc_1010",saveIndex=171,langId="tp_m_10070_08",dataTimeJp=107e3,dataTimeEn=86e3,important=0,special=0,fileName="tp_m_10070_08"},--
        {albumId="tp_etc_1016",saveIndex=170,langId="tp_m_10070_07",dataTimeJp=165e3,dataTimeEn=17e4,important=0,special=0,fileName="tp_m_10070_07"},--
        {albumId="tp_etc_1016",saveIndex=164,langId="tp_m_10070_01",dataTimeJp=103e3,dataTimeEn=132e3,important=0,special=0,fileName="tp_m_10070_01"},--
        {albumId="tp_etc_1016",saveIndex=165,langId="tp_m_10070_02",dataTimeJp=14e4,dataTimeEn=16e4,important=0,special=0,fileName="tp_m_10070_02"},--
        {albumId="tp_etc_1011",saveIndex=172,langId="tp_m_10190_01",dataTimeJp=206e3,dataTimeEn=225e3,important=1,special=0,fileName="tp_m_10190_01"},--
        {albumId="tp_etc_1012",saveIndex=173,langId="tp_m_10190_02",dataTimeJp=85e3,dataTimeEn=9e4,important=1,special=0,fileName="tp_m_10190_02"},--
        {albumId="tp_etc_1013",saveIndex=174,langId="tp_m_10190_03",dataTimeJp=184e3,dataTimeEn=187e3,important=1,special=0,fileName="tp_m_10190_03"},--
        {albumId="tp_etc_1015",saveIndex=175,langId="tp_m_10190_04",dataTimeJp=191e3,dataTimeEn=181e3,important=1,special=0,fileName="tp_m_10190_04"},--
        {albumId="tp_etc_1014",saveIndex=176,langId="tp_m_10190_05",dataTimeJp=31e3,dataTimeEn=26e3,important=0,special=0,fileName="tp_m_10190_05"},--
        {albumId="tp_etc_1014",saveIndex=177,langId="tp_m_10190_06",dataTimeJp=653e3,dataTimeEn=659e3,important=1,special=0,fileName="tp_m_10190_06"},--
        {albumId="tp_etc_0170",saveIndex=68,langId="tp_m_10090_01",dataTimeJp=76e3,dataTimeEn=74e3,important=1,special=0,fileName="tp_m_10090_01"},--
        {albumId="tp_etc_0171",saveIndex=69,langId="tp_m_10090_02",dataTimeJp=111e3,dataTimeEn=108e3,important=1,special=0,fileName="tp_m_10090_02"},--
        {albumId="tp_etc_0171",saveIndex=70,langId="tp_m_10090_03",dataTimeJp=109e3,dataTimeEn=94e3,important=0,special=0,fileName="tp_m_10090_03"},--
        {albumId="tp_etc_0200",saveIndex=44,langId="tp_m_10100_02",dataTimeJp=12e4,dataTimeEn=101e3,important=0,special=0,fileName="tp_m_10100_02"},--
        {albumId="tp_etc_0200",saveIndex=73,langId="tp_c_00000_07",dataTimeJp=38e3,dataTimeEn=3e4,important=0,special=0,fileName="tp_c_00000_07"},--
        {albumId="tp_etc_0200",saveIndex=74,langId="tp_c_00000_08",dataTimeJp=53e3,dataTimeEn=42e3,important=0,special=0,fileName="tp_c_00000_08"},--
        {albumId="tp_etc_0200",saveIndex=77,langId="tp_c_00000_11",dataTimeJp=52e3,dataTimeEn=43e3,important=0,special=0,fileName="tp_c_00000_11"},--
        {albumId="tp_etc_0200",saveIndex=78,langId="tp_c_00000_17",dataTimeJp=57e3,dataTimeEn=6e4,important=0,special=0,fileName="tp_c_00000_17"},--
        {albumId="tp_etc_0201",saveIndex=72,langId="tp_m_10100_03",dataTimeJp=1e5,dataTimeEn=99e3,important=1,special=0,fileName="tp_m_10100_03"},--
        {albumId="tp_etc_0203",saveIndex=76,langId="tp_c_00000_10",dataTimeJp=38e3,dataTimeEn=34e3,important=0,special=0,fileName="tp_c_00000_10"},--
        {albumId="tp_etc_0202",saveIndex=75,langId="tp_c_00000_09",dataTimeJp=78e3,dataTimeEn=67e3,important=0,special=0,fileName="tp_c_00000_09"},--
        {albumId="tp_etc_0202",saveIndex=71,langId="tp_m_10100_01",dataTimeJp=132e3,dataTimeEn=108e3,important=0,special=0,fileName="tp_m_10100_01"},--
        {albumId="tp_etc_0210",saveIndex=79,langId="tp_m_10110_01",dataTimeJp=71e3,dataTimeEn=66e3,important=1,special=0,fileName="tp_m_10110_01"},--
        {albumId="tp_etc_0210",saveIndex=80,langId="tp_m_10110_02",dataTimeJp=174e3,dataTimeEn=181e3,important=1,special=0,fileName="tp_m_10110_02"},--
        {albumId="tp_etc_0211",saveIndex=81,langId="tp_m_10110_03",dataTimeJp=36e3,dataTimeEn=34e3,important=1,special=0,fileName="tp_m_10110_03"},--
        {albumId="tp_etc_0212",saveIndex=82,langId="tp_m_10150_04",dataTimeJp=74e3,dataTimeEn=67e3,important=0,special=0,fileName="tp_m_10150_04"},--
        {albumId="tp_etc_0213",saveIndex=83,langId="tp_m_10150_21",dataTimeJp=94e3,dataTimeEn=97e3,important=0,special=0,fileName="tp_m_10150_21"},--
        {albumId="tp_etc_0213",saveIndex=84,langId="tp_m_10150_22",dataTimeJp=61e3,dataTimeEn=65e3,important=0,special=0,fileName="tp_m_10150_22"},--
        {albumId="tp_etc_0240",saveIndex=85,langId="tp_m_10120_01",dataTimeJp=11e4,dataTimeEn=92e3,important=0,special=0,fileName="tp_m_10120_01"},--
        {albumId="tp_etc_0240",saveIndex=86,langId="tp_m_10120_02",dataTimeJp=94e3,dataTimeEn=68e3,important=0,special=0,fileName="tp_m_10120_02"},--
        {albumId="tp_etc_0241",saveIndex=87,langId="tp_m_10120_03",dataTimeJp=79e3,dataTimeEn=75e3,important=0,special=0,fileName="tp_m_10120_03"},--
        {albumId="tp_etc_0242",saveIndex=88,langId="tp_m_10160_11",dataTimeJp=114e3,dataTimeEn=121e3,important=1,special=0,fileName="tp_m_10160_11"},--
        {albumId="tp_etc_0300",saveIndex=89,langId="tp_m_10140_01",dataTimeJp=154e3,dataTimeEn=168e3,important=1,special=0,fileName="tp_m_10140_01"},--
        {albumId="tp_etc_0300",saveIndex=90,langId="tp_m_10140_02",dataTimeJp=85e3,dataTimeEn=103e3,important=1,special=0,fileName="tp_m_10140_02"},--
        {albumId="tp_etc_0300",saveIndex=91,langId="tp_m_10140_03",dataTimeJp=113e3,dataTimeEn=122e3,important=0,special=0,fileName="tp_m_10140_03"},--
        {albumId="tp_etc_0320",saveIndex=92,langId="tp_m_10150_15",dataTimeJp=142e3,dataTimeEn=139e3,important=0,special=0,fileName="tp_m_10150_15"},--
        {albumId="tp_etc_0320",saveIndex=93,langId="tp_m_10150_16",dataTimeJp=204e3,dataTimeEn=199e3,important=0,special=0,fileName="tp_m_10150_16"},--
        {albumId="tp_etc_0320",saveIndex=94,langId="tp_m_10150_17",dataTimeJp=119e3,dataTimeEn=124e3,important=0,special=0,fileName="tp_m_10150_17"},--
        {albumId="tp_etc_0320",saveIndex=95,langId="tp_m_10150_23",dataTimeJp=251e3,dataTimeEn=254e3,important=0,special=0,fileName="tp_m_10150_23"},--
        {albumId="tp_etc_0330",saveIndex=96,langId="tp_m_10150_24",dataTimeJp=284e3,dataTimeEn=275e3,important=0,special=0,fileName="tp_m_10150_24"},--
        {albumId="tp_etc_0330",saveIndex=97,langId="tp_m_10150_25",dataTimeJp=19e4,dataTimeEn=167e3,important=0,special=0,fileName="tp_m_10150_25"},--
        {albumId="tp_etc_0331",saveIndex=99,langId="tp_m_10140_05",dataTimeJp=89e3,dataTimeEn=9e4,important=0,special=0,fileName="tp_m_10140_05"},--
        {albumId="tp_etc_0331",saveIndex=116,langId="tp_c_00000_04",dataTimeJp=84e3,dataTimeEn=88e3,important=0,special=0,fileName="tp_c_00000_04"},--
        {albumId="tp_etc_0325",saveIndex=117,langId="tp_c_00000_05",dataTimeJp=73e3,dataTimeEn=73e3,important=0,special=0,fileName="tp_c_00000_05"},--
        {albumId="tp_etc_0326",saveIndex=115,langId="tp_m_10150_01",dataTimeJp=129e3,dataTimeEn=105e3,important=0,special=0,fileName="tp_m_10150_01"},--
        {albumId="tp_etc_0301",saveIndex=98,langId="tp_m_10140_04",dataTimeJp=118e3,dataTimeEn=136e3,important=1,special=0,fileName="tp_m_10140_04"},--
        {albumId="tp_etc_0301",saveIndex=101,langId="tp_m_10140_07",dataTimeJp=11e4,dataTimeEn=108e3,important=0,special=0,fileName="tp_m_10140_07"},--
        {albumId="tp_etc_0303",saveIndex=100,langId="tp_m_10140_06",dataTimeJp=17e4,dataTimeEn=148e3,important=0,special=0,fileName="tp_m_10140_06"},--
        {albumId="tp_etc_0304",saveIndex=103,langId="tp_m_10150_19",dataTimeJp=123e3,dataTimeEn=139e3,important=0,special=0,fileName="tp_m_10150_19"},--
        {albumId="tp_etc_0302",saveIndex=104,langId="tp_m_10150_26",dataTimeJp=127e3,dataTimeEn=115e3,important=1,special=0,fileName="tp_m_10150_26"},--
        {albumId="tp_etc_0302",saveIndex=102,langId="tp_m_10150_18",dataTimeJp=218e3,dataTimeEn=227e3,important=0,special=0,fileName="tp_m_10150_18"},--
        {albumId="tp_etc_0321",saveIndex=105,langId="tp_m_10150_27",dataTimeJp=241e3,dataTimeEn=232e3,important=0,special=0,fileName="tp_m_10150_27"},--
        {albumId="tp_etc_0332",saveIndex=108,langId="tp_m_10150_31",dataTimeJp=148e3,dataTimeEn=127e3,important=1,special=0,fileName="tp_m_10150_31"},--
        {albumId="tp_etc_0333",saveIndex=106,langId="tp_m_10150_29",dataTimeJp=143e3,dataTimeEn=138e3,important=0,special=0,fileName="tp_m_10150_29"},--
        {albumId="tp_etc_0333",saveIndex=107,langId="tp_m_10150_30",dataTimeJp=193e3,dataTimeEn=193e3,important=0,special=0,fileName="tp_m_10150_30"},--
        {albumId="tp_etc_0322",saveIndex=109,langId="tp_m_10093_01",dataTimeJp=255e3,dataTimeEn=284e3,important=0,special=0,fileName="tp_m_10093_01"},--
        {albumId="tp_etc_0322",saveIndex=110,langId="tp_m_10093_02",dataTimeJp=354e3,dataTimeEn=388e3,important=0,special=0,fileName="tp_m_10093_02"},--
        {albumId="tp_etc_0322",saveIndex=111,langId="tp_m_10093_03",dataTimeJp=301e3,dataTimeEn=344e3,important=0,special=0,fileName="tp_m_10093_03"},--
        {albumId="tp_etc_0322",saveIndex=112,langId="tp_m_10093_04",dataTimeJp=21e4,dataTimeEn=249e3,important=0,special=0,fileName="tp_m_10093_04"},--
        {albumId="tp_etc_0322",saveIndex=113,langId="tp_m_10093_05",dataTimeJp=152e3,dataTimeEn=175e3,important=0,special=0,fileName="tp_m_10093_05"},--
        {albumId="tp_etc_0323",saveIndex=114,langId="tp_m_10240_04",dataTimeJp=287e3,dataTimeEn=318e3,important=0,special=0,fileName="tp_m_10240_04"},--
        {albumId="tp_etc_0327",saveIndex=131,langId="tp_m_10150_02",dataTimeJp=135e3,dataTimeEn=125e3,important=0,special=0,fileName="tp_m_10150_02"},--
        {albumId="tp_etc_0327",saveIndex=133,langId="tp_m_10150_05",dataTimeJp=156e3,dataTimeEn=146e3,important=0,special=0,fileName="tp_m_10150_05"},--
        {albumId="tp_etc_0327",saveIndex=134,langId="tp_m_10150_06",dataTimeJp=123e3,dataTimeEn=11e4,important=0,special=0,fileName="tp_m_10150_06"},--
        {albumId="tp_etc_0327",saveIndex=135,langId="tp_m_10150_07",dataTimeJp=89e3,dataTimeEn=74e3,important=0,special=0,fileName="tp_m_10150_07"},--
        {albumId="tp_etc_0327",saveIndex=136,langId="tp_m_10150_08",dataTimeJp=107e3,dataTimeEn=95e3,important=1,special=0,fileName="tp_m_10150_08"},--
        {albumId="tp_etc_0334",saveIndex=132,langId="tp_m_10150_03",dataTimeJp=69e3,dataTimeEn=66e3,important=0,special=0,fileName="tp_m_10150_03"},--
        {albumId="tp_etc_0334",saveIndex=137,langId="tp_m_10150_10",dataTimeJp=133e3,dataTimeEn=116e3,important=0,special=0,fileName="tp_m_10150_10"},--
        {albumId="tp_etc_0328",saveIndex=141,langId="tp_m_10150_20",dataTimeJp=186e3,dataTimeEn=156e3,important=0,special=0,fileName="tp_m_10150_20"},--
        {albumId="tp_etc_0329",saveIndex=140,langId="tp_m_10150_14",dataTimeJp=327e3,dataTimeEn=3e5,important=0,special=0,fileName="tp_m_10150_14"},--
        {albumId="tp_etc_0329",saveIndex=142,langId="tp_m_10150_28",dataTimeJp=647e3,dataTimeEn=631e3,important=0,special=0,fileName="tp_m_10150_28"},--
        {albumId="tp_etc_0335",saveIndex=138,langId="tp_m_10150_11",dataTimeJp=19e4,dataTimeEn=163e3,important=1,special=0,fileName="tp_m_10150_11"},--
        {albumId="tp_etc_0335",saveIndex=139,langId="tp_m_10150_12",dataTimeJp=63e3,dataTimeEn=56e3,important=0,special=0,fileName="tp_m_10150_12"},--
        {albumId="tp_etc_1000",saveIndex=158,langId="tp_m_10160_05",dataTimeJp=64e3,dataTimeEn=7e4,important=1,special=0,fileName="tp_m_10160_05"},--
        {albumId="tp_etc_1001",saveIndex=159,langId="tp_m_10160_06",dataTimeJp=79e3,dataTimeEn=9e4,important=1,special=0,fileName="tp_m_10160_06"},--
        {albumId="tp_etc_1002",saveIndex=160,langId="tp_m_10160_07",dataTimeJp=36e3,dataTimeEn=41e3,important=1,special=0,fileName="tp_m_10160_07"},--
        {albumId="tp_etc_1003",saveIndex=161,langId="tp_m_10160_08",dataTimeJp=1e5,dataTimeEn=108e3,important=1,special=0,fileName="tp_m_10160_08"},--
        {albumId="tp_etc_1004",saveIndex=162,langId="tp_m_10160_09",dataTimeJp=133e3,dataTimeEn=128e3,important=1,special=0,fileName="tp_m_10160_09"},--
        {albumId="tp_etc_1004",saveIndex=163,langId="tp_m_10160_10",dataTimeJp=43e3,dataTimeEn=47e3,important=1,special=0,fileName="tp_m_10160_10"},--
        {albumId="tp_etc_1005",saveIndex=157,langId="tp_m_10160_04",dataTimeJp=133e3,dataTimeEn=122e3,important=0,special=0,fileName="tp_m_10160_04"},--
        {albumId="tp_etc_0340",saveIndex=143,langId="tp_m_10156_01",dataTimeJp=178e3,dataTimeEn=171e3,important=1,special=0,fileName="tp_m_10156_01"},--
        {albumId="tp_etc_0340",saveIndex=144,langId="tp_m_10156_02",dataTimeJp=174e3,dataTimeEn=163e3,important=1,special=0,fileName="tp_m_10156_02"},--
        {albumId="tp_etc_0340",saveIndex=145,langId="tp_m_10156_03",dataTimeJp=219e3,dataTimeEn=193e3,important=1,special=0,fileName="tp_m_10156_03"},--
        {albumId="tp_etc_0370",saveIndex=149,langId="tp_m_10240_05",dataTimeJp=141e3,dataTimeEn=173e3,important=1,special=0,fileName="tp_m_10240_05"},--
        {albumId="tp_etc_0371",saveIndex=146,langId="tp_m_10240_01",dataTimeJp=121e3,dataTimeEn=138e3,important=0,special=0,fileName="tp_m_10240_01"},--
        {albumId="tp_etc_0371",saveIndex=147,langId="tp_m_10240_02",dataTimeJp=215e3,dataTimeEn=238e3,important=0,special=0,fileName="tp_m_10240_02"},--
        {albumId="tp_etc_0372",saveIndex=148,langId="tp_m_10240_03",dataTimeJp=119e3,dataTimeEn=118e3,important=0,special=0,fileName="tp_m_10240_03"},--
        {albumId="tp_etc_1100",saveIndex=178,langId="tp_m_99060_01",dataTimeJp=138e3,dataTimeEn=119e3,important=0,special=0,fileName="tp_m_99060_01"},--
        {albumId="tp_etc_1101",saveIndex=179,langId="tp_m_99060_02",dataTimeJp=14e4,dataTimeEn=117e3,important=0,special=0,fileName="tp_m_99060_02"},--
        {albumId="tp_etc_1102",saveIndex=180,langId="tp_m_99060_03",dataTimeJp=157e3,dataTimeEn=127e3,important=0,special=0,fileName="tp_m_99060_03"},--
        {albumId="tp_etc_1103",saveIndex=181,langId="tp_m_99060_04",dataTimeJp=148e3,dataTimeEn=123e3,important=0,special=0,fileName="tp_m_99060_04"},--
        {albumId="tp_etc_1104",saveIndex=182,langId="tp_m_99060_05",dataTimeJp=284e3,dataTimeEn=233e3,important=0,special=0,fileName="tp_m_99060_05"},--
        {albumId="tp_etc_9010",saveIndex=184,langId="tp_c_00001_01",dataTimeJp=133e3,dataTimeEn=129e3,important=0,special=0,fileName="tp_c_00001_01"},--
        {albumId="tp_etc_9011",saveIndex=185,langId="tp_c_00001_02",dataTimeJp=14e4,dataTimeEn=134e3,important=0,special=0,fileName="tp_c_00001_02"},--
        {albumId="tp_etc_9012",saveIndex=186,langId="tp_c_00001_03",dataTimeJp=355e3,dataTimeEn=343e3,important=0,special=0,fileName="tp_c_00001_03"},--
        {albumId="tp_etc_9013",saveIndex=187,langId="tp_c_00001_04",dataTimeJp=161e3,dataTimeEn=157e3,important=0,special=0,fileName="tp_c_00001_04"},--
        {albumId="tp_etc_0390",saveIndex=120,langId="tp_m_10280_03",dataTimeJp=242e3,dataTimeEn=199e3,important=1,special=0,fileName="tp_m_10280_03"},--
        {albumId="tp_etc_0390",saveIndex=124,langId="tp_m_10280_10",dataTimeJp=115e3,dataTimeEn=104e3,important=1,special=0,fileName="tp_m_10280_10"},--
        {albumId="tp_etc_0390",saveIndex=119,langId="tp_m_10280_02",dataTimeJp=47e3,dataTimeEn=5e4,important=0,special=0,fileName="tp_m_10280_02"},--
        {albumId="tp_etc_0390",saveIndex=121,langId="tp_m_10280_08",dataTimeJp=101e3,dataTimeEn=97e3,important=0,special=0,fileName="tp_m_10280_08"},--
        {albumId="tp_etc_0390",saveIndex=122,langId="tp_m_10280_09",dataTimeJp=121e3,dataTimeEn=112e3,important=0,special=0,fileName="tp_m_10280_09"},--
        {albumId="tp_etc_0390",saveIndex=123,langId="tp_m_10280_17",dataTimeJp=154e3,dataTimeEn=156e3,important=0,special=0,fileName="tp_m_10280_17"},--
        {albumId="tp_etc_0390",saveIndex=126,langId="tp_m_10280_12",dataTimeJp=402e3,dataTimeEn=409e3,important=1,special=0,fileName="tp_m_10280_12"},--
        {albumId="tp_etc_0390",saveIndex=118,langId="tp_m_10150_13",dataTimeJp=475e3,dataTimeEn=46e4,important=1,special=0,fileName="tp_m_10150_13"},--
        {albumId="tp_etc_0390",saveIndex=127,langId="tp_m_10280_13",dataTimeJp=2e5,dataTimeEn=227e3,important=1,special=0,fileName="tp_m_10280_13"},--
        {albumId="tp_etc_0390",saveIndex=128,langId="tp_m_10280_14",dataTimeJp=299e3,dataTimeEn=297e3,important=1,special=0,fileName="tp_m_10280_14"},--
        {albumId="tp_etc_0390",saveIndex=129,langId="tp_m_10280_15",dataTimeJp=551e3,dataTimeEn=564e3,important=1,special=0,fileName="tp_m_10280_15"},--
        {albumId="tp_etc_0390",saveIndex=130,langId="tp_m_10280_16",dataTimeJp=427e3,dataTimeEn=409e3,important=1,special=0,fileName="tp_m_10280_16"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10020_00",dataTimeJp=27e3,dataTimeEn=26e3,important=0,special=0,fileName="tp_m_10020_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10030_00",dataTimeJp=27e3,dataTimeEn=23e3,important=0,special=0,fileName="tp_m_10030_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10033_00",dataTimeJp=47e3,dataTimeEn=41e3,important=0,special=0,fileName="tp_m_10033_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10036_00",dataTimeJp=46e3,dataTimeEn=5e4,important=0,special=0,fileName="tp_m_10036_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10040_00",dataTimeJp=83e3,dataTimeEn=72e3,important=0,special=0,fileName="tp_m_10040_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10041_00",dataTimeJp=43e3,dataTimeEn=43e3,important=0,special=0,fileName="tp_m_10041_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10043_00",dataTimeJp=39e3,dataTimeEn=39e3,important=0,special=0,fileName="tp_m_10043_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10044_00",dataTimeJp=51e3,dataTimeEn=48e3,important=0,special=0,fileName="tp_m_10044_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10045_00",dataTimeJp=73e3,dataTimeEn=61e3,important=0,special=0,fileName="tp_m_10045_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10050_00",dataTimeJp=49e3,dataTimeEn=49e3,important=0,special=0,fileName="tp_m_10050_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10052_00",dataTimeJp=38e3,dataTimeEn=31e3,important=0,special=0,fileName="tp_m_10052_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10054_00",dataTimeJp=29e3,dataTimeEn=26e3,important=0,special=0,fileName="tp_m_10054_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10070_00",dataTimeJp=32e3,dataTimeEn=23e3,important=0,special=0,fileName="tp_m_10070_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10080_00",dataTimeJp=48e3,dataTimeEn=46e3,important=0,special=0,fileName="tp_m_10080_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10081_00",dataTimeJp=4e4,dataTimeEn=4e4,important=0,special=0,fileName="tp_m_10081_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10082_00",dataTimeJp=69e3,dataTimeEn=63e3,important=0,special=0,fileName="tp_m_10082_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10085_00",dataTimeJp=23e3,dataTimeEn=23e3,important=0,special=0,fileName="tp_m_10085_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10086_00",dataTimeJp=52e3,dataTimeEn=49e3,important=0,special=0,fileName="tp_m_10086_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10090_00",dataTimeJp=85e3,dataTimeEn=66e3,important=0,special=0,fileName="tp_m_10090_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10091_00",dataTimeJp=47e3,dataTimeEn=49e3,important=0,special=0,fileName="tp_m_10091_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10093_00",dataTimeJp=77e3,dataTimeEn=74e3,important=0,special=0,fileName="tp_m_10093_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10100_00",dataTimeJp=31e3,dataTimeEn=28e3,important=0,special=0,fileName="tp_m_10100_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10110_00",dataTimeJp=86e3,dataTimeEn=66e3,important=0,special=0,fileName="tp_m_10110_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10115_00",dataTimeJp=36e3,dataTimeEn=32e3,important=0,special=0,fileName="tp_m_10115_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10115_0a",dataTimeJp=36e3,dataTimeEn=31e3,important=0,special=0,fileName="tp_m_10115_0a"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10120_00",dataTimeJp=69e3,dataTimeEn=58e3,important=0,special=0,fileName="tp_m_10120_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10121_00",dataTimeJp=7e4,dataTimeEn=66e3,important=0,special=0,fileName="tp_m_10121_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10130_00",dataTimeJp=65e3,dataTimeEn=53e3,important=0,special=0,fileName="tp_m_10130_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10140_00",dataTimeJp=23e3,dataTimeEn=17e3,important=0,special=0,fileName="tp_m_10140_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10150_00",dataTimeJp=63e3,dataTimeEn=57e3,important=0,special=0,fileName="tp_m_10150_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10151_00",dataTimeJp=14e3,dataTimeEn=16e3,important=0,special=0,fileName="tp_m_10151_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10156_00",dataTimeJp=98e3,dataTimeEn=84e3,important=0,special=0,fileName="tp_m_10156_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10171_00",dataTimeJp=68e3,dataTimeEn=56e3,important=0,special=0,fileName="tp_m_10171_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10195_00",dataTimeJp=57e3,dataTimeEn=45e3,important=0,special=0,fileName="tp_m_10195_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10200_00",dataTimeJp=67e3,dataTimeEn=64e3,important=0,special=0,fileName="tp_m_10200_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10211_00",dataTimeJp=64e3,dataTimeEn=56e3,important=0,special=0,fileName="tp_m_10211_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10240_00",dataTimeJp=48e3,dataTimeEn=48e3,important=0,special=0,fileName="tp_m_10240_00"},--
        {albumId="tp_mission_01",saveIndex=-1,langId="tp_m_10260_00",dataTimeJp=38e3,dataTimeEn=31e3,important=0,special=0,fileName="tp_m_10260_00"},--
        {albumId="tp_bgm_10",saveIndex=0,langId="tp_bgm_10_01",dataTimeJp=163e3,dataTimeEn=163e3,important=0,special=0,fileName="tp_bgm_10_01"},--Scouting Barren Lands
        {albumId="tp_bgm_10",saveIndex=1,langId="tp_bgm_10_02",dataTimeJp=15e4,dataTimeEn=15e4,important=0,special=0,fileName="tp_bgm_10_02"},--Journey to Point C-5
        {albumId="tp_bgm_10",saveIndex=2,langId="tp_bgm_10_03",dataTimeJp=179e3,dataTimeEn=179e3,important=0,special=0,fileName="tp_bgm_10_03"},--Sands
        {albumId="tp_bgm_10",saveIndex=3,langId="tp_bgm_10_04",dataTimeJp=189e3,dataTimeEn=189e3,important=0,special=0,fileName="tp_bgm_10_04"},--Dreamt of an Eclipse
        {albumId="tp_bgm_10",saveIndex=202,langId="tp_bgm_10_05",dataTimeJp=142e3,dataTimeEn=142e3,important=0,special=0,fileName="tp_bgm_10_05"},--Afghanistan's a Big Place
        {albumId="tp_bgm_10",saveIndex=203,langId="tp_bgm_10_06",dataTimeJp=185e3,dataTimeEn=185e3,important=0,special=0,fileName="tp_bgm_10_06"},--MGO Trailer Music
        {albumId="tp_bgm_10",saveIndex=204,langId="tp_bgm_10_07",dataTimeJp=87e3,dataTimeEn=87e3,important=0,special=0,fileName="tp_bgm_10_07"},--Richard Wagner: &quot;Ride of the Valkyries&quot; from The Valkyrie -ACT III- (excerpt)
        {albumId="tp_bgm_10",saveIndex=4,langId="tp_bgm_11_01",dataTimeJp=22e4,dataTimeEn=22e4,important=0,special=0,fileName="tp_bgm_11_01"},--Heavens Divide
        {albumId="tp_bgm_10",saveIndex=5,langId="tp_bgm_11_02",dataTimeJp=14e4,dataTimeEn=14e4,important=0,special=3,fileName="tp_bgm_11_02"},--Koi no Yokushiryoku (Love Deterrence)
        {albumId="tp_bgm_11",saveIndex=6,langId="tp_bgm_11_03",dataTimeJp=294e3,dataTimeEn=294e3,important=0,special=0,fileName="tp_bgm_11_03"},--Gloria
        {albumId="tp_bgm_11",saveIndex=7,langId="tp_bgm_11_04",dataTimeJp=206e3,dataTimeEn=206e3,important=0,special=0,fileName="tp_bgm_11_04"},--Kids in America
        {albumId="tp_bgm_11",saveIndex=8,langId="tp_bgm_11_05",dataTimeJp=287e3,dataTimeEn=287e3,important=0,special=0,fileName="tp_bgm_11_05"},--Rebel Yell - 1999 Digital Remaster
        {albumId="tp_bgm_11",saveIndex=9,langId="tp_bgm_11_06",dataTimeJp=309e3,dataTimeEn=309e3,important=0,special=0,fileName="tp_bgm_11_06"},--The Final Countdown
        {albumId="tp_bgm_10",saveIndex=10,langId="tp_bgm_11_07",dataTimeJp=19e4,dataTimeEn=19e4,important=0,special=0,fileName="tp_bgm_11_07"},--Nitrogen
        {albumId="tp_bgm_11",saveIndex=11,langId="tp_bgm_11_08",dataTimeJp=229e3,dataTimeEn=229e3,important=0,special=0,fileName="tp_bgm_11_08"},--Take On Me
        {albumId="tp_bgm_10",saveIndex=12,langId="tp_bgm_11_09",dataTimeJp=265e3,dataTimeEn=265e3,important=0,special=0,fileName="tp_bgm_11_09"},--Ride A White Horse
        {albumId="tp_bgm_11",saveIndex=13,langId="tp_bgm_11_10",dataTimeJp=273e3,dataTimeEn=273e3,important=0,special=0,fileName="tp_bgm_11_10"},--Maneater
        {albumId="tp_bgm_10",saveIndex=14,langId="tp_bgm_11_11",dataTimeJp=238e3,dataTimeEn=238e3,important=0,special=0,fileName="tp_bgm_11_11"},--A Phantom Pain
        {albumId="tp_bgm_11",saveIndex=15,langId="tp_bgm_11_12",dataTimeJp=289e3,dataTimeEn=289e3,important=0,special=0,fileName="tp_bgm_11_12"},--Only Time Will Tell
        {albumId="tp_bgm_10",saveIndex=16,langId="tp_bgm_11_13",dataTimeJp=222e3,dataTimeEn=222e3,important=0,special=0,fileName="tp_bgm_11_13"},--Behind the Drapery
        {albumId="tp_bgm_11",saveIndex=17,langId="tp_bgm_11_14",dataTimeJp=206e3,dataTimeEn=206e3,important=0,special=0,fileName="tp_bgm_11_14"},--Love Will Tear Us Apart
        {albumId="tp_bgm_10",saveIndex=18,langId="tp_bgm_11_15",dataTimeJp=17e4,dataTimeEn=17e4,important=0,special=0,fileName="tp_bgm_11_15"},--All the Sun Touches
        {albumId="tp_bgm_11",saveIndex=19,langId="tp_bgm_11_16",dataTimeJp=394e3,dataTimeEn=394e3,important=0,special=0,fileName="tp_bgm_11_16"},--True
        {albumId="tp_bgm_10",saveIndex=20,langId="tp_bgm_11_17",dataTimeJp=294e3,dataTimeEn=294e3,important=0,special=0,fileName="tp_bgm_11_17"},--Take The D.W.
        {albumId="tp_bgm_11",saveIndex=21,langId="tp_bgm_11_18",dataTimeJp=216e3,dataTimeEn=216e3,important=0,special=0,fileName="tp_bgm_11_18"},--Friday I'm In Love
        {albumId="tp_bgm_10",saveIndex=22,langId="tp_bgm_11_19",dataTimeJp=286e3,dataTimeEn=286e3,important=0,special=0,fileName="tp_bgm_11_19"},--Midnight Mirage
        {albumId="tp_bgm_11",saveIndex=23,langId="tp_bgm_11_20",dataTimeJp=246e3,dataTimeEn=246e3,important=0,special=0,fileName="tp_bgm_11_20"},--Dancing With Tears In My Eyes
        {albumId="tp_bgm_10",saveIndex=24,langId="tp_bgm_11_21",dataTimeJp=283e3,dataTimeEn=283e3,important=0,special=0,fileName="tp_bgm_11_21"},--The Tangerine
        {albumId="tp_bgm_10",saveIndex=25,langId="tp_bgm_11_22",dataTimeJp=292e3,dataTimeEn=292e3,important=0,special=0,fileName="tp_bgm_11_22"},--Planet Scape
        {albumId="tp_bgm_10",saveIndex=26,langId="tp_bgm_11_23",dataTimeJp=32e4,dataTimeEn=32e4,important=0,special=0,fileName="tp_bgm_11_23"},--How 'bout them zombies ey?
        {albumId="tp_bgm_10",saveIndex=27,langId="tp_bgm_11_24",dataTimeJp=178e3,dataTimeEn=178e3,important=0,special=0,fileName="tp_bgm_11_24"},--Snake Eater
        {albumId="tp_bgm_10",saveIndex=28,langId="tp_bgm_11_25",dataTimeJp=11e4,dataTimeEn=11e4,important=0,special=0,fileName="tp_bgm_11_25"},--204863
        {albumId="tp_bgm_11",saveIndex=29,langId="tp_bgm_11_26",dataTimeJp=197e3,dataTimeEn=197e3,important=0,special=0,fileName="tp_bgm_11_26"},--You Spin Me Round (Like a Record)
        {albumId="tp_bgm_11",saveIndex=30,langId="tp_bgm_11_27",dataTimeJp=289e3,dataTimeEn=289e3,important=0,special=0,fileName="tp_bgm_11_27"},--Quiet Life
        {albumId="tp_bgm_11",saveIndex=31,langId="tp_bgm_11_28",dataTimeJp=221e3,dataTimeEn=221e3,important=0,special=0,fileName="tp_bgm_11_28"},--She Blinded Me With Science
        {albumId="tp_bgm_10",saveIndex=32,langId="tp_bgm_11_29",dataTimeJp=105e3,dataTimeEn=105e3,important=0,special=0,fileName="tp_bgm_11_29"},--Dormant Stream
        {albumId="tp_bgm_11",saveIndex=33,langId="tp_bgm_11_30",dataTimeJp=226e3,dataTimeEn=226e3,important=0,special=0,fileName="tp_bgm_11_30"},--Too Shy
        {albumId="tp_bgm_10",saveIndex=200,langId="tp_bgm_11_31",dataTimeJp=116e3,dataTimeEn=116e3,important=0,special=3,fileName="tp_bgm_11_31"},--British Sovereign Base Area - Dhekelia
        {albumId="tp_bgm_11",saveIndex=205,langId="tp_bgm_11_32",dataTimeJp=341e3,dataTimeEn=341e3,important=0,special=0,fileName="tp_bgm_11_32"},--Cyprus, a Nation Divided
        {albumId="tp_bgm_10",saveIndex=206,langId="tp_bgm_11_33",dataTimeJp=294e3,dataTimeEn=294e3,important=0,special=0,fileName="tp_bgm_11_33"},--World Affairs Over the 9 Years
        {albumId="tp_bgm_10",saveIndex=207,langId="tp_bgm_11_34",dataTimeJp=164e3,dataTimeEn=164e3,important=0,special=0,fileName="tp_bgm_11_34"},--SALT II
        {albumId="tp_sp_01_01",saveIndex=188,langId="tp_sp_01_01",dataTimeJp=13e3,dataTimeEn=13e3,important=0,special=1,fileName="tp_sp_01_01"},--Afghan Lullaby
        {albumId="tp_sp_01_02",saveIndex=189,langId="tp_sp_01_02",dataTimeJp=13e3,dataTimeEn=13e3,important=0,special=2,fileName="tp_sp_01_02"},--African Lullaby
        {albumId="tp_sp_01_03",saveIndex=190,langId="tp_sp_01_03",dataTimeJp=9e3,dataTimeEn=5e3,important=0,special=3,fileName="tp_sp_01_03"},--Love Deterrence
        {albumId="tp_sp_01_04",saveIndex=191,langId="tp_sp_01_04",dataTimeJp=14e3,dataTimeEn=14e3,important=0,special=4,fileName="tp_sp_01_04"},--Quiet's Theme
        {albumId="tp_sp_01_05",saveIndex=192,langId="tp_sp_01_05",dataTimeJp=3e3,dataTimeEn=3e3,important=0,special=5,fileName="tp_sp_01_05"},--&quot;Enemy Eliminated&quot;
        {albumId="tp_sp_01_06",saveIndex=193,langId="tp_sp_01_06",dataTimeJp=4e3,dataTimeEn=4e3,important=0,special=6,fileName="tp_sp_01_06"},--&quot;Enemy Eliminated&quot;
        {albumId="tp_sp_01_07",saveIndex=194,langId="tp_sp_01_07",dataTimeJp=18e3,dataTimeEn=18e3,important=0,special=7,fileName="tp_sp_01_07"},--Recorded in the Toilet
        {albumId="tp_sp_01_08",saveIndex=195,langId="tp_sp_01_08",dataTimeJp=13e3,dataTimeEn=13e3,important=0,special=8,fileName="tp_sp_01_08"},--Bird Calls
        {albumId="tp_sp_01_09",saveIndex=196,langId="tp_sp_01_09",dataTimeJp=5e3,dataTimeEn=5e3,important=0,special=9,fileName="tp_sp_01_09"},--Goat Bleats
        {albumId="tp_sp_01_10",saveIndex=197,langId="tp_sp_01_10",dataTimeJp=6e3,dataTimeEn=6e3,important=0,special=10,fileName="tp_sp_01_10"},--Horse Neighs
        {albumId="tp_sp_01_11",saveIndex=198,langId="tp_sp_01_11",dataTimeJp=12e3,dataTimeEn=12e3,important=0,special=11,fileName="tp_sp_01_11"},--Wolf Howl
        {albumId="tp_sp_01_12",saveIndex=199,langId="tp_sp_01_12",dataTimeJp=5e3,dataTimeEn=5e3,important=0,special=12,fileName="tp_sp_01_12"},--Bear Growls
      }--tracks
    }--GetTapeInfo return
  end,--GetTapeInfo
  SetStructure=function()
    InfCore.LogFlow("PreinstallTape.SetStructure:")--tex DEBUG
    TppMusicPlayer.SetStructure{albumNum=15,trackNum=18,downloadDirectory="/Assets/tpp/sound/scripts/tape"}
  end,
  SetMusicInfo=function()
    InfCore.LogFlow("PreinstallTape.SetMusicInfo:")--tex DEBUG
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_10",trackNum=4,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_10_01",dataTimeJp=163e3,dataTimeEn=163e3,albumId="tp_bgm_10"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_bgm_10_02",dataTimeJp=15e4,dataTimeEn=15e4,albumId="tp_bgm_10"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_bgm_10_03",dataTimeJp=179e3,dataTimeEn=179e3,albumId="tp_bgm_10"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_bgm_10_04",dataTimeJp=189e3,dataTimeEn=189e3,albumId="tp_bgm_10"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10020",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10020",dataTimeJp=25e3,dataTimeEn=25e3,albumId="tp_m_10020"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10030",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10030",dataTimeJp=22e3,dataTimeEn=22e3,albumId="tp_m_10030"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10036",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10036",dataTimeJp=46e3,dataTimeEn=46e3,albumId="tp_m_10036"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10043",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10043",dataTimeJp=37e3,dataTimeEn=37e3,albumId="tp_m_10043"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10033",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10033",dataTimeJp=33e3,dataTimeEn=33e3,albumId="tp_m_10033"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10044",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10044",dataTimeJp=47e3,dataTimeEn=47e3,albumId="tp_m_10044"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10052",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10052",dataTimeJp=3e4,dataTimeEn=3e4,albumId="tp_m_10052"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10081",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10081",dataTimeJp=31e3,dataTimeEn=31e3,albumId="tp_m_10081"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10086",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10086",dataTimeJp=49e3,dataTimeEn=49e3,albumId="tp_m_10086"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10091",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10091",dataTimeJp=51e3,dataTimeEn=51e3,albumId="tp_m_10091"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10100",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10100",dataTimeJp=28e3,dataTimeEn=28e3,albumId="tp_m_10100"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10115",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10115",dataTimeJp=32e3,dataTimeEn=32e3,albumId="tp_m_10115"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10195",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10195",dataTimeJp=45e3,dataTimeEn=45e3,albumId="tp_m_10195"}
    TppMusicPlayer.SetAlbum{albumId="tp_m_10040",trackNum=1,type="PREINSTALL_BRIEFING"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_m_10040",dataTimeJp=7e4,dataTimeEn=7e4,albumId="tp_m_10040"}
  end,--SetMusicInfo
  SetStructureGz=function()
    InfCore.LogFlow("PreinstallTape.SetStructureGz:")--tex DEBUG
    TppMusicPlayer.SetStructure{albumNum=19,trackNum=62}
  end,
  SetMusicInfoGz=function()
    InfCore.LogFlow("PreinstallTape.SetMusicInfoGz:")--tex DEBUG
    TppMusicPlayer.SetAlbum{albumId="tp_chico_01",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_01",dataTimeJp=231e3,dataTimeEn=231e3,albumId="tp_chico_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_02",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_02",dataTimeJp=149e3,dataTimeEn=149e3,albumId="tp_chico_02"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_03",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_03",dataTimeJp=98e3,dataTimeEn=98e3,albumId="tp_chico_03"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_04",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_04",dataTimeJp=607e3,dataTimeEn=599e3,albumId="tp_chico_04"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_05",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_05",dataTimeJp=231e3,dataTimeEn=22e4,albumId="tp_chico_05"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_06",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_06",dataTimeJp=281e3,dataTimeEn=273e3,albumId="tp_chico_06"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_07",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_07",dataTimeJp=396e3,dataTimeEn=369e3,albumId="tp_chico_07"}
    TppMusicPlayer.SetAlbum{albumId="tp_chico_08",trackNum=7,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_chico_00_01",dataTimeJp=231e3,dataTimeEn=231e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_chico_00_02",dataTimeJp=149e3,dataTimeEn=149e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_chico_00_03",dataTimeJp=98e3,dataTimeEn=98e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_chico_00_04",dataTimeJp=607e3,dataTimeEn=599e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=4,fileName="tp_chico_00_05",dataTimeJp=231e3,dataTimeEn=22e4,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=5,fileName="tp_chico_00_06",dataTimeJp=281e3,dataTimeEn=273e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetTrack{trackIndex=6,fileName="tp_chico_00_07",dataTimeJp=396e3,dataTimeEn=369e3,albumId="tp_chico_08"}
    TppMusicPlayer.SetAlbum{albumId="tp_bf20010_01",trackNum=9,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_20010_01_01",dataTimeJp=58e3,dataTimeEn=46e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_20010_01_02",dataTimeJp=34e3,dataTimeEn=28e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_20010_01_03",dataTimeJp=108e3,dataTimeEn=88e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_20010_01_04",dataTimeJp=135e3,dataTimeEn=118e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=4,fileName="tp_20010_01_05",dataTimeJp=94e3,dataTimeEn=78e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=5,fileName="tp_20010_01_06",dataTimeJp=139e3,dataTimeEn=119e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=6,fileName="tp_20010_01_07",dataTimeJp=72e3,dataTimeEn=61e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=7,fileName="tp_20010_01_08",dataTimeJp=62e3,dataTimeEn=54e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetTrack{trackIndex=8,fileName="tp_20010_01_09",dataTimeJp=117e3,dataTimeEn=96e3,albumId="tp_bf20010_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_pw_01",trackNum=12,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_pw_01_01",dataTimeJp=32e3,dataTimeEn=2e4,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_pw_01_02",dataTimeJp=79e3,dataTimeEn=63e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_pw_01_03",dataTimeJp=44e3,dataTimeEn=41e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_pw_01_04",dataTimeJp=34e3,dataTimeEn=34e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=4,fileName="tp_pw_01_05",dataTimeJp=5e4,dataTimeEn=42e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=5,fileName="tp_pw_01_06",dataTimeJp=33e3,dataTimeEn=37e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=6,fileName="tp_pw_01_07",dataTimeJp=29e3,dataTimeEn=29e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=7,fileName="tp_pw_01_08",dataTimeJp=37e3,dataTimeEn=33e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=8,fileName="tp_pw_01_09",dataTimeJp=29e3,dataTimeEn=33e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=9,fileName="tp_pw_01_10",dataTimeJp=76e3,dataTimeEn=68e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=10,fileName="tp_pw_01_11",dataTimeJp=29e3,dataTimeEn=24e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetTrack{trackIndex=11,fileName="tp_pw_01_12",dataTimeJp=48e3,dataTimeEn=39e3,albumId="tp_pw_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_it20030_01",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_it20030_01_01",dataTimeJp=483e3,dataTimeEn=447e3,albumId="tp_it20030_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_it20030_02",trackNum=1,type="PREINSTALL_TAPE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_it20030_02_01",dataTimeJp=5e3,dataTimeEn=5e3,albumId="tp_it20030_02"}
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_01",trackNum=1,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_01_01",dataTimeJp=317e3,dataTimeEn=317e3,albumId="tp_bgm_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_02",trackNum=4,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_02_01",dataTimeJp=22e4,dataTimeEn=22e4,albumId="tp_bgm_02"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_bgm_02_02",dataTimeJp=14e4,dataTimeEn=14e4,albumId="tp_bgm_02"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_bgm_02_03",dataTimeJp=124e3,dataTimeEn=124e3,albumId="tp_bgm_02"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_bgm_02_04",dataTimeJp=87e3,dataTimeEn=87e3,albumId="tp_bgm_02"}
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_03",trackNum=1,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_03_01",dataTimeJp=188e3,dataTimeEn=188e3,albumId="tp_bgm_03"}
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_04",trackNum=2,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_04_01",dataTimeJp=114e3,dataTimeEn=114e3,albumId="tp_bgm_04"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_bgm_04_02",dataTimeJp=202e3,dataTimeEn=202e3,albumId="tp_bgm_04"}
    TppMusicPlayer.SetAlbum{albumId="tp_bgm_05",trackNum=2,type="PREINSTALL_MUSIC"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_bgm_05_01",dataTimeJp=163e3,dataTimeEn=163e3,albumId="tp_bgm_05"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_bgm_05_02",dataTimeJp=119e3,dataTimeEn=119e3,albumId="tp_bgm_05"}
    TppMusicPlayer.SetAlbum{albumId="tp_archCD_01",trackNum=5,type="PREINSTALL_ARCHIVE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_arch_cd_01_01",dataTimeJp=321e3,dataTimeEn=0,albumId="tp_archCD_01"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_arch_cd_01_02",dataTimeJp=534e3,dataTimeEn=0,albumId="tp_archCD_01"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_arch_cd_01_03",dataTimeJp=428e3,dataTimeEn=0,albumId="tp_archCD_01"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_arch_cd_01_04",dataTimeJp=506e3,dataTimeEn=0,albumId="tp_archCD_01"}
    TppMusicPlayer.SetTrack{trackIndex=4,fileName="tp_arch_cd_01_05",dataTimeJp=362e3,dataTimeEn=0,albumId="tp_archCD_01"}
    TppMusicPlayer.SetAlbum{albumId="tp_archDiary_01",trackNum=10,type="PREINSTALL_ARCHIVE"}
    TppMusicPlayer.SetTrack{trackIndex=0,fileName="tp_arch_diary_01_01",dataTimeJp=132e3,dataTimeEn=111e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=1,fileName="tp_arch_diary_01_02",dataTimeJp=166e3,dataTimeEn=15e4,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=2,fileName="tp_arch_diary_01_03",dataTimeJp=262e3,dataTimeEn=218e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=3,fileName="tp_arch_diary_01_04",dataTimeJp=243e3,dataTimeEn=209e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=4,fileName="tp_arch_diary_01_05",dataTimeJp=245e3,dataTimeEn=231e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=5,fileName="tp_arch_diary_01_06",dataTimeJp=273e3,dataTimeEn=216e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=6,fileName="tp_arch_diary_01_07",dataTimeJp=217e3,dataTimeEn=172e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=7,fileName="tp_arch_diary_01_08",dataTimeJp=259e3,dataTimeEn=205e3,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=8,fileName="tp_arch_diary_01_09",dataTimeJp=177e3,dataTimeEn=13e4,albumId="tp_archDiary_01"}
    TppMusicPlayer.SetTrack{trackIndex=9,fileName="tp_arch_diary_01_10",dataTimeJp=319e3,dataTimeEn=196e3,albumId="tp_archDiary_01"}
  end--SetMusicInfoGz
}--PreinstallTape

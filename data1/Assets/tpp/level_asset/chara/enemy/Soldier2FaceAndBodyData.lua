-- DOBUILD: 1
-- Soldier2FaceAndBodyData.lua
local this={}
--face meshes
this.faceFova={
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v000_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v000_eye0.fpk"},--0,--males>
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v001_eye0.fpk"},--1,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v002_eye0.fpk"},--2,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v003_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v003_eye0.fpk"},--3,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v004_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v004_eye0.fpk"},--4,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v005_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v005_eye1.fpk"},--5,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v006_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v006_eye1.fpk"},--6,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v007_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v007_eye0.fpk"},--7,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v008_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v008_eye0.fpk"},--8,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v009_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v009_eye1.fpk"},--9,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v010_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v010_eye0.fpk"},--10,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v011_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v011_eye0.fpk"},--11,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v012_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v012_eye1.fpk"},--12,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v013_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v013_eye0.fpk"},--13,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v014_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v014_eye1.fpk"},--14,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v015_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v015_eye1.fpk"},--15,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v016_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v016_eye1.fpk"},--16,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v017_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v017_eye1.fpk"},--17,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h0_v018_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v018_eye0.fpk"},--18,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h1_v000_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h1_v000_eye0.fpk"},--19,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h1_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h1_v001_eye0.fpk"},--20,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h1_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h1_v002_eye0.fpk"},--21,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h1_v003_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h1_v003_eye0.fpk"},--22,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h1_v004_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h1_v004_eye0.fpk"},--23,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h2_v000_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h2_v000_eye0.fpk"},--24,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h2_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h2_v001_eye0.fpk"},--25,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_m0_h2_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h2_v002_eye0.fpk"},--26,--<
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_svs0_head_z_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_svs0_head_z_eye0.fpk"},--27,--balaclava
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_pfs0_head_z_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_pfs0_head_z_eye0.fpk"},--28,--balaclava
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds5_head_z_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds5_head_z_eye0.fpk"},--29,--dd headgear>
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds6_head_z_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds6_head_z_eye0.fpk"},--30
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds3_eqhd1_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds3_eqhd1_eye0.fpk"},--31,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds8_eqhd1_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds8_eqhd1_eye0.fpk"},--32,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds3_eqhd4_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds3_eqhd4_eye0.fpk"},--33,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds3_eqhd5_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds3_eqhd5_eye0.fpk"},--34,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds8_eqhd2_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds8_eqhd2_eye0.fpk"},--35,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds8_eqhd3_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds8_eqhd3_eye0.fpk"},--36,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds3_eqhd6_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds3_eqhd6_eye0.fpk"},--37,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds3_eqhd7_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds3_eqhd7_eye0.fpk"},--38,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds8_eqhd6_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds8_eqhd6_eye0.fpk"},--39,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_dds8_eqhd7_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_dds8_eqhd7_eye0.fpk"},--40,--<
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v000_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v000_eye1.fpk"},--41,--+glasses
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v001_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v001_eye1.fpk"},--42,--includes hair>
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v002_eye0.fpk"},--43,--<
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v003_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v003_eye1.fpk"},--44,--kojima, hair, glasses
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v004_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v004_eye0.fpk"},--45,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v005_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v005_eye0.fpk"},--46,--
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v006_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v006_eye0.fpk"},--47,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_unq_v007_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_unq_v007_eye0.fpk"},--48,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h0_v000_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h0_v000_eye0.fpk"},--49,--female>
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h0_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h0_v001_eye0.fpk"},--50,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h0_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h0_v002_eye0.fpk"},--51,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h0_v003_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h0_v003_eye0.fpk"},--52,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h1_v000_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h1_v000_eye0.fpk"},--53,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h1_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h1_v001_eye0.fpk"},--54,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h1_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h1_v002_eye0.fpk"},--55,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h2_v000_eye1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h2_v000_eye1.fpk"},--56,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h2_v001_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h2_v001_eye0.fpk"},--57,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face/cm_f0_h2_v002_eye0.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_f0_h2_v002_eye0.fpk"},--58,--<
}
--face textures
this.faceDecoFova={
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w000_m.fpk"},--0,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w001_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w001_m.fpk"},--1,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w002_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w002_m.fpk"},--2,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w003_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w003_m.fpk"},--3,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w004_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w004_m.fpk"},--4,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w005_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w005_m.fpk"},--5,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w006_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w006_m.fpk"},--6,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w007_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w007_m.fpk"},--7,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w008_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w008_m.fpk"},--8,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w009_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w009_m.fpk"},--9,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w010_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w010_m.fpk"},--10,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w011_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w011_m.fpk"},--11,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w012_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w012_m.fpk"},--12,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w013_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w013_m.fpk"},--13,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w014_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w014_m.fpk"},--14,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w015_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w015_m.fpk"},--15,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w016_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w016_m.fpk"},--16,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w017_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w017_m.fpk"},--17,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w018_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w018_m.fpk"},--18,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w019_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w019_m.fpk"},--19,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b000_m.fpk"},--20,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b001_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b001_m.fpk"},--21,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b002_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b002_m.fpk"},--22,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b003_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b003_m.fpk"},--23,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b004_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b004_m.fpk"},--24,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b005_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b005_m.fpk"},--25,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b006_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b006_m.fpk"},--26,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b007_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b007_m.fpk"},--27,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b008_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b008_m.fpk"},--28,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b009_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b009_m.fpk"},--29,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b010_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b010_m.fpk"},--30,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y000_m.fpk"},--31,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y001_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y001_m.fpk"},--32,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y002_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y002_m.fpk"},--33,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y003_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y003_m.fpk"},--34,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w000_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w000_f.fpk"},--35,--caucasian,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w001_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w001_f.fpk"},--36,--caucasian,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w002_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w002_f.fpk"},--37,--caucasian,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_w003_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_w003_f.fpk"},--38,--african,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b000_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b000_f.fpk"},--39,--african,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b001_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b001_f.fpk"},--40,--african,black hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_b002_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_b002_f.fpk"},--41,--african,black hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y000_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y000_f.fpk"},--42,--asian,black hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y001_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y001_f.fpk"},--43,--asian,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/cm_y002_f.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/cm_y002_f.fpk"},--44,--asian,brown hair
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_w000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_w000_m.fpk"},--45,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_w001_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_w001_m.fpk"},--46,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_w002_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_w002_m.fpk"},--47,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_w003_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_w003_m.fpk"},--48,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_w004_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_w004_m.fpk"},--49,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_b000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_b000_m.fpk"},--50,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_y000_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_y000_m.fpk"},--51,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_y001_m.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_y001_m.fpk"},--52,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_m000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_m000.fpk"},--53,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_m001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_m001.fpk"},--54,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_m002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_m002.fpk"},--55,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_m003.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_m003.fpk"},--56,
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_f000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_f000.fpk"},--57,--caucasian,brown?blond?,tatoo black fox hound
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_f001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_f001.fpk"},--58,--caucasian,red hair,tatoo white and black ddog emblem
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_f002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_f002.fpk"},--59,--caucasian,brown hair,tatoo black fox (fox logo fox)
  {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/sp_face_f003.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/sp_face_f003.fpk"},--60,--caucasian,white hair,tatoo white skull
}
--hair meshes
this.hairFova={
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c000.fpk"},--0,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c001.fpk"},--1,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c002.fpk"},--2,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c003.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c003.fpk"},--3,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c004.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c004.fpk"},--4,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c005.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c005.fpk"},--5,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/sp_hair_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/sp_hair_c000.fpk"},--6,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c100.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c100.fpk"},--7,female,bob
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c101.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c101.fpk"},--8,female,very short/pixie
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c102.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c102.fpk"},--9,female,short crop
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c103.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c103.fpk"},--10,female,ponytale bangs
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c104.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c104.fpk"},--11,female,ponytale parted
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c105.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c105.fpk"},--12,female,bun
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c106.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c106.fpk"},--13,female,afro textured very short
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair/cm_hair_c107.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/cm_hair_c107.fpk"},--14,appears to be duplicate of 13? not referenced anywhere i can see
}
--hair textures
this.hairDecoFova={
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c000.fpk"},--0,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c001.fpk"},--1,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c002.fpk"},--2,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c003.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c000_c003.fpk"},--3,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c001_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c001_c000.fpk"},--4,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c001_c001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c001_c001.fpk"},--5,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c002_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c002_c000.fpk"},--6,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c003_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c003_c000.fpk"},--7,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c004_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c004_c000.fpk"},--8,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c005_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c005_c000.fpk"},--9,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c100_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c100_c000.fpk"},--10
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c101_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c101_c000.fpk"},--11,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c102_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c102_c000.fpk"},--12,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c103_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c103_c000.fpk"},--13,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c104_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c104_c000.fpk"},--14,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c105_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c105_c000.fpk"},--15,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c106_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c106_c000.fpk"},--16,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/cm_hair_c107_c000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/cm_hair_c107_c000.fpk"},--17
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_m000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_m000.fpk"},--18,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_m001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_m001.fpk"},--19,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_m002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_m002.fpk"},--20,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_f000.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_f000.fpk"},--21,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_f001.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_f001.fpk"},--22,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_f002.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_f002.fpk"},--23,
  {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/sp_hair_f003.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/sp_hair_f003.fpk"},--24,
}
--NMC: see also bodyDefinition table below and TppEnemyBodyId.lua
--{"FV2 PATH","FOVA FPK PATH"}, bodyDefinition index, bodyId, TppEnemyBodyId, Notes...
--if TppEnemyBodyId not given it's likely the same as the fv2 file name
--In a lot of cases TppEnemyBodyId aren't used and the bodyId is used directly
--and in some cases the mapping is incorrect (see note on pfs0_dds0_v00 below)
this.bodyFova={
  --SOVIET see TppEnemy.bodyIdTable
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v00_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--0,0,,
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v01_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--1,1,,
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v02_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--2,2,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v00_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--3,5,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v01_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--4,6,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v02_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--5,7,,
  {"/Assets/tpp/fova/chara/svs/svs0_snp_v00_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--6,10,,
  {"/Assets/tpp/fova/chara/svs/svs0_rdo_v00_a.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--7,11,,
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v00_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--8,20,,
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v01_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--9,21,,
  {"/Assets/tpp/fova/chara/svs/svs0_rfl_v02_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--10,22,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v00_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--11,25,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v01_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--12,26,,
  {"/Assets/tpp/fova/chara/svs/svs0_mcg_v02_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--13,27,,
  {"/Assets/tpp/fova/chara/svs/svs0_snp_v00_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--14,30,,
  {"/Assets/tpp/fova/chara/svs/svs0_rdo_v00_b.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_main0_v00.fpk"},--15,31,,
  {"/Assets/tpp/fova/chara/svs/sva0_v00_a.fv2","/Assets/tpp/pack/fova/chara/svs/sva0_main0_v00.fpk"},--16,49,,soviet armor
  --PF see TppEnemy.bodyIdTable
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--17,50,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--18,51,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--19,55,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--20,60,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--21,61,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--22,70,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--23,71,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--24,75,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--25,80,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--26,81,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v00_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--27,90,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rfl_v01_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--28,91,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_mcg_v00_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--29,95,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_snp_v00_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--30,100,,
  {"/Assets/tpp/fova/chara/pfs/pfs0_rdo_v00_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_main0_v00.fpk"},--31,101,,
  --pf armor
  {"/Assets/tpp/fova/chara/pfs/pfa0_v00_b.fv2","/Assets/tpp/pack/fova/chara/pfs/pfa0_main0_v00.fpk"},--32,107,,PF armor
  {"/Assets/tpp/fova/chara/pfs/pfa0_v00_c.fv2","/Assets/tpp/pack/fova/chara/pfs/pfa0_main0_v00.fpk"},--33,108,,PF armor
  {"/Assets/tpp/fova/chara/pfs/pfa0_v00_a.fv2","/Assets/tpp/pack/fova/chara/pfs/pfa0_main0_v00.fpk"},--34,109,,PF armor
  --prisoners
  {"/Assets/tpp/fova/chara/prs/prs2_main0_v00.fv2","/Assets/tpp/pack/fova/chara/prs/prs2_main0_v00.fpk"},--35,110,,AFGH_HOSTAGE_MALE,Q19013/commFacility_q19013,Q99070/sovietBase_q99070,Q99072/tent_q99072
  {"/Assets/tpp/fova/chara/prs/prs5_main0_v00.fv2","/Assets/tpp/pack/fova/chara/prs/prs5_main0_v00.fpk"},--36,111,,MAFR_HOSTAGE_MALE,Q19012/hill_q19012
  {"/Assets/tpp/fova/chara/prs/prs3_main0_v00.fv2","/Assets/tpp/pack/fova/chara/prs/prs3_main0_v00.fpk"},--37,112,,AFGH_HOSTAGE_FEMALE
  {"/Assets/tpp/fova/chara/prs/prs6_main0_v00.fv2","/Assets/tpp/pack/fova/chara/prs/prs6_main0_v00.fpk"},--38,113,,MAFR_HOSTAGE_FEMALE
  --children
  {"/Assets/tpp/fova/chara/chd/chd0_v00.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--39,115,,
  {"/Assets/tpp/fova/chara/chd/chd0_v01.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--40,116,,
  {"/Assets/tpp/fova/chara/chd/chd0_v02.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--41,117,,
  {"/Assets/tpp/fova/chara/chd/chd0_v03.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--42,118,,
  {"/Assets/tpp/fova/chara/chd/chd0_v04.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--43,119,,
  {"/Assets/tpp/fova/chara/chd/chd0_v05.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--44,120,,
  {"/Assets/tpp/fova/chara/chd/chd0_v06.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--45,121,,
  {"/Assets/tpp/fova/chara/chd/chd0_v07.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--46,122,,
  {"/Assets/tpp/fova/chara/chd/chd0_v08.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--47,123,,
  {"/Assets/tpp/fova/chara/chd/chd0_v09.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--48,124,,
  {"/Assets/tpp/fova/chara/chd/chd0_v10.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--49,125,,
  {"/Assets/tpp/fova/chara/chd/chd0_v11.fv2","/Assets/tpp/pack/fova/chara/chd/chd0_main0_v00.fpk"},--50,126,,
  {"/Assets/tpp/fova/chara/chd/chd1_v00.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--51,130,,
  {"/Assets/tpp/fova/chara/chd/chd1_v01.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--52,131,,
  {"/Assets/tpp/fova/chara/chd/chd1_v02.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--53,132,,
  {"/Assets/tpp/fova/chara/chd/chd1_v03.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--54,133,,
  {"/Assets/tpp/fova/chara/chd/chd1_v04.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--55,134,,
  {"/Assets/tpp/fova/chara/chd/chd1_v05.fv2","/Assets/tpp/pack/fova/chara/chd/chd1_main0_v00.fpk"},--56,135,,
  --dds
  {"/Assets/tpp/fova/chara/dds/dds0_main1_v00.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main1_v00.fpk"},--57,140,,DD_PW,10115 Retake the plat,bodyIdTable ASSAULT
  {"/Assets/tpp/fova/chara/dds/dds0_main1_v01.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main1_v00.fpk"},--58,141,,DD_PW,10115 Retake the plat,Mosquito
  {"/Assets/tpp/fova/chara/dds/dds3_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/dds3_main0_v00.fpk"},--59,142,,DD_A default/drab
  {"/Assets/tpp/fova/chara/dds/dds5_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/dds5_main0_v00.fpk"},--60,143,,DD_FOB Tiger
  {"/Assets/tpp/fova/chara/dds/dds5_main0_v01.fv2",""},--61,144,,
  {"/Assets/tpp/fova/chara/dds/dds5_main0_v02.fv2",""},--62,145,,
  --dd researcher/labcoat male
  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--63,146,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--64,147,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--65,148,,

  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--66,149,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--67,150,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v02.fv2",""},--68,151,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v03.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--69,152,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v04.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--70,153,,
  --female
  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--71,154,,
  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--72,155,,
  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--73,156,,

  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--74,157,,
  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--75,158,,
  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--76,159,,

  {"/Assets/tpp/fova/chara/dds/dds3_main0_v01.fv2",""},--77,160,,
  {"/Assets/tpp/fova/chara/dds/dds5_main0_v03.fv2",""},--78,161,,
  {"/Assets/tpp/fova/chara/dds/dds6_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/dds6_main0_v00.fpk"},--79,162,,
  {"/Assets/tpp/fova/chara/dds/dds6_main0_v01.fv2",""},--80,163,,
  {"/Assets/tpp/fova/chara/dds/dds8_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/dds8_main0_v00.fpk"},--81,164,,
  {"/Assets/tpp/fova/chara/dds/dds8_main0_v01.fv2",""},--82,165,,

  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v03.fv2",""},--83,166,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v04.fv2",""},--84,167,,

  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v05.fv2",""},--85,168,,
  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v06.fv2",""},--86,169,,

  {"/Assets/tpp/fova/chara/dds/dds3_main0_v02.fv2",""},--87,170,,
  {"/Assets/tpp/fova/chara/dds/dds8_main0_v02.fv2",""},--88,171,,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--89,172,dds4_enem0_def,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--90,173,dds4_enef0_def,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--91,174,dds5_enem0_def,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--92,175,dds5_enef0_def,
  {"/Assets/tpp/fova/chara/dds/dds5_main0_v04.fv2","/Assets/tpp/pack/fova/chara/dds/dds5_main0_v01.fpk"},--93,176,,
  {"/Assets/tpp/fova/chara/dla/dla0_plym0_v00.fv2","/Assets/tpp/pack/fova/chara/dla/dla0_plym0_v00.fpk"},--94,177,dla0_plym0_def,
  {"/Assets/tpp/fova/chara/dla/dla1_plym0_v00.fv2","/Assets/tpp/pack/fova/chara/dla/dla1_plym0_v00.fpk"},--95,178,dla1_plym0_def,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--96,179,dlb0_plym0_def,
  {"/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2","/Assets/tpp/pack/fova/chara/sna/sna4_plym0_v00.fpk"},--97,180,dlc0_plyf0_def,
  {"/Assets/tpp/fova/chara/dlc/dlc1_plyf0_v00.fv2","/Assets/tpp/pack/fova/chara/dlc/dlc1_plyf0_v00.fpk"},--98,181,dlc1_plyf0_def,
  {"/Assets/tpp/fova/chara/dld/dld0_plym0_v00.fv2","/Assets/tpp/pack/fova/chara/dld/dld0_plym0_v00.fpk"},--99,182,dld0_plym0_def,
  {"/Assets/tpp/fova/chara/dle/dle0_plyf0_v00.fv2","/Assets/tpp/pack/fova/chara/dle/dle0_plyf0_v00.fpk"},--100,183,dle0_plyf0_def,
  {"/Assets/tpp/fova/chara/dle/dle1_plyf0_v00.fv2","/Assets/tpp/pack/fova/chara/dle/dle1_plyf0_v00.fpk"},--101,184,dle1_plyf0_def,
  --wss XOF
  {"/Assets/tpp/fova/chara/wss/wss4_main0_v00.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00.fpk"},--102,190,,--10150 : Mission 30 - Skull Face, SKULL_AFGH
  {"/Assets/tpp/fova/chara/wss/wss4_main0_v01.fv2",""},--103,191,
  {"/Assets/tpp/fova/chara/wss/wss4_main0_v02.fv2",""},--104,192,
  {"/Assets/tpp/fova/chara/wss/wss0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/wss/wss0_main0_v00.fpk"},--105,195,,--prologue gas mask xof
  {"/Assets/tpp/fova/chara/wss/wss3_main0_v00.fv2","/Assets/tpp/pack/fova/chara/wss/wss3_main0_v00.fpk"},--106,196,,--unused?
  --prisoners
  {"/Assets/tpp/fova/chara/prs/prs2_main0_v01.fv2","/Assets/tpp/pack/fova/chara/prs/prs2_main0_v01.fpk"},--107,200,,afgh hostage male
  {"/Assets/tpp/fova/chara/prs/prs5_main0_v01.fv2","/Assets/tpp/pack/fova/chara/prs/prs5_main0_v01.fpk"},--108,201,,mafr hostage male
  {"/Assets/tpp/fova/chara/prs/prs3_main0_v01.fv2","/Assets/tpp/pack/fova/chara/prs/prs3_main0_v01.fpk"},--109,202,,afgh hostage female
  {"/Assets/tpp/fova/chara/prs/prs6_main0_v01.fv2","/Assets/tpp/pack/fova/chara/prs/prs6_main0_v01.fpk"},--110,203,,mafr hostage female
  --children
  {"/Assets/tpp/fova/chara/chd/chd2_v00.fv2","/Assets/tpp/pack/fova/chara/chd/chd2_main0_v00.fpk"},--111,205,,Q20913/outland_q20913
  {"/Assets/tpp/fova/chara/chd/chd2_v01.fv2","/Assets/tpp/pack/fova/chara/chd/chd2_main0_v00.fpk"},--112,206,,Q20914/lab_q20914
  {"/Assets/tpp/fova/chara/chd/chd2_v02.fv2","/Assets/tpp/pack/fova/chara/chd/chd2_main0_v00.fpk"},--113,207,,Q20910/tent_q20910
  {"/Assets/tpp/fova/chara/chd/chd2_v03.fv2","/Assets/tpp/pack/fova/chara/chd/chd2_main0_v00.fpk"},--114,208,,Q20911/fort_q20911
  {"/Assets/tpp/fova/chara/chd/chd2_v04.fv2","/Assets/tpp/pack/fova/chara/chd/chd2_main0_v00.fpk"},--115,209,,Q20912/sovietBase_q20912
  --pf/soviet uniques
  --pf unique
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v210.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v00.fpk"},--116,250,,black beret, glases, black vest, red shirt, tan pants, fingerless gloves, white hands
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v250.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v01.fpk"},--117,251,,black beret, white coyote tshirt, black pants
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v360.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v03.fpk"},--118,253,,red long sleeve shirt, body vest, black pants
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v280.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v04.fpk"},--119,254,,black suit, white shirt, red white striped tie, uses unique model
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v150.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v05.fpk"},--120,255,,green beret, brown leather top, light tan muddy pants, white hands,Q19011/outland_q19011
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v220.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v06.fpk"},--121,256,,mafr tan shorts, looks normal, maybe the shoulder rank decorations?
  --soviet unique
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v010.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v00.fpk"},--122,257,,red beret
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v080.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v01.fpk"},--123,258,,digital camo, seems like it would be in the normal soviet body selection, dont know.
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v020.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v02.fpk"},--124,259,,green beret, brown coat,Q19010/ruins_q19010
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v040.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v03.fpk"},--125,260,,urban camo radio
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v050.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v04.fpk"},--126,261,,urban camo, cap
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v060.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v05.fpk"},--127,262,,black hoodie, green vest, urban pants
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v100.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v06.fpk"},--128,263,,tan/brown hoodie, brown pants
  --pf unique
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v140.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v07.fpk"},--129,264,,cap, glases, badly clipping medal, brown leather top, light tan muddy pants, fingerless gloves, white hands,Q99071/outland_q99071
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v241.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v08.fpk"},--130,265,,brown leather top, light tan muddy pants,s10091
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v242.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v09.fpk"},--131,266,,brown leather top, light tan muddy pants, cant tell any difference?,s10091
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v450.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v10.fpk"},--132,267,,red beret, brown leather top, light tan muddy pants
  --soviet unique
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v070.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v07.fpk"},--133,268,,red beret, green vest, tan top, pants
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v071.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v08.fpk"},--134,269,,red beret, woodland camo
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v072.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v09.fpk"},--135,270,,red beret, glases, urban, so no headgear,--model in fpk
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v420.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v10.fpk"},--136,271,,dark brown hoodie
  --pf unique
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v440.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v11.fpk"},--137,272,,red beret, black leather top, black pants,10093 vip
  --soviet unique
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v009.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v11.fpk"},--138,273,,red beret, green vest, grey top, pants
  {"/Assets/tpp/fova/chara/svs/svs0_unq_v421.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_uniq0_v12.fpk"},--139,274,,wood camo,s10045
  --pf unique
  {"/Assets/tpp/fova/chara/pfs/pfs0_unq_v155.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_uniq0_v12.fpk"},--140,275,,red beret cfa light tank shortpants fingerless gloves white hands
  --lost MSF, RETAILBUG pfs and svs dds are swapped in TppEnemyBodyId
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--141,280,pfs0_dds0_v00,model in fpk,MSF_01,q80060,--identical entries, don't know why, the different body ids are used however in the lost msf quests-v-
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--142,281,pfs0_dds0_v01,MSF_02,q80020
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--143,282,pfs0_dds0_v02,
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--144,283,pfs0_dds0_v03,
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--145,284,pfs0_dds0_v04,
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--146,285,pfs0_dds0_v05,
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--147,286,pfs0_dds0_v06,MSF_07,q80010
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--148,287,pfs0_dds0_v07,
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--149,288,pfs0_dds0_v08,MSF_09,q80080
  {"/Assets/tpp/fova/chara/svs/svs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/svs/svs0_dds0_v00.fpk"},--150,289,pfs0_dds0_v09,MSF_10,q80040,--^-

  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--151,290,svs0_dds0_v00,model in fpk, --identical entries, don't know why, the different body ids are used however in the lost msf quests-v-
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--152,291,svs0_dds0_v01,
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--153,292,svs0_dds0_v02,MSF_03,q80100
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--154,293,svs0_dds0_v03,MSF_04,q80200
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--155,294,svs0_dds0_v04,MSF_05,q80600
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--156,295,svs0_dds0_v05,MSF_06,q80400
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--157,296,svs0_dds0_v06,
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--158,297,svs0_dds0_v07,MSF_08,q80700
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--159,298,svs0_dds0_v08,
  {"/Assets/tpp/fova/chara/pfs/pfs0_dds0_v00.fv2","/Assets/tpp/pack/fova/chara/pfs/pfs0_dds0_v00.fpk"},--160,299,svs0_dds0_v09,--^-
  --cyprus hospital patients
  {"/Assets/tpp/fova/chara/ptn/ptn0_v00.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--161,300,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v01.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--162,301,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v02.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--163,302,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v03.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--164,303,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v04.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--165,304,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v05.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--166,305,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v06.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--167,306,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v07.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--168,307,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v08.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--169,308,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v09.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--170,309,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v10.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--171,310,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v11.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--172,311,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v12.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--173,312,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v13.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--174,313,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v14.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--175,314,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v15.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--176,315,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v16.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--177,316,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v17.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--178,317,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v18.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--179,318,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v19.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--180,319,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v20.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--181,320,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v21.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--182,321,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v22.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--183,322,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v23.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--184,323,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v24.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--185,324,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v25.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--186,325,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v26.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--187,326,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v27.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--188,327,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v28.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--189,328,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v29.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--190,329,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v30.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--191,330,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v31.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--192,331,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v32.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--193,332,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v33.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--194,333,,
  {"/Assets/tpp/fova/chara/ptn/ptn0_v34.fv2","/Assets/tpp/pack/fova/chara/ptn/ptn0_main0_v00.fpk"},--195,334,,

  {"/Assets/tpp/fova/chara/ptn/ptn1_v00.fv2",""},--196,335,,
  {"/Assets/tpp/fova/chara/ptn/ptn2_v00.fv2",""},--197,336,,
  --cyprus hospital nurses
  {"/Assets/tpp/fova/chara/nrs/nrs0_v00.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--198,340,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v01.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--199,341,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v02.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--200,342,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v03.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--201,343,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v04.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--202,344,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v05.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--203,345,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v06.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--204,346,,
  {"/Assets/tpp/fova/chara/nrs/nrs0_v07.fv2","/Assets/tpp/pack/fova/chara/nrs/nrs0_main0_v00.fpk"},--205,347,,
  --cyprus hospital doc
  {"/Assets/tpp/fova/chara/dct/dct0_v00.fv2","/Assets/tpp/pack/fova/chara/dct/dct0_main0_v00.fpk"},--206,348,,
  {"/Assets/tpp/fova/chara/dct/dct0_v01.fv2","/Assets/tpp/pack/fova/chara/dct/dct0_main0_v00.fpk"},--207,349,,
  --Mission 20 - Voices - infected prisoners
  {"/Assets/tpp/fova/chara/plh/plh0_v00.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--208,350,,
  {"/Assets/tpp/fova/chara/plh/plh0_v01.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--209,351,,
  {"/Assets/tpp/fova/chara/plh/plh0_v02.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--210,352,,
  {"/Assets/tpp/fova/chara/plh/plh0_v03.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--211,353,,
  {"/Assets/tpp/fova/chara/plh/plh0_v04.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--212,354,,
  {"/Assets/tpp/fova/chara/plh/plh0_v05.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--213,355,,
  {"/Assets/tpp/fova/chara/plh/plh0_v06.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--214,356,,
  {"/Assets/tpp/fova/chara/plh/plh0_v07.fv2","/Assets/tpp/pack/fova/chara/plh/plh0_main0_v00.fpk"},--215,357,,
  --ocellot
  {"/Assets/tpp/fova/chara/oce/oce0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/oce/oce0_main0_v00.fpk"},--216,370,,normal
  {"/Assets/tpp/fova/chara/oce/oce0_main0_v01.fv2","/Assets/tpp/pack/fova/chara/oce/oce0_main0_v00.fpk"},--217,371,,glasses
  {"/Assets/tpp/fova/chara/oce/oce0_main0_v02.fv2","/Assets/tpp/pack/fova/chara/oce/oce0_main0_v00.fpk"},--218,372,,??
  --prisoners
  {"/Assets/tpp/fova/chara/prs/prs7_main0_v00.fv2","/Assets/tpp/pack/fova/chara/prs/prs7_main0_v00.fpk"},--219,373,,Q99080_01,dd suit, unused
  {"/Assets/tpp/fova/chara/prs/prs7_main0_v01.fv2","/Assets/tpp/pack/fova/chara/prs/prs7_main0_v01.fpk"},--220,374,,Q99080_02,dd suit tiger stripe, used for kojima
  --skullface
  {"/Assets/tpp/fova/chara/wsp/wsp_def.fv2","/Assets/tpp/pack/fova/chara/wsp/wsp0_main0_v00.fpk"},--221,375,,
  {"/Assets/tpp/fova/chara/wsp/wsp_dam.fv2","/Assets/tpp/pack/fova/chara/wsp/wsp0_main0_v00.fpk"},--222,376,,
  --huey
  {"/Assets/tpp/fova/chara/hyu/hyu0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/hyu/hyu0_main0_v00.fpk"},--223,377,,
  {"/Assets/tpp/fova/chara/hyu/hyu0_main0_v01.fv2","/Assets/tpp/pack/fova/chara/hyu/hyu0_main0_v01.fpk"},--224,378,,
  {"/Assets/tpp/fova/chara/hyu/hyu0_main0_v02.fv2","/Assets/tpp/pack/fova/chara/hyu/hyu0_main0_v02.fpk"},--225,379,,
  --ishmael
  {"/Assets/tpp/fova/chara/ish/ish0_v00.fv2","/Assets/tpp/pack/fova/chara/ish/ish0_main0_v00.fpk"},--226,380,,
  {"/Assets/tpp/fova/chara/ish/ish0_v01.fv2","/Assets/tpp/pack/fova/chara/ish/ish0_main0_v00.fpk"},--227,381,,
  --swimwear
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v00.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v00.fpk"},   --228,382,, --RETAILPATCH 1.10>
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v00.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v00.fpk"}, --229,383,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v01.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v01.fpk"},   --230,384,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v01.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v01.fpk"}, --231,385,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v02.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v02.fpk"},   --232,386,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v02.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v02.fpk"}, --233,387,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v03.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v03.fpk"},   --234,388,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v03.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v03.fpk"}, --235,389,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v04.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v04.fpk"},   --236,390,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v04.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v04.fpk"}, --237,391,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v05.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v05.fpk"},   --238,392,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v05.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v05.fpk"}, --239,393,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v06.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v06.fpk"},   --240,394,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v06.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v06.fpk"}, --241,395,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v07.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v07.fpk"},   --242,396,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v07.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v07.fpk"}, --243,397,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v08.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v08.fpk"},   --244,398,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v08.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v08.fpk"}, --245,399,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v09.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v09.fpk"},   --246,400,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v09.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v09.fpk"}, --247,401,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v10.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v10.fpk"},   --248,402,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v10.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v10.fpk"}, --240,403,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_v11.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v11.fpk"},   --250,404,,
  {"/Assets/tpp/fova/chara/dlf/dlf1_enem0_f_v11.fv2","/Assets/tpp/pack/fova/chara/dlf/dlf0_plym0_v11.fpk"}, --251,405,, --<
  
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v00.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v00.fpk"},--RETAILPATCH 1.0.11>
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v00.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v00.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v01.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v01.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v01.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v01.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v02.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v02.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v02.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v02.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v03.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v03.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v03.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v03.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v04.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v04.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v04.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v04.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v05.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v05.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v05.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v05.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v06.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v06.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v06.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v06.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v07.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v07.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v07.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v07.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v08.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v08.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v08.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v08.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v09.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v09.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v09.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v09.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v10.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v10.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v10.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v10.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_v11.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v11.fpk"},
  {"/Assets/tpp/fova/chara/dlg/dlg1_enem0_f_v11.fv2","/Assets/tpp/pack/fova/chara/dlg/dlg0_plym0_v11.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v00.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v00.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v00.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v00.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v01.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v01.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v01.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v01.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v02.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v02.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v02.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v02.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v03.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v03.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v03.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v03.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v04.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v04.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v04.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v04.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v05.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v05.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v05.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v05.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v06.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v06.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v06.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v06.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v07.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v07.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v07.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v07.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v08.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v08.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v08.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v08.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v09.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v09.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v09.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v09.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v10.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v10.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v10.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v10.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_v11.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v11.fpk"},
  {"/Assets/tpp/fova/chara/dlh/dlh1_enem0_f_v11.fv2","/Assets/tpp/pack/fova/chara/dlh/dlh0_plym0_v11.fpk"},--<
--tex> OFF CULL
--  {"/Assets/tpp/fova/chara/dds/dds0_main2_v01.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main2_v00_ih.fpk"},--252,406,,
--  {"/Assets/tpp/fova/chara/dds/dds0_main2_v02.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main2_v00_ih.fpk"},--253,407,,
--  {"/Assets/tpp/fova/chara/dds/dds0_main2_v04.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main2_v00_ih.fpk"},--254,408,,
--  {"/Assets/tpp/fova/chara/dds/dds0_main2_v05.fv2","/Assets/tpp/pack/fova/chara/dds/dds0_main2_v00_ih.fpk"},--255,409,,
--
--  {"/Assets/tpp/fova/chara/wss/wss4_main0_v00.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--256,410,,
--  {"/Assets/tpp/fova/chara/wss/wss4_main0_v01.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--257,411,,
--  {"/Assets/tpp/fova/chara/wss/wss4_main0_v01.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--258,412,,
--<
}

--tex add player comos to fova system>
local numCamos=60 --tex from 0. missing 9,15,21 (see inffova), but will add them for simplicty since they're otherwise complete/contiguous.
--tex TODO player dds6/female fatigue fovas dont seem to apply to dd6, while player dds5 to dd5 is fine.
local fovaInfo={
  dds5={"/Assets/tpp/fova/chara/sna/dds5_main0_ply_v%02d.fv2","/Assets/tpp/pack/player/fova/plfova_dds5_main0_ply_v%02d.fpk"},
  dds6={"/Assets/tpp/fova/chara/sna/dds6_main0_ply_v%02d.fv2","/Assets/tpp/pack/player/fova/plfova_dds6_main0_ply_v%02d.fpk"},
}
local camoAddStart=#this.bodyFova
for camoId=0,numCamos do
  table.insert(this.bodyFova,{string.format(fovaInfo.dds5[1],camoId),string.format(fovaInfo.dds5[2],camoId)})
end
for camoId=0,numCamos do
  table.insert(this.bodyFova,{string.format(fovaInfo.dds6[1],camoId),string.format(fovaInfo.dds6[2],camoId)})
end
--<

local no=EnemyFova.INVALID_FOVA_VALUE
this.faceDefinition={
  --see TppMissionList and MbmCommonSetting (search 'faceId=') for uses
  --tex notes (NMC) (see legend line just before data below -v-)
  --unkN = unknown
  --gender:male/female(0/1)
  --ui textures in \texture1_dat\Assets\tpp\ui\texture\StaffImage

  --unknown unk1: ranges male: 0,1,2,3,16,17,18,19,48,50, female: 32,34,35,48,50, -- dd headgears (both gender) 16
  --for males initially appears to be race (see InfEneFova .RACE) when in the range 0-3, but then what is above that?

  --unk6 range {0,1,3}, 3 seems common face, 1 unique, 0?
  --unk6->unk10 are all zeroed past face 303, maximums do show those at 303 but DOC faceFova.ods spreadsheet shows that not all values in that 0-303 range are used uniquely

  --changing faceFova and also unknown1 (other params currently untested) changes voice
  --{n,50, 1, 1,58,60,13,24, 4, 4, 1,N/A          , 3,303,303,303,3}--maximums (from values)
  --{n,50, 1, 1,58,no,no,no,no,no, 1,N/A          , 3,303,303,303,3}--actual maximums (no=EnemyFova.INVALID_FOVA_VALUE)
  --{n,       50,     1,   1,      58,          60,      13,          24,   4,   4,   1,N/A          ,   3, 303, 303, 303,    3}--maximums
  --{faceId,unk1,gender,unk2,faceFova,faceDecoFova,hairFova,hairDecoFova,unk3,unk4,unk5,uiTextureName,unk6,unk7,unk8,unk9,unk10},--notes
  {  0, 0, 0, 0, 3, 0,no,no, 0, 0, 0,"ui_face_000", 3,  4,  2,  6,3},--male>
  {  1, 0, 0, 0, 1, 0,no,no, 3, 0, 0,"ui_face_001", 3,  4,  1,  0,2},
  {  2, 0, 0, 0, 2, 0,no,no, 1, 0, 0,"ui_face_002", 3,  4,  9, 10,3},
  {  3, 0, 0, 0, 5, 0,no,no, 4, 0, 1,"ui_face_003", 3,  3,  2,  0,2},
  {  4, 0, 0, 0, 6, 0,no,no, 0, 0, 1,"ui_face_004", 3,  7,  0,  0,1},
  {  5, 0, 0, 0, 8, 0,no,no, 3, 0, 0,"ui_face_005", 3,  1,  0,  0,1},
  {  6, 0, 0, 0,14, 0,no,no, 1, 0, 1,"ui_face_006", 3,  8,  0,  0,1},
  {  7, 0, 0, 0,15, 0,no,no, 4, 0, 1,"ui_face_007", 3,  7,  2,  0,2},
  {  8, 0, 0, 0,17, 0,no,no, 0, 0, 1,"ui_face_008", 3,  3,  0,  0,1},
  {  9, 0, 0, 0,18, 0,no,no, 3, 0, 0,"ui_face_009", 3,  3,  0,  0,1},
  { 10, 1, 0, 0, 0, 1,no,no, 1, 1, 0,"ui_face_010", 3, 17,  0,  0,1},
  { 11, 1, 0, 0, 1, 1,no,no, 1, 1, 0,"ui_face_011", 3, 17, 14, 13,3},
  { 12, 1, 0, 0, 3, 1,no,no, 1, 1, 0,"ui_face_012", 3, 18, 12,  0,2},
  { 13, 1, 0, 0, 4, 1,no,no, 1, 1, 0,"ui_face_013", 3, 12, 15,  0,2},
  { 14, 1, 0, 0, 7, 1,no,no, 1, 1, 0,"ui_face_014", 3, 14, 12,  0,2},
  { 15, 1, 0, 0, 9, 1,no,no, 4, 1, 1,"ui_face_015", 3, 18,  0,  0,1},
  { 16, 1, 0, 0,11, 1,no,no, 4, 1, 0,"ui_face_016", 3, 12, 11,  0,2},
  { 17, 1, 0, 0,13, 1,no,no, 4, 1, 0,"ui_face_017", 3, 16, 13,  0,2},
  { 18, 1, 0, 0,14, 1,no,no, 4, 1, 1,"ui_face_018", 3,  0,  0,  0,0},
  { 19, 1, 0, 0,17, 1,no,no, 4, 1, 1,"ui_face_019", 3, 17,  0,  0,1},
  { 20, 0, 0, 0, 0, 2,no,no, 1, 2, 0,"ui_face_020", 3, 22, 28, 27,3},
  { 21, 0, 0, 0, 2, 2,no,no, 4, 2, 0,"ui_face_021", 3, 26, 28, 27,3},
  { 22, 0, 0, 0, 5, 2,no,no, 0, 2, 1,"ui_face_022", 3, 22, 21, 28,3},
  { 23, 0, 0, 0, 7, 2,no,no, 3, 2, 0,"ui_face_023", 3, 29, 23,  0,2},
  { 24, 0, 0, 0, 9, 2,no,no, 1, 2, 1,"ui_face_024", 3, 29, 23,  0,2},
  { 25, 0, 0, 0,11, 2,no,no, 4, 2, 0,"ui_face_025", 3, 22, 30, 21,3},
  { 26, 0, 0, 0,10, 2,no,no, 1, 2, 0,"ui_face_026", 3, 28, 22, 23,3},
  { 27, 0, 0, 0,12, 2,no,no, 0, 2, 1,"ui_face_027", 3, 27, 23, 22,3},
  { 28, 0, 0, 0,16, 2,no,no, 3, 2, 1,"ui_face_028", 3, 25,  0,  0,1},
  { 29, 0, 0, 0,18, 2,no,no, 4, 2, 0,"ui_face_029", 3, 26, 22, 28,3},
  { 30, 0, 0, 0, 2, 3,no,no, 1, 2, 0,"ui_face_030", 3, 36, 40,  0,2},
  { 31, 0, 0, 0, 3, 3,no,no, 4, 2, 0,"ui_face_031", 3, 37, 35,  0,2},
  { 32, 0, 0, 0, 4, 3,no,no, 0, 2, 0,"ui_face_032", 3, 35,  0,  0,1},
  { 33, 0, 0, 0, 6, 3,no,no, 3, 2, 1,"ui_face_033", 3, 38,  0,  0,1},
  { 34, 0, 0, 0, 8, 3,no,no, 1, 2, 0,"ui_face_034", 3, 33, 37, 32,3},
  { 35, 0, 0, 0,12, 3,no,no, 4, 2, 1,"ui_face_035", 3, 31, 40,  0,2},
  { 36, 0, 0, 0,13, 3,no,no, 0, 2, 0,"ui_face_036", 3, 35, 32,  0,2},
  { 37, 0, 0, 0,14, 3,no,no, 3, 2, 1,"ui_face_037", 3, 39,  0,  0,1},
  { 38, 0, 0, 0,15, 3,no,no, 1, 2, 1,"ui_face_038", 3, 38,  0,  0,1},
  { 39, 0, 0, 0,18, 3,no,no, 4, 2, 0,"ui_face_039", 3, 31, 36,  0,2},
  { 40, 1, 0, 0, 0, 4,no,no, 1, 1, 0,"ui_face_040", 3, 42, 49, 47,3},
  { 41, 1, 0, 0, 2, 4,no,no, 1, 1, 0,"ui_face_041", 3, 48, 49, 47,3},
  { 42, 1, 0, 0, 4, 4,no,no, 4, 1, 0,"ui_face_042", 3, 44, 50,  0,2},
  { 43, 1, 0, 0, 5, 4,no,no, 1, 1, 1,"ui_face_043", 3, 42, 41, 49,3},
  { 44, 1, 0, 0,18, 4,no,no, 4, 1, 0,"ui_face_044", 3, 48, 42, 49,3},
  { 45, 1, 0, 0, 9, 4,no,no, 1, 1, 1,"ui_face_045", 3, 50, 44,  0,2},
  { 46, 1, 0, 0,10, 4,no,no, 1, 1, 0,"ui_face_046", 3, 49, 42, 44,3},
  { 47, 1, 0, 0,11, 4,no,no, 4, 1, 0,"ui_face_047", 3, 42, 45, 41,3},
  { 48, 1, 0, 0,12, 4,no,no, 4, 1, 1,"ui_face_048", 3, 47, 44, 42,3},
  { 49, 1, 0, 0,16, 4,no,no, 4, 1, 1,"ui_face_049", 3, 43, 46,  0,2},
  { 50, 0, 0, 0, 0, 5,no,no, 1, 0, 0,"ui_face_050", 3, 59, 57, 58,3},
  { 51, 0, 0, 0, 3, 5,no,no, 4, 0, 0,"ui_face_051", 3, 54, 55,  0,2},
  { 52, 0, 0, 0, 4, 5,no,no, 0, 0, 0,"ui_face_052", 3, 54, 61, 55,3},
  { 53, 0, 0, 0, 5, 5,no,no, 3, 0, 1,"ui_face_053", 3, 51, 59, 52,3},
  { 54, 0, 0, 0, 8, 5,no,no, 1, 0, 0,"ui_face_054", 3, 53, 56, 52,3},
  { 55, 0, 0, 0, 9, 5,no,no, 4, 0, 1,"ui_face_055", 3, 61, 54,  0,2},
  { 56, 0, 0, 0,10, 5,no,no, 0, 0, 0,"ui_face_056", 3, 59, 54, 51,3},
  { 57, 0, 0, 0,11, 5,no,no, 3, 0, 0,"ui_face_057", 3, 51,  0,  0,1},
  { 58, 0, 0, 0,12, 5,no,no, 1, 0, 1,"ui_face_058", 3, 57, 54,  0,2},
  { 59, 0, 0, 0,15, 5,no,no, 4, 0, 1,"ui_face_059", 3, 58, 61,  0,2},
  { 60, 0, 0, 0,16, 5,no,no, 0, 0, 1,"ui_face_060", 3, 53, 60, 56,3},
  { 61, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0,"ui_face_061", 3, 64, 69, 68,3},
  { 62, 0, 0, 0, 1, 6, 0, 0, 3, 0, 0,"ui_face_062", 3, 69, 65,  0,2},
  { 63, 0, 0, 0, 2, 6, 0, 0, 1, 0, 0,"ui_face_063", 3, 69, 68, 62,3},
  { 64, 0, 0, 0, 4, 6, 0, 0, 4, 0, 0,"ui_face_064", 3, 63, 67, 66,3},
  { 65, 0, 0, 0, 7, 6, 0, 0, 0, 0, 0,"ui_face_065", 3, 65, 67, 63,3},
  { 66, 0, 0, 0, 8, 6, 0, 0, 3, 0, 0,"ui_face_066", 3, 65, 70, 66,3},
  { 67, 0, 0, 0,10, 6, 0, 0, 1, 0, 0,"ui_face_067", 3, 69, 64, 62,3},
  { 68, 0, 0, 0,12, 6, 0, 0, 4, 0, 1,"ui_face_068", 3, 68, 64, 63,3},
  { 69, 0, 0, 0,13, 6, 0, 0, 0, 0, 0,"ui_face_069", 3, 67,  0,  0,1},
  { 70, 0, 0, 0,14, 6, 0, 0, 3, 0, 1,"ui_face_070", 3,  0,  0,  0,0},
  { 71, 0, 0, 0,17, 6, 0, 0, 1, 0, 1,"ui_face_071", 3, 64, 69,  0,2},
  { 72, 0, 0, 0, 0, 7,no,no, 0, 0, 0,"ui_face_072", 3, 75, 74, 79,3},
  { 73, 0, 0, 0, 1, 7,no,no, 3, 0, 0,"ui_face_073", 3, 77, 75, 73,3},
  { 74, 0, 0, 0, 4, 7,no,no, 1, 0, 0,"ui_face_074", 3, 74, 77, 73,3},
  { 75, 0, 0, 0, 6, 7,no,no, 4, 0, 1,"ui_face_075", 3, 81,  0,  0,1},
  { 76, 0, 0, 0, 7, 7,no,no, 0, 0, 0,"ui_face_076", 3, 75, 74,  0,2},
  { 77, 0, 0, 0, 9, 7,no,no, 3, 0, 1,"ui_face_077", 3, 80,  0,  0,1},
  { 78, 0, 0, 0,10, 7,no,no, 1, 0, 0,"ui_face_078", 3, 73,  0,  0,1},
  { 79, 0, 0, 0,13, 7,no,no, 4, 0, 0,"ui_face_079", 3, 78,  0,  0,1},
  { 80, 0, 0, 0,14, 7,no,no, 0, 0, 1,"ui_face_080", 3, 76,  0,  0,1},
  { 81, 0, 0, 0,17, 7,no,no, 3, 0, 1,"ui_face_081", 3,  0,  0,  0,0},
  { 82, 1, 0, 0, 2, 8,no,no, 1, 1, 0,"ui_face_082", 3, 89, 93,  0,2},
  { 83, 1, 0, 0, 3, 8,no,no, 1, 1, 0,"ui_face_083", 3, 90, 87,  0,2},
  { 84, 1, 0, 0, 6, 8,no,no, 1, 1, 1,"ui_face_084", 3, 91,  0,  0,1},
  { 85, 1, 0, 0, 7, 8,no,no, 1, 1, 0,"ui_face_085", 3, 87,  0,  0,1},
  { 86, 1, 0, 0, 8, 8,no,no, 1, 1, 0,"ui_face_086", 3, 90, 86,  0,2},
  { 87, 1, 0, 0, 9, 8,no,no, 1, 1, 1,"ui_face_087", 3, 90,  0,  0,1},
  { 88, 1, 0, 0,10, 8,no,no, 4, 1, 0,"ui_face_088", 3, 83,  0,  0,1},
  { 89, 1, 0, 0,13, 8,no,no, 4, 1, 0,"ui_face_089", 3, 87, 88, 84,3},
  { 90, 1, 0, 0,14, 8,no,no, 4, 1, 1,"ui_face_090", 3, 92, 85,  0,2},
  { 91, 1, 0, 0,15, 8,no,no, 4, 1, 1,"ui_face_091", 3, 91,  0,  0,1},
  { 92, 1, 0, 0,18, 8,no,no, 4, 1, 0,"ui_face_092", 3, 83,  0,  0,1},
  { 93, 0, 0, 0, 2, 9, 0, 1, 1, 0, 0,"ui_face_093", 3,102,103,  0,2},
  { 94, 0, 0, 0, 3, 9, 0, 1, 4, 0, 0,"ui_face_094", 3, 98,  0,  0,1},
  { 95, 0, 0, 0, 4, 9, 0, 1, 0, 0, 0,"ui_face_095", 3,101, 98,  0,2},
  { 96, 0, 0, 0, 6, 9, 0, 1, 3, 0, 1,"ui_face_096", 3, 99,  0,  0,1},
  { 97, 0, 0, 0, 8, 9, 0, 1, 1, 0, 0,"ui_face_097", 3, 96, 95,  0,2},
  { 98, 0, 0, 0,14, 9, 0, 1, 4, 0, 1,"ui_face_098", 3,100, 97,  0,2},
  { 99, 0, 0, 0,15, 9, 0, 1, 0, 0, 1,"ui_face_099", 3, 99,101,  0,2},
  {100, 0, 0, 0,16, 9, 0, 1, 3, 0, 1,"ui_face_100", 3, 96,100,  0,2},
  {101, 0, 0, 0,17, 9, 0, 1, 1, 0, 1,"ui_face_101", 3, 94,  0,  0,1},
  {102, 0, 0, 0,18, 9, 0, 1, 4, 0, 0,"ui_face_102", 3, 94,  0,  0,1},
  {103, 0, 0, 0, 2,10, 1, 4, 1, 0, 0,"ui_face_103", 3,112,113,106,3},
  {104, 0, 0, 0, 3,10, 1, 4, 4, 0, 0,"ui_face_104", 3,106,108,  0,2},
  {105, 0, 0, 0, 5,10, 1, 4, 0, 0, 1,"ui_face_105", 3,104,105,  0,2},
  {106, 0, 0, 0, 6,10, 1, 4, 3, 0, 1,"ui_face_106", 3,109,  0,  0,1},
  {107, 0, 0, 0, 8,10, 1, 4, 1, 0, 0,"ui_face_107", 3,105,  0,  0,1},
  {108, 0, 0, 0,14,10, 1, 4, 4, 0, 1,"ui_face_108", 3,110,  0,  0,1},
  {109, 0, 0, 0,15,10, 1, 4, 0, 0, 1,"ui_face_109", 3,109,  0,  0,1},
  {110, 0, 0, 0,16,10, 1, 4, 3, 0, 1,"ui_face_110", 3,110,  0,  0,1},
  {111, 0, 0, 0,17,10, 1, 4, 1, 0, 1,"ui_face_111", 3,104,  0,  0,1},
  {112, 0, 0, 0,18,10, 1, 4, 4, 0, 0,"ui_face_112", 3,104,  0,  0,1},
  {113, 0, 0, 0, 1,11, 2, 6, 1, 0, 0,"ui_face_113", 3,120,115,  0,2},
  {114, 0, 0, 0, 5,11, 2, 6, 4, 0, 1,"ui_face_114", 3,120,114,118,3},
  {115, 0, 0, 0, 6,11, 2, 6, 0, 0, 1,"ui_face_115", 3,  0,  0,  0,0},
  {116, 0, 0, 0, 9,11, 2, 6, 3, 0, 1,"ui_face_116", 3,121,115,  0,2},
  {117, 0, 0, 0,10,11, 2, 6, 1, 0, 0,"ui_face_117", 3,120,115,  0,2},
  {118, 0, 0, 0,11,11, 2, 6, 4, 0, 0,"ui_face_118", 3,122, 0,  0,1},
  {119, 0, 0, 0,12,11, 2, 6, 0, 0, 1,"ui_face_119", 3,118,115,114,3},
  {120, 0, 0, 0,16,11, 2, 6, 3, 0, 1,"ui_face_120", 3,117, 0,  0,1},
  {121, 0, 0, 0,18,11, 2, 6, 1, 0, 0,"ui_face_121", 3,119,120,  0,2},
  {122, 0, 0, 0, 0,12, 0, 2, 1, 0, 0,"ui_face_122", 3,125,129,128,3},
  {123, 0, 0, 0, 1,12, 0, 2, 4, 0, 0,"ui_face_123", 3,129,126,  0,2},
  {124, 0, 0, 0, 2,12, 0, 2, 0, 0, 0,"ui_face_124", 3,128,129,132,3},
  {125, 0, 0, 0, 4,12, 0, 2, 3, 0, 0,"ui_face_125", 3,124,127,  0,2},
  {126, 0, 0, 0, 7,12, 0, 2, 1, 0, 0,"ui_face_126", 3,126,124,  0,2},
  {127, 0, 0, 0,11,12, 0, 2, 4, 0, 0,"ui_face_127", 3,124,125,  0,2},
  {128, 0, 0, 0,12,12, 0, 2, 0, 0, 1,"ui_face_128", 3,125,124,132,3},
  {129, 0, 0, 0,13,12, 0, 2, 3, 0, 0,"ui_face_129", 3,  0,  0,  0,0},
  {130, 0, 0, 0,15,12, 0, 2, 1, 0, 1,"ui_face_130", 3,128,124,  0,2},
  {131, 0, 0, 0,17,12, 0, 2, 4, 0, 1,"ui_face_131", 3,128,125,129,3},
  {132, 0, 0, 0, 0,13, 3, 7, 1, 0, 0,"ui_face_132", 3,136,139,  0,2},
  {133, 0, 0, 0, 1,13, 3, 7, 4, 0, 0,"ui_face_133", 3,136,139,135,3},
  {134, 0, 0, 0, 4,13, 3, 7, 0, 0, 0,"ui_face_134", 3,134,136,138,3},
  {135, 0, 0, 0, 5,13, 3, 7, 3, 0, 1,"ui_face_135", 3,133,134,135,3},
  {136, 0, 0, 0, 6,13, 3, 7, 1, 0, 1,"ui_face_136", 3,  0,  0,  0,0},
  {137, 0, 0, 0, 7,13, 3, 7, 4, 0, 0,"ui_face_137", 3,135,136,134,3},
  {138, 0, 0, 0,11,13, 3, 7, 0, 0, 0,"ui_face_138", 3,134,133,  0,2},
  {139, 0, 0, 0,13,13, 3, 7, 3, 0, 0,"ui_face_139", 3,136,  0,  0,1},
  {140, 0, 0, 0,15,13, 3, 7, 1, 0, 1,"ui_face_140", 3,139,134,  0,2},
  {141, 0, 0, 0,17,13, 3, 7, 4, 0, 1,"ui_face_141", 3,139,  0,  0,1},
  {142, 0, 0, 0, 0,14, 6, 8, 4, 1, 0,"ui_face_142", 3,147,  0,  0,1},
  {143, 0, 0, 0, 3,14, 6, 8, 4, 1, 0,"ui_face_143", 3,  0,  0,  0,0},
  {144, 0, 0, 0, 4,14, 6, 8, 4, 1, 0,"ui_face_144", 3,  0,  0,  0,0},
  {145, 0, 0, 0, 9,14, 6, 8, 4, 1, 1,"ui_face_145", 3,  0,  0,  0,0},
  {146, 0, 0, 0,10,14, 6, 8, 4, 1, 0,"ui_face_146", 3,143,  0,  0,1},
  {147, 0, 0, 0,18,14, 6, 8, 4, 1, 0,"ui_face_147", 3,  0,  0,  0,0},
  {148, 0, 0, 0, 0,15,no,no, 1, 1, 0,"ui_face_148", 3,156,152,  0,2},
  {149, 0, 0, 0, 1,15,no,no, 1, 1, 0,"ui_face_149", 3,152,151,  0,2},
  {150, 0, 0, 0, 4,15,no,no, 1, 1, 0,"ui_face_150", 3,150,152,155,3},
  {151, 0, 0, 0, 5,15,no,no, 1, 1, 1,"ui_face_151", 3,149,150,156,3},
  {152, 0, 0, 0, 6,15,no,no, 1, 1, 1,"ui_face_152", 3,  0,  0,  0,0},
  {153, 0, 0, 0, 7,15,no,no, 1, 1, 0,"ui_face_153", 3,151,155,152,3},
  {154, 0, 0, 0, 8,15,no,no, 4, 1, 0,"ui_face_154", 3,151,157,154,3},
  {155, 0, 0, 0,10,15,no,no, 4, 1, 0,"ui_face_155", 3,152,149,  0,2},
  {156, 0, 0, 0,13,15,no,no, 4, 1, 0,"ui_face_156", 3,155,152,  0,2},
  {157, 0, 0, 0,15,15,no,no, 4, 1, 1,"ui_face_157", 3,150,  0,  0,1},
  {158, 0, 0, 0,17,15,no,no, 4, 1, 1,"ui_face_158", 3,  0,  0,  0,0},
  {159, 0, 0, 0, 7,16,no,no, 0, 0, 0,"ui_face_159", 3,163,  0,  0,1},
  {160, 0, 0, 0,12,16,no,no, 0, 0, 1,"ui_face_160", 3,  0,  0,  0,0},
  {161, 0, 0, 0,15,16,no,no, 3, 0, 1,"ui_face_161", 3,163,  0,  0,1},
  {162, 0, 0, 0,16,16,no,no, 3, 0, 1,"ui_face_162", 3,160,162,  0,2},
  {163, 0, 0, 0, 1,17, 5, 9, 0, 0, 0,"ui_face_163", 3,172,171,  0,2},
  {164, 0, 0, 0, 6,17, 5, 9, 3, 0, 1,"ui_face_164", 3,174,  0,  0,1},
  {165, 0, 0, 0, 3,17, 5, 9, 1, 0, 0,"ui_face_165", 3,173,167,164,3},
  {166, 0, 0, 0, 5,17, 5, 9, 4, 0, 1,"ui_face_166", 3,172,166,164,3},
  {167, 0, 0, 0, 8,17, 5, 9, 0, 0, 0,"ui_face_167", 3,173,166,169,3},
  {168, 0, 0, 0, 9,17, 5, 9, 3, 0, 1,"ui_face_168", 3,175,167,173,3},
  {169, 0, 0, 0,10,17, 5, 9, 1, 0, 0,"ui_face_169", 3,172,167,  0,2},
  {170, 0, 0, 0,11,17, 5, 9, 4, 0, 0,"ui_face_170", 3,164,  0,  0,1},
  {171, 0, 0, 0,12,17, 5, 9, 0, 0, 1,"ui_face_171", 3,170,167,164,3},
  {172, 0, 0, 0,13,17, 5, 9, 3, 0, 0,"ui_face_172", 3,175,168,167,3},
  {173, 0, 0, 0,14,17, 5, 9, 1, 0, 1,"ui_face_173", 3,  0,  0,  0,0},
  {174, 0, 0, 0,16,17, 5, 9, 4, 0, 1,"ui_face_174", 3,169,  0,  0,1},
  {175, 0, 0, 0, 2,18,no,no, 1, 0, 0,"ui_face_175", 3,181,186,  0,2},
  {176, 0, 0, 0, 3,18,no,no, 4, 0, 0,"ui_face_176", 3,182,180,  0,2},
  {177, 0, 0, 0, 6,18,no,no, 0, 0, 1,"ui_face_177", 3,183,  0,  0,1},
  {178, 0, 0, 0, 7,18,no,no, 3, 0, 0,"ui_face_178", 3,185,180,  0,2},
  {179, 0, 0, 0, 8,18,no,no, 1, 0, 0,"ui_face_179", 3,182,177,179,3},
  {180, 0, 0, 0,12,18,no,no, 4, 0, 1,"ui_face_180", 3,176,186,  0,2},
  {181, 0, 0, 0,13,18,no,no, 0, 0, 0,"ui_face_181", 3,185,180,177,3},
  {182, 0, 0, 0,14,18,no,no, 3, 0, 1,"ui_face_182", 3,184,  0,  0,1},
  {183, 0, 0, 0,15,18,no,no, 1, 0, 1,"ui_face_183", 3,185,183,  0,2},
  {184, 0, 0, 0,16,18,no,no, 4, 0, 1,"ui_face_184", 3,184,  0,  0,1},
  {185, 0, 0, 0,18,18,no,no, 0, 0, 0,"ui_face_185", 3,176,181,  0,2},
  {186, 0, 0, 0, 1,19,no,no, 1, 0, 0,"ui_face_186", 3,192,188,191,3},
  {187, 0, 0, 0, 5,19,no,no, 4, 0, 1,"ui_face_187", 3,192,187,189,3},
  {188, 0, 0, 0, 9,19,no,no, 0, 0, 1,"ui_face_188", 3,195,188,193,3},
  {189, 0, 0, 0,10,19,no,no, 3, 0, 0,"ui_face_189", 3,192,188,  0,2},
  {190, 0, 0, 0,11,19,no,no, 1, 0, 0,"ui_face_190", 3,187,  0,  0,1},
  {191, 0, 0, 0,12,19,no,no, 4, 0, 1,"ui_face_191", 3,190,188,187,3},
  {192, 0, 0, 0,13,19,no,no, 0, 0, 0,"ui_face_192", 3,195,188,189,3},
  {193, 0, 0, 0,14,19,no,no, 3, 0, 1,"ui_face_193", 3,  0,  0,  0,0},
  {194, 0, 0, 0,16,19,no,no, 1, 0, 1,"ui_face_194", 3,189,  0,  0,1},
  {195, 0, 0, 0, 1,47,no,no, 1, 0, 0,"ui_face_195", 3,198,199,  0,2},
  {196, 0, 0, 0, 2,47,no,no, 1, 0, 0,"ui_face_196", 3,199,198,200,3},
  {197, 0, 0, 0, 5,47,no,no, 4, 0, 1,"ui_face_197", 3,197,196,  0,2},
  {198, 0, 0, 0,11,47,no,no, 4, 0, 0,"ui_face_198", 3,196,197,  0,2},
  {199, 0, 0, 0,17,47,no,no, 3, 0, 1,"ui_face_199", 3,197,  0,  0,1},
  {200, 2, 0, 0,19,20, 4,16, 1, 3, 0,"ui_face_200", 3,209,203,204,3},
  {201, 2, 0, 0,20,20, 4,16, 1, 3, 0,"ui_face_201", 3,209,204,206,3},
  {202, 2, 0, 0,21,20, 4,16, 1, 3, 0,"ui_face_202", 3,206,201,209,3},
  {203, 2, 0, 0,22,20, 4,16, 1, 3, 0,"ui_face_203", 3,206,201,202,3},
  {204, 2, 0, 0,23,20, 4,16, 1, 3, 0,"ui_face_204", 3,203,201,  0,2},
  {205, 2, 0, 0, 0,20,no,no, 1, 3, 0,"ui_face_205", 3,207,203,202,3},
  {206, 2, 0, 0, 5,20,no,no, 1, 3, 1,"ui_face_206", 3,206,205,  0,2},
  {207, 2, 0, 0, 7,20,no,no, 1, 3, 0,"ui_face_207", 3,206,204,  0,2},
  {208, 2, 0, 0, 8,20,no,no, 1, 3, 0,"ui_face_208", 3,203,204,  0,2},
  {209, 2, 0, 0,19,21,no,no, 1, 3, 0,"ui_face_209", 3,216,212,213,3},
  {210, 2, 0, 0,20,21,no,no, 1, 3, 0,"ui_face_210", 3,216,213,  0,2},
  {211, 2, 0, 0,21,21,no,no, 1, 3, 0,"ui_face_211", 3,216,217,210,3},
  {212, 2, 0, 0,22,21,no,no, 1, 3, 0,"ui_face_212", 3,210,216,211,3},
  {213, 2, 0, 0,23,21,no,no, 1, 3, 0,"ui_face_213", 3,215,212,210,3},
  {214, 2, 0, 0, 3,21, 3, 7, 1, 3, 0,"ui_face_214", 3,214,212,  0,2},
  {215, 2, 0, 0, 8,21, 3, 7, 1, 3, 0,"ui_face_215", 3,213,212,  0,2},
  {216, 2, 0, 0, 9,21, 3, 7, 1, 3, 1,"ui_face_216", 3,212,  0,  0,1},
  {217, 2, 0, 0,19,22,no,no, 1, 4, 0,"ui_face_217", 3,223,220,221,3},
  {218, 2, 0, 0,20,22,no,no, 1, 4, 0,"ui_face_218", 3,221,223,  0,2},
  {219, 2, 0, 0,21,22,no,no, 1, 4, 0,"ui_face_219", 3,223,218,226,3},
  {220, 2, 0, 0,22,22,no,no, 1, 4, 0,"ui_face_220", 3,223,218,219,3},
  {221, 2, 0, 0,23,22,no,no, 1, 4, 0,"ui_face_221", 3,224,220,218,3},
  {222, 2, 0, 0, 0,22, 4,16, 1, 4, 0,"ui_face_222", 3,220,218,219,3},
  {223, 2, 0, 0, 3,22, 4,16, 1, 4, 0,"ui_face_223", 3,222,220,  0,2},
  {224, 2, 0, 0, 7,22, 4,16, 1, 4, 0,"ui_face_224", 3,218,221,  0,2},
  {225, 2, 0, 0, 9,22, 4,16, 1, 4, 1,"ui_face_225", 3,220,  0,  0,1},
  {226, 2, 0, 0,19,23,no,no, 1, 4, 0,"ui_face_226", 3,232,235,229,3},
  {227, 2, 0, 0,20,23,no,no, 1, 4, 0,"ui_face_227", 3,235,230,232,3},
  {228, 2, 0, 0,21,23,no,no, 1, 4, 0,"ui_face_228", 3,232,227,235,3},
  {229, 2, 0, 0,22,23,no,no, 1, 4, 0,"ui_face_229", 3,232,227,235,3},
  {230, 2, 0, 0,23,23,no,no, 1, 4, 0,"ui_face_230", 3,229,227,  0,2},
  {231, 2, 0, 0, 0,23,no,no, 1, 4, 0,"ui_face_231", 3,233,229,227,3},
  {232, 2, 0, 0, 5,23,no,no, 1, 4, 1,"ui_face_232", 3,232,231,  0,2},
  {233, 2, 0, 0, 7,23,no,no, 1, 4, 0,"ui_face_233", 3,232,230,  0,2},
  {234, 2, 0, 0, 8,23,no,no, 1, 4, 0,"ui_face_234", 3,230,229,  0,2},
  {235, 2, 0, 0,19,24,no,no, 1, 3, 0,"ui_face_235", 3,241,243,238,3},
  {236, 2, 0, 0,20,24,no,no, 1, 3, 0,"ui_face_236", 3,243,239,241,3},
  {237, 2, 0, 0,21,24,no,no, 1, 3, 0,"ui_face_237", 3,241,236,243,3},
  {238, 2, 0, 0,22,24,no,no, 1, 3, 0,"ui_face_238", 3,242,241,236,3},
  {239, 2, 0, 0,23,24,no,no, 1, 3, 0,"ui_face_239", 3,242,238,236,3},
  {240, 2, 0, 0, 0,24,no,no, 1, 3, 0,"ui_face_240", 3,238,236,237,3},
  {241, 2, 0, 0, 3,24,no,no, 1, 3, 0,"ui_face_241", 3,240,238,  0,2},
  {242, 2, 0, 0, 8,24,no,no, 1, 3, 0,"ui_face_242", 3,239,238,  0,2},
  {243, 2, 0, 0, 9,24,no,no, 1, 3, 1,"ui_face_243", 3,238,  0,  0,1},
  {244, 2, 0, 0,19,25,no,no, 1, 3, 0,"ui_face_244", 3,252,247,248,3},
  {245, 2, 0, 0,20,25,no,no, 1, 3, 0,"ui_face_245", 3,252,248,  0,2},
  {246, 2, 0, 0,21,25,no,no, 1, 3, 0,"ui_face_246", 3,245,252,253,3},
  {247, 2, 0, 0,22,25,no,no, 1, 3, 0,"ui_face_247", 3,250,245,252,3},
  {248, 2, 0, 0,23,25,no,no, 1, 3, 0,"ui_face_248", 3,250,247,245,3},
  {249, 2, 0, 0, 3,25, 6, 8, 1, 3, 0,"ui_face_249", 3,251,249,247,3},
  {250, 2, 0, 0, 5,25, 6, 8, 1, 3, 1,"ui_face_250", 3,250,249,  0,2},
  {251, 2, 0, 0, 8,25, 6, 8, 1, 3, 0,"ui_face_251", 3,248,247,  0,2},
  {252, 2, 0, 0, 9,25, 6, 8, 1, 3, 1,"ui_face_252", 3,251,247,  0,2},
  {253, 2, 0, 0,19,26,no,no, 1, 4, 0,"ui_face_253", 3,259,263,256,3},
  {254, 2, 0, 0,20,26,no,no, 1, 4, 0,"ui_face_254", 3,263,257,259,3},
  {255, 2, 0, 0,21,26,no,no, 1, 4, 0,"ui_face_255", 3,259,254,263,3},
  {256, 2, 0, 0,22,26,no,no, 1, 4, 0,"ui_face_256", 3,260,259,254,3},
  {257, 2, 0, 0,23,26,no,no, 1, 4, 0,"ui_face_257", 3,260,256,254,3},
  {258, 2, 0, 0, 0,26, 4,16, 1, 4, 0,"ui_face_258", 3,261,256,255,3},
  {259, 2, 0, 0, 3,26, 4,16, 1, 4, 0,"ui_face_259", 3,261,258,256,3},
  {260, 2, 0, 0, 5,26, 4,16, 1, 4, 1,"ui_face_260", 3,260,259,258,3},
  {261, 2, 0, 0, 7,26, 4,16, 1, 4, 0,"ui_face_261", 3,259,257,  0,2},
  {262, 2, 0, 0, 8,26, 4,16, 1, 4, 0,"ui_face_262", 3,257,256,  0,2},
  {263, 2, 0, 0, 9,26, 4,16, 1, 4, 1,"ui_face_263", 3,256,261,  0,2},
  {264, 2, 0, 0,19,27, 4,16, 1, 4, 0,"ui_face_264", 3,269,267,268,3},
  {265, 2, 0, 0,20,27, 4,16, 1, 4, 0,"ui_face_265", 3,268,269,  0,2},
  {266, 2, 0, 0,21,27, 4,16, 1, 4, 0,"ui_face_266", 3,269,265,273,3},
  {267, 2, 0, 0,22,27, 4,16, 1, 4, 0,"ui_face_267", 3,270,269,265,3},
  {268, 2, 0, 0, 0,27,no,no, 1, 4, 0,"ui_face_268", 3,267,265,266,3},
  {269, 2, 0, 0, 3,27,no,no, 1, 4, 0,"ui_face_269", 3,271,267,  0,2},
  {270, 2, 0, 0,23,27,no,no, 1, 4, 0,"ui_face_270", 3,270,267,265,3},
  {271, 2, 0, 0, 7,27,no,no, 1, 4, 0,"ui_face_271", 3,269,268,  0,2},
  {272, 2, 0, 0, 9,27,no,no, 1, 4, 1,"ui_face_272", 3,267,  0,  0,1},
  {273, 2, 0, 0,19,28, 6, 8, 1, 4, 0,"ui_face_273", 3,279,276,277,3},
  {274, 2, 0, 0,20,28, 6, 8, 1, 4, 0,"ui_face_274", 3,277,279,  0,2},
  {275, 2, 0, 0,21,28, 6, 8, 1, 4, 0,"ui_face_275", 3,279,274,283,3},
  {276, 2, 0, 0,22,28, 6, 8, 1, 4, 0,"ui_face_276", 3,280,279,274,3},
  {277, 2, 0, 0,23,28, 6, 8, 1, 4, 0,"ui_face_277", 3,280,276,274,3},
  {278, 2, 0, 0, 0,28,no,no, 1, 4, 0,"ui_face_278", 3,281,276,274,3},
  {279, 2, 0, 0, 3,28,no,no, 1, 4, 0,"ui_face_279", 3,278,281,276,3},
  {280, 2, 0, 0, 5,28,no,no, 1, 4, 1,"ui_face_280", 3,280,279,278,3},
  {281, 2, 0, 0, 7,28,no,no, 1, 4, 0,"ui_face_281", 3,279,277,  0,2},
  {282, 2, 0, 0, 9,28,no,no, 1, 4, 1,"ui_face_282", 3,277,276,  0,2},
  {283, 2, 0, 0,19,29,no,no, 1, 3, 0,"ui_face_283", 3,289,292,286,3},
  {284, 2, 0, 0,20,29,no,no, 1, 3, 0,"ui_face_284", 3,292,287,289,3},
  {285, 2, 0, 0,21,29,no,no, 1, 3, 0,"ui_face_285", 3,289,284,292,3},
  {286, 2, 0, 0,22,29,no,no, 1, 3, 0,"ui_face_286", 3,289,284,292,3},
  {287, 2, 0, 0,23,29,no,no, 1, 3, 0,"ui_face_287", 3,286,284,  0,2},
  {288, 2, 0, 0, 0,29,no,no, 1, 3, 0,"ui_face_288", 3,290,286,284,3},
  {289, 2, 0, 0, 5,29,no,no, 1, 3, 1,"ui_face_289", 3,289,288,  0,2},
  {290, 2, 0, 0, 7,29,no,no, 1, 3, 0,"ui_face_290", 3,287,289,  0,2},
  {291, 2, 0, 0, 8,29,no,no, 1, 3, 0,"ui_face_291", 3,286,287,  0,2},
  {292, 2, 0, 0, 9,29,no,no, 1, 3, 1,"ui_face_292", 3,290,286,  0,2},
  {293, 2, 0, 0,19,30,no,no, 1, 3, 0,"ui_face_293", 3,299,303,296,3},
  {294, 2, 0, 0,20,30,no,no, 1, 3, 0,"ui_face_294", 3,303,297,299,3},
  {295, 2, 0, 0,21,30,no,no, 1, 3, 0,"ui_face_295", 3,299,294,303,3},
  {296, 2, 0, 0,22,30,no,no, 1, 3, 0,"ui_face_296", 3,300,299,294,3},
  {297, 2, 0, 0,23,30,no,no, 1, 3, 0,"ui_face_297", 3,300,296,294,3},
  {298, 2, 0, 0, 0,30,no,no, 1, 3, 0,"ui_face_298", 3,301,296,294,3},
  {299, 2, 0, 0, 3,30,no,no, 1, 3, 0,"ui_face_299", 3,301,298,296,3},
  {300, 2, 0, 0, 5,30,no,no, 1, 3, 1,"ui_face_300", 3,300,299,298,3},
  {301, 2, 0, 0, 7,30,no,no, 1, 3, 0,"ui_face_301", 3,299,297,  0,2},
  {302, 2, 0, 0, 8,30,no,no, 1, 3, 0,"ui_face_302", 3,297,296,  0,2},
  {303, 2, 0, 0, 9,30,no,no, 1, 3, 1,"ui_face_303", 3,301,296,  0,2},--male<
  {320, 3, 0, 0,24,31, 0, 3, 1, 1, 0,"ui_face_320", 3,  0,  0,  0,0},--male>
  {321, 3, 0, 0,25,31, 0, 3, 4, 1, 0,"ui_face_321", 3,  0,  0,  0,0},
  {322, 3, 0, 0,26,31, 0, 3, 1, 1, 0,"ui_face_322", 3,  0,  0,  0,0},
  {323, 3, 0, 0,12,31, 6, 8, 4, 1, 1,"ui_face_323", 3,  0,  0,  0,0},
  {324, 3, 0, 0, 2,31, 6, 8, 1, 1, 0,"ui_face_324", 3,  0,  0,  0,0},
  {325, 3, 0, 0, 5,31, 6, 8, 4, 1, 1,"ui_face_325", 3,  0,  0,  0,0},
  {326, 3, 0, 0, 1,32, 0, 3, 1, 1, 0,"ui_face_326", 3,  0,  0,  0,0},
  {327, 3, 0, 0,24,32, 0, 3, 4, 1, 0,"ui_face_327", 3,  0,  0,  0,0},
  {328, 3, 0, 0,25,32, 0, 3, 1, 1, 0,"ui_face_328", 3,  0,  0,  0,0},
  {329, 3, 0, 0,26,32, 0, 3, 4, 1, 0,"ui_face_329", 3,  0,  0,  0,0},
  {330, 3, 0, 0,12,32, 3, 7, 1, 1, 1,"ui_face_330", 3,  0,  0,  0,0},
  {331, 3, 0, 0, 5,32, 3, 7, 4, 1, 1,"ui_face_331", 3,  0,  0,  0,0},
  {332, 3, 0, 0, 2,32, 3, 7, 1, 1, 0,"ui_face_332", 3,  0,  0,  0,0},
  {333, 3, 0, 0,24,33, 0, 3, 4, 1, 0,"ui_face_333", 3,  0,  0,  0,0},
  {334, 3, 0, 0,25,33, 0, 3, 1, 1, 0,"ui_face_334", 3,  0,  0,  0,0},
  {335, 3, 0, 0,26,33, 0, 3, 4, 1, 0,"ui_face_335", 3,  0,  0,  0,0},
  {336, 3, 0, 0,12,33, 6, 8, 1, 1, 1,"ui_face_336", 3,  0,  0,  0,0},
  {337, 3, 0, 0, 2,33, 6, 8, 4, 1, 0,"ui_face_337", 3,  0,  0,  0,0},
  {338, 3, 0, 0, 5,33, 6, 8, 1, 1, 1,"ui_face_338", 3,  0,  0,  0,0},
  {339, 3, 0, 0,24,34, 0, 3, 4, 1, 0,"ui_face_339", 3,  0,  0,  0,0},
  {340, 3, 0, 0,25,34, 0, 3, 1, 1, 0,"ui_face_340", 3,  0,  0,  0,0},
  {341, 3, 0, 0,26,34, 0, 3, 4, 1, 0,"ui_face_341", 3,  0,  0,  0,0},
  {342, 3, 0, 0,12,34, 6, 8, 1, 1, 1,"ui_face_342", 3,  0,  0,  0,0},
  {343, 3, 0, 0, 1,34, 6, 8, 4, 1, 0,"ui_face_343", 3,  0,  0,  0,0},
  {344, 3, 0, 0, 5,34, 6, 8, 1, 1, 1,"ui_face_344", 3,  0,  0,  0,0},
  {345, 3, 0, 0,24,51, 6, 8, 4, 1, 0,"ui_face_345", 3,  0,  0,  0,0},
  {346, 3, 0, 0,25,51, 6, 8, 1, 1, 0,"ui_face_346", 3,  0,  0,  0,0},
  {347, 3, 0, 0,26,51, 6, 8, 4, 1, 0,"ui_face_347", 3,  0,  0,  0,0},
  {348, 3, 0, 0, 2,51, 0, 3, 1, 1, 0,"ui_face_348", 3,  0,  0,  0,0},
  {349, 3, 0, 0, 5,51, 0, 3, 4, 1, 1,"ui_face_349", 3,  0,  0,  0,0},--male<
  {350,32, 1, 0,49,35, 7,10, 1, 0, 0,"ui_face_350", 3,  0,  0,  0,0},--female>
  {351,32, 1, 0,50,35, 7,10, 4, 0, 0,"ui_face_351", 3,  0,  0,  0,0},
  {352,32, 1, 0,51,35, 7,10, 0, 0, 0,"ui_face_352", 3,  0,  0,  0,0},
  {353,32, 1, 0,52,35, 7,10, 3, 0, 0,"ui_face_353", 3,  0,  0,  0,0},
  {354,32, 1, 0,49,35,12,15, 1, 0, 0,"ui_face_354", 3,  0,  0,  0,0},
  {355,32, 1, 0,50,35,12,15, 4, 0, 0,"ui_face_355", 3,  0,  0,  0,0},
  {356,32, 1, 0,51,35,12,15, 0, 0, 0,"ui_face_356", 3,  0,  0,  0,0},
  {357,32, 1, 0,52,35,12,15, 3, 0, 0,"ui_face_357", 3,  0,  0,  0,0},
  {358,32, 1, 0,49,35,11,14, 1, 0, 0,"ui_face_358", 3,  0,  0,  0,0},
  {359,32, 1, 0,50,35,11,14, 4, 0, 0,"ui_face_359", 3,  0,  0,  0,0},
  {360,32, 1, 0,51,35,11,14, 0, 0, 0,"ui_face_360", 3,  0,  0,  0,0},
  {361,32, 1, 0,52,35,11,14, 3, 0, 0,"ui_face_361", 3,  0,  0,  0,0},
  {362,32, 1, 0,49,36, 8,11, 0, 0, 0,"ui_face_362", 3,  0,  0,  0,0},
  {363,32, 1, 0,50,36, 8,11, 3, 0, 0,"ui_face_363", 3,  0,  0,  0,0},
  {364,32, 1, 0,51,36, 8,11, 1, 0, 0,"ui_face_364", 3,  0,  0,  0,0},
  {365,32, 1, 0,52,36, 8,11, 4, 0, 0,"ui_face_365", 3,  0,  0,  0,0},
  {366,32, 1, 0,49,36, 9,12, 0, 0, 0,"ui_face_366", 3,  0,  0,  0,0},
  {367,32, 1, 0,50,36, 9,12, 3, 0, 0,"ui_face_367", 3,  0,  0,  0,0},
  {368,32, 1, 0,51,36, 9,12, 1, 0, 0,"ui_face_368", 3,  0,  0,  0,0},
  {369,32, 1, 0,52,36, 9,12, 4, 0, 0,"ui_face_369", 3,  0,  0,  0,0},
  {370,32, 1, 0,49,36,10,13, 0, 0, 0,"ui_face_370", 3,  0,  0,  0,0},
  {371,32, 1, 0,50,36,10,13, 3, 0, 0,"ui_face_371", 3,  0,  0,  0,0},
  {372,32, 1, 0,51,36,10,13, 1, 0, 0,"ui_face_372", 3,  0,  0,  0,0},
  {373,32, 1, 0,52,36,10,13, 4, 0, 0,"ui_face_373", 3,  0,  0,  0,0},
  {374,32, 1, 0,49,37, 7,17, 1, 0, 0,"ui_face_374", 3,  0,  0,  0,0},
  {375,32, 1, 0,50,37, 7,17, 4, 0, 0,"ui_face_375", 3,  0,  0,  0,0},
  {376,32, 1, 0,51,37, 7,17, 0, 0, 0,"ui_face_376", 3,  0,  0,  0,0},
  {377,32, 1, 0,52,37, 7,17, 3, 0, 0,"ui_face_377", 3,  0,  0,  0,0},
  {378,32, 1, 0,49,37,12,15, 1, 0, 0,"ui_face_378", 3,  0,  0,  0,0},
  {379,32, 1, 0,50,37,12,15, 4, 0, 0,"ui_face_379", 3,  0,  0,  0,0},
  {380,32, 1, 0,51,37,12,15, 0, 0, 0,"ui_face_380", 3,  0,  0,  0,0},
  {381,32, 1, 0,52,37,12,15, 3, 0, 0,"ui_face_381", 3,  0,  0,  0,0},
  {382,32, 1, 0,49,37, 8,11, 1, 0, 0,"ui_face_382", 3,  0,  0,  0,0},
  {383,32, 1, 0,50,37, 8,11, 4, 0, 0,"ui_face_383", 3,  0,  0,  0,0},
  {384,32, 1, 0,51,37, 8,11, 0, 0, 0,"ui_face_384", 3,  0,  0,  0,0},
  {385,32, 1, 0,52,37, 8,11, 3, 0, 0,"ui_face_385", 3,  0,  0,  0,0},
  {386,32, 1, 0,57,37, 8,11, 1, 0, 0,"ui_face_386", 3,  0,  0,  0,0},
  {387,32, 1, 0,49,38, 8,11, 1, 2, 0,"ui_face_387", 3,  0,  0,  0,0},
  {388,32, 1, 0,50,38, 8,11, 4, 2, 0,"ui_face_388", 3,  0,  0,  0,0},
  {389,32, 1, 0,51,38, 8,11, 0, 2, 0,"ui_face_389", 3,  0,  0,  0,0},
  {390,32, 1, 0,52,38, 8,11, 3, 2, 0,"ui_face_390", 3,  0,  0,  0,0},
  {391,32, 1, 0,49,38, 9,12, 1, 2, 0,"ui_face_391", 3,  0,  0,  0,0},
  {392,32, 1, 0,50,38, 9,12, 4, 2, 0,"ui_face_392", 3,  0,  0,  0,0},
  {393,32, 1, 0,51,38, 9,12, 0, 2, 0,"ui_face_393", 3,  0,  0,  0,0},
  {394,32, 1, 0,52,38, 9,12, 3, 2, 0,"ui_face_394", 3,  0,  0,  0,0},
  {395,32, 1, 0,49,38,12,15, 1, 2, 0,"ui_face_395", 3,  0,  0,  0,0},
  {396,32, 1, 0,50,38,12,15, 4, 2, 0,"ui_face_396", 3,  0,  0,  0,0},
  {397,32, 1, 0,51,38,12,15, 0, 2, 0,"ui_face_397", 3,  0,  0,  0,0},
  {398,32, 1, 0,52,38,12,15, 3, 2, 0,"ui_face_398", 3,  0,  0,  0,0},
  {399,32, 1, 0,57,38,12,15, 1, 2, 0,"ui_face_399", 3,  0,  0,  0,0},--female<
  {450,34, 1, 0,53,39, 9,12, 1, 3, 0,"ui_face_450", 3,  0,  0,  0,0},--female>
  {451,34, 1, 0,54,39, 9,12, 1, 3, 0,"ui_face_451", 3,  0,  0,  0,0},
  {452,34, 1, 0,55,39, 9,12, 1, 3, 0,"ui_face_452", 3,  0,  0,  0,0},
  {453,34, 1, 0,56,39, 9,12, 1, 3, 1,"ui_face_453", 3,  0,  0,  0,0},
  {454,34, 1, 0,53,39,12,15, 1, 3, 0,"ui_face_454", 3,  0,  0,  0,0},
  {455,34, 1, 0,54,39,12,15, 1, 3, 0,"ui_face_455", 3,  0,  0,  0,0},
  {456,34, 1, 0,55,39,12,15, 1, 3, 0,"ui_face_456", 3,  0,  0,  0,0},
  {457,34, 1, 0,56,39,12,15, 1, 3, 1,"ui_face_457", 3,  0,  0,  0,0},
  {458,34, 1, 0,53,39, 7,17, 1, 3, 0,"ui_face_458", 3,  0,  0,  0,0},
  {459,34, 1, 0,54,39, 7,17, 1, 3, 0,"ui_face_459", 3,  0,  0,  0,0},
  {460,34, 1, 0,53,40,12,15, 1, 4, 0,"ui_face_460", 3,  0,  0,  0,0},
  {461,34, 1, 0,54,40,12,15, 1, 4, 0,"ui_face_461", 3,  0,  0,  0,0},
  {462,34, 1, 0,55,40,12,15, 1, 4, 0,"ui_face_462", 3,  0,  0,  0,0},
  {463,34, 1, 0,56,40,12,15, 1, 4, 1,"ui_face_463", 3,  0,  0,  0,0},
  {464,34, 1, 0,53,40,10,13, 1, 4, 0,"ui_face_464", 3,  0,  0,  0,0},
  {465,34, 1, 0,54,40,10,13, 1, 4, 0,"ui_face_465", 3,  0,  0,  0,0},
  {466,34, 1, 0,55,40,10,13, 1, 4, 0,"ui_face_466", 3,  0,  0,  0,0},
  {467,34, 1, 0,56,40,10,13, 1, 4, 1,"ui_face_467", 3,  0,  0,  0,0},
  {468,34, 1, 0,55,40,13,16, 1, 4, 0,"ui_face_468", 3,  0,  0,  0,0},
  {469,34, 1, 0,56,40,13,16, 1, 4, 1,"ui_face_469", 3,  0,  0,  0,0},
  {470,34, 1, 0,53,41,13,16, 1, 4, 0,"ui_face_470", 3,  0,  0,  0,0},
  {471,34, 1, 0,54,41,13,16, 1, 4, 0,"ui_face_471", 3,  0,  0,  0,0},
  {472,34, 1, 0,55,41,13,16, 1, 4, 0,"ui_face_472", 3,  0,  0,  0,0},
  {473,34, 1, 0,56,41,13,16, 1, 4, 1,"ui_face_473", 3,  0,  0,  0,0},
  {474,34, 1, 0,53,41, 9,12, 1, 4, 0,"ui_face_474", 3,  0,  0,  0,0},
  {475,34, 1, 0,54,41, 9,12, 1, 4, 0,"ui_face_475", 3,  0,  0,  0,0},
  {476,34, 1, 0,55,41, 9,12, 1, 4, 0,"ui_face_476", 3,  0,  0,  0,0},
  {477,34, 1, 0,51,41, 9,12, 1, 4, 0,"ui_face_477", 3,  0,  0,  0,0},
  {478,34, 1, 0,53,41,11,14, 1, 4, 0,"ui_face_478", 3,  0,  0,  0,0},
  {479,34, 1, 0,56,41,11,14, 1, 4, 1,"ui_face_479", 3,  0,  0,  0,0},--female<
  {500,35, 1, 0,56,42,11,14, 1, 1, 1,"ui_face_500", 3,  0,  0,  0,0},--female>
  {501,35, 1, 0,57,42,11,14, 4, 1, 0,"ui_face_501", 3,  0,  0,  0,0},
  {502,35, 1, 0,58,42,11,14, 1, 1, 0,"ui_face_502", 3,  0,  0,  0,0},
  {503,35, 1, 0,56,42, 9,12, 4, 1, 1,"ui_face_503", 3,  0,  0,  0,0},
  {504,35, 1, 0,57,42, 9,12, 1, 1, 0,"ui_face_504", 3,  0,  0,  0,0},
  {505,35, 1, 0,58,42, 9,12, 4, 1, 0,"ui_face_505", 3,  0,  0,  0,0},
  {506,35, 1, 0,50,42, 9,12, 1, 1, 0,"ui_face_506", 3,  0,  0,  0,0},
  {507,35, 1, 0,56,43, 9,12, 4, 0, 1,"ui_face_507", 3,  0,  0,  0,0},
  {508,35, 1, 0,57,43, 9,12, 1, 0, 0,"ui_face_508", 3,  0,  0,  0,0},
  {509,35, 1, 0,58,43, 9,12, 4, 0, 0,"ui_face_509", 3,  0,  0,  0,0},
  {510,35, 1, 0,56,43,12,15, 1, 0, 1,"ui_face_510", 3,  0,  0,  0,0},
  {511,35, 1, 0,57,43,12,15, 4, 0, 0,"ui_face_511", 3,  0,  0,  0,0},
  {512,35, 1, 0,58,43,12,15, 1, 0, 0,"ui_face_512", 3,  0,  0,  0,0},
  {513,35, 1, 0,50,43,12,15, 4, 0, 0,"ui_face_513", 3,  0,  0,  0,0},
  {514,35, 1, 0,56,44, 7,17, 1, 1, 1,"ui_face_514", 3,  0,  0,  0,0},
  {515,35, 1, 0,57,44, 7,17, 4, 1, 0,"ui_face_515", 3,  0,  0,  0,0},
  {516,35, 1, 0,58,44, 7,17, 1, 1, 0,"ui_face_516", 3,  0,  0,  0,0},
  {517,35, 1, 0,56,44,10,13, 4, 1, 1,"ui_face_517", 3,  0,  0,  0,0},
  {518,35, 1, 0,57,44,10,13, 1, 1, 0,"ui_face_518", 3,  0,  0,  0,0},
  {519,35, 1, 0,58,44,10,13, 4, 1, 0,"ui_face_519", 3,  0,  0,  0,0},--female<
  {550,16, 0, 0,27,no,no,no,no,no, 0,""           , 0},--,,,,--Balaclava Male
  {551,16, 0, 0,28,no,no,no,no,no, 0,""           , 0},--,,,,--Balaclava Male
  {552,16, 0, 0,29,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) male - face ids 552,553,554 identical
  {553,16, 0, 0,29,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) male
  {554,16, 0, 0,29,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) male
  {555,16, 1, 0,30,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) female - face ids 555,556,557 identical
  {556,16, 1, 0,30,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) female
  {557,16, 1, 0,30,no,no,no,no,no, 0,""           , 0},--,,,,--DD armor helmet (green top) female
  {558,16, 0, 0,31,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask and clava Male
  {559,16, 1, 0,32,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask and clava Female
  {560,16, 0, 0,33,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask DD helm Male
  {561,16, 0, 0,34,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask DD greentop helm Male
  {562,16, 1, 0,35,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask DD helm Female
  {563,16, 1, 0,36,no,no,no,no,no, 0,""           , 0},--,,,,--Gas mask DD greentop helm Female
  {564,16, 0, 0,37,no,no,no,no,no, 0,""           , 0},--,,,,--NVG DDgreentop Male
  {565,16, 0, 0,38,no,no,no,no,no, 0,""           , 0},--,,,,--NVG DDgreentop GasMask Male
  {566,16, 1, 0,39,no,no,no,no,no, 0,""           , 0},--,,,,--NVG DDgreentop Female (or just small head male lol, total cover)
  {567,16, 1, 0,40,no,no,no,no,no, 0,""           , 0},--,,,,--NVG DDgreentop GasMask Female (or just small head male lol, total cover)
  {600,16, 0, 1, 7,10, 1, 4, 1, 0, 0,"ui_face_600", 1,  0,  0,  0,0},--male> enemy, 10036
  {601,16, 0, 1,16, 0,no,no, 0, 0, 1,"ui_face_601", 1,  0,  0,  0,0},--Q19010--ruins_q19010
  {602,48, 0, 1,41,48, 2, 6, 1, 0, 1,"ui_face_602", 1,  0,  0,  0,0},--10033 glasses REF, from the hideo/kojima mod it replaces this, namely cm_unq_v000_eye1 which matches faceFova table of index 41(assuming indexed from 0 like bodyDefinition)
  {603,17, 0, 1,18, 1,no,no, 1, 1, 0,"ui_face_603", 1,  0,  0,  0,0},--enemy, 10040
  {604,16, 0, 1, 1, 9, 0, 1, 1, 0, 0,"ui_face_604", 1,  0,  0,  0,0},--enemy, 10040
  {605,16, 0, 1, 0,11, 2, 6, 1, 0, 0,"ui_face_605", 1,  0,  0,  0,0},--enemy, 10040
  {606,16, 0, 1, 9, 9, 0, 1, 1, 0, 1,"ui_face_606", 1,  0,  0,  0,0},--,10044
  {607,17, 0, 1, 1, 4,no,no, 1, 1, 0,"ui_face_607", 1,  0,  0,  0,0},--hostage, 10052
  {608,16, 0, 1,10,12, 0, 2, 1, 0, 0,"ui_face_608", 1,  0,  0,  0,0},--enemy,10052
  {609,16, 0, 1,12, 0,no,no, 0, 0, 1,"ui_face_609", 1,  0,  0,  0,0},--Q19011--outland_q19011, enemy 10086
  {610,48, 0, 1,11, 6, 0, 0, 0, 0, 0,"ui_face_610", 1,  0,  0,  0,0},--hostage 10086
  {611,16, 0, 1, 8, 7,no,no, 0, 0, 0,"ui_face_611", 1,  0,  0,  0,0},--hostage 10086
  {612,48, 0, 1, 9,12, 0, 2, 1, 0, 1,"ui_face_612", 1,  0,  0,  0,0},--hostage 10086 --< male
  {613,48, 1, 1,49,36, 7,10, 0, 0, 0,"ui_face_613", 1,  0,  0,  0,0},--female
  {614,16, 0, 1,14,11, 2, 6, 1, 0, 1,"ui_face_614", 1,  0,  0,  0,0},--male mission dudes> enemy, 10195
  {615,18, 0, 1,18,25,no,no, 1, 3, 0,"ui_face_615", 1,  0,  0,  0,0},--enemy, 10195
  {616,18, 0, 1,16,30,no,no, 1, 3, 1,"ui_face_616", 1,  0,  0,  0,0},--enemy, 10100
  {617,50, 0, 1,21,50, 4,16, 1, 3, 0,"ui_face_617", 1,  0,  0,  0,0},--enemy,10121
  {618,16, 0, 1,42,45,no,no, 1, 0, 1,"ui_face_618", 1,  0,  0,  0,0},--enemy, 10121
  {619,18, 0, 1,12,26, 4,16, 1, 4, 1,"ui_face_619", 1,  0,  0,  0,0},--enemy 10200
  {620,16, 0, 1, 2, 5,no,no, 1, 0, 0,"ui_face_620", 1,  0,  0,  0,0},--enemy 10211
  {621,19, 0, 1,43,51,no,no, 1, 1, 0,"ui_face_621", 1,  0,  0,  0,0},--TAN--65060 quest_q20015,quest_q20085,quest_q20095,quest_q20205,quest_q20705, fob event--serious asian with peircing eyes
  {622,19, 0, 1, 0, 0,no,no, 0, 0, 0,"ui_face_622", 1,  0,  0,  0,0},--male< --Hideo
  {623,16, 0, 1, 2,46, 3, 7, 1, 0, 0,"ui_face_623", 1,  0,  0,  0,0},-- bloody dude, shining lights
  {624,16, 0, 1, 2,13, 3, 7, 1, 0, 0,"ui_face_624", 1,  0,  0,  0,0},-- above, non bloody
  {625,16, 0, 1, 5,14, 6, 8, 1, 1, 1,"ui_face_625", 1,  0,  0,  0,0},
  {626,16, 0, 1,23,15,no,no, 1, 1, 0,"ui_face_626", 1,  0,  0,  0,0},--gz cuban guy
  {627,16, 0, 1,10,16,no,no, 1, 0, 0,"ui_face_627", 1,  0,  0,  0,0},--Finger
  {628,18, 0, 1,47,28,no,no, 1, 4, 0,"ui_face_628", 1,  0,  0,  0,0},--Eye
  {629,16, 0, 1, 9,11, 2, 6, 3, 0, 1,"ui_face_116", 1,  0,  0,  0,0},--enemy 10086
  {630,18, 0, 1, 0, 0,no,no, 0, 0, 0,""           , 0,  0,  0,  0,0},--same face (default?)>
  {631,16, 0, 1, 0, 0,no,no, 0, 0, 0,""           , 0,  0,  0,  0,0},
  {632,16, 0, 1, 0, 0,no,no, 0, 0, 0,""           , 0,  0,  0,  0,0},
  {633,16, 0, 1, 0, 0,no,no, 0, 0, 0,""           , 0,  0,  0,  0,0},
  {634,16, 0, 1, 0, 0,no,no, 0, 0, 0,""           , 0,  0,  0,  0,0},--<
  {635,16, 0, 1,10, 3,no,no, 1, 2, 0,"ui_face_635", 1,  0,  0,  0,0},--male enemy, 10020
  {636,16, 0, 1,46,no,no,no,no,no, 0,""           , 0},--,,,,--bullet to head, non animated face (which looks fucked cause eyes teeth still are) prologue i guess
  {637,16, 0, 1,13,47,no,no, 0, 0, 0,"ui_face_637", 1,  0,  0,  0,0},--enemy, 10041
  {638,16, 0, 1, 8,11, 2, 6, 1, 0, 0,"ui_face_638", 1,  0,  0,  0,0},--enemy, 10041
  {639,16, 0, 1,18,19,no,no, 1, 0, 0,"ui_face_639", 1,  0,  0,  0,0},--enemy, 10041
  {640,17, 0, 1, 0, 8,no,no, 1, 1, 0,"ui_face_640", 1,  0,  0,  0,0},--Q99070--sovietBase_q99070, fob event
  {641,18, 0, 1, 3,29,no,no, 1, 3, 0,"ui_face_641", 1,  0,  0,  0,0},--Q99071--outland_q99071, fob event
  {642,48, 0, 1,15,10, 1, 4, 1, 0, 1,"ui_face_642", 1,  0,  0,  0,0},--hostage 10085
  {643,50, 1, 1,49,39, 9,12, 1, 3, 0,"ui_face_643", 1,  0,  0,  0,0},--female hostage 10085
  {644,16, 0, 1,11, 3,no,no, 1, 2, 0,"ui_face_644", 1,  0,  0,  0,0},--hostage 10045
  {645,16, 0, 1,23, 0,no,no, 0, 0, 0,"ui_face_645", 1,  0,  0,  0,0},--enemy, 10171
  {646,48, 0, 1,48,49, 1, 5, 0, 2, 0,"ui_face_646", 1,  0,  0,  0,0},--Q99072--tent_q99072--beardy mcbeard, fob event
  {647,16, 0, 1,21, 1,no,no, 1, 1, 0,"ui_face_647", 1,  0,  0,  0,0},--Q19013--commFacility_q19013
  {648,48, 0, 1,17,17, 5, 9, 0, 0, 1,"ui_face_648", 1,  0,  0,  0,0},--Q19012--hill_q19012
  {649,18, 0, 1, 4,27,no,no, 1, 4, 0,"ui_face_649", 1,  0,  0,  0,0},--male--10093 vip bodyId 272
  {680,48, 0, 1, 0,53, 0,18, 3, 0, 0,"ui_face_680", 1,  0,  0,  0,0},--male tatoo fox hound black
  {681,48, 1, 1,49,57, 9,21, 3, 0, 0,"ui_face_681", 1,  0,  0,  0,0},--female tatoo fox hound black
  {682,48, 1, 1,50,58, 8,22, 4, 0, 0,"ui_face_682", 1,  0,  0,  0,0},--female tatoo whiteblack ddog red hair
  {683,48, 0, 1,11,54, 0,19, 4, 0, 0,"ui_face_683", 1,  0,  0,  0,0},--male tatoo whiteblack ddog red hair
  {684,48, 0, 1,17,55, 1,20, 1, 0, 1,"ui_face_684", 1,  0,  0,  0,0},--male tatoo fox black
  {685,48, 1, 1,51,59, 9,23, 1, 0, 0,"ui_face_685", 1,  0,  0,  0,0},--female tatoo fox black
  {686,48, 1, 1,52,60, 8,24, 3, 0, 0,"ui_face_686", 1,  0,  0,  0,0},--female tatoo skull white white hair
  {687,48, 0, 1, 9,56,no,no, 3, 0, 1,"ui_face_687", 1,  0,  0,  0,0},--male tatoo skull white bald
  --tex> these faceFova indexes had no definition entries
  --also faceDecoFova 52 isn't in any entry TODO see what what
  {688, 0, 0, 0,44,no,no,no, 0, 0, 0,"ui_face_687", 1,  0,  0,  0,0},--tex Hideo TODO: find hideo ui texture name
  --{689, 0, 0, 0,45,no,no,no, 0, 0, 0,"ui_face_687", 1,  0,  0,  0,0},--tex not-a-snail dude? same as 623 but all-in one I guess.
  --<
  --tex slots for run-time face modding, see InfEneFova.ApplyFaceFova >
  {689, 0, 0, 0, 0,no,no,no, 0, 0, 0,""           , 1,  0,  0,  0,0},
  {690, 0, 0, 0, 1,no,no,no, 0, 0, 0,""           , 1,  0,  0,  0,0},
--{faceId,unk1,gender,unk2,faceFova,faceDecoFova,hairFova,hairDecoFova,unk3,unk4,unk5,uiTextureName,unk6,unk7,unk8,unk9,unk10},--notes
--<
}

--{faceId,?type name,?type index},--
this.modFaceFova={
  {550,"Balaclava",1,""},
  {551,"Balaclava",2,""},
  {552,"Balaclava",3,""},
  {553,"Balaclava",4,""},
  {554,"Balaclava",5,""},
  {555,"Balaclava",6,""},
  {556,"Balaclava",7,""},
  {557,"Balaclava",8,""},
  {558,"Balaclava",9,""},
  {559,"Balaclava",10,""},
  {560,"Balaclava",11,""},
  {561,"Balaclava",12,""},
  {562,"Balaclava",13,""},
  {563,"Balaclava",14,""},
  {564,"Balaclava",15,""},
  {565,"Balaclava",16,""},
  {566,"Balaclava",17,""},
  {567,"Balaclava",18,""},
}

--maps TppEnemyBodyId to bodyFova table index (see above)
--{bodyId,bodyFova, isArmor? or something else common to armor?}--TppEnemyBodyId, further notes
this.bodyDefinition={
  {0,0,0},
  {1,1,0},
  {2,2,0},
  {5,3,0},
  {6,4,0},
  {7,5,0},
  {10,6,0},
  {11,7,0},
  {20,8,0},
  {21,9,0},
  {22,10,0},
  {25,11,0},
  {26,12,0},
  {27,13,0},
  {30,14,0},
  {31,15,0},
  {49,16,1},
  {50,17,0},
  {51,18,0},
  {55,19,0},
  {60,20,0},
  {61,21,0},
  {70,22,0},
  {71,23,0},
  {75,24,0},
  {80,25,0},
  {81,26,0},
  {90,27,0},
  {91,28,0},
  {95,29,0},
  {100,30,0},
  {101,31,0},
  {107,32,1},
  {108,33,1},
  {109,34,1},
  {110,35,0},
  {111,36,0},
  {112,37,0},
  {113,38,0},
  {115,39,0},
  {116,40,0},
  {117,41,0},
  {118,42,0},
  {119,43,0},
  {120,44,0},
  {121,45,0},
  {122,46,0},
  {123,47,0},
  {124,48,0},
  {125,49,0},
  {126,50,0},
  {130,51,0},
  {131,52,0},
  {132,53,0},
  {133,54,0},
  {134,55,0},
  {135,56,0},
  {140,57,0},
  {141,58,0},
  {142,59,0},
  {143,60,0},
  {144,61,0},
  {145,62,0},
  {146,63,0},
  {147,64,0},
  {148,65,0},
  {149,66,0},
  {150,67,0},
  {151,68,0},
  {152,69,0},
  {153,70,0},
  {154,71,0},
  {155,72,0},
  {156,73,0},
  {157,74,0},
  {158,75,0},
  {159,76,0},
  {160,77,0},
  {161,78,0},
  {162,79,0},
  {163,80,0},
  {164,81,0},
  {165,82,0},
  {166,83,0},
  {167,84,0},
  {168,85,0},
  {169,86,0},
  {170,87,0},
  {171,88,0},
  {172,89,0},
  {173,90,0},
  {174,91,0},
  {175,92,0},
  {176,93,0},
  {177,94,0},
  {178,95,0},
  {179,96,0},
  {180,97,0},
  {181,98,0},
  {182,99,0},
  {183,100,0},
  {184,101,0},
  {190,102,0},
  {191,103,0},
  {192,104,0},
  {195,105,0},
  {196,106,0},
  {200,107,0},
  {201,108,0},
  {202,109,0},
  {203,110,0},
  {205,111,0},
  {206,112,0},
  {207,113,0},
  {208,114,0},
  {209,115,0},
  {250,116,0},
  {251,117,0},
  {253,118,0},
  {254,119,0},
  {255,120,0},
  {256,121,0},
  {257,122,0},
  {258,123,0},
  {259,124,0},
  {260,125,0},
  {261,126,0},
  {262,127,0},
  {263,128,0},
  {264,129,0},
  {265,130,0},
  {266,131,0},
  {267,132,0},
  {268,133,0},
  {269,134,0},
  {270,135,0},
  {271,136,0},
  {272,137,0},
  {273,138,0},
  {274,139,0},
  {275,140,0},
  {280,141,0},
  {281,142,0},
  {282,143,0},
  {283,144,0},
  {284,145,0},
  {285,146,0},
  {286,147,0},
  {287,148,0},
  {288,149,0},
  {289,150,0},
  {290,151,0},
  {291,152,0},
  {292,153,0},
  {293,154,0},
  {294,155,0},
  {295,156,0},
  {296,157,0},
  {297,158,0},
  {298,159,0},
  {299,160,0},
  {300,161,0},
  {301,162,0},
  {302,163,0},
  {303,164,0},
  {304,165,0},
  {305,166,0},
  {306,167,0},
  {307,168,0},
  {308,169,0},
  {309,170,0},
  {310,171,0},
  {311,172,0},
  {312,173,0},
  {313,174,0},
  {314,175,0},
  {315,176,0},
  {316,177,0},
  {317,178,0},
  {318,179,0},
  {319,180,0},
  {320,181,0},
  {321,182,0},
  {322,183,0},
  {323,184,0},
  {324,185,0},
  {325,186,0},
  {326,187,0},
  {327,188,0},
  {328,189,0},
  {329,190,0},
  {330,191,0},
  {331,192,0},
  {332,193,0},
  {333,194,0},
  {334,195,0},
  {335,196,0},
  {336,197,0},
  {340,198,0},
  {341,199,0},
  {342,200,0},
  {343,201,0},
  {344,202,0},
  {345,203,0},
  {346,204,0},
  {347,205,0},
  {348,206,0},
  {349,207,0},
  {350,208,0},
  {351,209,0},
  {352,210,0},
  {353,211,0},
  {354,212,0},
  {355,213,0},
  {356,214,0},
  {357,215,0},
  {370,216,0},
  {371,217,0},
  {372,218,0},
  {373,219,0},
  {374,220,0},
  {375,221,0},
  {376,222,0},
  {377,223,0},
  {378,224,0},
  {379,225,0},
  {380,226,0},
  {381,227,0},
  {382,228,0},--RETAILPATCH 1.10>
  {383,229,0},
  {384,230,0},
  {385,231,0},
  {386,232,0},
  {387,233,0},
  {388,234,0},
  {389,235,0},
  {390,236,0},
  {391,237,0},
  {392,238,0},
  {393,239,0},
  {394,240,0},
  {395,241,0},
  {396,242,0},
  {397,243,0},
  {398,244,0},
  {399,245,0},
  {400,246,0},
  {401,247,0},
  {402,248,0},
  {403,249,0},
  {404,250,0},
  {405,251,0},--<
  {406,252,0},--RETAILPATCH 1.0.11>
  {407,253,0},
  {408,254,0},
  {409,255,0},
  {410,256,0},
  {411,257,0},
  {412,258,0},
  {413,259,0},
  {414,260,0},
  {415,261,0},
  {416,262,0},
  {417,263,0},
  {418,264,0},
  {419,265,0},
  {420,266,0},
  {421,267,0},
  {422,268,0},
  {423,269,0},
  {424,270,0},
  {425,271,0},
  {426,272,0},
  {427,273,0},
  {428,274,0},
  {429,275,0},
  {430,276,0},
  {431,277,0},
  {432,278,0},
  {433,279,0},
  {434,280,0},
  {435,281,0},
  {436,282,0},
  {437,283,0},
  {438,284,0},
  {439,285,0},
  {440,286,0},
  {441,287,0},
  {442,288,0},
  {443,289,0},
  {444,290,0},
  {445,291,0},
  {446,292,0},
  {447,293,0},
  {448,294,0},
  {449,295,0},
  {450,296,0},
  {451,297,0},
  {452,298,0},
  {453,299,0},--<
--tex OFF CULL
--  {406,252,0},--tex>dds0_main2
--  {407,253,0},
--  {408,254,0},
--  {409,255,0},--<
--  {410,256,0},--tex>wss4_main0
--  {411,257,0},
--  {412,258,0},--<
}

--tex> add player camos to fova system
local bodyIdStart=this.bodyDefinition[#this.bodyDefinition][1]+1
local bodyFovaStart=this.bodyDefinition[#this.bodyDefinition][2]+1
for camoId=0,numCamos do
  table.insert(this.bodyDefinition,{bodyIdStart+camoId,bodyFovaStart+camoId})
  TppEnemyBodyId[string.format("dds5_main0_ply_v%02d",camoId)]=bodyIdStart+camoId
end
local bodyIdStart=this.bodyDefinition[#this.bodyDefinition][1]+1
local bodyFovaStart=this.bodyDefinition[#this.bodyDefinition][2]+1
for camoId=0,numCamos do
  table.insert(this.bodyDefinition,{bodyIdStart+camoId,bodyFovaStart+camoId})
  TppEnemyBodyId[string.format("dds6_main0_ply_v%02d",camoId)]=bodyIdStart+camoId
end
--<

--{bodyId,?type name,?type index,?},--body description (from body id),type description
this.modBodyFova={
  {0,"CapType",1,""},--soviet a>
  {1,"CapType",1,""},
  {2,"CapType",1,""},
  {5,"CapType",1,""},
  {6,"CapType",1,""},
  {7,"CapType",1,""},
  {10,"CapType",1,""},
  {11,"CapType",1,""},--<
  {20,"CapType",2,""},--soviet b>
  {21,"CapType",2,""},
  {22,"CapType",2,""},
  {25,"CapType",2,""},
  {26,"CapType",2,""},
  {27,"CapType",2,""},
  {30,"CapType",2,""},
  {31,"CapType",2,""},--<
  {50,"CapType",3,""},--pf a>
  {51,"CapType",3,""},
  {55,"CapType",3,""},
  {60,"CapType",3,""},
  {61,"CapType",3,""},--<
  {70,"CapType",4,""},--pf b>
  {71,"CapType",4,""},
  {75,"CapType",4,""},
  {80,"CapType",4,""},
  {81,"CapType",4,""},--<
  {90,"CapType",5,""},--pf c>
  {91,"CapType",5,""},
  {95,"CapType",5,""},
  {100,"CapType",5,""},
  {101,"CapType",5,""},--<
  {107,"CapType",60,""},--pf b armor
  {108,"CapType",61,""},--pf c armor
  {109,"CapType",62,""},--pf a armor
  {250,"CapType",51,""},--pf unique,black beret
  {251,"CapType",51,""},--pf unique,black beret
  {255,"CapType",50,""},--pf unique,green beret
  {256,"CapType",40,""},--pf unique,?
  {257,"CapType",20,""},--soviet unique,red beret
  {259,"CapType",21,""},--soviet unique,green beret
  {261,"CapType",14,""},--soviet unique,sov cap?
  {264,"CapType",30,""},--pf unique,cap?
  {267,"CapType",52,""},--pf unique,red beret
  {268,"CapType",20,""},--soviet unique,red beret
  {269,"CapType",20,""},--soviet unique,red beret
  {270,"CapType",20,""},--soviet unique,red beret
  {272,"CapType",52,""},--pf unique,red beret
  {273,"CapType",20,""},--soviet unique,red beret
  {275,"CapType",52,""},--pf unique,red beret
}

this.highestVanillaFaceId=688--tex the highest faceid unmodded for sanity checking on fob --SYNC Ivars.playerFaceFilter
--OFF this.MAX_FACEID=688--tex added. faceIds are non contigious, but it's still nice to have a bounds check. SYNC: if you're going to dynamically add to this table

--tex shifted from after table definitions
if TppSoldierFace~=nil then
  this.fovaFileTable={--tex made local, was directly into SetFovaFileTable
    faceFova={table=this.faceFova,maxCount=100},
    faceDecoFova={table=this.faceDecoFova,maxCount=200},
    hairFova={table=this.hairFova,maxCount=20},
    hairDecoFova={table=this.hairDecoFova,maxCount=40},
    bodyFova={table=this.bodyFova,maxCount=301}--RETAILPATCH 1.0.11 increased from 256
  }
  this.fovaFileTable.bodyFova.maxCount=#this.bodyDefinition+1--tex

  InfCore.PCall(InfModelProc.Setup,this)--tex

  TppSoldierFace.SetFovaFileTable(this.fovaFileTable)

  TppSoldierFace.SetFaceFovaDefinitionTable{table=this.faceDefinition,uiTexBasePath="/Assets/tpp/ui/texture/StaffImage/"}

  if TppSoldierFace.ModFaceFovaDefinitionTable~=nil then
    TppSoldierFace.ModFaceFovaDefinitionTable{table=this.modFaceFova}
  end

  TppSoldierFace.SetBodyFovaDefinitionTable{table=this.bodyDefinition}

  if TppSoldierFace.ModBodyFovaDefinitionTable~=nil then
    TppSoldierFace.ModBodyFovaDefinitionTable{table=this.modBodyFova}
  end
end

return this--tex









--ORIG return{}

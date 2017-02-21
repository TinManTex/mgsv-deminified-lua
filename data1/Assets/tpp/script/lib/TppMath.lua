local this={}
function this.Vector3toTable(vector)
  return{vector:GetX(),vector:GetY(),vector:GetZ()}
end
function this.AddVector(v1,v2)
  return{v1[1]+v2[1],v1[2]+v2[2],v1[3]+v2[3]}
end
local e=180/foxmath.PI
local t=1/e
function this.RadianToDegree(rad)
  return rad*e
end
function this.DegreeToRadian(deg)
  return deg*t
end
function this.FindDistance(pos1,pos2)
  local distSqr=0
  for vecIndex=1,3 do
    distSqr=distSqr+(pos2[vecIndex]-pos1[vecIndex])^2
  end
  return distSqr
end
return this

AddCSLuaFile("shared.lua")
include("shared.lua")

local lastEntity = nil

function ENT:Draw()
   self:DrawModel()
end

hook.Add("PostDrawTranslucentRenderables", "HealthKit3DUI", function()
     local ply = LocalPlayer()
	 if not IsValid(ply) then return end
	   
	 local trace = ply:GetEyeTrace()
	 if trace.Entity and IsValid(trace.Entity) and 
	 trace.Entity:GetClass() == "health_pack" then
	      lastEntity = trace.Entity
	 else 
	      lastEntity = nil
	 end
	   
	 if IsValid(lastEntity) then
	     local pos = lastEntity:GetPos() + Vector(0,0,15)
		 local ang = Angle(0, ply:EyeAngles().y - 90,90)
		   
	  cam.Start3D2D(pos, ang, 0.1)
		    draw.SimpleTextOutlined("Healthkit", "DermaLarge", 0, -10, Color(200, 50 , 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
        	draw.SimpleTextOutlined("Healing: 100", "DermaLarge", 0, 20, Color(255, 255 ,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
	  cam.End3D2D()
	end
end)

AddCSLuaFile("shared.lua")
include("shared.lua")

local lastEntity = nil

function ENT:Draw()
   self:DrawModel()
end

hook.Add("PostDrawTranslucentRenderables", "DrawArmorPack3DUI", function()
     local ply = LocalPlayer()
	 if not IsValid(ply) then return end
	   
	 local trace = ply:GetEyeTrace()
	 if trace.Entity and IsValid(trace.Entity) and 
	 trace.Entity:GetClass() == "armor_pack" then
	      lastEntity = trace.Entity
	 else 
	      lastEntity = nil
	 end
	   
	 if IsValid(lastEntity) then
	     local pos = lastEntity:GetPos() + Vector(0,0,15)
		 local ang = Angle(0, ply:EyeAngles().y - 90,90)
		   
	  cam.Start3D2D(pos, ang, 0.1)
		    draw.SimpleTextOutlined("Armor Pack", "DermaLarge", 0, -10, Color(0, 100 ,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
        	draw.SimpleTextOutlined("Armor Amount: 100", "DermaLarge", 0, 20, Color(255, 255 ,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
	  cam.End3D2D()
	end
end)

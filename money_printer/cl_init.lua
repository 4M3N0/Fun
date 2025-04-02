AddCSLuaFile("shared.lua")
include("config.lua")
include("shared.lua")

function ENT:Draw()
   self:DrawModel()
end

local lastEntity = nil

hook.Add("PostDrawTranslucentRenderables", "DrawPrinter3DUI", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local trace = ply:GetEyeTrace()
    if trace.Entity and IsValid(trace.Entity) then
        local className = trace.Entity:GetClass()
        

        if PRINTERS[className] then

            local lastEntity = trace.Entity
            local pos = lastEntity:GetPos() + Vector(0, 0, 15)
            local ang = Angle(0, ply:EyeAngles().y - 90, 90)
            local printName = lastEntity:GetNWString("PrintName", "Unknown")
            local storedMoney = lastEntity:GetNWInt("StoredMoney", 0)
            local Health = lastEntity:Health() or 0

            cam.Start3D2D(pos, ang, 0.1)
                draw.SimpleTextOutlined(printName, "DermaLarge", 0, -10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
                draw.SimpleTextOutlined("$" .. storedMoney, "DermaLarge", 0, 20, Color(0, 135, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
                draw.SimpleTextOutlined("Health: " .. Health, "DermaLarge", 0, 50, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
            cam.End3D2D()
        end
    end
end)
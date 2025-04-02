AddCSLuaFile("shared.lua")
AddCSLuaFile("init.lua")
include("shared.lua")
include("Init.lua")

local lastEntity = nil

function ENT:Draw()
   self:DrawModel()
end

hook.Add("HUDPaint", "DrawMoneyAtCrosshair", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local lastEntity = nil
    local trace = ply:GetEyeTrace()


    if trace.Entity and IsValid(trace.Entity) and trace.Entity:GetClass() == "ent_money" then
        lastEntity = trace.Entity
    end

    if IsValid(lastEntity) then
        local moneyAmount = lastEntity:GetNWInt("MoneyAmount", 0)
        local scrW, scrH = ScrW(), ScrH()
        local x, y = scrW / 2, scrH / 2 
		local offset = 20
        draw.SimpleTextOutlined("$" .. moneyAmount, "ChatFont", x, y - offset, Color(0, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
    end
end)

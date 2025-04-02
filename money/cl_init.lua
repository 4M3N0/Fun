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

    -- Assuming 'lastEntity' holds the entity you're interacting with
    local lastEntity = nil
    local trace = ply:GetEyeTrace()

    -- Check if the player is looking at a "money" entity
    if trace.Entity and IsValid(trace.Entity) and trace.Entity:GetClass() == "ent_money" then
        lastEntity = trace.Entity
    end

    -- If a valid money entity is found, display the money amount
    if IsValid(lastEntity) then
        -- Get the money amount from the entity
        local moneyAmount = lastEntity:GetNWInt("MoneyAmount", 0)
        
        -- Draw the money amount at the center of the screen (crosshair)
        local scrW, scrH = ScrW(), ScrH()
        local x, y = scrW / 2, scrH / 2  -- Center of the screen

        -- Draw the money amount
		local offset = 20
        draw.SimpleTextOutlined("$" .. moneyAmount, "ChatFont", x, y - offset, Color(0, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
    end
end)
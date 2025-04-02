AddCSLuaFile("config.lua")

DEFINE_BASECLASS("base_gmodentity")
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = true

for className, config in pairs(PRINTERS) do
    local ENT = {}
    ENT.Type = "anim"
    ENT.Base = "base_gmodentity"
    ENT.PrintName = config.PrintName
    ENT.Spawnable = true
    ENT.Model = config.Model
    scripted_ents.Register(ENT, className)
end

function ENT:ShowMoneyStatus()
 -- debug if needed
end

function ENT:Use(a, c)
   if a:IsPlayer() then 
   
       local moneyGiven = self.StoredMoney
	   if moneyGiven > 0 then
	      GAMEMODE:AddMoney(a, moneyGiven)
		  self.StoredMoney = 0
		  self:ShowMoneyStatus()
		  a:ChatPrint("+$" .. moneyGiven)
		  
	   else
	   
	      a:ChatPrint("No money to collect")
		  
	   end 
	end
end

print("Shared.lua loaded!")

function ENT:UpdateStoredMoney()
    if SERVER then
       net.Start("MoneyPrinter_UpdateMoney")
	   net.WriteEntity(self)
	   net.WriteInt(self.StoredMoney, 32)
	   net.Broadcast()
	end
end
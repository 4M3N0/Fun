AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("config.lua")
include("config.lua")
include("shared.lua")

util.AddNetworkString("MoneyPrinter_UpdateMoney")
util.AddNetworkString("MoneyPrinter_SetName")


for className, config in pairs(PRINTERS) do

	scripted_ents.Register(ENT, className)
    ENT.Spawnable = true


end

function ENT:Initialize()
    local className = self:GetClass()
    local config = PRINTERS[className]
	if config then
	    --self.PrintName = config.PrintName or "UNDEFINED"
     	self.PrintRate = config.PrintRate or 1
	    self.PrintAmount = config.PrintAmount or 1
	    self.MaxMoney = config.MaxMoney or 10000
	    self.Model = config.Model
		self.StoredMoney = 0
		self.Color = config.Color
		self:SetNWString("PrintName", config.PrintName)
		self:SetNWInt("StoredMoney", self.StoredMoney)
		util.PrecacheModel(config.Model)
		self:SetModel(config.Model)
		self:SetColor(config.Color)
		print("Entity Class:", className)	
		print("[DEBUG] Model to be set:", config.Model)
		
	else
	    print(self:GetClass() .. "not configurated")	
	end
    --self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:StartPrintingMoney()
	self:SetHealth(config.Health or 100)
	self:SetRenderMode(RENDERMODE_NORMAL)
	
	-- self:Ignite(10, 10)
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
	   phys:Wake()
	end
	
end

function ENT:StartPrintingMoney()

    timer.Create("MoneyPrintTimer_" .. self:EntIndex(), self.PrintRate, 0, function() 
		if IsValid(self) then 
	       self:PrintMoney()
		end
	end)
end

function ENT:UpdateStoredAmount()
end

function ENT:ShowMoneyStatus()
end

function ENT:PrintMoney()

    if self.StoredMoney < self.MaxMoney then
	   self.StoredMoney = self.StoredMoney + self.PrintAmount
	   self:SetNWInt("StoredMoney", self.StoredMoney)
	   self:ShowMoneyStatus()
	   self:UpdateStoredAmount()
	   
	   -- print("[DEBUG] StoredMoney Updated: " .. self.StoredMoney)
	   
	end
	
end

function ENT:StartFire()
   if not IsValid(self) then return end
   if self:Health() <= 30 then
      self:Ignite(10, 10)
   end
end

-- function ENT:FireDamage()
-- end

--function ENT:OnDamageTaken()
--end

function ENT:OnTakeDamage(dmginfo)
    local damage = dmginfo:GetDamage()
	self:SetHealth(self:Health() - damage)
	if self:Health() <= 30 then
	   self:Ignite(10, 30)
	end
	
	if self:Health() <= 0 then
	   self:OnDestroyed()
	end
end

function ENT:OnDestroyed()
    if self:Health() <= 0 then
	   self:RadiusDamage(100, 40)
       self:Remove()
	   local effect = EffectData()
	   effect:SetOrigin(self:GetPos())
	   util.Effect("Explosion", effect)
	end
end

function ENT:RadiusDamage(radius, damageAmount)

    local pos = self:GetPos()
	local entitiesInRange = ents.FindInSphere(pos, radius)
	
	for _, entity in pairs(entitiesInRange) do
	   if entity:IsValid() and entity ~= self then
	      local damageInfo = DamageInfo()
		  damageInfo:SetDamage(damageAmount)
		  damageInfo:SetAttacker(self)
		  damageInfo:SetInflictor(self)
		  damageInfo:SetDamageType(DMG_BLAST)
		  entity:TakeDamageInfo(damageInfo)
	   end
	end	
end

print("init.lua loaded!")

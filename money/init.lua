AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.Model or "models/props/cs_assault/money.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	--self:SetUseType(SIMPLE_USE)
	local moneyAmount = self.MoneyAmount or 100
	self:SetNWInt("MoneyAmount", moneyAmount)
	
	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then
	   phys:Wake()
	end
end

function ENT:Use(ply)
    if IsValid(ply) and ply:IsPlayer() then
	   if GAMEMODE.AddMoney then
	      GAMEMODE:AddMoney(ply, self.MoneyAmount)
	      ply:ChatPrint("+$" .. self.MoneyAmount)
       end
	   ply:EmitSound("items/flashlight1.wav")
       self:Remove()
   end
end

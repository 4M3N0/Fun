AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    if not util.IsValidModel(self.Model) then
        print("Error: Invalid model path!")
        return
	end
	self:SetModel(self.Model)
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetHealth(50)
    self:SetUseType(SIMPLE_USE)
    self:SetRenderMode(RENDERMODE_NORMAL)
    self:SetColor(Color(255, 255, 255, 255))  
	
	local phys = self:GetPhysicsObject()
    if IsValid(phys) then
    phys:Wake()


    end
end
	


function ENT:GiveHealth(ply)
    if IsValid(ply) and ply:IsPlayer() then
        ply:SetHealth(math.min(ply:Health() + 100, 100)) 
    end
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        self:GiveHealth(activator)
        activator:EmitSound("items/medshot4.wav")
        self:Remove()
    end
end

function ENT:OnTakeDamage(dmginfo)
    local damage = dmginfo:GetDamage()
	self:SetHealth(self:Health() - damage)
	if self:Health() <= 0 then 
	   self:OnDestroyed()
	end
end

function ENT:OnDestroyed()
    self:EmitSound("ambient/levels/labs/electric_explosion1.wav")
	self:Remove()
end
	

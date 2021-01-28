AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    -- Setting the model
    self:SetModel("models/props_junk/sawblade001a.mdl")
    self:DrawShadow(false)

    -- Defining physics
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetModelScale(0.520)

    self:SetOwner(self.Owner)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then phys:Wake() end
end


-- Sets collision behaviour to stick to surfaces, kind of like when you shoot a saw blade using the gravity gun
function ENT:PhysicsCollide(col_data, phys)
    if (col_data.HitEntity:IsWorld() or col_data.HitEntity:GetClass() == "prop_physics") and not col_data.HitEntity:IsPlayer() then
        if col_data.Speed > 500 then self:EmitSound(Sound("Metal.SawBladeStick")) phys:EnableMotion(false) phys:Sleep() phys:EnableMotion(true) end
    end
end


-- Returns saw blade as ammo
function ENT:Use(activator)
    if activator:IsPlayer() then
        activator:GiveAmmo(1, "XBowBolt")
        self:Remove()
    end
end
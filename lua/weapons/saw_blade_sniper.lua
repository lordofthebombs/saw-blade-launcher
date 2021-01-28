-- SWEP Data
SWEP.PrintName = "Saw Blade Sniper"
SWEP.Purpose = "Attack people from long ranges with saw blades"
SWEP.Author = "lordofthebombs"
SWEP.Instructions = "Hold left click to charge the shot. The longer you hold it, the faster the projectile will fly"
SWEP.Category = "Lord's Wacky Weapons"
SWEP.IconOverride = ""
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.BounceWeaponIcon = false
-- if CLIENT then SWEP.WepSelectIcon = "" end


-- Ammo info
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Firerate = 1.0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true


-- Setting secondary fire to do absolutely nothing
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

-- Weapon Switching info
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 2
SWEP.SlotPos = 1


-- Weapon viewmodel settings
SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.UseHands = true

-- scope variables
SWEP.ZoomFOV = 20
SWEP.Scoped = false
SWEP.ZoomTransition = 0.15

-- This will activate and deactivate the scope
function SWEP:SecondaryAttack()

    local owner = self:GetOwner()
    print(owner)

    if not scope_zoom then
        owner:SetFOV(self.ZoomFOV, self.ZoomTransition)
        scope_zoom = true
    else
        owner:SetFOV(0, self.ZoomTransition)
        scope_zoom = false
    end
end
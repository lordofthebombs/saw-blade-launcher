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
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Firerate = 1.0
SWEP.DrawAmmo = true
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

SWEP.ReloadingTime = 1
SWEP.EmptySound = Sound("weapons/ar2/ar2_empty.wav")

-- Weapon viewmodel settings
SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.UseHands = true

-- scope variables
SWEP.ZoomFOV = 15
SWEP.ZoomTransition = 0.15
SWEP.ScopeSound = Sound("zoom.wav")


-- Shots are fired here
function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    if self:Clip1() > 0 then
        self:ShootEffects(ACT_VM_PRIMARYATTACK)
        self:TakePrimaryAmmo(1)
        owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
    else
        self:EmitSound(self.EmptySound)
    end

end


-- Reload function
function SWEP:Reload()
    local owner = self:GetOwner()
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
    if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
        --self:EmitSound(self.ReloadSound)
        self:DefaultReload(ACT_VM_RELOAD)
        local AnimationTime = owner:GetViewModel():SequenceDuration()
        self.ReloadingTime = CurTime() + AnimationTime
        self:SetNextPrimaryFire(CurTime() + AnimationTime)
        self:SetNextSecondaryFire(CurTime() + AnimationTime)
    end
end


-- This will activate and deactivate the scope zoom
function SWEP:SecondaryAttack()
    self:EmitSound(self.ScopeSound)
    local owner = self:GetOwner()

    if not owner:IsValid() then return end          -- Checks if owner is valid

    if not self:GetNWBool("Scoped") then
        owner:SetFOV(self.ZoomFOV, self.ZoomTransition)
        owner:CrosshairDisable()
        self:SetNWBool("Scoped", true)
    else
        owner:SetFOV(0, self.ZoomTransition)
        owner:CrosshairEnable()
        self:SetNWBool("Scoped", false)
    end
end


function SWEP:fire_saw()
    
end


if CLIENT then
-- Draws scope on HUD when zoomed in (currently doesn't work)
    function SWEP:DrawHUD()
        if self:GetNWBool("Scoped") then

            local width, height = ScrW(), ScrH()

            local x, y = (ScrW() / 2) - (width / 2) , (ScrH() / 2) - (height / 2)      -- Center of the screen, while also centering image on the screen
            
            surface.SetMaterial(Material("materials/weapons/scope.png", "smooth"))
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(x, y, width, height)
        end
    end

    -- Reduces sensitivity when zoomed in
    function SWEP:AdjustMouseSensitivity()
        if self:GetNWBool("Scoped") then return 0.2 end
    end

    -- Draws a custom crosshair
    function SWEP:DoDrawCrosshair(x, y)
        local length = 26
        local gap = 12
        offset = 1      -- offset used to deal with how pixels are really centered
        surface.SetDrawColor(255, 255, 255)

        surface.DrawRect(x - offset ,y , 1, 1)                              -- center dot
        surface.DrawLine(x - length, y, x - gap, y)                         -- left line
        surface.DrawLine(x + length - 2, y, x + gap - 2, y)                 -- right line       The -2 is there in an attempt to center it perfectly to the screen
        surface.DrawLine(x - offset, y - length, x - offset, y - gap)       -- top line
        surface.DrawLine(x - offset, y + length, x - offset, y + gap)       -- bottom line

        return true
    end
end
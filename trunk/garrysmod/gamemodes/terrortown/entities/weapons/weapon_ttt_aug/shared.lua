---- Example TTT custom weapon

-- First some standard GMod stuff
if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_tuna_ak47.vmt")
end

if CLIENT then
   SWEP.PrintName = "Steyr AUG A1"
   SWEP.Slot      = 2 -- add 1 to get the slot number key
   SWEP.Author	  = "EraYaN"
   SWEP.Icon = "VGUI/ttt/icon_tuna_aug"
end

-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"

--- Standard GMod values

SWEP.HoldType			= "ar2"

SWEP.Primary.Delay       = 0.12
SWEP.Primary.Recoil      = 1.4
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 22
SWEP.Primary.Cone        = 0.015
SWEP.Primary.Ammo        = "CombineCannon"
SWEP.Primary.ClipSize    = 25
SWEP.Primary.ClipMax     = 75
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Sound       = Sound( "Weapon_AUG.Single" )
SWEP.HeadshotMultiplier = 4.5

SWEP.IronSightsPos = Vector (2.7088, -1.4358, 1.9033)
SWEP.IronSightsAng = Vector (1.3976, 0.4462, 0)

SWEP.ViewModel  = "models/weapons/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.Kind = WEAPON_HEAVY

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_rifle_ttt"

SWEP.AllowDrop = true

SWEP.IsSilent = false

SWEP.NoSights = false

function SWEP:SetZoom(state)
   if CLIENT then return end
   if state then
      self.Owner:SetFOV(30, 0.6)
   else
      self.Owner:SetFOV(0, 0.2)
   end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
   if not self.IronSightsPos then return end
   if self.Weapon:GetNextSecondaryFire() > CurTime() then return end
   
   bIronsights = not self:GetIronsights()
   
   self:SetIronsights( bIronsights )
   
   if SERVER then
      self:SetZoom(bIronsights)
   end
   
   self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:PreDrop()
   self:SetZoom(false)
   self:SetIronsights(false)
   return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
   self.Weapon:DefaultReload( ACT_VM_RELOAD );
   self:SetIronsights( false )
   self:SetZoom(false)
end


function SWEP:Holster()
   self:SetIronsights(false)
   self:SetZoom(false)
   return true
end
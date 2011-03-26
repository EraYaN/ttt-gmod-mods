if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_bb_aug.vmt")
end

if CLIENT then
   SWEP.PrintName = "Steyr AUG A1"
   SWEP.Slot      = 7 -- add 1 to get the slot number key
   SWEP.Author	  = "EraYaN"
   SWEP.Icon = "VGUI/ttt/icon_bb_aug"
   SWEP.EquipMenuData = {
      type="Weapon",
      model="models/weapons/w_rif_aug.mdl",
      name="Steyr AUG A1",
      desc="The Steyr AUG A1\n is a powerful assault rifle.\n Does good damage, has good accuracy,\n a good gun."
   };
end

-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"

--- Standard GMod values

SWEP.HoldType			= "ar2"

SWEP.Primary.Delay       = 0.12
SWEP.Primary.Recoil      = 1.4
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 25
SWEP.Primary.Cone        = 0.015
SWEP.Primary.Ammo        = "CombineCannon"
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound       = Sound( "Weapon_AUG.Single" )
SWEP.HeadshotMultiplier = 4.5

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_DETECTIVE} -- only detectives can buy
SWEP.LimitedStock = true -- only buyable once

SWEP.IronSightsPos = Vector (2.7088, -1.4358, 1.9033)
SWEP.IronSightsAng = Vector (1.3976, 0.4462, 0)

SWEP.ViewModel  = "models/weapons/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.Kind = WEAPON_EQUIP1

SWEP.AutoSpawnable = false

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
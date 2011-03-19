---- Example TTT custom weapon

-- First some standard GMod stuff
if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_tuna_sg552.vmt")
end

if CLIENT then
   SWEP.PrintName = "SG 552 Commando"
   SWEP.Slot      = 7 -- add 1 to get the slot number key
   SWEP.Author	  = "EraYaN"
   SWEP.Icon = "VGUI/ttt/icon_tuna_sg552"
   SWEP.EquipMenuData = {
      type="Sniper Weapon",
      model="models/weapons/w_rif_sg552.mdl",
      name="SG 552 Commando",
      desc="SG 552 Commando\n is a powerful assault rifle.\n Does good damage, has good accuracy,\n a good gun."
   };
end

-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"

--- Standard GMod values

SWEP.HoldType			= "ar2"

SWEP.Primary.Delay       = 0.11
SWEP.Primary.Recoil      = 1.5
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 21
SWEP.Primary.Cone        = 0.015
SWEP.Primary.Ammo        = "CombineCannon"
SWEP.Primary.ClipSize    = 20
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Sound       = Sound( "Weapon_SG552.Single" )
SWEP.HeadshotMultiplier = 6

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock = true -- only buyable once

SWEP.IronSightsPos = Vector( 6.05, -5, 2.4 )
SWEP.IronSightsAng = Vector( 2.2, -0.1, 0 )

SWEP.ViewModel  = "models/weapons/v_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"

SWEP.Kind = WEAPON_EQUIP1

SWEP.AutoSpawnable = false

SWEP.AmmoEnt = "item_ammo_rifle_ttt"

SWEP.AllowDrop = true

SWEP.IsSilent = false

SWEP.NoSights = false

function SWEP:SetZoom(state)
   if CLIENT then return end
   if state then
      self.Owner:SetFOV(35, 0.4)
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
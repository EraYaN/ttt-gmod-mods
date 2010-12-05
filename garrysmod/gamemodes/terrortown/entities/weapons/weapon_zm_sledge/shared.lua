if SERVER then

   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType			= "crossbow"


if CLIENT then

   SWEP.PrintName			= "FN M-249 PARA"
   SWEP.Author				= "TTT"
   SWEP.Slot				= 2
   SWEP.SlotPos			= 0

   SWEP.Icon = "VGUI/ttt/icon_m249"

   SWEP.ViewModelFlip		= false
end


SWEP.Base				= "weapon_tttbase"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249


SWEP.Primary.Damage = 11
SWEP.Primary.Delay = 0.055
SWEP.Primary.Cone = 0.1 -- 0.067
SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.AutoSpawnable      = true
SWEP.Primary.Recoil			= 1.9
SWEP.Primary.Sound			= Sound("Weapon_m249.Single")
SWEP.ViewModel			= "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos 		= Vector( -4.4, -3, 2 )

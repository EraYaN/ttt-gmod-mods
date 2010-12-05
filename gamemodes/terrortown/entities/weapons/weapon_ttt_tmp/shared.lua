if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if CLIENT then

   SWEP.PrintName = "Steyr TMP"			
   SWEP.Slot = 2

   SWEP.Icon = "VGUI/ttt/icon_ninjah_tmp"
end


SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Damage      = 12
SWEP.Primary.Delay       = 0.050
SWEP.Primary.Cone        = 0.025
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 0.95
SWEP.Primary.Sound       = Sound( "Weapon_tmp.Single" )

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModel  = "models/weapons/v_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"

SWEP.HeadshotMultiplier = 2

SWEP.IronSightsPos = Vector( 6.62, -3, 2.9 )
SWEP.IronSightsAng = Vector( 0.7, 5.3, 7 )

SWEP.DeploySpeed = 3

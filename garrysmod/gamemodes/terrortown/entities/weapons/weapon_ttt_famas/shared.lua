if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/vgui/ttt/icon_bb_famas.vmt")
end

SWEP.HoldType = "ar2"

if CLIENT then

   SWEP.PrintName = "FAMAS G1"			
   SWEP.Slot = 2

   SWEP.Icon = "vgui/ttt/icon_bb_famas"
   SWEP.ViewModelFOV  = 72
   SWEP.ViewModelFlip = false
end


SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Damage      = 15
SWEP.Primary.Delay       = 0.07
SWEP.Primary.Cone        = 0.025
SWEP.Primary.ClipSize    = 25
SWEP.Primary.ClipMax     = 75
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "CombineCannon"
SWEP.Primary.Recoil      = 1.018
SWEP.Primary.Sound       = Sound( "Weapon_famas.Single" )

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_rifle_ttt"

SWEP.ViewModel  = "models/weapons/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"

SWEP.HeadshotMultiplier = 2

SWEP.IronSightsPos = Vector (-2.9917, -7.5747, 2.4776)
SWEP.IronSightsAng = Vector (0.9064, 0.4293, 3.6684)

SWEP.DeploySpeed = 2.2

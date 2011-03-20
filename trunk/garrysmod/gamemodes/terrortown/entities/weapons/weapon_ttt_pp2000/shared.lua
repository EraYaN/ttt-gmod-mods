if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_tuna_pp2000.vmt")
   resource.AddFile("models/weapons/v_smg_pp2000.mdl")
   resource.AddFile("models/weapons/w_smg_pp2000.mdl")
   resource.AddFile("materials/models/weapons/v_models/v_smg_pp2000/pbs1soundsupressorjpeg.vmt")
   resource.AddFile("materials/models/weapons/v_models/v_smg_pp2000/PP2000_1.vmt")
   resource.AddFile("materials/models/weapons/v_models/v_smg_pp2000/PP2000_2.vmt")
   resource.AddFile("sound/weapons/pp2000/pp2000_bolt.wav")
   resource.AddFile("sound/weapons/pp2000/pp2000_clipin.wav")
   resource.AddFile("sound/weapons/pp2000/pp2000_clipout.wav")
   resource.AddFile("sound/weapons/pp2000/pp2000_deploy.wav")
   resource.AddFile("sound/weapons/pp2000/pp2000-1.wav")
end

SWEP.HoldType = "pistol"

if CLIENT then

   SWEP.PrintName = "KBP PP-2000"			
   SWEP.Slot = 2

   SWEP.Icon = "VGUI/ttt/icon_tuna_pp2000"
end


SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Damage      = 15
SWEP.Primary.Delay       = 0.09
SWEP.Primary.Cone        = 0.022
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.0
SWEP.Primary.Sound       = Sound( "weapons/pp2000/pp2000-1.wav" )

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModel  = "models/weapons/v_smg_pp2000.mdl"
SWEP.WorldModel = "models/weapons/w_smg_pp2000.mdl"

SWEP.HeadshotMultiplier = 2.5

SWEP.IronSightsPos = Vector (5.2438, -6.792, 2.5232)
SWEP.IronSightsAng = Vector (0.8378, 0.0285, 0.2531)

SWEP.DeploySpeed = 3
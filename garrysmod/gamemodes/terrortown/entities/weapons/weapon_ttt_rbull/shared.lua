-- Taurus Raging Bull

if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile("materials/VGUI/ttt/icon_bb_rbull.vmt")
	resource.AddFile("models/weapons/v_revl_raging.mdl")
	resource.AddFile("models/weapons/w_revl_raging.mdl")
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\barrel.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\barrel.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\body.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\body.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\bullet.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_revl_raging\bullet.vtf" )
	resource.AddFile("sound\weapons\ragingbull\bulldraw.wav")
	resource.AddFile("sound\weapons\ragingbull\bullreload.wav")
	resource.AddFile("sound\weapons\ragingbull\revolver.wav")
	resource.AddFile("scripts/sounds/ragingbull.txt")
end
	
SWEP.HoldType			= "pistol"

if CLIENT then
	SWEP.PrintName			= "Taurus Raging Bull"			
	SWEP.Author				= "EraYaN"

	SWEP.Slot				= 1
	SWEP.SlotPos			= 1

	SWEP.Icon = "VGUI/ttt/icon_bb_rbull"
end

SWEP.Base				= "weapon_tttbase"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Ammo		 = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage = 45
SWEP.Primary.Delay = 0.7
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 36
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = true

SWEP.HeadshotMultiplier = 4.5

SWEP.AutoSpawnable		= true
SWEP.AmmoEnt = "item_ammo_revolver_ttt"
SWEP.Primary.Sound			= Sound( "weapons/ragingbull/revolver.wav" )
SWEP.ViewModel			= "models/weapons/v_revl_raging.mdl"
SWEP.WorldModel			= "models/weapons/w_revl_raging.mdl"

SWEP.IronSightsPos = Vector(2.8,-1.8,0.80)
SWEP.IronSightsAng = Vector(.3,0,0)

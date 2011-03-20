if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight = 5
	resource.AddFile( "models/weapons/v_mp7_silenced.mdl" )
	resource.AddFile( "models/weapons/w_mp7_silenced.mdl" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/aim0py.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/bolt.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/flashhideb.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/main.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/map2.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sights_down.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sila.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/aim0py.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/bolt.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/flashhideb.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/main.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/map2.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/sights_down.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/sila.vmt" )
	resource.AddFile( "materials/VGUI/entities/weapon_bd_mp7.vmt" )
	resource.AddFile( "materials/VGUI/entities/weapon_bd_mp7.vtf" )
	resource.AddFile( "materials/weapons/weapon_bd_mp7.vmt" )
	resource.AddFile( "materials/weapons/weapon_bd_mp7.vtf" )
	resource.AddFile( "sound/weapons/mp7/mp7_reload.wav" )
	resource.AddFile( "sound/weapons/mp7/mp7_fire.wav" )
end

if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.PrintName			= "MP-7"
	SWEP.Slot 				= 2
	SWEP.BounceWeaponIcon   = false	
	SWEP.WepSelectIcon		= surface.GetTextureID("weapons/weapon_bd_mp7")
	SWEP.Icon = "VGUI/ttt/icon_tuna_mp7"
	killicon.Add("weapon_bd_mp7","weapons/weapon_bd_mp7",Color(255,255,255))	
end
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_HEAVY
SWEP.Author 			= "Baddog"	
SWEP.Instructions 		= "Left click to shoot.\nRight click to use the scope.\nHold USE and right click to switch between normal and dissolving bullets.\nHold USE and left click to toggle the laser sight."
SWEP.Category			= "Baddog's Weapons"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel      = "models/weapons/v_mp7_silenced.mdl"
SWEP.WorldModel   	= "models/weapons/w_mp7_silenced.mdl"
SWEP.HoldType 		= "ar2"

SWEP.SprintPos 			= Vector(-3.1731, -5.3573, 1.4608)
SWEP.SprintAng 			= Vector(-18.7139, -48.1596, 0)
SWEP.ScopePos 			= Vector(3, -20, 1.5)
SWEP.ScopeAng 			= Vector(0, 0, 0)

SWEP.ZoomModes 			= { 0, 40 }
SWEP.ZoomSpeeds 		= { 0.25, 0.40 }

SWEP.Primary.Sound			= Sound("weapons/mp7/mp7_fire.wav")
SWEP.Primary.Recoil			= .4
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.025
SWEP.Primary.Rpm 			= 500
SWEP.Primary.Delay			= 0.002

SWEP.Primary.ClipSize		= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Ammo			= "smg1"

SWEP.LastRunFrame = 0
SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.HeadshotMultiplier = 2

function SWEP:Holster()
	return true
end

function SWEP:AdjustMouseSensitivity()
	local num = self.Weapon:GetNWInt("Mode",1)
	local scale = self.ZoomModes[num] / 100
	if scale == 0 then
		return nil
	end
	return scale
end

function SWEP:CanSecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.LastRunFrame > CurTime() then return false end
	if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_LEFT) or self.Owner:KeyDown(IN_RIGHT) or self.Weapon:Clip1() <= 0 then
		if self.Weapon:GetZoomMode() != 1 and SERVER then
			self.Weapon:SetZoomMode(1)
			self.Weapon:SetNWBool("ReverseAnim",true)
			self.Weapon:SetViewModelPosition(self.ScopePos,self.ScopeAng,0.3)
		end
		return false
	end
	return true
end

function SWEP:CanPrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.LastRunFrame > CurTime() then return false end
	if self.Weapon:Clip1() <= 0 then
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )		
		if self.Weapon:GetZoomMode() != 1 and SERVER then
			self.Weapon:SetZoomMode(1)
			self.Weapon:SetNWBool("ReverseAnim",true)
			self.Weapon:SetViewModelPosition(self.ScopePos,self.ScopeAng,0.3)
		end	
		return false
	end
	return true
end

function SWEP:IdleViewModelPos( movetime, duration, mul )
	mul = 1
	if ( CurTime() - movetime < duration ) then
		mul = math.Clamp( (CurTime() - duration) / movetime, 0, 1 )
	end
	if self.Weapon:GetNWBool("ReverseAnim",false) then
		return 1 - mul
	end
	return mul
end

function SWEP:AngApproach( newang, ang, mul )
	ang:RotateAroundAxis( ang:Right(), 		newang.x * mul )
	ang:RotateAroundAxis( ang:Up(), 		newang.y * mul )
	ang:RotateAroundAxis( ang:Forward(), 	newang.z * mul )
	return ang
end

function SWEP:PosApproach( newpos, pos, ang, mul ) 
	local right 	= ang:Right()
	local up 		= ang:Up()
	local forward 	= ang:Forward()
	pos = pos + newpos.x * right * mul
	pos = pos + newpos.y * forward * mul
	pos = pos + newpos.z * up * mul
	return pos
end

function SWEP:MoveViewModelTo( newpos, newang, pos, ang, mul )
	ang = self:AngApproach( newang, ang, mul )
	pos = self:PosApproach( newpos, pos, ang, mul )
	return pos, ang
end


local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE
}

function SWEP:SetWeaponHoldType( t )
	local index = ActIndex[ t ]
	if (index == nil) then
		Msg( "SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set! (defaulting to normal)\n" )
		t = "normal"
	end
	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end
	if t == "passive" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_CROUCH_IDLE
	end
	if t == "knife" || t == "melee2" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = nil
	end
	self:SetupWeaponHoldTypeForAI( t )
	self._InternalHoldType = t
endw


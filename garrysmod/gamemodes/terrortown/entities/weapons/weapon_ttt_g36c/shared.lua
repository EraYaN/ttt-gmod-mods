if (SERVER) then
	AddCSLuaFile("shared.lua")
    SWEP.Weight = 5
end
resource.AddFile( "models/weapons/v_g36c.mdl" )
resource.AddFile( "models/weapons/w_g36c.mdl" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/ACOG.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/ACOG.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/ACOG_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_grip.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Grip.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Grip_NO_Rails.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Grip_NO_Rails.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Grip_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_rail.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Rail.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Rail_NO_ACOG.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Rail_NO_ACOG.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/C_Rail_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/cmag.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/cmag.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/cmag_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/frame.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Frame.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Frame_inverted.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Frame_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Frame_Normal_invert.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Mag.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Mag.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Mag_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Silencer.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Silencer.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Silencer_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Stock.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Stock.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Stock_inverted.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Stock_Normal.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Stock_Normal_invert.vtf" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Trit.vmt" )
resource.AddFile( "materials/models/weapons/v_models/TheLama.Thanez_G36c/Trit.vtf" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/ACOG.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/C_grip.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/C_Grip_NO_Rails.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/C_rail.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/C_Rail_NO_ACOG.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/cmag.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/frame.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/Mag.vmt" )
resource.AddFile( "materials/models/weapons/w_models/TheLama.Thanez_G36c/Stock.vmt" )
resource.AddFile( "materials/VGUI/entities/weapon_bd_g36c.vmt" )
resource.AddFile( "materials/VGUI/entities/weapon_bd_g36c.vtf" )
resource.AddFile( "materials/weapons/weapon_bd_g36c.vmt" )
resource.AddFile( "materials/weapons/weapon_bd_g36c.vtf" )
resource.AddFile( "sound/weapons/g36c/g36c_draw.wav" )
resource.AddFile( "sound/weapons/g36c/g36c_fire.wav" )
resource.AddFile( "sound/weapons/g36c/g36c_reload.wav" )
if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.PrintName			= "G36C"
	SWEP.Slot 				= 3
	SWEP.BounceWeaponIcon   = false	
	SWEP.WepSelectIcon		= surface.GetTextureID("weapons/weapon_bd_g36c")
	killicon.Add("weapon_bd_g36c","weapons/weapon_bd_g36c",Color(255,255,255))	
	SWEP.ViewModelFOV  = 90
	SWEP.ViewModelFlip = true
	SWEP.Icon = "VGUI/ttt/icon_tuna_g36c"
end
-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"

SWEP.Author 			= "Baddog"	
SWEP.Instructions 		= "Left click to shoot.\nRight click to use the scope.\nHold USE and right click to switch between automatic and semi-automatic."
SWEP.Category			= "Baddog's Weapons"

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true

SWEP.ViewModel      = "models/weapons/v_g36c.mdl"
SWEP.WorldModel   	= "models/weapons/w_g36c.mdl"
SWEP.HoldType 		= "ar2"

SWEP.SprintPos 			= Vector(-3.1731, -5.3573, 1.4608)
SWEP.SprintAng 			= Vector(-18.7139, -48.1596, 0)
SWEP.ScopePos 			= Vector(3, -20, 1.5)
SWEP.ScopeAng 			= Vector(0, 0, 0)

SWEP.ZoomModes 			= { 0, 45 }
SWEP.ZoomSpeeds 		= { 0.25, 0.40 }

SWEP.Primary.Sound			= Sound("weapons/g36c/g36c_fire.wav")
SWEP.Primary.Recoil			= .8
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Rpm 			= 400
SWEP.Primary.Delay			= 1/400

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Ammo			= "CombineCannon"

SWEP.Secondary.Sound        = Sound( "weapons/sniper/sniper_zoomout.wav" )
SWEP.Secondary.Delay  		= 0.5
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.LastRunFrame = 0
SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_rifle_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false


function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
end

function SWEP:Deploy()
	if SERVER then
		self.Weapon:SetViewModelPosition()
		self.Weapon:SetZoomMode(1)
	end	
self.Weapon:EmitSound("weapons/g36c/g36c_draw.wav")
self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:PrimaryAttack()
	if not self.Weapon:CanPrimaryAttack() then return end
	self.Weapon:SetNextPrimaryFire( CurTime() + (60/self.Primary.Rpm) )
	self.Weapon:EmitSound( self.Primary.Sound, 100, math.random(95,105) )
	self.Weapon:ShootBullets( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone, 1)
	self.Weapon:TakePrimaryAmmo( 1 )
end

function SWEP:ShootBullets( damage, recoil, numbullets, aimcone, numtracer )
	local scale = aimcone
	local ducking = self.Owner:KeyDown(IN_DUCK)
	local moveing = [[self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT)]]
	local zooming = [[self.Weapon:GetZoomMode() == 1]]
	local semiautomatic = [[self.Primary.Automatic == false ]]
	if not moving and not ducking and not zooming and not semiautomatic then
	scale = aimcone * 2.5
	elseif moving and not ducking and not zooming and not semiautomatic then
	scale = aimcone * 4
	elseif moving and not ducking and zooming and not semiautomatic then
	scale = aimcone * 3
	elseif moving and ducking and not zooming and not semiautomatic then
	scale = aimcone * 2
	elseif moving and ducking and zooming and not semiautomatic then
	scale = aimcone * 1.5
	elseif not moving and not ducking and zooming and not semiautomatic then
	scale = aimcone * 1.25
	elseif not moving and ducking and not zooming and not semiautomatic then
	scale = aimcone * .75
	elseif not moving and ducking and zooming and not semiautomatic then
	scale = aimcone * .25
	elseif not moving and not ducking and not zooming and semiautomatic then
	scale = aimcone * 2.125
	elseif moving and not ducking and not zooming and semiautomatic then
	scale = aimcone * 3.4
	elseif moving and not ducking and zooming and semiautomatic then
	scale = aimcone * 2.55
	elseif moving and ducking and not zooming and semiautomatic then
	scale = aimcone * 1.7
	elseif moving and ducking and zooming and semiautomatic then
	scale = aimcone * 1.275
	elseif not moving and not ducking and zooming and semiautomatic then
	scale = aimcone * 1.0625
	elseif not moving and ducking and not zooming and semiautomatic then
	scale = aimcone * .6375
	elseif not moving and ducking and zooming and semiautomatic then
	scale = aimcone * .2125
	end
	
	local bullet = {}
	bullet.Num 			= numbullets
	bullet.Src 			= self.Owner:GetShootPos()			
	bullet.Dir 			= self.Owner:GetAimVector()			
	bullet.Spread 		= Vector( scale, scale, 0 )		
	bullet.Tracer		= 1
	bullet.Force		= 20							
	bullet.Damage		= math.Round(damage)
	bullet.AmmoType		= "CombineCannon"
	bullet.TracerName	= "Tracer"
		
bullet.Callback = function(att, tr, dmginfo)
end
	
	self.Owner:FireBullets( bullet )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil
		self.Owner:SetEyeAngles( eyeang )
end

function SWEP:Think()		
	if self.Owner:KeyDown(IN_SPEED) then
				self:SetWeaponHoldType("passive")
	else
			self:SetWeaponHoldType(self.HoldType)
	end
	if self.Owner:KeyDown(IN_SPEED) then
		self.LastRunFrame = CurTime() + 0.3
		if self.Weapon:GetZoomMode() != 1 and SERVER then
			self.Weapon:SetZoomMode(1)
			self.Weapon:SetNWBool("ReverseAnim",true)
			self.Weapon:SetViewModelPosition(self.ScopePos,self.ScopeAng,0.3)
		end
	end
	if self.MoveTime and self.MoveTime < CurTime() and SERVER then
		self.MoveTime = nil
		self.Weapon:SetZoomMode( self.Weapon:GetZoomMode() + 1 )
	end
end

function SWEP:DrawHUD()
	local mode = self.Weapon:GetNWInt( "Mode", 1 )
	if mode != 1 then
		local w = ScrW()
		local h = ScrH()
		local wr = ( h / 3 ) * 4
		surface.SetTexture( surface.GetTextureID( "gmod/scope" ) )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawTexturedRect( ( w / 2 ) - wr / 2, 0, wr, h )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, ( w / 2 ) - wr / 2, h )
		surface.DrawRect( ( w / 2 ) + wr / 2, 0, w - ( ( w / 2 ) + wr / 2 ), h )
		surface.DrawLine( 0, h * 0.50, w, h * 0.50 )
		surface.DrawLine( w * 0.50, 0, w * 0.50, h )
	end
end

function SWEP:SetZoomMode( num )
	if num > #self.ZoomModes then
		num = 1
		self.Weapon:SetNWBool("ReverseAnim",true)
		self.Weapon:SetViewModelPosition(self.ScopePos,self.ScopeAng,0.3)
	end
	self.Weapon:SetNWInt("Mode",num)
	self.Owner:SetFOV(self.ZoomModes[num],self.ZoomSpeeds[num])
end

function SWEP:GetZoomMode()
	return self.Weapon:GetNWInt("Mode",1)
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_USE) then
    if self.Primary.Automatic == false then
        self.Primary.Automatic = true
        self.Owner:PrintMessage( HUD_PRINTCENTER, "Automatic" )
		self.Weapon:EmitSound ("weapons/smg1/switch_single.wav")
    else
        self.Primary.Automatic = false
        self.Owner:PrintMessage( HUD_PRINTCENTER, "Semi-Automatic" )
		self.Weapon:EmitSound ("weapons/smg1/switch_single.wav")
    end 
	end
	
	if not self.Owner:KeyDown(IN_USE) then
		if not self.Weapon:CanSecondaryAttack() then return end
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
		if SERVER then
			if self.Weapon:GetZoomMode() == 1 then
				self.Weapon:SetNWBool("ReverseAnim",false)
				self.Weapon:SetViewModelPosition(self.ScopePos, self.ScopeAng, 0.3)
				self.MoveTime = CurTime() + 0.35
			else
				self.Weapon:SetZoomMode( self.Weapon:GetZoomMode() + 1 )
			end
		end
		self.Weapon:EmitSound( self.Secondary.Sound )
	end
end

function SWEP:AdjustMouseSensitivity()
	local num = self.Weapon:GetNWInt("Mode",1)
	local scale = self.ZoomModes[num] / 100
	if scale == 0 then
		return nil
	end
	return scale
end

function SWEP:Reload()
	if ( self:Ammo1() <= 0 ) then return end
	if ( self.Weapon:Clip1() <= 0 ) and ( self:Ammo1() <= 0 ) then return end
	if self.Weapon:Clip1() == self.Primary.ClipSize then return end
	if self.Weapon:GetZoomMode() != 1 and SERVER then
		self.Weapon:SetZoomMode(1)
		self.Weapon:SetNWBool("ReverseAnim",true)
		self.Weapon:SetViewModelPosition(self.ScopePos,self.ScopeAng,0.3)
	end	
	self.Weapon:DefaultReload( ACT_VM_RELOAD )
	self.Weapon:EmitSound("weapons/g36c/g36c_reload.wav")
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

function SWEP:SetViewModelPosition( vec, ang, movetime )
	self.Weapon:SetNWVector("ViewVector",vec)
	self.Weapon:SetNWVector("ViewAngle",ang)
	self.Weapon:SetNWInt("ViewDuration",movetime) 
	self.Weapon:SetNWInt("ViewTime",CurTime())
end

function SWEP:GetViewModelPosition( pos, ang )
	local newpos = self.Weapon:GetNWVector("ViewVector",nil)
	local newang = self.Weapon:GetNWVector("ViewAngle",nil)
	local movetime = self.Weapon:GetNWInt("ViewDuration",0.25)
	local duration = self.Weapon:GetNWInt("ViewTime",0)
	if ( !newpos || !newang ) then
		newpos = pos
		newang = ang
	end
	local mul = 0
	if self.Owner:KeyDown( IN_SPEED ) then
		self.SwayScale 	= 1.25
		self.BobScale 	= 1.25
		if (!self.SprintStart) then
			self.SprintStart = CurTime()
		end
		mul = math.Clamp( (CurTime() - self.SprintStart) / movetime, 0, 1 )
		newang = self.SprintAng
		newpos = self.SprintPos
	else 
		self.SwayScale 	= 1.0
		self.BobScale 	= 1.0
		if ( self.SprintStart ) then
			self.SprintEnd = CurTime()
			self.SprintStart = nil
		end
		if ( self.SprintEnd ) then
			mul = 1 - math.Clamp( (CurTime() - self.SprintEnd) / movetime, 0, 1 )
			newang = self.SprintAng
			newpos = self.SprintPos
			if ( mul == 0 ) then
				self.SprintEnd = nil 
			end
		else
			mul = self:IdleViewModelPos( movetime, duration, mul )
		end
	end
	return self:MoveViewModelTo( newpos, newang, pos, ang, mul )
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
end

function SWEP:TranslateActivity( act )
	if ( self.Owner:IsNPC() ) then
		if ( self.ActivityTranslateAI[ act ] ) then
			return self.ActivityTranslateAI[ act ]
		end
		return -1
	end
	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end
	return -1
end
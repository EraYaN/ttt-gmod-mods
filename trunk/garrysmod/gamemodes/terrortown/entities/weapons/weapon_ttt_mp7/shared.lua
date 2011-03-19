if (SERVER) then
	AddCSLuaFile("shared.lua")
SWEP.Weight = 5
end
resource.AddFile( "models/weapons/v_mp7_silenced.mdl" )
resource.AddFile( "models/weapons/w_mp7_silenced.mdl" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/aim0py.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/aim0py.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/aim0py_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/bolt.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/bolt.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/bolt_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/flashhideb.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/flashhideb.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/flashhideb_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/main.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/main.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/main_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/map2.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/map2.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/map2_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sights_down.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sights_down.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sights_down_ref.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sila.vmt" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sila.vtf" )
resource.AddFile( "materials/models/weapons/v_models/schmung_mp7/sila_ref.vtf" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/aim0py.vmt" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/bolt.vmt" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/flashhideb.vmt" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/main.vmt" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/map2.vmt" )
resource.AddFile( "materials/models/weapons/w_models/schmung_mp7/sights_down.vmt" )
resource.AddFile( "materials/VGUI/entities/weapon_bd_mp7.vmt" )
resource.AddFile( "materials/VGUI/entities/weapon_bd_mp7.vtf" )
resource.AddFile( "materials/weapons/weapon_bd_mp7.vmt" )
resource.AddFile( "materials/weapons/weapon_bd_mp7.vtf" )
resource.AddFile( "sound/weapons/mp7/mp7_reload.wav" )
resource.AddFile( "sound/weapons/mp7/mp7_fire.wav" )
if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
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

SWEP.ZoomModes 			= { 0, 20 }
SWEP.ZoomSpeeds 		= { 0.25, 0.40 }

SWEP.Primary.Sound			= Sound("weapons/mp7/mp7_fire.wav")
SWEP.Primary.Recoil			= .4
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.025
SWEP.Primary.Rpm 			= 950

SWEP.Primary.ClipSize		= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.Sound        = Sound( "weapons/sniper/sniper_zoomout.wav" )
SWEP.Secondary.Delay  		= 0.5
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.LastRunFrame = 0
SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.HeadshotMultiplier = 2

function SWEP:Holster()
	return true
end

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
changebullettype = 0
changelaser	= 0
end

function SWEP:Deploy()
	if SERVER then
		self.Weapon:SetViewModelPosition()
		self.Weapon:SetZoomMode(1)
	end	
self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_USE) then
		if self.Weapon:GetNetworkedBool("IsLaserToggleOn") and CurTime() > changelaser then
			changelaser = CurTime() + 0.5
			self.Weapon:SetNWBool( "IsLaserToggleOn", false )
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Laser Off" )
			self.Weapon:EmitSound ("items/nvg_off.wav")
		elseif not self.Weapon:GetNetworkedBool("IsLaserToggleOn") and CurTime() > changelaser then
			changelaser = CurTime() + 0.5
			self.Weapon:SetNWBool( "IsLaserToggleOn", true )
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Laser On" )
			self.Weapon:EmitSound ("items/nvg_on.wav")
		end
	end
if not self.Owner:KeyDown(IN_USE) then
	if not self.Weapon:CanPrimaryAttack() then return end
	self.Weapon:SetNextPrimaryFire( CurTime() + (60/self.Primary.Rpm) )
	self.Weapon:EmitSound( self.Primary.Sound, 100, math.random(95,105) )
	self.Weapon:ShootBullets( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone, 1)
	self.Weapon:TakePrimaryAmmo( 1 )
end
end

function SWEP:ShootBullets( damage, recoil, numbullets, aimcone, numtracer )
	local scale = aimcone
	local ducking = self.Owner:KeyDown(IN_DUCK)
	local moveing = [[self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT)]]
	local zooming = [[self.Weapon:GetZoomMode() == 1]]
	local laseron = [[self.Weapon:GetNWBool( "IsLaserOn", true)]]
	if not moving and not ducking and not zooming and not laseron then
	scale = aimcone * 2.5
	elseif moving and not ducking and not zooming and not laseron then
	scale = aimcone * 4
	elseif moving and not ducking and zooming and not laseron then
	scale = aimcone * 3
	elseif moving and ducking and not zooming and not laseron then
	scale = aimcone * 2
	elseif moving and ducking and zooming and not laseron then
	scale = aimcone * 1.5
	elseif not moving and not ducking and zooming and not laseron then
	scale = aimcone * 1.25
	elseif not moving and ducking and not zooming and not laseron then
	scale = aimcone * .75
	elseif not moving and ducking and zooming and not laseron then
	scale = aimcone * .25
	elseif not moving and not ducking and not zooming and laseron then
	scale = aimcone * 2.125
	elseif moving and not ducking and not zooming and laseron then
	scale = aimcone * 3.4
	elseif moving and not ducking and zooming and laseron then
	scale = aimcone * 2.55
	elseif moving and ducking and not zooming and laseron then
	scale = aimcone * 1.7
	elseif moving and ducking and zooming and laseron then
	scale = aimcone * 1.275
	elseif not moving and not ducking and zooming and laseron then
	scale = aimcone * 1.0625
	elseif not moving and ducking and not zooming and laseron then
	scale = aimcone * .6375
	elseif not moving and ducking and zooming and laseron then
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
	
		if self.Weapon:GetNetworkedBool("Dissolve") then
		bullet.AmmoType 	= "AR2AltFire"
		bullet.TracerName	= "Ar2Tracer"
		else
		bullet.AmmoType		= "pistol"
		bullet.TracerName	= "Tracer"
		end
		
bullet.Callback = function(att, tr, dmginfo)
	if self.Weapon:GetNetworkedBool("Dissolve") then

	local eff = EffectData()
	eff:SetOrigin(tr.HitPos)
	eff:SetNormal(tr.HitNormal)
	util.Effect("cball_bounce", eff)
	util.Effect("AR2Impact", eff)

		if SERVER or (CLIENT and IsFirstTimePredicted()) then
		local ent = tr.Entity
			if (not tr.HitWorld) and IsValid(ent) then
			local edata = EffectData()
			edata:SetEntity(ent)
			edata:SetMagnitude(20)
			edata:SetScale(20)
			util.Effect("TeslaHitBoxes", edata)
			end
		end
	else	
	end
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
if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
self.Weapon:SetNetworkedBool("Reloading", false)
end

	if self.Weapon:GetNetworkedBool("IsLaserToggleOn") and not self.Owner:KeyDown(IN_SPEED) then
		if IsFirstTimePredicted() then
        self.Weapon:SetNWBool( "IsLaserOn", true )
		end
	elseif self.Weapon:GetNetworkedBool("IsLaserToggleOn") and self.Owner:KeyDown(IN_SPEED) then
		if IsFirstTimePredicted() then
        self.Weapon:SetNWBool( "IsLaserOn", false )
		end
	end
	if not self.Weapon:GetNetworkedBool("IsLaserToggleOn") then
		if IsFirstTimePredicted() then
        self.Weapon:SetNWBool( "IsLaserOn", false )
		end
	end
	
	if self.Weapon:GetNetworkedBool("Reloading") then
	self.Weapon:SetNWBool( "IsLaserOn", false )
	end
	
	
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
	if self.Owner:KeyDown(IN_USE) and self.Owner:IsAdmin() then
		if self.Weapon:GetNetworkedBool("Dissolve") and CurTime() > changebullettype then
			changebullettype = CurTime() + 0.5
			self.Weapon:SetNWBool("Dissolve",false)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Normal Bullets Active" )
			self.Weapon:EmitSound ("weapons/smg1/switch_single.wav")
		elseif not self.Weapon:GetNetworkedBool("Dissolve") and CurTime() > changebullettype then
			changebullettype = CurTime() + 0.5
			self.Weapon:SetNWBool("Dissolve",true)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Dissolving Bullets Active" )
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
	self.Weapon:EmitSound("weapons/mp7/mp7_reload.wav")
	self.Weapon:SetNetworkedBool("Reloading", true)
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

if CLIENT then

    local LaserDot = Material( "Sprites/light_glow02_add" )
    local LaserBeam = Material( "trails/laser" )

    local function GetTracerShootPos( ply, ent, attach )
        if !IsValid( ent ) then return false end
        if !ent:IsWeapon() then return false end
        
        local pos = false

        if ent:IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then    
            local ViewModel = LocalPlayer():GetViewModel()
            if IsValid( ViewModel ) then
                local att = ViewModel:GetAttachment( attach )
                if att then
                    pos = att.Pos
                end
            end
        else
            local att = ent:GetAttachment( attach )
            if att then
                pos = att.Pos
            end
        end

        return pos
    end

    hook.Add( "RenderScreenspaceEffects", "LASERPOINTER.RenderScreenspaceEffects", function()
        for k,v in ipairs( player.GetAll() ) do
            local weap = v:GetActiveWeapon()
            
            if IsValid( weap ) and weap:GetNWBool( "IsLaserOn", false ) then
                cam.Start3D( EyePos(), EyeAngles() )
                    local shootpos = v:GetShootPos()
                    local ang = v:GetAimVector()
                    
                    local tr = {}
                    tr.start = shootpos
                    tr.endpos = shootpos + ( ang * 999999 )
                    tr.filter = v
                    tr.mask = MASK_SHOT
                    
                    local trace = util.TraceLine( tr )
                    local Size = 4 + ( math.random() * 10 )
                    local beamstartpos = GetTracerShootPos( v, weap, 1 )
                    local beamendpos = trace.HitPos
                    
                    if beamstartpos then
                        local Distance = beamstartpos:Distance( beamendpos )
                        render.SetMaterial( LaserBeam )
                        render.DrawBeam( beamstartpos, beamendpos, 4, 1, 0, Color(255, 0, 0, 255)  )
                    end
                    
                    render.SetMaterial( LaserDot )
                    render.DrawQuadEasy( beamendpos + trace.HitNormal * 0.5, trace.HitNormal, Size, Size, Color(255, 0, 0, 255) , 0 )
                    render.DrawQuadEasy( beamendpos + trace.HitNormal * 0.5, trace.HitNormal * -1, Size, Size, Color(255, 0, 0, 255) , 0 )
                    
                cam.End3D()
            end
        end
    end )
elseif SERVER then

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
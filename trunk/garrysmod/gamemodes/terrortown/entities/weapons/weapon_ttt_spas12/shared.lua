-- Franchi SPAS-12
if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile("materials/VGUI/ttt/icon_bb_spas12.vmt")
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\barrels.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\barrels.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\barrels_normal.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\base.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\base.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\base_normal.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\extra_shells.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\extra_shells.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\forefrip.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\foregrip.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\foregrip_normal.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\handle.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\handle.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\handle_normal.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\heatshield.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\heatshield.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\heatshield_ref.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\stock_flap.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\stock_flap.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\stock_flap_ref.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\string.vmt" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\string.vtf" )
	resource.AddFile( "materials\models\weapons\v_models\v_shot_spas12\string_normal.vtf" )
	resource.AddFile("models/weapons/v_shot_spas12.mdl")
	resource.AddFile("models/weapons/w_shot_spas12.mdl")
	resource.AddFile("sound/weapons/spas12/spas12_cock.wav")
	resource.AddFile("sound/weapons/spas12/spas12_insertshell.wav")
	resource.AddFile("sound/weapons/spas12/spas12-1.wav")
	resource.AddFile("scripts/sounds/spas12.txt")
end

SWEP.HoldType			= "shotgun"

if CLIENT then
	SWEP.PrintName			= "Franchi SPAS-12"			
	SWEP.Author				= "NinjaTuna"
	SWEP.Slot				= 2
 
	SWEP.Icon = "VGUI/ttt/icon_bb_spas12"
end


SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Damage = 7.5
SWEP.Primary.Cone = 0.07
SWEP.Primary.Delay = 0.5
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 15
SWEP.AutoSpawnable		= true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.ViewModel			= "models/weapons/v_shot_spas12.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_spas12.mdl"
SWEP.Primary.Sound			= Sound( "weapons/spas12/spas12-1.wav" )
SWEP.Primary.Recoil			= 8

SWEP.IronSightsPos = Vector (2.0727, 0, -1.0603)
SWEP.IronSightsAng = Vector (7.6132, -0.232, 0)

SWEP.reloadtimer = 0

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "reloading")

	return self.BaseClass.SetupDataTables(self)
end

function SWEP:Reload()
	self:SetIronsights( false )
	
	--if self.Weapon:GetNetworkedBool( "reloading", false ) then return end
	if self.dt.reloading then return end

	if not IsFirstTimePredicted() then return end
	
	if self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
		
		if self:StartReload() then
			return
		end
	end

end

function SWEP:StartReload()
	--if self.Weapon:GetNWBool( "reloading", false ) then
	if self.dt.reloading then
		return false
	end

	if not IsFirstTimePredicted() then return false end

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	local ply = self.Owner
	
	if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then 
		return false
	end

	local wep = self.Weapon
	
	if wep:Clip1() >= self.Primary.ClipSize then 
		return false 
	end

	wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

	self.reloadtimer =  CurTime() + wep:SequenceDuration()

	--wep:SetNWBool("reloading", true)
	self.dt.reloading = true

	return true
end

function SWEP:PerformReload()
	local ply = self.Owner
	
	-- prevent normal shooting in between reloads
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

	local wep = self.Weapon

	if wep:Clip1() >= self.Primary.ClipSize then return end

	self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
	self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )

	wep:SendWeaponAnim(ACT_VM_RELOAD)

	self.reloadtimer = CurTime() + wep:SequenceDuration()
end

function SWEP:FinishReload()
	self.dt.reloading = false
	self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	
	self.reloadtimer = CurTime() + self.Weapon:SequenceDuration()
end

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound( "Weapon_Shotgun.Empty" )
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		return false
	end
	return true
end

function SWEP:Think()
	if self.dt.reloading and IsFirstTimePredicted() then
		
		if self.Owner:KeyDown(IN_ATTACK) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self:FinishReload()
			return
		end
		
		if self.reloadtimer <= CurTime() then

			if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
				self:FinishReload()
			elseif self.Weapon:Clip1() < self.Primary.ClipSize then
				self:PerformReload()
			else
				self:FinishReload()
			end
			return				
		end
	end
end

function SWEP:Deploy()
	self.dt.reloading = false
	self.reloadtimer = 0
	return self.BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
	local att = dmginfo:GetAttacker()
	if not ValidEntity(att) then return 3 end

	local dist = victim:GetPos():Distance(att:GetPos())
	local d = math.max(0, dist - 140)
	
	-- decay from 3.5 to 1 slowly as distance increases
	return 1 + math.max(0, (2.5 - 0.002 * (d ^ 1.25)))
end


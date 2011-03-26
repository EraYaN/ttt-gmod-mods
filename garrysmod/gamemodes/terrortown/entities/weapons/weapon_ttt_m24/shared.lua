--Remington M24

if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile("materials/VGUI/ttt/icon_tuna_m24.vmt")
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/bipod.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/bipod.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/C3A1_2.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/C3A1_2.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/C3A1_2_normal.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/Gucci copy.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M24(2).vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M24(2).vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M24(2)_normal.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M241.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M241.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/M241_normal.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/silencer.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/silencer_normal.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/UV1.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/UV1_original.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_snip_m24/UV1_ref.vtf" )
	resource.AddFile("models/weapons/v_snip_m24.mdl")
	resource.AddFile("models/weapons/w_snip_m24.mdl")
	resource.AddFile("sound/weapons/m24/m24_bolt.wav")
	resource.AddFile("sound/weapons/m24/m24_boltback.wav")
	resource.AddFile("sound/weapons/m24/m24_boltforward.wav")
	resource.AddFile("sound/weapons/m24/m24_clipin.wav")
	resource.AddFile("sound/weapons/m24/m24_clipout.wav")
	resource.AddFile("sound/weapons/m24/m24_cliptap.wav")
	resource.AddFile("sound/weapons/m24/m24_fire-1.wav")
	resource.AddFile("scripts/sounds/m24.txt")
end

SWEP.HoldType			  = "ar2"

if CLIENT then
	SWEP.PrintName			 = "Remington M24"

	SWEP.Slot					= 2

	SWEP.Icon = "VGUI/ttt/icon_m24"
end


SWEP.Base					= "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			 = 2
SWEP.Primary.Recoil			= 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 60
SWEP.Primary.Cone = 0.005
SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 10

SWEP.HeadshotMultiplier = 4

SWEP.AutoSpawnable		= true
SWEP.AmmoEnt = "item_ammo_357_ttt"
SWEP.ViewModel			 = Model("models/weapons/v_snip_m24.mdl")
SWEP.WorldModel			= Model("models/weapons/w_snip_m24.mdl")

SWEP.Primary.Sound = Sound("weapons/m24/m24_fire-1.wav")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos		= Vector( 5, -15, -2 )
SWEP.IronSightsAng		= Vector( 2.6, 1.37, 3.5 )

function SWEP:SetZoom(state)
	 if CLIENT then 
		 return
	 else
		 if state then
			 self.Owner:SetFOV(20, 0.3)
		 else
			 self.Owner:SetFOV(0, 0.2)
		 end
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
	  else
		  self:EmitSound(self.Secondary.Sound)
	 end
	 
	 self.Weapon:SetNextSecondaryFire( CurTime() + 0.3)
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

function SWEP:PrimaryAttack(worldsnd)
	if self:GetIronsights() then
		timer.Simple( self.Primary.Delay - 0.2, self.SetZoom, self, true)
		timer.Simple( self.Primary.Delay - 0.2, self.SetIronsights, self, true)
	end

	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	if not self:CanPrimaryAttack() then return end
		
	self:SetZoom(false)
	self:SetIronsights(false)

	if not worldsnd then
		self.Weapon:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	elseif SERVER then
		WorldSound(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )
	
	self:TakePrimaryAmmo( 1 )

	local owner = self.Owner	
	if not ValidEntity(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end
	
	owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	
end

if CLIENT then
	local scope = surface.GetTextureID("sprites/scope")
	function SWEP:DrawHUD()
		if self:GetIronsights() then
			surface.SetDrawColor( 0, 0, 0, 255 )
			
			local x = ScrW() / 2.0
			local y = ScrH() / 2.0
			local scope_size = ScrH()

			-- crosshair
			local gap = 80
			local length = scope_size
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )

			gap = 0
			length = 50
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )


			-- cover edges
			local sh = scope_size / 2
			local w = (x - sh) + 2
			surface.DrawRect(0, 0, w, scope_size)
			surface.DrawRect(x + sh - 2, 0, w, scope_size)

			surface.SetDrawColor(255, 0, 0, 255)
			surface.DrawLine(x, y, x + 1, y + 1)

			-- scope
			surface.SetTexture(scope)
			surface.SetDrawColor(255, 255, 255, 255)

			surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)

		else
			return self.BaseClass.DrawHUD(self)
		end
	end
end

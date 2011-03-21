if (SERVER) then
	AddCSLuaFile("shared.lua")
	resource.AddFile( "models/weapons/v_rif_g36c.mdl" )
	resource.AddFile( "models/weapons/w_rif_g36c.mdl" )
	resource.AddFile("materials/VGUI/ttt/icon_bb_g36c.vmt")
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/ACOG.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/C_grip.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/C_Grip_NO_Rails.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/C_rail.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/C_Rail_NO_ACOG.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/cmag.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/frame.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Frame_inverted.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Mag.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Silencer.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Stock.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Stock_inverted.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_rif_g36c/Trit.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/ACOG.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/C_grip.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/C_Grip_NO_Rails.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/C_rail.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/C_Rail_NO_ACOG.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/cmag.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/frame.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/Mag.vmt" )
	resource.AddFile( "materials/models/weapons/w_models/v_rif_g36c/Stock.vmt" )
	resource.AddFile( "sound/weapons/g36c/g36c_clothshit.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c-1.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c_magin.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c_magout.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c_magfiddle.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c_boltback.wav" )
	resource.AddFile( "sound/weapons/g36c/g36c_boltforward.wav" )
end

if (CLIENT) then
	SWEP.PrintName			= "H&K G36C"
	SWEP.Slot 				= 2
	
    SWEP.ViewModelFOV  = 90	
	SWEP.ViewModelFlip		= true
	SWEP.Icon = "VGUI/ttt/icon_bb_g36c"
end

-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"
SWEP.Author 			= "EraYaN & Ninjatuna"	

SWEP.ViewModel      = "models/weapons/v_rif_g36c.mdl"
SWEP.WorldModel   	= "models/weapons/w_rif_g36c.mdl"
SWEP.HoldType 		= "ar2"
SWEP.HeadshotMultiplier = 2.5

SWEP.Primary.Sound			= Sound("weapons/g36c/g36c-1.wav")
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05
SWEP.Primary.Delay			= 0.15
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Ammo			= "CombineCannon"

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_rifle_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

SWEP.IronSightsPos = Vector (3.5236, -15.1832, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)

function SWEP:SetZoom(state)
    if CLIENT then 
       return
    else
       if state then
          self.Owner:SetFOV(30, 0.5)
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

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope_reddot")
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local x = ScrW() / 2.0
         local y = ScrH() / 2.0
         local scope_size = ScrH()

         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)


         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)

      else
         return self.BaseClass.DrawHUD(self)
      end
   end
end
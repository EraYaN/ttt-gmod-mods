--H&K MP7

if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight = 5
	resource.AddFile("materials/vgui/ttt/icon_bb_mp7.vmt")
	resource.AddFile( "models/weapons/v_smg_mp7.mdl" )
	resource.AddFile( "models/weapons/w_smg_mp7.mdl" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/aim0py.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/aim0py.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/aim0py_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/bolt.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/bolt.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/bolt_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/flashhideb.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/flashhideb.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/flashhideb_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/main.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/main.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/main_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/map2.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/map2.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/map2_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sights_down.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sights_down.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sights_down_ref.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sila.vmt" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sila.vtf" )
	resource.AddFile( "materials/models/weapons/v_models/v_smg_mp7/sila_ref.vtf" )
	resource.AddFile( "sound/weapons/mp7/mp7-1.wav" )
	resource.AddFile( "sound/weapons/mp7/mp7_magin.wav" )
	resource.AddFile( "sound/weapons/mp7/mp7_magout.wav" )
	resource.AddFile( "sound/weapons/mp7/mp7_charger.wav" )
	resource.AddFile( "scripts/sounds/mp7.txt" )
end

if (CLIENT) then
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.PrintName			= "H&K MP7"
	SWEP.Slot 				= 2
	SWEP.Icon = "vgui/ttt/icon_bb_mp7"	
end
SWEP.Base = "weapon_tttbase"
SWEP.Kind = WEAPON_HEAVY
SWEP.Author 			= "EraYaN & Ninjatuna"	

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel      = "models/weapons/v_smg_mp7.mdl"
SWEP.WorldModel   	= "models/weapons/w_smg_mp7.mdl"
SWEP.HoldType 		= "ar2"

SWEP.Primary.Sound			= Sound("weapons/mp7/mp7-1.wav")
SWEP.Primary.Recoil			= 0.8
SWEP.Primary.Damage			= 9
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.025
SWEP.Primary.Delay			= 0.08

SWEP.Primary.ClipSize		= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Ammo			= "smg1"

SWEP.LastRunFrame = 0
SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.HeadshotMultiplier = 2.25

SWEP.IronSightsPos = Vector (3.5236, -15.1832, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)

function SWEP:SetZoom(state)
    if CLIENT then 
       return
    else
       if state then
          self.Owner:SetFOV(33, 0.4)
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
    
    self.Weapon:SetNextSecondaryFire( CurTime() + 0.25)
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


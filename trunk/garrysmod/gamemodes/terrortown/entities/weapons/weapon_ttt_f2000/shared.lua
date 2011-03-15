---- FN F2000

-- First some standard GMod stuff
if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials\VGUI\ttt\icon_tuna_f2000.vmt")
   resource.AddFile("materials\models\weapons\v_models\stalker_fn2000\wpn_fn2000.vmt")
   resource.AddFile("models\weapons\v_rif_f2k.mdl")
end

if CLIENT then
   SWEP.PrintName = "FN F2000"
   SWEP.Slot      = 2 -- add 1 to get the slot number key

   SWEP.ViewModelFOV  = 72
   SWEP.ViewModelFlip = true
   SWEP.Icon = "VGUI/ttt/icon_tuna_f2000"
end

-- Always derive from weapon_tttbase.
SWEP.Base				= "weapon_tttbase"

--- Standard GMod values

SWEP.HoldType			= "ar2"

SWEP.Primary.Delay       = 0.07
SWEP.Primary.Recoil      = 1.8
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 16
SWEP.Primary.Cone        = 0.015
SWEP.Primary.Ammo        = "CombineCannon"
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound       = Sound( "Weapon_AUG.Single" )

SWEP.IronSightsPos = Vector (3.5236, -15.1832, 1.6849)
SWEP.IronSightsAng = Vector (0, 0, 0)

SWEP.ViewModel  = "models/weapons/v_rif_f2k.mdl"
SWEP.WorldModel = "models/weapons/w_rif_f2k.mdl"


SWEP.Kind = WEAPON_HEAVY

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_rifle_ttt"


SWEP.AllowDrop = true

SWEP.IsSilent = false

SWEP.NoSights = false

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
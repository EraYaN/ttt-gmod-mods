-- AN-94 Abakan

if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_tuna_an94.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/frame.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/gp30.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/kobra.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/lense.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/mag.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/mount.vmt")
   resource.AddFile("materials/models/weapons/v_models/rif_an94/vog25p.vmt")
   resource.AddFile("models/weapons/v_rif_an-94.mdl")
   resource.AddFile("models/weapons/w_rif_an-94.mdl")
   resource.AddFile("sound/weapons/an94/an94_boltpull.wav")
   resource.AddFile("sound/weapons/an94/an94_Clipin.wav")
   resource.AddFile("sound/weapons/an94/an94_Clipout.wav")
   resource.AddFile("sound/weapons/an94/an94-1.wav")

end

SWEP.HoldType			= "ar2"
   

if CLIENT then

   SWEP.PrintName			= "AN-94 Abakan"			
   SWEP.Author				= "NinjaTuna"
   SWEP.Slot				= 2

   SWEP.Icon = "VGUI/ttt/icon_tuna_an94"
end


SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay			= 0.12
SWEP.Primary.Recoil			= 1.8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "CombineCannon"
SWEP.Primary.Damage = 21
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_rifle_ttt"
SWEP.ViewModel			= "models/weapons/v_rif_an-94.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_an94.mdl"

SWEP.Primary.Sound = Sound( "Weapon_galil.Single" )

SWEP.IronSightsPos = Vector (4.532, -7.5, 4.055)
SWEP.IronSightsAng = Vector (0, 0, 0)


function SWEP:SetZoom(state)
   if CLIENT then return end
   if state then
      self.Owner:SetFOV(35, 0.5)
   else
      self.Owner:SetFOV(0, 0.2)
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
   
   self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
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
   function SWEP:DrawHUD()
      if self:GetIronsights() then
      else
         return self.BaseClass.DrawHUD(self)
      end
   end
end

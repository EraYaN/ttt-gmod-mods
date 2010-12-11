
if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType           = "ar2"

if CLIENT then
   SWEP.PrintName          = "AW Magnum Sniper"

   SWEP.Slot               = 7

   SWEP.Icon = "VGUI/ttt/icon_ninjah_awp"
   SWEP.EquipMenuData = {
      type="Sniper Weapon",
      model="models/weapons/w_snip_awp.mdl",
      name="Artic Warfare Magnum",
      desc="The Artic Warfare Magnum (AWM) is a powerful sniper rifle. It will have a one shot kill, but it's extremely loud. Also known as Artic Warfare Police (AWP), that is incorrect."
   };
end


SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay          = 2
SWEP.Primary.Recoil         = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "None";
SWEP.Primary.Damage = 125
SWEP.Primary.Cone = 0.0001
SWEP.Primary.ClipSize = 5
SWEP.Primary.ClipMax = 5 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 5

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock = false -- only buyable once

SWEP.HeadshotMultiplier = 4

SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_awm_ttt"
SWEP.ViewModel          = Model("models/weapons/v_snip_awp.mdl")
SWEP.WorldModel         = Model("models/weapons/w_snip_awp.mdl")

SWEP.Primary.Sound = Sound("weapon_AWP.Single")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos = Vector (5.5479, -21.9574, 1.5427)
SWEP.IronSightsAng = Vector (-11.6507, 0.5963, 0)


function SWEP:SetZoom(state, reset)
    if CLIENT then 
       return
    else
       if self.Owner:GetFOV() == 25 then 
		self.Owner:SetFOV(10, 0.3)
		return 10;
		else
		   if state then
			  self.Owner:SetFOV(25, 0.3)
			  return 25;
		   else
			  self.Owner:SetFOV(0, 0.2)
			  return 0;
		   end
	   end
	   if reset then
		self.Owner:SetFOV(0, 0.2)
			  return 0;
	   end
    end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
	local result = 0;
    if not self.IronSightsPos then return end
    if self.Weapon:GetNextSecondaryFire() > CurTime() then return end
    
    bIronsights = not self:GetIronsights()
    
    
    
    if SERVER then
        result = self:SetZoom(bIronsights)
		if result == 0 then
			self:SetIronsights( false )
		else
			self:SetIronsights( true )
		end
     else
        self:EmitSound(self.Secondary.Sound)
    end
    
    self.Weapon:SetNextSecondaryFire( CurTime() + 0.3)
end

function SWEP:PreDrop()
    self:SetZoom(false, true)
    self:SetIronsights(false)
    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    self.Weapon:DefaultReload( ACT_VM_RELOAD );
    self:SetIronsights( false )
    self:SetZoom(false, true)
end


function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)
    return true
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

if SERVER then

   resource.AddFile("materials/VGUI/ttt/icon_ninjah_awm.vmt")
end

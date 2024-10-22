
if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/vgui/ttt/icon_bb_awm.vmt")
end

SWEP.HoldType           = "ar2"

if CLIENT then
   SWEP.PrintName          = "AW Magnum Snip."

   SWEP.Slot               = 7

   SWEP.Icon = "vgui/ttt/icon_bb_awm"
   SWEP.EquipMenuData = {
      type="Sniper Weapon",
      model="models/weapons/w_snip_awp.mdl",
      name="Artic Warfare Magnum",
      desc="The Artic Warfare Magnum\n (AWM) is a powerful sniper rifle.\n One shot is almost deadly,\n but it's extremely loud. And you need a good aim. You get two chances tho."
   };
end


SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Delay          = 2
SWEP.Primary.Recoil         = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "None";
SWEP.Primary.Damage = 105
SWEP.Primary.Cone = 0.0001
SWEP.Primary.ClipSize = 2
SWEP.Primary.ClipMax = 2 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 2

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock = true -- only buyable once

SWEP.HeadshotMultiplier = 6

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
		if reset then
			self.Owner:SetFOV(0, 0.2)
			return 0
		end	   
		if self.Owner:GetFOV() == 25 then 
		self.Owner:SetFOV(10, 0.2)
		return 10
		else
		   if state then
			  self.Owner:SetFOV(25, 0.3)
			  return 25
		   else
			  self.Owner:SetFOV(0, 0.2)
			  return 0
		   end
	   end
	end	   
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
	local result = 0
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
    
    self.Weapon:SetNextSecondaryFire( CurTime() + 0.15)
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
    self:SetZoom(false, true)
    return true
end

function SWEP:OnRestore()
   self.NextSecondaryAttack = 0
   self:SetIronsights( false )
   self:SetZoom(false, true)
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
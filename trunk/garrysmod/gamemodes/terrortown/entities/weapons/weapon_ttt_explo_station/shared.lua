
if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "normal"


if CLIENT then
   SWEP.PrintName = "Death Station"
   SWEP.Slot = 6

   SWEP.ViewModelFOV = 10

   SWEP.EquipMenuData = {
      type="Weapon",
      model="models/props/cs_office/microwave.mdl",
      desc="Allows people to die when placed.\n\nFaster recharge. Anyone can use it, and\nit can be damaged plus it has a nasty suprise against vandalism. Can be checked for\nDNA samples of its users."
   };

   SWEP.Icon = "vgui/ttt/icon_health"
end

SWEP.Base = "weapon_tttbase"

SWEP.ViewModel          = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel         = "models/props/cs_office/microwave.mdl"

SWEP.DrawCrosshair      = true
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo       = "none"
SWEP.Primary.Delay = 1.0

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Ammo     = "none"
SWEP.Secondary.Delay = 1.0

-- This is special equipment


SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy
SWEP.LimitedStock = true -- only buyable once

SWEP.AllowDrop = false

SWEP.NoSights = true

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:PrimaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:HealthDrop()
end
function SWEP:SecondaryAttack()
   self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   self:HealthDrop()
end

local throwsound = Sound( "Weapon_SLAM.SatchelThrow" )

-- ye olde droppe code
function SWEP:HealthDrop()
   if SERVER then
      local ply = self.Owner
      if not ValidEntity(ply) then return end

      if self.Planted then return end

      local vsrc = ply:GetShootPos()
      local vang = ply:GetAimVector()
      local vvel = ply:GetVelocity()
      
      local vthrow = vvel + vang * 200

      local health = ents.Create("ttt_explo_station")
      if ValidEntity(health) then
         health:SetPos(vsrc + vang * 10)
         health:SetOwner(ply)
         health:Spawn()

         health:PhysWake()
         local phys = health:GetPhysicsObject()
         if ValidEntity(phys) then
            phys:SetVelocity(vthrow)
         end   
         self:Remove()

         self.Planted = true
      end
   end

   self.Weapon:EmitSound(throwsound)
end


function SWEP:Reload()
   return false
end

function SWEP:OnRemove()
   if CLIENT and ValidEntity(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("lastinv")
   end
end

if CLIENT then
   local hudtxt = {text="Click to place the death station", font="TabLarge", xalign=TEXT_ALIGN_RIGHT}
   function SWEP:DrawHUD()
      hudtxt.pos = {ScrW() - 80, ScrH() - 80}
      draw.TextShadow(hudtxt, 2)
   end
end

function SWEP:Deploy()
   if SERVER and IsValid(self.Owner) then
      self.Owner:DrawViewModel(false)
   end
   return true
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end


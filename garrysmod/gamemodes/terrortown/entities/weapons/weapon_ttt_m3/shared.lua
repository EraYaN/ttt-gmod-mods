if SERVER then
   AddCSLuaFile( "shared.lua" )
   resource.AddFile("materials/VGUI/ttt/icon_tuna_m3.vmt")
end

SWEP.HoldType			= "shotgun"

if CLIENT then
   SWEP.PrintName = "Benelli M3"
   SWEP.Slot      = 2 -- add 1 to get the slot number key
   SWEP.SlotPos	  = 1
   SWEP.Author	  = "NinjaTuna"

   SWEP.ViewModelFOV  = 72
   SWEP.ViewModelFlip = true
   
   SWEP.Icon = "VGUI/ttt/icon_tuna_m3"
end

--- Standard GMod values

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Autospawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Ammo        = "Buckshot"
SWEP.Primary.Damage      = 9
SWEP.Primary.Cone        = 0.085
SWEP.Primary.Delay       = 0.95
SWEP.Primary.ClipSize    = 8
SWEP.Primary.ClipMax     = 32
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic   = true
SWEP.Primary.NumShots	 = 12
SWEP.AmmoEnt 			 = "item_box_buckshot_ttt"
SWEP.ViewModel 			 = "models/weapons/v_shot_m3super90.mdl"
SWEP.WorldModel 		 = "models/weapons/w_shot_m3super90.mdl"
SWEP.Primary.Sound       = Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil      = 5

SWEP.IronSightsPos 		 = Vector (5.7431, -1.6786, 3.3682)
SWEP.IronSightsAng 		 = Vector (0.0634, -0.0235, 0)

SWEP.reloadtimer = 0

-- Tell the server that it should download our icon to clients.
if SERVER then
   -- It's important to give your icon a unique name. GMod does NOT check for
   -- file differences, it only looks at the name. This means that if you have
   -- an icon_ak47, and another server also has one, then players might see the
   -- other server's dumb icon. Avoid this by using a unique name.
   resource.AddFile("materials/VGUI/ttt/icon_ninjah_m3.vmt")
end


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
   if self.dt.reloading then
      
      if self.Owner:KeyDown(IN_ATTACK) then
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
   
   -- decay from 3.1 to 1 slowly as distance increases
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end
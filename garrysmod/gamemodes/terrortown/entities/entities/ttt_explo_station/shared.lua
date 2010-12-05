---- Health dispenser

if SERVER then AddCSLuaFile("shared.lua") end

if CLIENT then
   -- this entity can be DNA-sampled so we need some display info
   ENT.Icon = "VGUI/ttt/icon_health"
   ENT.PrintName = "Death Station"

   ENT.TargetIDHint = {
      name="Health Station",
      hint= "Press " .. Key("+use", "USE") .. " to receive health. Charge: %d.",
      fmt=function(ent, str)
             return Format(str, IsValid(ent) and ent:GetStoredHealth() or 0)
          end
   };
end

ENT.Type = "anim"
ENT.Model = Model("models/props/cs_office/microwave.mdl")


ENT.CanUseKey = true
ENT.CanHavePrints = true
ENT.MaxHeal = 50
ENT.MaxStored = 200
ENT.RechargeRate = 5
ENT.RechargeFreq = 1 -- in seconds

AccessorFuncDT(ENT, "StoredHealth", "StoredHealth")

function ENT:SetupDataTables()
   self:DTVar("Int", 0, "StoredHealth")
end

function ENT:Initialize()
   self.Entity:SetModel(self.Model)

   self.Entity:PhysicsInit(SOLID_VPHYSICS)
   self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
   self.Entity:SetSolid(SOLID_VPHYSICS)
   self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
   if SERVER then
      self.Entity:SetMaxHealth(200)

      local phys = self.Entity:GetPhysicsObject()
      if IsValid(phys) then
         phys:SetMass(200)
      end
   end
   self.Entity:SetHealth(200)

   self.Entity:SetColor(180, 180, 255, 255)

   self:SetStoredHealth(200)

   self.fingerprints = {}
end

function ENT:UseOverride(activator)
   if ValidEntity(activator) and activator:IsPlayer() and activator:IsActive() then
      self:GiveHealth(activator)
   end
end

function ENT:AddToStorage(amount)
   self:SetStoredHealth(math.min(self.MaxStored, self:GetStoredHealth() + amount))
end

function ENT:TakeFromStorage(amount)
   -- if we only have 5 healthpts in store, that is the amount we heal
   amount = math.min(amount, self:GetStoredHealth())
   self:SetStoredHealth(math.max(0, self:GetStoredHealth() - amount))
   return amount
end

local healsound = Sound("items/medshotno2.wav")
local failsound = Sound("items/medshotno1.wav")
function ENT:GiveHealth(ply)
   if self:GetStoredHealth() > 0 then
      local dmg = ply:GetMaxHealth() - ply:Health()
      if dmg > 0 then
         -- constant clamping, no risks
         local healed = self:TakeFromStorage(math.min(self.MaxHeal, dmg))
         local new = math.min(ply:GetMaxHealth(), ply:Health() - healed)
         
         ply:SetHealth(new)

         self:EmitSound(healsound)

         if not table.HasValue(self.fingerprints, ply) then
            table.insert(self.fingerprints, ply)
         end
      else
         ply:ChatPrint("Your health is full.")
         self:EmitSound(failsound)
      end
   else
      ply:ChatPrint("The health station is empty!")
      self:EmitSound(failsound)
   end
end

-- traditional equipment destruction effects
function ENT:OnTakeDamage(dmginfo)
   if dmginfo:GetAttacker() == self:GetOwner() then return end

   self:TakePhysicsDamage(dmginfo)

   self:SetHealth(self:Health() - dmginfo:GetDamage())
   if self:Health() < 0 then
      self:Remove()
	 local explode = ents.Create( "env_explosion" ) //creates the explosion
	explode:SetPos( self:Pos )
	--this creates the explosion through your self.Owner:GetEyeTrace, which is why I put eyetrace in front
	explode:SetOwner( self.Owner ) -- this sets you as the person who made the explosion
	explode:Spawn() --this actually spawns the explosion
	explode:SetKeyValue( "iMagnitude", "1000" ) --the magnitude
	SetKeyValue("radius", r_outer)
	explode:Fire( "Explode", 0, 0 )
	explode:EmitSound( "weapon_AWP.Single", 1500, 1500 ) --the sound for the explosion, and how far away it can be heard

      --[[local effect = EffectData()
      effect:SetOrigin(self:GetPos())
      util.Effect("cball_explode", effect)
      WorldSound(zapsound, self:GetPos())]]--

      if IsValid(self:GetOwner()) then
         TraitorMsg(self:GetOwner(), "YOUR HEALTH^^ STATION HAS BEEN DESTROYED!")
      end
   end
end

if SERVER then
   -- recharge
   local nextcharge = 0
   function ENT:Think()
      if nextcharge < CurTime() then
         self:AddToStorage(self.RechargeRate)

         nextcharge = CurTime() + self.RechargeFreq
      end
   end
end


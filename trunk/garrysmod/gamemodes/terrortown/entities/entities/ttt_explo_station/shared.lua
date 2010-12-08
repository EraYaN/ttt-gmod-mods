---- Health dispenser

if SERVER then AddCSLuaFile("shared.lua") end
--[[function ENT:MessageTraitorHook()
     Msg("Round started")
	 self.Entity:SetColor(180, 180, 255, 255)
	if LocalPlayer():IsTraitor() or LocalPlayer():IsTraitor() == nil then
		self.TargetIDHint = {name="DEATH Station",
			hint= "Do not press " .. Key("+use", "USE") .. " to receive death. Charge: %d.",
			fmt=function(ent, str)
				 return Format(str, IsValid(self) and self:GetStoredHealth() or 0)
			  end
		}
		self.Entity:SetColor(255,180,180,255)
	else
		self.TargetIDHint = {name="Health Station",
			hint= "Press " .. Key("+use", "USE") .. " to receive health. Charge: %d.",
			fmt=function(self, str)
				return Format(str, IsValid(self) and self:GetStoredHealth() or 0)
			end
		}
		self.Entity:SetColor(180, 180, 255, 255)
	end
  end]]--
  --hook.Add("TTTBeginRound", "EraYaNExploStationMessageTraitorHook", ENT:MessageTraitorHook())
  --ttt_role.Hook("ttt_role", ENT:MessageTraitorHook())
if CLIENT then
   -- this entity can be DNA-sampled so we need some display info
   ENT.Icon = "VGUI/ttt/icon_health"
   ENT.PrintName = "Death Station"
ENT.TargetIDHint = {name="Health Station",
			hint= "Press " .. Key("+use", "USE") .. " to receive health. Charge: %d.",
			fmt=function(ent, str)
				return Format(str, IsValid(ent) and ent:GetStoredHealth() or 0)
			end
		}
  

   
   
end

ENT.Type = "anim"
ENT.Model = Model("models/props/cs_office/microwave.mdl")


ENT.CanUseKey = true
ENT.CanHavePrints = true
ENT.MaxHeal = 50
ENT.MaxStored = 200
ENT.RechargeRate = 5
ENT.RechargeFreq = 3 -- in seconds

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
	self.Entity:SetHealth(25)

	self.Entity:SetColor(180, 180, 255, 255)

	self:SetStoredHealth(200)
	if CLIENT then
	self:CheckTraitor()
	end

	self.fingerprints = {}
end

function ENT:CheckTraitor()
     Msg("\nDS Traitor Check\n\n")
	 self.Entity:SetColor(180, 180, 255, 255)
	if LocalPlayer():IsActiveTraitor() and LocalPlayer():IsActiveTraitor() ~= nil then
		self.TargetIDHint = {name="DEATH Station",
			hint= "Do not press " .. Key("+use", "USE") .. " to receive death. Charge: %d.",
			fmt=function(ent, str)
				 return Format(str, IsValid(self) and self:GetStoredHealth() or 0)
			  end
		}
		self.Entity:SetColor(255,180,180,255)
	else
		self.TargetIDHint = {name="Health Station",
			hint= "Press " .. Key("+use", "USE") .. " to receive health. Charge: %d.",
			fmt=function(self, str)
				return Format(str, IsValid(self) and self:GetStoredHealth() or 0)
			end
		}
		self.Entity:SetColor(180, 180, 255, 255)
	end
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
if ply:Health() == 1 then
	ply:ChatPrint("Watch your health!")
    self:EmitSound(failsound)
return
end
if ply:Health() < 1 then
	ply:ChatPrint("You are Dead!")
    self:EmitSound(failsound)
return
end
   if self:GetStoredHealth() > 0 then
      local dmg = ply:GetMaxHealth() - ply:Health()

		if ply:Health() > self.MaxHeal then
			ply:SetHealth(ply:Health() - self:TakeFromStorage(math.min(self.MaxHeal, ply:Health()-1)))
			else
			ply:SetHealth(1)
		end
		self:EmitSound(healsound)

         if not table.HasValue(self.fingerprints, ply) then
            table.insert(self.fingerprints, ply)
         end
   else
      ply:ChatPrint("The health station is empty!")
      self:EmitSound(failsound)
   end
end

-- traditional equipment destruction effects
function ENT:OnTakeDamage(dmginfo)
   --if dmginfo:GetAttacker() == self:GetOwner() then return end

   self:TakePhysicsDamage(dmginfo)
	
   self:SetHealth(self:Health() - dmginfo:GetDamage())
   if self:Health() < 0 then
  
      self:Remove()
	 local explode = ents.Create( "env_explosion" ) --creates the explosion
	explode:SetPos( self:GetPos() + Vector (0,0,4))
	explode:SetOwner( self.Owner ) -- this sets you as the person who made the explosion
	--explode:SetActivator( self.Owner ) -- this sets you as the person who made the explosion
	--explode:SetInflictor( self.Owner ) -- this sets you as the person who made the explosion
	explode:SetPhysicsAttacker(self.Owner)
	explode:SetKeyValue( "iMagnitude", "1000" ) --the magnitude
	explode:SetKeyValue( "rendermode", "4")
	explode:Fire( "Explode", "", 0.2 )
	explode:EmitSound( "ambient/explosions/explode_3.wav", 500, 100 ) --the sound for the explosion, and how far away it can be heard
	explode:Spawn() --this actually spawns the explosion
		Msg("DS said BOOM!")
      local effect = EffectData()
      effect:SetOrigin(self:GetPos())
      util.Effect("Explosion_2", effect)
	  --[[
			* Explosion_2
			* Explosion_2_Chunks
			* Explosion_2_Embers
			* Explosion_2_Fire
			* Explosion_2_FireSmoke
			* Explosion_2_flash
			* ExplosionCore
			* ExplosionEmbers
			* ExplosionFlash 
	  ]]--
      --WorldSound(zapsound, self:GetPos())

      if IsValid(self:GetOwner()) then
		
         TraitorMsg(self:GetOwner(), "YOUR DEATH STATION HAS BEEN DESTROYED!")
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


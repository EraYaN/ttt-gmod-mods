-- Scout + SIG ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "357"
ENT.AmmoAmount = 10
ENT.AmmoMax = 20
ENT.Model = Model("models/items/357ammo.mdl")

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:CheckForWeapon(ent) and self:PlayerCanPickup(ent)) then

         local ammo = ent:GetAmmoCount(self.AmmoType)
				
			 if ent:GetWeapon("weapon_ttt_sg550"):IsValid() and (40 >= (ammo + math.ceil(20 * 0.25))) then
				ent:GiveAmmo( math.min(20, 40 - ammo), self.AmmoType)
				self:Remove()
				-- just in case remove does not happen soon enough
				self.taken = true
			
				 elseif ( ent:GetWeapon("weapon_zm_rifle"):IsValid() or ent:GetWeapon("weapon_ttt_m24"):IsValid() )and (20 >= (ammo + math.ceil(10 * 0.25))) then
					ent:GiveAmmo( math.min(10, 20 - ammo), self.AmmoType)
					self:Remove()
					-- just in case remove does not happen soon enough
					self.taken = true
					end       
		end	
	end
end

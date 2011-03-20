-- MAC10 + TMP ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "SMG1"
ENT.AmmoAmount = 30
ENT.AmmoMax = 60
ENT.Model = Model("models/items/boxmrounds.mdl")

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:CheckForWeapon(ent) and self:PlayerCanPickup(ent)) then

         local ammo = ent:GetAmmoCount(self.AmmoType)
				
			 if ent:GetWeapon("weapon_ttt_mp7"):IsValid() and (80 >= (ammo + math.ceil(40 * 0.25))) then
				ent:GiveAmmo( math.min(20, 40 - ammo), self.AmmoType)
				self:Remove()
				-- just in case remove does not happen soon enough
				self.taken = true
			
				 elseif ( ent:GetWeapon("weapon_zm_mac10"):IsValid() or ent:GetWeapon("weapon_ttt_tmp"):IsValid() )and (60 >= (ammo + math.ceil(30 * 0.25))) then
					ent:GiveAmmo( math.min(10, 20 - ammo), self.AmmoType)
					self:Remove()
					-- just in case remove does not happen soon enough
					self.taken = true
					end       
		end	
	end
end
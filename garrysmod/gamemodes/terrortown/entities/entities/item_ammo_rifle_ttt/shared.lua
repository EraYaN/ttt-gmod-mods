-- M4A1 + AK47 + FAMAS ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "CombineCannon"
ENT.AmmoAmount = 30
ENT.AmmoMax = 60
ENT.Model = Model("models/items/boxsrounds.mdl")

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:CheckForWeapon(ent) and self:PlayerCanPickup(ent)) then

         local ammo = ent:GetAmmoCount(self.AmmoType)
				
			 if (ent:GetWeapon("weapon_ttt_ak47"):IsValid() or ent:GetWeapon("weapon_ttt_an94"):IsValid() or ent:GetWeapon("weapon_ttt_f2000"):IsValid() or ent:GetWeapon("weapon_ttt_g36c"):IsValid()) and (60 >= (ammo + math.ceil(30 * 0.25))) then
				ent:GiveAmmo( math.min(30, 60 - ammo), self.AmmoType)
				self:Remove()
				-- just in case remove does not happen soon enough
				self.taken = true
			
				 elseif ent:GetWeapon("weapon_ttt_m16"):IsValid() and (50 >= (ammo + math.ceil(25 * 0.25))) then
					ent:GiveAmmo( math.min(25, 50 - ammo), self.AmmoType)
					self:Remove()
					-- just in case remove does not happen soon enough
					self.taken = true
				
					 elseif ent:GetWeapon("weapon_ttt_famas"):IsValid() and (75 >= (ammo + math.ceil(25 * 0.25))) then
						ent:GiveAmmo( math.min(25, 75 - ammo), self.AmmoType)
						self:Remove()
						-- just in case remove does not happen soon enough
						self.taken = true
						end	
           
		end	
	end
end

function ENT:Initialize()
    -- Differentiate from pistol ammo
    self:SetColor(100, 70, 0, 255)

    return self.BaseClass.Initialize(self)
end

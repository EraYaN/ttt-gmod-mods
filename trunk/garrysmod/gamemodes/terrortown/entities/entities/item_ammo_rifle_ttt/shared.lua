-- rifle ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   language.Add("CombineCannon_ammo", "Rifle ammo")
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
         -- need clipmax info and room for at least 1/4th
         if self.AmmoMax >= (ammo + math.ceil(self.AmmoAmount * 0.25)) then

			local class = ent:GetActiveWeapon( ):GetClass()
				if class == "weapon_ttt_ak47" then
				ent:GiveAmmo( math.min(30, 60 - ammo), self.AmmoType)
				self:Remove()
				-- just in case remove does not happen soon enough
				self.taken = true
			
		 
					elseif class == "weapon_ttt_m16" then
					ent:GiveAmmo( math.min(25, 50 - ammo), self.AmmoType)
					self:Remove()
					-- just in case remove does not happen soon enough
					self.taken = true
				
						elseif class == "weapon_ttt_famas" then
						ent:GiveAmmo( math.min(25, 75 - ammo), self.AmmoType)
						self:Remove()
						-- just in case remove does not happen soon enough
						self.taken = true
						end
		 end            
		end	
	end
end

function ENT:Initialize()
    -- Differentiate from pistol ammo
    self:SetColor(40, 100, 166, 255)

    self:RealInit()
end

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
		 local class = ent:GetActiveWeapon( ):GetClass()
				
			 if class == "weapon_ttt_ak47" and (60 >= (ammo + math.ceil(30 * 0.25))) then
				ent:GiveAmmo( math.min(30, 60 - ammo), self.AmmoType)
				self:Remove()
				-- just in case remove does not happen soon enough
				self.taken = true
			
		 
				 elseif class == "weapon_ttt_m16"  and (50 >= (ammo + math.ceil(25 * 0.25))) then
					ent:GiveAmmo( math.min(25, 50 - ammo), self.AmmoType)
					self:Remove()
					-- just in case remove does not happen soon enough
					self.taken = true
				
					 elseif class == "weapon_ttt_famas" and (75 >= (ammo + math.ceil(25 * 0.25))) then
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
    self:SetColor(0, 70, 100, 255)

    self:RealInit()
end

-- Deagle ammo override

if SERVER then
    AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "AlyxGun"
ENT.AmmoAmount = 12
ENT.AmmoMax = 36
ENT.Model = Model("models/items/357ammo.mdl")

function ENT:Initialize()
    -- Differentiate from rifle ammo
    self:SetColor(255, 100, 100, 255)

    return self.BaseClass.Initialize(self)
end

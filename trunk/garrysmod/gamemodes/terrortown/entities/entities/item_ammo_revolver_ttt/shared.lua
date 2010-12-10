-- Deagle ammo override

if SERVER then
    AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   language.Add("AlysxGun_ammo", "Deagle ammo")
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

    self:RealInit()
end

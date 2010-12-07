-- SIG 550 ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "AirboatGun"
ENT.AmmoAmount = 20
ENT.AmmoMax = 40
ENT.Model = Model("models/items/357ammo.mdl")

function ENT:Initialize()
    -- Differentiate from rifle ammo
    self:SetColor(112, 138, 144, 255)

    self:RealInit()
end
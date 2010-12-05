-- ak47 ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "AK-47"
ENT.AmmoAmount = 45
ENT.AmmoMax = 90
ENT.Model = Model("models/items/boxsrounds.mdl")

function ENT:Initialize()
    -- Differentiate from pistol ammo
    self:SetColor(160, 82, 45, 255)

    self:RealInit()
end

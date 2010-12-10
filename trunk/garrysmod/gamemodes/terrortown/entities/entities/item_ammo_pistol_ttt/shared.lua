-- Pistol ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   language.Add("Pistol_ammo", "Pistol ammo")
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "Pistol"
ENT.AmmoAmount = 20
ENT.AmmoMax = 60
ENT.Model = Model("models/items/boxsrounds.mdl")

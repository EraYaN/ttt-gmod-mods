-- MAC10 + TMP ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   language.Add("SMG1_ammo", "SMG ammo")
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "SMG1"
ENT.AmmoAmount = 30
ENT.AmmoMax = 60
ENT.Model = Model("models/items/boxmrounds.mdl")

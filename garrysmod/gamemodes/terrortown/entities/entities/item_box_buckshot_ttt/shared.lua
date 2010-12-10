-- M3 + M4 ammo override

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   language.Add("Buckshot_ammo", "Rifle ammo")
end

ENT.Type = "anim"
ENT.Base = "base_ammo_ttt"
ENT.AmmoType = "Buckshot"
ENT.AmmoAmount = 8
ENT.AmmoMax = 24
ENT.Model = "models/items/boxbuckshot.mdl"

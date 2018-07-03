
-----------------------------------------------------
ENT.Type = "anim"
ENT.PrintName = "Static Radio"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize()
  if SERVER then
    self:SetModel("models/props_lab/citizenradio.mdl")
    self:SetUseType(SIMPLE_USE)
    self:PhysicsInit(SOLID_VPHYSICS)
  	self:SetMoveType(MOVETYPE_VPHYSICS)
  	self:SetSolid(SOLID_VPHYSICS)
  end
end

function ENT:Use(client)
  if not client:Team() == can_view_team then return end
  netstream.Start(client, "type_radio_message", {
    ent = self
  })
end

ITEM.name = "Important Documents"
ITEM.flag = "Y"
ITEM.model = "models/props_lab/clipboard.mdl"
ITEM.uniqueID = "papers"

ITEM.functions.Drop = nil
ITEM.functions.show = {
  icon = "icon16/user.png",
  name = "Show",
  onRun = function(item)
    local ply = item.player
    local target = ply:GetEyeTrace().Entity
    if not target:IsPlayer() or not IsValid(target) or target:GetPos():Distance(ply:GetPos()) > 500 then return end

    netstream.Start(target, "openUpID", ply)
    return false
  end,
  onCanRun = function(item)
    local trEnt = item.player:GetEyeTrace().Entity
    return IsValid(trEnt) and trEnt:IsPlayer()
  end
}

nut.command.add("announce", {
  syntax = "<string msg>",
  adminOnly = true,
  onRun = function(ply, args, msg)
  if ply:IsSuperAdmin() then
  nut.util.notify("ANNOUNCEMENT: "..args[1])
  else
  ply:ChatPrint( "Not super admin fag" )
end
end
})

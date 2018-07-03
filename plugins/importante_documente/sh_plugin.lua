PLUGIN.name = "Important Document"
PLUGIN.desc = "Adds an important document with all the information about a player's appearance."
PLUGIN.author = "Robert Bearson"

nut.util.include("cl_docGUI.lua")
nut.util.include("cl_missingInfos.lua")
nut.util.include("sv_networking.lua")

charCharacteristics = {
  ["Age"] = "number",
  ["Date of Birth"] = "string",
  ["Place of Birth"] = "string",
  ["Height"] = "string",
  ["Hair Color"] = "string",
  ["Eye Color"] = "string",
  ["Religion"] = "string",
  ["Blood Type"] = {valueType = "choice", choices={"O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"}},
	["Occupation"] = "string"
}

nut.command.add("chareditpapers", {
	syntax = "",
	onRun = function(ply,args)
		netstream.Start(ply,"missingCharacteristics", "Edit your information", true)
	end
})

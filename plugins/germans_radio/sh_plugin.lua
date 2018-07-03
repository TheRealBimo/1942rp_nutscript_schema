-----------------------------------------------------
PLUGIN.name = "Germans Radio"
PLUGIN.author = "RobertLP"
PLUGIN.desc = "Let people use their portable radios & use of stationary radios too"

--Settings
local can_view_team = {
    FACTION_Clone,
    FACTION_Coruscant,
    FACTION_Medical,
    FACTION_FELG,
    FACTION_ORDF,
    FACTION_navy,
    FACTION_luftwaffe,
}
local chat_tag = "RADIO"
local tag_color = Color(214,36,36)
local message_color = Color(255,255,255)
local show_author_his_message = false
local texts = {
  no_radio = "You do not have the required equipment.",
  no_arguments = "You must specify the message you want to transmit"
}

--Include
nut.util.include("cl_radio_typewriter.lua", "client")

--Radio Command
nut.command.add("radio", {
  syntax = "[string message]",
  onRun = function(client, args)
    local inv = client:getChar():getInv()
    local radio = nut.item.list["radio"]

    if not inv:hasItem(radio.uniqueID) then
      client:notify(texts.no_radio)
      return
    end

    if #args <= 0 then
      client:notify(texts.no_arguments)
    else
      local msg = table.concat(args," ",1,#args)

      --NetMSG Everyone
      local pls = player.GetAll()
      for i=1, #pls do
        netstream.Start(pls[i], "radio_message", {
          msg = client:Nick() .. " - " .. msg,
          sent_by = client
        })
      end
    end
  end
})

netstream.Hook("send_radio_msg", function(ply, data)
  local pls = player.GetAll()
  for i=1, #pls do
    netstream.Start(pls[i], "radio_message", {
      msg = data.sent_by:Nick() .. " - " .. data.msg,
      sent_by = data.sent_by
    })
  end
end)

if CLIENT then
  netstream.Hook("radio_message", function(data)
    if show_author_his_message and not LocalPlayer() == data.sent_by then
      return
    end

    local canview = false
    for _,team in pairs(can_view_team) do
      if LocalPlayer():Team() == team then
		print("You can view this")
        chat.AddText(tag_color, "[" .. chat_tag .. "] ", message_color, data.msg)
        break
      end
    end
  end)
end
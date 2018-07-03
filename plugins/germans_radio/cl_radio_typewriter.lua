
-----------------------------------------------------
netstream.Hook("type_radio_message", function(data)
  local radio = data.ent

  --Frame
  local frame = vgui.Create("DFrame")
  frame:SetSize(500, 120)
  frame:Center()
  frame:MakePopup()
  frame:SetTitle("")
  function frame:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,Color(35,35,35))
  end

  --Title
  local t = vgui.Create("DLabel", frame)
  t:SetText("Message to send")
  t:SizeToContents()
  t:SetPos(0, 20)
  t:CenterHorizontal()

  --Entry
  local e = vgui.Create("DTextEntry", frame)
  e:SetSize(frame:GetWide()-20, e:GetTall())
  e:Center()

  --Send
  local s = vgui.Create("DButton", frame)
  s:SetSize(120, 25)
  s:SetText("Send")
  s:SetPos(frame:GetWide()/2-s:GetWide()/2, frame:GetTall()-s:GetTall()-10)
  s:SetColor(color_white)
  function s:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,Color(20,20,20))
    if self:IsHovered() then
      draw.RoundedBox(0,0,0,w,h,Color(25,25,25))
    end
  end
  function s:DoClick()
    if #e:GetValue() <= 0 then
      nut.util.notify("You need to enter a message to send", LocalPlayer())
    else
      netstream.Start("send_radio_msg", {
        sent_by = LocalPlayer(),
        msg = e:GetValue()
      })
    end
  end
end)

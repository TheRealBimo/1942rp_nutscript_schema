netstream.Hook("openUpID", function(from)
  local frame = vgui.Create("DFrame")
  frame:SetSize(600,430)
  frame:MakePopup()
  frame:Center()
  frame:ShowCloseButton(false)
  frame:SetTitle("")
  function frame:OnKeyCodePressed(key)
    if key == KEY_F1 then
      self:Close()
    end
  end
  function frame:Paint(w,h)
    draw.RoundedBoxEx(4,0,0,w,h,Color(60,60,60,80),true,true)
  end

  local cover = frame:Add("DPanel")
  cover:SetSize(frame:GetWide()/2, frame:GetTall()-30)
  cover:CenterHorizontal()
  cover.mat = Material("vrp/impdoc/cover.png","smooth")
  function cover:Paint(w,h)
    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(self.mat)
    surface.DrawTexturedRect(0,0,w,h)
  end

  local complete = frame:Add("DPanel")
  complete:SetSize(frame:GetWide(), frame:GetTall()-30)
  complete:CenterHorizontal()
  complete:SetAlpha(0)
  complete.mat = Material("vrp/impdoc/infos.jpg","smooth")
  local anchor = frame:GetWide()/2
  function complete:Paint(w,h)
    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(self.mat)
    surface.DrawTexturedRect(0,0,w,h)
  end
  function complete:ShowModel()
    self.mdl = self:Add("DModelPanel")
    self.mdl:SetSize(230,240)
    self.mdl:SetPos((frame:GetWide()/2)/2-self.mdl:GetWide()/2, 23)
    self.mdl:SetModel(from:GetModel())
    self.mdl:SetFOV(20)
    self.mdl:SetAlpha(0)
    self.mdl:AlphaTo(255,0.2)
    local head = self.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") --Look at the model head
    if head and head >= 0 then
      self.mdl:SetLookAt(self.mdl.Entity:GetBonePosition(head))
    end
    function self.mdl:LayoutEntity(ent)
      ent:SetAngles(Angle(0,45,0))
      ent:ResetSequence(2)
    end
  end

  --Displaying Informations
  local name = complete:Add("DLabel")
  name:SetText(from:Nick())
  name:SetFont("nutMediumFont")
  name:SetColor(Color(60,60,60))
  name:SizeToContents()
  name:SetPos((complete:GetWide()/2)/2 - name:GetWide()/2, complete:GetTall()-100)

  local inf = complete:Add("DPanel")
  inf:SetSize(complete:GetWide()/2,complete:GetTall())
  inf:SetPos(complete:GetWide()/2,0)
  inf.Paint = nil

  inf.list = inf:Add("DListLayout")
  inf.list:SetSize(inf:GetWide()-30)
  inf.list:SetPos(inf:GetWide()-inf.list:GetWide(),10)

  netstream.Start("getPlayerCharacs", from)
  netstream.Hook("returnPlayerCharacs", function(data)
    PrintTable(data)
    for k,v in pairs(data) do
      local i = inf.list:Add("DPanel")
      i:SetTall(23)
      i.Paint = nil

      i.key = i:Add("DLabel")
      i.key:SetText(k)
      i.key:SetFont("nutSmallFont")
      i.key:SetColor(Color(60, 60, 60))
      i.key:SizeToContents()

      i.val = i:Add("DLabel")
      i.val:SetText(v)
      i.val:SetFont("nutSmallFont")
      i.val:SetColor(Color(60, 60, 60))
      i.val:SizeToContents()
      i.val:SetPos(inf.list:GetWide()-i.val:GetWide()-30)
    end
  end)

  local cont = frame:Add("DButton")
  cont:SetSize(frame:GetWide(),30)
  cont:SetPos(0,frame:GetTall()-cont:GetTall())
  cont:SetText("Continue")
  cont:SetFont("nutSmallFont")
  cont:SetColor(color_white)
  cont.finish = false
  function cont:Paint(w,h)
    if self:IsHovered() then
      draw.RoundedBoxEx(4,0,0,w,h,Color(46, 152, 204),false,false,true,true)
    else
      draw.RoundedBoxEx(4,0,0,w,h,Color(60,60,60,80),false,false,true,true)
    end
  end
  function cont:DoClick()
    cover:MoveTo(frame:GetWide()-cover:GetWide(),0,0.2,0.2,-1,function()
      cover:AlphaTo(0,0.2)
      complete:AlphaTo(255,0.2,0,function()
        complete:ShowModel()
        self:SetText("Finish")
        self.finish = true
        self.DoClick = function(this)
          frame:AlphaTo(0,0.2,0,function()
            if frame and IsValid(frame) then
              frame:Remove()
            end
          end)
        end
      end)
    end)
  end
end)

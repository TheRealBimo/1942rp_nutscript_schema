local function openMissingInfoMenu(title, fill)
	title = title or nil
	fill = fill or false

  local frame = vgui.Create("DFrame")
  frame:SetSize(500,450)
  frame:Center()
  frame:MakePopup()
  frame:SetTitle("")
  frame:SetAlpha(0)
  frame:AlphaTo(255,0.2)
  function frame:Paint(w,h)
    draw.RoundedBox(4,0,0,w,h,Color(30, 30, 35))
  end
  function frame:OnKeyCodePressed(key)
    if key == KEY_END and LocalPlayer():IsSuperAdmin() then
      frame:Close()
    end
  end

  --Why the player is seeing this menu
  frame.whatPanel = frame:Add("DPanel")
  frame.whatPanel:SetSize(frame:GetWide(), 80)
  frame.whatPanel:SetPos(0,0)
  frame.whatPanel:SetContentAlignment(5)
  function frame.whatPanel:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,Color(33,33,37))

    surface.SetDrawColor(110, 110, 110)
    surface.DrawLine(0,h-1,w,h-1)
  end

  frame.what = frame.whatPanel:Add("DLabel")
  frame.what:SetText(title or "If you are in this menu, it means that you are missing some crucial information about your character. Please enter the needed informatin below.")
  frame.what:SetFont("nutSmallFont")
  frame.what:SetColor(color_white)
	function frame.what:LayoutNormal()
		frame.what:Dock(FILL)
		frame.what:DockMargin(5,5,5,5)
		frame.what:SetWrap(true)
	end
	if title then
		frame.what:SizeToContents()
		if frame.what:GetWide() >= frame.whatPanel:GetWide() then
			frame.what:LayoutNormal()
		end
	else
		frame.what:LayoutNormal()
	end
  frame.what:Center()

  --Display all the information
  frame.scroll = frame:Add("DScrollPanel")
  frame.scroll:SetSize(frame:GetWide(), frame:GetTall()-frame.whatPanel:GetTall()-30)
  frame.scroll:SetPos(0, frame.whatPanel:GetTall())

  frame.list = frame.scroll:Add("DIconLayout")
  frame.list:SetSize(frame.scroll:GetSize())

  local alt = true
  local values = {}
	local characs = LocalPlayer():getChar():getData("charCharacteristics", {})
  for k,v in SortedPairs(charCharacteristics) do
    local val = frame.list:Add("DPanel")
    val:SetSize(frame.list:GetWide(), 40)
    val.alt = alt
    function val:Paint(w,h)
      if self.alt then
        draw.RoundedBox(0,0,0,w,h,Color(35,35,40))
      end
    end

		print(#k)
    val.title = val:Add("DLabel")
    val.title:SetText(k)
    val.title:SetFont("nutSmallFont")
    val.title:SetColor(color_white)
    val.title:SetSize(val:GetWide()/2-10, val:GetTall())
    val.title:SetPos(10,0)

    local function styleTE(te)
      function te:Paint(w,h)
        if self:HasFocus() then
          draw.RoundedBox(4,0,0,w,h,color_white)
        else
          draw.RoundedBox(4,0,0,w,h,Color(210, 210, 210))
        end
        self:DrawTextEntryText(color_black,nut.config.get("color"),color_black)
      end
    end

    if not istable(v) and v == "string" then
      val.edit = val:Add("DTextEntry")
      val.edit:SetSize(val:GetWide()/2-10,val:GetTall()-10)
      val.edit:SetPos(val:GetWide()/2+5,5)
      styleTE(val.edit)
    elseif not istable(v) and v == "number" then
      val.edit = val:Add("DNumberWang")
      val.edit:SetSize(val:GetWide()/2-10,val:GetTall()-10)
      val.edit:SetPos(val:GetWide()/2+5,5)
      val.edit:SetMinMax(20,100)
      val.edit:SetDecimals(0)
      val.edit:SetValue(20)
      function val.edit:Think()
        if self:GetValue() > self:GetMax() then
          self:SetValue(self:GetMax())
        end
      end
      styleTE(val.edit)
    elseif istable(v) and v.valueType == "choice" then
      val.edit = val:Add("DComboBox")
      val.edit:SetSize(val:GetWide()/2-10,val:GetTall()-10)
      val.edit:SetPos(val:GetWide()/2+5,5)
      function val.edit:Paint(w,h)
        draw.RoundedBox(4,0,0,w,h,Color(200,200,200))
      end
      for _,c in pairs(v.choices) do
        local select = false
        if c == v.choices[1] then select = true end
        val.edit:AddChoice(c,nil,select)
      end
    end

		if fill then
			local cv = characs[k]
			if cv then
				val.edit:SetValue(cv)
			end
		end

    values[k] = val.edit

    alt = not alt
  end

  local finish = frame:Add("DButton")
  finish:SetText("Finish")
  finish:SetFont("nutSmallFont")
  finish:SetColor(color_white)
  finish:SetSize(frame:GetWide(),frame:GetTall()-frame.whatPanel:GetTall()-frame.scroll:GetTall())
  finish:SetPos(0,frame:GetTall()-finish:GetTall())
  function finish:Think()
    local disable = false
    for name,pnl in pairs(values) do
      if not pnl:GetValue() or pnl:GetValue() == "" then
        disable = true
        break
      end
    end
    self:SetDisabled(disable)
  end
  function finish:Paint(w,h)
    if self:GetDisabled() then
      draw.RoundedBoxEx(4,0,0,w,h,Color(30, 30, 30),false,false,true,true)
      return
    end

    if self:IsHovered() and not self:GetDisabled() then
      draw.RoundedBoxEx(4,0,0,w,h,Color(50,155,205),false,false,true,true)
    else
      draw.RoundedBoxEx(4,0,0,w,h,Color(45,150,200),false,false,true,true)
    end
  end
  function finish:DoClick()
    local vals = {}
    for k,v in pairs(values) do
      if v:GetValue() then
        vals[k] = v:GetValue()
      end
    end

    netstream.Start("setCharCharacteristics", vals, true)

    frame:AlphaTo(0,0.2,0,function()
      if frame and IsValid(frame) then
        frame:Remove()
      end
    end)
  end
end

netstream.Hook("missingCharacteristics", openMissingInfoMenu)

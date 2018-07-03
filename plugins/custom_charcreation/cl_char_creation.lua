local PANEL = {}
local gradient = surface.GetTextureID("vgui/gradient-u")
local gradient2 = surface.GetTextureID("vgui/gradient-d")

function PANEL:Init()
	local fadeSpeed = 1

	if (IsValid(nut.gui.loading)) then
		nut.gui.loading:Remove()
	end

	if (!nut.localData.intro) then
		timer.Simple(0.1, function()
			vgui.Create("nutIntro", self)
		end)
	else
		self:playMusic()
	end

	if (IsValid(nut.gui.char) or (LocalPlayer().getChar and LocalPlayer():getChar())) then
		nut.gui.char:Remove()
		fadeSpeed = 0
  end

  function self:OnKeyCodePressed(key)
    if key == KEY_F1 and fadeSpeed == 0 then
      self:Remove()
    end
  end

	nut.gui.char = self

	self:SetSize(ScrW(),ScrH())
	self:MakePopup()
	self:Center()
	self:ParentToHUD()

	self.darkness = self:Add("DPanel")
	self.darkness:Dock(FILL)
	self.darkness.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, h)
	end
	self.darkness:SetZPos(99)
  self.darkness:AlphaTo(0, 2 * fadeSpeed, 0, function()
		self.darkness:SetZPos(-99)
	end)

  self.sideBar = self:Add("DPanel")
  self.sideBar:SetSize(self:GetWide()/4, self:GetTall())
  self.sideBar:SetPos(0,0)
  function self.sideBar:Paint(w,h)
    nut.util.drawBlur(self, 4)
    draw.RoundedBox(0,0,0,w,h,Color(33, 34, 41, 240))
  end

	self.sideBar.title = self.sideBar:Add("DLabel")
	self.sideBar.title:SetContentAlignment(5)
	-- self.sideBar.title:SetText(L2("schemaName") or SCHEMA.name or L"unknown")
	self.sideBar.title:SetText("1940 Roleplay")
	self.sideBar.title:SetFont("nutBigFont")
	self.sideBar.title:SizeToContents()
  self.sideBar.title:SetPos(0, 64)
  self.sideBar.title:CenterHorizontal()
	self.sideBar.title:SetTextColor(color_white)
	self.sideBar.title:SetZPos(100)
	self.sideBar.title:SetAlpha(0)
	self.sideBar.title:AlphaTo(255, fadeSpeed, 3 * fadeSpeed)
	self.sideBar.title:SetExpensiveShadow(2, Color(0, 0, 0, 200))

	self.sideBar.subTitle = self.sideBar:Add("DLabel")
	self.sideBar.subTitle:SetContentAlignment(5)
	self.sideBar.subTitle:SetFont("nutMediumFont")
	-- self.sideBar.subTitle:SetText(L2("schemaDesc") or SCHEMA.desc or L"noDesc")
	self.sideBar.subTitle:SetText("Munich, Germany, Summer of 1941")
	self.sideBar.subTitle:SetTextColor(Color(170, 170, 170))

	self.sideBar.subTitle:SetPos(10, 64 + self.sideBar.title:GetTall() + 10)
	self.sideBar.subTitle:SetWrap(true)
	self.sideBar.subTitle:SetSize(self.sideBar:GetWide()-20,80)

	self.sideBar.subTitle:SetAlpha(0)
	self.sideBar.subTitle:AlphaTo(255, 4 * fadeSpeed, 3 * fadeSpeed)
	self.sideBar.subTitle:SetExpensiveShadow(2, Color(0, 0, 0, 200))

	local list = self:Add("DListLayout")
	list:SetSize(self.sideBar:GetWide(),self.sideBar:GetTall()/2)
	list:CenterVertical()

	local function putWPBeside(wp, panel)
		local bx, by = list:LocalToScreen(panel:GetPos())
		wp:SetPos(self.sideBar:GetWide(), by-(wp:GetTall()/2) + (panel:GetTall()/2))
	end

	local opts = {
  	["Choose Character"] = function(panel, btnPnl)
			function panel:Paint(w,h)
				nut.util.drawBlur(self, 4)
				draw.RoundedBox(0,0,0,w,h,Color(30, 30, 30, 240))
			end

			panel:SetSize(0,200)
			putWPBeside(panel, btnPnl)

			panel:SetAlpha(0)
			panel:AlphaTo(255,0.3)
			panel:SizeTo(self:GetWide()-self.sideBar:GetWide(),panel:GetTall(),0.5,0,-1,function()
				panel.scroll = panel:Add("DScrollPanel")
				panel.scroll:SetSize(panel:GetSize())
				panel.scroll:Center()

				panel.list = panel.scroll:Add("DIconLayout")
				panel.list:SetSize(panel.scroll:GetWide()-10, panel.scroll:GetTall()-10)
				panel.list:SetPos(5,5)
				panel.list:SetSpaceX(5)

				for k,v in pairs(nut.characters) do
					local char = nut.char.loaded[v]

					local c = panel.list:Add("DButton")
					c:SetText("")
					c:SetSize(panel.list:GetTall(), panel.list:GetTall()-6)
					function c:Paint(w,h)
						draw.RoundedBox(4,0,0,w,h,Color(45, 45, 45))
					end

					c:SetAlpha(0)
					c:AlphaTo(255,0.2,0,function()
						c.mdl = c:Add("DModelPanel")
						c.mdl:SetSize(c:GetSize())
						c.mdl:SetModel(char:getModel())
						c.mdl:SetFOV(20)
						local head = c.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") --Look at the model head
				    if head and head >= 0 then
				      c.mdl:SetLookAt(c.mdl.Entity:GetBonePosition(head))
				    end
						function c.mdl:LayoutEntity(ent)
				      ent:SetAngles(Angle(0,45,0))
				      ent:ResetSequence(2)
				    end
						function c.mdl.DoClick(this)
							if LocalPlayer():getChar() and LocalPlayer():getChar():getID() == v then
								nut.util.notify("You're currently using this character", LocalPlayer())
								return
							end

							self.darkness:SetZPos(999)
							self.darkness:AlphaTo(255,1,0,function()
								self.darkness:AlphaTo(0,0.5,0,function() self.darkness:Remove() self:Remove() end)
								netstream.Start("charChoose", v)
							end)
						end

						c.name = c:Add("DLabel")
						c.name:SetSize(c:GetWide(),30)
						c.name:SetText(char:getName())
						c.name:SetFont("nutSmallFont")
						c.name:SetColor(color_white)
						c.name:SetContentAlignment(5)
						function c.name:Paint(w,h)
            	draw.RoundedBox(0,0,0,w,h,Color(30,30,30,80))
						end
					end)

					timer.Simple(0.2,function()
						c.delete = c:Add("DButton")
						c.delete:SetText("Delete")
						c.delete:SetColor(color_white)
						c.delete:SetFont("nutSmallFont")
						c.delete:SetSize(c:GetWide(),25)
						c.delete:SetPos(0,c:GetTall()-c.delete:GetTall())
						c.delete:SetAlpha(0)
						c.delete:AlphaTo(255,0.2)
						c.delete:SetZPos(99)
						function c.delete:Paint(w,h)
							if self:IsHovered() then
								draw.RoundedBoxEx(4,0,0,w,h,Color(235,85,85),false,false,true,true)
							else
								draw.RoundedBoxEx(4,0,0,w,h,Color(225,75,75),false,false,true,true)
							end
						end
						function c.delete.DoClick(this)
							local menu = DermaMenu()
								local confirm = menu:AddSubMenu(L("delConfirm", char:getName()))
								confirm:AddOption(L"no"):SetImage("icon16/cross.png")
								confirm:AddOption(L"yes", function()
									netstream.Start("charDel", char:getID())
									self.wp:Remove()
								end):SetImage("icon16/tick.png")
							menu:Open()
						end
					end)
				end
			end)
		end,
		["Create Character"] = function(panel, btnPnl)
			function panel:Paint(w,h)
				nut.util.drawBlur(self, 4)
				draw.RoundedBox(0,0,0,w,h,Color(30, 30, 30, 240))
			end

			panel:SetSize(0,500)
			putWPBeside(panel, btnPnl)

			local payload = {}

			panel:SetAlpha(0)
			panel:AlphaTo(255,0.3)
			panel:SizeTo(self:GetWide()-self.sideBar:GetWide(),panel:GetTall(),0.5,0,-1,function()
				local function fillInfo()
					local mdl = panel:Add("DModelPanel")
					mdl:SetSize(panel:GetWide()/3,panel:GetTall())
					mdl:SetModel(nut.faction.indices[payload.faction].models[payload.model])
					mdl:SetFOV(35)
					mdl:SetAlpha(0)
					mdl:AlphaTo(255,0.2)
					local head = mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") --Look at the model head
			    if head and head >= 0 then
			      mdl:SetLookAt(mdl.Entity:GetBonePosition(head))
			    end
					function mdl:LayoutEntity(ent)
						ent:ResetSequence(2)
						ent:SetAngles(Angle(0,60,0))
					end
					function mdl:PaintOver(w,h)
						draw.RoundedBox(0,w-3,0,3,h,Color(100, 100, 100))
					end

					--Basic Informations
					local basicInfos = panel:Add("DPanel")
					basicInfos:SetSize(panel:GetWide()-mdl:GetWide(),170)
					basicInfos:SetPos(mdl:GetWide(),0)
					function basicInfos:Paint(w,h)
						draw.RoundedBox(0,0,h-3,w,3,Color(100,100,100))
					end

					basicInfos.title = basicInfos:Add("DLabel")
					basicInfos.title:SetText("Basic Information")
					basicInfos.title:SetFont("nutMediumFont")
					basicInfos.title:SetColor(color_white)
					basicInfos.title:SizeToContents()
					basicInfos.title:SetPos(5,10)

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

					local nameEntry = basicInfos:Add("DTextEntry")
					nameEntry:SetSize(200,30)
					nameEntry:SetPos(((basicInfos:GetWide()/2)/2)-nameEntry:GetWide()/2, basicInfos:GetTall()/2-nameEntry:GetTall()/2 +20)
					styleTE(nameEntry)

					local nameLabel = basicInfos:Add("DLabel")
					nameLabel:SetText("Name: ")
					nameLabel:SetFont("nutSmallFont")
					nameLabel:SetColor(color_white)
					nameLabel:SizeToContents()
					local x,y = nameEntry:GetPos()
					nameLabel:SetPos(x+nameEntry:GetWide()/2-nameLabel:GetWide()/2,y - nameLabel:GetTall()-10)

					local descEntry = basicInfos:Add("DTextEntry")
					descEntry:SetSize(200,30)
					descEntry:SetPos(((basicInfos:GetWide()/2)/2)*3-descEntry:GetWide()/2, basicInfos:GetTall()/2-descEntry:GetTall()/2 +20)
					styleTE(descEntry)

					local descLabel = basicInfos:Add("DLabel")
					descLabel:SetText("Description: ")
					descLabel:SetFont("nutSmallFont")
					descLabel:SetColor(color_white)
					descLabel:SizeToContents()
					local x,y = descEntry:GetPos()
					descLabel:SetPos(x+descEntry:GetWide()/2-descLabel:GetWide()/2,y - descLabel:GetTall()-10)

					--Additional information
					local add = panel:Add("DScrollPanel")
					add:SetSize(panel:GetWide()-mdl:GetWide(),panel:GetTall()-basicInfos:GetTall()-30)
					add:SetPos(mdl:GetWide(), basicInfos:GetTall())

					local list = add:Add("DIconLayout")
					list:SetSize(add:GetWide()-15, add:GetTall())

					local alt = true
				  local values = {}
				  for k,v in SortedPairs(charCharacteristics) do
				    local val = list:Add("DPanel")
				    val:SetSize(list:GetWide(), 40)
				    val.alt = alt
				    function val:Paint(w,h)
				      if self.alt then
								draw.RoundedBox(0,0,0,w,h,Color(35,35,40))
				      else
								draw.RoundedBox(0,0,0,w,h,Color(30,30,35))
							end
				    end

				    val.title = val:Add("DLabel")
				    val.title:SetText(k)
				    val.title:SetFont("nutSmallFont")
				    val.title:SetColor(color_white)
				    val.title:SetSize(val:GetWide()/2-10, val:GetTall())
				    val.title:SetPos(10,0)

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

				    values[k] = val.edit

				    alt = not alt
				  end

					local finish = panel:Add("DButton")
				  finish:SetText("Finish")
				  finish:SetFont("nutSmallFont")
				  finish:SetColor(color_white)
				  finish:SetSize(panel:GetWide()-mdl:GetWide(),panel:GetTall()-basicInfos:GetTall()-add:GetTall())
				  finish:SetPos(mdl:GetWide(),panel:GetTall()-finish:GetTall())
				  function finish:Think()
				    local disable = false
				    for name,pnl in pairs(values) do
				      if not pnl:GetValue() or pnl:GetValue() == "" or not nameEntry:GetValue() or nameEntry:GetValue() == "" or not descEntry:GetValue() or descEntry:GetValue() == "" then
				        disable = true
				        break
				      end
				    end
				    self:SetDisabled(disable)
				  end
				  function finish:Paint(w,h)
				    if self:GetDisabled() then
				      draw.RoundedBox(0,0,0,w,h,Color(30, 30, 30))
				      return
				    end

				    if self:IsHovered() and not self:GetDisabled() then
				      draw.RoundedBox(0,0,0,w,h,Color(50,155,205))
				    else
				      draw.RoundedBox(0,0,0,w,h,Color(45,150,200))
				    end
				  end
				  function finish:DoClick()
				    local vals = {}
				    for k,v in pairs(values) do
				      if v:GetValue() then
				        vals[k] = v:GetValue()
				      end
				    end

						payload.data = {}
						payload.name = nameEntry:GetValue()
						payload.desc = descEntry:GetValue()
		        payload.steamID = LocalPlayer():SteamID64()

		        for k,v in SortedPairsByMemberValue(nut.char.vars, "index") do --Checking the variables
		          local value = payload[k]

		          if v.onValidate then
		            local result = {v.onValidate(value, payload, LocalPlayer())}

		            if result[1] == false then
		              nut.util.notify(L(unpack(result,2)) or "Unknown Error", LocalPlayer())
		              return
		            end
		          end
		        end

						--Setting additonal information
						netstream.Start("setCharCharacteristics", vals, false)

						netstream.Start("charCreate", payload)
		        netstream.Hook("charAuthed", function(fault, ...) --Check for server response
		          if type(fault) == "string" then
		            nut.util.notify(L(fault,...))
		            return
		          end

		          if type(fault) == "table" then --Updating the characters table
		            nut.characters = fault
		          end

		          netstream.Start("charChoose", nut.characters[#nut.characters]) --Choose latest character
		          local darkness = vgui.Create("DPanel")
		          darkness:MakePopup()
		          function darkness:Paint(w,h) draw.RoundedBox(0,0,0,w,h,Color(0,0,0)) end
		          darkness:AlphaTo(255,1,1,function()
		            nut.gui.char:Remove()

		            darkness:AlphaTo(0,1,0,function()
		              if darkness and IsValid(darkness) then darkness:Remove() end
		            end)
		          end)
		        end)
					end
				end

				local function showModels(fac)
					panel.scroll = panel:Add("DScrollPanel")
					panel.scroll:SetSize(panel:GetSize())
					panel.list = panel.scroll:Add("DIconLayout")
					panel.list:SetSize(panel.scroll:GetSize())

					for k,v in pairs(fac.models) do
						local mp = panel.list:Add("DPanel")
						mp:SetSize(panel.list:GetWide()/4,panel.list:GetTall())
						mp.color = Color(0,0,0,0)
						function mp:Paint(w,h)
							draw.RoundedBox(0,0,0,w,h,self.color)
						end

						mp.mdl = mp:Add("DModelPanel")
						mp.mdl:SetSize(mp:GetSize())
						mp.mdl:SetModel(v)
						local spine = mp.mdl.Entity:LookupBone("ValveBiped.Bip01_Spine")
						if spine and spine >= 0 then
							mp.mdl:SetLookAt(mp.mdl.Entity:GetBonePosition(spine))
							mp.mdl:SetFOV(50)
						end
						function mp.mdl:LayoutEntity(ent)
							ent:ResetSequence(2)
							ent:SetAngles(Angle(0,45,0))
						end
						function mp.mdl:Think()
							if self:IsHovered() then
								mp.color = Color(55, 55, 55)
							else
								mp.color = Color(0,0,0,0)
							end
						end
						function mp.mdl:DoClick()
							for _,pnl in pairs(panel.list:GetChildren()) do
								pnl:AlphaTo(0,0.2,0,function()
									if pnl and IsValid(pnl) then
										pnl:Remove()
									end
								end)
							end

							payload.model = k
							fillInfo()
						end
					end
				end

				local function chooseFaction()
					local facs = {}
					for k,v in pairs(nut.faction.indices) do --Looking for joinable factions
						if v.isDefault == nil or v.isDefault == true then
							facs[#facs+1] = k
						end
					end

					panel.title = panel:Add("DLabel")
					panel.title:SetText("Choose your faction")
					panel.title:SetFont("nutMediumFont")
					panel.title:SetColor(color_white)
					panel.title:SetPos(10,10)
					panel.title:SizeToContents()

					--Displaying buttons
					local count = 0
					local buts = {}
					for k,v in pairs(facs) do
						local fac = nut.faction.indices[v]
						local w = panel:GetWide()/table.Count(facs)

						local fPanel = panel:Add("DPanel")
						fPanel:SetSize(w, panel:GetTall())
						fPanel:SetPos(0+(w*count), 0)
						fPanel.Paint = nil

						local f = fPanel:Add("DButton")
						f:SetText(fac.name)
						f:SetFont("nutSmallFont")
						f:SetColor(color_white)
						f:SetSize(200,40)
						f:Center()
						function f:Paint(w,h)
							if self:IsHovered() then
								draw.RoundedBox(0,0,0,w,h,fac.color)
							else
								draw.RoundedBox(0,0,0,w,h,Color(fac.color.r-5,fac.color.g-5,fac.color.b-5))
							end
						end
						function f:DoClick()
							payload.faction = v
							panel.title:AlphaTo(0,0.5,0,function() if panel.title and IsValid(panel.title) then panel.title:Remove() end end)
							for _,pnl in pairs(buts) do
								pnl:AlphaTo(0,0.2,0,function()
									pnl:Remove()
								end)
							end

							timer.Simple(0.4, function()
								showModels(fac)
							end)
						end

						buts[#buts+1] = f
						count = count+1
					end

				end
				chooseFaction()
			end)
		end,
		["Disconnect"] = function()
			RunConsoleCommand("disconnect")
		end
  }

	--Display the tabs
	local curTab
	local function createWorkPanel(callback)
		local delay = 0
		if self.wp and IsValid(self.wp) then
			self.wp:AlphaTo(0,0.2,0,function()
				if self.wp and IsValid(self.wp) then self.wp:Remove() end
			end)

			delay = 0.3
		end

		local wp = self:Add("DPanel")
		wp:SetSize(self:GetWide()-self.sideBar:GetWide(),self:GetTall())
		wp:SetPos(self.sideBar:GetWide(),0)
		wp.Paint = nil
		wp:SetAlpha(0)
		wp:AlphaTo(255,0.2,delay,function()
			self.wp = wp
			if callback then callback(wp) end
		end)

		return wp
	end
	local function switchTab(openFnc, btnPnl)
		for _,pnl in pairs(list:GetChildren()) do --Disable buttons
			pnl:SetDisabled(true)
		end

		local wp = createWorkPanel(function(wp)
			for _,pnl in pairs(list:GetChildren()) do --Disable buttons
				pnl:SetDisabled(false)
			end

			openFnc(wp, btnPnl)
		end)
	end

	for name,open in SortedPairs(opts) do
		local o = list:Add("DButton")
		AccessorFunc(o,"color","Color")
		o.color = Color(30, 30, 40, 0)
		o:SetTall(40)
		o:SetText(name)
		o:SetTextColor(color_white)
		o:SetFont("nutMediumFont")
		function o:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,self.color)

			if self == curTab then
				draw.RoundedBox(0,0,0,4,h,color_white)
			end
		end
		function o:OnCursorEntered()
			self:ColorTo(Color(30, 30, 40, 240),0.2)
		end
		function o:OnCursorExited()
			self:ColorTo(Color(30, 30, 40, 0),0.2)
		end

		function o:DoClick()
			if curTab == self then return end --Already in there
			curTab = self
			switchTab(open, self)
		end
	end

	--Resizing list
	list:SetTall(40*table.Count(opts))
	list:CenterVertical(0.4)

	self.icon = self:Add("DHTML")
	self.icon:SetPos(ScrW() - 96, 8)
	self.icon:SetSize(86, 86)
	self.icon:SetHTML([[
		<html>
			<body style="margin: 0; padding: 0; overflow: hidden;">
				<img src="]]..nut.config.get("logo", "http://nutscript.rocks/nutscript.png")..[[" width="86" height="86" />
			</body>
		</html>
	]])
	self.icon:SetToolTip(nut.config.get("logoURL", "http://nutscript.rocks"))

	self.icon.click = self.icon:Add("DButton")
	self.icon.click:Dock(FILL)
	self.icon.click.DoClick = function(this)
		gui.OpenURL(nut.config.get("logoURL", "http://nutscript.rocks"))
	end
	self.icon.click:SetAlpha(0)
	self.icon:SetAlpha(150)

	local x, y = ScrW() * 0.1, ScrH() * 0.3
	local i = 1

	self.buttons = {}
	surface.SetFont("nutMenuButtonFont")

end

function PANEL:playMusic()
	if (nut.menuMusic) then
		nut.menuMusic:Stop()
		nut.menuMusic = nil
	end

	timer.Remove("nutMusicFader")

	local source = nut.config.get("music", ""):lower()

	if (source:find("%S")) then
		local function callback(music, errorID, fault)
			if (music) then
				music:SetVolume(0.5)

				nut.menuMusic = music
				nut.menuMusic:Play()
			else
				MsgC(Color(255, 50, 50), errorID.." ")
				MsgC(color_white, fault.."\n")
			end
		end

		if (source:find("http")) then
			sound.PlayURL(source, "noplay", callback)
		else
			sound.PlayFile("sound/"..source, "noplay", callback)
		end
	end

	for k, v in ipairs(engine.GetAddons()) do
		if (v.wsid == "207739713" and v.mounted) then
			return
		end
	end

	Derma_Query(L"contentWarning", L"contentTitle", L"yes", function()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=207739713")
	end, L"no")
end

function PANEL:OnRemove()
	if (nut.menuMusic) then
		local fraction = 1
		local start, finish = RealTime(), RealTime() + 10

		timer.Create("nutMusicFader", 0.1, 0, function()
			if (nut.menuMusic) then
				fraction = 1 - math.TimeFraction(start, finish, RealTime())
				nut.menuMusic:SetVolume(fraction * 0.5)

				if (fraction <= 0) then
					nut.menuMusic:Stop()
					nut.menuMusic = nil

					timer.Remove("nutMusicFader")
				end
			else
				timer.Remove("nutMusicFader")
			end
		end)
	end
end
vgui.Register("nutCharMenu", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "nutCharButton", function(tabs)
	tabs["Characters"] = function(panel)
		nut.gui.menu:Remove()
		vgui.Create("nutCharMenu")
	end
end)
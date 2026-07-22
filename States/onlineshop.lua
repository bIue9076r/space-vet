-- Online Shop
G_STATE_ONLINE_SHOP = 7

Computor_Back = {195/255, 176/255, 145/255}
Computor_Back2 = {195/255/2, 176/255/2, 145/255/2}
Computor_Color = {0, 130/255, 129/255}
Computor_Gray = {192/255,192/255,192/255}
Computor_DarkGray = {128/255,128/255,128/255}
Computor_White = {1,1,1}
Computor_Black = {0,0,0}
Computor_Blue = {0,0,128/255}

Computor_Exit_Button = Button.new(55,520,60,25)

function ShopSetup()
	Shop.clearGoods()
	-- Shop.newGood(StringFetch(45),200)
	-- Shop.newGood(StringFetch(46),500)
	-- Shop.newGood(StringFetch(47),1000)
end

function ShopPostoArrow(n)
	local n = n or math.max(Shop.position, Shop.lowerWindow)
	local l = Shop.lowerWindow

	return 20*(n - l)
end

function Computor_String()
	if G_DAY <= 1 then
		return 18, 19
	elseif G_DAY == 2 then
		return 22, 23
	elseif G_DAY == 3 then
		return 24, 25
	elseif G_DAY == 4 then
		return 26, 27
	elseif G_DAY == 5 then
		return 28, 29
	end

	return 30, 31
end

function Computor_Notepad_1(self)
	-- local self.Npx, self.Npy, self.Npw, self.Nph = 60,60,300,300
	love.graphics.setColor(Computor_Gray)
	love.graphics.rectangle("fill",self.Npx,self.Npy,self.Npw,self.Nph)

	love.graphics.setColor(Computor_Black)
	love.graphics.rectangle("fill",self.Npx,self.Npy+self.Nph,self.Npw+1,1)
	love.graphics.rectangle("fill",self.Npx+self.Npw,self.Npy,1,self.Nph+1)

	love.graphics.setColor(Computor_White)
	love.graphics.rectangle("fill",self.Npx,self.Npy,self.Npw,1)
	love.graphics.rectangle("fill",self.Npx,self.Npy,1,self.Nph)

	love.graphics.setColor(Computor_Blue)
	love.graphics.rectangle("fill",self.Npx+1,self.Npy+1,self.Npw-2,25)

	love.graphics.setColor(Computor_White)
	love.graphics.print({Computor_White,StringFetch(16)},self.Npx+5,self.Npy)
	love.graphics.rectangle("fill",self.Npx+5,self.Npy+30,self.Npw-10,self.Nph-35)

	love.graphics.setColor(Computor_DarkGray)
	love.graphics.rectangle("fill",self.Npx+5,self.Npy+30,self.Npw-10,1)
	love.graphics.rectangle("fill",self.Npx+5,self.Npy+30,1,self.Nph-35)

	love.graphics.setColor(Computor_White)
	local s2,s3 = Computor_String()
	love.graphics.printf({Computor_Black,StringFetch(17).."\n",Computor_Black,StringFetch(s2).."\n",Computor_Black,StringFetch(s3)},self.Npx+10,self.Npy+30,self.Npw-20,"left")
end

function Computor_Notepad_2(self)
	-- local self.Sx, self.Sy, self.Sw, self.Sh = 400,190,300,200
	love.graphics.setColor(Computor_Gray)
	love.graphics.rectangle("fill",self.Sx,self.Sy,self.Sw,self.Sh)

	love.graphics.setColor(Computor_Black)
	love.graphics.rectangle("fill",self.Sx,self.Sy+self.Sh,self.Sw+1,1)
	love.graphics.rectangle("fill",self.Sx+self.Sw,self.Sy,1,self.Sh+1)

	love.graphics.setColor(Computor_White)
	love.graphics.rectangle("fill",self.Sx,self.Sy,self.Sw,1)
	love.graphics.rectangle("fill",self.Sx,self.Sy,1,self.Sh)

	love.graphics.setColor(Computor_Blue)
	love.graphics.rectangle("fill",self.Sx+1,self.Sy+1,self.Sw-2,25)

	love.graphics.setColor(Computor_White)
	love.graphics.print({Computor_White,StringFetch(32)},self.Sx+5,self.Sy)
	love.graphics.rectangle("fill",self.Sx+5,self.Sy+30,self.Sw-10,self.Sh-35)

	love.graphics.setColor(Computor_DarkGray)
	love.graphics.rectangle("fill",self.Sx+5,self.Sy+30,self.Sw-10,1)
	love.graphics.rectangle("fill",self.Sx+5,self.Sy+30,1,self.Sh-35)

	love.graphics.setColor(Computor_White)
	love.graphics.printf({
		Computor_Black,StringFetch(33)..tostring(G_STATS.Pets).."\n",
		Computor_Black,StringFetch(34)..tostring(G_STATS.Pills_Used).."\n",
		Computor_Black,StringFetch(35)..tostring(G_STATS.Bandades_Used).."\n",
		Computor_Black,StringFetch(36)..tostring(G_STATS.Hammer_Used).."\n",
		Computor_Black,StringFetch(37)..tostring(G_STATS.Baths_Taken).."\n",
		Computor_Black,StringFetch(38)..tostring(G_STATS.Naps_Taken)
	},self.Sx+10,self.Sy+30,self.Sw-20,"left")
end

function Computor_Shop(self)
	love.graphics.setColor(Computor_Gray)
	love.graphics.rectangle("fill",self.Shx,self.Shy,self.Shw,self.Shh)

	love.graphics.setColor(Computor_Black)
	love.graphics.rectangle("fill",self.Shx,self.Shy+self.Shh,self.Shw+1,1)
	love.graphics.rectangle("fill",self.Shx+self.Shw,self.Shy,1,self.Shh+1)

	love.graphics.setColor(Computor_White)
	love.graphics.rectangle("fill",self.Shx,self.Shy,self.Shw,1)
	love.graphics.rectangle("fill",self.Shx,self.Shy,1,self.Shh)

	love.graphics.setColor(Computor_Blue)
	love.graphics.rectangle("fill",self.Shx+1,self.Shy+1,self.Shw-2,25)

	love.graphics.setColor(Computor_White)
	love.graphics.print({Computor_White,StringFetch(44)},self.Shx+5,self.Shy)
	love.graphics.rectangle("fill",self.Shx+5,self.Shy+30,self.Shw-10,self.Shh-35)

	love.graphics.setColor(Computor_DarkGray)
	love.graphics.rectangle("fill",self.Shx+5,self.Shy+30,self.Shw-10,1)
	love.graphics.rectangle("fill",self.Shx+5,self.Shy+30,1,self.Shh-35)

	love.graphics.setColor(Computor_White)

	local itms = Shop.getRange()
	if #itms > 0 then
		love.graphics.draw(Image.get("Arrow_red"),self.Shx+10,self.Shy+30+ShopPostoArrow())
	end
	for i = 1,#itms do
		if itms[i].good then
			if itms[i].good.bought then
				love.graphics.print({Computor_Black,itms[i].good.name.." - SOLD"},self.Shx+10+30,self.Shy+30+ShopPostoArrow(itms[i].index))
			else
				love.graphics.print({Computor_Black,itms[i].good.name.." - $"..string.format("%d",itms[i].good.cost)},self.Shx+10+30,self.Shy+30+ShopPostoArrow(itms[i].index))
			end
		end
	end

	self.Sho_button_1.x = self.Shx+15
	self.Sho_button_1.y = self.Shy+(200-40)
	self.Sho_button_1.ix = self.Sho_button_1.x
	self.Sho_button_1.iy = self.Sho_button_1.y
	self.Sho_button_1:draw()

	self.Sho_button_2.x = self.Shx+(150-12.5)
	self.Sho_button_2.y = self.Shy+(200-40)
	self.Sho_button_2.ix = self.Sho_button_2.x
	self.Sho_button_2.iy = self.Sho_button_2.y
	self.Sho_button_2:draw()

	self.Sho_button_3.x = self.Shx+(300-40)
	self.Sho_button_3.y = self.Shy+(200-40)
	self.Sho_button_3.ix = self.Sho_button_3.x
	self.Sho_button_3.iy = self.Sho_button_3.y
	self.Sho_button_3:draw()
end

Computor_Windows = {
	[1] = Computor_Notepad_1,
	[2] = Computor_Notepad_2,
	[3] = Computor_Shop,
}

function Computor_Swap(self,n)
	local t = {n}
	for i = 1,#self.windows do
		if not (self.windows[i] == n) then
			table.insert(t,self.windows[i])
		end
	end
	
	for i = 1,#t do
		self.windows[i] = t[i]
	end
end

G_STATE_ONLINE_SHOP_SUBSTATES = {
	[1] = {
		Npx = 60, Npy = 60,
		Npw = 300, Nph = 300,
		Np = Button.new(0,0,298,25),

		Sx = 415, Sy = 300,
		Sw = 300, Sh = 200,
		S = Button.new(0,0,298,25),

		Shx = 415, Shy = 75,
		Shw = 300, Shh = 200,
		Sho = Button.new(0,0,298,25),

		Sho_button_1 = Button.new(0,0,25,25,"Arrow_left"),
		Sho_button_2 = Button.new(0,0,25,25,"Check"),
		Sho_button_3 = Button.new(0,0,25,25,"Arrow_right"),

		windows = {3,1,2},
		ox = 0, oy = 0,
		oread = true,
		fo = true,

		Draw = function(self)
			self.Np.x, self.Np.y = self.Npx + 1, self.Npy + 1
			self.S.x, self.S.y = self.Sx + 1, self.Sy + 1
			self.Sho.x, self.Sho.y = self.Shx + 1, self.Shy + 1

			love.graphics.setColor(Computor_Back)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
			love.graphics.setColor(Computor_Back2)
			love.graphics.rectangle("fill",35,35,SCREEN_X-70,SCREEN_Y-70)

			love.graphics.setColor(Computor_Color)
			love.graphics.rectangle("fill",50,50,700,500)

			love.graphics.setColor(Computor_White)
			love.graphics.rectangle("fill",50,514,700,1)

			love.graphics.setColor(Computor_Gray)
			love.graphics.rectangle("fill",50,515,700,35)
			
			if not Computor_Exit_Button.f then
				love.graphics.setColor(Computor_Black)
				love.graphics.rectangle("fill",115,520,1,25)
				love.graphics.rectangle("fill",55,545,61,1)

				love.graphics.setColor(Computor_White)
				love.graphics.rectangle("fill",55,520,60,1)
				love.graphics.rectangle("fill",55,520,1,25)

				love.graphics.print({Computor_Black,StringFetch(3)},60,520)
			else
				love.graphics.setColor(Computor_White)
				love.graphics.rectangle("fill",115,520,1,25)
				love.graphics.rectangle("fill",55,545,61,1)

				love.graphics.setColor(Computor_Black)
				love.graphics.rectangle("fill",55,520,60,1)
				love.graphics.rectangle("fill",55,520,1,25)

				love.graphics.print({Computor_Black,StringFetch(3)},61,521)
			end

			for i = #self.windows, 1, -1 do
				Computor_Windows[self.windows[i]](self)
			end

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Music()
		end,

		Update = function(self,dt)
			local x, y = NormalizeMouse(love.mouse.getPosition())

			if love.mouse.isDown(1) then
				if (not self.Np.f) and (self.fo) then
					self.fo = false
					self.S:focus(x,y)
					self.Sho:focus(x,y)
				end

				if (not self.S.f) and (self.fo) then
					self.fo = false
					self.Np:focus(x,y)
					self.Sho:focus(x,y)
				end

				if (not self.Sho.f) and (self.fo) then
					self.fo = false
					self.S:focus(x,y)
					self.Np:focus(x,y)
				end

				if self.Np.f then
					Computor_Swap(self,1)
					if self.oread then
						self.ox, self.oy = x - self.Np.x, y - self.Np.y
						self.oread = false
					end

					self.Npx = math.max(50,math.min(750 - self.Npw,x - self.ox))
					self.Npy = math.max(50,math.min(516 - self.Nph,y - self.oy))
				end

				if self.S.f then
					Computor_Swap(self,2)
					if self.oread then
						self.ox, self.oy = x - self.S.x, y - self.S.y
						self.oread = false
					end

					self.Sx = math.max(50,math.min(750 - self.Sw,x - self.ox))
					self.Sy = math.max(50,math.min(516 - self.Sh,y - self.oy))
				end

				if self.Sho.f then
					Computor_Swap(self,3)
					if self.oread then
						self.ox, self.oy = x - self.Sho.x, y - self.Sho.y
						self.oread = false
					end

					self.Shx = math.max(50,math.min(750 - self.Shw,x - self.ox))
					self.Shy = math.max(50,math.min(516 - self.Shh,y - self.oy))
				end
			else
				self.fo = true
				self.oread = true
				self.S:focus(x,y)
				self.Np:focus(x,y)
				self.Sho:focus(x,y)
			end

			Computor_Exit_Button:focus(x,y)

			if self.windows[1] == 3 then
				-- Store buttons
				self.Sho_button_1:focus(x,y)
				self.Sho_button_2:focus(x,y)
				self.Sho_button_3:focus(x,y)
			end
		end,

		Keypressed = function(self,key)
			if G_KEY_DOWN(key) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
			end
		end,

		Mousepressed = function(self,x,y,button)
			x, y = NormalizeMouse(x,y)

			if Computor_Exit_Button:click(x,y) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
			end

			if self.windows[1] == 3 then
				-- Store buttons
				if self.Sho_button_1:click(x,y) then
					if not Shop.positionDiminish() then
						Play_Sfx("No_money")
					end
				end

				if self.Sho_button_2:click(x,y) then
					if not Shop.select() then
						Play_Sfx("No_money")
					end
				end

				if self.Sho_button_3:click(x,y) then
					if not Shop.positionAdvance() then
						Play_Sfx("No_money")
					end
				end
			end
		end
	}
}


G_DRAW[G_STATE_ONLINE_SHOP] = function()
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_ONLINE_SHOP] = function(dt)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_ONLINE_SHOP] = function(key)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_ONLINE_SHOP] = function(x,y,button)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

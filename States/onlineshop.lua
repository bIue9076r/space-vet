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

G_STATE_ONLINE_SHOP_SUBSTATES = {
	[1] = {
		Npx = 60, Npy = 60,
		Npw = 300, Nph = 300,
		Np = Button.new(0,0,298,25),

		Sx = 400, Sy = 190,
		Sw = 300, Sh = 200,
		S = Button.new(0,0,298,25),

		swap = false,
		ox = 0, oy = 0,
		oread = true,
		fo = true,

		Draw = function(self)
			self.Np.x, self.Np.y = self.Npx + 1, self.Npy + 1
			self.S.x, self.S.y = self.Sx + 1, self.Sy + 1
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

			if self.swap then
				Computor_Notepad_1(self)
				Computor_Notepad_2(self)
			else
				Computor_Notepad_2(self)
				Computor_Notepad_1(self)
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
				end

				if (not self.S.f) and (self.fo) then
					self.fo = false
					self.Np:focus(x,y)
				end

				if self.Np.f then
					self.swap = false
					if self.oread then
						self.ox, self.oy = x - self.Np.x, y - self.Np.y
						self.oread = false
					end

					self.Npx = math.max(50,math.min(750 - self.Npw,x - self.ox))
					self.Npy = math.max(50,math.min(516 - self.Nph,y - self.oy))
				end

				if self.S.f then
					self.swap = true
					if self.oread then
						self.ox, self.oy = x - self.S.x, y - self.S.y
						self.oread = false
					end

					self.Sx = math.max(50,math.min(750 - self.Sw,x - self.ox))
					self.Sy = math.max(50,math.min(516 - self.Sh,y - self.oy))
				end
			else
				self.fo = true
				self.oread = true
				self.S:focus(x,y)
				self.Np:focus(x,y)
			end

			Computor_Exit_Button:focus(x,y)
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

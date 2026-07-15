-- Main Menu
G_STATE_MAIN_MENU = 2

G_STATE_MAIN_MENU_SUB = 1
G_STATE_MAIN_MENU_SUBSTATES = {
	[1] = {
		NewGame_b = Button.new(90,95,85,25),
		LoadGame_b = Button.new(390,95,85,25),
		Settings_b = Button.new(90,295,85,25),
		Resume_b = Button.new(390,295,85,25),
		Save_b = Button.new(90,495,85,25),

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)

			-- Main menu
			love.graphics.print({{0,0,0},StringFetch(2)},50,50)
			
			-- New game
			if not self.NewGame_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.NewGame_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",90,95,85,25)
			love.graphics.print({{0,0,0},StringFetch(4)},100,100)

			if G_SAVE then
				-- Load game
				if not self.LoadGame_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.LoadGame_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
				love.graphics.rectangle("fill",390,95,85,25)
				love.graphics.print({{0,0,0},StringFetch(5)},400,100)
			end

			-- Settings
			if not self.Settings_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Settings_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",90,295,85,25)
			love.graphics.print({{0,0,0},StringFetch(6)},100,300)

			if G_PLAYING then
				--Resume
				if not self.Resume_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Resume_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
				love.graphics.rectangle("fill",390,295,85,25)
				love.graphics.print({{0,0,0},StringFetch(7)},400,300)

				-- Save
				if not self.Save_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Save_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
				love.graphics.rectangle("fill",90,495,85,25)
				love.graphics.print({{0,0,0},StringFetch(8)},100,500)
			end
			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.NewGame_b:focus(x,y)
			self.Settings_b:focus(x,y)
			self.LoadGame_b:focus(x,y)
			self.Resume_b:focus(x,y)
			self.Save_b:focus(x,y)
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			-- Start new game
			local nx, ny = NormalizeMouse(x,y)
			if self.NewGame_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE = G_STATE_OUTSIDE

				G_MUSIC_PLAYING = true
			if not G_PLAYING then
				G_MUSIC_NEW()
			else
				G_STATE = G_LAST_STATE
			end

			if G_MUSIC_SONG then
				G_MUSIC_SONG:play()
			end

			G_PLAYING = true
			end

			-- Load previous save
			local nx, ny = NormalizeMouse(x,y)
			if self.LoadGame_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 3
				
			end

			-- Open settings sub menu
			local nx, ny = NormalizeMouse(x,y)
			if self.Settings_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 2
			end

			-- Resume game
			local nx, ny = NormalizeMouse(x,y)
			if self.Resume_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE = G_LAST_STATE

				G_MUSIC_PLAYING = true
			if not G_PLAYING then
				G_MUSIC_NEW()
			else
				G_STATE = G_LAST_STATE
			end

			if G_MUSIC_SONG then
				G_MUSIC_SONG:play()
			end

			G_PLAYING = true
			end

			-- Save game
			local nx, ny = NormalizeMouse(x,y)
			if self.Save_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 4
			end
		end
	},

	[2] = {
		Back_b = Button.new(600,495,85,25),

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Settings
			love.graphics.print({{0,0,0},StringFetch(9)},50,50)

			-- Back button
			if not self.Back_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Back_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",630,495,85,25)
			love.graphics.print({{0,0,0},StringFetch(10)},650,500)

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Back_b:focus(x,y)
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 1
			end

		end

	},
	[3] = {
		Back_b = Button.new(600,495,85,25),
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Settings
			love.graphics.print({{0,0,0},StringFetch(11)},50,50)

			-- Back button
			if not self.Back_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Back_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",630,495,85,25)
			love.graphics.print({{0,0,0},StringFetch(10)},650,500)

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Back_b:focus(x,y)
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 1
			end

		end
	},
	[4] = {
		Back_b = Button.new(600,495,85,25),
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Settings
			love.graphics.print({{0,0,0},StringFetch(12)},50,50)

			-- Back button
			if not self.Back_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Back_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",630,495,85,25)
			love.graphics.print({{0,0,0},StringFetch(10)},650,500)

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Back_b:focus(x,y)
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				Play_Sfx("ding",0.1)
				G_STATE_MAIN_MENU_SUB = 1
			end

		end
	}
}


G_DRAW[G_STATE_MAIN_MENU] = function()
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_MAIN_MENU] = function(dt)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_MAIN_MENU] = function(key)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_MAIN_MENU] = function(x,y,button)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

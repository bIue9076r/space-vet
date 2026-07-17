-- Main Menu
G_STATE_MAIN_MENU = 2

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
			Play_Sfx("ding",0.1)
			-- Start new game
			local nx, ny = NormalizeMouse(x,y)
			if self.NewGame_b:click(nx,ny) then
				G_MUSIC_PLAYING = true
				G_STATE = G_STATE_OUTSIDE
				G_STATE_SUB = 1
				
				if G_MUSIC_SONG then
					G_MUSIC_SONG:stop()
				end

				G_MUSIC_NEW()

				if G_MUSIC_SONG then
					G_MUSIC_SONG:play()
				end

				G_PLAYING = true
				New_Game()
			end

			-- Load previous save
			if self.LoadGame_b:click(nx,ny) then
				G_STATE_SUB = 3
				
			end

			-- Open settings sub menu
			if self.Settings_b:click(nx,ny) then
				G_STATE_SUB = 2
			end

			-- Resume game
			if self.Resume_b:click(nx,ny) then
				G_MUSIC_PLAYING = true
				G_STATE = G_LAST_STATE
				if G_MUSIC_SONG then
					G_MUSIC_SONG:play()
				end
			end

			-- Save game
			if self.Save_b:click(nx,ny) then
				G_STATE_SUB = 4
			end
		end
	},

	[2] = {
		Back_b = Button.new(600,495,85,25),
		Mute_b = Button.new(50,250,25,25),
		Main_Volume_Up = Button.new(50,100,25,25),
		Main_Volume_Down = Button.new(100,100,25,25),
		Music_Volume_Up = Button.new(50,150,25,25),
		Music_Volume_Down = Button.new(100,150,25,25),
		SFX_Volume_Up = Button.new(50,200,25,25),
		SFX_Volume_Down = Button.new(100,200,25,25),

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

			self.Mute_b:draw()
			self.Main_Volume_Up:draw()
			self.Main_Volume_Down:draw()
			self.Music_Volume_Up:draw()
			self.Music_Volume_Down:draw()
			self.SFX_Volume_Up:draw()
			self.SFX_Volume_Down:draw()

			love.graphics.print({{0,0,0},Main_Volume},150,100)
			love.graphics.print({{0,0,0},Music_Volume},150,150)
			love.graphics.print({{0,0,0},SFX_Volume},150,200)

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Back_b:focus(x,y)
			self.Mute_b:focus(x,y)
			self.Main_Volume_Up:focus(x,y)
			self.Main_Volume_Down:focus(x,y)
			self.Music_Volume_Up:focus(x,y)
			self.Music_Volume_Down:focus(x,y)
			self.SFX_Volume_Up:focus(x,y)
			self.SFX_Volume_Down:focus(x,y)
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			Play_Sfx("ding",0.1)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				G_STATE_SUB = 1
			end

			if self.Mute_b:click(nx,ny) then
				Main_Volume = 0
				love.audio.setVolume(Main_Volume)
			end

			if self.Main_Volume_Up:click(nx,ny) then
				Main_Volume = math.min(1,Main_Volume + 0.1)
				love.audio.setVolume(Main_Volume)
			end

			if self.Main_Volume_Down:click(nx,ny) then
				Main_Volume = math.max(0,Main_Volume - 0.1)
				love.audio.setVolume(Main_Volume)
			end

			if self.Music_Volume_Up:click(nx,ny) then
				Music_Volume = math.min(1,Music_Volume + 0.1)
			end

			if self.Music_Volume_Down:click(nx,ny) then
				Music_Volume = math.max(0,Music_Volume - 0.1)
			end

			if self.SFX_Volume_Up:click(nx,ny) then
				SFX_Volume = math.min(1,SFX_Volume + 0.1)
			end

			if self.SFX_Volume_Down:click(nx,ny) then
				SFX_Volume = math.max(0,SFX_Volume - 0.1)
			end
		end
	},

	[3] = {
		Back_b = Button.new(600,495,85,25),
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Load
			love.graphics.print({{0,0,0},StringFetch(5)},50,50)

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
			Play_Sfx("ding",0.1)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				G_STATE_SUB = 1
			end
		end
	},

	[4] = {
		Back_b = Button.new(600,495,85,25),
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Save
			love.graphics.print({{0,0,0},StringFetch(8)},50,50)

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
			Play_Sfx("ding",0.1)
			local nx, ny = NormalizeMouse(x,y)
			if self.Back_b:click(nx,ny) then
				G_STATE_SUB = 1
			end
		end
	}
}


G_DRAW[G_STATE_MAIN_MENU] = function()
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_MAIN_MENU] = function(dt)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_MAIN_MENU] = function(key)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_MAIN_MENU] = function(x,y,button)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

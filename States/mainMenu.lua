-- Main Menu
G_STATE_MAIN_MENU = 2

G_STATE_MAIN_MENU_SUBSTATES = {
	[1] = {
		NewGame_b = Button.new(90,95,85,25),
		LoadGame_b = Button.new(90,155,85,25),
		Settings_b = Button.new(90,295,85,25),
		Resume_b = Button.new(630,495,85,25),
		Save_b = Button.new(90,215,85,25),
		Credits_b = Button.new(90,435,85,25),
		ExitGame_b = Button.new(90,495,85,25),

		Saved_t = 0,
		Loaded_t = 0,

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)

			-- Main menu
			love.graphics.print({{0,0,0},StringFetch(2)},Font.get("Spacy_3"),50,30)

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
				love.graphics.rectangle("fill",90,155,85,25)
				love.graphics.print({{0,0,0},StringFetch(5)},100,160)
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
				love.graphics.rectangle("fill",630,495,85,25)
				love.graphics.print({{0,0,0},StringFetch(7)},640,500)

				-- Save
				if not self.Save_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.Save_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",90,215,85,25)
				love.graphics.print({{0,0,0},StringFetch(8)},100,220)
			end

			-- Credits
			if not self.Credits_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.Credits_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",90,435,85,25)
			love.graphics.print({{0,0,0},StringFetch(15)},100,440)
			

			-- Exit the game
			if not self.ExitGame_b.f then
				love.graphics.setColor(1,1,1)
			else
				local t = math.min(self.ExitGame_b.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",90,495,85,25)
			love.graphics.print({{0,0,0},StringFetch(14)},100,500)

			if (self.Saved_t > 0) then
				self.Saved_t = self.Saved_t - G_DT()
				love.graphics.print({{0,0,0},StringFetch(21)},200,220)
			end
			
			if (self.Loaded_t > 0) then
				self.Loaded_t = self.Loaded_t - G_DT()
				love.graphics.print({{0,0,0},StringFetch(20)},200,160)
			end

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.NewGame_b:focus(x,y)
			self.Settings_b:focus(x,y)
			if G_SAVE then
				self.LoadGame_b:focus(x,y)
			end
			if G_PLAYING then
				self.Resume_b:focus(x,y)
				self.Save_b:focus(x,y)
			end
			self.ExitGame_b:focus(x,y)
			self.Credits_b:focus(x,y)
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

			if G_SAVE then
				-- Load previous save
				if self.LoadGame_b:click(nx,ny) then
					Load_Game(G_SAVE_PATH)
					self.Loaded_t = 1
				end
			end

			-- Open settings sub menu
			if self.Settings_b:click(nx,ny) then
				G_STATE_SUB = 2
			end

			if G_PLAYING then
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
					Save_Game(G_SAVE_PATH)
					self.Saved_t = 1
				end
			end
			
			-- Credits
			if self.Credits_b:click(nx,ny) then
				G_STATE = 9
			end

			-- Exit game
			if self.ExitGame_b:click(nx,ny) then
				love.event.quit()
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
			love.graphics.print({{0,0,0},StringFetch(9)},Font.get("Spacy_3"),50,30)

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
		Load_b = Button.new(),

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Load
			love.graphics.print({{0,0,0},StringFetch(5)},Font.get("Spacy_3"),50,30)

			-- Load button
			local x,y = NormalizeMouse(love.mouse.getPosition())
			love.graphics.setColor(1,0,1)
			-- love.graphics.rectangle("fill",x,y,85,25)

			-- Load aera
			love.graphics.printf({{0,0,0},StringFetch(V)},50,100,500)

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
			print(nx-50,ny-100)
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
			love.graphics.print({{0,0,0},StringFetch(8)},Font.get("Spacy_3"),50,30)

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

-- Main Menu
G_STATE_MAIN_MENU = 2

G_STATE_MAIN_MENU_SUBSTATES = {
	[1] = {
		NewGame_b = Button.new(90,95,140,70),
		LoadGame_b = Button.new(90,95+80,140,70),
		Save_b = Button.new(90,95+80*2,140,70),
		Settings_b = Button.new(90,95+80*3,140,70),
		Credits_b = Button.new(90,95+80*4,140,70),
		Resume_b = Button.new(630,95+80*5,140,70),
		ExitGame_b = Button.new(90,95+80*5,140,70),

		Saved_t = 0,
		Loaded_t = 0,

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)

			-- Main menu
			love.graphics.print({{0,0,0},StringFetch(2)},Font.get("Spacy_3"),50,30)

			-- New game
			if G_DEBUG then
				if not self.NewGame_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.NewGame_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",self.NewGame_b.x,self.NewGame_b.y,self.NewGame_b.w,self.NewGame_b.h)
			end
			local off = 0
			if not self.NewGame_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.NewGame_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button"),self.NewGame_b.x,self.NewGame_b.y + off)
			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},StringFetch(4)},self.NewGame_b.x + 27,self.NewGame_b.y + 24 + off)

			if G_SAVE then
				-- Load game
				if G_DEBUG then
					if not self.LoadGame_b.f then
						love.graphics.setColor(1,1,1)
					else
						local t = math.min(self.LoadGame_b.t/0.125,1)
						love.graphics.setColor(1*(1 - t),t,1*(1 - t))
					end
					love.graphics.rectangle("fill",self.LoadGame_b.x,self.LoadGame_b.y,self.LoadGame_b.w,self.LoadGame_b.h)
				end
				off = 0
				if not self.LoadGame_b.f then
					love.graphics.setColor(G_CLEAR)
				else
					local t = math.min(self.LoadGame_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
				end
				love.graphics.draw(Image.get("button"),self.LoadGame_b.x,self.LoadGame_b.y + off)
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},StringFetch(5)},self.LoadGame_b.x + 27,self.LoadGame_b.y + 24 + off)
			end

			-- Settings
			if G_DEBUG then
				if not self.Settings_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.Settings_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",self.Settings_b.x,self.Settings_b.y,self.Settings_b.w,self.Settings_b.h)
			end
			off = 0
			if not self.Settings_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Settings_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button"),self.Settings_b.x,self.Settings_b.y + off)
			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},StringFetch(6)},self.Settings_b.x + 27,self.Settings_b.y + 24 + off)

			if G_PLAYING then
				--Resume
				if G_DEBUG then
					if not self.Resume_b.f then
						love.graphics.setColor(1,1,1)
					else
						local t = math.min(self.Resume_b.t/0.125,1)
						love.graphics.setColor(1*(1 - t),t,1*(1 - t))
					end
					love.graphics.rectangle("fill",self.Resume_b.x,self.Resume_b.y,self.Resume_b.w,self.Resume_b.h)
				end
				off = 0
				if not self.Resume_b.f then
					love.graphics.setColor(G_CLEAR)
				else
					local t = math.min(self.Resume_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
				end
				love.graphics.draw(Image.get("button"),self.Resume_b.x,self.Resume_b.y + off)
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},StringFetch(7)},self.Resume_b.x + 27,self.Resume_b.y + 24 + off)

				-- Save
				if G_DEBUG then
					if not self.Save_b.f then
						love.graphics.setColor(1,1,1)
					else
						local t = math.min(self.Save_b.t/0.125,1)
						love.graphics.setColor(1*(1 - t),t,1*(1 - t))
					end
					love.graphics.rectangle("fill",self.Save_b.x,self.Save_b.y,self.Save_b.w,self.Save_b.h)
				end
				off = 0
				if not self.Save_b.f then
					love.graphics.setColor(G_CLEAR)
				else
					local t = math.min(self.Save_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
				end
				love.graphics.draw(Image.get("button"),self.Save_b.x,self.Save_b.y + off)
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},StringFetch(8)},self.Save_b.x + 27,self.Save_b.y + 24 + off)
			end

			-- Credits
			if G_DEBUG then
				if not self.Credits_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.Credits_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",self.Credits_b.x,self.Credits_b.y,self.Credits_b.w,self.Credits_b.h)
			end
			off = 0
			if not self.Credits_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Credits_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button"),self.Credits_b.x,self.Credits_b.y + off)
			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},StringFetch(15)},self.Credits_b.x + 27,self.Credits_b.y + 24 + off)
			

			-- Exit the game
			if G_DEBUG then
				if not self.ExitGame_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.ExitGame_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",self.ExitGame_b.x,self.ExitGame_b.y,self.ExitGame_b.w,self.ExitGame_b.h)
			end
			off = 0
			if not self.ExitGame_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.ExitGame_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button"),self.ExitGame_b.x,self.ExitGame_b.y + off)
			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},StringFetch(14)},self.ExitGame_b.x + 27,self.ExitGame_b.y + 24 + off)

			if (self.Saved_t > 0) then
				self.Saved_t = self.Saved_t - G_DT()
				love.graphics.print({{0,0,0},StringFetch(21)},self.Save_b.x + 25 + 140,self.Save_b.y + 24)
			end
			
			if (self.Loaded_t > 0) then
				self.Loaded_t = self.Loaded_t - G_DT()
				love.graphics.print({{0,0,0},StringFetch(20)},self.LoadGame_b.x + 25 + 140,self.LoadGame_b.y + 24)
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
			if key == "return" then
				New_Game()
			end
		end,

		Mousepressed = function(self,x,y,button)
			Play_Sfx("ding",0.1)
			-- Start new game
			local nx, ny = NormalizeMouse(x,y)
			if self.NewGame_b:click(nx,ny) then
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
		Back_b = Button.new(600,495,140,70),
		Main_Volume_Up = Button.new(50,100,70,70,nil,"+",24,24),
		Main_Volume_Down = Button.new(130,100,70,70,nil,"-",24,24),
		Music_Volume_Up = Button.new(50,180,70,70,nil,"+",24,24),
		Music_Volume_Down = Button.new(130,180,70,70,nil,"-",24,24),
		SFX_Volume_Up = Button.new(50,260,70,70,nil,"+",24,24),
		SFX_Volume_Down = Button.new(130,260,70,70,nil,"-",24,24),
		Mute_b = Button.new(50,340,70,70,nil,"x",24,24),
		Hint_b = Button.new(50,420,70,70,nil,"?",24,24),

		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			-- Settings
			love.graphics.print({{0,0,0},StringFetch(9)},Font.get("Spacy_3"),50,30)

			-- Back button
			if G_DEBUG then
				if not self.Back_b.f then
					love.graphics.setColor(1,1,1)
				else
					local t = math.min(self.Back_b.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t))
				end
				love.graphics.rectangle("fill",self.Back_b.x,self.Back_b.y,self.Back_b.w,self.Back_b.h)
			end
			local off = 0
			if not self.Back_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Back_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button"),self.Back_b.x,self.Back_b.y + off)
			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},StringFetch(10)},self.Back_b.x + 29,self.Back_b.y + 24 + off)

			-- self.Hint_b:draw()
			off = 0
			if not self.Hint_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Hint_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Hint_b.x,self.Hint_b.y + off)
			love.graphics.print({{0,0,0},self.Hint_b.s},Font.get("Spacy_2"),self.Hint_b.x + 29,self.Hint_b.y + 15 + off)

			-- self.Mute_b:draw()
			off = 0
			if not self.Mute_b.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Mute_b.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Mute_b.x,self.Mute_b.y + off)
			love.graphics.print({{0,0,0},self.Mute_b.s},Font.get("Spacy_2"),self.Mute_b.x + 29,self.Mute_b.y + 15 + off)

			-- self.Main_Volume_Up:draw()
			off = 0
			if not self.Main_Volume_Up.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Main_Volume_Up.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Main_Volume_Up.x,self.Main_Volume_Up.y + off)
			love.graphics.print({{0,0,0},self.Main_Volume_Up.s},Font.get("Spacy_2"),self.Main_Volume_Up.x + 29,self.Main_Volume_Up.y + 15 + off)

			-- self.Main_Volume_Down:draw()
			off = 0
			if not self.Main_Volume_Down.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Main_Volume_Down.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Main_Volume_Down.x,self.Main_Volume_Down.y + off)
			love.graphics.print({{0,0,0},self.Main_Volume_Down.s},Font.get("Spacy_2"),self.Main_Volume_Down.x + 29,self.Main_Volume_Down.y + 15 + off)

			-- self.Music_Volume_Up:draw()
			off = 0
			if not self.Music_Volume_Up.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Music_Volume_Up.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Music_Volume_Up.x,self.Music_Volume_Up.y + off)
			love.graphics.print({{0,0,0},self.Music_Volume_Up.s},Font.get("Spacy_2"),self.Music_Volume_Up.x + 29,self.Music_Volume_Up.y + 15 + off)

			-- self.Music_Volume_Down:draw()
			off = 0
			if not self.Music_Volume_Down.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.Music_Volume_Down.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.Music_Volume_Down.x,self.Music_Volume_Down.y + off)
			love.graphics.print({{0,0,0},self.Music_Volume_Down.s},Font.get("Spacy_2"),self.Music_Volume_Down.x + 29,self.Music_Volume_Down.y + 15 + off)

			-- self.SFX_Volume_Up:draw()
			off = 0
			if not self.SFX_Volume_Up.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.SFX_Volume_Up.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.SFX_Volume_Up.x,self.SFX_Volume_Up.y + off)
			love.graphics.print({{0,0,0},self.SFX_Volume_Up.s},Font.get("Spacy_2"),self.SFX_Volume_Up.x + 29,self.SFX_Volume_Up.y + 15 + off)

			-- self.SFX_Volume_Down:draw()
			off = 0
			if not self.SFX_Volume_Down.f then
				love.graphics.setColor(G_CLEAR)
			else
				local t = math.min(self.SFX_Volume_Down.t/0.125,1)
				love.graphics.setColor({1*(1 - t)+0.7*t,1*(1 - t)+0.7*t,1*(1 - t)+0.9*t})
				off = 5*t
			end
			love.graphics.draw(Image.get("button_squ"),self.SFX_Volume_Down.x,self.SFX_Volume_Down.y + off)
			love.graphics.print({{0,0,0},self.SFX_Volume_Down.s},Font.get("Spacy_2"),self.SFX_Volume_Down.x + 29,self.SFX_Volume_Down.y + 15 + off)

			love.graphics.setColor(G_CLEAR)
			love.graphics.print({{0,0,0},string.format("%.01f",Main_Volume)..StringFetch(39)},self.Main_Volume_Down.x + 104, self.Main_Volume_Down.y + 24)
			love.graphics.print({{0,0,0},string.format("%.01f",Music_Volume)..StringFetch(40)},self.Music_Volume_Down.x + 104, self.Music_Volume_Down.y + 24)
			love.graphics.print({{0,0,0},string.format("%.01f",SFX_Volume)..StringFetch(41)},self.SFX_Volume_Down.x + 104, self.SFX_Volume_Down.y + 24)
			love.graphics.print({{0,0,0},StringFetch(42)},self.SFX_Volume_Down.x + 104, self.Mute_b.y + 24)
			love.graphics.print({{0,0,0},StringFetch(43)..tostring(G_HINTS)},self.SFX_Volume_Down.x + 104, self.Hint_b.y + 24)

			love.graphics.setColor(G_CLEAR)
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Back_b:focus(x,y)
			self.Mute_b:focus(x,y)
			self.Hint_b:focus(x,y)
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

			if self.Hint_b:click(nx,ny) then
				G_HINTS = not(G_HINTS)
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

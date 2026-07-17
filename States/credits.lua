-- Credits
G_STATE_CREDITS = 9

Credits_Text = ""
Credits_Song = Sound.get("ggg")

function GetCredits(path)
	-- Defualt Localization (English)
	path = path or "/Assets/Credits.txt"
	local info = love.filesystem.getInfo(path)
	if info then
		if info.type == "file" then
			Credits_Text = love.filesystem.read(path)
		else
			Panic("Error: Text File is a Directory", "GetStrings")
		end
	else
		Panic("Error: No Text File at Path", "GetStrings")
	end
end

G_STATE_CREDITS_SUBSTATES = {
	[1] = {
		t = 0,

		Draw = function(self)
			Credits_Song:setVolume(Music_Volume)
			Credits_Song:play()

			local T = self.t/30
			local y = (SCREEN_Y + 10)*(1 - T) + -100*T
			love.graphics.print({{1,1,1},Credits_Text},Font.get("Spacy_3"),50,y)
		end,

		Update = function(self,dt)
			self.t = self.t + G_DT()

			if self.t > 80 then
				self.t = 0
				Credits_Song:stop()
				G_STATE = G_LAST_STATE
				G_STATE_SUB = 1
			end
		end,

		Keypressed = function(self,key)
			if key == "return" then
				self.t = 0
				Credits_Song:stop()
				G_STATE = G_LAST_STATE
				G_STATE_SUB = 1
			end
		end,

		Mousepressed = function(self,x,y,button)
			self.t = 0
			Credits_Song:stop()
			G_STATE = G_LAST_STATE
			G_STATE_SUB = 1
		end
	}
}


G_DRAW[G_STATE_CREDITS] = function()
	local f = G_STATE_CREDITS_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CREDITS] = function(dt)
	local f = G_STATE_CREDITS_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CREDITS] = function(key)
	local f = G_STATE_CREDITS_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CREDITS] = function(x,y,button)
	local f = G_STATE_CREDITS_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

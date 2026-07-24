-- Intro
G_STATE_INTRO = 1

G_INTRO_PLAYED = false

G_STATE_INTRO_SUBSTATES = {
	[1] = {
		Draw = function(self)
			
		end,

		Update = function(self,dt)
			local v = Video.get("intro")
			if v then
				v:seek(0)
				v:play()
			end
			
			if not G_INTRO_PLAYED then
				G_STATE_SUB = 2
			else
				G_STATE_SUB = 3
			end
		end,

		Keypressed = function(self,key)
			
		end,

		Mousepressed = function(self,x,y,button)
			
		end
	},

	[2] = {
		Draw = function(self)
			love.graphics.setColor(G_CLEAR)
			local v = Video.get("intro")
			if v then
				love.graphics.draw(v)
			end
		end,

		Update = function(self,dt)
			local v = Video.get("intro")
			if v then
				if not v:isPlaying() then
					G_STATE_SUB = 3
				end
			else
				G_STATE_SUB = 3
			end
		end,

		Keypressed = function(self,key)
			if key == "return" then
				G_STATE_SUB = 3
				Play_Sfx("ding",0.1)
			end
		end,

		Mousepressed = function(self,x,y,button)
			G_STATE_SUB = 3
			Play_Sfx("ding",0.1)
		end
	},

	[3] = {
		fadein = 0,
		Draw = function(self)
			self.fadein = self.fadein + G_DT()
			local t = math.min(self.fadein/0.5,1)
			love.graphics.setColor(t,t,t)
			love.graphics.rectangle("fill",0,0,800,600)
			love.graphics.print({{0,0,0},StringFetch(1)},Font.get("Spacy_4"),50,50)
		end,

		Update = function(self,dt)
			local v = Video.get("intro")
			if v then
				v:pause()
			end
		end,

		Keypressed = function(self,key)
			if key == "return" then
				G_STATE_SUB = 10
				Play_Sfx("ding",0.1)
			end
		end,

		Mousepressed = function(self,x,y,button)
			G_STATE_SUB = 10
			Play_Sfx("ding",0.1)
		end
	},

	[10] = {
		Update = function(self,dt)
			G_INTRO_PLAYED = true
			G_STATE = G_STATE_MAIN_MENU
			G_STATE_SUB = 1
		end
	}
}


G_DRAW[G_STATE_INTRO] = function()
	local f = G_STATE_INTRO_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_INTRO] = function(dt)
	local f = G_STATE_INTRO_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_INTRO] = function(key)
	local f = G_STATE_INTRO_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_INTRO] = function(x,y,button)
	local f = G_STATE_INTRO_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

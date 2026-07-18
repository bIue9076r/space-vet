-- Intro
G_STATE_INTRO = 1

G_STATE_INTRO_SUBSTATES = {
	[1] = {
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			love.graphics.print({{0,0,0},StringFetch(1)},Font.get("Spacy_4"),50,50)
		end,

		Update = function(self,dt)
			
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

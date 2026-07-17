-- Ending
G_STATE_ENDING = 8

G_STATE_ENDING_SUBSTATES = {
	[1] = {
		Draw = function(self)
			
		end,

		Update = function(self,dt)
			if G_ENDING == 0 then
				G_STATE_SUB = 2
			elseif G_ENDING == 1 then
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
			love.graphics.print({{1,1,1},"You failed to pay your debts."},Font.get("Spacy_3"),50,50)
		end,

		Update = function(self,dt)
			
		end,

		Keypressed = function(self,key)
			G_PLAYING = false
			G_LAST_STATE = G_STATE_INTRO
			G_STATE = G_STATE_CREDITS
			G_STATE_SUB = 1
		end,

		Mousepressed = function(self,x,y,button)
			G_PLAYING = false
			G_LAST_STATE = G_STATE_INTRO
			G_STATE = G_STATE_CREDITS
			G_STATE_SUB = 1
		end
	},

	[3] = {
		Draw = function(self)
			love.graphics.print({{1,1,1},"You paid off your debts."},Font.get("Spacy_3"),50,50)
		end,

		Update = function(self,dt)
			
		end,

		Keypressed = function(self,key)
			G_PLAYING = true
			G_STATE = G_STATE_CREDITS
			G_STATE_SUB = 1
		end,

		Mousepressed = function(self,x,y,button)
			G_PLAYING = true
			G_STATE = G_STATE_CREDITS
			G_STATE_SUB = 1
		end
	},
}


G_DRAW[G_STATE_ENDING] = function()
	local f = G_STATE_ENDING_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_ENDING] = function(dt)
	local f = G_STATE_ENDING_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_ENDING] = function(key)
	local f = G_STATE_ENDING_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_ENDING] = function(x,y,button)
	local f = G_STATE_ENDING_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

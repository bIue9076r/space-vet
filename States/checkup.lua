-- Check-up
G_STATE_CHECK_UP = 5

G_STATE_CHECK_UP_SUB = 1
G_STATE_CHECK_UP_SUBSTATES = {
	[1] = {
		Draw = function(self)
			
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if key == "a" then
				G_STATE = G_STATE_CARE_UNIT
			elseif key == "d" then
				G_STATE = G_STATE_FRONT_DESK
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_CHECK_UP] = function()
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_CHECK_UP_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CHECK_UP] = function(dt)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_CHECK_UP_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CHECK_UP] = function(key)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_CHECK_UP_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CHECK_UP] = function(x,y,button)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_CHECK_UP_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

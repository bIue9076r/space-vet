-- Outside
G_STATE_OUTSIDE = 3

G_STATE_OUTSIDE_SUB = 1
G_STATE_OUTSIDE_SUBSTATES = {
	[1] = {
		Draw = function(self)
			
		end,

		Update = function(self,dt)
			
		end,

		Keypressed = function(self,key)
			
		end,

		Mousepressed = function(self,x,y,button)
			
		end
	}
}


G_DRAW[G_STATE_OUTSIDE] = function()
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_OUTSIDE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_OUTSIDE] = function(dt)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_OUTSIDE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_OUTSIDE] = function(key)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_OUTSIDE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_OUTSIDE] = function(x,y,button)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_OUTSIDE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

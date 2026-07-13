-- Care Unit
G_STATE_CARE_UNIT = 6

G_STATE_CARE_UNIT_SUB = 1
G_STATE_CARE_UNIT_SUBSTATES = {
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


G_DRAW[G_STATE_CARE_UNIT] = function()
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CARE_UNIT] = function(dt)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CARE_UNIT] = function(key)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CARE_UNIT] = function(x,y,button)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

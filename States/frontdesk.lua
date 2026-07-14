-- Front Desk
G_STATE_FRONT_DESK = 4

G_STATE_FRONT_DESK_SUB = 1
G_STATE_FRONT_DESK_SUBSTATES = {
	[1] = {
		Draw = function(self)
			
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_UP(key) then
				G_STATE = G_STATE_ONLINE_SHOP
			elseif G_KEY_LEFT(key) then
				G_STATE = G_STATE_CHECK_UP
			elseif G_KEY_RIGHT(key) then
				G_STATE = G_STATE_OUTSIDE
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_FRONT_DESK] = function()
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_FRONT_DESK_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_FRONT_DESK] = function(dt)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_FRONT_DESK_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_FRONT_DESK] = function(key)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_FRONT_DESK_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_FRONT_DESK] = function(x,y,button)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_FRONT_DESK_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

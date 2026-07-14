-- Front Desk
G_STATE_FRONT_DESK = 4

G_STATE_FRONT_DESK_SUB = 1
G_STATE_FRONT_DESK_SUBSTATES = {
	[1] = {
		Draw = function(self)
			love.graphics.setColor(229/255, 162/255, 85/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(65/255, 38/255, 15/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			love.graphics.setColor(80/255,40/255,50/255)
			-- computer desk
			love.graphics.rectangle("fill",300,400,SCREEN_X - 600,100)

			love.graphics.setColor(0,1,1)
            -- computer
            love.graphics.rectangle("fill",490,280,SCREEN_X - 800,120)

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if key == "w" then
				G_STATE = G_STATE_ONLINE_SHOP
			elseif key == "a" then
				G_STATE = G_STATE_CHECK_UP
			elseif key == "d" then
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

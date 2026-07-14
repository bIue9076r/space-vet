-- Check-up
G_STATE_CHECK_UP = 5

G_STATE_CHECK_UP_SUB = 1
G_STATE_CHECK_UP_SUBSTATES = {
	[1] = {
		Draw = function(self)
            love.graphics.setColor(229/255, 182/255, 234/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(65/255, 38/255, 15/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

            love.graphics.setColor(1,0,0)
            -- bed
            love.graphics.rectangle("fill",500,400,SCREEN_X - 760,100)

            love.graphics.setColor(0,1,0)
            -- bath
            love.graphics.rectangle("fill",50,350,SCREEN_X - 700,150)
            
            love.graphics.setColor(G_CLEAR)
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

-- Front Desk
G_STATE_FRONT_DESK = 4

G_STATE_FRONT_DESK_SUBSTATES = {
	[1] = {
		Computor = Button.new(490,280,200,120),

		Draw = function(self)
			love.graphics.setColor(229/255, 162/255, 85/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(65/255, 38/255, 15/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			-- computer desk
			love.graphics.setColor(80/255,40/255,50/255)
			love.graphics.rectangle("fill",300,400,400,100)

			-- computer
			if not self.Computor.f then
				love.graphics.setColor(0,1,1)
			else
				local t = math.min(self.Computor.t/0.125,1)
				love.graphics.setColor(t,1*(1 - t),1*(1 - t))
			end
            love.graphics.rectangle("fill",490,280,200,120)

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Computor:focus(x,y)
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_UP(key) then
				G_STATE = G_STATE_ONLINE_SHOP
				G_STATE_SUB = 1
			elseif G_KEY_LEFT(key) then
				G_STATE = G_STATE_CHECK_UP
				G_STATE_SUB = 1
			elseif G_KEY_RIGHT(key) then
				G_STATE = G_STATE_OUTSIDE
				G_STATE_SUB = 1
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			local nx, ny = NormalizeMouse(x,y)
			if self.Computor:click(nx,ny) then
				G_STATE = G_STATE_ONLINE_SHOP
				G_STATE_SUB = 1
			end
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_FRONT_DESK] = function()
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_FRONT_DESK] = function(dt)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_FRONT_DESK] = function(key)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_FRONT_DESK] = function(x,y,button)
	local f = G_STATE_FRONT_DESK_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

-- Outside
G_STATE_OUTSIDE = 3

G_STATE_OUTSIDE_SUB = 1
G_STATE_OUTSIDE_SUBSTATES = {
	[1] = {
		Door = Button.new(0,180,100,360),

		Draw = function(self)
			love.graphics.setColor(135/255, 206/255, 235/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
			love.graphics.setColor(92/255, 153/255, 113/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			love.graphics.setColor(1,1,0)
			-- Customer Line
			love.graphics.rectangle("fill",240,225,SCREEN_X - 240,300)

			-- Door to inside
			-- Button
			if not self.Door.f then
				love.graphics.setColor(1,0,1)
			else
				local t = math.min(self.Door.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",0,180,100,360)

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Door:focus(x,y)
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if key == "left" or key == "a" then
				G_STATE = G_STATE_FRONT_DESK
				G_TRANSITION_T = 0
				G_TRANSITION = function()
					love.graphics.setColor(0,1,1)
					love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
					G_TRANSITION_T = G_TRANSITION_T + G_DT()
					if(G_TRANSITION_T < 1) then
						return true
					end
				end
				-- Play_Sfx("Swipe")
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			print(NormalizeMouse(x,y))
			local nx, ny = NormalizeMouse(x,y)
			if self.Door:click(nx,ny) then
				G_STATE = G_STATE_FRONT_DESK
				-- Play_Sfx("Swipe")
			end

			Meta_Game.Mousepressed(x,y,button)
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

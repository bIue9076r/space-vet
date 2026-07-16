-- Outside
G_STATE_OUTSIDE = 3

G_STATE_OUTSIDE_SUB = 1
G_STATE_OUTSIDE_SUBSTATES = {
	[1] = {
		Door = Button.new(30,100,225,480),

		Draw = function(self)
			local tn = Meta_Game.getTimeNumber() or 1
			love.graphics.draw(Image.get("Outside_"..tn),0,0)

			love.graphics.setColor(1,1,0,0.5)
			-- Customer Line
			love.graphics.rectangle("fill",325,125,SCREEN_X - 325,400)
			local tb = {Meta_Game.getLastThree()}
			love.graphics.setColor(0,0,1)
			for i = 1,#tb do
				love.graphics.rectangle("fill",325 + 175*(i - 1),125,100,400)
			end

			-- Door to inside
			-- Button
			if not self.Door.f then
				love.graphics.setColor(1,0,1,0.5)
			else
				local t = math.min(self.Door.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t),0.5)
			end
			love.graphics.rectangle("fill",30,100,225,480)

			love.graphics.setColor(G_CLEAR)
			
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Door:focus(x,y)
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_LEFT(key) then
				G_STATE = G_STATE_FRONT_DESK
				-- G_TRANSITION_T = 0
				-- G_TRANSITION = function()
				-- end
				-- Play_Sfx("Swipe")
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
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

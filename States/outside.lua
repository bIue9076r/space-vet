-- Outside
G_STATE_OUTSIDE = 3

G_STATE_OUTSIDE_SUBSTATES = {
	[1] = {
		Door = Button.new(30,100,250,380),

		Draw = function(self)
			local tn = Meta_Game.getTimeNumber() or 1
			love.graphics.draw(Image.get("Outside_"..tn),0,0)

			-- Customer Line
			if G_DEBUG then
				love.graphics.setColor(1,1,0,0.25)
				love.graphics.rectangle("fill",325,125,SCREEN_X - 325,400)
			end

			local tb = {Meta_Game.getLastThree()}
			for i = 1,#tb do
				love.graphics.setColor(G_CLEAR)
				love.graphics.draw(Image.get(tb[i].owner),325 + 175*(i - 1),125)

				if G_DEBUG then
					love.graphics.setColor(0,0,1,0.5)
					love.graphics.rectangle("fill",325 + 175*(i - 1),125,100,400)
				end
			end

			-- Door to inside
			-- Button
			if G_DEBUG then
				if not self.Door.f then
					love.graphics.setColor(1,0,1,0.25)
				else
					local t = math.min(self.Door.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t),0.25)
				end
				love.graphics.rectangle("fill",30,100,250,380)
			end

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Door:focus(x,y)

			if love.mouse.isDown(1) then
				if (not Meta_Game.Swiping) then
					local dx = (x - Meta_Game.Last_X)
					if dx <= -1 then
						Meta_Game.Swipe_t = Meta_Game.Swipe_t - dt
						if Meta_Game.Swipe_t < 0 then
							Meta_Game.Swipe_t = Meta_Game.Swipe_max
							Meta_Game.Swiping = true
							G_STATE = G_STATE_FRONT_DESK
							G_STATE_SUB = 1
							Play_Sfx("Door")
						end
					end
				end
			else
				Meta_Game.Swipe_t = Meta_Game.Swipe_max
				Meta_Game.Swiping = false
			end

			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_LEFT(key) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
				Play_Sfx("Door")
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			local nx, ny = NormalizeMouse(x,y)
			if self.Door:click(nx,ny) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
				Play_Sfx("Door")
			end
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_OUTSIDE] = function()
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_OUTSIDE] = function(dt)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_OUTSIDE] = function(key)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_OUTSIDE] = function(x,y,button)
	local f = G_STATE_OUTSIDE_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

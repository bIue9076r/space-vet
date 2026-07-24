-- Front Desk
G_STATE_FRONT_DESK = 4

G_STATE_FRONT_DESK_SUBSTATES = {
	[1] = {
		Computor = Button.new(50,255,305,315),

		Draw = function(self)
			love.graphics.draw(Image.get("FrontDesk"),0,0)

			-- computer
			if self.Computor.f then
				love.graphics.draw(Image.get("FrontDesk_Computer"),0,0)
			end

			if G_DEBUG then
				if self.Computor.f then
					local t = math.min(self.Computor.t/0.125,1)
					love.graphics.setColor(t,1*(1 - t),1*(1 - t),0.25)
				else
					love.graphics.setColor(0,1,1,0.25)
				end
				love.graphics.rectangle("fill",self.Computor.x,self.Computor.y,self.Computor.w,self.Computor.h)
			end

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Computor:focus(x,y)

			if love.mouse.isDown(1) then
				if (not Meta_Game.Swiping) then
					local dx = (x - Meta_Game.Last_X)
					if dx >= 1 then
						Meta_Game.Swipe_t = Meta_Game.Swipe_t - dt
						if Meta_Game.Swipe_t < 0 then
							Meta_Game.Swipe_t = Meta_Game.Swipe_max
							Meta_Game.Swiping = true
							G_STATE = G_STATE_CHECK_UP
							G_STATE_SUB = 1
							Play_Sfx("Swipe")
						end
					elseif dx <= -1 then
						Meta_Game.Swipe_t = Meta_Game.Swipe_t - dt
						if Meta_Game.Swipe_t < 0 then
							Meta_Game.Swipe_t = Meta_Game.Swipe_max
							Meta_Game.Swiping = true
							G_STATE = G_STATE_OUTSIDE
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
			if G_KEY_UP(key) then
				G_STATE = G_STATE_ONLINE_SHOP
				G_STATE_SUB = 1
			elseif G_KEY_LEFT(key) then
				G_STATE = G_STATE_CHECK_UP
				G_STATE_SUB = 1
				Play_Sfx("Swipe")
			elseif G_KEY_RIGHT(key) then
				G_STATE = G_STATE_OUTSIDE
				G_STATE_SUB = 1
				Play_Sfx("Door")
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

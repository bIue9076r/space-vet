-- Check-up
G_STATE_CHECK_UP = 5

G_STATE_CHECK_UP_SUBSTATES = {
	[1] = {
		Pet_Bed = Draggable.new(200,450,250,100,600,375,40,50,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Cold" then	-- Todo: Success chance for lower level items
											-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx")
			else
				Play_Sfx("no_"..math.random(1,4))
			end

			G_STATS.Naps_Taken = G_STATS.Naps_Taken + 1
			Meta_Game.Interaction = true
			Meta_Game.Interaction_Timer_Goal = 2
			
			Meta_Game.Interaction_Draw = function()
				local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
				-- Draw tool being used pet
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					love.graphics.draw(tb:image(n),500,200)

					if G_DEBUG then
						love.graphics.setColor(0,0,1,0.25)
						love.graphics.rectangle("fill",550,300,250,100)
					end
				end
			end
		end,"h","u"),

		Pet_Bath = Draggable.new(200,450,250,100,150,325,100,50,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Stinky" then	-- Todo: Success chance for lower level items
											-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx")
			else
				Play_Sfx("no_"..math.random(1,4))
			end

			G_STATS.Baths_Taken = G_STATS.Baths_Taken + 1
			Meta_Game.Interaction = true
			Meta_Game.Interaction_Timer_Goal = 2
			
			Meta_Game.Interaction_Draw = function()
				local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
				-- Draw tool being used by pet
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					love.graphics.draw(tb:image(n),50,200)

					if G_DEBUG then
						love.graphics.setColor(0,0,1,0.25)
						love.graphics.rectangle("fill",100,300,250,100)
					end
				end
			end
		end,"h","t"),

		Draw = function(self)
            love.graphics.setColor(229/255, 182/255, 234/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(65/255, 38/255, 15/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			-- bed
			love.graphics.setColor(1,0,0)
			love.graphics.rectangle("fill",500,400,240,100)
			-- bath
			love.graphics.setColor(0,1,0)
			love.graphics.rectangle("fill",50,350,300,150)
			
			if not Meta_Game.Interaction then
				-- Pet
				local tb = Meta_Game.getLastThree()
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					love.graphics.draw(tb:image(n),self.Pet_Bed.location.Button.x - 50,self.Pet_Bed.location.Button.y - 100)

					if G_DEBUG then
						love.graphics.setColor(0,0,1,0.25)
						love.graphics.rectangle("fill",
							self.Pet_Bed.location.Button.x,
							self.Pet_Bed.location.Button.y,
							self.Pet_Bed.location.Button.w,
							self.Pet_Bed.location.Button.h
						)
					end

					local x,y = NormalizeMouse(love.mouse.getPosition())
					if self.Pet_Bed.location.Button.f then
						love.graphics.setColor(G_CLEAR)
						love.graphics.print({{0,0,0},tb.name},x + 15,y + 15)
					end
				end
			else
				if Meta_Game.Interaction_Draw then
					Meta_Game.Interaction_Draw()
				end
			end
            
            love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			if not Meta_Game.Interaction then
				self.Pet_Bed:update(dt)
				self.Pet_Bath:update(dt)
			end
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if not Meta_Game.Interaction then
				if G_KEY_LEFT(key) then
					G_STATE = G_STATE_CARE_UNIT
					G_STATE_SUB = 1
				elseif G_KEY_RIGHT(key) then
					G_STATE = G_STATE_FRONT_DESK
					G_STATE_SUB = 1
				end
				self.Pet_Bed:keypressed(key)
				self.Pet_Bath:keypressed(key)
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			if not Meta_Game.Interaction then
				self.Pet_Bed:mousepressed(x,y,button)
				self.Pet_Bath:mousepressed(x,y,button)
			end
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_CHECK_UP] = function()
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CHECK_UP] = function(dt)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CHECK_UP] = function(key)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CHECK_UP] = function(x,y,button)
	local f = G_STATE_CHECK_UP_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

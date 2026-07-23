-- Check-up
G_STATE_CHECK_UP = 5

G_STATE_CHECK_UP_SUBSTATES = {
	[1] = {
		Pet_Bed = Draggable.new(0,0,0,0,480,330,250,125,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Cold" then	-- Todo: Success chance for lower level items
											-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx_"..math.random(1,4))
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
					-- local n = 1 -- TODO: Dynamic animations
					-- local p = tb:position(3) -- TODO: plus offsets
					-- love.graphics.draw(tb:image(n),p.x,p.y)
					love.graphics.draw(Image.get("CheckUp_Blanket_"..tb:size()),0,0)
				end
			end
		end,"h","u"),

		Pet_Bath = Draggable.new(0,0,0,0,0,250,345,90,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Stinky" then	-- Todo: Success chance for lower level items
											-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx_"..math.random(1,4))
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
					-- local n = 1 -- TODO: Dynamic animations
					-- local p = tb:position(2) -- TODO: plus offsets
					-- love.graphics.draw(tb:image(n),p.x,p.y)
					love.graphics.draw(Image.get("CheckUp_Bubbles"),0,0)
				end
			end
		end,"h","t"),

		Draw = function(self)
			love.graphics.draw(Image.get("CheckUp"),0,0)

			-- bed
			if G_HINTS then
				love.graphics.setColor(G_CLEAR)
				love.graphics.rectangle("fill",self.Pet_Bed.goal.Button.x + self.Pet_Bed.goal.Button.w/2 - 12.5, self.Pet_Bed.goal.Button.y - 80,32,32)
				love.graphics.print({{0,0,0},"u"},Font.get("Spacy_3"),self.Pet_Bed.goal.Button.x + self.Pet_Bed.goal.Button.w/2 - 5, self.Pet_Bed.goal.Button.y - 90)
			end

			-- bath
			if G_HINTS then
				love.graphics.setColor(G_CLEAR)
				love.graphics.rectangle("fill",self.Pet_Bath.goal.Button.x + self.Pet_Bath.goal.Button.w/2 - 12.5, self.Pet_Bath.goal.Button.y - 80,32,32)
				love.graphics.print({{0,0,0},"t"},Font.get("Spacy_3"),self.Pet_Bath.goal.Button.x + self.Pet_Bath.goal.Button.w/2 - 5, self.Pet_Bath.goal.Button.y - 90)
			end
			
			if not Meta_Game.Interaction then
				-- Pet
				local tb = Meta_Game.getLastThree()
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					local p = tb:position(2) -- TODO: plus offsets
					local h = tb:hitbox(2)
					self.Pet_Bed.location.x, self.Pet_Bed.location.y = h.x, h.y
					self.Pet_Bath.location.x, self.Pet_Bath.location.y = h.x, h.y
					self.Pet_Bed.location.Button.w, self.Pet_Bed.location.Button.h = h.w, h.h
					self.Pet_Bath.location.Button.w, self.Pet_Bath.location.Button.h = h.w, h.h
					
					if not self.Pet_Bed.drag then
						love.graphics.draw(tb:image(n),p.x,p.y)
					else
						local ox = self.Pet_Bed.location.x - self.Pet_Bed.location.Button.x
						local oy = self.Pet_Bed.location.y - self.Pet_Bed.location.Button.y
						love.graphics.draw(tb:image(n),p.x - ox,p.y - oy)
					end
					if G_HINTS then
						love.graphics.rectangle("fill",self.Pet_Bed.location.Button.x + self.Pet_Bed.location.Button.w/2 - 12.5, self.Pet_Bed.location.Button.y - 60,32,40)
						love.graphics.print({{0,0,0},"h"},Font.get("Spacy_3"),self.Pet_Bed.location.Button.x + self.Pet_Bed.location.Button.w/2 - 5, self.Pet_Bed.location.Button.y - 60)
					end

					if G_DEBUG then
						love.graphics.setColor(0,0,1,0.25)
						love.graphics.rectangle("fill",
							self.Pet_Bed.location.Button.x,
							self.Pet_Bed.location.Button.y,
							self.Pet_Bed.location.Button.w,
							self.Pet_Bed.location.Button.h
						)

						love.graphics.setColor(1,1,1,0.5)
						love.graphics.rectangle("fill",
							self.Pet_Bed.goal.Button.x,
							self.Pet_Bed.goal.Button.y,
							self.Pet_Bed.goal.Button.w,
							self.Pet_Bed.goal.Button.h
						)

						love.graphics.rectangle("fill",
							self.Pet_Bath.goal.Button.x,
							self.Pet_Bath.goal.Button.y,
							self.Pet_Bath.goal.Button.w,
							self.Pet_Bath.goal.Button.h
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
					Play_Sfx("Swipe")
				elseif G_KEY_RIGHT(key) then
					G_STATE = G_STATE_FRONT_DESK
					G_STATE_SUB = 1
					Play_Sfx("Swipe")
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

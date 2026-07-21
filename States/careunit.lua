-- Care Unit
G_STATE_CARE_UNIT = 6

G_STATE_CARE_UNIT_SUBSTATES = {
	[1] = {
		Xray = Button.new(0,70,235,255),
		Pet_Pills = Draggable.new(600,260,50,85,200,450,250,100,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Tummy" then	-- Todo: Success chance for lower level items
											-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx_"..math.random(1,4))
			else
				Play_Sfx("no_"..math.random(1,4))
			end

			G_STATS.Pills_Used = G_STATS.Pills_Used + 1
			Meta_Game.Interaction = true
			Meta_Game.Interaction_Timer_Goal = 1
			local w,h = self.location.Button.w, self.location.Button.h
			Meta_Game.Interaction_Draw = function()
				local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
				-- Draw Pet
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					local p = tb:position(1) -- TODO: plus offsets
					love.graphics.draw(tb:image(n),p.x,p.y)
				end

				-- Draw tool being used
				local l = tb:position(5)
				love.graphics.draw(Image.get("CareUnit_Pills_2"),l.x,l.y)
				if G_DEBUG then
					love.graphics.setColor(1,0,0,1 - t)
					love.graphics.rectangle("fill",l.x,l.y,w,h)
				end
			end
		end,"u","h"),

		Pet_Bandage = Draggable.new(520,330,50,75,200,450,250,100,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Scratch" then	-- Todo: Success chance for lower level items
												-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx_"..math.random(1,4))
			else
				Play_Sfx("no_"..math.random(1,4))
			end

			G_STATS.Bandades_Used = G_STATS.Bandades_Used + 1
			Meta_Game.Interaction = true
			Meta_Game.Interaction_Timer_Goal = 1
			local w,h = self.location.Button.w, self.location.Button.h
			Meta_Game.Interaction_Draw = function()
				local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
				-- Draw Pet
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					local p = tb:position(1) -- TODO: plus offsets
					love.graphics.draw(tb:image(n),p.x,p.y)
				end

				-- Draw tool being used
				local l = tb:position(7)
				love.graphics.draw(Image.get("CareUnit_Bandage_2"),l.x,l.y)
				if G_DEBUG then
					love.graphics.setColor(1,1,1,1 - t)
					love.graphics.rectangle("fill",l.x,l.y,w,h)
				end
			end
		end,"t","h"),

		Pet_Hammer = Draggable.new(670,335,70,70,200,450,250,100,function(self)
			local tb = Meta_Game.getLastThree()
			if tb.aches[1] == "Antenne" then	-- Todo: Success chance for lower level items
												-- Later: expand for more Aches
				tb.aches[1] = "None"
				Meta_Game.Cured = true
				Play_Sfx("thx_"..math.random(1,4))
			else
				Play_Sfx("no_"..math.random(1,4))
			end

			G_STATS.Hammer_Used = G_STATS.Hammer_Used + 1
			Meta_Game.Interaction = true
			Meta_Game.Interaction_Timer_Goal = 1
			local w,h = self.location.Button.w, self.location.Button.h
			Meta_Game.Interaction_Draw = function()
				local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
				-- Draw Pet
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					local p = tb:position(1) -- TODO: plus offsets
					love.graphics.draw(tb:image(n),p.x,p.y)
				end

				-- Draw tool being used
				local l = tb:position(6)
				love.graphics.draw(Image.get("CareUnit_RubberHammer_2"),l.x,l.y)
				if G_DEBUG then
					love.graphics.setColor(0,1,1,1 - t)
					love.graphics.rectangle("fill",l.x,l.y,w,h)
				end
			end
		end,"y","h"),

		Draw = function(self)
			love.graphics.draw(Image.get("CareUnit"),0,0)

			-- xray
			-- button
			if self.Xray.f then
				love.graphics.draw(Image.get("CareUnit_Xray_2"),0,0)
			else
				love.graphics.draw(Image.get("CareUnit_Xray_1"),0,0)
			end

			if G_DEBUG then
				if not self.Xray.f then
					love.graphics.setColor(1,1,0,0.25)
				else
					local t = math.min(self.Xray.t/0.125,1)
					love.graphics.setColor(1*(1 - t),t,1*(1 - t),0.25)
				end
				love.graphics.rectangle("fill",
					self.Xray.x,
					self.Xray.y,
					self.Xray.w,
					self.Xray.h
				)
			end

			-- pills
			love.graphics.setColor(G_CLEAR)
			love.graphics.draw(Image.get("CareUnit_Pills_1"),0,0)
			if G_DEBUG then
				love.graphics.setColor(1,0,0,0.25)
				love.graphics.rectangle("fill",
					self.Pet_Pills.location.x,
					self.Pet_Pills.location.y,
					self.Pet_Pills.location.Button.w,
					self.Pet_Pills.location.Button.h
				)
			end
			if G_HINTS then
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},"u"},self.Pet_Pills.location.x + self.Pet_Pills.location.Button.w/2 - 5, self.Pet_Pills.location.y - 30)
			end

			-- bandage
			love.graphics.setColor(G_CLEAR)
			love.graphics.draw(Image.get("CareUnit_Bandage_1"),0,0)
			if G_DEBUG then
				love.graphics.setColor(1,1,1,0.25)
				love.graphics.rectangle("fill",
					self.Pet_Bandage.location.x,
					self.Pet_Bandage.location.y,
					self.Pet_Bandage.location.Button.w,
					self.Pet_Bandage.location.Button.h
				)
			end
			if G_HINTS then
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},"t"},self.Pet_Bandage.location.x + self.Pet_Bandage.location.Button.w/2 - 5, self.Pet_Bandage.location.y - 30)
			end
			
			-- rubber hammer
			love.graphics.setColor(G_CLEAR)
			love.graphics.draw(Image.get("CareUnit_RubberHammer_1"),0,0)
			if G_DEBUG then
				love.graphics.setColor(0,1,1,0.25)
				-- love.graphics.rectangle("fill",570,330,70,50)
				love.graphics.rectangle("fill",
					self.Pet_Hammer.location.x,
					self.Pet_Hammer.location.y,
					self.Pet_Hammer.location.Button.w,
					self.Pet_Hammer.location.Button.h
				)
			end
			if G_HINTS then
				love.graphics.setColor(G_CLEAR)
				love.graphics.print({{0,0,0},"y"},self.Pet_Hammer.location.x + self.Pet_Hammer.location.Button.w/2 - 5, self.Pet_Hammer.location.y - 30)
			end

			if not Meta_Game.Interaction then
				-- Pet
				local tb = Meta_Game.getLastThree()
				if tb then
					love.graphics.setColor(G_CLEAR)
					local n = 1 -- TODO: Dynamic animations
					local p = tb:position(1) -- TODO: plus offsets
					local h = tb:hitbox()
					love.graphics.draw(tb:image(n),p.x,p.y)
					self.Pet_Pills.goal.Button:setVector(h)
					self.Pet_Bandage.goal.Button:setVector(h)
					self.Pet_Hammer.goal.Button:setVector(h)
					if G_HINTS then
						love.graphics.print({{0,0,0},"h"},self.Pet_Pills.goal.Button.x + self.Pet_Pills.goal.Button.w/2 - 5, self.Pet_Pills.goal.Button.y - 60)
					end


					if G_DEBUG then
						love.graphics.setColor(0,0,1,0.25)
						love.graphics.rectangle("fill",h.x,h.y,h.w,h.h)
					end

					local x,y = NormalizeMouse(love.mouse.getPosition())
					if self.Pet_Pills.goal.Button.f then
						love.graphics.setColor(G_CLEAR)
						love.graphics.print({{0,0,0},tb.name},x + 15,y + 15)
					end
				end
				
				if self.Pet_Pills.drag then
					love.graphics.setColor(G_CLEAR)
					love.graphics.draw(Image.get("CareUnit_Pills_2"),self.Pet_Pills.location.Button.x,self.Pet_Pills.location.Button.y)
					if G_DEBUG then
						love.graphics.setColor(1,0,0,0.25)
						love.graphics.rectangle("fill",
							self.Pet_Pills.location.Button.x,
							self.Pet_Pills.location.Button.y,
							self.Pet_Pills.location.Button.w,
							self.Pet_Pills.location.Button.h
						)
					end
				end
				
				if self.Pet_Bandage.drag then
					love.graphics.setColor(G_CLEAR)
					love.graphics.draw(Image.get("CareUnit_Bandage_2"),self.Pet_Bandage.location.Button.x,self.Pet_Bandage.location.Button.y)
					if G_DEBUG then
						love.graphics.setColor(1,1,1,0.25)
						love.graphics.rectangle("fill",
							self.Pet_Bandage.location.Button.x,
							self.Pet_Bandage.location.Button.y,
							self.Pet_Bandage.location.Button.w,
							self.Pet_Bandage.location.Button.h
						)
					end
				end
				
				if self.Pet_Hammer.drag then
					love.graphics.setColor(G_CLEAR)
					love.graphics.draw(Image.get("CareUnit_RubberHammer_2"),self.Pet_Hammer.location.Button.x,self.Pet_Hammer.location.Button.y)
					if G_DEBUG then
						love.graphics.setColor(0,1,1,0.25)
						love.graphics.rectangle("fill",
							self.Pet_Hammer.location.Button.x,
							self.Pet_Hammer.location.Button.y,
							self.Pet_Hammer.location.Button.w,
							self.Pet_Hammer.location.Button.h
						)
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
			local x,y = NormalizeMouse(love.mouse.getPosition())

			if not Meta_Game.Interaction then
				self.Xray:focus(x,y)

				-- This is done so that you could not drag multiple things at once
				if (not self.Pet_Bandage.drag) and (not self.Pet_Hammer.drag) then
					self.Pet_Pills:update(dt)
				end
				if (not self.Pet_Pills.drag) and (not self.Pet_Hammer.drag) then
					self.Pet_Bandage:update(dt)
				end
				if (not self.Pet_Bandage.drag) and (not self.Pet_Pills.drag) then
					self.Pet_Hammer:update(dt)
				end
			end

			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if not Meta_Game.Interaction then
				if G_KEY_RIGHT(key) then
					G_STATE = G_STATE_CHECK_UP
					G_STATE_SUB = 1
					Play_Sfx("Swipe")
				elseif G_KEY_UP(key) then
					G_STATE_SUB = 2
				end
				self.Pet_Pills:keypressed(key)
				self.Pet_Bandage:keypressed(key)
				self.Pet_Hammer:keypressed(key)
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)

			if not Meta_Game.Interaction then
				local nx,ny = NormalizeMouse(love.mouse.getPosition())
				if self.Xray:click(nx,ny,button) then
					G_STATE_SUB = 2
				end

				self.Pet_Pills:mousepressed(x,y,button)
				self.Pet_Bandage:mousepressed(x,y,button)
				self.Pet_Hammer:mousepressed(x,y,button)
			end
		
			Meta_Game.Mousepressed(x,y,button)
		end
	},

	[2] = {
		Draw = function(self)
			love.graphics.setColor(170/255, 212/255, 153/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(84/255, 34/255, 16/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 300,SCREEN_X,300)

			love.graphics.setColor(41/255,37/255,27/255)
			-- table
			love.graphics.rectangle("fill",550,110,250,330)

			-- Pet
			local tb = Meta_Game.getLastThree()
			if tb then
				love.graphics.setColor(G_CLEAR)
				local n = 2 -- TODO: Dynamic animations
				local p = tb:position(4) -- TODO: plus offsets
				love.graphics.draw(tb:image(n),p.x,p.y,0,2,2)

				if G_DEBUG then
					love.graphics.setColor(0,0,1,0.25)
					love.graphics.rectangle("fill",135,265,250*2,100*2)

					if tb.aches[1] == "Tummy" then
						love.graphics.setColor(1,1,1,0.5)
						love.graphics.rectangle("fill",135 + 125,265 + 50,250,100)
					end
				end
			end

			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_DOWN(key) then
				G_STATE_SUB = 1
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_CARE_UNIT] = function()
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CARE_UNIT] = function(dt)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CARE_UNIT] = function(key)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CARE_UNIT] = function(x,y,button)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

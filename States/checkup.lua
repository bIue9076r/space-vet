-- Check-up
G_STATE_CHECK_UP = 5

G_STATE_CHECK_UP_SUB = 1
G_STATE_CHECK_UP_SUBSTATES = {
	[1] = {
		Pet_Bed = Draggable.new(200,450,250,100,600,375,40,50,function ()
			print("Bed Interacted")
		end),

		Pet_Bath = Draggable.new(200,450,250,100,150,325,100,50,function ()
			print("Bath Interacted")
		end),

		Draw = function(self)
            love.graphics.setColor(229/255, 182/255, 234/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(65/255, 38/255, 15/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			if not Meta_Game.Interaction then
				love.graphics.setColor(1,0,0)
				-- bed
				love.graphics.rectangle("fill",500,400,240,100)

				love.graphics.setColor(0,1,0)
				-- bath
				love.graphics.rectangle("fill",50,350,300,150)

				-- Pet
				local tb = Meta_Game.getLastThree()
				if tb then
					love.graphics.setColor(0,0,1)
					love.graphics.rectangle("fill",
						self.Pet_Bed.location.Button.x,
						self.Pet_Bed.location.Button.y,
						self.Pet_Bed.location.Button.w,
						self.Pet_Bed.location.Button.h
					)
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
			if G_KEY_LEFT(key) then
				G_STATE = G_STATE_CARE_UNIT
			elseif G_KEY_RIGHT(key) then
				G_STATE = G_STATE_FRONT_DESK
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

-- Care Unit
G_STATE_CARE_UNIT = 6

G_STATE_CARE_UNIT_SUB = 1
G_STATE_CARE_UNIT_SUBSTATES = {
	[1] = {
		Xray = Button.new(60,250,220,250),

		Draw = function(self)
			love.graphics.setColor(170/255, 212/255, 153/255)
			love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
            love.graphics.setColor(84/255, 34/255, 16/255)
			love.graphics.rectangle("fill",0,SCREEN_Y - 100,SCREEN_X,100)

			love.graphics.setColor(41/255,37/255,27/255)
			-- table
			love.graphics.rectangle("fill",440,380,SCREEN_X - 710,120)

			-- pills
			love.graphics.setColor(1,0,0)
			love.graphics.rectangle("fill",680,340,SCREEN_X - 960,40)
			-- bandage
			love.graphics.setColor(1,1,1)
			love.graphics.rectangle("fill",490,350,SCREEN_X - 940,30)
			-- rubber hammer
			love.graphics.setColor(0,1,1)
			love.graphics.rectangle("fill",570,330,SCREEN_X - 930,50)

			-- xray
			-- button
			if not self.Xray.f then
				love.graphics.setColor(1,1,0)
			else
				local t = math.min(self.Xray.t/0.125,1)
				love.graphics.setColor(1*(1 - t),t,1*(1 - t))
			end
			love.graphics.rectangle("fill",60,250,220,250)


			love.graphics.setColor(G_CLEAR)
			Meta_Game.Draw()
		end,

		Update = function(self,dt)
			local x,y = NormalizeMouse(love.mouse.getPosition())
			self.Xray:focus(x,y)
			Meta_Game.Update(dt)
		end,

		Keypressed = function(self,key)
			if G_KEY_RIGHT(key) then
				G_STATE = G_STATE_CHECK_UP
			end
			Meta_Game.Keypressed(key)
		end,

		Mousepressed = function(self,x,y,button)
			
			Meta_Game.Mousepressed(x,y,button)
		end
	}
}


G_DRAW[G_STATE_CARE_UNIT] = function()
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_CARE_UNIT] = function(dt)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_CARE_UNIT] = function(key)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_CARE_UNIT] = function(x,y,button)
	local f = G_STATE_CARE_UNIT_SUBSTATES[G_STATE_CARE_UNIT_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

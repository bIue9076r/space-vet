-- Online Shop
G_STATE_ONLINE_SHOP = 7

Computor_Color = {1/255, 130/255, 129/255}
Computor_Gray = {192/255,192/255,192/255}
Computor_DarkGray = {128/255,128/255,128/255}
Computor_White = {1,1,1}
Computor_Black = {0,0,0}
Computor_Blue = {8/255,39/255,245/255}

Computor_Exit_Button = Button.new(55,520,60,25)

G_STATE_ONLINE_SHOP_SUBSTATES = {
	[1] = {
		Draw = function(self)
			love.graphics.setColor(Computor_Color)
			love.graphics.rectangle("fill",50,50,700,500)

			love.graphics.setColor(Computor_White)
			love.graphics.rectangle("fill",50,514,700,1)

			love.graphics.setColor(Computor_Gray)
			love.graphics.rectangle("fill",50,515,700,35)
			
			if not Computor_Exit_Button.f then
				love.graphics.setColor(Computor_Black)
				love.graphics.rectangle("fill",115,520,1,25)
				love.graphics.rectangle("fill",55,545,61,1)

				love.graphics.setColor(Computor_White)
				love.graphics.rectangle("fill",55,520,60,1)
				love.graphics.rectangle("fill",55,520,1,25)

				love.graphics.print({Computor_Black,StringFetch(3)},60,520)
			else
				love.graphics.setColor(Computor_White)
				love.graphics.rectangle("fill",115,520,1,25)
				love.graphics.rectangle("fill",55,545,61,1)

				love.graphics.setColor(Computor_Black)
				love.graphics.rectangle("fill",55,520,60,1)
				love.graphics.rectangle("fill",55,520,1,25)

				love.graphics.print({Computor_Black,StringFetch(3)},61,521)
			end
			
			love.graphics.setColor(Computor_Gray)
			love.graphics.rectangle("fill",80,100,300,300)

			love.graphics.setColor(Computor_Black)
			love.graphics.rectangle("fill",80,400,301,1)
			love.graphics.rectangle("fill",380,100,1,301)

			love.graphics.setColor(Computor_White)
			love.graphics.rectangle("fill",80,100,300,1)
			love.graphics.rectangle("fill",80,100,1,300)

			love.graphics.setColor(Computor_Blue)
			love.graphics.rectangle("fill",81,101,298,25)

			local x, y = NormalizeMouse(love.mouse.getPosition())
			love.graphics.setColor(Computor_White)
			love.graphics.print({Computor_White,StringFetch(16)},85,100)
			love.graphics.rectangle("fill",85,130,290,265)

			love.graphics.setColor(Computor_DarkGray)
			love.graphics.rectangle("fill",85,130,290,1)
			love.graphics.rectangle("fill",85,130,1,265)

			love.graphics.setColor(Computor_White)
			love.graphics.printf({Computor_Black,StringFetch(17),Computor_Black,StringFetch(18),Computor_Black,StringFetch(19)},90,130,280,"left")
			
			love.graphics.setColor(G_CLEAR)
			Meta_Game.Music()
		end,

		Update = function(self,dt)
			local x, y = NormalizeMouse(love.mouse.getPosition())

			Computor_Exit_Button:focus(x,y)
		end,

		Keypressed = function(self,key)
			if G_KEY_DOWN(key) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
			end
		end,

		Mousepressed = function(self,x,y,button)
			x, y = NormalizeMouse(x,y)
			
			if Computor_Exit_Button:click(x,y) then
				G_STATE = G_STATE_FRONT_DESK
				G_STATE_SUB = 1
			end
		end
	}
}


G_DRAW[G_STATE_ONLINE_SHOP] = function()
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_ONLINE_SHOP] = function(dt)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_ONLINE_SHOP] = function(key)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_ONLINE_SHOP] = function(x,y,button)
	local f = G_STATE_ONLINE_SHOP_SUBSTATES[G_STATE_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

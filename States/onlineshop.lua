-- Online Shop
G_STATE_ONLINE_SHOP = 7

Computor_Color = {1/255, 130/255, 129/255}
Computor_Gray = {192/255,192/255,192/255}
Computor_DarkGray = {128/255,128/255,128/255}
Computor_White = {1,1,1}
Computor_Black = {0,0,0}
Computor_Blue = {8/255,39/255,245/255}

Computor_Exit_Button = Button.new(55,520,60,25)

G_DRAW[G_STATE_ONLINE_SHOP] = function()
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

		love.graphics.print({Computor_Black,StringFetch(2)},60,525)
	else
		love.graphics.setColor(Computor_White)
		love.graphics.rectangle("fill",115,520,1,25)
		love.graphics.rectangle("fill",55,545,61,1)

		love.graphics.setColor(Computor_Black)
		love.graphics.rectangle("fill",55,520,60,1)
		love.graphics.rectangle("fill",55,520,1,25)

		love.graphics.print({Computor_Black,StringFetch(2)},61,526)
	end
	
	love.graphics.setColor(G_CLEAR)
end

G_UPDATE[G_STATE_ONLINE_SHOP] = function(dt)
	local x, y = love.mouse.getPosition()
	x, y = NormalizeMouse(x,y)

	Computor_Exit_Button:focus(x,y)
end

G_KEYPRESSED[G_STATE_ONLINE_SHOP] = function(key)
	
end

G_MOUSEPRESSED[G_STATE_ONLINE_SHOP] = function(x,y,button)
	x, y = NormalizeMouse(x,y)
	if Computor_Exit_Button:click(x,y) then
		G_STATE = G_STATE_INTRO
	end
end
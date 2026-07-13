-- Intro
G_STATE_INTRO = 1

G_DRAW[G_STATE_INTRO] = function()
	love.graphics.rectangle("fill",0,0,800,600)
	love.graphics.print({{0,0,0},StringFetch(1)},50,50)
end

G_UPDATE[G_STATE_INTRO] = function(dt)
	
end

G_KEYPRESSED[G_STATE_INTRO] = function(key)
	if key then
		G_STATE = G_STATE_ONLINE_SHOP
	end
end

G_MOUSEPRESSED[G_STATE_INTRO] = function(x,y,button)
	
end

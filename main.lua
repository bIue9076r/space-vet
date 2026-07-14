jit.off()
love.graphics.setDefaultFilter("nearest", "nearest")
utf8 = require("utf8")

require("globals")

function love.load()
	love.window.setMode(1000, 600, {resizable = true, minwidth = 800, minheight = 600})
	love.resize()

	-- Get Strings
	GetStrings()

	-- Check save file
	G_SAVE = true -- testing
end

function love.resize()
	SCREEN_X = love.graphics.getWidth()
	SCREEN_Y = love.graphics.getHeight()
	ASPECT = (SCREEN_X/SCREEN_Y) 
	
	ASPECT_INDEX = 1
	while ((SCREEN_X_O * (ASPECT_INDEX + 1)) <= SCREEN_X) and ((SCREEN_Y_O * (ASPECT_INDEX + 1)) <= SCREEN_Y) do
		ASPECT_INDEX = ASPECT_INDEX + 1
	end
end

function love.update(dt)
	if not G_TRANSITION then
		local f = G_UPDATE[G_STATE]
		if f then f(dt) end
	end
end

function love.keypressed(key)
	if not G_TRANSITION then
		local f = G_KEYPRESSED[G_STATE] or Error_Keypressed
		if f then f(key) end
	else
		G_TRANSITION = nil
	end
end

function love.mousepressed(x,y,button)
	if not G_TRANSITION then
		local f = G_MOUSEPRESSED[G_STATE]
		if f then f(x,y,button) end
	else
		G_TRANSITION = nil
	end
end

function love.draw()
	Draw_Sfx()
	love.graphics.setCanvas(CANVAS)
	love.graphics.clear()

	if not G_TRANSITION then
		local f = G_DRAW[G_STATE] or Error_Draw
		if f then f() end
	else
		local later = love.timer.getTime()
		if(G_TRANSITION and G_TRANSITION()) then
		else
			G_TRANSITION = nil
		end
	end

	love.graphics.setCanvas()

	local cx = (SCREEN_X - (ASPECT_INDEX * SCREEN_X_O))/2
	local cy = (SCREEN_Y - (ASPECT_INDEX * SCREEN_Y_O))/2
	
	-- Screen Border
	for y = 0, (math.ceil(cy/100) - 1) do
		for x = 0, (math.ceil(SCREEN_X/100) - 1) do
			love.graphics.draw(Image.get("Alien"),x*100,y*100)
			love.graphics.draw(Image.get("Alien"),x*100 + 100,SCREEN_Y - y*100 - 100,0,-1,1)
		end
	end

	for x = 0, (math.ceil(cx/100) - 1) do
		for y = 0, (math.ceil(SCREEN_Y/100) - 1) do
			love.graphics.draw(Image.get("Alien"),x*100,y*100)
			love.graphics.draw(Image.get("Alien"),SCREEN_X - x*100,y*100,0,-1,1)
		end
	end
	-----------------

	-- Black Background
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",cx,cy,ASPECT_INDEX*SCREEN_X_O,ASPECT_INDEX*SCREEN_Y_O)
	love.graphics.setColor(1,1,1)
	love.graphics.draw(CANVAS,cx,cy,0,ASPECT_INDEX,ASPECT_INDEX)
end

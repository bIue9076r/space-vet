jit.off()
love.graphics.setDefaultFilter("nearest", "nearest")
utf8 = require("utf8")

require("globals")

function love.load()
	love.window.setMode(1000, 600, {resizable = true, minwidth = 800, minheight = 600})
	love.resize()
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
	local f = G_UPDATE[G_STATE]
	if f then
		f(dt)
	end
end

function love.keypressed(key)
	local f = G_KEYPRESSED[G_STATE] or Error_Keypressed
	if f then
		f(key)
	end
end

function love.mousepressed(x,y,button)
	local f = G_MOUSEPRESSED[G_STATE]
	if f then
		f(x,y,button)
	end
end

function love.draw()
	love.graphics.setCanvas(CANVAS)
	love.graphics.clear()

	local f = G_DRAW[G_STATE] or Error_Draw
	if f then
		f()
	end

	love.graphics.setCanvas()
	for y = 0,SCREEN_Y,100 do
		for x = 0,SCREEN_X/2,100 do
			love.graphics.draw(Image.get("Alien"),x,y)
			love.graphics.draw(Image.get("Alien"),x + SCREEN_X/2 + 100,y,0,-1)
		end
	end

	local cx = (SCREEN_X - (ASPECT_INDEX * SCREEN_X_O))/2
	local cy = (SCREEN_Y - (ASPECT_INDEX * SCREEN_Y_O))/2
	for y = 0, math.ceil(cx/100) do
		for x = 0, math.ceil(cy/100) do
			love.graphics.draw(Image.get("Alien"),x,y)
			love.graphics.draw(Image.get("Alien"),x + SCREEN_X/2 + 100,y,0,-1)
		end
	end
	love.graphics.draw(CANVAS,cx,cy,0,ASPECT_INDEX,ASPECT_INDEX)
end

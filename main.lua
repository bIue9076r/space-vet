jit.off()
love.graphics.setDefaultFilter("nearest", "nearest")
utf8 = require("utf8")
math.randomseed(os.time())

require("globals")

function love.load(args)
	love.window.setMode(1000, 600, {resizable = true, minwidth = 800, minheight = 600})
	love.resize()

	for i, v in ipairs(args) do
		if(v == "-d" or v == "-D" or v == "debug") then
			G_DEBUG = true
			G_ALWAYS_AVALIABLE = true
		end
	end

	-- Get Strings
	GetStrings()

	-- Get Credits
	GetCredits()

	-- Generates random alien names
	Name.get()

	-- Check save file
	local info = love.filesystem.getInfo(G_SAVE_PATH)
	if info then
		if info.type == "file" then
			G_SAVE = true
			G_HINTS = false
		else
			-- Why is the save file a directory?
			-- Panic("Save File is a directory","love.load")
			G_SAVE = false
		end
	else
		G_SAVE = false
	end
end

function love.resize()
	CSCREEN_X = love.graphics.getWidth()
	CSCREEN_Y = love.graphics.getHeight()
	ASPECT = (CSCREEN_X/CSCREEN_Y) 
	
	ASPECT_INDEX = 1
	while ((SCREEN_X * (ASPECT_INDEX + 1)) <= CSCREEN_X) and ((SCREEN_Y * (ASPECT_INDEX + 1)) <= CSCREEN_Y) do
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
		if not G_TRANSITION_BLOCKING then
			G_TRANSITION = nil
		end
	end
end

function love.mousepressed(x,y,button)
	if not G_TRANSITION then
		local f = G_MOUSEPRESSED[G_STATE]
		if f then f(x,y,button) end
	else
		if not G_TRANSITION_BLOCKING then
			G_TRANSITION = nil
		end
	end
end

function love.draw()
	if G_MUSIC_SONG then
		if G_MUSIC_PLAYING then
			G_MUSIC_SONG:setVolume(Music_Volume)
		else
			G_MUSIC_SONG:pause()
		end
	end
	
	Draw_Sfx()
	love.graphics.setCanvas(CANVAS)
	love.graphics.clear()

	if not G_TRANSITION then
		local f = G_DRAW[G_STATE] or Error_Draw
		if f then f() end
	else
		if(G_TRANSITION and G_TRANSITION()) then
		else
			G_TRANSITION = nil
		end
	end

	love.graphics.setCanvas()

	local cx = (CSCREEN_X - (ASPECT_INDEX * SCREEN_X))/2
	local cy = (CSCREEN_Y - (ASPECT_INDEX * SCREEN_Y))/2
	
	-- Screen Border
	for y = 0, (math.ceil(cy/100) - 1) do
		for x = 0, (math.ceil(CSCREEN_X/100) - 1) do
			love.graphics.draw(Image.get("Alien"),x*100,y*100)
			love.graphics.draw(Image.get("Alien"),x*100 + 100,CSCREEN_Y - y*100 - 100,0,-1,1)
		end
	end

	for x = 0, (math.ceil(cx/100) - 1) do
		for y = 0, (math.ceil(CSCREEN_Y/100) - 1) do
			love.graphics.draw(Image.get("Alien"),x*100,y*100)
			love.graphics.draw(Image.get("Alien"),CSCREEN_X - x*100,y*100,0,-1,1)
		end
	end
	-----------------

	-- Black Background
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",cx,cy,ASPECT_INDEX*SCREEN_X,ASPECT_INDEX*SCREEN_Y)
	love.graphics.setColor(G_CLEAR)
	love.graphics.draw(CANVAS,cx,cy,0,ASPECT_INDEX,ASPECT_INDEX)
	love.graphics.setColor(G_CLEAR)
end

if jit then jit.off() end
love.graphics.setDefaultFilter("nearest", "nearest")
utf8 = require("utf8")
math.randomseed(os.time())

require("globals")

function love.load(args)
	love.window.setMode(1000, 600, {resizable = true, minwidth = 800, minheight = 600})
	G_RESIZE()

	local hintFlag = false
	for i, v in ipairs(args) do
		if(v == "-d" or v == "-D" or v == "-debug" or v == "debug") then
			G_DEBUG = true
			G_ALWAYS_AVALIABLE = true
			-- Todo: Cheats menu
		end

		if(v == "-a" or v == "-A") then
			G_ALWAYS_AVALIABLE = true
		end

		if(v == "-h" or v == "-H" or v == "-help" or v == "help") then
			G_HINTS = true
			hintFlag = true
		end

		if(v == "-m" or v == "-M" or v == "-mute" or v == "mute") then
			Main_Volume = 0
			love.audio.setVolume(Main_Volume)
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
			if not hintFlag then
				G_HINTS = false
			end
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
	G_RESIZE()
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

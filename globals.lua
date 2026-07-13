require("modules/assets")
require("Assets/defines")
require("modules/sfx")
require("modules/button")
require("modules/normMouse")

G_STATE = 1
G_UPDATE = {}
G_KEYPRESSED = {}
G_MOUSEPRESSED = {}
G_DRAW = {}

G_DAY = 1
G_CLEAR = {1,1,1,1}
G_STRINGS = {}

require("States/intro")
require("States/mainMenu")
require("States/outside")
require("States/frontdesk")
require("States/checkup")
require("States/careunit")
require("States/onlineshop")

Main_Volume = 1
Music_Volume = 1
SFX_Volume = 1
love.audio.setVolume(Main_Volume)

SCREEN_X = love.graphics.getWidth()
SCREEN_X_O = SCREEN_X
SCREEN_Y = love.graphics.getHeight()
SCREEN_Y_O = SCREEN_Y
ASPECT = (SCREEN_X/SCREEN_Y) 
ASPECT_INDEX = 1
CANVAS = love.graphics.newCanvas()

G_DRAW[-10] = function()
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("fill",0,0,SCREEN_X_O,SCREEN_Y_O)
	love.graphics.setColor(1,1,1)
	love.graphics.print({{1,1,1},G_REASON},50,50)
end

G_KEYPRESSED[-10] = function(key)
	if key then
		love.event.quit(-1)
	end
end

-- Panic
-- Used to signal an error
-- Takes: Reason for error, Caller of error
-- Returns: Nothing
function Panic(Reason, Caller)
	G_STATE = -10
	G_REASON = "Panic: Error."
	if Reason then
		if Caller then
			G_REASON = "Panic! "..tostring(Reason)..". Called by: "..tostring(Caller)
		else
			G_REASON = "Panic! "..tostring(Reason)
		end
	end
end

function Error_Draw()
	
end

function Error_Keypressed(key)
	if key == "return" then
		G_STATE = 1
	end
end

function GetStrings(path)
	-- Defualt Localization (English)
	path = path or "/Assets/TextMain_English.txt"
	local info = love.filesystem.getInfo(path)
	if info then
		if info.type == "file" then
			for v in love.filesystem.lines(path) do
				table.insert(G_STRINGS,v)
			end
		else
			Panic("Error: Text File is a Directory", "GetStrings")
		end
	else
		Panic("Error: No Text File at Path", "GetStrings")
	end
end

-- String Fetch
-- Takes: n - string index
-- Returns: String if it exists
function StringFetch(n)
	return G_STRINGS[n] or ""
end

require("modules/assets")
require("Assets/defines")
require("modules/sfx")
require("modules/button")
require("modules/draggable")
require("modules/normMouse")
require("modules/bank")
require("modules/animal")
require("modules/AlienNames")

G_VERSION = 1
G_DEBUG = true -- make false in release
G_STATE = 1
G_STATE_SUB = 1
G_ENDING = 0
G_UPDATE = {}
G_KEYPRESSED = {}
G_MOUSEPRESSED = {}
G_DRAW = {}

G_DAY = 0
G_CLEAR = {1,1,1,1}
G_STRINGS = {}
G_PLAYING = false
G_LAST_STATE = 1
G_STATS = {
	Pets = 0,
	Pills_Used = 0,
	Bandades_Used = 0,
	Hammer_Used = 0,
	Baths_Taken = 0,
	Naps_Taken = 0,
}

G_SAVE_PATH = "Save.txt"

love.graphics.setFont(Font.get("Spacy"))

require("States/metagame")
require("States/intro")
require("States/mainMenu")
require("States/outside")
require("States/frontdesk")
require("States/checkup")
require("States/careunit")
require("States/onlineshop")
require("States/ending")
require("States/credits")

Main_Volume = 1
Music_Volume = 1
SFX_Volume = 1
love.audio.setVolume(Main_Volume)

G_MUSIC_LIST = {
	"beep",
	"gloorp",
	"pit",
	"saturn",
}

G_MUSIC_LIST_C = {
	0,0,0,0
}

G_MUSIC_PLAYING = true
G_MUSIC_SONG = nil
G_MUSIC_DELAY = 5
G_MUSIC_DELAY_T = 0
G_TRANSITION_BLOCKING = false

CSCREEN_X = love.graphics.getWidth()
SCREEN_X = CSCREEN_X
CSCREEN_Y = love.graphics.getHeight()
SCREEN_Y = CSCREEN_Y
ASPECT = (CSCREEN_X/CSCREEN_Y) 
ASPECT_INDEX = 1
CANVAS = love.graphics.newCanvas()

function PrintAll(tbl)
	tbl = tbl or _G
	for i,v in pairs(tbl) do
		print(i,"= [",v,"]")
		if type(v) == "table" then
			PrintAll(v)
		end
	end
end

G_DRAW[-10] = function()
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
	love.graphics.setColor(1,1,1)
	love.graphics.print({{1,1,1},G_REASON},50,50)
end

G_KEYPRESSED[-10] = function(key)
	if key then
		love.event.quit(-1)
	end
end

function G_MUSIC_NEW()
	local n = math.random(1,#G_MUSIC_LIST)
	for _ = 1,5 do -- Try 5 times to shuffle
		local m = false
		for i = 1,#G_MUSIC_LIST do
			if not(i == n) then
				if G_MUSIC_LIST_C[n] - G_MUSIC_LIST_C[i] >= 1 then
					m = true
				end
			end
		end

		if m then
			n = math.random(1,#G_MUSIC_LIST)
		else
			break
		end
	end

	G_MUSIC_LIST_C[n] = G_MUSIC_LIST_C[n] + 1
	G_MUSIC_SONG = Sound.get(G_MUSIC_LIST[n])
end

function G_DT()
	return love.timer.getDelta()
end

function G_KEY_LEFT(key)
	return key == "a" or key == "left"
end

function G_KEY_RIGHT(key)
	return key == "d" or key == "right"
end

function G_KEY_UP(key)
	return key == "w" or key == "up"
end

function G_KEY_DOWN(key)
	return key == "s" or key == "down"
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

function PopTbl(tbl)
	local r = tbl[#tbl]
	tbl[#tbl] = nil
	return r
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

require("modules/assets")
require("Assets/defines")
require("modules/sfx")
require("modules/button")

G_STATE = 1
G_UPDATE = {}
G_KEYPRESSED = {}
G_MOUSEPRESSED = {}
G_DRAW = {
	[1] = function()
		love.graphics.rectangle("fill",0,0,800,600)
	end
}

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

function Error_Draw()
	
end

function Error_Keypressed(key)
	if key == "return" then
		G_STATE = 1
	end
end

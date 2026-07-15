-- Main Menu
G_STATE_MAIN_MENU = 2

G_STATE_MAIN_MENU_SUB = 1
G_STATE_MAIN_MENU_SUBSTATES = {
	[1] = {
		Draw = function(self)
			love.graphics.rectangle("fill",0,0,800,600)
			love.graphics.print({{0,0,0},StringFetch(2)},50,50)

			love.graphics.print({{0,0,0},StringFetch(4)},100,100)

			if G_SAVE then
				love.graphics.print({{0,0,0},StringFetch(5)},400,100)
			end

			love.graphics.print({{0,0,0},StringFetch(6)},100,300)

			if G_PLAYING then
				love.graphics.print({{0,0,0},StringFetch(7)},400,300)

				love.graphics.print({{0,0,0},StringFetch(8)},100,500)
			end
		end,

		Update = function(self,dt)
			
		end,

		Keypressed = function(self,key)
			Play_Sfx("ding",0.1)
		end,

		Mousepressed = function(self,x,y,button)
			Play_Sfx("ding",0.1)
			G_STATE = G_STATE_OUTSIDE

			G_MUSIC_PLAYING = true
			if not G_PLAYING then
				G_MUSIC_NEW()
			else
				G_STATE = G_LAST_STATE
			end

			if G_MUSIC_SONG then
				G_MUSIC_SONG:play()
			end

			G_PLAYING = true
		end
	}
}


G_DRAW[G_STATE_MAIN_MENU] = function()
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Draw then f:Draw() end
end

G_UPDATE[G_STATE_MAIN_MENU] = function(dt)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Update then f:Update(dt) end
end

G_KEYPRESSED[G_STATE_MAIN_MENU] = function(key)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Keypressed then f:Keypressed(key) end
end

G_MOUSEPRESSED[G_STATE_MAIN_MENU] = function(x,y,button)
	local f = G_STATE_MAIN_MENU_SUBSTATES[G_STATE_MAIN_MENU_SUB]
	if f and f.Mousepressed then f:Mousepressed(x,y,button) end
end

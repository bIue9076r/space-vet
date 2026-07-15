-- Meta Game State
Meta_Game = {}
Meta_Game.Objects = {}
Meta_Game.Objects.Animal = {}

function New_Game()
	Meta_Game.Objects.Animal = {
		Animal.new("Xittens", "Catlike", "Alien_1"),
	}
end

function Meta_Game.Draw()
	if G_MUSIC_PLAYING then
		if ((not G_MUSIC_SONG) or (not G_MUSIC_SONG:isPlaying())) then
			G_MUSIC_DELAY_T = G_MUSIC_DELAY_T + G_DT()
			if (G_MUSIC_DELAY_T > G_MUSIC_DELAY) then
				G_MUSIC_NEW()
				G_MUSIC_SONG:play()
				G_MUSIC_DELAY_T = 0
			end
		end
	end

	love.graphics.print({{0,0,0},"Day "..G_DAY},0,0)
	love.graphics.print({{0,0,0},"Balance: "..Bank.balance},0,20)
end

function Meta_Game.Update(dt)

end

function Meta_Game.Keypressed(key)
	if key == "escape" then
		G_MUSIC_PLAYING = false
		G_LAST_STATE = G_STATE
		G_STATE = G_STATE_MAIN_MENU
		G_STATE_MAIN_MENU_SUB = 1
	end
end

function Meta_Game.Mousepressed(x,y,button)

end

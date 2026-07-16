-- Meta Game State
Meta_Game = {}
Meta_Game.Objects = {}
Meta_Game.Animals = {}

Meta_Game.Animal_Count = 1
Meta_Game.Timer = 0
Meta_Game.Timer_Goal = 4*60
Meta_Game.Tick = true

Meta_Game.Interaction = false
Meta_Game.Interaction_Draw = function()
	
end
Meta_Game.Interaction_Timer = 0
Meta_Game.Interaction_Timer_Goal = 0

Meta_Game.Cured = false
Meta_Game.Cured_Pet = nil
Meta_Game.Cured_Draw = function ()
	local t = Meta_Game.Interaction_Timer/Meta_Game.Interaction_Timer_Goal
	love.graphics.setColor(0,0,1,1 - t)
	love.graphics.rectangle("fill",200,450,250,100)
end

function New_Day()
	G_DAY = G_DAY + 1
	Meta_Game.Timer = 0
	Meta_Game.Tick = true
	Meta_Game.Interaction = false
	Meta_Game.Interaction_Timer = 0
	Meta_Game.Interaction_Timer_Goal = 0

	if G_DAY == 1 then
		return
	end

	if G_DAY >= 2 then
		Meta_Game.Animal_Count = 3
	end

	if G_DAY == 6 then
		-- End of the week (temporary end of the game)
		-- Check balance
		if Bank.balance >= 5000 then
			G_ENDING = 1 -- Good
		else
			G_ENDING = 0 -- Bad
		end
	end

	Meta_Game.Animals = {}
	for i = 1, Meta_Game.Animal_Count do
		-- Todo: Name Generator
		Meta_Game.Animals[i] = Animal.new("???",Kinds.Generate(),Owners.Generate())
		Meta_Game.Animals[i].aches[1] = Ache.Generate()
	end
end

function New_Game()
	New_Day()

	Meta_Game.Animals = {
		Animal.new("Xittens", "Catlike", "Alien_1"),
		Animal.new("Xittens", "Catlike", "Alien_1"),
		Animal.new("Xittens", "Catlike", "Alien_1"),
		Animal.new("Xittens", "Catlike", "Alien_1"),
	}

	Meta_Game.Animals[1].aches = {
		[1] = "Antenne"
	}

	Meta_Game.Animals[2].aches = {
		[1] = "Antenne"
	}

	Meta_Game.Animals[3].aches = {
		[1] = "Antenne"
	}

	Meta_Game.Animals[4].aches = {
		[1] = "Antenne"
	}
end

function Load_Game(path)
	
end

function Save_Game(path)
	
end

function Meta_Game.getTimeNumber()
	if Meta_Game.Timer > Meta_Game.Timer_Goal*0.7 then
		return 2
	else
		return 1
	end
end

function Meta_Game.getLastThree()
	local tbl = {}
	for i = #Meta_Game.Animals, 1, -1 do
		if #tbl < 3 then
			table.insert(tbl,Meta_Game.Animals[i])
		else
			return tbl[1], tbl[2], tbl[3]
		end
	end

	return tbl[1], tbl[2], tbl[3]
end

function Meta_Game.Draw()
	if G_MUSIC_PLAYING then
		if ((not G_MUSIC_SONG) or (not G_MUSIC_SONG:isPlaying())) then
			G_MUSIC_DELAY_T = G_MUSIC_DELAY_T + G_DT()
			if (G_MUSIC_DELAY_T > G_MUSIC_DELAY) then
				G_MUSIC_NEW()
				if G_MUSIC_SONG then
					G_MUSIC_SONG:play()
					G_MUSIC_DELAY_T = 0
				end
			end
		end
	end

	love.graphics.print({{0,0,0},"Day "..G_DAY},0,0)
	love.graphics.print({{0,0,0},"Balance: "..Bank.balance},0,20)
	local m = string.format("%02d",math.floor((Meta_Game.Timer_Goal - Meta_Game.Timer) / 60))
	local s = string.format("%02d",math.fmod((Meta_Game.Timer_Goal - Meta_Game.Timer), 60))
	love.graphics.print({{0,0,0},"Time Remaining: "..m..":"..s},0,40)
end

function Meta_Game.Update(dt)
	if Meta_Game.Interaction then
		Meta_Game.Interaction_Timer = Meta_Game.Interaction_Timer + dt
		if Meta_Game.Interaction_Timer > Meta_Game.Interaction_Timer_Goal then
			Meta_Game.Interaction = false
			Meta_Game.Interaction_Timer = 0
			Meta_Game.Interaction_Timer_Goal = 0
			Meta_Game.Interaction_Draw = nil

			if Meta_Game.Cured then
				Meta_Game.Cured = false
				Meta_Game.Interaction = true
				Meta_Game.Interaction_Timer = 0
				Meta_Game.Interaction_Timer_Goal = 2
				Meta_Game.Interaction_Draw = Meta_Game.Cured_Draw
				Meta_Game.Cured_Pet = PopTbl(Meta_Game.Animals)
			end
		end
	end

	if Meta_Game.Tick then
		Meta_Game.Timer = Meta_Game.Timer + dt
		if Meta_Game.Timer > Meta_Game.Timer_Goal then
			-- end of day
			print("end of day")
		end
	end
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

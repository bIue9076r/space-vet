-- Meta Game State
Meta_Game = {}
Meta_Game.Objects = {}
Meta_Game.Animals = {}

Meta_Game.Animal_Count = 1
Meta_Game.Timer = 0
Meta_Game.Timer_Goal = 4*60
Meta_Game.Tick = true

Meta_Game.Interaction = false
Meta_Game.Interaction_Draw = nil
Meta_Game.Interaction_Timer = 0
Meta_Game.Interaction_Timer_Goal = 0

Meta_Game.Cured = false
Meta_Game.Cured_Pet = nil
Meta_Game.Deposit = false
Meta_Game.Cured_Draw = function ()
	local t = math.min(1,Meta_Game.Interaction_Timer/(Meta_Game.Interaction_Timer_Goal - 1))
	love.graphics.setColor(0,0,1,1 - t)
	love.graphics.rectangle("fill",200,450,250,100)

	if (not Meta_Game.Deposit) and Meta_Game.Interaction_Timer > (Meta_Game.Interaction_Timer_Goal - 1) then
		Bank.Deposit(math.random(264,300))
		Meta_Game.Deposit = true
	end
end

function New_Day()
	G_DAY = G_DAY + 1
	Meta_Game.Timer = 0
	Meta_Game.Tick = true
	Meta_Game.Interaction = false
	Meta_Game.Interaction_Timer = 0
	Meta_Game.Interaction_Timer_Goal = 0
	Meta_Game.Cured = false
	Meta_Game.Cured_Pet = nil
	Meta_Game.Deposit = false
	G_STATE = G_STATE_OUTSIDE
	G_STATE_SUB = 1

	if G_DAY == 1 then
		return
	end

	if G_DAY >= 2 then
		Meta_Game.Animal_Count = math.min(10,G_DAY + 1)
		Bank.Update()
	end

	if G_DAY == 6 then
		-- End of the week (temporary end of the game)
		-- Check balance
		if Bank.balance >= 5000 then
			Bank.Spend(5000)
			G_ENDING = 1 -- Good
		else
			Bank.balance = Bank.balance - 5000
			G_ENDING = 0 -- Bad
		end
		G_LAST_STATE = G_STATE
		G_STATE = G_STATE_ENDING
		if G_MUSIC_SONG then
			G_MUSIC_SONG:stop()
		end
	end

	Meta_Game.Animals = {}
	for i = 1, Meta_Game.Animal_Count do
		Meta_Game.Animals[i] = Animal.new(Name.Generate(),Kinds.Generate(),Owners.Generate())
		Meta_Game.Animals[i].aches[1] = Ache.Generate()
	end
end

function End_Day()
	G_TRANSITION_T = 0
	G_TRANSITION = function ()
		G_TRANSITION_T = G_TRANSITION_T + G_DT()
		love.graphics.setColor(G_CLEAR)
		love.graphics.draw(Image.get("Outside_2"),0,0)
		love.graphics.setColor(0,0,0,math.min(1,G_TRANSITION_T/2.5))
		love.graphics.rectangle("fill",0,0,SCREEN_X,SCREEN_Y)
		
		if G_TRANSITION_T >= 2.5 then
			local T = G_TRANSITION_T - 2.5
			love.graphics.setColor(G_CLEAR)

			love.graphics.setColor(1,1,1,1 - math.min(1,T/2.5))
			local s1 = StringFetch(11)..G_DAY
			local l1 = #s1
			local s2 = StringFetch(11)..(G_DAY+1)
			local x = SCREEN_X/2 - l1*96/3.5
			local y = SCREEN_Y/2 - 96
			love.graphics.print({{1,1,1},s1},Font.get("Spacy_5"),x,y)
			love.graphics.setColor(1,1,1,math.min(1,T/2.5))
			love.graphics.print({{1,1,1},s2},Font.get("Spacy_5"),x,y)
		end
		
		love.graphics.setColor(G_CLEAR)
		if G_TRANSITION_T >= 6 then
			New_Day()
			return false
		end
		return true
	end
end

function New_Game()
	G_DAY = 0
	Bank.balance = 0
	New_Day()

	Meta_Game.Animals = {
		Animal.new("Xittens", "Catlike", "Alien_1"),
	}

	Meta_Game.Animals[1].aches = {
		[1] = "Antenne"
	}
end

function Load_Game(path)
	path = path or "Save.txt"
	local st, save, err = pcall(love.filesystem.load, path)
	if not st or err then
		-- Panic(err,"Load_Game")
		return
	end

	local V = G_VERSION
	pcall(save())

	if V > G_VERSION then -- it shouldn't break but in case
		-- Panic("Save File Issue", "Load_Game")
	end
end

function Save_Game(path)
	path = path or "Save.txt"
	-- Stuff to store
		-- Version
		-- Main_Volume
		-- Music_Volume
		-- SFX_Volume
		-- G_LAST_STATE
		-- G_PLAYING
		-- G_ENDING
		-- Bank.balance
		-- G_DAY
		-- Statistics
			-- G_STATS.Pets
			-- G_STATS.Pills_Used
			-- G_STATS.Bandades_Used
			-- G_STATS.Hammer_Used
			-- G_STATS.Baths_Taken
			-- G_STATS.Naps_Taken
	
	local file, err = love.filesystem.newFile(path,"w")
	if err then
		-- Panic(err,"Save_Game")
		return
	end

	file:write("G_VERSION = "..tostring(G_VERSION))
	file:write("Main_Volume = "..tostring(Main_Volume))
	file:write("Main_Volume = "..tostring(Music_Volume))
	file:write("SFX_Volume = "..tostring(SFX_Volume))
	file:write("G_LAST_STATE = "..tostring(G_LAST_STATE))
	file:write("G_PLAYING = "..tostring(G_PLAYING))
	file:write("G_ENDING = "..tostring(G_ENDING))
	file:write("Bank.balance = "..tostring(Bank.balance))
	file:write("G_DAY = "..tostring(G_DAY))
	file:write("G_STATS.Pets = "..tostring(G_STATS.Pets))
	file:write("G_STATS.Pills_Used = "..tostring(G_STATS.Pills_Used))
	file:write("G_STATS.Bandades_Used = "..tostring(G_STATS.Bandades_Used))
	file:write("G_STATS.Hammer_Used = "..tostring(G_STATS.Hammer_Used))
	file:write("G_STATS.Baths_Taken = "..tostring(G_STATS.Baths_Taken))
	file:write("G_STATS.Naps_Taken = "..tostring(G_STATS.Naps_Taken))
	file:close()
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

function Meta_Game.Music()
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
end

function Meta_Game.Draw()
	Meta_Game.Music()

	love.graphics.print({{0,0,0},StringFetch(11)..G_DAY},0,0)
	love.graphics.print({{0,0,0},StringFetch(12)..Bank.balance},0,20)
	local m = string.format("%02d",math.floor((Meta_Game.Timer_Goal - Meta_Game.Timer) / 60))
	local s = string.format("%02d",math.fmod((Meta_Game.Timer_Goal - Meta_Game.Timer), 60))
	love.graphics.print({{0,0,0},StringFetch(13)..m..":"..s},0,40)
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
				Meta_Game.Deposit = false
				Meta_Game.Interaction = true
				Meta_Game.Interaction_Timer = 0
				Meta_Game.Interaction_Timer_Goal = 3.5
				Meta_Game.Interaction_Draw = Meta_Game.Cured_Draw
				Meta_Game.Cured_Pet = PopTbl(Meta_Game.Animals)
			end
		end
	else
		if #Meta_Game.Animals == 0 then
			End_Day()
		end
	end

	if Meta_Game.Tick then
		Meta_Game.Timer = Meta_Game.Timer + dt
		if Meta_Game.Timer > Meta_Game.Timer_Goal then
			-- end of day
			End_Day()
		end
	end
end

function Meta_Game.Keypressed(key)
	if key == "escape" then
		G_MUSIC_PLAYING = false
		G_LAST_STATE = G_STATE
		G_STATE = G_STATE_MAIN_MENU
		G_STATE_SUB = 1
	end
end

function Meta_Game.Mousepressed(x,y,button)

end

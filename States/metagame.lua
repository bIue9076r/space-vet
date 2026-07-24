-- Meta Game State
Meta_Game = {}
Meta_Game.Animals = {}

Meta_Game.Animal_Count = 1
Meta_Game.Timer = 0
Meta_Game.Timer_Goal = 4*60
Meta_Game.Tick = true

Meta_Game.Swiping = false
Meta_Game.Last_X = 0
Meta_Game.Swipe_t = 0
Meta_Game.Swipe_max = 0.125

Meta_Game.Interaction = false
Meta_Game.Interaction_Draw = nil
Meta_Game.Interaction_Timer = 0
Meta_Game.Interaction_Timer_Goal = 0

Meta_Game.Cured = false
Meta_Game.Cured_Pet = nil
Meta_Game.Cured_Location = 1
Meta_Game.Deposit = false
Meta_Game.Cured_Draw = function ()
	local t = math.min(1,Meta_Game.Interaction_Timer/(Meta_Game.Interaction_Timer_Goal - 1))

	love.graphics.setColor(1,1,1,(1 - t))
	local n = 1 -- TODO: Dynamic animations
	local p = Meta_Game.Cured_Pet:position(Meta_Game.Cured_Location) -- TODO: plus offsets
	local h = Meta_Game.Cured_Pet:hitbox()
	love.graphics.draw(Meta_Game.Cured_Pet:image(n),p.x,p.y)

	if G_DEBUG then
		love.graphics.setColor(0,0,1,(1 - t)*0.25)
		love.graphics.rectangle("fill",h.x,h.y,h.w,h.h)
	end

	if (not Meta_Game.Deposit) and Meta_Game.Interaction_Timer > (Meta_Game.Interaction_Timer_Goal - 1) then
		Bank.Deposit(math.random(170,200))
		G_STATS.Pets = G_STATS.Pets + 1
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
		Meta_Game.Animal_Count = math.min(10,2*G_DAY)
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
	G_TRANSITION_BLOCKING = true
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
			G_TRANSITION_BLOCKING = false
			return false
		end
		return true
	end
end

function New_Game()
	G_MUSIC_PLAYING = true
	G_STATE = G_STATE_OUTSIDE
	G_STATE_SUB = 1

	if G_MUSIC_SONG then
		G_MUSIC_SONG:stop()
	end
	G_MUSIC_NEW()
	if G_MUSIC_SONG then
		G_MUSIC_SONG:play()
	end

	G_PLAYING = true
	G_DAY = 0
	Bank.balance = 0
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Npx = 60
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Npy = 60
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Npw = 300
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Nph = 300
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Sx = 415
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Sy = 300
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Sw = 300
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Sh = 200
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Shx = 415
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Shy = 75
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Shw = 300
	G_STATE_ONLINE_SHOP_SUBSTATES[1].Shh = 200
	G_STATE_ONLINE_SHOP_SUBSTATES[1].windows = {3,2,1}
	ShopSetup()
	New_Day()

	Meta_Game.Animals = {
		Animal.new("Xittens", "Catlike", "Alien_1"),
	}

	Meta_Game.Animals[1].aches = {
		[1] = "Antenne"
	}
end

function Load_Game(path)
	path = path or G_SAVE_PATH
	local st, save, err = pcall(love.filesystem.load, path)
	if not st or err then
		-- Panic(err,"Load_Game")
		return
	end

	local V = G_VERSION
	pcall(save)
	
	for i,v in pairs(Meta_Game.Animals) do
		setmetatable(v,{__index = Animal})
	end


	if V > G_VERSION then -- it shouldn't break but in case
		-- Panic("Save File Issue", "Load_Game")
	end
end

function Save_Game(path)
	path = path or G_SAVE_PATH
	-- Stuff to store
		-- Version
		-- G_DEBUG
		-- Main_Volume
		-- Music_Volume
		-- SFX_Volume
		-- G_LAST_STATE
		-- G_PLAYING
		-- G_HINTS
		-- G_ENDING
		-- Bank.balance
		-- G_DAY
		-- G_CHEATS_ALWAYS_AVALIABLE
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Npx = 60
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Npy = 60
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Npw = 300
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Nph = 300
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Sx = 415
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Sy = 300
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Sw = 300
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Sh = 200
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Shx = 415
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Shy = 75
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Shw = 300
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].Shh = 200
		-- G_STATE_ONLINE_SHOP_SUBSTATES[1].windows = {1,2,3}
		-- Meta_Game.Timer
		-- Meta_Game.Tick
		-- Meta_Game.Interaction
		-- Meta_Game.Interaction_Timer
		-- Meta_Game.Interaction_Timer_Goal
		-- Meta_Game.Cured
		-- Meta_Game.Deposit
		-- Meta_Game.Animals
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

	file:write("G_VERSION = "..tostring(G_VERSION).."\n")
	file:write("G_DEBUG = "..tostring(G_DEBUG).."\n")
	file:write("Main_Volume = "..tostring(Main_Volume).."\n")
	file:write("Music_Volume = "..tostring(Music_Volume).."\n")
	file:write("SFX_Volume = "..tostring(SFX_Volume).."\n")
	file:write("G_LAST_STATE = "..tostring(G_LAST_STATE).."\n")
	file:write("G_PLAYING = "..tostring(G_PLAYING).."\n")
	file:write("G_HINTS = "..tostring(G_HINTS).."\n")
	file:write("G_ENDING = "..tostring(G_ENDING).."\n")
	file:write("Bank.balance = "..tostring(Bank.balance).."\n")
	file:write("G_DAY = "..tostring(G_DAY).."\n")
	file:write("G_CHEATS_ALWAYS_AVALIABLE = "..tostring(G_CHEATS_ALWAYS_AVALIABLE).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Npx = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Npx).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Npy = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Npy).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Npw = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Npw).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Nph = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Nph).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Sx = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Sx).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Sy = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Sy).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Sw = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Sw).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Sh = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Sh).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Shx = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Shx).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Shy = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Shy).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Shw = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Shw).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].Shh = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].Shh).."\n")
	file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].windows = {}\n")
	for i = 1,#G_STATE_ONLINE_SHOP_SUBSTATES[1].windows do
		file:write("G_STATE_ONLINE_SHOP_SUBSTATES[1].windows["..tostring(i).."] = "..tostring(G_STATE_ONLINE_SHOP_SUBSTATES[1].windows[i]).."\n")
	end
	Shop.Save(file)
	file:write("Meta_Game.Timer = "..tostring(Meta_Game.Timer).."\n")
	file:write("Meta_Game.Tick = "..tostring(Meta_Game.Tick).."\n")
	file:write("Meta_Game.Interaction = "..tostring(Meta_Game.Interaction).."\n")
	file:write("Meta_Game.Interaction_Timer = "..tostring(Meta_Game.Interaction_Timer).."\n")
	file:write("Meta_Game.Interaction_Timer_Goal = "..tostring(Meta_Game.Interaction_Timer_Goal).."\n")
	file:write("Meta_Game.Cured = "..tostring(Meta_Game.Cured).."\n")
	file:write("Meta_Game.Deposit = "..tostring(Meta_Game.Deposit).."\n")
	file:write("Meta_Game.Animals = {}\n")
	for i, v in pairs(Meta_Game.Animals) do
		file:write("Meta_Game.Animals["..tostring(i).."] = {}\n")
		for i2, v2 in pairs(v) do
			if type(v2) == "table" then
				file:write("Meta_Game.Animals["..tostring(i).."][\""..tostring(i2).."\"] = {}\n")
				for i3, v3 in pairs(v2) do
					file:write("Meta_Game.Animals["..tostring(i).."][\""..tostring(i2).."\"]["..tostring(i3).."] = \""..tostring(v3).."\"\n")
				end
			else
				file:write("Meta_Game.Animals["..tostring(i).."][\""..tostring(i2).."\"] = \""..tostring(v2).."\"\n")
			end
		end
	end
	file:write("G_STATS.Pets = "..tostring(G_STATS.Pets).."\n")
	file:write("G_STATS.Pills_Used = "..tostring(G_STATS.Pills_Used).."\n")
	file:write("G_STATS.Bandades_Used = "..tostring(G_STATS.Bandades_Used).."\n")
	file:write("G_STATS.Hammer_Used = "..tostring(G_STATS.Hammer_Used).."\n")
	file:write("G_STATS.Baths_Taken = "..tostring(G_STATS.Baths_Taken).."\n")
	file:write("G_STATS.Naps_Taken = "..tostring(G_STATS.Naps_Taken).."\n")
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

	love.graphics.setColor(G_CLEAR)
	love.graphics.print({{0,0,0},StringFetch(11)..G_DAY},0,0)
	love.graphics.print({{0,0,0},StringFetch(12)..Bank.balance},0,20)
	local m = string.format("%02d",math.floor((Meta_Game.Timer_Goal - Meta_Game.Timer) / 60))
	local s = string.format("%02d",math.fmod((Meta_Game.Timer_Goal - Meta_Game.Timer), 60))
	if s == "60" then s = "00" end
	love.graphics.print({{0,0,0},StringFetch(13)..m..":"..s},0,40)
	if G_HINTS then
		if G_STATE == G_STATE_CHECK_UP then
			love.graphics.print({{0,0,0},"1. h -> 2. t,u"},0,60)
		elseif G_STATE == G_STATE_CARE_UNIT then
			love.graphics.print({{0,0,0},"1. t,y,u -> 2. h"},0,60)
		end
	end
end

function Meta_Game.Update(dt)
	local _ -- Replace with a last Y
	Meta_Game.Last_X, _ = NormalizeMouse(love.mouse.getPosition())

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

	if G_DEBUG then
		G_LP_N = G_LP_N or  1
		if key == "=" then
			local lp = Meta_Game.Animals[#Meta_Game.Animals]
			if lp then
				G_LP_N = (G_LP_N % #Kinds.list) + 1
				lp.kind = Kinds.list[G_LP_N].value
			end
		elseif key == "-" then
			local lp = Meta_Game.Animals[#Meta_Game.Animals]
			if lp then
				G_LP_N = (G_LP_N - 2) % #Kinds.list + 1
				lp.kind = Kinds.list[G_LP_N].value
			end
		end
	end
end

function Meta_Game.Mousepressed(x,y,button)
	local x,y = NormalizeMouse(x,y)
	if (x >= SCREEN_X - 50) and (y <= 50) then
		G_MUSIC_PLAYING = false
		G_LAST_STATE = G_STATE
		G_STATE = G_STATE_MAIN_MENU
		G_STATE_SUB = 1
	end
end

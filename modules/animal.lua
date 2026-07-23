-- Animal
require("modules/dayobj")
require("modules/ache")
require("modules/kinds")
require("modules/owners")
Animal = {}
Animal.aches = {}
Animal.name = "No name"
Animal.kind = "Catlike"
Animal.owner = "Alien_1"
Animal_Position = {}
Animal_Position[1] = { -- care unit
	["Catlike"] = {x = 345, y = 205},
	["Doglike"] = {x = 345, y = 155},
	["Birdlike"] = {x = 370, y = 225},
	["Wormlike"] = {x = 355, y = 210},
	["Horselike"] = {x = 345, y = 155},
	["Bunnylike"] = {x = 355, y = 205},
	["Fishlike"] = {x = 355, y = 245},
	["Ratlike"] = {x = 370, y = 245},
}

Animal_Position[2] = { -- check up
	["Catlike"] = {x = 45, y = 375},
	["Doglike"] = {x = 45, y = 325},
	["Birdlike"] = {x = 70, y = 395},
	["Wormlike"] = {x = 55, y = 380},
	["Horselike"] = {x = 45, y = 325},
	["Bunnylike"] = {x = 55, y = 375},
	["Fishlike"] = {x = 55, y = 415},
	["Ratlike"] = {x = 70, y = 415},
}

-- Animal_Position[3] = { -- bed
-- }

Animal_Position[4] = { -- xray
	["Catlike"] = {x = 120, y = 180},
	["Doglike"] = {x = 110, y = 100},
	["Birdlike"] = {x = 145, y = 195},
	["Wormlike"] = {x = 135, y = 170},
	["Horselike"] = {x = 110, y = 90},
	["Bunnylike"] = {x = 120, y = 160},
	["Fishlike"] = {x = 120, y = 205},
	["Ratlike"] = {x = 154, y = 222},
}

Animal_Position[5] = { -- pills
	["Catlike"] = {x = 405, y = 280, f = 1},
	["Doglike"] = {x = 370, y = 215, f = 1},
	["Birdlike"] = {x = 490, y = 290, f = 1},
	["Wormlike"] = {x = 430, y = 300, f = 1},
	["Horselike"] = {x = 570, y = 265, f = 1},
	["Bunnylike"] = {x = 515, y = 295, f = -1},
	["Fishlike"] = {x = 520, y = 320, f = -1},
	["Ratlike"] = {x = 490, y = 320, f = -1},
}

Animal_Position[6] = { -- hammer
	["Catlike"] = {x = 410, y = 220},
	["Doglike"] = {x = 415, y = 145},
	["Birdlike"] = {x = 500, y = 245},
	["Wormlike"] = {x = 470, y = 265},
	["Horselike"] = {x = 605, y = 165},
	["Bunnylike"] = {x = 475, y = 240},
	["Fishlike"] = {x = 480, y = 285},
	["Ratlike"] = {x = 465, y = 285},
}

Animal_Position[7] = { -- bandage
	["Catlike"] = {x = 500, y = 280},
	["Doglike"] = {x = 425, y = 225},
	["Birdlike"] = {x = 460, y = 305},
	["Wormlike"] = {x = 425, y = 300},
	["Horselike"] = {x = 475, y = 265},
	["Bunnylike"] = {x = 480, y = 280},
	["Fishlike"] = {x = 485, y = 300},
	["Ratlike"] = {x = 480, y = 275},
}

Animal_Hitbox = {}
Animal_Hitbox[1] = {
	["Catlike"] = {x = 390, y = 270, w = 230, h = 140},
	["Doglike"] = {x = 360, y = 205, w = 260, h = 195},
	["Birdlike"] = {x = 480, y = 290, w = 85, h = 110},
	["Wormlike"] = {x = 440, y = 300, w = 135, h = 95},
	["Horselike"] = {x = 420, y = 205, w = 260, h = 195},
	["Bunnylike"] = {x = 460, y = 285, w = 105, h = 120},
	["Fishlike"] = {x = 465, y = 320, w = 100, h = 95},
	["Ratlike"] = {x = 445, y = 325, w = 125, h = 70},
}

Animal_Hitbox[2] = {
	["Catlike"] = {x = 90, y = 440, w = 230, h = 140},
	["Doglike"] = {x = 60, y = 375, w = 260, h = 195},
	["Birdlike"] = {x = 180, y = 460, w = 85, h = 110},
	["Wormlike"] = {x = 140, y = 470, w = 135, h = 95},
	["Horselike"] = {x = 120, y = 375, w = 260, h = 195},
	["Bunnylike"] = {x = 160, y = 455, w = 105, h = 120},
	["Fishlike"] = {x = 165, y = 490, w = 100, h = 95},
	["Ratlike"] = {x = 145, y = 495, w = 125, h = 70},
}

Animal_Size = {
	["Catlike"] = 2,
	["Doglike"] = 2,
	["Birdlike"] = 1,
	["Wormlike"] = 1,
	["Horselike"] = 2,
	["Bunnylike"] = 1,
	["Fishlike"] = 1,
	["Ratlike"] = 1,
}

-- New Animal
-- Takes: n - name; k - kind; o - owner
-- Returns: Animal
function Animal.new(n,k,o)
	local tbl = {
		name = n or "No name",
		kind = Kinds.Validate(k),
		owner = Owners.Validate(o),
		aches = {},
		-- Multiple Combinations of Aches in the future
	}

	local mt = {
		__index = Animal,
	}

	return setmetatable(tbl, mt)
end

function Animal:image(n)
	n = n or 1
	return Image.get(tostring(self.kind).."_"..tostring(self.aches[1]).."_"..tostring(n)) or Image.get("Catlike_None_1")
end

function Animal:position(n)
	n = n or 1
	local P = Animal_Position[n] or Animal_Position[1]
	return P[self.kind]
end

-- TODO: offsets
-- function Animal:offset(n,t)
--	n = n or 1
-- 	t = t or 0
-- 	local P = Animal_Offset[n] or Animal_Offset[1]
-- 	return {x = P[self.kind].x(t), y = P[self.kind].y(t)}
-- end

function Animal:hitbox(n)
	n = n or 1
	local H = Animal_Hitbox[n] or Animal_Hitbox[1]
	return H[self.kind]
end

function Animal:size()
	return Animal_Size[self.kind] or 1
end

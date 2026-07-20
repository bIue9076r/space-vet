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
Animal_Position[1] = { -- floor
	["Catlike"] = {x = 150, y = 350},
	["Doglike"] = {x = 150, y = 300},
	["Birdlike"] = {x = 175, y = 370},
	["Wormlike"] = {x = 160, y = 355},
	["Horselike"] = {x = 150, y = 300},--{x = 100, y = 275},
	["Bunnylike"] = {x = 160, y = 350},
	["Fishlike"] = {x = 160, y = 390},
	["Ratlike"] = {x = 175, y = 390},
}

Animal_Position[2] = { -- bath
	["Catlike"] = {x = 30, y = 200},
	["Doglike"] = {x = 50, y = 200},
	["Birdlike"] = {x = 35, y = 215},
	["Wormlike"] = {x = 40, y = 200},
	["Horselike"] = {x = 0, y = 120},
	["Bunnylike"] = {x = 40, y = 190},
	["Fishlike"] = {x = 40, y = 250},
	["Ratlike"] = {x = 50, y = 225},
}

Animal_Position[3] = { -- bed
	["Catlike"] = {x = 460, y = 225},
	["Doglike"] = {x = 460, y = 235},
	["Birdlike"] = {x = 455, y = 230},
	["Wormlike"] = {x = 470, y = 220},
	["Horselike"] = {x = 425, y = 180},
	["Bunnylike"] = {x = 455, y = 200},
	["Fishlike"] = {x = 455, y = 240},
	["Ratlike"] = {x = 455, y = 260},
}

Animal_Position[4] = { -- xray
	["Catlike"] = {x = 70, y = 130},
	["Doglike"] = {x = 60, y = 40},
	["Birdlike"] = {x = 95, y = 145},
	["Wormlike"] = {x = 85, y = 120},
	["Horselike"] = {x = 60, y = 40},--{x = -10, y = -10},
	["Bunnylike"] = {x = 70, y = 110},
	["Fishlike"] = {x = 70, y = 155},
	["Ratlike"] = {x = 104, y = 172},
}

Animal_Position[5] = { -- pills
	["Catlike"] = {x = 225, y = 450},
	["Doglike"] = {x = 190, y = 370},
	["Birdlike"] = {x = 320, y = 445},
	["Wormlike"] = {x = 260, y = 460},
	["Horselike"] = {x = 400, y = 415},
	["Bunnylike"] = {x = 270, y = 460},
	["Fishlike"] = {x = 270, y = 480},
	["Ratlike"] = {x = 240, y = 480},
}

Animal_Position[6] = { -- hammer
	["Catlike"] = {x = 185, y = 380},
	["Doglike"] = {x = 175, y = 285},
	["Birdlike"] = {x = 290, y = 395},
	["Wormlike"] = {x = 250, y = 410},
	["Horselike"] = {x = 370, y = 315},
	["Bunnylike"] = {x = 250, y = 390},
	["Fishlike"] = {x = 270, y = 440},
	["Ratlike"] = {x = 250, y = 445},
}

Animal_Position[7] = { -- bandage
	["Catlike"] = {x = 310, y = 455},
	["Doglike"] = {x = 225, y = 410},
	["Birdlike"] = {x = 280, y = 480},
	["Wormlike"] = {x = 240, y = 490},
	["Horselike"] = {x = 375, y = 460},
	["Bunnylike"] = {x = 320, y = 470},
	["Fishlike"] = {x = 284, y = 470},
	["Ratlike"] = {x = 308, y = 470},
}

Animal_Hitbox = {
	["Catlike"] = {x = 195, y = 435, w = 230, h = 120},
	["Doglike"] = {x = 165, y = 390, w = 260, h = 155},
	["Birdlike"] = {x = 285, y = 435, w = 85, h = 110},
	["Wormlike"] = {x = 245, y = 445, w = 135, h = 95},
	["Horselike"] = {x = 225, y = 390, w = 260, h = 155},
	["Bunnylike"] = {x = 265, y = 430, w = 105, h = 120},
	["Fishlike"] = {x = 270, y = 465, w = 100, h = 95},
	["Ratlike"] = {x = 250, y = 470, w = 125, h = 70},
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

function Animal:hitbox()
	return Animal_Hitbox[self.kind] or Animal_Hitbox["Catlike"]
end

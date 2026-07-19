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
	["Horselike"] = {x = 100, y = 275},
	["Bunnylike"] = {x = 160, y = 350},
	["Fishlike"] = {x = 160, y = 390},
	["Ratlike"] = {x = 175, y = 390},
}

Animal_Position[2] = { -- bath
	["Catlike"] = {x = 30, y = 200},
	["Doglike"] = {x = 50, y = 200},
	["Birdlike"] = {x = 35, y = 215},
	["Wormlike"] = {x = 40, y = 200},
	["Horselike"] = {x = -10, y = 100},
	["Bunnylike"] = {x = 40, y = 190},
	["Fishlike"] = {x = 40, y = 250},
	["Ratlike"] = {x = 50, y = 225},
}

Animal_Position[3] = { -- bed
	["Catlike"] = {x = 460, y = 225},
	["Doglike"] = {x = 460, y = 235},
	["Birdlike"] = {x = 455, y = 230},
	["Wormlike"] = {x = 470, y = 220},
	["Horselike"] = {x = 400, y = 130},
	["Bunnylike"] = {x = 455, y = 200},
	["Fishlike"] = {x = 455, y = 240},
	["Ratlike"] = {x = 455, y = 260},
}

Animal_Position[4] = { -- xray
	["Catlike"] = {x = 70, y = 130},
	["Doglike"] = {x = 60, y = 40},
	["Birdlike"] = {x = 95, y = 145},
	["Wormlike"] = {x = 85, y = 120},
	["Horselike"] = {x = -10, y = -10},
	["Bunnylike"] = {x = 70, y = 110},
	["Fishlike"] = {x = 70, y = 155},
	["Ratlike"] = {x = 104, y = 172},
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

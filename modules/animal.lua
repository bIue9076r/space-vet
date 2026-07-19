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
	["Birdlike"] = {x = 150, y = 350},
	["Wormlike"] = {x = 150, y = 350},
	["Horselike"] = {x = 100, y = 275},
	["Bunnylike"] = {x = 150, y = 350},
	["Fishlike"] = {x = 150, y = 350},
	["Ratlike"] = {x = 150, y = 350},
}

Animal_Position[2] = { -- bath
	["Catlike"] = {x = 50, y = 200},
	["Doglike"] = {x = 50, y = 200},
	["Birdlike"] = {x = 50, y = 200},
	["Wormlike"] = {x = 50, y = 200},
	["Horselike"] = {x = 50, y = 100},
	["Bunnylike"] = {x = 50, y = 200},
	["Fishlike"] = {x = 50, y = 200},
	["Ratlike"] = {x = 50, y = 200},
}

Animal_Position[3] = { -- bed
	["Catlike"] = {x = 500, y = 200},
	["Doglike"] = {x = 500, y = 200},
	["Birdlike"] = {x = 500, y = 200},
	["Wormlike"] = {x = 500, y = 200},
	["Horselike"] = {x = 400, y = 200},
	["Bunnylike"] = {x = 500, y = 200},
	["Fishlike"] = {x = 500, y = 200},
	["Ratlike"] = {x = 500, y = 200},
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

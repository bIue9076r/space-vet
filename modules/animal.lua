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

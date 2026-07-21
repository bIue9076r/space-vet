-- Owners
Owners = {}
Owners.list = {
	DayObj.new("Alien_1"),
	DayObj.new("Alien_2"),
	DayObj.new("Alien_3"),
	DayObj.new("Alien_4"),
	DayObj.new("Alien_5"),
	DayObj.new("Alien_6"),
	DayObj.new("Alien_7"),
	DayObj.new("Alien_8"),
	DayObj.new("Alien_9"),
	DayObj.new("Alien_10"),
	DayObj.new("Alien_11"),
	DayObj.new("Alien_12"),
	-- In the future add more owners :V
}

-- Validate Owner
-- Takes: o - Owner string
-- Returns: Owner string
function Owners.Validate(o)
	for i, v in pairs(Owners.list) do
		if o == v.value and DayObj.Available(v) then
			return o
		end
	end

	return "Alien_1"
end

function Owners.Generate()
	local tbl = {}
	for i,v in pairs(Owners.list) do
		if DayObj.Available(v) then
			table.insert(tbl,v.value)
		end
	end

	return tbl[math.random(1,#tbl)]
end

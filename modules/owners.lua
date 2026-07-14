-- Owners
Owners = {}
Owners.list = {
	DayObj.new("Alien_1"),
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

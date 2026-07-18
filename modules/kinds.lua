-- Kinds
Kinds = {}
Kinds.list = {
	DayObj.new("Catlike"), -- DayObj.new("Doglike",2), DayObj.new("Birdlike",2),
	DayObj.new("Wormlike",3), DayObj.new("Horselike",3), DayObj.new("Bunnylike",4),
	DayObj.new("Fishlike",4), -- DayObj.new("Ratlike",5)
	-- In the future add more animals :V
}

-- Validate Kind
-- Takes: k - kind string
-- Returns: Kind string
function Kinds.Validate(k)
	for i, v in pairs(Kinds.list) do
		if k == v.value and DayObj.Available(v) then
			return k
		end
	end

	return "Catlike"
end

function Kinds.Generate()
	local tbl = {}
	for i,v in pairs(Kinds.list) do
		if DayObj.Available(v) then
			table.insert(tbl,v.value)
		end
	end

	return tbl[math.random(1,#tbl)]
end

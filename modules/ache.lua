-- Ache
Ache = {}
Ache.list = {
	DayObj.new("Antenne"),
	DayObj.new("Tummy",2),
	DayObj.new("Cold",3),
	DayObj.new("Scratch",4),
	DayObj.new("Stinky",5)
}

-- Validate Ache
-- Takes: a - Ache string
-- Returns: Ache string
function Ache.Validate(a)
	for i, v in pairs(Ache.list) do
		if a == v.value and DayObj.Available(v) then
			return a
		end
	end

	return "Antenne"
end

function Ache.Generate()
	local tbl = {}
	for i,v in pairs(Ache.list) do
		if DayObj.Available(v) then
			table.insert(tbl,v.value)
		end
	end

	return tbl[math.random(1,#tbl)]
end

-- Kinds
Kinds = {}
Kinds.list = {
	DayObj.new("Catlike"), DayObj.new("Doglike",1), DayObj.new("Birdlike",1),
	DayObj.new("Wormlike",2), DayObj.new("Horselike",2), DayObj.new("Bearlike",3),
	DayObj.new("Fishlike",3), DayObj.new("Ratlike",4)
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

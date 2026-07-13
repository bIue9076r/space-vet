-- Ache
Ache = {}
Ache.list = {
	DayObj.new("Antenne"),
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

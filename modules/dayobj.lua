-- DayObj
DayObj = {}
DayObj.value = nil
DayObj.day = 0

-- New DayObj
-- Takes: v - value; day - day
-- Returns: DayObj
function DayObj.new(v,day)
	return {value = v, day = day or 0}
end

-- DayObj Available
-- Takes: DayObj
-- Returns: If available
function DayObj.Available(DObj)
	if DObj.day <= G_DAY then
		return true
	end

	return false
end

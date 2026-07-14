Days = {}
Days.days = {}

function NextDay()
	G_DAY = G_DAY + 1
	if Days.days[G_DAY] then
		-- Load day if something special
		Days.days[G_DAY]()
	end
end

Days.days[2] = function()
	
end

Days.days[3] = function()
	
end

Days.days[4] = function()
	
end

Days.days[5] = function()
	
end

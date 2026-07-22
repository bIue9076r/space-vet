-- Shop module
require("modules/bank")
Shop = {}
Shop.goods = {}
Shop.position = 1
Shop.lowerWindow = 1
Shop.windowSize = 4

function Shop.newGood(name,cost,n,b)
	if n and (type(n) == "number") then
		Shop.goods[n] = {name = name or "Good", cost = cost or math.maxinteger, bought = b or false}
	else
		table.insert(Shop.goods,{name = name or "Good", cost = cost or math.maxinteger, bought = false})
	end
end

function Shop.clearGoods()
	Shop.goods = {}
end

function Shop.Save(fileObj)
	for i,v in ipairs(Shop.goods) do
		fileObj:write("Shop.newGood(\""..v.name.."\","..v.cost..","..i..","..tostring(v.bought)..")\n")
	end
end

function Shop.buy(nname)
	if type(nname) == "number" then
		local n = nname
		if not Shop.goods[n] then
			return false
		end

		if Shop.goods[n].bought then
			return false
		end

		if not Bank.Spend(Shop.goods[n].cost) then
			Shop.goods[n].bought = true
			return true
		end
	else
		local name = nname
		for i, v in pairs(Shop.goods) do
			if v.name == name then
				if Shop.goods[i].bought then
					return false
				end
				
				if not Bank.Spend(Shop.goods[i].cost) then
					Shop.goods[i].bought = true
					return true
				end
			end
		end
	end

	return false
end

function Shop.getRange()
	local l = Shop.lowerWindow
	local h = Shop.lowerWindow + Shop.windowSize

	local tbl = {}
	for i = l,h do
		if Shop.goods[i] then
			table.insert(tbl,{index = i , good = Shop.goods[i]})
		end
	end
	return tbl
end

function Shop.positionAdvance()
	Shop.position = math.min(Shop.position + 1, #Shop.goods)
	if Shop.position > (Shop.lowerWindow + Shop.windowSize) then
		Shop.lowerWindow = math.min(Shop.lowerWindow + 1, #Shop.goods)
	end
end

function Shop.positionDiminish()
	Shop.position = math.max(Shop.position - 1, 1)
	if Shop.position < Shop.lowerWindow then
		Shop.lowerWindow = math.max(Shop.lowerWindow - 1, 1)
	end
end

function Shop.select()
	Shop.buy(Shop.position)
end

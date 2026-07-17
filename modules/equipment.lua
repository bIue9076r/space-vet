Equipment = {
    level = 1,
    Upgrade_Cost = 500,
    -- Upgrade_func = // constant for now

    -- Checks if the tool is used successfully
    act = function(self)
        if self.level == 1 then
            if math.random(0,1) == 0 then
                return true -- success
            end
            return false
        end
    end,

    -- Upgrades the tool if there is enough money and act function is successful
    upgrade = function(self)
        local result = (Bank.balance - self.Upgrade_Cost)

        if result < 0 then
            -- broke
            -- play sfx(No_money)
            self.level = self.level
			return
        end

		-- play sfx (Spend)
		self.level = self.level + 1
		Bank.balance = result
		-- self.Upgrade_Cost = self.Upgrade_func()
    end
}

-- Creates new tool
function Equipment.new(newCost)
    local newTool = {
		level = 1,
		Upgrade_Cost = newCost or 500,
	}

	local mt = {
		__index = Equipment,
	}

    return setmetatable(newTool,mt)
end


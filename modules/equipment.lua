Equipment = {
    level = 1,
    Upgrade_Cost = 500,
    -- Upgrade_func = // linear for now

    -- Checks if the upgrade is a success
    act = function()
        if Equipment.level == 1 then
            if math.random(0,1) == 0 then
                return true -- success
            end
            return false
        end
    end,

    -- Upgrades the tool if there is enough money and act function is successful
    upgrade = function()
        local result = (Bank.balance - Equipment.Upgrade_Cost)

        if result < 0 then
            -- broke
            -- play sfx(No_money)
            Equipment.level = Equipment.level
            return true
        end

        if Equipment.act() then
            -- play sfx (Spend)
            Equipment.level = Equipment.level + 1
            Bank.balance = result
            return false

        else 
            Equipment.level = Equipment.level
            -- sfx (Not successful)
            return true
        end
    end
}

-- Creates new tool
function Equipment.new(newCost)
    local newTool = {}

    newTool.level = Equipment.level
    newTool.Upgrade_Cost = newCost or Equipment.Upgrade_Cost

    return newTool
end


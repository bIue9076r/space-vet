-- Bank
Bank = {}

Bank.balance = 0 -- Balance
Bank.rate = 1.03 -- Intrest rate

-- Deposits money
-- Takes: n - amount of money to deposit
-- Returns: nothing
function Bank.Deposit(n)
	-- Play_Sfx(Spend)
	Bank.balance = Bank.balance + n
end

-- Spends money
-- Takes: n - amount of money to spend
-- Returns: If decline
function Bank.Spend(n)
	local result = (Bank.balance - n)
	if result < 0 then
		-- Broke
		-- Play_Sfx(No_money)
		return true
	end

	-- Play_Sfx(Spend)
	Bank.balance = result
	return false
end

-- Call this once per day change?
-- Intrest rate of 3% per day, pretty big.
function Bank.Update()
	Bank.balance = Bank.balance * Bank.rate
end
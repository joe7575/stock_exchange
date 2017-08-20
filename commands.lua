minetest.register_chatcommand("money_add", {
	params = "<PlayerName> <Value>",
	description = "Add <value> money to the players account",
	func = function(name, param)
		local player_name, value = param:match('^(%S+)%s(%d+)$')

		if player_name == nil or tonumber(value) == nil then
			return false, "[Stock] Syntax: money_add <PlayerName> <Value>"
		end
		if minetest.check_player_privs(name, "creative") then
			if stock_exchange.update_player_hud(name, tonumber(value)) then
				return true, "[Stock] amount added"
			end
			return false, "[Stock] Unknown player"
		else
			return false, "[Stock] Priv missing"
		end
	end,
})

minetest.register_chatcommand("money_set", {
	params = "<PlayerName> <Value>",
	description = "Set players account to the given value",
	func = function(name, param)
		local player_name, value = param:match('^(%S+)%s(%d+)$')

		if player_name == nil or tonumber(value) == nil then
			return false, "[Stock] Syntax: money_set <PlayerName> <Value>"
		end
		if minetest.check_player_privs(name, "creative") then
			if stock_exchange.set_player_hud(name, tonumber(value)) then
				return true, "[Stock] amount set"
			end
			return false, "[Stock] Unknown player"
		else
			return false, "[Stock] Priv missing"
		end
	end,
})

minetest.register_chatcommand("money_get", {
	params = "<PlayerName>",
	description = "Get players account",
	func = function(name, param)
		local player_name = param:match('^(%S+)$')

		if player_name == nil then
			return false, "[Stock] Syntax: money_get <PlayerName>"
		end
		if minetest.check_player_privs(name, "creative") then
			local value = stock_exchange.get_player_account(name)
			if value then
				return true, "[Stock] Player "..player_name.." has "..value.." €"
			end
			return false, "[Stock] Unknown player"
		else
			return false, "Priv missing"
		end
	end,
})

--[[

	Stock Exchange
	==============

	v0.05 by JoSt

	Copyright (C) 2017 Joachim Stolberg

	LGPLv2.1+
	See LICENSE.txt for more information

	History:
	2017-08-15  v0.01  First version
	2017-08-17  v0.02  Stones added
	2017-08-21  v0.03  Shop added
	2017-08-23  v0.04  Cactus added
	2017-08-28  v0.05  Sell Cancel bugfix
	2018-03-31  v0.06  price fluctuation added

]]--

local DefaultStock = {
	Coal = {name="default:coal_lump", amount=1000, price=10, trend=""},
	Steel = {name="default:steel_ingot", amount=1000, price=10, trend=""},
	Flint = {name="default:flint", amount=1000, price=10, trend="+"},
	Copper = {name="default:copper_ingot", amount=1000, price=32, trend=""},
	Tin = {name="default:tin_ingot", amount=1000, price=40, trend=""},
	Gold = {name="default:gold_ingot", amount=1000, price=60, trend=""},
	Mese = {name="default:mese_crystal", amount=1000, price=80, trend=""},
	Diamond = {name="default:diamond", amount=1000, price=100, trend=""},
	Silver = {name="moreores:silver_ingot", amount=1000, price=60, trend=""},
	Mithril = {name="moreores:mithril_ingot", amount=1000, price=120, trend=""},
	Apple = {name="default:apple", amount=1000, price=10, trend=""},
	Bread = {name="farming:bread", amount=1000, price=25, trend=""},
	Mushroom = {name="flowers:mushroom_brown", amount=1000, price=5, trend=""},
	["Wheat Seed"] = {name="farming:seed_wheat", amount=1000, price=10, trend=""},
	["Cotton Seed"] = {name="farming:seed_cotton", amount=1000, price=10, trend=""},
	["White dye"] = {name="dye:white", amount=1000, price=5, trend="+"},
	["Blue dye"] = {name="dye:blue", amount=1000, price=5, trend="+"},
	["Green dye"] = {name="dye:green", amount=1000, price=5, trend="+"},
	["Yellow dye"] = {name="dye:yellow", amount=1000, price=5, trend="+"},
	["Red dye"] = {name="dye:red", amount=1000, price=5, trend="+"},
	["Black dye"] = {name="dye:black", amount=1000, price=5, trend="+"},
	Paper = {name="default:paper", amount=1000, price=10, trend=""},
	Wheat = {name="farming:wheat", amount=1000, price=7, trend=""},
	Cotton = {name="farming:cotton", amount=1000, price=4, trend=""},
	Flour = {name="farming:flour", amount=1000, price=20, trend=""},
	Terracotta = {name="homedecor:terracotta_base", amount=1000, price=10, trend=""},
	Strow = {name="farming:straw ", amount=1000, price=21, trend=""},
	["White Wool"] = {name="wool:white", amount=1000, price=15, trend=""},
	["Desert Sandstone"] = {name="default:desert_sandstone", amount=1000, price=7, trend=""},
	["Sandstone"] = {name="default:sandstone", amount=10000, price=5, trend=""},
	["Silver Sandstone"] = {name="default:silver_sandstone", amount=10000, price=7, trend=""},
	["Desert Cobblestone"] = {name="default:desert_cobble", amount=10000, price=7, trend=""},
	["Mossy Cobblestone"] = {name="default:mossycobble", amount=10000, price=10, trend=""},
	["Brown Coral"] = {name="default:coral_brown", amount=1000, price=15, trend=""},
	["Orange Coral"] = {name="default:coral_orange", amount=1000, price=15, trend=""},
	["Coral Skeleton"] = {name="default:coral_skeleton", amount=1000, price=15, trend=""},
	["Plastic sheet"] =  {name="homedecor:plastic_sheeting", amount=1000, price=10, trend=""},
	Cactus = {name="default:cactus", amount=1000, price=20, trend=""},
	Coins = {name="homedecor:coin", amount=1000, price=2, trend=""},
	Marble = {name="building_blocks:Marble", amount=1000, price=15, trend=""},
	["Bio Gas"] =  {name="tubelib_addons1:biogas", amount=1000, price=7, trend=""},
	["Bio Fuel"] =  {name="tubelib_addons1:biofuel", amount=1000, price=15, trend=""},
	["Straw"] =  {name="farming:straw", amount=1000, price=21, trend=""},
	
	["Carrot"] =  {name="farming:carrot", amount=1000, price=7, trend=""},
	["Potato"] =  {name="farming:potato", amount=1000, price=7, trend=""},
	["Tomato"] =  {name="farming:tomato", amount=1000, price=7, trend=""},
	["Cucumber"] =  {name="farming:cucumber", amount=1000, price=7, trend=""},
	["Pumpkin Slice"] =  {name="farming:pumpkin_slice", amount=1000, price=7, trend=""},
	["Rhubarb"] =  {name="farming:rhubarb", amount=1000, price=7, trend=""},
	["Green Beans"] =  {name="farming:beans", amount=1000, price=7, trend=""},
	["Chili Pepper"] =  {name="farming:chili_pepper", amount=1000, price=7, trend=""},
	["Melon Slice"] =  {name="farming:melon_slice", amount=1000, price=7, trend=""},
	["Raspberries"] =  {name="farming:raspberries", amount=1000, price=7, trend=""},
	["Hemp Seed"] =  {name="farming:seed_hemp", amount=1000, price=7, trend=""},
	["Blueberries"] =  {name="farming:blueberries", amount=1000, price=7, trend=""},
	["Grapes"] =  {name="farming:grapes", amount=1000, price=7, trend=""},
	["Corn"] =  {name="farming:corn", amount=1000, price=7, trend=""},
	["Coffee Beans"] =  {name="farming:coffee_beans", amount=1000, price=7, trend=""},
	["Barley Seed"] =  {name="farming:seed_barley", amount=1000, price=7, trend=""},
	["Cocoa Beans"] =  {name="farming:cocoa_beans", amount=1000, price=7, trend=""},
	["Jungle Tree"] =  {name="default:jungletree", amount=1000, price=7, trend=""},
	["Pine Tree"] =  {name="default:pine_tree", amount=1000, price=7, trend=""},
	["Aspen Tree"] =  {name="default:aspen_tree", amount=1000, price=7, trend=""},
	["Apple Tree"] =  {name="default:tree", amount=1000, price=7, trend=""},
}

stock_exchange = {}

local storage = minetest.get_mod_storage()
local players = minetest.deserialize(storage:get_string("Players")) or {}
local Stock   = minetest.deserialize(storage:get_string("Stock")) or DefaultStock


--
-- Delete old players
--
Players = {}
for k,v in pairs(players) do
	if minetest.player_exists(k) then
		Players[k] = v
	else
		print("Player "..k.." is gone.")
	end
end

--
-- Update Stock table
--
for k,v in pairs(DefaultStock) do
	if Stock[k] == nil then
		Stock[k] = v
	end
end


local function update_mod_storage()
	storage:set_string("Players", minetest.serialize(Players))
	storage:set_string("Stock", minetest.serialize(Stock))
end

local new_day = true
local StartValue = 100
local PerDayValue = 100

local Orders = {}

local ItemGroups = {
	ores1 = {"Steel", "Copper", "Tin", "Gold", "Silver", "Mithril"},
	ores2 = {"Coal", "Flint", "Mese", "Diamond"},
	food = {"Apple", "Melon Slice", "Raspberries", "Blueberries", "Grapes", "Bread", "Wheat"},
	food2 = {"Carrot", "Potato", "Tomato", "Cucumber", "Pumpkin Slice", "Rhubarb", "Green Beans", "Chili Pepper"},
	dyes = {"White dye", "Blue dye", "Green dye", "Yellow dye",	"Red dye", "Black dye"},
	stones = {"Sandstone", "Desert Sandstone", "Silver Sandstone", "Desert Cobblestone", 
		      "Mossy Cobblestone", "Terracotta", "Marble"},
	corals = {"Coral Skeleton", "Brown Coral", "Orange Coral"},
	others = {"Cactus", "Paper", "Cotton", "White Wool", "Coins", "Plastic sheet", "Straw"},
	seed = {"Cotton Seed", "Wheat Seed", "Corn", "Coffee Beans", "Hemp Seed", "Barley Seed", "Cocoa Beans"},
	fuel = {"Bio Gas", "Bio Fuel", "Jungle Tree", "Pine Tree", "Aspen Tree", "Apple Tree"},
}

local tDescription = {
	ores1 = "Erze",
	ores2 = "Mineralien",
	food = "Obst und Lebensmittel",
	food2 = "Gemüse",
	dyes = "Farben",
	stones = "Steine",
	corals = "Korallen",
	others = "Sonstiges",
	seed = "Saatgut und Korn",
	fuel = "Kraftstoffe",
}



local lStockArticles = {}
for k,v in pairs(Stock) do
	table.insert(lStockArticles, k)
end

local function player_privs(player)
	if player:get_player_name() ~= "JoSto" then
		local privs = minetest.get_player_privs(player:get_player_name())
		privs["fly"] = nil
		privs["fast"] = nil
		minetest.set_player_privs(player:get_player_name(), privs)
    player:set_physics_override({gravity=1, speed=1})	
	end
end


minetest.register_on_newplayer(function(ObjectRef)
	local name = ObjectRef:get_player_name()
	if name ~= "" then
		Players[name] = {balance=StartValue}
	end
end)

minetest.register_on_joinplayer(function(ObjectRef)
	local name = ObjectRef:get_player_name()
	--ObjectRef:override_day_night_ratio(0.2)
	if Players[name] == nil or Players[name].balance == nil then
		Players[name] = {balance=StartValue}
	end
	local idx = ObjectRef:hud_add({
		hud_elem_type = "text",
		position = { x = 0.5, y=1 },
		text = string.format("%10.2f €", Players[name].balance),
		scale = { x = 0, y = 0 },
		alignment = { x = 1, y = 0},
		direction = 1,
		number = 0xFFFFFF,
		offset = { x = 180, y = -100}
	})		
	Players[name].hud_idx = idx
	player_privs(ObjectRef)
end)

local function price_fluctuation(article, amount)
	local price = article.price * (1 + amount/12000.0)
	article.price = price
end

function stock_exchange.player_has_money(name, price)
	local player = minetest.get_player_by_name(name)
	if player ~= nil then
		if Players[name].balance ~= nil then
			return Players[name].balance >= price
		end
	end
	return false
end

function stock_exchange.update_player_hud(name, amount)
	local player = minetest.get_player_by_name(name)
	if player ~= nil then
		if Players[name].balance ~= nil then
			Players[name].balance = Players[name].balance + amount
		else
			Players[name].balance = amount
		end
		local idx = Players[name].hud_idx
		if idx ~= nil then
			player:hud_change(idx, "text", string.format("%10.2f €", Players[name].balance))
      return true
		end
	end
	return false
end	

function stock_exchange.set_player_hud(name, amount)
	local player = minetest.get_player_by_name(name)
	if player ~= nil then
		Players[name].balance = amount
		local idx = Players[name].hud_idx
		if idx ~= nil then
			player:hud_change(idx, "text", string.format("%10.2f €", Players[name].balance))
			return true
		end
	end
	return false
end	

function stock_exchange.get_player_account(name)
	local player = minetest.get_player_by_name(name)
	if player ~= nil then
		if Players[name].balance ~= nil then
			return Players[name].balance
		end
	end
	return nil
end

local function balance_award_list()
	local sortedList = {}
	for key,val in pairs(Players) do
		if key ~= "JoSto" then
			sortedList[#sortedList+1] = {name=key, balance=val.balance}
		end
	end
	table.sort(sortedList, function(x,y) 
		return x.balance > y.balance
	end)
	return sortedList
end

minetest.register_on_leaveplayer(function(ObjectRef, timed_out)
	update_mod_storage()
end)

minetest.register_on_shutdown(function()
	update_mod_storage()
end)


local function chat(player_name, text)
	if player_name ~= nil then
		minetest.chat_send_player(player_name, "[Börse] "..text)
	end
end

local function daily_payment()
	for name, item in pairs(Players) do
		stock_exchange.update_player_hud(name, PerDayValue)
	end
end	

-- cyclically called to check if any order has to be performed
local function process_orders()
	for name, orders in pairs(Orders) do
		for _,order in ipairs(orders) do
			if tonumber(order.price) ~= nil and tonumber(order.amount) ~= nil then
				if order.transfer == "Verkaufen" and order.state == "open" then
					local price = tonumber(order.price) * tonumber(order.amount)
					order.state = "closed"
					stock_exchange.update_player_hud(name, price)
					price_fluctuation(Stock[order.item], -order.amount)
					minetest.log("action", name.." sells "..order.amount.." ".. order.item)
				elseif order.transfer == "Kaufen" and order.state == "open" then
					local price = tonumber(order.price) * tonumber(order.amount)
					if stock_exchange.player_has_money(name, price) then
						stock_exchange.update_player_hud(name, -price)
						price_fluctuation(Stock[order.item], order.amount)
						minetest.log("action", name.." buys "..order.amount.." "..order.item)
						order.state = "closed"
					end
				end
			end
		end
	end
end

local function good_morning()
	local time = minetest.get_timeofday()
	if new_day and  time ~= nil and time > 0.25 and time < 0.35 then
		minetest.chat_send_all("[Server] Guten Morgen!")
		daily_payment()
		new_day = false
	elseif time ~= nil and time > 0.75 and time < 0.85 then
		new_day = true
	end
	minetest.after(20.0, good_morning)
end


local function block_type_formspec()
	return "size[4,3]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[1,0; Minetest Börse]"..
		"label[1,0.6;Type of Block:]"..
		"textlist[1,1;2,1;block_type;Ores1,Ores2,Dyes,Food,Food2,Stones,Corals,Seed,Fuel,Others]"..
		"button_exit[1.5,2.5;1,0.8;exit;OK]"
end

-- helper function to interprete user input
local function block_type_result(player, fields)
	local pos = minetest.string_to_pos(player:get_attribute("stock_pos"))
	local meta = minetest.get_meta(pos)
	if fields.block_type then
		local tbl = {"ores1","ores2","dyes","food", "food2", "stones", "corals", "seed", "fuel", "others"}
		local idx = tonumber(string.sub(fields.block_type, 5))
		meta:set_string("selection", tbl[idx])
	elseif fields.exit == "OK" then
		local res = meta:get_string("selection")
		meta:set_string("infotext", tDescription[res])
		return res
	end
	return nil
end

-- Output a list of items from the given category
local function select_formspec(key)
	local tRes = {"size[9,10]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[3.5,0; Minetest Börse]"}
	tRes[2] = "label[2.4,0.6;Artikel]label[3.7,0.6;Preis]label[5,0.6;Trend]"..
			  "label[6.4,0.6;Kaufen]label[8,0.6;Verkaufen]"
	for idx,item in ipairs(ItemGroups[key]) do
		if Stock[item] then
			local value = Stock[item].price
			local ypos = 0.4 + idx*1.1
			local ypos2 = ypos + 0.2
			local ypos3 = ypos - 0.1
			tRes[#tRes+1] = "label[0.2,"..ypos2..";"..item.."]"
			tRes[#tRes+1] = "box[2.3,"..ypos3..";1,0.9;#555555]"
			tRes[#tRes+1] = "item_image[2.4,"..ypos3..";1,1;"..Stock[item].name.."]"
			tRes[#tRes+1] = "label[3.4,"..ypos2..";"..string.format("%6.2f", Stock[item].price).." €]"
			tRes[#tRes+1] = "image[5,"..ypos2..";stock_exchange_arrow.png]"
			tRes[#tRes+1] = "button_exit[6.3,"..ypos..";1,1;"..item..";buy]"
			tRes[#tRes+1] = "button_exit[8,"..ypos..";1,1;"..item..";sell]"
		end
	end
	return table.concat(tRes)
end	


local function buy_formspec(item)
	local price = string.format("%6.2f", Stock[item].price * 1.01)
	return "size[8,5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[2,0; Minetest Börse]"..
		"box[0.3,1.1;1,0.9;#555555]"..
		"item_image[0.4,1.1;1,1;"..Stock[item].name.."]"..
		"label[2,1.0;Artikel:]label[4.5,1.0;"..item.."]"..
		"label[2,1.6;Verfügbar:]label[4.5,1.6;"..Stock[item].amount.." Stück]"..
		"label[2,2.2;zum Preis:]label[4.5,2.2;"..price.." €]"..
		"label[2,3.4;Ich kaufe:]"..
		"field[1,4.6;2,1;number;Stück;10]"..
		"button_exit[5.2,4.3;1.8,1;buy;Kaufen]"
end	

local function sell_formspec(item, spos)
	local price = string.format("%6.2f", Stock[item].price * 0.99)
	return "size[8,9]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[2.8,0; Minetest Börse]"..
		"box[0.3,1.1;1,0.9;#555555]"..
		"item_image[0.4,1.1;1,1;"..Stock[item].name.."]"..
		"label[2,1.0;Artikel:]label[4.5,1.0;"..item.."]"..
		"label[2,1.5;Nachfrage:]label[4.5,1.5;"..Stock[item].amount.." Stück]"..
		"label[2,2;zum Preis:]label[4.5,2;"..price.." €]"..
		"label[2,2.8;Ich verkaufe:]"..
		"list[nodemeta:"..spos..";src;1.1,3.5;1,1;]"..
		"button_exit[5.2,3.5;2,1;sell;Verkaufen]"..
		"list[current_player;main;0,5;8,4;]"..
		"listring[nodemeta:"..spos..";src]"..
		"listring[current_player;main]"
end	

-- helper function to interprete user input
local function formspec_order(fields)
	for k,v in pairs(fields) do
		if k ~= "quit" then
			return k,v
		end
	end
	return nil, nil
end

-- helper function to interprete user input
local function formspec_cancel(fields)
	for k,v in pairs(fields) do
		if string.sub(k, 1, 3) == "btn" then
			return tonumber(string.sub(k, 4))
		end
	end
	return nil
end

function stock_exchange.add_to_players_inventory(player_name, item_name, amount)
	local inv = minetest.get_inventory({type="player", name=player_name})
	local stack
	if amount < 2 then
		stack = ItemStack(item_name)
	else
		stack = ItemStack(item_name.." "..amount)
	end
	if not inv:room_for_item("main", stack) then
		chat(player_name, "Error: Dein Inventory ist voll!")
		return false
	end
	inv:add_item("main", stack)
	return true
end

local function stock_open(player)
	local time = minetest.get_timeofday()
	if time ~= nil and time > 0.375 and time < 0.75 then
		return true
	else
		chat(player:get_player_name(), "Die Börse hat jetzt zu. Öffnungszeiten: 9:00 - 18:00 Uhr. Und Tschüss :-)")
		return false
	end
end	

local function on_player_receive_fields(player, formname, fields)
	local player_name = player:get_player_name()
	if formname == "stock_exchange:block_type" then			-- select block type?
		block_type_result(player, fields)
	elseif formname == "stock_exchange:select" then			-- select an item ?
		local item, transfer = formspec_order(fields)
		if transfer == "buy" then
			player:set_attribute("stock_item", item)
			minetest.show_formspec(player_name, "stock_exchange:buy", buy_formspec(item))
		elseif transfer == "sell" then
			player:set_attribute("stock_item", item)
			local pos = minetest.string_to_pos(player:get_attribute("stock_pos"))
			local spos = pos.x..","..pos.y..","..pos.z
			minetest.show_formspec(player_name, "stock_exchange:sell", sell_formspec(item, spos))
		end
	elseif formname == "stock_exchange:buy" then		-- buy an item?
		if fields.buy == "Kaufen" then
			local item = player:get_attribute("stock_item")
			if Orders[player_name] == nil then
				Orders[player_name] = {}
			end
			if fields.number ~= nil then
				local amount = tonumber(fields.number)
				if amount then
					amount = math.min(amount, 99)
				end
				if amount ~= nil and amount > 0 then
					Orders[player_name][#Orders[player_name]+1] = {transfer=fields.buy, item=item, 
								amount=amount, price=Stock[item].price, state="open", item=item}
				end
			end
		end
	elseif formname == "stock_exchange:sell" then		-- sell an item?
		if fields.sell == "Verkaufen" then
			local item = player:get_attribute("stock_item")
			local pos = minetest.string_to_pos(player:get_attribute("stock_pos"))
			local inv = minetest.get_inventory({type="node", pos=pos})
			local stack = ItemStack(Stock[item].name.." 99")
			local taken = inv:remove_item("src", stack)
			local amount = taken:get_count()
			if Orders[player_name] == nil then
				Orders[player_name] = {}
			end
			if amount ~= nil and amount > 0 then
				Orders[player_name][#Orders[player_name]+1] = {transfer=fields.sell, item=item, 
							amount=amount, price=Stock[item].price, state="open", item=item}
			end
		end
	elseif formname == "stock_exchange:orders" then		-- delete transfer list item?
		local idx = formspec_cancel(fields)
		if idx then
			local order = Orders[player_name][idx]
			local res = true
			if order and order.transfer == "Kaufen" and order.state == "closed" then
				res = stock_exchange.add_to_players_inventory(player_name, Stock[order.item].name, order.amount)
			elseif order and order.transfer == "Verkaufen" and order.state == "open" then
				res = stock_exchange.add_to_players_inventory(player_name, Stock[order.item].name, order.amount)
			end
			if res then
				table.remove(Orders[player_name], idx)
			end
		end
	end
	process_orders()
end

minetest.register_on_player_receive_fields(on_player_receive_fields)


local function allow_metadata_inventory(pos, listname, index, stack, player)
	return stack:get_count()
end

minetest.register_node("stock_exchange:stock", {
	description = "Stock Exchange Block",
	tiles = {
		-- up, down, right, left, back, front
		"stock_exchange_trend.png",
	},

	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 7/16,  8/16,  8/16, 8/16},
		},
	},
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		--meta:set_string("infotext", "Erze und Mineralien")
		--meta:set_string("formspec", formspec("ores"))
		--local pos = minetest.string_to_pos(player:get_attribute("pos"))
		--local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
	end,
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		if stock_open(clicker) then
			clicker:set_attribute("stock_pos", minetest.pos_to_string(pos))
			local meta = minetest.get_meta(pos)
			local res = meta:get_string("selection")
			if res ~= "" then
				minetest.show_formspec(clicker:get_player_name(), 
							"stock_exchange:select", select_formspec(res))
			else
				minetest.show_formspec(clicker:get_player_name(), 
							"stock_exchange:block_type", block_type_formspec())
			end
		end
	end,
	
	allow_metadata_inventory_put = allow_metadata_inventory,
	allow_metadata_inventory_take = allow_metadata_inventory,
	
	paramtype = 'light',
	light_source = 2,
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory=1},
	is_ground_content = false,
})

local function orders_formspec(name)
--	Orders[name] = {
--		{transfer="Verkaufen", item="Coal", amount=50, price=100, state="open", placed=0},
--		{transfer="Kaufen", item="Iron", amount=250, price=50, state="open", placed=0},
--	}
	local tRes = {"size[9.4,10]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[3.6,0; Deine Aufträge]"}
		tRes[2] = "label[0.1,0.6;Vorgang]label[1.6,0.6;Artikel]label[4.4,0.6;Stück]"..
					"label[5.6,0.6;Preis]label[6.8,0.6;Status]label[8,0.6;Löschen]"
		local idx = 0
		if Orders[name] ~= nil and #Orders[name] > 0 then
			for _,order in ipairs(Orders[name]) do
				idx = idx + 1
				if idx >= 11 then
					break
				end
				local ypos = 0.7 + idx*0.7
				tRes[#tRes+1] = "label[0.1,"..ypos..";"..order.transfer.."]"
				tRes[#tRes+1] = "label[1.6,"..ypos..";"..order.item.."]"
				tRes[#tRes+1] = "label[4.4,"..ypos..";"..order.amount.."]"
				tRes[#tRes+1] = "label[5.6,"..ypos..";"..string.format("%6.2f €]", order.price)
				tRes[#tRes+1] = "label[6.8,"..ypos..";"..order.state.."]"
				tRes[#tRes+1] = "button_exit[8,"..ypos..";1,0.6;btn"..idx..";x]"
			end
		end
		tRes[#tRes+1] = "label[0,9;Die Artikel werden beim Löschvorgang wieder\n"..
						"deinem Inventory hinzugefügt,\n sofern dort ausreichend Platz ist.]"
		return table.concat(tRes)
end	

minetest.register_node("stock_exchange:order", {
	description = "Stock Orders",
	tiles = {
		-- up, down, right, left, back, front
		"stock_exchange_orders.png",
	},

	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 7/16,  8/16,  8/16, 8/16},
		},
	},
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Aufträge")
	end,
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.show_formspec(clicker:get_player_name(), "stock_exchange:orders", 
					orders_formspec(clicker:get_player_name()))
	end,
	
	paramtype = 'light',
	light_source = 2,
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory=1},
	is_ground_content = false,
})

local function award_formspec(players)
	local tRes = {"size[8,10]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[1,0;Name]label[5,0;Vermögen]"}
		for idx,player in ipairs(players) do
			if idx >= 16 then
				break
			end
			local ypos = idx*0.6
			tRes[#tRes+1] = "label[1,"..ypos..";"..player.name.."]"
			tRes[#tRes+1] = "label[5,"..ypos..";"..string.format("%6.2f €]", player.balance)
		end
		return table.concat(tRes)
end	

minetest.register_node("stock_exchange:award", {
	description = "Stock Award",
	tiles = {
		-- up, down, right, left, back, front
		"stock_exchange_award.png",
	},

	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 7/16,  8/16,  8/16, 8/16},
		},
	},
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Bestenliste")
	end,
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local list = balance_award_list()
		minetest.show_formspec(clicker:get_player_name(), "stock_exchange:award", 
					award_formspec(list))
	end,
	
	paramtype = 'light',
	light_source = 2,
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory=1},
	is_ground_content = false,
})

minetest.register_node("stock_exchange:mirror_glass", {
	description = "Stock Exchange Mirror Glass",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 15/32,  8/16,  8/16, 8/16},
		},
	},
	-- up, down, right, left, back, front
	tiles = {
		"default_obsidian_glass.png", 
		"default_obsidian_glass.png", 
		"default_obsidian_glass.png", 
		"default_obsidian_glass.png", 
--		"default_obsidian_glass_detail.png",
--		"default_obsidian_glass_detail.png",
--		"default_obsidian_glass_detail.png",
--		"default_obsidian_glass_detail.png",
		"default_obsidian_glass.png",
		"stock_exchange_glass.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	sunlight_propagates = true,
	--sounds = default.node_sound_glass_defaults(),
	groups = {cracky = 3},
})

local function share_price()
	local idx = math.random(#lStockArticles)
	local amount = math.random(-8, 8) * 99
	local article = Stock[lStockArticles[idx]]
	price_fluctuation(article, amount)
	minetest.after(math.random(120,480), share_price)
end

good_morning()
share_price()

dofile(minetest.get_modpath("stock_exchange") .. "/homedecor.lua")
dofile(minetest.get_modpath("stock_exchange") .. "/commands.lua")
dofile(minetest.get_modpath("stock_exchange") .. "/skins.lua")


print ("[MOD] Stock Exchange loaded")


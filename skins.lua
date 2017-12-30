--[[

	Stock Exchange
	==============

	Copyright (C) 2017 Joachim Stolberg

	LGPLv2.1+
	See LICENSE.txt for more information

]]--

tSkins = {
	{"Sam 0", 'Sam_0_by_Jordach'},
	{"Sam 1", 'Sam_I_by_Jordach'},
	{"Iron Man", 'Iron_Man_MK._7_by_Jordach'},
	{"Clown", 'Claude-the_Clown_by_Jimmey'},
	{"Tuxedo Sam", 'Tuxedo_Sam_by_Jordach'},
	{"G-Robo", 'G-Robo_v5000_by_philipbenr'},
	{"jojoa1997", 'jojoa1997_by_jojoa1997'},
	{"Farmer Sam", 'Demon_Farmer_Sam_by_sdzen'},
	{"Summer Sam", 'Summer_Sam_by_philipbenr'},
	{"Infantry Man", 'Infantry_man_by_philipbenr'},
	{"Zombie", 'Zombie_by_viv100'},
	{"CaligoPL", 'CaligoPL_by_CaligoPL'},
	{"Diamond Sam", 'Diamond_Armor_Sam_by_Block_Guy'},
	{"SuperSam", 'SuperSam_by_AMMOnym'},
	{"lordphoenixmh", 'lordphoenixmh_by_lordphoenixmh'},
	{"4 degree", '4-deg'},
	
	{"Female Sam", 'Female_Sam_by_Jordach'},
	{"Ashley", 'Ashley_by_loupicate'},
	{"Aurora", 'Aurora_by_WD8Ubisoft'},
	{"Beatch Girl", 'beatch_girl_by_lovehart'},
	{"Camille", 'Camille_by_loupicate'},
	{"Charlotte", 'Charlotte_by_Sporax'},
	{"Alejandra", 'alejandra_by_rexyGYM'},
	{"Samantha", 'Samantha_I_by_philipbenr'},
	{"Summer", 'Summer_by_lizzie'},
	{"Lisa", 'lisa_by_hansuke123'},
	{"Emma", 'Emma_by_Cidney7760'},
	{"Malon", 'Malon_by_SummerCampV'},
	{"Ladyvioletkitty", 'Ladyvioletkitty_by_lordphoenixmh'},
	{"Mammu", 'Mammu_by_hansuke123'},
	{"Dante", 'Dante_by_bajanhgk'},
	{"Jayne", 'Jayne_by_Andromeda'},
	
	{"Gangnam Style", 'Gangnam_Style_by_Ferdi_Napoli'},
	{"Daffy Duck", 'Daffy_Duck_by_LuxAtheris'},
	{"DareDevil", 'DareDevil_by_Ferdi_Napoli'},
	{"Clone", 'Clone_by_Ferdi_Napoli'},
	{"Jesus", 'Jesus_by_Ferdi_Napoli'},
	{"Wires", 'Wires_by_Geopbyte'},
	{"PenguinDad", 'PenguinDad_by_PenguinDad'},
	{"wheat_farmer", 'wheat_farmer_by_addi'},
	{"Spider man", 'Spider_man_by_bajanhgk'},
	{"In the Navy", 'In_the_Navy_by_Bob_Hovercraft'},
	{"Hunky Simon", 'Hunky_Simon_by_Andromeda'},
	{"cheapie", 'cheapie_by_lovehart'},
	{"Michal Flynee", 'Michal_VonFlynee_by_Michal_VonFlynee'},
	{"gato rojo", 'gato_rojo_by_edwar_masterchieft'},
	{"war-sloop", 'war-sloop_by_ange_black69'},
	{"Batman", 'Batman_by_unknown'},

	{"blue girl", 'blue_girl_by_lovehart'},
	{"DanTDM Girl", 'DanTDM_Girl_by_Hansuke123'},
	{"Female Skin", 'Female_Skin_by_Guvienov'},
	{"farmer girl", 'farmer_girl_pink_and_green_by_Misty'},
	{"Pirate girl", 'Pirate_girl_by_Misty'},
	{"Violette", 'Violette_by_nelly'},
	{"Julie", 'Julie_by_nelly'},
	{"Julia", 'Julia_by_nelly'},
	{"Iris", 'Iris_by_loupicate'},
	{"Halloween Girl", 'Halloween_Girl_by_ElMehdiBen'},
	{"Santa Claus", 'santa_by_jordan4ibanez'},
}

MAX_SKIN 	 = #tSkins
MAX_PER_PAGE = 16
MAX_PER_ROW  = 8
PRICE        = 100

local function buy_formspec(image, desc)
	return "size[6,6"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[2,0; Player Skin]"..
		"image[0.1,1;2,4;"..image.."]"..
		"label[2.2,1.0;"..desc.."]"..
		"label[2.2,1.8;Preis:]label[3.5,1.8;"..PRICE.." €]"..
		"field[2.5,3;2,1;number;Stück;1]"..
		"button_exit[1,5;2,1;buy;Kaufen]"..
		"button_exit[3,5;2,1;cancel;Abbruch]"
end	

local function shop_formspec(tab)
	local tRes = {"size[9,7.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[3,0; Player Skin Shelf "..tab.."]"}
	local start = ((tab-1)*MAX_PER_PAGE) + 1
	local stop = math.min(start + MAX_PER_PAGE - 1, MAX_SKIN)
	for idx = start,stop do
		local i = (idx-1) % MAX_PER_PAGE
		local ypos = (math.floor(i / MAX_PER_ROW) * 2.5) + 1
		local xpos = (i % MAX_PER_ROW) * 1.1
		local img_name = minetest.formspec_escape(tSkins[idx][2].."_preview.png")
		tRes[#tRes+1] = "image_button_exit["..xpos..","..ypos..";1.2,2.3;"..img_name..";"..idx..";]"
	end
	tRes[#tRes+1] = "label[1,6.9;Alle Skins kosten "..PRICE.." €]"
	tRes[#tRes+1] = "button_exit[6,6.7;2,1;exit;Cancel]"
	return table.concat(tRes)
end	

local function update_player_skin(player, idx)
	if not player then
		return
	end
	local item = tSkins[idx] or tSkins[1]

--	if armor_mod then -- if 3D_armor's installed, let it set the skin
--		armor.textures[player:get_player_name()].skin = img_name
--		armor:update_player_visuals(player)
--	else
		player:set_properties({textures = {item[2]..".png"}})
--	end
end


local function on_player_receive_fields(player, formname, fields)
	local player_name = player:get_player_name()
	if formname == "stock_exchange:skin" then			-- select an item ?
		for i = 1,MAX_SKIN do
			if fields[tostring(i)] == "" then
				player:set_attribute("skin_shop_item", "stock_exchange:skin"..i)
				local image = tSkins[i][2].."_preview.png"
				local desc = tSkins[i][1]
				minetest.show_formspec(player_name, "stock_exchange:skin_buy", buy_formspec(image, desc))
				break
			end
		end
	elseif formname == "stock_exchange:skin_buy" then
		if fields.buy == "Kaufen" then
			local number = fields.number or "1"
			number = tonumber(number) or 1
			number = math.min(number, 99)
			local price = PRICE * number
			local shop_item = player:get_attribute("skin_shop_item")
			if stock_exchange.player_has_money(player_name, price) then
				if stock_exchange.add_to_players_inventory(player_name, shop_item, number) then
					stock_exchange.update_player_hud(player_name, -price)
				end
			end
		end
	end
end


minetest.register_on_player_receive_fields(on_player_receive_fields)

local function allow_metadata_inventory(pos, listname, index, stack, player)
	return stack:get_count()
end


for idx,item in ipairs(tSkins) do
	minetest.register_craftitem("stock_exchange:skin"..idx, {
		description = item[1],
		inventory_image = item[2].."_preview.png",
		stack_max = 1,
		wield_image = item[2].."_preview.png",
		groups = {cracky=0},
		
		on_use = function (itemstack, user)
			update_player_skin(user, idx)
			local old_idx = user:get_attribute("stock_exchange:skin_idx") or 1
			stock_exchange.add_to_players_inventory(user:get_player_name(), "stock_exchange:skin"..old_idx, 1)
			user:set_attribute("stock_exchange:skin_idx", tostring(idx))
			itemstack:take_item()
			return itemstack
		end,
		on_place = function (itemstack, user)
			update_player_skin(user, idx)
			local old_idx = user:get_attribute("stock_exchange:skin_idx") or 1
			stock_exchange.add_to_players_inventory(user:get_player_name(), "stock_exchange:skin"..old_idx, 1)
			user:set_attribute("stock_exchange:skin_idx", tostring(idx))
			itemstack:take_item()
			return itemstack
		end,
		groups = {not_in_creative_inventory=1},
	})
end

for idx = 1,4 do
	minetest.register_node("stock_exchange:skin_shop"..idx, {
		description = "Skin Shop "..idx,
		tiles = {
			-- up, down, right, left, back, front
			'stock_exchange_skin_side.png^[transformR90',
			'stock_exchange_skin_side.png^[transformR90',
			'stock_exchange_skin_side.png',
			'stock_exchange_skin_side.png',
			'stock_exchange_skin_front.png',
			'stock_exchange_skin_front.png',
		},

		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", "Shelf "..idx)
			meta:set_int("shelf", idx)
		end,

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			minetest.show_formspec(clicker:get_player_name(), 
						"stock_exchange:skin", shop_formspec(idx))
		end,
		
		allow_metadata_inventory_put = allow_metadata_inventory,
		allow_metadata_inventory_take = allow_metadata_inventory,
		
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "facedir",
		groups = {crumbly=3, not_in_creative_inventory=1},
		--groups = {crumbly=3},
		is_ground_content = false,
		sounds = default.node_sound_wood_defaults(),
	})
end

-- load player skin on join
minetest.register_on_joinplayer(function(player)
	local idx = player:get_attribute("stock_exchange:skin_idx") or "1"
	update_player_skin(player, tonumber(idx))
end)


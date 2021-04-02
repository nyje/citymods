--lockpick by Nige lGarnett
--Adds a lockpick and overrides locked chest to allow picking

local breakexp = .66 --exponent for tools to determine 

--lockpick definitions
minetest.register_tool("lockpick:lockpick", {
	description="Lockpick",
	inventory_image = "gold_lockpick.png",
	tool_capabilities = {
		max_drop_level = 1,
		groupcaps = {locked={maxlevel=1, uses=10, times={[3]=10.00}}}
	}
})

--pick recipe definitions
minetest.register_craft({
	output = "lockpick:lockpick",
	recipe = {
		{"", "default:gold_ingot", "default:gold_ingot"},
		{"", "default:gold_ingot", ""},
		{"", "default:steel_ingot", ""}
	}
})

minetest.override_item("default:chest_locked", {
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if player:get_wielded_item():get_tool_capabilities().groupcaps.locked then
			if player:get_wielded_item():get_tool_capabilities().groupcaps.locked.maxlevel >= 1 then
				return true
			end
		end
		return inv:is_empty("main") and 
				default.can_interact_with_node(player, pos)
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		if puncher:get_wielded_item():get_tool_capabilities().groupcaps.locked then
			if puncher:get_wielded_item():get_tool_capabilities().groupcaps.locked.maxlevel >= 1 then
				minetest.chat_send_player(meta:get_string("owner"),"Someone is picking your lock at "..minetest.pos_to_string(pos), true)
			end
		end
	end,
	on_dig = function(pos, node, digger)
		
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local inv_list = inv:get_list("main")
		--if player dug chest with a lockpick
		if digger:get_wielded_item():get_tool_capabilities().groupcaps.locked then
			if digger:get_wielded_item():get_tool_capabilities().groupcaps.locked.maxlevel >= 1 then
				local wielditem = digger:get_wielded_item()
				local wieldlevel = digger:get_wielded_item():get_tool_capabilities().max_drop_level
				if math.random() > math.pow(.66, wieldlevel) then
					minetest.set_node(pos, {name="default:chest",paramtype2="facedir"})
					local n_meta = minetest.get_meta(pos)
					local n_inv = n_meta:get_inventory()
					n_inv:set_list("main", inv_list)
				else
					wielditem:clear()
					digger:set_wielded_item(wieldeditem)
					minetest.chat_send_player(digger:get_player_name(), "Your lockpick broke!")
				end
			end
		else
			minetest.node_dig(pos, node, digger)
		end
	end,
})
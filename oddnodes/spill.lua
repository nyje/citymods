
local function add_spill_privs(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.spill = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "************************************************")
		minetest.chat_send_player(pn, "***** !!!!!  You Can Now Use Liquids !!!! ****")
		minetest.chat_send_player(pn, "************************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:spill", {
    description="Gain ability to use liquids",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "spill.png",
    sunlight_propagates = true,
    tiles = { "spill.png" },
	light_source = 14,
    inventory_image = "spill.png",
	after_place_node = add_spill_privs,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:spill',
	recipe = {
		{"default:snowblock", "unified_inventory:bag_large", "default:snowblock"},
		{"default:mese", "invisibility:potion", "default:mese"},
		{"default:snowblock", "default:mese", "default:snowblock"},
	}
})

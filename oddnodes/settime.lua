
local function add_settime_privs(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.settime = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "***** !!!!!  You Can Now SetTime !!!! ****")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:settime", {
    description="Gain Settime",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "settime.png",
    sunlight_propagates = true,
    tiles = { "settime.png" },
	light_source = 14,
    inventory_image = "settime.png",
	after_place_node = add_settime_privs,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:settime',
	recipe = {
		{"default:mese", "orbs_of_time:orb_day", "default:mese"},
		{"orbs_of_time:orb_dawn", "default:mese", "orbs_of_time:orb_dusk"},
		{"default:mese", "orbs_of_time:orb_night", "default:mese"},
	}
})

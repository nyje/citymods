
local function add_outlander_privs(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.outlander = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "*****************************************************")
		minetest.chat_send_player(pn, "***** !!!!!  You Can Now Go Outside the noob box ****")
		minetest.chat_send_player(pn, "*****************************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:outlander", {
    description="Gain outlander",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "openbox.png",
    sunlight_propagates = true,
    tiles = { "openbox.png" },
	light_source = 14,
    inventory_image = "openbox.png",
	after_place_node = add_outlander_privs,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:outlander',
	recipe = {
		{"oddnodes:fast", "oddnodes:settime", "oddnodes:noclip"},
		{"oddnodes:fly", "default:book", "oddnodes:fly"},
		{"oddnodes:noclip", "oddnodes:teleport", "oddnodes:fast"},
	}
})

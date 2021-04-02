
local function add_farlander_privs(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.farlander = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "***********************************************")
		minetest.chat_send_player(pn, "***** !!!!!  You Can Now Move Freely !!!! ****")
		minetest.chat_send_player(pn, "**********************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:farlander", {
    description="Gain farlander",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "escape.png",
    sunlight_propagates = true,
    tiles = { "escape.png" },
	light_source = 14,
    inventory_image = "escape.png",
	after_place_node = add_farlander_privs,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:farlander',
	recipe = {
		{"oddnodes:outlander", "oddnodes:outlander", "oddnodes:outlander"},
		{"oddnodes:outlander", "oddnodes:outlander", "oddnodes:outlander"},
		{"oddnodes:outlander", "oddnodes:outlander", "oddnodes:outlander"},
	}
})

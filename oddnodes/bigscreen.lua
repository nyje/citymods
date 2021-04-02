
local function bigscreen(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.ui_full = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "You Will Now Have The Big Menu After Next Login")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:bigscreen", {
    description="get the full sized menu from next login",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "bigscreen.png",
    sunlight_propagates = true,
    tiles = { "bigscreen.png" },
	light_source = 14,
    inventory_image = "bigscreen.png",
	after_place_node = bigscreen,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:bigscreen',
	recipe = {
		{"group:wood", "default:dirt", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "default:dirt", "group:wood"},
	}
})

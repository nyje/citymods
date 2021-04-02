
local function smallscreen(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.ui_full = nil
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "******************************************")
		minetest.chat_send_player(pn, "You Will Now Have The Small Menu After Next Login")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, "*******************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:smallscreen", {
    description="Get the smaller menu for smaller screens from next login",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "smallscreen.png",
    sunlight_propagates = true,
    tiles = { "smallscreen.png" },
	light_source = 14,
    inventory_image = "smallscreen.png",
	after_place_node = smallscreen,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:smallscreen',
	recipe = {
		{"default:leaves", "default:stick", "default:leaves"},
		{"default:stick", "default:dirt", "default:stick"},
		{"default:leaves", "default:stick", "default:leaves"},
	}
})

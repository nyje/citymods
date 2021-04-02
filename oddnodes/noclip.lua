
local function add_noclip_privs(pos,placer,istack,pt)
	local pn = placer:get_player_name()
	if pn then
		local privs = minetest.get_player_privs(pn)
		privs.noclip = true
		minetest.set_player_privs(pn, privs)
		minetest.chat_send_player(pn, " ")
		minetest.chat_send_player(pn, "**************************************")
		minetest.chat_send_player(pn, "***** !!!!!  You Have Noclip !!!! ****")
		minetest.chat_send_player(pn, "**************************************")
		minetest.chat_send_player(pn, " ")
		--mobs:explosion(pos, 1, 1, 1)
		minetest.set_node(pos, {name="fire:permanent_flame"})
		--minetest.set_node(pos, {name="air"})
	end
end

minetest.register_node("oddnodes:noclip", {
    description="Gain NoClip",
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
	paramtype = "light",
	paramtype2 = "wallmounted",
    wield_image = "noclip.png",
    sunlight_propagates = true,
    tiles = { "noclip.png" },
	light_source = 14,
    inventory_image = "noclip.png",
	after_place_node = add_noclip_privs,
	groups = {cracky=3, choppy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:noclip',
	recipe = {
		{"mobs:feather", "default:goldblock", "mobs:feather"},
		{"tnt:tnt", "default:diamondblock", "default:goldblock"},
		{"mobs:feather", "default:goldblock", "mobs:feather"},
	}
})

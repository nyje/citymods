-- Node definitions
minetest.register_node("bitchange:minecoin_in_ground", {
	description = "you hacker!",
	tiles = { "default_stone.png^bitchange_minecoin_in_ground.png" },
	is_ground_content = true,
	groups = {cracky=2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		max_items = 2,
		items = {
			{items = {"bitchange:minecoin"}, rarity = 2 },
			{items = {"bitchange:minecoin 3"} }
		}
	},
})

minetest.register_node("bitchange:mineninth_in_ground", {
	description = "you hacker!",
	tiles = { "default_stone.png^bitchange_mineninth_in_ground.png" },
	is_ground_content = true,
	groups = {cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		max_items = 3,
		items = {
			{items = {"bitchange:mineninth 4"}, rarity = 3 },
			{items = {"bitchange:mineninth 6"} }
		}
	},
})

minetest.register_node("bitchange:minecoinblock", {
	description = "MineCoin Block",
	tiles = { "bitchange_minecoinblock.png" },
	groups = {cracky=2},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
	stack_max = 30000,
})

minetest.register_craftitem("bitchange:minecoin", {
	description = "MineCoin",
	inventory_image = "bitchange_minecoin.png",
	stack_max = 30000,
})

minetest.register_craftitem("bitchange:mineninth", {
	description = "MineNinth",
	inventory_image = "bitchange_mineninth.png",
	stack_max = 30000,
})

minetest.register_alias("bitchange:coinbase", "bitchange:mineninth")

-- Crafting
minetest.register_craft({
	output = "bitchange:minecoinblock",
	recipe = {
		{"bitchange:minecoin", "bitchange:minecoin", "bitchange:minecoin"},
		{"bitchange:minecoin", "bitchange:minecoin", "bitchange:minecoin"},
		{"bitchange:minecoin", "bitchange:minecoin", "bitchange:minecoin"},
	}
})

minetest.register_craft({
	output = "bitchange:minecoin 9",
	recipe = {
		{"bitchange:minecoinblock"},
	}
})

minetest.register_craft({
	output = "bitchange:minecoin",
	recipe = {
		{"bitchange:mineninth", "bitchange:mineninth", "bitchange:mineninth"},
		{"bitchange:mineninth", "bitchange:mineninth", "bitchange:mineninth"},
		{"bitchange:mineninth", "bitchange:mineninth", "bitchange:mineninth"},
	}
})

minetest.register_craft({
	output = "bitchange:mineninth 9",
	recipe = {
		{"bitchange:minecoin"},
	}
})


minetest.register_craft({
	output = "bitchange:mineninth",
	recipe = { {"default:steel_ingot"}, }})
minetest.register_craft({
	output = "default:steel_ingot",
	recipe = { {"bitchange:mineninth"}, }})


minetest.register_craft({
	output = "bitchange:mineninth 5",
	recipe = { {"default:tin_ingot"}, }})
minetest.register_craft({
	output = "default:tin_ingot",
	recipe = {  {"","bitchange:mineninth",""},
                {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"},
                {"","bitchange:mineninth",""},  }})

minetest.register_craft({
	output = "bitchange:mineninth 6",
	recipe = { {"moreores:silver_ingot"}, }})
minetest.register_craft({
	output = "moreores:silver_ingot",
	recipe = {  {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"},
                {"","",""},
                {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"}, }})

minetest.register_craft({
	output = "bitchange:mineninth 7",
	recipe = { {"default:copper_ingot"}, }})
minetest.register_craft({
	output = "default:copper_ingot",
	recipe = { {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"},
                {"","bitchange:mineninth",""},
                {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"}, }})

minetest.register_craft({
	output = "bitchange:mineninth 8",
	recipe = { {"default:bronze_ingot"}, }})
minetest.register_craft({
	output = "default:bronze_ingot",
	recipe = { {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"},
                {"bitchange:mineninth","","bitchange:mineninth",},
                {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"}, }})

minetest.register_craft({
	output = "bitchange:minecoin",
	recipe = { {"default:gold_ingot"}, }})

minetest.register_craft({
    type = "cooking",
    recipe = "bitchange:minecoin",
    output = "default:gold_ingot",
    })
--minetest.register_craft({
--	output = "default:gold_ingot",
--	recipe = { {"bitchange:minecoin"}, }})

minetest.register_craft({
	output = "bitchange:mineninth 12",
	recipe = { {"default:mese_crystal"}, }})
minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {  {"","",""},
                {"","bitchange:minecoin",""},
                {"bitchange:mineninth","bitchange:mineninth","bitchange:mineninth"},
            }})


minetest.register_craft({
	output = "bitchange:mineninth 18",
	recipe = { {"default:diamond"}, }})
minetest.register_craft({
	output = "default:diamond",
	recipe = { {"","",""},
               {"","bitchange:minecoin",""},
               {"","bitchange:minecoin",""}, }})

minetest.register_craft({
	output = "bitchange:mineninth 36",
	recipe = { {"moreores:mithril_ingot"}, }})
minetest.register_craft({
	output = "moreores:mithril_ingot",
	recipe = { {"bitchange:minecoin","bitchange:minecoin"},
               {"bitchange:minecoin","bitchange:minecoin"}, }})

minetest.register_craft({
	output = "bitchange:minecoin 5",
	recipe = { {"nyancat:nyancat_rainbow"}, }})
minetest.register_craft({
	output = "bitchange:minecoin 30",
	recipe = { {"nyancat:nyancat"}, }})





-- Cooking
-- minetest.register_craft({
-- 	type = "cooking",
-- 	recipe = "default:goldblock",
-- 	output = "bitchange:minecoinblock 2",
-- })
--
-- minetest.register_craft({
-- 	type = "cooking",
-- 	recipe = "bitchange:minecoinblock",
-- 	output = "default:gold_ingot 4",
-- })

-- Generation
if bitchange.enable_generation then
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "bitchange:minecoin_in_ground",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 7,
	y_max          = -512,
	y_min          = -18000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "bitchange:mineninth_in_ground",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 8,
	y_max          = -256,
	y_min          = -511,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "bitchange:mineninth_in_ground",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 3,
	clust_size     = 7,
	y_max          = 28000,
	y_min          = -255,
})
end

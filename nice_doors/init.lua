 local door_list = {   -- , Description , Image
	{"Acacia" , "acacia"},
	{"Aspen", "aspen"},
	{"Birch" , "birch"},
	{"Beech", "beech"},
	{"Dark_Oak" , "dark_oak"},
	{"Iron " , "iron"},
	{"Jungle" , "jungle"},
	{"Spruce" , "spruce"},
	{"Wood" , "wood"},
	{"Fir", "fir"},
	{"Pine", "pine"},
	{"Willow", "willow"},
	{"Sequoia", "sequoia"},
}

for i in ipairs(door_list) do
	local desc = door_list[i][1]
	local img = door_list[i][2]

	doors.register_door("nice_doors:"..img, {
		description = desc,
		inventory_image = "nice_doors_"..img.."_inv.png",
		groups = {choppy=2,cracky=2,door=1},
		tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
		protected = true,
	})
end

-- Crafts

minetest.register_craft({
	output = "nice_doors:acacia 2",
	recipe = {
		{"default:acacia_wood", "default:acacia_wood", ""},
		{"default:acacia_wood", "default:acacia_wood", ""},
		{"default:acacia_wood", "default:acacia_wood", ""}
	}
})
minetest.register_craft({
	output = "nice_doors:pine 2",
	recipe = {
		{"default:pine_wood", "default:pine_wood", ""},
		{"default:pine_wood", "default:pine_wood", ""},
		{"default:pine_wood", "default:pine_wood", ""}
	}
})
minetest.register_craft({
	output = "nice_doors:aspen 2",
	recipe = {
		{"default:aspen_wood", "default:aspen_wood", ""},
		{"default:aspen_wood", "default:aspen_wood", ""},
		{"default:aspen_wood", "default:aspen_wood", ""}
	}
})
minetest.register_craft({
	output = "nice_doors:jungle 2",
	recipe = {
		{"default:junglewood", "default:junglewood", ""},
		{"default:junglewood", "default:junglewood", ""},
		{"default:junglewood", "default:junglewood", ""}
	}
})

if minetest.get_modpath("moretrees") then
	minetest.register_craft({
		output = "nice_doors:fir 2",
		recipe = {
			{"moretrees:fir_planks", "moretrees:fir_planks", ""},
			{"moretrees:fir_planks", "moretrees:fir_planks", ""},
			{"moretrees:fir_planks", "moretrees:fir_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:wood 2",
		recipe = {
			{"moretrees:apple_tree_planks", "moretrees:apple_tree_planks", ""},
			{"moretrees:apple_tree_planks", "moretrees:apple_tree_planks", ""},
			{"moretrees:apple_tree_planks", "moretrees:apple_tree_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:spruce 2",
		recipe = {
			{"moretrees:spruce_planks", "moretrees:spruce_planks", ""},
			{"moretrees:spruce_planks", "moretrees:spruce_planks", ""},
			{"moretrees:spruce_planks", "moretrees:spruce_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:sequoia 2",
		recipe = {
			{"moretrees:sequoia_planks", "moretrees:sequoia_planks", ""},
			{"moretrees:sequoia_planks", "moretrees:sequoia_planks", ""},
			{"moretrees:sequoia_planks", "moretrees:sequoia_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:birch 2",
		recipe = {
			{"moretrees:birch_planks", "moretrees:birch_planks", ""},
			{"moretrees:birch_planks", "moretrees:birch_planks", ""},
			{"moretrees:birch_planks", "moretrees:birch_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:beech 2",
		recipe = {
			{"moretrees:beech_planks", "moretrees:beech_planks", ""},
			{"moretrees:beech_planks", "moretrees:beech_planks", ""},
			{"moretrees:beech_planks", "moretrees:beech_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:dark_oak 2",
		recipe = {
			{"moretrees:oak_planks", "moretrees:oak_planks", ""},
			{"moretrees:oak_planks", "moretrees:oak_planks", ""},
			{"moretrees:oak_planks", "moretrees:oak_planks", ""}
		}
	})
	minetest.register_craft({
		output = "nice_doors:willow 2",
		recipe = {
			{"moretrees:willow_planks", "moretrees:willow_planks", ""},
			{"moretrees:willow_planks", "moretrees:willow_planks", ""},
			{"moretrees:willow_planks", "moretrees:willow_planks", ""}
		}
	})

elseif minetest.get_modpath("cblocks") then
	minetest.register_craft({
		output = "nice_doors:fir 2",
		recipe = {
			{"cblocks:wood_orange", "cblocks:wood_orange", ""},
			{"cblocks:wood_orange", "cblocks:wood_orange", ""},
			{"cblocks:wood_orange", "cblocks:wood_orange", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:wood 2",
		recipe = {
			{"cblocks:wood_grey", "cblocks:wood_grey", ""},
			{"cblocks:wood_grey", "cblocks:wood_grey", ""},
			{"cblocks:wood_grey", "cblocks:wood_grey", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:spruce 2",
		recipe = {
			{"cblocks:wood_brown", "cblocks:wood_brown", ""},
			{"cblocks:wood_brown", "cblocks:wood_brown", ""},
			{"cblocks:wood_brown", "cblocks:wood_brown", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:dark_oak 2",
		recipe = {
			{"cblocks:wood_black", "cblocks:wood_black", ""},
			{"cblocks:wood_black", "cblocks:wood_black", ""},
			{"cblocks:wood_black", "cblocks:wood_black", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:beech 2",
		recipe = {
			{"cblocks:wood_red", "cblocks:wood_red", ""},
			{"cblocks:wood_red", "cblocks:wood_red", ""},
			{"cblocks:wood_red", "cblocks:wood_red", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:birch 2",
		recipe = {
			{"cblocks:wood_yellow", "cblocks:wood_yellow", ""},
			{"cblocks:wood_yellow", "cblocks:wood_yellow", ""},
			{"cblocks:wood_yellow", "cblocks:wood_yellow", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:sequoia 2",
		recipe = {
			{"cblocks:wood_dark_grey", "cblocks:wood_dark_grey", ""},
			{"cblocks:wood_dark_grey", "cblocks:wood_dark_grey", ""},
			{"cblocks:wood_dark_grey", "cblocks:wood_dark_grey", ""},
		}
	})
	minetest.register_craft({
		output = "nice_doors:willow 2",
		recipe = {
			{"cblocks:wood_green", "cblocks:wood_green", ""},
			{"cblocks:wood_green", "cblocks:wood_green", ""},
			{"cblocks:wood_green", "cblocks:wood_green", ""},
		}
	})
end

if minetest.get_modpath("technic") then
	minetest.register_craft({
		output = "nice_doors:iron 2",
		recipe = {
			{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""},
			{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""},
			{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""}
		}
	})
else
	minetest.register_craft({
		output = "nice_doors:iron 2",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", ""},
			{"default:glass", "default:steel_ingot", ""},
			{"default:steel_ingot", "default:steel_ingot", ""},
		}
	})
end

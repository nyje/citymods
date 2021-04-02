--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- default registrations
local saw_nodes = { -- Default stairs/slabs/panels/microblocks:
	"stone",
	"stone_block",
	"cobble",
	"mossycobble",
	"brick",
	"sandstone",
	"steelblock",
	"goldblock",
	"copperblock",
	"bronzeblock",
	"diamondblock",
	"tinblock",
	"desert_stone",
	"desert_stone_block",
	"desert_cobble",
	"meselamp",
	"glass",
	"tree",
	"wood",
	"jungletree",
	"junglewood",
	"pine_tree",
	"pine_wood",
	"acacia_tree",
	"acacia_wood",
	"aspen_tree",
	"aspen_wood",
	"obsidian",
	"obsidian_block",
	"obsidianbrick",
	"obsidian_glass",
	"stonebrick",
	"desert_stonebrick",
	"sandstonebrick",
	"silver_sandstone",
	"silver_sandstone_brick",
	"silver_sandstone_block",
	"desert_sandstone",
	"desert_sandstone_brick",
	"desert_sandstone_block",
	"sandstone_block",
	"coral_skeleton",
	"ice",
    "caverealms:glow_amethyst",
    "caverealms:glow_amethyst_ore",
    "caverealms:glow_crystal",
    "caverealms:glow_emerald",
    "caverealms:glow_mese",
    "caverealms:glow_obsidian",
    "caverealms:glow_obsidian_2",
    "caverealms:glow_obsidian_glass",
    "caverealms:glow_ore",
    "caverealms:glow_ruby",
    "caverealms:glow_ruby_ore",
    "caverealms:hot_cobble",
    "caverealms:mushroom_cap",
    "caverealms:mushroom_stem",
    "caverealms:salt_crystal",
    "caverealms:stone_with_salt",
    "caverealms:thin_ice",
    "love_mod:tree",
    "love_mod:wood",
    "love_mod:glass",
    "prefab:concrete",
    "prefab:concrete_wall",
    "xdecor:cactusbrick",
    "xdecor:coalstone_tile",
    "xdecor:desertstone_tile",
    "xdecor:hard_clay",
    "xdecor:moonbrick",
    "xdecor:packed_ice",
    "xdecor:stone_rune",
    "xdecor:wooden_tile",
    "xdecor:wooden_lightbox",
    "xdecor:iron_lightbox",
    "xdecor:woodframed_glass",
	"cblocks:glass_black",
	"cblocks:glass_blue",
	"cblocks:glass_brown",
	"cblocks:glass_cyan",
	"cblocks:glass_dark_green",
	"cblocks:glass_dark_grey",
	"cblocks:glass_green",
	"cblocks:glass_grey",
	"cblocks:glass_magenta",
	"cblocks:glass_orange",
	"cblocks:glass_pink",
	"cblocks:glass_red",
	"cblocks:glass_violet",
	"cblocks:glass_white",
	"cblocks:glass_yellow",	
	"cblocks:stonebrick_black",
	"cblocks:stonebrick_blue",
	"cblocks:stonebrick_brown",
	"cblocks:stonebrick_cyan",
	"cblocks:stonebrick_dark_green",
	"cblocks:stonebrick_dark_grey",
	"cblocks:stonebrick_green",
	"cblocks:stonebrick_grey",
	"cblocks:stonebrick_magenta",
	"cblocks:stonebrick_orange",
	"cblocks:stonebrick_pink",
	"cblocks:stonebrick_red",
	"cblocks:stonebrick_violet",
	"cblocks:stonebrick_white",
	"cblocks:stonebrick_yellow",
	"cblocks:wood_black",
	"cblocks:wood_blue",
	"cblocks:wood_brown",
	"cblocks:wood_cyan",
	"cblocks:wood_dark_green",
	"cblocks:wood_dark_grey",
	"cblocks:wood_green",
	"cblocks:wood_grey",
	"cblocks:wood_magenta",
	"cblocks:wood_orange",
	"cblocks:wood_pink",
	"cblocks:wood_red",
	"cblocks:wood_violet",
	"cblocks:wood_white",
	"cblocks:wood_yellow",
	"nyancat:nyancat_rainbow",
	
}

for _, name in pairs(saw_nodes) do
    local mod
    if not name:find(":") then
        mod = "default"
    else
        mod = string.split(name,":")[1]
        name = string.split(name,":")[2]
    end

    --print(mod,name)
	local nodename = mod .. ":" .. name
	--print(mod.."  "..name)
	local ndef = table.copy(minetest.registered_nodes[nodename])
	ndef.sunlight_propagates = true

	-- Stone and desert_stone drop cobble and desert_cobble respectively.
	if type(ndef.drop) == "string" then
		ndef.drop = ndef.drop:gsub(".+:", "")
	end

	-- Use the primary tile for all sides of cut glasslike nodes and disregard paramtype2.
	if #ndef.tiles > 1 and ndef.drawtype and ndef.drawtype:find("glass") then
		ndef.tiles = {ndef.tiles[1]}
		ndef.paramtype2 = nil
	end

	partmod = "moreblocks"
	stairsplus:register_alias_all(mod, name , partmod, name)
	stairsplus:register_all(partmod, name, nodename, ndef)
	local pre=string.split(name,"_")
	minetest.register_alias_force("stairs:stair_" .. name, partmod .. ":stair_" .. name)
	minetest.register_alias_force("stairs:stair_outer_" .. name, partmod .. ":stair_" .. name .. "_outer")
	minetest.register_alias_force("stairs:stair_inner_" .. name, partmod .. ":stair_" .. name .. "_inner")
	minetest.register_alias_force("stairs:slab_"  .. name, partmod .. ":slab_"  .. name)
end

-- farming registrations
if minetest.get_modpath("farming") then
	local farming_nodes = {"straw"}
	for _, name in pairs(farming_nodes) do
		local mod = "farming"
		local nodename = mod .. ":" .. name
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndef.sunlight_propagates = true

		mod = "moreblocks"
		stairsplus:register_all(mod, name, nodename, ndef)
		minetest.register_alias_force("stairs:stair_" .. name, mod .. ":stair_" .. name)
		minetest.register_alias_force("stairs:stair_outer_" .. name, mod .. ":stair_" .. name .. "_outer")
		minetest.register_alias_force("stairs:stair_inner_" .. name, mod .. ":stair_" .. name .. "_inner")
		minetest.register_alias_force("stairs:slab_"  .. name, mod .. ":slab_"  .. name)
	end
end

-- wool registrations
if minetest.get_modpath("wool") then
	local dyes = {"white", "grey", "black", "red", "yellow", "green", "cyan",
	              "blue", "magenta", "orange", "violet", "brown", "pink",
	              "dark_grey", "dark_green"}
	for _, name in pairs(dyes) do
		local mod = "wool"
		local nodename = mod .. ":" .. name
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndef.sunlight_propagates = true

		-- Prevent dye+cut wool recipy from creating a full wool block.
		ndef.groups.wool = nil

		stairsplus:register_all(mod, name, nodename, ndef)
	end
end

-- basic_materials, keeping the original other-mod-oriented names
-- for backwards compatibility

if minetest.get_modpath("basic_materials") then
	stairsplus:register_all("technic","concrete","basic_materials:concrete_block",{
		description = "Concrete",
		tiles = {"basic_materials_concrete_block.png",},
		groups = {cracky=1, level=2, concrete=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_alias("prefab:concrete_stair","technic:stair_concrete")
	minetest.register_alias("prefab:concrete_slab","technic:slab_concrete")

	stairsplus:register_all("gloopblocks", "cement", "basic_materials:cement_block", {
		description = "Cement",
		tiles = {"basic_materials_cement_block.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

	stairsplus:register_all("technic", "brass_block", "basic_materials:brass_block", {
		description="Brass Block",
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"basic_materials_brass_block.png"},
	})

end

-- Alias cuts of split_stone_tile_alt which was renamed checker_stone_tile.
stairsplus:register_alias_all("moreblocks", "split_stone_tile_alt", "moreblocks", "checker_stone_tile")

-- The following LBM is necessary because the name stair_split_stone_tile_alt
-- conflicts with another node and so the alias for that specific node gets
-- ignored.
minetest.register_lbm({
	name = "moreblocks:fix_split_stone_tile_alt_name_collision",
	nodenames = {"moreblocks:stair_split_stone_tile_alt"},
	action = function(pos, node)
		minetest.set_node(pos, {
			name = "moreblocks:stair_checker_stone_tile",
			param2 = minetest.get_node(pos).param2

		})
		minetest.log('action', "LBM replaced " .. node.name ..
			" at " .. minetest.pos_to_string(pos))
	end,
})

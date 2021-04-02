
oddnodes = {}

oddnodes.modpath = minetest.get_modpath("oddnodes")

oddnodes.config = {}

--dofile(oddnodes.modpath.."/goaway.lua")
--dofile(oddnodes.modpath.."/farlander.lua")

dofile(oddnodes.modpath.."/fly.lua")
dofile(oddnodes.modpath.."/spill.lua")
dofile(oddnodes.modpath.."/fast.lua")
dofile(oddnodes.modpath.."/noclip.lua")
dofile(oddnodes.modpath.."/teleport.lua")
dofile(oddnodes.modpath.."/settime.lua")
dofile(oddnodes.modpath.."/outlander.lua")
dofile(oddnodes.modpath.."/smallscreen.lua")
dofile(oddnodes.modpath.."/bigscreen.lua")
dofile(oddnodes.modpath.."/streetlight.lua")
dofile(oddnodes.modpath.."/goaway.lua")
--dofile(oddnodes.modpath.."/deathblock.lua")

minetest.register_node("oddnodes:airy", {
	description = "airy",
	drawtype = "airlike",
	paramtype="light",
    sunlight_propagates=true,
    walkable=false,
	light_source = 14,
    pointable=false,
    is_ground_content=false,
    buildable_to=true,
	groups = {cracky=3,not_in_creative_inventory=1},
})

minetest.register_alias_force("default:mossycobble","default:stone")
minetest.register_alias("goblins:mossycobble_trap","default:stone")
minetest.register_alias("goblins:stone_with_iron_trap","default:stone")
minetest.register_alias("goblins:stone_with_coal_trap","default:stone")
minetest.register_alias("goblins:stone_with_copper_trap","default:stone")
minetest.register_alias("goblins:stone_with_gold_trap","default:stone")
minetest.register_alias("goblins:stone_with_diamond_trap","default:stone")


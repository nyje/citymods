
local die_radius = 6
local die_radius_max = 16


minetest.register_privilege("live", {
	description = "Can not be made to die."
})

local function die_make_formspec(pos)
	minetest.get_meta(pos):set_string("formspec", "size[9,2.5]" ..
		"field[0.3,  0;9,2;scanname;Names of players to ignore:;${scanname}]"..
		"field[0.3,1.5;4,2;radius;Radius:;${radius}]"..
		"button_exit[7,0.75;2,3;;Save]")
end

local function die_on_receive_fields(pos, _, fields,sender)
	if not fields.scanname or not fields.radius then return false end
	local meta = minetest.get_meta(pos)
	local name = sender:get_player_name()
	local bname = meta:get_string("owner")
	if bname == name then
		meta:set_string("scanname", fields.scanname)
		if tonumber(fields.radius)<die_radius_max then
			meta:set_int("radius", fields.radius)
		else
			meta:set_int("radius", die_radius_max)
		end
		die_make_formspec(pos)
	end
end

local function die_scan(pos)
	local timer = minetest.get_node_timer(pos)
	timer:start(0.3)
	--print("die scan at "..minetest.pos_to_string(pos))
	local meta = minetest.get_meta(pos)
	local radius = meta:get_int("radius") or die_radius
	local objs = minetest.get_objects_inside_radius(pos, radius)
	-- abort if no scan results were found
	if next(objs) == nil then return false end
	local scanname = meta:get_string("scanname")
	for _, obj in pairs(objs) do
		-- "" is returned if it is not a player; "" ~= nil; so only handle objects with foundname ~= ""
		local foundname = obj:get_player_name()
		if foundname ~= "" then
			local h, _ = minetest.check_player_privs(foundname, {live = true})
			if not h then
				-- return true if player found who is not in the scanname string
				if scanname == "" or string.find(scanname,foundname)==nil then
					obj:set_hp(0)
					return true
				end
			end
		end
	end
	return false
end

local function die_set_meta(pos,placer,istack,pt)
	local meta = minetest.get_meta(pos)
	local pn = placer:get_player_name()
	if pn then
		meta:set_string("scanname", pn )
		minetest.log("action", "Setting scanner to ignore "..pn)
		meta:set_int("radius", die_radius )
		meta:set_string("owner", pn )
		local timer = minetest.get_node_timer(pos)
		timer:start(0.5)
		minetest.chat_send_player(pn, "DIE started.")
	end
end

minetest.register_node("oddnodes:deathblock", {
	tiles = {"die.png"},
	paramtype = "light",
	walkable = true,
	groups = {unbreakable=1},
	description="Go die Block",
	on_construct = die_make_formspec,
	on_receive_fields = die_on_receive_fields,
	after_place_node = die_set_meta,
	on_timer = die_scan,
	sounds = default.node_sound_stone_defaults(),
	on_blast = function() end,
	
})

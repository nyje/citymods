
local away_radius = 6
local away_radius_max = 12


minetest.register_privilege("stay", {
	description = "Can not be made to go away."
})

local function away_make_formspec(pos)
	minetest.get_meta(pos):set_string("formspec", "size[9,2.5]" ..
		"field[0.3,  0;9,2;scanname;Names of players to ignore(comma:;${scanname}]"..
		"field[0.3,1.5;4,2;radius;Radius:;${radius}]"..
		"button_exit[7,0.75;2,3;;Save]")
end

local function away_on_receive_fields(pos, _, fields,sender)
	if not fields.scanname or not fields.radius then return false end
	local meta = minetest.get_meta(pos)
	local name = sender:get_player_name()
	local bname = meta:get_string("owner")
	if bname == name or minetest.check_player_privs(name, {server = true}) then
		meta:set_string("scanname", fields.scanname)
		if fields.radius then
			if tonumber(fields.radius)<away_radius_max then
				meta:set_int("radius", fields.radius)
			else
				meta:set_int("radius", away_radius_max)
			end
		else
			meta:set_int("radius", away_radius_max)
		end
	else
		minetest.chat_send_player(name," This is not yours. Ignoring changes.")
	end
end

local function away_with_you(pos,obj)
	local name = obj:get_player_name()
	if name ~= "" then
		local opos = obj:getpos()
		local npos = { x=(opos.x-pos.x)*2+pos.x, y=(opos.y-pos.y)*2+pos.y, z=(opos.z-pos.z)*2+pos.z }
		local count = 0
		local node = minetest.get_node_or_nil(npos)
		while node do
			if node.name == 'air' then
				local hp = obj:get_hp()
				if hp>1 then
					--obj:set_hp(1)
				else
					--obj:set_hp(0)
				end
				if count > 1 then
					--minetest.chat_send_player(name, " You were rescued from being buried "..count.." meters deep.")
				end
				--obj:setpos(npos)
				return
			elseif node.name == "ignore" then
				return
			else
				npos.y = npos.y + 1
				count = count + 1
			end
			node = minetest.get_node_or_nil(npos)
		end
	end
end

local function away_scan(pos)
	--print("goaway scan at "..minetest.pos_to_string(pos))
	local meta = minetest.get_meta(pos)
	local radius = meta:get_int("radius") or away_radius
	local objs = minetest.get_objects_inside_radius(pos, radius)
	if next(objs) ~= nil then
		local scanname = meta:get_string("scanname")
		for _, obj in pairs(objs) do
			local foundname = obj:get_player_name()
			if foundname then
				if foundname ~= "" then
					local h = minetest.check_player_privs(foundname, {stay = true})
					if not h then
						if scanname == "" or string.find(scanname,foundname, 1, true)==nil then
							minetest.chat_send_player(foundname," You are not welcome in this area...")
							away_with_you(pos,obj)
						end
					else
						--minetest.chat_send_player(foundname,"Attempted removal from "..minetest.pos_to_string(pos))
					end
				end
			end
		end
	end
end

local function away_set_meta(pos,placer,istack,pt)
	local meta = minetest.get_meta(pos)
	local pn = placer:get_player_name()
	if pn then
		meta:set_string("scanname", pn )
		minetest.log("action", "Setting scanner to ignore "..pn)
		meta:set_int("radius", away_radius )
		meta:set_string("owner", pn )
		local timer = minetest.get_node_timer(pos)
		timer:start(0.5)
		minetest.chat_send_player(pn, "GOAWAY started.")
	end
end

minetest.register_node("oddnodes:goaway", {
	tiles = {"die.png"},
	paramtype = "light",
	walkable = true,
	groups = {cracky=3},
	description="Go Away Block",
	on_construct = away_make_formspec,
	on_receive_fields = away_on_receive_fields,
	after_place_node = away_set_meta,
	on_timer = function(pos)
		away_scan(pos)
		return true
	end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'oddnodes:goaway',
	recipe = {
		{"default:steel_ingot", "mobs:feather", "default:steel_ingot"},
		{"mobs:feather", "default:steel_ingot", "mobs:feather"},
		{"default:steel_ingot", "mobs:feather", "default:steel_ingot"},
	}
})

minetest.register_alias("oddnodes:go_away","default:diamondblock")

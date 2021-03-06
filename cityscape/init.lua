cityscape = {}
cityscape.version = "1.0"

cityscape.path = minetest.get_modpath("cityscape")
cityscape.vacancies = tonumber(minetest.setting_get('cityscape_vacancies')) or 0
if cityscape.vacancies < 0 or cityscape.vacancies > 10 then
	cityscape.vacancies = 0
end
cityscape.divisions_x = tonumber(minetest.setting_get('cityscape_divisions_x')) or 3
if cityscape.divisions_x < 0 or cityscape.divisions_x > 4 then
	cityscape.divisions_x = 3
end
cityscape.divisions_z = tonumber(minetest.setting_get('cityscape_divisions_z')) or 3
if cityscape.divisions_z < 0 or cityscape.divisions_z > 4 then
	cityscape.divisions_z = 3
end
cityscape.desolation = tonumber(minetest.setting_get('cityscape_desolation')) or 0
if cityscape.desolation < 0 or cityscape.desolation > 10 then
	cityscape.desolation = 0
end
cityscape.suburbs = tonumber(minetest.setting_get('cityscape_suburbs')) or 3
if cityscape.suburbs < 0 or cityscape.suburbs > 10 then
	cityscape.suburbs = 3
end

function cityscape.clone_node(name)
	local node = minetest.registered_nodes[name]
	local node2 = table.copy(node)
	return node2
end

function cityscape.node(name)
	if not cityscape.node_cache then
		cityscape.node_cache = {}
	end

	if not cityscape.node_cache[name] then
		cityscape.node_cache[name] = minetest.get_content_id(name)
		--print("*** "..name..": "..cityscape.node_cache[name])
		if name ~= "ignore" and cityscape.node_cache[name] == 127 then
			print("*** Failure to find node: "..name)
		end
	end

	return cityscape.node_cache[name]
end

function cityscape.breaker(node)
	local sr = math.random(50)
	if sr <= cityscape.desolation then
		return "air"
	elseif cityscape.desolation > 0 and sr / 5 <= cityscape.desolation then
		return string.gsub(node, ".*:", "cityscape:").."_broken"
	else
		return node
	end
end


dofile(cityscape.path .. "/nodes.lua")
dofile(cityscape.path .. "/deco_rocks.lua")
dofile(cityscape.path .. "/mapgen.lua")
dofile(cityscape.path .. "/buildings.lua")
dofile(cityscape.path .. "/houses.lua")
dofile(cityscape.path .. "/molotov.lua")

cityscape.players_to_check = {}

function cityscape.respawn(player)
	cityscape.players_to_check[#cityscape.players_to_check+1] = player:get_player_name()
end

function cityscape.unearth(dtime)
	for i, player_name in pairs(cityscape.players_to_check) do
		local player = minetest.get_player_by_name(player_name)
		if not player then
			return
		end
		local pos = player:getpos()
		if not pos then
			return
		end
		local count = 0
		local node = minetest.get_node_or_nil(pos)
		while node do
			if node.name == 'air' then
				player:setpos(pos)
				table.remove(cityscape.players_to_check, i)
				if count > 1 then
					print("*** Cityscape unearthed "..player_name.." from "..count.." meters below.")
				end
				return
			elseif node.name == "ignore" then
				return
			else
				pos.y = pos.y + 1
				count = count + 1
			end
			node = minetest.get_node_or_nil(pos)
			end
	end
end

minetest.register_on_newplayer(cityscape.respawn)
minetest.register_on_respawnplayer(cityscape.respawn)
minetest.register_on_generated(cityscape.generate)
minetest.register_globalstep(cityscape.unearth)

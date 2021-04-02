local schems = { "empty","park1","park2","park3","park4","small_glass","small_concrete","small_redbrick","small_redstone","small_yellowstone","big_glass","big_brownstone","big_concrete","big_redbrick","big_redstone"}

local function get_intersects (p1, p2)
    local res = ""
    for id, area in pairs(areas.areas) do
        local a1=area.pos1
        local a2=area.pos2
        if ((a1.x >= p1.x and a1.x <= p2.x) or (a2.x >= p1.x and a2.x <= p2.x) or (a1.x < p1.x and a2.x > p2.x)) and
            ((a1.y >= p1.y and a1.y <= p2.y) or (a2.y >= p1.y and a2.y <= p2.y) or (a1.y < p1.y and a2.y > p2.y)) and
            ((a1.z >= p1.z and a1.z <= p2.z) or (a2.z >= p1.z and a2.z <= p2.z) or (a1.z < p1.z and a2.z > p2.z)) then
            res = res..","..area.owner.." owns "..area.name.." ("..a1.x.." "..a1.y.." "..a1.z..")-("..a2.x.." "..a2.y.." "..a2.z..")"
        end
    end
    if res ~= "" then
        return "!!! Cannot Change Area !!!,Protected areas found:"..res
    else
        return nil
    end
end

local chooser = function(pos)
    return "size[8,8]"
           .."label[0,0;Chose what to create:]"
           .."textlist[0,1;4,6;schematic;"..table.concat(schems,",")..";0;true]"
           .."button[4,1;2,1;protect;Protect]"
           .."button_exit[0,7;4,1;exit;Cancel]"
           .."field[10,1;1,1;x:"..pos.x..";"..pos.x..";X]"
           .."field[11,1;1,1;y:"..(pos.y - 1)..";"..(pos.y - 1)..";Y]"
           .."field[12,1;1,1;z:"..pos.z..";"..pos.z..";Z]"
end

local protected = function(intersects,pos)
    return "size[5,8]"
           .."bgcolor[#F00]"
           .."textlist[0,0;5,7;;"..intersects.."]"
           .."button_exit[3,7;2,1;player_list_exit;Close]"
           .."button[0,7;2,1;unprotect;Un-Protect]"
           .."field[10,1;1,1;x:"..pos.x..";"..pos.x..";X]"
           .."field[11,1;1,1;y:"..(pos.y - 1)..";"..(pos.y - 1)..";Y]"
           .."field[12,1;1,1;z:"..pos.z..";"..pos.z..";Z]"
end

minetest.override_item("cityscape:streetlight", {
	description = "Magic Streetlight",
	tiles = {{
			name="oddnodes_black_plasma.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
		}},
    drops = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
    on_place = nil,
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if pointed_thing then
			if pointed_thing.under then
				local pt = pointed_thing.under
				local pos1 = { x = pt.x, y = pt.y-1, z= pt.z }
				local pos2 = { x = pt.x+25, y = pt.y+100, z= pt.z+25 }
				local intersects = get_intersects(pos1,pos2)
				local privs = minetest.get_player_privs(player:get_player_name())
				if (intersects and privs.server==nil) then
					minetest.show_formspec(player:get_player_name(), "magic_streetlight", protected(intersects,pointed_thing.under))
				else
					minetest.show_formspec(player:get_player_name(), "magic_streetlight", chooser(pointed_thing.under))
				end
			end
		end
    end,
	on_blast = function() end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "magic_streetlight" then
        local pos,itab = {},{}
        for i,v in pairs(fields) do
            itab=string.split(i,":")
            if itab[2] then
                pos[itab[1]] = tonumber(itab[2])
            end
        end
        if pos.x and pos.y and pos.z then
            local pos2 = { x = pos.x+25, y = pos.y+100, z= pos.z+25 }
            local name = player:get_player_name()
            if fields.schematic then
                minetest.close_formspec(name, formname)
                local idx=minetest.explode_textlist_event(fields.schematic).index
                local filename = "lp_"..schems[idx]..".mts"
                local stuffed = worldedit.set(pos, pos2, "air")
                minetest.place_schematic(pos, minetest.get_modpath("oddnodes").."/schematics/"..filename)
                return true
            end
            if fields.protect then
                minetest.close_formspec(name, formname)
                --areas:setPos1(name, pos)
                --areas:setPos2(name, pos2)
        		local canAdd, errMsg = areas:canPlayerAddArea(pos, pos2, name)
        		if not canAdd then
        			minetest.chat_send_player(player:get_player_name(), "You can't protect that area: "..errMsg)
        		else
                    local id = areas:add(name, name, pos, pos2, nil)
                    areas:save()
                    minetest.chat_send_player(player:get_player_name(), "Area Protected")
                end
            end
            if fields.unprotect then
                minetest.close_formspec(name, formname)
                local aobj = minetest.get_objects_inside_radius(pos, 8)
                for _, obj in ipairs(aobj) do
                    if obj then
                        if obj:get_player_name() == name then
                            for id, a in pairs(areas:getAreasAtPos(pos)) do
                                if a.owner == name then
                                    areas:remove(id)
                                    areas:save()
                                    minetest.chat_send_player(name, "Removed area "..id)
                                end
                            end
                        end
                    end
                end
            end
        end
	end
end)



--
-- Helper functions
--

local function is_water(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

--
-- Cart entity
--

local boat = {
	physical = true,
	collisionbox = {-2.4,-1,-2.4, 2.4,2.0,2.4},
	visual = "mesh",
	visual_size = {x=2.0,y=2.0},
	mesh = "barge.obj",
	textures = {"prefab_concrete_boat.png"},

	driver = nil,
	v = 0,
}

function boat:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:set_yaw(clicker:get_look_horizontal())
	end
end

function boat:on_activate(staticdata)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function boat:get_staticdata()
	return tostring(self.v)
end

function boat:on_punch(puncher)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "prefab:boat")
	end
end

function boat:on_step(dtime)
	self.v = get_v(self.object:get_velocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+0.03
		end
		if ctrl.down then
			self.v = self.v-0.03
		end
		if ctrl.left then
			self.object:set_yaw(self.object:get_yaw()+math.pi/120+dtime*math.pi/120)
		end
		if ctrl.right then
			self.object:set_yaw(self.object:get_yaw()-math.pi/120-dtime*math.pi/120)
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:set_velocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5*get_sign(self.v)
	end

	local p = self.object:get_pos()
	p.y = p.y-0.5
	if not is_water(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:set_acceleration({x=0, y=-10, z=0})
		self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
	else
		p.y = p.y+1
		if is_water(p) then
			self.object:set_acceleration({x=0, y=3, z=0})
			local y = self.object:get_velocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:set_acceleration({x=0, y=10, z=0})
			end
			self.object:set_velocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:set_acceleration({x=0, y=0, z=0})
			if math.abs(self.object:get_velocity().y) < 1 then
				local pos = self.object:get_pos()
				pos.y = math.floor(pos.y)+0.5
				self.object:set_pos(pos)
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), 0))
			else
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
			end
		end
	end
end

minetest.register_entity("prefab:boat", boat)

minetest.register_craftitem("prefab:boat", {
	description = "Prefab Concrete Barge",
	inventory_image = "prefab_boat_inventory.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,

	on_place = function(itemstack, _, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if not is_water(pointed_thing.under) then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y-0.5
		minetest.add_entity(pointed_thing.under, "prefab:boat")
		itemstack:take_item()
		return itemstack
	end,
})

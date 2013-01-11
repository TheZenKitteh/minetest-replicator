minetest.register_node("replicator:replicator", {

	description = "Replicator",
	tile_images = { "replicator_top.png", "replicator_bottom.png", "replicator_side.png"},
	inventory_image = minetest.inventorycube("replicator_top.png","replicator_side.png","replicator_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 10,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	sounds = default.node_sound_stone_defaults(),
	legacy_facedir_simple = true,
})
minetest.register_node("replicator:industrial", {

	description = "Industrial Replicator",
	tile_images = { "replicator_top.png", "replicator_bottom.png", "replicator_industrial_side.png"},
	inventory_image = minetest.inventorycube("replicator_top.png","replicator_industrial_side.png","replicator_industrial_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 10,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	sounds = default.node_sound_stone_defaults(),
	legacy_facedir_simple = true,
})
minetest.register_node("replicator:industrial_h", {

	description = "Industrial Replicator MKII",
	tile_images = {"replicator_industrial_side.png","replicator_industrial_side.png", "replicator_top.png"},
	inventory_image = minetest.inventorycube("replicator_industrial_side.png","replicator_top.png","replicator_top.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 10,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	sounds = default.node_sound_stone_defaults(),
	legacy_facedir_simple = true,
})

minetest.register_craft({
	output = 'replicator:replicator 1',
	recipe = {
		{'','',''},
		{'','default:mese',''},
		{'default:mese','default:mese','default:mese'},
	}
})
minetest.register_craft({
	output = 'replicator:industrial 1',
	recipe = {
		{'','replicator:replicator',''},
		{'','replicator:replicator',''},
		{'','replicator:replicator',''},
	}
})
minetest.register_craft({
	output = 'replicator:industrial_h 1',
	recipe = {
		{'','replicator:replicator',''},
		{'replicator:replicator','replicator:replicator','replicator:replicator'},
		{'','',''},
	}
})

minetest.register_abm({
		nodenames = { "replicator:replicator" },
		interval = 60,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
				local ontop = {x=pos.x,y=pos.y+1,z=pos.z}
				local is_air  = minetest.env:get_node(ontop)
				if(is_air.name == "air")	then		
						local below = {x=pos.x,y=pos.y-1,z=pos.z}
						local replicate_this = minetest.env:get_node(below)
						if replicate_this.name ~= "replicator:replicator" and
						replicate_this.name ~= "replicator:industrial" and
						replicate_this.name ~= "replicator:industrial_h" then 								
	minetest.env:add_node(ontop,{type="node",name=replicate_this.name})
						end
				end


		
			end
			
		})

minetest.register_abm({
		nodenames = { "replicator:industrial" },
		interval = 90,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			local below = {x=pos.x,y=pos.y-1,z=pos.z}
			local replicate_this = minetest.env:get_node(below)
			if replicate_this.name ~= "replicator:replicator" and
			replicate_this.name ~= "replicator:industrial" and
			replicate_this.name ~= "replicator:industrial_h" then 								
				for i = 0, 10, 1 do
					local ontop = {x=pos.x,y=pos.y+(i+1),z=pos.z}
					local is_air  = minetest.env:get_node(ontop)
					if(is_air.name == "air")	then		
						minetest.env:add_node(ontop,{type="node",name=replicate_this.name})
    				end
				end
			end
		end
		})

minetest.register_abm({
		nodenames = { "replicator:industrial_h" },
		interval = 90,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			local xm = {x=pos.x-1,y=pos.y,z=pos.z}
			local xp = {x=pos.x+1,y=pos.y,z=pos.z}
			local zm = {x=pos.x,y=pos.y,z=pos.z-1}
			local zp = {x=pos.x,y=pos.y,z=pos.z+1}
			local xmnode = minetest.env:get_node(xm)
			local xpnode = minetest.env:get_node(xp)
			local zmnode = minetest.env:get_node(zm)
			local zpnode = minetest.env:get_node(zp)
			if xmnode.name == "air" and
				xpnode.name ~= "air" and
				xpnode.name ~= "replicator:replicator" and
				xpnode.name ~= "replicator:industrial" and
				xpnode.name ~= "replicator:industrial_h" then
				for i = 0, 10, 1 do
					local curnode = {x=pos.x-(i+1),y=pos.y,z=pos.z}
					local is_air  = minetest.env:get_node(curnode)
					if(is_air.name == "air")	then		
						minetest.env:add_node(curnode,{type="node",name=xpnode.name})
					end
				end
			end
	
			if xpnode.name == "air" and
				xmnode.name ~= "air" and
				xmnode.name ~= "replicator:replicator" and
				xmnode.name ~= "replicator:industrial" and
				xmnode.name ~= "replicator:industrial_h" then
				for i = 0, 10, 1 do
					local curnode = {x=pos.x+(i+1),y=pos.y,z=pos.z}
					local is_air  = minetest.env:get_node(curnode)
					if(is_air.name == "air")	then		
						minetest.env:add_node(curnode,{type="node",name=xmnode.name})
	    				end
				end
			end
			if zmnode.name == "air" and
				zpnode.name ~= "air" and
				zpnode.name ~= "replicator:replicator" and
				zpnode.name ~= "replicator:industrial" and
				zpnode.name ~= "replicator:industrial_h" then
				for i = 0, 10, 1 do
					local curnode = {x=pos.x,y=pos.y,z=pos.z-(i+1)}
					local is_air  = minetest.env:get_node(curnode)
					if(is_air.name == "air")	then		
						minetest.env:add_node(curnode,{type="node",name=zpnode.name})
    					end
				end
			end
			if zpnode.name == "air" and
				zmnode.name ~= "air" and
				zmnode.name ~= "replicator:replicator" and
				zmnode.name ~= "replicator:industrial" and
				zmnode.name ~= "replicator:industrial_h" then
				for i = 0, 10, 1 do
					local curnode = {x=pos.x,y=pos.y,z=pos.z+(i+1)}
					local is_air  = minetest.env:get_node(curnode)
					if(is_air.name == "air")	then		
						minetest.env:add_node(curnode,{type="node",name=zmnode.name})
    					end
				end
			end
		end
})


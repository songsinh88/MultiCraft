creative = {}

creative.set_creative_formspec = function()

end

minetest.register_on_player_receive_fields(function(player, formname, fields)

end)

if minetest.setting_getbool("creative_mode") then
	local digtime = 1
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=0.3},
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				cracky = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				snappy = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				choppy = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				oddly_breakable_by_hand = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
			},
			damage_groups = {fleshy = 1},
		}
	})
	
	minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
		return true
	end)
	
	function minetest.handle_node_drops(pos, drops, digger)
		if not digger or not digger:is_player() then
			return
		end
		local inv = digger:get_inventory()
		if inv then
			for _,item in ipairs(drops) do
				item = ItemStack(item):get_name()
				if not inv:contains_item("main", item) then
					inv:add_item("main", item)
				end
			end
		end
	end
	
end
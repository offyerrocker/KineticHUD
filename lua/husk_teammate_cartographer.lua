local hooked_class,hook_id
if RequiredScript == "lib/units/beings/player/huskplayermovement" then 
	hooked_class = HuskPlayerMovement
	hook_func_id = "update"
	hook_id = "khud_huskplayermovement_update"
elseif RequiredScript == "lib/units/beings/player/huskplayermovement" then 
--[[
	--as a client, team ai do not have a nav tracker assigned to them, so this method does not work
elseif RequiredScript == "lib/units/team_ai/huskteamaimovement" then 
	hooked_class = HuskTeamAIMovement
	hook_func_id = "upd_actions"
	hook_id = "khud_huskteamaimovement_update"
--]]
elseif RequiredScript == "lib/units/player_team/teamaimovement" then
	hooked_class = TeamAIMovement
	hook_func_id = "_upd_location"
	hook_id = "khud_teamaimovement_update"
end
if hooked_class then 
	Hooks:PostHook(hooked_class,hook_func_id,hook_id,function(self,unit,t,dt)
		unit = unit or self._unit
		local allow_nav_location_names = true
		local cartographer_data = KineticHUD._cache.cartographer_data
		if cartographer_data then 
			local char_data
			
			for _, character in pairs(managers.criminals._characters) do
				if unit == character.unit then
					char_data = character.data
					break
				end
			end
			local panel_id = char_data and char_data.panel_id
			if panel_id then 
				local cartographer_navs = cartographer_data.nav_segments
				local nav_tracker = self._nav_tracker
				if nav_tracker then 
					local nav_segment = nav_tracker:nav_segment()
					if nav_segment then 
						local nav_metadata = managers.navigation:get_nav_seg_metadata(nav_segment)
						local location_id = nav_metadata.location_id 
						if location_id and location_id ~= "location_unknown" and allow_nav_location_names then 
							KineticHUD:SetTeammateLocationText(panel_id,managers.localization:text(location_id))
						else
							location_id = cartographer_navs[tostring(nav_segment)]
							if location_id then 
								KineticHUD:SetTeammateLocationText(panel_id,managers.localization:text(location_id))
							end
						end
					end
				end
			end
		end
	end)
end
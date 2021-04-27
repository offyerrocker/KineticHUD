do return end

Hooks:PostHook(HUDManager,"init","khud_hudmanager_init",function(self)
--	KineticHUD:CreateHUD(self._fullscreen_workspace)
end)
--waypoint stuff goes here


Hooks:PostHook(HUDManager,"_update_waypoints","khud_hudmanager_updwaypoint",function(self,t,dt)
	for id,data in pairs(self._hud.waypoints) do 
--		Console:SetTrackerValue("trackera",tostring(data.testbm))
		if data.testbm then 
			data.testbm:set_center_x(data.current_position.x)
			data.testbm:set_center_y(data.current_position.y)
			break
		end
	end
end)

Hooks:PreHook(HUDManager,"remove_waypoint","khud_hudmanager_removewaypoint",function(self,id,data)
	if not self._hud.waypoints[id] then
		return
	end

	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)

	if not hud then
		return
	end

	local waypoint_panel = hud.panel
	waypoint_panel:remove(self._hud.waypoints[id].testbm)
	
end)

Hooks:PostHook(HUDManager,"add_waypoint","khud_hudmanager_addwaypoint",function(self,id,data)

	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	if not hud then return end
	local waypoint_panel = hud.panel
	
	local testbm = waypoint_panel:bitmap({
		name = "testbm",
		texture = "textures/ui/heart",
		visible = false,
		color = data.color or Color.white
	})
	self._hud.waypoints[id].testbm = testbm
end)
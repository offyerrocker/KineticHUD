


Hooks:PostHook(HUDManager,"add_waypoint","khud_hudmanager_addwaypoint",function(self,id,data)
	KineticHUD:AddCompassWaypoint(id,data)
end)

Hooks:PostHook(HUDManager,"remove_waypoint","khud_hudmanager_removewaypoint",function(self,id,data)
	KineticHUD:RemoveCompassWaypoint(id,data)
end)

Hooks:PostHook(HUDManager,"change_waypoint_icon","khud_hudmanager_changewaypointicon",function(self,id,icon)
	KineticHUD:ChangeCompassWaypointTexture(id,icon)
end)


Hooks:PostHook(HUDManager,"change_waypoint_icon_alpha","khud_hudmanager_changewaypointicon",function(self,id,alpha)
	KineticHUD:ChangeCompassWaypointAlpha(id,alpha)
end)

do return end


--waypoint stuff goes here

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
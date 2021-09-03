
Hooks:PreHook(HUDManager,"init_finalize","khud_hudmanager_initfinialize",function(self)
	if self:alive("guis/mask_off_hud") then
		self:script("guis/mask_off_hud").mask_on_text:set_y(72)
	end
end)


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


function HUDManager:pd_start_progress(current, total, msg, icon_id)
--[[
	local hud = self:script(PlayerBase.PLAYER_DOWNED_HUD)

	if not hud then
		return
	end

	self._pd2_hud_interaction = HUDInteraction:new(managers.hud:script(PlayerBase.PLAYER_DOWNED_HUD))

	self._pd2_hud_interaction:show_interact({
		text = utf8.to_upper(managers.localization:text(msg))
	})
	self._pd2_hud_interaction:show_interaction_bar(current, total)
	self._hud_player_downed:hide_timer()

	local function feed_circle(o, total)
		local t = 0

		while total > t do
			t = t + coroutine.yield()

			self._pd2_hud_interaction:set_interaction_bar_width(t, total)
		end
	end

	if _G.IS_VR then
		return
	end

	self._pd2_hud_interaction._interact_circle._circle:stop()
	self._pd2_hud_interaction._interact_circle._circle:animate(feed_circle, total)
	--]]
end

function HUDManager:pd_stop_progress()
--[[
	local hud = self:script(PlayerBase.PLAYER_DOWNED_HUD)

	if not hud then
		return
	end

	if self._pd2_hud_interaction then
		self._pd2_hud_interaction:destroy()

		self._pd2_hud_interaction = nil
	end

	self._hud_player_downed:show_timer()
--]]
end

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
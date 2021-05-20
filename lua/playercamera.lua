do return end

Hooks:PostHook(PlayerCamera,"set_FOV","khud_set_player_fov",function(self,fov_value)
--	local aspect_ratio = 16/9
	KineticHUD:LayoutWorldPanels(75 / fov_value)
--	Console:SetTrackerValue("trackerb",fov_value)
--	Console:SetTrackerValue("trackerc",75/fov_value)
end)
do return end

Hooks:PostHook(PlayerCamera,"set_FOV","khud_set_player_fov",function(self,fov_value)
	local r = 16/9
	KineticHUD:LayoutWorldPanels((((managers.user:get_setting("fov_standard") or 75) * (managers.user:get_setting("fov_multiplier") or 1)) / fov_value)
--	Console:SetTrackerValue("trackera",fov_value)
end)
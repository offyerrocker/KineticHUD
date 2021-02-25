
Hooks:PostHook(HUDManager,"_setup_player_info_hud_pd2","khud_hudpd2_create",function(self)
	if KineticHUD and KineticHUD.Setup then 
		local hm = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local parent_panel = hm and hm.panel
		if alive(parent_panel) then 
			KineticHUD:Setup(parent_panel)
		end
	else
		log("KineticHUD: HUDManager:_setup_player_info_hud_pd2(): khud global not found")
	end
end)



Hooks:PostHook(HUDManager,"_create_heist_timer","khudf_hudmanager_create_heist_timer",function(self,...)
	if self._hud_heist_timer then 
		local timer = self._hud_heist_timer._timer_text
		if alive(timer) then 
			timer:set_font(Idstring(KineticHUD._fonts.digital))
			timer:set_font_size(KineticHUD.settings.HEIST_TIMER_FONT_SIZE)
			timer:set_color(KineticHUD.color_data.white)
		end
	end
end)

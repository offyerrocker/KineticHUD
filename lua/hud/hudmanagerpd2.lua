
Hooks:PostHook(HUDManager,"_setup_player_info_hud_pd2","khud_hudpd2_create",function(self)
	if KineticHUD then 
		local hm = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local parent_panel = hm and hm.panel
		if alive(parent_panel) then 
			KineticHUD:CreateHUD(parent_panel)
		end
	else
		log("KineticHUD: HUDManager:_setup_player_info_hud_pd2(): khud global not found")
	end
end)
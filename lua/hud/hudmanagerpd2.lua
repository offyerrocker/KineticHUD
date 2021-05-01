
Hooks:PreHook(HUDManager,"_setup_player_info_hud_pd2","khud_hudpd2_create",function(self)
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


Hooks:PostHook(HUDManager,"set_disabled","khud_hudmanager_hidehud",function(self)
	KineticHUD:HideHUD()
end)

Hooks:PostHook(HUDManager,"set_enabled","khud_hudmanager_showhud",function(self)
	KineticHUD:ShowHUD()
end)


Hooks:PostHook(HUDManager,"_create_heist_timer","khudf_hudmanager_create_heist_timer",function(self,...)
	if self._hud_heist_timer then 
		local timer = self._hud_heist_timer._timer_text
		if alive(timer) then 
			timer:set_font(Idstring(KineticHUD._fonts.digital))
			timer:set_font_size(KineticHUD.layout_settings.HEIST_TIMER_FONT_SIZE)
			timer:set_color(KineticHUD.color_data.white)
		end
	end
end)

do return end

HUDManager.orig_add_name_label = HUDManager._add_name_label
function HUDManager:_add_name_label(data,...)
	local id = self:orig_add_name_label(data,...)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	
	local panel = hud.panel:child("name_label" .. id)
	if alive(panel) then 
		panel:rect({
			name = "rect_test_" .. id,
			color = Color(tonumber(id or 1),1,1),
			alpha = 0.1,
			visible = false
		})
		local is_husk_player = data.unit:base().is_husk_player
		if is_husk_player or true then 
			panel:text({
				name = "khud_seal_text",
				text = "Dredgen",
				font = KineticHUD._fonts.syke,
				font_size = 24,
				align = "center",
				vertical = "bottom",
				layer = 4,
				visible = data.name and true or false,
				color = KineticHUD.color_data.purple
			})
		end
	end
	return id
end
do return end

Hooks:PostHook(HUDSuspicion,"init","khud_hudsuspicion_init",function(self,hud,sound_source)
	self._hud_panel:hide()
end)


Hooks:PostHook(TeamAIDamage,"init","khud_teamai_init",function(self)
	local panel_id
	for _, character in pairs(managers.criminals._characters) do
		if self._unit == character.unit then
			char_data = character.data
			self._teammate_panel_id = char_data.panel_id or false
			panel_id = self._teammate_panel_id --from khud
			break
		end
	end
	
	--todo add listener
end)

Hooks:PostHook(TeamAIDamage,"_regenerated","khud_teamai_regenerated",function(self)
	local panel_id = self._teammate_panel_id
	if panel_id then
		KineticHUD:SetTeammateHealth(panel_id,self._health,self._HEALTH_TOTAL)
	end
end)

Hooks:PostHook(TeamAIDamage,"_apply_damage","khud_teamai_applydamage",function(self,attack_data, result)
	local panel_id = self._teammate_panel_id
	if panel_id then
		KineticHUD:SetTeammateHealth(panel_id,self._health,self._HEALTH_TOTAL)
	end
end)

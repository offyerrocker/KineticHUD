Hooks:PostHook(HUDTemp,"init","khud_bagpanel_init",function(self,hud)
	self._hud_panel:child("temp_panel"):hide()
end)


function HUDTemp:show_carry_bag(carry_id, value)
	KineticHUD:ShowCarry(carry_id,value)
end

function HUDTemp:hide_carry_bag()
	KineticHUD:HideCarry()
end

function HUDTemp:set_stamina_value(value)
	KineticHUD:SetStamina(value)
end

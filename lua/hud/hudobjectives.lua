Hooks:PostHook(HUDObjectives,"init","khud_hudobjectives_init",function(self,hud)
	local objectives_panel = self._hud_panel:child("objectives_panel")
	objectives_panel:hide()
end)

HUDObjectives.orig_activate_objective = HUDObjectives.activate_objective
function HUDObjectives:activate_objective(data)
	self._active_objective_id = data.id
	
	KineticHUD:SetObjectiveText(data.text or "ERROR")
--	KineticHUD:SetObjectiveAmount(data.current_amount,data.amount,"activate")
	
	
	if data.amount then
		self:update_amount_objective(data)
	end
end

HUDObjectives.orig_complete_objective = HUDObjectives.activate_objective
function HUDObjectives:complete_objective(data)
	if data.id == self._active_objective_id then
		KineticHUD:SetObjectiveText("","complete")
		KineticHUD:SetObjectiveAmount(nil)
	end
end

HUDObjectives.orig_update_amount_objective = HUDObjectives.update_amount_objective
function HUDObjectives:update_amount_objective(data)
	if data.id == self._active_objective_id then
		KineticHUD:SetObjectiveAmount(data.current_amount,data.amount,"update_amount")
	end
end


--[[
Hooks:PostHook(HUDObjectives,"activate_objective","khud_hudobjectives_activate",function(self,data)
	KineticHUD:SetObjectiveText(data.text or "ERROR")
	KineticHUD:SetObjectiveAmount(data.current_amount,data.amount)
end)

Hooks:PostHook(HUDObjectives,"complete_objective","khud_hudobjectives_complete",function(self,data)
	KineticHUD:SetObjectiveText("STANDBY" or data.text)
end)	


Hooks:PreHook(HUDObjectives,"update_amount_objective","khud_hudobjectives_update_count",function(self,data)
	if data.id == self._active_objective_id then 
		KineticHUD:SetObjectiveAmount(data.current_amount,data.amount)
	end
end)

--]]
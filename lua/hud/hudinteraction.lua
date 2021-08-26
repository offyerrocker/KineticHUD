

function HUDInteraction:show_interact(...)
	return KineticHUD:ShowInteract(...)
end

function HUDInteraction:remove_interact(...)
	return KineticHUD:HideInteract(...)
end

function HUDInteraction:show_interaction_bar(...)
	return KineticHUD:ShowInteractBar(...)
end

function HUDInteraction:set_interaction_bar_width(...)
	return KineticHUD:SetInteractProgress(...)
end

function HUDInteraction:hide_interaction_bar(...)
	return KineticHUD:HideInteractBar(...)
end

function HUDInteraction:set_bar_valid(...)
	return KineticHUD:SetInteractValid(...)
end

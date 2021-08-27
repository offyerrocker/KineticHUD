local self = KineticHUD
BeardLib:RemoveUpdater("askdfhj")
BeardLib:AddUpdater("askdfhj",function(t,dt)
	if alive(self._current_interaction) then 
		self._current_interaction:show()
		local line = self._current_interaction:child("interaction_line")
		line:show()
		line:set_rotation( line:rotate(dt * 180))
--			line:set_position(0,0)
	end
end)


if alive(KineticHUD._current_interaction:child("debuga")) then 
	KineticHUD._current_interaction:remove(KineticHUD._current_interaction:child("debuga"))
end
if alive(KineticHUD._current_interaction:child("debugb")) then 
	KineticHUD._current_interaction:remove(KineticHUD._current_interaction:child("debugb"))
end
KineticHUD._current_interaction:rect({
	name = "debuga",
	color = Color.red,
	alpha = 1,
	w = 10,
	h = 10,
	y = 100,
	layer = -10
})
KineticHUD._current_interaction:rect({
	name = "debugb",
	color = Color.blue,
	alpha = 1,
	w = 10,
	h = 10,
	x = 100,
	layer = -10
})
KineticHUD._current_interaction:child("interaction_line"):set_position(100,0)


---


function KineticHUD:CreateInteractPanel()
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[6]
	if not alive(selected_parent_panel) then 
		return
	end
	
	local interaction_panel = selected_parent_panel:panel({
		name = "interaction_panel"
	})
	self._interaction_panel = interaction_panel

	local interaction_text = interaction_panel:text({
		name = "interaction_text",
		text = "",
		font = self._fonts.alt_mono,
		font_size = 48,
		x = 70,
		y = 64,
		color = self.color_data.white
	})
	
end

function KineticHUD:ShowInteract(data)
	
	if alive(self._current_interaction) then 
		self._current_interaction:show()
		local text = data.text or "Press $INTERACT to interact"
		local interaction_text = self._current_interaction:child("interaction_text")
		interaction_text:set_text(utf8.to_upper(text))
		interaction_text:show()
--		self._current_interaction:child("interaction_line"):hide()
--		self._current_interaction:child("interaction_circle"):hide()
--		self._current_interaction:child("interaction_timer"):hide()
		self._current_interaction:child("interaction_text_invalid"):hide()
	end
	
	--SET TEXT
	
end

function KineticHUD:HideInteract()
	if alive(self._current_interaction) then 
		self._current_interaction:hide()
	end

	--hide interact
end

function KineticHUD:ShowInteractBar(current,total)
	local show_timer = true
	
	local interaction_panel = self._interaction_panel
	if not alive(interaction_panel) then 
		return
	end
	
	if alive(self._current_interaction) then 
		self._current_interaction:parent():remove(self._current_interaction)
	end
	local current_interaction = interaction_panel:panel({
		name = "current_interaction",
		x = 400,
		y = 300
	})
	self._current_interaction = current_interaction
	self.make_debug_rect(current_interaction):show()
	
	local interaction_circle = current_interaction:bitmap({
		name = "interaction_circle",
		texture = "guis/textures/pd2/hud_progress_active",
		w = 64,
		h = 64,
		render_template = "VertexColorTexturedRadial"
	})
	interaction_circle:set_color(Color(current/total,0,0))
	
	local interaction_text = current_interaction:text({
		name = "interaction_text",
		text = "",
		font = self._fonts.alt_mono,
		font_size = 48,
		x = 70,
		color = self.color_data.white
	})
	local interaction_text_invalid = current_interaction:text({
		name = "interaction_text_invalid",
		text = "",
		font = self._fonts.alt_mono,
		font_size = 48,
		x = 70,
		color = self.color_data.red,
		visible = false
	})
	local interaction_line = current_interaction:rect({
		name = "interaction_line",
		color = self.color_data.white,
		visible = false,
		w = 1,
		h = 16,
		rotation = 1
	})
	local interaction_timer = current_interaction:text({
		name = "interaction_timer",
		text = "",
		color = self.color_data.white,
		visible = show_timer,
		y = 48,
		x = 70,
		font = self._fonts.syke,
		font_size = 20
	})
	local interaction_target_dot = current_interaction:bitmap({
		name = "interaction_target_dot",
		texture = "textures/ui/firemode_dots_1",
		texture_rect = {
			0,0,16,16
		},
		w = 8,
		h = 8,
		visible = false
	})
	
	
	self:SetInteractProgress(current,total)
end

function KineticHUD:SetInteractProgress(current,total)
--[[
	BeardLib:RemoveUpdater("askdfhj")
	BeardLib:AddUpdater("askdfhj",function(t,dt)
		if alive(self._current_interaction) then 
			self._current_interaction:show()
			local line = self._current_interaction:child("interaction_line")
			line:show()
			line:set_rotation( line:rotation() + (dt * 180))
	--			line:set_position(0,0)
		end
	end)
	do return end
	--]]
	
	if alive(self._current_interaction) then 
		--update guiding lines to state._interact_params.object
		local player = managers.player:local_player()
--		local camera = player:camera()
		local state = player:movement():current_state()
--		local interact_params = state._interact_params
--		local object = interact_params and interact_params.object
		local current_unit = state._interaction and state._interaction:active_unit()
		local interaction_line = self._current_interaction:child("interaction_line")
		local interaction_circle = self._current_interaction:child("interaction_circle")
		if current_unit then 
--			asdf = current_unit

			local oobb = current_unit:oobb()
			local pos = oobb and oobb:center() or current_unit:position()

			local ws = self._workspaces[6]
			local unp = ws:world_to_screen(managers.viewport:get_current_camera(),pos)
			
			local to_x,to_y = unp.x,unp.y
			local from_x,from_y = interaction_circle:world_center()
			
			--[[
			if grugrugru then 
				grugrugru:set_position(to_x,to_y)
			else
				grugrugru = self._interaction_panel:rect({
					name = "grugrugru",
					color = Color.blue,
					alpha = 1,
					x = to_x,
					y = to_y,
					w = 8,
					h = 8
				})
			end
			if asdfdfdsfd then 
				asdfdfdsfd:set_position(from_x,from_y)
			else
				asdfdfdsfd = self._interaction_panel:rect({
					name = "asdfdfdsfd",
					color = Color.red,
					alpha = 1,
					x = from_x,
					y = from_y,
					w = 8,
					h = 8
				})
			end
			--]]
			
			local d_x = to_x - from_x
			local d_y = to_y - from_y
			
			local hyp = math.sqrt((d_x * d_x) + (d_y * d_y))
			
			local angle = math.atan(d_y / d_x) + 90
			
			interaction_line:set_h(hyp)
			
			interaction_line:set_rotation(angle)
			
			local ix,iy = interaction_circle:center()
			ix = ix + (d_x/2)
			iy = iy + (d_y/2) - (hyp / 2)
			
			interaction_line:set_position(ix,iy)
			interaction_line:show()
			
			local interaction_target_dot = self._current_interaction:child("interaction_target_dot")
			interaction_target_dot:show()
			interaction_target_dot:set_rotation(angle)
			interaction_target_dot:set_world_center(to_x,to_y)
		else
			interaction_line:hide()
		end
		
		local interaction_circle = self._current_interaction:child("interaction_circle")
		interaction_circle:set_color(Color(current/total,1,1))
		
		local interaction_timer = self._current_interaction:child("interaction_timer")
		local timer_text = ""
		if true then --timer enabled
			--todo leading zeroes/decimal place accuracy
			
			if show_total_time then 
				timer_text = string.format("%0.1f/%0.1f",current,total)
			else
				timer_text = string.format("%0.2f",current)
			end
		end
		interaction_timer:set_text(timer_text)
	end
end

function KineticHUD:HideInteractBar(complete)
	if alive(self._current_interaction) then 
		--remove old interaction bar
		self._current_interaction:hide()
		self._current_interaction:child("interaction_circle"):hide()
		self._current_interaction:child("interaction_line"):hide()
		self._current_interaction:child("interaction_timer"):hide()
		self._current_interaction:child("interaction_target_dot"):hide()
		
		if complete then 
			--hud animation for interaction complete
		end
	end
end

function KineticHUD:SetInteractValid(valid,text_id)
	--set invalid text visible
	
	if alive(self._current_interaction) then 
		self._current_interaction:child("interaction_circle"):set_image("guis/textures/pd2/hud_progress_invalid")
		local interaction_text_invalid = self._current_interaction:child("interaction_text_invalid")
		interaction_text_invalid:set_visible(not valid)
		if text_id then 
			interaction_text_invalid:set_text(managers.localization:to_upper_text(text_id))
		end
		self._current_interaction:child("interaction_text"):set_visible(valid)
	end
end

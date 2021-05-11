
HUDChat.orig_init = HUDChat.init
function HUDChat:init(ws, hud, ...)
	local ws = KineticHUD._workspaces[KineticHUD.layout_settings.chat_panel_location]
	if ws and alive(KineticHUD._chat_panel) then 
		if hud == managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2) then
			--another HUDChat instance is created for use during camera access i guess. but it's not properly deactivated with my mod, probably due to sharing the same workspace
			--so... camera access (managers.hud:script(IngameAccessCamera.GUI_SAFERECT)) gets to be flatscreen 
			self._ws = ws
			local data = { panel = KineticHUD._chat_panel }
			return self:orig_init(ws,data,...)
		end
	end
	return self:orig_init(ws,hud,...)
end



function HUDChat:clbk_khud_mouse_pressed(o,button,x,y)
	if button == Idstring("mouse wheel up") then 
		self._panel:child("output_panel"):move(0,-HUDChat.line_height)
	elseif button == Idstring("mouse wheel down") then
		self._panel:child("output_panel"):move(0,HUDChat.line_height)
	end
end


Hooks:PreHook(HUDChat,"_on_focus","hudchat_on_focus",function(self,...)

	local data = {
--		mouse_move = callback(self, self, "mouse_move"),
--		mouse_click = callback(self, self, "mouse_click"),
		mouse_press = callback(self, self, "clbk_khud_mouse_pressed"),
--		mouse_release = callback(self, self, "mouse_release"),
--		mouse_double_click = callback(self, self, "mouse_double_click"),
		id = KineticHUD.MOUSE_ID
	}
	
	managers.mouse_pointer:use_mouse(data)
	
end)

Hooks:PreHook(HUDChat,"_loose_focus","hudchat_on_lose_focus",function(self,...)
	if not self._focus then
		return
	end
	managers.mouse_pointer:remove_mouse(KineticHUD.MOUSE_ID)
	self:_layout_output_panel()
end)






do return end

function HUDChat:_loose_focus()
	if not self._focus then
		return
	end
	
		
	self._focus = false

	self._input_panel:child("focus_indicator"):set_color(Color.white:with_alpha(0.2))
	self._ws:disconnect_keyboard()
	self._input_panel:key_press(nil)
	self._input_panel:enter_text(nil)
	self._input_panel:key_release(nil)
	self._panel:child("output_panel"):stop()
	self._panel:child("output_panel"):animate(callback(self, self, "_animate_fade_output"))
	self._input_panel:stop()
	self._input_panel:animate(callback(self, self, "_animate_hide_input"))

	local text = self._input_panel:child("input_text")

	text:stop()
	self._input_panel:child("input_bg"):stop()
	self:set_layer(1)
	self:update_caret()
	
end


function HUDChat:_on_focus()
	if self._focus then
		return
	end
	
	local data = {
--		mouse_move = callback(self, self, "mouse_moved"),
--		mouse_click = callback(self, self, "mouse_clicked"),
		mouse_press = callback(self, self, "mouse_pressed"),
--		mouse_release = callback(self, self, "mouse_released"),
--		mouse_double_click = callback(self, self, "mouse_double_clicked"),
		id = KineticHUD.MOUSE_ID
	}
	
	managers.mouse_pointer:use_mouse(data)

	local output_panel = self._panel:child("output_panel")

	output_panel:stop()
	output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
	self._input_panel:stop()
	self._input_panel:animate(callback(self, self, "_animate_show_component"))

	self._focus = true

	self._input_panel:child("focus_indicator"):set_color(Color(0.8, 1, 0.8):with_alpha(0.2))
	self._ws:connect_keyboard(Input:keyboard())

	if _G.IS_VR then
		Input:keyboard():show()
	end

	self._input_panel:key_press(callback(self, self, "key_press"))
	self._input_panel:key_release(callback(self, self, "key_release"))

	self._enter_text_set = false

	self._input_panel:child("input_bg"):animate(callback(self, self, "_animate_input_bg"))
	self:set_layer(1100)
	self:update_caret()

end
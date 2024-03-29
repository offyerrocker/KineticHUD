--todo get voice commands list from json file
--todo add option to use localized name ids
--
--Hooks:PostHook(HUDChat,"_layout_input_panel","khud_layout_chat_input",function(self)
--end)


function HUDChat:set_khud_chat_scale(scale)
	if not scale then return end
	
	local panel = self._panel
	local input = self._input_panel
	local output = self._output_panel
	local say = input:child("say")
	local text = input:child("input_text")
	local caret = input:child("caret")
	local bg = input:child("bg")
	
--	if input.set_font_size then 
--		input:set_font_size(scale * tweak_data.menu.pd2_small_font_size)
--	end
	
	--do stuff with self._lines here
	
	
--	self._input_panel:child(
	
end


Hooks:PostHook(HUDChat,"receive_message","khud_hudchat_receive_message",function(self,name,message,color,icon)
	local dewit = (KineticHUD.chat_lines % 2) == 0
--	Log(KineticHUD.concat({dewit,KineticHUD.chat_lines,name,message,color,icon}),{color = Color.yellow})
	
	if dewit then 
		local infamy_icon = true
	--todo init that v
		local text_margin_x = 2
		local text_margin_y = 2
		local text_y = 0 --default
		local font_size = 12
		
		local frame = managers.hud._khud_base:child("hudchat_test_frame")
--		managers.hud._khud_base:child("hudchat_test_frame"):child("chatlog")
		
		local chatlog = frame:child("chatlog")
		local previous_line = chatlog:child("message_" .. KineticHUD.chat_lines - 2)
		if alive(previous_line) then
			local _,y,_,h = previous_line:text_rect()
			text_y = (y - chatlog:y()) + h + text_margin_y
		end
		
		
--
--	local sender = chatlog:text({
--		name = "sender_" .. KineticHUD.chat_lines,
--		layer = 1,
--		x = 0,
--		y = text_y,
--		text = name,
--		font = tweak_data.hud.medium_font,
--		font_size = font_size,
--		color = color
--	})
--	local _,_,sender_w,_ = sender:text_rect()
--
		local color_data,processed_message = KineticHUD.scan_colormacros(message)
		local line = chatlog:text({
			name = "message_" .. KineticHUD.chat_lines,
			layer = 1,
			x = 0 + text_margin_x,
			y = text_y,
			text = name .. ": " .. processed_message,
			font = tweak_data.hud.medium_font,
			font_size = font_size,
			color = Color.white
		})
		
		
		local namelen = utf8.len(name) + 1
		
		for k,v in pairs(color_data) do 
			local col = Color[v.color] or KineticHUD.quality_colors[v.color]
			line:set_range_color(v.start,v.finish,((type(col) == type(Color.white)) and col) or Color.white)
		end
		
		line:set_range_color(0, namelen, color)
--		line:set_range_color(namelen, utf8.len(line:text()), Color(1,1,0))
		
		local _,_,_,h = line:text_rect()
		
		chatlog:set_y(chatlog:y() - (h + text_margin_y))
	end
	KineticHUD.chat_lines = KineticHUD.chat_lines + 1
	
	--todo flashy fucking colors, cause i'm cool
	--todo macro replace given chars
	--todo macro replace given colors?
	
	
end)



Hooks:PostHook(HUDChat,"_on_focus","khud_on_chatfocus",function(self)
	if (KineticHUD.settings.chat_display_mode % 2) == 0 then
		KineticHUD.chat_fadeout_desired = false
		KineticHUD.chat_fadeout_t = Application:time()
		KineticHUD.chat_lifetime_t = Application:time()
	end
end)
	
	
Hooks:PostHook(HUDChat,"init","khud_init_hudchat",function(self,ws,hud)
	local hud = managers.hud._khud_base
	if not hud then 
		KineticHUD:_log("No khud base found")
		return
	end
	local hudchat_test_frame = hud:panel({
		name = "hudchat_test_frame",
		visible = false,
		w = 400,
		h = 400
	})
	local chatlog = hudchat_test_frame:panel({
		name = "chatlog",
		y = 400
	})
	local hudchat_test_debug = hudchat_test_frame:rect({
		name = "hudchat_test_debug",
		color = Color.red:with_alpha(0.3),
		visible = false
	})
	
	local input_bg_col = Color.white
	self._input_panel:child("input_bg"):set_gradient_points({
		0,
		input_bg_col:with_alpha(0),
		0.8, --formerly 0.2
		input_bg_col:with_alpha(0.25),
		1,
		input_bg_col:with_alpha(0)
	})
--	local show_debug = KineticHUD:IsDebugEnabled()
	
	local output_bg_col = Color.black
	local output_panel = self._panel:child("output_panel")
	local output_bg = output_panel:child("output_bg")
	local output_bg_blend_mode = "normal"
	output_bg:set_gradient_points({
		0,
		output_bg_col:with_alpha(0),
		0.2,
		output_bg_col:with_alpha(0.25),
		1,
		output_bg_col:with_alpha(0)
	})
	output_bg:set_blend_mode(output_bg_blend_mode)
	
	
	local debug_output = output_panel:rect({
		name = "debug_output",
		color = Color.green:with_alpha(0.3),
		visible = false
	})
	local debug_input = self._input_panel:rect({
		name = "debug_input",
		color = Color.red:with_alpha(0.3),
		visible = false
	})
	local debug_chat = self._panel:rect({
		name = "debug_chat",
		color = Color.blue:with_alpha(0.3),
		visible = false
	})
	
	local qchat = self._panel:panel({
		name = "quickchat_panel",
		layer = 1,
		x = 100,
		visible = false --should start out false
	})
	local y_margin = 5
	local x_margin = 10
	local y_offset = 128
	local fontsize = 18
	qchat:text({
		name = "quickchat_title",
		align = "left",
		font = "fonts/font_medium_mf",
		font_size = 24,
		blend_mode = "normal",
		x = x_margin,--self._panel:w() / 2,
		y = y_offset + y_margin,
		layer = 1,
		visible = true,
		text = "VOICE COMMANDS", --todo loc manager
		Color = Color.white
	})
	qchat:bitmap({
		name = "quickchat_bg",
		w = 170 + x_margin,
		h = 135 + y_margin,
		y = y_offset,
		layer = 0,
		texture = "guis/textures/pd2/hud_tabs",
		texture_rect = {84,0,44,32},
		color = Color.white * 0.75
	})
	
	for i = 1, 4 do --or 14
		qchat:text({
			name = "quickchat_entry_" .. tostring(i),
			align = "left",
			vertical = "top",
			font = "fonts/font_medium_mf",
--			font = "fonts/font_small_mf",--font_euro_stencil",
			font_size = fontsize,
			blend_mode = "normal",
			x = x_margin,
			y = y_offset + ((y_margin + fontsize) * (i + 1)),
			layer = 1,
			visible = true,
			text = tostring(i),
			Color = Color.white
		})
	end
end)

function HUDChat:hide_quickchat_menu()--instant hide, no fade anim
	local qchat = self._panel:child("quickchat_panel")
	qchat:hide()
end --not currently called anywhere

function HUDChat:refresh_quickchat_menu(selected)
	selected = selected or 1
	local qchat = self._panel:child("quickchat_panel")
	local this_panel,j
	qchat:child("quickchat_title"):set_text("VOICE COMMANDS: [" .. tostring(selected) .. "]")
	local category = KineticHUD:get_quickchat_focus()
	local sel
	if category then 
		qchat:hide()
		
		local num = (4 * (category - 1)) + selected
		
		sel = KineticHUD.quickchat_defaults[num]
		
		if sel then 
			if sel.sound then 
				KineticHUD:play_criminal_sound(sel.sound)
			end
			if not KineticHUD:IsQuickChatNoText() and sel.text then 
				managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "(Voice) " .. tostring(sel.text))
			end
			if sel.anim then 
				KineticHUD:play_viewmodel_anim(sel.anim)
			end
		end

		--do selected
		KineticHUD:set_quickchat_focus() --resets to nil
		return
	else
		KineticHUD.quickchat_start_t = Application:time()
		qchat:show()
		qchat:set_alpha(1)
		KineticHUD:set_quickchat_focus(selected)
	end
	for i = 1, 4 do
		j = (4 * (selected - 1)) + i
		this_panel = qchat:child("quickchat_entry_" .. tostring(i))
		this_panel:set_text(tostring(i) .. ". " .. (KineticHUD.quickchat_defaults[j] and KineticHUD.quickchat_defaults[j].name or "[EMPTY]"))--todo get preferences[j]
	end
end

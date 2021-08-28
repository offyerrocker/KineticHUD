--thanks to Dom for making everything better with Better Assault Indicators mod

Hooks:PostHook(HUDAssaultCorner,"init","khud_assaultcorner_init",function(self,hud,full_hud,tweak_hud)
	self._hud_panel:hide()
	self._hostages_bg_box:hide()
	self._hud_panel:child("hostages_panel"):set_y(-100)
	self._hud_panel:child("hostages_panel"):set_alpha(0)
	if alive(self._hud_panel:child("wave_panel")) then 
		self._hud_panel:child("wave_panel"):hide()
	end
end)

HUDAssaultCorner.orig_set_control_info = HUDAssaultCorner.set_control_info
function HUDAssaultCorner:set_control_info(data)
	KineticHUD:SetHostagesCount(data.nr_hostages)
end

HUDAssaultCorner.orig_start_assault = HUDAssaultCorner._start_assault
function HUDAssaultCorner:_start_assault(text_list)
	
	KineticHUD:AnimateShowAssaultBanner("ASSAULT IN PROGRESS",2,5)
	
	local started_now = not self._assault
	self._assault = true
	
--	KineticHUD:SetAssaultMode(true,"normal")
	
	if managers.skirmish:is_skirmish() and started_now then
		self:_popup_wave_started()
	end
--	KineticHUD:SetAssaultPhaseText("ASSAULT IN PROGRESS")
	--assault panel: show wave info
end

HUDAssaultCorner.orig_end_assault = HUDAssaultCorner._end_assault
function HUDAssaultCorner:_end_assault()
	if not self._assault then
		return
	end
	
	KineticHUD:AnimateHideAssaultBanner()
	
--	KineticHUD:SetAssaultMode(false)

	self:_set_feedback_color(nil) --i wish my keyboard supported assault colors lol

	self._assault = false
	

	if self:should_display_waves() then
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list(self:_get_survived_assault_strings())
		local wave_max
		local wave_current
		if self._max_waves < math.huge then 
			wave_current = managers.network:session():is_host() and managers.groupai:state():get_assault_number() or self._wave_number
			wave_max = self._max_waves
		end
		KineticHUD:SetAssaultWaveNumber(wave_current,wave_max)
		
		if managers.skirmish:is_skirmish() then
			self:_popup_wave_finished()
		else
--[[
			NobleHUD:AddQueuedObjective({
				mode = "wave",
				id = "noblehud_assault_wave",
				color = self._current_assault_color,
				amount = wave_max,
				current_amount = wave_current,
				text = self:wave_popup_string_end()
			})
			--]]
		end
	end
end

HUDAssaultCorner.orig_show_casing = HUDAssaultCorner.show_casing
function HUDAssaultCorner:show_casing(mode)
--	KineticHUD:c_log("show casing " .. tostring(mode))
--	KineticHUD:SetAssaultMode(true,mode or "stealth")
end

HUDAssaultCorner.orig_hide_casing = HUDAssaultCorner.hide_casing
function HUDAssaultCorner:hide_casing()
--	KineticHUD:SetAssaultMode(false,"stealth")
end

HUDAssaultCorner.orig_feed_point_of_no_return_timer = HUDAssaultCorner.feed_point_of_no_return_timer
function HUDAssaultCorner:feed_point_of_no_return_timer(time, is_inside)
	KineticHUD:SetAssaultPONRTimer(time)
end

HUDAssaultCorner.orig_show_point_of_no_return_timer = HUDAssaultCorner.show_point_of_no_return_timer
function HUDAssaultCorner:show_point_of_no_return_timer()
	KineticHUD:ShowAssaultPONR()

	self:_set_feedback_color(self._noreturn_color)

	self._point_of_no_return = true
end

HUDAssaultCorner.orig_hide_point_of_no_return_timer = HUDAssaultCorner.hide_point_of_no_return_timer
function HUDAssaultCorner:hide_point_of_no_return_timer()
	KineticHUD:HideAssaultPONR()
	
	self._point_of_no_return = false
	self:_set_feedback_color(nil)
end

HUDAssaultCorner.orig_flash_point_of_no_return_timer = HUDAssaultCorner.flash_point_of_no_return_timer
function HUDAssaultCorner:flash_point_of_no_return_timer(beep)
	--rien
end

function HUDAssaultCorner:_popup_wave(text, color)
--[[
	NobleHUD:AddQueuedObjective({
		mode = "wave",
		id = "noblehud_assault_wave",
		color = color,
--		amount = total_wave,
--		current_amount = current_wave,
		text = text
	})
	--]]
end

HUDAssaultCorner.orig_show_hostages = HUDAssaultCorner._show_hostages
function HUDAssaultCorner:_show_hostages()
end

HUDAssaultCorner.orig_hide_hostages = HUDAssaultCorner._hide_hostages
function HUDAssaultCorner:_hide_hostages()
	self._hud_panel:child("hostages_panel"):hide()
end

HUDAssaultCorner.orig_sync_set_assault_mode = HUDAssaultCorner.sync_set_assault_mode
function HUDAssaultCorner:sync_set_assault_mode(mode) --from host
	if self._assault_mode == mode then 
		return 
	end
	
	self._assault_mode = mode
	if mode == "phalanx" then 
		color = self._vip_assault_color
		KineticHUD:AnimateShowAssaultBanner("WINTERS ASSAULT",2,5)
	end
--	KineticHUD:SetAssaultMode(mode)
	self:_update_assault_hud_color(color)
	
end

HUDAssaultCorner.orig_set_assault_wave_number = HUDAssaultCorner.set_assault_wave_number
function HUDAssaultCorner:set_assault_wave_number(assault_number)
	self._wave_number = assault_number
	KineticHUD:SetAssaultWaveNumber(assault_number,self._max_waves)
end


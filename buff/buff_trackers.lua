if GameInfoManager then 
	






end





if not BuffTracker then 
	return
end

if RequiredScript == "core/lib/managers/coreenvironmentcontrollermanager" then 

	Hooks:PostHook(CoreEnvironmentControllerManager,"set_flashbang","noblehud_buff_flashbang",function(self,flashbang_pos, line_of_sight, travel_dis, linear_dis, duration)
		NobleHUD:AddBuff("flashbang",{duration = self._current_flashbang})
	end)

elseif RequiredScript == "lib/managers/hud/hudassaultcorner" then 
	function HUDAssaultCorner:set_buff_enabled(buff_name, enabled) --winters dmg resist buff for cops; other captains in resmod
	--	NobleHUD:log("ASSAULTCORNER: Buff enabled [" .. tostring(buff_name) .. "]: " .. tostring(enabled))
		if enabled then 
			NobleHUD:AddBuff(buff_name)
		else
			NobleHUD:RemoveBuff(buff_name)
		end
	end
elseif RequiredScript == "lib/managers/hud/hudteammate" then 


	Hooks:PostHook(HUDTeammate,"set_absorb_active","noblehud_buff_hysteria",function(self,absorb_amount)
		if self._main_player then 
			if absorb_amount > 0 then
				NobleHUD:AddBuff("hysteria",{value = absorb_amount})
			else 
				NobleHUD:RemoveBuff("hysteria")
			end
		end
	end)

	Hooks:PostHook(HUDTeammate,"set_delayed_damage","noblehud_buff_stoic",function(self,damage)
		if self._main_player then 
			if damage > 0 then 
				NobleHUD:AddBuff("delayed_damage",{value = damage})
			else
				NobleHUD:RemoveBuff("delayed_damage")
			end
		end
	end)


	Hooks:PostHook(HUDTeammate,"set_stored_health","noblehud_buff_expresident",function(self,stored_health)
		if self._main_player then 
			if stored_health > 0 then 
				NobleHUD:AddBuff("expresident",{value = stored_health})
			else
				NobleHUD:RemoveBuff("expresident")
			end
		end
	end)

	Hooks:PostHook(HUDTeammate,"activate_ability_radial","noblehud_buff_throwables",function(self,time_left,time_total)
	--	NobleHUD:log("doing buff activate_ability_radial(" .. tostring(time_left) .. "," .. tostring(time_total)..")")
		if self._main_player then 			
			if time_left then
				local ability,amount = managers.blackmarket:equipped_grenade()
				if ability then 
					NobleHUD:AddBuff(ability,{duration = time_left})
				else
					NobleHUD:log("activate_ability_radial(" .. tostring(time_left) .. "," .. tostring(time_total)..") No ability found!")
				end
			end
		end
	end)
elseif RequiredScript == "lib/units/beings/player/playerdamage" then 
	Hooks:PostHook(PlayerDamage,"_on_enter_swansong_event","noblehud_buff_swansong",function(self)
		NobleHUD:AddBuff("swan_song",{end_t = managers.player:get_activate_temporary_expire_time("temporary", "berserker_damage_multiplier")})
		--value = managers.player:upgrade_value("temporary", "berserker_damage_multiplier")
		--duration = value[2]
	end)

	Hooks:PostHook(PlayerDamage,"_on_revive_event","noblehud_buff_messiah_ready_remove",function(self)
		NobleHUD:RemoveBuff("messiah_ready")
		NobleHUD:RemoveBuff("swan_song")
	end)

	Hooks:PostHook(PlayerDamage,"_on_exit_swansong_event","noblehud_buff_swansong_remove",function(self)
		NobleHUD:RemoveBuff("swan_song")
	end)

	--[[
	Hooks:PostHook(PlayerDamage,"_on_damage_armor_grinding","noblehud_buff_anarchist_lust_for_life",function(self)
		NobleHUD:AddBuff("anarchist_lust_for_life")
	end)
	--]]

	Hooks:PostHook(PlayerDamage,"_update_armor_grinding","noblehud_buff_anarchist",function(self,t,dt)
		if not (self._armor_grinding and self._armor_grinding.elapsed and self._armor_grinding.target_tick) then
			return
		end
		local next_regen = self._armor_grinding.target_tick - self._armor_grinding.elapsed
		local regen_amount = self._armor_grinding.armor_value
		NobleHUD:AddBuff("anarchist_armor_regen",{duration = next_regen,value = regen_amount})
	end)

	Hooks:PreHook(PlayerDamage,"_check_bleed_out","noblehud_buff_uppers_aced_cooldown",function(self,can_activate_berserker,ignore_movement_state,...)
		if self:get_real_health() == 0 and not self._check_berserker_done then

			if not self._block_medkit_auto_revive and self._uppers_elapsed + self._UPPERS_COOLDOWN < Application:time() then
				local auto_recovery_kit = FirstAidKitBase.GetFirstAidKit(self._unit:position())

				if auto_recovery_kit then
					NobleHUD:AddBuff("uppers_aced_cooldown",{duration = self._UPPERS_COOLDOWN})
				end
			end
		end
	end)

	Hooks:PostHook(PlayerDamage,"set_health","noblehud_buff_berserker",function(self,health) 
		if managers.player:has_category_upgrade("player", "damage_health_ratio_multiplier") then
			local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "melee")
			if ratio > 0 then 
				NobleHUD:AddBuff("berserker_damage_multiplier",{value=ratio})
			else
				NobleHUD:RemoveBuff("berserker_damage_multiplier")
			end
		end
		if managers.player:has_category_upgrade("player", "melee_damage_health_ratio_multiplier") then
			local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "damage")
			if ratio > 0 then 
				NobleHUD:AddBuff("berserker_melee_damage_multiplier",{value=ratio})
			else
				NobleHUD:RemoveBuff("berserker_melee_damage_multiplier")
			end
		end
		if managers.player:has_category_upgrade("player", "movement_speed_damage_health_ratio_multiplier") then
			local ratio = managers.player:get_damage_health_ratio(self:health_ratio(), "movement_speed")
			if ratio > 0 then 
				NobleHUD:AddBuff("yakuza",{value=string.format("%.2f",ratio)}) --in most other places, formatting is handled in UpdateHUD() but not here since it's very simple
			else
				NobleHUD:RemoveBuff("yakuza")
			end
		end
	end)

	Hooks:PostHook(PlayerDamage,"_upd_health_regen","noblehud_buff_hp_regen",function(self,t,dt)
		if self._health_regen_update_timer then
			if math.floor(managers.player:health_regen() * 100) > 0 then 
				NobleHUD:AddBuff("hp_regen",{value=health_value,duration=self._health_regen_update_timer})
			else
				NobleHUD:RemoveBuff("hp_regen")
			end
		else
			NobleHUD:RemoveBuff("hp_regen")
		end
		

		local hot_stacks = self._damage_to_hot_stack
		local next_doh = hot_stacks and hot_stacks[1]
		if next_doh then 
			local ticks_count = 0
			for k,doh in pairs(hot_stacks) do 

				if doh.ticks_left then 
					ticks_count = ticks_count + doh.ticks_left
				end
			end
			NobleHUD:AddBuff("grinder",{value=ticks_count})
		else
			NobleHUD:RemoveBuff("grinder")
		end
	end)

	Hooks:PreHook(PlayerDamage,"_update_regenerate_timer","noblehud_buff_dire_need_remove",function(self,no_sound)
		NobleHUD:RemoveBuff("dire_need")
	end)

	Hooks:PreHook(PlayerDamage,"set_armor","noblehud_buff_dire_need",function(self,armor)
		armor = math.clamp(armor, 0, self:_max_armor())

		if self._armor then
			if self:get_real_armor() ~= 0 and armor == 0 and self._dire_need then
				local duration = managers.player:upgrade_value("player", "armor_depleted_stagger_shot", 0)
				if duration > 0 then 
					NobleHUD:AddBuff("dire_need",{duration=duration})
				end
			end
		end
	end)


elseif RequiredScript == "lib/units/beings/player/playerinventory" then 

	Hooks:PostHook(PlayerInventory,"_start_feedback_effect","noblehud_buff_pocket_ecm_jammer_feedback",function(self,end_time,interval,range)
		NobleHUD:AddBuff("pocket_ecm_jammer_feedback",{end_t = end_time or (TimerManager:game():time() + self:get_jammer_time()),timer_source = "game"})
	end)

	Hooks:PostHook(PlayerInventory,"_start_jammer_effect","noblehud_buff_pocket_ecm_jammer",function(self,end_time)
		NobleHUD:AddBuff("pocket_ecm_jammer",{end_t = end_time or (TimerManager:game():time() + self:get_jammer_time()),timer_source = "game"})
	end)

	Hooks:PostHook(PlayerInventory,"_stop_jammer_effect","noblehud_buff_pocket_ecm_jammer_remove",function(self,end_time)
	--	NobleHUD:RemoveBuff("pocket_ecm_jammer")
	end)
	--NobleHUD:AddBuff("pocket_ecm_jammer",{end_t = (TimerManager:game():time() + 6),timer_source = "game"})
elseif RequiredScript == "lib/managers/playermanager" then 

	Hooks:PostHook(PlayerManager,"remove_property","noblehud_remove_property",function(self,name)
		NobleHUD:RemoveBuff(name)
	--	NobleHUD:log("PlayerManager:remove_property(" .. tostring(name) .. ")",{color=Color.yellow})
	end)

	Hooks:PostHook(PlayerManager,"set_property","noblehud_set_property",function(self,name,value)
		NobleHUD:AddBuff(name,{value=value})
		--NobleHUD:log("PlayerManager:set_property(" .. tostring(name) .. "," .. tostring(value) .. ")",{color=Color.yellow})
	end)

	--[[
	Hooks:PreHook(PlayerManager,"_change_player_state","noblehud_on_game_state_changed",function(self)
		if not (NobleHUD and game_state_machine) then
			return 
		end
		local previous_state = game_state_machine:last_queued_state_name()
		local state = self._player_states[self._current_state]
		NobleHUD:OnGameStateChanged(previous_state,state)
	end)
	--]]

	Hooks:PostHook(PlayerManager,"activate_temporary_upgrade","noblehud_activate_temporary_upgrade",function(self,category, upgrade)
		local t = self._temporary_upgrades[category] and self._temporary_upgrades[category][upgrade] and self._temporary_upgrades[category][upgrade].expire_time
		
		NobleHUD:AddBuff(upgrade,{end_t = t}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
	end)

	Hooks:PostHook(PlayerManager,"activate_temporary_property","noblehud_activate_temporary_property",function(self,name, time, value)
		--NobleHUD:log("PlayerManager:activate_temporary_property(" .. NobleHUD.table_concat({name=name,time=time,value=value},",","=") .. ")",{color=Color.yellow})
	--	local t = self._temporary_upgrades[category] and self._temporary_upgrades[category][upgrade] and self._temporary_upgrades[category][upgrade].expire_time
	--	NobleHUD:AddBuff(upgrade,{end_t = t}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
		NobleHUD:AddBuff(name,{duration=time,value=value})
	end)

	Hooks:PostHook(PlayerManager,"activate_temporary_upgrade_by_level","noblehud_activate_temporary_upgrade_by_level",function(self,category, upgrade, level)
		local t = self._temporary_upgrades[category] and self._temporary_upgrades[category][upgrade] and self._temporary_upgrades[category][upgrade].expire_time
		NobleHUD:AddBuff(upgrade,{end_t = t}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
	end)

	Hooks:PostHook(PlayerManager,"add_to_temporary_property","noblehud_add_temporary_property",function(self,name, time, value)
		NobleHUD:AddBuff(name,{duration = time}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
	end)

	Hooks:PostHook(PlayerManager,"aquire_cooldown_upgrade","noblehud_aquire_cooldown_upgrade",function(self,upgrade)
	--upgrade is a table. whoops.
		local name = upgrade.upgrade
		local upgrade_value = self:upgrade_value(upgrade.category,name)
		--NobleHUD:log("PlayerManager:aquire_cooldown_upgrade(" .. NobleHUD.table_concat(upgrade,",","=") .. ")")
	--	NobleHUD:AddBuff(name,{duration = time}) --i'd have to re-calculate stuff or overwrite the function to use duration instead of end_t. i'd rather risk having desynced end times
	end)

	Hooks:PostHook(PlayerManager,"disable_cooldown_upgrade","noblehud_disable_cooldown_upgrade",function(self,category,upgrade)
		local upgrade_value = self:upgrade_value(category, upgrade)

		if upgrade_value == 0 then
			return
		end

		local t = upgrade_value[2]

		NobleHUD:AddBuff(upgrade,{duration = t})
	end)

	--[[
	Hooks:PostHook(PlayerManager,"sync_tag_team","noblehud_buff_tag_team",function(self,tagged,owner,end_time)
		
	end)
	--]]

	Hooks:PreHook(PlayerManager,"on_headshot_dealt","noblehud_buff_bullseye",function(self)
		if not self:player_unit() then return end

		if self._on_headshot_dealt_t and Application:time() < self._on_headshot_dealt_t then
			return
		end

		if self:upgrade_value("player", "headshot_regen_armor_bonus", 0) > 0 then 
			if self._on_headshot_dealt_t then 
				NobleHUD:AddBuff("bullseye",{end_t = self._on_headshot_dealt_t})
			else --just in case
				NobleHUD:AddBuff("bullseye",{duration = (tweak_data.upgrades.on_headshot_dealt_cooldown or 0)})
			end
		end
	end)

	Hooks:PreHook(PlayerManager,"_on_enemy_killed_bloodthirst","noblehud_buff_bloodthirst",function(self,equipped_unit,variant,killed_unit)
		if variant == "melee" then
			local data = self:upgrade_value("player", "melee_kill_increase_reload_speed", 0)
			if data ~= 0 then 
	--			NobleHUD:log("bloodthirst [1] = " .. tostring(data[1]) .. ",[2] = " .. tostring(data[2]))
				NobleHUD:AddBuff("bloodthirst_reload_speed",{duration=data[2]})
			end
		end	
	--	managers.player:has_active_temporary_property("melee_kill_increase_reload_speed")
	end)

	Hooks:PostHook(PlayerManager,"reset_melee_dmg_multiplier","noblehud_buff_bloodthirst_melee_remove",function(self)
		NobleHUD:RemoveBuff("bloodthirst_melee")
	end)

	Hooks:PostHook(PlayerManager,"set_melee_dmg_multiplier","noblehud_buff_bloodthirst_melee",function(self,value)
		NobleHUD:AddBuff("bloodthirst_melee",{value=value})
	end)

	Hooks:PreHook(PlayerManager,"_on_expert_handling_event","noblehud_buff_desperado",function(self,unit, attack_data)
		local attacker_unit = attack_data.attacker_unit
		local variant = attack_data.variant

		if attacker_unit == self:player_unit() and self:is_current_weapon_of_category("pistol") and variant == "bullet" and not self._coroutine_mgr:is_running(PlayerAction.ExpertHandling) then
			local data = self:upgrade_value("pistol", "stacked_accuracy_bonus", nil)

			if data and type(data) ~= "number" then
				NobleHUD:AddBuff("desperado",{end_t = Application:time() + data.max_time,value = data.max_stacks})
			end
		end
	end)

	Hooks:PreHook(PlayerManager,"_on_enter_trigger_happy_event","noblehud_buff_trigger_happy",function(self,unit, attack_data)
		local attacker_unit = attack_data.attacker_unit
		local variant = attack_data.variant

		if attacker_unit == self:player_unit() and variant == "bullet" and not self._coroutine_mgr:is_running("trigger_happy") and self:is_current_weapon_of_category("pistol") then
			local data = self:upgrade_value("pistol", "stacking_hit_damage_multiplier", 0)

			if data ~= 0 then
				NobleHUD:AddBuff("trigger_happy",{end_t = Application:time() + data.max_time,value = data.damage_bonus})
	--			NobleHUD:log("_on_enter_trigger_happy_event(" .. NobleHUD.table_concat({damage_bonus = data.damage_bonus,max_stacks = data.max_stacks,end_t = ,time = Application:time()},",","="))
	--			self._coroutine_mgr:add_coroutine("trigger_happy", PlayerAction.TriggerHappy, self, data.damage_bonus, data.max_stacks, Application:time() + data.max_time)
			end
		end
	end)

	Hooks:PreHook(PlayerManager,"_on_enter_shock_and_awe_event","noblehud_buff_lock_n_load",function(self)
		if NobleHUD:IsBuffEnabled("shock_and_awe_reload_multiplier") and not self._coroutine_mgr:is_running("automatic_faster_reload") then
			local equipped_unit = self:get_current_state()._equipped_unit
			local data = self:upgrade_value("player", "automatic_faster_reload", nil)
			local is_grenade_launcher = equipped_unit:base():is_category("grenade_launcher")

			if data and equipped_unit and not is_grenade_launcher and (equipped_unit:base():fire_mode() == "auto" or equipped_unit:base():is_category("bow", "flamethrower")) then

				local reload_multiplier = data.max_reload_increase
				local ammo = equipped_unit:base():get_ammo_max_per_clip()
				if self:has_category_upgrade("player", "automatic_mag_increase") and equipped_unit:base():is_category("smg", "assault_rifle", "lmg") then
					ammo = ammo - self:upgrade_value("player", "automatic_mag_increase", 0)
				end
				
				local min_bullets = data.min_bullets
				if min_bullets < ammo then 
					local num_bullets = ammo - min_bullets
					for i = 1, num_bullets, 1 do
						reload_multiplier = math.max(data.min_reload_increase, reload_multiplier * data.penalty)
					end
				end
				
				NobleHUD:AddBuff("shock_and_awe_reload_multiplier",{value = string.format("%.1f",reload_multiplier)})

			end
		end
		
	end)

	Hooks:PostHook(PlayerManager,"_on_messiah_recharge_event","noblehud_buff_messiah",function(self)
		local count = self._messiah_charges
		if count > 0 then 
			NobleHUD:AddBuff("messiah_charge",{value = count})
		else
			NobleHUD:RemoveBuff("messiah_charge")
		end
	end)

	Hooks:PreHook(PlayerManager,"_on_messiah_event","noblehud_buff_messiah_event",function(self)
		if self._messiah_charges > 0 and self._current_state == "bleed_out" and not self._coroutine_mgr:is_running("get_up_messiah") then
			NobleHUD:AddBuff("messiah_ready")
		end
	end)

	Hooks:PostHook(PlayerManager,"use_messiah_charge","noblehud_buff_messiah_remove",function(self)
		NobleHUD:RemoveBuff("messiah_ready")
		local count = self._messiah_charges
		if count > 0 then 
			NobleHUD:AddBuff("messiah_charge",{value = count})
		else
			NobleHUD:RemoveBuff("messiah_charge")
		end
	end)

	Hooks:PostHook(PlayerManager,"chk_wild_kill_counter","noblehud_buff_biker",function(self,killed_unit,variant)
		local player = self:local_player()
		if not player then 
			return
		end
		if not (self:has_category_upgrade("player", "wild_health_amount") or self:has_category_upgrade("player", "wild_armor_amount")) then
			return
		end
		
	--	local max_trigger_time
		local wild_kill_triggers = self._wild_kill_triggers or {}
		local triggers_count = #wild_kill_triggers
		local triggers_left = tweak_data.upgrades.wild_max_triggers_per_time - triggers_count
		if triggers_left > 0 then 
			for i,trigger_time in pairs(wild_kill_triggers) do 
				--NobleHUD:log("Triggered wild kill counter: " .. tostring(i) .. ": " .. tostring(trigger_time),{color=Color.green})
	--			max_trigger_time = 
			end
			NobleHUD:AddBuff("wild_kill_counter",{value=triggers_left,start_t = Application:time(),end_t=wild_kill_triggers[#wild_kill_triggers]})
		end
	end)
elseif RequiredScript == "lib/units/beings/player/playermovement" then 
	Hooks:PostHook(PlayerMovement,"on_morale_boost","noblehud_buff_morale_boost",function(self,benefactor_unit) --inspire basic buff (receive)
		NobleHUD:AddBuff("morale_boost",{end_t = Application:time() + tweak_data.upgrades.morale_boost_time})
	--this gives move speed AND reload speed apparently so i'm just gonna show that you have the inspire bonus rather than clutter the HUD
	end)
elseif RequiredScript == "lib/units/beings/player/states/playerstandard" then 
	Hooks:PostHook(PlayerStandard,"_update_omniscience","noblehud_buff_sixth_sense",function(self,t,dt)
		if managers.player:has_category_upgrade("player", "standstill_omniscience") then 
			if self._state_data.omniscience_t then 
				NobleHUD:AddBuff("sixth_sense",{end_t = self._state_data.omniscience_t})
			else
				NobleHUD:RemoveBuff("sixth_sense")		
			end
	--		if managers.player:current_state() == "civilian" or self:_interacting() or self._ext_movement:has_carry_restriction() or self:is_deploying() or self:_changing_weapon() or self:_is_throwing_projectile() or self:_is_meleeing() or self:_on_zipline() or self._moving or self:running() or self:_is_reloading() or self:in_air() or self:in_steelsight() or self:is_equipping() or self:shooting() or not managers.groupai:state():whisper_mode() or not tweak_data.player.omniscience then
	--			NobleHUD:RemoveBuff("sixth_sense")
	--		elseif self._state_data.omniscience_t then
	--			NobleHUD:AddBuff("sixth_sense",{end_t = 1,persistent_timer = true})
	--		end
		end
	end)

	Hooks:PostHook(PlayerStandard,"_do_melee_damage","noblehud_buff_overdog",function(self,t, bayonet_melee, melee_hit_ray, melee_entry, hand_id)
		if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
			local state_data = self._state_data.stacking_dmg_mul or {}
			local stack = self._state_data.stacking_dmg_mul.melee or {
				nil,
				0
			}
			local dmg_multiplier = 1
			if stack[1] and t < stack[1] then
				dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
			else
	--			stack[2] = 0
			end
			if dmg_multiplier > 1 then 
				NobleHUD:AddBuff("overdog",{value = dmg_multiplier,duration = stack[2] or managers.player:upgrade_value("melee", "stacking_hit_expire_t", 1)})
			else
				NobleHUD:RemoveBuff("overdog")
			end
			
	--		Console:SetTrackerValue("trackera","overdog: " .. tostring(dmg_multiplier) .. " " .. NobleHUD.random_character())
	--		Console:SetTrackerValue("trackerb","stack1: " .. tostring(stack[1]) .. " " .. NobleHUD.random_character())
	--		Console:SetTrackerValue("trackerc","stack2: " .. tostring(stack[2]) .. " " .. NobleHUD.random_character())
		end


	end)
elseif RequiredScript == "lib/units/beings/player/states/playertased" then 
	Hooks:PostHook(PlayerTased,"enter","noblehud_buff_tased",function(self,state_data,enter_data)
		local buff_name,duration
		if state_data.non_lethal_electrocution then 
			buff_name = "electrocuted"
			duration = tweak_data.player.damage.TASED_TIME * managers.player:upgrade_value("player", "electrocution_resistance_multiplier", 1)
		else
			buff_name = "tased"
			duration = managers.modifiers:modify_value("PlayerTased:TasedTime", tweak_data.player.damage.TASED_TIME)
		end
		--or for , priority
		local color
		if managers.player:has_category_upgrade("player", "escape_taser") then 
			color = NobleHUD.color_data.solar
		elseif managers.player:has_category_upgrade("player", "taser_malfunction") then
			--todo get info from managers.player:upgrade_value("player", "taser_malfunction"); .interval, .chance_to_trigger
			color = NobleHUD.color_data.strange
		end
		NobleHUD:AddBuff(buff_name,{end_t = Application:time() + duration,text_color = color})
	end)


	Hooks:PreHook(PlayerTased,"exit","noblehud_buff_tased_remove",function(self,enter_data)
		if self._state_data.non_lethal_electrocution then 
			NobleHUD:RemoveBuff("electrocuted")
		else
			NobleHUD:RemoveBuff("tased")
		end
	end)

end
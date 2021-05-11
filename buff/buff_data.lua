do return end

KineticHUD._buff_data = {
	["vip"] = {
		source = "manual",
		priority = 1,
		icon = "guis/textures/skull_phalanx",
		text_color = KineticHUD.color_data.red,
		label = "noblehud_hud_assault_phase_phalanx",
		label_compact = "",
		value_type = "status",
		flash = true
	},
	["ecm_normal"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_2x",
		icon_rect = {3,4},
		label = "noblehud_buff_ecm_normal_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 20, -- tweak_data.upgrades.ecm_jammer_base_battery_life
		flash = false
	},
	["ecm_strong"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_booster",
		icon_rect = {6,3},
		label = "noblehud_buff_ecm_normal_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 30, --(tweak_data.upgrades.ecm_jammer_base_battery_life * 1.5)
		flash = false
	},
	["ecm_feedback"] = { --not implemented
		source = "skill",
		priority = 0,
		icon = "ecm_feedback",
		icon_rect = {1,2},
		label = "noblehud_buff_ecm_normal_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 15, --tweak_data.upgrades.ecm_feedback_min_duration 
		flash = false
	},
	["dmg_resist_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "juggernaut", --naut too sure about this icon. --drop_soap?
		label = "noblehud_buff_dmg_aggregated_label",
		value_type = "value",
		label_compact = "$VALUE%",
		flash = false
	},
	["crit_chance_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "backstab",
		label = "noblehud_buff_crit_aggregated_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = false
	},
	["dodge_chance_total"] = { --aggregated
		source = "skill",
		priority = 1,
		icon = "jail_diet", --'dance_instructor' is pistol mag bonus
		label = "noblehud_buff_dodge_aggregated_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = false
	},
	["hp_regen"] = { --aggregated, standard timed-healing from multiple sources (muscle, hostage taker, etc)
		source = "perk",
		priority = 1,
		icon = 17, --chico perk deck
		icon_tier = 3, --heart with hollow +  
		persistent_timer = true,
		label = "noblehud_buff_regen_aggregated_label",
		label_compact = "x$VALUE $TIMER",
		duration = 10,
		value_type = "timer",
		text_color = Color("FFD700"),
		flash = false
	},
	["long_dis_revive"] = {
		source = "skill",
		priority = 3,
		icon = "inspire",
		icon_rect = {4,9},
		label = "noblehud_buff_long_dis_revive_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 20,
		text_color = KineticHUD.color_data.red,
		flash = true
	},
	["morale_boost"] = {
		source = "skill",
		priority = 3,
		icon = "inspire",
		icon_rect = {4,9},
		label = "noblehud_buff_morale_boost_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 4,
		flash = false
	},
	["fully_loaded"] = { --throwable pickup chance; not implemented
		disabled = true,
		priority = 2
	},
	["dire_need"] = { --todo
		source = "skill",
		priority = 1,
		icon = "drop_soap",
		label = "noblehud_buff_dire_need",
		label_compact = "$TIMER",
		duration = 10,
		value_type = "timer",
		flash = true
	},
	["hitman"] = {
		source = "perk",
		priority = 5,
		icon = 4, --hitman perk deck
		icon_tier = 7,
--		disabled = true, --guaranteed regen from Hitman 9 Tooth and Claw; not implemented
		label = "noblehud_buff_hitman_label",
		label_compact = "$TIMER",
		persistent_timer = true,
		duration = 1.5,
		value_type = "timer",
		text_color = KineticHUD.color_data.yellow,
		flash = false
	},
	["overdog"] = {
		source = "perk",
		priority = 4,
		icon = 9,
		icon_tier = 1,
		label = "noblehud_buff_overdog",
		label_compact = "x$VALUE $TIMER",
		value_type = "timer", --10x melee damage within 1s from infiltrator 1 or Sociopath 1, Overdog; not implemented
		duration = 1,
		text_color = KineticHUD.color_data.sky_blue,
		flash = true
	},
	["tension"] = { 
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_tension",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath armorgate on kill cooldown; 3; also blending in so idk
		text_color = KineticHUD.color_data.red,
		flash = true
	},
	["clean_hit"] = { 
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_clean_hit",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath health regen on melee kill cooldown; 5/9; also blending in so idk
		text_color = KineticHUD.color_data.red,
		flash = true
	},
	["overdose"] = {
		disabled = true,
		source = "perk",
		priority = 7,
		duration = 1,
		icon = 9,
		icon_tier = 3,
		label = "noblehud_buff_overdose",
		label_compact = "$TIMER",
		value_type = "timer", --sociopath armorgate on medium range kill cooldown; 7/9; also blending in so idk
		text_color = KineticHUD.color_data.red,
		flash = true
	},
	["melee_life_leech"] = {
		source = "perk",
		priority = 3,
		duration = 10,
		icon = 8,
		icon_tier = 9,
		label = "noblehud_buff_infiltrator_life_drain",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer", --melee hit regens 20% hp, once per 10s from infiltrator 9/9 Life Drain; not implemented
		flash = false
	},
	["loose_ammo_restore_health"] = { --gambler medical supplies
		source = "perk",
		priority = 5,
		duration = 3,
		value_type = "timer", --n health on ammo pickup, once per 3s from Gambler 1/9 Medical Supplies
		icon = 10,
		icon_tier = 1,
		tier_floors = {1,7,9},
		label = "noblehud_buff_gambler_medical_supplies_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		source = "perk",
		flash = false
	},
	["loose_ammo_give_team"] = { --gambler ammo give out
		source = "perk",
		priority = 63,
		duration = 5,
		value_type = "timer", -- half normal ammo pickup to all team members once every 5 seconds from Gambler 3
		icon = 10,
		icon_tier = 3,
		icon_rect = {3,5},
		label = "noblehud_buff_gambler_ammo_give_out_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		flash = false
	},
	["grinder"] = {
		source = "perk",
		priority = 2,
		icon = 11,
		icon_tier = 1, --overridden by tier_floors
		tier_floors = {1,3,5,7,9},
		icon_rect = {6,1},
		label = "noblehud_buff_grinder_label",
		label_compact = "x$VALUE",
		value_type = "value",
		flash = false
	},
	["yakuza"] = {
		source = "perk",
		priority = 2,
		disabled = false,
		icon = 12,
		icon_tier = 3,
		label = "noblehud_buff_yakuza_label",
		label_compact = "x$VALUE",
		value_type = "value", --armor recovery rate, like berserker
		flash = false
	},
	["expresident"] = {
		source = "perk",
		priority = 2,
		disabled = false,
		icon = 13, --ex-president perk deck
		icon_tier = 1,
		text_color = KineticHUD.color_data.sky_blue,
		label = "noblehud_buff_expresident_label",
		label_compact = "$VALUE%",
		value_type = "value", --stored health
		flash = true
	},
	["hysteria"] = {
		source = "perk",
		priority = 2,
		icon = 14,
		icon_rect = {1,7},
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_maniac_label",
		label_compact = "x$VALUE",
		value_type = "value",
		flash = true
	},
	["anarchist_armor_regen"] = {
		source = "perk",
		priority = 1,
		icon = 15,
		icon_tier = 1,
		label = "noblehud_buff_anarchist_label",
		label_compact = "$TIMER",
		persistent_timer = true,
		text_color = KineticHUD.color_data.yellow,
		value_type = "timer",
		flash = false
	},
	["anarchist_lust_for_life"] = {
		disabled = true,
		source = "perk",
		priority = 4,
		icon = 15,
		icon_tier = 9,
		duration = 1.5,
		label = "noblehud_buff_anarchist_lust_for_life_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		flash = true
	},
	["armor_break_invulnerable"] = {
		source = "perk",
		priority = 3,
		icon = 15,
		icon_tier = 1,
		label = "noblehud_buff_armor_break_invulnerable_active_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,--red for 15s cooldown; blue for 2s invuln period
		value_type = "timer",
		flash = false
	},
	["wild_kill_counter"] = {
		source = "perk",
		priority = 1,
		icon = 16,
		icon_tier = 1,
		label = "noblehud_buff_biker_label",
		label_compact = "$TIMER",
		value_type = "timer",
		text_color = KineticHUD.color_data.yellow,
		icon_color = KineticHUD.color_data.green,
		persistent_timer = true,
--		render_template = "VertexColorTexturedRadialFlex",
		flash = true
	},
	["chico_injector"] = {
		source = "perk",
		priority = 3,
		icon = 17,--"chico_injector",
		icon_tier = 1,
		label = "noblehud_buff_kingpin_label",
		label_compact = "$TIMER",
		icon_color = KineticHUD.color_data.yellow,
		value_type = "timer",
		flash = true
	},
	["sicario"] = {
		source = "perk",
		priority = 3,
		icon = 18,
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_sicario_label",
		label_compact = "",
		text_color = KineticHUD.color_data.yellow,
		value_type = "timer",
		flash = true
	},
	["delayed_damage"] = {
		source = "perk",
		priority = 3,
		icon = 19,
		tier_floors = {1,9},
		icon_tier = 1,
		label = "noblehud_buff_delayed_damage_label",
		label_compact = "x$VALUE $TIMER",
		value_type = "value",
		flash = true
		--health counter
	},
	["tag_team"] = {
		source = "perk",
		priority = 3,
		icon = 20,
		icon_tier = 1,
		label = "noblehud_buff_tag_team_label",
		label_compact = "$TIMER",
		value_type = "timer", --is being tagged; tag team duration
		priority = 3
	},
	["pocket_ecm_jammer"] = {
		source = "perk",
		priority = 5,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 1,
		label = "noblehud_buff_hacker_ecm_label",
		label_compact = "$TIMER",
		icon_color = KineticHUD.color_data.yellow,
		value_type = "timer",
		flash = true
	},
	["pocket_ecm_jammer_feedback"] = {
		source = "perk",
		priority = 5,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 1,
		label = "noblehud_buff_hacker_feedback_label",
		label_compact = "$TIMER",
		icon_color = KineticHUD.color_data.yellow,
		value_type = "timer",
		flash = true
	},
	["pocket_ecm_kill_dodge"] = {
		source = "perk",
		priority = 3,
		icon = 21,--"pocket_ecm_jammer",
		icon_tier = 7,
		label = "noblehud_buff_hacker_kluge_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["flashbang"] = {
		source = "icon", --where to get icon (not directly related to where ingame buff came from)
		priority = 7,
		icon = "concussion_grenade", --if no source is specified, use this icon tweak data
--		icon_rect = {1,7}, --if source is "manual" then use "icon" as path and "icon_rect" to find bitmap
		label = "noblehud_buff_flashbang_label", --display name
		label_compact = "$TIMER",
		text_color = Color.black:with_alpha(0.3),
		icon_color = KineticHUD.color_data.red,
		value_type = "timer", --value calculation type
		flash = true --alpha sine flash if true
	},
	["downed"] = { --i think people will probably figure out that they've been downed, actually. unless they're flashbanged.
		source = "icon",
		priority = 3,
		disabled = true,
		icon = "mugshot_downed",
		icon_rect = {240,464,48,48},
		label = "downed",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		duration = 30,
		flash = false
	},
	["tased"] = {
		source = "icon",
		priority = 3,
		icon = "mugshot_electrified",--skill icon "insulation",
		label = "noblehud_buff_tased_label",
		label_compact = "$TIMER",
		icon_color = Color.white,
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		flash = true
	},
	["electrocuted"] = {
		source = "icon",
		priority = 3,
		icon = "mugshot_electrified",
		label = "noblehud_buff_electrocuted_label",
		label_compact = "$TIMER",
		icon_color = Color.yellow,
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		flash = true
	},
	["swan_song"] = {
		source = "skill",
		priority = 3,
		icon = "perseverance",
		duration = 3, --6 aced
		label = "noblehud_buff_swan_song_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.tf2_strange,
		value_type = "timer",
		flash = true
	},
	["messiah_charge"] = {
		source = "skill",
		priority = 2,
		icon = "messiah",
		text_color = KineticHUD.color_data.yellow,
		label = "noblehud_buff_messiah_charge_label",
		label_compact = "x$VALUE",
		value_type = "value", --just in case multiple messiah charges is ever implemented, or modded in
		flash = false
	},
	["messiah_ready"] = {
		source = "skill",
		priority = 1,
		icon = "messiah",
		icon_color = KineticHUD.color_data.sky_blue,
		text_color = KineticHUD.color_data.sky_blue,
		label = "noblehud_buff_messiah_ready_label",
		label_compact = "RDY", --!
		value_type = "status",
		flash = true
	},
	["bullseye"] = { --DONE
		source = "skill",
		priority = 5,
		icon = "prison_wife",
		icon_rect = {6,11},
		label = "noblehud_buff_bullseye_label",
		label_compact = "$TIMER",
		value_type = "timer",
		text_color = KineticHUD.color_data.red,
		duration = 2.5,
		flash = true
	},
	["uppers_aced_cooldown"] = {
		source = "skill",
		priority = 2,
		icon = "tea_cookies",
		label = "noblehud_buff_uppers_cooldown_label",
		label_compact = "$TIMER",
		text_color = KineticHUD.color_data.red,
		value_type = "timer",
		flash = false
	},
	["uppers_ready"] = {
		source = "skill",
		priority = 2,
		icon = "tea_cookies",
		label = "noblehud_buff_uppers_ready_label",
		label_compact = "RDY", --!
		text_color = KineticHUD.color_data.yellow,
		value_type = "status",
		flash = false
	},
	["berserker_damage_multiplier"] = {
		source = "skill",
		priority = 2,
		icon = "wolverine",
		label = "noblehud_buff_berserker_aced_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = true
	},
	["berserker_melee_damage_multiplier"] = {
		source = "skill",
		priority = 2,
		icon = "wolverine",
		label = "noblehud_buff_berserker_label",
		label_compact = "$VALUE%",
		value_type = "value",
		flash = true
	},
	["bullet_storm"] = {
		source = "skill",
		priority = 3,
		icon = "ammo_reservoir",
		icon_rect = {0,3},
		label = "noblehud_buff_bulletstorm_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false	
	},
	["unseen_strike"] = { --DONE
		source = "skill",
		priority = 3,
		icon = "unseen_strike",
		label = "noblehud_buff_unseen_strike_label",
		label_compact = "$TIMER",
		duration = 18, --debug purposes only; t is passed
		value_type = "timer",
		flash = false
	},
	["overkill_damage_multiplier"] = {
		source = "skill",
		priority = 3,
		icon = "overkill",
		label = "noblehud_buff_overkill_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["bloodthirst_melee"] = {
		source = "skill",
		priority = 3,
		disabled = false,
		icon = "bloodthirst", --assassin?
		label = "noblehud_buff_bloodthirst_melee_label",
		label_compact = "x$VALUE",
		value_type = "value", --not sure
		flash = false
	},
	["bloodthirst_reload_speed"] = {
		source = "skill",
		priority = 4,
		icon = "bloodthirst",
		icon_rect = {1,7},
		label = "noblehud_buff_bloodthirst_reload_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 10,
		flash = false	
	},
	["team_damage_speed_multiplier_received"] = {
		source = "skill",
		priority = 5,
		icon = "scavenger",
		icon_rect = {10,9},
		label = "noblehud_buff_second_wind_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["damage_speed_multiplier"] = {
		source = "skill",
		priority = 5,
		icon = "scavenger",
		icon_rect = {10,9},
		label = "noblehud_buff_second_wind_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["sixth_sense"] = {
		source = "skill",
		priority = 7,
		icon = "chameleon",
		label = "noblehud_buff_sixth_sense_label",
		label_compact = "$TIMER",
		value_type = "timer",
		persistent_timer = true,
--		timer_source = "player",
		flash = false
	},
	["revive_damage_reduction"] = { --combat medic
		source = "skill",
		priority = 5,
		icon = "combat_medic",
		icon_rect = {5,7},
		label = "noblehud_buff_combat_medic_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 5,
		flash = false
	},
	["trigger_happy"] = {
		source = "skill",
		priority = 3,
		icon = "trigger_happy",
		label = "noblehud_buff_trigger_happy_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 2, --4 aced
		flash = false
	},
	["desperado"] = {
		source = "skill",
		priority = 3,
		icon = "expert_handling",
		label = "noblehud_buff_desperado_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 10,
		flash = false
	},
	["partners_in_crime"] = {
		source = "skill",
		priority = 3,
		icon = "control_freak",
		label = "noblehud_buff_partners_in_crime_label",
		label_compact = "",
		value_type = "status", --move speed from hostage
		flash = false
	},
	["partners_in_crime_aced"] = {
		source = "skill",
		priority = 3,
		disabled = true, --same proc conditions as basic
		icon = "control_freak",
		label = "noblehud_buff_partners_in_crime_aced_label",
		label_compact = "",
		value_type = "status", --hp boost from hostage
		flash = false,
	},
	["single_shot_fast_reload"] = {
		source = "skill",
		priority = 5,
		icon = "speedy_reload",
		label = "noblehud_buff_aggressive_reload_label",
		label_compact = "$TIMER",
		value_type = "timer",
		duration = 4,
		flash = false
	},
	["shock_and_awe_reload_multiplier"] = {
		source = "skill",
		priority = 5,
		icon = "shock_and_awe",
		label = "noblehud_buff_lock_n_load_label",
		label_compact = "x$VALUE",
		value_type = "value", --auto multikills reload speed from skilltree "lock n load"
		flash = false
	},
	["dmg_multiplier_outnumbered"] = { --underdog dmg boost; DONE
		source = "skill",
		priority = 7,
		icon = "underdog",
		label = "noblehud_buff_underdog_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["dmg_dampener_outnumbered"] = { --underdog dmg resist; DONE
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "noblehud_buff_underdog_aced_label",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["dmg_dampener_close_contact"] = { --dmg resist; activates in conjuction with underdog but lasts 5 seconds??? ovk y u do dis
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "dmg_dampener_close_contact",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},	
	["dmg_dampener_outnumbered_strong"] = { --same as above, but aced
		source = "skill",
		priority = 7,
		disabled = true,
		icon = "underdog",
		label = "dmg_dampener_outnumbered_strong",
		label_compact = "$TIMER",
		value_type = "timer",
		flash = false
	},
	["combat_medic_damage_multiplier"] = {
		priority = 5,
		disabled = true
	},
	["combat_medic_enter_steelsight_speed_multiplier"] = {
		priority = 5,
		disabled = true
	},
	["stockholm_ready"] = {
		disabled = true,
		priority = 2,
		value_type = "status"
	},
	["first_aid_damage_reduction"] = { --120s 10% damage reduction from using fak/docbag
		source = "skill",
		priority = 3,
		icon = "tea_time",
		icon_rect = {1,11},
		label = "noblehud_buff_quick_fix_label",
		value_type = "timer",
		label_compact = "$TIMER",
		flash = false
	},
	["reload_weapon_faster"] = { --running from death basic, part 1
		source = "skill",
		priority = 3,
		icon = "running_from_death", --or speedy_reload
		label = "noblehud_buff_running_from_death_reload_label",
		value_type = "timer", --reload + swap faster after revive
		label_compact = "$TIMER",
		duration = 10,
		flash = true	
	},
	["swap_weapon_faster"] = { --running from death basic, part 2; disabled due to identical proc conditions + duration
		disabled = true,
		source = "skill",
		priority = 3,
		icon = "speedy_reload",
		label = "noblehud_buff_running_from_death_swap_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	},
	["increased_movement_speed"] = { --running from death aced; disabled due to identical proc conditions + duration
		disabled = true,
		source = "skill",
		priority = 3,
		icon = "running_from_death",
		label = "noblehud_buff_running_from_death_aced_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	},
	["revived_damage_resist"] = { --up you go basic
		source = "skill",
		priority = 3,
		icon = "up_you_go",
		icon_rect = {11,4},
		label = "noblehud_buff_up_you_go_label",
		value_type = "timer",
		label_compact = "$TIMER",
		duration = 10,
		flash = true
	}
}

--todo addbuff/removebuff functions
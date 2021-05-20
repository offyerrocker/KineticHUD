local buff_data = {
--skills

	--mastermind
	combat_medic_interaction = {
		icon_id = "combat_medic",
		source = "skill",
--		text = "khud_buff_combat_medic_reviving",
		value_format = "x%.2f"
	},
	combat_medic_success = {
		icon_id = "combat_medic",
		source = "skill",
--		text = "khud_buff_combat_medic_revived",
		value_format = "x%.2f"
	},
	quick_fix = {
		icon_id = "tea_time",
		source = "skill",
--		text = "khud_buff_quick_fix",
		value_format = nil
	},
	pain_killer = {
		icon_id = "pain_killer",
		source = "skill",
--		text = "khud_buff_painkillers",
		value_format = nil
	},
	inspire = {
		icon_id = "inspire",
		source = "skill",
--		text = "khud_buff_inspire_basic",
		value_format = nil
	},
	inspire_debuff = {
		icon_id = "inspire",
		source = "skill",
--		text = "khud_buff_inspire_basic_cooldown",
		text_color_id = "light_red",
		value_format = nil
	},
	inspire_revive_debuff = {
		icon_id = "inspire",
		aced = true,
		source = "skill",
--		text = "khud_buff_inspire_aced_cooldown",
		text_color_id = "light_red",
		value_format = ""
	},
	forced_friendship = {
		disabled = true,
		icon_id = "triathlete",
		source = "skill",
--		text = "khud_buff_forced_friendship",
		value_format = nil
	},
	partner_in_crime = {
		icon_id = "control_freak",
		source = "skill",
--		text = "khud_buff_partners_in_crime",
		value_format = nil
	},
	partner_in_crime_aced = {
		icon_id = "control_freak",
		aced = true,
		source = "skill",
--		text = "khud_buff_partners_in_crime_aced",
		value_format = nil
	},
	hostage_taker = {
		icon_id = "hostage_taker",
		source = "skill",
--		text = "khud_buff_hostage_taker",
		value_format = nil
	},
	ammo_efficiency = { --doesn't appear to work
		icon_id = "ammo_efficiency",
		source = "skill",
--		text = "khud_buff_ammo_efficiency",
		value_format = nil
	},
	aggressive_reload_aced = {
		icon_id = "speedy_reload",
		aced = true,
		source = "skill",
--		text = "khud_buff_aggressive_reload",
		value_format = "x%i"
	},
	
	--enforcer
	underdog = {
		icon_id = "underdog",
		source = "skill",
--		text = "khud_buff_underdog",
		value_format = "x%.2f"
	},
	underdog_aced = {
		disabled = true,
		icon_id = "underdog",
		aced = true,
		source = "skill",
--		text = "khud_buff_underdog_aced",
		value_format = "x%.2f"
	},
	overkill = {
		icon_id = "overkill",
		source = "skill",
--		text = "khud_buff_label_overkill",
		value_format = "x%.2f"
	},
	overkill_aced = { --doesn't appear to work. shouldn't matter since it has identical proc conditions to basic anyway
		disabled = false,
		icon_id = "overkill",
		aced = true,
		source = "skill",
--		text = "khud_buff_label_overkill_aced",
		value_format = "x%.2f"
	},
	die_hard = {
		icon_id = "show_of_force",
		source = "skill",
		value_format = "x%.1f"
	},
	bullseye_debuff = {
		icon_id = "prison_wife",
		source = "skill",
--		text = "khud_buff_bullseye",
		text_color_id = "light_red",
		value_format = nil
	},
		--scavenger 6th kill ammobox killcount?
	bullet_storm = {
		icon_id = "ammo_reservoir",
		source = "skill",
		text = "khud_buff_label_maniac",
		value_format = ""
	},
		--fully loaded aced kills to grenade?
	
	--technician
	lock_n_load = {
		icon_id = "shock_and_awe",
		source = "skill",
--		text = "khud_buff_label_lock_n_load",
		value_format = "x%.1f"
	},
	
	--ghost
	sixth_sense = {
		icon_id = "chameleon",
		source = "skill",
--		text = "khud_buff_label_sixth_sense",
		value_format = nil
	},
	dire_need = {
		icon_id = "dire_need",
		source = "skill",
--		text = "khud_buff_label_dire_need",
		value_format = nil
	},
		--shockproof stun window timer?
	second_wind = {
		icon_id = "scavenger",
		source = "skill",
--		text = "khud_buff_label_second_wind",
		value_format = "x%.1f"
	},
	unseen_strike = {
		icon_id = "unseen_strike",
		source = "skill",
--		text = "khud_buff_label_unseen_strike",
		value_format = "x%.2f"
	},
	unseen_strike_debuff = {
		icon_id = "unseen_strike",
		source = "skill",
		text = "khud_buff_label_unseen_strike_cooldown",
		text_color_id = "light_red",
		value_format = ""
	},
	
	--fugitive
	desperado = {
		icon_id = "expert_handling",
		source = "skill",
--		text = "khud_buff_label_desperado",
		value_format = "x%0.2f"
	},
	trigger_happy = {
		icon_id = "trigger_happy",
		source = "skill",
--		text = "khud_buff_label_trigger_happy",
		value_format = "x%0.2f"
	},
	running_from_death_reload_speed = {
		icon_id = "running_from_death",
		source = "skill",
		text = "khud_buff_label_running_from_death_reload",
		value_format = "x%.1f"
	},
	
	running_from_death_swap_speed = {
		disabled = true, --todo change this to disabled by default in settings
		icon_id = "running_from_death",
		source = "skill",
		text = "khud_buff_label_running_from_death_swap",
		value_format = "x%.1f"
	},
	
	running_from_death_move_speed = {
		disabled = true, --todo change this to disabled by default in settings
		icon_id = "running_from_death",
		aced = true,
		source = "skill",
		text = "khud_buff_label_running_from_death_move",
		value_format = "x%.1f"
	},
	up_you_go = {
		icon_id = "up_you_go",
		source = "skill",
--		text = "khud_buff_label_up_you_go",
		value_format = "x%.1f"
	},
	swan_song = {
		icon_id = "perseverance",
		source = "skill",
--		text = "khud_buff_label_swan_song",
		value_format = ""
	},
	swan_song_aced = {
		icon_id = "perseverance",
		aced = true,
		source = "skill",
--		text = "khud_buff_label_swan_song_aced",
		value_format = ""
	},
	messiah = {
		icon_id = "",
		source = "skill",
--		text = "khud_buff_label_messiah",
		value_format = nil
	},
	--messiah ready
	--messiah charge present
		--combine both messiah buffs into one?
	bloodthirst_basic = {
		icon_id = "bloodthirst",
		source = "skill",
--		text = "khud_buff_label_bloodthirst_basic",
		value_format = "x%i"
	},
	bloodthirst_aced = {
		icon_id = "bloodthirst",
		aced = true,
		source = "skill",
--		text = "khud_buff_label_bloodthirst_aced",
		value_format = "x%.1f"
	},
	berserker = {
		icon_id = "wolverine",
		source = "skill",
--		text = "khud_buff_label_berserker_basic",
		value_format = "x%.1f"
	},
	berserker_aced = {
		icon_id = "wolverine",
		aced = true,
		source = "skill",
--		text = "khud_buff_label_berserker_aced",
		value_format = "x%.1f"
	},
	
	
--perkdecks

--[[--crew chief
	cc_passive_health_multiplier = {
	
	},
	cc_hostage_health_multiplier = {
	
	},
	cc_passive_stamina_multiplier = {
	
	},
	cc_hostage_stamina_multiplier = {
	
	},
	cc_passive_damage_reduction = {
	
	},
	cc_hostage_damage_reduction = {
	
	},
	--]]
	grinder = { --does not seem to show number of stacks
		icon_id = 11,
		source = "perk",
		tier_floors = {1,3,5,7,9},
--		text = "khud_buff_label_grinder",
		value_format = nil
	},
	grinder_debuff = {
		icon_id = 11,
		source = "perk",
		tier_floors = {1,3,5,7,9},
--		text = "khud_buff_label_grinder_cooldown",
		text_color_id = "light_red",
		value_format = nil
	},
	maniac = {
		icon_id = 14,
		source = "perk",
		icon_tier = 1,
		tier_floors = {1,9},
--		text = "khud_buff_label_maniac",
		value_format = "x%i"
	}

	
--general
	--flashbang duration?
	--ecm duration (normal, feedback, cooldown)
	--cam looping duration
}
if deathvox and deathvox:IsTotalCrackdownEnabled() then 
	--add TCD-specific/changed skills here
end

local unverified_buff_data = {
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
	["fully_loaded"] = { --throwable pickup chance; not implemented
		disabled = true,
		priority = 2
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
	}
}

return buff_data
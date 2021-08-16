

KineticHUD = KineticHUD or {}
KineticHUD._mod_path = KineticHUD:GetPath()
KineticHUD._settings_save_path = SavePath .. "KineticHUD_2_settings.txt"
KineticHUD._layout_save_path = SavePath .. "KineticHUD_2_layout.txt"
KineticHUD._menu_path = KineticHUD._mod_path .. "menu/"
KineticHUD._updater_id_check_player = "khud_update_check_player"

KineticHUD.MOUSE_ID = "khud_mouse_chat"

dofile(KineticHUD._mod_path .. "lua/utils/QuickAnimate.lua")

KineticHUD.url = {
	colorpicker = "https://modwork.shop/29641"
}
KineticHUD.special_characters = {
	skull = ""
}

KineticHUD.color_data = {
	white = Color("ffffff"),
	black = Color("000000"),
	grey = Color("888888"),
	gray = Color("888888"),
	red = Color("ff0000"),
	light_red = Color("ff8080"), --not pink. completely different color
	orange = Color("ffbd80"),
	gold = Color("ffd080"),
	yellow = Color("fffb80"),
	light_green = Color("80ff82"),
	green = Color("00ff00"),
	teal = Color("80ffbb"),
	cyan = Color("80ffea"),
	sky_blue = Color("80e3ff"),
	blue = Color("809cff"),
	purple = Color("8080ff"),
	violet = Color("aa80ff"),
	magenta = Color("ff80ea"),
	
	tf2_strange = Color("ffd700")
}

KineticHUD._fonts = {
	tommy_bold = "fonts/made_tommy_xb", --custom; 48
	syke = "fonts/syke", --custom; 24(?)
	digital = "fonts/font_digital", --vanilla
	large = "fonts/font_large_mf", --vanilla
}

KineticHUD.hud_panel_locations = {
	"khud_panel_left_title",
	"khud_panel_right_title",
	"khud_panel_top_title",
	"khud_panel_bottom_title"
}

KineticHUD.menu_divider_sizes = {
	xsmall = 4,
	small = 8,
	medium = 16,
	large = 32,
	xlarge = 48,
	yourmom = 64
}

Hooks:Register("khud_on_load_buff_data")

--one menu to rule them all
--all menus are, to some degree, sub-menus of this one
KineticHUD._menu_id_main = "khud_menu_main"
---once menus are populated, add them to this queue
--they are then built, and should be usable in-game
KineticHUD._populated_menus = {}

--registers submenus for menu objects
KineticHUD._queued_add_menus = {} 

--holds ordered data to generate menus;
--mainly done to allow dynamic menu option insertion and also to avoid using json menus 
KineticHUD._menu_ids = {
	{
		type = "menu",
		id = "khud_menu_layouts",
		title = "khud_menu_layouts_title",
		desc = "khud_menu_layouts_desc",
		children = {
			{ --player/team	
				type = "menu",
				id = "khud_menu_layouts_criminals",
				title = "khud_menu_layouts_criminals_title",
				desc = "khud_menu_layouts_criminals_desc",
				area_bg = "none",
				children = {
					{ --player layouts
						type = "menu",
						id = "khud_menu_layouts_player",
						title = "khud_menu_layouts_player_title",
						desc = "khud_menu_layouts_player_desc",
						area_bg = "none",
						children = {
							{--vitals layout customization here
								type = "menu",
								id = "khud_menu_layouts_player_vitals",
								title = "khud_menu_layouts_player_vitals_title",
								desc = "khud_menu_layouts_player_vitals_desc",
								area_bg = "none",
								children = {
									{
										type = "multiple_choice",
										id = "khud_player_vitals_panel_set_location",
										title = "khud_menu_layouts_generic_location_title",
										desc = "khud_menu_layouts_generic_location_desc",
										items = table.deep_map_copy(KineticHUD.hud_panel_locations),
										callback = "callback_khud_player_vitals_panel_set_location",
										settings_source = "layout",
										value = "player_vitals_panel_location"
									},
									{
										type = "divider",
										id = "khud_menu_layouts_player_vitals_div_1",
										size = KineticHUD.menu_divider_sizes.medium
									},
									{--health customization here
										type = "menu",
										id = "khud_menu_layouts_player_vitals_health",
										title = "khud_menu_layouts_player_vitals_health_title",
										desc = "khud_menu_layouts_player_vitals_health_desc",
										area_bg = "none",
										children = {
										}
									},
									{
										type = "menu",--armor customization here
										id = "khud_menu_layouts_player_vitals_armor",
										title = "khud_menu_layouts_player_vitals_armor_title",
										desc = "khud_menu_layouts_player_vitals_armor_desc",
										area_bg = "none",
										children = {
										}
									}
									
								}
							},
							{
								type = "menu",
								id = "khud_menu_layouts_player_weapons",
								title = "khud_menu_layouts_player_weapons_title",
								desc = "khud_menu_layouts_player_weapons_desc",
								area_bg = "none",
								children = {
									{
										type = "multiple_choice",
										id = "khud_player_weapons_panel_set_location",
										title = "khud_menu_layouts_generic_location_title",
										desc = "khud_menu_layouts_generic_location_desc",
										items = table.deep_map_copy(KineticHUD.hud_panel_locations),
										callback = "callback_khud_player_weapons_panel_set_location",
										settings_source = "layout",
										value = "player_weapons_panel_location"
									},
									{
										type = "divider",
										id = "khud_menu_layouts_player_weapons_div_1",
										size = KineticHUD.menu_divider_sizes.medium
									},
									{		
										type = "slider",
										id = "khud_player_weapons_panel_set_x",
										title = "khud_player_weapons_panel_set_x_title",
										description = "khud_player_weapons_panel_set_x_desc",
										callback = "callback_khud_player_weapons_panel_set_x",
										settings_source = "layout",
										show_value = true,
										value = "player_weapons_panel_x",
										default_value = 750,
										min = 0,
										max = 1024,
										step = 1
									},
									{
										type = "slider",
										id = "khud_player_weapons_panel_set_y",
										title = "khud_player_weapons_panel_set_y_title",
										description = "khud_player_weapons_panel_set_y_desc",
										callback = "callback_khud_player_weapons_panel_set_y",
										settings_source = "layout",
										show_value = true,
										value = "player_weapons_panel_y",
										default_value = 1,
										min = 0,
										max = 1024,
										step = 1
									},
									{
										type = "slider",
										id = "khud_player_weapons_panel_set_scale",
										title = "khud_player_weapons_panel_set_scale_title",
										desc = "khud_player_weapons_panel_set_scale_title",
										callback = "callback_khud_player_weapons_panel_set_scale",
										settings_source = "layout",
										show_value = true,
										value = "player_weapons_panel_scale",
										default_value = 1,
										min = 0,
										max = 3,
										step = 0.1
									}
								}
							},
							{
								type = "menu",
								id = "khud_menu_layouts_player_equipment_all",
								title = "khud_menu_layouts_player_equipment_all_title",
								desc = "khud_menu_layouts_player_equipment_all_desc",
								area_bg = "none",
								children = {
									{
										type = "menu",
										id = "khud_menu_layouts_player_equipment",
										title = "khud_menu_layouts_player_equipment_title",
										desc = "khud_menu_layouts_player_equipment_desc",
										area_bg = "none",
										children = {
											{
												type = "multiple_choice",
												id = "khud_player_equipment_panel_set_location",
												title = "khud_menu_layouts_generic_location_title",
												desc = "khud_menu_layouts_generic_location_desc",
												items = table.deep_map_copy(KineticHUD.hud_panel_locations),
												callback = "callback_khud_player_equipment_panel_set_location",
												settings_source = "layout",
												value = "player_equipment_panel_location"
											},
											{
												type = "divider",
												id = "khud_menu_layouts_player_equipment_div_1",
												size = KineticHUD.menu_divider_sizes.medium
											},
											{		
												type = "slider",
												id = "khud_player_equipment_panel_set_x",
												title = "khud_menu_layouts_generic_x_title",
												description = "khud_menu_layouts_generic_x_desc",
												callback = "callback_khud_player_equipment_panel_set_x",
												settings_source = "layout",
												show_value = true,
												value = "PLAYER_EQUIPMENT_X",
												default_value = 750,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_equipment_panel_set_y",
												title = "khud_menu_layouts_generic_y_title",
												description = "khud_menu_layouts_generic_y_desc",
												callback = "callback_khud_player_equipment_panel_set_y",
												settings_source = "layout",
												show_value = true,
												value = "PLAYER_EQUIPMENT_Y",
												default_value = 1,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_equipment_panel_set_scale",
												title = "khud_menu_layouts_generic_scale_title",
												desc = "khud_menu_layouts_generic_scale_desc",
												callback = "callback_khud_player_equipment_panel_set_scale",
												settings_source = "layout",
												show_value = true,
												value = "player_equipment_panel_scale",
												default_value = 1,
												min = 0,
												max = 3,
												step = 0.1
											}
										}
									},
									{
										type = "menu",
										id = "khud_menu_layouts_player_mission_equipment",
										title = "khud_menu_layouts_player_mission_equipment_title",
										desc = "khud_menu_layouts_player_mission_equipment_desc",
										area_bg = "none",
										children = {
											{
												type = "multiple_choice",
												id = "khud_player_mission_equipment_panel_set_location",
												title = "khud_menu_layouts_generic_location_title",
												desc = "khud_menu_layouts_generic_location_desc",
												items = table.deep_map_copy(KineticHUD.hud_panel_locations),
												callback = "callback_khud_player_mission_equipment_panel_set_location",
												settings_source = "layout",
												value = "player_mission_equipment_panel_location"
											},
											{
												type = "divider",
												id = "khud_menu_layouts_player_mission_equipment_div_1",
												size = KineticHUD.menu_divider_sizes.medium
											},
											{		
												type = "slider",
												id = "khud_player_mission_equipment_panel_set_x",
												title = "khud_menu_layouts_generic_x_title",
												description = "khud_menu_layouts_generic_x_desc",
												callback = "callback_khud_player_mission_equipment_panel_set_x",
												settings_source = "layout",
												show_value = true,
												value = "PLAYER_MISSION_EQUIPMENT_X",
												default_value = 750,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_mission_equipment_panel_set_y",
												title = "khud_menu_layouts_generic_y_title",
												description = "khud_menu_layouts_generic_y_desc",
												callback = "callback_khud_player_mission_equipment_panel_set_y",
												settings_source = "layout",
												show_value = true,
												value = "PLAYER_MISSION_EQUIPMENT_Y",
												default_value = 1,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_mission_equipment_panel_set_scale",
												title = "khud_menu_layouts_generic_scale_title",
												desc = "khud_menu_layouts_generic_scale_desc",
												callback = "callback_khud_player_mission_equipment_panel_set_scale",
												settings_source = "layout",
												show_value = true,
												value = "player_mission_equipment_panel_scale",
												default_value = 1,
												min = 0,
												max = 3,
												step = 0.1
											}
										}
									},
									{
										type = "menu",
										id = "khud_menu_layouts_player_carry",
										title = "khud_menu_layouts_player_carry_title",
										desc = "khud_menu_layouts_player_carry_desc",
										area_bg = "none",
										children = {
											{
												type = "multiple_choice",
												id = "khud_player_carry_panel_set_location",
												title = "khud_menu_layouts_generic_location_title",
												desc = "khud_menu_layouts_generic_location_desc",
												items = table.deep_map_copy(KineticHUD.hud_panel_locations),
												callback = "callback_khud_player_carry_panel_set_location",
												settings_source = "layout",
												value = "player_carry_panel_location"
											},
											{
												type = "divider",
												id = "khud_menu_layouts_player_carry_div_1",
												size = KineticHUD.menu_divider_sizes.medium
											},
											{		
												type = "slider",
												id = "khud_player_carry_panel_set_x",
												title = "khud_menu_layouts_generic_x_title",
												description = "khud_menu_layouts_generic_x_desc",
												callback = "callback_khud_player_carry_panel_set_x",
												settings_source = "layout",
												show_value = true,
												value = "CARRY_X",
												default_value = 750,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_carry_panel_set_y",
												title = "khud_menu_layouts_generic_y_title",
												description = "khud_menu_layouts_generic_y_desc",
												callback = "callback_khud_player_carry_panel_set_y",
												settings_source = "layout",
												show_value = true,
												value = "CARRY_Y",
												default_value = 1,
												min = 0,
												max = 1024,
												step = 1
											},
											{
												type = "slider",
												id = "khud_player_carry_panel_set_scale",
												title = "khud_menu_layouts_generic_scale_title",
												desc = "khud_menu_layouts_generic_scale_desc",
												callback = "callback_khud_player_carry_panel_set_scale",
												settings_source = "layout",
												show_value = true,
												value = "player_carry_panel_scale",
												default_value = 1,
												min = 0,
												max = 3,
												step = 0.1
											}
										}
									}
								}
							}
						}
					},
					{ --teammate layouts
						type = "menu",
						id = "khud_menu_layouts_teammates",
						title = "khud_menu_layouts_teammates_title",
						desc = "khud_menu_layouts_teammates_desc",
						area_bg = "none",
						children = {
							{
								type = "multiple_choice",
								id = "khud_teammates_panel_set_location",
								title = "khud_menu_layouts_generic_location_title",
								desc = "khud_menu_layouts_generic_location_desc",
								items = table.deep_map_copy(KineticHUD.hud_panel_locations),
								callback = "callback_khud_teammates_panel_set_location",
								settings_source = "layout",
								value = "teammates_panel_location"
							},
							{
								type = "slider",
								id = "khud_teammates_panel_set_x",
								title = "khud_menu_layouts_generic_x_title",
								desc = "khud_menu_layouts_generic_x_desc",
								callback = "callback_khud_teammates_panel_set_x",
								settings_source = "layout",
								value = "teammates_panel_x",
								min = -1280,
								max = 1280,
								step = 1,
								show_value = true
							},
							{
								type = "slider",
								id = "khud_teammates_panel_set_y",
								title = "khud_menu_layouts_generic_y_title",
								desc = "khud_menu_layouts_generic_y_desc",
								callback = "callback_khud_teammates_panel_set_y",
								settings_source = "layout",
								value = "teammates_panel_y",
								min = -720,
								max = 720,
								step = 1,
								show_value = true
							},
							{
								type = "slider",
								id = "khud_teammates_panel_set_scale",
								title = "khud_menu_layouts_generic_scale_title",
								desc = "khud_menu_layouts_generic_scale_desc",
								callback = "callback_khud_teammates_panel_set_scale",
								settings_source = "layout",
								value = "teammates_panel_scale",
								min = 0.01,
								max = 5,
								step = 0.1,
								show_value = true
							},
							{
								type = "divider",
								id = "khud_menu_layouts_teammates_panel_div_1",
								size = KineticHUD.menu_divider_sizes.medium
							}
						}
					}
				}
			},
			{ --objectives
				type = "menu",
				id = "khud_menu_layouts_objectives",
				title = "khud_menu_layouts_objectives_title",
				desc = "khud_menu_layouts_objectives_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_objective_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_objective_panel_set_location",
						settings_source = "layout",
						value = "objective_panel_location"
					},
					{
						type = "slider",
						id = "khud_objective_panel_set_x",
						title = "khud_menu_layouts_generic_x_title",
						desc = "khud_menu_layouts_generic_x_desc",
						callback = "callback_khud_objective_panel_set_x",
						settings_source = "layout",
						value = "OBJECTIVE_X",
						min = -1280,
						max = 1280,
						step = 1,
						show_value = true
					},
					{
						type = "slider",
						id = "khud_objective_panel_set_y",
						title = "khud_menu_layouts_generic_y_title",
						desc = "khud_menu_layouts_generic_y_desc",
						callback = "callback_khud_objective_panel_set_y",
						settings_source = "layout",
						value = "OBJECTIVE_Y",
						min = -720,
						max = 720,
						step = 1,
						show_value = true
					},
					{
						type = "slider",
						id = "khud_objective_panel_set_scale",
						title = "khud_menu_layouts_generic_scale_title",
						desc = "khud_menu_layouts_generic_scale_desc",
						callback = "callback_khud_objective_panel_set_scale",
						settings_source = "layout",
						value = "objective_panel_scale",
						min = 0.01,
						max = 5,
						step = 0.1,
						show_value = true
					},
					{
						type = "divider",
						id = "khud_menu_layouts_objective_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --assault
				type = "menu",
				id = "khud_menu_layouts_assault",
				title = "khud_menu_layouts_assault_title",
				desc = "khud_menu_layouts_assault_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_assault_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_assault_panel_set_location",
						settings_source = "layout",
						value = "assault_panel_location"
					},
					{
							type = "slider",
							id = "khud_assault_panel_set_x",
							title = "khud_menu_layouts_generic_x_title",
							desc = "khud_menu_layouts_generic_x_desc",
							callback = "callback_khud_assault_panel_set_x",
							settings_source = "layout",
							value = "ASSAULT_X",
							min = -1280,
							max = 1280,
							step = 1,
							show_value = true
						},
						{
							type = "slider",
							id = "khud_assault_panel_set_y",
							title = "khud_menu_layouts_generic_y_title",
							desc = "khud_menu_layouts_generic_y_desc",
							callback = "callback_khud_assault_panel_set_y",
							settings_source = "layout",
							value = "ASSAULT_Y",
							min = -720,
							max = 720,
							step = 1,
							show_value = true
						},
						{
							type = "slider",
							id = "khud_assault_panel_set_scale",
							title = "khud_menu_layouts_generic_scale_title",
							desc = "khud_menu_layouts_generic_scale_desc",
							callback = "callback_khud_assault_panel_set_scale",
							settings_source = "layout",
							value = "assault_panel_scale",
							min = 0.01,
							max = 5,
							step = 0.1,
							show_value = true
						},
					{
						type = "divider",
						id = "khud_menu_layouts_assault_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --interaction
				type = "menu",
				id = "khud_menu_layouts_interaction",
				title = "khud_menu_layouts_interaction_title",
				desc = "khud_menu_layouts_interaction_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_interaction_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_interaction_panel_set_location",
						settings_source = "layout",
						value = "interaction_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_interaction_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --hints
				type = "menu",
				id = "khud_menu_layouts_hints",
				title = "khud_menu_layouts_hints_title",
				desc = "khud_menu_layouts_hints_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_hints_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_hints_panel_set_location",
						settings_source = "layout",
						value = "hints_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_hints_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --presenter
				type = "menu",
				id = "khud_menu_layouts_presenter",
				title = "khud_menu_layouts_presenter_title",
				desc = "khud_menu_layouts_presenter_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_presenter_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_presenter_panel_set_location",
						settings_source = "layout",
						value = "presenter_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_presenter_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --chat
				type = "menu",
				id = "khud_menu_layouts_chat",
				title = "khud_menu_layouts_chat_title",
				desc = "khud_menu_layouts_chat_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_chat_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_chat_panel_set_location",
						settings_source = "layout",
						value = "chat_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_chat_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --hit direction
				type = "menu",
				id = "khud_menu_layouts_hitdirection",
				title = "khud_menu_layouts_hitdirection_title",
				desc = "khud_menu_layouts_hitdirection_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_hitdirection_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_hitdirection_panel_set_location",
						settings_source = "layout",
						value = "hitdirection_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_hitdirection_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --waypoints
				type = "menu",
				id = "khud_menu_layouts_waypoints",
				title = "khud_menu_layouts_waypoints_title",
				desc = "khud_menu_layouts_waypoints_desc",
				area_bg = "none",
				children = {
				
				}
			},
			{ --custody/trade timer
				type = "menu",
				id = "khud_menu_layouts_custody",
				title = "khud_menu_layouts_custody_title",
				desc = "khud_menu_layouts_custody_desc",
				area_bg = "none",
				children = {
				
				}
			},
			{ --drop in/waiting hud
				type = "menu",
				id = "khud_menu_layouts_waiting",
				title = "khud_menu_layouts_waiting_title",
				desc = "khud_menu_layouts_waiting_desc",
				area_bg = "none",
				children = {
				
				}
			},
			{ --detection/suspicion
				type = "menu",
				id = "khud_menu_layouts_suspicion",
				title = "khud_menu_layouts_suspicion_title",
				desc = "khud_menu_layouts_suspicion_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_suspicion_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_suspicion_panel_set_location",
						settings_source = "layout",
						value = "suspicion_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_suspicion_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --buffs
				type = "menu",
				id = "khud_menu_layouts_buffs",
				title = "khud_menu_layouts_buffs_title",
				desc = "khud_menu_layouts_buffs_desc",
				area_bg = "none",
				children = {
					{
						type = "multiple_choice",
						id = "khud_buffs_panel_set_location",
						title = "khud_menu_layouts_generic_location_title",
						desc = "khud_menu_layouts_generic_location_desc",
						items = table.deep_map_copy(KineticHUD.hud_panel_locations),
						callback = "callback_khud_buffs_panel_set_location",
						settings_source = "layout",
						value = "buffs_panel_location"
					},
					{
						type = "divider",
						id = "khud_menu_layouts_buffs_panel_div_1",
						size = KineticHUD.menu_divider_sizes.medium
					}
				}
			},
			{ --cartographer, compass, (includes heist name popup)
				type = "menu",
				id = "khud_menu_layouts_cartographer",
				title = "khud_menu_layouts_cartographer_title",
				desc = "khud_menu_layouts_cartographer_desc",
				area_bg = "none",
				children = {
					{ --compass
						type = "menu",
						id = "khud_menu_layouts_cartographer_compass",
						title = "khud_menu_layouts_cartographer_compass_title",
						desc = "khud_menu_layouts_cartographer_compass_desc",
						area_bg = "none",
						children = {
							{
								type = "multiple_choice",
								id = "khud_compass_panel_set_location",
								title = "khud_menu_layouts_generic_location_title",
								desc = "khud_menu_layouts_generic_location_desc",
								items = table.deep_map_copy(KineticHUD.hud_panel_locations),
								callback = "callback_khud_compass_panel_set_location",
								settings_source = "layout",
								value = "compass_panel_location"
							},
							{
								type = "divider",
								id = "khud_menu_layouts_compass_panel_div_1",
								size = KineticHUD.menu_divider_sizes.medium
							}
						}
					}
				}
			}			
		}
	}
}

--holds generated menus by menu id
KineticHUD._game_menus = {}

		
KineticHUD._USE_UNIQUE_WORKSPACE = false
KineticHUD._world_panels = {}
KineticHUD._workspaces = {}

KineticHUD._cache = {
	selections_by_unit = {},
	kills_by_weapon_unit = {},
	teammate_health = {},
	local_peer_id = nil
}

KineticHUD._teammate_panels = {}


KineticHUD.valign_values = {
	"top",
	"center",
	"bottom"
}
KineticHUD.halign_values = {
	"left",
	"center",
	"right"
}

--number values used for sizing, positioning etc. which should not be change-able by settings
KineticHUD.hud_values = {
	DEBUG_PANELS_VISIBLE = false,
	world_panels = {
		{
			name = "left_panel",
			localized_name = "khud_panel_left_title",
			DISTANCE = 5,
			HALIGN = "left",
			VALIGN = "top",
			TEXT = "LEFT PANEL",
			W_SCALAR = 0.25,
			H_SCALAR = 1,
			WORLD_W = 5,
			WORLD_H = 10,
			GUI_W = 500,
			GUI_H = 1000,
			OFFSET_YAW = 15,
			OFFSET_PITCH = 0,
			OFFSET_ROLL = 0,
			OFFSET_X = 0.05,
			OFFSET_Y = 0,
			OFFSET_Z = 0,
			RECT_COLOR = Color.red,
			RECT_ALPHA = 0.5
		},
		{
			name = "right_panel",
			localized_name = "khud_panel_right_title",
			DISTANCE = 5,
			HALIGN = "right",
			VALIGN = "top",
			TEXT = "RIGHT PANEL",
			W_SCALAR = 0.25,
			H_SCALAR = 1,
			WORLD_W = 5,
			WORLD_H = 10,
			GUI_W = 500,
			GUI_H = 1000,
			OFFSET_YAW = -15,
			OFFSET_PITCH = 0,
			OFFSET_ROLL = 0,
			OFFSET_X = 0.05,
			OFFSET_Y = 0,
			OFFSET_Z = 0,
			RECT_COLOR = Color.blue,
			RECT_ALPHA = 0.5
		},
		{
			name = "top_panel",
			localized_name = "khud_panel_top_title",
			DISTANCE = 6,
			HALIGN = "center",
			VALIGN = "top",
			TEXT = "TOP PANEL",
			W_SCALAR = 0.4,
			H_SCALAR = 0.4,
			WORLD_W = 11,
			WORLD_H = 6,
			GUI_W = 800,
			GUI_H = 450,
			OFFSET_YAW = 0,
			OFFSET_PITCH = 10,
			OFFSET_ROLL = 0,
			OFFSET_X = 0,
			OFFSET_Y = 0.2,
			OFFSET_Z = 0,
			RECT_COLOR = Color.yellow,
			RECT_ALPHA = 0.5
		},
		{
			name = "bottom_panel",
			localized_name = "khud_panel_bottom_title",
			DISTANCE = 6,
			HALIGN = "center",
			VALIGN = "bottom",
			TEXT = "BOTTOM PANEL",
			W_SCALAR = 0.4,
			H_SCALAR = 0.4,
			WORLD_W = 11,
			WORLD_H = 6,
			GUI_W = 1600 / 1.5,
			GUI_H = 900 / 1.5,
			OFFSET_YAW = 0,
			OFFSET_PITCH = 10,
			OFFSET_ROLL = 0,
			OFFSET_X = 0,
			OFFSET_Y = 0.2,
			OFFSET_Z = 0,
			RECT_COLOR = Color.green,
			RECT_ALPHA = 0.5
		},
		{
			name = "stats_top_panel",
			unhidable = true,
			localized_name = "khud_panel_stats_top_title",
			DISTANCE = 5,
			HALIGN = "left",
			VALIGN = "top",
			TEXT = "STATS TOP PANEL",
			W_SCALAR = 0.6,
			H_SCALAR = 0.6,
			WORLD_W = 11,
			WORLD_H = 6,
			GUI_W = 800,
			GUI_H = 450,
			OFFSET_YAW = 10,
			OFFSET_PITCH = 10,
			OFFSET_ROLL = 0,
			OFFSET_X = 0.1,
			OFFSET_Y = 0.2,
			OFFSET_Z = 0,
			RECT_COLOR = Color(0,1,1),
			RECT_ALPHA = 0.5
		}
	},
	
	
	FIREMODE_SINGLE_TEXTURE = "textures/ui/firemode_dots_1",
	FIREMODE_BURST_TEXTURE = "textures/ui/firemode_dots_2",
	FIREMODE_AUTO_TEXTURE = "textures/ui/firemode_dots_3",
	FIREMODE_TEXTURE_W = 16 / 2,
	FIREMODE_TEXTURE_H = 80 / 2,
	
	PLAYER_VITALS_PANEL_W = 1000,
	PLAYER_VITALS_PANEL_H = 100,
	PLAYER_VITALS_LABEL_FONT_SIZE = 32,
	PLAYER_VITALS_COUNTER_FONT_SIZE_LARGE = 32,
	PLAYER_VITALS_COUNTER_FONT_SIZE_MEDIUM = 24,
	
	PLAYER_HEALTH_PANEL_W = 520,
	PLAYER_HEALTH_PANEL_H = 100,
	PLAYER_HEALTH_PANEL_X = 0,
	PLAYER_HEALTH_PANEL_Y = -12,
	
	PLAYER_ARMOR_PANEL_W = 520,
	PLAYER_ARMOR_PANEL_H = 100,
	PLAYER_ARMOR_PANEL_X = 0,
	PLAYER_ARMOR_PANEL_Y = -12,
	
	PLAYER_VITALS_BAR_OUTLINE_W = 512,
	PLAYER_VITALS_BAR_OUTLINE_H = 24,
	PLAYER_VITALS_BAR_OUTLINE_X = 0,
	PLAYER_VITALS_BAR_OUTLINE_Y = 0,
	
	PLAYER_VITALS_BAR_FILL_W = 512,
	PLAYER_VITALS_BAR_FILL_H = 16,
	PLAYER_VITALS_BAR_FILL_X = 0,
	PLAYER_VITALS_BAR_FILL_Y = 0,
	
	PLAYER_VITALS_LABELS_X = 0,
	PLAYER_VITALS_LABELS_Y = 0,
	
	PLAYER_ARMOR_BAR_W = 300,
	PLAYER_ARMOR_BAR_H = 16,
	PLAYER_ARMOR_BAR_X = 100,
	PLAYER_ARMOR_BAR_Y = 500,
	PLAYER_ARMOR_FILL_TEXTURE_W = 256,
	PLAYER_ARMOR_FILL_TEXTURE_H = 8,
	PLAYER_HEALTH_FILL_TEXTURE_W = 256,
	PLAYER_HEALTH_FILL_TEXTURE_H = 8,
	PLAYER_HEALTH_BAR_W = 300,
	PLAYER_HEALTH_BAR_H = 16,
	PLAYER_HEALTH_BAR_X = 700,
	PLAYER_HEALTH_BAR_Y = 500,
	
	PLAYER_EQUIPMENT_DEPLOYABLE_1_X = 0,
	PLAYER_EQUIPMENT_DEPLOYABLE_1_Y = 0,
	PLAYER_EQUIPMENT_DEPLOYABLE_2_X = 128 + 56,
	PLAYER_EQUIPMENT_DEPLOYABLE_2_Y = 0,
	PLAYER_EQUIPMENT_CABLE_TIES_X = 25,
	PLAYER_EQUIPMENT_CABLE_TIES_Y = 75,
	PLAYER_EQUIPMENT_THROWABLE_X = 25 + 128,
	PLAYER_EQUIPMENT_THROWABLE_Y = 75,
	
	PLAYER_EQUIPMENT_BOX_W = 116,
	PLAYER_EQUIPMENT_BOX_H = 48,
	
	
	PLAYER_EQUIPMENT_BOX_OUTLINE_THICKNESS = 2,
	PLAYER_EQUIPMENT_BOX_OUTLINE_ALPHA = 0.5,
	PLAYER_EQUIPMENT_BOX_BG_ALPHA = 0.5,
	
	PLAYER_MISSION_EQUIPMENT_W = 500,
	PLAYER_MISSION_EQUIPMENT_H = 100,
	PLAYER_MISSION_EQUIPMENT_ICON_SIZE = 32,
	PLAYER_MISSION_EQUIPMENT_FONT_SIZE = 24,
	
	PLAYER_WEAPON_HUD_ANIMATION_SWAP_DURATION = 1/3,
	
	PLAYER_WEAPONS_W = 500,
	PLAYER_WEAPONS_H = 400,
	
	PLAYER_WEAPON_PRIMARY_SCALE = 1,
	PLAYER_WEAPON_SECONDARY_SCALE = 0.75,
	
	PLAYER_WEAPON_W = 500,
	PLAYER_WEAPON_H = 100,
	PLAYER_WEAPON_X = 0, --this is an absolute coordinate. also, unscaled (unaffected by scale settings)
	PLAYER_WEAPON_Y = 0, --absolute/unscaled
	PLAYER_WEAPON_PRIMARY_X = 0, --absolute/unscaled
	PLAYER_WEAPON_PRIMARY_Y = 0, --absolute/unscaled
	PLAYER_WEAPON_SECONDARY_X = 100, --this is a relative coordinate, and is dependent on another setting value (PLAYER_WEAPON_X). also, scaled
	PLAYER_WEAPON_SECONDARY_Y = 50, --relative/scaled (PLAYER_WEAPON_PRIMARY_Y)
	
	PLAYER_WEAPON_FONT_SIZE_SMALL = 20, --reserve
	PLAYER_WEAPON_FONT_SIZE_LARGE = 32, --magazine
	PLAYER_WEAPON_ICON_X = 84,
	PLAYER_WEAPON_ICON_Y = 0,
	PLAYER_WEAPON_ICON_W = 200,
	PLAYER_WEAPON_ICON_H = 100,
	PLAYER_WEAPON_ICON_BG_ALPHA = 0.5,
	PLAYER_WEAPON_BORDER_ALPHA = 0.8,
	PLAYER_WEAPON_BORDER_THICKNESS = 2,
	PLAYER_WEAPON_FIREMODE_W = 16 * 0.5,
	PLAYER_WEAPON_FIREMODE_H = 80 * 0.5,
	PLAYER_WEAPON_RESERVE_X = 20,
	
--	ASSAULT_PANEL_
	
	MARGIN_XXXSMALL = 1,
	MARGIN_XXSMALL = 2,
	MARGIN_XSMALL = 4,
	MARGIN_SMALL = 8,
	MARGIN_MEDIUM = 16,
	MARGIN_XMEDIUM = 32, --that's right. extra medium
	MARGIN_LARGE = 48,
	MARGIN_XLARGE = 56,
	MARGIN_XXLARGE = 64,
	
	TEAMMATE_PANEL_X = 0,
	TEAMMATE_PANEL_Y = 128,
	TEAMMATE_PANEL_W = 400,
	TEAMMATE_PANEL_H = 56,
	
	TEAMMATE_NAMETAG_PANEL_X = 8,
	TEAMMATE_NAMETAG_PANEL_Y = 0,
	TEAMMATE_NAMETAG_PANEL_W = 128,
	TEAMMATE_NAMETAG_PANEL_H = 32,
	TEAMMATE_NAMETAG_FONT_SIZE = 32,
	TEAMMATE_COLOR_INDICATOR_W = 4,
	TEAMMATE_COLOR_INDICATOR_H = 0,
	TEAMMATE_COLOR_INDICATOR_X = 0,
	TEAMMATE_COLOR_INDICATOR_Y = 0,
	TEAMMATE_BPM_PANEL_W = 100,
	TEAMMATE_BPM_PANEL_H = 0,
	TEAMMATE_BPM_PANEL_X = 0,
	TEAMMATE_BPM_PANEL_Y = 0,
	TEAMMATE_BPM_ICON_SIZE_MUL = 1,
	TEAMMATE_BPM_ICON_X = 0,
	TEAMMATE_BPM_ICON_Y = 0,
	
	TEAMMATE_EQUIPMENT_BOX_OUTLINE_THICKNESS = 1,
	TEAMMATE_EQUIPMENT_BOX_W = 72,
	TEAMMATE_EQUIPMENT_BOX_H = 24,
	TEAMMATE_EQUIPMENT_FONT_SIZE = 24,
	TEAMMATE_EQUIPMENT_ICON_SIZE = 24,
	TEAMMATE_EQUIPMENT_TEXT_X = 0,
	TEAMMATE_EQUIPMENT_TEXT_Y = 0,
	TEAMMATE_EQUIPMENT_BOX_DOUBLE_W_MUL = 1.5, --yes i know it says "double"
	
	TEAMMATE_BPM_MASK_X = 0,
	TEAMMATE_BPM_MASK_Y = 0,
	
	TEAMMATE_SPEAKING_ICON_X = 0,
	TEAMMATE_SPEAKING_ICON_Y = 0,
	TEAMMATE_SPEAKING_ICON_SIZE_MUL = 1,	
	TEAMMATE_SPEAKING_ICON_ID = "pd2_talk",
	
	TEAMMATE_DEPLOYABLE_X = 0,
	TEAMMATE_DEPLOYABLE_Y = 0,
	TEAMMATE_REVIVES_FONT_SIZE = 20,
	
	ASSAULT_W = 300,
	ASSAULT_H = 100,
	ASSAULT_ICON_W = 32,
	ASSAULT_ICON_H = 32,
	ASSAULT_ICON_X = 0,
	ASSAULT_ICON_Y = 0,
	ASSAULT_HALIGN = "right",
	ASSAULT_VALIGN = "top",
	ASSAULT_PHASE_LABEL_X = 32 + 8,
	ASSAULT_PHASE_LABEL_Y = 0,
	ASSAULT_PHASE_LABEL_HALIGN = "left",
	ASSAULT_PHASE_LABEL_VALIGN = "top",
	ASSAULT_PHASE_LABEL_COLOR = Color.white,
	ASSAULT_PHASE_LABEL_FONT_SIZE = 32,
	
	BUFFS_PANEL_W = 1100,
	BUFFS_PANEL_H = 600,
	
	BUFF_FONT_SIZE = 36,
	BUFF_ICON_W = 48,
	BUFF_ICON_H = 48,
	BUFF_W = 300,
	BUFF_H = 56,
	BUFF_W_COMPACT = 100,
	
	
	OBJECTIVE_W = 500,
	OBJECTIVE_H = 100,
	
	OBJECTIVE_HALIGN = "left", --these ones are manually applied
	OBJECTIVE_VALIGN = "top",
	
	OBJECTIVE_TITLE_TEXT_X = 0,
	OBJECTIVE_TITLE_TEXT_Y = 0,
	OBJECTIVE_TITLE_TEXT_HALIGN = "left",
	OBJECTIVE_TITLE_TEXT_VALIGN = "top",
	OBJECTIVE_TITLE_TEXT_FONT_SIZE = 48,
	OBJECTIVE_TITLE_TEXT_COLOR = Color.white,
	
	OBJECTIVE_TEXT_X = 16,
	OBJECTIVE_TEXT_Y = 32,
	OBJECTIVE_TEXT_HALIGN = "left",
	OBJECTIVE_TEXT_VALIGN = "top",
	OBJECTIVE_TEXT_FONT_SIZE = 32,
	OBJECTIVE_TEXT_COLOR = Color.white,
	
	OBJECTIVE_COUNT_TEXT_X = 48,
	OBJECTIVE_COUNT_TEXT_Y = 56,
	OBJECTIVE_COUNT_TEXT_HALIGN = "left",
	OBJECTIVE_COUNT_TEXT_VALIGN = "top",
	OBJECTIVE_COUNT_TEXT_FONT_SIZE = 32,
	OBJECTIVE_COUNT_TEXT_COLOR = Color.white,
	
	OBJECTIVE_ANIMATE_TEXT_TYPING_SPEED = 0.1, --seconds per character in typing animation
	OBJECTIVE_ANIMATE_TEXT_TYPING_HOLD_DURATION = 3,
	OBJECTIVE_ANIMATE_TEXT_TYPING_CURSOR_BLINK_SPEED = 1,
	OBJECTIVE_ANIMATE_TEXT_BACKSPACE_DURATION = 0.5,
	
	CARRY_W = 500,
	CARRY_H = 100,
	CARRY_ICON_ID = "bag_icon",
	CARRY_ICON_X = 0,
	CARRY_ICON_Y = 50,
	CARRY_ICON_W = 24,
	CARRY_ICON_H = 24,
	CARRY_ICON_ALPHA = 0.8,
	CARRY_LABEL_X = 32,
	CARRY_LABEL_Y = -24,
	CARRY_LABEL_FONT_SIZE = 24,
	CARRY_LABEL_HALIGN = "left",
	CARRY_LABEL_VALIGN = "bottom",
	CARRY_VALUE_X = 32,
	CARRY_VALUE_Y = 0,
	CARRY_VALUE_FONT_SIZE = 24,
	CARRY_VALUE_HALIGN = "left",
	CARRY_VALUE_VALIGN = "bottom",
	
	CARRY_ANIMATE_TEXT_LABEL_TYPING_SPEED = 0.1,
	CARRY_ANIMATE_ICON_WAIT_DURATION = 1,
	CARRY_ANIMATE_TEXT_VALUE_DURATION = 1,
	CARRY_ANIMATE_TEXT_VALUE_POWER = 1,
	
	HEALTH_THRESHOLD_NORMAL = 1,
	HEALTH_THRESHOLD_STRESSED = 0.5,
	HEALTH_THRESHOLD_CRITICAL = 1/3,
	HEALTH_THRESHOLD_FLATLINE = 0,
	EKG_LAYER = 2,
	EKG_SPEED = 16, --pixels per second
	EKG_SIZE = 24,
	EKG_Y = 2,
	EKG_ATLAS = {
		texture = "textures/ui/ekg_atlas",
		states = {
			normal = {
				{
					0 * 128,0 * 128,128,128
				},
				{
					1 * 128,0 * 128,128,128
				},
				{
					2 * 128,0 * 128,128,128
				},
				{
					3 * 128,0 * 128,128,128
				}
			},
			stressed = {
				{
					0 * 64,1 * 128,64,128
				},
				{
					1 * 64,1 * 128,64,128
				},
				{
					2 * 64,1 * 128,64,128
				},
				{
					3 * 64,1 * 128,64,128
				},
				{
					4 * 64,1 * 128,64,128
				},
				{
					5 * 64,1 * 128,64,128
				},
				{
					6 * 64,1 * 128,64,128
				},
				{
					7 * 64,1 * 128,64,128
				}
			},
			critical = {
				{
					0 * 64,2 * 128,128,128
				},
				{
					2  * 64,2 * 128,128,128
				},
				{
					4  * 64,2 * 128,64,128
				},
				{
					5  * 64,2 * 128,128,128
				},
				{
					7 * 64,2 * 128,64,128
				}
			},
			flatline = {
				{
					0 * 64,3 * 128,64,128
				},
				{
					1 * 64,3 * 128,64,128
				},
				{
					2 * 64,3 * 128,64,128
				},
				{
					3 * 64,3 * 128,64,128
				},
				{
					4 * 64,3 * 128,64,128
				},
				{
					5 * 64,3 * 128,64,128
				},
				{
					6 * 64,3 * 128,64,128
				},
				{
					7 * 64,3 * 128,64,128
				}
			}
		}
	}
}

KineticHUD.default_layout_settings = {
	HEIST_TIMER_FONT_SIZE = 24,
	
	player_vitals_panel_location = 4,
	player_vitals_panel_scale = 1,

	player_weapons_panel_x = 0,
	player_weapons_panel_y = 750,
	player_weapons_panel_location = 2, --locations are [1-4]
	player_weapons_panel_scale = 1,
	
	player_equipment_panel_scale = 1,
	player_equipment_panel_location = 1,
	PLAYER_EQUIPMENT_X = 150,
	PLAYER_EQUIPMENT_Y = 800,
	
	player_mission_equipment_panel_scale = 1,
	player_mission_equipment_panel_location = 1,
	PLAYER_MISSION_EQUIPMENT_X = 0,
	PLAYER_MISSION_EQUIPMENT_Y = 700,
	
	player_carry_panel_location = 1,
	player_carry_panel_scale = 1,
	CARRY_X = 0,
	CARRY_Y = 400,
	
	presenter_panel_location = 3,
	interaction_panel_location = 4, --5, after i make that
	chat_panel_location = 1,
	hitdirection_panel_location = 4,
	suspicion_panel_location = 3,
	compass_panel_location = 3,
	hints_panel_location = 2,
	
	buffs_panel_location = 4,
	buffs_panel_scale = 1,
	buffs_panel_animation_speed = 1,
	buffs_panel_x = 0,
	buffs_panel_y = 0,
	buffs_panel_halign = 1,
	buffs_panel_valign = 1,
	
	teammates_panel_location = 1,
	teammates_panel_scale = 1,
	teammates_panel_x = 0,
	teammates_panel_y = 0,
	
	assault_panel_scale = 1,
	assault_panel_location = 2,
	ASSAULT_X = 0,
	ASSAULT_Y = 0,
	
	objective_panel_scale = 1,
	objective_panel_location = 1,
	OBJECTIVE_X = 0,
	OBJECTIVE_Y = 0
}

KineticHUD.debug_value_1 = 0.5

--default settings
KineticHUD.default_settings = {
}

KineticHUD.layout_settings = table.deep_map_copy(KineticHUD.default_layout_settings)
KineticHUD.settings = table.deep_map_copy(KineticHUD.default_settings)
--loading settings from existing save file comes after, so that it is layed over the default_settings

--Settings getters
function KineticHUD:GetVerticalAlignFromIndex(index)
	return self.valign_values[index]
end

function KineticHUD:GetHorizontalAlignFromIndex(index)
	return self.halign_values[index]
end

function KineticHUD:UseWeaponRealAmmo()
	return true
end

function KineticHUD:ResetSettings()
	self.settings = table.deep_map_copy(self.default_settings)
end

--experimental. recreates a guiobject using another as reference. can be used to "clone" a guiobject to another parent
--GuiObject source, Panel new_parent, table params: GuiObject new_object,Panel new_parent,table cloning_failures
--example: KineticHUD.CloneGuiObject(orig_eq_panel,new_eq_panel,{force_recreate = true,recreate_tree = true})
function KineticHUD.CloneGuiObject(source,new_parent,params)
	if alive(source) then 
		if alive(new_parent) and new_parent.type_name == "Panel" then 
			
			local function assert_nonnil(a,b)
				if a == nil then 
					return b
				else
					return a
				end
			end
			
			params = type(params) == "table" and params or {}
			
--			params.destroy_orig = params.destroy_orig --do not use; bugs the heck out atm
			
			params.name = params.name or source:name()
			params.layer = params.layer or source:layer()
			params.visible = assert_nonnil(params.visible,source:visible())
			params.x = params.x or source:x()
			params.y = params.y or source:y()
			params.w = params.w or source:w()
			params.h = params.h or source:h()
			params.halign = params.halign or source:halign()
			params.valign = params.valign or source:valign()
			params.alpha = params.alpha or source:alpha()
			
			local gui_type = source.type_name
			local e --list of objects that could not be successfully created
			local existing_gui_obj = new_parent:child(params.name)
			local new_gui_obj
			
			if gui_type == "Bitmap" then 
				
				params.texture = params.texture or source:texture_name()
				params.texture_rect = params.texture_rect --no getter
				params.color = params.color or source:color()
				params.rotation = params.rotation or source:rotation()
				params.render_template = params.render_template or source:render_template()
				params.blend_mode = params.blend_mode --no getter
				
				if alive(existing_gui_obj) and not params.force_recreate then 
					existing_gui_obj:set_texture(params.texture)
					existing_gui_obj:set_color(params.color)
					existing_gui_obj:set_render_template(params.render_template)
					existing_gui_obj:set_blend_mode(params.blend_mode)
					
					new_gui_obj = existing_gui_obj
				else
					new_gui_obj = new_parent:bitmap(params)
				end
				
			elseif gui_type == "Gradient" then 
				
				params.color = params.color or source:color()
				params.rotation = params.rotation or source:rotation()
				params.render_template = params.render_template or source:render_template()
				params.blend_mode = params.blend_mode --no getter
				params.orientation = params.orientation or source:orientation()
				params.gradient_points = params.gradient_points --no getter
				
				new_gui_obj = new_parent:gradient(params)
			elseif gui_type == "MultiBitmap" then 
				log("ERROR: CloneGuiObject(): [".. tostring(gui_type) .."] is not supported!")
			elseif gui_type == "Panel" then 
				
				new_gui_obj = new_parent:panel(params)
				--experimental; recreates each of its children throughout the rest of the tree
				if params.deep_clone then 
					e = {}
					for i,o in ipairs(source:children()) do 
						local new_child,p,new_gui_type = KineticHUD.CloneGuiObject(o,new_gui_obj,{destroy_orig = params.destroy_orig,deep_clone = params.deep_clone})
						if not alive(new_child) then 
							table.insert(e,{parent = p,gui_type = new_gui_type})
						end
					end
				end
				
			elseif gui_type == "Polygon" then 
				log("ERROR: CloneGuiObject(): [".. tostring(gui_type) .."] is not fully supported.")
--				log(debug.traceback())
				params.color = params.color or source:color()
				params.rotation = params.rotation or source:rotation()
				params.render_template = params.render_template or source:render_template()
				params.blend_mode = params.blend_mode --no getter
				params.convex = params.convex --no getter
				params.triangles = params.triangles --no getter
				params.colored_triangles = params.triangles --no getter
				
				new_gui_obj = new_parent:polygon(params)
			elseif gui_type == "Polyline" then 
				log("ERROR: CloneGuiObject(): [".. tostring(gui_type) .."] is not yet supported.")
				log(debug.traceback())
				return nil,new_parent,gui_type
			elseif gui_type == "Rect" then 
				params.color = params.color or source:color()
				params.rotation = params.rotation or source:rotation()
				params.render_template = params.render_template or source:render_template()
				params.blend_mode = params.blend_mode --no getter
				
				new_gui_obj = new_parent:rect(params)
			elseif gui_type == "Text" then 
				params.color = params.color or source:color()
				params.rotation = params.rotation or source:rotation()
				params.render_template = params.render_template or source:render_template()
				params.blend_mode = params.blend_mode --no getter
				params.text = params.text or source:text()
				params.font = params.font --font() getter returns an Idstring; font here is a string asset path
				params.font_scale = params.font_scale or source:font_scale()
				params.font_size = params.font_size or source:font_size()
				params.monospace = params.monospace or source:monospace()
				params.kern = params.kern or source:kern()
				params.word_wrap = assert_nonnil(params.word_wrap or source:word_wrap())
				params.align = params.align or source:align()
				params.vertical = params.vertical or source:vertical()
				
				if params.force_recreate then 
					new_gui_obj = new_parent:text(params)
				else
					new_gui_obj = existing_gui_obj
				end
				if alive(new_gui_obj) then 
					new_gui_obj:set_color(params.color)
					new_gui_obj:set_rotation(params.rotation)
					new_gui_obj:set_render_template(params.render_template)
					new_gui_obj:set_blend_mode(params.blend_mode)
					new_gui_obj:set_text(params.text)
					new_gui_obj:set_font(source:font())
					new_gui_obj:set_font_size(params.font_size)
					new_gui_obj:set_font_scale(params.font_scale)
					new_gui_obj:set_monospace(params.monospace)
					new_gui_obj:set_kern(params.kern)
					new_gui_obj:set_word_wrap(params.word_wrap)
					new_gui_obj:set_align(params.align)
					new_gui_obj:set_vertical(params.vertical)
				end
				
			elseif gui_type == "Unit" then
				log("ERROR: CloneGuiObject(): [".. tostring(gui_type) .."] is not supported!")
				log(debug.traceback())
			elseif gui_type == "Video" then
				log("ERROR: CloneGuiObject(): [".. tostring(gui_type) .."] is not supported!")
				log(debug.traceback())
				
			else
				log("ERROR: CloneGuiObject(): Unknown type name [" .. tostring(gui_type) .. "]")
			end
			
			if alive(new_gui_obj) then
				new_gui_obj:set_position(params.x,params.y)
				new_gui_obj:set_size(params.w,params.h)
				new_gui_obj:set_layer(params.layer)
				new_gui_obj:set_visible(params.visible)
				new_gui_obj:set_halign(params.halign)
				new_gui_obj:set_valign(params.valign)
				new_gui_obj:set_alpha(params.alpha)
				
				if params.destructive_clone then 
					if existing_gui_obj and existing_gui_obj ~= new_gui_obj and alive(existing_gui_obj) then 
						existing_gui_obj:parent():remove(existing_gui_obj)
					end
				end
			end
			
			return new_gui_obj,new_parent,gui_type,e
		else
			log("ERROR: CloneGuiObject(): invalid new_parent parameter " .. tostring(new_parent))
		end
	else
		log("ERROR: CloneGuiObject(): Invalid source GuiObject " .. tostring(source))
		log(debug.traceback())
	end
end


function KineticHUD.format_seconds(raw)
	return string.format("%i:%02d",math.floor(raw / 60),math.floor(raw % 60))
end


--i had to write this because get_specialization_icon_data() always picks the top tier. booooo
function KineticHUD.get_specialization_icon_data_by_tier(spec,tier,no_fallback)
	local sm = managers.skilltree
	local st = tweak_data.skilltree
	
	spec = spec or sm:get_specialization_value("current_specialization")

	local data = st.specializations[spec]
	local max_tier = sm:get_specialization_value(spec, "tiers", "max_tier")
	local tier_data = data and data[tier or max_tier] --this and the arg tier are the only things i changed. :|

	if not tier_data then
		if no_fallback then
			return
		else
			return tweak_data.hud_icons:get_icon_data("fallback")
		end
	end

	local guis_catalog = "guis/" .. (tier_data.texture_bundle_folder and "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/" or "")
	local x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
	local y = tier_data.icon_xy and tier_data.icon_xy[2] or 0

	return guis_catalog .. "textures/pd2/specialization/icons_atlas", {
		x * 64,
		y * 64,
		64,
		64
	}
end

--misc management


--Writes information for debugging to the appropriate output. Calls global function Log() with all arguments passed if defined (namely, by the Developer Console mod), else uses log() (from BLT)
--Arguments: any (content agnostic)
--Returns: nil
function KineticHUD:c_log(...)
	local f = Log or log
	return f(...)
end


function KineticHUD:Update(t,dt)
	self:UpdateAnimate(t,dt)
	self:UpdateHUD(t,dt)
	--self:UpdateCompass()
	--self:UpdateCartographer()
end


--HUD Animation

KineticHUD.animator = QuickAnimate:new("khud",{parent = KineticHUD,updater_type = 3})

function KineticHUD:animate(target,func,done_cb,...)
	return self.animator:animate(target,func,done_cb,...)
end

function KineticHUD:animate_wait(...)
	return self.animator:animate_wait(...)
end

function KineticHUD:animate_stop(...)
	return self.animator:animate_stop(...)
end

--animation library

	--lerp movement between two sets of 2d coordinates
function KineticHUD.animate_move(o,t,dt,start_t,duration,start_x,start_y,end_x,end_y)
	local progress = (t - start_t) / duration
	local lerp = math.clamp(progress,0,1)
	local d_x = end_x - start_x
	local d_y = end_y - start_y
	o:set_position(start_x + (d_x * lerp),start_y + (d_y * lerp))
	if lerp >= 1 then 
		return true
	end
end

function KineticHUD.animate_move_sin(o,t,dt,start_t,duration,start_x,start_y,end_x,end_y)
	local progress = (t - start_t) / duration
	local lerp = math.clamp(math.sin(progress * 90),0,1)
	local d_x = end_x - start_x
	local d_y = end_y - start_y
	o:set_position(start_x + (d_x * lerp),start_y + (d_y * lerp))
	if progress >= 1 then 
		return true
	end
end

	--this calls the a specific khud function and should not be used as a general animation function
function KineticHUD.animate_weapon_panels_switch(o,t,dt,start_t,duration,start_x,start_y,end_x,end_y,power,params)
	power = power or 2
	
	local progress = (t - start_t) / duration
	local lerp_x = math.pow(progress,1/power)
	local lerp_y = math.pow(progress,power)
	if progress >= 1 then 
		lerp_x = 1
		lerp_y = 1
	end
	local d_x = end_x - start_x
	local d_y = end_y - start_y
	o:set_position(start_x + (d_x * lerp_x),start_y + (d_y * lerp_y))
	
	params.lerp_override = lerp_x
	KineticHUD:LayoutPlayerWeaponsPanel(params)
	
	if progress >= 1 then 
		return true
	end
end

function KineticHUD.animate_move_pow(o,t,dt,start_t,duration,start_x,start_y,end_x,end_y,power)
	power = power or 2
	
	if t - start_t > duration then 
		o:set_position(end_x,end_y)
		return true
	end
	
	local progress = math.pow((t - start_t) / duration,power or 2)
	local d_x = end_x - start_x
	local d_y = end_y - start_y
	o:set_position(start_x + (d_x * progress),start_y + (d_y * progress))
end

function KineticHUD.animate_move_rotate_clockwise(o,t,dt,start_t,duration,start_x,start_y,end_x,end_y,power)
	power = power or 2
	
	local progress = (t - start_t) / duration
	local lerp_x = math.pow(progress,1/power)
	local lerp_y = math.pow(progress,power)
	if progress >= 1 then 
		lerp_x = 1
		lerp_y = 1
	end
	local d_x = end_x - start_x
	local d_y = end_y - start_y
	o:set_position(start_x + (d_x * lerp_x),start_y + (d_y * lerp_y))
	if progress >= 1 then 
		return true
	end
end

function KineticHUD.animate_text_typing(o,t,dt,start_t,duration,text,type_char,post_duration,blink_speed)
	post_duration = post_duration or 0

	type_char = type_char or "_"
	if t - start_t > (duration + post_duration) then 
		o:set_text(text)
		return true
	elseif t - start_t < duration then
		local length = string.len(text)
		local ratio = (t - start_t) / duration
		o:set_text(string.sub(text,1,math.clamp(ratio * length,1,length)) .. type_char)
	elseif math.sin((t - start_t) * 360  * (blink_speed or 2)) > 0 then 
		o:set_text(text .. type_char)
	else
		o:set_text(text)
	end
end

	--animates deleting all characters in a text sequentially in reverse, leaving only an empty string ""
function KineticHUD.animate_text_backspaced(o,t,dt,start_t,duration,start_text,type_char,post_duration,blink_speed)
	post_duration = post_duration or 0
	type_char = type_char or "_"
	blink_speed = blink_speed or 0
	
	if t - start_t > (duration + post_duration) then 
		o:set_text("")
		return true
	elseif t - start_t < duration then 
		local length = string.len(start_text)
		local ratio = (t - start_t) / duration
		o:set_text(string.sub(start_text,1,-math.floor((ratio * length) + 2)) .. type_char)
	else
		if math.sin((t - start_t) * 360  * (blink_speed or 2)) > 0 then 
			o:set_text(type_char)
		else
			o:set_text("")
		end
	end
end

function KineticHUD.animate_text_unscramble(o,t,dt,start_t,duration,end_text,scramble_interval,valid_r_chars)
	local progress = (t - start_t) / duration
	if t - start_t > duration then 
		o:set_text(end_text)
		return true
	end
	local current_text = o:text()
	local length = string.len(end_text)
	local new_text = ""
	local n_correct = 0
	for i=1,length do
		if string.sub(current_text,i,i) == string.sub(end_text,i,i) and (n_correct + 1 < length) then
			--nothing
		elseif math.random() > progress then 
			new_text = new_text .. string.sub(end_text,i,i)
		else
			if valid_r_chars then 
				local r = math.random(string.len(valid_r_chars))
				new_text = new_text .. string.sub(valid_r_chars,r,r)
			else
				new_text = new_text .. string.char(math.random(65,90))
			end
		end
	end
	o:set_text(new_text)
end

--sets a text object to an increasing interpolated formatted cash amount string
--eg. animates from "$0", counting up to "$200"
function KineticHUD.animate_text_money_count(o,t,dt,start_t,duration,start_amount,end_amount,power)
	local progress = math.pow((t - start_t) / duration,power or 1)
	if t - start_t > duration then 
		o:set_text(managers.experience:cash_string(end_amount))
		return true
	end
	local interp_amount = (end_amount - start_amount) * progress
	o:set_text(managers.experience:cash_string(interp_amount))
end

function KineticHUD.animate_color_shift_duo(o,t,dt,start_t,duration,color_1,color_2)
	local progress = (t - start_t) / duration
	local done
	if progress >= 1 then
		done = true
		progress = 1
	end
	local d_c = color_2 - color_1
	o:set_color(color_1 + (d_c * progress))
	if done then 
		return true
	end
end

function KineticHUD:UpdateAnimate(t,dt,...)
	if self.animator then 
		self.animator:UpdateAnimate(t,dt,...)
	end
end








function KineticHUD.callback_show_colorpicker_missing_prompt()
	local loc = callback(managers.localization,managers.localization,"text")
	QuickMenu:new(loc("khud_missing_colorpicker_title"),string.gsub(loc("khud_missing_colorpicker_desc"),"$URL",KineticHUD.url.colorpicker),{
		{
			text = loc("menu_ok"),
			is_cancel_button = true
		}
	},true)
end










--io

function KineticHUD:LoadLayout()
	local file = io.open(self._layout_save_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.layout_settings[k] = v
		end
	else
		self:SaveLayout()
	end
end

function KineticHUD:SaveLayout()
	local file = io.open(self._layout_save_path, "w+")
	if file then
		file:write(json.encode(self.layout_settings))
		file:close()
	end

end

function KineticHUD:Load(skip_settings,skip_layout)
	if not skip_settings then 
		self:LoadSettings()
	end
	if not skip_layout then 
		self:LoadLayout()
	end
end

function KineticHUD:Save(skip_settings,skip_layout)
	if not skip_settings then 
		self:SaveSettings()
	end
	if not skip_layout then 
		self:SaveLayout()
	end
end

function KineticHUD:LoadSettings()
	local file = io.open(self._settings_save_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.settings[k] = v
		end
	else
		self:Save()
	end
end

function KineticHUD:SaveSettings()
	local file = io.open(self._settings_save_path, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end


KineticHUD._buff_data = KineticHUD._buff_data or {}
--load hud buff data
local load_buff_data,e = blt.vm.loadfile(KineticHUD._mod_path .. "buff/buff_data.lua")
if e then 
	KineticHUD:c_log("Error: Could not load buff data.")
	KineticHUD:c_log(e)
elseif load_buff_data then 
	KineticHUD._buff_data = load_buff_data() or KineticHUD._buff_data
end

return KineticHUD

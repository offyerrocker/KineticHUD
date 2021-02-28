
KineticHUD = KineticHUD or {}
KineticHUD._mod_path = KineticHUD:GetPath()
KineticHUD._save_path = SavePath .. "KineticHUD_2.txt"
KineticHUD._menu_path = KineticHUD._mod_path .. "menu/"
KineticHUD._updater_id_check_player = "khud_update_check_player"

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

--one menu to rule them all
--all menus are, to some degree, sub-menus of this one
KineticHUD._menu_id_main = "khud_menu_main"

KineticHUD._populated_menus = {}

---once menus are populated, add them to this queue
--they are then built, and should be usable in-game
KineticHUD._queued_build_menus = {} --deprecated

--registers submenus for menu objects
KineticHUD._queued_add_menus = {} --deprecated

--holds ordered data to generate menus;
--mainly done to allow dynamic menu option insertion and also to avoid using json menus 
KineticHUD._menu_ids = {
--[[
	"khud_menu_layouts",
		"khud_menu_layouts_player",
			"khud_menu_layouts_player_vitals",
				"khud_menu_layouts_player_vitals_armor",
				"khud_menu_layouts_player_vitals_health",
				"khud_menu_layouts_player_vitals_revives",
			"khud_menu_layouts_player_weapons",
		"khud_menu_layouts_teammates",
		"khud_menu_layouts_compass",
		"khud_menu_layouts_assault",
		"khud_menu_layouts_objectives",
		"khud_menu_layouts_hints",
		"khud_menu_layouts_presenter",
		"khud_menu_layouts_buffs"
}

local menu_ids_indev = {
		--]]
		
--todo: preview image for any given menu
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
				children = {
					{ --player layouts
						type = "menu",
						id = "khud_menu_layouts_player",
						title = "khud_menu_layouts_player_title",
						desc = "khud_menu_layouts_player_desc",
						children = {
							{
								type = "menu",
								id = "khud_menu_layouts_player_vitals",
								title = "khud_menu_layouts_player_vitals_title",
								desc = "khud_menu_layouts_player_vitals_desc",
								children = {
									{
										type = "menu",
										id = "khud_menu_layouts_player_vitals_health",
										title = "khud_menu_layouts_player_vitals_health_title",
										desc = "khud_menu_layouts_player_vitals_health_desc",
										children = {
											--health customization here
										}
									},
									{
										type = "menu",
										id = "khud_menu_layouts_player_vitals_armor",
										title = "khud_menu_layouts_player_vitals_armor_title",
										desc = "khud_menu_layouts_player_vitals_armor_desc",
										children = {
											--armor customization here
										}
									}
									--vitals layout customization here
								}
							},
							{
								type = "menu",
								id = "khud_menu_layouts_player_weapons",
								title = "khud_menu_layouts_player_weapons_title",
								desc = "khud_menu_layouts_player_weapons_desc",
								children = {
									--weapons customization here
									{
										type = "slider",
										id = "khud_player_weapons_panel_set_scale",
										title = "khud_player_weapons_panel_set_scale_title",
										desc = "khud_player_weapons_panel_set_scale_title",
										callback = "callback_khud_player_weapons_panel_set_scale",
										value = "player_weapons_panel_scale",
										default_value = 1,
										min = 0,
										max = 3,
										step = 0.1
									},
									{		
										type = "slider",
										id = "khud_player_weapons_panel_set_x",
										title = "khud_player_weapons_panel_set_x_title",
										description = "khud_player_weapons_panel_set_x_desc",
										callback = "callback_khud_player_weapons_panel_set_x",
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
										value = "player_weapons_panel_y",
										default_value = 1,
										min = 0,
										max = 1024,
										step = 1
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
						children = {
						
						}
					}
				}
			},
			{ --objectives
				type = "menu",
				id = "khud_menu_layouts_objectives",
				title = "khud_menu_layouts_objectives_title",
				desc = "khud_menu_layouts_objectives_desc",
				children = {
				
				}
			},
			{ --assault
				type = "menu",
				id = "khud_menu_layouts_assault",
				title = "khud_menu_layouts_assault_title",
				desc = "khud_menu_layouts_assault_desc",
				children = {
				
				}
			},
			{ --interaction
				type = "menu",
				id = "khud_menu_layouts_interaction",
				title = "khud_menu_layouts_interaction_title",
				desc = "khud_menu_layouts_interaction_desc",
				children = {
				
				}
			},
			{ --hints
				type = "menu",
				id = "khud_menu_layouts_hints",
				title = "khud_menu_layouts_hints_title",
				desc = "khud_menu_layouts_hints_desc",
				children = {
				
				}
			},
			{ --presenter
				type = "menu",
				id = "khud_menu_layouts_presenter",
				title = "khud_menu_layouts_presenter_title",
				desc = "khud_menu_layouts_presenter_desc",
				children = {
				
				}
			},
			{ --chat
				type = "menu",
				id = "khud_menu_layouts_chat",
				title = "khud_menu_layouts_chat_title",
				desc = "khud_menu_layouts_chat_desc",
				children = {
				
				}
			},
			{ --hit direction
				type = "menu",
				id = "khud_menu_layouts_hitdirection",
				title = "khud_menu_layouts_hitdirection_title",
				desc = "khud_menu_layouts_hitdirection_desc",
				children = {
				
				}
			},
			{ --waypoints
				type = "menu",
				id = "khud_menu_layouts_waypoints",
				title = "khud_menu_layouts_waypoints_title",
				desc = "khud_menu_layouts_waypoints_desc",
				children = {
				
				}
			},
			{ --custody/trade timer
				type = "menu",
				id = "khud_menu_layouts_custody",
				title = "khud_menu_layouts_custody_title",
				desc = "khud_menu_layouts_custody_desc",
				children = {
				
				}
			},
			{ --drop in/waiting hud
				type = "menu",
				id = "khud_menu_layouts_waiting",
				title = "khud_menu_layouts_waiting_title",
				desc = "khud_menu_layouts_waiting_desc",
				children = {
				
				}
			},
			{ --detection/suspicion
				type = "menu",
				id = "khud_menu_layouts_suspicion",
				title = "khud_menu_layouts_suspicion_title",
				desc = "khud_menu_layouts_suspicion_desc",
				children = {
				
				}
			},
			{ --buffs
				type = "menu",
				id = "khud_menu_layouts_buffs",
				title = "khud_menu_layouts_buffs_title",
				desc = "khud_menu_layouts_buffs_desc",
				children = {
				
				}
			},
			{ --cartographer, compass, (includes heist name popup)
				type = "menu",
				id = "khud_menu_layouts_cartographer",
				title = "khud_menu_layouts_cartographer_title",
				desc = "khud_menu_layouts_cartographer_desc",
				children = {
					{ --compass
						type = "menu",
						id = "khud_menu_layouts_cartographer_compass",
						title = "khud_menu_layouts_cartographer_compass_title",
						desc = "khud_menu_layouts_cartographer_compass_desc",
						children = {
						
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
	teammate_health = {}
}

KineticHUD._teammate_panels = {}

--number values used for sizing, positioning etc. which should not be change-able by settings
KineticHUD.hud_values = {
	world_panels = {
		{
			name = "left_panel",
			localized_name = "khud_panel_left_title",
			TEXT = "LEFT PANEL",
			WORLD_W = 5,
			WORLD_H = 10,
			GUI_W = 500,
			GUI_H = 1000,
			OFFSET_YAW = 15,
			OFFSET_PITCH = 90,
			OFFSET_ROLL = 0,
			OFFSET_X = -5.25,
			OFFSET_Y = 0,
			OFFSET_Z = -10,
			RECT_COLOR = Color.red
		},
		{
			name = "right_panel",
			localized_name = "khud_panel_right_title",
			TEXT = "RIGHT PANEL",
			WORLD_W = 5,
			WORLD_H = 10,
			GUI_W = 500,
			GUI_H = 1000,
			OFFSET_YAW = -15,
			OFFSET_PITCH = 90,
			OFFSET_ROLL = 0,
			OFFSET_X = 5.25,
			OFFSET_Y = 0,
			OFFSET_Z = -10,
			RECT_COLOR = Color.blue
		},
		{
			name = "top_panel",
			localized_name = "khud_panel_top_title",
			TEXT = "TOP PANEL",
			WORLD_W = 11,
			WORLD_H = 6,
			GUI_W = 1100,
			GUI_H = 600,
			OFFSET_YAW = 0,
			OFFSET_PITCH = 90 + 10,
			OFFSET_ROLL = 0,
			OFFSET_X = 0,
			OFFSET_Y = 1.5,
			OFFSET_Z = -10,
			RECT_COLOR = Color.yellow
		},
		{
			name = "bottom_panel",
			localized_name = "khud_panel_bottom_title",
			TEXT = "BOTTOM PANEL",
			WORLD_W = 11,
			WORLD_H = 6,
			GUI_W = 1100,
			GUI_H = 600,
			OFFSET_YAW = 0,
			OFFSET_PITCH = 90 - 10,
			OFFSET_ROLL = 0,
			OFFSET_X = 0,
			OFFSET_Y = -1.5,
			OFFSET_Z = -10,
			RECT_COLOR = Color.green
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
	
	PLAYER_WEAPON_HUD_ANIMATION_SWAP_DURATION = 1/3,
	
	PLAYER_WEAPONS_W = 500,
	PLAYER_WEAPONS_H = 400,
	PLAYER_WEAPONS_X = 0,
	PLAYER_WEAPONS_Y = 750,
	
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
	TEAMMATE_PANEL_Y = 0,
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
	
	TEAMMATE_DEPLOYABLE_X = 0,
	TEAMMATE_DEPLOYABLE_Y = 0,
	TEAMMATE_REVIVES_FONT_SIZE = 20,
	
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

KineticHUD.debug_value_1 = 0.5

--default settings
KineticHUD.default_settings = {
	player_panel_scale = 1, --deprecated
	player_vitals_panel_scale = 1,
	player_weapons_panel_scale = 1,
	player_weapons_panel_x = 0,
	player_weapons_panel_y = 750,
	teammate_panel_scale = 1,
	PLAYER_HEALTH_BAR_HALIGN = 1,
	PLAYER_HEALTH_BAR_VALIGN = 1,
	HEIST_TIMER_FONT_SIZE = 24
}

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
KineticHUD._animate_targets = {}
KineticHUD._num_animate_waits = 0
function KineticHUD:animate(target,func,done_cb,...)
	if target then 
		if type(func) == "function" then 
		elseif type(self[tostring(func)]) == "function" then
			func = self[tostring(func)]
		else
			self:log("ERROR: Unknown/unsupported animate function type: " .. tostring(func) .. " (" .. type(func) .. ")",{color=Color.red})
			return
		end
		if (type(target) == "number") or alive(target) then
			self._animate_targets[tostring(target)] = {
				func = func,
				target = target,
				start_t = Application:time(),
				done_cb = done_cb,
				params = {
					...
				}
			}
		end
	end
end

function KineticHUD:animate_wait(timer,callback,...)
	self._num_animate_waits = self._num_animate_waits + 1
	self:animate(self._num_animate_waits,self._animate_wait,callback,timer,...)
end

function KineticHUD._animate_wait(o,t,dt,start_t,duration)
	if (t - start_t) >= duration then 
		return true
	end
end

function KineticHUD:animate_stop(name,do_cb)
	local item = self._animate_targets[tostring(name)]
	if item and do_cb and (type(item.done_cb) == "function") then 
		return item.done_cb(item.target,unpack(item.params))
	end
end

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

function KineticHUD:UpdateAnimate(t,dt)
	for id,data in pairs(self._animate_targets) do 
		if data and data.target and ((type(data.target) == "number") or alive(data.target)) then 
			local result = data.func(data.target,t,dt,data.start_t,unpack(data.params or {}))
			if result then 
				if type(data.done_cb) == "function" then 
					local done_cb = data.done_cb
					local target = data.target
					local params = data.params
					self._animate_targets[id] = nil
					done_cb(target,unpack(params))
--					data.done_cb(data.target,unpack(data.params))
				else
					self._animate_targets[id] = nil
				end
			end
		else
			self._animate_targets[id] = nil
		end
	end
end








function KineticHUD.callback_show_colorpicker_missing_prompt()
	local loc = callback(managers.localization,managers.localization,"text")
	QuickMenu:new(loc("title"),loc("desc"),{
		{
			text = loc("Yes"),
			callback = callback(self,self,"ClearCartographerData",true)
		},
		{
			text = loc("Cancel"),
			callback = callback(self,self,"Create_Cartographer_Menu")
		}
	},true)
end










--io

function KineticHUD:Load()
	local file = io.open(KineticHUD._save_path, "r")
	if (file) then
		for k, v in pairs(json.decode(file:read("*all"))) do
			KineticHUD.settings[k] = v
		end
	else
		KineticHUD:Save()
	end
end

function KineticHUD:Save()
	local file = io.open(KineticHUD._save_path,"w+")
	if file then
		file:write(json.encode(KineticHUD.settings))
		file:close()
	end
end


return KineticHUD

--[[
AESTHETICS
	* Digital-retro?
		Filament displays
		Dot Matrix displays
		Nixie Tube displays/vacuum fluorescent
	* Glass projections:
		see Apex Legends
		lots of glows and gradients and partial transparency
	* Art deco
		* Prey
	* "Guiding lines"?
		See: The Division's world hud placement
	
ASSETS
	* better main font?
		* also a version with a shadow?
	* better seven-segment digital font?
		* italicized
		* even spacing
		* bg shading (simulating empty leds)
	* firemode indicator
		* larger margins, relatively smaller circles
		* individual dot texture?
	* player cross/heart/revive texture?
	* teammate deaths texture?
		* progressively become more damaged with more revives?
		* show significant difference when user is on predicted/synced last down? eg. bw
	* bpm states
		* generally okay (75 < x < 100% hp)
		* kinda hecked up (50 < x < 75% hp)
		* woah where's your blood (33 < x < 50% hp)
		* you are going to die (0 < x < 33%)
		* omae wa mou shindeiru (0 / downed)
	
HUD SEGMENTS
	SPEAKING INDICATOR:
		See: The Division's voice waveform analysis animation
	
	HEIST TIMER:
		* seven-segment number display?
	
	COMPASS:
		- Top
		* Linear style?
		* Circular icon style?
	
	HEIST NAME
		- Top left
		- region popup at mission start? eg. WASHINGTON DC a la Destiny 2
	
	OBJECTIVE
		- Top left?
		
		* Title
		* Description
	
	
	CRIMINALS:
		- Teammates (3)
			* Name
				* Name Color
				* Title (Dredgen etc)
			* Weapons
				* Current/Total ammo
				
				- Primary
				- Secondary
			* Vitals
				* Health
					* heartrate animation?
					* health meter/number above head in waypoint?
				* ExPres
				* Maniac
				* Armor
				* Revives
			* Mission Equipment
			* Deployables
			* Throwables
			
			
			
		- Player (1)
			* General Status
				Vitals animation?
					* that'll be fun to make
				
			* Name
				* Name Color
				* Title (Dredgen etc)
			* Concealment?
				- Stealth Only
			* Weapons (Primary, Secondary, Current Underbarrel)
				* Current / Total Ammo
				* Firemode
				* Icons?
				* Kills
				
			* Melee
				* Icon?
				* Kills?
				
			* Mission Equipment
				- Theoretically, many possible
			* Deployables
				* Optional Icons?
				- Primary 
				- Secondary
				- Top left? With unified Loadout?
			* Throwables
				* Icon?
				* Name?
				* Counter
				* Cooldown meter
			* Vitals
				* Health
					- Counter?
					- Bottom of screen?
					* Health Lost chunking animation?
					* low health screen effect?
						* division red screen border style?
						* cod blood spatter style?
				* Armor
					- Counter?
				* Revives
					- Counter
					- Icon?
					- Name?
				* ExPres
				* Maniac
				* Stamina
					- Counter?
						* probably not
					- Meter?
					- Name?
					- Icon?
	
	CROSSHAIR:
		* bullet prediction
			( concentric targeting boxes in 3d space )
	
	HINT:
		* Yes
		
	CHAT:
		- Bottom left?
	
	INTERACTION
		
	DETECTION:
		* Enemy detection icon animations instead of simple exclamation points appearing?
		* Replace the boring DETECTED text

	ASSAULT:
		* Phase
		* Timer
			* to 1/10 second
		* Hostages
			* Counter
			* Icon?
			* Name?

	HIT DIRECTION:
		
	WAYPOINTS:
		* waypoints on compass??????
		* teammate health
		* sentries
	
	MISC:
		* Trade Timer
		* Drop-in Waiting
		* Camera Overlay
		* Driving



CORE TENETS:
	hud customizability:
		each element should have a changeable scale
		each element should have a changeable position
		hud movable by mouse dragging?
	compatibility/modularity:
		do not break other mods if at all possible
		do not be broken by other mods if at all possible
		option to disable the hooks or functions in commonly used functions, if hooked, to allow for increased compatibility and also customization
		state flags for whether a given hud component is loaded should be checked when using hud setter functions, to allow for modularity/customization in enabling/disabling hud elements
	information:
		add information. you can move it, but don't remove it.
	accessibility:
		colorblind options:
			changeable colors for any given hud color





SYSTEMS:
	* get/set color through settings
	* buff tracker
		* allow intuitive menu enabling/disabling of buffs
			* see khud organization



DEVELOPMENT TODO:

	test world_to_screen on world panels (update/persist script with static location paired with console settracker)

DESIRED FEATURES:

	button prompts next to hud icons?

	april fool's: when shot, there is a 1% chance your hud will fall off of your face and to the ground, and you will need to pick it up or wait x minutes for it to regrow

	buff counter



teammates:
option to show data on their waypoint, or data on the hud, or both (or neither)




TODO
Fix down counter


"titles" (dredgen etc)
grenade charge meter
removed secondary deployable meter


--]]
local mod_path = KineticHUD and KineticHUD._mod_path or (KineticHUD.GetPath and KineticHUD:GetPath()) or ModPath
if not KineticHUD then 
	dofile(mod_path .. "khud_core.lua")
end

KineticHUD._mod_path = KineticHUD._mod_path or mod_path


--Writes information for debugging to the appropriate output. Calls global function Log() with all arguments passed if defined (namely, by the Developer Console mod), else uses log() (from BLT)
--Arguments: any (content agnostic)
--Returns: nil
function KineticHUD:c_log(...)
	local f = Log or log
	return f(...)
end

--Called once to start the HUD initialization process, along with a reference to the parent hud for optional "flat" panel usage.
--Arguments: parent_panel [Panel]. The panel object to create the HUD on.
--Returns: nil
function KineticHUD:Setup(parent_panel)
	self._gui = World:newgui()
	self:CreateWorldPanels()
	self:CreateHUD(parent_panel)
	
	BeardLib:AddUpdater("kinetichud_update",callback(self,self,"Update"))
	
	self:RegisterUpdateCheckPlayer()
end

--Create world panels to be linked later, and stores them in a table. 
--Returns: nil
function KineticHUD:CreateWorldPanels()
	for i,panel_data in pairs(self.hud_values.world_panels) do 
		local panel_w = panel_data.GUI_W
		local panel_h = panel_data.GUI_H
		local panel_name = panel_data.name
		local panel_text = panel_data.TEXT
		local rect_color = panel_data.RECT_COLOR
		
		local ws = self._gui:create_world_workspace(panel_w,panel_h,Vector3(),Vector3(),Vector3())
	
		local panel = ws:panel():panel({
			name = panel_name,
			layer = 1
		})
		
		local text = panel:text({
			name = "text",
			color = Color.white,
			font = self._fonts.grotesk,
			text = panel_text,
			vertical = "center",
			align = "center",
			layer = 2,
			font_size = 32
		})
		local rect = panel:rect({
			color = rect_color,
			layer = -1,
			alpha = 0.2
		})
		
		self._workspaces[panel_name] = ws
		self._world_panels[i] = panel
	end
end

--Creates the main HUD elements onto the appropriate panel, depending on user options.
--Safe to call multiple times, as it removes preexisting duplicate HUD elements.
--Arguments: parent_panel [Panel]. The panel object to create the HUD on.
--Returns: nil
function KineticHUD:CreateHUD(parent_panel)
		
	self._parent_panel = parent_panel
	if alive(self._base)  then 
		parent_panel:remove(self._base)
	end
	local base = parent_panel:panel({
		name = "kinetichud"
	})
	self._panel = base
	
	self:CreatePlayerVitalsPanel()
	self:CreatePlayerWeaponsPanel()
	--[[

	--create teammates panel
	self._teammates = base:panel({
		name = "teammates"
	})
	
	self._player = base:panel({
		name = "player"
	})
	self:_create_player(self._player)
--]]	
	
end

--Creates the a HUD element to hold:
--The player's health, armor, damage absorption, stored health, and revives,
--and then positions and scales each element according to user settings.
--Arguments: skip_layout [bool]. Optional. If true, skips the HUD positioning step after creation.
--Returns: nil
function KineticHUD:CreatePlayerVitalsPanel(skip_layout)
	local selected_parent_panel = self._world_panels[4]
	local scale = self.settings.player_panel_scale
	
	local vitals_panel = selected_parent_panel:panel({
		name = "vitals_master",
		visible = true
		--todo custom x/y here
	})
	
--VITALS
--[[
	local armor_label = vitals_panel:text({
		name = "armor_label",
		text = "AP",
		color = Color.white,
		font = self._fonts.grotesk,
		x = self.hud_values.PLAYER_ARMOR_BAR_X * scale,
		y = self.hud_values.PLAYER_ARMOR_BAR_Y * scale,
		align = "left",
		layer = 2,
		font_size = 32
	})
	local a_w,a_h,a_x,a_y = armor_label:text_rect()
	--]]
	local armor_bar = vitals_panel:bitmap({
		name = "armor_bar",
		texture = "textures/ui/health_bar",
		w = self.hud_values.PLAYER_ARMOR_BAR_W * scale,
		h = self.hud_values.PLAYER_ARMOR_BAR_H * scale,
		x = self.hud_values.PLAYER_ARMOR_BAR_X * scale,
		y = self.hud_values.PLAYER_ARMOR_BAR_Y * scale
	})
	local armor_fill = vitals_panel:bitmap({
		name = "armor_fill",
		texture = "textures/ui/health_fill",
		w = self.hud_values.PLAYER_ARMOR_BAR_W * scale,
		h = self.hud_values.PLAYER_ARMOR_BAR_H * scale,
		x = self.hud_values.PLAYER_ARMOR_BAR_X * scale,
		y = self.hud_values.PLAYER_ARMOR_BAR_Y * scale
	})

	local health_bar = vitals_panel:bitmap({
		name = "health_bar",
		texture = "textures/ui/health_bar",
		w = self.hud_values.PLAYER_HEALTH_BAR_W * scale,
		h = self.hud_values.PLAYER_HEALTH_BAR_H * scale,
		x = self.hud_values.PLAYER_HEALTH_BAR_X * scale,
		y = self.hud_values.PLAYER_HEALTH_BAR_Y * scale
	})
	
	local health_fill = vitals_panel:bitmap({
		name = "health_fill",
		texture = "textures/ui/health_fill",
		w = self.hud_values.PLAYER_HEALTH_BAR_W * scale,
		h = self.hud_values.PLAYER_HEALTH_BAR_H * scale,
		x = self.hud_values.PLAYER_HEALTH_BAR_X * scale,
		y = self.hud_values.PLAYER_HEALTH_BAR_Y * scale
	})
	if not skip_layout then 
		self:LayoutPlayerVitals()
	end
end

--Arranges the subelements of the HUD panel that contains the player's health, armor, etc. 
--Arguments: none
--Returns: nil
function KineticHUD:LayoutPlayerVitals()

end

--Creates rectangular border of varying color/thickness on the inside edge of a specified panel.
--If the border already exists, modifies the border and returns it.
--Arguments:
	--panel: [Panel] panel to apply to (revolver ocelot [revolver ocelot])
	--params; [table] table containing optional values
		--width (also "thickness", "stroke", or "weight": [float] border thickness (w value for left/right, or h value for top/bot)
		--color: [Color] color of border (revolver ocelot [revolver {revolver ocelot} ocelot])
		--[NOT SUPPORTED] rotation: [float] (range [0-360])
		--blend mode: [string] ("add","sub","normal")
		--alpha: [float] (range [0,1]) transparency of border
		--margin: [float] offset from square outside edges. essentially scale, but using linear pixel offset. Because of parent panel boundaries, you cannot make borders outside of its parent panel area. 
		--layer: [float] panel layer. higher values are closer to the top (?)
		--id_prefix: [string] appended to internal panel names. Advised, but not strictly necessary unless you're applying multiple borders to one panel object.
--Returns: resulting border panel [Panel],whether the border already existed or not [bool]
function KineticHUD:PanelBorder(panel,params)
	if not (panel and alive(panel)) then
		KineticHUD:c_log("Error: Invalid panel argument for function panel_border(" .. tostring(panel) .. ",{ " .. table.concat(params,",") .." } )")
		return
	end
	local blend_mode = params.blend_mode or "normal"
	local thiccness = params.width or params.thickness or	 params.stroke or params.weight or 1
	local color = params.color or Color.white
	local margin = params.margin or 0 --can be negative
	local layer = params.layer
	local id_prefix = params.id_prefix or ""
	local id = id_prefix .. "panel_borders"
	local alpha = params.alpha or 1
	local name = panel:name()
	local h = params.h or panel:h()
	local w = params.w or panel:w()
	local borders = panel:child(id)
	local exists = false
	if not alive(borders) then 
		borders = panel:panel({
			name = id,
			layer = layer,
--			rotation = rotation,
			alpha = alpha
		})
		local left = borders:rect({
			name = name .. "_border_left",
			w = thiccness,
			h = h - ((thiccness + margin ) * 2),
			x = margin,
			y = margin + thiccness,
			blend_mode = blend_mode,
			color = color
		})
		local right = borders:rect({
			name = name .. "_border_right",
			w = thiccness,
			h = h - ((thiccness + margin ) * 2),
			x = w - (margin + thiccness),
			y = margin + thiccness,
			blend_mode = blend_mode,
			color = color
		})
		local top = borders:rect({
			name = name .. "_border_top",
			w = w - (margin * 2),
			h = thiccness,
			x = margin,
			y = margin,
			blend_mode = blend_mode,
			color = color
		})
		local bottom = borders:rect({
			name = name .. "_border_bottom",
			w = w - (margin * 2),
			h = thiccness,
			x = margin,
			y = h - (margin + thiccness),
			blend_mode = blend_mode,
			color = color
		})
	else
		exists = true
		local left = borders:child(name .. "_border_left")
		local right = borders:child(name .. "_border_right")
		local top = borders:child(name .. "_border_top")
		local bottom = borders:child(name .. "_border_bottom")
		if layer then
			borders:set_layer(layer)
		end
--		borders:set_rotation(rotation)
		left:set_w(thiccness)
		left:set_h(h - (margin * 2))
		left:set_x(margin)
		left:set_y(margin)
		left:set_color(color)
		
		right:set_w(thiccness)
		right:set_h(h - (margin * 2))
		right:set_x(w - (margin + thiccness))
		right:set_y(margin)
		right:set_color(color)
		
		top:set_w(w - (margin * 2))
		top:set_h(thiccness)
		top:set_x(margin)
		top:set_y(margin)
		top:set_color(color)
		
		bottom:set_w(w - (margin * 2))
		bottom:set_h(thiccness)
		bottom:set_x(margin)
		bottom:set_y(h - (margin + thiccness))
		bottom:set_color(color)
	end
	return borders,exists --rip borders, killed by amazon. you deserved better
end


--Creates the a HUD element to hold information about the player's current weapons. (Two weapons in vanilla, the Primary and Secondary)
--Each weapon panel has one of the following: Kill counter, Weapon icon, Firemode indicator, Magazine counter, Reserve counter, Underbarrel ammo counter.
--After creation, the HUD elements are positioned and scaled according to user settings.
--Arguments: skip_layout [bool]. If true, skips the positioning step after creation.
--Returns: nil
function KineticHUD:CreatePlayerWeaponsPanel()
	local selected_parent_panel = self._world_panels[2]
	local parent_weapons_panel = selected_parent_panel:panel({
		name = "weapons_panel",
--		w = 400,
		h = 400,
		x = 0,
		y = 800
	})
--todo straighten out layers (integers only)
--todo put vertical offset in weapons_panel as well as in subpanels
	local function create_weapon_subpanel(index,scale)
			
		local box_w = 200 * scale
		local box_h = 100 * scale
		local font_size_large = 32 * scale
		local font_size_small = 24 * scale
		
		local weapon_panel = parent_weapons_panel:panel({
			name = tostring(index),
--			y = 500,
--			w = 400,
			h = box_h
		})
		
		local icon_box = weapon_panel:panel({
			name = "icon_box",
			x = 50,
			w = box_w,
			h = box_h
		})
		local icon_bitmap = icon_box:bitmap({
			name = "icon_bitmap",
			texture = "",
			w = box_w,
			h = box_h,
			layer = 1
		})
		icon_bitmap:set_image(managers.blackmarket:get_weapon_icon_path("amcar"))
		icon_bitmap:set_size(box_w,box_h)
		
		local icon_bg = icon_box:bitmap({
			name = "icon_bg",
			texture = nil,
			color = Color.black,
			blend_mode = "multiply",
			alpha = 0.5,
			layer = 0
		})
		
		local border = self:PanelBorder(icon_box,{
			thickness = 2,
			color = Color.white,
			alpha = 0.8,
			layer = 2
		})
		
		--todo firemode scale
		local firemode = weapon_panel:bitmap({
			name = "firemode",
			x = icon_box:right() + 4,
			y = icon_box:y(),
			texture = "textures/ui/firemode_dots_3",
--			visible = false,
			layer = 3
		})
		firemode:set_y((weapon_panel:h() - firemode:h()) / 2)
		
		
		--note: right() seems to use world right (including x of parent panel)
		local magazine = weapon_panel:text({
			name = "magazine",
			color = Color.white,
			font = self._fonts.digital,
			text = "123",
			vertical = "bottom",
			x = firemode:right() + 8,
			y = - box_h / 20,
			layer = 4,
			font_size = font_size_large
		})
		local reserve = weapon_panel:text({
			name = "reserve",
			color = Color.white,
			font = self._fonts.digital,
			text = "999",
			vertical = "bottom",
			x = firemode:right() + (84 * scale),
			y = - box_h / 20,
			layer = 4,
			font_size = font_size_small
		})
		
		local mag_x,_,_,mag_h = magazine:text_rect()
		
		--[[
		
		name = "hp_gradient",
		layer = 2,
		blend_mode = "add",
		x = (- bar_hp_bg_panel:h() + bar_hp_bg_panel:w()) / 2, --todo hp_gradient:set_center(x,y)
		y = (bar_hp_bg_panel:h() - bar_hp_bg_panel:w()) / 2,
		w = bar_hp_bg_panel:h(),
		h = bar_hp_bg_panel:w(),
		valign = "grow",
		rotation = 90,
		--]]
		local gradient_bg = weapon_panel:gradient({
			name = "gradient_bg",
			blend_mode = "multiply",
			valign = "grow",
			x = magazine:x(),
			y = box_h - (box_h - mag_h),
			w = 200,
			h = box_h - mag_h,
			alpha = 1,
			layer = 1.5,
			gradient_points = {
				0,
				Color.black,
				1,
				Color.black:with_alpha(1)
			}
		})
		
		--todo create subpanel to hold + center these text objects
		--todo center vertically but move each away from center? or set vertical top and bottom, from y = vertical center plus margin
		local kill_icon = weapon_panel:text({
			name = "kill_icon",
			color = Color.white,
			font = self._fonts.large,
			text = self.special_characters.skull,
			align = "right",
			vertical = "top",
			x = -8 + - (weapon_panel:w() -icon_box:x()),
			y = box_h / 20,
			layer = 4,
			font_size = font_size_large
		})
		
		local kill_counter = weapon_panel:text({
			name = "kill_counter",
			color = Color.white,
			font = self._fonts.digital,
			text = "0",
			align = "right",
			vertical = "bottom",
			x = -8 + - (weapon_panel:w() -icon_box:x()),
			y = - box_h / 20,
			layer = 4,
			font_size = font_size_large
		})
		local debug_rect = weapon_panel:rect({
			name = "debug",
			visible = false,
			alpha = 0.2,
			color = Color.red
		})
		
		return weapon_panel
	end
	
--	local inventory = managers.player:local_player():inventory()
	
--	for i,selection_data in ipairs(#inventory._available_selections) do
--		create_weapon_subpanel(i)
--	end
	local primary = create_weapon_subpanel(1,1)
	local secondary = create_weapon_subpanel(2,0.75)
	secondary:set_x(100)
	secondary:set_y(125)
--	create_weapon_subpanel(2)
	
	
end


--Links world panels created from CreateWorldPanels() to the player camera object.
--If successfully attempted to link at least one panel, returns true. Else, returns false.
--Returns: bool
function KineticHUD:LinkWS(link_target_object)
	local done_any = false
	for i,panel in pairs(self._world_panels) do 
		local hv = self.hud_values.world_panels[i]
		local workspace = self._workspaces[hv.name]
		
		local world_w = hv.WORLD_W
		local world_h = hv.WORLD_H
		local panel_w = hv.GUI_W
		local panel_h = hv.GUI_H
		
		local ra = link_target_object:rotation()
		
		local rb = Rotation(hv.OFFSET_YAW,hv.OFFSET_PITCH,hv.OFFSET_ROLL)
		
		local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
		
		local x_axis = Vector3(world_w,0,0)
		
		mvector3.rotate_with(x_axis,rot)
		
		local y_axis = Vector3(0,-world_h,0)
		
		mvector3.rotate_with(y_axis,rot)
		
		local center = Vector3(world_w / 2,-world_h / 2)
		
		mvector3.rotate_with(center,rot)
		
		local offset = Vector3(hv.OFFSET_X,hv.OFFSET_Y,hv.OFFSET_Z)
			--x+ is distance right
			--y+ is distance upward
			--z+ is distance backward
			
		mvector3.rotate_with(offset,rot)
		
		local position = link_target_object:position()
		workspace:set_linked(panel_w,panel_h,link_target_object,position - center + offset,x_axis,y_axis)
		done_any = true
	end
	return done_any
end

--Removes the updater from RegisterUpdateCheckPlayer(), which called UpdateCheckPlayer(). This is safe to call multiple times.
function KineticHUD:UnregisterUpdateCheckPlayer()
	BeardLib:RemoveUpdater(self._updater_id_check_player)
end

--Each frame, attempts to find the player unit, in order to link the world panels to the player camera.
--Upon success, it calls its own unregistration in order to save performance.
--Do not call manually- instead, call the update registration function RegisterUpdateCheckPlayer().
function KineticHUD:UpdateCheckPlayer(t,dt)
	local player = managers.player:local_player()
	if alive(player) then 
		if self:LinkWS(player:camera()._camera_object) then
			self:UnregisterUpdateCheckPlayer()
		end
	end
end

--Adds the updater, which calls UpdateCheckPlayer(). This is safe to call multiple times.
function KineticHUD:RegisterUpdateCheckPlayer()
	self:UnregisterUpdateCheckPlayer()
	BeardLib:AddUpdater(self._updater_id_check_player,callback(self,self,"UpdateCheckPlayer"))
end





function KineticHUD:SetTeammateHealth(current,total)
	
end

function KineticHUD:SetPlayerHealth(current,total)

end

function KineticHUD:UpdateHUD(t,dt)
	local player = managers.player:local_player()
	if player then
		
	end		
end


function KineticHUD:SetRevives(i,current)
	
end

function KineticHUD:SetHealth(i,current,total)
--		self._worldhud_base:child("health_fill"):set_texture_rect(0,0,(self.hud_data.hp_w / self.hud_data.hp_scale) * current / total,self.hud_data.hp_h / self.hud_data.hp_scale)
end


--load hud buff data
dofile(KineticHUD._mod_path .. "buff/buff_data.lua")





--marked for deprecation below this line




--Creates the main player's vitals.
function KineticHUD:_create_player(panel)
	local scale = self.settings.player_panel_scale
	
	local vitals_panel = panel:panel({
		name = "vitals_master",
		visible = false
		--todo custom x/y here
	})
	
--VITALS	
	local armor_bar = vitals_panel:bitmap({
		name = "armor_bar",
		texture = "textures/ui/health_bar",
		w = self.hud_values.PLAYER_ARMOR_BAR_W * scale,
		h = self.hud_values.PLAYER_ARMOR_BAR_H * scale,
		x = self.hud_values.PLAYER_ARMOR_BAR_X * scale,
		y = self.hud_values.PLAYER_ARMOR_BAR_Y * scale
	})
	local armor_fill = vitals_panel:bitmap({
		name = "armor_fill",
		texture = "textures/ui/health_fill",
		w = self.hud_values.PLAYER_ARMOR_BAR_W * scale,
		h = self.hud_values.PLAYER_ARMOR_BAR_H * scale,
		x = self.hud_values.PLAYER_ARMOR_BAR_X * scale,
		y = self.hud_values.PLAYER_ARMOR_BAR_Y * scale
	})
	
	local health_bar = vitals_panel:bitmap({
		name = "health_bar",
		texture = "textures/ui/health_bar",
		w = self.hud_values.PLAYER_HEALTH_BAR_W * scale,
		h = self.hud_values.PLAYER_HEALTH_BAR_H * scale,
		x = self.hud_values.PLAYER_HEALTH_BAR_X * scale,
		y = self.hud_values.PLAYER_HEALTH_BAR_Y * scale
	})
	
	local health_fill = vitals_panel:bitmap({
		name = "health_fill",
		texture = "textures/ui/health_fill",
		w = self.hud_values.PLAYER_HEALTH_BAR_W * scale,
		h = self.hud_values.PLAYER_HEALTH_BAR_H * scale,
		x = self.hud_values.PLAYER_HEALTH_BAR_X * scale,
		y = self.hud_values.PLAYER_HEALTH_BAR_Y * scale
	})
	
	
--WEAPONS	
	local weapons = panel:panel({
		name = "weapons",
		w = self.hud_values.PLAYER_WEAPONS_W * scale,
		h = self.hud_values.PLAYER_WEAPONS_H * scale,
		x = self.hud_values.PLAYER_WEAPONS_X * scale,
		y = self.hud_values.PLAYER_WEAPONS_Y * scale
	})
	--make each weapon here

--LOADOUT
	--(grenade,melee,zipties,deployable)
	local loadout = panel:panel({
		name = "loadout"
	})
	
	
end

--all teammates, but main player is hidden after call
function KineticHUD:_create_teammate(panel)
	return teammates
end


do return end

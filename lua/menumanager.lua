--[[

DEVELOPMENT:
	CURRENT TODO:
		killcounter
			fire burn deaths count as 2 kills
	
		buffs
			aligns/sizing for buffs panel
			aggregated buffs (dodge, crit, damage resist, regen)
			misc buffs (winters)
			remaining perk deck buffs (throwables, etc)
			player state buffs (tased, downed, electrocuted, flashbanged etc)
			odd buffs (uppers nearby/ready, messiah ready/charged, etc)
			grinder stacks? similar internally stacked perk deck effects like biker
			separate buff handlers for cameras etc?
				loot?
				enemies?
				pickups?
				timers?
				(post-release)
			
			buffs customization menu
				compact
				priority
			--scale should only apply to individual buffs, not the master buffs panel
			
			buff visual sorting/animation
		
		
		reposition with fov (solves ADS and vehicle issues)
		
		resize equipments after menu change (AnimateLayoutPlayerMissionEquipment(true))
		main color scheme
		misc category- eg. heist timer scale
	
		hud tabscreen
	
		preview image for any given menu
		write player equipment
		revives bg
		write alignment code for:
			player vitals
			player equipment
		event hooks for player join/leave to reset values like hud, hp, etc.
		add player cartographer hud element
		add player compass hud element
			waypoints on the compass bar
		implement team mission equipments
		dim digital display counters when empty (eg. weapon ammo, deployable/equipment counts)
		
		--flashing assault light during assaults; different colors based on assault phase (bai compat)
		
		
		underbarrel weapon support for main player
		substitute for world_to_screen on world panels
		non-focused weapon icon is not properly resized on setting the icon image
			
		updater should work when paused?
		
	DESIRED FEATURES:
		button prompts next to hud icons?

		april fool's: when shot, there is a 1% chance your hud will fall off of your face and to the ground, and you will need to pick it up or wait x minutes for it to regrow

		teammates:
		option to show data on their waypoint, or data on the hud, or both (or neither)

		"titles" (dredgen etc)
			-write tweakdata
			-sync data
		grenade charge meter animation

	SYSTEMS:
		* down counter compat
		* get/set color through settings
		* buff tracker
			* allow intuitive menu enabling/disabling of buffs
				* see khud organization

	MENU STRUCTURING: hoo boy this is indeed rough
		* HUD Layout
			* Player
				* Enabled/vanilla/hidden
				* Vitals
					* Health Bar
						* Parent/Scale/Position/Align
						* Fill/Outline/Text Color
					* Armor Bar
						* Parent/Scale/Position/Align
						* Fill/Outline/Text Color
					* Revives
						* Enabled/Disabled
						* Parent/Scale/Position/Align
						* Color
				* Player Weapons
					* Parent/Scale/Position/Align
					* Magazine/Reserves/Kills/Kills Icon/Weapon Icon/Firemode/Box Color
			* Teammates
				* Parent/Scale/Position/Align
				* Toggle: Color by peer id
			* Compass
				* Parent/Scale/Position/Align
				* Color
			* Assault
				* ???
				* BAI Compatibility
			* Objectives
				* Enabled/vanilla/hidden
				* Parent/Scale/Position/Align
				* Color
			* Hints
				* Enabled/disabled
				* Parent/Scale/Position
				* Color
			* Presenter
				* Enabled/disabled
				* Parent/Scale/Position
				* Color
			* Buffs
				* Enabled/disabled
				* Parent/Align
				* Max per Row/Max per Column
				* Color
			* Heist name popup
				* Enabled/disabled
				* Parent/Scale/Position/Align
				* Color
		* Buffs Tracker
			* Applicable Buffs
		* Objectives
			* Popup enabled/disabled
			
----


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
	* version of fonts that have shadows?
		* teammate deaths texture?
			* must be distinct from the "revives" icon since it cannot, by default, indicate actual revives counter
		* progressively become more damaged with more revives?
		* show significant difference when user is on predicted/synced last down? eg. bw
	* bpm states
		(add one more of these?)
		* generally okay (75 < x < 100% hp)
		* kinda hecked up (50 < x < 75% hp)
		* woah where's your blood (33 < x < 50% hp)
		* you are going to die (0 < x < 33%)
		* omae wa mou shindeiru (0 / downed)
	
	faction icons:
		payday gang, swat, fbi, gensec, murkywater, zeal, mexican federals, 
		russian gangsters from hm, russian mercs, ovk mc, cobras from rats, mendoza, 
		sosa cartel, coyopa from border crossing and buluc mansion, honduran from goat sim
		ResDogs is LAPD
		SFPD faction?
	
HUD SEGMENTS
	SPEAKING INDICATOR:
		See: The Division's voice waveform analysis animation
	
	COMPASS:
		- Top
		* Linear style?
		* Circular icon style?
	
	HEIST NAME
		- Top right
		- region popup at mission start? eg. WASHINGTON DC a la Destiny 2
	
	OBJECTIVE
		- Top right
		
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
					* health meter/number above head in waypoint?
				* ExPres
				* Maniac
				* Armor
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
			* Weapons 
				* Underbarrel
				
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
					* Health Lost chunking animation?
					* low health screen effect?
						* division red screen border style?
						* cod blood spatter style?
				* Revives
					- Label?
					- Icon?
				* ExPres
				* Maniac
				* Stamina
					- Meter?
					- Name?
					- Icon?
	
	HINT:
		* Top right, below assault/objective
		
	CHAT:
		- Bottom left?
	
	INTERACTION
		* something good i hope
	DETECTION:
		* Enemy detection icon animations instead of simple exclamation points appearing? (cool lightning bolts crown!)
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
		* Yes
		
	WAYPOINTS:
		* waypoints on compass??????
		* teammate health
		* sentries
	
	MISC:
		* Trade Timer
		* Drop-in Waiting
		* Camera Overlay
		* Driving

	
	HEIST TIMER: (DONE)
		* seven-segment number display?
	

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



--]]
local mod_path = KineticHUD and KineticHUD._mod_path or (KineticHUD.GetPath and KineticHUD:GetPath()) or ModPath
if not KineticHUD then 
	dofile(mod_path .. "khud_core.lua")
end

KineticHUD._mod_path = KineticHUD._mod_path or mod_path

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
		--id_prefix: [string] append	ed to internal panel names. Advised, but not strictly necessary unless you're applying multiple borders to one panel object.
--Returns: resulting border panel [Panel],whether the border already existed or not [bool]
function KineticHUD:PanelBorder(panel,params)
	if not (panel and alive(panel)) then
		self:c_log("Error: Invalid panel argument for function panel_border(" .. tostring(panel) .. ",{ " .. table.concat(params,",") .." } )")
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
		borders:set_size(w,h)
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

function KineticHUD:RegisterCurrentWeaponSelections() --not used
	for i,selection in pairs(player:inventory()) do
		self:RegisterWeaponSelectionByUnit(selection.unit,i)
	end
end

function KineticHUD:RegisterWeaponSelectionByUnit(unit,selection)
	self._cache.selections_by_unit[unit:key()] = selection
end

function KineticHUD:GetSelectionIndexByUnit(unit)
	if alive(unit) then 
		local result = self._cache.selections_by_unit[unit:key()]
		if result == nil then 
			self:RegisterWeaponSelectionByUnit(unit,false)
		end
		return result or false
	end
end

--Sets a text panel's text to a formatted number, using that object's set_text method.
--The number is formatted by clamping it between 0 and the maximum base-10 number of the given number of digits:
--eg. given a digits value of 3, the amount is clamped between 0 and 999; given digits = 5, amount is clamped between 0 and 99999.
--The text object's text is then set to the amount formatted as an integer, padding the result with zeroes.
--This is intended for use with text objects that use the digital (7-segment) font from the base game, since it only supports characters 0-9,
--and digit counters in this HUD are designed with static spacing/kerning in mind.
--Example: SetDigitalText(myTextPanel,12.5,4) --> (text is set to "0012")
--Example 2: SetDigitalText(myTextPanel,413,2) --> (text is set to "99")
--Arguments: text_gui [Text], amount [number], digits [integer]
--Returns: nil
function KineticHUD.SetDigitalText(text_gui,amount,digits)
	text_gui:set_text(string.format("%0" .. tostring(digits) .. "i",math.clamp(0,amount or 0,math.pow(10,digits or 1) - 1) ) )
end

--Hides all workspaces associated with KineticHUD
--Arguments: none
--Returns: nil
function KineticHUD:HideHUD()
	for panel_name,ws in pairs(self._workspaces) do 
		if alive(ws) then 
			ws:hide()
		end
	end
end

--Shows all workspaces associated with KineticHUD
--Arguments: none
--Returns: nil
function KineticHUD:ShowHUD()
	for panel_name,ws in pairs(self._workspaces) do 
		if alive(ws) then 
			ws:show()
		end
	end
end

--Called once to start the HUD initialization process, along with a reference to the parent hud for optional "flat" panel usage. Also loads assets required for the HUD to function
--Arguments: parent_panel [Panel]. The panel object to create the HUD on.
--Returns: nil
function KineticHUD:Setup()
	managers.dyn_resource:load(Idstring("font"), Idstring("fonts/font_digital"), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
	managers.dyn_resource:load(Idstring("texture"), Idstring("fonts/font_digital"), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)

	if managers.network:session() then 
		self._cache.local_peer_id = managers.network:session():local_peer():id()
	end
	
	self._gui = World:newgui()
	self:CreateWorldPanels()
--	self:CreateFlatHUD(parent_panel)
	self:CreateWorldHUD()
	
	BeardLib:AddUpdater("kinetichud_update",callback(self,self,"Update"))
	
	Hooks:Call("khud_on_load_buff_data",self._buff_data)
	
	self:RegisterBuffListeners()
	
	
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
			font = self._fonts.syke,
			text = panel_text,
			vertical = "center",
			align = "center",
			layer = 2,
			font_size = 32,
			visible = false
		})
		
		local rect = panel:rect({
			name = "debug",
			color = rect_color,
			layer = -1,
			alpha = 0.2,
			visible = false
		})
		
		self._workspaces[i] = ws
		self._world_panels[i] = panel
	end
end

--Links world panels created from CreateWorldPanels() to the player camera object.
--If successfully attempted to link at least one panel, returns true. Else, returns false.
--Returns: bool
function KineticHUD:LinkWS(link_target_object)
	local done_any = false
	
	local ws_flat = managers.hud._workspace
	local ws_flat_panel = ws_flat:panel()
	local camera = managers.player:local_player():camera()._camera_object
	for i,panel in ipairs(self._world_panels) do 
		local hv = self.hud_values.world_panels[i]
		local workspace = self._workspaces[i]
		
		local world_w = hv.WORLD_W 
		local world_h = hv.WORLD_H
		
		local w_scale = hv.W_SCALAR
		local h_scale = hv.H_SCALAR
		
		local panel_w = hv.GUI_W
		local panel_h = hv.GUI_H
		local offset_yaw = hv.OFFSET_YAW
		local offset_pitch = hv.OFFSET_PITCH
		local offset_roll = hv.OFFSET_ROLL
		local distance = hv.DISTANCE
		
		local offset_x = hv.OFFSET_X
		local offset_y = hv.OFFSET_Y
		local offset_z = hv.OFFSET_Z
		
		
		if true then 
			
	--		local _topleft = ws_flat:screen_to_world(camera,Vector3(0,0,distance))
	--		local _bottomright = ws_flat:screen_to_world(camera,Vector3(ws_flat_panel:w(),ws_flat_panel:h(),distance))

			local origin = ws_flat:screen_to_world(camera,Vector3(0,0,distance)) --top left
			local origin_center = ws_flat:screen_to_world(camera,Vector3(ws_flat_panel:h()/2,ws_flat_panel:h()/2,0))
			local _right = ws_flat:screen_to_world(camera,Vector3(ws_flat_panel:w(),0,distance))
			local _bottom = ws_flat:screen_to_world(camera,Vector3(0,ws_flat_panel:h(),distance))
			local _fwd = camera:position() + (camera:rotation():y() * distance) --ws_flat:screen_to_world(camera,Vector3(ws_flat_panel:h()/2,ws_flat_panel:h()/2,distance + 1))

			world_w = mvector3.length(_right - origin) * w_scale
			world_h = mvector3.length(_bottom - origin) * h_scale
			
--			local fwd = ws_flat:screen_to_world(camera,Vector3(0,0,distance + yaw_dis)
			
			local x_axis = _right - origin
			local y_axis = _bottom - origin
			local z_axis = _fwd - origin_center
			
			local pos = Vector3()
			local d_x = mvector3.copy(x_axis)
			mvector3.normalize(d_x)
			
			local d_y = mvector3.copy(y_axis)
			mvector3.normalize(d_y)
			
			local d_z = mvector3.copy(z_axis)
			mvector3.normalize(d_z)
			
			
			
			x_axis = d_x * world_w
			y_axis = d_y * world_h
			
			if hv.HALIGN == "right" then 
				
				local _x = math.cos(offset_yaw) * world_w
				local _y = math.sin(offset_yaw) * world_w
				
				pos = _right - (d_x * world_w) - (d_z * _y)
				
				local temp = (d_z * _y) + (d_x * _x)
				x_axis = temp
				
				offset_x = -offset_x
			elseif hv.HALIGN == "center" then 
				--origin_center
				
				local _x = math.cos(offset_yaw) * world_w
				local _y = math.sin(offset_yaw) * world_w
				
				pos = (origin + ((_right - origin) / 2)) - (x_axis / 2) -- (d_x * _x) - (d_z * _y)
				x_axis = (d_z * _y) + (d_x * _x)
				
			else --defaults to "left"
				pos = origin
				local _x = math.cos(offset_yaw) * world_w
				local _y = math.sin(offset_yaw) * world_w
				local temp = (d_z * _y) + (d_x * _x)

				x_axis = temp
--				Draw:brush(Color(1,0,1):with_alpha(0.1)):sphere(origin + temp,1/3)
--				Draw:brush(Color(0,1,1):with_alpha(0.1)):sphere(origin_center,1/3)
--				Console:SetTrackerValue("trackerc",tostring(d_z))
--				Console:SetTrackerValue("trackerd",tostring(d_x))
				
--				Draw:brush(Color(1,0,1):with_alpha(0.5)):line(origin,origin+(x_axis * 5),1)
--				Draw:brush(Color(1,1,0):with_alpha(0.5)):line(origin,origin+(y_axis * 5),1)
--				Draw:brush(Color(0,1,1):with_alpha(0.5)):line(origin,origin+(z_axis * 5),1)
				
			end
			
			if hv.VALIGN == "bottom" then 
				pos = pos + (_bottom - origin) - y_axis
				offset_y = -offset_y
			elseif hv.VALIGN == "center" then 
				pos = pos + ((_bottom - origin) - y_axis) / 2
			else --defaults to "top"
			end
			
			local top_left = pos
			if link_target_object then 
				
--				Draw:brush(Color.red:with_alpha(0.1)):sphere(top_left,1/3)
--				Draw:brush(Color.green:with_alpha(0.1)):sphere(top_left + x_axis,1/3)
--				Draw:brush(Color.blue:with_alpha(0.1)):sphere(top_left + y_axis,1/3)
				
				local offset_pos = (x_axis * offset_x) + (y_axis * offset_y) + (z_axis * offset_z)
				top_left = top_left + offset_pos
				
				workspace:set_linked(panel_w,panel_h,link_target_object,top_left,x_axis,y_axis)
				done_any = true
			end
			
		else
			
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
	end
	return done_any
end

function KineticHUD:LayoutWorldPanels(m)
	m = m or 1
	local player = managers.player:local_player()
	local link_target_object
	if alive(player) then 
		link_target_object = player:camera()._camera_object
	end
	if not alive(link_target_object) then 
		self:c_log("ERROR: LayoutWorldPanels(): no link target object")
		return
	end
	
	for i,panel in ipairs(self._world_panels) do 
		local hv = self.hud_values.world_panels[i]
		local workspace = self._workspaces[i]

		local world_w = hv.WORLD_W
		local world_h = hv.WORLD_H
		local panel_w = hv.GUI_W
		local panel_h = hv.GUI_H
		
		--rotation is already applied relative to the linked object, so we just need the offsets;
		--hence, no rotation adding unlike in LinkWS()
		
		local rot = Rotation(hv.OFFSET_YAW,hv.OFFSET_PITCH,hv.OFFSET_ROLL)
		
		local x_axis = Vector3(world_w,0,0)
		
		mvector3.rotate_with(x_axis,rot)
		
		local y_axis = Vector3(0,-world_h,0)
		
		mvector3.rotate_with(y_axis,rot)
		
		local center = Vector3(world_w / 2,-world_h / 2, 0)
		
		mvector3.rotate_with(center,rot)
		
		local offset = Vector3(hv.OFFSET_X / m,hv.OFFSET_Y / m,hv.OFFSET_Z)
			--x+ is distance right
			--y+ is distance upward
			--z+ is distance backward
			
		mvector3.rotate_with(offset,rot)
		
		local position = link_target_object:position()
		
		workspace:set_world(panel_w,panel_h,- center + offset,x_axis,y_axis)
	end
	
	
end

--Removes the updater from RegisterUpdateCheckPlayer(), which called UpdateCheckPlayer(). This is safe to call multiple times.
function KineticHUD:UnregisterUpdateCheckPlayer()
	BeardLib:RemoveUpdater(self._updater_id_check_player)
end

--Each frame, attempts to find the player unit, in order to link the world panels to the player camera.
--Upon success, it calls its own unregistration in order to save performance.
--Not recommended to call manually- instead, call the update registration function RegisterUpdateCheckPlayer().
function KineticHUD:UpdateCheckPlayer(t,dt)
	local player = managers.player:local_player()
	if alive(player) then 
		if self:LinkWS(player:camera()._camera_object) then
			self:UnregisterUpdateCheckPlayer()
		end
		
		local inventory = player:inventory()
		if inventory then 
			for i,selection in pairs(inventory._available_selections) do 
				local weapon_unit = selection.unit
				if alive(weapon_unit) then 
					self:RegisterWeaponSelectionByUnit(weapon_unit,i)
					local weapon_id = weapon_unit:base():get_name_id()
					if weapon_id then 
						self:SetPlayerWeaponIcon(i,weapon_id)
					end
				end
			end
		end
	end
end

--Adds the updater, which calls UpdateCheckPlayer(). This is safe to call multiple times.
function KineticHUD:RegisterUpdateCheckPlayer()
	self:UnregisterUpdateCheckPlayer()
	BeardLib:AddUpdater(self._updater_id_check_player,callback(self,self,"UpdateCheckPlayer"))
end

--Experimental: Adds buff listeners for pjal3urb's GameInfoManager plugin
function KineticHUD:RegisterBuffListeners()
	if managers.gameinfo then 
	
		managers.gameinfo:register_listener("khud_buff_listener","buff","activate",callback(self,self,"RegisterBuff"))
		managers.gameinfo:register_listener("khud_buff_listener","buff","deactivate",callback(self,self,"UnregisterBuff"))
--[[
	managers.gameinfo:register_listener("khud_change_whisper_mode_listener", "whisper_mode", "change", function(...)
		buttr = {...}
		self:c_log("Changed whisper mode state")
		logall(buttr)
	end, nil, true)
	
	managers.gameinfo:register_listener("kinetichud_register_pager_answer","pager", "set_answered", function(pager_data)
--		Log("Received pager answered data")
--		Log(pager_data)
	end, nil, nil)
--]]	
	
	
	
	
	end
end

--Creates the main HUD elements, using the in-world HUD panels.
--Safe to call multiple times, as it removes preexisting duplicate HUD elements.
--Returns: nil
function KineticHUD:CreateWorldHUD()
		
	local font_ids = Idstring("font")
	local dyn_pkg = DynamicResourceManager.DYN_RESOURCES_PACKAGE
	local font_resources_ready = managers.dyn_resource:is_resource_ready(font_ids,Idstring(self._fonts.digital),dyn_pkg)
		and managers.dyn_resource:is_resource_ready(font_ids,Idstring(self._fonts.syke),dyn_pkg)
		and managers.dyn_resource:is_resource_ready(font_ids,Idstring(self._fonts.tommy_bold),dyn_pkg)


	self:CreatePlayerVitalsPanel(font_resources_ready)
	self:CreatePlayerWeaponsPanel(font_resources_ready)
	self:CreatePlayerEquipmentPanel()
	self:CreatePlayerMissionEquipmentPanel()
	
	self:CreateTeammatesPanel()
	
	self:CreateHints()
	self:CreatePresenter()
	self:CreateCarryPanel()
	self:CreateBuffsPanel()
	self:CreateChatPanel()
	
	
	self:CreateAssaultPanel()
	self:CreateObjectivePanel()
	
end

--unused
--Arguments: parent_panel [Panel]. The panel object to create the HUD on.
function KineticHUD:CreateFlatHUD(parent_panel)
	self._parent_panel = parent_panel
	if alive(self._base)  then 
		parent_panel:remove(self._base)
	end
	local base = parent_panel:panel({
		name = "kinetichud"
	})
	self._panel = base
	
end

--Creates the a HUD element to hold:
--The player's health, armor, damage absorption, stored health, and revives,
--and then positions and scales each element according to user settings.
--Arguments: skip_layout [bool]. Optional. If true, skips the HUD positioning step after creation.
--Returns: nil
function KineticHUD:CreatePlayerVitalsPanel(skip_layout)
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[layout_settings.player_vitals_panel_location]
	local scale = layout_settings.player_vitals_panel_scale
	local hv = self.hud_values
	local VITALS_H = hv.PLAYER_VITALS_PANEL_H * scale
	
	local margin_xsmall = hv.MARGIN_XSMALL * scale
	
	local label_font_size = hv.PLAYER_VITALS_LABEL_FONT_SIZE * scale
	local counter_large_font_size = hv.PLAYER_VITALS_COUNTER_FONT_SIZE_LARGE * scale
	local counter_medium_font_size = hv.PLAYER_VITALS_COUNTER_FONT_SIZE_MEDIUM * scale
	
	local PLAYER_HEALTH_PANEL_W = hv.PLAYER_HEALTH_PANEL_W * scale
	local PLAYER_HEALTH_PANEL_H = hv.PLAYER_HEALTH_PANEL_H * scale
	local PLAYER_HEALTH_PANEL_X = hv.PLAYER_HEALTH_PANEL_X * scale
	local PLAYER_HEALTH_PANEL_Y = hv.PLAYER_HEALTH_PANEL_Y * scale
	
	local PLAYER_ARMOR_PANEL_W = hv.PLAYER_ARMOR_PANEL_W * scale
	local PLAYER_ARMOR_PANEL_H = hv.PLAYER_ARMOR_PANEL_H * scale
	local PLAYER_ARMOR_PANEL_X = hv.PLAYER_ARMOR_PANEL_X * scale
	local PLAYER_ARMOR_PANEL_Y = hv.PLAYER_ARMOR_PANEL_Y * scale
	
	local PLAYER_VITALS_BAR_OUTLINE_W = hv.PLAYER_VITALS_BAR_OUTLINE_W * scale
	local PLAYER_VITALS_BAR_OUTLINE_H = hv.PLAYER_VITALS_BAR_OUTLINE_H * scale
	local PLAYER_VITALS_BAR_OUTLINE_X = (hv.PLAYER_VITALS_BAR_OUTLINE_X * scale) + margin_xsmall
	local PLAYER_VITALS_BAR_OUTLINE_Y = hv.PLAYER_VITALS_BAR_OUTLINE_Y * scale
	local PLAYER_VITALS_BAR_FILL_W = hv.PLAYER_VITALS_BAR_FILL_W * scale
	local PLAYER_VITALS_BAR_FILL_H = hv.PLAYER_VITALS_BAR_FILL_H * scale
	local PLAYER_VITALS_BAR_FILL_X = (hv.PLAYER_VITALS_BAR_FILL_X * scale) + PLAYER_VITALS_BAR_OUTLINE_X
	local PLAYER_VITALS_BAR_FILL_Y = (hv.PLAYER_VITALS_BAR_FILL_Y * scale) - ((PLAYER_VITALS_BAR_OUTLINE_H - PLAYER_VITALS_BAR_FILL_H) / 2)
	
	local PLAYER_VITALS_LABELS_X = hv.PLAYER_VITALS_LABELS_X * scale
	local PLAYER_VITALS_LABELS_Y = (hv.PLAYER_VITALS_LABELS_Y * scale) + (PLAYER_VITALS_BAR_FILL_Y - (margin_xsmall + PLAYER_VITALS_BAR_FILL_H))
	
	--valign bottom
	local vitals_panel = selected_parent_panel:panel({
		name = "vitals_master",
		h = VITALS_H,
		y = selected_parent_panel:h() - VITALS_H
	})
	local vitals_debug = vitals_panel:rect({
		name = "debug",
		color = Color.red,
		alpha = 0.1,
		visible = false
	})
	
	
--VITALS

	local armor_panel = vitals_panel:panel({
		name = "armor_panel",
		w = PLAYER_ARMOR_PANEL_W,
		h = PLAYER_ARMOR_PANEL_H,
		x = PLAYER_ARMOR_PANEL_X,
		y = PLAYER_ARMOR_PANEL_Y,
		layer = 4
	})
	local health_panel = vitals_panel:panel({
		name = "health_panel",
		w = PLAYER_HEALTH_PANEL_W,
		h = PLAYER_HEALTH_PANEL_H,
		x = PLAYER_HEALTH_PANEL_X + vitals_panel:w() - PLAYER_HEALTH_PANEL_W,
		y = PLAYER_HEALTH_PANEL_Y,
		layer = 4
	})
	local health_debug = health_panel:rect({
		name = "health_debug",
		color = Color.blue,
		alpha = 0.1,
		visible = false
	})
	local armor_debug = armor_panel:rect({
		name = "armor_debug",
		color = Color.red,
		alpha = 0.1,
		visible = false
	})
	
	
	local armor_label = armor_panel:text({
		name = "armor_label",
		text = "AP",
		color = Color.white,
		font = self._fonts.tommy_bold,
		x = PLAYER_VITALS_LABELS_X + margin_xsmall,
		y = PLAYER_VITALS_LABELS_Y,
		align = "left",
		vertical = "bottom",
		layer = 2,
		font_size = label_font_size
	})
	local al_x,al_y,al_w,al_h = armor_label:text_rect()
	
	local armor_current = armor_panel:text({
		name = "armor_current",
		text = "123",
		color = Color.white,
		font = self._fonts.digital,
		x = PLAYER_VITALS_LABELS_X + al_w + al_x + margin_xsmall,
		y = PLAYER_VITALS_LABELS_Y,
		align = "left",
		vertical = "bottom",
		layer = 2,
		font_size = counter_large_font_size
	})
	local ac_x,ac_y,ac_w,ac_h = armor_current:text_rect()
	
	local armor_total = armor_panel:text({
		name = "armor_total",
		text = "456",
		color = Color.white,
		font = self._fonts.digital,
		x = PLAYER_VITALS_LABELS_X + ac_w + ac_x + margin_xsmall,
		y = PLAYER_VITALS_LABELS_Y,
		align = "left",
		vertical = "bottom",
		layer = 2,
		font_size = counter_medium_font_size
	})
	
--health
	local health_label = health_panel:text({
		name = "health_label",
		text = "HP",
		color = Color.white,
		font = self._fonts.tommy_bold,
		x = - (PLAYER_VITALS_LABELS_X + margin_xsmall),
		y = PLAYER_VITALS_LABELS_Y,
		align = "right",
		vertical = "bottom",
		layer = 2,
		font_size = label_font_size
	})
	local hl_x,hl_y,hl_w,hl_h = health_label:text_rect()
	
	local health_current = health_panel:text({
		name = "health_current",
		text = "789",
		color = Color.white,
		font = self._fonts.digital,
		x = - (PLAYER_VITALS_LABELS_X + margin_xsmall + hl_w + margin_xsmall),
		y = PLAYER_VITALS_LABELS_Y,
		align = "right",
		vertical = "bottom",
		layer = 2,
		font_size = counter_large_font_size
	})
	local hc_x,hc_y,hc_w,hc_h = health_current:text_rect()
	
	
	local health_total = health_panel:text({
		name = "health_total",
		text = "000",
		color = Color.white,
		font = self._fonts.digital,
		x = - (PLAYER_VITALS_LABELS_X + margin_xsmall + hl_w + margin_xsmall + hc_w + margin_xsmall),
		y = PLAYER_VITALS_LABELS_Y,
		align = "right",
		vertical = "bottom",
		layer = 2,
		font_size = counter_medium_font_size
	})

	
	local armor_outline = armor_panel:bitmap({
		name = "armor_outline",
		texture = "textures/ui/armor_bar_outline",
		w = PLAYER_VITALS_BAR_OUTLINE_W,
		h = PLAYER_VITALS_BAR_OUTLINE_H,
		x = PLAYER_VITALS_BAR_OUTLINE_X,
		y = PLAYER_VITALS_BAR_OUTLINE_Y + (PLAYER_ARMOR_PANEL_H - PLAYER_VITALS_BAR_OUTLINE_H),
		visible = true,
		layer = 5
	})
	local armor_fill = armor_panel:bitmap({
		name = "armor_fill",
		texture = "textures/ui/armor_bar_fill",
		w = PLAYER_VITALS_BAR_FILL_W,
		h = PLAYER_VITALS_BAR_FILL_H,
		x = PLAYER_VITALS_BAR_FILL_X,
		y = PLAYER_VITALS_BAR_FILL_Y + (PLAYER_ARMOR_PANEL_H - PLAYER_VITALS_BAR_FILL_H),
		color = self.color_data.light_red,
		layer = 4
	})

	local health_outline = health_panel:bitmap({
		name = "health_outline",
		texture = "textures/ui/health_bar_outline",
		w = PLAYER_VITALS_BAR_OUTLINE_W,
		h = PLAYER_VITALS_BAR_OUTLINE_H,
		x = -PLAYER_VITALS_BAR_OUTLINE_X + (PLAYER_HEALTH_PANEL_W - PLAYER_VITALS_BAR_OUTLINE_W),
		y = PLAYER_VITALS_BAR_OUTLINE_Y + (PLAYER_HEALTH_PANEL_H - PLAYER_VITALS_BAR_OUTLINE_H),
		visible = true,
		layer = 5
	})
	
	local health_fill = health_panel:bitmap({
		name = "health_fill",
		texture = "textures/ui/health_bar_fill",
		w = PLAYER_VITALS_BAR_FILL_W,
		h = PLAYER_VITALS_BAR_FILL_H,
		x = -PLAYER_VITALS_BAR_FILL_X + (PLAYER_HEALTH_PANEL_W - PLAYER_VITALS_BAR_FILL_W),
		y = PLAYER_VITALS_BAR_FILL_Y + (PLAYER_HEALTH_PANEL_H - PLAYER_VITALS_BAR_FILL_H),
		color = self.color_data.light_green,
		layer = 4
	})
	
	local revives_text = vitals_panel:text({
		name = "revives_text",
		text = "0",
		color = Color.white,
		font = self._fonts.digital,
		align = "center",
		vertical = "bottom",
		layer = 7,
		font_size = counter_medium_font_size
	})
	
	self._player_vitals_panel = vitals_panel
	if not skip_layout then 
		self:LayoutPlayerVitals({layout_all = true})
	end
end

--Creates the a HUD element to hold information about the player's current weapons. (Two weapons in vanilla, the Primary and Secondary)
--Each weapon panel has one of the following: Kill counter, Weapon icon, Firemode indicator, Magazine counter, Reserve counter, Underbarrel ammo counter.
--After creation, the HUD elements are positioned and scaled according to user settings.
--Arguments: skip_layout [bool]. If true, skips the positioning step after creation.
--Returns: nil
function KineticHUD:CreatePlayerWeaponsPanel(skip_layout)
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[layout_settings.player_weapons_panel_location]
	if not alive(selected_parent_panel) then 
		return
	end
	local scale = layout_settings.player_weapons_panel_scale
	
	local hv = self.hud_values
	local weapons_panel_w = hv.PLAYER_WEAPONS_W
	local weapons_panel_h = hv.PLAYER_WEAPONS_H
	local weapons_panel_x = layout_settings.player_weapons_panel_x
	local weapons_panel_y = layout_settings.player_weapons_panel_y
	
	local margin_xsmall = hv.MARGIN_XSMALL * scale
	local margin_small = hv.MARGIN_SMALL * scale
	
	local weapon_panel_w = hv.PLAYER_WEAPON_W * scale
	local weapon_panel_h = hv.PLAYER_WEAPON_H * scale
	local weapon_panel_x = hv.PLAYER_WEAPON_X
	local weapon_panel_y = hv.PLAYER_WEAPON_Y
	local weapon_font_size_large = hv.PLAYER_WEAPON_FONT_SIZE_LARGE * scale
	local weapon_font_size_small = hv.PLAYER_WEAPON_FONT_SIZE_SMALL * scale
	local weapon_icon_x = hv.PLAYER_WEAPON_ICON_X * scale
	local weapon_icon_y = hv.PLAYER_WEAPON_ICON_Y * scale
	local weapon_icon_w = hv.PLAYER_WEAPON_ICON_W * scale
	local weapon_icon_h = hv.PLAYER_WEAPON_ICON_H * scale
	local weapon_icon_bg_alpha = hv.PLAYER_WEAPON_ICON_BG_ALPHA
	local weapon_border_alpha = hv.PLAYER_WEAPON_BORDER_ALPHA
	local weapon_border_thickness = hv.PLAYER_WEAPON_BORDER_THICKNESS * scale
	local weapon_firemode_w = hv.PLAYER_WEAPON_FIREMODE_W * scale
	local weapon_firemode_h = hv.PLAYER_WEAPON_FIREMODE_H * scale
	local weapon_primary_scale = hv.PLAYER_WEAPON_PRIMARY_SCALE * scale
	local weapon_secondary_scale = hv.PLAYER_WEAPON_SECONDARY_SCALE * scale
	local weapon_primary_x = hv.PLAYER_WEAPON_PRIMARY_X
	local weapon_primary_y = hv.PLAYER_WEAPON_PRIMARY_Y
	local weapon_secondary_x = hv.PLAYER_WEAPON_SECONDARY_X * scale
	local weapon_secondary_y = hv.PLAYER_WEAPON_SECONDARY_Y * scale
	local weapon_reserve_x = hv.PLAYER_WEAPON_RESERVE_X * scale
	
	
	local parent_weapons_panel = selected_parent_panel:panel({
		name = "weapons_panel",
		w = weapons_panel_w,
		h = weapons_panel_h,
		x = weapons_panel_x,
		y = weapons_panel_y
	})
	self._player_weapons_panel = parent_weapons_panel
	
	local debug_weapons = parent_weapons_panel:rect({
		name = "debug_weapons",
		color=Color.green,
		alpha=0.2,
		visible = false
	})
	
--todo straighten out layers (integers only)
--todo put vertical offset in weapons_panel as well as in subpanels
	local function create_weapon_subpanel(index,scale)
		local icon_x = weapon_icon_x * scale
		local icon_y = weapon_icon_y * scale
		local icon_w = weapon_icon_w * scale
		local icon_h = weapon_icon_h * scale
		local box_w = weapon_panel_w * scale
		local box_h = weapon_panel_h * scale
		local box_x = weapon_panel_x * scale
		local box_y = weapon_panel_y * scale
		local font_size_large = weapon_font_size_large * scale
		local font_size_small = weapon_font_size_small * scale
		local border_alpha = weapon_border_alpha
		local border_thickness = weapon_border_thickness * scale
		local icon_bg_alpha = weapon_icon_bg_alpha
		local firemode_w = weapon_firemode_w * scale
		local firemode_h = weapon_firemode_h * scale
		local reserve_x = weapon_reserve_x * scale
			
		local ammo_text_bottom = -box_h / 20
		local ammo_text_top = box_h / 20
		
		local weapon_panel = parent_weapons_panel:panel({
			name = tostring(index),
			x = box_x,
--			y = box_y,
			w = box_w,
			h = box_h
		})
		
		local icon_box = weapon_panel:panel({
			name = "icon_box",
			x = icon_x,
			y = icon_y,
			w = icon_w,
			h = icon_h
		})
		local icon_bitmap = icon_box:bitmap({
			name = "icon_bitmap",
			texture = "",
			layer = 1
		})
		icon_bitmap:set_image(managers.blackmarket:get_weapon_icon_path("amcar"))
		icon_bitmap:set_size(icon_w,icon_h)
		
		local icon_bg = icon_box:bitmap({
			name = "icon_bg",
			texture = nil,
			color = Color.black,
			blend_mode = "multiply",
			alpha = icon_bg_alpha,
			layer = 0
		})
		icon_bg:set_size(box_w,box_h)
		
		local border = self:PanelBorder(icon_box,{
			thickness = border_thickness,
			color = Color.white,
			alpha = border_alpha,
			layer = 2
		})
		
		local firemode = weapon_panel:bitmap({
			name = "firemode",
			x = icon_box:right() + margin_xsmall,
			y = icon_box:y(),
			w = firemode_w,
			h = firemode_h,
			texture = "textures/ui/firemode_dots_3",
--			visible = false,
			layer = 3
		})
		firemode:set_y((weapon_panel:h() - firemode:h()) / 2) --vertically centered
		
		
		--note: right() seems to use world right (including x of parent panel)
		local magazine = weapon_panel:text({
			name = "magazine",
			color = Color.white,
			font = self._fonts.digital,
			text = "123",
			vertical = "bottom",
			x = firemode:right() + margin_small,
			y = ammo_text_bottom,
			layer = 4,
			font_size = font_size_large
		})
		local m_x,m_y,m_w,m_h = magazine:text_rect()
		local reserve = weapon_panel:text({
			name = "reserve",
			color = Color.white,
			font = self._fonts.digital,
			text = "999",
			vertical = "bottom",
			x = magazine:x() + m_w + reserve_x,
			y = ammo_text_bottom,
			layer = 4,
			font_size = font_size_small
		})
		
		local mag_x,_,_,mag_h = magazine:text_rect()

		--todo center vertically but move each away from center? or set vertical top and bottom, from y = vertical center plus margin
		local kill_icon = weapon_panel:text({
			name = "kill_icon",
			color = Color.white,
			font = self._fonts.large,
			text = self.special_characters.skull,
			align = "right",
			vertical = "top",
			x = -margin_small + - (weapon_panel:w() -icon_box:x()),
			y = ammo_text_top,
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
			x = -margin_small + - (weapon_panel:w() -icon_box:x()),
			y = ammo_text_bottom,
			layer = 4,
			font_size = font_size_large
		})
		local debug_rect = weapon_panel:rect({
			name = "debug_rect",
			visible = false,
			alpha = 0.2,
			color = Color.red
		})
		
		return weapon_panel
	end
	
	local primary = create_weapon_subpanel(1,weapon_primary_scale)
	primary:set_position(weapon_primary_x,weapon_primary_y)
	local secondary = create_weapon_subpanel(2,weapon_secondary_scale)
	secondary:set_position(weapon_primary_x + weapon_secondary_x,weapon_primary_y + weapon_secondary_y)
	
	if not skip_layout then 
		self:LayoutPlayerWeaponsPanel({recreate_text_objects=true,highlighted_index=2})
	end
end

function KineticHUD:CreatePlayerEquipmentPanel(skip_layout)
	local selected_parent_panel = self._world_panels[self.layout_settings.player_equipment_panel_location]
	if not alive(selected_parent_panel) then 
		return
	end
	local player_equipment_panel = selected_parent_panel:panel({
		name = "player_equipment_panel"
	})

	local deployable_1_x = 100
	local deployable_1_y = 0
	
	local deployable_2_x = 125
	local deployable_2_y = 100
	
	local cable_ties_x = 0
	local cable_ties_y = 200
	
	local throwable_x = 100
	local throwable_y = 200
	
	local deployable_1 = self:CreatePlayerEquipmentBox(player_equipment_panel,{name = "deployable_1",icon="",double=true})
	deployable_1:set_position(deployable_1_x,deployable_1_y)
	deployable_1:hide() 
	
	local deployable_2 = self:CreatePlayerEquipmentBox(player_equipment_panel,{name = "deployable_2",icon="",double=true})
	deployable_2:set_position(deployable_2_x,deployable_2_y)
	deployable_2:hide() 
	
	local cable_ties = self:CreatePlayerEquipmentBox(player_equipment_panel,{name = "cable_ties",icon="equipment_cable_ties",double=false})
	cable_ties:set_position(cable_ties_x,cable_ties_y)
--	cable_ties:hide()
	
	local throwable = self:CreatePlayerEquipmentBox(player_equipment_panel,{name = "throwable",icon="",double=false})
	throwable:set_position(throwable_x,throwable_y)
--	throwable:hide()
	self._player_equipment_panel = player_equipment_panel
	if not skip_layout then 
		self:LayoutPlayerEquipmentPanel()
	end
	return player_equipment_panel
end

function KineticHUD:CreatePlayerEquipmentBox(player_panel,params)
	if not (params and type(params) == "table") then 
		params = {}
	end
	local name = params.name
	local double = params.double
	local icon_id = params.icon
	
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.player_equipment_panel_scale
	
	local font_size = 36 * scale
	local icon_w = 48 * scale
	local icon_h = 48 * scale
	local margin_small = hv.MARGIN_SMALL * scale
	local border_thickness = 2
	
	local box_w = hv.PLAYER_EQUIPMENT_BOX_W * scale
	local box_h = hv.PLAYER_EQUIPMENT_BOX_H * scale
	
	local text_x = 48 + margin_small
	local text_y = 0
	
	local texture,texture_rect
	if icon_id and icon_id ~= "" then 
		texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon_id)
	end
	
	if double then 
		box_w = box_w * 1.75
	end
	
	local equipment_box = player_panel:panel({
		name = name,
		w = box_w,
		h = box_h
	})
	
	local icon_box = equipment_box:panel({
		name = "icon_box",
		w = box_h,
		h = box_h
	})
	local icon_bitmap = icon_box:bitmap({
		name = "icon_bitmap",
		texture = texture,
		texture_rect = texture_rect,
		layer = 6
	})
	local _w,_h = icon_bitmap:size()
	local icon_aspect_ratio = _w/_h
	
	icon_bitmap:set_size(icon_aspect_ratio * icon_h,icon_h)
	icon_bitmap:set_center(icon_box:center())
	
	local borders = self:PanelBorder(icon_box,{
		thickness = border_thickness,
		layer = 4
	})
	
	local icon_gradient_bg = equipment_box:bitmap({
		name = "icon_gradient_bg",
		texture = "textures/ui/gradient",
		w = box_w,
		h = box_h,
		x = 0,
		y = 0,
		color = self.color_data.black,
		alpha = 1/3,
		layer = 2
	})
	
	local text = equipment_box:text({
		name = "text",
		text = "00",
		font = self._fonts.digital,
		font_size = font_size,
		x = text_x,
		y = text_y,
		layer = 6
	})
	local t_x,_,t_w,_ = text:text_rect()
	
	local text_2 = equipment_box:text({
		name = "text_2",
		text = "00",
		font = self._fonts.digital,
		font_size = font_size,
		x = t_w + t_x + margin_small + margin_small,
		y = text_y,
		visible = false, --visibility is checked on layout
		layer = 6
	})
	
	return equipment_box
	
end

function KineticHUD:CreatePlayerMissionEquipmentPanel(skip_layout)
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[layout_settings.player_mission_equipment_panel_location]
	if not alive(selected_parent_panel) then 
		return
	end
	local player_mission_equipment_panel = selected_parent_panel:panel({
		name = "player_mission_equipment_panel"
	})
	self._player_mission_equipment_panel = player_mission_equipment_panel
	if not skip_layout then 
		self:LayoutPlayerMissionEquipmentPanel()
	end
end

function KineticHUD:CreateTeammatesPanel(skip_layout)
	local layout_settings = self.layout_settings
	local hud_values = self.hud_values
	
	local teammates_x = layout_settings.teammates_x
	local teammates_y = layout_settings.teammates_y
	local selected_parent_panel = self._world_panels[layout_settings.teammates_panel_location]
	local teammates_panel_parent = selected_parent_panel:panel({
		name = "teammates_panel",
		x = teammates_x,
		y = teammates_y
	})
	self._teammates_panel = teammates_panel_parent
	
	if not skip_layout then 
		self:LayoutTeammatesPanel()
	end
end

function KineticHUD:CreateTeammateEquipmentBox(teammate_panel,name,icon_id,double)
	local layout_settings = self.layout_settings
	local scale = layout_settings.teammates_panel_scale
	local hv = self.hud_values
	local box_w = hv.TEAMMATE_EQUIPMENT_BOX_W * scale
	local box_h = hv.TEAMMATE_EQUIPMENT_BOX_H * scale
	
	local font_size = hv.TEAMMATE_EQUIPMENT_FONT_SIZE * scale
	local icon_w = hv.TEAMMATE_EQUIPMENT_ICON_SIZE * scale
	local icon_h = hv.TEAMMATE_EQUIPMENT_ICON_SIZE * scale
	local margin = hv.MARGIN_XSMALL * scale
	local text_x = (hv.TEAMMATE_EQUIPMENT_TEXT_X * scale) + icon_w + margin
	local text_y = hv.TEAMMATE_EQUIPMENT_TEXT_Y * scale
	
	local texture,texture_rect
	if icon_id and icon_id ~= "" then 
		texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon_id)
	else
		--hacky fix to make the equipment invisible if there is no icon
	end
	
	if double then 
		box_w = box_w * hv.TEAMMATE_EQUIPMENT_BOX_DOUBLE_W_MUL
	end
	
	local equipment_box = teammate_panel:panel({
		name = name,
		w = box_w,
		h = box_h
	})
	
	local icon_box = equipment_box:panel({
		name = "icon_box",
		w = box_h,
		h = box_h
	})
	local icon_bitmap = icon_box:bitmap({
		name = "icon_bitmap",
		texture = texture,
		texture_rect = texture_rect,
		layer = 6
	})
	local _w,_h = icon_bitmap:size()
	local icon_aspect_ratio = _w/_h
	
	icon_bitmap:set_size(icon_aspect_ratio * icon_h,icon_h)
	icon_bitmap:set_center(icon_box:center())
	
	local borders = self:PanelBorder(icon_box,{
		thickness = hv.TEAMMATE_EQUIPMENT_BOX_OUTLINE_THICKNESS,
		layer = 4
	})
	
	local icon_gradient_bg = equipment_box:bitmap({
		name = "icon_gradient_bg",
		texture = "textures/ui/gradient",
		w = box_w,
		h = box_h,
		x = 0,
		y = 0,
		color = self.color_data.black,
		alpha = 1/3,
		layer = 2
	})
	
	local text = equipment_box:text({
		name = "text",
		text = "00",
		font = self._fonts.digital,
		font_size = font_size,
		x = text_x,
		y = text_y,
		layer = 6
	})
	local t_x,_,t_w,_ = text:text_rect()
	
	local text_2 = equipment_box:text({
		name = "text_2",
		text = "00",
		font = self._fonts.digital,
		font_size = font_size,
		x = t_w + t_x + margin + margin,
		y = text_y,
		visible = false, --visibility is checked on layout
		layer = 6
	})
	
	return equipment_box
end

function KineticHUD:CreateTeammatePanel(i,skip_layout)
	local layout_settings = self.layout_settings
	local scale = self.layout_settings.teammates_panel_scale
	local hv = self.hud_values
	local margin = hv.MARGIN_XSMALL * scale

	local teammate_w = hv.TEAMMATE_PANEL_W * scale
	local teammate_h = hv.TEAMMATE_PANEL_H * scale
	
	local nametag_panel_x = hv.TEAMMATE_NAMETAG_PANEL_X * scale
	local nametag_panel_y = hv.TEAMMATE_NAMETAG_PANEL_Y -margin
	local nametag_panel_w = hv.TEAMMATE_NAMETAG_PANEL_W * scale
	local nametag_panel_h = hv.TEAMMATE_NAMETAG_PANEL_H * scale
	local nametag_font_size = hv.TEAMMATE_NAMETAG_FONT_SIZE * scale
	
	local color_indicator_w = hv.TEAMMATE_COLOR_INDICATOR_W * scale
	local color_indicator_h = (hv.TEAMMATE_COLOR_INDICATOR_H * scale) + nametag_panel_h
	local color_indicator_x = hv.TEAMMATE_COLOR_INDICATOR_X * scale
	local color_indicator_y = hv.TEAMMATE_COLOR_INDICATOR_Y * scale
	
	
	local bpm_panel_w = hv.TEAMMATE_BPM_PANEL_W * scale
	local bpm_panel_h = (hv.TEAMMATE_BPM_PANEL_H * scale) + nametag_panel_h
	local bpm_panel_x = (hv.TEAMMATE_BPM_PANEL_X * scale) + color_indicator_w + nametag_panel_x + nametag_panel_w
	local bpm_panel_y = hv.TEAMMATE_BPM_PANEL_Y * scale
	
	local bpm_icon_w = nametag_panel_h * hv.TEAMMATE_BPM_ICON_SIZE_MUL
	local bpm_icon_h = nametag_panel_h * hv.TEAMMATE_BPM_ICON_SIZE_MUL
	local bpm_icon_x = hv.TEAMMATE_BPM_ICON_X * scale --color_indicator_w + nametag_panel_w
	local bpm_icon_y = hv.TEAMMATE_BPM_ICON_Y * scale
	
	local bpm_mask_h = nametag_panel_h
	local bpm_mask_x = (hv.TEAMMATE_BPM_MASK_X * scale) + (bpm_icon_w / 2) --bpm_icon_w / 2 --the idea was for the ekg line to disappear under the heart, but layers/opacity aren't playing nice
	local bpm_mask_w = bpm_panel_w - bpm_mask_x
	local bpm_mask_y = hv.TEAMMATE_BPM_MASK_Y * scale
	
	local bpm_readout_w = 128 / 4
	local bpm_readout_h = 96 / 4
	
	local speaking_icon_x = (hv.TEAMMATE_SPEAKING_ICON_X * scale) + bpm_panel_x + bpm_panel_w
	local speaking_icon_y = hv.TEAMMATE_SPEAKING_ICON_Y * scale
	local speaking_icon_w = (nametag_panel_h * hv.TEAMMATE_SPEAKING_ICON_SIZE_MUL)
	local speaking_icon_h = (nametag_panel_h * hv.TEAMMATE_SPEAKING_ICON_SIZE_MUL)
	
	
	local deployable_1_x = hv.TEAMMATE_DEPLOYABLE_X * scale
	local deployable_1_y = (hv.TEAMMATE_DEPLOYABLE_Y * scale) + nametag_panel_h
	
	local revives_font_size = hv.TEAMMATE_REVIVES_FONT_SIZE * scale
	
	
	local teammate = self._teammates_panel:panel({
		name = tostring(i),
		w = teammate_w,
		h = teammate_h
	})
	local color_indicator = teammate:bitmap({
		name = "color_indicator",
		texture = nil,
		w = color_indicator_w,
		h = color_indicator_h,
		x = color_indicator_x,
		y = color_indicator_y,
		color = self.color_data.teal,
		layer = 4
	})
	
	local nametag_panel = teammate:panel({
		name = "nametag_panel",
		w = nametag_panel_w,
		h = nametag_panel_h,
		x = nametag_panel_x,
		y = nametag_panel_y
	})
	local nametag_debug = nametag_panel:rect({
		name = "nametag_debug",
		alpha = 0.1,
		color = Color.yellow,
		visible = false
	})
	
	local nametag = nametag_panel:text({
		name = "nametag",
		text = managers.localization:text("khud_hud_player_name_loading"),
		font = self._fonts.syke,
		font_size = nametag_font_size,
		align = "left",
		vertical = "top",
		layer = 6
	})
	
	local bpm_panel = teammate:panel({
		name = "bpm_panel",
		w = bpm_panel_w,
		h = bpm_panel_h,
		x = bpm_panel_x,
		y = bpm_panel_y,
		visible = false
	})
	
	local bpm_icon_box = bpm_panel:panel({
		name = "bpm_icon_box",
		w = bpm_icon_w,
		h = bpm_icon_h,
		x = bpm_icon_x,
		y = bpm_icon_y,
		layer = 4
	})
	local bpm_icon = bpm_icon_box:bitmap({
		name = "bpm_icon",
		texture = "textures/ui/heart",
		w = bpm_icon_w,
		h = bpm_icon_h,
		color = self.color_data.red,
		layer = 4
	})
	
	local bpm_mask = bpm_panel:panel({
		name = "bpm_mask",
		w = bpm_mask_w,
		h = bpm_mask_h,
		x = bpm_mask_x,
		y = bpm_mask_y,
		layer = 2
	})
	
	local bpm_readout_init = bpm_mask:bitmap({
		name = "bpm_readout",
		texture = "",
--		color = self.color_data.red,
		x = -1,
		w = bpm_readout_w,
		h = bpm_readout_h,
		alpha = 0
	})
	
	local revives = bpm_icon_box:text({
		name = "revives",
		text = "0",
		font = self._fonts.digital,
		font_size = revives_font_size,
		align = "center",
		vertical = "center",
		layer = 5
	})
	
	local bpm_debug_1 = bpm_panel:rect({
		name = "bpm_debug_1",
		color = Color.green,
		alpha = 0.4,
		visible = false
	})
	local bpm_debug_2 = bpm_mask:rect({
		name = "bpm_debug_2",
		color = Color.blue,
		alpha = 0.1,
		visible = false
	})
	
	local speaking_icon_texture,speaking_icon_texture_rect = tweak_data.hud_icons:get_icon_data(hv.TEAMMATE_SPEAKING_ICON_ID)

	local speaking_icon = teammate:bitmap({
		name = "speaking_icon",
		texture = speaking_icon_texture,
		texture_rect = speaking_icon_texture_rect,
		w = speaking_icon_w,
		h = speaking_icon_h,
		x = speaking_icon_x,
		y = speaking_icon_y,
		color = self.color_data.white,
		visible = false
	})
	
	local location_text = teammate:text({
		name = "location_text",
		text = "" or "In Lobby abcdefghij",
		font = self._fonts.syke,
		font_size = nametag_font_size,
		align = "left",
		vertical = "top",
		x = bpm_panel:right() + margin,
		y = -margin,
		layer = 6
	})

	local deployable_1 = self:CreateTeammateEquipmentBox(teammate,"deployable_1","",true)
	deployable_1:set_position(deployable_1_x,deployable_1_y)
	deployable_1:hide() 
	
	local deployable_2 = self:CreateTeammateEquipmentBox(teammate,"deployable_2","",true)
	deployable_2:set_position(deployable_1:right(),deployable_1_y)
	deployable_2:hide() 
	
	local cable_ties = self:CreateTeammateEquipmentBox(teammate,"cable_ties","equipment_cable_ties")
	cable_ties:set_position(deployable_2:right(),deployable_1_y)
	cable_ties:hide()
	
	local throwable = self:CreateTeammateEquipmentBox(teammate,"throwable","")
	throwable:set_position(cable_ties:right(),deployable_1_y)
	throwable:hide()
	
	self._teammate_panels[i] = teammate
	if not skip_layout then 
		self:LayoutTeammatePanel(i)
	end
	return teammate
end

function KineticHUD:CreateAssaultPanel(skip_layout)
	local hud_values = self.hud_values
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[layout_settings.assault_panel_location]
	
	local assault_panel = selected_parent_panel:panel({
		name = "assault_panel"
	})
	self._assault_panel = assault_panel
	
	local assault_icon = assault_panel:bitmap({
		name = "assault_icon",
		texture = "guis/textures/pd2/hud_icon_assaultbox",
		texture_rect = nil,
		visible = false,
		layer = 2
	})
	
	local assault_phase_label = assault_panel:text({
		name = "assault_phase_label",
		font = self._fonts.syke,
		font_size = hud_values.ASSAULT_PHASE_LABEL_FONT_SIZE,
		layer = 2,
		text = ""
	})
	
	local assault_debug = assault_panel:rect({
		name = "assault_debug",
		layer = 1,
		visible = false,
		color = Color.blue,
		alpha = 0.2
	})
	
	
	
	
	
	
	
	if not skip_layout then 
		self:LayoutAssaultPanel({
			recreate_text_objects = true
		})
	end
end

function KineticHUD:CreateHints()
	--self.settings.hints_panel_location
	--you can't stand up here, etc.
end

function KineticHUD:CreatePresenter()
	--self.settings.presenter_panel_location
	--mission objectives and pickups, etc
end

function KineticHUD:CreateObjectivePanel(skip_layout)
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	
	local selected_parent_panel = self._world_panels[layout_settings.objective_panel_location]
	local objective_panel = selected_parent_panel:panel({
		name = "objective_panel",
		w = hv.OBJECTIVE_W,
		h = hv.OBJECTIVE_H,
		x = layout_settings.OBJECTIVE_X,
		y = layout_settings.OBJECTIVE_Y
	})
	
	self._objective_panel = objective_panel
	
	local objective_title_text = objective_panel:text({
		name = "objective_title_text",
		text = managers.localization:text("khud_hud_objective_title"),
		font = self._fonts.syke,
		font_size = hv.OBJECTIVE_TITLE_TEXT_FONT_SIZE,
		color = hv.OBJECTIVE_TITLE_TEXT_COLOR,
		align = hv.OBJECTIVE_TITLE_TEXT_HALIGN,
		vertical = hv.OBJECTIVE_TITLE_TEXT_VALIGN,
		layer = 2,
		x = hv.OBJECTIVE_TITLE_TEXT_X,
		y = hv.OBJECTIVE_TITLE_TEXT_Y
	})
	
	local current_objective_text = objective_panel:text({
		name = "current_objective_text",
		text = "",
		font = self._fonts.syke,
		font_size = hv.OBJECTIVE_TEXT_FONT_SIZE,
		color = hv.OBJECTIVE_TEXT_COLOR,
		align = hv.OBJECTIVE_TEXT_HALIGN,
		vertical = hv.OBJECTIVE_TEXT_VALIGN,
		layer = 2,
		x = hv.OBJECTIVE_TEXT_X,
		y = hv.OBJECTIVE_TEXT_Y
	})
	
	local current_count_text = objective_panel:text({
		name = "current_count_text",
		text = "",
		font = self._fonts.syke,
		font_size = hv.OBJECTIVE_COUNT_TEXT_FONT_SIZE,
		color = hv.OBJECTIVE_COUNT_TEXT_COLOR,
		align = hv.OBJECTIVE_COUNT_TEXT_HALIGN,
		vertical = hv.OBJECTIVE_COUNT_TEXT_VALIGN,
		layer = 2,
		x = hv.OBJECTIVE_COUNT_TEXT_X,
		y = hv.OBJECTIVE_COUNT_TEXT_Y
	})
	
	local objective_debug = objective_panel:rect({
		name = "objective_debug",
		color = Color.red,
		visible = false,
		layer = 1,
		alpha = 0.5
	})
	
	--todo checkbox bitmap + animation
	
	
	if not skip_layout then 
		self:LayoutObjectivePanel()
	end
end

function KineticHUD:CreateCarryPanel(skip_layout)
	
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.player_carry_panel_scale
	
	local selected_parent_panel = self._world_panels[layout_settings.player_carry_panel_location]
	local carry_panel = selected_parent_panel:panel({
		name = "carry_panel",
		w = hv.CARRY_W * scale,
		h = hv.CARRY_H * scale,
		x = layout_settings.CARRY_X,
		y = layout_settings.CARRY_Y,
		visible = false
	})
	self._carry_panel = carry_panel
	
	local bag_texture, bag_rect = tweak_data.hud_icons:get_icon_data(hv.CARRY_ICON_ID)
	
	local bag_icon = carry_panel:bitmap({
		name = "bag_icon",
		texture = bag_texture,
		texture_rect = bag_rect,
		layer = 2,
		color = self.color_data.white,
		alpha = hv.CARRY_ICON_ALPHA
	})	
	
	local debug_rect = carry_panel:rect({
		name = "debug_rect",
		color = Color.green,
		visible = false,
		alpha = 0.1
	})
	
	if not skip_layout then 
		self:LayoutCarryPanel()
	end
	
	
end

function KineticHUD:CreateChatPanel(skip_layout)
	local layout_settings = self.layout_settings
	local selected_parent_panel = self._world_panels[layout_settings.chat_panel_location]
	if not alive(selected_parent_panel) then 
		return
	end
	local panel = selected_parent_panel:panel({
		name = "chat_panel_main",
		x = 0,
		y = 0
	})
	self._chat_panel = panel
	
	if not skip_layout then 
		self:LayoutChatPanel()
	end
end

function KineticHUD:LayoutChatPanel()
--	self._chat_panel:set_position(0,0)
--	self._chat_panel:set_size(0,0)
end

--Arranges the subelements of the HUD panel that contains the player's health, armor, etc. 
--Arguments: none
--Returns: nil
function KineticHUD:LayoutPlayerVitals(params)
	local vitals_panel = self._player_vitals_panel
	if alive(vitals_panel) then 
		if not (params and type(params) == "table") then 
			params = {layout_all = true}
		end
		local hv = self.hud_values
		local layout_settings = self.layout_settings
		
		local recreate_text_objects = params.recreate_text_objects
		local layout_all = params.layout_all
		local layout_health = layout_all or params.layout_health
		local layout_armor = layout_all or params.layout_armor
		local layout_revives = layout_all or params.layout_revives
		local skip_reposition = layout_all or params.skip_reposition

		local scale = self.layout_settings.player_vitals_panel_scale
		
		if params.lerp_override then 
			scale = params.lerp_override
		end


		local VITALS_H = hv.PLAYER_VITALS_PANEL_H * scale
		
		local margin_xsmall = hv.MARGIN_XSMALL * scale
		
		local label_font_size = hv.PLAYER_VITALS_LABEL_FONT_SIZE * scale
		local counter_large_font_size = hv.PLAYER_VITALS_COUNTER_FONT_SIZE_LARGE * scale
		local counter_medium_font_size = hv.PLAYER_VITALS_COUNTER_FONT_SIZE_MEDIUM * scale
		
		local PLAYER_HEALTH_PANEL_W = hv.PLAYER_HEALTH_PANEL_W * scale
		local PLAYER_HEALTH_PANEL_H = hv.PLAYER_HEALTH_PANEL_H * scale
		local PLAYER_HEALTH_PANEL_X = hv.PLAYER_HEALTH_PANEL_X * scale
		local PLAYER_HEALTH_PANEL_Y = hv.PLAYER_HEALTH_PANEL_Y * scale
		
		local PLAYER_ARMOR_PANEL_W = hv.PLAYER_ARMOR_PANEL_W * scale
		local PLAYER_ARMOR_PANEL_H = hv.PLAYER_ARMOR_PANEL_H * scale
		local PLAYER_ARMOR_PANEL_X = hv.PLAYER_ARMOR_PANEL_X * scale
		local PLAYER_ARMOR_PANEL_Y = hv.PLAYER_ARMOR_PANEL_Y * scale
		
		local PLAYER_VITALS_BAR_OUTLINE_W = hv.PLAYER_VITALS_BAR_OUTLINE_W * scale
		local PLAYER_VITALS_BAR_OUTLINE_H = hv.PLAYER_VITALS_BAR_OUTLINE_H * scale
		local PLAYER_VITALS_BAR_OUTLINE_X = (hv.PLAYER_VITALS_BAR_OUTLINE_X * scale) + margin_xsmall
		local PLAYER_VITALS_BAR_OUTLINE_Y = hv.PLAYER_VITALS_BAR_OUTLINE_Y * scale
		local PLAYER_VITALS_BAR_FILL_W = hv.PLAYER_VITALS_BAR_FILL_W * scale
		local PLAYER_VITALS_BAR_FILL_H = hv.PLAYER_VITALS_BAR_FILL_H * scale
		local PLAYER_VITALS_BAR_FILL_X = (hv.PLAYER_VITALS_BAR_FILL_X * scale) + PLAYER_VITALS_BAR_OUTLINE_X
		local PLAYER_VITALS_BAR_FILL_Y = (hv.PLAYER_VITALS_BAR_FILL_Y * scale) - ((PLAYER_VITALS_BAR_OUTLINE_H - PLAYER_VITALS_BAR_FILL_H) / 2)
		
		local PLAYER_VITALS_LABELS_X = hv.PLAYER_VITALS_LABELS_X * scale
		local PLAYER_VITALS_LABELS_Y = (hv.PLAYER_VITALS_LABELS_Y * scale) + (PLAYER_VITALS_BAR_FILL_Y - (margin_xsmall + PLAYER_VITALS_BAR_FILL_H))


	--raw texture sizes; do not scale by settings
		local PLAYER_ARMOR_FILL_TEXTURE_W = hv.PLAYER_ARMOR_FILL_TEXTURE_W
		local PLAYER_ARMOR_FILL_TEXTURE_H = hv.PLAYER_ARMOR_FILL_TEXTURE_H
		local PLAYER_HEALTH_FILL_TEXTURE_W = hv.PLAYER_HEALTH_FILL_TEXTURE_W
		local PLAYER_HEALTH_FILL_TEXTURE_H = hv.PLAYER_HEALTH_FILL_TEXTURE_H


		if layout_health then 
			local health_panel = vitals_panel:child("health_panel")
			local health_fill = health_panel:child("health_fill")
			
			local health_ratio = params.health_ratio
			
			if health_ratio then 
				local outline_offset = PLAYER_HEALTH_PANEL_W - PLAYER_VITALS_BAR_FILL_W - (margin_xsmall * scale)
				local DEPLETE_LEFT_TO_RIGHT = true
				if DEPLETE_LEFT_TO_RIGHT then 
					health_fill:set_texture_rect(PLAYER_HEALTH_FILL_TEXTURE_W,0,-PLAYER_HEALTH_FILL_TEXTURE_W * health_ratio,PLAYER_HEALTH_FILL_TEXTURE_H)
					health_fill:set_w(-PLAYER_VITALS_BAR_FILL_W * health_ratio)
					health_fill:set_x(PLAYER_VITALS_BAR_FILL_W + outline_offset)
				else
					health_fill:set_texture_rect(0,0,PLAYER_HEALTH_FILL_TEXTURE_W * health_ratio,PLAYER_HEALTH_FILL_TEXTURE_H)
					health_fill:set_w(PLAYER_VITALS_BAR_FILL_W * health_ratio * scale)
					health_fill:set_x(-PLAYER_VITALS_BAR_FILL_X + outline_offset)
				end
			end
			
			
			
			
			health_panel:child("health_debug"):set_size(health_panel:size())
		end
		
		if layout_armor then 
			local armor_panel = vitals_panel:child("armor_panel")
			local armor_fill = armor_panel:child("armor_fill")
			local armor_ratio = params.armor_ratio
			if armor_ratio then 
				local outline_offset = PLAYER_ARMOR_PANEL_W - PLAYER_VITALS_BAR_FILL_W
				local DEPLETE_LEFT_TO_RIGHT = false
				if DEPLETE_LEFT_TO_RIGHT then 
					armor_fill:set_texture_rect(PLAYER_ARMOR_FILL_TEXTURE_W,0,-PLAYER_ARMOR_FILL_TEXTURE_W * armor_ratio,PLAYER_ARMOR_FILL_TEXTURE_H)
					armor_fill:set_w(-PLAYER_VITALS_BAR_FILL_W * armor_ratio)
					armor_fill:set_x(PLAYER_VITALS_BAR_FILL_W + outline_offset)
				else
					armor_fill:set_texture_rect(0,0,PLAYER_ARMOR_FILL_TEXTURE_W * armor_ratio,PLAYER_ARMOR_FILL_TEXTURE_H)
					armor_fill:set_w(PLAYER_VITALS_BAR_FILL_W * armor_ratio * scale)
					armor_fill:set_x(-PLAYER_VITALS_BAR_FILL_X + outline_offset)
				end
			end
			
			if not skip_reposition then 
--				armor_panel:set_position(x,y)
--				armor_panel:set_size(w,h)
			end
			
--			armor_panel:child("armor_label"):set_font_size(label_font_size)
			
			armor_panel:child("armor_debug"):set_size(armor_panel:size())
		end
		
	end
end

function KineticHUD:LayoutPlayerWeaponsPanel(params)
	local parent_weapons_panel = self._player_weapons_panel
	if alive(parent_weapons_panel) then
		if not (params and type(params) == "table") then 
			params = {}
		end
		local hud_values = self.hud_values
		local layout_settings = self.layout_settings
		local scale = self.layout_settings.player_weapons_panel_scale
		
		local recreate_text_objects = params.recreate_text_objects
		local skip_reposition = params.skip_reposition
		local skip_parent = params.skip_parent
		local highlighted_index = params.highlighted_index or 1
		local single_layout = params.single_layout
		local lerp_override = params.lerp_override
		
		local weapon_primary_scale = hud_values.PLAYER_WEAPON_PRIMARY_SCALE * scale
		local weapon_secondary_scale = hud_values.PLAYER_WEAPON_SECONDARY_SCALE * scale
		
		if lerp_override then 
			local s1 = weapon_secondary_scale + ((weapon_primary_scale - weapon_secondary_scale) * lerp_override)
			local s2 = weapon_primary_scale + ((weapon_secondary_scale - weapon_primary_scale) * lerp_override)
			weapon_primary_scale = s1
			weapon_secondary_scale = s2
		end
		
		
		local weapon_primary_x = hud_values.PLAYER_WEAPON_PRIMARY_X
		local weapon_primary_y = hud_values.PLAYER_WEAPON_PRIMARY_Y
		local weapon_secondary_x = hud_values.PLAYER_WEAPON_SECONDARY_X * scale
		local weapon_secondary_y = hud_values.PLAYER_WEAPON_SECONDARY_Y * scale
		
		
		local weapons_panel_w = hud_values.PLAYER_WEAPONS_W
		local weapons_panel_h = hud_values.PLAYER_WEAPONS_H
		local weapons_panel_x = layout_settings.player_weapons_panel_x
		local weapons_panel_y = layout_settings.player_weapons_panel_y
		
		local margin_xsmall = hud_values.MARGIN_XSMALL * scale
		local margin_small = hud_values.MARGIN_SMALL * scale
		
		local weapon_panel_w = hud_values.PLAYER_WEAPON_W * scale
		local weapon_panel_h = hud_values.PLAYER_WEAPON_H * scale
		local weapon_panel_x = hud_values.PLAYER_WEAPON_X
		local weapon_panel_y = hud_values.PLAYER_WEAPON_Y
		local weapon_font_size_large = hud_values.PLAYER_WEAPON_FONT_SIZE_LARGE * scale
		local weapon_font_size_small = hud_values.PLAYER_WEAPON_FONT_SIZE_SMALL * scale
		local weapon_icon_x = hud_values.PLAYER_WEAPON_ICON_X * scale
		local weapon_icon_y = hud_values.PLAYER_WEAPON_ICON_Y * scale
		local weapon_icon_w = hud_values.PLAYER_WEAPON_ICON_W * scale
		local weapon_icon_h = hud_values.PLAYER_WEAPON_ICON_H * scale
		local weapon_icon_bg_alpha = hud_values.PLAYER_WEAPON_ICON_BG_ALPHA
		local weapon_border_alpha = hud_values.PLAYER_WEAPON_BORDER_ALPHA
		local weapon_border_thickness = hud_values.PLAYER_WEAPON_BORDER_THICKNESS * scale
		local weapon_firemode_w = hud_values.PLAYER_WEAPON_FIREMODE_W * scale
		local weapon_firemode_h = hud_values.PLAYER_WEAPON_FIREMODE_H * scale
			
		local weapon_reserve_x = hud_values.PLAYER_WEAPON_RESERVE_X * scale
		
		if not skip_parent then 
			if not skip_reposition then 
				parent_weapons_panel:set_position(weapons_panel_x,weapons_panel_y)
			end
			parent_weapons_panel:set_size(weapons_panel_w,weapons_panel_h)
		end
		
		local function layout_weapon_subpanel(index)
			local scale
			if index == highlighted_index then 
				scale = weapon_primary_scale
			else
				scale = weapon_secondary_scale
			end
			
			local icon_x = weapon_icon_x * scale
			local icon_y = weapon_icon_y * scale
			local icon_w = weapon_icon_w * scale
			local icon_h = weapon_icon_h * scale
			local box_w = weapon_panel_w * scale
			local box_h = weapon_panel_h * scale
			local box_x = weapon_panel_x * scale
			local box_y = weapon_panel_y * scale
			local font_size_large = weapon_font_size_large * scale
			local font_size_small = weapon_font_size_small * scale
			local border_alpha = weapon_border_alpha
			local border_thickness = weapon_border_thickness * scale
			local icon_bg_alpha = weapon_icon_bg_alpha
			local firemode_w = weapon_firemode_w * scale
			local firemode_h = weapon_firemode_h * scale
			local reserve_x = weapon_reserve_x * scale
			
			local ammo_text_bottom = -box_h / 20
			local ammo_text_top = box_h / 20
			
			local weapon_panel = parent_weapons_panel:child(tostring(index))
			weapon_panel:set_size(box_w,box_h)
			if not skip_reposition then 
				weapon_panel:set_position(box_x,box_y)
			end
			
			local icon_box = weapon_panel:child("icon_box")
			icon_box:set_position(icon_x,icon_y)
			icon_box:set_size(icon_w,icon_h)
			
			local icon_bitmap = icon_box:child("icon_bitmap")
			icon_bitmap:set_position(0,0)
			icon_bitmap:set_size(icon_w,icon_h)
			
			local icon_bg = icon_box:child("icon_bg")
			icon_bg:set_position(0,0)
			icon_bg:set_size(box_w,box_h)
			icon_bg:set_alpha(icon_bg_alpha)
			
			local border = self:PanelBorder(icon_box,{
				thickness = border_thickness,
				color = Color.white,
				alpha = border_alpha,
				layer = 2
			}) --only creates a new panel border if one does not exist
			
			local firemode = weapon_panel:child("firemode")
			firemode:set_size(firemode_w,firemode_h)
			firemode:set_position(icon_box:right() + margin_xsmall,(weapon_panel:h() - firemode:h()) / 2) --vertically centered
			
			local magazine = weapon_panel:child("magazine")
			local reserve = weapon_panel:child("reserve")
			local kill_icon = weapon_panel:child("kill_icon")
			local kill_counter = weapon_panel:child("kill_counter")
			if recreate_text_objects then 
				local magazine_text = magazine:text()
				self:animate_stop(magazine)
				magazine:stop()
				weapon_panel:remove(magazine)
				magazine = weapon_panel:text({
					name = "magazine",
					color = Color.white,
					font = self._fonts.digital,
					text = magazine_text,
					vertical = "bottom",
					x = firemode:right() + margin_small,
					y = ammo_text_bottom,
					layer = 4,
					font_size = font_size_large
				})
				local m_x,m_y,m_w,m_h = magazine:text_rect()
				
				local reserve_text = reserve:text()
				self:animate_stop(reserve)
				reserve:stop()
				weapon_panel:remove(reserve)
				reserve = weapon_panel:text({
					name = "reserve",
					color = Color.white,
					font = self._fonts.digital,
					text = reserve_text,
					vertical = "bottom",
					x = magazine:x() + m_w + reserve_x,
					y = ammo_text_bottom,
					layer = 4,
					font_size = font_size_small
				})
		
				local kill_icon_text = kill_icon:text()
				self:animate_stop(kill_icon)
				kill_icon:stop()
				weapon_panel:remove(kill_icon)
				kill_icon = weapon_panel:text({
					name = "kill_icon",
					color = Color.white,
					font = self._fonts.large,
					text = kill_icon_text,
					align = "right",
					vertical = "top",
					x = -margin_small + - (weapon_panel:w() -icon_box:x()),
					y = ammo_text_top,
					layer = 4,
					font_size = font_size_large
				})
				
				local kill_counter_text = kill_counter:text()
				self:animate_stop(kill_counter)
				kill_counter:stop()
				weapon_panel:remove(kill_counter)
				kill_counter = weapon_panel:text({
					name = "kill_counter",
					color = Color.white,
					font = self._fonts.digital,
					text = kill_counter_text,
					align = "right",
					vertical = "bottom",
					x = -margin_small + - (weapon_panel:w() -icon_box:x()),
					y = ammo_text_bottom,
					layer = 4,
					font_size = font_size_large
				})
			else
				magazine:set_font_size(font_size_large)
				magazine:set_position(firemode:right() + margin_small,ammo_text_bottom)
				
				local m_x,m_y,m_w,m_h = magazine:text_rect()
				
				reserve:set_font_size(font_size_small)
				reserve:set_position(firemode:right() + m_w + reserve_x,ammo_text_bottom)
				
				kill_icon:set_font_size(font_size_large)
				kill_icon:set_position(-margin_small + - (weapon_panel:w() -icon_box:x()),ammo_text_top)
				
				kill_counter:set_font_size(font_size_large)
				kill_counter:set_position(-margin_small + - (weapon_panel:w() -icon_box:x()),ammo_text_bottom)
			end
			
			local debug_rect = weapon_panel:child("debug_rect")
			debug_rect:set_size(weapon_panel:size())
			debug_rect:set_position(0,0)
			
		end
		
		if single_layout then 
			layout_weapon_subpanel(single_layout)
		else
			layout_weapon_subpanel(2)
			layout_weapon_subpanel(1)
			if not skip_reposition then 
				local w1,w2
				if highlighted_index == 1 then 
					w1 = parent_weapons_panel:child("1")
					w2 = parent_weapons_panel:child("2")
				else
					w1 = parent_weapons_panel:child("2")
					w2 = parent_weapons_panel:child("1")
				end
				w1:set_position(weapon_primary_x,weapon_primary_y)
				w2:set_position(weapon_primary_x + weapon_secondary_x,weapon_panel_y + (scale * weapon_panel_h) + weapon_secondary_y)
			end
		end
		
	end
end

function KineticHUD:LayoutPlayerEquipmentPanel(params)
	local player_equipment_panel = self._player_equipment_panel
	if not alive(player_equipment_panel) then 
		return
	end
	
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.player_equipment_panel_scale
	
	local equipments_x = layout_settings.PLAYER_EQUIPMENT_X * scale
	local equipments_y = layout_settings.PLAYER_EQUIPMENT_Y * scale
	
	player_equipment_panel:set_position(equipments_x,equipments_y)
	
	local deployable_1_x = hv.PLAYER_EQUIPMENT_DEPLOYABLE_1_X * scale
	local deployable_1_y = hv.PLAYER_EQUIPMENT_DEPLOYABLE_1_Y * scale
	
	local deployable_2_x = hv.PLAYER_EQUIPMENT_DEPLOYABLE_2_X * scale
	local deployable_2_y = hv.PLAYER_EQUIPMENT_DEPLOYABLE_2_Y * scale
	
	local cable_ties_x = hv.PLAYER_EQUIPMENT_CABLE_TIES_X * scale
	local cable_ties_y = hv.PLAYER_EQUIPMENT_CABLE_TIES_Y * scale
	
	local throwable_x = hv.PLAYER_EQUIPMENT_THROWABLE_X * scale
	local throwable_y = hv.PLAYER_EQUIPMENT_THROWABLE_Y * scale
	
	local deployable_1 = player_equipment_panel:child("deployable_1")
	deployable_1:set_position(deployable_1_x,deployable_1_y)
--	deployable_1:hide() 
	
	local deployable_2 = player_equipment_panel:child("deployable_2")
	deployable_2:set_position(deployable_2_x,deployable_2_y)
--	deployable_2:hide() 
	
	local cable_ties = player_equipment_panel:child("cable_ties")
	cable_ties:set_position(cable_ties_x,cable_ties_y)
--	cable_ties:hide()
	
	local throwable = player_equipment_panel:child("throwable")
	throwable:set_position(throwable_x,throwable_y)
--	throwable:hide()
	
end

function KineticHUD:LayoutPlayerMissionEquipmentPanel()
	local player_mission_equipment_panel = self._player_mission_equipment_panel
	if alive(player_mission_equipment_panel) then 
		local hv = self.hud_values
		local layout_settings = self.layout_settings
		local scale = layout_settings.player_mission_equipment_panel_scale
		
		local mission_equipment_w = hv.PLAYER_MISSION_EQUIPMENT_W * scale
		local mission_equipment_h = hv.PLAYER_MISSION_EQUIPMENT_H * scale
		
		local mission_equipment_x = layout_settings.PLAYER_MISSION_EQUIPMENT_X * scale
		local mission_equipment_y = layout_settings.PLAYER_MISSION_EQUIPMENT_Y * scale
		
		player_mission_equipment_panel:set_position(mission_equipment_x,mission_equipment_y)
		player_mission_equipment_panel:set_size(mission_equipment_w,mission_equipment_h)
	end
end

function KineticHUD:LayoutTeammatesPanel()
	--todo
end

function KineticHUD:LayoutTeammatePanel(i,recreate_text_objects)
	local teammate = self._teammate_panels[i]
	if alive(teammate) then 
	
		local hv = self.hud_values
		local layout_settings = self.layout_settings
		local scale = layout_settings.teammates_panel_scale
		local margin = hv.MARGIN_XSMALL * scale
		local margin_medium = hv.MARGIN_MEDIUM * scale
		local teammate_x = hv.TEAMMATE_PANEL_X * scale
		local teammate_y = hv.TEAMMATE_PANEL_Y * scale
		local teammate_w = hv.TEAMMATE_PANEL_W * scale
		local teammate_h = hv.TEAMMATE_PANEL_H * scale
		local nametag_panel_w = hv.TEAMMATE_NAMETAG_PANEL_W * scale
		local nametag_panel_h = hv.TEAMMATE_NAMETAG_PANEL_H * scale
		local nametag_panel_x = hv.TEAMMATE_NAMETAG_PANEL_X * scale
		local nametag_panel_y = hv.TEAMMATE_NAMETAG_PANEL_Y -margin
		local nametag_font_size = hv.TEAMMATE_NAMETAG_FONT_SIZE * scale
		local color_indicator_w = hv.TEAMMATE_COLOR_INDICATOR_W * scale
		local color_indicator_h = (hv.TEAMMATE_COLOR_INDICATOR_H * scale) + nametag_panel_h
		local color_indicator_x = hv.TEAMMATE_COLOR_INDICATOR_X * scale
		local color_indicator_y = hv.TEAMMATE_COLOR_INDICATOR_Y * scale
		local bpm_panel_w = hv.TEAMMATE_BPM_PANEL_W * scale
		local bpm_panel_h = (hv.TEAMMATE_BPM_PANEL_H * scale) + nametag_panel_h
		local bpm_panel_x = (hv.TEAMMATE_BPM_PANEL_X * scale) + color_indicator_w + nametag_panel_x + nametag_panel_w
		local bpm_panel_y = hv.TEAMMATE_BPM_PANEL_Y * scale
		local bpm_icon_w = nametag_panel_h * hv.TEAMMATE_BPM_ICON_SIZE_MUL
		local bpm_icon_h = nametag_panel_h * hv.TEAMMATE_BPM_ICON_SIZE_MUL
		local bpm_icon_x = hv.TEAMMATE_BPM_ICON_X * scale
		local bpm_icon_y = hv.TEAMMATE_BPM_ICON_Y * scale
		local bpm_mask_h = nametag_panel_h
		local bpm_mask_x = (hv.TEAMMATE_BPM_MASK_X * scale) + (bpm_icon_w / 2)
		local bpm_mask_w = bpm_panel_w - bpm_mask_x
		local bpm_mask_y = hv.TEAMMATE_BPM_MASK_Y * scale
		
		local speaking_icon_x = (hv.TEAMMATE_SPEAKING_ICON_X * scale) + bpm_panel_x + bpm_panel_w
		local speaking_icon_y = hv.TEAMMATE_SPEAKING_ICON_Y * scale
		local speaking_icon_w = (nametag_panel_h * hv.TEAMMATE_SPEAKING_ICON_SIZE_MUL)
		local speaking_icon_h = (nametag_panel_h * hv.TEAMMATE_SPEAKING_ICON_SIZE_MUL)
		
		
		local deployable_1_x = hv.TEAMMATE_DEPLOYABLE_X * scale
		local deployable_1_y = (hv.TEAMMATE_DEPLOYABLE_Y * scale) + nametag_panel_h
		
		
		local revives_font_size = hv.TEAMMATE_REVIVES_FONT_SIZE * scale
		
		local eq_box_w = hv.TEAMMATE_EQUIPMENT_BOX_W * scale
		local eq_box_h = hv.TEAMMATE_EQUIPMENT_BOX_H * scale
		local eq_box_w_double_mul = hv.TEAMMATE_EQUIPMENT_BOX_DOUBLE_W_MUL
		
		teammate:set_size(teammate_w,teammate_h)
		teammate:set_position(teammate_x,teammate_y + ((teammate_h + margin_medium)* (i - 1)))
		
		local color_indicator = teammate:child("color_indicator")
		color_indicator:set_size(color_indicator_w,color_indicator_h)
		color_indicator:set_position(color_indicator_x,color_indicator_y)
		
		local nametag_panel = teammate:child("nametag_panel")
		local nametag = nametag_panel:child("nametag")
		if recreate_text_objects then 
			local nametag_text = nametag:text()
			self:animate_stop(nametag,false)
			nametag:stop()
			nametag_panel:remove(nametag)
			nametag = nametag_panel:text({
				name = "nametag",
				text = nametag_text,
				font = self._fonts.syke,
				font_size = nametag_font_size,
				align = "left",
				vertical = "top",
				layer = 6
			})
		else
			nametag:set_font_size(nametag_font_size)
		end
		local bpm_panel = teammate:child("bpm_panel")
		bpm_panel:set_size(bpm_panel_w,bpm_panel_h)
		bpm_panel:set_position(bpm_panel_x,bpm_panel_y)
		
		local bpm_icon_box = bpm_panel:child("bpm_icon_box")
		bpm_icon_box:set_size(bpm_icon_w,bpm_icon_h)
		bpm_icon_box:set_position(bpm_icon_x,bpm_icon_y)
		local bpm_icon = bpm_icon_box:child("bpm_icon")
		bpm_icon:set_size(bpm_icon_w,bpm_icon_h)
		bpm_icon:set_position(0,0)
		local bpm_mask = bpm_panel:child("bpm_mask")
		bpm_mask:set_size(bpm_mask_w,bpm_mask_h)
		bpm_mask:set_position(bpm_mask_x,bpm_mask_y)
		
		local revives = bpm_icon_box:child("revives")
		if recreate_text_objects then 
			local revives_text = revives:text()
			revives:stop()
			self:animate_stop(revives,false)
			bpm_icon_box:remove(revives)
			revives = bpm_icon_box:text({
				name = "revives",
				text = "0",
				font = self._fonts.digital,
				font_size = revives_font_size,
				align = "center",
				vertical = "center",
				layer = 5
			})
		else
			revives:set_font_size(revives_font_size)
		end
		
		local speaking_icon = teammate:child("speaking_icon")
		local location_text = teammate:child("location_text")
		if recreate_text_objects then 
			local location = location_text:text()
			location_text:stop()
			self:animate_stop(location_text,false)
			teammate:remove(location_text)
			location_text = teammate:text({
				name = "location_text",
				text = "",
				font = self._fonts.syke,
				font_size = nametag_font_size,
				align = "left",
				vertical = "top",
				x = bpm_panel:right() + margin,
				y = -margin,
				layer = 6
			})
		else
			location_text:set_font_size(nametag_font_size)
		end
		local deployable_1 = teammate:child("deployable_1")
		local deployable_2 = teammate:child("deployable_2")
		local cable_ties = teammate:child("cable_ties")
		local throwable = teammate:child("throwable")
		
		local deployable_1_text_2 = deployable_1:child("text_2")
		if deployable_1_text_2:visible() then 
			--local d1t2x,d1t2y,d1t2w,d1t2h = deployable_1_text_2:text_rect()
			--deployable_1:set_size(d1t2x + d1t2w,eq_box_h)
			deployable_1:set_size(eq_box_w * eq_box_w_double_mul,eq_box_h)
		else
			deployable_1:set_size(eq_box_w,eq_box_h)
		end
		deployable_1:set_position(deployable_1_x,deployable_1_y)
		
		if deployable_2:visible() then 
			local deployable_2_text_2 = deployable_2:child("text_2")
			if deployable_2_text_2:visible() then 
--				local d2t2x,d2t2y,d2t2w,d2t2h = deployable_2_text_2:text_rect()
--				deployable_2:set_size(d2t2x + d2t2w + margin,eq_box_h)
				deployable_2:set_size(eq_box_w * eq_box_w_double_mul,eq_box_h)
			else
				deployable_2:set_size(eq_box_w,eq_box_h)
			end
			deployable_2:set_position(deployable_1:right(),deployable_1_y)
			cable_ties:set_x(deployable_2:right())
		elseif deployable_1:visible() then 
			cable_ties:set_x(deployable_1:right())
		else
			cable_ties:set_x(deployable_1_x)
		end
		cable_ties:set_size(eq_box_w,eq_box_h)
		cable_ties:set_y(deployable_1_y)
		throwable:set_size(eq_box_w,eq_box_h)
		throwable:set_position(cable_ties:right(),deployable_1_y)
		
	end
end

function KineticHUD:LayoutAssaultPanel(params)
	if not (params and type(params) == "table") then 
		params = {}
	end
	
	local assault_panel = self._assault_panel
	local parent_panel = assault_panel:parent()
	
	local recreate_text_objects = params.recreate_text_objects
	
	local hud_values = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.assault_panel_scale
	
	local panel_x = 0
	local panel_y = 0
	
	local assault_x = layout_settings.ASSAULT_X * scale
	local assault_y = layout_settings.ASSAULT_Y * scale
	local panel_w = hud_values.ASSAULT_W * scale
	local panel_h = hud_values.ASSAULT_H * scale
	
	local icon_w = hud_values.ASSAULT_ICON_W * scale
	local icon_h = hud_values.ASSAULT_ICON_H * scale
	local icon_x = hud_values.ASSAULT_ICON_X * scale
	local icon_y = hud_values.ASSAULT_ICON_Y * scale
	
	local phase_label_x = hud_values.ASSAULT_PHASE_LABEL_X * scale
	local phase_label_y = hud_values.ASSAULT_PHASE_LABEL_Y * scale
	
	local assault_phase_font_size = hud_values.ASSAULT_PHASE_LABEL_FONT_SIZE * scale
	
	if hud_values.ASSAULT_HALIGN == "right" then 
		panel_x = parent_panel:w() - (panel_w + assault_x)
	elseif hud_values.ASSAULT_HALIGN == "center" then 
		panel_x = assault_x + (( parent_panel:w() - panel_w ) / 2)
	else
		panel_x = assault_x
	end
	
	if hud_values.ASSAULT_VALIGN == "bottom" then 
		panel_y = parent_panel:h() - (panel_h + assault_y)
	elseif hud_values.ASSAULT_VALIGN == "center" then 
		panel_y = assault_y + ((parent_panel:h() - panel_h) / 2)
	else
		panel_y = assault_y
	end
	
	assault_panel:set_position(panel_x,panel_y)
	assault_panel:set_size(panel_w,panel_h)

	local assault_icon = assault_panel:child("assault_icon")
	local assault_phase_label = assault_panel:child("assault_phase_label")
	local assault_timer_label
	local assault_faction_label
	local assault_difficulty_label
	local assault_spawns_label
	
	local hostages_icon
	local hostages_label
	
	assault_icon:set_size(icon_w,icon_h)
	assault_icon:set_position(icon_x,icon_y)
	if recreate_text_objects then 
		local assault_phase_label_text = assault_phase_label:text()
		assault_phase_label:parent():remove(assault_phase_label)
		assault_phase_label = assault_panel:text({
			name = "assault_phase_label",
			text = assault_phase_label_text,
			font = self._fonts.syke,
			font_size = assault_phase_font_size,
			align = hud_values.ASSAULT_PHASE_LABEL_HALIGN,
			vertical = hud_values.ASSAULT_PHASE_LABEL_VALIGN,
			color = hud_values.ASSAULT_PHASE_LABEL_COLOR,
			layer = 2,
			x = phase_label_x,
			y = phase_label_y
		})
	else
		assault_phase_label:set_font_size(assault_phase_font_size)
		assault_phase_label:set_align(hud_values.ASSAULT_PHASE_LABEL_HALIGN)
		assault_phase_label:set_vertical(hud_values.ASSAULT_PHASE_LABEL_VALIGN)
		assault_phase_label:set_color(hud_values.ASSAULT_PHASE_LABEL_COLOR)
		assault_phase_label:set_position(phase_label_x,phase_label_y)
	end
	
end

function KineticHUD:LayoutObjectivePanel()
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	
	local scale = self.layout_settings.objective_panel_scale
	local objective_panel = self._objective_panel
	local parent_panel = objective_panel:parent()
	
	local panel_x = 0
	local panel_y = 0
	
	local objective_x = layout_settings.OBJECTIVE_X * scale
	local objective_y = layout_settings.OBJECTIVE_Y * scale
	local panel_w = hv.OBJECTIVE_W * scale
	local panel_h = hv.OBJECTIVE_H * scale
	if hv.OBJECTIVE_HALIGN == "right" then 
		panel_x = parent_panel:w() - (panel_w + objective_x)
	elseif hv.OBJECTIVE_HALIGN == "center" then 
		panel_x = objective_x + (( parent_panel:w() - panel_w ) / 2)
	else
		panel_x = objective_x
	end
	if hv.OBJECTIVE_VALIGN == "bottom" then 
		panel_y = parent_panel:h() - (panel_h + objective_y)
	elseif hv.OBJECTIVE_VALIGN == "center" then 
		panel_y = objective_y + ((parent_panel:h() - panel_h) / 2)
	else
		panel_y = objective_y
	end
	
	
	local title_font_size = hv.OBJECTIVE_TITLE_TEXT_FONT_SIZE * scale
	local title_x = hv.OBJECTIVE_TITLE_TEXT_X * scale
	local title_y = hv.OBJECTIVE_TITLE_TEXT_Y * scale
	
	local current_text_font_size = hv.OBJECTIVE_TEXT_FONT_SIZE * scale
	local current_text_x = hv.OBJECTIVE_TEXT_X * scale
	local current_text_y = hv.OBJECTIVE_TEXT_Y * scale
	
	local current_count_font_size = hv.OBJECTIVE_COUNT_TEXT_FONT_SIZE * scale
	local current_count_x = hv.OBJECTIVE_COUNT_TEXT_X * scale
	local current_count_y = hv.OBJECTIVE_COUNT_TEXT_Y * scale
	
	
	
	objective_panel:set_position(panel_x,panel_y)
	objective_panel:set_size(panel_w,panel_h)
	
	local objective_title_text = objective_panel:child("objective_title_text")
--	objective_title_text:set_font(Idstring(self._fonts.tommy_bold))
	objective_title_text:set_font_size(title_font_size)
	objective_title_text:set_align(hv.OBJECTIVE_TITLE_TEXT_HALIGN)
	objective_title_text:set_vertical(hv.OBJECTIVE_TITLE_TEXT_VALIGN)
	objective_title_text:set_color(hv.OBJECTIVE_TITLE_TEXT_COLOR)
	objective_title_text:set_position(title_x,title_y)
	
--	objective_title_text:set_text(managers.localization:text("khud_hud_objective_title")) --redundant
	
	
	local current_objective_text = objective_panel:child("current_objective_text")
	current_objective_text:set_font(Idstring(self._fonts.syke))
	current_objective_text:set_font_size(current_text_font_size)
	current_objective_text:set_align(hv.OBJECTIVE_TEXT_HALIGN)
	current_objective_text:set_vertical(hv.OBJECTIVE_TEXT_VALIGN)
	current_objective_text:set_color(hv.OBJECTIVE_TEXT_COLOR)
	current_objective_text:set_position(current_text_x,current_text_y)
	
	local current_count_text = objective_panel:child("current_count_text")
--	current_count_text:set_font(Idstring(self._fonts.syke))
	current_count_text:set_font_size(current_count_font_size)
	current_count_text:set_align(hv.OBJECTIVE_COUNT_TEXT_HALIGN)
	current_count_text:set_vertical(hv.OBJECTIVE_COUNT_TEXT_VALIGN)
	current_count_text:set_color(hv.OBJECTIVE_COUNT_TEXT_COLOR)
	current_count_text:set_position(current_count_x,current_count_y)
end


function KineticHUD:LayoutCarryPanel() 
	local carry_panel = self._carry_panel
	
	local hv = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.player_carry_panel_scale
	
	
	local carry_x = layout_settings.CARRY_X
	local carry_y = layout_settings.CARRY_Y
	local carry_w = hv.CARRY_W * scale
	local carry_h = hv.CARRY_H * scale
	
	local carry_icon_x = hv.CARRY_ICON_X * scale
	local carry_icon_y = hv.CARRY_ICON_Y * scale
	local carry_icon_w = hv.CARRY_ICON_W * scale
	local carry_icon_h = hv.CARRY_ICON_H * scale
	
	local carry_label_font_size = hv.CARRY_LABEL_FONT_SIZE * scale
	local carry_label_x = hv.CARRY_LABEL_X * scale
	local carry_label_y = hv.CARRY_LABEL_Y * scale
	local carry_value_x = hv.CARRY_VALUE_X * scale
	local carry_value_y = hv.CARRY_VALUE_Y * scale
	
	local carry_value_font_size = hv.CARRY_VALUE_FONT_SIZE * scale
	
	carry_panel:set_position(carry_x,carry_y)
	carry_panel:set_size(carry_w,carry_h)
	
	local bag_icon = carry_panel:child("bag_icon")
	bag_icon:set_position(carry_icon_x,carry_icon_y)
	bag_icon:set_size(carry_icon_w,carry_icon_h)
	
	local bag_label = carry_panel:child("bag_label")
	if alive(bag_label) then 
		bag_label:set_position(carry_label_x,carry_label_y)
		bag_label:set_font_size(carry_label_font_size)
		bag_label:set_align(hv.CARRY_LABEL_HALIGN)
		bag_label:set_vertical(hv.CARRY_LABEL_VALIGN)
	end
	local bag_value = carry_panel:child("bag_value")
	if alive(bag_value) then 
		bag_value:set_position(carry_value_x,carry_value_y)
		bag_value:set_font_size(carry_value_font_size)
		bag_value:set_align(hv.CARRY_VALUE_HALIGN)
		bag_value:set_vertical(hv.CARRY_VALUE_VALIGN)
	end
	
end

------  HUD setters  ------

	--objective
function KineticHUD:SetObjectiveText(text,from,skip_animate)
	if alive(self._objective_panel) then 
		local hud_values = self.hud_values
		local current_objective_text = self._objective_panel:child("current_objective_text")
		--todo format instead of appending ">"
--		current_objective_text:set_text("> " .. text)
		if from == "complete" then 
			--animate complete here
			
		elseif from == "activate" then 
			--animate in here
		end
		
		self:animate_stop(current_objective_text)
		local typing_char = "|"
		local duration = string.len(text) * hud_values.OBJECTIVE_ANIMATE_TEXT_TYPING_SPEED
		
		local function type_cb(o)
			self:animate(o,"animate_text_typing",nil,duration,text,typing_char,hud_values.OBJECTIVE_ANIMATE_TEXT_TYPING_HOLD_DURATION,nil)	
		end
		local current_text = current_objective_text:text()
		if string.len(current_text) > 0 then 
			self:animate(current_objective_text,"animate_text_backspaced",type_cb,hud_values.OBJECTIVE_ANIMATE_TEXT_BACKSPACE_DURATION,current_text,typing_char,hud_values.OBJECTIVE_ANIMATE_TEXT_TYPING_CURSOR_BLINK_SPEED,nil)
		else
			type_cb(current_objective_text)
		end
	end
end

function KineticHUD:SetObjectiveAmount(current,total,from)
	if alive(self._objective_panel) then 
		if total and current then 
			self._objective_panel:child("current_count_text"):set_text(tostring(current) .. " / " .. tostring(total))
		else
			self._objective_panel:child("current_count_text"):set_text(tostring(current or total or ""))
		end
	end
end

	--player weapon
function KineticHUD:SetPlayerWeaponSelected(i)
	KineticHUD:AnimateSwitchWeapons(i)
end
	
function KineticHUD:SetPlayerWeaponFiremode(i,firemode)
	if alive(self._player_weapons_panel) then 
		local weapon_panel = self._player_weapons_panel:child(tostring(i))
		if alive(weapon_panel) then 
			local hud_values = self.hud_values
			local texture
			local w = hud_values.FIREMODE_TEXTURE_W
			local h = hud_values.FIREMODE_TEXTURE_H
			if firemode == "auto" then 
				texture = hud_values.FIREMODE_AUTO_TEXTURE
			elseif firemode == "single" then 
				texture = hud_values.FIREMODE_SINGLE_TEXTURE
			elseif firemode == "burst" then 
				texture = hud_values.FIREMODE_BURST_TEXTURE
			elseif firemode == "safety" then 
				texture = hud_values.FIREMODE_AUTO_TEXTURE
				w = 0
				h = 0
			end
			local firemode_icon = weapon_panel:child("firemode")
			if alive(firemode_icon) then 
				firemode_icon:set_image(texture)
--				firemode_icon:set_size(w,h)
			end
		end
	end
end

function KineticHUD:SetPlayerWeaponReserve(i,amount)
	if alive(self._player_weapons_panel) then 
		local weapon_panel = self._player_weapons_panel:child(tostring(i))
		if alive(weapon_panel) then 
			self.SetDigitalText(weapon_panel:child("reserve"),amount,3)
		end
	end
end

function KineticHUD:SetPlayerWeaponMagazine(i,amount)
	if alive(self._player_weapons_panel) then 
		local weapon_panel = self._player_weapons_panel:child(tostring(i))
		if alive(weapon_panel) then 
			self.SetDigitalText(weapon_panel:child("magazine"),amount,3)
		end
	end
end

function KineticHUD:SetPlayerWeaponIcon(i,weapon_id)
	if alive(self._player_weapons_panel) then 
		local weapon_panel = self._player_weapons_panel:child(tostring(i))
		if alive(weapon_panel) then
			local texture,texture_rect = managers.blackmarket:get_weapon_icon_path(weapon_id)
			weapon_panel:child("icon_box"):child("icon_bitmap"):set_image(texture,texture_rect and unpack(texture_rect))
		end
	end
end

function KineticHUD:SetPlayerWeaponKillCount(i,amount)
	if alive(self._player_weapons_panel) then 
		local weapon_panel = self._player_weapons_panel:child(tostring(i))
		if alive(weapon_panel) then 
			weapon_panel:child("kill_counter"):set_text(string.format("%i",amount)) 
			--don't use SetDigitalText() because i don't want padded zeroes
		end
	end
end

function KineticHUD:AnimateAmmoLow(id) --not used
	
end

function KineticHUD:AnimateAmmoEmpty(id) --not used
	
end

function KineticHUD:AnimateSwitchWeapons(highlighted_index)
	local weapons_panel = self._player_weapons_panel
	if alive(weapons_panel) then 
		local w1,w2,params1,params2
		if highlighted_index == 1 then 
			w1 = weapons_panel:child("1")
			w2 = weapons_panel:child("2")
			params1 = {
				recreate_text_objects = true,
				skip_reposition = true,
				skip_parent = true,
				highlighted_index = highlighted_index,
				single_layout = 1
			}
			params2 = {
				recreate_text_objects = true,
				skip_reposition = true,
				skip_parent = true,
				highlighted_index = highlighted_index,
				single_layout = 2
			}
		else
			params1 = {
				recreate_text_objects = true,
				skip_reposition = true,
				skip_parent = true,
				highlighted_index = highlighted_index,
				single_layout = 2
			}
			params2 = {
				recreate_text_objects = true,
				skip_reposition = true,
				skip_parent = true,
				highlighted_index = highlighted_index,
				single_layout = 1
			}
			w2 = weapons_panel:child("1")
			w1 = weapons_panel:child("2")
		end
		
		local hud_values = self.hud_values
		local layout_settings = self.layout_settings
		local scale = layout_settings.player_weapons_panel_scale
		
		local weapons_panel_w = hud_values.PLAYER_WEAPONS_W
		local weapons_panel_h = hud_values.PLAYER_WEAPONS_H
		local weapons_panel_x = layout_settings.player_weapons_panel_x
		local weapons_panel_y = layout_settings.player_weapons_panel_y
		
		local weapon_panel_w = hud_values.PLAYER_WEAPON_W * scale
		local weapon_panel_h = hud_values.PLAYER_WEAPON_H * scale
		local weapon_panel_x = hud_values.PLAYER_WEAPON_X
		local weapon_panel_y = hud_values.PLAYER_WEAPON_Y
		
		local weapon_primary_x = hud_values.PLAYER_WEAPON_PRIMARY_X
		local weapon_primary_y = hud_values.PLAYER_WEAPON_PRIMARY_Y
		local weapon_secondary_x = hud_values.PLAYER_WEAPON_SECONDARY_X * scale
		local weapon_secondary_y = (hud_values.PLAYER_WEAPON_SECONDARY_Y + weapon_panel_h) * scale
		
		local weapon_primary_scale = hud_values.PLAYER_WEAPON_PRIMARY_SCALE * scale
		local weapon_secondary_scale = hud_values.PLAYER_WEAPON_SECONDARY_SCALE * scale
		
		local swap_time = hud_values.PLAYER_WEAPON_HUD_ANIMATION_SWAP_DURATION
		
		local cb1,cb2
		self:animate(w2,"animate_weapon_panels_switch",cb2,swap_time,w2:x(),w2:y(),weapon_secondary_x,weapon_secondary_y,2,params2)
		self:animate(w1,"animate_weapon_panels_switch",cb1,swap_time,w1:x(),w1:y(),weapon_primary_x,weapon_primary_y,2,params1)
	end
end

	--player loadout
	
--This function is used to directly check the player's equipment. 
--Because the base game functions that control deployables don't allow for HUDs that can display both primary
-- and secondary deployables, 
--and KineticHUD definitely wants to do that thing I just said,
--I don't really have a choice except to eschew whatever deployable information the HUDManager is asking to display,
--and just check it myself. 
function KineticHUD:CheckPlayerDeployableEquipment()
	local pm = managers.player
	local player = pm:local_player()
	if alive(player) then 
		for i,equipment in ipairs(pm._equipment.selections) do 
			local data = {
				index = i,
				icon = equipment.icon,
				equipment = equipment.equipment, --(equipment)
				amount = {}
			}
			for j,raw in ipairs(equipment.amount) do 
				data.amount[j] = Application:digest_value(raw,false)
			end
			self:SetPlayerDeployableEquipment(data)
		end
		--[[
		if equipment.icon then 
			hud_data.icon = equipment.icon
		end
		if equipment.index then 
			hud_data.icon = equipment.index
		end
		--]]
		
	end
end

function KineticHUD:SetPlayerDeployableEquipment(data)
	local player_equipment_panel = self._player_equipment_panel 
	if alive(player_equipment_panel) then 
		local icon = data.icon
		local amount = data.amount or {}
		local amount_1 = amount[1]
		local amount_2 = amount[2]
		local index = data.index
		local has_any = false
		local deployable
		if index == 2 then 
			deployable = player_equipment_panel:child("deployable_2")
		else
			deployable = player_equipment_panel:child("deployable_1")
		end
		
		if amount_1 then 
			has_any = true
			local text_1 = deployable:child("text")
			self.SetDigitalText(text_1,amount_1,2)
		end
		if amount_2 then 
			has_any = true
			local text_2 = deployable:child("text_2")
			if not text_2:visible() then
				text_2:show()
			end
--			deployable:child("icon_gradient_bg"):set_w(self.hud_values.PLAYER_EQUIPMENT_BOX_W * self.layout_settings.player_equipment_panel_scale)
			self.SetDigitalText(text_2,amount_2,2)
		end
		if has_any then 
			deployable:show()
		end
		if icon then 
			local texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon)
			local icon_box = deployable:child("icon_box")
			local icon_bitmap = icon_box:child("icon_bitmap")
			icon_bitmap:set_image(texture,unpack(texture_rect))
			icon_bitmap:set_center(icon_box:center())
		end
		self:LayoutPlayerEquipmentPanel()
	end
end

function KineticHUD:SetPlayerCableTies(amount)
	local player_equipment_panel = self._player_equipment_panel 
	if alive(player_equipment_panel) then 
		local cable_ties = player_equipment_panel:child("cable_ties")
		if amount then  
			self.SetDigitalText(cable_ties:child("text"),amount,2)
		end
	end
end

function KineticHUD:SetPlayerGrenadesIcon(icon)
	local player_equipment_panel = self._player_equipment_panel 
	if alive(player_equipment_panel) then 
		local throwable = player_equipment_panel:child("throwable")
		if icon then 
			local texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon)
			local icon_box = throwable:child("icon_box")
			local bitmap = icon_box:child("icon_bitmap")
			bitmap:set_image(texture,unpack(texture_rect))
			bitmap:set_center(icon_box:center())
		end
	end
end

function KineticHUD:SetPlayerGrenadesAmount(amount)
	local player_equipment_panel = self._player_equipment_panel 
	if alive(player_equipment_panel) then 
		local throwable = player_equipment_panel:child("throwable")
		if amount then  
			self.SetDigitalText(throwable:child("text"),amount,2)
		end
	end
end

function KineticHUD:SetPlayerHealth(current,total)
	if alive(self._player_vitals_panel) then 
		local health_panel = self._player_vitals_panel:child("health_panel")
		
		self:LayoutPlayerVitals({layout_health = true,health_ratio=current/total})
		self.SetDigitalText(health_panel:child("health_current"),current,3)
		self.SetDigitalText(health_panel:child("health_total"),total,3)
	end
end

function KineticHUD:SetPlayerArmor(current,total)
	if alive(self._player_vitals_panel) then 
		local armor_panel = self._player_vitals_panel:child("armor_panel")
		if total ~= 0 then 
			self:LayoutPlayerVitals({layout_armor = true,armor_ratio= current / total})
		else
			self:LayoutPlayerVitals({layout_armor = true,armor_ratio = 0})
		end
		
		self.SetDigitalText(armor_panel:child("armor_current"),current,3)
		self.SetDigitalText(armor_panel:child("armor_total"),total,3)
--		if total <= 0 then 
--			armor_panel:hide()
--		end
	end
end

Hooks:Add("dcs_standalone_on_revives_changed","khud_downcounterstandalone_onreviveschanged",function(peer_id,revives,prev_revives)
	if peer_id == LuaNetworking:LocalPeerID() then 
		KineticHUD:SetPlayerRevives(revives)
	end
end)

function KineticHUD:SetPlayerRevives(amount)
	if alive(self._player_vitals_panel) then 
		self.SetDigitalText(self._player_vitals_panel:child("revives_text"),amount,1)
	end
end

function KineticHUD:AddPlayerMissionEquipment(data)
	local mission_equipment_panel = self._player_mission_equipment_panel
	
	local id = data.id
	local amount = data.amount or 1
	local icon = data.icon
	
	local scale = self.layout_settings.player_equipment_panel_scale
	local hud_values = self.hud_values
	local layout_settings = self.layout_settings
	local eq_size = hud_values.PLAYER_MISSION_EQUIPMENT_ICON_SIZE * scale
	local margin = hud_values.MARGIN_SMALL * scale
	local margin_xsmall = hud_values.MARGIN_XSMALL * scale
	local margin_xxsmall = hud_values.MARGIN_XXSMALL * scale
	
	local font_size = hud_values.PLAYER_MISSION_EQUIPMENT_FONT_SIZE * scale
	
	local texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon)
	local eq = mission_equipment_panel:panel({
		name = id,
		layer = 1,
		w = eq_size,
		h = 2 * eq_size,
		x = (1 + #self._player_mission_equipment_panel:children()) * (eq_size + margin)
	})
	local bitmap = eq:bitmap({
		name = "bitmap",
		layer = 1,
		texture = texture,
		texture_rect = texture_rect,
		color = self.color_data.teal,
		w = eq_size,
		h = eq_size
	})
	self:PanelBorder(eq,{
		thickness = hud_values.PLAYER_EQUIPMENT_BOX_OUTLINE_THICKNESS,
		color = self.color_data.white,
		alpha = hud_values.PLAYER_EQUIPMENT_BOX_OUTLINE_ALPHA,
		layer = 4,
		h = eq_size
	})
	local text = eq:text({
		name = "amount",
		vertical = "bottom",
		align = "right",
		font = self._fonts.digital or self._fonts.syke or "fonts/font_small_noshadow_mf",
		font_size = font_size,
		x = 0, --if centering, use margin_xsmall
		y = -margin_xxsmall,
		layer = 3,
		text = tostring(amount),
		visible = amount > 1,
		color = self.color_data.white
	})
	local bg = eq:bitmap({
		name = "bg",
		texture = "textures/ui/gradient",
		color = self.color_data.black,
		alpha = hud_values.PLAYER_EQUIPMENT_BOX_BG_ALPHA,
		w = eq:w(),
		h = amount > 1 and eq:h() or eq_size,
		layer = 0
	})
	local function cb()
		self:animate(bitmap,"animate_color_shift_duo",nil,0.5,bitmap:color(),self.color_data.white)
	end
	self:animate_wait(2,cb)
	--[[
	local function cb(o)
		self:animate(o,"animate_color_shift_duo",nil,0.5,o:color(),Color.white)
	end
	self:animate(bitmap,"animate_color_shift_duo",cb,1,bitmap:color(),Color.yellow)
--]]
	self:AnimateLayoutPlayerMissionEquipment()
end

function KineticHUD:SetPlayerMissionEquipmentAmount(id,amount)
	amount = amount or 1
	local mission_equipment_panel = self._player_mission_equipment_panel
	local eq = mission_equipment_panel:child(id)
	if alive(eq) then 
		local text = eq:child("amount")
		text:set_text(amount)
		text:set_visible(amount > 1)
		self:AnimateLayoutPlayerMissionEquipment()
		local bg = eq:child("bg")
		bg:set_h(eq:h() * (amount > 1 and 2 or 1))
	else
		self:c_log("ERROR: Bad id to SetPlayerMissionEquipmentAmount(" .. tostring(id) .. "," .. tostring(amount) .. ")")
	end
end

function KineticHUD:RemovePlayerMissionEquipment(id)
	local mission_equipment_panel = self._player_mission_equipment_panel
	local do_animate
	for i,eq in ipairs(self._player_mission_equipment_panel:children()) do 
		if eq:name() == id then 
			eq:parent():remove(eq)
			do_animate = true
		end
	end
	if do_animate then 
		self:AnimateLayoutPlayerMissionEquipment()
	end
end

function KineticHUD:ClearPlayerMissionEquipment()
	local do_animate
	for i,eq in ipairs(self._player_mission_equipment_panel:children()) do 
		eq:parent():remove(eq)
		do_animate = true
	end
	if do_animate then 
		self:AnimateLayoutPlayerMissionEquipment()
	end
end

function KineticHUD:AnimateLayoutPlayerMissionEquipment(resize)
	local player_mission_equipment_panel = self._player_mission_equipment_panel
	local eqs = player_mission_equipment_panel:children()
	local margin = 8
--	local is_even = false
	local c_x,_ = player_mission_equipment_panel:center()
	local c_y = 0
	local half = #eqs / 2
	for i,eq in ipairs(eqs) do 
		if resize then 
			--todo
		end
		self:animate_stop(eq)
		--align center (limit of 8 at 48x, 8 margin)
		local x1,y1 = eq:position()
		local y2 = 0
		local x2 = (i - half) * (eq:w() + margin)
		
		--[[ multirow (buggy/incomplete)
		local nx = x2 + c_x + eq:w()
		if nx > player_mission_equipment_panel:w() or nx < eq:w() then 
			x2 = -half * (eq:w() + margin)
			y2 = y2 + eq:h() + margin
			j = 0
		end
		--]]
		--[[ --zigzag centered
		local x2 = (math.floor(i/2)) * (margin + eq:w())
		if is_even then 
			x2 = -x2
		end
		is_even = not is_even
		--]]
		--[[ align from left
		local x2 = (32 + 8) * (i - 1)
		local y2 = 0
		--]]
		self:animate(eq,"animate_move_sin",nil,0.25,x1,y1,c_x + x2,c_y + y2)
	end
end

function KineticHUD:AddTeammateMissionEquipment(id,amount)
	
end

-- teammate
function KineticHUD:SetTeammateName(i,name)
	local teammate_panel = self._teammate_panels[i]
	if teammate_panel then 
		teammate_panel:child("nametag_panel"):child("nametag"):set_text(name)
	end
end

function KineticHUD:SetTeammatePeerId(i,id)
	local teammate_panel = self._teammate_panels[i]
	if teammate_panel then 
		teammate_panel:child("color_indicator"):set_color(tweak_data.chat_colors[#tweak_data.chat_colors])
	end
end

function KineticHUD:SetTeammateArmor(i,current,total)

end

function KineticHUD:SetTeammateHealth(i,current,total)
	self._cache.teammate_health[i] = current/total
	local teammate = self._teammate_panels[i]
	if alive(teammate) and not teammate:child("bpm_panel"):visible() then 
		teammate:child("bpm_panel"):show()
	end
	
end

function KineticHUD:SetTeammateRevives(i,current)
	local teammate = self._teammate_panels[i]
	if alive(teammate) then 
		teammate:child("bpm_panel"):child("bpm_icon_box"):child("revives"):set_text(string.format("%01i",math.clamp(current,0,99)))
	end
end

function KineticHUD:SetTeammateCableTies(i,amount)
	local teammate_panel = self._teammate_panels[i]
	if teammate_panel then 
		local cable_ties = teammate_panel:child("cable_ties")
		if amount then 
			self.SetDigitalText(cable_ties:child("text"),amount,2)
		end
		if not cable_ties:visible() then
			cable_ties:show()
			self:LayoutTeammatePanel(i)
		end
	end
end

function KineticHUD:SetTeammateGrenadesIcon(i,icon_id)
	local teammate = self._teammate_panels[i]
	if alive(teammate) then 
		local grenades_panel = teammate:child("throwable")

		local texture,texture_rect = tweak_data.hud_icons:get_icon_data(icon_id)
		if texture then 
			if true or not grenades_panel:visible() then 
				local icon_box = grenades_panel:child("icon_box")
				local icon_bitmap = icon_box:child("icon_bitmap")
				icon_bitmap:set_image(texture,unpack(texture_rect))
				grenades_panel:show()
				icon_bitmap:set_center(icon_box:center())
				self:LayoutTeammatePanel()
			end
		end
	end
end

function KineticHUD:SetTeammateGrenadesAmount(i,amount)
	local teammate = self._teammate_panels[i]
	if alive(teammate) then 
		local grenades_panel = teammate:child("throwable")
		self.SetDigitalText(grenades_panel:child("text"),amount,2)
	end
end

function KineticHUD:SetTeammateDeployableEquipment(i,index,data)
	index = index or 1
	local teammate = self._teammate_panels[i]
	local queue_layout = false
	if alive(teammate) then 
		local deployable
		if index == 2 then
			deployable = teammate:child("deployable_2")
		else
			deployable = teammate:child("deployable_1")
		end
		if not deployable:visible() then 
			deployable:show()
			queue_layout = true
		end
		
		if data.icon then 
			local icon_box = deployable:child("icon_box")
			local deployable_icon = icon_box:child("icon")
			local texture,texture_rect = tweak_data.hud_icons:get_icon_data(data.icon)
			if alive(deployable_icon) then 
				deployable_icon:set_image(texture,unpack(texture_rect))
				deployable_icon:set_center(icon_box:center())
				queue_layout = true
			end
		end
		if data.amount then
			local amount
			local deployable_text = deployable:child("text")
			if type(data.amount) == "table" then 
				if data.amount[1] then 
					self.SetDigitalText(deployable_text,data.amount[1],2)
				end
				if data.amount[2] then 
					local deployable_text_2 = deployable:child("text_2")
					self.SetDigitalText(deployable_text_2,data.amount[2],2)
					if not deployable_text_2:visible() then 
						deployable_text_2:show()
						queue_layout = true
					end
				end
			else
				self.SetDigitalText(deployable_text,data.amount,2)
			end
		end
	end
	if queue_layout then 
		self:LayoutTeammatePanel(i)
	end
end

--objective/assault
function KineticHUD:AnimateShowAssaultBanner(new_text,duration,post_duration)
	local label = self._assault_panel:child("assault_phase_label")
	self:animate_stop(label)
	local typing_char = "|"
	function cb(o)
		self:animate(o,"animate_text_typing",nil,duration or 3,new_text,typing_char,post_duration,1)	
	end
	self:animate(label,"animate_text_backspaced",cb,0.5,label:text(),typing_char,1,1)
end

function KineticHUD:AnimateHideAssaultBanner()
	local label = self._assault_panel:child("assault_phase_label")
	self:animate_stop(label)
	local typing_char = "|"
	self:animate(label,"animate_text_backspaced",nil,1,label:text(),typing_char,1,1)
end

function KineticHUD:ShowCarry(carry_id,value)
	local carry_panel = self._carry_panel
	if alive(carry_panel) then 
		carry_panel:show()
		local bag_label = carry_panel:child("bag_label")
		local bag_value = carry_panel:child("bag_value")
		local bag_icon = carry_panel:child("bag_icon")
		if alive(bag_label) then 
			self:animate_stop(bag_label)
			carry_panel:remove(bag_label)
		end
		if alive(bag_value) then
			self:animate_stop(bag_value)
			carry_panel:remove(bag_value)
		end
		
		local hv = self.hud_values
		local layout_settings = self.layout_settings
		local scale = layout_settings.player_carry_panel_scale
		local margin_small = hv.MARGIN_SMALL * scale
		
		local carry_icon_x = hv.CARRY_ICON_X * scale
		local carry_icon_y = hv.CARRY_ICON_Y * scale
		
		local carry_label_font_size = hv.CARRY_LABEL_FONT_SIZE * scale
		local carry_label_x = hv.CARRY_LABEL_X * scale
		local carry_label_y = hv.CARRY_LABEL_Y * scale
		
		local carry_value_font_size = hv.CARRY_VALUE_FONT_SIZE * scale
		local carry_value_x = hv.CARRY_VALUE_X * scale
		local carry_value_y = hv.CARRY_VALUE_Y * scale
		
		
		local carry_td = tweak_data.carry
		local td = carry_td[tostring(carry_id)]
		local weight_mul = 1
		if td.type and carry_td.types[td.type] then 
			weight_mul = carry_td.types[td.type].move_speed_modifier or weight_mul
		end
		local value_animate_duration = hv.CARRY_ANIMATE_TEXT_VALUE_DURATION
		local name = td and td.name_id and managers.localization:text(td.name_id) or ("ERROR: " .. tostring(carry_id))
		local label_animate_duration = hv.CARRY_ANIMATE_TEXT_LABEL_TYPING_SPEED * utf8.len(name)
		bag_label = carry_panel:text({
			name = "bag_label",
			font = self._fonts.syke,
			text = name,
			font_size = carry_label_font_size,
			x = carry_label_x,
			y = carry_label_y,
			align = hv.CARRY_LABEL_HALIGN,
			vertical = hv.CARRY_LABEL_VALIGN,
			alpha = 1,
			color = self.color_data.white
		})
		local carry_h = carry_panel:h()
	--[[
		local n_x,n_y,n_w,n_h = bag_label:text_rect()
		
		local bag_icon_x = n_x + n_w + margin_small
		local bag_icon_y = 0
		
		bag_icon:set_position(bag_icon_x,bag_icon_y)
		self:animate_stop(bag_icon)
		self:animate(bag_icon,"animate_move_sin",nil,3,bag_icon_x,bag_icon_y,0,0)
	--]]
		self:animate_stop(bag_icon)
		bag_icon:set_position(0,carry_h)
		local function cb_icon_move_2(o)
			self:animate(o,"animate_move_pow",nil,0.5,o:x(),o:y(),carry_icon_x,carry_icon_y,2)
		end
		self:animate(bag_icon,"animate_move_sin",cb_icon_move_2,0.5 / weight_mul,bag_icon:x(),bag_icon:y(),0,(carry_h - carry_icon_y) * (1 - weight_mul))
	
--		self:animate(bag_label,"animate_text_unscramble",nil,3,name,nil,nil)
		
		local value_string = value and managers.experience:cash_string(0) or ""
		
		bag_value = carry_panel:text({
			name = "bag_value",
			font = self._fonts.syke,
			text = value_string,
			font_size = carry_value_font_size,
			x = carry_value_x,
			y = carry_value_y,
			align = hv.CARRY_VALUE_HALIGN,
			vertical = hv.CARRY_VALUE_VALIGN,
			visible = value and true or false,
			color = self.color_data.white
		})
		
		local done_cb 
		
		if value then
			done_cb = function()
			--self:animate_wait(hv.CARRY_ANIMATE_ICON_WAIT_DURATION,function()
				self:animate(bag_value,"animate_text_money_count",nil,value_animate_duration,1,value,hv.CARRY_ANIMATE_TEXT_VALUE_POWER)
			end
		end
		
		
		self:animate(bag_label,"animate_text_typing",done_cb,label_animate_duration,name,"|",1,nil)
	end
end

function KineticHUD:HideCarry()
	local carry_panel = self._carry_panel
	if alive(carry_panel) then 
		local bag_label = carry_panel:child("bag_label")
		local bag_value = carry_panel:child("bag_value")
		if alive(bag_label) then 
			self:animate_stop(bag_label)
			carry_panel:remove(bag_label)
		end
		if alive(bag_value) then
			self:animate_stop(bag_value)
			carry_panel:remove(bag_value)
		end
		carry_panel:hide()
	end
end

function KineticHUD:SetStamina(current,maximum)
--[[
	local player = managers.player:local_player()
	local stamina_panel = self._stamina_panel
	if not self:IsStaminaEnabled() then 
		return
	end
	if current and alive(player) then 
		local movement = player:movement()
		local total = total or movement:_max_stamina()
		local progress = current/total
		stamina_panel:child("stamina_outline"):set_color(Color(progress,1,1))
		if total - current <= 0.001 then 
			self:animate(stamina_panel,"animate_fadeout_linear",nil,0.75)
		elseif stamina_panel:alpha() < 1 then 
			stamina_panel:set_alpha(math.clamp(stamina_panel:alpha() * 1.3,0.001,self:GetHUDAlpha()))
		end
		
		if movement:is_above_stamina_threshold() then 
			stamina_panel:child("stamina_icon"):set_color(self.color_data.hud_bluefill)
			stamina_panel:child("stamina_fill"):set_color(self.color_data.hud_blueoutline)
		else
			stamina_panel:child("stamina_fill"):set_color(Color(0.3,0.3,0.3))
			stamina_panel:child("stamina_icon"):set_color(Color(0.6,0.6,0.6))
		end
	end
--]]
end

function KineticHUD:SetHostagesCount(num)
	--todo
end

function KineticHUD:SetAssaultWaveNumber(current,total)
	--todo
end

function KineticHUD:SetAssaultPONRTimer(time)
	
end

function KineticHUD:ShowAssaultPONR()
--	self:SetAssaultMode(true,"ponr")
end

function KineticHUD:HideAssaultPONR()
	
end

function KineticHUD:SetAssaultMode(active,mode)
--	self:c_log("assault mode " .. tostring(mode))
	if active ~= nil then
		self._assault_panel:child("assault_icon"):set_visible(active)
		if active then 
			if mode == "phalanx" then
				self._assault_panel:child("assault_icon"):set_image("guis/textures/pd2/hud_icon_padlockbox")
				--"guis/textures/pd2/hud_buff_shield"
			elseif mode == "stealth" then 
				self._assault_panel:child("assault_icon"):set_image("guis/textures/pd2/hud_icon_stealthbox")
			elseif mode == "ponr" then
				self._assault_panel:child("assault_icon"):set_image("guis/textures/pd2/hud_icon_noreturnbox")
			else
				self._assault_panel:child("assault_icon"):set_image("guis/textures/pd2/hud_icon_assaultbox")
			end
		end
	end
--	self:SetAssaultPhaseText(mode or "")
	--todo set icon
end

function KineticHUD:SetAssaultPhaseText(text)
	self._assault_panel:child("assault_phase_label"):set_text(text)
end

function KineticHUD:ShowPresenterPopup(params)
	--add to queue, queue should have its own update function
end

function KineticHUD:ShowHintPopup(params)
	--take from noblehud?
end

function KineticHUD:UpdateHUD(t,dt)
	local player = managers.player:local_player()
	if player then
		self:LinkWS(player:camera()._camera_object)
	end
	
	
	local hud_values = self.hud_values
	local ekg_speed = hud_values.EKG_SPEED
	local ekg_size = hud_values.EKG_SIZE
	local ekg_y = hud_values.EKG_Y
	for id,teammate_panel in pairs(self._teammate_panels) do 
		if alive(teammate_panel) then 
			local bpm_panel = teammate_panel:child("bpm_panel")
			if bpm_panel:visible() then 
				local bpm_mask = bpm_panel:child("bpm_mask")
				local readouts = bpm_mask:children()
				local all_out_of_bounds = true
				for _i,ekg_segment in pairs(readouts) do 
					ekg_segment:move(-ekg_speed * dt,0)
					
					if all_out_of_bounds and (ekg_segment:x() + ekg_segment:w() ) >= bpm_mask:w() then 
						all_out_of_bounds = false
					end
					
					if ekg_segment:x() < -ekg_segment:w() then 
						bpm_mask:remove(ekg_segment)
					end
				end
				if all_out_of_bounds then
					local teammate_health = self._cache.teammate_health[id] or 1
					local ekg_atlas = hud_values.EKG_ATLAS
					local ekg_data
					if teammate_health <= hud_values.HEALTH_THRESHOLD_FLATLINE then 
						ekg_data = ekg_atlas.states.flatline
					elseif teammate_health <= hud_values.HEALTH_THRESHOLD_CRITICAL then 
						ekg_data = ekg_atlas.states.critical
					elseif teammate_health <= hud_values.HEALTH_THRESHOLD_STRESSED then 
						ekg_data = ekg_atlas.states.stressed
					else
						ekg_data = ekg_atlas.states.normal
					end
					local texture_rect = ekg_data and ekg_data[math.random(#ekg_data)]
					if texture_rect then 
						local reading_w = texture_rect[3]
						local reading_h = texture_rect[4]
						local reading_r = reading_w / reading_h
						
						local w,h
						if reading_r > 1 then 
							w = ekg_size
							h = ekg_size * reading_r
						else
							w = ekg_size * reading_r
							h = ekg_size
						end
						
						local new_ekg_readout = bpm_mask:bitmap({
							name = tostring(teammate_health),
							texture = ekg_atlas.texture,
							texture_rect = texture_rect,
							color = self.color_data.white,
							w = w,
							h = h,
							x = bpm_mask:w(),
							y = ekg_y,
							layer = hud_values.EKG_LAYER
						})
					else
						self:c_log("ERROR! Bad EKG data for " .. tostring(teammate_health))
					end
				end
			end
		end
	end
	
	self:UpdateHUDBuffs(t,dt)
	
end

function KineticHUD:AnimatePanelSelectedFlash(id)
	local world_panel = id and self._world_panels[id]
	if alive(world_panel) then 
		local hv = self.hud_values
		local world_panel_data = hv.world_panels[id]
		local flash_rect = world_panel:child("selected_flash_rect")
		if alive(flash_rect) then 
			self:animate_stop(flash_rect)
			world_panel:remove(flash_rect)
		end
		flash_rect = world_panel:rect({
			name = "selected_flash_rect",
			color = world_panel_data.RECT_COLOR,
			alpha = 0
		})
		
		local function cb_destroy(o)
			o:parent():remove(o)
		end
		
		local function cb_fadeout(o)
			self:animate(o,"animate_fadeout",cb_destroy,0.75,o:alpha())
		end
		self:animate(flash_rect,"animate_fadein",cb_fadeout,0.25,hv.RECT_ALPHA)
	end
end

function KineticHUD:AddKillCountByUnit(unit,count)
	local current = self._cache.kills_by_weapon_unit[unit] or 0
	local new = current + count
	self._cache.kills_by_weapon_unit[unit] = new
	return new
end

function KineticHUD:OnKill(data)
	
	if type(data) == "table" and alive(data.weapon_unit) then 
		if data.type ~= "civilians" then 
			local selection_index = self:GetSelectionIndexByUnit(data.weapon_unit)
			if selection_index then 
				local kill_count = self:AddKillCountByUnit(data.weapon_unit,1)
				self:SetPlayerWeaponKillCount(selection_index,kill_count)
			end
		end
	end
end

function KineticHUD:OnMissionEnd(data)

end

--buff
function KineticHUD:CreateBuffsPanel(skip_layout)
	local selected_parent_panel = self._world_panels[self.layout_settings.buffs_panel_location]
	
	if not alive(selected_parent_panel) then 
		return
	end
	local parent_buffs_panel = selected_parent_panel:panel({
		name = "buffs_panel",
		w = 600,
		h = 300,
		x = 0,
		y = 0
	})
	--[[
	local debug_rect = parent_buffs_panel:rect({
		name = "debug_rect",
		alpha = 0.1,
		visible = false,
		color = Color.red
	})
	--]]
	self._buffs_panel = parent_buffs_panel
	if not skip_layout then 
		self:LayoutBuffsPanel()
	end
end


--set size and position of buffs panel here 
function KineticHUD:LayoutBuffsPanel()
	local buffs_panel = self._buffs_panel
	local layout_settings = self.layout_settings
	local scale = layout_settings.buffs_panel_scale
	local hud_values = self.hud_values
	local buffs_w = hud_values.BUFFS_PANEL_W * scale
	local buffs_h = hud_values.BUFFS_PANEL_H * scale
	
	local buffs_x = layout_settings.buffs_panel_x
	local buffs_y = layout_settings.buffs_panel_y
	
	buffs_panel:set_size(buffs_w,buffs_h)
	
	local _halign = layout_settings.buffs_panel_halign
	local halign = _halign and self.halign_values[_halign]
	
	local _valign = layout_settings.buffs_panel_valign
	local valign = _valign and self.valign_values[_valign]
	
	local selected_parent_panel = buffs_panel:parent()
	if halign == "center" then 
		buffs_panel:set_x((selected_parent_panel:w() - buffs_panel:w()) / 2)
	elseif halign == "left" then 
		buffs_panel:set_x(0)
	elseif halign == "right" then 
--		buffs_panel:set_right(selected_parent_panel:w())
		buffs_panel:set_x(selected_parent_panel:w() - buffs_panel:w())
	end
	
	if valign == "top" then 
		buffs_panel:set_y(0)
	elseif valign == "center" then 
		buffs_panel:set_y((selected_parent_panel:h() - buffs_panel:h()) / 2)
	elseif valign == "bottom" then 
		buffs_panel:set_y(selected_parent_panel:h())
	end
	buffs_panel:move(buffs_x,buffs_y)
end

function KineticHUD:IsBuffEnabled(id) --todo check from buff settings
	return true
end

function KineticHUD:IsBuffCompactLabelMode() 
	return false
end

function KineticHUD:RegisterBuff(_,id,data)
	local buff_data = id and self._buff_data[id]
	if buff_data then 
		if not buff_data.disabled and self:IsBuffEnabled(id) then 
			local buff_item = self:GetBuffItem(id) 
			if buff_item then
				self:AnimateRefreshBuff(buff_item)
			else
				self:AddBuffItem(id,buff_data,data)
			end
		end
	else
		self:c_log("No buff data found for " .. tostring(id))
	end
end

function KineticHUD:AnimateRefreshBuff(buff_item)
	--register is only called on new buffs- this should never actually be executed

	local buff_refresher = buff_item:child("refresher")
	if alive(buff_refresher) then 
		buff_item:remove(buff_refresher)
	end
	
	buff_refresher = buff_item:rect({
		name = "refresher",
		color = self.color_data.white,
		alpha = 0,
		layer = -2
	})
	
	local remove_gui = callback(buff_refresher,buff_refresher,"remove")
	
	local function anim_fadeout(o)
		self:animate(o,"animate_fadeout",remove_gui(o),0.5,0)
	end
	
	self:animate(buff_refresher,"animate_fadein",anim_fadeout,0.1,1)
	
	--update buff text/color/icon?
	--flash on refresh
	
end

function KineticHUD:UnregisterBuff(_,id,data)
	self:RemoveBuffItem(id)
end

function KineticHUD:GetBuffItem(id)
	local buffs_panel = self._buffs_panel
	if id and alive(buffs_panel) then 
		return buffs_panel:child(tostring(id))
	end
end

function KineticHUD:GetBuffIcon(id,data)

	local icon_id = data.icon_id
	local icon_tier = data.icon_tier
	local tier_floors = data.tier_floors
	local source = data.source
	
	local texture,texture_rect
	if source == "icon" then 
		texture,texture_rect = tweak_data.hud_icons:get_icon_data(data.icon_id)
	elseif source == "skill" then 
		texture = "guis/textures/pd2/skilltree_2/icons_atlas_2"
		local SKILL_ICON_SIZE = 80
		local x,y = unpack(tweak_data.skilltree.skills[icon_id].icon_xy)
		texture_rect = {x * SKILL_ICON_SIZE,y * SKILL_ICON_SIZE,SKILL_ICON_SIZE,SKILL_ICON_SIZE}
	elseif source == "skill_1" then --that reads "skill_" and then the numerical form of "one"
		texture = "guis/textures/pd2/skilltree/icons_atlas"
		local SKILL_ICON_SIZE = 64
		local x,y = unpack(tweak_data.skilltree.skills[icon_id].icon_xy)
		texture_rect = {x * SKILL_ICON_SIZE,y * SKILL_ICON_SIZE,SKILL_ICON_SIZE,SKILL_ICON_SIZE}
	elseif source == "perk" then 
		texture,texture_rect = KineticHUD.get_specialization_icon_data_by_tier(icon_id,icon_tier,tier_floors)
	end
	
	return texture,texture_rect
end

function KineticHUD:UpdateHUDBuffs(t,dt)
	local buffs_panel = self._buffs_panel
	
	local hud_values = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.buffs_panel_scale
	local margin_medium = hud_values.MARGIN_MEDIUM * scale
	
	local compact_label = self:IsBuffCompactLabelMode()
	
	local rows = true
	local align = "left"
	local valign = "right"
	
	local buffs_w,buffs_h = buffs_panel:size()
	
	for i,buff_panel in ipairs(buffs_panel:children()) do 
	
		local id = buff_panel:name()
		
		local buff_info = managers.gameinfo:get_buffs()[id]
		local buff_data = self._buff_data[id]
		if buff_info and buff_data then 
			local skill_id = buff_data.icon_id
			local source = buff_data.source
			local aced = buff_data.aced
			
			
			local text = ""
			if not compact_label then 
				if buff_data.text then
					text = managers.localization:text(buff_data.text)
				else
					if source == "perk" then 
						local skilltd = tweak_data.skilltree.specializations[skill_id]
						if skilltd then 
							text = managers.localization:text(skilltd.name_id)
						end
					elseif source == "skill" then 
						local skilltd = tweak_data.skilltree.skills[skill_id]
						if skilltd then 
							text = managers.localization:text(skilltd.name_id)
							if aced then 
								text = text .. " " .. managers.localization:text("khud_aced_buff")
							end
						end
					end
				end
			end
			
			if buff_info then 
				local duration = ""
				local value = ""
				
				if buff_info.expire_t then 
					local duration_remaining = buff_info.expire_t - t
					duration = KineticHUD.format_seconds(math.ceil(duration_remaining))
				end
				if buff_info.value then 
					if buff_data.value_format then 
						value = string.format(buff_data.value_format,buff_info.value)
					else
						value = buff_info.value
					end
				end
				if value ~= "" then 
					text = text .. " " .. value
				end
				if duration ~= "" then 
					text = text .. " " .. duration
				end
				
--				self:c_log("Logging buff_info for " .. tostring(id) .. "<--")
--				logall(buff_info)
--				self:c_log("</-->" .. tostring(id))
			else
--				self:c_log("buff_info is nil for " .. tostring(id))
			end
			local label = buff_panel:child("label")
			label:set_text(text)
		
		end
		
		local x,y = 0,0
		if align == "left" then 
			
			if i > 1 then 
				local buff_w = buff_panel:w()
				local buff_h = buff_panel:h()
				if rows then 
					x = x + buff_w
					if x + margin_medium + buff_w > buffs_w then 
						x = 0
						y = y + margin_medium + buff_h
					end
				else --organize buffs by columns 
					y = y + buff_h
					if y + margin_medium + buff_h > buffs_h then 
						x = x + margin_medium + buff_w
						y = 0
					end
				end
			end
		elseif align == "right" then 
		
		end
		buff_panel:set_position(x,y)
	end
end

--buttw = KineticHUD:AddBuffItem({id = "hello",texture = "guis/textures/pd2/cn_minighost"})
--creates a hud item with the buff specified
function KineticHUD:AddBuffItem(id,data,buff_info)

	local skill_id = data.icon_id
	local aced = data.aced
	
	local compact_mode = self:IsBuffCompactLabelMode()
	
	local texture,texture_rect
	local text = ""
	local text_color = self.color_data.white
	local icon_color = self.color_data.white
	if data.text_color_id then 
		text_color = self.color_data[data.text_color_id] or text_color
	end
	if data.icon_color_id then 
		icon_color = self.color_data[data.icon_color_id] or icon_color
	end
	
	local skilltd = tweak_data.skilltree.skills[skill_id]
	if not compact_mode then 
		if data.text then
			text = managers.localization:text(data.text)
		elseif skilltd then 
			text = managers.localization:text(skilltd.name_id)
		end
	end
		
	if buff_info then 
		local duration = ""
		local value = ""
		
		if buff_info.t and buff_info.expire_t then 
			duration = KineticHUD.format_seconds(buff_info.expire_t - buff_info.t)
		end
		if buff_info.value then 
			if data.value_format then 
				value = string.format(data.value_format,buff_info.value)
			else
				value = buff_info.value
			end
		end
		
		if duration ~= "" then 
			text = text .. " " .. tostring(duration)
		end
		if value ~= "" then 
			text = text .. " " .. tostring(value)
		end
	end
	
	if data.texture then 
		texture,texture_rect = data.texture,data.texture_rect
	else
		texture,texture_rect = KineticHUD:GetBuffIcon(id,data)
	end
	
	local hud_values = self.hud_values
	local layout_settings = self.layout_settings
	local scale = layout_settings.buffs_panel_scale
	
	local font = self._fonts.syke
	if data.font then 
		font = self._fonts[data.font] or font
	end
	local font_size = (data.font_size or hud_values.BUFF_FONT_SIZE) * scale
	
	local margin_medium = hud_values.MARGIN_MEDIUM * scale
	
	local buffs_panel = self._buffs_panel
	
	local icon_w = hud_values.BUFF_ICON_W * scale
	local icon_h = hud_values.BUFF_ICON_H * scale
	
	local panel_w = hud_values.BUFF_W * scale
	if compact_mode then 
		panel_w = hud_values.BUFF_W_COMPACT * scale
	end
	local panel_h = hud_values.BUFF_H * scale
	
	local panel_x = 0 * scale
	local panel_y = 0 * scale
	
	local panel = buffs_panel:panel({
		name = id,
		x = panel_x,
		y = panel_y,
		w = panel_w,
		h = panel_h,
		layer = 3
	})
	
	local icon = panel:bitmap({
		name = "icon",
		texture = texture,
		texture_rect = texture_rect,
		w = icon_w,
		h = icon_h,
		x = 0,
		y = (panel_h - icon_h) / 2,
		color = icon_color,
		layer = 2
	})
	
	local aced_texture = "guis/textures/pd2/skilltree_2/ace_symbol"
	local aced_texture_rect = nil
	local aced_icon = panel:bitmap({
		name = "aced_icon",
		texture = aced_texture,
		texture_rect = aced_texture_rect,
		blend_mode = "add",
		--set rotation to 360 to disable clipping
		w = icon_w,
		h = icon_h,
		x = 0,
		y = (panel_h - icon_h) / 2,
		color = tweak_data.screen_colors.button_stage_2,
		layer = 1,
		visible = aced
	})
	
	local label = panel:text({
		name = "label",
		text = text,
		font = font,
		font_size = font_size,
		x = icon:x() + icon:w() + margin_medium,
		color = text_color,
		layer = 3,
		align = "left",
		vertical = "center"
	})
	
	local bg = panel:bitmap({
		name = "bg",
		texture = "textures/ui/gradient",
		texture_rect = nil,
		w = panel_w,
		h = panel_h,
		layer = 0,
		alpha = 0.5,
		color = self.color_data.black
	})
	
	--[[
	local r = math.random()
	local debug_rect = panel:rect({
		name = "debug_rect",
		color = Color(r,1 - r,1),
		visible = true,
		layer = -2,
		alpha = 0.1
	})
	--]]
	
--	self:AnimateLayoutBuffs()
	--todo insert by priority
	return panel
end

function KineticHUD:RemoveBuffItem(id)
	local buff_item = self:GetBuffItem(id)
	if buff_item then 
		buff_item:parent():remove(buff_item)
	end
end

function KineticHUD:AnimateLayoutBuffs()
	do return end
	
	local buffs = {}
	
	for _,_ in ipairs(buffs) do 
		--animate move buff by x/y according to priority
	end
end

Hooks:Add("MenuManagerSetupCustomMenus", "MenuManagerSetupCustomMenus_khud", function(menu_manager, nodes)
	KineticHUD._populated_menus[KineticHUD._menu_id_main] = {menu = MenuHelper:NewMenu(KineticHUD._menu_id_main)}
end)

--iterator? i 'ardly even know 'er!
function KineticHUD.traverse(tbl,indexed_targets,func,...)
	indexed_targets = indexed_targets or {}
	for k,v in ipairs(tbl) do 
		if type(v) == "table" then 
			if indexed_targets[tostring(v)] then 
				--no infinite recursion or stack overflows, thanks
				return
			end
			indexed_targets[tostring(v)] = true
			local next_traversal_target,args = func(k,v,...)
			if next_traversal_target then 
				KineticHUD.traverse(next_traversal_target,indexed_targets,func,unpack(args or {}))
			end
		end
	end
end


--boy i love inventing things! i wonder what i should call this... round... circle... thing, 
-- that i just made up, myself. good thing nobody has already created this before
function KineticHUD.add_menu_option_from_data(i,menu_data,parent_menu_id)
	if not parent_menu_id then 
		KineticHUD:c_log("ERROR: add_menu_option_from_data(): bad parent menu id!")
		return
	end
	local priority = i
	local menu_type = menu_data.type
	
	local settings,default_settings
	if menu_data.settings_source == "layout" then 
		settings = KineticHUD.layout_settings
		default_settings = KineticHUD.default_layout_settings
	else
		settings = KineticHUD.settings
		default_settings = KineticHUD.default_settings
	end
	if menu_type == "menu" then 
		KineticHUD._populated_menus[menu_data.id] = {
			menu = MenuHelper:NewMenu(menu_data.id),
			
			area_bg = menu_data.area_bg,
			back_callback = menu_data.back_callback,
			focus_changed_callback = menu_data.back_callback
		}
		table.insert(KineticHUD._queued_add_menus,{
			parent_menu_id = parent_menu_id,
			submenu_id = menu_data.id,
			title = menu_data.title,
			desc = menu_data.desc,
			priority = priority
		})
		
		if type(menu_data.children) == "table" then
			return menu_data.children,{menu_data.id}
		end
	elseif menu_type == "toggle" then 
		MenuHelper:AddToggle({
			id = menu_data.id,
			title = menu_data.title,
			desc = menu_data.desc,
			callback = menu_data.callback,
			value = settings[menu_data.value],
			default_value = menu_data.default_value or default_settings[menu_data.value],
			menu_id = parent_menu_id,
			priority = priority
		})
	elseif menu_type == "slider" then 
		MenuHelper:AddSlider({
			id = menu_data.id,
			title = menu_data.title,
			desc = menu_data.desc,
			callback = menu_data.callback,
			value = settings[menu_data.value],
			default_value = menu_data.default_value or default_settings[menu_data.value],
			min = menu_data.min,
			max = menu_data.max,
			step = menu_data.step,
			show_value = menu_data.show_value,
			menu_id = parent_menu_id,
			priority = priority
		})
	elseif menu_type == "button" then 
		MenuHelper:AddButton({
			id = menu_data.id,
			title = menu_data.title,
			desc = menu_data.desc,
			callback = menu_data.callback,
			menu_id = parent_menu_id,
			priority = priority
		})
	elseif menu_type == "divider" then 
		return MenuHelper:AddDivider({
			id = menu_data.id,
			size = menu_data.size,
			menu_id = parent_menu_id,
			priority = priority
		})
	elseif menu_type == "multiple_choice" then 
		MenuHelper:AddMultipleChoice({
			id = menu_data.id,
			title = menu_data.title,
			desc = menu_data.desc,
			callback = menu_data.callback,
			items = menu_data.items,
			value = settings[menu_data.value],
			default_value = menu_data.default_value or default_settings[menu_data.value],
			menu_id = parent_menu_id,
			priority = priority
		})
	elseif menu_type == "keybind" then 
		MenuHelper:AddKeybinding({
			id = menu_data.id,
			title = menu_data.title,
			callback = menu_data.callback,
			connection_name = menu_data.connection_name,
			binding = menu_data.binding,
			button = menu_data.button,
			menu_id = parent_menu_id,
			priority = priority,
		})
	end
end

Hooks:Add("MenuManagerPopulateCustomMenus", "MenuManagerPopulateCustomMenus_khud", function(menu_manager, nodes)
	--do custom addon loading here
	--do validate settings here
	--do populate dynamic menus (like buffs) here
	
	KineticHUD.traverse(KineticHUD._menu_ids,{},KineticHUD.add_menu_option_from_data,KineticHUD._menu_id_main)
end)

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_khud", function(menu_manager, nodes)
	
	for menu_id,menu_data in pairs(KineticHUD._populated_menus) do 
		nodes[menu_id] = MenuHelper:BuildMenu(
			menu_id,
			{
				area_bg = menu_data.area_bg,
				back_callback = menu_data.back_callback,
				focus_changed_callback = menu_data.focus_changed_callback
			}
		)
	end
	
	for _,menu_data in ipairs(KineticHUD._queued_add_menus) do 
		local parent_menu_id = menu_data.parent_menu_id
		local menu = MenuHelper:GetMenu(parent_menu_id)
		local submenu_id = menu_data.submenu_id
		local title = menu_data.title
		local desc = menu_data.desc
		local priority = menu_data.priority
		if menu then 
			MenuHelper:AddMenuItem(menu,submenu_id,title,desc,priority)
		end
	end
end)

Hooks:Add( "MenuManagerInitialize", "khud_MenuManagerInitialize", function(menu_manager)

--player weapons panel
	MenuCallbackHandler.callback_khud_player_weapons_panel_set_scale = function(self,item)
		if alive(KineticHUD._player_weapons_panel) then 
			local value = tonumber(item:value())
			KineticHUD.layout_settings.player_weapons_panel_scale = value
			
			KineticHUD:LayoutPlayerWeaponsPanel({recreate_text_objects = true})
		end
	end
	MenuCallbackHandler.callback_khud_player_weapons_panel_set_x = function(self,item)
		if alive(KineticHUD._player_weapons_panel) then 
			local value = tonumber(item:value())
			KineticHUD.layout_settings.player_weapons_panel_x = value
			
			KineticHUD:LayoutPlayerWeaponsPanel({recreate_text_objects = false})
		end
	end
	MenuCallbackHandler.callback_khud_player_weapons_panel_set_y = function(self,item)
		if alive(KineticHUD._player_weapons_panel) then 
			local value = tonumber(item:value())
			KineticHUD.layout_settings.player_weapons_panel_y = value
			
			KineticHUD:LayoutPlayerWeaponsPanel({recreate_text_objects = false})
		end
	end
	
--player vitals panel
	MenuCallbackHandler.callback_khud_player_vitals_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_vitals_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end
	MenuCallbackHandler.callback_khud_player_weapons_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_weapons_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end
	
--player equipment panel
	MenuCallbackHandler.callback_khud_player_equipment_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.PLAYER_EQUIPMENT_X = value
		KineticHUD:LayoutPlayerEquipmentPanel()
	end
	MenuCallbackHandler.callback_khud_player_equipment_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.PLAYER_EQUIPMENT_Y = value
		KineticHUD:LayoutPlayerEquipmentPanel()
	end
	MenuCallbackHandler.callback_khud_player_equipment_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_equipment_panel_scale = value
		KineticHUD:LayoutPlayerEquipmentPanel()
	end
	MenuCallbackHandler.callback_khud_player_equipment_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_equipment_panel_location = value
		--[[
		local orig_eq_panel = KineticHUD._player_equipment_panel
		local new_eq_panel = KineticHUD._world_panels[value]
		if alive(new_eq_panel) then 
			KineticHUD._player_equipment_panel = KineticHUD.CloneGuiObject(orig_eq_panel,new_eq_panel,{destructive_clone = false,force_recreate = true,deep_clone = true})
			if alive(orig_eq_panel) then 
				orig_eq_panel:parent():remove(orig_eq_panel)
				--on close, remove original
			end
			if not Application:paused() then 
				KineticHUD:AnimatePanelSelectedFlash(value)
			end
		end
		--]]
	end
	
--player mission mission_equipment panel
	MenuCallbackHandler.callback_khud_player_mission_equipment_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.PLAYER_MISSION_EQUIPMENT_X = value
		KineticHUD:LayoutPlayerMissionEquipmentPanel()
	end
	MenuCallbackHandler.callback_khud_player_mission_equipment_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.PLAYER_MISSION_EQUIPMENT_Y = value
		KineticHUD:LayoutPlayerMissionEquipmentPanel()
	end
	MenuCallbackHandler.callback_khud_player_mission_equipment_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_mission_equipment_panel_scale = value
		KineticHUD:AnimateLayoutPlayerMissionEquipment(true)
		--todo re-apply scale here
	end
	MenuCallbackHandler.callback_khud_player_mission_equipment_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_mission_equipment_panel_location = value
	end
	
--player carry bag loot panel
	MenuCallbackHandler.callback_khud_player_carry_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.CARRY_X = value
		KineticHUD:LayoutCarryPanel()
	end
	MenuCallbackHandler.callback_khud_player_carry_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.CARRY_Y = value
		KineticHUD:LayoutCarryPanel()
	end
	MenuCallbackHandler.callback_khud_player_carry_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_carry_panel_scale = value
		KineticHUD:LayoutCarryPanel()
		--todo re-apply scale here
	end
	MenuCallbackHandler.callback_khud_player_carry_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.player_carry_panel_location = value
	end
	
--teammates panel
	MenuCallbackHandler.callback_khud_teammates_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.teammates_panel_x = value
		KineticHUD:LayoutTeammatesPanel()
	end
	MenuCallbackHandler.callback_khud_teammates_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.teammates_panel_y = value
		KineticHUD:LayoutTeammatesPanel()
	end
	MenuCallbackHandler.callback_khud_teammates_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.teammates_panel_scale = value
		KineticHUD:LayoutTeammatesPanel()
	end
	MenuCallbackHandler.callback_khud_teammates_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.teammates_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--objectives panel
	MenuCallbackHandler.callback_khud_objective_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.OBJECTIVE_X = value
		KineticHUD:LayoutObjectivePanel()
	end
	MenuCallbackHandler.callback_khud_objective_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.OBJECTIVE_Y = value
		KineticHUD:LayoutObjectivePanel()
	end
	MenuCallbackHandler.callback_khud_objective_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.objective_panel_scale = value
		KineticHUD:LayoutObjectivePanel()
	end
	MenuCallbackHandler.callback_khud_objective_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.objective_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end
	
--assault panel
	MenuCallbackHandler.callback_khud_assault_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.ASSAULT_X = value
		KineticHUD:LayoutAssaultPanel()
	end
	MenuCallbackHandler.callback_khud_assault_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.ASSAULT_Y = value
		KineticHUD:LayoutAssaultPanel()
	end
	MenuCallbackHandler.callback_khud_assault_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.assault_panel_scale = value
		KineticHUD:LayoutAssaultPanel()
	end
	MenuCallbackHandler.callback_khud_assault_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.assault_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--interaction panel
	MenuCallbackHandler.callback_khud_interaction_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.interaction_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end
	MenuCallbackHandler.callback_khud_interaction_panel_set_x = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.interaction_panel_x = value
--		KineticHUD:LayoutInteractionPanel()
	end
	MenuCallbackHandler.callback_khud_interaction_panel_set_y = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.interaction_panel_y = value
--		KineticHUD:LayoutInteractionPanel()
	end
	MenuCallbackHandler.callback_khud_interaction_panel_set_scale = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.interaction_panel_scale = value
--		KineticHUD:LayoutInteractionPanel()
	end

--hints panel
	MenuCallbackHandler.callback_khud_hints_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.hints_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--location panel
	MenuCallbackHandler.callback_khud_presenter_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.presenter_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--chat panel
	MenuCallbackHandler.callback_khud_chat_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.chat_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--hit direction
	MenuCallbackHandler.callback_khud_hitdirection_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.hitdirection_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--suspicion panel
	MenuCallbackHandler.callback_khud_suspicion_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.suspicion_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--buffs panel
	MenuCallbackHandler.callback_khud_buffs_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.buffs_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end

--compass panel
	MenuCallbackHandler.callback_khud_compass_panel_set_location = function(self,item)
		local value = tonumber(item:value())
		KineticHUD.layout_settings.compass_panel_location = value
		KineticHUD:AnimatePanelSelectedFlash(value)
	end
	
	
--on closed main menu
	MenuCallbackHandler.callback_khud_close = function(this)
		KineticHUD:Save()
		--note to self: weapons menu and compass menu use this generic callback
	end
	KineticHUD:Load()
	
	MenuHelper:LoadFromJsonFile(KineticHUD._menu_path .. "menu_main.json", KineticHUD, KineticHUD.settings)

end)




--marked for deprecation below this line
do return end


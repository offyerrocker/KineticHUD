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

--Called once to start the HUD initialization process, along with a reference to the parent hud for optional "flat" panel usage.
function KineticHUD:Setup(parent_panel)
	self._gui = World:newgui()
	self:CreateWorldPanels()
	self:CreateHUD(parent_panel)
	
	BeardLib:AddUpdater("kinetichud_update",callback(self,self,"Update"))
	
	self:RegisterUpdateCheckPlayer()
end

--Create world panels to be linked later, and stores them in a table. 
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
			layer = 1,
			alpha = 0.2
		})
		
		self._workspaces[panel_name] = ws
		self._world_panels[i] = panel
	end
end

--Creates the main HUD elements onto the appropriate panel, depending on user options.
--Safe to call multiple times, as it removes preexisting duplicate HUD elements.
function KineticHUD:CreateHUD(parent_panel)
		
	self._parent_panel = parent_panel
	if alive(self._base)  then 
		parent_panel:remove(self._base)
	end
	local base = parent_panel:panel({
		name = "kinetichud"
	})
	self._panel = base
	
	self:CreatePlayerVitals()
	
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
--The player's health, armor, damage absorption, stored health, and revives.
function KineticHUD:CreatePlayerVitals()
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
	
end

function KineticHUD:LayoutPlayerVitals()

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

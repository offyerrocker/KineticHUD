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

function KineticHUD:Setup()
	BeardLib:AddUpdater("kinetichud_update",callback(self,self,"Update"))
	
	self:RegisterUpdateCheckPlayer()
	self._gui = World:newgui()
end

function KineticHUD:Test()
	self:CreateLeftPanel()
	self:CreateRightPanel()
	self:CreateTopPanel()
	self:CreateBottomPanel()
end

function KineticHUD:CreateLeftPanel()

	--placeholders until the panel is linked
	local actual_w = 1000
	local actual_h = 1000
	
	self._left_ws = self._gui:create_world_workspace(actual_w,actual_h,Vector3(),Vector3(),Vector3())
	
	self._left_panel = self._left_ws:panel():panel({
		name = "khud_realpanel_test",
		layer = 1
	})
	
	self._left_panel:text({
		name = "testxt",
		color=Color.white,
		font = self._fonts.grotesk,
		text = "hello and welcome to zombocom",
		vertical = "center",
		align = "center",
		layer = 1,
		font_size = 32
	})
	self._left_panel:rect({
		color=Color.red,
		layer = 0,
		alpha = 0.2
	})
end

function KineticHUD:CreateRightPanel()
	
	local player = managers.player:local_player()
	local gui_object = player:camera()._camera_object
	
	local onscreen_w = 5
	local onscreen_h = 10
	local actual_w = 1000
	local actual_h = 1000
	
	local ra = gui_object:rotation()
	
	local rb = Rotation(-15,90,0)
	
	local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
	
	local x_axis = Vector3(onscreen_w,0,0)
	
	mvector3.rotate_with(x_axis,rot)
	
	local y_axis = Vector3(0,-onscreen_h,0)
	
	mvector3.rotate_with(y_axis,rot)
	
	local center = Vector3(onscreen_w / 2,-onscreen_h / 2)
	
	mvector3.rotate_with(center,rot)
	
	local offset = Vector3(5,0,-10)
		--x+ is distance right
		--y+ is distance upward
		--z+ is distance backward
		
	mvector3.rotate_with(offset,rot)
	
	local position = gui_object:position()
	
	self._right_ws = self._gui:create_world_workspace(actual_w,actual_h,position,x_axis,y_axis)
	
	self._right_ws:set_linked(actual_w,actual_h,gui_object,position - center + offset,x_axis,y_axis)
	
	
	
	self._right_panel = self._right_ws:panel():panel({
		name = "khud_realpanel_test",
		layer = 1
	})
	
	self._right_panel:text({
		name = "testxt",
		color=Color.white,
		font = self._fonts.grotesk_bold,
		text = "this is zombocom",
		vertical = "center",
		align = "center",
		layer = 1,
		font_size = 32
	})
	self._right_panel:rect({
		color=Color.blue,
		layer = 0,
		alpha = 0.2
	})
end

function KineticHUD:CreateTopPanel()
	
	local player = managers.player:local_player()
	local gui_object = player:camera()._camera_object
	
	local onscreen_w = 11
	local onscreen_h = 7
	local actual_w = 1000
	local actual_h = 1000
	
	local ra = gui_object:rotation()
	
	local rb = Rotation(0,90 + 5,0)
	
	local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
	
	local x_axis = Vector3(onscreen_w,0,0)
	
	mvector3.rotate_with(x_axis,rot)
	
	local y_axis = Vector3(0,-onscreen_h,0)
	
	mvector3.rotate_with(y_axis,rot)
	
	local center = Vector3(onscreen_w / 2,-onscreen_h / 2)
	
	mvector3.rotate_with(center,rot)
	
	local offset = Vector3(0,2,-10)
		--x+ is distance right
		--y+ is distance upward
		--z+ is distance backward
		
	mvector3.rotate_with(offset,rot)
	
	local position = gui_object:position()
	
	self._top_ws = self._gui:create_world_workspace(actual_w,actual_h,position,x_axis,y_axis)
	
	self._top_ws:set_linked(actual_w,actual_h,gui_object,position - center + offset,x_axis,y_axis)
	
	
	
	self._top_panel = self._top_ws:panel():panel({
		name = "khud_realpanel_test",
		layer = 1
	})
	
	self._top_panel:text({
		name = "testxt",
		color=Color.white,
		font = self._fonts.cromwell,
		text = "you can do anything at zombocom",
		vertical = "center",
		align = "center",
		layer = 1,
		font_size = 32
	})
	self._top_panel:rect({
		color=Color.green,
		layer = 0,
		alpha = 0.2
	})
end

function KineticHUD:CreateBottomPanel()
	
	local player = managers.player:local_player()
	local gui_object = player:camera()._camera_object
	
	local onscreen_w = 11
	local onscreen_h = 7
	local actual_w = 1000
	local actual_h = 1000
	
	local ra = gui_object:rotation()
	
	local rb = Rotation(0,90 - 5,0)
	
	local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
	
	local x_axis = Vector3(onscreen_w,0,0)
	
	mvector3.rotate_with(x_axis,rot)
	
	local y_axis = Vector3(0,-onscreen_h,0)
	
	mvector3.rotate_with(y_axis,rot)
	
	local center = Vector3(onscreen_w / 2,-onscreen_h / 2)
	
	mvector3.rotate_with(center,rot)
	
	local offset = Vector3(0,-2,-10)
		--x+ is distance right
		--y+ is distance upward
		--z+ is distance backward
		
	mvector3.rotate_with(offset,rot)
	
	local position = gui_object:position()
	
	self._bottom_ws = self._gui:create_world_workspace(actual_w,actual_h,position,x_axis,y_axis)
	
	self._bottom_ws:set_linked(actual_w,actual_h,gui_object,position - center + offset,x_axis,y_axis)
	
	
	
	self._bottom_panel = self._bottom_ws:panel():panel({
		name = "khud_realpanel_test",
		layer = 1
	})
	
	self._bottom_panel:text({
		name = "testxt",
		color=Color.white,
		font = self._fonts.cromwell,
		text = "the unattainable is unknown at zombocom",
		vertical = "center",
		align = "center",
		layer = 1,
		font_size = 32
	})
	self._bottom_panel:rect({
		color=Color.yellow,
		layer = 0,
		alpha = 0.2
	})
end

function KineticHUD:Test2()
	local player = managers.player:local_player()
	local gui_object = player:camera()._camera_object
--	local gui_object = player:orientation_object()
	
	self._gui = World:newgui()
	
	local onscreen_w = 100
	local onscreen_h = 100
	local actual_w = 5000
	local actual_h = 5000
	
	local ra = gui_object:rotation()
	
	local rb = Rotation(0,90,0)
	
	local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
	
	
	
	
	local x_axis = Vector3(onscreen_w,0,0)
	
	mvector3.rotate_with(x_axis,rot)
	
	local y_axis = Vector3(0,-onscreen_h,0)
	
	mvector3.rotate_with(y_axis,rot)
	
	local center = Vector3(onscreen_w / 2,-onscreen_h / 2)
	
	mvector3.rotate_with(center,rot)
	
	local offset = Vector3(0,0,-10)
		--z+ is distance backward
		--y+ is distance upward
		
	mvector3.rotate_with(offset,rot)
	
	local position = gui_object:position()
	
	self._ws = self._gui:create_world_workspace(actual_w,actual_h,position,x_axis,y_axis)
	
	self._ws:set_linked(actual_w,actual_h,gui_object,position - center + offset,x_axis,y_axis)
	
	
	
	self._panel = self._ws:panel():panel({
		name = "khud_realpanel_test",
		layer = 1
	})
	
	self._panel:text({
		name = "testxt",
		color=Color.white,
		font = self._fonts.grotesk,
		text = "hello and welcome to zombocom",
		vertical = "center",
		align = "center",
		font_size = 32
	})
	
	self._rect = self._panel:rect({
		color=Color.red,
		alpha = 0.5
	})
end

function KineticHUD:CreateHUD(parent_panel)
	self._parent_panel = parent_panel
	local base = parent_panel:panel({
		name = "kinetichud"
	})
	self._panel = base

	--create teammates panel
	self._teammates = base:panel({
		name = "teammates"
	})
	
	self._player = base:panel({
		name = "player"
	})
	self:_create_player(self._player)
	
	
end

function KineticHUD:LinkWS(link_target_object)

	if alive(self._left_panel) then 
			
		local onscreen_w = 5
		local onscreen_h = 10
		local actual_w = 1000
		local actual_h = 1000
		
		local ra = link_target_object:rotation()
		
		local rb = Rotation(15,90,0)
		
		local rot = Rotation(ra:yaw() + rb:yaw(),ra:pitch() + rb:pitch(),ra:roll() + rb:roll())
		
		local x_axis = Vector3(onscreen_w,0,0)
		
		mvector3.rotate_with(x_axis,rot)
		
		local y_axis = Vector3(0,-onscreen_h,0)
		
		mvector3.rotate_with(y_axis,rot)
		
		local center = Vector3(onscreen_w / 2,-onscreen_h / 2)
		
		mvector3.rotate_with(center,rot)
		
		local offset = Vector3(-5,0,-10)
			--x+ is distance right
			--y+ is distance upward
			--z+ is distance backward
			
		mvector3.rotate_with(offset,rot)
		
		local position = link_target_object:position()
		
		self._left_ws:set_linked(actual_w,actual_h,link_target_object,position - center + offset,x_axis,y_axis)
		return true
	end
end

function KineticHUD:UnregisterUpdateCheckPlayer()
	BeardLib:RemoveUpdater(self._updater_id_check_player)
end

function KineticHUD:UpdateCheckPlayer(t,dt)
	local player = managers.player:local_player()
	if alive(player) then 
		if self:LinkWS(player:camera()._camera_object) then
			self:UnregisterUpdateCheckPlayer()
		end
	end
end

function KineticHUD:RegisterUpdateCheckPlayer()
	self:UnregisterUpdateCheckPlayer()
	BeardLib:AddUpdater(self._updater_id_check_player,callback(self,self,"UpdateCheckPlayer"))
end


function KineticHUD:SetTeammateHealth(current,total)
	
end

function KineticHUD:SetPlayerHealth(current,total)

end


--main player only
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


Hooks:Add("BaseNetworkSessionOnLoadComplete","kinetichud_register_updater",function() --PlayerManager_on_internal_load
	KineticHUD:Setup()
end)

--load hud buff data
dofile(KineticHUD._mod_path .. "buff/buff_data.lua")

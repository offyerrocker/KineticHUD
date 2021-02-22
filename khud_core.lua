
KineticHUD = KineticHUD or {}
KineticHUD._mod_path = KineticHUD:GetPath()
KineticHUD._save_path = SavePath .. "KineticHUD2.txt"

KineticHUD._updater_id_check_player = "khud_update_check_player"

KineticHUD.color_data = {
	red = Color("ff8080"),
	orange = Color("ffbd80"),
	gold = Color("ffd080"),
	yellow = Color("fffb80"),
	green = Color("80ff82"),
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
	cromwell = "fonts/cromwell_nf",
	grotesk = "fonts/grotesk_normal",
	grotesk_bold = "fonts/grotesk_bold"
}

KineticHUD._USE_UNIQUE_WORKSPACE = false

--number values used for sizing, positioning etc. which should not be change-able by settings
KineticHUD.hud_values = {
	PLAYER_ARMOR_BAR_W = 500,
	PLAYER_ARMOR_BAR_H = 16,
	PLAYER_ARMOR_BAR_X = 640,
	PLAYER_ARMOR_BAR_Y = 100,
	PLAYER_HEALTH_BAR_W = 500,
	PLAYER_HEALTH_BAR_H = 16,
	PLAYER_HEALTH_BAR_X = 640,
	PLAYER_HEALTH_BAR_Y = 132,
	PLAYER_WEAPONS_W = 500,
	PLAYER_WEAPONS_H = 250,
	PLAYER_WEAPONS_X = 300,
	PLAYER_WEAPONS_Y = 700
}

--default settings
KineticHUD.default_settings = {
	player_panel_scale = 1,
	PLAYER_HEALTH_BAR_HALIGN = 1,
	PLAYER_HEALTH_BAR_VALIGN = 1
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


function KineticHUD:ResetSettings()
	self.settings = table.deep_map_copy(self.default_settings)
end



--misc management
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

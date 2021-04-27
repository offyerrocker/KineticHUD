--written by Offyerrocker
local THIS_VERSION = 2

if QuickAnimate and QuickAnimate.VERSION and (QuickAnimate.VERSION >= THIS_VERSION) then 
	log(ModPath .. ": QuickAnimate version " .. tostring(QuickAnimate.VERSION) .. " already exists")
	return
end
QuickAnimate = QuickAnimate or class()
---
--v2 experimental: added parent class to default getting animate functions from
---
QuickAnimate.updater_types = {
	HUDManager = 1,
	BeardLib = 2,
	none = 3
}

QuickAnimate.VERSION = THIS_VERSION

QuickAnimate._animate_targets = {}
QuickAnimate._animate_waits = 0 --used for unique number identifiers for animate_wait() calls


function QuickAnimate:log(a,...)
	if Console then 
		Console:Log(self._id .. ": " .. tostring(a),...)
	else
		log(self._id .. ": " .. tostring(a),...)
	end
end

function QuickAnimate:init(id,params,...)
	self._id = id
	self.updater_id = "QuickAnimate_" .. tostring(self._id)
	params = params or {}
	self.parent = params.parent
	--parent is used to get animation funcs from; must be table or class, should contain animate functions 
	
	local updater_type = params.updater_type
	if updater_type == QuickAnimate.updater_types.none then 
		--do nothing; presumably, let the caller handle it
	elseif updater_type == QuickAnimate.updater_types.BeardLib then 
		if BeardLib then 
			BeardLib:AddUpdater(self.updater_id,callback(self,self,"UpdateAnimate"))
		else
			self:log("ERROR: Failed to create updater- BeardLib is not installed!")
		end
	elseif updater_type == QuickAnimate.updater_types.HUDManager then
		if managers.hud then 
			managers.hud:add_updator(self.updater_id,callback(self,self,"UpdateAnimate"))
		else
			Hooks:Add("BaseNetworkSessionOnLoadComplete","QuickAnimate_" .. tostring(id) .. "_OnLoadComplete",callback(self,self,"QueuedAddUpdater"))
		end
	end
end

function QuickAnimate:QueuedAddUpdater()
	if managers.hud then 
		managers.hud:add_updator(self.updater_id,callback(self,self,"UpdateAnimate"))
	else
		self:log("ERROR: Unable to add updator")
	end
end

function QuickAnimate:animate_stop(name,do_cb)
	local item = self._animate_targets[tostring(name)]
	self._animate_targets[tostring(name)] = nil
	if item and do_cb and (type(item.done_cb) == "function") then 
		return item.done_cb(item.target,unpack(item.params))
	end
end

function QuickAnimate:animate(target,func,done_cb,...)
	if target then 
		local f_s = tostring(func)
		if type(func) == "function" then 
		elseif self.parent and self.parent[f_s] and type(self.parent[f_s]) == "function" then
			func = self.parent[f_s]
		elseif type(self[f_s]) == "function" then
			func = self[f_s]
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

function QuickAnimate:animate_wait(timer,callback,...)
	self._animate_waits = self._animate_waits + 1
	self:animate(self._animate_waits,self._animate_wait,callback,timer,...)
end

function QuickAnimate._animate_wait(o,t,dt,start_t,duration)
	if (t - start_t) >= duration then 
		return true
	end
end

function QuickAnimate.animate_fadeout(o,t,dt,start_t,duration,from_alpha,exit_x,exit_y)
	duration = duration or 1
	from_alpha = from_alpha or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(0)
		return true
	end
	o:set_alpha(from_alpha * (1 - ratio))
	if exit_y then 
		o:set_y(o:y() + (exit_y * dt / duration))
	end
	if exit_x then 
		o:set_x(o:x() + (exit_x * dt / duration))
	end
end

function QuickAnimate.animate_fadein(o,t,dt,start_t,duration,end_alpha,start_x,end_x,start_y,end_y)
	duration = duration or 1
	end_alpha = end_alpha or 1
	local ratio = math.pow((t - start_t) / duration,2)
	
	if ratio >= 1 then 
		o:set_alpha(end_alpha)
		if end_x then 
			o:set_x(end_x)
		end 
		if end_y then 
			o:set_y(end_y)
		end
		return true
	end
	o:set_alpha(ratio * end_alpha)
	if start_x and end_x then 
		o:set_x(start_x + ((end_x - start_x) * ratio))
	end
	if start_y and end_y then 
		o:set_y(start_y + ((end_y - start_y) * ratio))
	end
end

function QuickAnimate.animate_oscillate_alpha(o,t,dt,start_t,offset_percent,frequency,alpha_min,alpha_max)
	local d_a = alpha_max - alpha_min
	local _t = t
	local offset = offset_percent * 180
	local wave = math.sin((t + offset) * (frequency * math.pi))
	o:set_alpha(alpha_min + (d_a * wave))
end

function QuickAnimate:UpdateAnimate(t,dt)
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
				else
					self._animate_targets[id] = nil
				end
			end
		else
			self._animate_targets[id] = nil
		end
	end
end


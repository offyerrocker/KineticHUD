
Hooks:PostHook(HUDStatsScreen,"init","khud_hudstatsscreen_init",function(self)
	local parent_panel = managers.hud:script(managers.hud.STATS_SCREEN_FULLSCREEN).panel
	self._left:hide()
	self._right:hide()
	self._bottom:hide()
	
	KineticHUD:CreateStatsPanel()
	--[[
		-mission data
			crimespree:
				mission name from data
				cs level
			normal:
				current day
				number of days
				is stealthable icon
				level name
				difficulty name
				is one down
				payout
				
			all objectives (0+)
			converted enemies
			if stealth:
				pagers used
				pagers total
	
			lobby player info:
				info on players in your lobby
				
			lootbags:
				-mandatory amount
				-secured amount
				-bonus amount
				-secured bags value
				-instant cash
			
			
		-mutators
			list of mutators ig
		-current playing track
		-tracked achievements
	
	--]]
	
end)

function HUDStatsScreen:recreate_left()
	KineticHUD:RefreshStatsObjectives()
	KineticHUD:RefreshStatsConverts()
end

function HUDStatsScreen:_create_tracked_list()
	KineticHUD:RefreshStatsAchievements()
end

function HUDStatsScreen:_create_mutators_list()
	KineticHUD:RefreshStatsMutators()
end

function HUDStatsScreen:loot_value_updated()
	KineticHUD:RefreshStatsLoot()
end

function HUDStatsScreen:on_ext_inventory_changed()
	KineticHUD:RefreshStatsInventory()
end

function HUDStatsScreen:hide()
	if alive(KineticHUD._stats_panel) then 
		KineticHUD:ShowHUD()
		KineticHUD._stats_panel:hide()
	end
end


function HUDStatsScreen:show()
	if alive(KineticHUD._stats_panel) then 
		KineticHUD:HideHUD()
		KineticHUD._stats_panel:show()
	end
end


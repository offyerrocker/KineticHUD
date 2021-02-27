Hooks:PreHook(StatisticsManager,"stop_session","khud_stats_onstopsession",function(self,data)
	if data and self._session_started then 
		--on mission end
		KineticHUD:OnMissionEnd(data)
	end
end)

Hooks:PostHook(StatisticsManager,"killed","khud_stats_onkill",function(self,data)
	KineticHUD:OnKill(data)
end)

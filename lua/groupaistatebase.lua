

Hooks:PostHook(GroupAIStateBase,"_set_converted_police","khud_groupaistate_set_converted_police",function(self,u_key, unit, owner_unit)
	if owner_unit == managers.player:local_player() then 
		KineticHUD:RegisterPlayerConvert(u_key,unit,owner_unit)
	end
	KineticHUD:RefreshStatsConverts()
end)

local orig_removeminion = GroupAIStateBase.remove_minion
function GroupAIStateBase:remove_minion(minion_key,player_key,...)
	KineticHUD:UnregisterPlayerConvert(minion_key,player_key,...)
	local result = {orig_removeminion(self,minion_key,player_key,...)}
	KineticHUD:RefreshStatsConverts()
	return unpack(result)
end
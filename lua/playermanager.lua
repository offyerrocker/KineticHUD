Hooks:PostHook(PlayerManager,"player_destroyed","khud_on_player_diagnosed_with_dead",function(self,id)
	if id == KineticHUD._cache.local_peer_id then 
--		KineticHUD:RegisterUpdateCheckPlayer()
	end
end)
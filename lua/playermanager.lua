Hooks:PostHook(PlayerManager,"player_destroyed","khud_on_player_diagnosed_with_dead",function(self,id)
	if id == managers.network:session():local_peer():id() then 
		 KineticHUD:RegisterUpdateCheckPlayer()
	end
end)
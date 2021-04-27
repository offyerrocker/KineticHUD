--note: HUDBuffManager is a class added from this mod, written by Offyerrocker, and is not related to any classes in PAYDAY 2
HUDBuffManager = HUDBuffManager or class()

function HUDBuffManager:init()
	
end

function HUDBuffManager:AddBuff()
	
end

function HUDBuffManager:RemoveBuff()

end


--holds individual HUD buffs
HUDBuffItem = HUDBuffItem or class()

function HUDBuffItem:init(params)
	self._parent_hud_panel = KineticHUD._buffs_panel
	self._data = params
	
	
end

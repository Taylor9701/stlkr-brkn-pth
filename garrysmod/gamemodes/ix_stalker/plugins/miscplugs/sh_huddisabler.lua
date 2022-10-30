--[[
local PLUGIN = PLUGIN
PLUGIN.name = "hidehud"
PLUGIN.author = "verne"
PLUGIN.desc = "Disables the HUD."
--]]

ix.option.Add("disablehud", ix.type.bool, false, { -- optDisablehud in language
	category = "STALKER Settings",
})

function PLUGIN:HUDPaint()
	if ix.option.Get("disablehud", false) then
		return false
	end
end

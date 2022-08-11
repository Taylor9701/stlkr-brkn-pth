ITEM.name = "Test Walllet"
ITEM.description= "Default kit."
ITEM.longdesc = ""
ITEM.model = "models/props_junk/garbage_bag001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Kits"
ITEM.itemsForcedDrop = {}
ITEM.items[1] = {
	dropAmount = 1, --How many times it will roll for drop
	dropRareChance = 40, --chances for the rarer drops
	dropVeryRareChance = 20,
	itemsCommon = {
		{"bagrubles", {["quantity"] = 100}}, 
		{"bagrubles", {["quantity"] = 200}},
	},
	itemsRare = {
		{"bagrubles", {["quantity"] = 1000}}, 
		{"762x25"},
	},
	itemsVeryRare = {
		{"bagrubles", {["quantity"] = 5000}}, 
	}


}







--[[ Example format
ITEM.items[1] = {
	dropAmount = 5, --How many times it will roll for drop
	dropRareChance = 40, --chances for the rarer drops
	dropVeryRareChance = 20,
	itemsCommon = {
		{"9x18"},
		{"9x19"},
		{"12gauge"},
	},
	itemsRare = {
		{"57x28"},
		{"380acp"},
		{"762x25"},
	},
	itemsVeryRare = {
		{"22lr"},
		{"mp5", {["durability"] = 30}}, --Data can also be passed
		{"45acp"},
	},
}
]]--


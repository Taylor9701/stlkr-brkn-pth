ITEM.name = "Beard Oil"
ITEM.model = "models/kek1ch/drink_flask.mdl"
ITEM.description = "A artifact-based concotion slathered onto suits for extra Chemical protection."
ITEM.longdesc = "With the knowledge of a specialist, a Beard artifact can be distilled into a soupy texture that can be slathered onto a suit as a salve to temporarily imbue a version of its effects without a need for an artifact container. After it dries, it takes the appearence of green glue that can be scraped off. \nFor 20 Minutes:\nIf not in hotspot: +1 Chem Tier\nIf in hotspot: +4 Rounds\nImpact -1" 
ITEM.quantity = 1
ITEM.price = 0
ITEM.width = 1
ITEM.height = 1
ITEM.cookable = false
ITEM.flag = "A"
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "applies a coating of "..item.name..".", false)
end)
ITEM.weight = 0.1
ITEM:DecideFunction()
ITEM.name = "Consumable"
ITEM.description = "Something to eat"
ITEM.longdesc = ""
ITEM.model = "models/kleiner.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumables"
ITEM.hunger = 0
ITEM.thirst = 0
ITEM.empty = false
ITEM.quantity = 1
ITEM.quantMax = 1
ITEM.useName = "Consume" -- "Eat" or "Drink" generally
ITEM.useIcon = "icon16/stalker/drink.png" -- or "icon16/stalker/eat.png"

ITEM.functions.Sell = {
	name = "Sell",
	icon = "icon16/stalker/sell.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		local sellprice = item.price/1.32
		
		if item.quantity > 1 then
			sellprice = ((item.price/1.32) * (item:GetData("quantity",item.quantity)/item.quantity))
		end
		sellprice = math.Round(sellprice)
		client:Notify( "Sold for "..(sellprice).." rubles." )
		client:GetCharacter():GiveMoney(sellprice)
		return true 
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

ITEM.functions.Value = {
	name = "Value",
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		local sellprice = (item.price/1.32)
		
		if item.quantity > 1 then
			sellprice = (sellprice * (item:GetData("quantity",item.quantity)/item.quantity))
		end
		sellprice = math.Round(sellprice)
		client:Notify( "Item is sellable for "..(sellprice).." rubles." )
		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

function ITEM:GetDescription()
	local str = self.description
	if self.longdesc and !IsValid(self.entity) then
		str = str.."\n"..(self.longdesc or "")
	end

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end
	
	if (customData.longdesc) and !IsValid(self.entity) then
		str = str.."\n"..customData.longdesc or ""
	end

    return (str)
end

function ITEM:GetName()
	local name = self.name
	
	local customData = self:GetData("custom", {})
	if(customData.name) then
		name = customData.name
	end
	
	return name
end

ITEM.functions.Custom = {
	name = "Customize",
	tip = "Customize this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)		
		ix.plugin.list["customization"]:startCustom(item.player, item)
		
		return false
	end,
	
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

ITEM.functions.Inspect = {
	name = "Inspect",
	tip = "Inspect this item",
	icon = "icon16/picture.png",
	OnClick = function(item, test)
		local customData = item:GetData("custom", {})

		local frame = vgui.Create("DFrame")
		frame:SetSize(540, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		
		local imageCode = [[<img src = "]]..customData.img..[["/>]]
		
		frame.html:SetHTML([[<html><body style="background-color: #000000; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..imageCode..[[</body></html>]])
	end,
	OnRun = function(item)
		return false
	end,
	OnCanRun = function(item)
		local customData = item:GetData("custom", {})
	
		if(!customData.img) then
			return false
		end
		
		if(item.entity) then
			return false
		end
		
		return true
	end
}

ITEM.functions.Clone = {
	name = "Clone",
	tip = "Clone this item",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player	
	
		client:requestQuery("Are you sure you want to clone this item?", "Clone", function(text)
			if text then
				local inventory = client:GetCharacter():GetInventory()
				
				if(!inventory:Add(item.uniqueID, 1, item.data)) then
					client:Notify("Inventory is full")
				end
			end
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
	end
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		local cooked = item:GetData("cooked", 1)
		local quantity = item:GetData("quantity", item.quantity)

		draw.SimpleText(quantity.."/"..item.quantMax, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		
		if !data[1] then
			return false
		end
		
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		local combinedQuant = (localQuant + targetQuant)

		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

		if combinedQuant <= item.quantMax then
			targetItem:SetData("quantity", combinedQuant)
			return true
		elseif localQuant >= targetQuant then
			targetItem:SetData("quantity",item.quantity)
			item:SetData("quantity",(localQuant - (item.quantity - targetQuant)))
			return false
		else
			targetItem:SetData("quantity",(targetQuant - (item.quantity - localQuant)))
			item:SetData("quantity",item.quantity)
			return false
		end
	end,
}

ITEM.functions.use = {
	name = ITEM.useName,
	icon = ITEM.useIcon,
	OnCanRun = function(item)
		plyThirst = item.player:GetCharacter():GetData("thirst", 100)
		plyHunger = item.player:GetCharacter():GetData("hunger", 100)
		
		if !IsValid(item.entity) then
			if (item.thirst > 0 and plyThirst >= 100) then
				return false
			elseif(item.hunger > 0 and plyHunger >= 100) then
				return false
			end
		end
	end,
	OnRun = function(item)
		local itemtable = item
		local player = itemtable.player
		local hunger = player:GetCharacter():GetData("hunger", 100)
		local thirst = player:GetCharacter():GetData("thirst", 100)
		local quantity = itemtable:GetData("quantity", itemtable.quantity)
		local newhealth = math.Clamp(player:Health() + itemtable.heal, 1, 100)
		player:SetHealth(newhealth)
		player:SetHunger(hunger + itemtable.hunger)
		player:SetThirst(thirst + itemtable.thirst)
		player:UpdateThirstState(itemtable.player)
		if itemtable.empty then
			local inv = player:GetCharacter():GetInventory()
			inv:Add(itemtable.empty)
		end
		
		if itemtable.healot and not timer.Exists("foodheal") then
			timer.Create("foodheal", 3, 5, function()
				local newhealth = math.Clamp(player:Health() + itemtable.heal, 1, 100)
				player:SetHealth(newhealth)
			end)
		elseif itemtable.healot and timer.Exists("foodheal") then
			timer.Adjust("foodheal", 3, 5, function()
				local newhealth = math.Clamp(player:Health() + itemtable.heal, 1, 100)
				player:SetHealth(newhealth)
			end)
		end

		quantity = quantity - 1
		
		if (quantity >= 1) then
			itemtable:SetData("quantity", quantity)
			return false
		end
	end
}
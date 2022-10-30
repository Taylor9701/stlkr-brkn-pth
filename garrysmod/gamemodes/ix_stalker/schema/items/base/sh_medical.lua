ITEM.name = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Helps your body survive in the zone - in one way or another."
ITEM.longdesc = " "
ITEM.stopsBleed = false
ITEM.quantMax = 5
ITEM.quantity = 1
ITEM.weight = 1
ITEM.restore = 0
ITEM.radrem = 0
ITEM.stamBuff = 0
ITEM.useName = "Heal"
ITEM.useText = {"opens a ", " and uses it"}

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

ITEM:Hook("usetarget", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
end)

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
	local quant = self:GetData("quantity", 1)
	local str = self.description
	if self.longdesc then
		str = str.."\n"..(self.longdesc or "").."\n\nThere's only "..quant.." use(s) left."
	end

	local customData = self:GetData("custom", {})
	if(customData.desc) then
		str = customData.desc
	end

	if (customData.longdesc) then
		str = str.."\n"..(customData.longdesc or "").."\n\nThere's only "..quant.." use(s) left."
	end

	if (self.entity) then
		return (self.description)
	else
        return (str)
	end
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

function ITEM:stopBleed(client)
	if(timer.Exists(client:Name().."res_bleed")) then
		timer.Remove(client:Name().."res_bleed")
		client:Notify("Your bleeding has stopped.")
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantMax, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.use = {
	name = ITEM.useName,
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		
		if (item.stamBuff > 0) then
			item.player:AddBuff("buff_staminarestore", 300, { amount = item.stamBuff })
		end
		
		if (item.restore > 0 or item.radrem > 0) then
			item.player:AddBuff("buff_slowheal", 20, { amount = item.restore })
			item.player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem })
		end
		
		ix.chat.Send(item.player, "iteminternal", item.useText[1]..item.name..item.useText[2], false)
		
		if (item.stopsBleed) then item:stopBleed(item.player) end
		
		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

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

--[[
ITEM.functions.usetarget = {
	name = "Heal Target",
	icon = "icon16/stalker/heal.png",
	onRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:getData("quantity", item.quantity)
		if (IsValid(target) and target:IsPlayer()) then
			target:AddBuff("buff_slowheal", 15, { amount = item.restore*(1+(item.player:getChar():getAttrib("medical", 0)/50))/10 })
			nut.chat.send(item.player, "iteminternal", "opens a "..item.name.." and uses it on "..target:Name()..".", false)
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:setData("quantity", quantity)
				return false
			end
			
			
		else
			item.player:notify("Not looking at a player!")
			return false
		end

		return true
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
--]]
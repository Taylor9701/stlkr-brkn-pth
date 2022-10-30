PLUGIN.name = "Weight"
PLUGIN.author = "Taylor"
PLUGIN.desc = "Adds a Weight system for items"

local backpacks = {
	["Modern Military Backpack (Ukranian)"] = 55,
	["Modern Military Backpack (USA)"] = 55,
	["Modern Military Backpack (Russian)"] = 55,
	["Large Modern Military Backpack (Ukranian)"] = 60,
	["Large Modern Military Backpack (USA)"] = 60,
	["Large Modern Military Backpack (Russian)"] = 60,
	["Zone Survival Backpack"] = 65,
	["Zone Survival Backpack (Camouflaged)"] = 65,
	["Large Zone Survival Backpack"] = 70,
	["Large Zone Survival Backpack (Camouflaged)"] = 70,
}

hook.Remove("CreateMenuButtons", "ixInventory")

hook.Add("CreateMenuButtons", "ixInventory", function(tabs)
	if (hook.Run("CanPlayerViewInventory") == false) then
		return
	end

	tabs["inv"] = {
		bDefault = true,
		Create = function(info, container)
			local canvas = container:Add("DTileLayout")
			local canvasLayout = canvas.PerformLayout
			canvas.PerformLayout = nil -- we'll layout after we add the panels instead of each time one is added
			canvas:SetBorder(0)
			canvas:SetSpaceX(2)
			canvas:SetSpaceY(2)
			canvas:Dock(FILL)

			ix.gui.menuInventoryContainer = canvas

			local panel = canvas:Add("ixInventory")
			panel:SetPos(0, 0)
			panel:SetDraggable(false)
			panel:SetSizable(false)
			panel:SetTitle("")
			panel.bNoBackgroundBlur = true
			panel.childPanels = {}

			local inventory = LocalPlayer():GetCharacter():GetInventory()

			if (inventory) then
				panel:SetInventory(inventory)
			end

			ix.gui.inv1 = panel

			if (ix.option.Get("openBags", true)) then
				for _, v in pairs(inventory:GetItems()) do
					if (!v.isBag) then
						continue
					end

					v.functions.View.OnClick(v)
				end
			end

			canvas.PerformLayout = canvasLayout
			canvas:Layout()
		end
	}
end)

ix.config.Add("maxWeight", 50, "Determines the default max carry weight.", nil, {
	data = {min = 1, max = 200},
	category = "server"
})
 
if (SERVER) then
    function PLUGIN:CharacterLoaded(char) 
        if char == nil then return end
        local character = char
		local carrybuff = character:GetData("WeightBuffCur") or 0
        local inventory = character:GetInv()
        local weight = 0
        local totweight = 0
        local maxweight = ix.config.Get("maxWeight", 50)
		local bpBuff = 0
		
        for x, y in pairs(inventory:GetItems()) do
			if y.weight == nil then continue end
			
			local quantity = y:GetData("quantity",1)
			
            if y:GetData("weight") ~= nil then
                weight = y:GetData("weight",0)
            elseif y.weight ~= nil then
                weight = y.weight
            end
            
            if y.isCW then
                if weight ~= (y.weight + y:GetData("weight",0)) then
            	    weight = y.weight + y:GetData("weight",0)
            	end
            end
            
            totweight = ((quantity * weight) + totweight)
        end
		
		for x,y in pairs(inventory:GetItems(true)) do
			if backpacks[y.name] then
				if bpBuff < backpacks[y.name] then
					bpBuff = backpacks[y.name]
				end
			end
		end
		
		
		maxweight = maxweight + carrybuff + bpBuff
        character:SetData("Weight", totweight)
        character:SetData("MaxWeight", maxweight)
    end
elseif (CLIENT) then
    function PLUGIN:PostDrawInventory(panel)
        if LocalPlayer():GetChar() == nil then return end
        local character = LocalPlayer():GetChar()
        local weight = character:GetData("Weight",0)
        local maxweight = character:GetData("MaxWeight",50)
		
        if IsValid(panel) then
            panel:SetTitle(L"inv" .. " | " .. weight .. "lb of " .. maxweight .. "lb")
        end
    end
end

function PLUGIN:CanPlayerTakeItem(client, itemEnt)
	local character = client:GetChar()
	local carrybuff = character:GetData("WeightBuffCur") or 0
    local inventory = character:GetInv()
	local item = ix.item.list[itemEnt:GetItemID()]
	local itemWeight = item.weight
    local weight = 0
    local totweight = 0
    local maxweight = ix.config.Get("maxWeight", 50) + carrybuff
	local bpBuff = 0
	
	for x,y in pairs(inventory:GetItems(true)) do
		if backpacks[y.name] then
			if bpBuff < backpacks[y.name] then
				bpBuff = backpacks[y.name]
			end
		end
	end
	
	for x, y in pairs(inventory:GetItems()) do
		if y.weight == nil then continue end
		local quantity = y:GetData("quantity",1)
		
        if y:GetData("weight") ~= nil then
            weight = y:GetData("weight",0)
        elseif y.weight ~= nil then
            weight = y.weight
        end
        
        if y.isCW then
            if weight ~= (y.weight + y:GetData("weight",0)) then
                weight = y.weight + y:GetData("weight",0)
			end
        end
        
        totweight = ((quantity * weight) + totweight)
    end
	
	if itemWeight ~= nil then
		local quantity = item:GetData("quantity",1)
		if item.isCW then
			if item.isCW then
				if weight ~= (itemWeight + item:GetData("weight",0)) then
					weight = itemWeight + item:GetData("weight",0)
				end
			end
		else
			if item:GetData("weight") ~= nil then
				weight = item:GetData("weight",0)
			else
				weight = itemWeight
			end
		end
		totweight = ((quantity * weight) + totweight)
	end
	
	if totweight > maxweight then
		client:NotifyLocalized("This would put you over max weight.")
		return false
	end
end

function PLUGIN:PlayerInteractItem(client, action, item)
    local character = client:GetChar()
	local carrybuff = character:GetData("WeightBuffCur") or 0
    local inventory = character:GetInv()
    local weight = 0
    local totweight = 0
    local maxweight = ix.config.Get("maxWeight", 50)
	local bpBuff = 0
	
	for x,y in pairs(inventory:GetItems(true)) do
		if backpacks[y.name] then
			if bpBuff < backpacks[y.name] then
				bpBuff = backpacks[y.name]
			end
		end
	end
	
	if action == "take" then
		if item.weight then
			if item:GetData("quantity") then
				totweight = (totweight + (item:GetData("quantity") * item.weight))
			else
				totweight = (totweight + item.weight)
			end
		end
    elseif action == "drop" then
		if item.weight then
			if item:GetData("quantity") then
				totweight = (totweight - (item:GetData("quantity") * item.weight))
			else
				totweight = (totweight - item.weight)
			end
		end
	end
	
    for x, y in pairs(inventory:GetItems()) do
		if y.weight == nil then continue end
		local quantity = y:GetData("quantity",1)
		
        if y:GetData("weight") ~= nil then
            weight = y:GetData("weight",0)
        elseif y.weight ~= nil then
            weight = y.weight
        end
        
        if y.isCW then
            if weight ~= (y.weight + y:GetData("weight",0)) then
                weight = y.weight + y:GetData("weight",0)
			end
        end
        
        totweight = ((quantity * weight) + totweight)
    end
	
	maxweight = maxweight + carrybuff + bpBuff
    character:SetData("Weight", totweight)
    character:SetData("MaxWeight", maxweight)
end
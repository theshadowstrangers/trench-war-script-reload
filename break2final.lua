-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local LeftButtonContainer = Instance.new("Frame")
local LeftButtonList = Instance.new("UIListLayout")

ScreenGui.Name = "BreakIn2Gui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
MainFrame.Size = UDim2.new(0, 360, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " Break in 2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 300, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 330, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
RightPanel.BorderSizePixel = 0
RightPanel.Size = UDim2.new(1, -85, 1, -35)
RightPanel.Position = UDim2.new(0, 85, 0, 35)

LeftButtonContainer.Name = "LeftButtonContainer"
LeftButtonContainer.Parent = LeftPanel
LeftButtonContainer.BackgroundTransparency = 1
LeftButtonContainer.Size = UDim2.new(1, -6, 1, -6)
LeftButtonContainer.Position = UDim2.new(0, 3, 0, 3)

LeftButtonList.Name = "LeftButtonList"
LeftButtonList.Parent = LeftButtonContainer
LeftButtonList.Padding = UDim.new(0, 4)
LeftButtonList.SortOrder = Enum.SortOrder.LayoutOrder

local function createTab(tabName, displayName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Text = displayName or tabName
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = LeftButtonContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -6, 1, -6)
    content.Position = UDim2.new(0, 3, 0, 3)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.ScrollBarThickness = 3
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = RightPanel
    Instance.new("UIListLayout", content).Padding = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(RightPanel:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        content.Visible = true
    end)

    return btn, content
end

local infoBtn, infoTab = createTab("Info", "Info")
local everyoneBtn, everyoneTab = createTab("Everyone", "Everyone")
local itemsBtn, itemsTab = createTab("Items", "Items")
local miscBtn, miscTab = createTab("Misc", "Misc")
local deleteBtn, deleteTab = createTab("Delete", "Delete")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Break in 2\nCopy By The8883"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EVERYONE ====================
local healAllBtn = Instance.new("TextButton")
healAllBtn.Size = UDim2.new(1, 0, 0, 32)
healAllBtn.Text = "Heal all"
healAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
healAllBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
healAllBtn.Font = Enum.Font.SourceSansBold
healAllBtn.TextSize = 13
healAllBtn.BorderSizePixel = 0
healAllBtn.Parent = everyoneTab
Instance.new("UICorner", healAllBtn).CornerRadius = UDim.new(0, 4)

healAllBtn.MouseButton1Click:Connect(function()
    local player = game:GetService("Players").LocalPlayer
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if not events then return end
    
    local giveTool = events:FindFirstChild("GiveTool")
    local healNoobs = events:FindFirstChild("HealTheNoobs")
    if not giveTool or not healNoobs then return end
    
    pcall(function()
        giveTool:FireServer("GoldenApple")
    end)
    
    local apple = nil
    local startTime = tick()
    while tick() - startTime < 3 do
        apple = player.Backpack:FindFirstChild("GoldenApple")
        if apple then break end
        task.wait(0.1)
    end
    
    if apple then
        local char = player.Character
        if char then
            apple.Parent = char
            task.wait(0.3)
        end
    end
    
    pcall(function()
        healNoobs:FireServer()
    end)
end)

local selectedPlayerName = nil

local selectPlayerBtn = Instance.new("TextButton")
selectPlayerBtn.Size = UDim2.new(1, 0, 0, 32)
selectPlayerBtn.Text = "Player: none"
selectPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selectPlayerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
selectPlayerBtn.Font = Enum.Font.SourceSansBold
selectPlayerBtn.TextSize = 13
selectPlayerBtn.BorderSizePixel = 0
selectPlayerBtn.Parent = everyoneTab
Instance.new("UICorner", selectPlayerBtn).CornerRadius = UDim.new(0, 4)

local kickPlayerBtn = Instance.new("TextButton")
kickPlayerBtn.Size = UDim2.new(1, 0, 0, 32)
kickPlayerBtn.Text = "Kick player"
kickPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
kickPlayerBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
kickPlayerBtn.Font = Enum.Font.SourceSansBold
kickPlayerBtn.TextSize = 13
kickPlayerBtn.BorderSizePixel = 0
kickPlayerBtn.Parent = everyoneTab
Instance.new("UICorner", kickPlayerBtn).CornerRadius = UDim.new(0, 4)

local kickOthersBtn = Instance.new("TextButton")
kickOthersBtn.Size = UDim2.new(1, 0, 0, 32)
kickOthersBtn.Text = "Kick others"
kickOthersBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
kickOthersBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
kickOthersBtn.Font = Enum.Font.SourceSansBold
kickOthersBtn.TextSize = 13
kickOthersBtn.BorderSizePixel = 0
kickOthersBtn.Parent = everyoneTab
Instance.new("UICorner", kickOthersBtn).CornerRadius = UDim.new(0, 4)

selectPlayerBtn.MouseButton1Click:Connect(function()
    local selectGui = Instance.new("ScreenGui")
    selectGui.Name = "PlayerSelectorGui"
    selectGui.Parent = game:GetService("CoreGui")
    selectGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 350)
    frame.Position = UDim2.new(0.5, -125, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Parent = selectGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    header.BorderSizePixel = 0
    header.Parent = frame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -50, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = "Select Player"
    headerLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Font = Enum.Font.SourceSansBold
    headerLabel.TextSize = 14
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 18
    closeBtn.Parent = header
    closeBtn.MouseButton1Click:Connect(function()
        selectGui:Destroy()
    end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 30)
        b.Text = plr.Name
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        b.Font = Enum.Font.SourceSans
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.BorderSizePixel = 0
        b.Parent = scroll
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)

        b.MouseButton1Click:Connect(function()
            selectedPlayerName = plr.Name
            selectPlayerBtn.Text = "Player: " .. plr.Name
            selectGui:Destroy()
        end)
    end
end)

kickPlayerBtn.MouseButton1Click:Connect(function()
    if not selectedPlayerName then return end
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if not events then return end
    local onDoorHit = events:FindFirstChild("OnDoorHit")
    if not onDoorHit then return end

    local target = game:GetService("Players"):FindFirstChild(selectedPlayerName)
    if target then
        pcall(function()
            onDoorHit:FireServer(target)
        end)
    end
end)

kickOthersBtn.MouseButton1Click:Connect(function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if not events then return end
    local onDoorHit = events:FindFirstChild("OnDoorHit")
    if not onDoorHit then return end

    local localPlayer = game:GetService("Players").LocalPlayer
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= localPlayer then
            pcall(function()
                onDoorHit:FireServer(plr)
            end)
            task.wait(0.1)
        end
    end
end)

-- ==================== ITEMS ====================
local selectedFood = nil
local selectedItem = nil
local selectedWeapon = nil

local foodBtn = Instance.new("TextButton")
foodBtn.Size = UDim2.new(1, 0, 0, 32)
foodBtn.Text = "Food: none"
foodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
foodBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
foodBtn.Font = Enum.Font.SourceSansBold
foodBtn.TextSize = 13
foodBtn.BorderSizePixel = 0
foodBtn.Parent = itemsTab
Instance.new("UICorner", foodBtn).CornerRadius = UDim.new(0, 4)

local giveFoodBtn = Instance.new("TextButton")
giveFoodBtn.Size = UDim2.new(1, 0, 0, 32)
giveFoodBtn.Text = "Give Food"
giveFoodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveFoodBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
giveFoodBtn.Font = Enum.Font.SourceSansBold
giveFoodBtn.TextSize = 13
giveFoodBtn.BorderSizePixel = 0
giveFoodBtn.Parent = itemsTab
Instance.new("UICorner", giveFoodBtn).CornerRadius = UDim.new(0, 4)

local itemBtn = Instance.new("TextButton")
itemBtn.Size = UDim2.new(1, 0, 0, 32)
itemBtn.Text = "Item: none"
itemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
itemBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
itemBtn.Font = Enum.Font.SourceSansBold
itemBtn.TextSize = 13
itemBtn.BorderSizePixel = 0
itemBtn.Parent = itemsTab
Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)

local giveItemBtn = Instance.new("TextButton")
giveItemBtn.Size = UDim2.new(1, 0, 0, 32)
giveItemBtn.Text = "Give Item"
giveItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveItemBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
giveItemBtn.Font = Enum.Font.SourceSansBold
giveItemBtn.TextSize = 13
giveItemBtn.BorderSizePixel = 0
giveItemBtn.Parent = itemsTab
Instance.new("UICorner", giveItemBtn).CornerRadius = UDim.new(0, 4)

local weaponBtn = Instance.new("TextButton")
weaponBtn.Size = UDim2.new(1, 0, 0, 32)
weaponBtn.Text = "Weapon: none"
weaponBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
weaponBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
weaponBtn.Font = Enum.Font.SourceSansBold
weaponBtn.TextSize = 13
weaponBtn.BorderSizePixel = 0
weaponBtn.Parent = itemsTab
Instance.new("UICorner", weaponBtn).CornerRadius = UDim.new(0, 4)

local giveWeaponBtn = Instance.new("TextButton")
giveWeaponBtn.Size = UDim2.new(1, 0, 0, 32)
giveWeaponBtn.Text = "Give Weapon"
giveWeaponBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveWeaponBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
giveWeaponBtn.Font = Enum.Font.SourceSansBold
giveWeaponBtn.TextSize = 13
giveWeaponBtn.BorderSizePixel = 0
giveWeaponBtn.Parent = itemsTab
Instance.new("UICorner", giveWeaponBtn).CornerRadius = UDim.new(0, 4)

local function openSelector(titleText, itemsList, onSelect)
    local selectGui = Instance.new("ScreenGui")
    selectGui.Name = "SelectorGui"
    selectGui.Parent = game:GetService("CoreGui")
    selectGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 350)
    frame.Position = UDim2.new(0.5, -125, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Parent = selectGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    header.BorderSizePixel = 0
    header.Parent = frame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -50, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = titleText
    headerLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Font = Enum.Font.SourceSansBold
    headerLabel.TextSize = 14
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 18
    closeBtn.Parent = header
    closeBtn.MouseButton1Click:Connect(function()
        selectGui:Destroy()
    end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, itemName in ipairs(itemsList) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 30)
        b.Text = itemName
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        b.Font = Enum.Font.SourceSans
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.BorderSizePixel = 0
        b.Parent = scroll
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)

        b.MouseButton1Click:Connect(function()
            onSelect(itemName)
            selectGui:Destroy()
        end)
    end
end

foodBtn.MouseButton1Click:Connect(function()
    local foods = {"Apple", "Cookie", "BloxyCola", "Chips", "MedKit", "Pizza", "GoldPizza", "GoldenApple", "RainbowPizza", "RainbowPizzaBox", "ExpiredBloxyCola"}
    openSelector("Food", foods, function(selected)
        selectedFood = selected
        foodBtn.Text = "Food: " .. selected
    end)
end)

giveFoodBtn.MouseButton1Click:Connect(function()
    if not selectedFood then return end
    local ev = game:GetService("ReplicatedStorage"):FindFirstChild("Events") and game:GetService("ReplicatedStorage").Events:FindFirstChild("GiveTool")
    if ev then
        pcall(function()
            ev:FireServer(selectedFood)
        end)
    end
end)

itemBtn.MouseButton1Click:Connect(function()
    local items = {"Key", "Louise", "Book", "Bottle", "Phone", "Battery", "Armor2"}
    openSelector("Item", items, function(selected)
        selectedItem = selected
        itemBtn.Text = "Item: " .. selected
    end)
end)

giveItemBtn.MouseButton1Click:Connect(function()
    if not selectedItem then return end
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if selectedItem == "Armor2" then
        if events and events:FindFirstChild("Vending") then
            pcall(function()
                events.Vending:FireServer(3, "Armor2", "Armor", game:GetService("Players").LocalPlayer, 1)
            end)
        end
    else
        if events and events:FindFirstChild("GiveTool") then
            pcall(function()
                events.GiveTool:FireServer(selectedItem)
            end)
        end
    end
end)

weaponBtn.MouseButton1Click:Connect(function()
    local weapons = {"Broom", "Pitchfork", "Crowbar2", "Crowbar1", "Crowbar", "Bat", "Hammer", "Wrench"}
    openSelector("Weapon", weapons, function(selected)
        selectedWeapon = selected
        weaponBtn.Text = "Weapon: " .. selected
    end)
end)

giveWeaponBtn.MouseButton1Click:Connect(function()
    if not selectedWeapon then return end
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if events and events:FindFirstChild("Vending") then
        pcall(function()
            events.Vending:FireServer(3, selectedWeapon, "Weapons", game:GetService("Players").LocalPlayer, 1)
        end)
    end
end)

-- ==================== MISC ====================
local larryEndBtn = Instance.new("TextButton")
larryEndBtn.Size = UDim2.new(1, 0, 0, 32)
larryEndBtn.Text = "Get basic-end"
larryEndBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
larryEndBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 180)
larryEndBtn.Font = Enum.Font.SourceSansBold
larryEndBtn.TextSize = 13
larryEndBtn.BorderSizePixel = 0
larryEndBtn.Parent = miscTab
Instance.new("UICorner", larryEndBtn).CornerRadius = UDim.new(0, 4)

larryEndBtn.MouseButton1Click:Connect(function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if not events then return end
    local larry = events:FindFirstChild("LarryEndingEvent")
    if not larry then return end
    pcall(function() larry:FireServer("HatCollected", true) end)
    task.wait(0.2)
    pcall(function() larry:FireServer("MaskCollected") end)
    task.wait(0.2)
    pcall(function() larry:FireServer("HatCollected") end)
    task.wait(0.2)
    pcall(function() larry:FireServer("CrowbarCollected") end)
end)

local getDogBtn = Instance.new("TextButton")
getDogBtn.Size = UDim2.new(1, 0, 0, 32)
getDogBtn.Text = "Get Dog"
getDogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getDogBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
getDogBtn.Font = Enum.Font.SourceSansBold
getDogBtn.TextSize = 13
getDogBtn.BorderSizePixel = 0
getDogBtn.Parent = miscTab
Instance.new("UICorner", getDogBtn).CornerRadius = UDim.new(0, 4)

getDogBtn.MouseButton1Click:Connect(function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if not events then return end
    local giveTool = events:FindFirstChild("GiveTool")
    if giveTool then
        pcall(function() giveTool:FireServer("Pizza") end)
    end
    task.wait(0.5)
    local catFed = events:FindFirstChild("CatFed")
    if catFed then
        pcall(function() catFed:FireServer("Pizza") end)
    end
end)

-- ==================== DELETE ====================
local selectedDeletePlayer = nil

local selectDeletePlayerBtn = Instance.new("TextButton")
selectDeletePlayerBtn.Size = UDim2.new(1, 0, 0, 32)
selectDeletePlayerBtn.Text = "Player: none"
selectDeletePlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selectDeletePlayerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
selectDeletePlayerBtn.Font = Enum.Font.SourceSansBold
selectDeletePlayerBtn.TextSize = 13
selectDeletePlayerBtn.BorderSizePixel = 0
selectDeletePlayerBtn.Parent = deleteTab
Instance.new("UICorner", selectDeletePlayerBtn).CornerRadius = UDim.new(0, 4)

selectDeletePlayerBtn.MouseButton1Click:Connect(function()
    local selectGui = Instance.new("ScreenGui")
    selectGui.Name = "DeletePlayerSelectorGui"
    selectGui.Parent = game:GetService("CoreGui")
    selectGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 350)
    frame.Position = UDim2.new(0.5, -125, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Parent = selectGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    header.BorderSizePixel = 0
    header.Parent = frame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -50, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = "Select Player"
    headerLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Font = Enum.Font.SourceSansBold
    headerLabel.TextSize = 14
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 18
    closeBtn.Parent = header
    closeBtn.MouseButton1Click:Connect(function()
        selectGui:Destroy()
    end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 30)
        b.Text = plr.Name
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        b.Font = Enum.Font.SourceSans
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.BorderSizePixel = 0
        b.Parent = scroll
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)

        b.MouseButton1Click:Connect(function()
            selectedDeletePlayer = plr.Name
            selectDeletePlayerBtn.Text = "Player: " .. plr.Name
            selectGui:Destroy()
        end)
    end
end)

local function deleteBodyPart(partName)
    if not selectedDeletePlayer then return end
    local target = workspace:FindFirstChild(selectedDeletePlayer)
    if target then
        local part = target:FindFirstChild(partName)
        if part then
            part:Destroy()
        end
    end
end

local bodyParts = {
    "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
    "UpperTorso", "LowerTorso", "LeftHand", "RightHand", "LeftFoot", "RightFoot",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "HumanoidRootPart"
}

for _, partName in ipairs(bodyParts) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Text = "Delete " .. partName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = deleteTab
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        deleteBodyPart(partName)
    end)
end

local deleteGameBtn = Instance.new("TextButton")
deleteGameBtn.Size = UDim2.new(1, 0, 0, 32)
deleteGameBtn.Text = "Delete Game"
deleteGameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteGameBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
deleteGameBtn.Font = Enum.Font.SourceSansBold
deleteGameBtn.TextSize = 14
deleteGameBtn.BorderSizePixel = 0
deleteGameBtn.Parent = deleteTab
Instance.new("UICorner", deleteGameBtn).CornerRadius = UDim.new(0, 4)

deleteGameBtn.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetChildren()) do
        pcall(function()
            obj:Destroy()
        end)
    end
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 30), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = false
        RightPanel.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 320), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = true
        RightPanel.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    collectgarbage()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

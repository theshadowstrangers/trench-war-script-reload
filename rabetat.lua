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

ScreenGui.Name = "RunAway Beta"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
MainFrame.Size = UDim2.new(0, 360, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " RunAway Beta"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 70, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RightPanel.BorderSizePixel = 0
RightPanel.Size = UDim2.new(1, -75, 1, -35)
RightPanel.Position = UDim2.new(0, 75, 0, 35)

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
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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
local exploitBtn, exploitTab = createTab("Exploit", "Exploit")
local espBtn, espTab = createTab("Esp", "Esp")
local grabBtn, grabTab = createTab("Grab-item", "Grab-item")
local miscBtn, miscTab = createTab("Misc", "Misc")
local playerBtn, playerTab = createTab("Player", "Player")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "RunAway Beta\nBy Spynote\nCreate in 2026 year"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local Event = game:GetService("ReplicatedStorage").FlowClient.ClientRunner.Event
local FunctionEvent = game:GetService("ReplicatedStorage").FlowClient.ClientRunner.Function
local NPCs = workspace:FindFirstChild("NPCs")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- ==================== 10-ITEMS-GIVE ====================
local tools10Btn = Instance.new("TextButton")
tools10Btn.Size = UDim2.new(1, 0, 0, 32)
tools10Btn.Text = "10-items Give"
tools10Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
tools10Btn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
tools10Btn.Font = Enum.Font.SourceSansBold
tools10Btn.TextSize = 14
tools10Btn.BorderSizePixel = 0
tools10Btn.Parent = exploitTab
Instance.new("UICorner", tools10Btn).CornerRadius = UDim.new(0, 4)

tools10Btn.MouseButton1Click:Connect(function()
    local loot = workspace:FindFirstChild("Loot")
    if not loot then
        print("Loot not found!")
        return
    end

    local items = {}
    for _, child in pairs(loot:GetChildren()) do
        local handle = child:FindFirstChild("Handle")
        if handle then
            table.insert(items, {
                Object = child,
                Handle = handle
            })
        end
    end

    if #items == 0 then
        print("No items with Handle found!")
        return
    end

    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local originalPos = hrp.CFrame
    local count = math.min(10, #items)

    for i = 1, count do
        local item = items[i]
        if item and item.Handle and item.Handle:IsA("BasePart") then
            -- Телепортируемся к предмету
            hrp.CFrame = item.Handle.CFrame * CFrame.new(0, 2, 0)
            task.wait(0.2)
            
            -- Выполняем евент для захвата
            pcall(function()
                FunctionEvent:InvokeServer("Loot", "LootEquip", item.Handle)
            end)
            task.wait(0.2)
        end
    end

    -- Возвращаемся обратно
    hrp.CFrame = originalPos
    print("✅ Захвачено " .. count .. " предметов!")
end)

-- ==================== ESP ====================
local espActive = false
local espConnections = {}
local espObjects = {}

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(1, 0, 0, 32)
espBtn.Text = "Esp Items OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
espBtn.Font = Enum.Font.SourceSansBold
espBtn.TextSize = 14
espBtn.BorderSizePixel = 0
espBtn.Parent = espTab
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 4)

local function clearESP()
    for _, obj in pairs(espObjects) do
        obj:Destroy()
    end
    espObjects = {}
    for _, conn in pairs(espConnections) do
        conn:Disconnect()
    end
    espConnections = {}
end

local function createESP(item)
    if not item or not item:IsA("BasePart") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Parent = item

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Text = item.Name
    nameLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 14
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.Text = "0 studs"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.BackgroundTransparency = 1
    distLabel.Font = Enum.Font.SourceSans
    distLabel.TextSize = 12
    distLabel.Parent = billboard

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.fromRGB(0, 100, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
    highlight.OutlineTransparency = 0.3
    highlight.Parent = item

    table.insert(espObjects, billboard)
    table.insert(espObjects, highlight)

    local connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not espActive then
            connection:Disconnect()
            return
        end
        if not item or not item.Parent then
            connection:Disconnect()
            return
        end
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (item.Position - player.Character.HumanoidRootPart.Position).Magnitude
            distLabel.Text = math.floor(dist) .. " studs"
        end
    end)
    table.insert(espConnections, connection)
end

local function scanLoot()
    clearESP()
    local loot = workspace:FindFirstChild("Loot")
    if not loot then return end

    for _, item in pairs(loot:GetChildren()) do
        if item:IsA("BasePart") or item:FindFirstChildWhichIsA("BasePart") then
            local part = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart")
            if part then
                createESP(part)
            end
        end
    end
end

espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive

    if espActive then
        espBtn.Text = "Esp Items ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        espBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        scanLoot()

        local loot = workspace:FindFirstChild("Loot")
        if loot then
            local conn = loot.ChildAdded:Connect(function(child)
                if espActive then
                    task.wait(0.1)
                    scanLoot()
                end
            end)
            table.insert(espConnections, conn)

            local conn2 = loot.ChildRemoved:Connect(function()
                if espActive then
                    task.wait(0.1)
                    scanLoot()
                end
            end)
            table.insert(espConnections, conn2)
        end
    else
        espBtn.Text = "Esp Items OFF"
        espBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        clearESP()
    end
end)

-- ==================== GRAB-ITEM ====================
local grabContainer = Instance.new("ScrollingFrame")
grabContainer.Size = UDim2.new(1, 0, 1, -10)
grabContainer.Position = UDim2.new(0, 0, 0, 10)
grabContainer.BackgroundTransparency = 1
grabContainer.ScrollBarThickness = 5
grabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
grabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
grabContainer.Parent = grabTab

local grabList = Instance.new("UIListLayout")
grabList.Parent = grabContainer
grabList.Padding = UDim.new(0, 4)
grabList.SortOrder = Enum.SortOrder.LayoutOrder

local function updateGrabItems()
    for _, child in pairs(grabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local loot = workspace:FindFirstChild("Loot")
    if not loot then return end

    for _, item in pairs(loot:GetChildren()) do
        local part = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart")
        if part then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Text = "Teleport to " .. item.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 12
            btn.BorderSizePixel = 0
            btn.Parent = grabContainer
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

            btn.MouseButton1Click:Connect(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp and part then
                    hrp.CFrame = part.CFrame * CFrame.new(0, 2, 0)
                end
            end)
        end
    end
end

grabBtn.MouseButton1Click:Connect(function()
    updateGrabItems()
end)

-- ==================== MISC ====================
-- Kill All
local killAllActive = false
local killAllConnection = nil

local killAllBtn = Instance.new("TextButton")
killAllBtn.Size = UDim2.new(1, 0, 0, 32)
killAllBtn.Text = "Kill All OFF"
killAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
killAllBtn.Font = Enum.Font.SourceSansBold
killAllBtn.TextSize = 14
killAllBtn.BorderSizePixel = 0
killAllBtn.Parent = miscTab
Instance.new("UICorner", killAllBtn).CornerRadius = UDim.new(0, 4)

local killAllOneBtn = Instance.new("TextButton")
killAllOneBtn.Size = UDim2.new(1, 0, 0, 32)
killAllOneBtn.Text = "Kill All - One"
killAllOneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killAllOneBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
killAllOneBtn.Font = Enum.Font.SourceSansBold
killAllOneBtn.TextSize = 14
killAllOneBtn.BorderSizePixel = 0
killAllOneBtn.Parent = miscTab
Instance.new("UICorner", killAllOneBtn).CornerRadius = UDim.new(0, 4)

-- Explode All - One (перемещён из Exploit)
local explodeAllOneBtn = Instance.new("TextButton")
explodeAllOneBtn.Size = UDim2.new(1, 0, 0, 32)
explodeAllOneBtn.Text = "Explode All - One"
explodeAllOneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
explodeAllOneBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
explodeAllOneBtn.Font = Enum.Font.SourceSansBold
explodeAllOneBtn.TextSize = 14
explodeAllOneBtn.BorderSizePixel = 0
explodeAllOneBtn.Parent = miscTab
Instance.new("UICorner", explodeAllOneBtn).CornerRadius = UDim.new(0, 4)

local function killAllNPCs()
    if not NPCs then return end
    for _, npc in pairs(NPCs:GetChildren()) do
        local humanoid = npc:FindFirstChild("Humanoid")
        if humanoid then
            pcall(function()
                Event:FireServer("NPCs", "Damage", humanoid, 100)
            end)
        end
    end
end

local function explodeNPCs()
    if not NPCs then return end
    for _, npc in pairs(NPCs:GetChildren()) do
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                Event:FireServer("Explosions", "Exploded", hrp.Position)
            end)
        end
    end
end

killAllBtn.MouseButton1Click:Connect(function()
    killAllActive = not killAllActive

    if killAllActive then
        killAllBtn.Text = "Kill All ON"
        killAllBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        killAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        killAllConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not killAllActive then
                killAllConnection:Disconnect()
                killAllConnection = nil
                return
            end
            killAllNPCs()
        end)
    else
        killAllBtn.Text = "Kill All OFF"
        killAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        killAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if killAllConnection then
            killAllConnection:Disconnect()
            killAllConnection = nil
        end
    end
end)

killAllOneBtn.MouseButton1Click:Connect(function()
    killAllNPCs()
end)

explodeAllOneBtn.MouseButton1Click:Connect(function()
    explodeNPCs()
end)

-- Get Safes
local safesActive = false
local safesConnection = nil

local safesBtn = Instance.new("TextButton")
safesBtn.Size = UDim2.new(1, 0, 0, 32)
safesBtn.Text = "Get Safes OFF"
safesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
safesBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
safesBtn.Font = Enum.Font.SourceSansBold
safesBtn.TextSize = 14
safesBtn.BorderSizePixel = 0
safesBtn.Parent = miscTab
Instance.new("UICorner", safesBtn).CornerRadius = UDim.new(0, 4)

local function findSafes()
    local safes = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return safes end

    local descendants = map:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "Safe" then
            table.insert(safes, obj)
        end
    end
    return safes
end

local function damageSafes()
    local safes = findSafes()
    for _, safe in pairs(safes) do
        pcall(function()
            Event:FireServer("DamageToOpen", "Damage", safe, 1000, "melee")
        end)
    end
end

safesBtn.MouseButton1Click:Connect(function()
    safesActive = not safesActive

    if safesActive then
        safesBtn.Text = "Get Safes ON"
        safesBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        safesBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        safesConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not safesActive then
                safesConnection:Disconnect()
                safesConnection = nil
                return
            end
            damageSafes()
        end)
    else
        safesBtn.Text = "Get Safes OFF"
        safesBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        safesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if safesConnection then
            safesConnection:Disconnect()
            safesConnection = nil
        end
    end
end)

-- Explode All (в Misc)
local explodeAllMiscActive = false
local explodeAllMiscConnection = nil

local explodeAllBtn = Instance.new("TextButton")
explodeAllBtn.Size = UDim2.new(1, 0, 0, 32)
explodeAllBtn.Text = "Explode All OFF"
explodeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
explodeAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
explodeAllBtn.Font = Enum.Font.SourceSansBold
explodeAllBtn.TextSize = 14
explodeAllBtn.BorderSizePixel = 0
explodeAllBtn.Parent = miscTab
Instance.new("UICorner", explodeAllBtn).CornerRadius = UDim.new(0, 4)

local function explodeAllNPCs()
    if not NPCs then return end
    for _, npc in pairs(NPCs:GetChildren()) do
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                Event:FireServer("Explosions", "Exploded", hrp.Position)
            end)
        end
    end
end

explodeAllBtn.MouseButton1Click:Connect(function()
    explodeAllMiscActive = not explodeAllMiscActive

    if explodeAllMiscActive then
        explodeAllBtn.Text = "Explode All ON"
        explodeAllBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        explodeAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        explodeAllMiscConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not explodeAllMiscActive then
                explodeAllMiscConnection:Disconnect()
                explodeAllMiscConnection = nil
                return
            end
            explodeAllNPCs()
        end)
    else
        explodeAllBtn.Text = "Explode All OFF"
        explodeAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        explodeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if explodeAllMiscConnection then
            explodeAllMiscConnection:Disconnect()
            explodeAllMiscConnection = nil
        end
    end
end)

-- Get ATM
local atmActive = false
local atmConnection = nil

local atmBtn = Instance.new("TextButton")
atmBtn.Size = UDim2.new(1, 0, 0, 32)
atmBtn.Text = "Get ATM OFF"
atmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
atmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
atmBtn.Font = Enum.Font.SourceSansBold
atmBtn.TextSize = 14
atmBtn.BorderSizePixel = 0
atmBtn.Parent = miscTab
Instance.new("UICorner", atmBtn).CornerRadius = UDim.new(0, 4)

local function findATMs()
    local atms = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return atms end

    local descendants = map:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "ATM" then
            table.insert(atms, obj)
        end
    end
    return atms
end

local function damageATMs()
    local atms = findATMs()
    for _, atm in pairs(atms) do
        pcall(function()
            Event:FireServer("DamageToOpen", "Damage", atm, 10000, "melee")
        end)
    end
end

atmBtn.MouseButton1Click:Connect(function()
    atmActive = not atmActive

    if atmActive then
        atmBtn.Text = "Get ATM ON"
        atmBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        atmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        atmConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not atmActive then
                atmConnection:Disconnect()
                atmConnection = nil
                return
            end
            damageATMs()
        end)
    else
        atmBtn.Text = "Get ATM OFF"
        atmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        atmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if atmConnection then
            atmConnection:Disconnect()
            atmConnection = nil
        end
    end
end)

-- Get Trash (GarbageCan)
local trashActive = false
local trashConnection = nil

local trashBtn = Instance.new("TextButton")
trashBtn.Size = UDim2.new(1, 0, 0, 32)
trashBtn.Text = "Get Trash OFF"
trashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
trashBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
trashBtn.Font = Enum.Font.SourceSansBold
trashBtn.TextSize = 14
trashBtn.BorderSizePixel = 0
trashBtn.Parent = miscTab
Instance.new("UICorner", trashBtn).CornerRadius = UDim.new(0, 4)

local function findTrash()
    local trashCans = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return trashCans end

    local descendants = map:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "GarbageCan" then
            table.insert(trashCans, obj)
        end
    end
    return trashCans
end

local function damageTrash()
    local trashCans = findTrash()
    for _, can in pairs(trashCans) do
        pcall(function()
            Event:FireServer("DamageToOpen", "Damage", can, 1000, "melee")
        end)
    end
end

trashBtn.MouseButton1Click:Connect(function()
    trashActive = not trashActive

    if trashActive then
        trashBtn.Text = "Get Trash ON"
        trashBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        trashBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        trashConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not trashActive then
                trashConnection:Disconnect()
                trashConnection = nil
                return
            end
            damageTrash()
        end)
    else
        trashBtn.Text = "Get Trash OFF"
        trashBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        trashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if trashConnection then
            trashConnection:Disconnect()
            trashConnection = nil
        end
    end
end)

-- Get Dumpster
local dumpsterActive = false
local dumpsterConnection = nil

local dumpsterBtn = Instance.new("TextButton")
dumpsterBtn.Size = UDim2.new(1, 0, 0, 32)
dumpsterBtn.Text = "Get Dumpster OFF"
dumpsterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dumpsterBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
dumpsterBtn.Font = Enum.Font.SourceSansBold
dumpsterBtn.TextSize = 14
dumpsterBtn.BorderSizePixel = 0
dumpsterBtn.Parent = miscTab
Instance.new("UICorner", dumpsterBtn).CornerRadius = UDim.new(0, 4)

local function findDumpsters()
    local dumpsters = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return dumpsters end

    local descendants = map:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "Dumpster" then
            table.insert(dumpsters, obj)
        end
    end
    return dumpsters
end

local function damageDumpsters()
    local dumpsters = findDumpsters()
    for _, dumpster in pairs(dumpsters) do
        pcall(function()
            Event:FireServer("DamageToOpen", "Damage", dumpster, 10000, "melee")
        end)
    end
end

dumpsterBtn.MouseButton1Click:Connect(function()
    dumpsterActive = not dumpsterActive

    if dumpsterActive then
        dumpsterBtn.Text = "Get Dumpster ON"
        dumpsterBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        dumpsterBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        dumpsterConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not dumpsterActive then
                dumpsterConnection:Disconnect()
                dumpsterConnection = nil
                return
            end
            damageDumpsters()
        end)
    else
        dumpsterBtn.Text = "Get Dumpster OFF"
        dumpsterBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        dumpsterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if dumpsterConnection then
            dumpsterConnection:Disconnect()
            dumpsterConnection = nil
        end
    end
end)

-- Get CashRegister
local cashRegActive = false
local cashRegConnection = nil

local cashRegBtn = Instance.new("TextButton")
cashRegBtn.Size = UDim2.new(1, 0, 0, 32)
cashRegBtn.Text = "Get CashRegister OFF"
cashRegBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cashRegBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
cashRegBtn.Font = Enum.Font.SourceSansBold
cashRegBtn.TextSize = 14
cashRegBtn.BorderSizePixel = 0
cashRegBtn.Parent = miscTab
Instance.new("UICorner", cashRegBtn).CornerRadius = UDim.new(0, 4)

local function findCashRegisters()
    local registers = {}
    local map = workspace:FindFirstChild("Map")
    if not map then return registers end

    local descendants = map:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "CashRegister" then
            table.insert(registers, obj)
        end
    end
    return registers
end

local function damageCashRegisters()
    local registers = findCashRegisters()
    for _, reg in pairs(registers) do
        pcall(function()
            Event:FireServer("DamageToOpen", "Damage", reg, 10000, "melee")
        end)
    end
end

cashRegBtn.MouseButton1Click:Connect(function()
    cashRegActive = not cashRegActive

    if cashRegActive then
        cashRegBtn.Text = "Get CashRegister ON"
        cashRegBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        cashRegBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        cashRegConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not cashRegActive then
                cashRegConnection:Disconnect()
                cashRegConnection = nil
                return
            end
            damageCashRegisters()
        end)
    else
        cashRegBtn.Text = "Get CashRegister OFF"
        cashRegBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        cashRegBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if cashRegConnection then
            cashRegConnection:Disconnect()
            cashRegConnection = nil
        end
    end
end)

-- Kill Aura
local killAuraActive = false
local killAuraConnection = nil

local killAuraBtn = Instance.new("TextButton")
killAuraBtn.Size = UDim2.new(1, 0, 0, 32)
killAuraBtn.Text = "Kill Aura OFF"
killAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killAuraBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
killAuraBtn.Font = Enum.Font.SourceSansBold
killAuraBtn.TextSize = 14
killAuraBtn.BorderSizePixel = 0
killAuraBtn.Parent = miscTab
Instance.new("UICorner", killAuraBtn).CornerRadius = UDim.new(0, 4)

local function killAuraLoop()
    if not NPCs then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, npc in pairs(NPCs:GetChildren()) do
        local npcHrp = npc:FindFirstChild("HumanoidRootPart")
        if npcHrp then
            local dist = (npcHrp.Position - hrp.Position).Magnitude
            if dist <= 50 then
                local humanoid = npc:FindFirstChild("Humanoid")
                if humanoid then
                    pcall(function()
                        Event:FireServer("NPCs", "Damage", humanoid, 100)
                    end)
                end
            end
        end
    end
end

killAuraBtn.MouseButton1Click:Connect(function()
    killAuraActive = not killAuraActive

    if killAuraActive then
        killAuraBtn.Text = "Kill Aura ON"
        killAuraBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        killAuraBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        killAuraConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not killAuraActive then
                killAuraConnection:Disconnect()
                killAuraConnection = nil
                return
            end
            killAuraLoop()
        end)
    else
        killAuraBtn.Text = "Kill Aura OFF"
        killAuraBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        killAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if killAuraConnection then
            killAuraConnection:Disconnect()
            killAuraConnection = nil
        end
    end
end)

-- Auto Cash
local autoCashActive = false
local autoCashConnection = nil

local autoCashBtn = Instance.new("TextButton")
autoCashBtn.Size = UDim2.new(1, 0, 0, 32)
autoCashBtn.Text = "Auto Cash OFF"
autoCashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoCashBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
autoCashBtn.Font = Enum.Font.SourceSansBold
autoCashBtn.TextSize = 14
autoCashBtn.BorderSizePixel = 0
autoCashBtn.Parent = miscTab
Instance.new("UICorner", autoCashBtn).CornerRadius = UDim.new(0, 4)

local function findCashObjects()
    local cashObjects = {}
    local cashFolder = workspace:FindFirstChild("Cash")
    if not cashFolder then return cashObjects end

    local descendants = cashFolder:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj.Name == "TouchSensor" then
            local touchInterest = obj:FindFirstChild("TouchInterest")
            if touchInterest then
                local parent = obj.Parent
                local moneyPart = nil
                if parent then
                    if parent:IsA("BasePart") then
                        moneyPart = parent
                    else
                        for _, child in pairs(parent:GetChildren()) do
                            if child:IsA("BasePart") then
                                moneyPart = child
                                break
                            end
                        end
                    end
                end
                if moneyPart then
                    table.insert(cashObjects, {
                        TouchInterest = touchInterest,
                        MoneyPart = moneyPart,
                        TouchSensor = obj
                    })
                end
            end
        end
    end
    return cashObjects
end

local function collectCash()
    local cashObjects = findCashObjects()
    if #cashObjects == 0 then return end

    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, data in pairs(cashObjects) do
        local touchInterest = data.TouchInterest
        local moneyPart = data.MoneyPart
        
        if moneyPart and moneyPart:IsA("BasePart") then
            local targetCFrame = moneyPart.CFrame * CFrame.new(0, 0, 2)
            hrp.CFrame = targetCFrame
            task.wait(0.1)
            for i = 1, 3 do
                pcall(function()
                    touchInterest:FireTouchInterest(hrp)
                end)
                task.wait(0.05)
            end
            task.wait(0.1)
        end
    end
end

autoCashBtn.MouseButton1Click:Connect(function()
    autoCashActive = not autoCashActive

    if autoCashActive then
        autoCashBtn.Text = "Auto Cash ON"
        autoCashBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        autoCashBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        autoCashConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not autoCashActive then
                autoCashConnection:Disconnect()
                autoCashConnection = nil
                return
            end
            collectCash()
        end)
    else
        autoCashBtn.Text = "Auto Cash OFF"
        autoCashBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        autoCashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if autoCashConnection then
            autoCashConnection:Disconnect()
            autoCashConnection = nil
        end
    end
end)

-- ==================== PLAYER ====================
local playerSpeedActive = false
local playerSpeedLoop = nil
local originalSpeed = nil

-- Поле для скорости
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Text = "Speed:"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.BackgroundTransparency = 1
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = playerTab

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(1, 0, 0, 25)
speedInput.PlaceholderText = "Enter speed..."
speedInput.Text = "20"
speedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 14
speedInput.Parent = playerTab
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 4)

-- Кнопка Start Speed
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, 0, 0, 32)
speedBtn.Text = "Start Speed OFF"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
speedBtn.BorderSizePixel = 0
speedBtn.Parent = playerTab
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 4)

-- Разделитель
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 2)
separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
separator.BorderSizePixel = 0
separator.Parent = playerTab

-- Поле для ника игрока
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 20)
nameLabel.Text = "Player Name:"
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.TextSize = 14
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.BackgroundTransparency = 1
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = playerTab

local nameInput = Instance.new("TextBox")
nameInput.Size = UDim2.new(1, 0, 0, 25)
nameInput.PlaceholderText = "Enter name..."
nameInput.Text = ""
nameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
nameInput.TextColor3 = Color3.new(1, 1, 1)
nameInput.Font = Enum.Font.SourceSans
nameInput.TextSize = 14
nameInput.Parent = playerTab
Instance.new("UICorner", nameInput).CornerRadius = UDim.new(0, 4)

-- Кнопка Teleport
local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(1, 0, 0, 32)
teleportBtn.Text = "Teleport"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
teleportBtn.Font = Enum.Font.SourceSansBold
teleportBtn.TextSize = 14
teleportBtn.BorderSizePixel = 0
teleportBtn.Parent = playerTab
Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 4)

-- Логика скорости
speedBtn.MouseButton1Click:Connect(function()
    playerSpeedActive = not playerSpeedActive

    if playerSpeedActive then
        speedBtn.Text = "Start Speed ON"
        speedBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        speedBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                originalSpeed = humanoid.WalkSpeed
            end
        end
        if not originalSpeed then
            originalSpeed = 16
        end

        playerSpeedLoop = task.spawn(function()
            while playerSpeedActive do
                local speedValue = tonumber(speedInput.Text)
                if not speedValue or speedValue < 0 then
                    speedValue = 16
                end
                local char = LocalPlayer.Character
                if char then
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = speedValue
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        speedBtn.Text = "Start Speed OFF"
        speedBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        playerSpeedActive = false
        if playerSpeedLoop then
            coroutine.close(playerSpeedLoop)
            playerSpeedLoop = nil
        end

        if originalSpeed then
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = originalSpeed
                end
            end
            originalSpeed = nil
        end
    end
end)

-- Логика телепортации
teleportBtn.MouseButton1Click:Connect(function()
    local name = nameInput.Text
    if name == "" then return end

    local targetPlayer = nil
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= LocalPlayer then
            local lowerName = string.lower(player.Name)
            local lowerDisplay = string.lower(player.DisplayName or "")
            local lowerInput = string.lower(name)
            if string.sub(lowerName, 1, #lowerInput) == lowerInput or
               string.sub(lowerDisplay, 1, #lowerInput) == lowerInput then
                targetPlayer = player
                break
            end
        end
    end

    if targetPlayer and targetPlayer.Character then
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP and localHRP then
            localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
        end
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
    killAllActive = false
    if killAllConnection then
        killAllConnection:Disconnect()
        killAllConnection = nil
    end
    espActive = false
    clearESP()
    safesActive = false
    if safesConnection then
        safesConnection:Disconnect()
        safesConnection = nil
    end
    explodeAllMiscActive = false
    if explodeAllMiscConnection then
        explodeAllMiscConnection:Disconnect()
        explodeAllMiscConnection = nil
    end
    atmActive = false
    if atmConnection then
        atmConnection:Disconnect()
        atmConnection = nil
    end
    trashActive = false
    if trashConnection then
        trashConnection:Disconnect()
        trashConnection = nil
    end
    dumpsterActive = false
    if dumpsterConnection then
        dumpsterConnection:Disconnect()
        dumpsterConnection = nil
    end
    cashRegActive = false
    if cashRegConnection then
        cashRegConnection:Disconnect()
        cashRegConnection = nil
    end
    killAuraActive = false
    if killAuraConnection then
        killAuraConnection:Disconnect()
        killAuraConnection = nil
    end
    autoCashActive = false
    if autoCashConnection then
        autoCashConnection:Disconnect()
        autoCashConnection = nil
    end
    playerSpeedActive = false
    if playerSpeedLoop then
        coroutine.close(playerSpeedLoop)
        playerSpeedLoop = nil
    end
    if originalSpeed then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = originalSpeed
            end
        end
    end
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)
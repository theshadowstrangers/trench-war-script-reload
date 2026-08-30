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

ScreenGui.Name = "Cart-Rider"
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
TitleLabel.Text = " Pozzy-cart"
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
local toolsBtn, toolsTab = createTab("Tools", "Tools")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Cart-Rider\nBy Spynote\nCreate in 2026 year\nalltabs Exploit, Tools"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== WIN MESSAGE (ПРИ ЗАПУСКЕ) ====================
pcall(function()
    local winEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Honeypot")
    if winEvent then
        winEvent = winEvent:FindFirstChild("Internal")
        if winEvent then
            winEvent = winEvent:FindFirstChild("RemoteStorage")
            if winEvent then
                local remote = winEvent:FindFirstChild("WinMessage - RemoteEvent")
                if remote then
                    firesignal(remote.OnClientEvent, "Hello i have message for you, Thanks for Using my scrip, I very Happy Lol) Ok bye Script Kiddie LLL")
                end
            end
        end
    end
end)

-- ==================== EXPLOIT ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== CART-SPAWNER-ALL (SPAM) ====================
local isCartSpawnerAll = false
local cartSpawnerAllConnection = nil

local function startCartSpawnerAll()
    if cartSpawnerAllConnection then
        cartSpawnerAllConnection:Disconnect()
        cartSpawnerAllConnection = nil
    end

    cartSpawnerAllConnection = RunService.Heartbeat:Connect(function()
        if not isCartSpawnerAll then
            cartSpawnerAllConnection:Disconnect()
            cartSpawnerAllConnection = nil
            return
        end

        for i = 1, 30 do
            local child = workspace:GetChildren()[i]
            if child then
                local button = child:FindFirstChild("Button")
                if button then
                    local clickDetector = button:FindFirstChild("ClickDetector")
                    if clickDetector then
                        for j = 1, 10 do
                            pcall(function()
                                fireclickdetector(clickDetector)
                            end)
                        end
                    end
                end
            end
        end
    end)
end

local cartSpawnerAllBtn = Instance.new("TextButton")
cartSpawnerAllBtn.Size = UDim2.new(1, 0, 0, 32)
cartSpawnerAllBtn.Text = "Cart-spawner-all OFF"
cartSpawnerAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
cartSpawnerAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
cartSpawnerAllBtn.Font = Enum.Font.SourceSansBold
cartSpawnerAllBtn.TextSize = 13
cartSpawnerAllBtn.BorderSizePixel = 0
cartSpawnerAllBtn.Parent = exploitTab
Instance.new("UICorner", cartSpawnerAllBtn).CornerRadius = UDim.new(0, 4)

cartSpawnerAllBtn.MouseButton1Click:Connect(function()
    isCartSpawnerAll = not isCartSpawnerAll
    if isCartSpawnerAll then
        cartSpawnerAllBtn.Text = "Cart-spawner-all ON"
        cartSpawnerAllBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        cartSpawnerAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startCartSpawnerAll()
    else
        cartSpawnerAllBtn.Text = "Cart-spawner-all OFF"
        cartSpawnerAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        cartSpawnerAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if cartSpawnerAllConnection then
            cartSpawnerAllConnection:Disconnect()
            cartSpawnerAllConnection = nil
        end
    end
end)

-- ==================== CART-ALL-SPAWNED (ONE TIME) ====================
local function cartAllSpawnedOnce()
    for i = 1, 30 do
        local child = workspace:GetChildren()[i]
        if child then
            local button = child:FindFirstChild("Button")
            if button then
                local clickDetector = button:FindFirstChild("ClickDetector")
                if clickDetector then
                    pcall(function()
                        fireclickdetector(clickDetector)
                    end)
                end
            end
        end
    end
end

local cartAllSpawnedBtn = Instance.new("TextButton")
cartAllSpawnedBtn.Size = UDim2.new(1, 0, 0, 32)
cartAllSpawnedBtn.Text = "Cart-all-spawned"
cartAllSpawnedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cartAllSpawnedBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
cartAllSpawnedBtn.Font = Enum.Font.SourceSansBold
cartAllSpawnedBtn.TextSize = 13
cartAllSpawnedBtn.BorderSizePixel = 0
cartAllSpawnedBtn.Parent = exploitTab
Instance.new("UICorner", cartAllSpawnedBtn).CornerRadius = UDim.new(0, 4)

cartAllSpawnedBtn.MouseButton1Click:Connect(function()
    cartAllSpawnedOnce()
end)

-- ==================== ALL CART START (SPAM) ====================
local isAllCartStart = false
local allCartStartConnection = nil

local function startAllCartStart()
    if allCartStartConnection then
        allCartStartConnection:Disconnect()
        allCartStartConnection = nil
    end

    allCartStartConnection = RunService.Heartbeat:Connect(function()
        if not isAllCartStart then
            allCartStartConnection:Disconnect()
            allCartStartConnection = nil
            return
        end

        local activeCarts = workspace:FindFirstChild("ActiveCarts")
        if not activeCarts then return end

        for _, cart in pairs(activeCarts:GetChildren()) do
            if cart:IsA("Model") then
                local buttons = cart:FindFirstChild("Buttons")
                if buttons then
                    local startButton = buttons:FindFirstChild("Start")
                    if startButton then
                        local clickDetector = startButton:FindFirstChild("ClickDetector")
                        if clickDetector then
                            for i = 1, 10 do
                                pcall(function()
                                    fireclickdetector(clickDetector)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local allCartStartBtn = Instance.new("TextButton")
allCartStartBtn.Size = UDim2.new(1, 0, 0, 32)
allCartStartBtn.Text = "All Cart Start OFF"
allCartStartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
allCartStartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
allCartStartBtn.Font = Enum.Font.SourceSansBold
allCartStartBtn.TextSize = 13
allCartStartBtn.BorderSizePixel = 0
allCartStartBtn.Parent = exploitTab
Instance.new("UICorner", allCartStartBtn).CornerRadius = UDim.new(0, 4)

allCartStartBtn.MouseButton1Click:Connect(function()
    isAllCartStart = not isAllCartStart
    if isAllCartStart then
        allCartStartBtn.Text = "All Cart Start ON"
        allCartStartBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        allCartStartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startAllCartStart()
    else
        allCartStartBtn.Text = "All Cart Start OFF"
        allCartStartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        allCartStartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if allCartStartConnection then
            allCartStartConnection:Disconnect()
            allCartStartConnection = nil
        end
    end
end)

-- ==================== START-CART-ALL-ONE (ONE TIME) ====================
local function startCartAllOne()
    local activeCarts = workspace:FindFirstChild("ActiveCarts")
    if not activeCarts then return end

    for _, cart in pairs(activeCarts:GetChildren()) do
        if cart:IsA("Model") then
            local buttons = cart:FindFirstChild("Buttons")
            if buttons then
                local startButton = buttons:FindFirstChild("Start")
                if startButton then
                    local clickDetector = startButton:FindFirstChild("ClickDetector")
                    if clickDetector then
                        pcall(function()
                            fireclickdetector(clickDetector)
                        end)
                    end
                end
            end
        end
    end
end

local startCartAllOneBtn = Instance.new("TextButton")
startCartAllOneBtn.Size = UDim2.new(1, 0, 0, 32)
startCartAllOneBtn.Text = "Start-cart-all-one"
startCartAllOneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startCartAllOneBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
startCartAllOneBtn.Font = Enum.Font.SourceSansBold
startCartAllOneBtn.TextSize = 13
startCartAllOneBtn.BorderSizePixel = 0
startCartAllOneBtn.Parent = exploitTab
Instance.new("UICorner", startCartAllOneBtn).CornerRadius = UDim.new(0, 4)

startCartAllOneBtn.MouseButton1Click:Connect(function()
    startCartAllOne()
end)

-- ==================== ALL-ACTIVECARTS-DOWN (SPAM) ====================
local isAllCartsDown = false
local allCartsDownConnection = nil

local function startAllCartsDown()
    if allCartsDownConnection then
        allCartsDownConnection:Disconnect()
        allCartsDownConnection = nil
    end

    allCartsDownConnection = RunService.Heartbeat:Connect(function()
        if not isAllCartsDown then
            allCartsDownConnection:Disconnect()
            allCartsDownConnection = nil
            return
        end

        local activeCarts = workspace:FindFirstChild("ActiveCarts")
        if not activeCarts then return end

        for _, cart in pairs(activeCarts:GetChildren()) do
            if cart:IsA("Model") then
                local buttons = cart:FindFirstChild("Buttons")
                if buttons then
                    local downButton = buttons:FindFirstChild("Down")
                    if downButton then
                        local clickDetector = downButton:FindFirstChild("ClickDetector")
                        if clickDetector then
                            for i = 1, 10 do
                                pcall(function()
                                    fireclickdetector(clickDetector)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local allCartsDownBtn = Instance.new("TextButton")
allCartsDownBtn.Size = UDim2.new(1, 0, 0, 32)
allCartsDownBtn.Text = "All-ActiveCarts-Down OFF"
allCartsDownBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
allCartsDownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
allCartsDownBtn.Font = Enum.Font.SourceSansBold
allCartsDownBtn.TextSize = 13
allCartsDownBtn.BorderSizePixel = 0
allCartsDownBtn.Parent = exploitTab
Instance.new("UICorner", allCartsDownBtn).CornerRadius = UDim.new(0, 4)

allCartsDownBtn.MouseButton1Click:Connect(function()
    isAllCartsDown = not isAllCartsDown
    if isAllCartsDown then
        allCartsDownBtn.Text = "All-ActiveCarts-Down ON"
        allCartsDownBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        allCartsDownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startAllCartsDown()
    else
        allCartsDownBtn.Text = "All-ActiveCarts-Down OFF"
        allCartsDownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        allCartsDownBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if allCartsDownConnection then
            allCartsDownConnection:Disconnect()
            allCartsDownConnection = nil
        end
    end
end)

-- ==================== ALL-ACTIVECARTS-START (SPAM) ====================
local isActiveCartsStart = false
local activeCartsStartConnection = nil

local function startActiveCartsStart()
    if activeCartsStartConnection then
        activeCartsStartConnection:Disconnect()
        activeCartsStartConnection = nil
    end

    activeCartsStartConnection = RunService.Heartbeat:Connect(function()
        if not isActiveCartsStart then
            activeCartsStartConnection:Disconnect()
            activeCartsStartConnection = nil
            return
        end

        local activeCarts = workspace:FindFirstChild("ActiveCarts")
        if not activeCarts then return end

        for _, cart in pairs(activeCarts:GetChildren()) do
            if cart:IsA("Model") then
                local buttons = cart:FindFirstChild("Buttons")
                if buttons then
                    local upButton = buttons:FindFirstChild("Up")
                    if upButton then
                        local clickDetector = upButton:FindFirstChild("ClickDetector")
                        if clickDetector then
                            for i = 1, 10 do
                                pcall(function()
                                    fireclickdetector(clickDetector)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local activeCartsStartBtn = Instance.new("TextButton")
activeCartsStartBtn.Size = UDim2.new(1, 0, 0, 32)
activeCartsStartBtn.Text = "All-ActiveCarts-Start OFF"
activeCartsStartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
activeCartsStartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
activeCartsStartBtn.Font = Enum.Font.SourceSansBold
activeCartsStartBtn.TextSize = 13
activeCartsStartBtn.BorderSizePixel = 0
activeCartsStartBtn.Parent = exploitTab
Instance.new("UICorner", activeCartsStartBtn).CornerRadius = UDim.new(0, 4)

activeCartsStartBtn.MouseButton1Click:Connect(function()
    isActiveCartsStart = not isActiveCartsStart
    if isActiveCartsStart then
        activeCartsStartBtn.Text = "All-ActiveCarts-Start ON"
        activeCartsStartBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        activeCartsStartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startActiveCartsStart()
    else
        activeCartsStartBtn.Text = "All-ActiveCarts-Start OFF"
        activeCartsStartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        activeCartsStartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if activeCartsStartConnection then
            activeCartsStartConnection:Disconnect()
            activeCartsStartConnection = nil
        end
    end
end)

-- ==================== TOOLS ====================
local function getTouchPart()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function fireTouchInterest(touchPart)
    local root = getTouchPart()
    if not root or not touchPart then return end
    
    pcall(function()
        firetouchinterest(root, touchPart, 0)
        task.wait(0.1)
        firetouchinterest(root, touchPart, 1)
    end)
end

-- HyperLaserGun
local hyperLaserBtn = Instance.new("TextButton")
hyperLaserBtn.Size = UDim2.new(1, 0, 0, 32)
hyperLaserBtn.Text = "HyperLaserGun"
hyperLaserBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hyperLaserBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
hyperLaserBtn.Font = Enum.Font.SourceSansBold
hyperLaserBtn.TextSize = 13
hyperLaserBtn.BorderSizePixel = 0
hyperLaserBtn.Parent = toolsTab
Instance.new("UICorner", hyperLaserBtn).CornerRadius = UDim.new(0, 4)

hyperLaserBtn.MouseButton1Click:Connect(function()
    local gamepasses = workspace:FindFirstChild("Gamepasses")
    if not gamepasses then return end
    local endHolder = gamepasses:FindFirstChild("EndHolder")
    if not endHolder then return end
    local gun = endHolder:FindFirstChild("HyperlaserGun")
    if not gun then return end
    local touchPart = gun:FindFirstChild("TouchPart")
    if not touchPart then return end
    fireTouchInterest(touchPart)
end)

-- Rainbow Carpet (MagicCarpet)
local carpetBtn = Instance.new("TextButton")
carpetBtn.Size = UDim2.new(1, 0, 0, 32)
carpetBtn.Text = "Rainbow Carpet"
carpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
carpetBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 200)
carpetBtn.Font = Enum.Font.SourceSansBold
carpetBtn.TextSize = 13
carpetBtn.BorderSizePixel = 0
carpetBtn.Parent = toolsTab
Instance.new("UICorner", carpetBtn).CornerRadius = UDim.new(0, 4)

carpetBtn.MouseButton1Click:Connect(function()
    local gamepasses = workspace:FindFirstChild("Gamepasses")
    if not gamepasses then return end
    local endHolder = gamepasses:FindFirstChild("EndHolder")
    if not endHolder then return end
    local carpet = endHolder:FindFirstChild("MagicCarpet")
    if not carpet then return end
    local touchPart = carpet:FindFirstChild("TouchPart")
    if not touchPart then return end
    fireTouchInterest(touchPart)
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
    isCartSpawnerAll = false
    isAllCartStart = false
    isAllCartsDown = false
    isActiveCartsStart = false
    
    if cartSpawnerAllConnection then
        cartSpawnerAllConnection:Disconnect()
        cartSpawnerAllConnection = nil
    end
    if allCartStartConnection then
        allCartStartConnection:Disconnect()
        allCartStartConnection = nil
    end
    if allCartsDownConnection then
        allCartsDownConnection:Disconnect()
        allCartsDownConnection = nil
    end
    if activeCartsStartConnection then
        activeCartsStartConnection:Disconnect()
        activeCartsStartConnection = nil
    end
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

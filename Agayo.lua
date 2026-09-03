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

ScreenGui.Name = "Agayo-sploit"
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
TitleLabel.Text = " Agayo-sploit"
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
local miscBtn, miscTab = createTab("Misc", "Misc")
local settingsBtn, settingsTab = createTab("Settings", "Settings")
local trollBtn, trollTab = createTab("Troll", "Troll")
local twoKBtn, twoKTab = createTab("2Kshoter", "2Kshoter")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Tools Agayo\n\n[Exploit] - Spam events around you\n[Misc] - All spam ON/OFF\n[Settings] - Set radius for spam\n[Troll] - Target specific player"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 16
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Настройки радиуса (по умолчанию 100)
local settingsRadius = 100
local horizontalMode = false -- Режим горизонтального спама

-- Таблица активных спамеров
local activeSpammers = {}
local events = {}

-- Функция для генерации случайного вектора в радиусе от игрока
local function getRandomPosition(radius)
    local char = LocalPlayer.Character
    if not char then return Vector3.new(0,0,0) end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return Vector3.new(0,0,0) end
    local origin = hrp.Position
    
    if horizontalMode then
        -- Горизонтальный режим: только по X и Z, Y = 0
        local theta = math.random() * 2 * math.pi
        local r = math.random() * radius
        local dx = r * math.cos(theta)
        local dz = r * math.sin(theta)
        return origin + Vector3.new(dx, 0, dz)
    else
        -- Обычный режим: во все стороны (сфера)
        local theta = math.random() * 2 * math.pi
        local phi = math.acos(2 * math.random() - 1)
        local r = math.random() * radius
        local dx = r * math.sin(phi) * math.cos(theta)
        local dy = r * math.sin(phi) * math.sin(theta)
        local dz = r * math.cos(phi)
        return origin + Vector3.new(dx, dy, dz)
    end
end

-- Функция для генерации позиции вокруг конкретного игрока
local function getTargetPosition(targetPlayer, radius)
    if not targetPlayer or not targetPlayer.Character then return Vector3.new(0,0,0) end
    local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return Vector3.new(0,0,0) end
    local origin = hrp.Position
    
    if horizontalMode then
        -- Горизонтальный режим: только по X и Z, Y = 0
        local theta = math.random() * 2 * math.pi
        local r = math.random() * radius
        local dx = r * math.cos(theta)
        local dz = r * math.sin(theta)
        return origin + Vector3.new(dx, 0, dz)
    else
        -- Обычный режим: во все стороны (сфера)
        local theta = math.random() * 2 * math.pi
        local phi = math.acos(2 * math.random() - 1)
        local r = math.random() * radius
        local dx = r * math.sin(phi) * math.cos(theta)
        local dy = r * math.sin(phi) * math.sin(theta)
        local dz = r * math.cos(phi)
        return origin + Vector3.new(dx, dy, dz)
    end
end

-- Основной цикл спама
local spamConnection = nil
local targetPlayer = nil
local isTargeting = false

local function startSpamLoop()
    if spamConnection then return end
    spamConnection = RunService.Heartbeat:Connect(function()
        for eventKey, active in pairs(activeSpammers) do
            if active then
                local eventFunc = events[eventKey]
                if eventFunc then
                    local ev = eventFunc()
                    if ev then
                        local pos
                        if isTargeting and targetPlayer then
                            pos = getTargetPosition(targetPlayer, settingsRadius)
                        else
                            pos = getRandomPosition(settingsRadius)
                        end
                        pcall(function()
                            ev:FireServer(pos)
                        end)
                    end
                end
            end
        end
    end)
end

local function stopSpamLoop()
    if spamConnection then
        spamConnection:Disconnect()
        spamConnection = nil
    end
end

-- Добавляем евенты
local eventConfigs = {
    {
        key = "!ansnns",
        label = "!ansnns",
        getEvent = function()
            return game:GetService("ReplicatedStorage")["!ansnns"]
        end
    },
    {
        key = "SVDDR22",
        label = "SVDDR22",
        getEvent = function()
            return game:GetService("ReplicatedStorage").SVDDR22
        end
    },
    {
        key = "SpikeLog",
        label = "Spike Log",
        getEvent = function()
            local char = LocalPlayer.Character
            if not char then return nil end
            local spike = char:FindFirstChild("Spike Log")
            if not spike then return nil end
            return spike:FindFirstChild("LogEvent")
        end
    },
    {
        key = "TrashBag",
        label = "Trash Bag",
        getEvent = function()
            local char = LocalPlayer.Character
            if not char then return nil end
            local trash = char:FindFirstChild("Trash Bag")
            if not trash then return nil end
            return trash:FindFirstChild("ThrowEvent")
        end
    },
    {
        key = "1332mmm",
        label = "1332mmm",
        getEvent = function()
            return game:GetService("ReplicatedStorage")["1332mmm"]
        end
    },
    {
        key = "LegoBrick",
        label = "Lego Brick",
        getEvent = function()
            local char = LocalPlayer.Character
            if not char then return nil end
            local brick = char:FindFirstChild("Lego Brick")
            if not brick then return nil end
            return brick:FindFirstChild("ThrowEvent")
        end
    },
    {
        key = "Nuke",
        label = "Nuke",
        getEvent = function()
            local char = LocalPlayer.Character
            if not char then return nil end
            local nuke = char:FindFirstChild("Nuke")
            if not nuke then return nil end
            return nuke:FindFirstChild("NukeEvent")
        end
    },
    {
        key = "CarAirstrike",
        label = "Car Airstrike",
        getEvent = function()
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if not backpack then return nil end
            local car = backpack:FindFirstChild("CarAirstrike")
            if not car then return nil end
            return car:FindFirstChild("AirstrikeEvent")
        end
    },
    {
        key = "ThrowFish",
        label = "Throw Fish",
        getEvent = function()
            local char = LocalPlayer.Character
            if not char then return nil end
            local fish = char:FindFirstChild("Throw Fish")
            if not fish then return nil end
            return fish:FindFirstChild("FishEvent")
        end
    }
}

-- Сохраняем в таблицу events
for _, cfg in ipairs(eventConfigs) do
    events[cfg.key] = cfg.getEvent
    activeSpammers[cfg.key] = false
end

-- Создаем кнопки в Exploit
local exploitContainer = exploitTab
for _, cfg in ipairs(eventConfigs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Text = cfg.label .. " OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = exploitContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        local key = cfg.key
        activeSpammers[key] = not activeSpammers[key]
        if activeSpammers[key] then
            btn.Text = cfg.label .. " ON"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            btn.TextColor3 = Color3.fromRGB(0, 0, 0)
            startSpamLoop()
        else
            btn.Text = cfg.label .. " OFF"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            local anyActive = false
            for _, v in pairs(activeSpammers) do
                if v then anyActive = true; break end
            end
            if not anyActive then
                stopSpamLoop()
            end
        end
    end)
end

-- ==================== MISC ====================
local allSpamActive = false
local allSpamConnection = nil

local allSpamBtn = Instance.new("TextButton")
allSpamBtn.Size = UDim2.new(1, 0, 0, 32)
allSpamBtn.Text = "all-spam OFF"
allSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
allSpamBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
allSpamBtn.Font = Enum.Font.SourceSansBold
allSpamBtn.TextSize = 14
allSpamBtn.BorderSizePixel = 0
allSpamBtn.Parent = miscTab
Instance.new("UICorner", allSpamBtn).CornerRadius = UDim.new(0, 4)

-- Кнопка горизонтального режима
local cosBtn = Instance.new("TextButton")
cosBtn.Size = UDim2.new(1, 0, 0, 32)
cosBtn.Text = "cos OFF"
cosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cosBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
cosBtn.Font = Enum.Font.SourceSansBold
cosBtn.TextSize = 14
cosBtn.BorderSizePixel = 0
cosBtn.Parent = miscTab
Instance.new("UICorner", cosBtn).CornerRadius = UDim.new(0, 4)

local function spamAllEvents()
    for eventKey, active in pairs(activeSpammers) do
        if active then
            local eventFunc = events[eventKey]
            if eventFunc then
                local ev = eventFunc()
                if ev then
                    local pos
                    if isTargeting and targetPlayer then
                        pos = getTargetPosition(targetPlayer, settingsRadius)
                    else
                        pos = getRandomPosition(settingsRadius)
                    end
                    pcall(function()
                        ev:FireServer(pos)
                    end)
                end
            end
        end
    end
end

allSpamBtn.MouseButton1Click:Connect(function()
    allSpamActive = not allSpamActive
    
    if allSpamActive then
        allSpamBtn.Text = "all-spam ON"
        allSpamBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        allSpamBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        for key in pairs(activeSpammers) do
            activeSpammers[key] = true
        end
        
        for _, child in pairs(exploitContainer:GetChildren()) do
            if child:IsA("TextButton") then
                local label = child.Text:gsub(" OFF", ""):gsub(" ON", "")
                for _, cfg in ipairs(eventConfigs) do
                    if cfg.label == label then
                        child.Text = cfg.label .. " ON"
                        child.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                        child.TextColor3 = Color3.fromRGB(0, 0, 0)
                        break
                    end
                end
            end
        end
        
        startSpamLoop()
    else
        allSpamBtn.Text = "all-spam OFF"
        allSpamBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        allSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        for key in pairs(activeSpammers) do
            activeSpammers[key] = false
        end
        
        for _, child in pairs(exploitContainer:GetChildren()) do
            if child:IsA("TextButton") then
                local label = child.Text:gsub(" OFF", ""):gsub(" ON", "")
                for _, cfg in ipairs(eventConfigs) do
                    if cfg.label == label then
                        child.Text = cfg.label .. " OFF"
                        child.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                        child.TextColor3 = Color3.fromRGB(255, 255, 255)
                        break
                    end
                end
            end
        end
        
        stopSpamLoop()
    end
end)

cosBtn.MouseButton1Click:Connect(function()
    horizontalMode = not horizontalMode
    
    if horizontalMode then
        cosBtn.Text = "cos ON"
        cosBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        cosBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        cosBtn.Text = "cos OFF"
        cosBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        cosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- ==================== SETTINGS ====================
local settingsLabel = Instance.new("TextLabel")
settingsLabel.Size = UDim2.new(1, 0, 0, 25)
settingsLabel.Text = ""
settingsLabel.TextColor3 = Color3.new(1, 1, 1)
settingsLabel.TextSize = 16
settingsLabel.Font = Enum.Font.SourceSansBold
settingsLabel.BackgroundTransparency = 1
settingsLabel.TextXAlignment = Enum.TextXAlignment.Left
settingsLabel.Parent = settingsTab

local radiusInput = Instance.new("TextBox")
radiusInput.Size = UDim2.new(1, 0, 0, 30)
radiusInput.PlaceholderText = "100"
radiusInput.Text = "100"
radiusInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
radiusInput.TextColor3 = Color3.new(1, 1, 1)
radiusInput.Font = Enum.Font.SourceSans
radiusInput.TextSize = 16
radiusInput.Parent = settingsTab
Instance.new("UICorner", radiusInput).CornerRadius = UDim.new(0, 4)

local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(1, 0, 0, 32)
applyBtn.Text = "using studs"
applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
applyBtn.Font = Enum.Font.SourceSansBold
applyBtn.TextSize = 16
applyBtn.BorderSizePixel = 0
applyBtn.Parent = settingsTab
Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0, 4)

applyBtn.MouseButton1Click:Connect(function()
    local val = tonumber(radiusInput.Text)
    if val and val > 0 then
        settingsRadius = val
        radiusInput.Text = tostring(val)
    else
        radiusInput.Text = tostring(settingsRadius)
    end
end)

-- ==================== TROLL (ИСПРАВЛЕННЫЙ) ====================
local trollLabel = Instance.new("TextLabel")
trollLabel.Size = UDim2.new(1, 0, 0, 20)
trollLabel.Text = "Player Name:"
trollLabel.TextColor3 = Color3.new(1, 1, 1)
trollLabel.TextSize = 14
trollLabel.Font = Enum.Font.SourceSansBold
trollLabel.BackgroundTransparency = 1
trollLabel.TextXAlignment = Enum.TextXAlignment.Left
trollLabel.Parent = trollTab

local trollInput = Instance.new("TextBox")
trollInput.Size = UDim2.new(1, 0, 0, 25)
trollInput.PlaceholderText = "Enter name..."
trollInput.Text = ""
trollInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
trollInput.TextColor3 = Color3.new(1, 1, 1)
trollInput.Font = Enum.Font.SourceSans
trollInput.TextSize = 14
trollInput.Parent = trollTab
Instance.new("UICorner", trollInput).CornerRadius = UDim.new(0, 4)

local targetingBtn = Instance.new("TextButton")
targetingBtn.Size = UDim2.new(1, 0, 0, 32)
targetingBtn.Text = "Targeting OFF"
targetingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
targetingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
targetingBtn.Font = Enum.Font.SourceSansBold
targetingBtn.TextSize = 14
targetingBtn.BorderSizePixel = 0
targetingBtn.Parent = trollTab
Instance.new("UICorner", targetingBtn).CornerRadius = UDim.new(0, 4)

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

targetingBtn.MouseButton1Click:Connect(function()
    isTargeting = not isTargeting

    if isTargeting then
        local target = findPlayer(trollInput.Text)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer = target
            targetingBtn.Text = "Targeting ON - " .. target.Name
            targetingBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            targetingBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            
            -- ПЕРЕЗАПУСКАЕМ ЦИКЛ, ЧТОБЫ ОН ИСПОЛЬЗОВАЛ НОВУЮ ЦЕЛЬ
            if spamConnection then
                stopSpamLoop()
            end
            startSpamLoop()
            print("✅ Таргет на: " .. target.Name)
        else
            isTargeting = false
            targetingBtn.Text = "Targeting OFF"
            targetingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            targetingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            print("❌ Игрок не найден или без персонажа")
        end
    else
        targetPlayer = nil
        targetingBtn.Text = "Targeting OFF"
        targetingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        targetingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- ПЕРЕЗАПУСКАЕМ ЦИКЛ БЕЗ ТАРГЕТА
        if spamConnection then
            stopSpamLoop()
            startSpamLoop()
        end
        print("✅ Таргет выключен")
    end
end)

-- ==================== 2KSHOTER (ИСПРАВЛЕННЫЙ) ====================
local twoKActive = false
local twoKConnection = nil

local twoKKillBtn = Instance.new("TextButton")
twoKKillBtn.Size = UDim2.new(1, 0, 0, 32)
twoKKillBtn.Text = "kill all OFF"
twoKKillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
twoKKillBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
twoKKillBtn.Font = Enum.Font.SourceSansBold
twoKKillBtn.TextSize = 14
twoKKillBtn.BorderSizePixel = 0
twoKKillBtn.Parent = twoKTab
Instance.new("UICorner", twoKKillBtn).CornerRadius = UDim.new(0, 4)

local function get2KEvent()
    local char = LocalPlayer.Character
    if not char then return nil end
    local shooter = char:FindFirstChild("2000s shooter")
    if not shooter then return nil end
    return shooter:FindFirstChild("ShootEvent")
end

local function get2KTargetPos(player)
    if not player or not player.Character then return nil end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.Position -- Vector3
end

local function get2KTargetCFrame(player)
    if not player or not player.Character then return nil end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.CFrame -- CFrame
end

local function shootAllPlayers()
    local players = Players:GetPlayers()
    local ev = get2KEvent()
    if not ev then 
        print("❌ ShootEvent не найден у LocalPlayer")
        return 
    end
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            local targetPos = get2KTargetPos(player)
            local targetCFrame = get2KTargetCFrame(player)
            
            if targetPos then
                -- Пробуем отправить Vector3
                local success, err = pcall(function()
                    ev:FireServer(targetPos)
                end)
                
                if not success then
                    -- Если не сработало, пробуем CFrame
                    pcall(function()
                        ev:FireServer(targetCFrame)
                    end)
                end
                
                -- Третий вариант: может нужен InvokeServer
                pcall(function()
                    ev:InvokeServer(targetPos)
                end)
            end
        end
    end
end

twoKKillBtn.MouseButton1Click:Connect(function()
    twoKActive = not twoKActive

    if twoKActive then
        twoKKillBtn.Text = "kill all ON"
        twoKKillBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        twoKKillBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

        twoKConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not twoKActive then
                twoKConnection:Disconnect()
                twoKConnection = nil
                return
            end
            shootAllPlayers()
        end)
        print("✅ 2Kshoter включен")
    else
        twoKKillBtn.Text = "kill all OFF"
        twoKKillBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        twoKKillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        if twoKConnection then
            twoKConnection:Disconnect()
            twoKConnection = nil
        end
        print("✅ 2Kshoter выключен")
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
    for k in pairs(activeSpammers) do
        activeSpammers[k] = false
    end
    stopSpamLoop()
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

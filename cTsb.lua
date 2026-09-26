-- ==================== STATS-GUI ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

if game:GetService("CoreGui"):FindFirstChild("StatsGui") then
    game:GetService("CoreGui"):FindFirstChild("StatsGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StatsGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================== ГЛАВНОЕ ОКНО ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(100, 70, 200)
MainStroke.Thickness = 1.2

-- ==================== ФОН ЗВЁЗД ====================
local StarField = Instance.new("Frame")
StarField.Name = "StarField"
StarField.Parent = MainFrame
StarField.BackgroundTransparency = 1
StarField.Size = UDim2.new(1, 0, 1, 0)
StarField.ClipsDescendants = true
StarField.ZIndex = 0
StarField.Visible = false

local stars = {}
for i = 1, 50 do
    local star = Instance.new("Frame")
    star.Name = "Star" .. i
    star.Parent = StarField
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BorderSizePixel = 0
    star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.ZIndex = 0
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    star.BackgroundTransparency = math.random(20, 70) / 100
    table.insert(stars, {frame = star, speed = math.random(20, 60) / 1000, offset = math.random()})
end

task.spawn(function()
    while ScreenGui.Parent do
        if StarField.Visible then
            for _, s in pairs(stars) do
                if s.frame and s.frame.Parent then
                    s.frame.BackgroundTransparency = 0.3 + math.abs(math.sin(tick() * s.speed * 10 + s.offset)) * 0.6
                end
            end
        end
        task.wait(0.05)
    end
end)

-- ==================== ЗАГОЛОВОК ====================
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.ZIndex = 2
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Spynote"
TitleLabel.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 35, 80)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -60, 0, 4)
MinimizeButton.Size = UDim2.new(0, 22, 0, 22)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(220, 210, 255)
MinimizeButton.TextSize = 13
MinimizeButton.ZIndex = 3
MinimizeButton.AutoButtonColor = false
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 5)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 40, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -33, 0, 4)
CloseButton.Size = UDim2.new(0, 22, 0, 22)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 210, 210)
CloseButton.TextSize = 15
CloseButton.ZIndex = 3
CloseButton.AutoButtonColor = false
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5)

-- ==================== ВЕРХНЯЯ ИНФО ПАНЕЛЬ ====================
local TopInfo = Instance.new("Frame")
TopInfo.Parent = MainFrame
TopInfo.BackgroundColor3 = Color3.fromRGB(18, 14, 35)
TopInfo.BorderSizePixel = 0
TopInfo.Position = UDim2.new(0, 8, 0, 36)
TopInfo.Size = UDim2.new(1, -16, 0, 46)
TopInfo.ZIndex = 2
Instance.new("UICorner", TopInfo).CornerRadius = UDim.new(0, 6)

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Parent = TopInfo
StatsLabel.BackgroundTransparency = 1
StatsLabel.Position = UDim2.new(0, 8, 0, 0)
StatsLabel.Size = UDim2.new(1, -16, 1, 0)
StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.Text = "players: 0\nFps: 0\nPing: 0"
StatsLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
StatsLabel.TextSize = 11
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.TextYAlignment = Enum.TextYAlignment.Center
StatsLabel.TextWrapped = true
StatsLabel.ZIndex = 3

-- ==================== КОНТЕНТ ====================
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 8, 0, 88)
ContentFrame.Size = UDim2.new(1, -16, 1, -140)
ContentFrame.ZIndex = 2

-- Info
local InfoTab = Instance.new("Frame")
InfoTab.Parent = ContentFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.Visible = true
InfoTab.ZIndex = 2

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "Spynote\n\nПростое инфо-гуи.\n\n• Info — информация\n• Exec — функции\n• Emote — эмоции\n• Settings — темы"
InfoLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
InfoLabel.TextSize = 12
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextWrapped = true
InfoLabel.ZIndex = 2

-- Exec
local ExecTab = Instance.new("Frame")
ExecTab.Parent = ContentFrame
ExecTab.BackgroundTransparency = 1
ExecTab.Size = UDim2.new(1, 0, 1, 0)
ExecTab.Visible = false
ExecTab.ZIndex = 2

local ExecScroll = Instance.new("ScrollingFrame")
ExecScroll.Parent = ExecTab
ExecScroll.BackgroundTransparency = 1
ExecScroll.Size = UDim2.new(1, 0, 1, 0)
ExecScroll.BorderSizePixel = 0
ExecScroll.ScrollBarThickness = 3
ExecScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ExecScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ExecScroll.ZIndex = 2

local ExecList = Instance.new("UIListLayout", ExecScroll)
ExecList.Padding = UDim.new(0, 8)

local InstantBackBtn = Instance.new("TextButton")
InstantBackBtn.Parent = ExecScroll
InstantBackBtn.Size = UDim2.new(1, -6, 0, 34)
InstantBackBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
InstantBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantBackBtn.Font = Enum.Font.GothamBold
InstantBackBtn.TextSize = 13
InstantBackBtn.Text = "instant-back"
InstantBackBtn.BorderSizePixel = 0
InstantBackBtn.AutoButtonColor = false
InstantBackBtn.ZIndex = 3
Instance.new("UICorner", InstantBackBtn).CornerRadius = UDim.new(0, 6)

local InstantLHpBtn = Instance.new("TextButton")
InstantLHpBtn.Parent = ExecScroll
InstantLHpBtn.Size = UDim2.new(1, -6, 0, 34)
InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
InstantLHpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantLHpBtn.Font = Enum.Font.GothamBold
InstantLHpBtn.TextSize = 13
InstantLHpBtn.Text = "instant-lHp"
InstantLHpBtn.BorderSizePixel = 0
InstantLHpBtn.AutoButtonColor = false
InstantLHpBtn.ZIndex = 3
Instance.new("UICorner", InstantLHpBtn).CornerRadius = UDim.new(0, 6)

local AutoBackBtn = Instance.new("TextButton")
AutoBackBtn.Parent = ExecScroll
AutoBackBtn.Size = UDim2.new(1, -6, 0, 34)
AutoBackBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
AutoBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBackBtn.Font = Enum.Font.GothamBold
AutoBackBtn.TextSize = 13
AutoBackBtn.Text = "Auto-back OFF"
AutoBackBtn.BorderSizePixel = 0
AutoBackBtn.AutoButtonColor = false
AutoBackBtn.ZIndex = 3
Instance.new("UICorner", AutoBackBtn).CornerRadius = UDim.new(0, 6)

local AutoSaveBtn = Instance.new("TextButton")
AutoSaveBtn.Parent = ExecScroll
AutoSaveBtn.Size = UDim2.new(1, -6, 0, 34)
AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
AutoSaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSaveBtn.Font = Enum.Font.GothamBold
AutoSaveBtn.TextSize = 13
AutoSaveBtn.Text = "Auto Save OFF"
AutoSaveBtn.BorderSizePixel = 0
AutoSaveBtn.AutoButtonColor = false
AutoSaveBtn.ZIndex = 3
Instance.new("UICorner", AutoSaveBtn).CornerRadius = UDim.new(0, 6)

-- Emote
local EmoteTab = Instance.new("Frame")
EmoteTab.Parent = ContentFrame
EmoteTab.BackgroundTransparency = 1
EmoteTab.Size = UDim2.new(1, 0, 1, 0)
EmoteTab.Visible = false
EmoteTab.ZIndex = 2

local EmoteScroll = Instance.new("ScrollingFrame")
EmoteScroll.Parent = EmoteTab
EmoteScroll.BackgroundTransparency = 1
EmoteScroll.Size = UDim2.new(1, 0, 1, 0)
EmoteScroll.BorderSizePixel = 0
EmoteScroll.ScrollBarThickness = 3
EmoteScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
EmoteScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
EmoteScroll.ZIndex = 2

local EmoteList = Instance.new("UIListLayout", EmoteScroll)
EmoteList.Padding = UDim.new(0, 8)

local TransformBtn = Instance.new("TextButton")
TransformBtn.Parent = EmoteScroll
TransformBtn.Size = UDim2.new(1, -6, 0, 34)
TransformBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
TransformBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TransformBtn.Font = Enum.Font.GothamBold
TransformBtn.TextSize = 13
TransformBtn.Text = "Transform"
TransformBtn.BorderSizePixel = 0
TransformBtn.AutoButtonColor = false
TransformBtn.ZIndex = 3
Instance.new("UICorner", TransformBtn).CornerRadius = UDim.new(0, 6)

-- Settings
local SettingsTab = Instance.new("Frame")
SettingsTab.Parent = ContentFrame
SettingsTab.BackgroundTransparency = 1
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.Visible = false
SettingsTab.ZIndex = 2

local SettingsScroll = Instance.new("ScrollingFrame")
SettingsScroll.Parent = SettingsTab
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.Size = UDim2.new(1, 0, 1, 0)
SettingsScroll.BorderSizePixel = 0
SettingsScroll.ScrollBarThickness = 3
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsScroll.ZIndex = 2

local SettingsList = Instance.new("UIListLayout", SettingsScroll)
SettingsList.Padding = UDim.new(0, 8)

local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Parent = SettingsScroll
ThemeLabel.Size = UDim2.new(1, -6, 0, 18)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Text = "Тема:"
ThemeLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
ThemeLabel.TextSize = 12
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.ZIndex = 2

local StandardBtn = Instance.new("TextButton")
StandardBtn.Parent = SettingsScroll
StandardBtn.Size = UDim2.new(1, -6, 0, 34)
StandardBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
StandardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StandardBtn.Font = Enum.Font.GothamBold
StandardBtn.TextSize = 13
StandardBtn.Text = "Standard"
StandardBtn.BorderSizePixel = 0
StandardBtn.AutoButtonColor = false
StandardBtn.ZIndex = 3
Instance.new("UICorner", StandardBtn).CornerRadius = UDim.new(0, 6)

local DarkBtn = Instance.new("TextButton")
DarkBtn.Parent = SettingsScroll
DarkBtn.Size = UDim2.new(1, -6, 0, 34)
DarkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
DarkBtn.TextColor3 = Color3.fromRGB(230, 220, 255)
DarkBtn.Font = Enum.Font.GothamBold
DarkBtn.TextSize = 13
DarkBtn.Text = "Dark"
DarkBtn.BorderSizePixel = 0
DarkBtn.AutoButtonColor = false
DarkBtn.ZIndex = 3
Instance.new("UICorner", DarkBtn).CornerRadius = UDim.new(0, 6)

-- ==================== НИЖНИЕ ВКЛАДКИ ====================
local TabsBar = Instance.new("Frame")
TabsBar.Parent = MainFrame
TabsBar.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
TabsBar.BorderSizePixel = 0
TabsBar.Position = UDim2.new(0, 0, 1, -42)
TabsBar.Size = UDim2.new(1, 0, 0, 42)
TabsBar.ZIndex = 5
Instance.new("UICorner", TabsBar).CornerRadius = UDim.new(0, 10)

local TabsLayout = Instance.new("UIListLayout", TabsBar)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.Padding = UDim.new(0, 4)
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabButton(name, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 56, 0, 28)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 170, 210)
    btn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.Parent = TabsBar
    btn.AutoButtonColor = false
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        ExecTab.Visible = false
        EmoteTab.Visible = false
        SettingsTab.Visible = false
        targetTab.Visible = true
        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                if StarField.Visible then
                    child.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
                    child.TextColor3 = Color3.fromRGB(150, 150, 180)
                else
                    child.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
                    child.TextColor3 = Color3.fromRGB(180, 170, 210)
                end
            end
        end
        if StarField.Visible then
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            btn.TextColor3 = Color3.fromRGB(220, 220, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
            btn.TextColor3 = Color3.fromRGB(255, 220, 100)
        end
    end)
    return btn
end

local infoTabBtn = createTabButton("Info", InfoTab)
local execTabBtn = createTabButton("Exec", ExecTab)
local emoteTabBtn = createTabButton("Emote", EmoteTab)
local settingsTabBtn = createTabButton("Settings", SettingsTab)

infoTabBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
infoTabBtn.TextColor3 = Color3.fromRGB(255, 220, 100)

-- ==================== СМЕНА ТЕМЫ ====================
local function applyTheme(theme)
    if theme == "standard" then
        StarField.Visible = false
        MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
        MainStroke.Color = Color3.fromRGB(100, 70, 200)
        TitleBar.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
        TitleLabel.TextColor3 = Color3.fromRGB(180, 140, 255)
        TopInfo.BackgroundColor3 = Color3.fromRGB(18, 14, 35)
        StatsLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
        InfoLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
        ThemeLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
        TabsBar.BackgroundColor3 = Color3.fromRGB(20, 16, 40)
        InstantBackBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
        InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
        AutoBackBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        TransformBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
        StandardBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
        DarkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                local isActive = (child == infoTabBtn and InfoTab.Visible) or
                                 (child == execTabBtn and ExecTab.Visible) or
                                 (child == emoteTabBtn and EmoteTab.Visible) or
                                 (child == settingsTabBtn and SettingsTab.Visible)
                if isActive then
                    child.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
                    child.TextColor3 = Color3.fromRGB(255, 220, 100)
                else
                    child.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
                    child.TextColor3 = Color3.fromRGB(180, 170, 210)
                end
            end
        end
    elseif theme == "dark" then
        StarField.Visible = true
        MainFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 8)
        MainStroke.Color = Color3.fromRGB(60, 60, 90)
        TitleBar.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
        TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
        TopInfo.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
        StatsLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
        InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
        ThemeLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
        TabsBar.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
        InstantBackBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        AutoBackBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        TransformBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        StandardBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        DarkBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                local isActive = (child == infoTabBtn and InfoTab.Visible) or
                                 (child == execTabBtn and ExecTab.Visible) or
                                 (child == emoteTabBtn and EmoteTab.Visible) or
                                 (child == settingsTabBtn and SettingsTab.Visible)
                if isActive then
                    child.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                    child.TextColor3 = Color3.fromRGB(220, 220, 255)
                else
                    child.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
                    child.TextColor3 = Color3.fromRGB(150, 150, 180)
                end
            end
        end
    end
end

StandardBtn.MouseButton1Click:Connect(function()
    applyTheme("standard")
end)

DarkBtn.MouseButton1Click:Connect(function()
    applyTheme("dark")
end)

-- ==================== СТАТИСТИКА ====================
local fpsCount = 0
local fpsTimer = tick()

RunService.RenderStepped:Connect(function()
    fpsCount = fpsCount + 1
    if tick() - fpsTimer >= 1 then
        local fps = fpsCount
        fpsCount = 0
        fpsTimer = tick()

        local ping = 0
        pcall(function()
            ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)

        local playersCount = #Players:GetPlayers()
        StatsLabel.Text = "players: " .. playersCount .. "\nFps: " .. fps .. "\nPing: " .. ping
    end
end)

-- ==================== INSTANT-BACK ====================
local function instantBack()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local closestPlayer = nil
    local closestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                local dist = (myHrp.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlayer = plr
                end
            end
        end
    end

    if not closestPlayer then return end

    local targetHrp = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end

    local behindPos = targetHrp.CFrame * CFrame.new(0, 0, 3)
    myHrp.CFrame = behindPos
end

InstantBackBtn.MouseButton1Click:Connect(function()
    local oldText = InstantBackBtn.Text
    InstantBackBtn.Text = "✓ Done"
    InstantBackBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)

    pcall(instantBack)

    task.wait(0.6)
    InstantBackBtn.Text = oldText
    if StarField.Visible then
        InstantBackBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    else
        InstantBackBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
    end
end)

-- ==================== INSTANT-LHP ====================
local function instantLHp()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local lowestPlayer = nil
    local lowestHp = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                if humanoid.Health < lowestHp then
                    lowestHp = humanoid.Health
                    lowestPlayer = plr
                end
            end
        end
    end

    if not lowestPlayer then return end

    local targetHrp = lowestPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end

    local behindPos = targetHrp.CFrame * CFrame.new(0, 0, 3)
    myHrp.CFrame = behindPos
end

InstantLHpBtn.MouseButton1Click:Connect(function()
    local oldText = InstantLHpBtn.Text
    InstantLHpBtn.Text = "✓ Done"
    InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)

    pcall(instantLHp)

    task.wait(0.6)
    InstantLHpBtn.Text = oldText
    if StarField.Visible then
        InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    else
        InstantLHpBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
    end
end)

-- ==================== AUTO-BACK (ПЕРЕХВАТ СОБЫТИЙ) ====================
local autoBackActive = false

local function teleportToClosestPlayer()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local closestPlayer = nil
    local closestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 then
                local dist = (myHrp.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlayer = plr
                end
            end
        end
    end

    if not closestPlayer then return end

    local targetHrp = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end

    local behindPos = targetHrp.CFrame * CFrame.new(0, 0, 3)
    myHrp.CFrame = behindPos
end

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and self.Name == "Communicate" then
        local data = args[1]
        if type(data) == "table" then
            if data.Mobile == true and data.Goal == "LeftClick" then
                if autoBackActive then
                    task.spawn(function()
                        pcall(teleportToClosestPlayer)
                    end)
                end
            end
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

AutoBackBtn.MouseButton1Click:Connect(function()
    autoBackActive = not autoBackActive
    if autoBackActive then
        AutoBackBtn.Text = "Auto-back ON"
        AutoBackBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
    else
        AutoBackBtn.Text = "Auto-back OFF"
        if StarField.Visible then
            AutoBackBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        else
            AutoBackBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end
end)

-- ==================== AUTO SAVE ====================
local autoSaveActive = false
local autoSaveCooldown = false
local saveCFrame = CFrame.new(66.3987427, 652.837646, -413.314026, -0.119502902, 1.05234655e-07, -0.992833853, -1.53309863e-08, 1, 1.07839547e-07, 0.992833853, 2.81082606e-08, -0.119502902)

task.spawn(function()
    while true do
        task.wait(1)
        if autoSaveActive and not autoSaveCooldown then
            local myChar = LocalPlayer.Character
            local myHumanoid = myChar and myChar:FindFirstChildOfClass("Humanoid")
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myHumanoid and myHrp then
                if myHumanoid.Health > 0 and myHumanoid.Health < 10 then
                    myHrp.CFrame = saveCFrame
                    autoSaveCooldown = true
                    task.wait(10)
                    autoSaveCooldown = false
                end
            end
        end
    end
end)

AutoSaveBtn.MouseButton1Click:Connect(function()
    autoSaveActive = not autoSaveActive
    if autoSaveActive then
        AutoSaveBtn.Text = "Auto Save ON"
        AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
    else
        AutoSaveBtn.Text = "Auto Save OFF"
        autoSaveCooldown = false
        if StarField.Visible then
            AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        else
            AutoSaveBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end
end)

-- ==================== EMOTE TRANSFORM ====================
TransformBtn.MouseButton1Click:Connect(function()
    local oldText = TransformBtn.Text
    TransformBtn.Text = "✓ Done"
    TransformBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 80)

    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local event = char:FindFirstChild("Communicate")
        if not event then return end
        event:FireServer({
            Goal = "Emote",
            Emote = "Transform"
        })
    end)

    task.wait(0.6)
    TransformBtn.Text = oldText
    if StarField.Visible then
        TransformBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    else
        TransformBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
    end
end)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 30), "Out", "Quad", 0.2, true)
        TopInfo.Visible = false
        ContentFrame.Visible = false
        TabsBar.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 200), "Out", "Quad", 0.2, true)
        TopInfo.Visible = true
        ContentFrame.Visible = true
        TabsBar.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

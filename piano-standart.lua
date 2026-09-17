-- ==================== PIANO ERUDITE GUI ====================
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if game:GetService("CoreGui"):FindFirstChild("PianoEruditeGui") then
    game:GetService("CoreGui"):FindFirstChild("PianoEruditeGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PianoEruditeGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -180)
MainFrame.Size = UDim2.new(0, 440, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(120, 80, 220)
MainStroke.Thickness = 1.5

local StarField = Instance.new("Frame")
StarField.Name = "StarField"
StarField.Parent = MainFrame
StarField.BackgroundTransparency = 1
StarField.Size = UDim2.new(1, 0, 1, 0)
StarField.ClipsDescendants = true
StarField.ZIndex = 0

local stars = {}
for i = 1, 60 do
    local star = Instance.new("Frame")
    star.Name = "Star" .. i
    star.Parent = StarField
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BorderSizePixel = 0
    star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.ZIndex = 0
    local sc = Instance.new("UICorner", star)
    sc.CornerRadius = UDim.new(1, 0)
    star.BackgroundTransparency = math.random(20, 80) / 100
    table.insert(stars, {frame = star, speed = math.random(20, 60) / 1000, offset = math.random()})
end

task.spawn(function()
    while ScreenGui.Parent do
        for _, s in pairs(stars) do
            if s.frame and s.frame.Parent then
                s.frame.BackgroundTransparency = 0.3 + math.abs(math.sin(tick() * s.speed * 10 + s.offset)) * 0.6
            end
        end
        task.wait(0.05)
    end
end)

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.ZIndex = 2

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 12)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "♪ Piano Erudite"
TitleLabel.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLabel.TextSize = 17
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 180, 255)
MinimizeButton.TextSize = 16
MinimizeButton.ZIndex = 3
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 30, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 200, 200)
CloseButton.TextSize = 18
CloseButton.ZIndex = 3
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 10, 0, 46)
ContentFrame.Size = UDim2.new(1, -20, 1, -100)
ContentFrame.ZIndex = 2

local InfoTab = Instance.new("Frame")
InfoTab.Name = "InfoTab"
InfoTab.Parent = ContentFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.Visible = true

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "♪ Piano Erudite ♪\n\nПростой пианино-скрипт для Roblox.\n\nВкладки:\n  • Info — информация\n  • Songs — песни\n  • Settings — настройки"
InfoLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
InfoLabel.TextSize = 14
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextWrapped = true

local SongsTab = Instance.new("Frame")
SongsTab.Name = "SongsTab"
SongsTab.Parent = ContentFrame
SongsTab.BackgroundTransparency = 1
SongsTab.Size = UDim2.new(1, 0, 1, 0)
SongsTab.Visible = false

local SongsScroll = Instance.new("ScrollingFrame")
SongsScroll.Parent = SongsTab
SongsScroll.BackgroundTransparency = 1
SongsScroll.Size = UDim2.new(1, 0, 1, 0)
SongsScroll.BorderSizePixel = 0
SongsScroll.ScrollBarThickness = 4
SongsScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 220)
SongsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SongsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local SongsList = Instance.new("UIListLayout", SongsScroll)
SongsList.Padding = UDim.new(0, 8)
SongsList.SortOrder = Enum.SortOrder.LayoutOrder

local SettingsTab = Instance.new("Frame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Parent = ContentFrame
SettingsTab.BackgroundTransparency = 1
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.Visible = false

local SettingsScroll = Instance.new("ScrollingFrame")
SettingsScroll.Parent = SettingsTab
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.Size = UDim2.new(1, 0, 1, 0)
SettingsScroll.BorderSizePixel = 0
SettingsScroll.ScrollBarThickness = 4
SettingsScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 220)
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local SettingsList = Instance.new("UIListLayout", SettingsScroll)
SettingsList.Padding = UDim.new(0, 8)
SettingsList.SortOrder = Enum.SortOrder.LayoutOrder

local function pressKey(keyCode)
    VIM:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, keyCode, false, game)
end

local function pressKeyShift(keyCode)
    VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, keyCode, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
end

local function holdKey(keyCode, holdTime)
    VIM:SendKeyEvent(true, keyCode, false, game)
    task.wait(holdTime)
    VIM:SendKeyEvent(false, keyCode, false, game)
end

local function playFieldOfMemories()
    for i = 1, 2 do
        pressKey(Enum.KeyCode.T)
        task.wait(0.3)
        pressKey(Enum.KeyCode.O)
        task.wait(0.3)
        pressKey(Enum.KeyCode.S)
        task.wait(0.3)
    end

    task.wait(0)
    pressKeyShift(Enum.KeyCode.D)
    task.wait(0.09)
    pressKey(Enum.KeyCode.D)
    task.wait(0.5)

    for i = 1, 2 do
        pressKey(Enum.KeyCode.I)
        task.wait(0.3)
        pressKey(Enum.KeyCode.O)
        task.wait(0.3)
        pressKey(Enum.KeyCode.S)
        task.wait(0.3)
    end

    task.wait(0)
    pressKey(Enum.KeyCode.D)
    task.wait(0.09)
    pressKeyShift(Enum.KeyCode.D)
    task.wait(0.5)

    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.S)
    task.wait(0.5)

    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.5)

    for i = 1, 2 do
        pressKey(Enum.KeyCode.T)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.Y)
        task.wait(0.3)
        pressKey(Enum.KeyCode.Y)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.E)
        task.wait(0.3)
    end
end

local function playNostalgia2()
    for i = 1, 3 do
        pressKey(Enum.KeyCode.J)
        task.wait(0.3)
        pressKey(Enum.KeyCode.S)
        task.wait(0.3)
        pressKey(Enum.KeyCode.G)
        task.wait(0.3)
        pressKey(Enum.KeyCode.S)
        task.wait(0.3)
    end

    task.wait(0)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.S)
    task.wait(0.3)
    pressKey(Enum.KeyCode.G)
    task.wait(0.3)
    pressKey(Enum.KeyCode.H)
    task.wait(0.3)
    pressKey(Enum.KeyCode.J)
end

local function play7weaksNostal()
    pressKey(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.S)
    task.wait(0.3)
    pressKey(Enum.KeyCode.F)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.G)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.H)
    task.wait(0.5)

    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.S)
    task.wait(0.3)
    pressKey(Enum.KeyCode.F)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.G)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.H)
    task.wait(0.5)

    for i = 1, 2 do
        pressKey(Enum.KeyCode.U)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.O)
        task.wait(0.3)
        pressKey(Enum.KeyCode.A)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.S)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.D)
        task.wait(0.3)
        pressKeyShift(Enum.KeyCode.S)
        task.wait(0.3)
    end
end

local function playFnaf4Westi()
    holdKey(Enum.KeyCode.G, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.J, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.H, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.S, 0.7)
    task.wait(0.3)

    holdKey(Enum.KeyCode.G, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.H, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.J, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.G, 0.7)
    task.wait(0.3)

    holdKey(Enum.KeyCode.J, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.G, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.H, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.S, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.S, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.H, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.J, 0.7)
    task.wait(0.1)
    holdKey(Enum.KeyCode.G, 0.7)
end

local function playGermany90x()
    pressKey(Enum.KeyCode.T)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.T)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.5)
    pressKey(Enum.KeyCode.S)
    task.wait(0.5)
    pressKey(Enum.KeyCode.S)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.5)
    pressKeyShift(Enum.KeyCode.O)
end

-- ==================== ПЕСНЯ: bad piggies ====================
local function playBadPiggies()
    -- s s P s (P теперь большая!)
    pressKey(Enum.KeyCode.S)
    task.wait(0.3)
    pressKey(Enum.KeyCode.S)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKey(Enum.KeyCode.S)
    task.wait(0.5)

    -- P (большая) O (большая) o (маленькая)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.5)

    -- P (большая) O (большая) o (маленькая) i Y (большая) i o
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.I)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.3)
    pressKey(Enum.KeyCode.I)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.5)

    -- P (большая) P (большая) O (большая) o (маленькая) i Y (большая) i o
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.P)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.3)
    pressKey(Enum.KeyCode.I)
    task.wait(0.3)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.3)
    pressKey(Enum.KeyCode.I)
    task.wait(0.3)
    pressKey(Enum.KeyCode.O)
    task.wait(0.5)

    -- ФИНАЛ быстро 0.07: o Y (большая) t Y (большая) o Y (большая) y (маленькая)
    pressKey(Enum.KeyCode.O)
    task.wait(0.07)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.07)
    pressKey(Enum.KeyCode.T)
    task.wait(0.07)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.07)
    pressKey(Enum.KeyCode.O)
    task.wait(0.07)
    pressKeyShift(Enum.KeyCode.Y)
    task.wait(0.07)
    pressKey(Enum.KeyCode.Y)
end

local function jumpTwice()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    humanoid.Jump = true
    task.wait(0.4)
    humanoid.Jump = true
end

local function createSongButton(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 45)
    btn.Text = "▶  " .. name
    btn.TextColor3 = Color3.fromRGB(220, 200, 255)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = parent
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(80, 50, 150)
    stroke.Thickness = 1

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(45, 30, 90)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(25, 20, 50)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        local oldText = btn.Text
        btn.Text = "♪ Playing..."
        btn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
        btn.TextColor3 = Color3.fromRGB(255, 220, 100)

        task.spawn(function()
            pcall(callback)
            task.wait(0.3)
            btn.Text = oldText
            btn.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
            btn.TextColor3 = Color3.fromRGB(220, 200, 255)
        end)
    end)

    return btn
end

local function createSettingsButton(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 45)
    btn.Text = "⚙  " .. name
    btn.TextColor3 = Color3.fromRGB(220, 200, 255)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = parent
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(80, 50, 150)
    stroke.Thickness = 1

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(45, 30, 90)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(25, 20, 50)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        local oldText = btn.Text
        btn.Text = "✓ Done!"
        btn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
        btn.TextColor3 = Color3.fromRGB(200, 255, 200)

        task.spawn(function()
            pcall(callback)
            task.wait(0.5)
            btn.Text = oldText
            btn.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
            btn.TextColor3 = Color3.fromRGB(220, 200, 255)
        end)
    end)

    return btn
end

createSongButton(SongsScroll, "Field of Memories", playFieldOfMemories)
createSongButton(SongsScroll, "Nostalgia-2", playNostalgia2)
createSongButton(SongsScroll, "7weaks-Nostal", play7weaksNostal)
createSongButton(SongsScroll, "fnaf4-westi", playFnaf4Westi)
createSongButton(SongsScroll, "Germany-90x", playGermany90x)
createSongButton(SongsScroll, "bad piggies", playBadPiggies)

createSettingsButton(SettingsScroll, "Jump 2", jumpTwice)

local TabsBar = Instance.new("Frame")
TabsBar.Name = "TabsBar"
TabsBar.Parent = MainFrame
TabsBar.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
TabsBar.BorderSizePixel = 0
TabsBar.Position = UDim2.new(0, 0, 1, -46)
TabsBar.Size = UDim2.new(1, 0, 0, 46)
TabsBar.ZIndex = 2

local TabsBarCorner = Instance.new("UICorner", TabsBar)
TabsBarCorner.CornerRadius = UDim.new(0, 12)

local TabsLayout = Instance.new("UIListLayout", TabsBar)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.Padding = UDim.new(0, 8)
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabButton(name, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 32)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 170, 210)
    btn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = TabsBar
    btn.AutoButtonColor = false
    btn.ZIndex = 3

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(80, 50, 150)
    s.Thickness = 1

    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        SongsTab.Visible = false
        SettingsTab.Visible = false
        targetTab.Visible = true

        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(30, 22, 60),
                    TextColor3 = Color3.fromRGB(180, 170, 210)
                }):Play()
            end
        end
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 40, 140),
            TextColor3 = Color3.fromRGB(255, 220, 100)
        }):Play()
    end)

    return btn
end

local infoTabBtn = createTabButton("Info", InfoTab)
local songsTabBtn = createTabButton("Songs", SongsTab)
local settingsTabBtn = createTabButton("Settings", SettingsTab)

infoTabBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
infoTabBtn.TextColor3 = Color3.fromRGB(255, 220, 100)

local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 38), "Out", "Quad", 0.2, true)
        ContentFrame.Visible = false
        TabsBar.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 360), "Out", "Quad", 0.2, true)
        ContentFrame.Visible = true
        TabsBar.Visible = true
        MinimizeButton.Text = "—"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

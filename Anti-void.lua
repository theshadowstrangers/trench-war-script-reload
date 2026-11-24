-- ==================== SPYNOTE DARK GUI ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function getGuiParent()
    local target = nil
    pcall(function()
        if gethui then
            target = gethui()
        end
    end)
    if not target then
        pcall(function()
            target = game:GetService("CoreGui")
        end)
    end
    if not target then
        target = LocalPlayer:WaitForChild("PlayerGui")
    end
    return target
end

local GuiParent = getGuiParent()

pcall(function()
    local old = GuiParent:FindFirstChild("StatsGui")
    if old then old:Destroy() end
    local oldCore = game:GetService("CoreGui"):FindFirstChild("StatsGui")
    if oldCore then oldCore:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StatsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentOk = pcall(function()
    ScreenGui.Parent = GuiParent
end)
if not parentOk or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ==================== ГЛАВНОЕ ОКНО (ТЕМНО-ЧЕРНОЕ) ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 1

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(35, 35, 45)
MainStroke.Thickness = 1.2

-- ==================== ЗАГОЛОВОК ====================
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
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
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -60, 0, 4)
MinimizeButton.Size = UDim2.new(0, 22, 0, 22)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 210)
MinimizeButton.TextSize = 13
MinimizeButton.ZIndex = 4
MinimizeButton.AutoButtonColor = false
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 5)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 30, 40)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -33, 0, 4)
CloseButton.Size = UDim2.new(0, 22, 0, 22)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 210, 210)
CloseButton.TextSize = 15
CloseButton.ZIndex = 4
CloseButton.AutoButtonColor = false
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5)

-- ==================== ВЕРХНЯЯ ИНФО ПАНЕЛЬ ====================
local TopInfo = Instance.new("Frame")
TopInfo.Parent = MainFrame
TopInfo.BackgroundColor3 = Color3.fromRGB(9, 9, 13)
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
StatsLabel.TextColor3 = Color3.fromRGB(190, 190, 205)
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
ContentFrame.Size = UDim2.new(1, -16, 1, -134)
ContentFrame.ZIndex = 2

-- Вкладка INFO
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
InfoLabel.Text = "Зверя нет сильнее птички, старый бог сломал яички\n\n• Info — информация\n• Note — основные функции"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
InfoLabel.TextSize = 12
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextWrapped = true
InfoLabel.ZIndex = 3

-- Вкладка NOTE
local NoteTab = Instance.new("Frame")
NoteTab.Parent = ContentFrame
NoteTab.BackgroundTransparency = 1
NoteTab.Size = UDim2.new(1, 0, 1, 0)
NoteTab.Visible = false
NoteTab.ZIndex = 2

local NoteScroll = Instance.new("ScrollingFrame")
NoteScroll.Parent = NoteTab
NoteScroll.BackgroundTransparency = 1
NoteScroll.Size = UDim2.new(1, 0, 1, 0)
NoteScroll.BorderSizePixel = 0
NoteScroll.ScrollBarThickness = 3
NoteScroll.CanvasSize = UDim2.new(0, 0, 0, 130)
NoteScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
NoteScroll.ZIndex = 2

local NoteList = Instance.new("UIListLayout", NoteScroll)
NoteList.Padding = UDim.new(0, 6)
NoteList.SortOrder = Enum.SortOrder.LayoutOrder

-- Кнопка Anti-void (комбо выживания в войде без телепортации)
local AntiVoidBtn = Instance.new("TextButton")
AntiVoidBtn.Parent = NoteScroll
AntiVoidBtn.LayoutOrder = 1
AntiVoidBtn.Size = UDim2.new(1, -6, 0, 32)
AntiVoidBtn.BackgroundColor3 = Color3.fromRGB(130, 35, 35)
AntiVoidBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiVoidBtn.Font = Enum.Font.GothamBold
AntiVoidBtn.TextSize = 13
AntiVoidBtn.Text = "Anti-void OFF"
AntiVoidBtn.BorderSizePixel = 0
AntiVoidBtn.AutoButtonColor = false
AntiVoidBtn.ZIndex = 4
Instance.new("UICorner", AntiVoidBtn).CornerRadius = UDim.new(0, 6)

-- Контейнер для Safe-zone и Safe-back в один ряд
local SafeRow = Instance.new("Frame")
SafeRow.Parent = NoteScroll
SafeRow.LayoutOrder = 2
SafeRow.BackgroundTransparency = 1
SafeRow.Size = UDim2.new(1, -6, 0, 32)
SafeRow.ZIndex = 3

local SafeZoneBtn = Instance.new("TextButton")
SafeZoneBtn.Parent = SafeRow
SafeZoneBtn.Size = UDim2.new(0.5, -3, 1, 0)
SafeZoneBtn.Position = UDim2.new(0, 0, 0, 0)
SafeZoneBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SafeZoneBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
SafeZoneBtn.Font = Enum.Font.GothamBold
SafeZoneBtn.TextSize = 13
SafeZoneBtn.Text = "Safe-zone"
SafeZoneBtn.BorderSizePixel = 0
SafeZoneBtn.AutoButtonColor = false
SafeZoneBtn.ZIndex = 4
Instance.new("UICorner", SafeZoneBtn).CornerRadius = UDim.new(0, 6)

local SafeBackBtn = Instance.new("TextButton")
SafeBackBtn.Parent = SafeRow
SafeBackBtn.Size = UDim2.new(0.5, -3, 1, 0)
SafeBackBtn.Position = UDim2.new(0.5, 3, 0, 0)
SafeBackBtn.BackgroundColor3 = Color3.fromRGB(30, 90, 130)
SafeBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SafeBackBtn.Font = Enum.Font.GothamBold
SafeBackBtn.TextSize = 13
SafeBackBtn.Text = "Safe-back"
SafeBackBtn.BorderSizePixel = 0
SafeBackBtn.AutoButtonColor = false
SafeBackBtn.ZIndex = 4
Instance.new("UICorner", SafeBackBtn).CornerRadius = UDim.new(0, 6)

-- Статус текст
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = NoteScroll
StatusLabel.LayoutOrder = 3
StatusLabel.Size = UDim2.new(1, -6, 0, 16)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.ZIndex = 4

-- ==================== НИЖНИЕ ВКЛАДКИ (INFO И NOTE) ====================
local TabsBar = Instance.new("Frame")
TabsBar.Parent = MainFrame
TabsBar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
TabsBar.BorderSizePixel = 0
TabsBar.Position = UDim2.new(0, 0, 1, -38)
TabsBar.Size = UDim2.new(1, 0, 0, 38)
TabsBar.ZIndex = 5
Instance.new("UICorner", TabsBar).CornerRadius = UDim.new(0, 10)

local TabsLayout = Instance.new("UIListLayout", TabsBar)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.Padding = UDim.new(0, 8)
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabButton(name, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 26)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 165)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = TabsBar
    btn.AutoButtonColor = false
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        NoteTab.Visible = false
        targetTab.Visible = true
        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
                child.TextColor3 = Color3.fromRGB(150, 150, 165)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

local infoTabBtn = createTabButton("Info", InfoTab)
local noteTabBtn = createTabButton("Note", NoteTab)

infoTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
infoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ==================== СТАТИСТИКА (FPS / PING / PLAYERS) ====================
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
        StatsLabel.Text = "players: " .. #Players:GetPlayers() .. "\nFps: " .. fps .. "\nPing: " .. ping
    end
end)

-- ==================== VOID ЗАЩИТА (КОМБО ИЗ VOID TP) ====================
local voidHbConn = nil
local voidHealthHookOn = false
local voidCurrentMT = nil
local voidOldNewIndex = nil
local voidOldFallen = workspace.FallenPartsDestroyHeight
local voidPlatform = nil
local voidIsProtected = false
local voidSavedCFrame = nil
local voidBusy = false
local isAntiVoid = false

local function voidEnableProtection()
    if voidIsProtected then return end
    voidIsProtected = true
    if not voidHbConn then
        voidHbConn = RunService.Heartbeat:Connect(function()
            local t = os.clock()
            while os.clock() - t < 0.05 do end
        end)
    end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and not voidHealthHookOn then
        pcall(function()
            local rawMt = getrawmetatable and getrawmetatable(game)
            if rawMt then
                voidCurrentMT = rawMt
                voidOldNewIndex = rawMt.__newindex
                setreadonly(rawMt, false)
                rawMt.__newindex = function(t, k, v)
                    if t == hum and k == "Health" and v <= 0 then
                        return
                    end
                    return voidOldNewIndex(t, k, v)
                end
                setreadonly(rawMt, true)
                voidHealthHookOn = true
            end
        end)
    end
    pcall(function()
        workspace.FallenPartsDestroyHeight = -999999
    end)
end

local function voidDisableProtection()
    if not voidIsProtected then return end
    voidIsProtected = false
    if voidHbConn then
        voidHbConn:Disconnect()
        voidHbConn = nil
    end
    if voidHealthHookOn and voidCurrentMT and voidOldNewIndex then
        pcall(function()
            setreadonly(voidCurrentMT, false)
            voidCurrentMT.__newindex = voidOldNewIndex
            setreadonly(voidCurrentMT, true)
        end)
        voidHealthHookOn = false
        voidCurrentMT = nil
        voidOldNewIndex = nil
    end
    pcall(function()
        workspace.FallenPartsDestroyHeight = voidOldFallen
    end)
    if voidPlatform then
        voidPlatform:Destroy()
        voidPlatform = nil
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    voidHealthHookOn = false
    voidCurrentMT = nil
    voidOldNewIndex = nil
    if isAntiVoid then
        voidIsProtected = false
        voidEnableProtection()
    end
end)

-- Кнопка Anti-void (включает комбо защиты от смерти в войде без телепортации)
AntiVoidBtn.MouseButton1Click:Connect(function()
    isAntiVoid = not isAntiVoid
    if isAntiVoid then
        AntiVoidBtn.Text = "Anti-void ON"
        AntiVoidBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 65)
        StatusLabel.Text = "Status: Anti-void combo active"
        voidEnableProtection()
    else
        AntiVoidBtn.Text = "Anti-void OFF"
        AntiVoidBtn.BackgroundColor3 = Color3.fromRGB(130, 35, 35)
        StatusLabel.Text = "Status: Idle"
        if not voidPlatform then
            voidDisableProtection()
        end
    end
end)

pcall(function()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if isAntiVoid and method == "FireServer" and tostring(self) == "Communicate" then
            local data = args[1]
            if type(data) == "table" and (data.Goal == "PingCheck" or data.Goal == "delete bv") then
                return nil
            end
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
end)

-- Кнопка Safe-zone (Void TP на платформу)
SafeZoneBtn.MouseButton1Click:Connect(function()
    if voidBusy then return end
    voidBusy = true
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        SafeZoneBtn.Text = "No HRP"
        task.wait(1)
        SafeZoneBtn.Text = "Safe-zone"
        voidBusy = false
        return
    end
    voidSavedCFrame = hrp.CFrame
    voidEnableProtection()
    task.wait(0.1)
    if voidPlatform then voidPlatform:Destroy() end
    voidPlatform = Instance.new("Part")
    voidPlatform.Name = "VoidPlatform"
    voidPlatform.Size = Vector3.new(2000, 5, 2000)
    voidPlatform.Position = Vector3.new(hrp.Position.X, -5000, hrp.Position.Z)
    voidPlatform.Anchored = true
    voidPlatform.CanCollide = true
    voidPlatform.Color = Color3.fromRGB(15, 15, 20)
    voidPlatform.Material = Enum.Material.SmoothPlastic
    voidPlatform.Transparency = 0.2
    voidPlatform.Parent = workspace

    hrp.CFrame = CFrame.new(hrp.Position.X, -4997, hrp.Position.Z)
    SafeZoneBtn.Text = "In Void"
    StatusLabel.Text = "Status: In safe-zone (saved)"
    task.wait(1)
    SafeZoneBtn.Text = "Safe-zone"
    voidBusy = false
end)

-- Кнопка Safe-back (возврат из Void TP)
SafeBackBtn.MouseButton1Click:Connect(function()
    if voidBusy then return end
    voidBusy = true
    if not voidSavedCFrame then
        SafeBackBtn.Text = "No saved"
        task.wait(1)
        SafeBackBtn.Text = "Safe-back"
        voidBusy = false
        return
    end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        SafeBackBtn.Text = "No HRP"
        task.wait(1)
        SafeBackBtn.Text = "Safe-back"
        voidBusy = false
        return
    end
    hrp.CFrame = voidSavedCFrame
    if voidPlatform then
        voidPlatform:Destroy()
        voidPlatform = nil
    end
    if not isAntiVoid then
        voidDisableProtection()
    end
    SafeBackBtn.Text = "Returned"
    StatusLabel.Text = "Status: Returned back"
    task.wait(1)
    SafeBackBtn.Text = "Safe-back"
    voidBusy = false
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
    isAntiVoid = false
    voidDisableProtection()
    ScreenGui:Destroy()
end)

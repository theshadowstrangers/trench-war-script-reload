-- ==================== INTERACT SPY ====================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("InteractSpyGui") then
    CoreGui.InteractSpyGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "InteractSpyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- ==================== БУФЕР ====================
local function copyToClipboard(text)
    if setclipboard then setclipboard(text) return true end
    if setrbxclipboard then setrbxclipboard(text) return true end
    if toclipboard then toclipboard(text) return true end
    return false
end

-- ==================== НАСТРОЙКИ ====================
local enabledTouch = true
local enabledClick = true
local enabledProx = true
local realTime = false
local MAX_LIMIT = 500

local COLOR_TOUCH = Color3.fromRGB(0, 200, 80)
local COLOR_CLICK = Color3.fromRGB(60, 60, 60)
local COLOR_PROX = Color3.fromRGB(80, 180, 255)

-- ==================== СПИСОК СЕРВИСОВ ====================
local SERVICES = {
    Workspace = true, ReplicatedStorage = true, ReplicatedFirst = true,
    ServerScriptService = true, ServerStorage = true,
    StarterGui = true, StarterPack = true, StarterPlayer = true,
    SoundService = true, Lighting = true, Chat = true,
    LocalizationService = true, Players = true, RunService = true,
    TweenService = true, HttpService = true, TeleportService = true,
    MarketplaceService = true, DataStoreService = true,
    BadgeService = true, GroupService = true, TextService = true,
    UserInputService = true, ContextActionService = true,
    GuiService = true, HapticService = true, VRService = true,
    PathfindingService = true, PhysicsService = true,
    CollectionService = true, ContentProvider = true,
    InsertService = true, JointService = true, LogService = true,
    MessageBusService = true, NetworkClient = true, NetworkServer = true,
    NotificationService = true, PhysicsSettings = true,
    PolicyService = true, ProximityPromptService = true,
    RbxAnalyticsService = true, ScriptContext = true,
    ScriptService = true, Selection = true, SocialService = true,
    Stats = true, StudioService = true, TextChatService = true,
    TouchInputService = true, UserService = true, VoiceChatService = true
}

local function buildPath(obj)
    if not obj then return "nil" end
    if obj == game then return "game" end
    local parts = {}
    local cur = obj
    while cur and cur ~= game do
        table.insert(parts, 1, cur.Name)
        cur = cur.Parent
    end
    if #parts == 0 then return "game" end
    local first = parts[1]
    local result
    if first == "Workspace" then
        result = "workspace"
    elseif SERVICES[first] then
        result = 'game:GetService("' .. first .. '")'
    else
        if first:match("^%a[%w_]*$") then
            result = "game." .. first
        else
            result = 'game["' .. first .. '"]'
        end
    end
    for i = 2, #parts do
        local name = parts[i]
        if name:match("^%a[%w_]*$") then
            result = result .. "." .. name
        else
            result = result .. '["' .. name .. '"]'
        end
    end
    return result
end

-- ==================== МИНИ-КНОПКА ====================
local MiniBtn = Instance.new("TextButton", ScreenGui)
MiniBtn.Size = UDim2.new(0, 110, 0, 22)
MiniBtn.Position = UDim2.new(0.5, -55, 0, 5)
MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MiniBtn.BorderSizePixel = 0
MiniBtn.Text = "Interact Spy"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Font = Enum.Font.Gotham
MiniBtn.TextSize = 10
MiniBtn.AutoButtonColor = false
MiniBtn.Visible = false
MiniBtn.ZIndex = 100
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(0, 4)

-- ==================== ГЛАВНОЕ ОКНО ====================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 340)
Main.Position = UDim2.new(0.5, -250, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(50, 50, 50)
MainStroke.Thickness = 1

-- Звёзды
local StarField = Instance.new("Frame", Main)
StarField.Size = UDim2.new(1, 0, 1, 0)
StarField.BackgroundTransparency = 1
StarField.ClipsDescendants = true
StarField.ZIndex = 0

local stars = {}
for i = 1, 80 do
    local star = Instance.new("Frame", StarField)
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BorderSizePixel = 0
    star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.ZIndex = 0
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    star.BackgroundTransparency = math.random(30, 80) / 100
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

-- Заголовок
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 24)
Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Top.BorderSizePixel = 0
Top.ZIndex = 2
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel", Top)
Title.Text = "Interact Spy"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.ZIndex = 2

local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.Size = UDim2.new(0, 22, 0, 22)
Close.Position = UDim2.new(1, -24, 0, 1)
Close.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Close.BorderSizePixel = 0
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.Gotham
Close.TextSize = 13
Close.AutoButtonColor = false
Close.ZIndex = 3
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 3)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Minimize = Instance.new("TextButton", Top)
Minimize.Text = "<"
Minimize.Size = UDim2.new(0, 22, 0, 22)
Minimize.Position = UDim2.new(1, -48, 0, 1)
Minimize.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Minimize.BorderSizePixel = 0
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.Font = Enum.Font.Gotham
Minimize.TextSize = 11
Minimize.AutoButtonColor = false
Minimize.ZIndex = 3
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 3)

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniBtn.Visible = true
end)
MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniBtn.Visible = false
end)

-- Контент
local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, -8, 1, -56)
ContentFrame.Position = UDim2.new(0, 4, 0, 26)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 2

-- ==================== INFO ====================
local InfoTab = Instance.new("Frame", ContentFrame)
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfoTab.BorderSizePixel = 0
InfoTab.ZIndex = 2
InfoTab.Visible = true
Instance.new("UICorner", InfoTab).CornerRadius = UDim.new(0, 4)

local InfoLabel = Instance.new("TextLabel", InfoTab)
InfoLabel.Size = UDim2.new(1, -10, 1, -10)
InfoLabel.Position = UDim2.new(0, 5, 0, 5)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Interact Spy\n\nОбозреватель всех интерактивных объектов.\n\n• TouchInterest — зелёный\n• ClickDetector — чёрный\n• ProximityPrompt — голубой\n\nFire / Copy / Copy-Script / Teleport / Locate"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextWrapped = true
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 10
InfoLabel.ZIndex = 3

-- ==================== INTERACT-EX ====================
local ExTab = Instance.new("Frame", ContentFrame)
ExTab.Size = UDim2.new(1, 0, 1, 0)
ExTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExTab.BorderSizePixel = 0
ExTab.ZIndex = 2
ExTab.Visible = false
Instance.new("UICorner", ExTab).CornerRadius = UDim.new(0, 4)

-- Поиск
local SearchBox = Instance.new("TextBox", ExTab)
SearchBox.Size = UDim2.new(0.55, -60, 0, 22)
SearchBox.Position = UDim2.new(0, 5, 0, 5)
SearchBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SearchBox.BorderSizePixel = 0
SearchBox.PlaceholderText = "Поиск объекта (например: konfeta)..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Font = Enum.Font.Code
SearchBox.TextSize = 10
SearchBox.ClearTextOnFocus = false
SearchBox.ZIndex = 3
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

local FindBtn = Instance.new("TextButton", ExTab)
FindBtn.Size = UDim2.new(0, 55, 0, 22)
FindBtn.Position = UDim2.new(0.55, -58, 0, 5)
FindBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
FindBtn.BorderSizePixel = 0
FindBtn.Text = "Find"
FindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FindBtn.Font = Enum.Font.GothamBold
FindBtn.TextSize = 10
FindBtn.AutoButtonColor = false
FindBtn.ZIndex = 3
Instance.new("UICorner", FindBtn).CornerRadius = UDim.new(0, 4)

-- Счётчик
local CounterLabel = Instance.new("TextLabel", ExTab)
CounterLabel.Size = UDim2.new(0.45, -4, 0, 22)
CounterLabel.Position = UDim2.new(0.55, 4, 0, 5)
CounterLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
CounterLabel.BorderSizePixel = 0
CounterLabel.Text = "T:0 C:0 P:0 | 0"
CounterLabel.TextColor3 = Color3.fromRGB(180, 200, 220)
CounterLabel.Font = Enum.Font.Code
CounterLabel.TextSize = 10
CounterLabel.ZIndex = 3
Instance.new("UICorner", CounterLabel).CornerRadius = UDim.new(0, 4)

-- Левая панель
local ListScroll = Instance.new("ScrollingFrame", ExTab)
ListScroll.Size = UDim2.new(0.55, -6, 1, -40)
ListScroll.Position = UDim2.new(0, 5, 0, 30)
ListScroll.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 4
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListScroll.ZIndex = 3
Instance.new("UICorner", ListScroll).CornerRadius = UDim.new(0, 4)

local ListLayout = Instance.new("UIListLayout", ListScroll)
ListLayout.Padding = UDim.new(0, 1)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Правая панель
local DetailFrame = Instance.new("Frame", ExTab)
DetailFrame.Size = UDim2.new(0.45, -4, 1, -10)
DetailFrame.Position = UDim2.new(0.55, 1, 0, 5)
DetailFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
DetailFrame.BorderSizePixel = 0
DetailFrame.ZIndex = 3
Instance.new("UICorner", DetailFrame).CornerRadius = UDim.new(0, 4)

local DetailLabel = Instance.new("TextLabel", DetailFrame)
DetailLabel.Size = UDim2.new(1, -8, 1, -164)
DetailLabel.Position = UDim2.new(0, 4, 0, 4)
DetailLabel.BackgroundTransparency = 1
DetailLabel.Text = "-- выбери объект слева --"
DetailLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DetailLabel.TextXAlignment = Enum.TextXAlignment.Left
DetailLabel.TextYAlignment = Enum.TextYAlignment.Top
DetailLabel.TextWrapped = true
DetailLabel.Font = Enum.Font.Code
DetailLabel.TextSize = 9
DetailLabel.ZIndex = 4

local DBtnHolder = Instance.new("Frame", DetailFrame)
DBtnHolder.Size = UDim2.new(1, -8, 0, 156)
DBtnHolder.Position = UDim2.new(0, 4, 1, -160)
DBtnHolder.BackgroundTransparency = 1
DBtnHolder.ZIndex = 4

local function createDBtn(text, y, color)
    local b = Instance.new("TextButton", DBtnHolder)
    b.Size = UDim2.new(1, 0, 0, 24)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.AutoButtonColor = false
    b.ZIndex = 5
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

local FireBtn = createDBtn("Fire", 0, Color3.fromRGB(60, 30, 80))
local CopyBtn = createDBtn("Copy", 27, Color3.fromRGB(30, 50, 80))
local CopyScriptBtn = createDBtn("Copy-Script", 54, Color3.fromRGB(40, 40, 90))
local TpBtn = createDBtn("Teleport", 81, Color3.fromRGB(30, 70, 40))
local LocateBtn = createDBtn("Locate: OFF", 108, Color3.fromRGB(60, 40, 20))

-- ==================== SETTINGS ====================
local SetTab = Instance.new("Frame", ContentFrame)
SetTab.Size = UDim2.new(1, 0, 1, 0)
SetTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SetTab.BorderSizePixel = 0
SetTab.ZIndex = 2
SetTab.Visible = false
Instance.new("UICorner", SetTab).CornerRadius = UDim.new(0, 4)

local SetScroll = Instance.new("ScrollingFrame", SetTab)
SetScroll.Size = UDim2.new(1, -10, 1, -10)
SetScroll.Position = UDim2.new(0, 5, 0, 5)
SetScroll.BackgroundTransparency = 1
SetScroll.BorderSizePixel = 0
SetScroll.ScrollBarThickness = 3
SetScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
SetScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SetScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SetScroll.ZIndex = 3
local SetLayout = Instance.new("UIListLayout", SetScroll)
SetLayout.Padding = UDim.new(0, 5)
SetLayout.SortOrder = Enum.SortOrder.LayoutOrder

local InteractLabel = Instance.new("TextLabel", SetScroll)
InteractLabel.Size = UDim2.new(1, -4, 0, 16)
InteractLabel.BackgroundTransparency = 1
InteractLabel.Text = "Interact:"
InteractLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InteractLabel.TextXAlignment = Enum.TextXAlignment.Left
InteractLabel.Font = Enum.Font.GothamBold
InteractLabel.TextSize = 11
InteractLabel.ZIndex = 3

local function createToggle(text, defaultOn)
    local b = Instance.new("TextButton", SetScroll)
    b.Size = UDim2.new(1, -4, 0, 26)
    b.BackgroundColor3 = defaultOn and Color3.fromRGB(20, 60, 20) or Color3.fromRGB(40, 20, 20)
    b.BorderSizePixel = 0
    b.Text = text .. (defaultOn and "  ✓" or "  ×")
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    b.ZIndex = 3
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

local TouchTgl = createToggle("TouchInterest", true)
local ClickTgl = createToggle("ClickDetector", true)
local ProxTgl = createToggle("ProximityPrompt", true)

local RTLabel = Instance.new("TextLabel", SetScroll)
RTLabel.Size = UDim2.new(1, -4, 0, 16)
RTLabel.BackgroundTransparency = 1
RTLabel.Text = "Real-time:"
RTLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
RTLabel.TextXAlignment = Enum.TextXAlignment.Left
RTLabel.Font = Enum.Font.GothamBold
RTLabel.TextSize = 11
RTLabel.ZIndex = 3

local RTBtn = Instance.new("TextButton", SetScroll)
RTBtn.Size = UDim2.new(1, -4, 0, 26)
RTBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
RTBtn.BorderSizePixel = 0
RTBtn.Text = "Real-time: ×"
RTBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RTBtn.Font = Enum.Font.GothamBold
RTBtn.TextSize = 11
RTBtn.AutoButtonColor = false
RTBtn.ZIndex = 3
Instance.new("UICorner", RTBtn).CornerRadius = UDim.new(0, 4)

local LimitLabel = Instance.new("TextLabel", SetScroll)
LimitLabel.Size = UDim2.new(1, -4, 0, 16)
LimitLabel.BackgroundTransparency = 1
LimitLabel.Text = "Limit (по умолчанию 500):"
LimitLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
LimitLabel.TextXAlignment = Enum.TextXAlignment.Left
LimitLabel.Font = Enum.Font.GothamBold
LimitLabel.TextSize = 11
LimitLabel.ZIndex = 3

local LimitInput = Instance.new("TextBox", SetScroll)
LimitInput.Size = UDim2.new(1, -4, 0, 26)
LimitInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LimitInput.BorderSizePixel = 0
LimitInput.Text = tostring(MAX_LIMIT)
LimitInput.TextColor3 = Color3.fromRGB(255, 255, 255)
LimitInput.Font = Enum.Font.Code
LimitInput.TextSize = 11
LimitInput.ClearTextOnFocus = false
LimitInput.ZIndex = 3
Instance.new("UICorner", LimitInput).CornerRadius = UDim.new(0, 4)

local SetLimitBtn = Instance.new("TextButton", SetScroll)
SetLimitBtn.Size = UDim2.new(1, -8, 0, 26)
SetLimitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SetLimitBtn.BorderSizePixel = 0
SetLimitBtn.Text = "Set limit"
SetLimitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SetLimitBtn.Font = Enum.Font.GothamBold
SetLimitBtn.TextSize = 11
SetLimitBtn.AutoButtonColor = false
SetLimitBtn.ZIndex = 3
Instance.new("UICorner", SetLimitBtn).CornerRadius = UDim.new(0, 4)

-- ==================== НИЖНИЕ ВКЛАДКИ ====================
local TabsBar = Instance.new("Frame", Main)
TabsBar.Size = UDim2.new(1, -8, 0, 24)
TabsBar.Position = UDim2.new(0, 4, 1, -26)
TabsBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TabsBar.BorderSizePixel = 0
TabsBar.ZIndex = 2
Instance.new("UICorner", TabsBar).CornerRadius = UDim.new(0, 4)

local TabsList = Instance.new("UIListLayout", TabsBar)
TabsList.FillDirection = Enum.FillDirection.Horizontal
TabsList.Padding = UDim.new(0, 4)
TabsList.VerticalAlignment = Enum.VerticalAlignment.Center
TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabBtn(name, target)
    local btn = Instance.new("TextButton", TabsBar)
    btn.Size = UDim2.new(0, 100, 0, 18)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)
    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        ExTab.Visible = false
        SetTab.Visible = false
        target.Visible = true
        for _, c in pairs(TabsBar:GetChildren()) do
            if c:IsA("TextButton") then
                c.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                c.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

createTabBtn("Info", InfoTab)
createTabBtn("Interact-Ex", ExTab)
createTabBtn("Settings", SetTab)

-- ==================== ЛОГИКА ====================
local interactList = {}
local selectedIndex = nil
local rowMap = {}
local locateActive = false
local locateHighlight = nil
local locateBillboard = nil
local locateTarget = nil
local searchQuery = ""

local function getInteractType(obj)
    if obj:IsA("TouchTransmitter") then return "touch" end
    if obj:IsA("ClickDetector") then return "click" end
    if obj:IsA("ProximityPrompt") then return "prox" end
    return nil
end

local function getShortName(obj, itype)
    local parentName = obj.Parent and obj.Parent.Name or "?"
    local suffix = itype == "touch" and "TouchInterest" or (itype == "click" and "ClickDetector" or "ProximityPrompt")
    return parentName .. "." .. suffix
end

local function getFullPath(obj)
    return obj:GetFullName()
end

local function matchesSearch(obj)
    if searchQuery == "" then return true end
    local parentName = obj.Parent and obj.Parent.Name or ""
    return string.find(string.lower(parentName), string.lower(searchQuery), 1, true) ~= nil
end

local function getTypeDetails(obj, itype)
    local lines = {}
    if itype == "touch" then
        if obj.Parent then
            table.insert(lines, "")
            table.insert(lines, "-- Parent info --")
            table.insert(lines, "Class: " .. obj.Parent.ClassName)
            if obj.Parent:IsA("BasePart") then
                table.insert(lines, "Transparency: " .. string.format("%.2f", obj.Parent.Transparency))
                table.insert(lines, "CanCollide: " .. tostring(obj.Parent.CanCollide))
                table.insert(lines, "Anchored: " .. tostring(obj.Parent.Anchored))
            end
        end
    elseif itype == "click" then
        table.insert(lines, "")
        table.insert(lines, "-- ClickDetector info --")
        table.insert(lines, "MaxActivationDistance: " .. tostring(obj.MaxActivationDistance))
        table.insert(lines, "CursorIcon: " .. tostring(obj.CursorIcon))
    elseif itype == "prox" then
        table.insert(lines, "")
        table.insert(lines, "-- ProximityPrompt info --")
        table.insert(lines, "ActionText: " .. tostring(obj.ActionText))
        table.insert(lines, "ObjectText: " .. tostring(obj.ObjectText))
        table.insert(lines, "HoldDuration: " .. string.format("%.2f", obj.HoldDuration))
        table.insert(lines, "MaxActivationDistance: " .. tostring(obj.MaxActivationDistance))
        table.insert(lines, "RequiresLineOfSight: " .. tostring(obj.RequiresLineOfSight))
        table.insert(lines, "Enabled: " .. tostring(obj.Enabled))
    end
    return table.concat(lines, "\n")
end

local function generateScript(obj, itype)
    local fullPath = buildPath(obj)
    local parentPath = buildPath(obj.Parent)

    local code = "-- script by Spynote\n"
    code = code .. "-- Interact Spy generated\n"
    code = code .. "-- Path: " .. obj:GetFullName() .. "\n"
    code = code .. "-- Type: " .. (itype == "touch" and "TouchInterest" or (itype == "click" and "ClickDetector" or "ProximityPrompt")) .. "\n\n"

    if itype == "touch" then
        code = code .. "local TouchPart = " .. parentPath .. "\n"
        code = code .. "local LocalPlayer = game:GetService(\"Players\").LocalPlayer\n"
        code = code .. "local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()\n"
        code = code .. "local Root = Character:WaitForChild(\"HumanoidRootPart\")\n\n"
        code = code .. "-- Fire TouchInterest\n"
        code = code .. "firetouchinterest(TouchPart, Root, 0)\n"
        code = code .. "task.wait(0.05)\n"
        code = code .. "firetouchinterest(TouchPart, Root, 1)\n"
    elseif itype == "click" then
        code = code .. "local ClickDetector = " .. fullPath .. "\n\n"
        code = code .. "-- Fire ClickDetector\n"
        code = code .. "fireclickdetector(ClickDetector)\n"
    else
        code = code .. "local ProximityPrompt = " .. fullPath .. "\n\n"
        code = code .. "-- Fire ProximityPrompt\n"
        code = code .. "fireproximityprompt(ProximityPrompt)\n"
    end

    return code
end

local function createRow(entry, idx)
    local obj = entry.obj
    local itype = entry.type

    local row = Instance.new("TextButton", ListScroll)
    row.Size = UDim2.new(1, -4, 0, 18)
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.ZIndex = 3
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 3)

    local bgColor
    if itype == "touch" then bgColor = Color3.fromRGB(20, 50, 30)
    elseif itype == "click" then bgColor = Color3.fromRGB(25, 25, 25)
    else bgColor = Color3.fromRGB(20, 40, 60) end
    row.BackgroundColor3 = bgColor

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1, -6, 1, 0)
    label.Position = UDim2.new(0, 6, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "#" .. idx .. "  " .. getShortName(obj, itype)
    label.TextColor3 = itype == "touch" and COLOR_TOUCH or (itype == "click" and Color3.fromRGB(220, 220, 220) or COLOR_PROX)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = 9
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 4

    row.MouseButton1Click:Connect(function()
        if not obj or not obj.Parent then
            row:Destroy()
            rowMap[idx] = nil
            return
        end

        selectedIndex = idx

        for _, c in pairs(ListScroll:GetChildren()) do
            if c:IsA("TextButton") then
                local lbl = c:FindFirstChildWhichIsA("TextLabel")
                if lbl then
                    local n = tonumber(lbl.Text:match("#(%d+)"))
                    if n and interactList[n] and interactList[n].type then
                        local t = interactList[n].type
                        if t == "touch" then
                            c.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
                        elseif t == "click" then
                            c.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        elseif t == "prox" then
                            c.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
                        end
                    end
                end
            end
        end
        row.BackgroundColor3 = Color3.fromRGB(80, 80, 100)

        local actualType = getInteractType(obj) or itype

        local typeName = "Unknown"
        if actualType == "touch" then typeName = "TouchInterest"
        elseif actualType == "click" then typeName = "ClickDetector"
        elseif actualType == "prox" then typeName = "ProximityPrompt" end

        local parentPath = obj.Parent and obj.Parent:GetFullName() or "?"
        local details = getTypeDetails(obj, actualType)

        DetailLabel.Text = "Path:\n" .. getFullPath(obj) ..
            "\n\nType: " .. typeName ..
            "\n\nParent: " .. parentPath ..
            "\n\nParent class: " .. (obj.Parent and obj.Parent.ClassName or "?") ..
            "\n" .. details

        if actualType == "touch" then
            FireBtn.Text = "Fire TouchInterest"
            FireBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
        elseif actualType == "click" then
            FireBtn.Text = "Fire ClickDetector"
            FireBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
        elseif actualType == "prox" then
            FireBtn.Text = "Fire ProximityPrompt"
            FireBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 80)
        end

        if locateActive then
            stopLocate()
            LocateBtn.Text = "Locate: OFF"
            LocateBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
        end
    end)

    rowMap[idx] = row
end

local function updateCounter()
    local t, c, p = 0, 0, 0
    for _, e in ipairs(interactList) do
        if e.type == "touch" then t = t + 1
        elseif e.type == "click" then c = c + 1
        else p = p + 1 end
    end
    CounterLabel.Text = "T:" .. t .. " C:" .. c .. " P:" .. p .. " | " .. #interactList
end

local function scanInteracts()
    for _, c in pairs(ListScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    interactList = {}
    rowMap = {}
    selectedIndex = nil

    for _, obj in ipairs(workspace:GetDescendants()) do
        if #interactList >= MAX_LIMIT then break end
        local itype = getInteractType(obj)
        if itype then
            if (itype == "touch" and enabledTouch) or
               (itype == "click" and enabledClick) or
               (itype == "prox" and enabledProx) then
                if matchesSearch(obj) then
                    table.insert(interactList, {type = itype, obj = obj})
                    createRow(interactList[#interactList], #interactList)
                end
            end
        end
    end

    updateCounter()
    print("[Interact Spy] Найдено: " .. #interactList)
end

local function realTimeRefresh()
    local toRemove = {}
    for idx, entry in pairs(interactList) do
        if not entry.obj or not entry.obj.Parent then
            table.insert(toRemove, idx)
        end
    end

    table.sort(toRemove, function(a, b) return a > b end)
    for _, idx in ipairs(toRemove) do
        if rowMap[idx] then
            rowMap[idx]:Destroy()
            rowMap[idx] = nil
        end
        table.remove(interactList, idx)

        if selectedIndex == idx then
            selectedIndex = nil
            DetailLabel.Text = "-- выбери объект слева --"
            FireBtn.Text = "Fire"
            if locateActive then
                stopLocate()
                LocateBtn.Text = "Locate: OFF"
                LocateBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
            end
        elseif selectedIndex and selectedIndex > idx then
            selectedIndex = selectedIndex - 1
        end
    end

    if #toRemove > 0 then
        for _, c in pairs(ListScroll:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        rowMap = {}
        for i, entry in ipairs(interactList) do
            createRow(entry, i)
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if #interactList >= MAX_LIMIT then break end
        local itype = getInteractType(obj)
        if itype then
            if (itype == "touch" and enabledTouch) or
               (itype == "click" and enabledClick) or
               (itype == "prox" and enabledProx) then
                if matchesSearch(obj) then
                    local exists = false
                    for _, e in ipairs(interactList) do
                        if e.obj == obj then exists = true break end
                    end
                    if not exists then
                        table.insert(interactList, {type = itype, obj = obj})
                        createRow(interactList[#interactList], #interactList)
                    end
                end
            end
        end
    end

    updateCounter()
end

-- ==================== ПОИСК ====================
FindBtn.MouseButton1Click:Connect(function()
    searchQuery = SearchBox.Text
    scanInteracts()
    FindBtn.Text = "OK"
    task.wait(0.4)
    FindBtn.Text = "Find"
end)

SearchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        searchQuery = SearchBox.Text
        scanInteracts()
    end
end)

-- ==================== FIRE ====================
FireBtn.MouseButton1Click:Connect(function()
    if not selectedIndex or not interactList[selectedIndex] then
        FireBtn.Text = "Выбери"
        task.wait(0.6)
        return
    end
    local entry = interactList[selectedIndex]
    if not entry.obj or not entry.obj.Parent then
        FireBtn.Text = "✗ Мёртв"
        task.wait(0.6)
        return
    end
    local obj = entry.obj
    local itype = getInteractType(obj) or entry.type
    local old = FireBtn.Text

    if itype == "touch" then
        local parent = obj.Parent
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if parent and myRoot then
            pcall(function()
                firetouchinterest(parent, myRoot, 0)
                task.wait(0.05)
                firetouchinterest(parent, myRoot, 1)
            end)
            FireBtn.Text = "✓ Done"
        else
            FireBtn.Text = "✗ No part"
        end
    elseif itype == "click" then
        pcall(function()
            if fireclickdetector then fireclickdetector(obj) end
        end)
        FireBtn.Text = "✓ Done"
    else
        pcall(function()
            if fireproximityprompt then fireproximityprompt(obj) end
        end)
        FireBtn.Text = "✓ Done"
    end
    task.wait(0.6)
    FireBtn.Text = old
end)

-- ==================== COPY ====================
CopyBtn.MouseButton1Click:Connect(function()
    if not selectedIndex or not interactList[selectedIndex] then
        CopyBtn.Text = "Выбери"
        task.wait(0.6)
        CopyBtn.Text = "Copy"
        return
    end
    local entry = interactList[selectedIndex]
    if not entry.obj or not entry.obj.Parent then
        CopyBtn.Text = "✗ Мёртв"
        task.wait(0.6)
        CopyBtn.Text = "Copy"
        return
    end
    local typeName = entry.type == "touch" and "TouchInterest" or (entry.type == "click" and "ClickDetector" or "ProximityPrompt")
    local info = "Path: " .. getFullPath(entry.obj) ..
                 "\nType: " .. typeName ..
                 "\nParent: " .. (entry.obj.Parent and entry.obj.Parent:GetFullName() or "?") ..
                 "\n" .. getTypeDetails(entry.obj, entry.type)
    local ok = copyToClipboard(info)
    CopyBtn.Text = ok and "✓ OK" or "✗ No"
    task.wait(0.6)
    CopyBtn.Text = "Copy"
end)

-- ==================== COPY-SCRIPT ====================
CopyScriptBtn.MouseButton1Click:Connect(function()
    if not selectedIndex or not interactList[selectedIndex] then
        CopyScriptBtn.Text = "Выбери"
        task.wait(0.6)
        CopyScriptBtn.Text = "Copy-Script"
        return
    end
    local entry = interactList[selectedIndex]
    if not entry.obj or not entry.obj.Parent then
        CopyScriptBtn.Text = "✗ Мёртв"
        task.wait(0.6)
        CopyScriptBtn.Text = "Copy-Script"
        return
    end
    local script = generateScript(entry.obj, entry.type)
    local ok = copyToClipboard(script)
    CopyScriptBtn.Text = ok and "✓ Copied" or "✗ No"
    task.wait(0.8)
    CopyScriptBtn.Text = "Copy-Script"
end)

-- ==================== TELEPORT ====================
TpBtn.MouseButton1Click:Connect(function()
    if not selectedIndex or not interactList[selectedIndex] then
        TpBtn.Text = "Выбери"
        task.wait(0.6)
        TpBtn.Text = "Teleport"
        return
    end
    local entry = interactList[selectedIndex]
    if not entry.obj or not entry.obj.Parent then
        TpBtn.Text = "✗ Мёртв"
        task.wait(0.6)
        TpBtn.Text = "Teleport"
        return
    end
    local parent = entry.obj.Parent
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then
        TpBtn.Text = "Нет чара"
        task.wait(0.6)
        TpBtn.Text = "Teleport"
        return
    end
    local pos = nil
    if parent then
        if parent:IsA("BasePart") then
            pos = parent.CFrame
        elseif parent:IsA("Model") then
            local pp = parent.PrimaryPart or parent:FindFirstChildWhichIsA("BasePart")
            if pp then pos = pp.CFrame end
        end
    end
    if pos then
        myRoot.CFrame = pos + Vector3.new(0, 5, 0)
        TpBtn.Text = "✓ TP"
    else
        TpBtn.Text = "✗ Нет поз"
    end
    task.wait(0.6)
    TpBtn.Text = "Teleport"
end)

-- ==================== LOCATE ====================
local function stopLocate()
    locateActive = false
    if locateHighlight then pcall(function() locateHighlight:Destroy() end) locateHighlight = nil end
    if locateBillboard then pcall(function() locateBillboard:Destroy() end) locateBillboard = nil end
    locateTarget = nil
end

local function startLocate()
    if not selectedIndex or not interactList[selectedIndex] then return false end
    local entry = interactList[selectedIndex]
    if not entry.obj or not entry.obj.Parent then return false end
    local parent = entry.obj.Parent
    if not parent then return false end

    local target = parent
    if parent:IsA("BasePart") then target = parent
    elseif parent:IsA("Model") then target = parent
    end
    if not target then return false end

    locateTarget = target
    locateActive = true

    locateHighlight = Instance.new("Highlight", target)
    locateHighlight.Adornee = target
    locateHighlight.FillColor = Color3.fromRGB(255, 0, 0)
    locateHighlight.FillTransparency = 0.5
    locateHighlight.OutlineColor = Color3.fromRGB(255, 0, 0)

    local anchorPart = target:IsA("BasePart") and target or (target:FindFirstChildWhichIsA("BasePart") or target.PrimaryPart)
    if anchorPart then
        locateBillboard = Instance.new("BillboardGui", anchorPart)
        locateBillboard.Size = UDim2.new(0, 120, 0, 28)
        locateBillboard.StudsOffset = Vector3.new(0, 3, 0)
        locateBillboard.AlwaysOnTop = true

        local txt = Instance.new("TextLabel", locateBillboard)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.TextColor3 = Color3.fromRGB(255, 60, 60)
        txt.TextStrokeTransparency = 0
        txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        txt.TextSize = 9
        txt.Font = Enum.Font.GothamBold
        txt.Text = target.Name .. "\nstuds: ?"

        task.spawn(function()
            while locateActive and locateBillboard and locateBillboard.Parent and anchorPart.Parent do
                local myChar = LP.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local dist = math.floor((myRoot.Position - anchorPart.Position).Magnitude)
                    txt.Text = target.Name .. "\nstuds: " .. dist
                end
                task.wait(0.2)
            end
        end)
    end
    return true
end

LocateBtn.MouseButton1Click:Connect(function()
    if not selectedIndex or not interactList[selectedIndex] then
        LocateBtn.Text = "Выбери"
        task.wait(0.6)
        LocateBtn.Text = locateActive and "Locate: ON" or "Locate: OFF"
        return
    end
    if locateActive then
        stopLocate()
        LocateBtn.Text = "Locate: OFF"
        LocateBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
    else
        local ok = startLocate()
        if ok and locateActive then
            LocateBtn.Text = "Locate: ON"
            LocateBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
        else
            LocateBtn.Text = "✗ Ошибка"
            task.wait(0.6)
            LocateBtn.Text = "Locate: OFF"
        end
    end
end)

-- ==================== SETTINGS КНОПКИ ====================
TouchTgl.MouseButton1Click:Connect(function()
    enabledTouch = not enabledTouch
    TouchTgl.Text = "TouchInterest" .. (enabledTouch and "  ✓" or "  ×")
    TouchTgl.BackgroundColor3 = enabledTouch and Color3.fromRGB(20, 60, 20) or Color3.fromRGB(40, 20, 20)
    scanInteracts()
end)

ClickTgl.MouseButton1Click:Connect(function()
    enabledClick = not enabledClick
    ClickTgl.Text = "ClickDetector" .. (enabledClick and "  ✓" or "  ×")
    ClickTgl.BackgroundColor3 = enabledClick and Color3.fromRGB(20, 60, 20) or Color3.fromRGB(40, 20, 20)
    scanInteracts()
end)

ProxTgl.MouseButton1Click:Connect(function()
    enabledProx = not enabledProx
    ProxTgl.Text = "ProximityPrompt" .. (enabledProx and "  ✓" or "  ×")
    ProxTgl.BackgroundColor3 = enabledProx and Color3.fromRGB(20, 60, 20) or Color3.fromRGB(40, 20, 20)
    scanInteracts()
end)

-- ==================== REAL-TIME ====================
local rtConn = nil

RTBtn.MouseButton1Click:Connect(function()
    realTime = not realTime
    if realTime then
        RTBtn.Text = "Real-time: ✓"
        RTBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
        if rtConn then rtConn:Disconnect() end
        rtConn = workspace.DescendantAdded:Connect(function(obj)
            if not realTime then return end
            if #interactList >= MAX_LIMIT then return end
            local itype = getInteractType(obj)
            if not itype then return end
            if (itype == "touch" and not enabledTouch) or
               (itype == "click" and not enabledClick) or
               (itype == "prox" and not enabledProx) then return end
            if not matchesSearch(obj) then return end
            for _, e in ipairs(interactList) do
                if e.obj == obj then return end
            end
            table.insert(interactList, {type = itype, obj = obj})
            createRow(interactList[#interactList], #interactList)
            updateCounter()
        end)
    else
        RTBtn.Text = "Real-time: ×"
        RTBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
        if rtConn then rtConn:Disconnect() rtConn = nil end
    end
end)

-- ==================== SET LIMIT ====================
SetLimitBtn.MouseButton1Click:Connect(function()
    local val = tonumber(LimitInput.Text)
    if val and val > 0 then
        MAX_LIMIT = math.floor(val)
        SetLimitBtn.Text = "✓ " .. MAX_LIMIT
        task.wait(0.5)
        SetLimitBtn.Text = "Set limit"
        task.spawn(function() scanInteracts() end)
    else
        SetLimitBtn.Text = "Invalid"
        task.wait(0.6)
        SetLimitBtn.Text = "Set limit"
    end
end)

task.spawn(function()
    while ScreenGui.Parent do
        if realTime then
            pcall(realTimeRefresh)
        end
        task.wait(1.5)
    end
end)

-- ==================== СТАРТ ====================
task.spawn(function()
    scanInteracts()
end)

print("[Interact Spy] LoL Loaded.")

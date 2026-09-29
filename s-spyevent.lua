-- ==================== SPY EVENT ====================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("SpyEventGui") then CoreGui.SpyEventGui:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "SpyEventGui"
Screen.ResetOnSpawn = false
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.IgnoreGuiInset = true

-- ==================== БУФЕР ОБМЕНА ====================
local function copyToClipboard(text)
    if setclipboard then setclipboard(text) return true end
    if setrbxclipboard then setrbxclipboard(text) return true end
    if toclipboard then toclipboard(text) return true end
    if set_clipboard then set_clipboard(text) return true end
    if syn and syn.write_clipboard then syn.write_clipboard(text) return true end
    if Clipboard and Clipboard.set then Clipboard.set(text) return true end
    return false
end

-- ==================== МИНИ-КНОПКА ====================
local MiniBtn = Instance.new("TextButton", Screen)
MiniBtn.Size = UDim2.new(0, 80, 0, 26)
MiniBtn.Position = UDim2.new(0.5, -40, 0, 5)
MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MiniBtn.BorderSizePixel = 0
MiniBtn.Text = "SpyEvent"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Font = Enum.Font.Gotham
MiniBtn.TextSize = 11
MiniBtn.AutoButtonColor = false
MiniBtn.Visible = false
MiniBtn.ZIndex = 100
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(0, 4)

-- ==================== ГЛАВНОЕ ОКНО ====================
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 380, 0, 320)
Main.Position = UDim2.new(0.5, -190, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 40, 40)
MainStroke.Thickness = 1

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 24)
Top.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Top.BorderSizePixel = 0
Top.ZIndex = 2

local Title = Instance.new("TextLabel", Top)
Title.Text = "Simple SpyEvent"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Gotham
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
Close.TextSize = 14
Close.AutoButtonColor = false
Close.ZIndex = 3
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 3)
Close.MouseButton1Click:Connect(function() Screen:Destroy() end)

local Minimize = Instance.new("TextButton", Top)
Minimize.Text = "<"
Minimize.Size = UDim2.new(0, 22, 0, 22)
Minimize.Position = UDim2.new(1, -48, 0, 1)
Minimize.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Minimize.BorderSizePixel = 0
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.Font = Enum.Font.Gotham
Minimize.TextSize = 12
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

local ContentFrame = Instance.new("Frame", Main)
ContentFrame.Size = UDim2.new(1, -10, 1, -60)
ContentFrame.Position = UDim2.new(0, 5, 0, 28)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 2

-- Info
local InfoTab = Instance.new("Frame", ContentFrame)
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
InfoTab.BorderSizePixel = 0
InfoTab.ZIndex = 2
InfoTab.Visible = true
Instance.new("UICorner", InfoTab).CornerRadius = UDim.new(0, 4)

local InfoLabel = Instance.new("TextLabel", InfoTab)
InfoLabel.Size = UDim2.new(1, -12, 1, -12)
InfoLabel.Position = UDim2.new(0, 6, 0, 6)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "SpyEvent\n\nПерехват исходящих RemoteEvent и RemoteFunction\n\n• Info — инфо\n• Note — список событий\n• Settings — настройки"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextWrapped = true
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 10
InfoLabel.ZIndex = 3

-- ==================== ФУНКЦИЯ СОЗДАНИЯ ВКЛАДКИ ====================
local function createSpyTab(parent)
    local tab = Instance.new("Frame", parent)
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tab.BorderSizePixel = 0
    tab.ZIndex = 2
    tab.Visible = false
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 4)

    local leftPanel = Instance.new("ScrollingFrame", tab)
    leftPanel.Size = UDim2.new(0.4, -4, 1, -118)
    leftPanel.Position = UDim2.new(0, 4, 0, 4)
    leftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    leftPanel.BorderSizePixel = 0
    leftPanel.ScrollBarThickness = 3
    leftPanel.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    leftPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    leftPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    leftPanel.ZIndex = 3
    Instance.new("UICorner", leftPanel).CornerRadius = UDim.new(0, 3)

    local leftList = Instance.new("UIListLayout", leftPanel)
    leftList.Padding = UDim.new(0, 2)
    leftList.SortOrder = Enum.SortOrder.LayoutOrder

    local rightPanel = Instance.new("ScrollingFrame", tab)
    rightPanel.Size = UDim2.new(0.6, -6, 1, -118)
    rightPanel.Position = UDim2.new(0.4, 2, 0, 4)
    rightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    rightPanel.BorderSizePixel = 0
    rightPanel.ScrollBarThickness = 3
    rightPanel.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    rightPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    rightPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightPanel.ZIndex = 3
    Instance.new("UICorner", rightPanel).CornerRadius = UDim.new(0, 3)

    local rightText = Instance.new("TextLabel", rightPanel)
    rightText.Size = UDim2.new(1, -8, 0, 20)
    rightText.Position = UDim2.new(0, 4, 0, 4)
    rightText.BackgroundTransparency = 1
    rightText.Text = "-- выбери --"
    rightText.TextColor3 = Color3.fromRGB(220, 220, 220)
    rightText.TextXAlignment = Enum.TextXAlignment.Left
    rightText.TextYAlignment = Enum.TextYAlignment.Top
    rightText.TextWrapped = true
    rightText.Font = Enum.Font.Code
    rightText.TextSize = 9
    rightText.ZIndex = 3
    rightText.AutomaticSize = Enum.AutomaticSize.Y

    local bottomPanel = Instance.new("Frame", tab)
    bottomPanel.Size = UDim2.new(1, -8, 0, 110)
    bottomPanel.Position = UDim2.new(0, 4, 1, -114)
    bottomPanel.BackgroundTransparency = 1
    bottomPanel.ZIndex = 3

    local function createBtn(text, x, y, w, h, color)
        local b = Instance.new("TextButton", bottomPanel)
        b.Size = UDim2.new(w, -2, 0, h)
        b.Position = UDim2.new(x, 2, 0, y)
        b.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.Gotham
        b.TextSize = 10
        b.AutoButtonColor = false
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
        return b
    end

    local BtnH = 26
    local FireBtn = createBtn("Fire", 0, 0, 0.5, BtnH)
    local CopyBtn = createBtn("Copy", 0.5, 0, 0.5, BtnH)
    local SpamBtn = createBtn("Spam", 0, BtnH + 2, 0.5, BtnH)
    local ClearBtn = createBtn("Clear", 0.5, BtnH + 2, 0.5, BtnH)
    local BlockBtn = createBtn("Block", 0, (BtnH + 2) * 2, 0.5, BtnH, Color3.fromRGB(80, 30, 30))
    local UnblockBtn = createBtn("Unblock", 0.5, (BtnH + 2) * 2, 0.5, BtnH, Color3.fromRGB(30, 60, 80))
    local CopyInfoBtn = createBtn("CopyInfo", 0, (BtnH + 2) * 3, 1, BtnH)

    return {
        tab = tab,
        leftPanel = leftPanel,
        rightPanel = rightPanel,
        rightText = rightText,
        bottomPanel = bottomPanel,
        FireBtn = FireBtn,
        CopyBtn = CopyBtn,
        SpamBtn = SpamBtn,
        ClearBtn = ClearBtn,
        BlockBtn = BlockBtn,
        UnblockBtn = UnblockBtn,
        CopyInfoBtn = CopyInfoBtn
    }
end

local NoteUI = createSpyTab(ContentFrame)

-- Settings
local SettingsTab = Instance.new("Frame", ContentFrame)
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
SettingsTab.BorderSizePixel = 0
SettingsTab.ZIndex = 2
SettingsTab.Visible = false
Instance.new("UICorner", SettingsTab).CornerRadius = UDim.new(0, 4)

local HookLabel = Instance.new("TextLabel", SettingsTab)
HookLabel.Size = UDim2.new(1, -12, 0, 18)
HookLabel.Position = UDim2.new(0, 6, 0, 4)
HookLabel.BackgroundTransparency = 1
HookLabel.Text = "Hooking:"
HookLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
HookLabel.TextXAlignment = Enum.TextXAlignment.Left
HookLabel.Font = Enum.Font.GothamBold
HookLabel.TextSize = 11
HookLabel.ZIndex = 3

local RemoteEventToggle = Instance.new("TextButton", SettingsTab)
RemoteEventToggle.Size = UDim2.new(1, -12, 0, 28)
RemoteEventToggle.Position = UDim2.new(0, 6, 0, 26)
RemoteEventToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RemoteEventToggle.BorderSizePixel = 0
RemoteEventToggle.Text = "RemoteEvent  ✓"
RemoteEventToggle.TextColor3 = Color3.fromRGB(0, 200, 100)
RemoteEventToggle.Font = Enum.Font.GothamBold
RemoteEventToggle.TextSize = 11
RemoteEventToggle.AutoButtonColor = false
RemoteEventToggle.ZIndex = 3
Instance.new("UICorner", RemoteEventToggle).CornerRadius = UDim.new(0, 4)

local RemoteFunctionToggle = Instance.new("TextButton", SettingsTab)
RemoteFunctionToggle.Size = UDim2.new(1, -12, 0, 28)
RemoteFunctionToggle.Position = UDim2.new(0, 6, 0, 58)
RemoteFunctionToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RemoteFunctionToggle.BorderSizePixel = 0
RemoteFunctionToggle.Text = "RemoteFunction  ✓"
RemoteFunctionToggle.TextColor3 = Color3.fromRGB(0, 200, 100)
RemoteFunctionToggle.Font = Enum.Font.GothamBold
RemoteFunctionToggle.TextSize = 11
RemoteFunctionToggle.AutoButtonColor = false
RemoteFunctionToggle.ZIndex = 3
Instance.new("UICorner", RemoteFunctionToggle).CornerRadius = UDim.new(0, 4)

-- ==================== НИЖНИЕ ВКЛАДКИ ====================
local TabsBar = Instance.new("Frame", Main)
TabsBar.Size = UDim2.new(1, -10, 0, 26)
TabsBar.Position = UDim2.new(0, 5, 1, -30)
TabsBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
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
    btn.Size = UDim2.new(0, 90, 0, 20)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)
    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        NoteUI.tab.Visible = false
        SettingsTab.Visible = false
        target.Visible = true
        for _, c in pairs(TabsBar:GetChildren()) do
            if c:IsA("TextButton") then
                c.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                c.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

local infoTabBtn = createTabBtn("Info", InfoTab)
local noteTabBtn = createTabBtn("Note", NoteUI.tab)
local settingsTabBtn = createTabBtn("Settings", SettingsTab)

infoTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
infoTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

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
    local current = obj
    while current and current ~= game do
        table.insert(parts, 1, current.Name)
        current = current.Parent
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

-- ==================== ЛОГИКА ====================
local MAX_EVENTS = 5000
local MAX_QUEUE = 500

local hookRemoteEvent = true
local hookRemoteFunction = true

local function fmt(v, depth)
    depth = depth or 0
    if depth > 2 then return "..." end
    local t = type(v)
    if t == "string" then
        if #v > 80 then return string.format("%q", v:sub(1, 80)) end
        return string.format("%q", v)
    elseif t == "number" then
        if v == math.floor(v) and math.abs(v) < 1e9 then return tostring(v) end
        return string.format("%.4f", v)
    elseif t == "boolean" then
        return tostring(v)
    elseif t == "nil" then
        return "nil"
    elseif t == "Vector3" then
        return string.format("Vector3.new(%.2f, %.2f, %.2f)", v.X, v.Y, v.Z)
    elseif t == "CFrame" then
        local p = v.Position
        return string.format("CFrame.new(%.2f, %.2f, %.2f)", p.X, p.Y, p.Z)
    elseif t == "Color3" then
        return string.format("Color3.fromRGB(%d, %d, %d)", math.floor(v.R*255), math.floor(v.G*255), math.floor(v.B*255))
    elseif t == "EnumItem" then
        return tostring(v)
    elseif t == "Instance" then
        return buildPath(v)
    elseif t == "table" then
        local count = 0
        local maxN = 0
        for k in pairs(v) do
            count = count + 1
            if type(k) == "number" and k > maxN then maxN = k end
            if count > 10 then return "{...}" end
        end
        local parts = {}
        for i = 1, maxN do
            if v[i] ~= nil then table.insert(parts, fmt(v[i], depth + 1)) end
        end
        for k, val in pairs(v) do
            if not (type(k) == "number" and k >= 1 and k == math.floor(k) and k <= maxN) then
                local keyStr
                if type(k) == "string" and k:match("^%a[%w_]*$") then keyStr = k
                else keyStr = "[" .. fmt(k, depth + 1) .. "]" end
                table.insert(parts, keyStr .. " = " .. fmt(val, depth + 1))
                if #parts > 12 then break end
            end
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    end
    return tostring(v)
end

-- ==================== ГЕНЕРАЦИЯ ====================
local function generateCode(e)
    local path = buildPath(e.event)
    local argsStr = {}
    for i = 1, #e.args do
        table.insert(argsStr, "    " .. fmt(e.args[i]))
    end

    local code = "-- Type: " .. (e.isFunction and "RemoteFunction" or "RemoteEvent") .. "\n"
    code = code .. "-- This code was generated by SpyEvent\n\n"

    if e.isFunction then
        code = code .. "local Event = " .. path .. "\n"
        code = code .. "Event:InvokeServer(\n"
        code = code .. table.concat(argsStr, ",\n")
        code = code .. "\n)"
    else
        code = code .. "local Event = " .. path .. "\n"
        code = code .. "Event:FireServer(\n"
        code = code .. table.concat(argsStr, ",\n")
        code = code .. "\n)"
    end

    return code
end

local function generateInfo(e)
    local path = buildPath(e.event)
    local kind = e.isFunction and "RemoteFunction" or "RemoteEvent"
    local call = e.isFunction and ":InvokeServer" or ":FireServer"

    local lines = {}
    table.insert(lines, "Type: " .. kind)
    table.insert(lines, "Name: " .. e.name)
    table.insert(lines, "Path: " .. path)
    table.insert(lines, "Call: " .. call)
    table.insert(lines, "Args: " .. #e.args)

    return table.concat(lines, "\n")
end

-- ==================== NOTE — ОЧЕРЕДЬ ====================
local noteEvents = {}
local noteSelectedIndex = nil
local noteQueue = {}
local noteCurrentCode = ""
local noteSpamActive = false
local noteSpamThread = nil
local noteBlocked = {}

local function noteShowEventInfo(index)
    local e = noteEvents[index]
    if not e then return end
    noteCurrentCode = generateCode(e)
    NoteUI.rightText.Text = noteCurrentCode
end

task.spawn(function()
    while Screen.Parent do
        local processed = 0
        while #noteQueue > 0 and processed < 10 do
            local evt = table.remove(noteQueue, 1)
            if evt then
                table.insert(noteEvents, evt)
                local idx = #noteEvents

                local btn = Instance.new("TextButton", NoteUI.leftPanel)
                btn.Size = UDim2.new(1, -4, 0, 20)
                if evt.isFunction then
                    btn.BackgroundColor3 = Color3.fromRGB(140, 80, 200)
                else
                    btn.BackgroundColor3 = Color3.fromRGB(200, 110, 40)
                end
                btn.BorderSizePixel = 0
                btn.Text = "#" .. idx .. " " .. evt.name
                btn.TextColor3 = Color3.fromRGB(230, 230, 230)
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 9
                btn.AutoButtonColor = false
                btn.ZIndex = 3
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)

                btn.MouseButton1Click:Connect(function()
                    noteSelectedIndex = idx
                    for _, c in pairs(NoteUI.leftPanel:GetChildren()) do
                        if c:IsA("TextButton") then
                            local num = tonumber(c.Text:match("#(%d+)"))
                            local evt2 = num and noteEvents[num]
                            if evt2 then
                                if evt2.isFunction then
                                    c.BackgroundColor3 = Color3.fromRGB(140, 80, 200)
                                else
                                    c.BackgroundColor3 = Color3.fromRGB(200, 110, 40)
                                end
                            end
                        end
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    noteShowEventInfo(idx)
                end)

                if #noteEvents > MAX_EVENTS then
                    local first = NoteUI.leftPanel:FindFirstChildWhichIsA("TextButton")
                    if first then first:Destroy() end
                    table.remove(noteEvents, 1)
                end
            end
            processed = processed + 1
        end
        task.wait(0.15)
    end
end)

-- ==================== ХУК ====================
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if method == "FireServer" and hookRemoteEvent and self.ClassName == "RemoteEvent" then
        if not noteBlocked[self.Name] and #noteQueue < MAX_QUEUE then
            table.insert(noteQueue, {
                name = self.Name,
                event = self,
                args = {...},
                isFunction = false
            })
        end
    elseif method == "InvokeServer" and hookRemoteFunction and self.ClassName == "RemoteFunction" then
        if not noteBlocked[self.Name] and #noteQueue < MAX_QUEUE then
            table.insert(noteQueue, {
                name = self.Name,
                event = self,
                args = {...},
                isFunction = true
            })
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

-- ==================== ОКНО UNBLOCK ====================
local function openUnblockWindow(blockedTable, title)
    if Screen:FindFirstChild("UnblockWindow") then
        Screen.UnblockWindow:Destroy()
    end

    local win = Instance.new("Frame", Screen)
    win.Name = "UnblockWindow"
    win.Size = UDim2.new(0, 220, 0, 240)
    win.Position = UDim2.new(0.5, -110, 0.5, -120)
    win.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    win.BorderSizePixel = 0
    win.Active = true
    win.Draggable = true
    win.ZIndex = 200
    Instance.new("UICorner", win).CornerRadius = UDim.new(0, 6)

    local winStroke = Instance.new("UIStroke", win)
    winStroke.Color = Color3.fromRGB(60, 60, 60)
    winStroke.Thickness = 1

    local wTop = Instance.new("Frame", win)
    wTop.Size = UDim2.new(1, 0, 0, 24)
    wTop.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    wTop.BorderSizePixel = 0
    wTop.ZIndex = 201

    local wTitle = Instance.new("TextLabel", wTop)
    wTitle.Text = "Unblock - " .. title
    wTitle.Size = UDim2.new(1, -30, 1, 0)
    wTitle.Position = UDim2.new(0, 8, 0, 0)
    wTitle.BackgroundTransparency = 1
    wTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    wTitle.TextXAlignment = Enum.TextXAlignment.Left
    wTitle.Font = Enum.Font.Gotham
    wTitle.TextSize = 11
    wTitle.ZIndex = 202

    local wClose = Instance.new("TextButton", wTop)
    wClose.Text = "×"
    wClose.Size = UDim2.new(0, 22, 0, 22)
    wClose.Position = UDim2.new(1, -24, 0, 1)
    wClose.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    wClose.BorderSizePixel = 0
    wClose.TextColor3 = Color3.fromRGB(255, 255, 255)
    wClose.Font = Enum.Font.Gotham
    wClose.TextSize = 14
    wClose.AutoButtonColor = false
    wClose.ZIndex = 203
    Instance.new("UICorner", wClose).CornerRadius = UDim.new(0, 3)
    wClose.MouseButton1Click:Connect(function() win:Destroy() end)

    local scroll = Instance.new("ScrollingFrame", win)
    scroll.Size = UDim2.new(1, -12, 1, -36)
    scroll.Position = UDim2.new(0, 6, 0, 30)
    scroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 201
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 3)

    local sList = Instance.new("UIListLayout", scroll)
    sList.Padding = UDim.new(0, 2)

    local count = 0
    for name, _ in pairs(blockedTable) do
        count = count + 1
        local b = Instance.new("TextButton", scroll)
        b.Size = UDim2.new(1, -4, 0, 22)
        b.BackgroundColor3 = Color3.fromRGB(30, 60, 80)
        b.BorderSizePixel = 0
        b.Text = "✕ " .. name
        b.TextColor3 = Color3.fromRGB(220, 220, 220)
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Font = Enum.Font.Gotham
        b.TextSize = 10
        b.AutoButtonColor = false
        b.ZIndex = 202
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)

        b.MouseButton1Click:Connect(function()
            blockedTable[name] = nil
            b:Destroy()
            if count <= 1 then
                task.wait(0.1)
                win:Destroy()
            end
        end)
    end

    if count == 0 then
        local lbl = Instance.new("TextLabel", scroll)
        lbl.Size = UDim2.new(1, -4, 0, 30)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Нет заблокированных"
        lbl.TextColor3 = Color3.fromRGB(150, 150, 150)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 10
        lbl.ZIndex = 202
    end
end

-- ==================== NOTE — КНОПКИ ====================
NoteUI.FireBtn.MouseButton1Click:Connect(function()
    if not noteSelectedIndex then
        NoteUI.FireBtn.Text = "Нет"; task.wait(0.6); NoteUI.FireBtn.Text = "Fire"; return
    end
    local e = noteEvents[noteSelectedIndex]
    if not e or not e.event or not e.event.Parent then
        NoteUI.FireBtn.Text = "Нет"; task.wait(0.6); NoteUI.FireBtn.Text = "Fire"; return
    end
    if e.isFunction then
        pcall(function() e.event:InvokeServer(unpack(e.args)) end)
    else
        pcall(function() e.event:FireServer(unpack(e.args)) end)
    end
    NoteUI.FireBtn.Text = "OK"; task.wait(0.5); NoteUI.FireBtn.Text = "Fire"
end)

NoteUI.CopyBtn.MouseButton1Click:Connect(function()
    if noteCurrentCode == "" then
        NoteUI.CopyBtn.Text = "Нет"; task.wait(0.6); NoteUI.CopyBtn.Text = "Copy"; return
    end
    local ok = copyToClipboard(noteCurrentCode)
    NoteUI.CopyBtn.Text = ok and "OK" or "No"
    task.wait(0.5); NoteUI.CopyBtn.Text = "Copy"
end)

NoteUI.SpamBtn.MouseButton1Click:Connect(function()
    if not noteSelectedIndex or not noteEvents[noteSelectedIndex] then
        NoteUI.SpamBtn.Text = "Нет"; task.wait(0.6); NoteUI.SpamBtn.Text = "Spam"; return
    end
    noteSpamActive = not noteSpamActive
    if noteSpamActive then
        NoteUI.SpamBtn.Text = "ON"
        NoteUI.SpamBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        noteSpamThread = task.spawn(function()
            while noteSpamActive do
                local e = noteEvents[noteSelectedIndex]
                if e and e.event and e.event.Parent then
                    if e.isFunction then
                        pcall(function() e.event:InvokeServer(unpack(e.args)) end)
                    else
                        pcall(function() e.event:FireServer(unpack(e.args)) end)
                    end
                end
                task.wait()
            end
        end)
    else
        NoteUI.SpamBtn.Text = "Spam"
        NoteUI.SpamBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        if noteSpamThread then task.cancel(noteSpamThread) noteSpamThread = nil end
    end
end)

NoteUI.ClearBtn.MouseButton1Click:Connect(function()
    noteSpamActive = false
    if noteSpamThread then task.cancel(noteSpamThread) noteSpamThread = nil end
    NoteUI.SpamBtn.Text = "Spam"
    NoteUI.SpamBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    for _, c in pairs(NoteUI.leftPanel:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    noteEvents = {}; noteSelectedIndex = nil; noteQueue = {}; noteCurrentCode = ""
    NoteUI.rightText.Text = "-- выбери --"
    NoteUI.ClearBtn.Text = "OK"; task.wait(0.6); NoteUI.ClearBtn.Text = "Clear"
end)

NoteUI.BlockBtn.MouseButton1Click:Connect(function()
    if not noteSelectedIndex or not noteEvents[noteSelectedIndex] then
        NoteUI.BlockBtn.Text = "Нет"; task.wait(0.6); NoteUI.BlockBtn.Text = "Block"; return
    end
    local e = noteEvents[noteSelectedIndex]
    if not e then return end
    local name = e.name
    noteBlocked[name] = true
    for _, c in pairs(NoteUI.leftPanel:GetChildren()) do
        if c:IsA("TextButton") then
            local num = tonumber(c.Text:match("#(%d+)"))
            local evt2 = num and noteEvents[num]
            if evt2 and evt2.name == name then c:Destroy() end
        end
    end
    local newQ = {}
    for _, evt in ipairs(noteQueue) do
        if evt.name ~= name then table.insert(newQ, evt) end
    end
    noteQueue = newQ
    noteSelectedIndex = nil; noteCurrentCode = ""
    NoteUI.rightText.Text = "-- " .. name .. " заблокирован --"
    NoteUI.BlockBtn.Text = "OK"; task.wait(0.6); NoteUI.BlockBtn.Text = "Block"
end)

NoteUI.UnblockBtn.MouseButton1Click:Connect(function()
    openUnblockWindow(noteBlocked, "Note")
end)

NoteUI.CopyInfoBtn.MouseButton1Click:Connect(function()
    if not noteSelectedIndex or not noteEvents[noteSelectedIndex] then
        NoteUI.CopyInfoBtn.Text = "Нет"; task.wait(0.6); NoteUI.CopyInfoBtn.Text = "CopyInfo"; return
    end
    local info = generateInfo(noteEvents[noteSelectedIndex])
    local ok = copyToClipboard(info)
    NoteUI.CopyInfoBtn.Text = ok and "OK" or "No"
    task.wait(0.5); NoteUI.CopyInfoBtn.Text = "CopyInfo"
end)

-- ==================== SETTINGS ====================
RemoteEventToggle.MouseButton1Click:Connect(function()
    hookRemoteEvent = not hookRemoteEvent
    RemoteEventToggle.Text = "RemoteEvent  " .. (hookRemoteEvent and "✓" or "×")
    RemoteEventToggle.TextColor3 = hookRemoteEvent and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
end)

RemoteFunctionToggle.MouseButton1Click:Connect(function()
    hookRemoteFunction = not hookRemoteFunction
    RemoteFunctionToggle.Text = "RemoteFunction  " .. (hookRemoteFunction and "✓" or "×")
    RemoteFunctionToggle.TextColor3 = hookRemoteFunction and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
end)

print("[Simple SpyEvent] loaded.")

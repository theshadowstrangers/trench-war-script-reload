-- Void Hub Fixed + Auto-Refresh + Auto Prompt + Stars BG
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("VoidHub") then CoreGui.VoidHub:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "VoidHub"
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.IgnoreGuiInset = true

-- ==================== ГЛАВНОЕ ОКНО ====================
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 420, 0, 300)
Main.Position = UDim2.new(0.5, -210, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(80, 50, 160)
MainStroke.Thickness = 1.3

-- ==================== ФОН СО ЗВЁЗДАМИ ====================
local StarField = Instance.new("Frame", Main)
StarField.Name = "StarField"
StarField.Size = UDim2.new(1, 0, 1, 0)
StarField.BackgroundTransparency = 1
StarField.ClipsDescendants = true
StarField.ZIndex = 0

local stars = {}
for i = 1, 60 do
    local star = Instance.new("Frame", StarField)
    star.Name = "Star" .. i
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
    while Screen.Parent do
        for _, s in pairs(stars) do
            if s.frame and s.frame.Parent then
                s.frame.BackgroundTransparency = 0.3 + math.abs(math.sin(tick() * s.speed * 10 + s.offset)) * 0.6
            end
        end
        task.wait(0.05)
    end
end)

-- ==================== ВЕРХНЯЯ ПАНЕЛЬ ====================
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 30)
Top.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
Top.BorderSizePixel = 0
Top.ZIndex = 2
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Top)
Title.Text = "  ✦ Void Hub"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(200, 160, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.ZIndex = 2

local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.Size = UDim2.new(0, 26, 0, 26)
Close.Position = UDim2.new(1, -28, 0, 2)
Close.BackgroundColor3 = Color3.fromRGB(120, 30, 50)
Close.BorderSizePixel = 0
Close.TextColor3 = Color3.fromRGB(255, 200, 200)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.AutoButtonColor = false
Close.ZIndex = 3
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
Close.MouseButton1Click:Connect(function() Screen:Destroy() end)

local Minimize = Instance.new("TextButton", Top)
Minimize.Text = "<"
Minimize.Size = UDim2.new(0, 26, 0, 26)
Minimize.Position = UDim2.new(1, -56, 0, 2)
Minimize.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
Minimize.BorderSizePixel = 0
Minimize.TextColor3 = Color3.fromRGB(220, 210, 255)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14
Minimize.AutoButtonColor = false
Minimize.ZIndex = 3
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 6)

-- ==================== SIDEBAR ====================
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 110, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 5, 18)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -110, 1, -30)
Container.Position = UDim2.new(0, 110, 0, 30)
Container.BackgroundTransparency = 1
Container.ZIndex = 2

local Minimized = false
Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        Main:TweenSize(UDim2.new(0, 420, 0, 30), "Out", "Quad", 0.2, true)
        Minimize.Text = ">"
    else
        Main:TweenSize(UDim2.new(0, 420, 0, 300), "Out", "Quad", 0.2, true)
        Minimize.Text = "<"
    end
end)

local Pages = {}
local Buttons = {}

local function CreateTab(name, color)
    local p = Instance.new("ScrollingFrame", Container)
    p.Size = UDim2.new(1, -10, 1, -10)
    p.Position = UDim2.new(0, 5, 0, 5)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.BorderSizePixel = 0
    p.ScrollBarThickness = 3
    p.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 220)
    p.CanvasSize = UDim2.new(0, 0, 0, 0)
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.ZIndex = 3

    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 5)

    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -8, 0, 32)
    btn.Position = UDim2.new(0, 4, 0, 4 + #Buttons * 36)
    btn.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 170, 210)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        for _, pg in pairs(Pages) do pg.Visible = false end
        for _, b in pairs(Buttons) do
            b.TextColor3 = Color3.fromRGB(180, 170, 210)
            b.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
        end
        p.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 220, 100)
        btn.BackgroundColor3 = color
    end)

    table.insert(Pages, p)
    table.insert(Buttons, btn)
    return p
end

-- Tabs
local TabEsp = CreateTab("Esp", Color3.fromRGB(60, 40, 120))
local TabKeys = CreateTab("Grab Keys", Color3.fromRGB(120, 40, 60))
local TabDoors = CreateTab("Door TP", Color3.fromRGB(40, 100, 60))
local TabItems = CreateTab("Items Grab", Color3.fromRGB(120, 100, 40))
local TabPapers = CreateTab("Grab Papers", Color3.fromRGB(100, 50, 150))
local TabFaul = CreateTab("Faul_Grab", Color3.fromRGB(50, 100, 150))

-- ==================== ЦВЕТА ESP ====================
local ESP_COLORS = {
    items = Color3.fromRGB(0, 255, 0),      -- Items — зелёный
    keys = Color3.fromRGB(255, 215, 0),     -- Keys — золотой
    papers = Color3.fromRGB(200, 100, 255), -- Papers — фиолетовый
    faul = Color3.fromRGB(0, 200, 255),     -- Fuel — голубой
    locust = Color3.fromRGB(255, 0, 0)      -- Locust — красный
}

local espState = {items = false, keys = false, locust = false, papers = false, faul = false}

local function ApplyEsp(obj, customName, colorKey)
    if not obj or obj:FindFirstChild("VoidTag") then return end
    local bg = Instance.new("BillboardGui", obj)
    bg.Name = "VoidTag"
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(0, 100, 0, 30)
    bg.Enabled = false

    local txt = Instance.new("TextLabel", bg)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = ESP_COLORS[colorKey] or Color3.new(1,1,1)
    txt.TextStrokeTransparency = 0
    txt.TextSize = 12
    txt.Font = Enum.Font.GothamBold

    local displayName = customName or obj.Name

    local conn
    conn = RunService.Stepped:Connect(function()
        if not obj.Parent then conn:Disconnect() return end
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.Position or obj:GetModelCFrame().p) or (obj:IsA("BasePart") and obj.Position or Vector3.new(0,0,0))
            local dist = math.floor((LP.Character.HumanoidRootPart.Position - pos).Magnitude)
            txt.Text = displayName .. "\n[studs: " .. dist .. "]"
        end
    end)
    return bg
end

local function SetupEspFolder(folderName, stateKey, colorKey)
    task.spawn(function()
        local folder = workspace:WaitForChild(folderName, 5)
        if folder then
            folder.ChildAdded:Connect(function(child)
                local tag = ApplyEsp(child, nil, colorKey)
                if tag then tag.Enabled = espState[stateKey] end
            end)
            for _, x in pairs(folder:GetChildren()) do ApplyEsp(x, nil, colorKey) end
        end
    end)
end

SetupEspFolder("ActiveEquipments", "items", "items")
SetupEspFolder("ActiveKeys", "keys", "keys")
SetupEspFolder("ActivePapers", "papers", "papers")
SetupEspFolder("ActiveFuel", "faul", "faul")

-- Locust ESP Setup
task.spawn(function()
    while task.wait(2) do
        local targets = {"BlackLocust", "PlayerBlackLocust"}
        for _, name in pairs(targets) do
            local locust = workspace:FindFirstChild(name)
            if locust then
                local tag = ApplyEsp(locust, name == "BlackLocust" and "Locust" or "Player Locust", "locust")
                if tag then tag.Enabled = espState.locust end
            end
        end
    end
end)

local function CreateToggle(parent, text, type)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -5, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
    b.TextColor3 = Color3.fromRGB(255, 80, 80)
    b.Text = text .. ": OFF"
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.ZIndex = 3
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

    b.MouseButton1Click:Connect(function()
        espState[type] = not espState[type]
        b.Text = text .. (espState[type] and ": ON" or ": OFF")
        b.TextColor3 = espState[type] and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)

        if type == "locust" then
            local targets = {"BlackLocust", "PlayerBlackLocust"}
            for _, name in pairs(targets) do
                local locust = workspace:FindFirstChild(name)
                if locust and locust:FindFirstChild("VoidTag") then
                    locust.VoidTag.Enabled = espState.locust
                end
            end
        else
            local fName = (type == "items" and "ActiveEquipments") or (type == "keys" and "ActiveKeys") or (type == "papers" and "ActivePapers") or (type == "faul" and "ActiveFuel")
            local folder = workspace:FindFirstChild(fName)
            if folder then
                for _, x in pairs(folder:GetChildren()) do
                    local tag = x:FindFirstChild("VoidTag")
                    if tag then tag.Enabled = espState[type] end
                end
            end
        end
    end)
end

CreateToggle(TabEsp, "ESP Items", "items")
CreateToggle(TabEsp, "ESP Keys", "keys")
CreateToggle(TabEsp, "ESP Papers", "papers")
CreateToggle(TabEsp, "ESP Locust", "locust")
CreateToggle(TabEsp, "Esp Faul", "faul")

-- ==================== АВТО-АКТИВАЦИЯ PROXIMITYPROMPT (x5 за 0.04s) ====================
local function triggerPrompt(obj)
    if not obj then return end

    local prompt = obj:FindFirstChild("ProximityPrompt", true)
    if not prompt then
        local handle = obj:FindFirstChild("Handle")
        if handle then
            prompt = handle:FindFirstChild("ProximityPrompt")
        end
    end
    if not prompt then return end

    task.spawn(function()
        for i = 1, 5 do
            pcall(function()
                if fireproximityprompt then
                    fireproximityprompt(prompt)
                else
                    prompt:InputHoldBegin()
                    task.wait(prompt.HoldDuration > 0 and prompt.HoldDuration or 0.02)
                    prompt:InputHoldEnd()
                end
            end)
            task.wait(0.04)
        end
    end)
end

-- Auto-Refresh
local function RefreshList(folder, page)
    for _, child in pairs(page:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local cola = workspace:FindFirstChild("BloxyCola")
    if cola and page == TabItems then
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, -5, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(40, 25, 25)
        b.TextColor3 = Color3.fromRGB(255, 200, 0)
        b.Text = "TP: Bloxy Cola 🥤"
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local pos = cola:IsA("Model") and (cola.PrimaryPart and cola.PrimaryPart.CFrame or cola:GetModelCFrame()) or (cola:IsA("BasePart") and cola.CFrame)
                LP.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0, 3, 0)
                task.wait(0.1)
                triggerPrompt(cola)
            end
        end)
    end

    if not folder then return end

    local children = folder:GetChildren()
    for _, obj in pairs(children) do
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, -5, 0, 28)
        b.BackgroundColor3 = Color3.fromRGB(20, 15, 40)
        b.TextColor3 = Color3.fromRGB(200, 190, 230)
        b.Text = "TP: " .. obj.Name
        b.Font = Enum.Font.Gotham
        b.TextSize = 11
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

        b.MouseButton1Click:Connect(function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local pos = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.CFrame or obj:GetModelCFrame()) or (obj:IsA("BasePart") and obj.CFrame)
                if pos then
                    LP.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0, 3, 0)
                    task.wait(0.1)
                    triggerPrompt(obj)
                end
            end
        end)
    end
    page.CanvasSize = UDim2.new(0, 0, 0, (#children + (cola and 1 or 0)) * 33)
end

local function BindUpdate(folderName, page)
    task.spawn(function()
        local folder = workspace:WaitForChild(folderName, 5)

        if page == TabItems then
            workspace.ChildAdded:Connect(function(child) if child.Name == "BloxyCola" then RefreshList(folder, page) end end)
            workspace.ChildRemoved:Connect(function(child) if child.Name == "BloxyCola" then RefreshList(folder, page) end end)
        end

        if folder then
            folder.ChildAdded:Connect(function() RefreshList(folder, page) end)
            folder.ChildRemoved:Connect(function() RefreshList(folder, page) end)
            RefreshList(folder, page)
        else
            RefreshList(nil, page)
        end
    end)
end

BindUpdate("ActiveKeys", TabKeys)
BindUpdate("LockedDoors", TabDoors)
BindUpdate("ActiveEquipments", TabItems)
BindUpdate("ActivePapers", TabPapers)
BindUpdate("ActiveFuel", TabFaul)

-- Init
Buttons[1].BackgroundColor3 = Color3.fromRGB(60, 40, 120)
Buttons[1].TextColor3 = Color3.fromRGB(255, 220, 100)
Pages[1].Visible = true

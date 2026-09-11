local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local targetParent = localPlayer:WaitForChild("PlayerGui")

if targetParent:FindFirstChild("SimpleExecutorGui") then
    targetParent.SimpleExecutorGui:Destroy()
end

local espEnabled = false
local espObjects = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleExecutorGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = targetParent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 200)
mainFrame.Position = UDim2.new(0.5, -130, 0.4, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 50, 50)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "Auto-farm"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextSize = 22
closeBtn.Font = Enum.Font.Gotham
closeBtn.BackgroundTransparency = 1
closeBtn.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -65, 0, 2)
minimizeBtn.Text = "<"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Parent = topBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0, 220, 0, 40)
espBtn.Position = UDim2.new(0.5, -110, 0, 5)
espBtn.Text = "Esp killers: OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
espBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14
espBtn.Parent = contentFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = espBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(60, 60, 60)
btnStroke.Thickness = 1
btnStroke.Parent = espBtn

local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0, 220, 0, 40)
autoFarmBtn.Position = UDim2.new(0.5, -110, 0, 55)
autoFarmBtn.Text = "Auto farm: OFF"
autoFarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextSize = 14
autoFarmBtn.Parent = contentFrame

local autoFarmCorner = Instance.new("UICorner")
autoFarmCorner.CornerRadius = UDim.new(0, 6)
autoFarmCorner.Parent = autoFarmBtn

local autoFarmStroke = Instance.new("UIStroke")
autoFarmStroke.Color = Color3.fromRGB(60, 60, 60)
autoFarmStroke.Thickness = 1
autoFarmStroke.Parent = autoFarmBtn

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 260, 0, 35) or UDim2.new(0, 260, 0, 200)
    minimizeBtn.Text = minimized and ">" or "<"
    contentFrame.Visible = not minimized
    
    TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    espEnabled = false
    autoFarmEnabled = false
    for _, obj in pairs(espObjects) do
        if obj then
            for _, subObj in pairs(obj) do pcall(function() subObj:Destroy() end) end
        end
    end
    screenGui:Destroy()
end)

local function createESP(monster)
    if not monster:IsA("Model") or espObjects[monster] then return end
    
    local humanoid = monster:FindFirstChildOfClass("Humanoid")
    local root = monster:FindFirstChild("HumanoidRootPart") or monster.PrimaryPart
    
    if not humanoid or not root then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.6
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Adornee = monster
    highlight.Parent = screenGui

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPText"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = root
    billboard.Parent = screenGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.Parent = billboard

    espObjects[monster] = {highlight, billboard, textLabel}

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not espEnabled or not monster:IsDescendantOf(workspace) or not humanoid or humanoid.Health <= 0 then
            pcall(function() highlight:Destroy() end)
            pcall(function() billboard:Destroy() end)
            espObjects[monster] = nil
            connection:Disconnect()
            return
        end
        
        local currentHealth = math.floor(humanoid.Health)
        local maxHealth = math.floor(humanoid.MaxHealth)
        textLabel.Text = string.format("%s\nHP: %d / %d", monster.Name, currentHealth, maxHealth)
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if espEnabled then
            local killersFolder = workspace:FindFirstChild("Killers")
            if killersFolder then
                for _, descendant in pairs(killersFolder:GetDescendants()) do
                    if descendant:IsA("Model") and descendant:FindFirstChildOfClass("Humanoid") then
                        if not espObjects[descendant] then
                            createESP(descendant)
                        end
                    end
                end
            end
        end
    end
end)

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espBtn.Text = "Esp killers: ON"
        espBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        espBtn.Text = "Esp killers: OFF"
        espBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        for monster, elements in pairs(espObjects) do
            for _, obj in pairs(elements) do pcall(function() obj:Destroy() end) end
            espObjects[monster] = nil
        end
    end
end)

-- ==================== AUTO FARM ====================
local autoFarmEnabled = false

-- Функция проверки: есть ли хоть один живой киллер
local function hasAliveKillers()
    local killers = workspace:FindFirstChild("Killers")
    if not killers then return false end
    for _, desc in pairs(killers:GetDescendants()) do
        if desc:IsA("Model") then
            local humanoid = desc:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                return true
            end
        end
    end
    return false
end

-- Функция убийства (копия из classic-Area51.lua)
local function killAllKillersOnce()
    local backpack = localPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local hasWeapon = false
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
            hasWeapon = true
            break
        end
    end

    if not hasWeapon then
        local char = localPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local oldCF = root.CFrame
            local pistolCF = CFrame.new(-64.3158493, 735.329529, 18.362793, 0.0249549318, -1.01103925e-08, 0.999688566, 4.47392262e-11, 1, 1.01124256e-08, -0.999688566, -2.07629594e-10, 0.0249549318)
            root.CFrame = pistolCF
            task.wait(2)
            root.CFrame = oldCF
            task.wait(0.3)
        end
    end

    local hitEvent = nil
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
            local hit = tool:FindFirstChild("Hit")
            if hit then
                hitEvent = hit
                break
            end
        end
    end

    if not hitEvent then
        local char = localPlayer.Character
        if char then
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
                    local hit = tool:FindFirstChild("Hit")
                    if hit then
                        hitEvent = hit
                        break
                    end
                end
            end
        end
    end

    if not hitEvent then return end

    local killers = workspace:FindFirstChild("Killers")
    if not killers then return end

    for _, child in pairs(killers:GetChildren()) do
        if child:IsA("Model") then
            local zombie = child:FindFirstChild("Zombie")
            if zombie then
                for j = 1, 5 do
                    pcall(function()
                        hitEvent:FireServer(zombie, "Head")
                    end)
                end
            end
        end
    end
end

-- Цикл Auto farm
task.spawn(function()
    while task.wait(0.5) do
        if autoFarmEnabled then
            -- Проверяем, есть ли хоть один живой киллер
            if hasAliveKillers() then
                killAllKillersOnce()
            end
        end
    end
end)

autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        autoFarmBtn.Text = "Auto farm: ON"
        autoFarmBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        autoFarmBtn.Text = "Auto farm: OFF"
        autoFarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

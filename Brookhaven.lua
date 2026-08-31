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

ScreenGui.Name = "Brookhaven"
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
TitleLabel.Text = " Brookhaven"
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

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Brookhaven\nBy Spynote\nCreate in 2026 year"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Поле ввода ника
local inputLabel = Instance.new("TextLabel")
inputLabel.Size = UDim2.new(1, 0, 0, 20)
inputLabel.Text = ""
inputLabel.TextColor3 = Color3.new(1, 1, 1)
inputLabel.TextSize = 14
inputLabel.Font = Enum.Font.SourceSansBold
inputLabel.BackgroundTransparency = 1
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = exploitTab

local targetInput = Instance.new("TextBox")
targetInput.Size = UDim2.new(1, 0, 0, 25)
targetInput.PlaceholderText = "Enter name..."
targetInput.Text = ""
targetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
targetInput.TextColor3 = Color3.new(1, 1, 1)
targetInput.Font = Enum.Font.SourceSans
targetInput.TextSize = 14
targetInput.Parent = exploitTab
Instance.new("UICorner", targetInput).CornerRadius = UDim.new(0, 4)

local TargetPos = CFrame.new(12.5321894, -272.947388, 291.137085)

local function findTarget(name)
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

local function ensureCouch()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end
    
    if backpack:FindFirstChild("Couch") then
        return true
    end
    
    local event = ReplicatedStorage:FindFirstChild("RE")
    if event then
        event = event:FindFirstChild("1Too1l")
    end
    
    if not event then
        warn("Event not found")
        return false
    end
    
    pcall(function()
        event:InvokeServer("PickingTools", "Couch")
    end)
    
    task.wait(0.5)
    
    return backpack:FindFirstChild("Couch") ~= nil
end

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(1, 0, 0, 32)
killBtn.Text = "Kill"
killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
killBtn.Font = Enum.Font.SourceSansBold
killBtn.TextSize = 14
killBtn.BorderSizePixel = 0
killBtn.Parent = exploitTab
Instance.new("UICorner", killBtn).CornerRadius = UDim.new(0, 4)

killBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local target = findTarget(targetInput.Text)
    
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or not hrp then
        return
    end
    
    -- Убеждаемся что есть Couch
    if not ensureCouch() then
        warn("Couch not found")
        return
    end
    
    local oldPos = hrp.CFrame
    local couch = LocalPlayer.Backpack:FindFirstChild("Couch")
    
    if couch then
        couch.Parent = char
        hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        task.wait(2)
        hrp.CFrame = TargetPos
        task.wait(0.3)
        -- Убираем диван с рук сразу после телепортации
        if couch.Parent == char then
            couch.Parent = LocalPlayer.Backpack
        end
        task.wait(0.1)
        hrp.CFrame = oldPos
    end
end)

-- ==================== MISC ====================
local nameInputLabel = Instance.new("TextLabel")
nameInputLabel.Size = UDim2.new(1, 0, 0, 20)
nameInputLabel.Text = ""
nameInputLabel.TextColor3 = Color3.new(1, 1, 1)
nameInputLabel.TextSize = 14
nameInputLabel.Font = Enum.Font.SourceSansBold
nameInputLabel.BackgroundTransparency = 1
nameInputLabel.TextXAlignment = Enum.TextXAlignment.Left
nameInputLabel.Parent = miscTab

local nameInput = Instance.new("TextBox")
nameInput.Size = UDim2.new(1, 0, 0, 25)
nameInput.PlaceholderText = "Enter name..."
nameInput.Text = ""
nameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
nameInput.TextColor3 = Color3.new(1, 1, 1)
nameInput.Font = Enum.Font.SourceSans
nameInput.TextSize = 14
nameInput.Parent = miscTab
Instance.new("UICorner", nameInput).CornerRadius = UDim.new(0, 4)

-- КНОПКА SET NAME - ОДИН РАЗ БЕРЕТ ИМЯ ИЗ ПОЛЯ И ВЫПОЛНЯЕТ ЭВЕНТ
local setNameBtn = Instance.new("TextButton")
setNameBtn.Size = UDim2.new(1, 0, 0, 32)
setNameBtn.Text = "Set Name"
setNameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setNameBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
setNameBtn.Font = Enum.Font.SourceSansBold
setNameBtn.TextSize = 14
setNameBtn.BorderSizePixel = 0
setNameBtn.Parent = miscTab
Instance.new("UICorner", setNameBtn).CornerRadius = UDim.new(0, 4)

setNameBtn.MouseButton1Click:Connect(function()
    local event = ReplicatedStorage:FindFirstChild("RE")
    if event then
        event = event:FindFirstChild("1RPNam1eTex1t")
    end
    if event and nameInput.Text ~= "" then
        pcall(function()
            event:FireServer("RolePlayBio", nameInput.Text)
        end)
    end
end)

local isRainbow = false
local rainbowConnection = nil

local colors = {
    Color3.new(0, 0.13048458099365, 1), -- синий
    Color3.new(1, 0, 0.071661472320557), -- красный
    Color3.new(0.11028170585632, 1, 0), -- зелёный
    Color3.new(1, 0.9100107550621, 5.9604644775391e-08), -- жёлтый
    Color3.new(0.78051459789276, 0.02986466884613, 1), -- фиолетовый
    Color3.new(1, 5.9604644775391e-08, 0.80265235900879), -- розовый
    Color3.new(1, 0.62964773178101, 0), -- оранжевый
    Color3.new(0.9797688126564, 1, 0.96812200546265) -- белый
}

local function setColor(color)
    local event = ReplicatedStorage:FindFirstChild("RE")
    if event then
        event = event:FindFirstChild("1RPNam1eColo1r")
    end
    if event then
        pcall(function()
            event:FireServer("PickingRPBioColor", color)
        end)
    end
end

local function setBio(text)
    local event = ReplicatedStorage:FindFirstChild("RE")
    if event then
        event = event:FindFirstChild("1RPNam1eTex1t")
    end
    if event and text ~= "" then
        pcall(function()
            event:FireServer("RolePlayBio", text)
        end)
    end
end

local function startRainbow()
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    
    -- Сначала устанавливаем био
    setBio(nameInput.Text)
    
    rainbowConnection = RunService.Heartbeat:Connect(function()
        if not isRainbow then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
            return
        end
        
        local randomColor = colors[math.random(1, #colors)]
        setColor(randomColor)
    end)
end

local rainbowBtn = Instance.new("TextButton")
rainbowBtn.Size = UDim2.new(1, 0, 0, 32)
rainbowBtn.Text = "Start Rainbow OFF"
rainbowBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
rainbowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rainbowBtn.Font = Enum.Font.SourceSansBold
rainbowBtn.TextSize = 13
rainbowBtn.BorderSizePixel = 0
rainbowBtn.Parent = miscTab
Instance.new("UICorner", rainbowBtn).CornerRadius = UDim.new(0, 4)

rainbowBtn.MouseButton1Click:Connect(function()
    isRainbow = not isRainbow
    if isRainbow then
        rainbowBtn.Text = "Start Rainbow ON"
        rainbowBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        rainbowBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startRainbow()
    else
        rainbowBtn.Text = "Start Rainbow OFF"
        rainbowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        rainbowBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
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
    isRainbow = false
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

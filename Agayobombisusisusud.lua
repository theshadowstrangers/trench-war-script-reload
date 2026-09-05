-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local BombButton = Instance.new("TextButton")

ScreenGui.Name = "TestBombGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -60)
MainFrame.Size = UDim2.new(0, 240, 0, 120)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 180, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " Test Bomb-all"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0, 180, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Parent = MainFrame

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0, 210, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Parent = MainFrame

BombButton.Name = "BombButton"
BombButton.Parent = MainFrame
BombButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
BombButton.BorderSizePixel = 0
BombButton.Position = UDim2.new(0.5, -80, 0.5, -15)
BombButton.Size = UDim2.new(0, 160, 0, 40)
BombButton.Font = Enum.Font.SourceSansBold
BombButton.Text = "Bomb-all OFF"
BombButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BombButton.TextSize = 16
BombButton.Parent = MainFrame
Instance.new("UICorner", BombButton).CornerRadius = UDim.new(0, 6)

local isMinimized = false
local isBombActive = false
local bombConnection = nil

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 30), "Out", "Quad", 0.2, true)
        BombButton.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 120), "Out", "Quad", 0.2, true)
        BombButton.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    if bombConnection then
        bombConnection:Disconnect()
        bombConnection = nil
    end
    ScreenGui:Destroy()
    collectgarbage()
end)

-- ====== ОСНОВНАЯ ЛОГИКА ======
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Функция для получения события FireEvent (ищет везде)
local function getFireEvent()
    -- Проверяем в Character (оружие в руках)
    local char = LocalPlayer.Character
    if char then
        local launcher = char:FindFirstChild("Grenade Launcher")
        if launcher then
            local ev = launcher:FindFirstChild("FireEvent")
            if ev then
                return ev
            end
        end
    end
    
    -- Проверяем в Backpack
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        local launcher = backpack:FindFirstChild("Grenade Launcher")
        if launcher then
            local ev = launcher:FindFirstChild("FireEvent")
            if ev then
                return ev
            end
        end
    end
    
    return nil
end

-- Функция для получения позиции игрока
local function getPlayerPosition(player)
    if not player or not player.Character then return nil end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.Position
end

-- Функция для бомбёжки всех игроков
local function bombAllPlayers()
    local fireEvent = getFireEvent()
    if not fireEvent then
        warn("❌ FireEvent не найден! Проверь наличие Grenade Launcher")
        return
    end
    
    local players = Players:GetPlayers()
    local count = 0
    
    for _, player in pairs(players) do
        if player ~= LocalPlayer then
            local pos = getPlayerPosition(player)
            if pos then
                pcall(function()
                    fireEvent:FireServer(pos)
                    count = count + 1
                end)
            end
        end
    end
    
    if count > 0 then
        print("✅ Бомб отправлено: " .. count)
    end
end

BombButton.MouseButton1Click:Connect(function()
    isBombActive = not isBombActive
    
    if isBombActive then
        BombButton.Text = "Bomb-all ON"
        BombButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        BombButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        -- Проверяем наличие события при включении
        local ev = getFireEvent()
        if not ev then
            warn("❌ FireEvent не найден! Кнопка включена, но бомбёжка не работает.")
        else
            print("✅ FireEvent найден! Готов к бомбёжке.")
        end
        
        bombConnection = RunService.Heartbeat:Connect(function()
            if not isBombActive then
                bombConnection:Disconnect()
                bombConnection = nil
                return
            end
            bombAllPlayers()
        end)
    else
        BombButton.Text = "Bomb-all OFF"
        BombButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        BombButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        if bombConnection then
            bombConnection:Disconnect()
            bombConnection = nil
        end
        print("✅ Bomb-all выключен")
    end
end)

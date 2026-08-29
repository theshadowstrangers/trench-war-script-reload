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

ScreenGui.Name = "Area51Gui"
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
TitleLabel.Text = " Area51 Classic"
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
local teleportBtn, teleportTab = createTab("Teleport", "Teleport")
local gunsBtn, gunsTab = createTab("Guns", "Guns")
local badgesBtn, badgesTab = createTab("Badges", "Badges")
local miscBtn, miscTab = createTab("Misc", "Misc")
local espBtn, espTab = createTab("Esp", "Esp")

infoTab.Visible = true

-- ==================== INFO ====================
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Area51 Classic 2018\nBy Spynote\nCreate in 2026 year\nalltabs Teleport, Exploit, Misc, Guns, Badges, Esp"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

-- ==================== EXPLOIT ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function ensureWeapon()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
            return true
        end
    end

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local oldCF = root.CFrame
        local pistolCF = CFrame.new(-64.3158493, 735.329529, 18.362793, 0.0249549318, -1.01103925e-08, 0.999688566, 4.47392262e-11, 1, 1.01124256e-08, -0.999688566, -2.07629594e-10, 0.0249549318)
        root.CFrame = pistolCF
        task.wait(0.5)
        root.CFrame = oldCF
        task.wait(0.3)
    end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
            return true
        end
    end
    return false
end

local function killAllOnce()
    if not ensureWeapon() then return end

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local weapons = {}
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
            local hit = tool:FindFirstChild("Hit")
            if hit then
                table.insert(weapons, hit)
            end
        end
    end

    if #weapons == 0 then return end

    local killers = workspace:FindFirstChild("Killers")
    if not killers then return end

    local monsterNames = {
        "Eyeless Jack", "Chucky", "Captain Zombie", "Alien",
        "Granny", "GhostFace", "Freddy Krueger", "Leatherface",
        "Jeff", "Jason Voorhees", "Rake", "Pennywise",
        "Mikael", "Sonic.exe", "Slenderman", "Robot"
    }

    local zombies = {}
    for _, name in pairs(monsterNames) do
        local monster = killers:FindFirstChild(name)
        if monster then
            local zombie = monster:FindFirstChild("Zombie")
            if zombie then
                table.insert(zombies, zombie)
            end
        end
    end

    local child13 = killers:GetChildren()[13]
    if child13 and child13:IsA("Model") then
        table.insert(zombies, child13)
    end

    if #zombies == 0 then return end

    for _, hit in pairs(weapons) do
        for _, zombie in pairs(zombies) do
            for i = 1, 5 do
                pcall(function()
                    hit:FireServer(zombie, "Head")
                end)
            end
        end
    end
end

local killOnceBtn = Instance.new("TextButton")
killOnceBtn.Size = UDim2.new(1, 0, 0, 32)
killOnceBtn.Text = "Kill All Basic-Killers"
killOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killOnceBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
killOnceBtn.Font = Enum.Font.SourceSansBold
killOnceBtn.TextSize = 13
killOnceBtn.BorderSizePixel = 0
killOnceBtn.Parent = exploitTab
Instance.new("UICorner", killOnceBtn).CornerRadius = UDim.new(0, 4)

killOnceBtn.MouseButton1Click:Connect(function()
    killAllOnce()
end)

-- ==================== CRASHERBOOM-BOOM (EXPLOIT) ====================
local function crasherBoomOnce()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local myPos = root.Position
    local grenadeEvent = nil
    
    -- Ищем GrenadeHit в M16A2
    local gun = char:FindFirstChild("M16A2")
    if gun then
        grenadeEvent = gun:FindFirstChild("GrenadeHit")
    end

    if not grenadeEvent then
        -- Если нет M16A2, пробуем найти в бэкпаке
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == "M16A2" then
                    grenadeEvent = tool:FindFirstChild("GrenadeHit")
                    if grenadeEvent then break end
                end
            end
        end
    end

    if not grenadeEvent then return end

    -- Генерируем случайные координаты в радиусе 100 studs
    local angle = math.random() * math.pi * 2
    local radius = math.random() * 100
    local offsetX = math.cos(angle) * radius
    local offsetZ = math.sin(angle) * radius
    local offsetY = (math.random() * 80) - 40

    local targetPos = Vector3.new(
        myPos.X + offsetX,
        myPos.Y + offsetY,
        myPos.Z + offsetZ
    )

    pcall(function()
        grenadeEvent:FireServer(targetPos)
    end)
end

local crasherBoomBtn = Instance.new("TextButton")
crasherBoomBtn.Size = UDim2.new(1, 0, 0, 32)
crasherBoomBtn.Text = "CrasherBoom-Boom"
crasherBoomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
crasherBoomBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
crasherBoomBtn.Font = Enum.Font.SourceSansBold
crasherBoomBtn.TextSize = 13
crasherBoomBtn.BorderSizePixel = 0
crasherBoomBtn.Parent = exploitTab
Instance.new("UICorner", crasherBoomBtn).CornerRadius = UDim.new(0, 4)

crasherBoomBtn.MouseButton1Click:Connect(function()
    crasherBoomOnce()
end)

-- ==================== KILL ALL KILLERS (EXPLOIT) ====================
local function killAllKillersOnce()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    -- Проверяем есть ли оружие с Hit (кроме Flashlight)
    local hasWeapon = false
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
            hasWeapon = true
            break
        end
    end

    -- Если нет оружия - телепортируемся к пистолету
    if not hasWeapon then
        local char = LocalPlayer.Character
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

    -- Ищем любое оружие с Hit (кроме Flashlight)
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
        local char = LocalPlayer.Character
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

    -- Перебираем всех детей в Killers
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

local killAllKillersBtn = Instance.new("TextButton")
killAllKillersBtn.Size = UDim2.new(1, 0, 0, 32)
killAllKillersBtn.Text = "Kill All Killers"
killAllKillersBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killAllKillersBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
killAllKillersBtn.Font = Enum.Font.SourceSansBold
killAllKillersBtn.TextSize = 13
killAllKillersBtn.BorderSizePixel = 0
killAllKillersBtn.Parent = exploitTab
Instance.new("UICorner", killAllKillersBtn).CornerRadius = UDim.new(0, 4)

killAllKillersBtn.MouseButton1Click:Connect(function()
    killAllKillersOnce()
end)

-- ==================== ALL-KILLERS-CABOOM (EXPLOIT) ====================
local function allKillersCaboomOnce()
    local char = LocalPlayer.Character
    if not char then return end
    
    -- Ищем GrenadeHit
    local grenadeEvent = nil
    local gun = char:FindFirstChild("M16A2")
    if gun then
        grenadeEvent = gun:FindFirstChild("GrenadeHit")
    end

    if not grenadeEvent then
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == "M16A2" then
                    grenadeEvent = tool:FindFirstChild("GrenadeHit")
                    if grenadeEvent then break end
                end
            end
        end
    end

    if not grenadeEvent then return end

    local killers = workspace:FindFirstChild("Killers")
    if not killers then return end

    -- Перебираем всех детей в Killers
    for _, child in pairs(killers:GetChildren()) do
        if child:IsA("Model") then
            local head = child:FindFirstChild("Head")
            if head and head:IsA("BasePart") then
                for i = 1, 5 do
                    pcall(function()
                        grenadeEvent:FireServer(head.Position)
                    end)
                end
            end
        end
    end
end

local allKillersCaboomBtn = Instance.new("TextButton")
allKillersCaboomBtn.Size = UDim2.new(1, 0, 0, 32)
allKillersCaboomBtn.Text = "All-Killers-Caboom"
allKillersCaboomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
allKillersCaboomBtn.Font = Enum.Font.SourceSansBold
allKillersCaboomBtn.TextSize = 13
allKillersCaboomBtn.BorderSizePixel = 0
allKillersCaboomBtn.Parent = exploitTab
Instance.new("UICorner", allKillersCaboomBtn).CornerRadius = UDim.new(0, 4)

allKillersCaboomBtn.MouseButton1Click:Connect(function()
    allKillersCaboomOnce()
end)


-- ==================== BADGES ====================
local badgeLocations = {
    {name = "Helpful", cframe = CFrame.new(10.7580309, 768.249695, 120.934952, 0.812219799, 9.73034808e-09, 0.583351493, -9.07471787e-08, 1, 1.0967026e-07, -0.583351493, -1.4201386e-07, 0.812219799)},
    {name = "Alien", cframe = CFrame.new(110.662727, 781.801636, 225.300201, 0.760611594, 2.94469196e-08, -0.649207175, -4.80355915e-08, 1, -1.09202585e-08, 0.649207175, 3.94911268e-08, 0.760611594)},
    {name = "Atomic", cframe = CFrame.new(35.8430214, 789.801758, 301.66687, 0.576444566, -6.31990886e-08, -0.817136288, -4.96619421e-08, 1, -1.12375922e-07, 0.817136288, 1.05359064e-07, 0.576444566)},
    {name = "Execution room", cframe = CFrame.new(-96.3033371, 757.499756, -42.7801704, 0.999044955, -3.44070088e-08, -0.0436937362, 3.23239e-08, 1, -4.83817431e-08, 0.0436937362, 4.69231871e-08, 0.999044955)},
    {name = "Gian Zombie", cframe = CFrame.new(50.8655472, 757.399475, 331.196838, -0.288832575, -1.2662337e-08, 0.957379639, 6.82125734e-09, 1, 1.52839466e-08, -0.957379639, 1.09450342e-08, -0.288832575)},
    {name = "ThewayOut", cframe = CFrame.new(136.702515, 801.950806, 329.398102, -0.997689724, 1.58878013e-08, 0.0679352731, 1.67069718e-08, 1, 1.14899379e-08, -0.0679352731, 1.25983854e-08, -0.997689724)}
}

local function createBadgeButton(parent, name, cframe)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe
        end
    end)
    return btn
end

for _, loc in ipairs(badgeLocations) do
    createBadgeButton(badgesTab, loc.name, loc.cframe)
end

-- Give All Badges
local giveAllBtn = Instance.new("TextButton")
giveAllBtn.Size = UDim2.new(1, 0, 0, 30)
giveAllBtn.Text = "Give All Badges"
giveAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveAllBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
giveAllBtn.Font = Enum.Font.SourceSansBold
giveAllBtn.TextSize = 13
giveAllBtn.BorderSizePixel = 0
giveAllBtn.Parent = badgesTab
Instance.new("UICorner", giveAllBtn).CornerRadius = UDim.new(0, 4)

giveAllBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local root = char.HumanoidRootPart
    for _, loc in ipairs(badgeLocations) do
        root.CFrame = loc.cframe
        task.wait(1.2)
    end
end)

-- ==================== TELEPORT ====================
local function createTPButton(parent, name, cframe)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe
        end
    end)
    return btn
end

createTPButton(teleportTab, "Lobby", CFrame.new(200.531662, 955.25, 150.4431, 0.999933898, -5.04139064e-10, -0.0114961434, 5.04414011e-10, 1, 2.10146935e-11, 0.0114961434, -2.68121202e-11, 0.999933898))
createTPButton(teleportTab, "Zombiemorph", CFrame.new(274.360229, 956.714966, 147.663025, 0.117416635, 6.31049275e-08, -0.993082762, 3.96189712e-08, 1, 6.82288146e-08, 0.993082762, -4.73561137e-08, 0.117416635))
createTPButton(teleportTab, "start-yama", CFrame.new(199.476608, 757.249756, 125.352921, 0.053038884, 1.08034932e-08, 0.998592436, 6.47038512e-09, 1, -1.11623875e-08, -0.998592436, 7.05331837e-09, 0.053038884))
createTPButton(teleportTab, "center-yama", CFrame.new(111.154442, 757.249756, 124.20433, -0.916778684, 4.78177924e-08, 0.399395645, 5.4334464e-08, 1, 4.9947535e-09, -0.399395645, 2.62800306e-08, -0.916778684))
createTPButton(teleportTab, "computer", CFrame.new(37.1424942, 757.249878, 190.751022, 0.72430414, -1.55433699e-09, -0.689480603, 1.09612923e-08, 1, 9.2605541e-09, 0.689480603, -1.42650567e-08, 0.72430414))
createTPButton(teleportTab, "Love-yama", CFrame.new(54.6380768, 772.249512, -70.0079803, -0.614201605, -2.18387495e-08, 0.789149165, 5.73766412e-09, 1, 3.21394644e-08, -0.789149165, 2.42679832e-08, -0.614201605))
createTPButton(teleportTab, "secret-tunnel", CFrame.new(63.2251205, 777.249573, 25.9734955, 0.634899437, -4.62911665e-09, -0.77259475, -2.80260926e-09, 1, -8.29476487e-09, 0.77259475, 7.43162287e-09, 0.634899437))
createTPButton(teleportTab, "Robot-Room", CFrame.new(-97.7791061, 757.249512, 20.6939659, -0.632564187, -1.33346774e-07, 0.77450794, -4.48379822e-08, 1, 1.35549129e-07, -0.77450794, 5.10161478e-08, -0.632564187))
createTPButton(teleportTab, "Chucky-room", CFrame.new(-62.8614349, 757.249878, -33.2262154, 0.890462697, -1.36611689e-07, 0.45505628, 1.18723548e-07, 1, 6.78878607e-08, -0.45505628, -6.42570708e-09, 0.890462697))
createTPButton(teleportTab, "Slender-Room", CFrame.new(-110.900925, 757.249756, 133.593231, 0.522096455, 1.04989579e-06, -0.852886438, 3.67411568e-09, 1, 1.23324048e-06, 0.852886438, -6.47004072e-07, 0.522096455))
createTPButton(teleportTab, "koridor-room", CFrame.new(-35.770256, 757.249939, 115.196388, -0.864833951, 3.65657229e-08, 0.50205797, 3.81156759e-08, 1, -7.17445037e-09, -0.50205797, 1.29315714e-08, -0.864833951))
createTPButton(teleportTab, "tarelka-room", CFrame.new(-98.1795349, 757.249695, 190.577682, -0.817441404, 7.76139586e-06, 0.576011777, 6.81257879e-05, 1, 8.32056612e-05, -0.576011777, 0.000107257008, -0.817441404))
createTPButton(teleportTab, "Secret-Room-2", CFrame.new(21.7545528, 771.249756, 148.736115, 0.247461677, -1.69996657e-08, -0.9688977, -9.14222724e-08, 1, -4.0895106e-08, 0.9688977, 9.86987985e-08, 0.247461677))
createTPButton(teleportTab, "Freddy-Cruger", CFrame.new(144.117188, 777.249695, 425.717346, 0.7949512, -8.15916508e-08, 0.60667336, -7.71759531e-11, 1, 1.34591374e-07, -0.60667336, -1.07040393e-07, 0.7949512))

-- ==================== GUNS ====================
local gunData = {
    {name = "MP5k", path = workspace.MP5k and workspace.MP5k["MP5k Giver"] and workspace.MP5k["MP5k Giver"]["PUT THE WEAPON IN THIS BRICK"]},
    {name = "R870", path = workspace.R870 and workspace.R870["R870 Giver"] and workspace.R870["R870 Giver"]["PUT THE WEAPON IN THIS BRICK"]},
    {name = "SVD", path = workspace.SVD and workspace.SVD.SVDGiver and workspace.SVD.SVDGiver.Reward},
    {name = "M16A2", path = workspace.M16A2Room and workspace.M16A2Room["M16A2/M203"] and workspace.M16A2Room["M16A2/M203"]["M16A2/M203 Giver"] and workspace.M16A2Room["M16A2/M203"]["M16A2/M203 Giver"]["PUT THE WEAPON IN THIS BRICK"]}
}

local function createGunButton(parent, name, part)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if not part then
            print("Ошибка: не найдена часть для " .. name)
            return
        end

        pcall(function()
            firetouchinterest(root, part, 0)
            task.wait(0.1)
            firetouchinterest(root, part, 1)
        end)
    end)
    return btn
end

for _, gun in ipairs(gunData) do
    createGunButton(gunsTab, gun.name, gun.path)
end

local gunTeleportData = {
    {name = "RayGun", cframe = CFrame.new(106.310112, 817.449646, -201.25647, -0.928216398, 2.76972614e-08, 0.372040719, 3.32270105e-08, 1, 8.45228953e-09, -0.372040719, 2.02073558e-08, -0.928216398)},
    {name = "M14", cframe = CFrame.new(-18.549881, 767.451233, 433.196289, 0.727414489, 8.90424534e-09, 0.686198354, -3.60391139e-09, 1, -9.15581921e-09, -0.686198354, 4.18707735e-09, 0.727414489)}
}

local function createGunTeleportButton(parent, name, cframe)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Text = "TP: " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local oldCF = char.HumanoidRootPart.CFrame
            char.HumanoidRootPart.CFrame = cframe
            task.wait(2)
            char.HumanoidRootPart.CFrame = oldCF
        end
    end)
    return btn
end

for _, gun in ipairs(gunTeleportData) do
    createGunTeleportButton(gunsTab, gun.name, gun.cframe)
end

-- ==================== ESP ====================
local isEspEnabled = false
local espHighlights = {}
local espBillboards = {}

local function clearEsp()
    for _, item in pairs(espHighlights) do if item then item:Destroy() end end
    espHighlights = {}
    for _, bill in pairs(espBillboards) do if bill then bill:Destroy() end end
    espBillboards = {}
end

local espToggleBtn = Instance.new("TextButton")
espToggleBtn.Size = UDim2.new(1, 0, 0, 32)
espToggleBtn.Text = "Esp Players OFF"
espToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
espToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggleBtn.Font = Enum.Font.SourceSansBold
espToggleBtn.TextSize = 13
espToggleBtn.BorderSizePixel = 0
espToggleBtn.Parent = espTab
Instance.new("UICorner", espToggleBtn).CornerRadius = UDim.new(0, 4)

espToggleBtn.MouseButton1Click:Connect(function()
    isEspEnabled = not isEspEnabled
    if isEspEnabled then
        espToggleBtn.Text = "Esp Players ON"
        espToggleBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        espToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        espToggleBtn.Text = "Esp Players OFF"
        espToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        espToggleBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        clearEsp()
    end
end)

RunService.Heartbeat:Connect(function()
    if not isEspEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local root = char.HumanoidRootPart

            local highlight = char:FindFirstChild("SpyNoteESP")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "SpyNoteESP"
                highlight.Adornee = char
                highlight.FillColor = Color3.fromRGB(0, 0, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.Parent = char
                table.insert(espHighlights, highlight)
            end

            local bill = root:FindFirstChild("SpyNoteESPText")
            if not bill then
                bill = Instance.new("BillboardGui")
                bill.Name = "SpyNoteESPText"
                bill.Size = UDim2.new(0, 80, 0, 25)
                bill.StudsOffset = Vector3.new(0, 3, 0)
                bill.AlwaysOnTop = true

                local txt = Instance.new("TextLabel")
                txt.Name = "Distance"
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                txt.TextSize = 10
                txt.Font = Enum.Font.SourceSansBold
                txt.TextStrokeTransparency = 0
                txt.Parent = bill
                bill.Parent = root
                table.insert(espBillboards, bill)
            end

            local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if localRoot and bill:FindFirstChild("Distance") then
                local dist = math.floor((root.Position - localRoot.Position).Magnitude)
                bill.Distance.Text = "studs: " .. dist
            end
        end
    end
end)

-- ==================== ESP KILLERS (ESP TAB) ====================
local isEspKillers = false
local espKillersHighlights = {}
local espKillersBillboards = {}
local espKillersConnection = nil

local function clearEspKillers()
    for _, item in pairs(espKillersHighlights) do
        if item then item:Destroy() end
    end
    espKillersHighlights = {}
    for _, bill in pairs(espKillersBillboards) do
        if bill then bill:Destroy() end
    end
    espKillersBillboards = {}
end

local function updateEspKillers()
    if not isEspKillers then
        clearEspKillers()
        return
    end

    local killers = workspace:FindFirstChild("Killers")
    if not killers then return end

    for _, child in pairs(killers:GetChildren()) do
        if child:IsA("Model") then
            local humanoid = child:FindFirstChild("Humanoid")
            if humanoid then
                -- Подсветка
                local highlight = child:FindFirstChild("EspKillerHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "EspKillerHighlight"
                    highlight.Adornee = child
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Parent = child
                    table.insert(espKillersHighlights, highlight)
                end

                -- Billboard с расстоянием
                local rootPart = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                if rootPart then
                    local bill = rootPart:FindFirstChild("EspKillerBillboard")
                    if not bill then
                        bill = Instance.new("BillboardGui")
                        bill.Name = "EspKillerBillboard"
                        bill.Size = UDim2.new(0, 80, 0, 25)
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        bill.AlwaysOnTop = true

                        local txt = Instance.new("TextLabel")
                        txt.Name = "Distance"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                        txt.TextSize = 10
                        txt.Font = Enum.Font.SourceSansBold
                        txt.TextStrokeTransparency = 0
                        txt.Parent = bill
                        bill.Parent = rootPart
                        table.insert(espKillersBillboards, bill)
                    end

                    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if localRoot and bill:FindFirstChild("Distance") then
                        local dist = math.floor((rootPart.Position - localRoot.Position).Magnitude)
                        bill.Distance.Text = "studs: " .. dist
                    end
                end
            end
        end
    end
end

local espKillersBtn = Instance.new("TextButton")
espKillersBtn.Size = UDim2.new(1, 0, 0, 32)
espKillersBtn.Text = "Esp Killers OFF"
espKillersBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
espKillersBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espKillersBtn.Font = Enum.Font.SourceSansBold
espKillersBtn.TextSize = 13
espKillersBtn.BorderSizePixel = 0
espKillersBtn.Parent = espTab
Instance.new("UICorner", espKillersBtn).CornerRadius = UDim.new(0, 4)

espKillersBtn.MouseButton1Click:Connect(function()
    isEspKillers = not isEspKillers
    if isEspKillers then
        espKillersBtn.Text = "Esp Killers ON"
        espKillersBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        espKillersBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        if espKillersConnection then
            espKillersConnection:Disconnect()
            espKillersConnection = nil
        end
        
        espKillersConnection = RunService.Heartbeat:Connect(function()
            updateEspKillers()
        end)
    else
        espKillersBtn.Text = "Esp Killers OFF"
        espKillersBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        espKillersBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        
        if espKillersConnection then
            espKillersConnection:Disconnect()
            espKillersConnection = nil
        end
        clearEspKillers()
    end
end)

-- ==================== MISC ====================
-- Give Ammo
local ammoBtn = Instance.new("TextButton")
ammoBtn.Size = UDim2.new(1, 0, 0, 32)
ammoBtn.Text = "Give Ammo"
ammoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ammoBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
ammoBtn.Font = Enum.Font.SourceSansBold
ammoBtn.TextSize = 14
ammoBtn.BorderSizePixel = 0
ammoBtn.Parent = miscTab
Instance.new("UICorner", ammoBtn).CornerRadius = UDim.new(0, 4)

ammoBtn.MouseButton1Click:Connect(function()
    local Event = game:GetService("ReplicatedStorage"):FindFirstChild("RefillAmmo")
    if Event then
        firesignal(Event.OnClientEvent)
    end
end)

-- Exploit Caboom
local isExploding = false
local loopConnection = nil

local function getGrenadeEvent()
    local char = LocalPlayer.Character
    if not char then return nil end
    local gun = char:FindFirstChild("M16A2")
    if not gun then return nil end
    return gun:FindFirstChild("GrenadeHit")
end

local function startExploit()
    if loopConnection then loopConnection:Disconnect() end
    loopConnection = RunService.Heartbeat:Connect(function()
        if not isExploding then return end
        local event = getGrenadeEvent()
        if not event then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local pos = root.Position
        local target = pos
        pcall(function()
            event:FireServer(target)
        end)
    end)
end

local exploitBtnToggleMisc = Instance.new("TextButton")
exploitBtnToggleMisc.Size = UDim2.new(1, 0, 0, 32)
exploitBtnToggleMisc.Text = "Exploit Caboom OFF"
exploitBtnToggleMisc.TextColor3 = Color3.fromRGB(255, 85, 85)
exploitBtnToggleMisc.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
exploitBtnToggleMisc.Font = Enum.Font.SourceSansBold
exploitBtnToggleMisc.TextSize = 13
exploitBtnToggleMisc.BorderSizePixel = 0
exploitBtnToggleMisc.Parent = miscTab
Instance.new("UICorner", exploitBtnToggleMisc).CornerRadius = UDim.new(0, 4)

exploitBtnToggleMisc.MouseButton1Click:Connect(function()
    isExploding = not isExploding
    if isExploding then
        exploitBtnToggleMisc.Text = "Exploit Caboom ON"
        exploitBtnToggleMisc.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        exploitBtnToggleMisc.TextColor3 = Color3.fromRGB(0, 0, 0)
        startExploit()
    else
        exploitBtnToggleMisc.Text = "Exploit Caboom OFF"
        exploitBtnToggleMisc.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        exploitBtnToggleMisc.TextColor3 = Color3.fromRGB(255, 85, 85)
        if loopConnection then loopConnection:Disconnect() loopConnection = nil end
    end
end)

-- Kill All Killers (Spam)
local isKillAll = false
local killAllThread = nil

local function killAllLoop()
    while isKillAll do
        ensureWeapon()

        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            local weapons = {}
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
                    local hit = tool:FindFirstChild("Hit")
                    if hit then
                        table.insert(weapons, hit)
                    end
                end
            end

            if #weapons > 0 then
                local killers = workspace:FindFirstChild("Killers")
                if killers then
                    local monsterNames = {
                        "Eyeless Jack", "Chucky", "Captain Zombie", "Alien",
                        "Granny", "GhostFace", "Freddy Krueger", "Leatherface",
                        "Jeff", "Jason Voorhees", "Rake", "Pennywise",
                        "Mikael", "Sonic.exe", "Slenderman", "Robot"
                    }
                    local zombies = {}
                    for _, name in pairs(monsterNames) do
                        local monster = killers:FindFirstChild(name)
                        if monster then
                            local zombie = monster:FindFirstChild("Zombie")
                            if zombie then
                                table.insert(zombies, zombie)
                            end
                        end
                    end
                    local child13 = killers:GetChildren()[13]
                    if child13 and child13:IsA("Model") then
                        table.insert(zombies, child13)
                    end

                    if #zombies > 0 then
                        for _, hit in pairs(weapons) do
                            for _, zombie in pairs(zombies) do
                                for i = 1, 10 do
                                    pcall(function()
                                        hit:FireServer(zombie, "Head")
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

local killAllSpamBtn = Instance.new("TextButton")
killAllSpamBtn.Size = UDim2.new(1, 0, 0, 32)
killAllSpamBtn.Text = "Kill All Basic-Killers (Spam) OFF"
killAllSpamBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
killAllSpamBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
killAllSpamBtn.Font = Enum.Font.SourceSansBold
killAllSpamBtn.TextSize = 13
killAllSpamBtn.BorderSizePixel = 0
killAllSpamBtn.Parent = miscTab
Instance.new("UICorner", killAllSpamBtn).CornerRadius = UDim.new(0, 4)

killAllSpamBtn.MouseButton1Click:Connect(function()
    isKillAll = not isKillAll
    if isKillAll then
        killAllSpamBtn.Text = "Kill All Basic-Killers (Spam) ON"
        killAllSpamBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        killAllSpamBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        killAllThread = task.spawn(killAllLoop)
    else
        killAllSpamBtn.Text = "Kill All Basic-Killers (Spam) OFF"
        killAllSpamBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        killAllSpamBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if killAllThread then
            task.cancel(killAllThread)
            killAllThread = nil
        end
    end
end)

-- Give All Missions
local giveMissionsBtn = Instance.new("TextButton")
giveMissionsBtn.Size = UDim2.new(1, 0, 0, 32)
giveMissionsBtn.Text = "Give All Missions"
giveMissionsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveMissionsBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
giveMissionsBtn.Font = Enum.Font.SourceSansBold
giveMissionsBtn.TextSize = 13
giveMissionsBtn.BorderSizePixel = 0
giveMissionsBtn.Parent = miscTab
Instance.new("UICorner", giveMissionsBtn).CornerRadius = UDim.new(0, 4)

giveMissionsBtn.MouseButton1Click:Connect(function()
    local secrets = workspace:FindFirstChild("Secrets")
    if not secrets then
        print("Ошибка: папка Secrets не найдена")
        return
    end

    local paths = {
        "SecretPath5", "SecretPath6", "ZombieMorph", "SecretPath2",
        "SecretPath3", "SecretPath4", "R870", "RayGun", "SVD",
        "SecretPath1", "Paper1", "Paper2", "Paper3", "M16A2/M203",
        "MP5k", "PackAPunch", "M14", "Giant", "Alien", "AmmoBag",
        "ExecutionRoom", "M1911"
    }

    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, name in ipairs(paths) do
        local obj = secrets:FindFirstChild(name)
        if obj and obj:IsA("BasePart") then
            pcall(function()
                firetouchinterest(root, obj, 0)
                task.wait(0.05)
                firetouchinterest(root, obj, 1)
            end)
        elseif obj then
            local part = obj:FindFirstChildWhichIsA("BasePart")
            if part then
                pcall(function()
                    firetouchinterest(root, part, 0)
                    task.wait(0.05)
                    firetouchinterest(root, part, 1)
                end)
            end
        end
        task.wait(0.03)
    end
end)

-- Weapons All Upgrade
local weaponsUpgradeBtn = Instance.new("TextButton")
weaponsUpgradeBtn.Size = UDim2.new(1, 0, 0, 32)
weaponsUpgradeBtn.Text = "Weapons-All-upgrade"
weaponsUpgradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
weaponsUpgradeBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
weaponsUpgradeBtn.Font = Enum.Font.SourceSansBold
weaponsUpgradeBtn.TextSize = 13
weaponsUpgradeBtn.BorderSizePixel = 0
weaponsUpgradeBtn.Parent = miscTab
Instance.new("UICorner", weaponsUpgradeBtn).CornerRadius = UDim.new(0, 4)

weaponsUpgradeBtn.MouseButton1Click:Connect(function()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local papEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PAPRemoteEvent")
    if not papEvent then
        print("Ошибка: PAPRemoteEvent не найден")
        return
    end

    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
            pcall(function()
                papEvent:FireServer("PerformUpgrade", tool.Name)
                task.wait(0.1)
            end)
        end
    end
end)

-- ==================== CRASHERBOOM (MISC) ====================
local isCrasherBoom = false
local crasherConnection = nil

local function startCrasherBoom()
    if crasherConnection then
        crasherConnection:Disconnect()
        crasherConnection = nil
    end

    crasherConnection = RunService.Heartbeat:Connect(function()
        if not isCrasherBoom then
            crasherConnection:Disconnect()
            crasherConnection = nil
            return
        end

        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local myPos = root.Position
        local grenadeEvent = nil
        
        -- Ищем GrenadeHit в M16A2
        local gun = char:FindFirstChild("M16A2")
        if gun then
            grenadeEvent = gun:FindFirstChild("GrenadeHit")
        end

        if not grenadeEvent then
            -- Если нет M16A2, пробуем найти в бэкпаке
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name == "M16A2" then
                        grenadeEvent = tool:FindFirstChild("GrenadeHit")
                        if grenadeEvent then break end
                    end
                end
            end
        end

        if not grenadeEvent then return end

        -- Генерируем случайные координаты в радиусе 100 studs
        local angle = math.random() * math.pi * 2
        local radius = math.random() * 100
        local offsetX = math.cos(angle) * radius
        local offsetZ = math.sin(angle) * radius
        local offsetY = (math.random() * 80) - 40 -- от -40 до +40 по Y

        local targetPos = Vector3.new(
            myPos.X + offsetX,
            myPos.Y + offsetY,
            myPos.Z + offsetZ
        )

        pcall(function()
            grenadeEvent:FireServer(targetPos)
        end)
    end)
end

local crasherBtn = Instance.new("TextButton")
crasherBtn.Size = UDim2.new(1, 0, 0, 32)
crasherBtn.Text = "CrasherBoom OFF"
crasherBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
crasherBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
crasherBtn.Font = Enum.Font.SourceSansBold
crasherBtn.TextSize = 13
crasherBtn.BorderSizePixel = 0
crasherBtn.Parent = miscTab
Instance.new("UICorner", crasherBtn).CornerRadius = UDim.new(0, 4)

crasherBtn.MouseButton1Click:Connect(function()
    isCrasherBoom = not isCrasherBoom
    if isCrasherBoom then
        crasherBtn.Text = "CrasherBoom ON"
        crasherBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        crasherBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startCrasherBoom()
    else
        crasherBtn.Text = "CrasherBoom OFF"
        crasherBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        crasherBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if crasherConnection then
            crasherConnection:Disconnect()
            crasherConnection = nil
        end
    end
end)

-- ==================== ALL-KILLERS-CABOOM (MISC) ====================
local isAllKillersCaboom = false
local allKillersConnection = nil

local function getAllKillersHeads()
    local heads = {}
    local killers = workspace:FindFirstChild("Killers")
    if not killers then return heads end

    local monsterNames = {
        "Eyeless Jack", "Chucky", "Captain Zombie", "Alien",
        "Granny", "GhostFace", "Freddy Krueger", "Leatherface",
        "Jeff", "Jason Voorhees", "Rake", "Pennywise",
        "Mikael", "Sonic.exe", "Slenderman", "Robot"
    }

    for _, name in pairs(monsterNames) do
        local monster = killers:FindFirstChild(name)
        if monster then
            local head = monster:FindFirstChild("Head")
            if head and head:IsA("BasePart") then
                table.insert(heads, head)
            end
        end
    end

    -- Добавляем 13-го ребенка
    local child13 = killers:GetChildren()[13]
    if child13 and child13:IsA("Model") then
        local head = child13:FindFirstChild("Head")
        if head and head:IsA("BasePart") then
            table.insert(heads, head)
        end
    end

    return heads
end

local function startAllKillersCaboom()
    if allKillersConnection then
        allKillersConnection:Disconnect()
        allKillersConnection = nil
    end

    allKillersConnection = RunService.Heartbeat:Connect(function()
        if not isAllKillersCaboom then
            allKillersConnection:Disconnect()
            allKillersConnection = nil
            return
        end

        local char = LocalPlayer.Character
        if not char then return end
        
        local grenadeEvent = nil
        local gun = char:FindFirstChild("M16A2")
        if gun then
            grenadeEvent = gun:FindFirstChild("GrenadeHit")
        end

        if not grenadeEvent then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name == "M16A2" then
                        grenadeEvent = tool:FindFirstChild("GrenadeHit")
                        if grenadeEvent then break end
                    end
                end
            end
        end

        if not grenadeEvent then return end

        local heads = getAllKillersHeads()
        if #heads == 0 then return end

        for _, head in pairs(heads) do
            pcall(function()
                grenadeEvent:FireServer(head.Position)
            end)
        end
    end)
end

local allKillersCaboomBtn = Instance.new("TextButton")
allKillersCaboomBtn.Size = UDim2.new(1, 0, 0, 32)
allKillersCaboomBtn.Text = "All-Basic-Killers-Caboom OFF"
allKillersCaboomBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
allKillersCaboomBtn.Font = Enum.Font.SourceSansBold
allKillersCaboomBtn.TextSize = 13
allKillersCaboomBtn.BorderSizePixel = 0
allKillersCaboomBtn.Parent = miscTab
Instance.new("UICorner", allKillersCaboomBtn).CornerRadius = UDim.new(0, 4)

allKillersCaboomBtn.MouseButton1Click:Connect(function()
    isAllKillersCaboom = not isAllKillersCaboom
    if isAllKillersCaboom then
        allKillersCaboomBtn.Text = "All-Basic-Killers-Caboom ON"
        allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        allKillersCaboomBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startAllKillersCaboom()
    else
        allKillersCaboomBtn.Text = "All-Basic-Killers-Caboom OFF"
        allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        allKillersCaboomBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if allKillersConnection then
            allKillersConnection:Disconnect()
            allKillersConnection = nil
        end
    end
end)

-- ==================== KILL ALL KILLERS SPAM (MISC) ====================
local isKillAllSpam = false
local killAllSpamConnection = nil

local function killAllKillersSpamLoop()
    if killAllSpamConnection then
        killAllSpamConnection:Disconnect()
        killAllSpamConnection = nil
    end

    killAllSpamConnection = RunService.Heartbeat:Connect(function()
        if not isKillAllSpam then
            killAllSpamConnection:Disconnect()
            killAllSpamConnection = nil
            return
        end

        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if not backpack then return end

        -- Проверяем есть ли оружие с Hit (кроме Flashlight)
        local hasWeapon = false
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
                hasWeapon = true
                break
            end
        end

        -- Если нет оружия - телепортируемся к пистолету
        if not hasWeapon then
            local char = LocalPlayer.Character
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

        -- Ищем любое оружие с Hit (кроме Flashlight)
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
            local char = LocalPlayer.Character
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

        -- Перебираем всех детей в Killers
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
    end)
end

local killAllKillersSpamBtn = Instance.new("TextButton")
killAllKillersSpamBtn.Size = UDim2.new(1, 0, 0, 32)
killAllKillersSpamBtn.Text = "Kill All Killers Spam OFF"
killAllKillersSpamBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
killAllKillersSpamBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
killAllKillersSpamBtn.Font = Enum.Font.SourceSansBold
killAllKillersSpamBtn.TextSize = 13
killAllKillersSpamBtn.BorderSizePixel = 0
killAllKillersSpamBtn.Parent = miscTab
Instance.new("UICorner", killAllKillersSpamBtn).CornerRadius = UDim.new(0, 4)

killAllKillersSpamBtn.MouseButton1Click:Connect(function()
    isKillAllSpam = not isKillAllSpam
    if isKillAllSpam then
        killAllKillersSpamBtn.Text = "Kill All Killers Spam ON"
        killAllKillersSpamBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        killAllKillersSpamBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        killAllKillersSpamLoop()
    else
        killAllKillersSpamBtn.Text = "Kill All Killers Spam OFF"
        killAllKillersSpamBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        killAllKillersSpamBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if killAllSpamConnection then
            killAllSpamConnection:Disconnect()
            killAllSpamConnection = nil
        end
    end
end)

-- ==================== ALL-KILLERS-CABOOM SPAM (MISC) ====================
local isAllKillersCaboom = false
local allKillersCaboomConnection = nil

local function getAllKillersCaboomLoop()
    if allKillersCaboomConnection then
        allKillersCaboomConnection:Disconnect()
        allKillersCaboomConnection = nil
    end

    allKillersCaboomConnection = RunService.Heartbeat:Connect(function()
        if not isAllKillersCaboom then
            allKillersCaboomConnection:Disconnect()
            allKillersCaboomConnection = nil
            return
        end

        local char = LocalPlayer.Character
        if not char then return end
        
        -- Ищем GrenadeHit
        local grenadeEvent = nil
        local gun = char:FindFirstChild("M16A2")
        if gun then
            grenadeEvent = gun:FindFirstChild("GrenadeHit")
        end

        if not grenadeEvent then
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name == "M16A2" then
                        grenadeEvent = tool:FindFirstChild("GrenadeHit")
                        if grenadeEvent then break end
                    end
                end
            end
        end

        if not grenadeEvent then return end

        local killers = workspace:FindFirstChild("Killers")
        if not killers then return end

        -- Перебираем всех детей в Killers
        for _, child in pairs(killers:GetChildren()) do
            if child:IsA("Model") then
                local head = child:FindFirstChild("Head")
                if head and head:IsA("BasePart") then
                    pcall(function()
                        grenadeEvent:FireServer(head.Position)
                    end)
                end
            end
        end
    end)
end

local allKillersCaboomBtn = Instance.new("TextButton")
allKillersCaboomBtn.Size = UDim2.new(1, 0, 0, 32)
allKillersCaboomBtn.Text = "All-Killers-Caboom OFF"
allKillersCaboomBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
allKillersCaboomBtn.Font = Enum.Font.SourceSansBold
allKillersCaboomBtn.TextSize = 13
allKillersCaboomBtn.BorderSizePixel = 0
allKillersCaboomBtn.Parent = miscTab
Instance.new("UICorner", allKillersCaboomBtn).CornerRadius = UDim.new(0, 4)

allKillersCaboomBtn.MouseButton1Click:Connect(function()
    isAllKillersCaboom = not isAllKillersCaboom
    if isAllKillersCaboom then
        allKillersCaboomBtn.Text = "All-Killers-Caboom ON"
        allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        allKillersCaboomBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        getAllKillersCaboomLoop()
    else
        allKillersCaboomBtn.Text = "All-Killers-Caboom OFF"
        allKillersCaboomBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        allKillersCaboomBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        if allKillersCaboomConnection then
            allKillersCaboomConnection:Disconnect()
            allKillersCaboomConnection = nil
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
    isExploding = false
    isKillAll = false
    isEspEnabled = false
    if loopConnection then loopConnection:Disconnect() end
    if killAllThread then task.cancel(killAllThread) end
    clearEsp()
    ScreenGui:Destroy()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

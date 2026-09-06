-- Создаём главный GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExploitConsole"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

-- === СОЗДАЁМ КНОПКУ (СВЁРНУТОЕ СОСТОЯНИЕ) ===
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 80, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "> Exploit"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.BorderSizePixel = 0
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 14
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 4)

-- === СОЗДАЁМ МИНИ-ОКНО (РАЗВЁРНУТОЕ СОСТОЯНИЕ) ===
local consoleFrame = Instance.new("Frame")
consoleFrame.Name = "ConsoleFrame"
consoleFrame.Size = UDim2.new(0, 250, 0, 240)
consoleFrame.Position = UDim2.new(0, 10, 0, 50)
consoleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
consoleFrame.BorderSizePixel = 0
consoleFrame.Visible = false
consoleFrame.Parent = screenGui
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 6)

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = consoleFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "Exploit Command"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 25, 1, 0)
minimizeButton.Position = UDim2.new(1, -30, 0, 0)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 16
minimizeButton.Parent = titleBar

-- Список команд
local commandList = Instance.new("TextLabel")
commandList.Size = UDim2.new(1, -10, 1, -35)
commandList.Position = UDim2.new(0, 5, 0, 30)
commandList.Text = [[Доступные команды:
;explode-killers     - Взорвать всех
;kill-killers        - Убить всех
;give ammo           - Дать патроны
;give M16A2          - Дать M16A2
;give SVD            - Дать SVD
;give MP5k           - Дать MP5k
;give R870           - Дать R870
;weapons-upgrade     - Улучшить оружие
;give all-missions   - Дать все миссии
;whocreate           - Кто создал
.boom-tool           - Создать Boom Tool]]
commandList.TextColor3 = Color3.fromRGB(200, 200, 200)
commandList.BackgroundTransparency = 1
commandList.Font = Enum.Font.SourceSans
commandList.TextSize = 11
commandList.TextXAlignment = Enum.TextXAlignment.Left
commandList.TextYAlignment = Enum.TextYAlignment.Top
commandList.Parent = consoleFrame

-- === ЛОГИКА ОКНА ===
local isConsoleOpen = false

local function toggleConsole()
    isConsoleOpen = not isConsoleOpen
    consoleFrame.Visible = isConsoleOpen
    toggleButton.Text = isConsoleOpen and "< Exploit" or "> Exploit"
end

toggleButton.MouseButton1Click:Connect(toggleConsole)
minimizeButton.MouseButton1Click:Connect(toggleConsole)

-- === ЛОГИКА КОМАНД (из classic-Area51.lua) ===
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ====== ФУНКЦИЯ ДЛЯ ОТПРАВКИ СООБЩЕНИЙ В ЧАТ ======

local function sendChatMessage(message)
    local TextChatService = game:GetService("TextChatService")
    local channel = TextChatService:FindFirstChild("TextChannels")
    if channel then
        channel = channel:FindFirstChild("RBXGeneral")
    end
    if channel then
        pcall(function()
            channel:SendAsync(message)
            print("✅ Сообщение отправлено в чат!")
        end)
    else
        pcall(function()
            game:GetService("Chat"):Chat(LocalPlayer.Character, message)
            print("✅ Сообщение отправлено в чат (Legacy)!")
        end)
    end
end

-- ====== ФУНКЦИИ ДЛЯ КОМАНД ======

-- Функция: Убить всех (kill-killers)
local function killAllKillersOnce()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local hasWeapon = false
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" and tool:FindFirstChild("Hit") then
            hasWeapon = true
            break
        end
    end

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

-- Функция: Взорвать всех (explode-killers)
local function explodeAllKillersOnce()
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

    local killers = workspace:FindFirstChild("Killers")
    if not killers then return end

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

-- Функция: Взорвать в конкретной точке
local function explodeAtPosition(position)
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

    pcall(function()
        grenadeEvent:FireServer(position)
    end)
end

-- Функция: Дать оружие
local function giveWeapon(weaponName)
    local char = LocalPlayer.Character
    if not char then
        print("❌ Персонаж не найден")
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        print("❌ HumanoidRootPart не найден")
        return
    end

    local paths = {
        M16A2 = workspace.M16A2Room and workspace.M16A2Room["M16A2/M203"] and workspace.M16A2Room["M16A2/M203"]["M16A2/M203 Giver"] and workspace.M16A2Room["M16A2/M203"]["M16A2/M203 Giver"]["PUT THE WEAPON IN THIS BRICK"],
        SVD = workspace.SVD and workspace.SVD.SVDGiver and workspace.SVD.SVDGiver.Reward,
        MP5k = workspace.MP5k and workspace.MP5k["MP5k Giver"] and workspace.MP5k["MP5k Giver"]["PUT THE WEAPON IN THIS BRICK"],
        R870 = workspace.R870 and workspace.R870["R870 Giver"] and workspace.R870["R870 Giver"]["PUT THE WEAPON IN THIS BRICK"]
    }

    local part = paths[weaponName]
    if not part then
        print("❌ Оружие " .. weaponName .. " не найдено на карте")
        return
    end

    pcall(function()
        firetouchinterest(root, part, 0)
        task.wait(0.1)
        firetouchinterest(root, part, 1)
        print("✅ " .. weaponName .. " выдано!")
    end)
end

-- Функция: Дать патроны
local function giveAmmo()
    local Event = game:GetService("ReplicatedStorage"):FindFirstChild("RefillAmmo")
    if Event then
        pcall(function()
            firesignal(Event.OnClientEvent)
            print("✅ Патроны выданы!")
        end)
    else
        print("❌ RefillAmmo не найден")
    end
end

-- Функция: Улучшить всё оружие (weapons-upgrade)
local function upgradeWeapons()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then
        print("❌ Backpack не найден")
        return
    end

    local papEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PAPRemoteEvent")
    if not papEvent then
        print("❌ PAPRemoteEvent не найден")
        return
    end

    local count = 0
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name ~= "Flashlight" then
            pcall(function()
                papEvent:FireServer("PerformUpgrade", tool.Name)
                count = count + 1
                task.wait(0.1)
            end)
        end
    end
    print("✅ Улучшено оружий: " .. count)
end

-- Функция: Дать все миссии (give all-missions)
local function giveAllMissions()
    local secrets = workspace:FindFirstChild("Secrets")
    if not secrets then
        print("❌ Папка Secrets не найдена")
        return
    end

    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local paths = {
        "SecretPath5", "SecretPath6", "ZombieMorph", "SecretPath2",
        "SecretPath3", "SecretPath4", "R870", "RayGun", "SVD",
        "SecretPath1", "Paper1", "Paper2", "Paper3", "M16A2/M203",
        "MP5k", "PackAPunch", "M14", "Giant", "Alien", "AmmoBag",
        "ExecutionRoom", "M1911"
    }

    local count = 0
    for _, name in ipairs(paths) do
        local obj = secrets:FindFirstChild(name)
        if obj and obj:IsA("BasePart") then
            pcall(function()
                firetouchinterest(root, obj, 0)
                task.wait(0.05)
                firetouchinterest(root, obj, 1)
                count = count + 1
            end)
        elseif obj then
            local part = obj:FindFirstChildWhichIsA("BasePart")
            if part then
                pcall(function()
                    firetouchinterest(root, part, 0)
                    task.wait(0.05)
                    firetouchinterest(root, part, 1)
                    count = count + 1
                end)
            end
        end
        task.wait(0.03)
    end
    print("✅ Выдано миссий: " .. count)
end

-- Функция: Отправить сообщение от имени игрока
local function whocreate()
    local message = "SpyNote the official Creater This Expl0it Script! That's for using Me"
    sendChatMessage(message)
end

-- ====== УНИКАЛЬНАЯ КОМАНДА .boom-tool (ДЛЯ МОБИЛЬНЫХ) ======

local function createBoomTool()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChild("Boom Tool") then
        print("❌ Boom Tool уже в инвентаре!")
        return
    end

    local tool = Instance.new("Tool")
    tool.Name = "Boom Tool"
    tool.RequiresHandle = false
    tool.CanBeDropped = true
    tool.Parent = backpack

    local cooldown = false

    -- Функция для получения позиции касания в мире
    local function getWorldPosition(input)
        local camera = workspace.CurrentCamera
        if not camera then return nil end
        local viewportPoint = input.Position
        local ray = camera:ScreenPointToRay(viewportPoint.X, viewportPoint.Y)
        local direction = ray.Direction * 1000
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        local hit, position, normal = workspace:Raycast(ray.Origin, direction, raycastParams)
        if hit and position then
            return position
        else
            return ray.Origin + direction
        end
    end

    -- Обработчик касания (для мобильных)
    local function onTouch(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType ~= Enum.UserInputType.Touch then return end
        if cooldown then return end
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("Boom Tool") then
            return
        end
        cooldown = true
        task.wait(0.2)
        cooldown = false

        local pos = getWorldPosition(input)
        if pos then
            explodeAtPosition(pos)
            print("💥 Взрыв в: " .. tostring(pos))
        end
    end

    -- Подписываемся на касания (для мобильных)
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        onTouch(input, gameProcessed)
    end)

    -- Чистим соединение при уничтожении инструмента
    tool.AncestryChanged:Connect(function()
        if not tool.Parent or (tool.Parent ~= LocalPlayer.Character and tool.Parent ~= LocalPlayer.Backpack) then
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end)

    print("✅ Boom Tool создан! Возьми в руки и коснись экрана для взрыва.")
end

-- ====== ОБРАБОТЧИК СООБЩЕНИЙ В ЧАТЕ ======
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    if msg == ";explode-killers" then
        explodeAllKillersOnce()
        print("[Exploit] Взрыв выполнен!")
    elseif msg == ";kill-killers" then
        killAllKillersOnce()
        print("[Exploit] Убийство выполнено!")
    elseif msg == ";give ammo" or msg == ";give Ammo" then
        giveAmmo()
    elseif msg == ";weapons-upgrade" or msg == ";weapons Upgrade" then
        upgradeWeapons()
    elseif msg == ";give all-missions" or msg == ";give missions" then
        giveAllMissions()
    elseif msg == ";whocreate" or msg == ";who create" then
        whocreate()
    elseif msg == ".boom-tool" then
        createBoomTool()
    elseif msg:match("^;give ") then
        local weaponName = msg:gsub(";give ", "")
        local validWeapons = {M16A2 = true, SVD = true, MP5k = true, R870 = true}
        if validWeapons[weaponName] then
            giveWeapon(weaponName)
        else
            print("❌ Неизвестное оружие. Доступны: M16A2, SVD, MP5k, R870")
        end
    end
end)

print("[Exploit] Команды активированы!")
print("Доступные команды:")
print(";explode-killers - Взорвать всех")
print(";kill-killers - Убить всех")
print(";give ammo - Дать патроны")
print(";give M16A2 - Дать M16A2")
print(";give SVD - Дать SVD")
print(";give MP5k - Дать MP5k")
print(";give R870 - Дать R870")
print(";weapons-upgrade - Улучшить всё оружие")
print(";give all-missions - Дать все миссии")
print(";whocreate - Отправить сообщение в чат")
print(".boom-tool - Создать Boom Tool (взрыв по касанию)")

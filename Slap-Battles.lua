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

ScreenGui.Name = "SlapBattlesLMAO"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -160)
MainFrame.Size = UDim2.new(0, 360, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = " Slap-Battles LMAO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
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
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LeftPanel.BorderSizePixel = 0
LeftPanel.Size = UDim2.new(0, 80, 1, -30)
LeftPanel.Position = UDim2.new(0, 0, 0, 30)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
RightPanel.BorderSizePixel = 0
RightPanel.Size = UDim2.new(1, -85, 1, -35)
RightPanel.Position = UDim2.new(0, 85, 0, 35)

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
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
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
local playerBtn, playerTab = createTab("Player", "Player")
local auraBtn, auraTab = createTab("Aura", "Aura")
local farmBtn, farmTab = createTab("Farm", "Farm")
local teleportBtn, teleportTab = createTab("Teleport", "Teleport")
local settingsBtn, settingsTab = createTab("Settings", "Settings")

infoTab.Visible = true

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "Slap-Battles LMAO\nCreate by Lmao-spynote"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.BackgroundTransparency = 1
infoLabel.Parent = infoTab

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local auraActive = false
local auraThread = nil
local settingsRadius = 30
local settingsSpeed = 0.7

local auraButton = Instance.new("TextButton")
auraButton.Size = UDim2.new(1, 0, 0, 40)
auraButton.Position = UDim2.new(0.5, -80, 0.5, -20)
auraButton.Text = "Aura OFF"
auraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
auraButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
auraButton.Font = Enum.Font.SourceSansBold
auraButton.TextSize = 16
auraButton.BorderSizePixel = 0
auraButton.Parent = auraTab
Instance.new("UICorner", auraButton).CornerRadius = UDim.new(0, 6)

local function getGloveName()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if not leaderstats then return nil end
    local glove = leaderstats:FindFirstChild("Glove")
    if not glove then return nil end
    return glove.Value
end

local function stopAura()
    if auraThread then
        task.cancel(auraThread)
        auraThread = nil
    end
end

local function startAura()
    stopAura()
    auraActive = true

    local gloveName = getGloveName()
    if not gloveName or gloveName == "" then
        auraButton.Text = "No glove!"
        task.wait(2)
        auraButton.Text = "Aura OFF"
        auraActive = false
        return
    end

    local event = nil
    local extraArg = nil

    -- Исключение для Extended
    if gloveName == "Extended" then
        event = ReplicatedStorage:FindFirstChild("b")
    -- Исключение для Golden важно false обычный удар а true это под ульт
    elseif gloveName == "Golden" then
        event = ReplicatedStorage:FindFirstChild("GoldenHit")
        extraArg = true
    else
        -- Обычный поиск для остальных перчаток
        local eventNames = {
            gloveName .. "Hit",
            string.lower(gloveName) .. "hit",
            gloveName,
            string.lower(gloveName),
            string.upper(gloveName) .. "HIT",
            string.lower(gloveName) .. "Hit",
            gloveName .. "HIT",
            string.lower(gloveName) .. "HIT"
        }
        for _, name in ipairs(eventNames) do
            local ev = ReplicatedStorage:FindFirstChild(name)
            if ev then
                event = ev
                break
            end
        end
    end

    if not event then
        event = ReplicatedStorage:FindFirstChild("GeneralHit")
    end

    if not event then
        auraButton.Text = "No event!"
        task.wait(2)
        auraButton.Text = "Aura OFF"
        auraActive = false
        return
    end

    auraButton.Text = "Aura ON"
    auraButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    auraButton.TextColor3 = Color3.fromRGB(0, 0, 0)

    auraThread = task.spawn(function()
        while auraActive do
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local otherChar = player.Character
                            if otherChar then
                                local otherHrp = otherChar:FindFirstChild("HumanoidRootPart")
                                if otherHrp then
                                    local dist = (hrp.Position - otherHrp.Position).Magnitude
                                    if dist <= settingsRadius then
                                        if gloveName == "Extended" then
                                            pcall(function()
                                                event:FireServer(otherHrp)
                                            end)
                                        elseif gloveName == "Golden" then
                                            local rightArm = otherChar:FindFirstChild("Right Arm")
                                            if rightArm then
                                                pcall(function()
                                                    event:FireServer(rightArm, extraArg)
                                                end)
                                            end
                                        else
                                            local rightArm = otherChar:FindFirstChild("Right Arm")
                                            if rightArm then
                                                pcall(function()
                                                    event:FireServer(rightArm)
                                                end)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            task.wait(settingsSpeed)
        end
    end)
end

auraButton.MouseButton1Click:Connect(function()
    auraActive = not auraActive
    if auraActive then
        startAura()
    else
        auraButton.Text = "Aura OFF"
        auraButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        auraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        stopAura()
    end
end)

local radiusInput = Instance.new("TextBox")
radiusInput.Size = UDim2.new(1, 0, 0, 25)
radiusInput.PlaceholderText = "30"
radiusInput.Text = "30"
radiusInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
radiusInput.TextColor3 = Color3.new(1, 1, 1)
radiusInput.Font = Enum.Font.SourceSans
radiusInput.TextSize = 14
radiusInput.Parent = settingsTab
Instance.new("UICorner", radiusInput).CornerRadius = UDim.new(0, 4)

local radiusBtn = Instance.new("TextButton")
radiusBtn.Size = UDim2.new(1, 0, 0, 32)
radiusBtn.Text = "Set Studs"
radiusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
radiusBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
radiusBtn.Font = Enum.Font.SourceSansBold
radiusBtn.TextSize = 14
radiusBtn.BorderSizePixel = 0
radiusBtn.Parent = settingsTab
Instance.new("UICorner", radiusBtn).CornerRadius = UDim.new(0, 4)

radiusBtn.MouseButton1Click:Connect(function()
    local val = tonumber(radiusInput.Text)
    if val and val > 0 then
        settingsRadius = val
        radiusInput.Text = tostring(val)
    else
        radiusInput.Text = tostring(settingsRadius)
    end
end)

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(1, 0, 0, 25)
speedInput.PlaceholderText = "0.7"
speedInput.Text = "0.7"
speedInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
speedInput.TextColor3 = Color3.new(1, 1, 1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 14
speedInput.Parent = settingsTab
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 4)

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, 0, 0, 32)
speedBtn.Text = "Set Time"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
speedBtn.Font = Enum.Font.SourceSansBold
speedBtn.TextSize = 14
speedBtn.BorderSizePixel = 0
speedBtn.Parent = settingsTab
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 4)

speedBtn.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val and val > 0 then
        settingsSpeed = val
        speedInput.Text = tostring(val)
        if auraActive then
            stopAura()
            startAura()
        end
    else
        speedInput.Text = tostring(settingsSpeed)
    end
end)

-- ==================== FARM TAB ====================
local farmOneBtn = Instance.new("TextButton")
farmOneBtn.Size = UDim2.new(1, 0, 0, 40)
farmOneBtn.Text = "one-slap-get"
farmOneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOneBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
farmOneBtn.Font = Enum.Font.SourceSansBold
farmOneBtn.TextSize = 16
farmOneBtn.BorderSizePixel = 0
farmOneBtn.Parent = farmTab
Instance.new("UICorner", farmOneBtn).CornerRadius = UDim.new(0, 6)

local farmAutoActive = false
local farmAutoThread = nil

local farmAutoBtn = Instance.new("TextButton")
farmAutoBtn.Size = UDim2.new(1, 0, 0, 40)
farmAutoBtn.Text = "auto-farm-slap OFF"
farmAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
farmAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
farmAutoBtn.Font = Enum.Font.SourceSansBold
farmAutoBtn.TextSize = 16
farmAutoBtn.BorderSizePixel = 0
farmAutoBtn.Parent = farmTab
Instance.new("UICorner", farmAutoBtn).CornerRadius = UDim.new(0, 6)

local function getSlapTouchInterests()
    local arena = workspace:FindFirstChild("Arena")
    if not arena then return {} end
    local island5 = arena:FindFirstChild("island5")
    if not island5 then return {} end
    local slapples = island5:FindFirstChild("Slapples")
    if not slapples then return {} end

    local results = {}
    local descendants = slapples:GetDescendants()
    for _, obj in pairs(descendants) do
        if obj:IsA("BasePart") and obj:FindFirstChildOfClass("TouchTransmitter") then
            table.insert(results, obj)
        end
    end
    return results
end

local function slapAll()
    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local objects = getSlapTouchInterests()
    for _, obj in pairs(objects) do
        pcall(function()
            firetouchinterest(rootPart, obj, 0)
            task.wait()
            firetouchinterest(rootPart, obj, 1)
        end)
    end
end

farmOneBtn.MouseButton1Click:Connect(function()
    slapAll()
    farmOneBtn.Text = "Done!"
    task.wait(1.5)
    farmOneBtn.Text = "one-slap-get"
end)

local function stopFarmAuto()
    if farmAutoThread then
        task.cancel(farmAutoThread)
        farmAutoThread = nil
    end
end

local function startFarmAuto()
    stopFarmAuto()
    farmAutoActive = true
    farmAutoBtn.Text = "auto-farm-slap ON"
    farmAutoBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
    farmAutoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

    farmAutoThread = task.spawn(function()
        while farmAutoActive do
            slapAll()
            task.wait(0.5)
        end
    end)
end

farmAutoBtn.MouseButton1Click:Connect(function()
    farmAutoActive = not farmAutoActive
    if farmAutoActive then
        startFarmAuto()
    else
        farmAutoBtn.Text = "auto-farm-slap OFF"
        farmAutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        farmAutoBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        stopFarmAuto()
    end
end)

-- ==================== TELEPORT TAB ====================
local function createTPButton(parent, name, cframe)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe
        end
    end)
    return btn
end

createTPButton(teleportTab, "Arena", CFrame.new(-1.45848584, -5.17286634, 5.90687323, 0.980471313, 7.10163306e-08, -0.196662202, -5.78279327e-08, 1, 7.28035303e-08, 0.196662202, -6.00091994e-08, 0.980471313))
createTPButton(teleportTab, "Island5", CFrame.new(-397.40271, 48.655201, -16.2150345, -0.889724016, 2.2067983e-08, -0.456498861, 3.52799461e-08, 1, -2.0419396e-08, 0.456498861, -3.42728832e-08, -0.889724016))
createTPButton(teleportTab, "Island4", CFrame.new(-201.053955, -5.2782979, -3.01133037, -0.952727675, 9.04268216e-09, 0.303825587, 2.55092356e-08, 1, 5.0228401e-08, -0.303825587, 5.5604346e-08, -0.952727675))
createTPButton(teleportTab, "Island3", CFrame.new(3.15288162, -5.06742907, 175.115463, -0.981112599, 5.88456173e-09, -0.193437561, 7.35458583e-09, 1, -6.88136881e-09, 0.193437561, -8.17405077e-09, -0.981112599))
createTPButton(teleportTab, "Island2", CFrame.new(-6.93693304, -5.14445829, -195.899261, 0.937894583, -1.26653568e-08, -0.346920341, 4.15567882e-08, 1, 7.58402621e-08, 0.346920341, -8.55470716e-08, 0.937894583))

-- ==================== SETTINGS ====================
local clearSettingsBtn = Instance.new("TextButton")
clearSettingsBtn.Size = UDim2.new(1, 0, 0, 32)
clearSettingsBtn.Position = UDim2.new(0, 0, 1, -36)
clearSettingsBtn.Text = "Reset Settings"
clearSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearSettingsBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
clearSettingsBtn.Font = Enum.Font.SourceSansBold
clearSettingsBtn.TextSize = 14
clearSettingsBtn.BorderSizePixel = 0
clearSettingsBtn.Parent = settingsTab
Instance.new("UICorner", clearSettingsBtn).CornerRadius = UDim.new(0, 4)

clearSettingsBtn.MouseButton1Click:Connect(function()
    settingsRadius = 30
    settingsSpeed = 0.7
    radiusInput.Text = "30"
    speedInput.Text = "0.7"
    if auraActive then
        stopAura()
        startAura()
    end
end)

-- ==================== PLAYER TAB ====================
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Text = ""
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.BackgroundTransparency = 1
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = playerTab

local speedInputPlayer = Instance.new("TextBox")
speedInputPlayer.Size = UDim2.new(1, 0, 0, 25)
speedInputPlayer.PlaceholderText = "20"
speedInputPlayer.Text = "20"
speedInputPlayer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
speedInputPlayer.TextColor3 = Color3.new(1, 1, 1)
speedInputPlayer.Font = Enum.Font.SourceSans
speedInputPlayer.TextSize = 14
speedInputPlayer.Parent = playerTab
Instance.new("UICorner", speedInputPlayer).CornerRadius = UDim.new(0, 4)

local setSpeedBtn = Instance.new("TextButton")
setSpeedBtn.Size = UDim2.new(1, 0, 0, 32)
setSpeedBtn.Text = "Set Speed"
setSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setSpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
setSpeedBtn.Font = Enum.Font.SourceSansBold
setSpeedBtn.TextSize = 14
setSpeedBtn.BorderSizePixel = 0
setSpeedBtn.Parent = playerTab
Instance.new("UICorner", setSpeedBtn).CornerRadius = UDim.new(0, 4)

local originalSpeed = 16
local speedValue = 20

setSpeedBtn.MouseButton1Click:Connect(function()
    local val = tonumber(speedInputPlayer.Text)
    if val and val > 0 then
        speedValue = val
        speedInputPlayer.Text = tostring(val)
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = val
            end
        end
    else
        speedInputPlayer.Text = tostring(speedValue)
    end
end)

local invisiblePartActive = false
local invisiblePart = nil
-- Платформа ниже (изменён Y с -5.17 на -20)
local platformCFrame = CFrame.new(90.2251129, -17, -88.9260788, -0.384783238, 8.77443256e-08, 0.923006952, -8.72101413e-09, 1, -9.86991751e-08, -0.923006952, -4.60273455e-08, -0.384783238)

local invisiblePartBtn = Instance.new("TextButton")
invisiblePartBtn.Size = UDim2.new(1, 0, 0, 40)
invisiblePartBtn.Text = "invisible-part OFF"
invisiblePartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
invisiblePartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invisiblePartBtn.Font = Enum.Font.SourceSansBold
invisiblePartBtn.TextSize = 16
invisiblePartBtn.BorderSizePixel = 0
invisiblePartBtn.Parent = playerTab
Instance.new("UICorner", invisiblePartBtn).CornerRadius = UDim.new(0, 6)

local function createPlatform()
    if invisiblePart then
        invisiblePart:Destroy()
        invisiblePart = nil
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local part = Instance.new("Part")
    part.Name = "InvisiblePlatform"
    part.Size = Vector3.new(1000, 0.5, 1000)
    part.CFrame = platformCFrame
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = 0.7
    part.Color = Color3.fromRGB(100, 100, 100)
    part.Material = Enum.Material.SmoothPlastic
    part.Parent = workspace
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(100, 100, 100)
    highlight.FillTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(100, 100, 100)
    highlight.OutlineTransparency = 0.5
    highlight.Parent = part
    
    invisiblePart = part
end

local function removePlatform()
    if invisiblePart then
        invisiblePart:Destroy()
        invisiblePart = nil
    end
end

invisiblePartBtn.MouseButton1Click:Connect(function()
    invisiblePartActive = not invisiblePartActive
    
    if invisiblePartActive then
        invisiblePartBtn.Text = "invisible-part ON"
        invisiblePartBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        invisiblePartBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        createPlatform()
    else
        invisiblePartBtn.Text = "invisible-part OFF"
        invisiblePartBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        invisiblePartBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
        removePlatform()
    end
end)

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
    if auraThread then
        task.cancel(auraThread)
        auraThread = nil
    end
    if farmAutoThread then
        task.cancel(farmAutoThread)
        farmAutoThread = nil
    end
    removePlatform()
    ScreenGui:Destroy()
    collectgarbage()
end)

infoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
infoBtn.TextColor3 = Color3.new(1, 1, 1)

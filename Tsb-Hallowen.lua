-- id game 10449761463
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui")
sg.Name = "HalloweenFarmGui"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 100
sg.Parent = PG

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 300, 0, 310)
main.Position = UDim2.new(0.5, -150, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ZIndex = 1
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(70, 70, 90)
mainStroke.Thickness = 1

local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
topBar.BorderSizePixel = 0
topBar.ZIndex = 5
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "HalloweenFarm Gui"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 6

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 35, 35)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 6
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local minBtn = Instance.new("TextButton", topBar)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -56, 0, 2)
minBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.AutoButtonColor = false
minBtn.ZIndex = 6
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local miniBtn = Instance.new("TextButton", sg)
miniBtn.Size = UDim2.new(0, 150, 0, 26)
miniBtn.Position = UDim2.new(0.5, -75, 0, 5)
miniBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
miniBtn.Text = "HalloweenFarm Gui"
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 11
miniBtn.AutoButtonColor = false
miniBtn.Visible = false
miniBtn.ZIndex = 10
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 6)
minBtn.MouseButton1Click:Connect(function() main.Visible = false miniBtn.Visible = true end)
miniBtn.MouseButton1Click:Connect(function() main.Visible = true miniBtn.Visible = false end)

local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1, -24, 0, 26)
tabBar.Position = UDim2.new(0, 12, 0, 34)
tabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
tabBar.BorderSizePixel = 0
tabBar.ZIndex = 10
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 6)
local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local pagesHolder = Instance.new("Frame", main)
pagesHolder.Size = UDim2.new(1, -24, 1, -96)
pagesHolder.Position = UDim2.new(0, 12, 0, 64)
pagesHolder.BackgroundTransparency = 1
pagesHolder.ZIndex = 1

local farmPage = Instance.new("Frame", pagesHolder)
farmPage.Size = UDim2.new(1, 0, 1, 0)
farmPage.BackgroundTransparency = 1
farmPage.Visible = true
farmPage.ZIndex = 1

local farmStatus = Instance.new("TextLabel", farmPage)
farmStatus.Size = UDim2.new(1, 0, 0, 18)
farmStatus.Position = UDim2.new(0, 0, 0, 0)
farmStatus.BackgroundTransparency = 1
farmStatus.Text = "Ready"
farmStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
farmStatus.Font = Enum.Font.Gotham
farmStatus.TextSize = 11
farmStatus.TextXAlignment = Enum.TextXAlignment.Left
farmStatus.TextTruncate = Enum.TextTruncate.AtEnd
farmStatus.ZIndex = 2

local farmCount = Instance.new("TextLabel", farmPage)
farmCount.Size = UDim2.new(1, 0, 0, 16)
farmCount.Position = UDim2.new(0, 0, 0, 18)
farmCount.BackgroundTransparency = 1
farmCount.Text = "Doors: ? | Penyata: ?"
farmCount.TextColor3 = Color3.fromRGB(150, 150, 165)
farmCount.Font = Enum.Font.Gotham
farmCount.TextSize = 11
farmCount.TextXAlignment = Enum.TextXAlignment.Left
farmCount.ZIndex = 2

local function createPageBtn(parent, text, y, color, height)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, height or 28)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.AutoButtonColor = false
    b.ZIndex = 2
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local farmBtn = createPageBtn(farmPage, "Farm One", 40, Color3.fromRGB(60, 150, 60))

local notifBtn = createPageBtn(farmPage, "Penyata-Notifier: ×", 72, Color3.fromRGB(50, 50, 60))
notifBtn.Size = UDim2.new(0.55, -3, 0, 28)

local tpBtn = createPageBtn(farmPage, "Penyata-TP", 72, Color3.fromRGB(60, 90, 160))
tpBtn.Size = UDim2.new(0.45, -3, 0, 28)
tpBtn.Position = UDim2.new(0.55, 3, 0, 72)

local storeBtn = createPageBtn(farmPage, "TP to Store", 104, Color3.fromRGB(150, 100, 40))

local backBtn = createPageBtn(farmPage, "Penyata-Back: ×", 136, Color3.fromRGB(80, 50, 130))

local infoPage = Instance.new("Frame", pagesHolder)
infoPage.Size = UDim2.new(1, 0, 1, 0)
infoPage.BackgroundTransparency = 1
infoPage.Visible = false
infoPage.ZIndex = 1

local infoText = Instance.new("TextLabel", infoPage)
infoText.Size = UDim2.new(1, 0, 1, 0)
infoText.BackgroundTransparency = 1
infoText.Text = [[HalloweenFarm Gui

Farm:
• Farm One - random door teleport
• Penyata-Notifier - watches Penyata
• Penyata-TP - teleport to Penyata
• TP to Store - teleport to shop
• Penyata-Back - teleport behind-spam
  Penyata and hold position]]
infoText.TextColor3 = Color3.fromRGB(180, 180, 195)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 11
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.TextWrapped = true
infoText.ZIndex = 2

local tabs = {}
local function setTab(name)
    farmPage.Visible = (name == "Farm")
    infoPage.Visible = (name == "Info")
    for tname, btn in pairs(tabs) do
        if tname == name then
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            btn.TextColor3 = Color3.new(1,1,1)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            btn.TextColor3 = Color3.fromRGB(150, 150, 160)
        end
    end
end

local function createTab(name)
    local b = Instance.new("TextButton", tabBar)
    b.Size = UDim2.new(0, 80, 0, 20)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(150, 150, 160)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    b.ZIndex = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(function() setTab(name) end)
    tabs[name] = b
    return b
end

createTab("Farm")
createTab("Info")
setTab("Farm")

local function setFarmStatus(t, c)
    farmStatus.Text = t
    farmStatus.TextColor3 = c or Color3.fromRGB(200,200,200)
end

local function isTrash(prompt)
    local cur = prompt
    while cur and cur ~= workspace do
        if cur.Name:lower():find("trash", 1, true) then return true end
        cur = cur.Parent
    end
    return false
end

local function findAllPrompts()
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and not isTrash(obj) then
            table.insert(found, obj)
        end
    end
    return found
end

local function getPromptPart(prompt)
    if prompt.Parent and prompt.Parent:IsA("BasePart") then return prompt.Parent end
    local p = prompt.Parent
    if p then
        for _, ch in ipairs(p:GetChildren()) do
            if ch:IsA("BasePart") then return ch end
        end
        local up = p
        while up and not up:IsA("BasePart") do up = up.Parent end
        if up then return up end
    end
    return nil
end

local function tpTo(part)
    local char = LP.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local doorPos = part.Position
    local dir = (hrp.Position - doorPos)
    dir = Vector3.new(dir.X, 0, dir.Z)
    if dir.Magnitude < 0.1 then dir = Vector3.new(0,0,1) end
    dir = dir.Unit
    local finalPos = doorPos + dir * 2.2 + Vector3.new(0, 2.5, 0)
    local look = CFrame.new(finalPos, Vector3.new(doorPos.X, finalPos.Y, doorPos.Z))
    local tw = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = look})
    tw:Play()
    tw.Completed:Wait()
    return true
end

local function firePromptOnce(prompt)
    local was = prompt.Enabled
    if not was then
        prompt.Enabled = true
        task.wait(0.05)
    end
    pcall(function() fireproximityprompt(prompt) end)
    if not was then
        task.wait(0.05)
        pcall(function() prompt.Enabled = false end)
    end
end

local function getPenyataModel()
    local live = workspace:FindFirstChild("Live")
    if not live then return nil end
    for _, ch in ipairs(live:GetChildren()) do
        if (ch.Name == "Penyta" or ch.Name == "Penyata") and (ch:IsA("Model") or ch:IsA("BasePart")) then
            return ch
        end
    end
    return nil
end

local function getPenyataPart(model)
    if not model then return nil end
    if model:IsA("BasePart") then return model end
    if model:IsA("Model") then
        local hrp = model:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:IsA("BasePart") then return hrp end
        local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
        if torso and torso:IsA("BasePart") then return torso end
        if model.PrimaryPart then return model.PrimaryPart end
        return model:FindFirstChildWhichIsA("BasePart")
    end
    return nil
end

local busy = false
farmBtn.MouseButton1Click:Connect(function()
    if busy then return end
    busy = true
    farmBtn.BackgroundColor3 = Color3.fromRGB(110,110,110)

    setFarmStatus("Searching doors...", Color3.fromRGB(220,220,100))
    local list = findAllPrompts()
    local peny = getPenyataModel()
    farmCount.Text = "Doors: " .. #list .. " | Penyata: " .. (peny and "yes" or "no")

    if #list == 0 then
        setFarmStatus("No doors found", Color3.fromRGB(255,80,80))
        busy = false
        farmBtn.BackgroundColor3 = Color3.fromRGB(60,150,60)
        return
    end

    local prompt = list[math.random(1, #list)]
    local part = getPromptPart(prompt)
    if not part then
        setFarmStatus("No door part", Color3.fromRGB(255,80,80))
        busy = false
        farmBtn.BackgroundColor3 = Color3.fromRGB(60,150,60)
        return
    end

    setFarmStatus("Teleport...", Color3.fromRGB(220,220,100))
    if not tpTo(part) then
        setFarmStatus("TP fail", Color3.fromRGB(255,80,80))
        busy = false
        farmBtn.BackgroundColor3 = Color3.fromRGB(60,150,60)
        return
    end

    task.wait(0.3)
    setFarmStatus("Fire...", Color3.fromRGB(220,220,100))
    firePromptOnce(prompt)

    setFarmStatus("Done ✓", Color3.fromRGB(80,210,80))
    busy = false
    farmBtn.BackgroundColor3 = Color3.fromRGB(60,150,60)
end)

tpBtn.MouseButton1Click:Connect(function()
    local model = getPenyataModel()
    local part = getPenyataPart(model)
    if not part then
        setFarmStatus("No Penyata", Color3.fromRGB(255,120,120))
        return
    end
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetPos = part.Position + Vector3.new(0, 3, 0)
    local look = CFrame.new(targetPos, part.Position)
    local tw = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = look})
    tw:Play()
    tw.Completed:Wait()
    setFarmStatus("TP to Penyata ✓", Color3.fromRGB(100, 180, 255))
end)

local STORE_CFRAME = CFrame.new(
    554.537598, 443.957733, -442.86264,
    -0.406192094, -4.43955486e-08, -0.913787723,
    -4.66577603e-08, 1, -2.78440311e-08,
    0.913787723, 3.13252642e-08, -0.406192094
)

storeBtn.MouseButton1Click:Connect(function()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tw = TweenService:Create(hrp, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = STORE_CFRAME})
    tw:Play()
    tw.Completed:Wait()
    setFarmStatus("TP to Store ✓", Color3.fromRGB(255, 180, 60))
end)

local notifierEnabled = false
local notifierLoopRunning = false
local lastPenyataState = false
local notifGui = nil
local notifQueue = 0

local function showNotif(modelName)
    notifQueue = notifQueue + 1
    local myId = notifQueue
    if notifGui then pcall(function() notifGui:Destroy() end) notifGui = nil end

    notifGui = Instance.new("ScreenGui")
    notifGui.Name = "PenyataNotif"
    notifGui.ResetOnSpawn = false
    notifGui.IgnoreGuiInset = true
    notifGui.DisplayOrder = 999
    notifGui.Parent = PG

    local box = Instance.new("Frame", notifGui)
    box.Size = UDim2.new(0, 260, 0, 56)
    box.Position = UDim2.new(0.5, -130, 0, -70)
    box.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(170, 100, 255)
    stroke.Thickness = 2

    local icon = Instance.new("TextLabel", box)
    icon.Size = UDim2.new(0, 36, 0, 36)
    icon.Position = UDim2.new(0, 10, 0.5, -18)
    icon.BackgroundColor3 = Color3.fromRGB(170, 100, 255)
    icon.Text = "!"
    icon.TextColor3 = Color3.new(1,1,1)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 20
    Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

    local ttl = Instance.new("TextLabel", box)
    ttl.Size = UDim2.new(1, -60, 0, 20)
    ttl.Position = UDim2.new(0, 54, 0, 8)
    ttl.BackgroundTransparency = 1
    ttl.Text = "Penyata appeared!"
    ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
    ttl.Font = Enum.Font.GothamBold
    ttl.TextSize = 13
    ttl.TextXAlignment = Enum.TextXAlignment.Left

    local sub = Instance.new("TextLabel", box)
    sub.Size = UDim2.new(1, -60, 0, 16)
    sub.Position = UDim2.new(0, 54, 0, 30)
    sub.BackgroundTransparency = 1
    sub.Text = "workspace.Live." .. (modelName or "Penyta")
    sub.TextColor3 = Color3.fromRGB(200, 180, 255)
    sub.Font = Enum.Font.Code
    sub.TextSize = 10
    sub.TextXAlignment = Enum.TextXAlignment.Left

    local tweenIn = TweenService:Create(box, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -130, 0, 10)
    })
    tweenIn:Play()

    task.delay(3, function()
        if myId ~= notifQueue then return end
        if notifGui and notifGui.Parent then
            local tweenOut = TweenService:Create(box, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -130, 0, -70)
            })
            tweenOut:Play()
            tweenOut.Completed:Wait()
            pcall(function() notifGui:Destroy() end)
            notifGui = nil
        end
    end)
end

local function notifierLoop()
    if notifierLoopRunning then return end
    notifierLoopRunning = true
    while notifierEnabled and sg.Parent do
        local model = getPenyataModel()
        local nowExists = model ~= nil
        if nowExists and not lastPenyataState then
            showNotif(model.Name)
            setFarmStatus("Penyata appeared!", Color3.fromRGB(200, 140, 255))
        elseif not nowExists and lastPenyataState then
            setFarmStatus("Penyata left", Color3.fromRGB(180, 180, 180))
        end
        lastPenyataState = nowExists
        local doorsCount = #findAllPrompts()
        farmCount.Text = "Doors: " .. doorsCount .. " | Penyata: " .. (nowExists and "yes" or "no")
        task.wait(0.3)
    end
    notifierLoopRunning = false
end

notifBtn.MouseButton1Click:Connect(function()
    notifierEnabled = not notifierEnabled
    if notifierEnabled then
        notifBtn.Text = "Penyata-Notifier: ✓"
        notifBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        lastPenyataState = false
        notifierLoop()
    else
        notifBtn.Text = "Penyata-Notifier: ×"
        notifBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        if notifGui then pcall(function() notifGui:Destroy() end) notifGui = nil end
    end
end)

local backEnabled = false
local backLoopRunning = false

local function getBackPosition(penyPart)
    local penyCF = penyPart.CFrame
    local backDir = penyCF.LookVector * -1
    local finalPos = penyPart.Position + backDir * 3
    local look = CFrame.new(finalPos, penyPart.Position)
    return look
end

local function backLoop()
    if backLoopRunning then return end
    backLoopRunning = true

    while backEnabled and sg.Parent do
        local model = getPenyataModel()
        local part = getPenyataPart(model)

        if part then
            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                pcall(function()
                    hrp.CFrame = getBackPosition(part)
                end)
            end
            setFarmStatus("Penyata-Back: ON", Color3.fromRGB(180, 140, 255))
        else
            setFarmStatus("Penyata-Back: waiting", Color3.fromRGB(180, 180, 100))
        end

        task.wait(0.1)
    end
    backLoopRunning = false
end

backBtn.MouseButton1Click:Connect(function()
    backEnabled = not backEnabled
    if backEnabled then
        backBtn.Text = "Penyata-Back: ✓"
        backBtn.BackgroundColor3 = Color3.fromRGB(110, 70, 180)
        backLoop()
    else
        backBtn.Text = "Penyata-Back: ×"
        backBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 130)
    end
end)

task.spawn(function()
    task.wait(1)
    local doors = findAllPrompts()
    local peny = getPenyataModel()
    farmCount.Text = "Doors: " .. #doors .. " | Penyata: " .. (peny and "yes" or "no")
    setFarmStatus("Ready", Color3.fromRGB(80,210,80))
end)

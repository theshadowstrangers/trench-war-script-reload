-- ==================== TARGET-GUI (отдельное окно) ====================
local TargetScreenGui = Instance.new("ScreenGui")
local TargetMainFrame = Instance.new("Frame")
local TargetTitleLabel = Instance.new("TextLabel")
local TargetMinimizeButton = Instance.new("TextButton")
local TargetCloseButton = Instance.new("TextButton")
local TargetNameInput = Instance.new("TextBox")
local TargetToggleBtn = Instance.new("TextButton")
local OthersTargetBtn = Instance.new("TextButton")

TargetScreenGui.Name = "TargetGui"
TargetScreenGui.Parent = game:GetService("CoreGui")
TargetScreenGui.ResetOnSpawn = false

TargetMainFrame.Name = "TargetMainFrame"
TargetMainFrame.Parent = TargetScreenGui
TargetMainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
TargetMainFrame.BorderSizePixel = 0
TargetMainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
TargetMainFrame.Size = UDim2.new(0, 280, 0, 180)
TargetMainFrame.Active = true
TargetMainFrame.Draggable = true
TargetMainFrame.ClipsDescendants = true

local TargetMainCorner = Instance.new("UICorner", TargetMainFrame)
TargetMainCorner.CornerRadius = UDim.new(0, 10)

local TargetMainStroke = Instance.new("UIStroke", TargetMainFrame)
TargetMainStroke.Color = Color3.fromRGB(40, 40, 50)
TargetMainStroke.Thickness = 1.5

TargetTitleLabel.Name = "TitleLabel"
TargetTitleLabel.Parent = TargetMainFrame
TargetTitleLabel.BackgroundTransparency = 1
TargetTitleLabel.Position = UDim2.new(0, 12, 0, 0)
TargetTitleLabel.Size = UDim2.new(1, -80, 0, 35)
TargetTitleLabel.Font = Enum.Font.GothamBold
TargetTitleLabel.Text = "Target-Gui"
TargetTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetTitleLabel.TextSize = 15
TargetTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

TargetMinimizeButton.Name = "MinimizeButton"
TargetMinimizeButton.Parent = TargetMainFrame
TargetMinimizeButton.BackgroundTransparency = 1
TargetMinimizeButton.Position = UDim2.new(1, -65, 0, 0)
TargetMinimizeButton.Size = UDim2.new(0, 30, 0, 35)
TargetMinimizeButton.Font = Enum.Font.GothamBold
TargetMinimizeButton.Text = "<"
TargetMinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
TargetMinimizeButton.TextSize = 18

TargetCloseButton.Name = "CloseButton"
TargetCloseButton.Parent = TargetMainFrame
TargetCloseButton.BackgroundTransparency = 1
TargetCloseButton.Position = UDim2.new(1, -35, 0, 0)
TargetCloseButton.Size = UDim2.new(0, 30, 0, 35)
TargetCloseButton.Font = Enum.Font.GothamBold
TargetCloseButton.Text = "×"
TargetCloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
TargetCloseButton.TextSize = 20

TargetNameInput.Name = "NameInput"
TargetNameInput.Parent = TargetMainFrame
TargetNameInput.Position = UDim2.new(0, 12, 0, 45)
TargetNameInput.Size = UDim2.new(1, -24, 0, 35)
TargetNameInput.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TargetNameInput.BorderSizePixel = 0
TargetNameInput.Font = Enum.Font.Gotham
TargetNameInput.PlaceholderText = "Введи ник игрока..."
TargetNameInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
TargetNameInput.Text = ""
TargetNameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetNameInput.TextSize = 13
TargetNameInput.ClearTextOnFocus = false

local TargetInputCorner = Instance.new("UICorner", TargetNameInput)
TargetInputCorner.CornerRadius = UDim.new(0, 6)

local TargetInputStroke = Instance.new("UIStroke", TargetNameInput)
TargetInputStroke.Color = Color3.fromRGB(45, 45, 60)
TargetInputStroke.Thickness = 1

TargetToggleBtn.Name = "TargetToggleBtn"
TargetToggleBtn.Parent = TargetMainFrame
TargetToggleBtn.Position = UDim2.new(0, 12, 0, 90)
TargetToggleBtn.Size = UDim2.new(1, -24, 0, 32)
TargetToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
TargetToggleBtn.BorderSizePixel = 0
TargetToggleBtn.Font = Enum.Font.GothamBold
TargetToggleBtn.Text = "Target OFF"
TargetToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetToggleBtn.TextSize = 14

local TargetCorner = Instance.new("UICorner", TargetToggleBtn)
TargetCorner.CornerRadius = UDim.new(0, 6)

OthersTargetBtn.Name = "OthersTargetBtn"
OthersTargetBtn.Parent = TargetMainFrame
OthersTargetBtn.Position = UDim2.new(0, 12, 0, 130)
OthersTargetBtn.Size = UDim2.new(1, -24, 0, 32)
OthersTargetBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
OthersTargetBtn.BorderSizePixel = 0
OthersTargetBtn.Font = Enum.Font.GothamBold
OthersTargetBtn.Text = "others-targ OFF"
OthersTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OthersTargetBtn.TextSize = 14

local OthersTargetCorner = Instance.new("UICorner", OthersTargetBtn)
OthersTargetCorner.CornerRadius = UDim.new(0, 6)

-- Логика
local targetActive = false
local targetThread = nil
local targetPlayer = nil

local othersTargetActive = false
local othersTargetThread = nil

local function getGrenadeEvent()
    local char = game:GetService("Players").LocalPlayer.Character
    if not char then return nil end
    local gun = char:FindFirstChild("M16A2")
    if not gun then
        local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            gun = backpack:FindFirstChild("M16A2")
        end
    end
    if not gun then return nil end
    return gun:FindFirstChild("GrenadeHit")
end

local function findPlayerByName(name)
    if name == "" then return nil end
    for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= game:GetService("Players").LocalPlayer then
            if string.lower(plr.Name):sub(1, #name) == string.lower(name) or (plr.DisplayName and string.lower(plr.DisplayName):sub(1, #name) == string.lower(name)) then
                return plr
            end
        end
    end
    return nil
end

local function stopTarget()
    if targetThread then
        task.cancel(targetThread)
        targetThread = nil
    end
end

local function startTarget()
    stopTarget()
    targetActive = true
    targetThread = task.spawn(function()
        while targetActive do
            local ev = getGrenadeEvent()
            if ev and targetPlayer and targetPlayer.Character then
                local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    pcall(function()
                        ev:FireServer(hrp.Position)
                    end)
                end
            end
            task.wait(0.1)
        end
    end)
end

TargetToggleBtn.MouseButton1Click:Connect(function()
    if targetActive then
        targetActive = false
        stopTarget()
        TargetToggleBtn.Text = "Target OFF"
        TargetToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        return
    end

    local target = findPlayerByName(TargetNameInput.Text)
    if not target then
        TargetToggleBtn.Text = "Not found!"
        task.wait(1.5)
        TargetToggleBtn.Text = "Target OFF"
        return
    end

    targetPlayer = target
    TargetToggleBtn.Text = "Target ON - " .. target.Name
    TargetToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    startTarget()
end)

local function stopOthersTarget()
    if othersTargetThread then
        task.cancel(othersTargetThread)
        othersTargetThread = nil
    end
end

local function startOthersTarget()
    stopOthersTarget()
    othersTargetActive = true
    othersTargetThread = task.spawn(function()
        while othersTargetActive do
            local ev = getGrenadeEvent()
            if ev then
                for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr ~= game:GetService("Players").LocalPlayer and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            pcall(function()
                                ev:FireServer(hrp.Position)
                            end)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

OthersTargetBtn.MouseButton1Click:Connect(function()
    othersTargetActive = not othersTargetActive
    if othersTargetActive then
        OthersTargetBtn.Text = "others-targ ON"
        OthersTargetBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
        OthersTargetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        startOthersTarget()
    else
        OthersTargetBtn.Text = "others-targ OFF"
        OthersTargetBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
        OthersTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        stopOthersTarget()
    end
end)

-- Сворачивание
local targetMinimized = false
TargetMinimizeButton.MouseButton1Click:Connect(function()
    targetMinimized = not targetMinimized
    if targetMinimized then
        TargetMainFrame:TweenSize(UDim2.new(0, 280, 0, 35), "Out", "Quad", 0.2, true)
        TargetNameInput.Visible = false
        TargetToggleBtn.Visible = false
        OthersTargetBtn.Visible = false
        TargetMinimizeButton.Text = ">"
    else
        TargetMainFrame:TweenSize(UDim2.new(0, 280, 0, 180), "Out", "Quad", 0.2, true)
        TargetNameInput.Visible = true
        TargetToggleBtn.Visible = true
        OthersTargetBtn.Visible = true
        TargetMinimizeButton.Text = "<"
    end
end)

TargetCloseButton.MouseButton1Click:Connect(function()
    targetActive = false
    othersTargetActive = false
    stopTarget()
    stopOthersTarget()
    TargetScreenGui:Destroy()
end)

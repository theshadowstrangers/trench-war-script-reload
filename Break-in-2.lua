local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local PathInput = Instance.new("TextBox")
local DeleteButton = Instance.new("TextButton")
local PlayersPathButton = Instance.new("TextButton")
local PlayersMenuButton = Instance.new("TextButton")

ScreenGui.Name = "DeletedManager"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -95)
MainFrame.Size = UDim2.new(0, 280, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(40, 40, 50)
MainStroke.Thickness = 1.5

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -80, 0, 35)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Deleted Manager"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -65, 0, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 35)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "<"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 18

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 35)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 20

PathInput.Name = "PathInput"
PathInput.Parent = MainFrame
PathInput.Position = UDim2.new(0, 12, 0, 45)
PathInput.Size = UDim2.new(1, -24, 0, 35)
PathInput.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
PathInput.BorderSizePixel = 0
PathInput.Font = Enum.Font.Gotham
PathInput.PlaceholderText = "Введи путь (например workspace)"
PathInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
PathInput.Text = ""
PathInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PathInput.TextSize = 13
PathInput.ClearTextOnFocus = false

local InputCorner = Instance.new("UICorner", PathInput)
InputCorner.CornerRadius = UDim.new(0, 6)

local InputStroke = Instance.new("UIStroke", PathInput)
InputStroke.Color = Color3.fromRGB(45, 45, 60)
InputStroke.Thickness = 1

DeleteButton.Name = "DeleteButton"
DeleteButton.Parent = MainFrame
DeleteButton.Position = UDim2.new(0, 12, 0, 90)
DeleteButton.Size = UDim2.new(0.55, -16, 0, 35)
DeleteButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
DeleteButton.BorderSizePixel = 0
DeleteButton.Font = Enum.Font.GothamBold
DeleteButton.Text = "Delete"
DeleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeleteButton.TextSize = 14

local DeleteCorner = Instance.new("UICorner", DeleteButton)
DeleteCorner.CornerRadius = UDim.new(0, 6)

PlayersPathButton.Name = "PlayersPathButton"
PlayersPathButton.Parent = MainFrame
PlayersPathButton.Position = UDim2.new(0.55, 4, 0, 90)
PlayersPathButton.Size = UDim2.new(0.45, -16, 0, 35)
PlayersPathButton.BackgroundColor3 = Color3.fromRGB(50, 80, 180)
PlayersPathButton.BorderSizePixel = 0
PlayersPathButton.Font = Enum.Font.GothamBold
PlayersPathButton.Text = "Players-path"
PlayersPathButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayersPathButton.TextSize = 13

local PlayersCorner = Instance.new("UICorner", PlayersPathButton)
PlayersCorner.CornerRadius = UDim.new(0, 6)


PlayersMenuButton.Name = "PlayersMenuButton"
PlayersMenuButton.Parent = MainFrame
PlayersMenuButton.Position = UDim2.new(0, 12, 0, 135)
PlayersMenuButton.Size = UDim2.new(1, -24, 0, 35)
PlayersMenuButton.BackgroundColor3 = Color3.fromRGB(110, 40, 180)
PlayersMenuButton.BorderSizePixel = 0
PlayersMenuButton.Font = Enum.Font.GothamBold
PlayersMenuButton.Text = "Players"
PlayersMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayersMenuButton.TextSize = 14

local PlayersMenuCorner = Instance.new("UICorner", PlayersMenuButton)
PlayersMenuCorner.CornerRadius = UDim.new(0, 6)

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 280, 0, 35), "Out", "Quad", 0.2, true)
        PathInput.Visible = false
        DeleteButton.Visible = false
        PlayersPathButton.Visible = false
        PlayersMenuButton.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 280, 0, 190), "Out", "Quad", 0.2, true)
        PathInput.Visible = true
        DeleteButton.Visible = true
        PlayersPathButton.Visible = true
        PlayersMenuButton.Visible = true
        MinimizeButton.Text = "<"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

DeleteButton.MouseButton1Click:Connect(function()
    local pathText = PathInput.Text
    if pathText == "" then return end

    local getObject = loadstring("return " .. pathText)
    if getObject then
        local target = getObject()
        local Event = game:GetService("ReplicatedStorage").Events.OnDoorHit
        Event:FireServer(target)
    end
end)

PlayersPathButton.MouseButton1Click:Connect(function()
    local selectGui = Instance.new("ScreenGui")
    selectGui.Name = "PlayersPathSelector"
    selectGui.Parent = game:GetService("CoreGui")
    selectGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 240, 0, 320)
    frame.Position = UDim2.new(0.5, -120, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    frame.BorderSizePixel = 0
    frame.Parent = selectGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(40, 40, 50)
    stroke.Thickness = 1.5

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 32)
    header.BackgroundTransparency = 1
    header.Parent = frame

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -40, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = "Select Player"
    headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 14
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    local closeSelect = Instance.new("TextButton")
    closeSelect.Size = UDim2.new(0, 30, 1, 0)
    closeSelect.Position = UDim2.new(1, -30, 0, 0)
    closeSelect.Text = "×"
    closeSelect.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeSelect.BackgroundTransparency = 1
    closeSelect.Font = Enum.Font.GothamBold
    closeSelect.TextSize = 18
    closeSelect.Parent = header
    closeSelect.MouseButton1Click:Connect(function()
        selectGui:Destroy()
    end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -16, 1, -50)
    scroll.Position = UDim2.new(0, 8, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 30)
        b.Text = plr.Name
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        b.Font = Enum.Font.Gotham
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.BorderSizePixel = 0
        b.Parent = scroll
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

        b.MouseButton1Click:Connect(function()
            PathInput.Text = "game.Players." .. plr.Name
            selectGui:Destroy()
        end)
    end
end)


PlayersMenuButton.MouseButton1Click:Connect(function()
    local selectGui = Instance.new("ScreenGui")
    selectGui.Name = "PlayersStructureSelector"
    selectGui.Parent = game:GetService("CoreGui")
    selectGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 360)
    frame.Position = UDim2.new(0.5, -130, 0.5, -180)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    frame.BorderSizePixel = 0
    frame.Parent = selectGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(40, 40, 50)
    stroke.Thickness = 1.5

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 32)
    header.BackgroundTransparency = 1
    header.Parent = frame

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, -40, 1, 0)
    headerLabel.Position = UDim2.new(0, 10, 0, 0)
    headerLabel.Text = "Players Paths"
    headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 14
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.Parent = header

    local closeSelect = Instance.new("TextButton")
    closeSelect.Size = UDim2.new(0, 30, 1, 0)
    closeSelect.Position = UDim2.new(1, -30, 0, 0)
    closeSelect.Text = "×"
    closeSelect.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeSelect.BackgroundTransparency = 1
    closeSelect.Font = Enum.Font.GothamBold
    closeSelect.TextSize = 18
    closeSelect.Parent = header
    closeSelect.MouseButton1Click:Connect(function()
        selectGui:Destroy()
    end)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -16, 1, -50)
    scroll.Position = UDim2.new(0, 8, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        local paths = {
            ["Player (" .. plr.Name .. ")"] = "game.Players." .. plr.Name,
            ["Character"] = "workspace:FindFirstChild('" .. plr.Name .. "')",
            ["Backpack"] = "game.Players." .. plr.Name .. ".Backpack",
            ["PlayerGui"] = "game.Players." .. plr.Name .. ".PlayerGui",
            ["StarterGear"] = "game.Players." .. plr.Name .. ".StarterGear",
            ["PlayerScripts"] = "game.Players." .. plr.Name .. ".PlayerScripts"
        }

        for title, pathStr in pairs(paths) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 30)
            b.Text = " " .. title
            b.TextColor3 = Color3.fromRGB(220, 220, 255)
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.BorderSizePixel = 0
            b.Parent = scroll
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

            b.MouseButton1Click:Connect(function()
                PathInput.Text = pathStr
                selectGui:Destroy()
            end)
        end
    end
end)

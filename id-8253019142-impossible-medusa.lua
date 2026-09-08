-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local EspButton = Instance.new("TextButton")
local TouchButton = Instance.new("TextButton")
local GrabCoinsButton = Instance.new("TextButton")

ScreenGui.Name = "LmaoGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -100)
MainFrame.Size = UDim2.new(0, 240, 0, 200)
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
TitleLabel.Text = " Lmao Gui"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

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

EspButton.Name = "EspButton"
EspButton.Parent = MainFrame
EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
EspButton.BorderSizePixel = 0
EspButton.Position = UDim2.new(0.5, -80, 0, 45)
EspButton.Size = UDim2.new(0, 160, 0, 40)
EspButton.Font = Enum.Font.SourceSansBold
EspButton.Text = "Esp-part OFF"
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.TextSize = 16
Instance.new("UICorner", EspButton).CornerRadius = UDim.new(0, 6)

TouchButton.Name = "TouchButton"
TouchButton.Parent = MainFrame
TouchButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
TouchButton.BorderSizePixel = 0
TouchButton.Position = UDim2.new(0.5, -80, 0, 100)
TouchButton.Size = UDim2.new(0, 160, 0, 40)
TouchButton.Font = Enum.Font.SourceSansBold
TouchButton.Text = "Touch-roto one"
TouchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TouchButton.TextSize = 16
Instance.new("UICorner", TouchButton).CornerRadius = UDim.new(0, 6)

GrabCoinsButton.Name = "GrabCoinsButton"
GrabCoinsButton.Parent = MainFrame
GrabCoinsButton.BackgroundColor3 = Color3.fromRGB(90, 70, 50)
GrabCoinsButton.BorderSizePixel = 0
GrabCoinsButton.Position = UDim2.new(0.5, -80, 0, 155)
GrabCoinsButton.Size = UDim2.new(0, 160, 0, 40)
GrabCoinsButton.Font = Enum.Font.SourceSansBold
GrabCoinsButton.Text = "Grab-Coins"
GrabCoinsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GrabCoinsButton.TextSize = 16
Instance.new("UICorner", GrabCoinsButton).CornerRadius = UDim.new(0, 6)

local isMinimized = false
local isEspActive = false
local createdBoxes = {}

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 30), "Out", "Quad", 0.2, true)
        EspButton.Visible = false
        TouchButton.Visible = false
        GrabCoinsButton.Visible = false
        MinimizeButton.Text = ">"
    else
        MainFrame:TweenSize(UDim2.new(0, 240, 0, 200), "Out", "Quad", 0.2, true)
        EspButton.Visible = true
        TouchButton.Visible = true
        GrabCoinsButton.Visible = true
        MinimizeButton.Text = "<"
    end
end)

local function clearHighlights()
    for _, box in pairs(createdBoxes) do
        if box then box:Destroy() end
    end
    createdBoxes = {}
end

CloseButton.MouseButton1Click:Connect(function()
    isEspActive = false
    clearHighlights()
    ScreenGui:Destroy()
    collectgarbage()
end)

local function applyBoxEsp(part, color)
    if not part:IsA("BasePart") then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Size = part.Size
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Color3 = color
    box.Transparency = 0.4
    box.Adornee = part
    box.Parent = game:GetService("CoreGui")
    table.insert(createdBoxes, box)
end

local function updateEsp()
    clearHighlights()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Vidrio roto" then
            applyBoxEsp(obj, Color3.fromRGB(255, 0, 0))
        elseif obj.Name == "Vidrio templado" then
            applyBoxEsp(obj, Color3.fromRGB(0, 255, 0))
        end
    end
end

EspButton.MouseButton1Click:Connect(function()
    isEspActive = not isEspActive
    if isEspActive then
        EspButton.Text = "Esp-part ON"
        EspButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        EspButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        updateEsp()
    else
        EspButton.Text = "Esp-part OFF"
        EspButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        clearHighlights()
    end
end)

TouchButton.MouseButton1Click:Connect(function()
    if not firetouchinterest then
        TouchButton.Text = "No executor support!"
        task.wait(1.5)
        TouchButton.Text = "Touch-roto one"
        return
    end
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        TouchButton.Text = "No Character Found!"
        task.wait(1.5)
        TouchButton.Text = "Touch-roto one"
        return
    end
    TouchButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    TouchButton.Text = "Touching..."
    local count = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Vidrio roto" and obj:IsA("BasePart") then
            if obj:FindFirstChildOfClass("TouchTransmitter") then
                firetouchinterest(rootPart, obj, 0)
                task.wait()
                firetouchinterest(rootPart, obj, 1)
                count = count + 1
            end
        end
    end
    TouchButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    TouchButton.Text = "Done! ("..count..")"
    task.wait(2)
    TouchButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    TouchButton.Text = "Touch-roto one"
end)

GrabCoinsButton.MouseButton1Click:Connect(function()
    if not firetouchinterest then
        GrabCoinsButton.Text = "No executor support!"
        task.wait(1.5)
        GrabCoinsButton.Text = "Grab-Coins"
        return
    end
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        GrabCoinsButton.Text = "No Character Found!"
        task.wait(1.5)
        GrabCoinsButton.Text = "Grab-Coins"
        return
    end
    GrabCoinsButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    GrabCoinsButton.Text = "Grabbing..."
    local count = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Moneda" and obj:IsA("BasePart") then
            if obj:FindFirstChildOfClass("TouchTransmitter") then
                firetouchinterest(rootPart, obj, 0)
                task.wait()
                firetouchinterest(rootPart, obj, 1)
                count = count + 1
            end
        end
    end
    GrabCoinsButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    GrabCoinsButton.Text = "Grab! ("..count..")"
    task.wait(2)
    GrabCoinsButton.BackgroundColor3 = Color3.fromRGB(90, 70, 50)
    GrabCoinsButton.Text = "Grab-Coins"
end)

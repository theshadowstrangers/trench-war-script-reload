-- By modifying original script

local P = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local p = P.LocalPlayer

-- === GUI ===
local sg = Instance.new("ScreenGui")
sg.Name = "NoCooldownDash"
sg.ResetOnSpawn = false
pcall(function() sg.Parent = game:GetService("CoreGui") end)
if not sg.Parent then sg.Parent = p:WaitForChild("PlayerGui") end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = sg
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 30)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.Text = "no-cooldown Dash"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -55, 0, 2)
minBtn.Text = "<"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.Parent = mainFrame

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 2)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = mainFrame

-- Dash Button
local dashBtn = Instance.new("TextButton")
dashBtn.Name = "DashButton"
dashBtn.Size = UDim2.new(0, 120, 0, 35)
dashBtn.Position = UDim2.new(0.5, -60, 0, 50)
dashBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
dashBtn.TextColor3 = Color3.new(1, 1, 1)
dashBtn.Font = Enum.Font.GothamBold
dashBtn.TextScaled = true
dashBtn.Text = "Dash OFF"
dashBtn.Parent = mainFrame
Instance.new("UICorner", dashBtn).CornerRadius = UDim.new(0.2, 0)

-- State
local cOn = false
local isD = false

-- Minimize logic
local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame:TweenSize(UDim2.new(0, 200, 0, 30), "Out", "Quad", 0.2, true)
        dashBtn.Visible = false
        minBtn.Text = ">"
    else
        mainFrame:TweenSize(UDim2.new(0, 200, 0, 100), "Out", "Quad", 0.2, true)
        dashBtn.Visible = true
        minBtn.Text = "<"
    end
end)

-- Close logic
closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- Dash toggle
dashBtn.MouseButton1Click:Connect(function()
    cOn = not cOn
    dashBtn.Text = cOn and "Dash ON" or "Dash OFF"
    dashBtn.BackgroundColor3 = cOn and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
    if cOn then
        -- Optional: play a sound or feedback
    end
end)

-- === Original dash functions ===

local function pAnim(id)
    local c = p.Character
    local h = c and c:FindFirstChild("Humanoid")
    if h then
        local a = Instance.new("Animation")
        a.AnimationId = "rbxassetid://" .. id
        local tr = h:LoadAnimation(a)
        tr.Priority = Enum.AnimationPriority.Action4
        tr:Play()
        return tr
    end
end

local function linDash(r, bv, dirF, dist, t)
    local st = os.clock()
    local spd = (2 * dist) / t
    while true do
        if not r or not r.Parent or not bv or not bv.Parent then break end
        local el = os.clock() - st
        if el >= t then break end
        bv.Velocity = dirF() * (spd * (1 - (el / t)))
        RS.Heartbeat:Wait()
    end
    bv.Velocity = Vector3.zero
end

local function dDash()
    if isD then return end
    local c = p.Character
    local r = c and c:FindFirstChild("HumanoidRootPart")
    local h = c and c:FindFirstChild("Humanoid")
    if not r or not h or h.Health <= 0 then return end

    local rDir = r.CFrame:VectorToObjectSpace(h.MoveDirection)
    local dTyp
    if rDir.Z > 0.5 then dTyp = "B"
    elseif rDir.X < -0.5 then dTyp = "L"
    elseif rDir.X > 0.5 then dTyp = "R"
    else return end

    isD = true
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 0, 1e5)
    bv.Velocity = Vector3.zero
    bv.Parent = r

    if dTyp == "L" then
        pAnim("10480796021")
        linDash(r, bv, function() return -r.CFrame.RightVector end, 30, 0.3)
        task.wait(0.1)
    elseif dTyp == "R" then
        pAnim("10480793962")
        linDash(r, bv, function() return r.CFrame.RightVector end, 30, 0.3)
        task.wait(0.1)
    elseif dTyp == "B" then
        pAnim("10491993682")
        local spd = 20 / 0.35
        local up = RS.Heartbeat:Connect(function() bv.Velocity = -r.CFrame.LookVector * spd end)
        task.wait(0.35)
        if up then up:Disconnect() end
        bv.Velocity = Vector3.zero
        task.wait(0.1)
        up = RS.Heartbeat:Connect(function() bv.Velocity = -r.CFrame.LookVector * spd end)
        task.wait(0.35)
        if up then up:Disconnect() end
    end

    if bv then bv:Destroy() end
    isD = false
end

-- === Input handling (key Q) ===
UIS.InputBegan:Connect(function(i, gp)
    if i.KeyCode == Enum.KeyCode.Q then
        if cOn then dDash() end
        return
    end
    -- Touch support for mobile dash button (if we want to keep)
    if (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and cOn then
        local pg = p:FindFirstChild("PlayerGui")
        if not pg then return end
        for _, gui in pairs(pg:GetDescendants()) do
            if gui.Name == "DashButton" and gui:IsA("GuiObject") and gui.Visible and gui.AbsoluteSize.X > 0 then
                local pos, bPos, bSz = i.Position, gui.AbsolutePosition, gui.AbsoluteSize
                if pos.X >= bPos.X and pos.X <= (bPos.X + bSz.X) and pos.Y >= bPos.Y and pos.Y <= (bPos.Y + bSz.Y) then
                    dDash()
                    break
                end
            end
        end
    end
end)

--!strict

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
	Colors = {
		Background = Color3.fromRGB(18, 18, 24),
		Sidebar = Color3.fromRGB(24, 24, 32),
		Header = Color3.fromRGB(30, 30, 40),
		Panel = Color3.fromRGB(28, 28, 36),
		Accent = Color3.fromRGB(88, 101, 242),
		Slap = Color3.fromRGB(88, 101, 242),
		Kill = Color3.fromRGB(237, 66, 69),
		Get = Color3.fromRGB(59, 165, 93),
		Teleport = Color3.fromRGB(250, 166, 26),
		AutoOff = Color3.fromRGB(237, 66, 69),
		AutoOn = Color3.fromRGB(59, 165, 93),
		Text = Color3.fromRGB(255, 255, 255),
		Subtext = Color3.fromRGB(160, 160, 175),
	},
	AnimSpeed = 0.2,
}

local isAutoSlapping = false
local autoSlapConnection: RBXScriptConnection? = nil

local function tween(instance: Instance, props: { [string]: any }, duration: number?): Tween
	local t = TweenService:Create(instance,
		TweenInfo.new(duration or CONFIG.AnimSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function slap(target, pos)
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("MiniSlap") then
		char.MiniSlap.Event:FireServer("slash", target.Character, pos)
	end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpyNote_Improved"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 340)
Main.Position = UDim2.new(0.5, -240, 0.5, -170)
Main.BackgroundColor3 = CONFIG.Colors.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = Main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(50, 50, 65)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.5
mainStroke.Parent = Main

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 8)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.4
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.ZIndex = -1
shadow.Parent = Main

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = CONFIG.Colors.Header
Header.BorderSizePixel = 0
Header.Parent = Main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = Header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 16)
headerFix.Position = UDim2.new(0, 0, 1, -16)
headerFix.BackgroundColor3 = CONFIG.Colors.Header
headerFix.BorderSizePixel = 0
headerFix.Parent = Header

local TitleIcon = Instance.new("TextLabel")
TitleIcon.Size = UDim2.new(0, 24, 0, 24)
TitleIcon.Position = UDim2.new(0, 18, 0.5, 0)
TitleIcon.AnchorPoint = Vector2.new(0, 0.5)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "❔"
TitleIcon.TextSize = 18
TitleIcon.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 48, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SpyNote-Improved"
Title.TextColor3 = CONFIG.Colors.Text
Title.TextSize = 17
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 32, 0, 32)
Minimize.Position = UDim2.new(1, -42, 0.5, 0)
Minimize.AnchorPoint = Vector2.new(0, 0.5)
Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Minimize.BackgroundTransparency = 0.9
Minimize.Text = ""
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 10)
minCorner.Parent = Minimize

local MinimizeIcon = Instance.new("TextLabel")
MinimizeIcon.Size = UDim2.new(1, 0, 1, 0)
MinimizeIcon.BackgroundTransparency = 1
MinimizeIcon.Text = "−"
MinimizeIcon.TextColor3 = CONFIG.Colors.Text
MinimizeIcon.TextSize = 20
MinimizeIcon.Font = Enum.Font.GothamBold
MinimizeIcon.Parent = Minimize

Minimize.MouseEnter:Connect(function()
	tween(Minimize, { BackgroundTransparency = 0.7 }, 0.15)
end)
Minimize.MouseLeave:Connect(function()
	tween(Minimize, { BackgroundTransparency = 0.9 }, 0.15)
end)

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 120, 1, -48)
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.BackgroundColor3 = CONFIG.Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local sidebarList = Instance.new("UIListLayout")
sidebarList.Padding = UDim.new(0, 6)
sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
sidebarList.Parent = Sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 8)
sidebarPadding.PaddingRight = UDim.new(0, 8)
sidebarPadding.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -120, 1, -48)
ContentArea.Position = UDim2.new(0, 120, 0, 48)
ContentArea.BackgroundColor3 = CONFIG.Colors.Background
ContentArea.BorderSizePixel = 0
ContentArea.Parent = Main

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 14)
contentPadding.PaddingLeft = UDim.new(0, 14)
contentPadding.PaddingRight = UDim.new(0, 14)
contentPadding.PaddingBottom = UDim.new(0, 14)
contentPadding.Parent = ContentArea

local function createPage(name: string): Frame
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = ContentArea

	local list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0, 8)
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Parent = page

	return page
end

local InfoPage = createPage("InfoPage")
local ExploitPage = createPage("ExploitPage")
local TeleportPage = createPage("TeleportPage")

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "Information"
InfoTitle.TextColor3 = CONFIG.Colors.Text
InfoTitle.TextSize = 20
InfoTitle.Font = Enum.Font.GothamBlack
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
InfoTitle.Parent = InfoPage

local InfoLine1 = Instance.new("TextLabel")
InfoLine1.Size = UDim2.new(1, 0, 0, 24)
InfoLine1.BackgroundTransparency = 1
InfoLine1.Text = "That's improved Version Void Hub Ui"
InfoLine1.TextColor3 = CONFIG.Colors.Subtext
InfoLine1.TextSize = 14
InfoLine1.Font = Enum.Font.GothamMedium
InfoLine1.TextXAlignment = Enum.TextXAlignment.Left
InfoLine1.Parent = InfoPage

local InfoLine2 = Instance.new("TextLabel")
InfoLine2.Size = UDim2.new(1, 0, 0, 24)
InfoLine2.BackgroundTransparency = 1
InfoLine2.Text = "By Spynote"
InfoLine2.TextColor3 = CONFIG.Colors.Accent
InfoLine2.TextSize = 14
InfoLine2.Font = Enum.Font.GothamBold
InfoLine2.TextXAlignment = Enum.TextXAlignment.Left
InfoLine2.Parent = InfoPage

local function createButton(parent: Instance, text: string, color: Color3, height: number?, callback: () -> ()): TextButton
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, height or 44)
	btn.BackgroundColor3 = color
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.Parent = parent

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = btn

	local btnText = Instance.new("TextLabel")
	btnText.Size = UDim2.new(1, 0, 1, 0)
	btnText.BackgroundTransparency = 1
	btnText.Text = text
	btnText.TextColor3 = CONFIG.Colors.Text
	btnText.TextSize = 14
	btnText.Font = Enum.Font.GothamBold
	btnText.Parent = btn

	btn.MouseEnter:Connect(function()
		tween(btn, { BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.15) }, 0.15)
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, { BackgroundColor3 = color }, 0.15)
	end)
	btn.MouseButton1Click:Connect(callback)

	return btn
end

local exploitTitle = Instance.new("TextLabel")
exploitTitle.Size = UDim2.new(1, 0, 0, 30)
exploitTitle.BackgroundTransparency = 1
exploitTitle.Text = "Exploit"
exploitTitle.TextColor3 = CONFIG.Colors.Text
exploitTitle.TextSize = 20
exploitTitle.Font = Enum.Font.GothamBlack
exploitTitle.TextXAlignment = Enum.TextXAlignment.Left
exploitTitle.Parent = ExploitPage

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, 0, 0, 48)
toggleBtn.BackgroundColor3 = CONFIG.Colors.AutoOff
toggleBtn.Text = ""
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = ExploitPage

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleBtn

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = CONFIG.Colors.AutoOff
toggleStroke.Thickness = 1.5
toggleStroke.Transparency = 0.4
toggleStroke.Parent = toggleBtn

local toggleText = Instance.new("TextLabel")
toggleText.Size = UDim2.new(1, -80, 1, 0)
toggleText.Position = UDim2.new(0, 16, 0, 0)
toggleText.BackgroundTransparency = 1
toggleText.Text = "Auto Slap"
toggleText.TextColor3 = CONFIG.Colors.Text
toggleText.TextSize = 14
toggleText.Font = Enum.Font.GothamBold
toggleText.TextXAlignment = Enum.TextXAlignment.Left
toggleText.Parent = toggleBtn

local toggleState = Instance.new("TextLabel")
toggleState.Size = UDim2.new(0, 60, 0, 20)
toggleState.Position = UDim2.new(1, -70, 0.5, 0)
toggleState.AnchorPoint = Vector2.new(0, 0.5)
toggleState.BackgroundTransparency = 1
toggleState.Text = "OFF"
toggleState.TextColor3 = Color3.fromRGB(255, 150, 150)
toggleState.TextSize = 12
toggleState.Font = Enum.Font.GothamBold
toggleState.Parent = toggleBtn

local function updateToggleVisuals(enabled: boolean)
	local targetColor = enabled and CONFIG.Colors.AutoOn or CONFIG.Colors.AutoOff
	tween(toggleBtn, { BackgroundColor3 = targetColor }, 0.25)
	tween(toggleStroke, { Color = targetColor }, 0.25)
	toggleState.Text = enabled and "ON" or "OFF"
	toggleState.TextColor3 = enabled and Color3.fromRGB(150, 255, 150) or Color3.fromRGB(255, 150, 150)
end

local function startAutoSlaps()
	if autoSlapConnection then return end
	autoSlapConnection = RunService.Heartbeat:Connect(function()
		if not isAutoSlapping then return end
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				slap(p, Vector3.new(5.795, 0, 1.553))
			end
		end
	end)
end

local function stopAutoSlaps()
	if autoSlapConnection then
		autoSlapConnection:Disconnect()
		autoSlapConnection = nil
	end
end

toggleBtn.MouseButton1Click:Connect(function()
	isAutoSlapping = not isAutoSlapping
	updateToggleVisuals(isAutoSlapping)
	if isAutoSlapping then startAutoSlaps() else stopAutoSlaps() end
end)

createButton(ExploitPage, "Slap All", CONFIG.Colors.Slap, nil, function()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			slap(p, Vector3.new(5.795, 0, 1.553))
		end
	end
end)

createButton(ExploitPage, "Kill All", CONFIG.Colors.Kill, nil, function()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			slap(p, Vector3.new(999999, 999999, 999999))
		end
	end
end)

createButton(ExploitPage, "Get Slap", CONFIG.Colors.Get, nil, function()
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local oldCF = hrp.CFrame
		hrp.CFrame = CFrame.new(35.5245972, 430.265778, 110.490166, -0.99256891, -0.00960774068, -0.121303864, -1.0003518e-09, 0.996878028, -0.0789566338, 0.121683754, -0.0783699006, -0.989470184)
		task.wait(2)
		hrp.CFrame = oldCF
	end
end)

local tpTitle = Instance.new("TextLabel")
tpTitle.Size = UDim2.new(1, 0, 0, 30)
tpTitle.BackgroundTransparency = 1
tpTitle.Text = "Teleport"
tpTitle.TextColor3 = CONFIG.Colors.Text
tpTitle.TextSize = 20
tpTitle.Font = Enum.Font.GothamBlack
tpTitle.TextXAlignment = Enum.TextXAlignment.Left
tpTitle.Parent = TeleportPage

createButton(TeleportPage, "Tp to End", CONFIG.Colors.Teleport, nil, function()
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(47.5518875, 430.140961, 97.6296234, -0.981359243, 0.0532703884, -0.184651896, -2.21735208e-09, 0.960816085, 0.277186692, 0.192182347, 0.272019714, -0.942905724)
	end
end)

local tabs = {
	{ Name = "Info", Page = InfoPage },
	{ Name = "Exploit", Page = ExploitPage },
	{ Name = "Teleport", Page = TeleportPage },
}

local tabButtons: { TextButton } = {}
local activeTab = "Info"

local function switchTab(name: string)
	activeTab = name
	for _, t in ipairs(tabs) do
		t.Page.Visible = (t.Name == name)
	end
	for _, b in ipairs(tabButtons) do
		local isActive = b:GetAttribute("TabName") == name
		tween(b, { BackgroundColor3 = isActive and CONFIG.Colors.Accent or CONFIG.Colors.Panel }, 0.2)
		local lbl = b:FindFirstChild("Label")
		if lbl then
			lbl.TextColor3 = isActive and CONFIG.Colors.Text or CONFIG.Colors.Subtext
		end
	end
end

for _, tab in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = CONFIG.Colors.Panel
	btn.Text = ""
	btn.AutoButtonColor = false
	btn:SetAttribute("TabName", tab.Name)
	btn.Parent = Sidebar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	local lbl = Instance.new("TextLabel")
	lbl.Name = "Label"
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = tab.Name
	lbl.TextColor3 = CONFIG.Colors.Subtext
	lbl.TextSize = 13
	lbl.Font = Enum.Font.GothamBold
	lbl.Parent = btn

	btn.MouseEnter:Connect(function()
		if activeTab ~= tab.Name then
			tween(btn, { BackgroundColor3 = Color3.fromRGB(40, 40, 52) }, 0.15)
		end
	end)
	btn.MouseLeave:Connect(function()
		if activeTab ~= tab.Name then
			tween(btn, { BackgroundColor3 = CONFIG.Colors.Panel }, 0.15)
		end
	end)
	btn.MouseButton1Click:Connect(function()
		switchTab(tab.Name)
	end)

	table.insert(tabButtons, btn)
end

switchTab("Info")

local open = true
Minimize.MouseButton1Click:Connect(function()
	open = not open
	if open then
		Sidebar.Visible = true
		ContentArea.Visible = true
		tween(Main, { Size = UDim2.new(0, 480, 0, 340) }, 0.25)
		MinimizeIcon.Text = "−"
	else
		tween(Main, { Size = UDim2.new(0, 480, 0, 48) }, 0.25)
		task.wait(0.12)
		Sidebar.Visible = false
		ContentArea.Visible = false
		MinimizeIcon.Text = "+"
	end
end)

local dragging = false
local dragStart: Vector3?
local startPos: UDim2?

Header.InputBegan:Connect(function(input: InputObject)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or
	   input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input: InputObject)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
	   input.UserInputType == Enum.UserInputType.Touch) then
		if dragStart and startPos then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end
end)

Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, { Size = UDim2.new(0, 480, 0, 340) }, 0.4)

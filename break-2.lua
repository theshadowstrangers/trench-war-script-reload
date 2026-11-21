local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

if Player.PlayerGui:FindFirstChild("VoidHubGui") then
	Player.PlayerGui.VoidHubGui:Destroy()
end

local function Notify(msg)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "VOID HUB",
			Text = tostring(msg),
			Duration = 3
		})
	end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoidHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local FULL_SIZE = UDim2.new(0, 316, 0, 336)
local MIN_SIZE = UDim2.new(0, 148, 0, 30)

local MainFrame = Instance.new("Frame")
MainFrame.Size = FULL_SIZE
MainFrame.Position = UDim2.new(0.5, -158, 0.5, -168)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(55, 55, 65)
MainStroke.Thickness = 1

local StarsContainer = Instance.new("Frame")
StarsContainer.Size = UDim2.new(1, 0, 1, 0)
StarsContainer.BackgroundTransparency = 1
StarsContainer.Parent = MainFrame

local stars = {}
for i = 1, 80 do
	local star = Instance.new("Frame")
	star.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
	star.Position = UDim2.new(math.random(), 0, math.random(), 0)
	star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	star.BackgroundTransparency = 0.45
	star.BorderSizePixel = 0
	star.Visible = false
	star.Parent = StarsContainer
	table.insert(stars, star)
end

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "VOID HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.Size = UDim2.new(1, -56, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(240, 240, 248)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "X"
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.TextSize = 11
ExitBtn.Size = UDim2.new(0, 26, 1, 0)
ExitBtn.Position = UDim2.new(1, -26, 0, 0)
ExitBtn.TextColor3 = Color3.fromRGB(255, 95, 95)
ExitBtn.BackgroundTransparency = 1
ExitBtn.Parent = Header
ExitBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 13
MinimizeBtn.Size = UDim2.new(0, 26, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -52, 0, 0)
MinimizeBtn.TextColor3 = Color3.fromRGB(205, 205, 215)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = Header

local Side = Instance.new("Frame")
Side.Size = UDim2.new(0, 82, 1, -30)
Side.Position = UDim2.new(0, 0, 0, 30)
Side.BackgroundColor3 = Color3.fromRGB(27, 27, 32)
Side.BorderSizePixel = 0
Side.Parent = MainFrame

local sideLayout = Instance.new("UIListLayout", Side)
sideLayout.Padding = UDim.new(0, 4)

local sidePad = Instance.new("UIPadding", Side)
sidePad.PaddingTop = UDim.new(0, 6)
sidePad.PaddingLeft = UDim.new(0, 5)
sidePad.PaddingRight = UDim.new(0, 5)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -90, 1, -38)
Container.Position = UDim2.new(0, 86, 0, 34)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local isMinimized = false
local activeTabName = "Home"

local allTabs = {}
local allTabButtons = {}

local function setTab(name)
	activeTabName = name
	for tabName, frame in pairs(allTabs) do
		frame.Visible = (not isMinimized) and (tabName == name)
	end
	for tabName, btn in pairs(allTabButtons) do
		if tabName == name then
			btn.BackgroundColor3 = Color3.fromRGB(68, 112, 215)
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
			btn.TextColor3 = Color3.fromRGB(185, 185, 198)
		end
	end
end

local function setMinimized(state)
	isMinimized = state
	if isMinimized then
		Side.Visible = false
		Container.Visible = false
		Title.Text = "VOID"
		MinimizeBtn.Text = "+"
		MainFrame:TweenSize(MIN_SIZE, "Out", "Quad", 0.16, true)
	else
		Title.Text = "VOID HUB"
		MinimizeBtn.Text = "-"
		MainFrame:TweenSize(FULL_SIZE, "Out", "Quad", 0.16, true)
		task.delay(0.09, function()
			if not isMinimized then
				Side.Visible = true
				Container.Visible = true
				setTab(activeTabName)
			end
		end)
	end
end

MinimizeBtn.MouseButton1Click:Connect(function()
	setMinimized(not isMinimized)
end)

Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then
		local now = tick()
		if now - (Title:GetAttribute("LastClick") or 0) <= 0.3 then
			setMinimized(not isMinimized)
		end
		Title:SetAttribute("LastClick", now)
	end
end)

local function CreateTab(name)
	local f = Instance.new("ScrollingFrame")
	f.Size = UDim2.new(1, 0, 1, 0)
	f.BackgroundTransparency = 1
	f.ScrollBarThickness = 2
	f.Visible = false
	f.CanvasSize = UDim2.new(0, 0, 0, 0)
	f.AutomaticCanvasSize = Enum.AutomaticSize.Y
	f.Parent = Container

	local layout = Instance.new("UIListLayout", f)
	layout.Padding = UDim.new(0, 4)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 26)
	b.Text = name
	b.Font = Enum.Font.GothamSemibold
	b.TextSize = 11
	b.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
	b.TextColor3 = Color3.fromRGB(185, 185, 198)
	b.BorderSizePixel = 0
	b.Parent = Side
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)

	b.MouseButton1Click:Connect(function()
		setTab(name)
	end)

	allTabs[name] = f
	allTabButtons[name] = b
	return f
end

local function CreateButton(parent, text, color, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -4, 0, 30)
	b.Text = text
	b.TextSize = 11
	b.BackgroundColor3 = color
	b.Font = Enum.Font.GothamSemibold
	b.TextColor3 = Color3.new(1, 1, 1)
	b.BorderSizePixel = 0
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	b.MouseButton1Click:Connect(callback)
	return b
end

local tHome = CreateTab("Home")
local itxt = Instance.new("TextLabel", tHome)
itxt.Size = UDim2.new(1, -4, 0, 64)
itxt.Text = "VOID HUB v2\nAuthor-Scriptblox: spynote\nDiscord: @yfrosta\nRoblox: sedfortip"
itxt.TextColor3 = Color3.new(1, 1, 1)
itxt.TextSize = 11
itxt.BackgroundTransparency = 1
itxt.Font = Enum.Font.Gotham

local tRoles = CreateTab("Roles")

CreateButton(tRoles, "Role: Police", Color3.fromRGB(50, 80, 180), function()
	RS.RemoteEvents.OutsideRole:FireServer("Gun", true)
end)

CreateButton(tRoles, "Role: SWAT", Color3.fromRGB(42, 42, 48), function()
	RS.RemoteEvents.OutsideRole:FireServer("SwatGun", true)
end)

CreateButton(tRoles, "Role: Fighter", Color3.fromRGB(115, 88, 18), function()
	RS.RemoteEvents.OutsideRole:FireServer("Sword", true)
end)

CreateButton(tRoles, "Role: Hungry", Color3.fromRGB(150, 80, 90), function()
	RS.RemoteEvents.OutsideRole:FireServer("Chips", true)
end)

CreateButton(tRoles, "Role: Medic", Color3.fromRGB(190, 80, 95), function()
	RS.RemoteEvents.OutsideRole:FireServer("MedKit", true)
end)

CreateButton(tRoles, "Role: Bat User", Color3.fromRGB(99, 100, 70), function()
	RS.RemoteEvents.OutsideRole:FireServer("Bat", true)
end)

CreateButton(tRoles, "Role: Lollipop [OLD..]", Color3.fromRGB(52, 52, 62), function()
	RS.RemoteEvents.OutsideRole:FireServer("Lollipop", true)
end)

CreateButton(tRoles, "Role: Guest [OLD..]", Color3.fromRGB(100, 90, 110), function()
	RS.RemoteEvents.OutsideRole:FireServer("LinkedSword", true)
end)

CreateButton(tRoles, "Role: Stealthy", Color3.fromRGB(80, 175, 45), function()
	RS.RemoteEvents.OutsideRole:FireServer("TeddyBloxpin", true)
end)

local tGear = CreateTab("Gear")

local function GetTool(name)
	RS.RemoteEvents.GiveTool:FireServer(name)
end

CreateButton(tGear, "Give Medkit", Color3.fromRGB(50, 150, 50), function() GetTool("MedKit") end)
CreateButton(tGear, "Give Pizza v3", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza3") end)
CreateButton(tGear, "Give Lollipop", Color3.fromRGB(200, 80, 150), function() GetTool("Lollipop") end)
CreateButton(tGear, "Give Teddy", Color3.fromRGB(150, 100, 200), function() GetTool("TeddyBloxpin") end)
CreateButton(tGear, "Give Cure", Color3.fromRGB(65, 185, 135), function() GetTool("Cure") end)
CreateButton(tGear, "Give Plank", Color3.fromRGB(160, 110, 60), function() GetTool("Plank") end)
CreateButton(tGear, "Give Car Key", Color3.fromRGB(195, 165, 35), function() GetTool("CarKey") end)
CreateButton(tGear, "Give Expired Cola", Color3.fromRGB(80, 155, 210), function() GetTool("ExpiredBloxyCola") end)
CreateButton(tGear, "Give Pizza v2", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza2") end)
CreateButton(tGear, "Give Pizza v1", Color3.fromRGB(200, 120, 50), function() GetTool("Pizza1") end)
CreateButton(tGear, "Give Key", Color3.fromRGB(45, 75, 40), function() GetTool("Key") end)
CreateButton(tGear, "Give Epic Pizza", Color3.fromRGB(77, 100, 89), function() GetTool("EpicPizza") end)
CreateButton(tGear, "Give Pie", Color3.fromRGB(115, 65, 95), function() GetTool("Pie") end)

local foodItems = {
	{"Apple", Color3.fromRGB(195, 55, 55)},
	{"Cookie", Color3.fromRGB(150, 100, 50)},
	{"Chips", Color3.fromRGB(195, 145, 50)},
	{"BloxyCola", Color3.fromRGB(55, 65, 185)}
}
for _, item in pairs(foodItems) do
	CreateButton(tGear, "Give " .. item[1], item[2], function() GetTool(item[1]) end)
end

CreateButton(tGear, "Weapon: Bat", Color3.fromRGB(80, 80, 90), function()
	RS.RemoteEvents.GiveTool:FireServer("Bat")
end)

CreateButton(tGear, "Weapon: Linked Sword", Color3.fromRGB(95, 95, 195), function()
	RS.RemoteEvents.GiveTool:FireServer("LinkedSword")
end)

CreateButton(tGear, "Weapon: Sword", Color3.fromRGB(165, 165, 85), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Sword")
end)

CreateButton(tGear, "Weapon: Gun", Color3.fromRGB(50, 80, 180), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Gun")
end)

CreateButton(tGear, "Weapon: SWAT Gun", Color3.fromRGB(42, 42, 48), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "SwatGun")
end)

CreateButton(tGear, "Weapon: Hammer", Color3.fromRGB(40, 95, 50), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Hammer")
end)

CreateButton(tGear, "Weapon: Crowbar", Color3.fromRGB(115, 80, 35), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Crowbar")
end)

CreateButton(tGear, "Weapon: Spanner", Color3.fromRGB(60, 100, 140), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Spanner")
end)

CreateButton(tGear, "Weapon: Pitchfork", Color3.fromRGB(125, 60, 60), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Pitchfork")
end)

CreateButton(tGear, "Weapon: Broom", Color3.fromRGB(150, 30, 89), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Broom")
end)

CreateButton(tGear, "Weapon: Breaker", Color3.fromRGB(210, 65, 90), function()
	RS.RemoteEvents.BasementWeapon:FireServer(true, "Breaker")
end)

local tPlayers = CreateTab("Players")
local Box = Instance.new("TextBox", tPlayers)
Box.Size = UDim2.new(1, -4, 0, 30)
Box.PlaceholderText = "Target name..."
Box.TextSize = 11
Box.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
Box.TextColor3 = Color3.new(1, 1, 1)
Box.BorderSizePixel = 0
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

local function FindP()
	if Box.Text == "" then return nil end
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower():find(Box.Text:lower(), 1, true) then
			return p
		end
	end
end

CreateButton(tPlayers, "Drown Target", Color3.fromRGB(180, 50, 50), function()
	local t = FindP()
	if t then RS.RemoteEvents.ToxicDrown:FireServer(1, t) end
end)

CreateButton(tPlayers, "Drown All", Color3.fromRGB(210, 30, 30), function()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= Player then RS.RemoteEvents.ToxicDrown:FireServer(1, p) end
	end
end)

local loop = false
local tkBtn = CreateButton(tPlayers, "Auto Drown: OFF", Color3.fromRGB(62, 62, 72), function() end)

tkBtn.MouseButton1Click:Connect(function()
	loop = not loop
	if loop then
		tkBtn.Text = "Auto Drown: ON"
		tkBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		tkBtn.Text = "Auto Drown: OFF"
		tkBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

task.spawn(function()
	while task.wait(1.5) do
		if loop then
			local t = FindP()
			if t then RS.RemoteEvents.ToxicDrown:FireServer(1, t) end
		end
	end
end)

CreateButton(tPlayers, "Drown Random", Color3.fromRGB(195, 50, 50), function()
	local candidates = {}
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= Player then
			table.insert(candidates, plr)
		end
	end
	if #candidates > 0 then
		local randomPlayer = candidates[math.random(1, #candidates)]
		RS.RemoteEvents.ToxicDrown:FireServer(1, randomPlayer)
	end
end)

local selectedCurePlayer = nil

local selectPlayerBtn = Instance.new("TextButton")
selectPlayerBtn.Size = UDim2.new(1, -4, 0, 30)
selectPlayerBtn.Text = "Heal Target: None"
selectPlayerBtn.Font = Enum.Font.GothamSemibold
selectPlayerBtn.TextSize = 11
selectPlayerBtn.TextColor3 = Color3.new(1, 1, 1)
selectPlayerBtn.BackgroundColor3 = Color3.fromRGB(55, 100, 195)
selectPlayerBtn.BorderSizePixel = 0
selectPlayerBtn.Parent = tPlayers
Instance.new("UICorner", selectPlayerBtn).CornerRadius = UDim.new(0, 6)

selectPlayerBtn.MouseButton1Click:Connect(function()
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 190, 0, 260)
	frame.Position = UDim2.new(0.5, -95, 0.5, -130)
	frame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	frame.BorderSizePixel = 0
	frame.Parent = ScreenGui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0, 28, 0, 28)
	close.Position = UDim2.new(1, -28, 0, 0)
	close.Text = "X"
	close.Font = Enum.Font.GothamBold
	close.TextColor3 = Color3.fromRGB(255, 85, 85)
	close.BackgroundTransparency = 1
	close.Parent = frame
	close.MouseButton1Click:Connect(function() frame:Destroy() end)

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -10, 1, -36)
	scroll.Position = UDim2.new(0, 5, 0, 32)
	scroll.BackgroundTransparency = 1
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.ScrollBarThickness = 3
	scroll.Parent = frame
	Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 3)

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= Player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -6, 0, 28)
			btn.Text = plr.Name
			btn.TextSize = 11
			btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.BorderSizePixel = 0
			btn.Parent = scroll
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
			btn.MouseButton1Click:Connect(function()
				selectedCurePlayer = plr
				selectPlayerBtn.Text = "Heal Target: " .. plr.Name
				frame:Destroy()
			end)
		end
	end
end)

local cureHimBtn = CreateButton(tPlayers, "Cure Target", Color3.fromRGB(75, 175, 95), function()
	if not selectedCurePlayer then return end
	task.spawn(function()
		RS.RemoteEvents.GiveTool:FireServer("Cure")
		task.wait(0.3)
		local backpack = Player.Backpack
		local cure = backpack:FindFirstChild("Cure")
		if cure then
			RS.RemoteEvents.BackpackEvent:FireServer("Equip", cure)
			task.wait(0.2)
		end
		for i = 1, 3 do
			RS.RemoteEvents.CurePlayer:FireServer(selectedCurePlayer)
			task.wait(0.1)
		end
		if Player.Character then
			local tool = Player.Character:FindFirstChild("Cure")
			if tool then tool.Parent = backpack end
		end
		task.wait(0.2)
		if cure then
			RS.RemoteEvents.AddIngredient:FireServer(cure.Name)
		end
	end)
end)

local tWarps = CreateTab("Warps")

local function addTPButton(name, cframe)
	CreateButton(tWarps, "TP: " .. name, Color3.fromRGB(70, 110, 190), function()
		local char = Player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = cframe
		end
	end)
end

addTPButton("Basement", CFrame.new(71, -15, -163))
addTPButton("House", CFrame.new(-36, 3, -200))
addTPButton("Hiding Spot", CFrame.new(-42.87, 6.43, -222.01))
addTPButton("Attic", CFrame.new(-16, 35, -220))
addTPButton("Store", CFrame.new(-422, 3, -121))
addTPButton("Sewer", CFrame.new(129, 3, -125))
addTPButton("Boss Room", CFrame.new(-39, -287, -1480))
addTPButton("Larry House", CFrame.new(-1805.54561, 4961.04932, -2426.79102, -0.98962009, 3.316136293-09, -0.143708378, 1.78976622e-09, 1, 1.075058e-08, 0.143708378, 1.03817852e-08, -0.98962009))
addTPButton("Auto Park", CFrame.new(-3113.70776, 1418.43811, -1972.401, -0.472113997, 0.303905189, -0.827496231, -3.9409386e-08, 0.938696563, 0.344744503, 0.881537497, 0.162758738, -0.443171769))
addTPButton("Load Players", CFrame.new(-1214.32019, 13.7232265, -79.6718445, 0.919825017, 0.14922373, -0.362841815, -8.02136313e-09, 0.924841106, 0.380353689, 0.392328829, -0.34985885, 0.850691974))
addTPButton("Wardrobe", CFrame.new(-46.3465195, 2.21590257, -192.691376, -0.743683636, -3.29508119e-08, -0.668531716, 1.47892463e-08, 1, -6.57400818e-08, 0.668531716, -5.87769051e-08, -0.743683636))

local tActions = CreateTab("Actions")

CreateButton(tActions, "Slay BadGuys", Color3.fromRGB(195, 50, 50), function()
	local enemies = workspace:FindFirstChild("BadGuys")
	if enemies then
		for _, enemy in pairs(enemies:GetChildren()) do
			for i = 1, 50 do
				RS.RemoteEvents.HitBadguy:FireServer(enemy, 10)
				RS.RemoteEvents.HitBadguy:FireServer(enemy, 996)
				RS.RemoteEvents.HitBadguy:FireServer(enemy, 9)
				RS.RemoteEvents.HitBadguy:FireServer(enemy, 8)
			end
		end
	end
end)

CreateButton(tActions, "Befriend Cat", Color3.fromRGB(215, 165, 75), function()
	RS.RemoteEvents.Cattery:FireServer()
end)

local catJumpEnabled = false
local catJumpConnection = nil
local catJumpBtn = CreateButton(tActions, "Cat Jump Loop: OFF", Color3.fromRGB(62, 62, 72), function() end)

catJumpBtn.MouseButton1Click:Connect(function()
	catJumpEnabled = not catJumpEnabled
	if catJumpEnabled then
		catJumpBtn.Text = "Cat Jump Loop: ON"
		catJumpBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		catJumpConnection = task.spawn(function()
			while catJumpEnabled do
				RS.RemoteEvents.CatJumped:FireServer()
				task.wait(0.05)
			end
		end)
	else
		catJumpBtn.Text = "Cat Jump Loop: OFF"
		catJumpBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
		if catJumpConnection then
			task.cancel(catJumpConnection)
			catJumpConnection = nil
		end
	end
end)

CreateButton(tActions, "Self Padlock Check", Color3.fromRGB(195, 100, 50), function()
	RS.RemoteEvents.PadlockDetector:FireServer(Player)
end)

local healEnabled = false
local healConnection = nil
local healBtn = CreateButton(tActions, "Cat Energy Loop: OFF", Color3.fromRGB(62, 62, 72), function() end)

healBtn.MouseButton1Click:Connect(function()
	healEnabled = not healEnabled
	if healEnabled then
		healBtn.Text = "Cat Energy Loop: ON"
		healBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		healConnection = task.spawn(function()
			while healEnabled do
				for i = 1, 200 do
					if not healEnabled then break end
					RS.RemoteEvents.Energy:FireServer("Cat")
					task.wait(0.005)
				end
				task.wait(0.1)
			end
		end)
	else
		healBtn.Text = "Cat Energy Loop: OFF"
		healBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
		if healConnection then
			task.cancel(healConnection)
			healConnection = nil
		end
	end
end)

CreateButton(tActions, "Spawn Ladder", Color3.fromRGB(55, 100, 195), function()
	RS.RemoteEvents.Ladder:FireServer(1)
end)

CreateButton(tActions, "Clear Backpack", Color3.fromRGB(195, 100, 50), function()
	local remote = RS.RemoteEvents.AddIngredient
	local function clearBackpack()
		local backpack = Player:WaitForChild("Backpack")
		local tools = {}
		for _, tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				table.insert(tools, tool.Name)
			end
		end
		for _, name in ipairs(tools) do
			remote:FireServer(name)
		end
		return #tools
	end

	task.spawn(function()
		while true do
			local count = clearBackpack()
			if count == 0 then break end
			task.wait(0.3)
		end
	end)
end)

local autoOpenFrontEnabled = false
local autoOpenFrontBtn = CreateButton(tActions, "Auto Front Door: OFF", Color3.fromRGB(62, 62, 72), function() end)

autoOpenFrontBtn.MouseButton1Click:Connect(function()
	autoOpenFrontEnabled = not autoOpenFrontEnabled
	if autoOpenFrontEnabled then
		autoOpenFrontBtn.Text = "Auto Front Door: ON"
		autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while autoOpenFrontEnabled do
				RS.RemoteEvents.Door:FireServer("Front")
				task.wait(2)
			end
		end)
	else
		autoOpenFrontBtn.Text = "Auto Front Door: OFF"
		autoOpenFrontBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

CreateButton(tActions, "Unlock Basement", Color3.fromRGB(100, 80, 200), function()
	RS.RemoteEvents.UnlockDoor:FireServer()
end)

CreateButton(tActions, "Scary Larry Ending", Color3.fromRGB(175, 55, 175), function()
	RS.RemoteEvents.GetKeys:FireServer()
	task.wait(0.1)
	RS.RemoteEvents.CarEnding:FireServer()
	Notify("Scary Larry Ending triggered")
end)

CreateButton(tActions, "EggEnd Start", Color3.fromRGB(175, 55, 175), function()
	RS.RemoteEvents.EggHuntEvent:FireServer(2, "IcePart1")
	Notify("EggEnd Successfully")
end)

CreateButton(tActions, "Start Basement Task", Color3.fromRGB(75, 145, 75), function()
	RS.RemoteEvents.BasementMission:FireServer()
end)

CreateButton(tActions, "Open Attic", Color3.fromRGB(165, 110, 50), function()
	RS.RemoteEvents.Ladder:FireServer(1)
	task.wait(0.5)

	local char = Player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = CFrame.new(-19.7859402, 19.4470539, -225.477798, 0.919709146, -1.09539059e-07, 0.392600417, 9.91085827e-08, 1, 4.68363979e-08, -0.392600417, -4.16579482e-09, 0.919709146)
	end

	local mouse = Player:GetMouse()
	local clickStartTime = tick()
	while tick() - clickStartTime < 2 do
		local clickEvent = {
			Target = nil,
			Position = mouse.Hit.p,
			UnitRay = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction),
			UserInputState = Enum.UserInputState.Begin,
			UserInputType = Enum.UserInputType.MouseButton1
		}
		game:GetService("ContextActionService"):FireInputBegan(mouse, clickEvent)
		task.wait(0.05)
	end
end)

CreateButton(tActions, "Heal All Players", Color3.fromRGB(50, 150, 100), function()
	task.spawn(function()
		RS.RemoteEvents.GiveTool:FireServer("MedKit")
		task.wait(0.3)

		local backpack = Player.Backpack
		local medKit = backpack:FindFirstChild("MedKit")

		if medKit then
			RS.RemoteEvents.BackpackEvent:FireServer("Equip", medKit)
			task.wait(0.2)
		end

		local allPlayers = {}
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= Player then
				table.insert(allPlayers, plr)
			end
		end

		for _, plr in pairs(allPlayers) do
			RS.RemoteEvents.HealPlayer:FireServer(plr)
			task.wait(0.05)
		end

		local character = Player.Character
		if character then
			local tool = character:FindFirstChild("MedKit")
			if tool then
				tool.Parent = backpack
			end
		end

		task.wait(0.2)

		if medKit then
			RS.RemoteEvents.AddIngredient:FireServer(medKit.Name)
		end

		Notify("Healed " .. #allPlayers .. " players")
	end)
end)

CreateButton(tActions, "Click Paintings", Color3.fromRGB(115, 115, 195), function()
	local house = workspace:FindFirstChild("TheHouse")
	if not house then return end

	for _, obj in pairs(house:GetDescendants()) do
		if obj.Name == "Painting" then
			local click = obj:FindFirstChildOfClass("ClickDetector")
			if click then
				local startTime = tick()
				while tick() - startTime < 3 do
					fireclickdetector(click)
					task.wait()
				end
			end
		end
	end
end)

CreateButton(tActions, "Crack Safe Code", Color3.fromRGB(195, 145, 50), function()
	local codeNote = workspace:FindFirstChild("CodeNote")
	if not codeNote then return end

	local gui = codeNote:FindFirstChild("SurfaceGui")
	if not gui then return end

	local label = gui:FindFirstChild("TextLabel")
	if not label then return end

	local code = label.Text
	if not code or code == "" then return end

	RS.RemoteEvents.Safe:FireServer(code)
end)

local autoBasementOpenEnabled = false
local autoBasementOpenConnection = nil
local autoBasementOpenBtn = CreateButton(tActions, "Auto Basement Door: OFF", Color3.fromRGB(62, 62, 72), function() end)

autoBasementOpenBtn.MouseButton1Click:Connect(function()
	autoBasementOpenEnabled = not autoBasementOpenEnabled
	if autoBasementOpenEnabled then
		autoBasementOpenBtn.Text = "Auto Basement Door: ON"
		autoBasementOpenBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		autoBasementOpenConnection = task.spawn(function()
			while autoBasementOpenEnabled do
				RS.RemoteEvents.Door:FireServer("Basement")
				task.wait(3)
			end
		end)
	else
		autoBasementOpenBtn.Text = "Auto Basement Door: OFF"
		autoBasementOpenBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
		if autoBasementOpenConnection then
			task.cancel(autoBasementOpenConnection)
			autoBasementOpenConnection = nil
		end
	end
end)

CreateButton(tActions, "Instant Ice Slip", Color3.fromRGB(90, 165, 235), function()
	RS.RemoteEvents.IceSlip:FireServer(Vector3.new(2.182706832885742, 13.64895248413086, -107.35334777832031))
end)

local bedHealEnabled = false
local bedHealConnection = nil
local bedHealBtn = CreateButton(tActions, "Bed Heal Spam: OFF", Color3.fromRGB(62, 62, 72), function() end)

bedHealBtn.MouseButton1Click:Connect(function()
	bedHealEnabled = not bedHealEnabled
	if bedHealEnabled then
		bedHealBtn.Text = "Bed Heal Spam: ON"
		bedHealBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		bedHealConnection = task.spawn(function()
			while bedHealEnabled do
				RS.RemoteEvents.BedTime:FireServer()
				task.wait()
			end
		end)
	else
		bedHealBtn.Text = "Bed Heal Spam: OFF"
		bedHealBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
		if bedHealConnection then
			task.cancel(bedHealConnection)
			bedHealConnection = nil
		end
	end
end)

local clickPaintingEnabled = false
local clickPaintingBtn = CreateButton(tActions, "Auto Cat Painting: OFF", Color3.fromRGB(62, 62, 72), function() end)

clickPaintingBtn.MouseButton1Click:Connect(function()
	clickPaintingEnabled = not clickPaintingEnabled
	if clickPaintingEnabled then
		clickPaintingBtn.Text = "Auto Cat Painting: ON"
		clickPaintingBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while clickPaintingEnabled do
				local house = workspace:FindFirstChild("TheHouse")
				local painting = house and house:FindFirstChild("Painting2")
				local clickDetector = painting and painting:FindFirstChild("ClickDetector")
				if clickDetector then
					fireclickdetector(clickDetector)
				end
				task.wait(0.1)
			end
		end)
	else
		clickPaintingBtn.Text = "Auto Cat Painting: OFF"
		clickPaintingBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

local catSpamEnabled = false
local catSpamBtn = CreateButton(tActions, "Cat Spam Loop: OFF", Color3.fromRGB(62, 62, 72), function() end)

catSpamBtn.MouseButton1Click:Connect(function()
	catSpamEnabled = not catSpamEnabled
	if catSpamEnabled then
		catSpamBtn.Text = "Cat Spam Loop: ON"
		catSpamBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while catSpamEnabled do
				RS.RemoteEvents.Cattery:FireServer()
				task.wait(0.2)
			end
		end)
	else
		catSpamBtn.Text = "Cat Spam Loop: OFF"
		catSpamBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

CreateButton(tActions, "Cure Self", Color3.fromRGB(75, 175, 95), function()
	task.spawn(function()
		RS.RemoteEvents.GiveTool:FireServer("Cure")
		task.wait(0.3)

		local backpack = Player.Backpack
		local cure = backpack:FindFirstChild("Cure")

		if cure then
			RS.RemoteEvents.BackpackEvent:FireServer("Equip", cure)
			task.wait(0.2)
		end

		for i = 1, 3 do
			RS.RemoteEvents.CurePlayer:FireServer(Player)
			task.wait(0.1)
		end

		if Player.Character then
			local tool = Player.Character:FindFirstChild("Cure")
			if tool then tool.Parent = backpack end
		end

		task.wait(0.2)

		if cure then
			RS.RemoteEvents.AddIngredient:FireServer(cure.Name)
		end
	end)
end)

local getKeysSpamEnabled = false
local getKeysSpamBtn = CreateButton(tActions, "Key Spam Loop: OFF", Color3.fromRGB(62, 62, 72), function() end)

getKeysSpamBtn.MouseButton1Click:Connect(function()
	getKeysSpamEnabled = not getKeysSpamEnabled
	if getKeysSpamEnabled then
		getKeysSpamBtn.Text = "Key Spam Loop: ON"
		getKeysSpamBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while getKeysSpamEnabled do
				RS.RemoteEvents.GetKeys:FireServer()
				task.wait(0.2)
			end
		end)
	else
		getKeysSpamBtn.Text = "Key Spam Loop: OFF"
		getKeysSpamBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

local pieHealPosEnabled = false
local pieHealPosBtn = CreateButton(tActions, "Pie Inf Heal (+): OFF", Color3.fromRGB(62, 62, 72), function() end)

pieHealPosBtn.MouseButton1Click:Connect(function()
	pieHealPosEnabled = not pieHealPosEnabled
	if pieHealPosEnabled then
		pieHealPosBtn.Text = "Pie Inf Heal (+): ON"
		pieHealPosBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while pieHealPosEnabled do
				RS.RemoteEvents.EatPie:FireServer(false, 1, math.huge, false)
				task.wait(0.1)
			end
		end)
	else
		pieHealPosBtn.Text = "Pie Inf Heal (+): OFF"
		pieHealPosBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

local pieHealNegEnabled = false
local pieHealNegBtn = CreateButton(tActions, "Pie Inf Heal (-): OFF", Color3.fromRGB(62, 62, 72), function() end)

pieHealNegBtn.MouseButton1Click:Connect(function()
	pieHealNegEnabled = not pieHealNegEnabled
	if pieHealNegEnabled then
		pieHealNegBtn.Text = "Pie Inf Heal (-): ON"
		pieHealNegBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while pieHealNegEnabled do
				RS.RemoteEvents.EatPie:FireServer(false, -1, math.huge, false)
				task.wait(0.1)
			end
		end)
	else
		pieHealNegBtn.Text = "Pie Inf Heal (-): OFF"
		pieHealNegBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

local unlockDoorEnabled = false
local unlockDoorBtn = CreateButton(tActions, "Unlock Spam: OFF", Color3.fromRGB(62, 62, 72), function() end)

unlockDoorBtn.MouseButton1Click:Connect(function()
	unlockDoorEnabled = not unlockDoorEnabled
	if unlockDoorEnabled then
		unlockDoorBtn.Text = "Unlock Spam: ON"
		unlockDoorBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		task.spawn(function()
			while unlockDoorEnabled do
				RS.RemoteEvents.UnlockDoor:FireServer()
				task.wait(0.2)
			end
		end)
	else
		unlockDoorBtn.Text = "Unlock Spam: OFF"
		unlockDoorBtn.BackgroundColor3 = Color3.fromRGB(62, 62, 72)
	end
end)

CreateButton(tActions, "Remove Planks", Color3.fromRGB(195, 100, 50), function()
	RS.RemoteEvents.DestroyPlank:FireServer()
end)

CreateButton(tActions, "Click Ice Part", Color3.fromRGB(55, 145, 195), function()
	local iceParts = workspace:FindFirstChild("IceParts")
	if iceParts then
		for _, obj in pairs(iceParts:GetChildren()) do
			local click = obj:FindFirstChild("ClickDetector")
			if click then
				fireclickdetector(click)
				break
			end
		end
	end
end)

CreateButton(tActions, "Suicide (-Inf)", Color3.fromRGB(180, 50, 50), function()
	RS.RemoteEvents.Energy:FireServer(-math.huge)
end)

local tTools = CreateTab("Tools")

local energySection = Instance.new("Frame")
energySection.Size = UDim2.new(1, -4, 0, 178)
energySection.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
energySection.BorderSizePixel = 0
energySection.Parent = tTools
Instance.new("UICorner", energySection).CornerRadius = UDim.new(0, 7)

local energyTitle = Instance.new("TextLabel")
energyTitle.Text = "Energy & Inventory"
energyTitle.Font = Enum.Font.GothamBold
energyTitle.TextSize = 11
energyTitle.TextColor3 = Color3.fromRGB(210, 210, 225)
energyTitle.BackgroundTransparency = 1
energyTitle.Size = UDim2.new(1, -16, 0, 20)
energyTitle.Position = UDim2.new(0, 8, 0, 4)
energyTitle.TextXAlignment = Enum.TextXAlignment.Left
energyTitle.Parent = energySection

local energyBox = Instance.new("TextBox")
energyBox.Size = UDim2.new(1, -16, 0, 28)
energyBox.Position = UDim2.new(0, 8, 0, 26)
energyBox.PlaceholderText = "Energy amount..."
energyBox.Text = "200"
energyBox.Font = Enum.Font.Gotham
energyBox.TextSize = 11
energyBox.TextColor3 = Color3.new(1, 1, 1)
energyBox.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
energyBox.BorderSizePixel = 0
energyBox.Parent = energySection
Instance.new("UICorner", energyBox).CornerRadius = UDim.new(0, 5)

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(1, -16, 0, 28)
minusBtn.Position = UDim2.new(0, 8, 0, 60)
minusBtn.Text = "Drain Energy"
minusBtn.Font = Enum.Font.GothamSemibold
minusBtn.TextSize = 11
minusBtn.TextColor3 = Color3.new(1, 1, 1)
minusBtn.BackgroundColor3 = Color3.fromRGB(195, 100, 50)
minusBtn.BorderSizePixel = 0
minusBtn.Parent = energySection
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 5)

minusBtn.MouseButton1Click:Connect(function()
	local num = tonumber(energyBox.Text)
	if num then
		RS.RemoteEvents.Energy:FireServer(-num)
	end
end)

local selectedItem = nil
local itemsBtn = Instance.new("TextButton")
itemsBtn.Size = UDim2.new(1, -16, 0, 28)
itemsBtn.Position = UDim2.new(0, 8, 0, 96)
itemsBtn.Text = "Selected Tool: None"
itemsBtn.Font = Enum.Font.GothamSemibold
itemsBtn.TextSize = 11
itemsBtn.TextColor3 = Color3.new(1, 1, 1)
itemsBtn.BackgroundColor3 = Color3.fromRGB(75, 100, 195)
itemsBtn.BorderSizePixel = 0
itemsBtn.Parent = energySection
Instance.new("UICorner", itemsBtn).CornerRadius = UDim.new(0, 5)

local deleteItemBtn = Instance.new("TextButton")
deleteItemBtn.Size = UDim2.new(1, -16, 0, 28)
deleteItemBtn.Position = UDim2.new(0, 8, 0, 130)
deleteItemBtn.Text = "Delete Selected Tool"
deleteItemBtn.Font = Enum.Font.GothamSemibold
deleteItemBtn.TextSize = 11
deleteItemBtn.TextColor3 = Color3.new(1, 1, 1)
deleteItemBtn.BackgroundColor3 = Color3.fromRGB(195, 75, 75)
deleteItemBtn.BorderSizePixel = 0
deleteItemBtn.Parent = energySection
Instance.new("UICorner", deleteItemBtn).CornerRadius = UDim.new(0, 5)

local function GetItemsList()
	local items = {}
	for _, tool in pairs(Player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			table.insert(items, tool.Name)
		end
	end
	if Player.Character then
		for _, tool in pairs(Player.Character:GetChildren()) do
			if tool:IsA("Tool") then
				table.insert(items, tool.Name)
			end
		end
	end
	return items
end

itemsBtn.MouseButton1Click:Connect(function()
	local itemsWindow = Instance.new("Frame")
	itemsWindow.Size = UDim2.new(0, 210, 0, 250)
	itemsWindow.Position = UDim2.new(0.5, -105, 0.5, -125)
	itemsWindow.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	itemsWindow.BorderSizePixel = 0
	itemsWindow.Parent = ScreenGui
	Instance.new("UICorner", itemsWindow).CornerRadius = UDim.new(0, 8)

	local winHeader = Instance.new("Frame")
	winHeader.Size = UDim2.new(1, 0, 0, 28)
	winHeader.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
	winHeader.BorderSizePixel = 0
	winHeader.Parent = itemsWindow
	Instance.new("UICorner", winHeader).CornerRadius = UDim.new(0, 8)

	local winTitle = Instance.new("TextLabel")
	winTitle.Size = UDim2.new(1, -40, 1, 0)
	winTitle.Position = UDim2.new(0, 10, 0, 0)
	winTitle.Text = "Select Tool"
	winTitle.TextSize = 11
	winTitle.TextColor3 = Color3.new(1, 1, 1)
	winTitle.BackgroundTransparency = 1
	winTitle.Font = Enum.Font.GothamBold
	winTitle.TextXAlignment = Enum.TextXAlignment.Left
	winTitle.Parent = winHeader

	local winClose = Instance.new("TextButton")
	winClose.Size = UDim2.new(0, 28, 1, 0)
	winClose.Position = UDim2.new(1, -28, 0, 0)
	winClose.Text = "X"
	winClose.Font = Enum.Font.GothamBold
	winClose.TextColor3 = Color3.fromRGB(255, 85, 85)
	winClose.BackgroundTransparency = 1
	winClose.Parent = winHeader
	winClose.MouseButton1Click:Connect(function() itemsWindow:Destroy() end)

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -10, 1, -36)
	scroll.Position = UDim2.new(0, 5, 0, 32)
	scroll.BackgroundTransparency = 1
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.ScrollBarThickness = 3
	scroll.Parent = itemsWindow
	Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 3)

	local items = GetItemsList()
	if #items == 0 then
		local noItems = Instance.new("TextLabel")
		noItems.Size = UDim2.new(1, -6, 0, 28)
		noItems.Text = "No tools found"
		noItems.TextSize = 11
		noItems.TextColor3 = Color3.fromRGB(255, 110, 110)
		noItems.BackgroundTransparency = 1
		noItems.Parent = scroll
	else
		for _, itemName in pairs(items) do
			local itemBtn = Instance.new("TextButton")
			itemBtn.Size = UDim2.new(1, -6, 0, 28)
			itemBtn.Text = itemName
			itemBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
			itemBtn.Font = Enum.Font.Gotham
			itemBtn.TextColor3 = Color3.new(1, 1, 1)
			itemBtn.TextSize = 11
			itemBtn.BorderSizePixel = 0
			itemBtn.Parent = scroll
			Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)

			itemBtn.MouseButton1Click:Connect(function()
				selectedItem = itemName
				itemsBtn.Text = "Selected Tool: " .. selectedItem
				itemsWindow:Destroy()
			end)
		end
	end
end)

deleteItemBtn.MouseButton1Click:Connect(function()
	if not selectedItem then return end
	local item = Player.Backpack:FindFirstChild(selectedItem) or (Player.Character and Player.Character:FindFirstChild(selectedItem))
	if item then
		RS.RemoteEvents.AddIngredient:FireServer(selectedItem)
		selectedItem = nil
		itemsBtn.Text = "Selected Tool: None"
	end
end)

local padlockSection = Instance.new("Frame")
padlockSection.Size = UDim2.new(1, -4, 0, 82)
padlockSection.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
padlockSection.BorderSizePixel = 0
padlockSection.Parent = tTools
Instance.new("UICorner", padlockSection).CornerRadius = UDim.new(0, 7)

local selectPlayerBtn = Instance.new("TextButton")
selectPlayerBtn.Size = UDim2.new(1, -16, 0, 28)
selectPlayerBtn.Position = UDim2.new(0, 8, 0, 8)
selectPlayerBtn.Text = "Padlock Target: None"
selectPlayerBtn.Font = Enum.Font.GothamSemibold
selectPlayerBtn.TextSize = 11
selectPlayerBtn.TextColor3 = Color3.new(1, 1, 1)
selectPlayerBtn.BackgroundColor3 = Color3.fromRGB(55, 100, 195)
selectPlayerBtn.BorderSizePixel = 0
selectPlayerBtn.Parent = padlockSection
Instance.new("UICorner", selectPlayerBtn).CornerRadius = UDim.new(0, 5)

local finderPadlockBtn = Instance.new("TextButton")
finderPadlockBtn.Size = UDim2.new(1, -16, 0, 28)
finderPadlockBtn.Position = UDim2.new(0, 8, 0, 44)
finderPadlockBtn.Text = "Scan Padlock"
finderPadlockBtn.Font = Enum.Font.GothamSemibold
finderPadlockBtn.TextSize = 11
finderPadlockBtn.TextColor3 = Color3.new(1, 1, 1)
finderPadlockBtn.BackgroundColor3 = Color3.fromRGB(195, 100, 50)
finderPadlockBtn.BorderSizePixel = 0
finderPadlockBtn.Parent = padlockSection
Instance.new("UICorner", finderPadlockBtn).CornerRadius = UDim.new(0, 5)

local selectedPadlockPlayer = nil

local function OpenPlayerList()
	local playerWindow = Instance.new("Frame")
	playerWindow.Size = UDim2.new(0, 210, 0, 280)
	playerWindow.Position = UDim2.new(0.5, -105, 0.5, -140)
	playerWindow.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	playerWindow.BorderSizePixel = 0
	playerWindow.Parent = ScreenGui
	Instance.new("UICorner", playerWindow).CornerRadius = UDim.new(0, 8)

	local winHeader = Instance.new("Frame")
	winHeader.Size = UDim2.new(1, 0, 0, 28)
	winHeader.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
	winHeader.BorderSizePixel = 0
	winHeader.Parent = playerWindow
	Instance.new("UICorner", winHeader).CornerRadius = UDim.new(0, 8)

	local winTitle = Instance.new("TextLabel")
	winTitle.Size = UDim2.new(1, -40, 1, 0)
	winTitle.Position = UDim2.new(0, 10, 0, 0)
	winTitle.Text = "Select Player"
	winTitle.TextSize = 11
	winTitle.TextColor3 = Color3.new(1, 1, 1)
	winTitle.BackgroundTransparency = 1
	winTitle.Font = Enum.Font.GothamBold
	winTitle.TextXAlignment = Enum.TextXAlignment.Left
	winTitle.Parent = winHeader

	local winClose = Instance.new("TextButton")
	winClose.Size = UDim2.new(0, 28, 1, 0)
	winClose.Position = UDim2.new(1, -28, 0, 0)
	winClose.Text = "X"
	winClose.Font = Enum.Font.GothamBold
	winClose.TextColor3 = Color3.fromRGB(255, 85, 85)
	winClose.BackgroundTransparency = 1
	winClose.Parent = winHeader
	winClose.MouseButton1Click:Connect(function() playerWindow:Destroy() end)

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -10, 1, -36)
	scroll.Position = UDim2.new(0, 5, 0, 32)
	scroll.BackgroundTransparency = 1
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.ScrollBarThickness = 3
	scroll.Parent = playerWindow
	Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 3)

	for _, plr in pairs(Players:GetPlayers()) do
		local playerBtn = Instance.new("TextButton")
		playerBtn.Size = UDim2.new(1, -6, 0, 28)
		playerBtn.Text = plr.Name
		playerBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
		playerBtn.Font = Enum.Font.Gotham
		playerBtn.TextColor3 = Color3.new(1, 1, 1)
		playerBtn.TextSize = 11
		playerBtn.BorderSizePixel = 0
		playerBtn.Parent = scroll
		Instance.new("UICorner", playerBtn).CornerRadius = UDim.new(0, 4)

		playerBtn.MouseButton1Click:Connect(function()
			selectedPadlockPlayer = plr
			selectPlayerBtn.Text = "Padlock Target: " .. plr.Name
			playerWindow:Destroy()
		end)
	end
end

selectPlayerBtn.MouseButton1Click:Connect(OpenPlayerList)

finderPadlockBtn.MouseButton1Click:Connect(function()
	if not selectedPadlockPlayer then return end
	RS.RemoteEvents.PadlockDetector:FireServer(selectedPadlockPlayer)
end)

local tTheme = CreateTab("Theme")
local rainbowConnection = nil
local voidEnabled = false

local function UpdateTheme(color)
	MainFrame.BackgroundColor3 = color
	Header.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.22)
	Side.BackgroundColor3 = color:lerp(Color3.new(0, 0, 0), 0.32)
end

local function SetVoidTheme(enabled)
	voidEnabled = enabled
	if enabled then
		MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
		Header.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
		Side.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
		for _, star in pairs(stars) do
			star.Visible = true
		end
	else
		for _, star in pairs(stars) do
			star.Visible = false
		end
	end
end

local themes = {
	{"Dark Slate", Color3.fromRGB(22, 22, 26)},
	{"Cobalt", Color3.fromRGB(30, 60, 120)},
	{"Crimson", Color3.fromRGB(100, 30, 30)},
	{"Forest", Color3.fromRGB(30, 80, 40)},
	{"Pitch Black", Color3.fromRGB(6, 6, 8)}
}

for _, theme in pairs(themes) do
	CreateButton(tTheme, theme[1], theme[2], function()
		if rainbowConnection then
			rainbowConnection:Disconnect()
			rainbowConnection = nil
		end
		SetVoidTheme(false)
		UpdateTheme(theme[2])
	end)
end

CreateButton(tTheme, "Rainbow Mode", Color3.fromRGB(145, 55, 145), function()
	if rainbowConnection then
		rainbowConnection:Disconnect()
		rainbowConnection = nil
		SetVoidTheme(false)
		UpdateTheme(Color3.fromRGB(22, 22, 26))
	else
		SetVoidTheme(false)
		rainbowConnection = RunService.RenderStepped:Connect(function()
			local hue = tick() % 5 / 5
			local color = Color3.fromHSV(hue, 0.7, 0.6)
			UpdateTheme(color)
		end)
	end
end)

CreateButton(tTheme, "Void Stars", Color3.fromRGB(20, 20, 42), function()
	if rainbowConnection then
		rainbowConnection:Disconnect()
		rainbowConnection = nil
	end
	SetVoidTheme(not voidEnabled)
end)

setTab("Home")

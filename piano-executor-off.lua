-- ==================== PIANO ERUDITE (INFO + EXECUTOR + SONGS + SETTINGS) ====================
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local hasFS = (writefile and readfile and listfiles and makefolder and isfolder)

if game:GetService("CoreGui"):FindFirstChild("PianoEruditeGui") then
    game:GetService("CoreGui"):FindFirstChild("PianoEruditeGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PianoEruditeGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -180)
MainFrame.Size = UDim2.new(0, 440, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(120, 80, 220)
MainStroke.Thickness = 1.5

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.ZIndex = 2
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "♪ Piano Erudite"
TitleLabel.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLabel.TextSize = 17
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 180, 255)
MinimizeButton.ZIndex = 3
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 30, 50)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 200, 200)
CloseButton.ZIndex = 3
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 10, 0, 46)
ContentFrame.Size = UDim2.new(1, -20, 1, -100)
ContentFrame.ZIndex = 2

-- ==================== ВКЛАДКА INFO ====================
local InfoTab = Instance.new("Frame")
InfoTab.Parent = ContentFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.Visible = false

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "♪ Piano Erudite ♪\n\nПианино-скрипт для Roblox.\n\nВкладки:\n  • Info — информация\n  • Executor — ввод нот, Clear, Save Notes\n  • Songs — сохраненные песни\n  • Settings — скорость, формат нот, Copy link songs\n\nФормат PianoBlox: abc, [abc], {abc}, - / --\nФормат PianoGlow: abc, [abc], . / - (паузы)"
InfoLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
InfoLabel.TextSize = 13
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextWrapped = true

-- ==================== ВКЛАДКА EXECUTOR ====================
local ExecutorTab = Instance.new("Frame")
ExecutorTab.Parent = ContentFrame
ExecutorTab.BackgroundTransparency = 1
ExecutorTab.Size = UDim2.new(1, 0, 1, 0)
ExecutorTab.Visible = true

local NotesBox = Instance.new("TextBox")
NotesBox.Parent = ExecutorTab
NotesBox.BackgroundColor3 = Color3.fromRGB(18, 15, 35)
NotesBox.BorderSizePixel = 1
NotesBox.BorderColor3 = Color3.fromRGB(80, 50, 150)
NotesBox.Position = UDim2.new(0, 0, 0, 0)
NotesBox.Size = UDim2.new(1, 0, 1, -95)
NotesBox.Font = Enum.Font.Code
NotesBox.Text = ""
NotesBox.PlaceholderText = "Вставь сюда ноты..."
NotesBox.TextColor3 = Color3.fromRGB(220, 200, 255)
NotesBox.PlaceholderColor3 = Color3.fromRGB(120, 100, 160)
NotesBox.TextSize = 13
NotesBox.TextWrapped = true
NotesBox.TextXAlignment = Enum.TextXAlignment.Left
NotesBox.TextYAlignment = Enum.TextYAlignment.Top
NotesBox.ClearTextOnFocus = false
NotesBox.MultiLine = true
Instance.new("UICorner", NotesBox).CornerRadius = UDim.new(0, 8)

local StartBtn = Instance.new("TextButton")
StartBtn.Parent = ExecutorTab
StartBtn.Position = UDim2.new(0, 0, 1, -85)
StartBtn.Size = UDim2.new(0.49, 0, 0, 38)
StartBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.Text = "▶ START"
StartBtn.TextColor3 = Color3.fromRGB(200, 255, 200)
StartBtn.TextSize = 15
StartBtn.BorderSizePixel = 0
Instance.new("UICorner", StartBtn).CornerRadius = UDim.new(0, 8)

local StopBtn = Instance.new("TextButton")
StopBtn.Parent = ExecutorTab
StopBtn.Position = UDim2.new(0.51, 0, 1, -85)
StopBtn.Size = UDim2.new(0.49, 0, 0, 38)
StopBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 50)
StopBtn.Font = Enum.Font.GothamBold
StopBtn.Text = "■ STOP"
StopBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
StopBtn.TextSize = 15
StopBtn.BorderSizePixel = 0
Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0, 8)

local ClearBtn = Instance.new("TextButton")
ClearBtn.Parent = ExecutorTab
ClearBtn.Position = UDim2.new(0, 0, 1, -42)
ClearBtn.Size = UDim2.new(0.49, 0, 0, 38)
ClearBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.Text = "Clear"
ClearBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
ClearBtn.TextSize = 14
ClearBtn.BorderSizePixel = 0
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 8)

local SaveBtn = Instance.new("TextButton")
SaveBtn.Parent = ExecutorTab
SaveBtn.Position = UDim2.new(0.51, 0, 1, -42)
SaveBtn.Size = UDim2.new(0.49, 0, 0, 38)
SaveBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 160)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.Text = "Save Notes"
SaveBtn.TextColor3 = Color3.fromRGB(200, 230, 255)
SaveBtn.TextSize = 14
SaveBtn.BorderSizePixel = 0
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8)

-- ==================== ВКЛАДКА SONGS ====================
local SongsTab = Instance.new("Frame")
SongsTab.Parent = ContentFrame
SongsTab.BackgroundTransparency = 1
SongsTab.Size = UDim2.new(1, 0, 1, 0)
SongsTab.Visible = false

local SongsScroll = Instance.new("ScrollingFrame")
SongsScroll.Parent = SongsTab
SongsScroll.BackgroundTransparency = 1
SongsScroll.Size = UDim2.new(1, 0, 1, 0)
SongsScroll.BorderSizePixel = 0
SongsScroll.ScrollBarThickness = 4
SongsScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 220)
SongsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SongsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", SongsScroll).Padding = UDim.new(0, 8)

-- ==================== ВКЛАДКА SETTINGS ====================
local SettingsTab = Instance.new("Frame")
SettingsTab.Parent = ContentFrame
SettingsTab.BackgroundTransparency = 1
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.Visible = false

-- Скорость abc
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SettingsTab
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Скорость abc (в секундах):"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = SettingsTab
SpeedBox.BackgroundColor3 = Color3.fromRGB(18, 15, 35)
SpeedBox.BorderSizePixel = 1
SpeedBox.BorderColor3 = Color3.fromRGB(80, 50, 150)
SpeedBox.Position = UDim2.new(0, 0, 0, 22)
SpeedBox.Size = UDim2.new(1, 0, 0, 30)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.Text = "0.12"
SpeedBox.TextColor3 = Color3.fromRGB(255, 220, 100)
SpeedBox.TextSize = 14
SpeedBox.TextXAlignment = Enum.TextXAlignment.Center
SpeedBox.ClearTextOnFocus = false
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 8)

local SetBtn = Instance.new("TextButton")
SetBtn.Parent = SettingsTab
SetBtn.Position = UDim2.new(0, 0, 0, 57)
SetBtn.Size = UDim2.new(1, 0, 0, 30)
SetBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
SetBtn.Font = Enum.Font.GothamBold
SetBtn.Text = "Set Update (abc)"
SetBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
SetBtn.TextSize = 13
SetBtn.BorderSizePixel = 0
Instance.new("UICorner", SetBtn).CornerRadius = UDim.new(0, 8)

-- Скорость {abc}
local FastLabel = Instance.new("TextLabel")
FastLabel.Parent = SettingsTab
FastLabel.BackgroundTransparency = 1
FastLabel.Position = UDim2.new(0, 0, 0, 95)
FastLabel.Size = UDim2.new(1, 0, 0, 20)
FastLabel.Font = Enum.Font.GothamBold
FastLabel.Text = "Скорость {abc} (по умолчанию 0.02):"
FastLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
FastLabel.TextSize = 13
FastLabel.TextXAlignment = Enum.TextXAlignment.Left

local FastBox = Instance.new("TextBox")
FastBox.Parent = SettingsTab
FastBox.BackgroundColor3 = Color3.fromRGB(18, 15, 35)
FastBox.BorderSizePixel = 1
FastBox.BorderColor3 = Color3.fromRGB(80, 50, 150)
FastBox.Position = UDim2.new(0, 0, 0, 117)
FastBox.Size = UDim2.new(1, 0, 0, 30)
FastBox.Font = Enum.Font.GothamBold
FastBox.Text = "0.02"
FastBox.TextColor3 = Color3.fromRGB(255, 220, 100)
FastBox.TextSize = 14
FastBox.TextXAlignment = Enum.TextXAlignment.Center
FastBox.ClearTextOnFocus = false
Instance.new("UICorner", FastBox).CornerRadius = UDim.new(0, 8)

local SetFastBtn = Instance.new("TextButton")
SetFastBtn.Parent = SettingsTab
SetFastBtn.Position = UDim2.new(0, 0, 0, 152)
SetFastBtn.Size = UDim2.new(1, 0, 0, 30)
SetFastBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
SetFastBtn.Font = Enum.Font.GothamBold
SetFastBtn.Text = "Set Update ({abc})"
SetFastBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
SetFastBtn.TextSize = 13
SetFastBtn.BorderSizePixel = 0
Instance.new("UICorner", SetFastBtn).CornerRadius = UDim.new(0, 8)

-- Переключатель формата нот
local FormatLabel = Instance.new("TextLabel")
FormatLabel.Parent = SettingsTab
FormatLabel.BackgroundTransparency = 1
FormatLabel.Position = UDim2.new(0, 0, 0, 192)
FormatLabel.Size = UDim2.new(1, 0, 0, 20)
FormatLabel.Font = Enum.Font.GothamBold
FormatLabel.Text = "Формат нот:"
FormatLabel.TextColor3 = Color3.fromRGB(200, 190, 230)
FormatLabel.TextSize = 13
FormatLabel.TextXAlignment = Enum.TextXAlignment.Left

local PianoBloxBtn = Instance.new("TextButton")
PianoBloxBtn.Parent = SettingsTab
PianoBloxBtn.Position = UDim2.new(0, 0, 0, 215)
PianoBloxBtn.Size = UDim2.new(0.49, 0, 0, 32)
PianoBloxBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
PianoBloxBtn.Font = Enum.Font.GothamBold
PianoBloxBtn.Text = "PianoBlox ✓"
PianoBloxBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
PianoBloxBtn.TextSize = 13
PianoBloxBtn.BorderSizePixel = 0
Instance.new("UICorner", PianoBloxBtn).CornerRadius = UDim.new(0, 8)

local PianoGlowBtn = Instance.new("TextButton")
PianoGlowBtn.Parent = SettingsTab
PianoGlowBtn.Position = UDim2.new(0.51, 0, 0, 215)
PianoGlowBtn.Size = UDim2.new(0.49, 0, 0, 32)
PianoGlowBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
PianoGlowBtn.Font = Enum.Font.GothamBold
PianoGlowBtn.Text = "PianoGlow ×"
PianoGlowBtn.TextColor3 = Color3.fromRGB(180, 170, 210)
PianoGlowBtn.TextSize = 13
PianoGlowBtn.BorderSizePixel = 0
Instance.new("UICorner", PianoGlowBtn).CornerRadius = UDim.new(0, 8)

-- Кнопка Copy link songs
local CopyLinkBtn = Instance.new("TextButton")
CopyLinkBtn.Parent = SettingsTab
CopyLinkBtn.Position = UDim2.new(0, 0, 0, 257)
CopyLinkBtn.Size = UDim2.new(1, 0, 0, 30)
CopyLinkBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 160)
CopyLinkBtn.Font = Enum.Font.GothamBold
CopyLinkBtn.Text = "Copy link songs"
CopyLinkBtn.TextColor3 = Color3.fromRGB(200, 230, 255)
CopyLinkBtn.TextSize = 13
CopyLinkBtn.BorderSizePixel = 0
Instance.new("UICorner", CopyLinkBtn).CornerRadius = UDim.new(0, 8)

-- ==================== ПЕРЕМЕННЫЕ ====================
local isPlaying = false
local noteDelay = 0.12
local fastDelay = 0.02
local noteFormat = "PianoBlox" -- "PianoBlox" или "PianoGlow"
local SONGS_FOLDER = "Songss-unikal"
local SONGS_LINK = "https://pianoglow.com/c/X5Wjq1Un, https://pianoblox.com/sheets/credits-song-for-my-death-impossible-piano-tutorial"

if hasFS then
    if not isfolder(SONGS_FOLDER) then
        makefolder(SONGS_FOLDER)
    end
end

-- ==================== ПЛЕЕР ====================
local function pressChar(c)
    local key
    local needShift = false

    if c:match("%a") then
        key = Enum.KeyCode[c:upper()]
        if c:match("%u") then needShift = true end
    elseif c:match("%d") then
        local digitNames = {["0"]="Zero",["1"]="One",["2"]="Two",["3"]="Three",["4"]="Four",["5"]="Five",["6"]="Six",["7"]="Seven",["8"]="Eight",["9"]="Nine"}
        key = Enum.KeyCode[digitNames[c]]
    elseif c == "$" then key = Enum.KeyCode.Four; needShift = true
    elseif c == "*" then key = Enum.KeyCode.Eight; needShift = true
    elseif c == "!" then key = Enum.KeyCode.One; needShift = true
    elseif c == "@" then key = Enum.KeyCode.Two; needShift = true
    elseif c == "#" then key = Enum.KeyCode.Three; needShift = true
    elseif c == "%" then key = Enum.KeyCode.Five; needShift = true
    elseif c == "^" then key = Enum.KeyCode.Six; needShift = true
    elseif c == "&" then key = Enum.KeyCode.Seven; needShift = true
    elseif c == "(" then key = Enum.KeyCode.Nine; needShift = true
    elseif c == ")" then key = Enum.KeyCode.Zero; needShift = true
    end

    if not key then return end

    if needShift then
        VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        task.wait(0.01)
    end
    VIM:SendKeyEvent(true, key, false, game)
    task.wait(0.02)
    VIM:SendKeyEvent(false, key, false, game)
    if needShift then
        task.wait(0.01)
        VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
    end
end

local function playNoteString(str, delay)
    for char in str:gmatch(".") do
        pressChar(char)
        task.wait(delay)
    end
end

local function playChordString(str)
    local keys = {}
    local needShift = false

    for char in str:gmatch(".") do
        local k, sh = nil, false
        if char:match("%a") then
            k = Enum.KeyCode[char:upper()]
            if char:match("%u") then sh = true end
        elseif char:match("%d") then
            local dNames = {["0"]="Zero",["1"]="One",["2"]="Two",["3"]="Three",["4"]="Four",["5"]="Five",["6"]="Six",["7"]="Seven",["8"]="Eight",["9"]="Nine"}
            k = Enum.KeyCode[dNames[char]]
        elseif char == "$" then k = Enum.KeyCode.Four; sh = true
        elseif char == "*" then k = Enum.KeyCode.Eight; sh = true
        end
        if k then 
            table.insert(keys, k)
            if sh then needShift = true end
        end
    end

    if #keys == 0 then return end

    if needShift then
        VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        task.wait(0.01)
    end
    for _, k in ipairs(keys) do VIM:SendKeyEvent(true, k, false, game) end
    task.wait(0.05)
    for _, k in ipairs(keys) do VIM:SendKeyEvent(false, k, false, game) end
    if needShift then
        task.wait(0.01)
        VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
    end
end

local function playTextSong(text)
    local i = 1
    local len = #text
    while i <= len do
        if not isPlaying then break end
        local c = text:sub(i, i)
        
        if c:match("%s") then
            i = i + 1
        elseif c == "-" then
            local dashCount = 1
            local j = i + 1
            while j <= len and text:sub(j,j) == "-" do
                dashCount = dashCount + 1
                j = j + 1
            end
            task.wait(noteDelay * dashCount)
            i = j
        elseif c == "." and noteFormat == "PianoGlow" then
            -- Точки = пауза для PianoGlow
            local dotCount = 1
            local j = i + 1
            while j <= len and text:sub(j,j) == "." do
                dotCount = dotCount + 1
                j = j + 1
            end
            task.wait(noteDelay * dotCount)
            i = j
        elseif c == "[" then
            local endIdx = text:find("]", i)
            if not endIdx then break end
            playChordString(text:sub(i + 1, endIdx - 1))
            i = endIdx + 1
            task.wait(noteDelay)
        elseif c == "{" then
            local endIdx = text:find("}", i)
            if not endIdx then break end
            playNoteString(text:sub(i + 1, endIdx - 1), fastDelay)
            i = endIdx + 1
            task.wait(noteDelay)
        else
            local startIdx = i
            local j = i
            while j <= len do
                local ch = text:sub(j, j)
                if ch:match("%s") or ch == "[" or ch == "{" or ch == "-" or (ch == "." and noteFormat == "PianoGlow") then break end
                j = j + 1
            end
            local str = text:sub(startIdx, j - 1)
            playNoteString(str, noteDelay)
            i = j
            task.wait(noteDelay * 0.5)
        end
    end
end

-- ==================== ФУНКЦИИ ФАЙЛОВ ====================
local function saveNotesToFile(name, content)
    if not hasFS then return false, "Executor не поддерживает файлы" end
    if not name or name == "" then return false, "Пустое имя" end
    name = name:gsub("[^%w_%-]", "")
    if name == "" then return false, "Некорректное имя" end
    local path = SONGS_FOLDER .. "/" .. name .. ".txt"
    local success, err = pcall(function() writefile(path, content) end)
    return success, err
end

local function loadSongsList()
    for _, child in ipairs(SongsScroll:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
    end

    if not hasFS then
        local err = Instance.new("TextLabel")
        err.Parent = SongsScroll
        err.Size = UDim2.new(1, 0, 0, 40)
        err.BackgroundTransparency = 1
        err.Text = "Файловая система не поддерживается."
        err.TextColor3 = Color3.fromRGB(255, 100, 100)
        err.Font = Enum.Font.Gotham
        err.TextSize = 14
        return
    end

    if not isfolder(SONGS_FOLDER) then makefolder(SONGS_FOLDER) end
    local files = listfiles(SONGS_FOLDER)
    if not files or #files == 0 then
        local msg = Instance.new("TextLabel")
        msg.Parent = SongsScroll
        msg.Size = UDim2.new(1, 0, 0, 40)
        msg.BackgroundTransparency = 1
        msg.Text = "Нет сохраненных песен. Сохрани что-нибудь в Executor!"
        msg.TextColor3 = Color3.fromRGB(150, 140, 180)
        msg.Font = Enum.Font.Gotham
        msg.TextSize = 13
        return
    end

    for _, filePath in ipairs(files) do
        if filePath:match("%.txt$") then
            local fileName = filePath:match("([^/\\]+)%.txt$")
            if fileName then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -8, 0, 45)
                btn.Text = "♪  " .. fileName
                btn.TextColor3 = Color3.fromRGB(220, 200, 255)
                btn.BackgroundColor3 = Color3.fromRGB(25, 20, 50)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 14
                btn.BorderSizePixel = 0
                btn.Parent = SongsScroll
                btn.AutoButtonColor = false
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
                Instance.new("UIStroke", btn).Color = Color3.fromRGB(80, 50, 150)

                btn.MouseButton1Click:Connect(function()
                    if isPlaying then return end
                    local content = readfile(filePath)
                    if content then
                        NotesBox.Text = content
                        InfoTab.Visible = false
                        ExecutorTab.Visible = true
                        SongsTab.Visible = false
                        SettingsTab.Visible = false
                        isPlaying = true
                        StartBtn.Text = "♪ PLAYING..."
                        task.spawn(function()
                            playTextSong(content)
                            isPlaying = false
                            StartBtn.Text = "▶ START"
                        end)
                    end
                end)
            end
        end
    end
end

-- ==================== ОБРАБОТЧИКИ КНОПОК ====================
StartBtn.MouseButton1Click:Connect(function()
    if isPlaying then return end
    local text = NotesBox.Text
    if text == "" then return end
    isPlaying = true
    StartBtn.Text = "♪ PLAYING..."
    task.spawn(function()
        playTextSong(text)
        isPlaying = false
        StartBtn.Text = "▶ START"
    end)
end)

StopBtn.MouseButton1Click:Connect(function()
    isPlaying = false
    StartBtn.Text = "▶ START"
end)

ClearBtn.MouseButton1Click:Connect(function()
    NotesBox.Text = ""
end)

SaveBtn.MouseButton1Click:Connect(function()
    if not hasFS then return end
    local name = "song_" .. tostring(os.time())
    local success, err = saveNotesToFile(name, NotesBox.Text)
    if success then
        SaveBtn.Text = "✓ Saved!"
        task.delay(1.5, function() SaveBtn.Text = "Save Notes" end)
        loadSongsList()
    else
        SaveBtn.Text = "✗ Error"
        task.delay(1.5, function() SaveBtn.Text = "Save Notes" end)
    end
end)

SetBtn.MouseButton1Click:Connect(function()
    local val = tonumber(SpeedBox.Text)
    if val and val > 0 then
        noteDelay = val
        SetBtn.Text = "✓ Updated!"
        task.delay(1, function() SetBtn.Text = "Set Update (abc)" end)
    else
        SetBtn.Text = "✗ Invalid!"
        task.delay(1.5, function() SetBtn.Text = "Set Update (abc)" end)
    end
end)

SetFastBtn.MouseButton1Click:Connect(function()
    local val = tonumber(FastBox.Text)
    if val and val > 0 then
        fastDelay = val
        SetFastBtn.Text = "✓ Updated!"
        task.delay(1, function() SetFastBtn.Text = "Set Update ({abc})" end)
    else
        SetFastBtn.Text = "✗ Invalid!"
        task.delay(1.5, function() SetFastBtn.Text = "Set Update ({abc})" end)
    end
end)

-- Переключатель формата (радио-кнопки)
local function setFormat(fmt)
    noteFormat = fmt
    if fmt == "PianoBlox" then
        PianoBloxBtn.Text = "PianoBlox ✓"
        PianoBloxBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
        PianoBloxBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
        PianoGlowBtn.Text = "PianoGlow ×"
        PianoGlowBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
        PianoGlowBtn.TextColor3 = Color3.fromRGB(180, 170, 210)
    else
        PianoGlowBtn.Text = "PianoGlow ✓"
        PianoGlowBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
        PianoGlowBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
        PianoBloxBtn.Text = "PianoBlox ×"
        PianoBloxBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
        PianoBloxBtn.TextColor3 = Color3.fromRGB(180, 170, 210)
    end
end

PianoBloxBtn.MouseButton1Click:Connect(function()
    setFormat("PianoBlox")
end)

PianoGlowBtn.MouseButton1Click:Connect(function()
    setFormat("PianoGlow")
end)

CopyLinkBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function() setclipboard(SONGS_LINK) end)
    if success then
        CopyLinkBtn.Text = "✓ Copied!"
        task.delay(1.5, function() CopyLinkBtn.Text = "Copy link songs" end)
    else
        CopyLinkBtn.Text = "✗ Error"
        task.delay(1.5, function() CopyLinkBtn.Text = "Copy link songs" end)
    end
end)

-- ==================== НИЖНИЕ ВКЛАДКИ ====================
local TabsBar = Instance.new("Frame")
TabsBar.Parent = MainFrame
TabsBar.BackgroundColor3 = Color3.fromRGB(15, 12, 35)
TabsBar.Position = UDim2.new(0, 0, 1, -46)
TabsBar.Size = UDim2.new(1, 0, 0, 46)
TabsBar.ZIndex = 2
Instance.new("UICorner", TabsBar).CornerRadius = UDim.new(0, 12)

local TabsLayout = Instance.new("UIListLayout", TabsBar)
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.Padding = UDim.new(0, 4)
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createTabButton(name, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 85, 0, 32)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 170, 210)
    btn.BackgroundColor3 = Color3.fromRGB(30, 22, 60)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = TabsBar
    btn.AutoButtonColor = false
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", btn).Color = Color3.fromRGB(80, 50, 150)

    btn.MouseButton1Click:Connect(function()
        InfoTab.Visible = false
        ExecutorTab.Visible = false
        SongsTab.Visible = false
        SettingsTab.Visible = false
        targetTab.Visible = true
        for _, child in pairs(TabsBar:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(30, 22, 60), TextColor3 = Color3.fromRGB(180, 170, 210) }):Play()
            end
        end
        TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(80, 40, 140), TextColor3 = Color3.fromRGB(255, 220, 100) }):Play()
        
        if targetTab == SongsTab then
            loadSongsList()
        end
    end)
    return btn
end

local infoTabBtn = createTabButton("Info", InfoTab)
local executorBtn = createTabButton("Executor", ExecutorTab)
local songsTabBtn = createTabButton("Songs", SongsTab)
local settingsTabBtn = createTabButton("Settings", SettingsTab)
executorBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
executorBtn.TextColor3 = Color3.fromRGB(255, 220, 100)

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 38), "Out", "Quad", 0.2, true)
        ContentFrame.Visible = false
        TabsBar.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 440, 0, 360), "Out", "Quad", 0.2, true)
        ContentFrame.Visible = true
        TabsBar.Visible = true
        MinimizeButton.Text = "—"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

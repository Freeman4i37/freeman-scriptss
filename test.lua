-- Freeman Music HUB - Modern Green UI Remake (PART 1: Setup & Main Structure)
local PRIMARY = Color3.fromRGB(32, 200, 84)
local SECONDARY = Color3.fromRGB(36, 44, 40)
local BG = Color3.fromRGB(20, 24, 20)
local WHITE = Color3.fromRGB(255,255,255)
local SHADOW = Color3.fromRGB(20, 32, 20)
local player = game:GetService("Players").LocalPlayer

local musicIDs = {
    ["1"] = 89907278904871,
    ["2"] = 99409598156364,
    ["3"] = 133900561957103,
    ["4"] = 93768636184697,
    ["5"] = 93218265275853,
    ["6"] = 140296674808875,
    ["7"] = 105770593501071,
    ["8"] = 16831105312,
    ["9"] = 87783857221289,
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local old = CoreGui:FindFirstChild("FreemanMusicUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "FreemanMusicUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Shadow effect for the main frame
local shadow = Instance.new("ImageLabel", gui)
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(0, 460, 0, 410)
shadow.Position = UDim2.new(0.5, -230, 0.5, -205)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 370)
frame.Position = UDim2.new(0.5, -210, 0.5, -185)
frame.BackgroundColor3 = BG
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
frame.ZIndex = 1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = PRIMARY
header.BorderSizePixel = 0
header.ZIndex = 2
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -56, 1, 0)
title.Position = UDim2.new(0, 22, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Freeman Music HUB"
title.TextColor3 = WHITE
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.ZIndex = 3

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 38, 1, 0)
close.Position = UDim2.new(1, -38, 0, 0)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 22
close.TextColor3 = WHITE
close.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
close.BorderSizePixel = 0
close.ZIndex = 3
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 14)

-- Sidebar with tab buttons
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 62, 1, -54)
sidebar.Position = UDim2.new(0, 0, 0, 54)
sidebar.BackgroundColor3 = SECONDARY
sidebar.ZIndex = 2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 13)

-- Tab system
local tabIcons = {"🎵", "🔢", "⚙️", "👤"}
local tabNames = {"Songs", "By ID", "Settings", "Credits"}
local tabs, tabFrames = {}, {}

for i, icon in ipairs(tabIcons) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -12, 0, 48)
    btn.Position = UDim2.new(0, 6, 0, 12 + (i-1)*60)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 28
    btn.TextColor3 = WHITE
    btn.BackgroundColor3 = (i==1) and PRIMARY or SECONDARY
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    tabs[tabNames[i]] = btn

    local f = Instance.new("Frame", frame)
    f.Name = tabNames[i].."Frame"
    f.Position = UDim2.new(0, 74, 0, 62)
    f.Size = UDim2.new(1, -82, 1, -74)
    f.BackgroundTransparency = 1
    f.Visible = (i==1)
    f.ZIndex = 2
    tabFrames[tabNames[i]] = f
end

for i, name in ipairs(tabNames) do
    tabs[name].MouseButton1Click:Connect(function()
        for j, f in pairs(tabFrames) do
            f.Visible = false
            tabs[j].BackgroundColor3 = SECONDARY
        end
        tabFrames[name].Visible = true
        tabs[name].BackgroundColor3 = PRIMARY
    end)
end

-- Freeman Music HUB - Modern Green UI Remake (PART 2: Songs Tab & Notifications)

-- Helper function for beautiful notifications
local function showNotification(text, duration)
    duration = duration or 3
    local notif = Instance.new("Frame", gui)
    notif.BackgroundColor3 = PRIMARY
    notif.Size = UDim2.new(0, 0, 0, 0)
    notif.Position = UDim2.new(0.5, 0, 0.1, 0)
    notif.AnchorPoint = Vector2.new(0.5, 0)
    notif.ZIndex = 100
    notif.BackgroundTransparency = 0
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 16)

    local label = Instance.new("TextLabel", notif)
    label.Size = UDim2.new(1, -24, 1, -16)
    label.Position = UDim2.new(0, 12, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = WHITE
    label.Font = Enum.Font.GothamBold
    label.TextSize = 17
    label.TextWrapped = true
    label.ZIndex = 101

    -- Animate in
    notif.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 280, 0, 50)}):Play()
    TweenService:Create(notif, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

    -- Wait and animate out
    delay(duration, function()
        TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(notif, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        wait(0.3)
        notif:Destroy()
    end)
end

-- SONGS TAB CONTENT
local songsFrame = tabFrames["Songs"]
local grid = Instance.new("UIGridLayout", songsFrame)
grid.CellSize = UDim2.new(0, 120, 0, 46)
grid.CellPadding = UDim2.new(0, 12, 0, 12)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

local soundFolder = workspace:FindFirstChild("FreemanClientSounds")
if not soundFolder then
    soundFolder = Instance.new("Folder", workspace)
    soundFolder.Name = "FreemanClientSounds"
end

for i = 1, 9 do
    local name = tostring(i)
    local id = musicIDs[name]
    local btn = Instance.new("TextButton", songsFrame)
    btn.Size = UDim2.new(0, 120, 0, 46)
    btn.Text = "Play ["..name.."]"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = WHITE
    btn.BackgroundColor3 = Color3.fromRGB(38, 60, 38)
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = PRIMARY}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(38, 60, 38)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        -- Play sound with animation
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s:Destroy() end
        end
        local s = Instance.new("Sound", soundFolder)
        s.SoundId = "rbxassetid://"..id
        s.Volume = 1
        s.Looped = false
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)

        -- Button animation feedback
        TweenService:Create(btn, TweenInfo.new(0.08), {TextSize = 15}):Play()
        wait(0.08)
        TweenService:Create(btn, TweenInfo.new(0.15), {TextSize = 18}):Play()
        showNotification("Now Playing: ["..name.."]", 2.5)
    end)
end

-- Freeman Music HUB - Modern Green UI Remake (PART 3: By ID Tab)

local byidFrame = tabFrames["By ID"]

local byidBox = Instance.new("TextBox", byidFrame)
byidBox.Size = UDim2.new(1, -30, 0, 46)
byidBox.Position = UDim2.new(0, 15, 0, 34)
byidBox.BackgroundColor3 = Color3.fromRGB(38, 60, 38)
byidBox.TextColor3 = WHITE
byidBox.PlaceholderText = "Enter Audio ID here..."
byidBox.Font = Enum.Font.GothamBold
byidBox.TextSize = 17
byidBox.Text = ""
byidBox.ClearTextOnFocus = false
byidBox.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", byidBox).CornerRadius = UDim.new(0, 10)

local playIdBtn = Instance.new("TextButton", byidFrame)
playIdBtn.Text = "PLAY"
playIdBtn.Size = UDim2.new(1, -30, 0, 42)
playIdBtn.Position = UDim2.new(0, 15, 0, 94)
playIdBtn.BackgroundColor3 = PRIMARY
playIdBtn.TextColor3 = WHITE
playIdBtn.Font = Enum.Font.GothamBold
playIdBtn.TextSize = 18
playIdBtn.AutoButtonColor = false
Instance.new("UICorner", playIdBtn).CornerRadius = UDim.new(0, 10)

playIdBtn.MouseEnter:Connect(function()
    TweenService:Create(playIdBtn, TweenInfo.new(0.17), {BackgroundColor3 = Color3.fromRGB(48, 230, 98)}):Play()
end)
playIdBtn.MouseLeave:Connect(function()
    TweenService:Create(playIdBtn, TweenInfo.new(0.17), {BackgroundColor3 = PRIMARY}):Play()
end)

playIdBtn.MouseButton1Click:Connect(function()
    local raw = byidBox.Text:gsub("rbxassetid://", "")
    local id = tonumber(raw)
    if id then
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s:Destroy() end
        end
        local s = Instance.new("Sound", soundFolder)
        s.SoundId = "rbxassetid://"..id
        s.Volume = 1
        s.Looped = false
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)

        -- Animated feedback
        TweenService:Create(playIdBtn, TweenInfo.new(0.09), {TextSize = 15}):Play()
        wait(0.09)
        TweenService:Create(playIdBtn, TweenInfo.new(0.16), {TextSize = 18}):Play()
        showNotification("Now Playing: " .. id, 2.5)
    else
        showNotification("Invalid Audio ID!", 2)
    end
end)

-- Freeman Music HUB - Modern Green UI Remake (PART 4: Settings Tab)

local settingsFrame = tabFrames["Settings"]

local loopToggle = false
local volume = 1

-- Loop Button
local loopBtn = Instance.new("TextButton", settingsFrame)
loopBtn.Text = "Loop: OFF"
loopBtn.Size = UDim2.new(1, -30, 0, 44)
loopBtn.Position = UDim2.new(0, 15, 0, 24)
loopBtn.BackgroundColor3 = Color3.fromRGB(38, 60, 38)
loopBtn.TextColor3 = WHITE
loopBtn.Font = Enum.Font.GothamBold
loopBtn.TextSize = 16
loopBtn.AutoButtonColor = false
Instance.new("UICorner", loopBtn).CornerRadius = UDim.new(0, 10)

loopBtn.MouseEnter:Connect(function()
    TweenService:Create(loopBtn, TweenInfo.new(0.17), {BackgroundColor3 = PRIMARY}):Play()
end)
loopBtn.MouseLeave:Connect(function()
    TweenService:Create(loopBtn, TweenInfo.new(0.17), {BackgroundColor3 = Color3.fromRGB(38, 60, 38)}):Play()
end)
loopBtn.MouseButton1Click:Connect(function()
    loopToggle = not loopToggle
    loopBtn.Text = "Loop: " .. (loopToggle and "ON" or "OFF")
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s.Looped = loopToggle
        end
    end
    showNotification("Loop " .. (loopToggle and "enabled" or "disabled") .. "!", 1.5)
end)

-- Stop Button
local stopBtn = Instance.new("TextButton", settingsFrame)
stopBtn.Text = "STOP ALL"
stopBtn.Size = UDim2.new(1, -30, 0, 44)
stopBtn.Position = UDim2.new(0, 15, 0, 80)
stopBtn.BackgroundColor3 = Color3.fromRGB(60,30,30)
stopBtn.TextColor3 = WHITE
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 16
stopBtn.AutoButtonColor = false
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 10)

stopBtn.MouseEnter:Connect(function()
    TweenService:Create(stopBtn, TweenInfo.new(0.17), {BackgroundColor3 = Color3.fromRGB(200,60,60)}):Play()
end)
stopBtn.MouseLeave:Connect(function()
    TweenService:Create(stopBtn, TweenInfo.new(0.17), {BackgroundColor3 = Color3.fromRGB(60,30,30)}):Play()
end)
stopBtn.MouseButton1Click:Connect(function()
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then s:Destroy() end
    end
    showNotification("All sounds stopped.", 1.2)
end)

-- Volume Slider (simple stepper, since Roblox GUIs don't have native sliders)
local volumeLabel = Instance.new("TextLabel", settingsFrame)
volumeLabel.Text = "Volume: " .. tostring(volume)
volumeLabel.Size = UDim2.new(0.6, -10, 0, 32)
volumeLabel.Position = UDim2.new(0, 15, 0, 138)
volumeLabel.BackgroundTransparency = 1
volumeLabel.TextColor3 = WHITE
volumeLabel.Font = Enum.Font.Gotham
volumeLabel.TextSize = 15
volumeLabel.TextXAlignment = Enum.TextXAlignment.Left

local volMinus = Instance.new("TextButton", settingsFrame)
volMinus.Text = "-"
volMinus.Size = UDim2.new(0, 34, 0, 32)
volMinus.Position = UDim2.new(0.6, 10, 0, 138)
volMinus.BackgroundColor3 = PRIMARY
volMinus.TextColor3 = WHITE
volMinus.Font = Enum.Font.GothamBold
volMinus.TextSize = 22
Instance.new("UICorner", volMinus).CornerRadius = UDim.new(0, 8)

local volPlus = Instance.new("TextButton", settingsFrame)
volPlus.Text = "+"
volPlus.Size = UDim2.new(0, 34, 0, 32)
volPlus.Position = UDim2.new(0.6, 50, 0, 138)
volPlus.BackgroundColor3 = PRIMARY
volPlus.TextColor3 = WHITE
volPlus.Font = Enum.Font.GothamBold
volPlus.TextSize = 22
Instance.new("UICorner", volPlus).CornerRadius = UDim.new(0, 8)

volMinus.MouseButton1Click:Connect(function()
    if volume > 0.1 then
        volume = math.max(0.1, volume - 0.1)
        volume = math.floor(volume*10)/10
        volumeLabel.Text = "Volume: " .. tostring(volume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Volume = volume end
        end
        showNotification("Volume: " .. tostring(volume), 0.8)
    end
end)
volPlus.MouseButton1Click:Connect(function()
    if volume < 2 then
        volume = math.min(2, volume + 0.1)
        volume = math.floor(volume*10)/10
        volumeLabel.Text = "Volume: " .. tostring(volume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Volume = volume end
        end
        showNotification("Volume: " .. tostring(volume), 0.8)
    end
end)

-- Freeman Music HUB - Modern Green UI Remake (PART 5: Credits Tab)

local creditsFrame = tabFrames["Credits"]

local creditsTitle = Instance.new("TextLabel", creditsFrame)
creditsTitle.Size = UDim2.new(1, 0, 0, 38)
creditsTitle.Position = UDim2.new(0, 0, 0.25, 0)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "Credits"
creditsTitle.TextColor3 = PRIMARY
creditsTitle.Font = Enum.Font.FredokaOne
creditsTitle.TextSize = 28
creditsTitle.TextWrapped = true
creditsTitle.TextXAlignment = Enum.TextXAlignment.Center

local creditsAuthor = Instance.new("TextLabel", creditsFrame)
creditsAuthor.Size = UDim2.new(1, 0, 0, 25)
creditsAuthor.Position = UDim2.new(0, 0, 0.25, 42)
creditsAuthor.BackgroundTransparency = 1
creditsAuthor.Text = "Made by Freeman4i37"
creditsAuthor.TextColor3 = WHITE
creditsAuthor.Font = Enum.Font.GothamBold
creditsAuthor.TextSize = 22
creditsAuthor.TextWrapped = true
creditsAuthor.TextXAlignment = Enum.TextXAlignment.Center

local creditsDesc = Instance.new("TextLabel", creditsFrame)
creditsDesc.Size = UDim2.new(1, -30, 0, 70)
creditsDesc.Position = UDim2.new(0, 15, 0.25, 74)
creditsDesc.BackgroundTransparency = 1
creditsDesc.Text = "A modern, animated music GUI for Roblox.\nThank you for using this script!"
creditsDesc.TextColor3 = PRIMARY
creditsDesc.Font = Enum.Font.Gotham
creditsDesc.TextSize = 16
creditsDesc.TextWrapped = true
creditsDesc.TextXAlignment = Enum.TextXAlignment.Center
creditsDesc.TextYAlignment = Enum.TextYAlignment.Top

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

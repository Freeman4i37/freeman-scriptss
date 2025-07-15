local musicIDs = {
    ["1"] = 89907278904871,
    ["2"] = 99409598156364,
    ["3"] = 133900561957103,
    ["4"] = 93768636184697,
    ["5"] = 93218265275853,
    ["6"] = 16831105312,
    ["7"] = 87783857221289,
    ["8"] = 80164463388144,
}

local musicNames = {
    ["1"] = "Funk da Praia",
    ["2"] = "Retrolam Funk",
    ["3"] = "Trash Funk",
    ["4"] = "2609 (Jersey Club)",
    ["5"] = "NewJeans (Jersey Club)",
    ["6"] = "Shake That Thing",
    ["7"] = "Temptation",
    ["8"] = "One Two Step (Jersey Club)",
}

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local soundFolder = workspace:FindFirstChild("FreemanClientSounds")
if not soundFolder then
    soundFolder = Instance.new("Folder")
    soundFolder.Name = "FreemanClientSounds"
    soundFolder.Parent = workspace
end

local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FreemanMusicUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local musicListBtnClicked = false
local isClientAudio = false
local isLoop = false
local currentVolume = 1
local currentPitch = 1

local function stopAllClientSounds()
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s:Stop()
            s:Destroy()
        end
    end
end

local function playClientAudio(id, parent)
    stopAllClientSounds()
    local sound = Instance.new("Sound", parent or soundFolder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Pitch = currentPitch
    sound.Name = tostring(id)
    sound:Play()
    return sound
end

local function destroyAllNotificationBlocks()
    for _, guiObj in ipairs(game:GetService("CoreGui"):GetChildren()) do
        if guiObj:IsA("ScreenGui") or guiObj:IsA("Frame") then
            for _, frame in ipairs(guiObj:GetDescendants()) do
                if frame.Name == "block" or (frame:IsA("Frame") and frame.ZIndex == 10000) then
                    pcall(function() frame:Destroy() end)
                end
            end
        end
    end
end

local function showSelectorPopup(titleText, options, callback)
    if gui:FindFirstChild("SelectorPopup") then gui.SelectorPopup:Destroy() end
    if gui:FindFirstChild("SelectorPopupBlock") then gui.SelectorPopupBlock:Destroy() end

    local block = Instance.new("Frame", gui)
    block.Name = "SelectorPopupBlock"
    block.Size = UDim2.new(1,0,1,0)
    block.BackgroundTransparency = 0.35
    block.BackgroundColor3 = Color3.fromRGB(0,0,0)
    block.ZIndex = 19999
    block.Active = true

    local popup = Instance.new("Frame", gui)
    popup.Name = "SelectorPopup"
    popup.Size = UDim2.new(0, 330, 0, 130)
    popup.Position = UDim2.new(0.5, -165, 0.5, -65)
    popup.BackgroundColor3 = Color3.fromRGB(25,25,25)
    popup.BorderSizePixel = 0
    popup.ZIndex = 20000
    popup.Active = true
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -16, 0, 32)
    title.Position = UDim2.new(0,8,0,7)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 20001

    local btnCount = #options
    local btnW = math.floor((298-(btnCount-1)*7)/btnCount)
    for i, opt in ipairs(options) do
        local btn = Instance.new("TextButton", popup)
        btn.Size = UDim2.new(0, btnW, 0, 38)
        btn.Position = UDim2.new(0, 16+((btnW+7)*(i-1)), 0, 50)
        btn.Text = tostring(opt)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.ZIndex = 20001
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(function()
            popup:Destroy()
            block:Destroy()
            if callback then callback(opt) end
        end)
    end
end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 360)
frame.Position = UDim2.new(1, -355, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
frame.BackgroundTransparency = 0

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Freeman HUB 🎵 6.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 35, 1, 0)
minimize.Position = UDim2.new(1, -70, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 12)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 35, 1, 0)
close.Position = UDim2.new(1, -35, 0, 0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 12)

local sideBar = Instance.new("Frame", frame)
sideBar.Size = UDim2.new(0, 44, 1, -35)
sideBar.Position = UDim2.new(1, -44, 0, 35)
sideBar.BackgroundTransparency = 1

local iconBtnY = 8
local iconBtnDelta = 50

local function makeIconBtn(parent, icon, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -8, 0, 36)
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 24
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.BorderSizePixel = 0
    return btn
end

local musicListBtn = makeIconBtn(sideBar, "📜", iconBtnY)
local settingsButton = makeIconBtn(sideBar, "⚙️", iconBtnY + iconBtnDelta*1)
local modeButton = makeIconBtn(sideBar, isClientAudio and "❎" or "✅", iconBtnY + iconBtnDelta*2)
local creditsButton = makeIconBtn(sideBar, "👤", iconBtnY + iconBtnDelta*3)

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 24
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Active = true
openIcon.Draggable = true

local mainFrame = Instance.new("ScrollingFrame", frame)
mainFrame.Position = UDim2.new(0, 0, 0, 35)
mainFrame.Size = UDim2.new(1, -44, 1, -110)
mainFrame.BackgroundTransparency = 1
mainFrame.CanvasSize = UDim2.new(0,0,0,0)
mainFrame.ScrollBarThickness = 6
mainFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local grid = Instance.new("UIGridLayout", mainFrame)
grid.CellSize = UDim2.new(0, 100, 0, 40)
grid.CellPadding = UDim2.new(0, 10, 0, 10)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

local creditsFrame = Instance.new("Frame", frame)
creditsFrame.Position = UDim2.new(0, 0, 0, 35)
creditsFrame.Size = UDim2.new(1, -44, 1, -110)
creditsFrame.BackgroundTransparency = 1
creditsFrame.Visible = false

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 1, -20)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.Text = "Made by Freeman4i37!\nThe best Roblox music GUI!\nThank you for using my script."
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextColor3 = Color3.fromRGB(255,255,255)
creditsLabel.TextSize = 14
creditsLabel.TextWrapped = true
creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
creditsLabel.BackgroundTransparency = 1

-- MUSIC LIST PANEL (LISTADO VERTICAL)
local musicListFrame = Instance.new("Frame", frame)
musicListFrame.Position = UDim2.new(0, 0, 0, 35)
musicListFrame.Size = UDim2.new(1, -44, 1, -110)
musicListFrame.BackgroundTransparency = 1
musicListFrame.Visible = false

local musicScroll = Instance.new("ScrollingFrame", musicListFrame)
musicScroll.Size = UDim2.new(1, 0, 1, 0)
musicScroll.Position = UDim2.new(0, 0, 0, 0)
musicScroll.BackgroundTransparency = 1
musicScroll.CanvasSize = UDim2.new(0,0,0,0)
musicScroll.ScrollBarThickness = 6
musicScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
musicScroll.Name = "musicScroll"

local musicListLayout = Instance.new("UIListLayout", musicScroll)
musicListLayout.Padding = UDim.new(0,8)
musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Only valid indices
for _, k in ipairs({"1","2","3","4","5","6","7","8"}) do
    local lbl = Instance.new("TextLabel", musicScroll)
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Text = "["..k.."] - "..musicNames[k]
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local settingsFrame = Instance.new("Frame", frame)
settingsFrame.Position = UDim2.new(0, 0, 0, 35)
settingsFrame.Size = UDim2.new(1, -44, 1, -110)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false

local muteBoomboxButton = Instance.new("TextButton", settingsFrame)
muteBoomboxButton.Size = UDim2.new(1, 0, 0, 40)
muteBoomboxButton.Position = UDim2.new(0, 0, 0, 10)
muteBoomboxButton.Text = "Mute All Boomboxes"
muteBoomboxButton.Font = Enum.Font.GothamBold
muteBoomboxButton.TextSize = 16
muteBoomboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteBoomboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteBoomboxButton).CornerRadius = UDim.new(0, 10)

local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(1, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0, 0, 0, 60)
muteGameSoundsButton.Text = "Mute All GameSounds"
muteGameSoundsButton.Font = Enum.Font.GothamBold
muteGameSoundsButton.TextSize = 16
muteGameSoundsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteGameSoundsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteGameSoundsButton).CornerRadius = UDim.new(0, 10)

local buttons = {}
for _, name in ipairs({"1", "2", "3", "4", "5", "6", "7", "8"}) do
    local id = musicIDs[name]
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.Parent = mainFrame
    btn.MouseButton1Click:Connect(function()
        if isClientAudio then
            playClientAudio(id)
        else
            if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                local args = { [1] = "PlaySong", [2] = id }
                pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
            else
                warn("Radio or Remote not found!")
            end
        end
        -- NÃO MOSTRA "Now Playing:" aqui!
    end)
    table.insert(buttons, btn)
end

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainFrame.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    settingsFrame.Visible = false
end)

local inputBox = Instance.new("TextBox", frame)
inputBox.PlaceholderText = "Audio ID here..."
inputBox.Size = UDim2.new(0.6, -10, 0, 35)
inputBox.Position = UDim2.new(0, 10, 1, -70)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

local playButton = Instance.new("TextButton", frame)
playButton.Text = "PLAY"
playButton.Size = UDim2.new(0.4, -10, 0, 35)
playButton.Position = UDim2.new(0.6, 0, 1, -70)
playButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.Font = Enum.Font.GothamBold
playButton.TextSize = 18
Instance.new("UICorner", playButton).CornerRadius = UDim.new(0, 10)

playButton.MouseButton1Click:Connect(function()
    local input = inputBox.Text:gsub("rbxassetid://", "")
    local id = tonumber(input)
    local foundName = nil
    for num, audioId in pairs(musicIDs) do
        if audioId == id then
            foundName = musicNames[num]
            break
        end
    end
    if id then
        local nameGot = foundName or ("Audio " .. id)
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(id)
        end)
        if success and info and info.Name and not foundName then
            nameGot = info.Name
        end
        if isClientAudio then
            playClientAudio(id)
        else
            if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                local args = { [1] = "PlaySong", [2] = id }
                pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
            else
                warn("Radio or Remote not found!")
            end
        end
        showAchievementBar("Now Playing: " .. nameGot, 6)
    else
        warn("INVALID ID")
    end
end)

local loopButton = Instance.new("TextButton", frame)
loopButton.Text = "Loop: NO"
loopButton.Size = UDim2.new(0, 70, 0, 25)
loopButton.Position = UDim2.new(0, 10, 1, -35)
loopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
loopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loopButton.Font = Enum.Font.GothamBold
loopButton.TextSize = 12
Instance.new("UICorner", loopButton).CornerRadius = UDim.new(0, 10)
loopButton.Visible = false

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "Stop"
stopButton.Size = UDim2.new(0, 70, 0, 25)
stopButton.Position = UDim2.new(0, 90, 1, -35)
stopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 12
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0, 10)
stopButton.Visible = false

local volumeButton = Instance.new("TextButton", frame)
volumeButton.Text = "Vol: 1"
volumeButton.Size = UDim2.new(0, 70, 0, 25)
volumeButton.Position = UDim2.new(0, 170, 1, -35)
volumeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
volumeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
volumeButton.Font = Enum.Font.GothamBold
volumeButton.TextSize = 12
Instance.new("UICorner", volumeButton).CornerRadius = UDim.new(0, 10)
volumeButton.Visible = false

local pitchButton = Instance.new("TextButton", frame)
pitchButton.Text = "Pitch: 1"
pitchButton.Size = UDim2.new(0, 70, 0, 25)
pitchButton.Position = UDim2.new(0, 250, 1, -35)
pitchButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pitchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
pitchButton.Font = Enum.Font.GothamBold
pitchButton.TextSize = 12
Instance.new("UICorner", pitchButton).CornerRadius = UDim.new(0, 10)
pitchButton.Visible = false

loopButton.MouseButton1Click:Connect(function()
    isLoop = not isLoop
    loopButton.Text = isLoop and "Loop: YES" or "Loop: NO"
end)

stopButton.MouseButton1Click:Connect(function()
    stopAllClientSounds()
end)

volumeButton.MouseButton1Click:Connect(function()
    showSelectorPopup("CHOOSE THE VOLUME", {0.5,0.75,1.0,1.5,2.0,4.0,6.0}, function(vol)
        currentVolume = vol
        volumeButton.Text = "Vol: " .. tostring(currentVolume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then
                s.Volume = currentVolume
            end
        end
    end)
end)

pitchButton.MouseButton1Click:Connect(function()
    showSelectorPopup("CHOOSE THE PITCH", {0.75,1.0,1.5,2.0}, function(pitch)
        currentPitch = pitch
        pitchButton.Text = "Pitch: " .. tostring(currentPitch)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then
                s.Pitch = currentPitch
            end
        end
    end)
end)

modeButton.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    modeButton.Text = isClientAudio and "❎" or "✅"
    loopButton.Visible = isClientAudio
    stopButton.Visible = isClientAudio
    volumeButton.Visible = isClientAudio
    pitchButton.Visible = isClientAudio
end)

local inCredits = false
creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainFrame.Visible = not inCredits
    creditsFrame.Visible = inCredits
    musicListFrame.Visible = false
    settingsFrame.Visible = false
end)

local inSettings = false
settingsButton.MouseButton1Click:Connect(function()
    inSettings = not inSettings
    mainFrame.Visible = not inSettings
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    settingsFrame.Visible = inSettings
    muteBoomboxButton.Text = boomboxMuted and "Unmute All Boomboxes" or "Mute All Boomboxes"
    muteGameSoundsButton.Text = gameSoundsMuted and "Unmute All GameSounds" or "Mute All GameSounds"
end)

local boomboxMuted = false
muteBoomboxButton.MouseButton1Click:Connect(function()
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player and plr.Character then
            local radio = plr.Character:FindFirstChild("Radio")
            if radio then
                for _, s in ipairs(radio:GetDescendants()) do
                    if s:IsA("Sound") then
                        s.Volume = not boomboxMuted and 0 or 1
                    end
                end
            end
        end
    end
    boomboxMuted = not boomboxMuted
    muteBoomboxButton.Text = boomboxMuted and "Unmute All Boomboxes" or "Mute All Boomboxes"
end)

local gameSoundsMuted = false
local muteGameSoundsConn

local function isMyBoombox(sound)
    if sound:IsDescendantOf(soundFolder) then return true end
    if player.Character then
        local radio = player.Character:FindFirstChild("Radio")
        if radio and sound:IsDescendantOf(radio) then return true end
    end
    return false
end

local function setGameSoundsMuted(mute)
    if mute and not muteGameSoundsConn then
        muteGameSoundsConn = runService.RenderStepped:Connect(function()
            for _, s in ipairs(workspace:GetDescendants()) do
                if s:IsA("Sound") and not isMyBoombox(s) then s.Volume = 0 end
            end
            for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
                if s:IsA("Sound") then s.Volume = 0 end
            end
        end)
    elseif not mute and muteGameSoundsConn then
        muteGameSoundsConn:Disconnect()
        muteGameSoundsConn = nil
        for _, s in ipairs(workspace:GetDescendants()) do
            if s:IsA("Sound") and not isMyBoombox(s) then s.Volume = 1 end
        end
        for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 1 end
        end
    end
    gameSoundsMuted = mute
    muteGameSoundsButton.Text = mute and "Unmute All GameSounds" or "Mute All GameSounds"
end

muteGameSoundsButton.MouseButton1Click:Connect(function()
    setGameSoundsMuted(not gameSoundsMuted)
end)

minimize.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -355, 0.5, -280)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(1, -355, 0.5, -280)
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(1, -355, 0.5, -180)})
    tween:Play()
end)

close.MouseButton1Click:Connect(function()
    destroyAllNotificationBlocks()
    gui:Destroy()
    if soundFolder then soundFolder:Destroy() end
    if muteGameSoundsConn then muteGameSoundsConn:Disconnect() muteGameSoundsConn = nil end
end)

function showAchievementBar(text, duration)
    local bar = Instance.new("Frame", gui)
    bar.Size = UDim2.new(0, 250, 0, 45)
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    bar.BackgroundTransparency = 0.2
    bar.BorderSizePixel = 0
    bar.AnchorPoint = Vector2.new(0,0)
    local uicorner = Instance.new("UICorner", bar)
    uicorner.CornerRadius = UDim.new(0, 12)
    local label = Instance.new("TextLabel", bar)
    label.Size = UDim2.new(1, -16, 1, -12)
    label.Position = UDim2.new(0, 8, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundTransparency = 1
    label.TextTransparency = 1
    local tweenIn = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 0, 18), BackgroundTransparency = 0.2})
    local tweenLabelIn = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 0})
    tweenIn:Play()
    tweenLabelIn:Play()
    tweenIn.Completed:Wait()
    wait(duration or 5)
    local tweenOut = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 0, -50), BackgroundTransparency = 1})
    local tweenLabelOut = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 1})
    tweenOut:Play()
    tweenLabelOut:Play()
    tweenOut.Completed:Wait()
    bar:Destroy()
end

coroutine.wrap(function()
    showAchievementBar("Welcome to Freeman HUB 6.0!\nScript by Freeman4i37.",4)
end)()
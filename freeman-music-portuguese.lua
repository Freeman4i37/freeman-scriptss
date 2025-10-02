local orange = Color3.fromRGB(255,140,0)
local white = Color3.fromRGB(255,255,255)
local darkBg = Color3.fromRGB(15,15,15)
local accentBg = Color3.fromRGB(30,30,30)

local musicIDs = {
    ["1"] = 94718473830640, ["2"] = 92209428926055, ["3"] = 133900561957103, ["4"] = 93768636184697,
    ["5"] = 92062588329352, ["6"] = 84773737820526, ["7"] = 87783857221289, ["8"] = 88342296270082,
    ["9"] = 85342086082111, ["10"] = 93058983119992, ["11"] = 92492039534399, ["12"] = 134035788881796,
    ["13"] = 18841893567, ["14"] = 73962723234161, ["15"] = 140268583413209, ["16"] = 77741294709660, ["17"] = 71531533552899, ["18"] = 16190782181, ["19"] = 117169209277972, ["20"] = 81299332131868, ["21"] = 77147911349059, ["22"] = 124092830839928, ["23"] = 122854357582130, ["24"] = 88094479399489, ["25"] = 88339486019486, ["26"] = 97765714111493, ["27"] = 92446612272052, ["28"] = 74366765967475, ["29"] = 112068892721408,
}
local musicNames = {
    ["1"] = "Funk da Febre", ["2"] = "Switch The Colors (Jersey Club)", ["3"] = "Trash Funk",
    ["4"] = "2609 (Jersey Club)", ["5"] = "Spooky Scary Sunday (Jersey Club)", ["6"] = "ANOTE AÍ",
    ["7"] = "Temptation", ["8"] = "Ela Tano", ["9"] = "Seu fã",
    ["10"] = "MONTAGEM ECLIPSE ESTRELAR", ["11"] = "Em Dezembro de 81 - Flamengo",
    ["12"] = "Esquema Confirmado - Arrocha", ["13"] = "JERSEY WAVE", ["14"] = "Arrepia XL 2", ["15"] = "Meepcity (Jersey Club)", ["16"] = "Manda Meu Passinho", ["17"] = "Lembro até hoje", ["18"] = "HR - EEYUH!", ["19"] = "I love ha", ["20"] = "SHE DON'T - Lonelybwoi", ["21"] = "NY Drill Ritual", ["22"] = "It Doesn't Matter (Jersey Club)", ["23"] = "69 PHONK", ["24"] = "Ela se envolveu", ["25"] = "Montagem Pose", ["26"] = "Trem Fantasma Funk", ["27"] = "MTG ZUM ZUM ZUM", ["28"] = "EU NÃO ESTOU LOUCO", ["29"] = "FUNK DA PRAIA (SLOWED)",
}

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local soundFolder = workspace:FindFirstChild("FreemanClientSounds") or Instance.new("Folder", workspace)
soundFolder.Name = "FreemanClientSounds"
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanMusicHub"
screenGui.ResetOnSpawn = false
local parentUi = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
screenGui.Parent = parentUi

local mainFrame = Instance.new("Frame")
mainFrame.Name = "FreemanMusicMain"
mainFrame.Size = UDim2.new(0, 360, 0, 470)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = darkBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = orange
mainStroke.Thickness = 2
mainStroke.Transparency = 0.7

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundTransparency = 1
header.Position = UDim2.new(0,0,0,0)
header.Name = "Header"
header.ZIndex = 2

-- Pumpkin icon and Halloween Update label
local pumpkinIcon = Instance.new("TextLabel", header)
pumpkinIcon.Text = "🎃"
pumpkinIcon.Font = Enum.Font.GothamBlack
pumpkinIcon.TextSize = 34
pumpkinIcon.TextColor3 = orange
pumpkinIcon.Size = UDim2.new(0, 44, 0, 44)
pumpkinIcon.Position = UDim2.new(0, 0, 0, 0)
pumpkinIcon.BackgroundTransparency = 1

local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Freeman Hub - Música"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 17
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -90, 0, 28)
headerTitle.Position = UDim2.new(0, 44, 0, 0)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

local halloweenUpdate = Instance.new("TextLabel", header)
halloweenUpdate.Text = "Atualização de Halloween!"
halloweenUpdate.Font = Enum.Font.GothamBold
halloweenUpdate.TextSize = 17
halloweenUpdate.TextColor3 = orange
halloweenUpdate.BackgroundTransparency = 1
halloweenUpdate.Size = UDim2.new(1, -90, 0, 24)
halloweenUpdate.Position = UDim2.new(0, 44, 0, 28)
halloweenUpdate.TextXAlignment = Enum.TextXAlignment.Left

local divider = Instance.new("Frame", mainFrame)
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 0, 52)
divider.BackgroundColor3 = orange
divider.BorderSizePixel = 0
local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, white),
    ColorSequenceKeypoint.new(1, orange)
})

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -44, 0, 8)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = orange
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = orange
closeBtnStroke.Thickness = 1.25
closeBtnStroke.Transparency = 0.7

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 36, 0, 36)
minimizeBtn.Position = UDim2.new(1, -88, 0, 8)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = orange
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local minimizeBtnStroke = Instance.new("UIStroke", minimizeBtn)
minimizeBtnStroke.Color = orange
minimizeBtnStroke.Thickness = 1.25
minimizeBtnStroke.Transparency = 0.7

local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 44, 1, -64)
sideBar.Position = UDim2.new(1, -44, 0, 54)
sideBar.BackgroundTransparency = 1
sideBar.ZIndex = 2

local function makeIconBtn(parent, icon, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -8, 0, 36)
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 25
    btn.TextColor3 = orange
    btn.BackgroundColor3 = accentBg
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = orange
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orange btn.TextColor3 = darkBg end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = orange end)
    return btn
end

local yDelta = 0
local musicListBtn = makeIconBtn(sideBar, "📜", yDelta)
local settingsButton = makeIconBtn(sideBar, "⚙️", yDelta+50)
local modeButton = makeIconBtn(sideBar, "🎵", yDelta+100)
local creditsButton = makeIconBtn(sideBar, "👤", yDelta+150)

local mainScroll = Instance.new("ScrollingFrame", mainFrame)
mainScroll.Position = UDim2.new(0, 12, 0, 64)
mainScroll.Size = UDim2.new(1, -68, 1, -138)
mainScroll.BackgroundTransparency = 1
mainScroll.CanvasSize = UDim2.new(0,0,0,0)
mainScroll.ScrollBarThickness = 7
mainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainScroll.ZIndex = 2

local grid = Instance.new("UIGridLayout", mainScroll)
grid.CellSize = UDim2.new(0, 105, 0, 44)
grid.CellPadding = UDim2.new(0, 10, 0, 10)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

local isClientAudio = false
local isLoop = false
local currentVolume = 1
local currentPitch = 1
local playingSound

local function stopAllClientSounds()
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s:Stop()
            s:Destroy()
        end
    end
    playingSound = nil
end

local function playClientAudio(id)
    stopAllClientSounds()
    local sound = Instance.new("Sound", soundFolder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Pitch = currentPitch
    sound.Name = tostring(id)
    sound:Play()
    playingSound = sound
    return sound
end

local function findBoomboxRemotes()
    local remotes = {}
    if player.Character then
        for _, obj in ipairs(player.Character:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                table.insert(remotes, obj)
            end
        end
    end
    return remotes
end

local function tryPlayBoombox(remotes, audioId)
    for _, remote in ipairs(remotes) do
        local argsList = {
            {audioId},
            {"PlaySong", audioId},
            {"Play", audioId},
            {audioId, true},
        }
        for _, args in ipairs(argsList) do
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(unpack(args))
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(unpack(args))
                end
            end)
        end
    end
end

for i = 1, 29 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 105, 0, 44)
    btn.Text = tostring(i)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = orange
    btn.BackgroundColor3 = accentBg
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = orange
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orange btn.TextColor3 = darkBg end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = orange end)
    btn.Parent = mainScroll
    btn.MouseButton1Click:Connect(function()
        local id = musicIDs[tostring(i)]
        if isClientAudio then
            playClientAudio(id)
        else
            local remotes = findBoomboxRemotes()
            if #remotes > 0 then
                tryPlayBoombox(remotes, id)
            else
                warn("Nenhum Remote de Boombox encontrado!")
            end
        end
    end)
end

local function makeSubFrame()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -68, 1, -138)
    f.Position = UDim2.new(0, 12, 0, 64)
    f.BackgroundColor3 = darkBg
    f.BackgroundTransparency = 0
    f.Visible = false
    f.ZIndex = 3
    Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", f)
    stroke.Color = orange
    stroke.Thickness = 1.25
    stroke.Transparency = 0.7
    return f
end

local creditsFrame = makeSubFrame()
creditsFrame.Parent = mainFrame
local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -16, 1, -16)
creditsLabel.Position = UDim2.new(0, 8, 0, 8)
creditsLabel.Text = "Feito por Freeman4i37\nObrigado por usar o script.\n🎃"
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextColor3 = orange
creditsLabel.TextSize = 16
creditsLabel.BackgroundTransparency = 1
creditsLabel.ZIndex = 3

local musicListFrame = makeSubFrame()
musicListFrame.Parent = mainFrame
local musicScroll = Instance.new("ScrollingFrame", musicListFrame)
musicScroll.Size = UDim2.new(1, 0, 1, 0)
musicScroll.BackgroundTransparency = 1
musicScroll.CanvasSize = UDim2.new(0,0,0,0)
musicScroll.ScrollBarThickness = 6
musicScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
musicScroll.Name = "musicScroll"
musicScroll.ZIndex = 4
local musicListLayout = Instance.new("UIListLayout", musicScroll)
musicListLayout.Padding = UDim.new(0,8)
musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder
for k = 1, 29 do
    local lbl = Instance.new("TextLabel", musicScroll)
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Text = "["..k.."] - "..musicNames[tostring(k)]
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = orange
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
end

local settingsFrame = makeSubFrame()
settingsFrame.Parent = mainFrame

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.PlaceholderText = "Coloque o ID aqui..."
inputBox.Size = UDim2.new(0.62, -10, 0, 36)
inputBox.Position = UDim2.new(0, 14, 1, -80)
inputBox.BackgroundColor3 = accentBg
inputBox.TextColor3 = orange
inputBox.PlaceholderColor3 = Color3.fromRGB(200,200,200)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 15
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
inputBox.ZIndex = 4
inputBox.AutoLocalize = false
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(1, 0)
local inputBoxStroke = Instance.new("UIStroke", inputBox)
inputBoxStroke.Color = orange
inputBoxStroke.Thickness = 1.25
inputBoxStroke.Transparency = 0.7

local playBtn = Instance.new("TextButton", mainFrame)
playBtn.Text = "TOCAR"
playBtn.Size = UDim2.new(0.36, -10, 0, 36)
playBtn.Position = UDim2.new(0.62, 0, 1, -80)
playBtn.BackgroundColor3 = accentBg
playBtn.TextColor3 = orange
playBtn.Font = Enum.Font.GothamBold
playBtn.TextSize = 16
playBtn.ZIndex = 4
playBtn.AutoButtonColor = true
Instance.new("UICorner", playBtn).CornerRadius = UDim.new(1, 0)
local playBtnStroke = Instance.new("UIStroke", playBtn)
playBtnStroke.Color = orange
playBtnStroke.Thickness = 1.25
playBtnStroke.Transparency = 0.7
playBtn.MouseEnter:Connect(function() playBtn.BackgroundColor3 = orange playBtn.TextColor3 = darkBg end)
playBtn.MouseLeave:Connect(function() playBtn.BackgroundColor3 = accentBg playBtn.TextColor3 = orange end)

local loopButton = Instance.new("TextButton", mainFrame)
loopButton.Text = "Loop: NÃO"
loopButton.Size = UDim2.new(0, 70, 0, 25)
loopButton.Position = UDim2.new(0, 10, 1, -44)
loopButton.BackgroundColor3 = accentBg
loopButton.TextColor3 = orange
loopButton.Font = Enum.Font.GothamBold
loopButton.TextSize = 12
loopButton.ZIndex = 4
loopButton.Visible = false
loopButton.AutoButtonColor = true
Instance.new("UICorner", loopButton).CornerRadius = UDim.new(1, 0)
local loopBtnStroke = Instance.new("UIStroke", loopButton)
loopBtnStroke.Color = orange
loopBtnStroke.Thickness = 1.25
loopBtnStroke.Transparency = 0.7

local stopButton = Instance.new("TextButton", mainFrame)
stopButton.Text = "Parar"
stopButton.Size = UDim2.new(0, 70, 0, 25)
stopButton.Position = UDim2.new(0, 90, 1, -44)
stopButton.BackgroundColor3 = accentBg
stopButton.TextColor3 = orange
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 12
stopButton.ZIndex = 4
stopButton.Visible = false
stopButton.AutoButtonColor = true
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(1, 0)
local stopBtnStroke = Instance.new("UIStroke", stopButton)
stopBtnStroke.Color = orange
stopBtnStroke.Thickness = 1.25
stopBtnStroke.Transparency = 0.7

local volumeButton = Instance.new("TextButton", mainFrame)
volumeButton.Text = "Vol: 1"
volumeButton.Size = UDim2.new(0, 70, 0, 25)
volumeButton.Position = UDim2.new(0, 170, 1, -44)
volumeButton.BackgroundColor3 = accentBg
volumeButton.TextColor3 = orange
volumeButton.Font = Enum.Font.GothamBold
volumeButton.TextSize = 12
volumeButton.ZIndex = 4
volumeButton.Visible = false
volumeButton.AutoButtonColor = true
Instance.new("UICorner", volumeButton).CornerRadius = UDim.new(1, 0)
local volumeBtnStroke = Instance.new("UIStroke", volumeButton)
volumeBtnStroke.Color = orange
volumeBtnStroke.Thickness = 1.25
volumeBtnStroke.Transparency = 0.7

local pitchButton = Instance.new("TextButton", mainFrame)
pitchButton.Text = "Tom: 1"
pitchButton.Size = UDim2.new(0, 70, 0, 25)
pitchButton.Position = UDim2.new(0, 250, 1, -44)
pitchButton.BackgroundColor3 = accentBg
pitchButton.TextColor3 = orange
pitchButton.Font = Enum.Font.GothamBold
pitchButton.TextSize = 12
pitchButton.ZIndex = 4
pitchButton.Visible = false
pitchButton.AutoButtonColor = true
Instance.new("UICorner", pitchButton).CornerRadius = UDim.new(1, 0)
local pitchBtnStroke = Instance.new("UIStroke", pitchButton)
pitchBtnStroke.Color = orange
pitchBtnStroke.Thickness = 1.25
pitchBtnStroke.Transparency = 0.7

local verticalBarFrame = Instance.new("Frame", screenGui)
verticalBarFrame.Size = UDim2.new(0, 36, 0, 260)
verticalBarFrame.Position = UDim2.new(0, mainFrame.AbsolutePosition.X + mainFrame.AbsoluteSize.X + 16, 0, mainFrame.AbsolutePosition.Y + 54)
verticalBarFrame.BackgroundTransparency = 1
verticalBarFrame.ZIndex = 1000
verticalBarFrame.Visible = true

local function updateBarPosition()
    verticalBarFrame.Position = UDim2.new(0, mainFrame.AbsolutePosition.X + mainFrame.AbsoluteSize.X + 16, 0, mainFrame.AbsolutePosition.Y + 54)
end

mainFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateBarPosition)
mainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateBarPosition)
screenGui:GetPropertyChangedSignal("Parent"):Connect(updateBarPosition)
updateBarPosition()

local timeLabel = Instance.new("TextLabel", verticalBarFrame)
timeLabel.Size = UDim2.new(1, 0, 0, 20)
timeLabel.Position = UDim2.new(0,0,0,0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "00:00"
timeLabel.TextColor3 = orange
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 13
timeLabel.TextXAlignment = Enum.TextXAlignment.Center
timeLabel.ZIndex = 1010

local durLabel = Instance.new("TextLabel", verticalBarFrame)
durLabel.Size = UDim2.new(1, 0, 0, 20)
durLabel.Position = UDim2.new(0,0,1,-9)
durLabel.AnchorPoint = Vector2.new(0,1)
durLabel.BackgroundTransparency = 1
durLabel.Text = "00:00"
durLabel.TextColor3 = orange
durLabel.Font = Enum.Font.GothamBold
durLabel.TextSize = 13
durLabel.TextXAlignment = Enum.TextXAlignment.Center
durLabel.ZIndex = 1010

local barBg = Instance.new("Frame", verticalBarFrame)
barBg.Size = UDim2.new(0.3, 0, 1, -45)
barBg.Position = UDim2.new(0.35, 0, 0, 24)
barBg.BackgroundColor3 = accentBg
barBg.ZIndex = 1011
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0.5, 4)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(1, 0, 0, 0)
bar.Position = UDim2.new(0,0,0,0)
bar.BackgroundColor3 = orange
bar.ZIndex = 1012
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0.5, 4)

runService.RenderStepped:Connect(function()
    updateBarPosition()
    if playingSound and playingSound.IsPlaying and playingSound.TimeLength > 0 then
        timeLabel.Text = string.format("%02d:%02d", math.floor(playingSound.TimePosition/60), math.floor(playingSound.TimePosition%60))
        durLabel.Text = string.format("%02d:%02d", math.floor(playingSound.TimeLength/60), math.floor(playingSound.TimeLength%60))
        local progress = math.clamp(playingSound.TimePosition / playingSound.TimeLength,0,1)
        bar.Size = UDim2.new(1,0,progress,0)
        verticalBarFrame.Visible = true
    else
        timeLabel.Text = "00:00"
        durLabel.Text = "00:00"
        bar.Size = UDim2.new(1,0,0,0)
        verticalBarFrame.Visible = false
    end
end)

local musicListBtnClicked = false

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainScroll.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    settingsFrame.Visible = false
end)

local inSettings = false
settingsButton.MouseButton1Click:Connect(function()
    inSettings = not inSettings
    mainScroll.Visible = not inSettings
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    settingsFrame.Visible = inSettings
    muteBoomboxButton.Text = boomboxMuted and "Ativar todos os boomboxes" or "Silenciar todos os boomboxes"
    muteGameSoundsButton.Text = gameSoundsMuted and "Ativar todos os Gamesounds" or "Silenciar todos os Gamesounds"
end)

local inCredits = false
creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainScroll.Visible = not inCredits
    creditsFrame.Visible = inCredits
    musicListFrame.Visible = false
    settingsFrame.Visible = false
end)

modeButton.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    modeButton.Text = isClientAudio and "C.A" or "R.A"
    loopButton.Visible = isClientAudio
    stopButton.Visible = isClientAudio
    volumeButton.Visible = isClientAudio
    pitchButton.Visible = isClientAudio
end)

mainScroll.Visible = true
musicListFrame.Visible = false
creditsFrame.Visible = false
settingsFrame.Visible = false

loopButton.MouseButton1Click:Connect(function()
    isLoop = not isLoop
    loopButton.Text = isLoop and "Loop: SIM" or "Loop: NÃO"
    if playingSound then playingSound.Looped = isLoop end
end)
stopButton.MouseButton1Click:Connect(stopAllClientSounds)
volumeButton.MouseButton1Click:Connect(function()
    showSelectorPopup("Escolha o Volume:", {0.5,0.75,1.0,1.5,2.0}, function(vol)
        currentVolume = vol
        volumeButton.Text = "Vol: " .. tostring(currentVolume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Volume = currentVolume end
        end
    end)
end)
pitchButton.MouseButton1Click:Connect(function()
    showSelectorPopup("Escolha o tom:", {0.75,1.0,1.5}, function(pitch)
        currentPitch = pitch
        pitchButton.Text = "Tom: " .. tostring(currentPitch)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Pitch = currentPitch end
        end
    end)
end)

local boomboxMuted = false
local muteBoomboxButton = Instance.new("TextButton", settingsFrame)
muteBoomboxButton.Size = UDim2.new(1, 0, 0, 40)
muteBoomboxButton.Position = UDim2.new(0, 0, 0, 10)
muteBoomboxButton.Text = "Silenciar todos os boomboxes"
muteBoomboxButton.Font = Enum.Font.GothamBold
muteBoomboxButton.TextSize = 13
muteBoomboxButton.BackgroundColor3 = accentBg
muteBoomboxButton.TextColor3 = orange
muteBoomboxButton.ZIndex = 4
Instance.new("UICorner", muteBoomboxButton).CornerRadius = UDim.new(1, 0)
local muteBoomboxBtnStroke = Instance.new("UIStroke", muteBoomboxButton)
muteBoomboxBtnStroke.Color = orange
muteBoomboxBtnStroke.Thickness = 1.25
muteBoomboxBtnStroke.Transparency = 0.7

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
    muteBoomboxButton.Text = boomboxMuted and "Ativar todos os boomboxes" or "Silenciar todos os boomboxes"
end)

local gameSoundsMuted = false
local muteGameSoundsConn
local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(1, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0, 0, 0, 60)
muteGameSoundsButton.Text = "Silenciar todos os Gamesounds"
muteGameSoundsButton.Font = Enum.Font.GothamBold
muteGameSoundsButton.TextSize = 13
muteGameSoundsButton.BackgroundColor3 = accentBg
muteGameSoundsButton.TextColor3 = orange
muteGameSoundsButton.ZIndex = 4
Instance.new("UICorner", muteGameSoundsButton).CornerRadius = UDim.new(1, 0)
local muteGameSoundsBtnStroke = Instance.new("UIStroke", muteGameSoundsButton)
muteGameSoundsBtnStroke.Color = orange
muteGameSoundsBtnStroke.Thickness = 1.25
muteGameSoundsBtnStroke.Transparency = 0.7

local function isMyBoombox(sound)
    if sound:IsDescendantOf(soundFolder) then return true end
    if player.Character then
        local radio = player.Character:FindFirstChild("Radio")
        if radio then
            if sound:IsDescendantOf(radio) then return true end
        end
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
    muteGameSoundsButton.Text = mute and "Ativar todos os Gamesounds" or "Silenciar todos os Gamesounds"
end

muteGameSoundsButton.MouseButton1Click:Connect(function()
    setGameSoundsMuted(not gameSoundsMuted)
end)

local openIcon = Instance.new("TextButton", screenGui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = orange
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 13
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = darkBg
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Active = true
openIcon.Draggable = true

minimizeBtn.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -355, 0.1, -280)})
    tween:Play()
    tween.Completed:Wait()
    mainFrame.Visible = false
    openIcon.Visible = true
    verticalBarFrame.Visible = false
end)
openIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openIcon.Visible = false
    mainFrame.BackgroundTransparency = 1
    mainFrame.Position = UDim2.new(1, -355, 0.5, -280)
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)})
    tween:Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    verticalBarFrame:Destroy()
    if soundFolder then soundFolder:Destroy() end
    if muteGameSoundsConn then muteGameSoundsConn:Disconnect() muteGameSoundsConn = nil end
end)

playBtn.MouseButton1Click:Connect(function()
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
            local remotes = findBoomboxRemotes()
            if #remotes > 0 then
                tryPlayBoombox(remotes, id)
            else
                warn("Nenhum Remote de Boombox encontrado!")
            end
        end
        showAchievementBar("Escutando: " .. nameGot, 6)
    else
        warn("ID INVÁLIDO.")
    end
end)

function showSelectorPopup(titleText, options, callback)
    if screenGui:FindFirstChild("SelectorPopup") then screenGui.SelectorPopup:Destroy() end
    if screenGui:FindFirstChild("SelectorPopupBlock") then screenGui.SelectorPopupBlock:Destroy() end

    local block = Instance.new("Frame", screenGui)
    block.Name = "SelectorPopupBlock"
    block.Size = UDim2.new(1,0,1,0)
    block.BackgroundTransparency = 0.35
    block.BackgroundColor3 = Color3.fromRGB(0,0,0)
    block.ZIndex = 19999
    block.Active = true

    local popup = Instance.new("Frame", screenGui)
    popup.Name = "SelectorPopup"
    popup.Size = UDim2.new(0, 330, 0, 130)
    popup.Position = UDim2.new(0.5, -165, 0.5, -65)
    popup.BackgroundColor3 = darkBg
    popup.BorderSizePixel = 0
    popup.ZIndex = 20000
    popup.Active = true
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)
    local popupStroke = Instance.new("UIStroke", popup)
    popupStroke.Color = orange
    popupStroke.Thickness = 1.25
    popupStroke.Transparency = 0.7

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -16, 0, 32)
    title.Position = UDim2.new(0,8,0,7)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = orange
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
        btn.TextColor3 = orange
        btn.BackgroundColor3 = accentBg
        btn.ZIndex = 20001
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = orange
        btnStroke.Thickness = 1.25
        btnStroke.Transparency = 0.7
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orange btn.TextColor3 = darkBg end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = orange end)
        btn.MouseButton1Click:Connect(function()
            popup:Destroy()
            block:Destroy()
            if callback then callback(opt) end
        end)
    end
end

function showAchievementBar(text, duration)
    local bar = Instance.new("Frame", screenGui)
    bar.Size = UDim2.new(0, 250, 0, 45)
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundColor3 = accentBg
    bar.BackgroundTransparency = 0.15
    bar.BorderSizePixel = 0
    bar.AnchorPoint = Vector2.new(0,0)
    local uicorner = Instance.new("UICorner", bar)
    uicorner.CornerRadius = UDim.new(0, 12)
    local label = Instance.new("TextLabel", bar)
    label.Size = UDim2.new(1, -16, 1, -12)
    label.Position = UDim2.new(0, 8, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = orange
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundTransparency = 1
    label.TextTransparency = 1
    local tweenIn = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 0, 18), BackgroundTransparency = 0.15})
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
    showAchievementBar("Bem-vindo(a) ao Freeman Hub 🎵🎃 V13!",4)
end)()

if not _G.FreemanAdminUsers then _G.FreemanAdminUsers = {} end
local plr = game:GetService("Players").LocalPlayer
if not table.find(_G.FreemanAdminUsers, plr.Name) then
    table.insert(_G.FreemanAdminUsers, plr.Name)
end
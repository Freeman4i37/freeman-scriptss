local orange = Color3.fromRGB(255,140,0)
local black = Color3.fromRGB(0,0,0)
local accentBg = Color3.fromRGB(32,32,32)
local white = Color3.fromRGB(255,255,255)
local discordInvite = "https://discord.gg/auralynx"
local musicIDs = {["1"]=94718473830640,["2"]=92209428926055,["3"]=133900561957103,["4"]=93768636184697,["5"]=92062588329352,["6"]=84773737820526,["7"]=87783857221289,["8"]=88342296270082,["9"]=85342086082111,["10"]=93058983119992,["11"]=92492039534399,["12"]=134035788881796,["13"]=18841893567,["14"]=73962723234161,["15"]=140268583413209,["16"]=77741294709660,["17"]=71531533552899,["18"]=16190782181,["19"]=117169209277972,["20"]=81299332131868,["21"]=77147911349059,["22"]=124092830839928,["23"]=122854357582130,["24"]=88094479399489,["25"]=88339486019486,["26"]=97765714111493,["27"]=92446612272052,["28"]=74366765967475,["29"]=112068892721408,["30"]=112143944982807,["31"]=111668097052966,["32"]=112214814544629,["33"]=101500915434329,["34"]=95046091312570,["35"]=110091098283354,["36"]=17422156627,["37"]=82411642961457,["38"]=87022583947683,["39"]=96974354995715,["40"]=119020235792430,["41"]=82411642961457,["42"]=96215620202470,["43"]=70782176012619,["44"]=112893354276338,["45"]=118507373399694,["46"]=98691879232718,["47"]=134457296749518,["48"]=118607303205005,["49"]=127504762051765,["50"]=118297487529239,["51"]=132082397247824,["52"]=106958630419629,["53"]=86685635786943,["54"]=101456813429584,["55"]=100533213305793}
local musicNames = {["1"]="Funk da Febre",["2"]="Switch The Colors (Jersey Club)",["3"]="Trash Funk",["4"]="2609 (Jersey Club)",["5"]="Spooky Scary Sunday (Jersey Club)",["6"]="ANOTE AÍ",["7"]="Temptation",["8"]="Ela Tano",["9"]="Seu fã",["10"]="MONTAGEM ECLIPSE ESTRELAR",["11"]="Em Dezembro de 81 - Flamengo",["12"]="Esquema Confirmado - Arrocha",["13"]="JERSEY WAVE",["14"]="Arrepia XL 2",["15"]="Meepcity (Jersey Club)",["16"]="Manda Meu Passinho",["17"]="Lembro até hoje",["18"]="HR - EEYUH!",["19"]="I love ha",["20"]="SHE DON'T - Lonelybwoi",["21"]="NY Drill Ritual",["22"]="It Doesn't Matter (Jersey Club)",["23"]="69 PHONK",["24"]="Ela se envolveu",["25"]="Montagem Pose",["26"]="Trem Fantasma Funk",["27"]="MTG ZUM ZUM ZUM",["28"]="EU NÃO ESTOU LOUCO",["29"]="FUNK DA PRAIA (SLOWED)",["30"]="Hogo Funk",["31"]="Novinha sapeca",["32"]="ANALOG HORROR FUNK",["33"]="Dum Dum",["34"]="Rebola pro pai",["35"]="Carro Bixo",["36"]="Onichan",["37"]="Arrepia XL 6",["38"]="Mandrake",["39"]="Toma Toma",["40"]="Lá no meu barraco",["41"]="Batida SP",["42"]="Funk SP",["43"]="Pega no cipó",["44"]="Rap do Minecraft (Funk)",["45"]="Melodia do Verão",["46"]="Funk do Famglia",["47"]="Vem no pique (Phonk)",["48"]="Michael Jackson FUNK",["49"]="Arrepia XL 4",["50"]="MONTAGEM NOVA MÁGICA 1.0",["51"]="V2 Daquela (XL Funk)",["52"]="Digitei seu número (Sertanejo)",["53"]="Auto toma",["54"]="Montagem Balanço",["55"]="Piseiro com sertanejo"}
local player = game:GetService("Players").LocalPlayer
local soundFolder = workspace:FindFirstChild("AuralynxClientSounds") or Instance.new("Folder", workspace)
soundFolder.Name = "AuralynxClientSounds"
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxMusicHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
local mainFrame = Instance.new("Frame")
mainFrame.Name = "AuralynxMusicMain"
mainFrame.Size = UDim2.new(0, 380, 0, 510)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = black
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = orange
mainStroke.Thickness = 2
mainStroke.Transparency = 0.2
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = black
header.ZIndex = 10
header.Position = UDim2.new(0,0,0,0)
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 20)
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Auralynx Brookhaven"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 21
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(0, 230, 0, 32)
headerTitle.Position = UDim2.new(0, 18, 0, 14)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
headerTitle.ZIndex = 11
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 35, 0, 32)
minimizeBtn.Position = UDim2.new(1, -81, 0, 14)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = orange
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 21
minimizeBtn.ZIndex = 11
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 35, 0, 32)
closeBtn.Position = UDim2.new(1, -41, 0, 14)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = orange
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 21
closeBtn.ZIndex = 11
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local tabsBar = Instance.new("Frame", mainFrame)
tabsBar.Size = UDim2.new(1, -32, 0, 37)
tabsBar.Position = UDim2.new(0, 16, 0, 66)
tabsBar.BackgroundTransparency = 1
tabsBar.ZIndex = 1000
local tabScroll = Instance.new("ScrollingFrame", tabsBar)
tabScroll.Size = UDim2.new(1, 0, 1, 0)
tabScroll.Position = UDim2.new(0,0,0,0)
tabScroll.BackgroundTransparency = 1
tabScroll.ScrollBarThickness = 0
tabScroll.CanvasSize = UDim2.new(0,0,0,0)
tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tabScroll.ZIndex = 5
local tabLayout = Instance.new("UIListLayout", tabScroll)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,8)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
local tabs = {
    {name = "IDs", label = "IDs"},
    {name = "MusicList", label = "Music List"},
    {name = "ClientAudio", label = "Client Audio"},
    {name = "Scripts", label = "Scripts"},
    {name = "Credits", label = "Credits"}
}
local tabFrames = {}
local tabButtons = {}
local selectedTab = 1
local minimized = false
local isClientAudio, isLoop, currentVolume, currentPitch = false, false, 1, 1
local function showTab(idx)
    for i, frame in ipairs(tabFrames) do
        frame.Visible = (not minimized) and (i == idx)
    end
end
for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabScroll)
    btn.Size = UDim2.new(0, 106, 0, 32)
    btn.Text = tab.label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = orange
    btn.BackgroundColor3 = accentBg
    btn.ZIndex = 6
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orange btn.TextColor3 = black end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = orange end)
    btn.MouseButton1Click:Connect(function()
        selectedTab = i
        showTab(i)
    end)
    tabButtons[i] = btn
    local frame = Instance.new("Frame", mainFrame)
    frame.Size = UDim2.new(1, -32, 1, -110)
    frame.Position = UDim2.new(0, 16, 0, 104)
    frame.BackgroundColor3 = black
    frame.Visible = (i == 1)
    frame.ZIndex = 10
    tabFrames[i] = frame
end
local function setMinimized(m)
    minimized = m
    tabsBar.Visible = not minimized
    tabScroll.Visible = not minimized
    showTab(selectedTab)
    minimizeBtn.Text = minimized and "+" or "-"
    local goal = minimized and UDim2.new(0, 380, 0, 60) or UDim2.new(0, 380, 0, 510)
    tweenService:Create(mainFrame, TweenInfo.new(0.27, Enum.EasingStyle.Quart), {Size = goal}):Play()
end
minimizeBtn.MouseButton1Click:Connect(function()
    setMinimized(not minimized)
end)
closeBtn.MouseButton1Click:Connect(function()
    for _, s in ipairs(soundFolder:GetChildren()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
    screenGui:Destroy()
    if soundFolder then soundFolder:Destroy() end
end)
local notificationBar = nil
local notificationConn = nil
local function showMusicNotification(musicName, duration, isLoop, sound)
    if notificationConn then notificationConn:Disconnect() end
    if notificationBar then notificationBar:Destroy() end
    notificationBar = Instance.new("Frame", screenGui)
    notificationBar.Size = UDim2.new(0, 340, 0, 64)
    notificationBar.Position = UDim2.new(0.5, -170, 0, 10)
    notificationBar.BackgroundColor3 = black
    notificationBar.BorderSizePixel = 0
    notificationBar.ZIndex = 9999
    local corner = Instance.new("UICorner", notificationBar)
    corner.CornerRadius = UDim.new(0,16)
    local stroke = Instance.new("UIStroke", notificationBar)
    stroke.Color = orange
    stroke.Thickness = 3
    stroke.Transparency = 0.1
    local nameLabel = Instance.new("TextLabel", notificationBar)
    nameLabel.Size = UDim2.new(1, -10, 0, 34)
    nameLabel.Position = UDim2.new(0,5,0,5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = musicName
    nameLabel.TextColor3 = orange
    nameLabel.TextSize = 22
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.ZIndex = 9999
    nameLabel.TextWrapped = true
    local durLabel = Instance.new("TextLabel", notificationBar)
    durLabel.Size = UDim2.new(1, -10, 0, 22)
    durLabel.Position = UDim2.new(0,5,0,38)
    durLabel.BackgroundTransparency = 1
    durLabel.TextColor3 = orange
    durLabel.TextSize = 16
    durLabel.Font = Enum.Font.Gotham
    durLabel.ZIndex = 9999
    durLabel.TextWrapped = true
    notificationBar.BackgroundTransparency = 1
    nameLabel.TextTransparency = 1
    durLabel.TextTransparency = 1
    tweenService:Create(notificationBar, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{BackgroundTransparency=0.09}):Play()
    tweenService:Create(nameLabel, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()
    tweenService:Create(durLabel, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()
    local function sec2str(sec)
        sec = math.floor(sec)
        local m = math.floor(sec/60)
        local s = sec%60
        return string.format("%02d:%02d",m,s)
    end
    local total = math.floor(duration)
    local function updateDur()
        if sound and sound.IsLoaded then
            local pos = math.floor(sound.TimePosition)
            durLabel.Text = sec2str(pos).." - "..sec2str(total)
        else
            durLabel.Text = "00:00 - "..sec2str(total)
        end
    end
    updateDur()
    notificationConn = runService.RenderStepped:Connect(function()
        if not notificationBar or not durLabel or not sound then return end
        updateDur()
    end)
    if not isLoop then
        sound.Ended:Connect(function()
            if notificationConn then notificationConn:Disconnect() end
            tweenService:Create(notificationBar, TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundTransparency=1}):Play()
            for _,v in ipairs(notificationBar:GetChildren()) do
                if v:IsA("TextLabel") then tweenService:Create(v, TweenInfo.new(0.18,Enum.EasingStyle.Quart),{TextTransparency=1}):Play() end
            end
            wait(0.3)
            if notificationBar then notificationBar:Destroy() end
            notificationBar = nil
        end)
    end
end
local playingSound = nil
local function stopAllClientSounds()
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then s:Stop() s:Destroy() end
    end
    playingSound = nil
    if notificationConn then notificationConn:Disconnect() end
    if notificationBar then notificationBar:Destroy() notificationBar = nil end
end
local function playClientAudio(id)
    if not id or type(id) ~= "number" then return end
    if playingSound and playingSound.IsPlaying and playingSound.Name == tostring(id) then return end
    stopAllClientSounds()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume or 1
    sound.Looped = isLoop
    sound.Pitch = currentPitch or 1
    sound.Name = tostring(id)
    sound.Parent = soundFolder
    sound:Play()
    playingSound = sound
    local musicName = nil
    for num, audioId in pairs(musicIDs) do
        if audioId == id then musicName = musicNames[num] break end
    end
    musicName = musicName or ("Audio "..id)
    sound.Loaded:Connect(function()
        local length = sound.TimeLength or 0
        local pitch = currentPitch or 1
        if pitch == 0 then pitch = 1 end
        showMusicNotification(musicName, length/pitch, isLoop, sound)
    end)
    return sound
end
local function showSelectorPopup(title, values, callback)
    local selectorPopup = screenGui:FindFirstChild("SelectorPopup")
    if selectorPopup then selectorPopup:Destroy() end
    selectorPopup = Instance.new("Frame", screenGui)
    selectorPopup.Name = "SelectorPopup"
    selectorPopup.Size = UDim2.new(0, 210, 0, 36 + 40*#values)
    selectorPopup.Position = UDim2.new(0.5, -105, 0.5, -((36 + 40*#values)//2))
    selectorPopup.BackgroundColor3 = accentBg
    selectorPopup.ZIndex = 5000
    Instance.new("UICorner", selectorPopup).CornerRadius = UDim.new(0, 12)
    local titleLabel = Instance.new("TextLabel", selectorPopup)
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, 0, 0, 36)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = orange
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.ZIndex = 5001
    for i, val in ipairs(values) do
        local btn = Instance.new("TextButton", selectorPopup)
        local mark = " "
        if title == "Choose Volume:" and val == currentVolume then mark = "➡ " end
        if title == "Choose Pitch:" and val == currentPitch then mark = "➡ " end
        btn.Text = mark .. tostring(val)
        btn.Size = UDim2.new(1, -20, 0, 32)
        btn.Position = UDim2.new(0, 10, 0, 36 + (i-1)*40)
        btn.BackgroundColor3 = black
        btn.TextColor3 = orange
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.ZIndex = 5002
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        btn.MouseButton1Click:Connect(function()
            if selectorPopup then selectorPopup:Destroy() selectorPopup = nil end
            callback(val)
        end)
    end
end
do
    local idsFrame = tabFrames[1]
    local mainScroll = Instance.new("ScrollingFrame", idsFrame)
    mainScroll.Size = UDim2.new(1, -20, 1, -68)
    mainScroll.Position = UDim2.new(0, 10, 0, 10)
    mainScroll.BackgroundTransparency = 1
    mainScroll.CanvasSize = UDim2.new(0,0,0,0)
    mainScroll.ScrollBarThickness = 7
    mainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    mainScroll.ZIndex = 11
    local grid = Instance.new("UIGridLayout", mainScroll)
    grid.CellSize = UDim2.new(0, 105, 0, 44)
    grid.CellPadding = UDim2.new(0, 10, 0, 10)
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid.VerticalAlignment = Enum.VerticalAlignment.Top
    grid.FillDirectionMaxCells = 2
    for i = 1, 55 do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 105, 0, 44)
        btn.Text = tostring(i)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 20
        btn.TextColor3 = orange
        btn.BackgroundColor3 = accentBg
        btn.ZIndex = 12
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = orange btn.TextColor3 = black end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = orange end)
        btn.Parent = mainScroll
        btn.MouseButton1Click:Connect(function()
            local id = tonumber(musicIDs[tostring(i)])
            if isClientAudio then
                if playingSound and playingSound.IsPlaying and playingSound.Name == tostring(id) then return end
                stopAllClientSounds()
                playClientAudio(id)
            else
                local rep = game:GetService("ReplicatedStorage")
                local function playMusicRemote(tipo, id)
                    if tipo == "🚗" then
                        rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("PickingVehicleMusicText", id)
                    elseif tipo == "🛴" then
                        rep:WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s"):FireServer("PickingScooterMusicText", id)
                    elseif tipo == "🛵" then
                        rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("PickingCarMusicText", id)
                    elseif tipo == "📻" then
                        rep:WaitForChild("RE"):WaitForChild("PlayerToolEvent"):FireServer("ToolMusicText", id)
                    elseif tipo == "🏠" then
                        rep:WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer("PickHouseMusicText", id)
                    end
                end
                showSelectorPopup("Escolha o tipo:", {"🚗", "🛴", "🛵", "📻", "🏠"}, function(tipo)
                    playMusicRemote(tipo, id)
                end)
            end
        end)
    end
    local idsInput = Instance.new("TextBox", idsFrame)
    idsInput.PlaceholderText = "Enter ID here..."
    idsInput.Size = UDim2.new(0.62, -10, 0, 36)
    idsInput.Position = UDim2.new(0, 14, 1, -48)
    idsInput.BackgroundColor3 = accentBg
    idsInput.TextColor3 = orange
    idsInput.PlaceholderColor3 = Color3.fromRGB(200,200,200)
    idsInput.Font = Enum.Font.Gotham
    idsInput.TextSize = 15
    idsInput.Text = ""
    idsInput.ClearTextOnFocus = false
    idsInput.ZIndex = 13
    idsInput.AutoLocalize = false
    Instance.new("UICorner", idsInput).CornerRadius = UDim.new(1, 0)
    local idsPlayBtn = Instance.new("TextButton", idsFrame)
    idsPlayBtn.Text = "Play"
    idsPlayBtn.Size = UDim2.new(0.36, -10, 0, 36)
    idsPlayBtn.Position = UDim2.new(0.62, 0, 1, -48)
    idsPlayBtn.BackgroundColor3 = accentBg
    idsPlayBtn.TextColor3 = orange
    idsPlayBtn.Font = Enum.Font.GothamBold
    idsPlayBtn.TextSize = 16
    idsPlayBtn.ZIndex = 13
    idsPlayBtn.AutoButtonColor = true
    Instance.new("UICorner", idsPlayBtn).CornerRadius = UDim.new(1, 0)
    idsPlayBtn.MouseEnter:Connect(function() idsPlayBtn.BackgroundColor3 = orange idsPlayBtn.TextColor3 = black end)
    idsPlayBtn.MouseLeave:Connect(function() idsPlayBtn.BackgroundColor3 = accentBg idsPlayBtn.TextColor3 = orange end)
    idsPlayBtn.MouseButton1Click:Connect(function()
        local input = idsInput.Text:gsub("rbxassetid://", "")
        local id = tonumber(input)
        if isClientAudio then
            if playingSound and playingSound.IsPlaying and playingSound.Name == tostring(id) then return end
            stopAllClientSounds()
            playClientAudio(id)
        else
            local rep = game:GetService("ReplicatedStorage")
            local function playMusicRemote(tipo, id)
                if tipo == "🚗" then
                    rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("PickingVehicleMusicText", id)
                elseif tipo == "🛴" then
                    rep:WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s"):FireServer("PickingScooterMusicText", id)
                elseif tipo == "🛵" then
                    rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("PickingCarMusicText", id)
                elseif tipo == "📻" then
                    rep:WaitForChild("RE"):WaitForChild("PlayerToolEvent"):FireServer("ToolMusicText", id)
                elseif tipo == "🏠" then
                    rep:WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer("PickHouseMusicText", id)
                end
            end
            showSelectorPopup("Escolha o tipo:", {"🚗", "🛴", "🛵", "📻", "🏠"}, function(tipo)
                playMusicRemote(tipo, id)
            end)
        end
    end)
end
do
    local musicListFrame = tabFrames[2]
    local musicScroll = Instance.new("ScrollingFrame", musicListFrame)
    musicScroll.Size = UDim2.new(1, -24, 1, -24)
    musicScroll.Position = UDim2.new(0, 12, 0, 12)
    musicScroll.BackgroundTransparency = 1
    musicScroll.CanvasSize = UDim2.new(0,0,0,0)
    musicScroll.ScrollBarThickness = 6
    musicScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    musicScroll.Name = "musicScroll"
    musicScroll.ZIndex = 14
    local musicListLayout = Instance.new("UIListLayout", musicScroll)
    musicListLayout.Padding = UDim.new(0,8)
    musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    for k = 1, 55 do
        local lbl = Instance.new("TextLabel", musicScroll)
        lbl.Size = UDim2.new(1, -10, 0, 28)
        lbl.BackgroundTransparency = 1
        lbl.Text = "["..k.."] - "..musicNames[tostring(k)]
        lbl.Font = Enum.Font.GothamBold
        lbl.TextColor3 = orange
        lbl.TextSize = 15
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 14
    end
end
do
    local clientAudioFrame = tabFrames[3]
    local clientAudioToggleBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioToggleBtn.Size = UDim2.new(1, -20, 0, 36)
    clientAudioToggleBtn.Position = UDim2.new(0, 10, 0, 10)
    clientAudioToggleBtn.BackgroundColor3 = accentBg
    clientAudioToggleBtn.TextColor3 = orange
    clientAudioToggleBtn.Font = Enum.Font.GothamBold
    clientAudioToggleBtn.TextSize = 15
    clientAudioToggleBtn.ZIndex = 15
    Instance.new("UICorner", clientAudioToggleBtn).CornerRadius = UDim.new(1, 0)
    clientAudioToggleBtn.Text = "Client Audio: Off"
    local clientAudioLoopBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioLoopBtn.Text = "Loop: NO"
    clientAudioLoopBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioLoopBtn.Position = UDim2.new(0, 10, 0, 56)
    clientAudioLoopBtn.BackgroundColor3 = accentBg
    clientAudioLoopBtn.TextColor3 = orange
    clientAudioLoopBtn.Font = Enum.Font.GothamBold
    clientAudioLoopBtn.TextSize = 13
    clientAudioLoopBtn.ZIndex = 15
    clientAudioLoopBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioLoopBtn).CornerRadius = UDim.new(1, 0)
    local clientAudioVolumeBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)
    clientAudioVolumeBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioVolumeBtn.Position = UDim2.new(0.5, 8, 0, 56)
    clientAudioVolumeBtn.BackgroundColor3 = accentBg
    clientAudioVolumeBtn.TextColor3 = orange
    clientAudioVolumeBtn.Font = Enum.Font.GothamBold
    clientAudioVolumeBtn.TextSize = 13
    clientAudioVolumeBtn.ZIndex = 15
    clientAudioVolumeBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioVolumeBtn).CornerRadius = UDim.new(1, 0)
    local clientAudioPitchBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)
    clientAudioPitchBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioPitchBtn.Position = UDim2.new(0, 10, 0, 96)
    clientAudioPitchBtn.BackgroundColor3 = accentBg
    clientAudioPitchBtn.TextColor3 = orange
    clientAudioPitchBtn.Font = Enum.Font.GothamBold
    clientAudioPitchBtn.TextSize = 13
    clientAudioPitchBtn.ZIndex = 15
    clientAudioPitchBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioPitchBtn).CornerRadius = UDim.new(1, 0)
    local selectorPopup = nil
    function showSelectorPopup(title, values, callback)
        if selectorPopup then selectorPopup:Destroy() selectorPopup = nil end
        selectorPopup = Instance.new("Frame", screenGui)
        selectorPopup.Size = UDim2.new(0, 210, 0, 36 + 40*#values)
        selectorPopup.Position = UDim2.new(0.5, -105, 0.5, -((36 + 40*#values)//2))
        selectorPopup.BackgroundColor3 = accentBg
        selectorPopup.ZIndex = 5000
        Instance.new("UICorner", selectorPopup).CornerRadius = UDim.new(0, 12)
        local titleLabel = Instance.new("TextLabel", selectorPopup)
        titleLabel.Text = title
        titleLabel.Size = UDim2.new(1, 0, 0, 36)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = orange
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        titleLabel.ZIndex = 5001
        local btns = {}
        for i, val in ipairs(values) do
            local btn = Instance.new("TextButton", selectorPopup)
            local mark = " "
            if title == "Choose Volume:" and val == currentVolume then mark = "➡ " end
            if title == "Choose Pitch:" and val == currentPitch then mark = "➡ " end
            btn.Text = mark .. tostring(val)
            btn.Size = UDim2.new(1, -20, 0, 32)
            btn.Position = UDim2.new(0, 10, 0, 36 + (i-1)*40)
            btn.BackgroundColor3 = black
            btn.TextColor3 = orange
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 16
            btn.ZIndex = 5002
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
            btn.MouseButton1Click:Connect(function()
                if selectorPopup then selectorPopup:Destroy() selectorPopup = nil end
                callback(val)
            end)
            btns[i] = btn
        end
    end
    clientAudioToggleBtn.MouseButton1Click:Connect(function()
        isClientAudio = not isClientAudio
        clientAudioToggleBtn.Text = "Client Audio: "..(isClientAudio and "On" or "Off")
        clientAudioLoopBtn.Visible = isClientAudio
        clientAudioVolumeBtn.Visible = isClientAudio
        clientAudioPitchBtn.Visible = isClientAudio
        if not isClientAudio then stopAllClientSounds() end
    end)
    clientAudioLoopBtn.MouseButton1Click:Connect(function()
        isLoop = not isLoop
        clientAudioLoopBtn.Text = isLoop and "Loop: YES" or "Loop: NO"
        if playingSound then playingSound.Looped = isLoop end
    end)
    clientAudioVolumeBtn.MouseButton1Click:Connect(function()
        showSelectorPopup("Choose Volume:", {0.5,0.75,1.0,1.5,2.0,2.5}, function(vol)
            currentVolume = vol or 1
            clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)
            for _, s in ipairs(soundFolder:GetChildren()) do
                if s:IsA("Sound") then s.Volume = currentVolume end
            end
        end)
    end)
    clientAudioPitchBtn.MouseButton1Click:Connect(function()
        showSelectorPopup("Choose Pitch:", {0.5,0.75,1.0}, function(pitch)
            currentPitch = pitch or 1
            clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)
            for _, s in ipairs(soundFolder:GetChildren()) do
                if s:IsA("Sound") then s.Pitch = currentPitch end
            end
        end)
    end)
end
do
    local scriptsFrame = tabFrames[4]
    local brookBtn = Instance.new("TextButton", scriptsFrame)
    brookBtn.Size = UDim2.new(1, -20, 0, 38)
    brookBtn.Position = UDim2.new(0, 10, 0, 28)
    brookBtn.BackgroundColor3 = accentBg
    brookBtn.TextColor3 = orange
    brookBtn.Font = Enum.Font.GothamBold
    brookBtn.TextSize = 15
    brookBtn.ZIndex = 17
    brookBtn.Text = "Drip Client"
    Instance.new("UICorner", brookBtn).CornerRadius = UDim.new(1, 0)
    brookBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Drip-Client-51784"))()
    end)
    local afemBtn = Instance.new("TextButton", scriptsFrame)
    afemBtn.Size = UDim2.new(1, -20, 0, 38)
    afemBtn.Position = UDim2.new(0, 10, 0, 78)
    afemBtn.BackgroundColor3 = accentBg
    afemBtn.TextColor3 = orange
    afemBtn.Font = Enum.Font.GothamBold
    afemBtn.TextSize = 15
    afemBtn.ZIndex = 17
    afemBtn.Text = "AFEM"
    Instance.new("UICorner", afemBtn).CornerRadius = UDim.new(1, 0)
    afemBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AFEM-Max-Open-Alpha-50210"))()
    end)
    local namelessBtn = Instance.new("TextButton", scriptsFrame)
    namelessBtn.Size = UDim2.new(1, -20, 0, 38)
    namelessBtn.Position = UDim2.new(0, 10, 0, 128)
    namelessBtn.BackgroundColor3 = accentBg
    namelessBtn.TextColor3 = orange
    namelessBtn.Font = Enum.Font.GothamBold
    namelessBtn.TextSize = 15
    namelessBtn.ZIndex = 17
    namelessBtn.Text = "Nameless Admin"
    Instance.new("UICorner", namelessBtn).CornerRadius = UDim.new(1, 0)
    namelessBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Nameless-admin-REWORKED-43502"))()
    end)
    -- Painel Admin removido completamente
end
do
    local creditsFrame = tabFrames[5]
    local creditsLabel = Instance.new("TextLabel", creditsFrame)
    creditsLabel.Size = UDim2.new(1, -16, 1, -60)
    creditsLabel.Position = UDim2.new(0, 8, 0, 8)
    creditsLabel.Text = "Made by Lynxdev.\nAuralynx Brookhaven © 2025."
    creditsLabel.Font = Enum.Font.GothamBold
    creditsLabel.TextColor3 = orange
    creditsLabel.TextSize = 16
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.ZIndex = 18
    local discordBtn = Instance.new("TextButton", creditsFrame)
    discordBtn.Size = UDim2.new(1, -20, 0, 38)
    discordBtn.Position = UDim2.new(0, 10, 1, -48)
    discordBtn.BackgroundColor3 = accentBg
    discordBtn.TextColor3 = orange
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 15
    discordBtn.ZIndex = 18
    discordBtn.Text = "Discord"
    Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(1, 0)
    discordBtn.MouseButton1Click:Connect(function()
        setclipboard(discordInvite)
    end)
end
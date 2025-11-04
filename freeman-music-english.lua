local violet = Color3.fromRGB(128,0,255)
local white = Color3.fromRGB(255,255,255)
local purple = Color3.fromRGB(128,0,128)
local pink = Color3.fromRGB(255,60,180)
local black = Color3.fromRGB(0,0,0)
local accentBg = Color3.fromRGB(0,0,0)
local discordInvite = "https://discord.gg/aqjca9xb3"
local player = game:GetService("Players").LocalPlayer
local soundFolder = workspace:FindFirstChild("AuralynxClientSounds")
if not soundFolder then soundFolder = Instance.new("Folder", workspace) soundFolder.Name = "AuralynxClientSounds" end
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

local musicIDs = {
    ["1"]=94718473830640,["2"]=92209428926055,["3"]=133900561957103,["4"]=93768636184697,["5"]=92062588329352,
    ["6"]=84773737820526,["7"]=87783857221289,["8"]=88342296270082,["9"]=85342086082111,["10"]=107434160225620,
    ["11"]=92492039534399,["12"]=134035788881796,["13"]=18841893567,["14"]=73962723234161,["15"]=140268583413209,
    ["16"]=77741294709660,["17"]=71531533552899,["18"]=16190782181,["19"]=117169209277972,["20"]=81299332131868,
    ["21"]=77147911349059,["22"]=124092830839928,["23"]=84928031488498,["24"]=88094479399489,["25"]=88339486019486,
    ["26"]=97765714111493,["27"]=130401348697721,["28"]=74366765967475,["29"]=112068892721408,["30"]=112143944982807,
    ["31"]=111668097052966,["32"]=112214814544629,["33"]=101500915434329,["34"]=95046091312570,["35"]=110091098283354,
    ["36"]=17422156627,["37"]=82411642961457,["38"]=87022583947683,["39"]=96974354995715,["40"]=119020235792430,
    ["41"]=82411642961457,["42"]=96215620202470,["43"]=70782176012619,["44"]=112893354276338,["45"]=118507373399694,
    ["46"]=98691879232718,["47"]=134457296749518,["48"]=118607303205005,["49"]=127504762051765,["50"]=118297487529239,
    ["51"]=132082397247824,["52"]=106958630419629,["53"]=86685635786943,["54"]=101456813429584,["55"]=100533213305793,
    ["56"]=112930367758222,["57"]=100828050594137,["58"]=124085422276732,["59"]=122114766584918
}
local musicNames = {
    ["1"]="Funk da Febre",["2"]="Switch The Colors (Jersey Club)",["3"]="Trash Funk",["4"]="2609 (Jersey Club)",
    ["5"]="Spooky Scary Sunday (Jersey Club)",["6"]="ANOTE AÍ",["7"]="Temptation",["8"]="Ela Tano",["9"]="Seu fã",
    ["10"]="Bailão",["11"]="Em Dezembro de 81 - Flamengo",["12"]="Esquema Confirmado - Arrocha",
    ["13"]="JERSEY WAVE",["14"]="Arrepia XL 2",["15"]="Meepcity (Jersey Club)",["16"]="Manda Meu Passinho",
    ["17"]="Lembro até hoje",["18"]="HR - EEYUH!",["19"]="I love ha",["20"]="SHE DON'T - Lonelybwoi",
    ["21"]="NY Drill Ritual",["22"]="It Doesn't Matter (Jersey Club)",["23"]="PCC",["24"]="Ela se envolveu",
    ["25"]="Montagem Pose",["26"]="Trem Fantasma Funk",["27"]="Fiz de Tudo",["28"]="EU NÃO ESTOU LOUCO",
    ["29"]="FUNK DA PRAIA (SLOWED)",["30"]="Hogo Funk",["31"]="Novinha sapeca",["32"]="ANALOG HORROR FUNK",
    ["33"]="Dum Dum",["34"]="Rebola pro pai",["35"]="Carro Bixo",["36"]="Onichan",["37"]="Arrepia XL 6",
    ["38"]="Mandrake",["39"]="Toma Toma",["40"]="Lá no meu barraco",["41"]="Batida SP",["42"]="Funk SP",
    ["43"]="Pega no cipó",["44"]="Rap do Minecraft (Funk)",["45"]="Melodia do Verão",["46"]="Funk do Famglia",
    ["47"]="Vem no pique (Phonk)",["48"]="Michael Jackson FUNK",["49"]="Arrepia XL 4",["50"]="MONTAGEM NOVA MÁGICA 1.0",
    ["51"]="V2 Daquela (XL Funk)",["52"]="Digitei seu número (Sertanejo)",["53"]="Auto toma",["54"]="Montagem Balanço",
    ["55"]="Piseiro com sertanejo",["56"]="Montagem Vozes Talentinho",["57"]="Spooky Scary (Funk)",
    ["58"]="SENTA (NGL x XL)",["59"]="Haha (NGL)"
}
local function createGradientAnim(obj, colorSeq, speed)
    local grad = Instance.new("UIGradient", obj)
    grad.Color = colorSeq
    spawn(function()
        local t0 = tick()
        while grad.Parent do grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*speed),0) wait(0.01) end
    end)
    return grad
end

local function styleButton(btn, customSeq)
    local seq = customSeq or ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }
    createGradientAnim(btn, seq, 1.4)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = violet btn.TextColor3 = white end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = violet end)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxMusicHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "AuralynxMusicMain"
mainFrame.Size = UDim2.new(0, 380, 0, 510)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = accentBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Color = violet
local gradMainBorder = Instance.new("UIGradient", mainStroke)
gradMainBorder.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, violet),
    ColorSequenceKeypoint.new(1.0, white),
}
spawn(function()
    local t0 = tick()
    while gradMainBorder.Parent do gradMainBorder.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.6),0) wait(0.03) end
end)

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = accentBg
header.ZIndex = 10
header.Position = UDim2.new(0,0,0,0)
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 20)
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Auralynx"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 21
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(0, 230, 0, 32)
headerTitle.Position = UDim2.new(0, 18, 0, 14)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
headerTitle.ZIndex = 11
createGradientAnim(headerTitle, ColorSequence.new{
    ColorSequenceKeypoint.new(0, violet),
    ColorSequenceKeypoint.new(1.0, white),
}, 1.5)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 35, 0, 32)
closeBtn.Position = UDim2.new(1, -41, 0, 14)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = violet
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 21
closeBtn.ZIndex = 11
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
styleButton(closeBtn)

local roundMinBtn = Instance.new("ImageButton")
roundMinBtn.Size = UDim2.new(0,42,0,42)
roundMinBtn.Position = UDim2.new(0, 34, 0, 66)
roundMinBtn.BackgroundTransparency = 1
roundMinBtn.Image = "rbxassetid://87151754202634"
roundMinBtn.ZIndex = 10000
roundMinBtn.Parent = screenGui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = roundMinBtn

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
    {name = "Brookhaven", label = "Brookhaven"},
    {name = "ClientAudio", label = "Client Audio"},
    {name = "Scripts", label = "Scripts"},
    {name = "Credits", label = "Credits"}
}
local tabFrames = {}
local tabButtons = {}
local selectedTab = 1
local minimized = false
local brookhavenActive = false
local isClientAudio, isLoop, currentVolume, currentPitch = false, false, 1, 1

local function showTab(idx)
    for i, frame in ipairs(tabFrames) do frame.Visible = not minimized and (i == idx) end
end

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabScroll)
    btn.Size = UDim2.new(0, 116, 0, 32)
    btn.Text = tab.label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = violet
    btn.BackgroundColor3 = accentBg
    btn.ZIndex = 6
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    styleButton(btn)
    btn.MouseButton1Click:Connect(function()
        selectedTab = i
        showTab(i)
    end)
    tabButtons[i] = btn
    local frame = Instance.new("Frame", mainFrame)
    frame.Size = UDim2.new(1, -32, 1, -110)
    frame.Position = UDim2.new(0, 16, 0, 104)
    frame.BackgroundColor3 = accentBg
    frame.Visible = (i == 1)
    frame.ZIndex = 10
    tabFrames[i] = frame
end

local minimized = false
local function setMinimized(m)
    minimized = m
    mainFrame.Visible = not minimized
    tabsBar.Visible = not minimized
    tabScroll.Visible = not minimized
    roundMinBtn.Visible = true
    if minimized then
        mainFrame.Size = UDim2.new(0,380,0,60)
    else
        mainFrame.Size = UDim2.new(0,380,0,510)
    end
    for i, frame in ipairs(tabFrames) do
        frame.Visible = not minimized and (i == selectedTab)
    end
end

roundMinBtn.MouseButton1Click:Connect(function()
    setMinimized(not minimized)
end)

local confirmFrame = nil
local function showConfirm(closeFunc)
    if confirmFrame then confirmFrame:Destroy() end
    confirmFrame = Instance.new("Frame", screenGui)
    confirmFrame.Size = UDim2.new(0, 240, 0, 110)
    confirmFrame.Position = UDim2.new(0.5, -120, 0.5, -55)
    confirmFrame.BackgroundColor3 = accentBg
    confirmFrame.ZIndex = 9999
    Instance.new("UICorner", confirmFrame).CornerRadius = UDim.new(0, 18)
    local label = Instance.new("TextLabel", confirmFrame)
    label.Text = "ARE YOU SURE?"
    label.Size = UDim2.new(1,0,0,36)
    label.Position = UDim2.new(0,0,0,8)
    label.TextColor3 = white
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.BackgroundTransparency = 1
    label.ZIndex = 9999
    createGradientAnim(label, ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }, 1.5)
    local yesBtn = Instance.new("TextButton", confirmFrame)
    yesBtn.Text = "YES"
    yesBtn.Size = UDim2.new(0.45,-12,0,32)
    yesBtn.Position = UDim2.new(0.05,0,0,60)
    yesBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
    yesBtn.TextColor3 = white
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextSize = 17
    yesBtn.ZIndex = 10000
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(1,0)
    styleButton(yesBtn,ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }, 1.5)
    local nahBtn = Instance.new("TextButton", confirmFrame)
    nahBtn.Text = "NO"
    nahBtn.Size = UDim2.new(0.45,-12,0,32)
    nahBtn.Position = UDim2.new(0.5,12,0,60)
    nahBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
    nahBtn.TextColor3 = white
    nahBtn.Font = Enum.Font.GothamBold
    nahBtn.TextSize = 17
    nahBtn.ZIndex = 10000
    Instance.new("UICorner", nahBtn).CornerRadius = UDim.new(1,0)
    styleButton(nahBtn,ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }, 1.5)
    yesBtn.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
        closeFunc()
    end)
    nahBtn.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end

closeBtn.MouseButton1Click:Connect(function()
    showConfirm(function()
        for _, s in ipairs(soundFolder:GetChildren()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
        screenGui:Destroy()
        if soundFolder then soundFolder:Destroy() end
    end)
end)

local notificationBar = nil
local notificationConn = nil
local lastNotifType = 0
local notifTimer = nil
local function showMusicNotification(musicName, duration, isLoop, sound)
    if notificationConn then notificationConn:Disconnect() end
    if notificationBar then notificationBar:Destroy() end
    notificationBar = Instance.new("Frame", screenGui)
    notificationBar.Size = UDim2.new(0, 340, 0, 64)
    notificationBar.Position = UDim2.new(0, 705, 0, 10)
    notificationBar.BackgroundColor3 = accentBg
    notificationBar.BorderSizePixel = 0
    notificationBar.ZIndex = 9999
    local corner = Instance.new("UICorner", notificationBar)
    corner.CornerRadius = UDim.new(0,16)
    local stroke = Instance.new("UIStroke", notificationBar)
    stroke.Thickness = 3
    stroke.Transparency = 0.1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = violet
    local gradStroke = Instance.new("UIGradient", stroke)
    gradStroke.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }
    spawn(function()
        local t0 = tick()
        while gradStroke.Parent do gradStroke.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.8),0) wait(0.03) end
    end)
    local nameLabel = Instance.new("TextLabel", notificationBar)
    nameLabel.Size = UDim2.new(1, -10, 0, 34)
    nameLabel.Position = UDim2.new(0,5,0,5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = musicName
    nameLabel.TextColor3 = violet
    nameLabel.TextSize = 22
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.ZIndex = 9999
    nameLabel.TextWrapped = true
    createGradientAnim(nameLabel, ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }, 1.5)
    local durLabel = Instance.new("TextLabel", notificationBar)
    durLabel.Size = UDim2.new(1, -10, 0, 22)
    durLabel.Position = UDim2.new(0,5,0,38)
    durLabel.BackgroundTransparency = 1
    durLabel.TextColor3 = violet
    durLabel.TextSize = 16
    durLabel.Font = Enum.Font.Gotham
    durLabel.ZIndex = 9999
    durLabel.TextWrapped = true
    createGradientAnim(durLabel, ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
    }, 1.5)
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

local function getMusicNotificationActive()
    return notificationBar and notificationBar.Parent
end

local function showCustomNotification(msg, gradColors)
    gradColors = gradColors or ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white)
    }
    local position = getMusicNotificationActive() and UDim2.new(0,705,0,84) or UDim2.new(0,705,0,10)
    local alertBar = Instance.new("Frame", screenGui)
    alertBar.Size = UDim2.new(0,340,0,64)
    alertBar.Position = position
    alertBar.BackgroundColor3 = accentBg
    alertBar.BorderSizePixel = 0
    alertBar.ZIndex = 9998
    Instance.new("UICorner", alertBar).CornerRadius = UDim.new(0,16)
    local stroke = Instance.new("UIStroke", alertBar)
    stroke.Thickness = 3
    stroke.Transparency = 0.1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = white
    local gradStroke = Instance.new("UIGradient", stroke)
    gradStroke.Color = gradColors
    spawn(function()
        local t0 = tick()
        while gradStroke.Parent do gradStroke.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.8),0) wait(0.03) end
    end)
    local msgLabel = Instance.new("TextLabel", alertBar)
    msgLabel.Size = UDim2.new(1,-10,1,-10)
    msgLabel.Position = UDim2.new(0,5,0,5)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = msg
    msgLabel.TextColor3 = white
    msgLabel.TextSize = 17
    msgLabel.Font = Enum.Font.GothamBold
    msgLabel.ZIndex = 9998
    msgLabel.TextWrapped = true
    local gradMsg = Instance.new("UIGradient", msgLabel)
    gradMsg.Color = gradColors
    alertBar.BackgroundTransparency = 1
    msgLabel.TextTransparency = 1
    tweenService:Create(alertBar, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{BackgroundTransparency=0.09}):Play()
    tweenService:Create(msgLabel, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()
    delay(7,function()
        tweenService:Create(alertBar, TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundTransparency=1}):Play()
        tweenService:Create(msgLabel, TweenInfo.new(0.18,Enum.EasingStyle.Quart),{TextTransparency=1}):Play()
        wait(0.3)
        if alertBar then alertBar:Destroy() end
    end)
end

local function periodicNotifications()
    if notifTimer then notifTimer:Disconnect() end
    local function notify()
        lastNotifType = lastNotifType % 2 + 1
        if lastNotifType == 1 then
            showCustomNotification("Thank you for using Auralynx 💜!")
        else
            showCustomNotification("💎 Get your Premium subscription now on our Discord server!")
        end
    end
    notify()
    notifTimer = runService.RenderStepped:Connect(function()
        if not screenGui.Parent then notifTimer:Disconnect() notifTimer = nil return end
    end)
    spawn(function()
        while screenGui.Parent do wait(120) notify() end
    end)
end

periodicNotifications()

local playingSound = nil
local function stopAllClientSounds()
    for _, s in ipairs(soundFolder:GetChildren()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
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
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Pitch = currentPitch
    sound.Name = tostring(id)
    sound.Parent = soundFolder
    sound:Play()
    playingSound = sound
    local musicName = nil
    for num, audioId in pairs(musicIDs) do if audioId == id then musicName = musicNames[num] break end end
    musicName = musicName or ("Audio "..id)
    sound.Loaded:Connect(function()
        local length = sound.TimeLength or 0
        local pitch = currentPitch or 1
        if pitch == 0 then pitch = 1 end
        showMusicNotification(musicName, length/pitch, isLoop, sound)
    end)
    return sound
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
    for i = 1, 59 do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 105, 0, 44)
        btn.Text = tostring(i)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 20
        btn.TextColor3 = violet
        btn.BackgroundColor3 = accentBg
        btn.ZIndex = 12
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        styleButton(btn)
        btn.Parent = mainScroll
        btn.MouseButton1Click:Connect(function()
            local id = tonumber(musicIDs[tostring(i)])
            if isClientAudio then
                playClientAudio(id)
            else
                if brookhavenActive then
                    local rep = game:GetService("ReplicatedStorage")
                    local function playBrookhavenRemote(tipo)
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
                    local selectorPopup = screenGui:FindFirstChild("SelectorPopup")
                    if selectorPopup then selectorPopup:Destroy() end
                    selectorPopup = Instance.new("Frame", screenGui)
                    selectorPopup.Name = "SelectorPopup"
                    selectorPopup.Size = UDim2.new(0, 240, 0, 60)
                    selectorPopup.Position = UDim2.new(0.5, -120, 0.5, -30)
                    selectorPopup.BackgroundColor3 = accentBg
                    selectorPopup.ZIndex = 5000
                    Instance.new("UICorner", selectorPopup).CornerRadius = UDim.new(0, 12)
                    local titleLabel = Instance.new("TextLabel", selectorPopup)
                    titleLabel.Text = "CHOOSE TYPE:"
                    titleLabel.Size = UDim2.new(1, 0, 0, 20)
                    titleLabel.Position = UDim2.new(0, 0, 0, 0)
                    titleLabel.BackgroundTransparency = 1
                    titleLabel.TextColor3 = violet
                    titleLabel.Font = Enum.Font.GothamBold
                    titleLabel.TextSize = 16
                    titleLabel.ZIndex = 5001
                    createGradientAnim(titleLabel, ColorSequence.new{
                        ColorSequenceKeypoint.new(0, violet),
                        ColorSequenceKeypoint.new(1.0, white),
                        
                    }, 1.5)
                    local btnsFrame = Instance.new("Frame", selectorPopup)
                    btnsFrame.BackgroundTransparency = 1
                    btnsFrame.Position = UDim2.new(0, 8, 0, 22)
                    btnsFrame.Size = UDim2.new(1, 0, 0, 36)
                    btnsFrame.ZIndex = 5002
                    local hLayout = Instance.new("UIListLayout", btnsFrame)
                    hLayout.FillDirection = Enum.FillDirection.Horizontal
                    hLayout.Padding = UDim.new(0, 6)
                    for _, tipo in ipairs({"🚗","🛴","🛵","📻","🏠"}) do
                        local tbtn = Instance.new("TextButton", btnsFrame)
                        tbtn.Text = tipo
                        tbtn.Size = UDim2.new(0, 40, 1, 0)
                        tbtn.BackgroundColor3 = accentBg
                        tbtn.TextColor3 = violet
                        tbtn.Font = Enum.Font.GothamBold
                        tbtn.TextSize = 19
                        tbtn.ZIndex = 5003
                        Instance.new("UICorner", tbtn).CornerRadius = UDim.new(0, 8)
                        styleButton(tbtn)
                        tbtn.MouseButton1Click:Connect(function()
                            if selectorPopup then selectorPopup:Destroy() end
                            playBrookhavenRemote(tipo)
                        end)
                    end
                else
                    if player.Character then
                        for _, obj in ipairs(player.Character:GetDescendants()) do
                            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                                local argsList = {{id}, {"PlaySong", id}, {"Play", id}, {id, true}}
                                for _, args in ipairs(argsList) do
                                    pcall(function()
                                        if obj:IsA("RemoteEvent") then
                                            obj:FireServer(unpack(args))
                                        elseif obj:IsA("RemoteFunction") then
                                            obj:InvokeServer(unpack(args))
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
    local idsInput = Instance.new("TextBox", idsFrame)
    idsInput.PlaceholderText = "Enter ID here..."
    idsInput.Size = UDim2.new(0.62, -10, 0, 36)
    idsInput.Position = UDim2.new(0, 14, 1, -48)
    idsInput.BackgroundColor3 = accentBg
    idsInput.TextColor3 = violet
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
    idsPlayBtn.TextColor3 = violet
    idsPlayBtn.Font = Enum.Font.GothamBold
    idsPlayBtn.TextSize = 16
    idsPlayBtn.ZIndex = 13
    idsPlayBtn.AutoButtonColor = true
    Instance.new("UICorner", idsPlayBtn).CornerRadius = UDim.new(1, 0)
    styleButton(idsPlayBtn)
    idsPlayBtn.MouseButton1Click:Connect(function()
        local input = idsInput.Text:gsub("rbxassetid://", "")
        local id = tonumber(input)
        if not id then return end
        if isClientAudio then
            playClientAudio(id)
        else
            if brookhavenActive then
                local rep = game:GetService("ReplicatedStorage")
                local function playBrookhavenRemote(tipo)
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
                local selectorPopup = screenGui:FindFirstChild("SelectorPopup")
                if selectorPopup then selectorPopup:Destroy() end
                selectorPopup = Instance.new("Frame", screenGui)
                selectorPopup.Name = "SelectorPopup"
                selectorPopup.Size = UDim2.new(0, 240, 0, 60)
                selectorPopup.Position = UDim2.new(0.5, -120, 0.5, -30)
                selectorPopup.BackgroundColor3 = accentBg
                selectorPopup.ZIndex = 5000
                Instance.new("UICorner", selectorPopup).CornerRadius = UDim.new(0, 12)
                local titleLabel = Instance.new("TextLabel", selectorPopup)
                titleLabel.Text = "CHOOSE TYPE:"
                titleLabel.Size = UDim2.new(1, 0, 0, 20)
                titleLabel.Position = UDim2.new(0, 0, 0, 0)
                titleLabel.BackgroundTransparency = 1
                titleLabel.TextColor3 = violet
                titleLabel.Font = Enum.Font.GothamBold
                titleLabel.TextSize = 16
                titleLabel.ZIndex = 5001
                createGradientAnim(titleLabel, ColorSequence.new{
                    ColorSequenceKeypoint.new(0, violet),
                    ColorSequenceKeypoint.new(1.0, white),
                    
                }, 1.5)
                local btnsFrame = Instance.new("Frame", selectorPopup)
                btnsFrame.BackgroundTransparency = 1
                btnsFrame.Position = UDim2.new(0, 8, 0, 22)
                btnsFrame.Size = UDim2.new(1, 0, 0, 36)
                btnsFrame.ZIndex = 5002
                local hLayout = Instance.new("UIListLayout", btnsFrame)
                hLayout.FillDirection = Enum.FillDirection.Horizontal
                hLayout.Padding = UDim.new(0, 6)
                for _, tipo in ipairs({"🚗","🛴","🛵","📻","🏠"}) do
                    local tbtn = Instance.new("TextButton", btnsFrame)
                    tbtn.Text = tipo
                    tbtn.Size = UDim2.new(0, 40, 1, 0)
                    tbtn.BackgroundColor3 = accentBg
                    tbtn.TextColor3 = violet
                    tbtn.Font = Enum.Font.GothamBold
                    tbtn.TextSize = 19
                    tbtn.ZIndex = 5003
                    Instance.new("UICorner", tbtn).CornerRadius = UDim.new(0, 8)
                    styleButton(tbtn)
                    tbtn.MouseButton1Click:Connect(function()
                        if selectorPopup then selectorPopup:Destroy() end
                        playBrookhavenRemote(tipo)
                    end)
                end
            else
                if player.Character then
                    for _, obj in ipairs(player.Character:GetDescendants()) do
                        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                            local argsList = {{id}, {"PlaySong", id}, {"Play", id}, {id, true}}
                            for _, args in ipairs(argsList) do
                                pcall(function()
                                    if obj:IsA("RemoteEvent") then
                                        obj:FireServer(unpack(args))
                                    elseif obj:IsA("RemoteFunction") then
                                        obj:InvokeServer(unpack(args))
                                    end
                                end)
                            end
                        end
                    end
                end
            end
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
    musicScroll.ZIndex = 14
    local musicListLayout = Instance.new("UIListLayout", musicScroll)
    musicListLayout.Padding = UDim.new(0,8)
    musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    for k = 1, 59 do
        local lbl = Instance.new("TextLabel", musicScroll)
        lbl.Size = UDim2.new(1, -10, 0, 28)
        lbl.BackgroundTransparency = 1
        lbl.Text = "["..k.."] - "..musicNames[tostring(k)]
        lbl.Font = Enum.Font.GothamBold
        lbl.TextColor3 = violet
        lbl.TextSize = 15
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 14
        createGradientAnim(lbl, ColorSequence.new{
            ColorSequenceKeypoint.new(0, violet),
            ColorSequenceKeypoint.new(1.0, white),
            
        }, 1.5)
    end
end

do
    local brookFrame = tabFrames[3]
    local brookToggle = Instance.new("TextButton", brookFrame)
    brookToggle.Size = UDim2.new(1, -20, 0, 40)
    brookToggle.Position = UDim2.new(0, 10, 0, 18)
    brookToggle.BackgroundColor3 = accentBg
    brookToggle.TextColor3 = violet
    brookToggle.Font = Enum.Font.GothamBold
    brookToggle.TextSize = 18
    brookToggle.ZIndex = 21
    brookToggle.Text = "Activate Brookhaven: Off"
    Instance.new("UICorner", brookToggle).CornerRadius = UDim.new(1, 0)
    styleButton(brookToggle)
    brookToggle.MouseButton1Click:Connect(function()
        brookhavenActive = not brookhavenActive
        brookToggle.Text = "Activate Brookhaven: " .. (brookhavenActive and "On" or "Off")
    end)
    local descLbl = Instance.new("TextLabel", brookFrame)
    descLbl.Size = UDim2.new(1, -20, 0, 28)
    descLbl.Position = UDim2.new(0, 10, 0, 65)
    descLbl.BackgroundTransparency = 1
    descLbl.TextColor3 = violet
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextSize = 12
    descLbl.Text = "It will only work if you are in brookhaven."
    descLbl.ZIndex = 22
    createGradientAnim(descLbl, ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
        
    }, 1.5)
end

do
    local clientAudioFrame = tabFrames[4]
    local clientAudioToggleBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioToggleBtn.Size = UDim2.new(1, -20, 0, 36)
    clientAudioToggleBtn.Position = UDim2.new(0, 10, 0, 10)
    clientAudioToggleBtn.BackgroundColor3 = accentBg
    clientAudioToggleBtn.TextColor3 = violet
    clientAudioToggleBtn.Font = Enum.Font.GothamBold
    clientAudioToggleBtn.TextSize = 15
    clientAudioToggleBtn.ZIndex = 15
    Instance.new("UICorner", clientAudioToggleBtn).CornerRadius = UDim.new(1, 0)
    styleButton(clientAudioToggleBtn)
    clientAudioToggleBtn.Text = "Client Audio: Off"
    local clientAudioLoopBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioLoopBtn.Text = "Loop: NO"
    clientAudioLoopBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioLoopBtn.Position = UDim2.new(0, 10, 0, 56)
    clientAudioLoopBtn.BackgroundColor3 = accentBg
    clientAudioLoopBtn.TextColor3 = violet
    clientAudioLoopBtn.Font = Enum.Font.GothamBold
    clientAudioLoopBtn.TextSize = 13
    clientAudioLoopBtn.ZIndex = 15
    clientAudioLoopBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioLoopBtn).CornerRadius = UDim.new(1, 0)
    styleButton(clientAudioLoopBtn)
    local clientAudioVolumeBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)
    clientAudioVolumeBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioVolumeBtn.Position = UDim2.new(0.5, 8, 0, 56)
    clientAudioVolumeBtn.BackgroundColor3 = accentBg
    clientAudioVolumeBtn.TextColor3 = violet
    clientAudioVolumeBtn.Font = Enum.Font.GothamBold
    clientAudioVolumeBtn.TextSize = 13
    clientAudioVolumeBtn.ZIndex = 15
    clientAudioVolumeBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioVolumeBtn).CornerRadius = UDim.new(1, 0)
    styleButton(clientAudioVolumeBtn)
    local clientAudioPitchBtn = Instance.new("TextButton", clientAudioFrame)
    clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)
    clientAudioPitchBtn.Size = UDim2.new(0.5, -14, 0, 30)
    clientAudioPitchBtn.Position = UDim2.new(0, 10, 0, 96)
    clientAudioPitchBtn.BackgroundColor3 = accentBg
    clientAudioPitchBtn.TextColor3 = violet
    clientAudioPitchBtn.Font = Enum.Font.GothamBold
    clientAudioPitchBtn.TextSize = 13
    clientAudioPitchBtn.ZIndex = 15
    clientAudioPitchBtn.Visible = isClientAudio
    Instance.new("UICorner", clientAudioPitchBtn).CornerRadius = UDim.new(1, 0)
    styleButton(clientAudioPitchBtn)
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
        local vols = {0.5, 0.75, 1, 1.5, 2, 2.5}
        local idx = table.find(vols, currentVolume) or 3
        idx = idx % #vols + 1
        currentVolume = vols[idx]
        clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)
        if playingSound then playingSound.Volume = currentVolume end
    end)
    clientAudioPitchBtn.MouseButton1Click:Connect(function()
        local pits = {0.5, 0.75, 1}
        local idx = table.find(pits, currentPitch) or 3
        idx = idx % #pits + 1
        currentPitch = pits[idx]
        clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)
        if playingSound then playingSound.Pitch = currentPitch end
    end)
end

do
    local scriptsFrame = tabFrames[5]
    local scriptScroll = Instance.new("ScrollingFrame", scriptsFrame)
    scriptScroll.Size = UDim2.new(1, -24, 1, -24)
    scriptScroll.Position = UDim2.new(0, 12, 0, 12)
    scriptScroll.BackgroundTransparency = 1
    scriptScroll.CanvasSize = UDim2.new(0,0,0,0)
    scriptScroll.ScrollBarThickness = 6
    scriptScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scriptScroll.ZIndex = 17
    local scriptListLayout = Instance.new("UIListLayout", scriptScroll)
    scriptListLayout.Padding = UDim.new(0,8)
    scriptListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local scripts = {
        {name="Execute Auralynx Premium", url="https://raw.githubusercontent.com/TheAnnonimated/freeman/main/veri.lua", dc="https://discord.gg/aqjca9xb3", color=nil},
        {name="Execute Coquette Hub", url="https://ghostbin.axel.org/paste/vkhh2/raw", dc="https://discord.gg/9w4UQp9y", color=nil},
        {name="Execute Demon Hub", url="https://coderawv2.vercel.app/api/raw?id=-Ocx9Pwtsl7r3vfy_Per", dc="https://discord.gg/9WfeEcr2J", color=nil},
        {name="Execute Nameless Admin", url="https://rawscripts.net/raw/Universal-Script-Nameless-admin-REWORKED-43502", dc="https://discord.gg/nfGKK4QF", color=nil},
        {name="Execute Shadow Hub", url="https://coderawv2.vercel.app/api/raw?id=-Od4Bqe0_QJoDQEel04h", dc="https://discord.gg/vFZtvBBk", color=ColorSequence.new{
            ColorSequenceKeypoint.new(0, pink),
            ColorSequenceKeypoint.new(1, purple)
        }, isShadow=true},
        {name="Execute AFEM", url="https://rawscripts.net/raw/Universal-Script-AFEM-Max-Open-Alpha-50210", dc="https://discord.gg/notfound", color=nil}
    }
    local helpFrame = nil
    local function showHelp(dcLink, customColor, isShadow)
        if helpFrame then helpFrame:Destroy() end
        helpFrame = Instance.new("Frame", screenGui)
        helpFrame.Size = UDim2.new(0, 320, 0, 110)
        helpFrame.Position = UDim2.new(0.5, -160, 0.5, -55)
        helpFrame.BackgroundColor3 = isShadow and purple or black
        helpFrame.ZIndex = 9999
        Instance.new("UICorner", helpFrame).CornerRadius = UDim.new(0, 18)
        local label = Instance.new("TextLabel", helpFrame)
        label.Text = "Help the script grow, join their Discord server!"
        label.Size = UDim2.new(1,0,0,50)
        label.Position = UDim2.new(0,0,0,8)
        label.TextColor3 = white
        label.Font = Enum.Font.GothamBold
        label.TextSize = 14
        label.BackgroundTransparency = 1
        label.ZIndex = 9999
        local seq = isShadow and ColorSequence.new{
            ColorSequenceKeypoint.new(0, pink),
            ColorSequenceKeypoint.new(1, purple),
        } or ColorSequence.new{
            ColorSequenceKeypoint.new(0, violet),
            ColorSequenceKeypoint.new(1, white)
        }
        createGradientAnim(label, seq, 1.5)
        local copyBtn = Instance.new("TextButton", helpFrame)
        copyBtn.Text = "Copy Discord"
        copyBtn.Size = UDim2.new(0.7,0,0,36)
        copyBtn.Position = UDim2.new(0.15,0,0,60)
        copyBtn.BackgroundColor3 = isShadow and pink or violet
        copyBtn.TextColor3 = black
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.TextSize = 17
        copyBtn.ZIndex = 9999
        Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(1,0)
        styleButton(copyBtn, seq)
        copyBtn.MouseButton1Click:Connect(function()
            setclipboard(dcLink)
            helpFrame:Destroy()
            helpFrame = nil
        end)
    end
    for i, script in ipairs(scripts) do
        local btn = Instance.new("TextButton", scriptScroll)
        btn.Size = UDim2.new(1, -10, 0, 38)
        btn.BackgroundColor3 = accentBg
        btn.TextColor3 = violet
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 15
        btn.ZIndex = 17
        btn.Text = script.name
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        styleButton(btn, script.color)
        btn.MouseButton1Click:Connect(function()
            showHelp(script.dc, script.color, script.isShadow)
            loadstring(game:HttpGet(script.url))()
        end)
    end
end

do
    local creditsFrame = tabFrames[6]
    local creditsLabel = Instance.new("TextLabel", creditsFrame)
    creditsLabel.Size = UDim2.new(1, -16, 1, -60)
    creditsLabel.Position = UDim2.new(0, 8, 0, 8)
    creditsLabel.Text = "Made by Lynxdev.\nAuralynx © 2025."
    creditsLabel.Font = Enum.Font.GothamBold
    creditsLabel.TextColor3 = violet
    creditsLabel.TextSize = 16
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.ZIndex = 18
    createGradientAnim(creditsLabel, ColorSequence.new{
        ColorSequenceKeypoint.new(0, violet),
        ColorSequenceKeypoint.new(1.0, white),
        
    }, 1.5)
    local discordBtn = Instance.new("TextButton", creditsFrame)
    discordBtn.Size = UDim2.new(1, -20, 0, 38)
    discordBtn.Position = UDim2.new(0, 10, 1, -48)
    discordBtn.BackgroundColor3 = accentBg
    discordBtn.TextColor3 = violet
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 15
    discordBtn.ZIndex = 18
    discordBtn.Text = "Discord"
    Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(1, 0)
    styleButton(discordBtn)
    discordBtn.MouseButton1Click:Connect(function()
        setclipboard(discordInvite)
    end)
end

showTab(selectedTab)
local orange = Color3.fromRGB(255,140,0)
local white = Color3.fromRGB(255,255,255)
local darkBg = Color3.fromRGB(15,15,15)
local accentBg = Color3.fromRGB(30,30,30)

local musicIDs = {
    ["1"] = 94718473830640, ["2"] = 92209428926055, ["3"] = 133900561957103, ["4"] = 93768636184697,
    ["5"] = 92062588329352, ["6"] = 84773737820526, ["7"] = 87783857221289, ["8"] = 88342296270082,
    ["9"] = 85342086082111, ["10"] = 93058983119992, ["11"] = 92492039534399, ["12"] = 134035788881796,
    ["13"] = 18841893567, ["14"] = 73962723234161, ["15"] = 140268583413209, ["16"] = 77741294709660,
    ["17"] = 71531533552899, ["18"] = 16190782181, ["19"] = 117169209277972, ["20"] = 81299332131868,
    ["21"] = 77147911349059, ["22"] = 124092830839928, ["23"] = 122854357582130, ["24"] = 88094479399489,
    ["25"] = 88339486019486, ["26"] = 97765714111493, ["27"] = 92446612272052, ["28"] = 74366765967475,
    ["29"] = 112068892721408, ["30"] = 112143944982807, ["31"] = 111668097052966, ["32"] = 112214814544629,
    ["33"] = 101500915434329, ["34"] = 95046091312570, ["35"] = 110091098283354, ["36"] = 17422156627, ["37"] = 82411642961457, ["38"] = 87022583947683, ["39"] = 96974354995715, ["40"] = 119020235792430, ["41"] = 82411642961457, ["42"] = 96215620202470
}
local musicNames = {
    ["1"] = "Funk da Febre", ["2"] = "Switch The Colors (Jersey Club)", ["3"] = "Trash Funk",
    ["4"] = "2609 (Jersey Club)", ["5"] = "Spooky Scary Sunday (Jersey Club)", ["6"] = "ANOTE AÍ",
    ["7"] = "Temptation", ["8"] = "Ela Tano", ["9"] = "Seu fã",
    ["10"] = "MONTAGEM ECLIPSE ESTRELAR", ["11"] = "Em Dezembro de 81 - Flamengo",
    ["12"] = "Esquema Confirmado - Arrocha", ["13"] = "JERSEY WAVE", ["14"] = "Arrepia XL 2",
    ["15"] = "Meepcity (Jersey Club)", ["16"] = "Manda Meu Passinho", ["17"] = "Lembro até hoje",
    ["18"] = "HR - EEYUH!", ["19"] = "I love ha", ["20"] = "SHE DON'T - Lonelybwoi",
    ["21"] = "NY Drill Ritual", ["22"] = "It Doesn't Matter (Jersey Club)", ["23"] = "69 PHONK",
    ["24"] = "Ela se envolveu", ["25"] = "Montagem Pose", ["26"] = "Trem Fantasma Funk",
    ["27"] = "MTG ZUM ZUM ZUM", ["28"] = "EU NÃO ESTOU LOUCO", ["29"] = "FUNK DA PRAIA (SLOWED)",
    ["30"] = "Hogo Funk", ["31"] = "Novinha sapeca", ["32"] = "ANALOG HORROR FUNK",
    ["33"] = "Dum Dum", ["34"] = "Rebola pro pai", ["35"] = "Carro Bixo",
    ["36"] = "Onichan", ["37"] = "Arrepia XL 6", ["38"] = "Mandrake", ["39"] = "Toma Toma", ["40"] = "Lá no meu barraco", ["41"] = "Batida SP", ["42"] = "Funk SP"
}

local langs = {
    en = {
        hubTitle = "Freeman Hub - Music",
        halloween = "Halloween Update!",
        play = "PLAY",
        loop = "Loop: NO",
        loopY = "Loop: YES",
        list = "Music List",
        settings = "Settings",
        credits = "Credits",
        muteBoombox = "Mute all Boomboxes",
        unmuteBoombox = "Unmute all Boomboxes",
        muteGame = "Mute all Gamesounds",
        unmuteGame = "Unmute all Gamesounds",
        volume = "Volume",
        pitch = "Pitch",
        selectVolume = "Choose Volume:",
        selectPitch = "Choose Pitch:",
        welcome = "Welcome to Freeman Hub 🎵🎃 V15!",
        thanks = "Made by Freeman4i37\nThanks for using the script.\n🎃",
        invalidId = "INVALID ID.",
        listening = "Listening: ",
        input = "Put ID here...",
        clientAudio = "Client Audio"
    },
    br = {
        hubTitle = "Freeman Hub - Música",
        halloween = "Atualização de Halloween!",
        play = "TOCAR",
        loop = "Loop: NÃO",
        loopY = "Loop: SIM",
        list = "Lista de Músicas",
        settings = "Configurações",
        credits = "Créditos",
        muteBoombox = "Silenciar todos os boomboxes",
        unmuteBoombox = "Ativar todos os boomboxes",
        muteGame = "Silenciar todos os Gamesounds",
        unmuteGame = "Ativar todos os Gamesounds",
        volume = "Volume",
        pitch = "Tom",
        selectVolume = "Escolha o Volume:",
        selectPitch = "Escolha o Tom:",
        welcome = "Bem-vindo(a) ao Freeman Hub 🎵🎃 V15!",
        thanks = "Feito por Freeman4i37\nObrigado por usar o script.\n🎃",
        invalidId = "ID INVÁLIDO.",
        listening = "Escutando: ",
        input = "Coloque o ID aqui...",
        clientAudio = "Áudio Local"
    }
}
local lang = "en"
local L = function(key) return langs[lang][key] end

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local soundFolder = workspace:FindFirstChild("FreemanClientSounds") or Instance.new("Folder", workspace)
soundFolder.Name = "FreemanClientSounds"
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanMusicHub"
screenGui.ResetOnSpawn = false
local parentUi = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
screenGui.Parent = parentUi

local mainFrame = Instance.new("Frame")
mainFrame.Name = "FreemanMusicMain"
mainFrame.Size = UDim2.new(0, 360, 0, 490)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = darkBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = orange
mainStroke.Thickness = 2
mainStroke.Transparency = 0.7
local grad = Instance.new("UIGradient", mainStroke)
grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, orange), ColorSequenceKeypoint.new(0.5, white), ColorSequenceKeypoint.new(1, orange)}
grad.Rotation = 0
spawn(function() while mainFrame and grad do grad.Rotation = (grad.Rotation + 2) % 360 wait(0.03) end end)

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundTransparency = 1
header.Position = UDim2.new(0,0,0,0)
header.Name = "Header"
header.ZIndex = 2
local pumpkinIcon = Instance.new("TextLabel", header)
pumpkinIcon.Text = "🎃"
pumpkinIcon.Font = Enum.Font.GothamBlack
pumpkinIcon.TextSize = 34
pumpkinIcon.TextColor3 = orange
pumpkinIcon.Size = UDim2.new(0, 44, 0, 44)
pumpkinIcon.Position = UDim2.new(0, 0, 0, 0)
pumpkinIcon.BackgroundTransparency = 1
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = L("hubTitle")
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 17
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -130, 0, 28)
headerTitle.Position = UDim2.new(0, 44, 0, 0)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
local halloweenUpdate = Instance.new("TextLabel", header)
halloweenUpdate.Text = L("halloween")
halloweenUpdate.Font = Enum.Font.GothamBold
halloweenUpdate.TextSize = 17
halloweenUpdate.TextColor3 = orange
halloweenUpdate.BackgroundTransparency = 1
halloweenUpdate.Size = UDim2.new(1, -130, 0, 24)
halloweenUpdate.Position = UDim2.new(0, 44, 0, 28)
halloweenUpdate.TextXAlignment = Enum.TextXAlignment.Left
local langButton = Instance.new("TextButton", header)
langButton.Size = UDim2.new(0, 36, 0, 36)
langButton.Position = UDim2.new(1, -132, 0, 8)
langButton.BackgroundColor3 = accentBg
langButton.Text = "🇱🇷"
langButton.TextColor3 = orange
langButton.Font = Enum.Font.GothamBold
langButton.TextSize = 20
Instance.new("UICorner", langButton).CornerRadius = UDim.new(1, 0)
local langBtnStroke = Instance.new("UIStroke", langButton)
langBtnStroke.Color = orange
langBtnStroke.Thickness = 1.25
langBtnStroke.Transparency = 0.7
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
dividerGradient.Rotation = 0
spawn(function()
    while divider and dividerGradient do
        dividerGradient.Rotation = (dividerGradient.Rotation + 2) % 360
        wait(0.03)
    end
end)
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
local creditsButton = makeIconBtn(sideBar, "👤", yDelta+100)
local clientAudioTabBtn = makeIconBtn(sideBar, "🎧", yDelta+150)
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
        if s:IsA("Sound") then s:Stop() s:Destroy() end
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
for i = 1, 42 do
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
    local grad = Instance.new("UIGradient", stroke)
    grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, orange),ColorSequenceKeypoint.new(0.5, white),ColorSequenceKeypoint.new(1, orange)})
    grad.Rotation = 0
    spawn(function() while f and grad do grad.Rotation = (grad.Rotation + 2) % 360 wait(0.03) end end)
    return f
end
local creditsFrame = makeSubFrame()
creditsFrame.Parent = mainFrame
local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -16, 1, -16)
creditsLabel.Position = UDim2.new(0, 8, 0, 8)
creditsLabel.Text = L("thanks")
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
for k = 1, 42 do
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
local clientAudioFrame = makeSubFrame()
clientAudioFrame.Parent = mainFrame

local clientAudioToggleBtn = Instance.new("TextButton", clientAudioFrame)
clientAudioToggleBtn.Size = UDim2.new(1, -20, 0, 36)
clientAudioToggleBtn.Position = UDim2.new(0, 10, 0, 10)
clientAudioToggleBtn.BackgroundColor3 = accentBg
clientAudioToggleBtn.TextColor3 = orange
clientAudioToggleBtn.Font = Enum.Font.GothamBold
clientAudioToggleBtn.TextSize = 15
clientAudioToggleBtn.ZIndex = 4
Instance.new("UICorner", clientAudioToggleBtn).CornerRadius = UDim.new(1, 0)
local clientAudioToggleStroke = Instance.new("UIStroke", clientAudioToggleBtn)
clientAudioToggleStroke.Color = orange
clientAudioToggleStroke.Thickness = 1.25
clientAudioToggleStroke.Transparency = 0.7
clientAudioToggleBtn.Text = L("clientAudio")..": "..(isClientAudio and "On" or "Off")

local clientAudioLoopBtn = Instance.new("TextButton", clientAudioFrame)
clientAudioLoopBtn.Text = L("loop")
clientAudioLoopBtn.Size = UDim2.new(0.5, -14, 0, 30)
clientAudioLoopBtn.Position = UDim2.new(0, 10, 0, 56)
clientAudioLoopBtn.BackgroundColor3 = accentBg
clientAudioLoopBtn.TextColor3 = orange
clientAudioLoopBtn.Font = Enum.Font.GothamBold
clientAudioLoopBtn.TextSize = 13
clientAudioLoopBtn.ZIndex = 4
clientAudioLoopBtn.Visible = isClientAudio
Instance.new("UICorner", clientAudioLoopBtn).CornerRadius = UDim.new(1, 0)
local clientAudioLoopStroke = Instance.new("UIStroke", clientAudioLoopBtn)
clientAudioLoopStroke.Color = orange
clientAudioLoopStroke.Thickness = 1.25
clientAudioLoopStroke.Transparency = 0.7
local clientAudioVolumeBtn = Instance.new("TextButton", clientAudioFrame)
clientAudioVolumeBtn.Text = L("volume")..": 1"
clientAudioVolumeBtn.Size = UDim2.new(0.5, -14, 0, 30)
clientAudioVolumeBtn.Position = UDim2.new(0.5, 8, 0, 56)
clientAudioVolumeBtn.BackgroundColor3 = accentBg
clientAudioVolumeBtn.TextColor3 = orange
clientAudioVolumeBtn.Font = Enum.Font.GothamBold
clientAudioVolumeBtn.TextSize = 13
clientAudioVolumeBtn.ZIndex = 4
clientAudioVolumeBtn.Visible = isClientAudio
Instance.new("UICorner", clientAudioVolumeBtn).CornerRadius = UDim.new(1, 0)
local clientAudioVolumeStroke = Instance.new("UIStroke", clientAudioVolumeBtn)
clientAudioVolumeStroke.Color = orange
clientAudioVolumeStroke.Thickness = 1.25
clientAudioVolumeStroke.Transparency = 0.7
local clientAudioPitchBtn = Instance.new("TextButton", clientAudioFrame)
clientAudioPitchBtn.Text = L("pitch")..": 1"
clientAudioPitchBtn.Size = UDim2.new(0.5, -14, 0, 30)
clientAudioPitchBtn.Position = UDim2.new(0, 10, 0, 96)
clientAudioPitchBtn.BackgroundColor3 = accentBg
clientAudioPitchBtn.TextColor3 = orange
clientAudioPitchBtn.Font = Enum.Font.GothamBold
clientAudioPitchBtn.TextSize = 13
clientAudioPitchBtn.ZIndex = 4
clientAudioPitchBtn.Visible = isClientAudio
Instance.new("UICorner", clientAudioPitchBtn).CornerRadius = UDim.new(1, 0)
local clientAudioPitchStroke = Instance.new("UIStroke", clientAudioPitchBtn)
clientAudioPitchStroke.Color = orange
clientAudioPitchStroke.Thickness = 1.25
clientAudioPitchStroke.Transparency = 0.7

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.PlaceholderText = L("input")
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
playBtn.Text = L("play")
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
local boomboxMuted = false
local muteBoomboxButton = Instance.new("TextButton", settingsFrame)
muteBoomboxButton.Size = UDim2.new(1, 0, 0, 40)
muteBoomboxButton.Position = UDim2.new(0, 0, 0, 10)
muteBoomboxButton.Text = L("muteBoombox")
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
                    if s:IsA("Sound") then s.Volume = not boomboxMuted and 0 or 1 end
                end
            end
        end
    end
    boomboxMuted = not boomboxMuted
    muteBoomboxButton.Text = boomboxMuted and L("unmuteBoombox") or L("muteBoombox")
end)
local gameSoundsMuted = false
local muteGameSoundsConn
local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(1, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0, 0, 0, 60)
muteGameSoundsButton.Text = L("muteGame")
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
    muteGameSoundsButton.Text = mute and L("unmuteGame") or L("muteGame")
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
    slideBarFrame.Visible = false
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
    stopAllClientSounds()
    screenGui:Destroy()
    slideBarFrame:Destroy()
    if soundFolder then soundFolder:Destroy() end
    if muteGameSoundsConn then muteGameSoundsConn:Disconnect() muteGameSoundsConn = nil end
end)
local slideBarFrame = Instance.new("Frame", screenGui)
slideBarFrame.Size = UDim2.new(0.4, 0, 0, 36)
slideBarFrame.Position = UDim2.new(0.3, 0, 0, -20)
slideBarFrame.BackgroundTransparency = 1
slideBarFrame.ZIndex = 1000
slideBarFrame.Visible = true
local slideBarBg = Instance.new("Frame", slideBarFrame)
slideBarBg.Size = UDim2.new(1, -40, 0, 10)
slideBarBg.Position = UDim2.new(0, 20, 1, -36)
slideBarBg.BackgroundColor3 = accentBg
slideBarBg.ZIndex = 1011
slideBarBg.BorderSizePixel = 0
Instance.new("UICorner", slideBarBg).CornerRadius = UDim.new(0.5, 4)
local slideBar = Instance.new("Frame", slideBarBg)
slideBar.Size = UDim2.new(0,0,1,0)
slideBar.Position = UDim2.new(0,0,0,0)
slideBar.BackgroundColor3 = orange
slideBar.ZIndex = 1012
slideBar.BorderSizePixel = 0
Instance.new("UICorner", slideBar).CornerRadius = UDim.new(0.5, 4)
local slideTimeLabel = Instance.new("TextLabel", slideBarFrame)
slideTimeLabel.Size = UDim2.new(0, 50, 0, 18)
slideTimeLabel.Position = UDim2.new(0, 0, 1, -30)
slideTimeLabel.BackgroundTransparency = 1
slideTimeLabel.Text = "00:00"
slideTimeLabel.TextColor3 = orange
slideTimeLabel.Font = Enum.Font.GothamBold
slideTimeLabel.TextSize = 13
slideTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
slideTimeLabel.ZIndex = 1010
local slideDurLabel = Instance.new("TextLabel", slideBarFrame)
slideDurLabel.Size = UDim2.new(0, 60, 0, 18)
slideDurLabel.Position = UDim2.new(1, -60, 1, -30)
slideDurLabel.BackgroundTransparency = 1
slideDurLabel.Text = "00:00"
slideDurLabel.TextColor3 = orange
slideDurLabel.Font = Enum.Font.GothamBold
slideDurLabel.TextSize = 13
slideDurLabel.TextXAlignment = Enum.TextXAlignment.Right
slideDurLabel.ZIndex = 1010
runService.RenderStepped:Connect(function()
    if playingSound and playingSound.IsPlaying and playingSound.TimeLength > 0 then
        slideTimeLabel.Text = string.format("%02d:%02d", math.floor(playingSound.TimePosition/60), math.floor(playingSound.TimePosition%60))
        slideDurLabel.Text = string.format("%02d:%02d", math.floor(playingSound.TimeLength/60), math.floor(playingSound.TimeLength%60))
        local progress = math.clamp(playingSound.TimePosition / playingSound.TimeLength,0,1)
        slideBar.Size = UDim2.new(progress,0,1,0)
        slideBarFrame.Visible = true
    else
        slideTimeLabel.Text = "00:00"
        slideDurLabel.Text = "00:00"
        slideBar.Size = UDim2.new(0,0,1,0)
        slideBarFrame.Visible = false
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
    popup:TweenSize(UDim2.new(0, 330, 0, 130), "Out", "Quad", 0.2, true)
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
            popup:TweenSize(UDim2.new(0, 80, 0, 30), "Out", "Quad", 0.13, true)
            wait(0.13)
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
coroutine.wrap(function() showAchievementBar(L("welcome"),4) end)()
if not _G.FreemanAdminUsers then _G.FreemanAdminUsers = {} end
local plr = player
if not table.find(_G.FreemanAdminUsers, plr.Name) then table.insert(_G.FreemanAdminUsers, plr.Name) end
local musicListBtnClicked = false
musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainScroll.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    settingsFrame.Visible = false
    clientAudioFrame.Visible = false
end)
local inSettings = false
settingsButton.MouseButton1Click:Connect(function()
    inSettings = not inSettings
    mainScroll.Visible = not inSettings
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    settingsFrame.Visible = inSettings
    clientAudioFrame.Visible = false
    muteBoomboxButton.Text = boomboxMuted and L("unmuteBoombox") or L("muteBoombox")
    muteGameSoundsButton.Text = gameSoundsMuted and L("unmuteGame") or L("muteGame")
end)
local inCredits = false
creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainScroll.Visible = not inCredits
    creditsFrame.Visible = inCredits
    musicListFrame.Visible = false
    settingsFrame.Visible = false
    clientAudioFrame.Visible = false
end)
local inClientAudio = false
clientAudioTabBtn.MouseButton1Click:Connect(function()
    inClientAudio = not inClientAudio
    mainScroll.Visible = not inClientAudio
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    settingsFrame.Visible = false
    clientAudioFrame.Visible = inClientAudio
end)
mainScroll.Visible = true
musicListFrame.Visible = false
creditsFrame.Visible = false
settingsFrame.Visible = false
clientAudioFrame.Visible = false
clientAudioToggleBtn.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    clientAudioToggleBtn.Text = L("clientAudio")..": "..(isClientAudio and "On" or "Off")
    clientAudioLoopBtn.Visible = isClientAudio
    clientAudioVolumeBtn.Visible = isClientAudio
    clientAudioPitchBtn.Visible = isClientAudio
    if not isClientAudio then stopAllClientSounds() end
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
        local success, info = pcall(function() return MarketplaceService:GetProductInfo(id) end)
        if success and info and info.Name and not foundName then nameGot = info.Name end
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
        showAchievementBar(L("listening") .. nameGot, 6)
    else
        warn(L("invalidId"))
    end
end)
clientAudioLoopBtn.MouseButton1Click:Connect(function()
    isLoop = not isLoop
    clientAudioLoopBtn.Text = isLoop and L("loopY") or L("loop")
    if playingSound then playingSound.Looped = isLoop end
end)
clientAudioVolumeBtn.MouseButton1Click:Connect(function()
    showSelectorPopup(L("selectVolume"), {0.5,0.75,1.0,1.5,2.0}, function(vol)
        currentVolume = vol
        clientAudioVolumeBtn.Text = L("volume")..": "..tostring(currentVolume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Volume = currentVolume end
        end
    end)
end)
clientAudioPitchBtn.MouseButton1Click:Connect(function()
    showSelectorPopup(L("selectPitch"), {0.75,1.0,1.5}, function(pitch)
        currentPitch = pitch
        clientAudioPitchBtn.Text = L("pitch")..": "..tostring(currentPitch)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then s.Pitch = currentPitch end
        end
    end)
end)
langButton.MouseButton1Click:Connect(function()
    lang = (lang == "en" and "br" or "en")
    langButton.Text = (lang == "en") and "🇱🇷" or "🇧🇷"
    headerTitle.Text = L("hubTitle")
    halloweenUpdate.Text = L("halloween")
    inputBox.PlaceholderText = L("input")
    playBtn.Text = L("play")
    muteBoomboxButton.Text = boomboxMuted and L("unmuteBoombox") or L("muteBoombox")
    muteGameSoundsButton.Text = gameSoundsMuted and L("unmuteGame") or L("muteGame")
    creditsLabel.Text = L("thanks")
    clientAudioToggleBtn.Text = L("clientAudio")..": "..(isClientAudio and "On" or "Off")
    clientAudioLoopBtn.Text = isLoop and L("loopY") or L("loop")
    clientAudioVolumeBtn.Text = L("volume")..": "..tostring(currentVolume)
    clientAudioPitchBtn.Text = L("pitch")..": "..tostring(currentPitch)
    for k, v in ipairs(musicScroll:GetChildren()) do
        if v:IsA("TextLabel") then v.Text = "["..k.."] - "..musicNames[tostring(k)] end
    end
end)
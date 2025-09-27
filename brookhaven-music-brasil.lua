local green = Color3.fromRGB(0,255,0)
local white = Color3.fromRGB(255,255,255)
local darkBg = Color3.fromRGB(15,15,15)
local accentBg = Color3.fromRGB(30,30,30)

local musicIDs = {
    ["1"] = 94718473830640, ["2"] = 92209428926055, ["3"] = 133900561957103, ["4"] = 93768636184697,
    ["5"] = 92062588329352, ["6"] = 84773737820526, ["7"] = 87783857221289, ["8"] = 80164463388144,
    ["9"] = 126960081879615, ["10"] = 93058983119992, ["11"] = 92492039534399, ["12"] = 134035788881796,
    ["13"] = 18841893567, ["14"] = 73962723234161, ["15"] = 140268583413209, ["16"] = 77741294709660, ["17"] = 71531533552899, ["18"] = 16190782181, ["19"] = 117169209277972, ["20"] = 81299332131868, ["21"] = 77147911349059, ["22"] = 124092830839928,
}
local musicNames = {
    ["1"] = "Funk da Febre", ["2"] = "Switch The Colors (Jersey Club)", ["3"] = "Trash Funk",
    ["4"] = "2609 (Jersey Club)", ["5"] = "Spooky Scary Sunday (Jersey Club)", ["6"] = "ANOTE AÍ",
    ["7"] = "Temptation", ["8"] = "One Two Step (Jersey Club)", ["9"] = "MONTAGEM LUA INFRATOR",
    ["10"] = "MONTAGEM ECLIPSE ESTRELAR", ["11"] = "Em Dezembro de 81 - Flamengo",
    ["12"] = "Esquema Confirmado - Arrocha", ["13"] = "JERSEY WAVE", ["14"] = "Arrepia XL 2", ["15"] = "Meepcity (Jersey Club)", ["16"] = "Manda Meu Passinho", ["17"] = "Lembro até hoje", ["18"] = "HR - EEYUH!", ["19"] = "I love ha", ["20"] = "SHE DON'T - Lonelybwoi", ["21"] = "NY Drill Ritual", ["22"] = "It Doesn't Matter (Jersey Club)",
}

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanMusicHub"
screenGui.ResetOnSpawn = false
local parentUi = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
screenGui.Parent = parentUi

local mainFrame = Instance.new("Frame")
mainFrame.Name = "FreemanMusicMain"
mainFrame.Size = UDim2.new(0, 360, 0, 430)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = darkBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = green
mainStroke.Thickness = 2
mainStroke.Transparency = 0.7

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1
header.Position = UDim2.new(0,0,0,0)
header.Name = "Header"
header.ZIndex = 2

local divider = Instance.new("Frame", mainFrame)
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 0, 42)
divider.BackgroundColor3 = green
divider.BorderSizePixel = 0
local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, green),
    ColorSequenceKeypoint.new(0.5, white),
    ColorSequenceKeypoint.new(1, green)
})

local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Freeman Hub - Brookhaven"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 20
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -90, 1, 0)
headerTitle.Position = UDim2.new(0, 10, 0, 0)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -44, 0, 4)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = white
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = green
closeBtnStroke.Thickness = 1.25
closeBtnStroke.Transparency = 0.7

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 36, 0, 36)
minimizeBtn.Position = UDim2.new(1, -88, 0, 4)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = white
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local minimizeBtnStroke = Instance.new("UIStroke", minimizeBtn)
minimizeBtnStroke.Color = green
minimizeBtnStroke.Thickness = 1.25
minimizeBtnStroke.Transparency = 0.7

local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 44, 1, -54)
sideBar.Position = UDim2.new(1, -44, 0, 44)
sideBar.BackgroundTransparency = 1
sideBar.ZIndex = 2

local function makeIconBtn(parent, icon, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -8, 0, 36)
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 25
    btn.TextColor3 = white
    btn.BackgroundColor3 = accentBg
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = green
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    return btn
end

local yDelta = 0
local musicListBtn = makeIconBtn(sideBar, "📜", yDelta)
local scriptsButton = makeIconBtn(sideBar, "🔍", yDelta+50)
local creditsButton = makeIconBtn(sideBar, "👤", yDelta+100)

local openIcon = Instance.new("TextButton", screenGui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -55, 1, -55)
openIcon.BackgroundColor3 = green
openIcon.Text = "+"
openIcon.TextSize = 13
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = darkBg
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Visible = false
openIcon.Active = true
openIcon.Draggable = true

local mainScroll = Instance.new("ScrollingFrame", mainFrame)
mainScroll.Position = UDim2.new(0, 12, 0, 54)
mainScroll.Size = UDim2.new(1, -68, 1, -128)
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

local function playMusicRemote(tipo, id)
    local rep = game:GetService("ReplicatedStorage")
    if tipo == "🚘" then
        rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("VehicleMusicPlay", id)
    elseif tipo == "🛹" then
        rep:WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s"):FireServer("PickingScooterMusicText", id)
    elseif tipo == "🏍️" then
        rep:WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer("PickingCarMusicText", id)
    elseif tipo == "📻" then
        rep:WaitForChild("RE"):WaitForChild("PlayerToolEvent"):FireServer("ToolMusicText", id)
    elseif tipo == "🏡" then
        rep:WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer("PickHouseMusicText", id)
    end
end

for i = 1, 22 do
    local id = musicIDs[tostring(i)]
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 105, 0, 44)
    btn.Text = tostring(i)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = white
    btn.BackgroundColor3 = accentBg
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = green
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    btn.Parent = mainScroll
    btn.MouseButton1Click:Connect(function()
        showSelectorPopup("Escolha o tipo:", {"🚘", "🛹", "🏍️", "📻", "🏡"}, function(tipo)
            playMusicRemote(tipo, id)
        end)
    end)
end

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
    popupStroke.Color = green
    popupStroke.Thickness = 1.25
    popupStroke.Transparency = 0.7

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -16, 0, 32)
    title.Position = UDim2.new(0,8,0,7)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = white
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
        btn.TextColor3 = white
        btn.BackgroundColor3 = accentBg
        btn.ZIndex = 20001
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = green
        btnStroke.Thickness = 1.25
        btnStroke.Transparency = 0.7
        btn.MouseButton1Click:Connect(function()
            popup:Destroy()
            block:Destroy()
            if callback then callback(opt) end
        end)
    end
end

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.PlaceholderText = "ID do Áudio aqui..."
inputBox.Size = UDim2.new(0.62, -10, 0, 36)
inputBox.Position = UDim2.new(0, 14, 1, -70)
inputBox.BackgroundColor3 = accentBg
inputBox.TextColor3 = white
inputBox.PlaceholderColor3 = Color3.fromRGB(200,200,200)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 15
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
inputBox.ZIndex = 4
inputBox.AutoLocalize = false
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(1, 0)
local inputBoxStroke = Instance.new("UIStroke", inputBox)
inputBoxStroke.Color = green
inputBoxStroke.Thickness = 1.25
inputBoxStroke.Transparency = 0.7

local playBtn = Instance.new("TextButton", mainFrame)
playBtn.Text = "TOCAR"
playBtn.Size = UDim2.new(0.36, -10, 0, 36)
playBtn.Position = UDim2.new(0.62, 0, 1, -70)
playBtn.BackgroundColor3 = accentBg
playBtn.TextColor3 = white
playBtn.Font = Enum.Font.GothamBold
playBtn.TextSize = 16
playBtn.ZIndex = 4
playBtn.AutoButtonColor = true
Instance.new("UICorner", playBtn).CornerRadius = UDim.new(1, 0)
local playBtnStroke = Instance.new("UIStroke", playBtn)
playBtnStroke.Color = green
playBtnStroke.Thickness = 1.25
playBtnStroke.Transparency = 0.7

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
        local nameGot = foundName or ("Áudio " .. id)
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(id)
        end)
        if success and info and info.Name and not foundName then
            nameGot = info.Name
        end
        showSelectorPopup("Escolha o tipo:", {"🚘", "🛹", "🏍️", "📻", "🏡"}, function(tipo)
            playMusicRemote(tipo, id)
        end)
        showAchievementBar("Tocando agora: " .. nameGot, 6)
    else
        warn("ID INVÁLIDO")
    end
end)

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
    label.TextColor3 = white
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
    showAchievementBar("Bem-vindo ao Freeman HUB Brookhaven - Música V11.9!",4)
end)()

local function makeSubFrame()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -68, 1, -128)
    f.Position = UDim2.new(0, 12, 0, 54)
    f.BackgroundColor3 = darkBg
    f.BackgroundTransparency = 0
    f.Visible = false
    f.ZIndex = 3
    Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
    local stroke = Instance.new("UIStroke", f)
    stroke.Color = green
    stroke.Thickness = 1.25
    stroke.Transparency = 0.7
    return f
end

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

for k = 1, 22 do
    local lbl = Instance.new("TextLabel", musicScroll)
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Text = k.."- "..musicNames[tostring(k)]
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = white
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
end

local creditsFrame = makeSubFrame()
creditsFrame.Parent = mainFrame
local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -16, 1, -16)
creditsLabel.Position = UDim2.new(0, 8, 0, 8)
creditsLabel.Text = "Feito por Freeman4i37\nObrigado por usar o script."
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextColor3 = white
creditsLabel.TextSize = 16
creditsLabel.BackgroundTransparency = 1
creditsLabel.ZIndex = 3

local scriptsFrame = makeSubFrame()
scriptsFrame.Parent = mainFrame

local scriptsTitle = Instance.new("TextLabel", scriptsFrame)
scriptsTitle.Size = UDim2.new(1, -16, 0, 32)
scriptsTitle.Position = UDim2.new(0, 8, 0, 8)
scriptsTitle.Text = "Outros scripts úteis:"
scriptsTitle.TextColor3 = white
scriptsTitle.BackgroundTransparency = 1
scriptsTitle.Font = Enum.Font.GothamBold
scriptsTitle.TextSize = 16
scriptsTitle.ZIndex = 4

local yScriptBtn = 50
local scriptList = {
    {name="Drip Client (Recomendado)", url="https://rawscripts.net/raw/Brookhaven-RP-Drip-Client-51784"},
    {name="AFEM", url="https://rawscripts.net/raw/Universal-Script-AFEM-Max-Open-Alpha-50210"},
    {name="Nameless Admin", url="https://rawscripts.net/raw/Universal-Script-Nameless-admin-REWORKED-43502"},
}
for i, data in ipairs(scriptList) do
    local btn = Instance.new("TextButton", scriptsFrame)
    btn.Size = UDim2.new(1, -16, 0, 36)
    btn.Position = UDim2.new(0, 8, 0, yScriptBtn)
    btn.Text = data.name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = white
    btn.ZIndex = 4
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = green
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 1

    if data.name == "Drip Client (Recomendado)" then
        local grad = Instance.new("UIGradient", btn)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 75, 215)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 64, 255))
        }
    elseif data.name == "AFEM" then
        local grad = Instance.new("UIGradient", btn)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
        }
    elseif data.name == "Nameless Admin" then
        local grad = Instance.new("UIGradient", btn)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
        }
    end

    btn.MouseButton1Click:Connect(function()
        if data.url and data.url ~= "" then
            pcall(function()
                loadstring(game:HttpGet(data.url))()
            end)
            showAchievementBar(data.name .. " executed.", 4)
        else
            showAchievementBar("Script not available!", 3)
        end
    end)
    yScriptBtn = yScriptBtn + 44
end

mainScroll.Visible = true
musicListFrame.Visible = false
creditsFrame.Visible = false
scriptsFrame.Visible = false

local musicListBtnClicked = false
local inScripts = false
local inCredits = false

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainScroll.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    scriptsFrame.Visible = false
end)
scriptsButton.MouseButton1Click:Connect(function()
    inScripts = not inScripts
    mainScroll.Visible = not inScripts
    musicListFrame.Visible = false
    creditsFrame.Visible = false
    scriptsFrame.Visible = inScripts
end)
creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainScroll.Visible = not inCredits
    musicListFrame.Visible = false
    creditsFrame.Visible = inCredits
    scriptsFrame.Visible = false
end)

minimizeBtn.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -355, 0.1, -280)})
    tween:Play()
    tween.Completed:Wait()
    mainFrame.Visible = false
    openIcon.Visible = true
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
end)
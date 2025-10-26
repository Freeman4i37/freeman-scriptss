-- Auralynx Audio Logger - Premium GOLD Edition (IDs salvos nunca somem, lixeira funcional)

local tagMap = {
    ["Kaua_452"] = {colors={Color3.fromRGB(212,175,55),Color3.fromRGB(5,5,5),Color3.fromRGB(255,0,0)}},
    ["Itz_Mariena"] = {colors={Color3.fromRGB(160,0,200),Color3.fromRGB(75,0,110)}},
    ["pedro312jee"] = {colors={Color3.fromRGB(0,15,85),Color3.fromRGB(0,60,255)}},
    ["UserModerator"] = {colors={Color3.fromRGB(255,90,0),Color3.fromRGB(255,215,0)}},
    ["UserStaff"] = {colors={Color3.fromRGB(0,80,255),Color3.fromRGB(120,120,130)}},
}
local player = game:GetService("Players").LocalPlayer
local tagColors = tagMap[player.Name] and tagMap[player.Name].colors or {Color3.fromRGB(255,215,0),Color3.fromRGB(50,50,50)}
local gold = tagColors[1]
local gold2 = tagColors[2] or gold
local gold3 = tagColors[3] or gold
local darkBg = Color3.fromRGB(20,20,20)
local accentBg = Color3.fromRGB(40,40,20)
local white = Color3.fromRGB(255,255,255)
local grayBtn = Color3.fromRGB(70,70,70)
local MarketplaceService = game:GetService("MarketplaceService")
local tweenService = game:GetService("TweenService")

-- Nome do arquivo fixo por usuário (mude se quiser)
local saveFile = ("AuralynxAudioLogger_"..player.Name..".txt")

local function makeGradient(obj, colors)
    local seq = {}
    for i,c in ipairs(colors) do
        table.insert(seq, ColorSequenceKeypoint.new((i-1)/(#colors-1), c))
    end
    local grad = Instance.new("UIGradient", obj)
    grad.Color = ColorSequence.new(seq)
    spawn(function()
        local t0 = tick()
        while grad.Parent do
            grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.1),0)
            wait(0.03)
        end
    end)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxAudioLogger"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "AuralynxAudioLoggerMain"
mainFrame.Size = UDim2.new(0, 600, 0, 340)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = darkBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = gold
mainStroke.Thickness = 2
mainStroke.Transparency = 0.7

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundTransparency = 1
header.Position = UDim2.new(0,0,0,0)
header.Name = "Header"
header.ZIndex = 2

local divider = Instance.new("Frame", mainFrame)
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 0, 36)
divider.BackgroundColor3 = gold
divider.BorderSizePixel = 0
makeGradient(divider, {gold,gold2,gold3,gold,gold2})

local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Auralynx - Audio Logger 💎"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 16
headerTitle.TextColor3 = gold
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -90, 1, 0)
headerTitle.Position = UDim2.new(0, 18, 0, 0)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 3)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = gold
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = gold
closeBtnStroke.Thickness = 1.25
closeBtnStroke.Transparency = 0.7

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(1, -80, 0, 3)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = gold
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local minimizeBtnStroke = Instance.new("UIStroke", minimizeBtn)
minimizeBtnStroke.Color = gold
minimizeBtnStroke.Thickness = 1.25
minimizeBtnStroke.Transparency = 0.7

local actionBar = Instance.new("Frame", mainFrame)
actionBar.Position = UDim2.new(0, 0, 0, 46)
actionBar.Size = UDim2.new(1, 0, 0, 32)
actionBar.BackgroundTransparency = 1
actionBar.Name = "ActionBar"

local function makeActionBtn(parent, text, posX, sizX)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, sizX or 130, 0, 26)
    btn.Position = UDim2.new(0, posX, 0, 3)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = gold
    btn.BackgroundColor3 = accentBg
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = gold2
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    makeGradient(btn, {gold,gold2,gold3})
    return btn
end

local scanGameBtn = makeActionBtn(actionBar, "Scan Game", 8, 130)
local scanWorkspaceBtn = makeActionBtn(actionBar, "Scan Workspace", 146, 130)
local autoScanBtn = makeActionBtn(actionBar, "Auto Scan", 284, 86)
autoScanBtn.BackgroundColor3 = grayBtn
local loadSavedBtn = makeActionBtn(actionBar, "Saved IDs", 380, 86)
loadSavedBtn.BackgroundColor3 = accentBg

local logsFrame = Instance.new("ScrollingFrame", mainFrame)
logsFrame.Name = "Logs"
logsFrame.Position = UDim2.new(0, 14, 0, 80)
logsFrame.Size = UDim2.new(0, 330, 1, -124)
logsFrame.BackgroundColor3 = accentBg
logsFrame.BackgroundTransparency = 0.03
logsFrame.BorderSizePixel = 0
logsFrame.CanvasSize = UDim2.new(0,0,0,0)
logsFrame.ScrollBarThickness = 8
logsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
logsFrame.ZIndex = 2
Instance.new("UICorner", logsFrame).CornerRadius = UDim.new(0, 12)
local logsLayout = Instance.new("UIListLayout", logsFrame)
logsLayout.Padding = UDim.new(0,4)
logsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local logSideBar = Instance.new("Frame", mainFrame)
logSideBar.Position = UDim2.new(0, 360, 0, 80)
logSideBar.Size = UDim2.new(0, 220, 1, -124)
logSideBar.BackgroundColor3 = accentBg
logSideBar.BackgroundTransparency = 0.04
logSideBar.BorderSizePixel = 0
logSideBar.ZIndex = 2
Instance.new("UICorner", logSideBar).CornerRadius = UDim.new(0, 12)

local btnY = 14
local function makeSideBtn(text)
    local btn = Instance.new("TextButton", logSideBar)
    btn.Size = UDim2.new(1, -18, 0, 28)
    btn.Position = UDim2.new(0, 9, 0, btnY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = gold
    btn.BackgroundColor3 = accentBg
    btn.AutoButtonColor = true
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = gold2
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    makeGradient(btn, {gold,gold2,gold3})
    btnY = btnY + 32
    return btn
end

local listenBtn = makeSideBtn("LISTEN SELECTED")
local copyBtn = makeSideBtn("COPY SELECTED IDs")
local saveBtn = makeSideBtn("SAVE SELECTED IDs")
local clearUnselectedBtn = makeSideBtn("CLEAR UNSELECTED")
local clearSelectedBtn = makeSideBtn("CLEAR SELECTED")

local loadedIdsFrame = Instance.new("ScrollingFrame", mainFrame)
loadedIdsFrame.Name = "LoadedIds"
loadedIdsFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
loadedIdsFrame.Size = UDim2.new(0, 420, 0, 240)
loadedIdsFrame.BackgroundColor3 = darkBg
loadedIdsFrame.Visible = false
loadedIdsFrame.ZIndex = 50
loadedIdsFrame.BorderSizePixel = 0
loadedIdsFrame.CanvasSize = UDim2.new(0,0,0,0)
loadedIdsFrame.ScrollBarThickness = 6
loadedIdsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", loadedIdsFrame).CornerRadius = UDim.new(0, 10)
local loadedIdsLayout = Instance.new("UIListLayout", loadedIdsFrame)
loadedIdsLayout.Padding = UDim.new(0,5)
loadedIdsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local loadedClose = Instance.new("TextButton", loadedIdsFrame)
loadedClose.Text = "Close"
loadedClose.Size = UDim2.new(1, -12, 0, 28)
loadedClose.Position = UDim2.new(0, 6, 0, 6)
loadedClose.BackgroundColor3 = accentBg
loadedClose.TextColor3 = gold
loadedClose.Font = Enum.Font.GothamBold
loadedClose.TextSize = 16
loadedClose.ZIndex = 51
loadedClose.AutoButtonColor = true
Instance.new("UICorner", loadedClose).CornerRadius = UDim.new(1, 0)
local loadedCloseStroke = Instance.new("UIStroke", loadedClose)
loadedCloseStroke.Color = gold2
loadedCloseStroke.Thickness = 1.25
loadedCloseStroke.Transparency = 0.7

loadedClose.MouseButton1Click:Connect(function()
    loadedIdsFrame.Visible = false
end)

local detailsLabel = Instance.new("TextLabel", logSideBar)
detailsLabel.Name = "Details"
detailsLabel.Position = UDim2.new(0, 12, 0, btnY + 8)
detailsLabel.Size = UDim2.new(1, -24, 1, -(btnY+12))
detailsLabel.Text = "Select an audio to see details."
detailsLabel.TextColor3 = gold
detailsLabel.BackgroundTransparency = 1
detailsLabel.TextSize = 14
detailsLabel.TextWrapped = true
detailsLabel.TextYAlignment = Enum.TextYAlignment.Top
detailsLabel.Font = Enum.Font.Gotham

local ignore = {
    "rbxasset://sounds/action_get_up.mp3",
    "rbxasset://sounds/uuhhh.mp3",
    "rbxasset://sounds/action_falling.mp3",
    "rbxasset://sounds/action_jump.mp3",
    "rbxasset://sounds/action_jump_land.mp3",
    "rbxasset://sounds/impact_water.mp3",
    "rbxasset://sounds/action_swim.mp3",
    "rbxasset://sounds/action_footsteps_plastic.mp3"
}

local function FindTable(Table, Name)
    for i,v in pairs(Table) do
        if v == Name then
            return true
        end end
    return false
end

local AudioLogs = {}
local Selected = {}

local function clearLogs(onlySelected)
    for i=#AudioLogs,1,-1 do
        local selected = Selected[AudioLogs[i][1]] == true
        if (onlySelected and selected) or (not onlySelected and not selected) then
            if AudioLogs[i][4] then AudioLogs[i][4]:Destroy() end
            table.remove(AudioLogs, i)
        end
    end
    Selected = {}
end
local function refreshLogs()
    logsFrame.CanvasSize = UDim2.new(0,0,0,math.max(#AudioLogs * 36,220))
end

local function addLog(sound)
    if FindTable(ignore, sound.SoundId) then return end
    for _,log in pairs(AudioLogs) do if log[1] == sound.SoundId then return end end
    local id = sound.SoundId
    local assetName = nil
    local foundName = false
    local numberId = id:match("%d+")
    if numberId then
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(tonumber(numberId))
        end)
        if success and info and info.Name and info.Name ~= "" then
            assetName = info.Name
            foundName = true
        end
    end
    if not foundName or not assetName or assetName == "" then
        assetName = sound.Name or "(Unknown)"
    end
    local displayText = assetName .. " - " .. (numberId or id)
    local audioBtn = Instance.new("TextButton")
    audioBtn.Size = UDim2.new(1, -6, 0, 30)
    audioBtn.Position = UDim2.new(0, 0, 0, 0)
    audioBtn.BackgroundColor3 = accentBg
    audioBtn.Text = displayText
    audioBtn.Font = Enum.Font.GothamBold
    audioBtn.TextColor3 = gold
    audioBtn.TextSize = 14
    audioBtn.TextXAlignment = Enum.TextXAlignment.Left
    audioBtn.TextYAlignment = Enum.TextYAlignment.Center
    audioBtn.TextTruncate = Enum.TextTruncate.AtEnd
    audioBtn.AnchorPoint = Vector2.new(0,0)
    audioBtn.ZIndex = 4
    audioBtn.Parent = logsFrame
    Instance.new("UICorner", audioBtn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", audioBtn)
    btnStroke.Color = gold2
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    makeGradient(audioBtn, {gold,gold2,gold3})

    local selected = false
    audioBtn.MouseButton1Click:Connect(function()
        selected = not selected
        if selected then
            Selected[id] = true
            audioBtn.Text = "✅ "..displayText
        else
            Selected[id] = nil
            audioBtn.Text = displayText
        end
        detailsLabel.Text = "Name: "..assetName.."\nID: "..id.."\nParent: "..(sound.Parent and sound.Parent.Name or "Unknown")
    end)
    AudioLogs[#AudioLogs+1] = {id, assetName, sound.Parent and sound.Parent.Name or "", audioBtn, sound}
    refreshLogs()
end

local function scanAudios(place)
    for _, child in pairs(place:GetDescendants()) do
        if child:IsA("Sound") and not FindTable(ignore,child.SoundId) then
            addLog(child)
        end
    end
end

-- Carregar IDs salvos do arquivo fixo ao iniciar
local function loadSavedIDs()
    if not isfile or not readfile then return end
    if not isfile(saveFile) then writefile(saveFile, "") end
    local lines = readfile(saveFile):split("\n")
    for _,line in ipairs(lines) do
        local name,id,parent = line:match("^(.-)|(.-)|(.*)$")
        if id and id ~= "" then
            local fakeSound = Instance.new("Sound")
            fakeSound.Name = name or "(Saved)"
            fakeSound.SoundId = id
            addLog(fakeSound)
            fakeSound:Destroy()
        end
    end
end
loadSavedIDs()

scanGameBtn.MouseButton1Click:Connect(function() scanAudios(game) end)
scanWorkspaceBtn.MouseButton1Click:Connect(function() scanAudios(workspace) end)

local autoscan = false
autoScanBtn.MouseButton1Click:Connect(function()
    autoscan = not autoscan
    autoScanBtn.BackgroundColor3 = autoscan and gold or grayBtn
end)

game.DescendantAdded:Connect(function(obj)
    if autoscan and obj:IsA("Sound") and not FindTable(ignore, obj.SoundId) then
        addLog(obj)
    end
end)

local brookhavenEventNames = {
    ["1Player1sCa1r"] = { "VehicleMusicPlay", "PickingCarMusicText" },
    ["1NoMoto1rVehicle1s"] = { "PickingScooterMusicText" },
    ["PlayerToolEvent"] = { "ToolMusicText" },
    ["1Player1sHous1e"] = { "PickHouseMusicText" },
}

for eventName, triggers in pairs(brookhavenEventNames) do
    local eventFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RE")
    if eventFolder and eventFolder:FindFirstChild(eventName) then
        eventFolder[eventName].OnClientEvent:Connect(function(trigger, id)
            if autoscan and typeof(id) == "string" and id:match("%d+") then
                local fakeSound = Instance.new("Sound")
                fakeSound.SoundId = "rbxassetid://"..id
                fakeSound.Name = "[Brookhaven] "..trigger
                addLog(fakeSound)
                fakeSound:Destroy()
            end
        end)
    end
end

clearSelectedBtn.MouseButton1Click:Connect(function()
    clearLogs(true)
    refreshLogs()
end)
clearUnselectedBtn.MouseButton1Click:Connect(function()
    clearLogs(false)
    refreshLogs()
end)

local sampleSound
listenBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(AudioLogs) do
        if Selected[v[1]] then
            if sampleSound then sampleSound:Destroy() sampleSound = nil listenBtn.Text = "Listen Selected" return end
            sampleSound = Instance.new("Sound", player.PlayerGui)
            sampleSound.SoundId = v[1]
            sampleSound.Volume = 1.3
            sampleSound.Looped = true
            sampleSound:Play()
            listenBtn.Text = "Stop"
            return
        end
    end
end)
copyBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(AudioLogs) do
        if Selected[v[1]] then
            if setclipboard then setclipboard(v[1]) end
        end
    end
end)

-- Salvar IDs selecionados no arquivo fixo, nunca perde!
saveBtn.MouseButton1Click:Connect(function()
    if not writefile then
        game:GetService('StarterGui'):SetCore('SendNotification', {
            Title = 'Audio Logger',
            Text = 'Seu exploit não suporta writefile.',
            Duration = 5,
        })
        return
    end
    local lines = {}
    for _, v in pairs(AudioLogs) do
        if Selected[v[1]] then
            table.insert(lines, string.format("%s|%s|%s", v[2], v[1], v[3]))
        end
    end
    if #lines == 0 then return end
    local allLines = {}
    if isfile(saveFile) then
        allLines = readfile(saveFile):split("\n")
    end
    for _, line in ipairs(lines) do
        local found = false
        for _, l in ipairs(allLines) do if l == line then found = true break end end
        if not found then table.insert(allLines, line) end
    end
    writefile(saveFile, table.concat(allLines, "\n"))
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = 'Audio Logger',
        Text = 'IDs adicionados ao arquivo: '..saveFile,
        Duration = 5,
    })
end)

-- Carregar IDs salvos + lixeira funcional
loadSavedBtn.MouseButton1Click:Connect(function()
    loadedIdsFrame.Visible = true
    for _,v in pairs(loadedIdsFrame:GetChildren()) do
        if v:IsA("TextButton") and v ~= loadedClose then
            v:Destroy()
        end
    end
    if not isfile or not readfile then return end
    if not isfile(saveFile) then writefile(saveFile, "") end
    local lines = readfile(saveFile):split("\n")
    for idx,line in ipairs(lines) do
        local name,id,parent = line:match("^(.-)|(.-)|(.*)$")
        if id and id ~= "" then
            local btn = Instance.new("TextButton", loadedIdsFrame)
            btn.Size = UDim2.new(1, -12, 0, 30)
            btn.Text = (name or "?").." - "..id.."   "
            btn.BackgroundColor3 = accentBg
            btn.TextColor3 = gold
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.ZIndex = 52
            btn.AutoButtonColor = true
            btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Color = gold2
            btnStroke.Thickness = 1.25
            btnStroke.Transparency = 0.7
            makeGradient(btn, {gold,gold2,gold3})

            btn.MouseButton1Click:Connect(function()
                if setclipboard then setclipboard(id) end
                btn.Text = "Copied!"
                wait(1)
                btn.Text = (name or "?").." - "..id.."   "
            end)
            -- Lixeira
            local trashBtn = Instance.new("TextButton", btn)
            trashBtn.Size = UDim2.new(0,24,0,24)
            trashBtn.Position = UDim2.new(1, -28, 0.5, -12)
            trashBtn.BackgroundTransparency = 1
            trashBtn.Text = "🗑"
            trashBtn.TextColor3 = gold
            trashBtn.Font = Enum.Font.GothamBold
            trashBtn.TextSize = 18
            trashBtn.ZIndex = 53
            trashBtn.AutoButtonColor = true
            trashBtn.MouseButton1Click:Connect(function()
                local allLines = readfile(saveFile):split("\n")
                table.remove(allLines, idx)
                writefile(saveFile, table.concat(allLines, "\n"))
                btn:Destroy()
            end)
        end
    end
end)

local openIcon = Instance.new("TextButton", screenGui)
openIcon.Size = UDim2.new(0, 38, 0, 38)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = gold
openIcon.Text = "+"
openIcon.TextSize = 14
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = darkBg
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Visible = false
openIcon.Active = true
openIcon.Draggable = true

minimizeBtn.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -600, 0.1, -180)})
    tween:Play()
    tween.Completed:Wait()
    mainFrame.Visible = false
    openIcon.Visible = true
end)
openIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openIcon.Visible = false
    mainFrame.BackgroundTransparency = 1
    mainFrame.Position = UDim2.new(1, -600, 0.5, -180)
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)})
    tween:Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    if sampleSound then sampleSound:Destroy() end
    screenGui:Destroy()
end)
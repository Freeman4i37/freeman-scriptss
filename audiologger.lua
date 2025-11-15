-- Auralynx Audio Logger - Premium GOLD Edition (IDs saved permanently, trash functional)

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local tweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local gold = Color3.fromRGB(255,215,0)
local gold2 = Color3.fromRGB(50,50,50)
local gold3 = gold
local darkBg = Color3.fromRGB(20,20,20)
local accentBg = Color3.fromRGB(40,40,20)
local white = Color3.fromRGB(255,255,255)
local grayBtn = Color3.fromRGB(70,70,70)

-- Fixed filename per user
local saveFile = ("AuralynxAudioLogger_"..player.Name..".txt")

local function SendNotif(text)
    StarterGui:SetCore("SendNotification", {
        Title = "Auralynx HUB",
        Text = text,
        Duration = 6
    })
end

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

-- GUI setup
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

-- Header
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
headerTitle.Text = "Auralynx HUB — Audio Logger (beta)"
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

-- Action bar
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

-- Logs frame
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

-- Sidebar buttons
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

-- Details label
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

-- Ignored sounds
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
        end
    end
    return false
end

-- Audio logs
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
    local assetName = sound.Name or "(Unknown)"
    local displayText = assetName .. " - " .. (id:match("%d+") or id)

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

-- Scan audios
local function scanAudios(place)
    for _, child in pairs(place:GetDescendants()) do
        if child:IsA("Sound") and not FindTable(ignore,child.SoundId) then
            addLog(child)
        end
    end
end

-- Load saved IDs
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

-- Autoscan
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

-- Listen, copy, save, clear buttons
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

saveBtn.MouseButton1Click:Connect(function()
    if not writefile then
        SendNotif("Your exploit does not support writefile.")
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
    SendNotif("IDs added to file: "..saveFile)
end)

clearSelectedBtn.MouseButton1Click:Connect(function()
    clearLogs(true)
    refreshLogs()
end)

clearUnselectedBtn.MouseButton1Click:Connect(function()
    clearLogs(false)
    refreshLogs()
end)
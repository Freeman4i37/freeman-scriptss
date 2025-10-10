local green = Color3.fromRGB(0,255,0)
local red = Color3.fromRGB(220,40,40)
local white = Color3.fromRGB(255,255,255)
local darkBg = Color3.fromRGB(15,15,15)
local accentBg = Color3.fromRGB(30,30,30)
local grayBtn = Color3.fromRGB(70,70,70)

local player = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanAudioLogger"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "FreemanAudioLoggerMain"
mainFrame.Size = UDim2.new(0, 860, 0, 540)
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
headerTitle.Text = "Freeman Hub - Audio Logger"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 20
headerTitle.TextColor3 = white
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -90, 1, 0)
headerTitle.Position = UDim2.new(0, 18, 0, 0)
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

local actionBar = Instance.new("Frame", mainFrame)
actionBar.Position = UDim2.new(0, 0, 0, 54)
actionBar.Size = UDim2.new(1, 0, 0, 38)
actionBar.BackgroundTransparency = 1
actionBar.Name = "ActionBar"

local function makeActionBtn(parent, text, posX, posY, sizX, sizY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, sizX or 145, 0, sizY or 32)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
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

local scanGameBtn = makeActionBtn(actionBar, "Scan - Game", 8, 3, 145, 32)
local scanWorkspaceBtn = makeActionBtn(actionBar, "Scan - Workspace", 161, 3, 145, 32)
local scanLightingBtn = makeActionBtn(actionBar, "Scan - Lighting", 314, 3, 145, 32)
local scanSoundServiceBtn = makeActionBtn(actionBar, "Scan - SoundService", 467, 3, 145, 32)
local autoScanBtn = makeActionBtn(actionBar, "Auto Scan (Use)", 620, 3, 110, 32)
autoScanBtn.BackgroundColor3 = grayBtn

local logsFrame = Instance.new("ScrollingFrame", mainFrame)
logsFrame.Name = "Logs"
logsFrame.Position = UDim2.new(0, 14, 0, 98)
logsFrame.Size = UDim2.new(0, 500, 1, -152)
logsFrame.BackgroundColor3 = accentBg
logsFrame.BackgroundTransparency = 0.03
logsFrame.BorderSizePixel = 0
logsFrame.CanvasSize = UDim2.new(0,0,0,0)
logsFrame.ScrollBarThickness = 10
logsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
logsFrame.ZIndex = 2
Instance.new("UICorner", logsFrame).CornerRadius = UDim.new(0, 14)

local logsLayout = Instance.new("UIListLayout", logsFrame)
logsLayout.Padding = UDim.new(0,4)
logsLayout.SortOrder = Enum.SortOrder.LayoutOrder

local logSideBar = Instance.new("Frame", mainFrame)
logSideBar.Position = UDim2.new(0, 530, 0, 98)
logSideBar.Size = UDim2.new(0, 310, 1, -152)
logSideBar.BackgroundColor3 = accentBg
logSideBar.BackgroundTransparency = 0.04
logSideBar.BorderSizePixel = 0
logSideBar.ZIndex = 2
Instance.new("UICorner", logSideBar).CornerRadius = UDim.new(0, 14)

local btnY = 20
local function makeSideBtn(text)
    local btn = Instance.new("TextButton", logSideBar)
    btn.Size = UDim2.new(1, -24, 0, 36)
    btn.Position = UDim2.new(0, 12, 0, btnY)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = white
    btn.BackgroundColor3 = accentBg
    btn.AutoButtonColor = true
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = green
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    btnY = btnY + 44
    return btn
end

local listenBtn = makeSideBtn("Listen Selected")
local copyBtn = makeSideBtn("Copy Selected ID")
local saveBtn = makeSideBtn("Save Selected")
local clearUnselectedBtn = makeSideBtn("Clear Unselected")
local clearSelectedBtn = makeSideBtn("Clear Selected")

local detailsLabel = Instance.new("TextLabel", logSideBar)
detailsLabel.Name = "Details"
detailsLabel.Position = UDim2.new(0, 12, 0, btnY + 8)
detailsLabel.Size = UDim2.new(1, -24, 1, -(btnY+20))
detailsLabel.Text = "Select an audio to see details!\nAuto Scan is recommended."
detailsLabel.TextColor3 = white
detailsLabel.BackgroundTransparency = 1
detailsLabel.TextSize = 15
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
    logsFrame.CanvasSize = UDim2.new(0,0,0,math.max(#AudioLogs * 42,410))
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

    local audioBtn = Instance.new("TextButton")
    audioBtn.Size = UDim2.new(1, -6, 0, 38)
    audioBtn.Position = UDim2.new(0, 0, 0, 0)
    audioBtn.BackgroundColor3 = grayBtn
    audioBtn.Text = assetName
    audioBtn.Font = Enum.Font.GothamBold
    audioBtn.TextColor3 = white
    audioBtn.TextSize = 16
    audioBtn.TextXAlignment = Enum.TextXAlignment.Left
    audioBtn.TextYAlignment = Enum.TextYAlignment.Center
    audioBtn.TextTruncate = Enum.TextTruncate.AtEnd
    audioBtn.AnchorPoint = Vector2.new(0,0)
    audioBtn.ZIndex = 4
    audioBtn.Parent = logsFrame
    Instance.new("UICorner", audioBtn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", audioBtn)
    btnStroke.Color = green
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7

    local selected = false
    audioBtn.MouseButton1Click:Connect(function()
        selected = not selected
        if selected then
            Selected[id] = true
            audioBtn.Text = "✅ "..assetName
        else
            Selected[id] = nil
            audioBtn.Text = assetName
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

scanGameBtn.MouseButton1Click:Connect(function() scanAudios(game) end)
scanWorkspaceBtn.MouseButton1Click:Connect(function() scanAudios(workspace) end)
scanLightingBtn.MouseButton1Click:Connect(function() scanAudios(game:GetService("Lighting")) end)
scanSoundServiceBtn.MouseButton1Click:Connect(function() scanAudios(game:GetService("SoundService")) end)

local autoscan = false
autoScanBtn.MouseButton1Click:Connect(function()
    autoscan = not autoscan
    autoScanBtn.BackgroundColor3 = autoscan and green or grayBtn
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
            sampleSound.Volume = 6
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
        game:GetService('StarterGui'):SetCore('SendNotification', {
            Title = 'Audio Logger',
            Text = 'Your exploit does not support writefile.',
            Duration = 5,
        })
        return
    end
    local lines = {}
    for _, v in pairs(AudioLogs) do
        if Selected[v[1]] then
            table.insert(lines, string.format("Name: %s\nID: %s\nParent: %s\n", v[2], v[1], v[3]))
        end
    end
    local filename = "FmanAudioLogger"..os.time()..".txt"
    writefile(filename, table.concat(lines, "\n"))
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = 'Audio Logger',
        Text = 'Saved: '..filename,
        Duration = 5,
    })
end)

local openIcon = Instance.new("TextButton", screenGui)
openIcon.Size = UDim2.new(0, 48, 0, 48)
openIcon.Position = UDim2.new(1, -60, 1, -60)
openIcon.BackgroundColor3 = green
openIcon.Text = "+"
openIcon.TextSize = 14
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = darkBg
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Visible = false
openIcon.Active = true
openIcon.Draggable = true

minimizeBtn.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -860, 0.1, -320)})
    tween:Play()
    tween.Completed:Wait()
    mainFrame.Visible = false
    openIcon.Visible = true
end)
openIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openIcon.Visible = false
    mainFrame.BackgroundTransparency = 1
    mainFrame.Position = UDim2.new(1, -860, 0.5, -320)
    local tween = tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)})
    tween:Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    if sampleSound then sampleSound:Destroy() end
    screenGui:Destroy()
end)
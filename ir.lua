--[[
Auralynx - Interminable Rooms ESP/Notify Hub
by Lynxdev | Halloween Edition
]]--

local orange = Color3.fromRGB(255,140,0)
local black = Color3.fromRGB(0,0,0)
local accentBg = Color3.fromRGB(32,32,32)
local white = Color3.fromRGB(255,255,255)
local green = Color3.fromRGB(0,255,0)
local red = Color3.fromRGB(255,0,0)

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")

-- SEGURA A PASTA Entities
local entitiesFolder
if workspace:FindFirstChild("Entities") then
    entitiesFolder = workspace.Entities
else
    workspace.ChildAdded:Connect(function(obj)
        if obj.Name == "Entities" and obj:IsA("Folder") then
            entitiesFolder = obj
        end
    end)
    repeat wait(0.5) until workspace:FindFirstChild("Entities")
    entitiesFolder = workspace:FindFirstChild("Entities")
end

local function getAllEntities()
    local list = {}
    if entitiesFolder then
        for _, obj in ipairs(entitiesFolder:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("BasePart") then
                table.insert(list, obj)
            end
        end
    end
    return list
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxInterminableHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "AuralynxMain"
mainFrame.Size = UDim2.new(0, 380, 0, 370)
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
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = black
header.ZIndex = 10
header.Position = UDim2.new(0,0,0,0)
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 20)
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Auralynx - Interminable Rooms"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 17
headerTitle.TextColor3 = orange
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(0, 270, 0, 32)
headerTitle.Position = UDim2.new(0, 18, 0, 13)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
headerTitle.ZIndex = 11

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 34, 0, 32)
minimizeBtn.Position = UDim2.new(1, -75, 0, 13)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = orange
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 21
minimizeBtn.ZIndex = 11
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 34, 0, 32)
closeBtn.Position = UDim2.new(1, -35, 0, 13)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = orange
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 21
closeBtn.ZIndex = 11
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local tabsBar = Instance.new("Frame", mainFrame)
tabsBar.Size = UDim2.new(1, -32, 0, 37)
tabsBar.Position = UDim2.new(0, 16, 0, 62)
tabsBar.BackgroundTransparency = 1
tabsBar.ZIndex = 1000
local tabScroll = Instance.new("Frame", tabsBar)
tabScroll.Size = UDim2.new(1, 0, 1, 0)
tabScroll.Position = UDim2.new(0,0,0,0)
tabScroll.BackgroundTransparency = 1
tabScroll.ZIndex = 5
local tabLayout = Instance.new("UIListLayout", tabScroll)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,8)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabs = {
    {name = "ESP", label = "ESP"},
    {name = "Others", label = "Others"},
    {name = "Credits", label = "Credits"}
}

local tabFrames = {}
local tabButtons = {}
local selectedTab = 1
local minimized = false

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
    btn.TextSize = 16
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
    local goal = minimized and UDim2.new(0, 380, 0, 55) or UDim2.new(0, 380, 0, 370)
    tweenService:Create(mainFrame, TweenInfo.new(0.27, Enum.EasingStyle.Quart), {Size = goal}):Play()
end

minimizeBtn.MouseButton1Click:Connect(function()
    setMinimized(not minimized)
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-------------------------------
-- ESP FUNCTIONALITY
-------------------------------
local espEnabled = false
local espObjects = {}

local function getEntityPart(obj)
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then
        return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
    end
end

local function createESP(obj)
    if espObjects[obj] then return end
    local adornee = getEntityPart(obj)
    if not adornee then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "AuralynxESP"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 120, 0, 38)
    billboard.Adornee = adornee
    billboard.Parent = adornee
    local txt = Instance.new("TextLabel", billboard)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = orange
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 17
    txt.TextStrokeTransparency = 0.7
    txt.Text = obj.Name
    txt.TextWrapped = true
    espObjects[obj] = {billboard = billboard, txt = txt, adornee = adornee, obj = obj}
end

local function removeESP(obj)
    if espObjects[obj] then
        espObjects[obj].billboard:Destroy()
        espObjects[obj] = nil
    end
end

local function refreshESPEntities()
    for obj,_ in pairs(espObjects) do
        if not obj.Parent or obj.Parent ~= entitiesFolder then
            removeESP(obj)
        end
    end
    for _, obj in ipairs(getAllEntities()) do
        if not espObjects[obj] then
            createESP(obj)
        end
    end
end

local function updateESP()
    refreshESPEntities()
    for _, esp in pairs(espObjects) do
        if esp.billboard then
            esp.billboard.Enabled = espEnabled
            if espEnabled then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local studs = "???"
                if hrp and esp.adornee and esp.adornee.Position then
                    local dist = (esp.adornee.Position - hrp.Position).Magnitude
                    studs = tostring(math.floor(dist)).." studs"
                end
                esp.txt.Text = esp.obj.Name.."\n"..studs
                esp.txt.TextColor3 = orange
            end
        end
    end
end

entitiesFolder.ChildAdded:Connect(function(obj)
    if obj:IsA("Model") or obj:IsA("BasePart") then
        createESP(obj)
        if _G.AuralynxNotifyEntitiesOn then
            if obj.Name then
                local msg = obj.Name.." has spawned, hide!"
                showNotification(msg, red)
            end
        end
    end
end)

entitiesFolder.ChildRemoved:Connect(function(obj)
    removeESP(obj)
    if _G.AuralynxNotifyEntitiesOn and obj.Name then
        showNotification(obj.Name.." has despawned!", green)
    end
end)

runService.RenderStepped:Connect(function()
    updateESP()
end)

-------------------------------
-- NOTIFICATION SYSTEM
-------------------------------
local notificationBar = nil
local notificationConn = nil
function showNotification(text, color)
    color = color or orange
    if notificationConn then notificationConn:Disconnect() end
    if notificationBar then notificationBar:Destroy() end
    notificationBar = Instance.new("Frame", screenGui)
    notificationBar.Size = UDim2.new(0, 300, 0, 52)
    notificationBar.Position = UDim2.new(0.5, -150, 0, 10)
    notificationBar.BackgroundColor3 = black
    notificationBar.BorderSizePixel = 0
    notificationBar.ZIndex = 9999
    local corner = Instance.new("UICorner", notificationBar)
    corner.CornerRadius = UDim.new(0,14)
    local stroke = Instance.new("UIStroke", notificationBar)
    stroke.Color = orange
    stroke.Thickness = 3
    stroke.Transparency = 0.1
    local nameLabel = Instance.new("TextLabel", notificationBar)
    nameLabel.Size = UDim2.new(1, -10, 1, -8)
    nameLabel.Position = UDim2.new(0,5,0,4)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = text
    nameLabel.TextColor3 = color
    nameLabel.TextSize = 19
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.ZIndex = 9999
    nameLabel.TextWrapped = true
    notificationBar.BackgroundTransparency = 1
    nameLabel.TextTransparency = 1
    tweenService:Create(notificationBar, TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundTransparency=0.09}):Play()
    tweenService:Create(nameLabel, TweenInfo.new(0.22,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()
    notificationConn = runService.RenderStepped:Connect(function() end)
    delay(4, function()
        if notificationConn then notificationConn:Disconnect() end
        tweenService:Create(notificationBar, TweenInfo.new(0.18,Enum.EasingStyle.Quart),{BackgroundTransparency=1}):Play()
        tweenService:Create(nameLabel, TweenInfo.new(0.15,Enum.EasingStyle.Quart),{TextTransparency=1}):Play()
        wait(0.25)
        if notificationBar then notificationBar:Destroy() end
        notificationBar = nil
    end)
end

-------------------------------
-- UI: ESP Tab
-------------------------------
do
    local espFrame = tabFrames[1]
    local espToggle = Instance.new("TextButton", espFrame)
    espToggle.Size = UDim2.new(1, -20, 0, 36)
    espToggle.Position = UDim2.new(0, 10, 0, 12)
    espToggle.BackgroundColor3 = accentBg
    espToggle.TextColor3 = orange
    espToggle.Font = Enum.Font.GothamBold
    espToggle.TextSize = 16
    espToggle.ZIndex = 12
    espToggle.Text = "ESP: Off"
    Instance.new("UICorner", espToggle).CornerRadius = UDim.new(1, 0)
    espToggle.MouseEnter:Connect(function() espToggle.BackgroundColor3 = orange espToggle.TextColor3 = black end)
    espToggle.MouseLeave:Connect(function() espToggle.BackgroundColor3 = accentBg espToggle.TextColor3 = orange end)
    espToggle.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        espToggle.Text = "ESP: "..(espEnabled and "On" or "Off")
    end)
end

-------------------------------
-- UI: Others Tab
-------------------------------
do
    local othersFrame = tabFrames[2]
    local notifyToggle = Instance.new("TextButton", othersFrame)
    notifyToggle.Size = UDim2.new(1, -20, 0, 36)
    notifyToggle.Position = UDim2.new(0, 10, 0, 12)
    notifyToggle.BackgroundColor3 = accentBg
    notifyToggle.TextColor3 = orange
    notifyToggle.Font = Enum.Font.GothamBold
    notifyToggle.TextSize = 16
    notifyToggle.ZIndex = 12
    notifyToggle.Text = "Notify Entities: Off"
    Instance.new("UICorner", notifyToggle).CornerRadius = UDim.new(1, 0)
    notifyToggle.MouseEnter:Connect(function() notifyToggle.BackgroundColor3 = orange notifyToggle.TextColor3 = black end)
    notifyToggle.MouseLeave:Connect(function() notifyToggle.BackgroundColor3 = accentBg notifyToggle.TextColor3 = orange end)
    notifyToggle.MouseButton1Click:Connect(function()
        _G.AuralynxNotifyEntitiesOn = not _G.AuralynxNotifyEntitiesOn
        notifyToggle.Text = "Notify Entities: "..(_G.AuralynxNotifyEntitiesOn and "On" or "Off")
    end)
end

-------------------------------
-- UI: Credits Tab
-------------------------------
do
    local creditsFrame = tabFrames[3]
    local creditsLabel = Instance.new("TextLabel", creditsFrame)
    creditsLabel.Size = UDim2.new(1, -16, 1, -20)
    creditsLabel.Position = UDim2.new(0, 8, 0, 8)
    creditsLabel.Text = "Made by Lynxdev.\nAuralynx IR © 2025."
    creditsLabel.Font = Enum.Font.GothamBold
    creditsLabel.TextColor3 = orange
    creditsLabel.TextSize = 16
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.ZIndex = 18
end

-- Inicialização
showTab(1)
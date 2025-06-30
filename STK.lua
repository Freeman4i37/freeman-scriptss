local cg = game:GetService("CoreGui")
local old = cg:FindFirstChild("FreemanMultiHub")
if old then old:Destroy() end

local player = game.Players.LocalPlayer
local ws = game:GetService("Workspace")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local fps = 0
local frameTimes = {}

local shopNames = {
    {name="Flashlight", path="Flashlight Shop"},
    {name="Jar", path="Jar Shop"},
    {name="GravityCoil", path="GravityCoil Shop"},
    {name="RegenCoil", path="RegenCoil Shop"},
    {name="SpeedCoil", path="SpeedCoil Shop"}
}

local tpCoords = {
    MainHouse = Vector3.new(10.077223777770996, 74.39205169677734, 47.603660583496094),
    House2 = Vector3.new(87.38883972167969, 68.63177490234375, 91.98570251464844),
    Roof = Vector3.new(97.15742492675781, 92.4198989868164, 100.06204223632812)
}

local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    return getChar():WaitForChild("HumanoidRootPart")
end

runService.RenderStepped:Connect(function()
    local t = tick()
    table.insert(frameTimes, t)
    while frameTimes[1] and frameTimes[1] < t - 1 do
        table.remove(frameTimes, 1)
    end
    fps = #frameTimes
end)

local gui = Instance.new("ScreenGui")
gui.Name = "FreemanMultiHub"
gui.Parent = cg
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 430)
frame.Position = UDim2.new(1, -415, 0.5, -215)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundColor3 = Color3.fromRGB(0,0,0)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Freeman HUB - 🗡 STK 1.0"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 38, 1, 0)
minimize.Position = UDim2.new(1, -76, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.fromRGB(255,255,255)
minimize.BackgroundColor3 = Color3.fromRGB(40,40,40)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 12)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 38, 1, 0)
close.Position = UDim2.new(1, -38, 0, 0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 20
close.TextColor3 = Color3.fromRGB(255,255,255)
close.BackgroundColor3 = Color3.fromRGB(64,64,64)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 12)

local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 56, 1, -38)
sidebar.Position = UDim2.new(0, 0, 0, 38)
sidebar.BackgroundTransparency = 1

local tabs = {}
local tabIcons = {"👤", "🗡", "🌀", "🧲", "⚙️"}
local tabNames = {"Credits", "Main", "Teleports", "Shop", "Settings"}

for i, icon in ipairs(tabIcons) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0, 48, 0, 48)
    btn.Position = UDim2.new(0, 4, 0, 8 + (i - 1) * 56)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 32
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.Name = tabNames[i]
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 14)
    tabs[tabNames[i]] = btn
end

local function getChatPlusPos()
    return UDim2.new(0, 180, 0, 90)
end

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = getChatPlusPos()
openIcon.BackgroundColor3 = Color3.fromRGB(40,40,40)
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 28
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Active = true
openIcon.Draggable = true

local tabFrames = {}
for i, name in ipairs(tabNames) do
    local f = Instance.new("Frame", frame)
    f.Name = name .. "Frame"
    f.Position = UDim2.new(0, 62, 0, 50)
    f.Size = UDim2.new(1, -70, 1, -60)
    f.BackgroundTransparency = 1
    f.Visible = i == 1
    tabFrames[name] = f
end

-- CREDITOS + AUTO DROP BUTTONS
local creditsFrame = tabFrames.Credits
local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 0, 60)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Font = Enum.Font.FredokaOne
creditsLabel.TextSize = 18
creditsLabel.TextColor3 = Color3.fromRGB(255,255,255)
creditsLabel.TextWrapped = true
creditsLabel.Text = "This script was made by Freeman4i37.\n"

local dropToggles = {
    Saxophone = false,
    VIPCoil = false,
    HealingPotion = false,
    MoonWalkPotion = false
}
local dropButtons = {}

local dropNames = {
    {var="Saxophone", display="AUTO DROP SAXOPHONE"},
    {var="VIPCoil", display="AUTO DROP VIPCOIL"},
    {var="HealingPotion", display="AUTO DROP HEALTH POTION"},
    {var="MoonWalkPotion", display="AUTO DROP MOONWALK POTION"},
}

local function autoDropTool(toolName, toggleVar)
    task.spawn(function()
        while dropToggles[toggleVar] do
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character or player.CharacterAdded:Wait()
            if backpack then
                for _, tool in ipairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name == toolName then
                        pcall(function()
                            tool.Parent = character
                        end)
                    end
                end
                task.wait()
                for _, tool in ipairs(character:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name == toolName then
                        pcall(function()
                            tool.Parent = workspace
                        end)
                    end
                end
            end
            wait(0.20)
        end
    end)
end

for i, info in ipairs(dropNames) do
    local btn = Instance.new("TextButton", creditsFrame)
    btn.Size = UDim2.new(1, -60, 0, 38)
    btn.Position = UDim2.new(0, 30, 0, 80 + (i-1)*48)
    btn.BackgroundColor3 = Color3.fromRGB(48,48,48)
    btn.Text = info.display .. ": OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    dropButtons[info.var] = btn
    btn.MouseButton1Click:Connect(function()
        dropToggles[info.var] = not dropToggles[info.var]
        btn.Text = info.display .. (dropToggles[info.var] and ": ON" or ": OFF")
        btn.BackgroundColor3 = dropToggles[info.var] and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
        if dropToggles[info.var] then
            autoDropTool(info.var, info.var)
        end
    end)
end

local mainBtnsY = 18
local grabCoins = false
local grabVIP = false
local vipPartOriginalCFrame = nil

local grabCoinsBtn = Instance.new("TextButton", tabFrames.Main)
grabCoinsBtn.Size = UDim2.new(1, -60, 0, 44)
grabCoinsBtn.Position = UDim2.new(0, 30, 0, mainBtnsY)
grabCoinsBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
grabCoinsBtn.Text = "Auto Grab Coins: OFF"
grabCoinsBtn.Font = Enum.Font.GothamBold
grabCoinsBtn.TextSize = 20
grabCoinsBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", grabCoinsBtn).CornerRadius = UDim.new(0, 10)
grabCoinsBtn.AutoButtonColor = true

grabCoinsBtn.MouseButton1Click:Connect(function()
    grabCoins = not grabCoins
    grabCoinsBtn.Text = grabCoins and "Auto Grab Coins: ON" or "Auto Grab Coins: OFF"
    grabCoinsBtn.BackgroundColor3 = grabCoins and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
end)

local grabVIPBtn = Instance.new("TextButton", tabFrames.Main)
grabVIPBtn.Size = UDim2.new(1, -60, 0, 44)
grabVIPBtn.Position = UDim2.new(0, 30, 0, mainBtnsY + 64)
grabVIPBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
grabVIPBtn.Text = "Auto Grab VIP Items: OFF"
grabVIPBtn.Font = Enum.Font.GothamBold
grabVIPBtn.TextSize = 20
grabVIPBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", grabVIPBtn).CornerRadius = UDim.new(0, 10)
grabVIPBtn.AutoButtonColor = true

grabVIPBtn.MouseButton1Click:Connect(function()
    grabVIP = not grabVIP
    grabVIPBtn.Text = grabVIP and "Auto Grab VIP Items: ON" or "Auto Grab VIP Items: OFF"
    grabVIPBtn.BackgroundColor3 = grabVIP and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    if not grabVIP then
        local vipFolder = ws:FindFirstChild("VIP Models")
        if vipFolder and vipFolder:FindFirstChild("Part") and vipPartOriginalCFrame then
            local vipPart = vipFolder.Part
            pcall(function()
                vipPart.CFrame = vipPartOriginalCFrame
            end)
        end
        vipPartOriginalCFrame = nil
    end
end)

local function showTPAlert()
    local alert = Instance.new("Frame", gui)
    alert.Size = UDim2.new(0, 420, 0, 55)
    alert.Position = UDim2.new(0.5, -210, 0.5, -36)
    alert.BackgroundColor3 = Color3.fromRGB(20,20,20)
    alert.BackgroundTransparency = 0.15
    alert.BorderSizePixel = 0
    alert.Active = true
    alert.ZIndex = 9998
    local uic = Instance.new("UICorner", alert)
    uic.CornerRadius = UDim.new(0, 14)
    local lbl = Instance.new("TextLabel", alert)
    lbl.Size = UDim2.new(1, -12, 1, -10)
    lbl.Position = UDim2.new(0, 6, 0, 5)
    lbl.BackgroundTransparency = 1
    lbl.Text = "ALERT\nTP Shop Items may not work well because of the game itself being broken in this part."
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextSize = 16
    lbl.Font = Enum.Font.GothamBold
    lbl.TextWrapped = true
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.ZIndex = 9999
    alert.Visible = true
    alert.BackgroundTransparency = 0.15
    lbl.TextTransparency = 0
    tweenService:Create(alert, TweenInfo.new(0.18), {BackgroundTransparency = 0.15}):Play()
    tweenService:Create(lbl, TweenInfo.new(0.18), {TextTransparency = 0}):Play()
    wait(4)
    tweenService:Create(alert, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
    tweenService:Create(lbl, TweenInfo.new(0.18), {TextTransparency = 1}):Play()
    wait(0.18)
    alert:Destroy()
end

local function createTPBtn(parent, label, pos, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -60, 0, 38)
    btn.Position = UDim2.new(0, 30, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(48,48,48)
    btn.Text = label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.MouseButton1Click:Connect(function()
        local hrp = getHRP()
        hrp.CFrame = CFrame.new(pos)
    end)
end

createTPBtn(tabFrames.Teleports, "TP MAIN HOUSE", tpCoords.MainHouse, 16)
createTPBtn(tabFrames.Teleports, "TP HOUSE 2", tpCoords.House2, 68)
createTPBtn(tabFrames.Teleports, "TP ROOF", tpCoords.Roof, 120)

local function createShopBtn(parent, display, shopName, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -60, 0, 34)
    btn.Position = UDim2.new(0, 30, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(48,48,48)
    btn.Text = display
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.MouseButton1Click:Connect(function()
        local shop = ws:FindFirstChild("Shop")
        if shop and shop:FindFirstChild(shopName) then
            local part = shop[shopName]:FindFirstChild("Part")
            if part then
                local hrp = getHRP()
                local old = hrp.CFrame
                hrp.CFrame = part.CFrame
                wait(0.2)
                hrp.CFrame = old
            end
        end
    end)
end

local shopY = 18
for i, shop in ipairs(shopNames) do
    createShopBtn(tabFrames.Shop, shop.name, shop.path, shopY + (i - 1) * 44)
end

local settings = {}
settings.FPS = false
settings.PlayerList = false
settings.FriendsList = false
settings.Fullbright = false
settings.Fog = true

local fpsBtn = Instance.new("TextButton", tabFrames.Settings)
fpsBtn.Size = UDim2.new(1, -60, 0, 36)
fpsBtn.Position = UDim2.new(0, 30, 0, 18)
fpsBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
fpsBtn.Text = "Enable FPS: OFF"
fpsBtn.Font = Enum.Font.GothamBold
fpsBtn.TextSize = 17
fpsBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 10)

local plBtn = Instance.new("TextButton", tabFrames.Settings)
plBtn.Size = UDim2.new(1, -60, 0, 36)
plBtn.Position = UDim2.new(0, 30, 0, 58)
plBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
plBtn.Text = "Enable Player List: OFF"
plBtn.Font = Enum.Font.GothamBold
plBtn.TextSize = 17
plBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", plBtn).CornerRadius = UDim.new(0, 10)

local frBtn = Instance.new("TextButton", tabFrames.Settings)
frBtn.Size = UDim2.new(1, -60, 0, 36)
frBtn.Position = UDim2.new(0, 30, 0, 98)
frBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
frBtn.Text = "Enable Friends List: OFF"
frBtn.Font = Enum.Font.GothamBold
frBtn.TextSize = 17
frBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", frBtn).CornerRadius = UDim.new(0, 10)

local fbBtn = Instance.new("TextButton", tabFrames.Settings)
fbBtn.Size = UDim2.new(1, -60, 0, 36)
fbBtn.Position = UDim2.new(0, 30, 0, 138)
fbBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
fbBtn.Text = "Enable Fullbright: OFF"
fbBtn.Font = Enum.Font.GothamBold
fbBtn.TextSize = 17
fbBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", fbBtn).CornerRadius = UDim.new(0, 10)

local fogBtn = Instance.new("TextButton", tabFrames.Settings)
fogBtn.Size = UDim2.new(1, -60, 0, 36)
fogBtn.Position = UDim2.new(0, 30, 0, 178)
fogBtn.BackgroundColor3 = Color3.fromRGB(48,48,48)
fogBtn.Text = "FOG: ON"
fogBtn.Font = Enum.Font.GothamBold
fogBtn.TextSize = 17
fogBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", fogBtn).CornerRadius = UDim.new(0, 10)

local fpsLabel = Instance.new("TextLabel", tabFrames.Settings)
fpsLabel.Size = UDim2.new(1, -40, 0, 24)
fpsLabel.Position = UDim2.new(0, 20, 1, -80)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.TextColor3 = Color3.fromRGB(255,255,255)
fpsLabel.Text = ""
fpsLabel.Visible = false

local plLabel = Instance.new("TextLabel", tabFrames.Settings)
plLabel.Size = UDim2.new(1, -40, 0, 24)
plLabel.Position = UDim2.new(0, 20, 1, -56)
plLabel.BackgroundTransparency = 1
plLabel.Font = Enum.Font.GothamBold
plLabel.TextSize = 16
plLabel.TextColor3 = Color3.fromRGB(255,255,255)
plLabel.Text = ""
plLabel.Visible = false

local frLabel = Instance.new("TextLabel", tabFrames.Settings)
frLabel.Size = UDim2.new(1, -40, 0, 24)
frLabel.Position = UDim2.new(0, 20, 1, -32)
frLabel.BackgroundTransparency = 1
frLabel.Font = Enum.Font.GothamBold
frLabel.TextSize = 16
frLabel.TextColor3 = Color3.fromRGB(255,255,255)
frLabel.Text = ""
frLabel.Visible = false

fpsBtn.MouseButton1Click:Connect(function()
    settings.FPS = not settings.FPS
    fpsBtn.Text = settings.FPS and "Enable FPS: ON" or "Enable FPS: OFF"
    fpsBtn.BackgroundColor3 = settings.FPS and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    fpsLabel.Visible = settings.FPS
end)

plBtn.MouseButton1Click:Connect(function()
    settings.PlayerList = not settings.PlayerList
    plBtn.Text = settings.PlayerList and "Enable Player List: ON" or "Enable Player List: OFF"
    plBtn.BackgroundColor3 = settings.PlayerList and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    plLabel.Visible = settings.PlayerList
end)

frBtn.MouseButton1Click:Connect(function()
    settings.FriendsList = not settings.FriendsList
    frBtn.Text = settings.FriendsList and "Enable Friends List: ON" or "Enable Friends List: OFF"
    frBtn.BackgroundColor3 = settings.FriendsList and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    frLabel.Visible = settings.FriendsList
end)

local oldAmbient, oldBrightness, oldOutdoorAmbient, oldTimeOfDay
fbBtn.MouseButton1Click:Connect(function()
    settings.Fullbright = not settings.Fullbright
    fbBtn.Text = settings.Fullbright and "Enable Fullbright: ON" or "Enable Fullbright: OFF"
    fbBtn.BackgroundColor3 = settings.Fullbright and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    if settings.Fullbright then
        oldAmbient = lighting.Ambient
        oldBrightness = lighting.Brightness
        oldOutdoorAmbient = lighting.OutdoorAmbient
        oldTimeOfDay = lighting.TimeOfDay
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.Brightness = 3
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        lighting.TimeOfDay = "14:00:00"
    else
        if oldAmbient then lighting.Ambient = oldAmbient end
        if oldBrightness then lighting.Brightness = oldBrightness end
        if oldOutdoorAmbient then lighting.OutdoorAmbient = oldOutdoorAmbient end
        if oldTimeOfDay then lighting.TimeOfDay = oldTimeOfDay end
    end
end)

local fogDefault = lighting.FogEnd
fogBtn.MouseButton1Click:Connect(function()
    settings.Fog = not settings.Fog
    fogBtn.Text = settings.Fog and "FOG: ON" or "FOG: OFF"
    fogBtn.BackgroundColor3 = settings.Fog and Color3.fromRGB(96,96,96) or Color3.fromRGB(48,48,48)
    if not settings.Fog then
        lighting.FogEnd = 100000
    else
        lighting.FogEnd = fogDefault
    end
end)

task.spawn(function()
    while gui.Parent do
        if settings.FPS then
            fpsLabel.Text = "FPS: " .. tostring(fps)
        end
        if settings.PlayerList then
            plLabel.Text = "Players: " .. tostring(#players:GetPlayers())
        end
        if settings.FriendsList then
            local cnt = 0
            for _, plr in pairs(players:GetPlayers()) do
                if plr ~= player then
                    local s, r = pcall(function() return player:IsFriendsWith(plr.UserId) end)
                    if s and r then cnt = cnt + 1 end
                end
            end
            frLabel.Text = "Friends: " .. tostring(cnt)
        end
        wait(0.2)
    end
end)

for i, name in ipairs(tabNames) do
    local btn = tabs[name]
    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do f.Visible = false end
        tabFrames[name].Visible = true
        if name == "Shop" then
            showTPAlert()
        end
    end)
end

minimize.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Position = UDim2.new(1, -415, 0.5, -320)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
    openIcon.Position = getChatPlusPos()
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(1, -415, 0.5, -320)
    local tween = tweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0, Position = UDim2.new(1, -415, 0.5, -215)})
    tween:Play()
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local function showAchievementBar(text, duration)
    local bar = Instance.new("Frame", gui)
    bar.Size = UDim2.new(0, 260, 0, 44)
    bar.Position = UDim2.new(1, -280, 0, 60)
    bar.BackgroundColor3 = Color3.fromRGB(24,24,24)
    bar.BackgroundTransparency = 0.1
    bar.BorderSizePixel = 0
    local uicorner = Instance.new("UICorner", bar)
    uicorner.CornerRadius = UDim.new(0, 12)
    local label = Instance.new("TextLabel", bar)
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 15
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    bar.Position = UDim2.new(1, -280, 0, 60)
    bar.BackgroundTransparency = 1
    label.TextTransparency = 1
    local tweenIn = tweenService:Create(bar, TweenInfo.new(0.22), {Position = UDim2.new(1, -280, 0, 16), BackgroundTransparency = 0.1})
    local tweenLabelIn = tweenService:Create(label, TweenInfo.new(0.12), {TextTransparency = 0})
    tweenIn:Play()
    tweenLabelIn:Play()
    tweenIn.Completed:Wait()
    wait(duration or 2.3)
    local tweenOut = tweenService:Create(bar, TweenInfo.new(0.22), {Position = UDim2.new(1, -280, 0, 60), BackgroundTransparency = 1})
    local tweenLabelOut = tweenService:Create(label, TweenInfo.new(0.12), {TextTransparency = 1})
    tweenOut:Play()
    tweenLabelOut:Play()
    tweenOut.Completed:Wait()
    bar:Destroy()
end

coroutine.wrap(function()
    showAchievementBar("Welcome to Freeman HUB!",3)
end)()

local function safeGrabCoins()
    local hrp
    pcall(function() hrp = getHRP() end)
    if not hrp then return end
    for _, killer in pairs(ws:GetChildren()) do
        if killer:IsA("Model") and killer:FindFirstChild("Coins") then
            for _, coin in pairs(killer.Coins:GetChildren()) do
                if coin:IsA("BasePart") and coin.Name == "Coin" then
                    pcall(function()
                        coin.CFrame = hrp.CFrame
                    end)
                end
            end
        end
    end
end

local function safeGrabVIP()
    local char = getChar()
    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    local vipFolder = ws:FindFirstChild("VIP Models")
    if vipFolder and vipFolder:FindFirstChild("Part") and torso then
        local vipPart = vipFolder.Part
        if not vipPartOriginalCFrame then
            vipPartOriginalCFrame = vipPart.CFrame
        end
        pcall(function()
            vipPart.CFrame = torso.CFrame
        end)
        wait(0.08)
        pcall(function()
            if vipPartOriginalCFrame then
                vipPart.CFrame = vipPartOriginalCFrame
            end
        end)
    end
end

task.spawn(function()
    while gui.Parent do
        if grabCoins then
            safeGrabCoins()
        end
        wait(0.15)
    end
end)

task.spawn(function()
    while gui.Parent do
        if grabVIP then
            safeGrabVIP()
        end
        wait(0.15)
    end
end)
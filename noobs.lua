local cg = game:GetService("CoreGui")
local player = game.Players.LocalPlayer
local ws = game:GetService("Workspace")
local tween = game:GetService("TweenService")

local old = cg:FindFirstChild("FMAN_HUB_PEPSICAT")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui", cg)
gui.Name = "FMAN_HUB_PEPSICAT"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 390, 0, 430)
frame.Position = UDim2.new(0, 80, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = Color3.fromRGB(30,30,38)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,16)
local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Freeman HUB - Noobs Must Die!"
title.TextColor3 = Color3.fromRGB(140,210,255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 38, 1, 0)
minimize.Position = UDim2.new(1, -76, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 22
minimize.TextColor3 = Color3.fromRGB(255,255,255)
minimize.BackgroundColor3 = Color3.fromRGB(55,55,55)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 13)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 38, 1, 0)
close.Position = UDim2.new(1, -38, 0, 0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 22
close.TextColor3 = Color3.fromRGB(255,255,255)
close.BackgroundColor3 = Color3.fromRGB(90,40,40)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 13)

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(0, 100, 0, 110)
openIcon.BackgroundColor3 = Color3.fromRGB(40,40,40)
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 28
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Active = true
openIcon.Draggable = true

local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 56, 1, -54)
sidebar.Position = UDim2.new(0, 0, 0, 54)
sidebar.BackgroundTransparency = 1

local tabIcons = {"🗡", "🎁", "🍔", "👤"}
local tabNames = {"Kill Noobs", "Items", "Burger", "Credits"}
local tabs, tabFrames = {}, {}

for i, icon in ipairs(tabIcons) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0, 44, 0, 44)
    btn.Position = UDim2.new(0, 6, 0, 18 + (i-1)*58)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 28
    btn.TextColor3 = Color3.fromRGB(210,210,210)
    btn.BackgroundColor3 = Color3.fromRGB(38,38,38)
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    tabs[tabNames[i]] = btn

    local f = Instance.new("Frame", frame)
    f.Name = tabNames[i].."Frame"
    f.Position = UDim2.new(0, 66, 0, 62)
    f.Size = UDim2.new(1, -76, 1, -74)
    f.BackgroundTransparency = 1
    f.Visible = (i==1)
    tabFrames[tabNames[i]] = f
end

for i, name in ipairs(tabNames) do
    tabs[name].MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do f.Visible = false end
        tabFrames[name].Visible = true
    end)
end

local killFrame = tabFrames["Kill Noobs"]
local Y = 12

local line1 = Instance.new("Frame", killFrame)
line1.Size = UDim2.new(1, -30, 0, 2)
line1.Position = UDim2.new(0, 6, 0, Y)
line1.BackgroundColor3 = Color3.fromRGB(70,70,70)
line1.BackgroundTransparency = 0.25
Y = Y+10

local autoKill = false
local killDelay = 1
local killLoop = nil

local function killAll()
    for _, enemy in pairs(ws:WaitForChild("Enemies"):GetChildren()) do
        if enemy:IsA("Model") then
            game:GetService("ReplicatedStorage").HurtEnemy:FireServer(enemy, 900000)
        end
    end
end

local function startAutoKillLoop()
    if killLoop and coroutine.status(killLoop) ~= "dead" then return end
    killLoop = coroutine.create(function()
        while true do
            if autoKill then
                killAll()
                wait(killDelay)
            else
                wait(0.1)
            end
        end
    end)
    coroutine.resume(killLoop)
end

local autoKillBtn = Instance.new("TextButton", killFrame)
autoKillBtn.Size = UDim2.new(1, -38, 0, 38)
autoKillBtn.Position = UDim2.new(0, 12, 0, Y)
autoKillBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
autoKillBtn.Text = "Auto Kill All Noobs [OFF]"
autoKillBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoKillBtn.Font = Enum.Font.GothamBold
autoKillBtn.TextSize = 18
Instance.new("UICorner", autoKillBtn).CornerRadius = UDim.new(0, 12)
Y = Y+50

autoKillBtn.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    autoKillBtn.Text = "Auto Kill All Noobs ["..(autoKill and "ON" or "OFF").."]"
    if autoKill then
        startAutoKillLoop()
    end
end)

local killBtn = Instance.new("TextButton", killFrame)
killBtn.Size = UDim2.new(1, -38, 0, 38)
killBtn.Position = UDim2.new(0, 12, 0, Y)
killBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
killBtn.Text = "Kill All Noobs"
killBtn.TextColor3 = Color3.fromRGB(255,255,255)
killBtn.Font = Enum.Font.GothamBold
killBtn.TextSize = 18
Instance.new("UICorner", killBtn).CornerRadius = UDim.new(0, 12)
Y = Y+44

killBtn.MouseButton1Click:Connect(killAll)

local delayBox = Instance.new("TextBox", killFrame)
delayBox.Size = UDim2.new(1, -38, 0, 36)
delayBox.Position = UDim2.new(0, 12, 0, Y)
delayBox.BackgroundColor3 = Color3.fromRGB(34,34,34)
delayBox.Text = "Delay: 1"
delayBox.TextColor3 = Color3.fromRGB(255,255,255)
delayBox.Font = Enum.Font.GothamBold
delayBox.TextSize = 17
delayBox.PlaceholderText = "Delay"
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 12)
Y = Y+38

delayBox.FocusLost:Connect(function()
    killDelay = tonumber(delayBox.Text:match("%d+")) or 1
    delayBox.Text = "DELAY: "..killDelay
end)

local itemsFrame = tabFrames["Items"]
local N, S, co = 1, nil, false
local Y2 = 12

local line2 = Instance.new("Frame", itemsFrame)
line2.Size = UDim2.new(1, -30, 0, 2)
line2.Position = UDim2.new(0, 6, 0, Y2)
line2.BackgroundColor3 = Color3.fromRGB(70,70,70)
line2.BackgroundTransparency = 0.25
Y2 = Y2+10

local items = {}
for _, item in ipairs(game:GetService("ReplicatedStorage").PlrMan.Items:GetChildren()) do
    if item:IsA("Part") then
        table.insert(items, item.Name)
    end
end

local selectedLabel = Instance.new("TextLabel", itemsFrame)
selectedLabel.Size = UDim2.new(1, -38, 0, 25)
selectedLabel.Position = UDim2.new(0, 12, 0, Y2)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Text = "Selected: None"
selectedLabel.TextColor3 = Color3.fromRGB(180,210,255)
selectedLabel.Font = Enum.Font.GothamBold
selectedLabel.TextSize = 16
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
Y2 = Y2 + 28

local scroll = Instance.new("ScrollingFrame", itemsFrame)
scroll.Position = UDim2.new(0, 12, 0, Y2)
scroll.Size = UDim2.new(1, -38, 0, 90)
scroll.BackgroundColor3 = Color3.fromRGB(32,32,32)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0,0,0,math.max(36 * #items, 90))
scroll.ScrollBarThickness = 8
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)
local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

for _, name in ipairs(items) do
    local opt = Instance.new("TextButton", scroll)
    opt.Size = UDim2.new(1, 0, 0, 32)
    opt.Text = name
    opt.BackgroundColor3 = Color3.fromRGB(44,44,44)
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.Font = Enum.Font.GothamBold
    opt.TextSize = 16
    Instance.new("UICorner", opt).CornerRadius = UDim.new(0, 7)
    opt.MouseButton1Click:Connect(function()
        S = name
        selectedLabel.Text = "Selected: " .. name
        for _,v in pairs(scroll:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundColor3 = Color3.fromRGB(44,44,44)
            end
        end
        opt.BackgroundColor3 = Color3.fromRGB(44,120,200)
    end)
end

Y2 = Y2 + 98

local getBtn = Instance.new("TextButton", itemsFrame)
getBtn.Size = UDim2.new(1, -38, 0, 38)
getBtn.Position = UDim2.new(0, 12, 0, Y2)
getBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
getBtn.Text = "GET"
getBtn.TextColor3 = Color3.fromRGB(255,255,255)
getBtn.Font = Enum.Font.GothamBold
getBtn.TextSize = 17
Instance.new("UICorner", getBtn).CornerRadius = UDim.new(0, 12)
Y2 = Y2 + 44

getBtn.MouseButton1Click:Connect(function()
    if S then
        game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(S)
    end
end)

local fastGetBtn = Instance.new("TextButton", itemsFrame)
fastGetBtn.Size = UDim2.new(1, -38, 0, 38)
fastGetBtn.Position = UDim2.new(0, 12, 0, Y2)
fastGetBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
fastGetBtn.Text = "Fast Auto Get [OFF]"
fastGetBtn.TextColor3 = Color3.fromRGB(255,255,255)
fastGetBtn.Font = Enum.Font.GothamBold
fastGetBtn.TextSize = 17
Instance.new("UICorner", fastGetBtn).CornerRadius = UDim.new(0, 12)
Y2 = Y2+44

fastGetBtn.MouseButton1Click:Connect(function()
    co = not co
    fastGetBtn.Text = "Fast Auto Get ["..(co and "ON" or "OFF").."]"
end)

spawn(function()
    while true do
        if co and S then
            for i = 1, 3 do
                game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(S)
            end
        end
        wait(0.1)
    end
end)

local burgerFrame = tabFrames["Burger"]
local Y3 = 12
local burgers = 1

local eatBox = Instance.new("TextBox", burgerFrame)
eatBox.Size = UDim2.new(1, -38, 0, 36)
eatBox.Position = UDim2.new(0, 12, 0, Y3)
eatBox.BackgroundColor3 = Color3.fromRGB(34,34,34)
eatBox.Text = "Amount of burgers"
eatBox.TextColor3 = Color3.fromRGB(255,255,255)
eatBox.Font = Enum.Font.GothamBold
eatBox.TextSize = 17
eatBox.PlaceholderText = "Amount"
Instance.new("UICorner", eatBox).CornerRadius = UDim.new(0, 12)
Y3 = Y3+38

eatBox.FocusLost:Connect(function()
    burgers = tonumber(eatBox.Text) or 1
end)

local eatBtn = Instance.new("TextButton", burgerFrame)
eatBtn.Size = UDim2.new(1, -38, 0, 38)
eatBtn.Position = UDim2.new(0, 12, 0, Y3)
eatBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
eatBtn.Text = "Give Burgers"
eatBtn.TextColor3 = Color3.fromRGB(255,255,255)
eatBtn.Font = Enum.Font.GothamBold
eatBtn.TextSize = 17
Instance.new("UICorner", eatBtn).CornerRadius = UDim.new(0, 12)
Y3 = Y3+44

eatBtn.MouseButton1Click:Connect(function()
    for i = 1, burgers do
        game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer("Chezburger")
    end
end)

local invBtn = Instance.new("TextButton", burgerFrame)
invBtn.Size = UDim2.new(1, -38, 0, 38)
invBtn.Position = UDim2.new(0, 12, 0, Y3)
invBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
invBtn.Text = "Become Invulnerable"
invBtn.TextColor3 = Color3.fromRGB(255,255,255)
invBtn.Font = Enum.Font.GothamBold
invBtn.TextSize = 17
Instance.new("UICorner", invBtn).CornerRadius = UDim.new(0, 12)
Y3 = Y3+44

invBtn.MouseButton1Click:Connect(function()
    for i = 1, 100 do
        game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer("RegenCoil")
        game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer("Cake")
        game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer("Armor")
    end
end)

local abuseWarn = Instance.new("TextLabel", burgerFrame)
abuseWarn.Size = UDim2.new(1, -20, 0, 22)
abuseWarn.Position = UDim2.new(0, 10, 1, -28)
abuseWarn.AnchorPoint = Vector2.new(0,1)
abuseWarn.BackgroundTransparency = 1
abuseWarn.Text = "DO NOT ABUSE THE AMOUNT"
abuseWarn.TextColor3 = Color3.fromRGB(255,48,48)
abuseWarn.Font = Enum.Font.GothamBold
abuseWarn.TextSize = 15
abuseWarn.TextWrapped = true

local creditFrame = tabFrames["Credits"]

local creditsTitle = Instance.new("TextLabel", creditFrame)
creditsTitle.Size = UDim2.new(1, 0, 0, 40)
creditsTitle.Position = UDim2.new(0, 0, 0.5, -36)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "Credits"
creditsTitle.TextColor3 = Color3.fromRGB(255,170,44)
creditsTitle.Font = Enum.Font.FredokaOne
creditsTitle.TextSize = 28
creditsTitle.TextWrapped = true
creditsTitle.TextXAlignment = Enum.TextXAlignment.Center

local creditsAuthor = Instance.new("TextLabel", creditFrame)
creditsAuthor.Size = UDim2.new(1, 0, 0, 30)
creditsAuthor.Position = UDim2.new(0, 0, 0.5, 4)
creditsAuthor.BackgroundTransparency = 1
creditsAuthor.Text = "Made by Freeman4i37!"
creditsAuthor.TextColor3 = Color3.fromRGB(255,170,44)
creditsAuthor.Font = Enum.Font.FredokaOne
creditsAuthor.TextSize = 22
creditsAuthor.TextWrapped = true
creditsAuthor.TextXAlignment = Enum.TextXAlignment.Center

minimize.MouseButton1Click:Connect(function()
    local tweenMin = tween:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Position = UDim2.new(0, 80, 0.5, -320)})
    tweenMin:Play()
    tweenMin.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)
openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0, 80, 0.5, -220)
    local tweenIn = tween:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = 0, Position = UDim2.new(0, 80, 0.5, -220)})
    tweenIn:Play()
end)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
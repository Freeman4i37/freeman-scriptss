local cg = game:GetService("CoreGui")
local old = cg:FindFirstChild("FMAN_HUB_SAKTKA51")
if old then old:Destroy() end

local player = game.Players.LocalPlayer
local ws = game:GetService("Workspace")
local rs = game:GetService("RunService")
local tween = game:GetService("TweenService")

local gui = Instance.new("ScreenGui", cg)
gui.Name = "FMAN_HUB_SAKTKA51"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local notifyFrame = Instance.new("Frame", gui)
notifyFrame.Size = UDim2.new(0, 440, 0, 50)
notifyFrame.Position = UDim2.new(0.5, -220, 0.15, 0)
notifyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
notifyFrame.BorderSizePixel = 0
notifyFrame.Visible = true
Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 10)
local notifyText = Instance.new("TextLabel", notifyFrame)
notifyText.Size = UDim2.new(1,0,1,0)
notifyText.BackgroundTransparency = 1
notifyText.Font = Enum.Font.FredokaOne
notifyText.Text = "This script is still under development, expect errors."
notifyText.TextColor3 = Color3.fromRGB(255,170,44)
notifyText.TextScaled = true
notifyText.TextStrokeTransparency = 0.2
notifyText.TextStrokeColor3 = Color3.new(0,0,0)
spawn(function()
	wait(3.5)
	tween:Create(notifyFrame, TweenInfo.new(.7),{BackgroundTransparency=1, Position=notifyFrame.Position + UDim2.new(0,0,-.09,0)}):Play()
	wait(.68)
	notifyFrame:Destroy()
end)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 370)
frame.Position = UDim2.new(0, 60, 0.5, -185)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundColor3 = Color3.fromRGB(12,12,12)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FMAN HUB - SAKTKA51"
title.TextColor3 = Color3.fromRGB(240,240,240)
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

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(0, 90, 0, 110)
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
sidebar.Size = UDim2.new(0, 48, 1, -46)
sidebar.Position = UDim2.new(0, 0, 0, 46)
sidebar.BackgroundTransparency = 1

local tabIcons = {"🔫","⚙️"}
local tabNames = {"Weapons","Mods"}
local tabs, tabFrames = {}, {}

for i, icon in ipairs(tabIcons) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0, 40, 0, 40)
    btn.Position = UDim2.new(0, 4, 0, 12 + (i-1)*52)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 26
    btn.TextColor3 = Color3.fromRGB(210,210,210)
    btn.BackgroundColor3 = Color3.fromRGB(32,32,32)
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    tabs[tabNames[i]] = btn

    local f = Instance.new("Frame", frame)
    f.Name = tabNames[i].."Frame"
    f.Position = UDim2.new(0, 56, 0, 54)
    f.Size = UDim2.new(1, -64, 1, -62)
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

local weaponsFrame = tabFrames.Weapons
local grabBtn = Instance.new("TextButton", weaponsFrame)
grabBtn.Size = UDim2.new(1, -44, 0, 40)
grabBtn.Position = UDim2.new(0, 16, 0, 20)
grabBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
grabBtn.Text = "Bring All Weapons"
grabBtn.TextColor3 = Color3.fromRGB(255,255,255)
grabBtn.Font = Enum.Font.GothamBold
grabBtn.TextSize = 19
grabBtn.AutoButtonColor = true
Instance.new("UICorner", grabBtn).CornerRadius = UDim.new(0, 12)

grabBtn.MouseButton1Click:Connect(function()
    local lqG_YI0E_2X = {}
    for _, v in pairs(ws:FindFirstChild("Weapons"):GetDescendants()) do
        if v.Name == "TouchInterest" and v.ClassName == "TouchTransmitter" then
            table.insert(lqG_YI0E_2X, v.Parent)
        end
    end
    for _, parent in ipairs(lqG_YI0E_2X) do
        firetouchinterest(player.Character.HumanoidRootPart, parent, 0)
        firetouchinterest(player.Character.HumanoidRootPart, parent, 1)
    end
end)

local tpBtn = Instance.new("TextButton", weaponsFrame)
tpBtn.Size = UDim2.new(1, -44, 0, 38)
tpBtn.Position = UDim2.new(0, 16, 0, 70)
tpBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
tpBtn.Text = "TP Pack a Punch (WIP)"
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 18
tpBtn.AutoButtonColor = true
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 12)

tpBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(110.22671508789062, 335.4999084472656, 70.36436462402344)
    end
end)

for _,btn in pairs({grabBtn, tpBtn}) do
    btn.MouseEnter:Connect(function()
        tween:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(64,64,64)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    end)
end

local modsFrame = tabFrames.Mods
local scroll = Instance.new("ScrollingFrame", modsFrame)
scroll.Position = UDim2.new(0,0,0,0)
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,380)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 8
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)

local function MakeBtn(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -24, 0, 38)
    btn.Position = UDim2.new(0, 12, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 17
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    btn.Parent = scroll
    btn.LayoutOrder = #scroll:GetChildren()
    btn.MouseEnter:Connect(function()
        tween:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(64,64,64)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
    end)
    return btn
end

local infAmmoBtn = MakeBtn("INF Ammo")
infAmmoBtn.MouseButton1Click:Connect(function()
    for i,v in next,getgc(true)do
        if type(v)=='table'and rawget(v,'ammo')then
            v.ammo = math.huge
            v.stored_ammo = math.huge
        end
    end
end)

local giveAmmoBtn = MakeBtn("Give Ammo")
giveAmmoBtn.MouseButton1Click:Connect(function()
    for i,v in next,getgc(true)do
        if type(v)=='table'and rawget(v,'ammo')then
            v.stored_ammo = v.max_stored
        end
    end
end)

local antiAfkBtn = MakeBtn("Anti-Afk")
local antiAfkState = false
antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkState = not antiAfkState
    if antiAfkState then
        local Players = game:GetService('Players')
        local GC = getconnections or get_signal_cons
        if GC then
            for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
                if v["Disable"] then v["Disable"](v)
                elseif v["Disconnect"] then v["Disconnect"](v) end
            end
        end
        antiAfkBtn.Text = "Anti-Afk (ON)"
    else
        antiAfkBtn.Text = "Anti-Afk (OFF)"
    end
end)

local espKillersBtn = MakeBtn("ESP Killers (bugged but work)")
local espState = false
local killerEsps = {}
local killerCon = nil
local killerNewCon = nil

local function addKillerEsp(v)
    if v:IsDescendantOf(workspace) and not v:FindFirstChild("KillerEspGreen") then
        local gui = Instance.new("BillboardGui")
        gui.Name = "KillerEspGreen"
        gui.ResetOnSpawn = false
        gui.AlwaysOnTop = true
        gui.Size = UDim2.new(2,0,2,0)
        gui.Parent = v
        local esp = Instance.new("TextLabel", gui)
        esp.Name = "TextLabel"
        esp.BackgroundTransparency = 1
        esp.Size = UDim2.new(1,0,1,0)
        esp.Font = Enum.Font.GothamBold
        esp.TextColor3 = Color3.fromRGB(0,255,0)
        esp.TextStrokeTransparency = 0.3
        esp.TextScaled = true
        killerEsps[v] = {gui = gui, label = esp}
    end
end

local function clearAllEsps()
    for v, data in pairs(killerEsps) do
        if data.gui and data.gui.Parent then data.gui:Destroy() end
    end
    killerEsps = {}
end

espKillersBtn.MouseButton1Click:Connect(function()
    espState = not espState
    espKillersBtn.Text = espState and "ESP Killers (ON)" or "ESP Killers (OFF)"
    if espState then
        local killers = ws:FindFirstChild("Killers")
        if killers then
            for _,v in pairs(killers:GetDescendants()) do
                if v.Name == "Head" and v:IsA("BasePart") and v.Parent then
                    addKillerEsp(v)
                end
            end
            if killerNewCon then killerNewCon:Disconnect() end
            killerNewCon = killers.DescendantAdded:Connect(function(v)
                if v.Name == "Head" and v:IsA("BasePart") and v.Parent then
                    addKillerEsp(v)
                end
            end)
            if killerCon then killerCon:Disconnect() end
            killerCon = rs.RenderStepped:Connect(function()
                for v, data in pairs(killerEsps) do
                    if v and v.Parent then
                        data.label.Text = v.Parent.Name
                    end
                end
            end)
        end
    else
        if killerCon then killerCon:Disconnect() end
        if killerNewCon then killerNewCon:Disconnect() end
        clearAllEsps()
    end
end)

local firerateBtn = MakeBtn("Firerate")
local firerateLevel = 1
local firerateLevels = {"V1","V2","V3"}
local firerateVals = {.18,.0000001,.03}
firerateBtn.Text = "Firerate (...)"
firerateBtn.MouseButton1Click:Connect(function()
    firerateLevel = firerateLevel % 3 + 1
    local XBullet = firerateVals[firerateLevel]
    for i,m in next,getgc(true)do
        if type(m)=='table'and rawget(m,'ammo') then
            m.shoot_wait = XBullet
            m.is_auto = true 
            m.bullet_count = 1
        end
    end
    firerateBtn.Text = "Firerate ("..firerateLevels[firerateLevel]..")"
end)

minimize.MouseButton1Click:Connect(function()
    local tweenMin = tween:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Position = UDim2.new(0, 60, 0.5, -260)})
    tweenMin:Play()
    tweenMin.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0, 60, 0.5, -180)
    local tweenIn = tween:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = 0, Position = UDim2.new(0, 60, 0.5, -185)})
    tweenIn:Play()
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
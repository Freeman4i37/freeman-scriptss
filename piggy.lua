local cg = game:GetService("CoreGui")
local old = cg:FindFirstChild("FMAN_HUB_PIGGY")
if old then old:Destroy() end

local player = game.Players.LocalPlayer
local ws = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local rs = game:GetService("RunService")
local tween = game:GetService("TweenService")
local fps = 0
local frameTimes = {}

rs.RenderStepped:Connect(function()
    local t = tick()
    table.insert(frameTimes, t)
    while frameTimes[1] and frameTimes[1] < t - 1 do
        table.remove(frameTimes, 1)
    end
    fps = #frameTimes
end)

local gui = Instance.new("ScreenGui", cg)
gui.Name = "FMAN_HUB_PIGGY"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 320)
frame.Position = UDim2.new(0, 60, 0.5, -160)
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
title.Text = "FMAN HUB - Piggy Farm"
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

local tabIcons = {"🔧", "⚙️"}
local tabNames = {"Farm", "Settings"}
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

local farmFrame = tabFrames.Farm

local farmBtn = Instance.new("TextButton", farmFrame)
farmBtn.Size = UDim2.new(1, -44, 0, 40)
farmBtn.Position = UDim2.new(0, 16, 0, 28)
farmBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
farmBtn.Text = "FARM PIGGY COINS"
farmBtn.TextColor3 = Color3.fromRGB(255,255,255)
farmBtn.Font = Enum.Font.GothamBold
farmBtn.TextSize = 19
farmBtn.AutoButtonColor = true
Instance.new("UICorner", farmBtn).CornerRadius = UDim.new(0, 12)

farmBtn.MouseButton1Click:Connect(function()
    local spawn = ws:FindFirstChild("GameFolder") and ws.GameFolder:FindFirstChild("MainSpawn")
    if spawn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = spawn.Position + Vector3.new(0, 8, 0)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end)

local setFrame = tabFrames.Settings
local state = {fullbright=false, fps=false}

local fullbrightBtn = Instance.new("TextButton", setFrame)
fullbrightBtn.Size = UDim2.new(1, -44, 0, 38)
fullbrightBtn.Position = UDim2.new(0, 16, 0, 20)
fullbrightBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
fullbrightBtn.Text = "FULLBRIGHT: OFF"
fullbrightBtn.TextColor3 = Color3.fromRGB(255,255,255)
fullbrightBtn.Font = Enum.Font.GothamBold
fullbrightBtn.TextSize = 18
Instance.new("UICorner", fullbrightBtn).CornerRadius = UDim.new(0, 12)

local fpsBtn = Instance.new("TextButton", setFrame)
fpsBtn.Size = UDim2.new(1, -44, 0, 38)
fpsBtn.Position = UDim2.new(0, 16, 0, 68)
fpsBtn.BackgroundColor3 = Color3.fromRGB(44,44,44)
fpsBtn.Text = "FPS: OFF"
fpsBtn.TextColor3 = Color3.fromRGB(255,255,255)
fpsBtn.Font = Enum.Font.GothamBold
fpsBtn.TextSize = 18
Instance.new("UICorner", fpsBtn).CornerRadius = UDim.new(0, 12)

local fpsLabel = Instance.new("TextLabel", setFrame)
fpsLabel.Size = UDim2.new(1, -30, 0, 26)
fpsLabel.Position = UDim2.new(0, 16, 0, 120)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = ""
fpsLabel.TextColor3 = Color3.fromRGB(255,255,255)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.Visible = false

local oldAmb, oldBright, oldOutAmb, oldTime
fullbrightBtn.MouseButton1Click:Connect(function()
    state.fullbright = not state.fullbright
    fullbrightBtn.Text = "FULLBRIGHT: "..(state.fullbright and "ON" or "OFF")
    fullbrightBtn.BackgroundColor3 = state.fullbright and Color3.fromRGB(80,80,80) or Color3.fromRGB(44,44,44)
    if state.fullbright then
        oldAmb = lighting.Ambient
        oldBright = lighting.Brightness
        oldOutAmb = lighting.OutdoorAmbient
        oldTime = lighting.TimeOfDay
        lighting.Ambient = Color3.new(1,1,1)
        lighting.Brightness = 3
        lighting.OutdoorAmbient = Color3.new(1,1,1)
        lighting.TimeOfDay = "14:00:00"
    else
        if oldAmb then lighting.Ambient = oldAmb end
        if oldBright then lighting.Brightness = oldBright end
        if oldOutAmb then lighting.OutdoorAmbient = oldOutAmb end
        if oldTime then lighting.TimeOfDay = oldTime end
    end
end)

fpsBtn.MouseButton1Click:Connect(function()
    state.fps = not state.fps
    fpsBtn.Text = "FPS: "..(state.fps and "ON" or "OFF")
    fpsBtn.BackgroundColor3 = state.fps and Color3.fromRGB(80,80,80) or Color3.fromRGB(44,44,44)
    fpsLabel.Visible = state.fps
end)
rs.RenderStepped:Connect(function()
    if state.fps then
        fpsLabel.Text = "FPS: "..tostring(fps)
    end
end)

for _,btn in pairs({farmBtn, fullbrightBtn, fpsBtn}) do
    btn.MouseEnter:Connect(function()
        tween:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(64,64,64)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if btn == farmBtn then
            btn.BackgroundColor3 = Color3.fromRGB(44,44,44)
        elseif btn == fullbrightBtn then
            btn.BackgroundColor3 = state.fullbright and Color3.fromRGB(80,80,80) or Color3.fromRGB(44,44,44)
        elseif btn == fpsBtn then
            btn.BackgroundColor3 = state.fps and Color3.fromRGB(80,80,80) or Color3.fromRGB(44,44,44)
        end
    end)
end

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
    frame.Position = UDim2.new(0, 60, 0.5, -260)
    local tweenIn = tween:Create(frame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundTransparency = 0, Position = UDim2.new(0, 60, 0.5, -160)})
    tweenIn:Play()
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
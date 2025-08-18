local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "RLD_UI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local mainColor = Color3.fromRGB(18, 18, 18)
local borderColor = Color3.fromRGB(30, 30, 30)
local accentColor = Color3.fromRGB(40, 120, 255)
local buttonColor = Color3.fromRGB(30, 30, 30)
local textColor = Color3.fromRGB(255,255,255)
local closeColor = Color3.fromRGB(180,30,30)
local minimizeColor = Color3.fromRGB(60,60,60)
local strongPink = Color3.fromRGB(255, 65, 195)
local strongOrange = Color3.fromRGB(255, 165, 0)
local strongCyan = Color3.fromRGB(0, 255, 255)
local strongRed = Color3.fromRGB(255, 0, 0)
local strongLime = Color3.fromRGB(140, 255, 60)
local strongYellow = Color3.fromRGB(255, 255, 40)

local lightColorTable = {
    red    = Color3.fromRGB(255,0,0),
    yellow = Color3.fromRGB(255,255,0),
    blue   = Color3.fromRGB(0,150,255),
    green  = Color3.fromRGB(0,255,0),
    purple = Color3.fromRGB(150,0,255),
    pink   = Color3.fromRGB(255, 65, 195),
    white  = Color3.fromRGB(255,255,255)
}
local currentLightColor = "white"
local playerLight
local lightEnabled = false

local function UpdatePlayerLight()
    if not lightEnabled then
        if playerLight then playerLight:Destroy(); playerLight = nil end
        return
    end
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    if not playerLight then
        playerLight = Instance.new("PointLight")
        playerLight.Name = "RLD_Light"
        playerLight.Parent = player.Character.HumanoidRootPart
        playerLight.Range = 130
        playerLight.Brightness = 2
    end
    playerLight.Color = lightColorTable[currentLightColor] or lightColorTable.white
end
player.CharacterAdded:Connect(function() wait(1) UpdatePlayerLight() end)

local function getTransitionColor(a, b, speed)
    local t = math.abs(math.sin(tick()*(speed or 2)))
    return Color3.new(a.R + (b.R - a.R) * t, a.G + (b.G - a.G) * t, a.B + (b.B - a.B) * t)
end
local function getMultiTransitionColor(colors, speed, interval)
    local t = (tick() * (speed or 1)) / (interval or 1)
    local idx = math.floor(t) % #colors + 1
    local nextidx = idx % #colors + 1
    local frac = t - math.floor(t)
    local c1, c2 = colors[idx], colors[nextidx]
    return Color3.new(c1.R + (c2.R - c1.R)*frac, c1.G + (c2.G - c1.G)*frac, c1.B + (c2.B - c1.B)*frac)
end
local function shouldShowForEntity(entName)
    return entName and (entName:match("^[AaBbGg]%-") or entName:upper() == "CG-55")
end

local colorTable = {
    -- Antigas
    ["happyman"] = Color3.fromRGB(255, 0, 0),
    ["sadman"] = Color3.fromRGB(255, 0, 0),
    ["angryman"] = Color3.fromRGB(255, 0, 0),
    ["nerdman"] = Color3.fromRGB(255, 65, 195),
    ["c-25"] = Color3.fromRGB(255, 65, 195),
    ["a-75"] = Color3.fromRGB(255, 65, 195),
    ["smartman"] = Color3.fromRGB(255, 65, 195),
    ["scaredman"] = Color3.fromRGB(128, 0, 128),
    ["shortman"] = Color3.fromRGB(0, 0, 255),
    ["mushman"] = Color3.fromRGB(0, 0, 255),
    ["bigman"] = Color3.fromRGB(0, 255, 0),
    ["a-25"] = Color3.fromRGB(0, 255, 0),
    ["c-60"] = Color3.fromRGB(0, 255, 0),
    ["a-105"] = Color3.fromRGB(0, 255, 0),
    ["tallman"] = Color3.fromRGB(255, 165, 0),
    ["a-45"] = Color3.fromRGB(255, 165, 0),
    ["1-a"] = Color3.fromRGB(255, 165, 0),
    ["joyfulman"] = Color3.fromRGB(255, 255, 0),
    ["a-120"] = Color3.fromRGB(255, 255, 0),
    ["a-275"] = Color3.fromRGB(255, 255, 0),
    ["glee"] = Color3.fromRGB(0, 150, 255),

    ["a-1"] = "graywhite",
    ["c-1"] = "rainbow",
    ["sn-1"] = Color3.fromRGB(48, 0, 64),
    ["jb-1"] = Color3.fromRGB(0, 96, 0),
    ["a-60"] = Color3.fromRGB(255, 0, 0),
    ["a-150"] = Color3.fromRGB(80, 180, 255),
    ["a-185"] = Color3.fromRGB(40, 80, 180),
    ["a-200"] = Color3.fromRGB(255, 255, 255),
    ["a-225"] = Color3.fromRGB(0, 0, 100),
    ["mournfulman"] = Color3.fromRGB(0, 0, 100),
    ["a-250"] = Color3.fromRGB(120, 0, 0),
    ["a-300"] = "orangered",
    ["cv-300"] = "whiteorange",
    ["wideglee"] = Color3.fromRGB(255, 65, 195),

    ["b-5"] = Color3.fromRGB(0, 255, 0),
    ["b-15"] = Color3.fromRGB(44, 74, 188),
    ["b-25"] = Color3.fromRGB(0, 255, 255),
    ["b-40"] = Color3.fromRGB(128, 40, 40),
    ["b-60"] = Color3.fromRGB(64, 0, 90),
    ["b-85"] = "blackwhite",
    ["b-100"] = Color3.fromRGB(0, 40, 90),
    ["b-120"] = Color3.fromRGB(120, 120, 120),
    ["b-140"] = Color3.fromRGB(120, 255, 120),
    ["mob-1"] = Color3.fromRGB(0, 255, 0),
    ["mob-2"] = Color3.fromRGB(0, 255, 0),
    ["b-170"] = Color3.fromRGB(70, 140, 70),
    ["b-200"] = "whitered",
    ["b-244"] = Color3.fromRGB(255, 0, 0),
    ["b-270"] = Color3.fromRGB(128, 0, 255),
    ["b-300"] = Color3.fromRGB(50, 255, 90),

    ["g-3"] = Color3.fromRGB(0, 80, 0),
    ["g-26"] = "g26bw",
    ["g-55"] = "g55wgb",
    ["cg-55"] = "g55wgb",
    ["gta-55"] = "g55wgb",
    ["cgta-55"] = "g55wgb",
    ["g-60"] = Color3.fromRGB(0, 255, 255),
    ["g-88"] = "g88transition",
    ["g-100"] = "greendarkred",
    ["g-122"] = Color3.fromRGB(255, 0, 0),
    ["g-150"] = Color3.fromRGB(255, 65, 195),
    ["g-159"] = Color3.fromRGB(140, 255, 60),
    ["g-177"] = Color3.fromRGB(0, 120, 0),
    ["g-200"] = Color3.fromRGB(255, 65, 195),
    ["g-222"] = "bluewhite",
    ["g-235"] = Color3.fromRGB(255, 255, 40),
    ["g-250"] = Color3.fromRGB(255, 165, 0),
    ["g-300"] = "g300multi",

    ["c-45"] = Color3.fromRGB(128, 0, 255),
    ["cc-45"] = Color3.fromRGB(0, 255, 255),
    ["c-105"] = "shadesofblue",
    ["cc-105"] = "orangetones",
    ["car-25"] = "bluered",
    ["g-45"] = "bwgray",
    ["cc-25"] = Color3.fromRGB(0, 255, 255),
    ["bagc-60"] = "bagc60multi",
    ["cc-60"] = Color3.fromRGB(190, 0, 255),
    ["ccc-60"] = "greencyan",

    -- Novas
    ["a-27"] = Color3.fromRGB(245, 245, 220), -- Beige
    ["widowed sleeper"] = Color3.fromRGB(255, 165, 0),
    ["cg-200"] = Color3.fromRGB(255, 120, 40),
    ["c-200"] = Color3.fromRGB(128, 128, 128),
    ["a-50"] = Color3.fromRGB(255, 0, 0),
    ["billy-140"] = "billy140mix",
    ["cfo-300"] = Color3.fromRGB(0, 255, 255),
    ["g-140"] = "g140fire",
    ["olaf-26"] = Color3.fromRGB(240, 240, 255),
    ["omg-40"] = "crazyall",
    ["nibbleton"] = Color3.fromRGB(128, 128, 128),
    ["guh"] = "guhwhiteorange",
    ["woah..."] = Color3.fromRGB(0, 255, 0),
    ["holay molay.."] = "holaymolay",
    ["g-eighty eight"] = "g88nopink",
    ["g-18"] = Color3.fromRGB(255, 255, 0),
    ["cg-18"] = Color3.fromRGB(0, 255, 255),
    ["b-385"] = Color3.fromRGB(128, 0, 255),
    ["ook"] = Color3.fromRGB(90, 0, 0),
    ["my_inner_skin"] = Color3.fromRGB(90, 0, 0),
    ["a-100"] = Color3.fromRGB(200, 60, 180),
    ["a-10"] = Color3.fromRGB(0, 120, 255),
    ["a-35"] = Color3.fromRGB(0, 255, 0),
    ["x-15"] = Color3.fromRGB(0, 255, 255),
    ["x-35"] = Color3.fromRGB(200, 60, 180),
    ["xx-10"] = Color3.fromRGB(255, 0, 0),
    ["xx-35"] = Color3.fromRGB(0, 120, 255),
    ["x-100"] = Color3.fromRGB(0, 255, 0),
    ["a-183"] = Color3.fromRGB(255, 120, 30),
    ["e-22"] = Color3.fromRGB(255, 120, 30),
    ["e-142"] = Color3.fromRGB(128, 0, 255),
    ["ae-sixte"] = Color3.fromRGB(255, 0, 0),
    ["a-240"] = Color3.fromRGB(0, 120, 255),
    ["fork"] = Color3.fromRGB(255, 0, 0),
    ["fudge"] = Color3.fromRGB(255, 0, 0),
}
local function getEntityColor(entity)
    local name = entity.Name:lower()
    -- CG-55 e CGTA-55 usam o efeito g55wgb
    if name == "cg-55" or name == "cgta-55" then
        return getMultiTransitionColor({
            Color3.fromRGB(255,255,255),
            Color3.fromRGB(180,180,180),
            Color3.fromRGB(0,0,0)
        }, 7, 1)
    end
    local color = colorTable[name]
    if not color then
        for key, val in pairs(colorTable) do
            if name == key or entity.Name == key or entity.Name == key:upper() or entity.Name:match("^A%-%d+") or entity.Name:match("^B%-%d+") or entity.Name:match("^G%-%d+") then
                color = val
                break
            end
        end
    end
    if not color then return Color3.fromRGB(255,255,255) end

    -- EFEITOS DINÂMICOS PADRÃO
    if color == "graywhite" then
        local v = math.abs(math.sin(tick()*2))
        return Color3.new(v,v,v)
    elseif color == "rainbow" then
        local rainbow = {
            Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0),
            Color3.fromRGB(255,255,0), Color3.fromRGB(0,255,0),
            Color3.fromRGB(0,0,255), Color3.fromRGB(75,0,130),
            Color3.fromRGB(148,0,211)
        }
        local t = tick()*8
        local i = math.floor(t)%#rainbow+1
        return rainbow[i]
    elseif color == "orangered" then
        local v = math.abs(math.sin(tick()*2))
        return Color3.fromRGB(255,math.floor(70+70*v),0)
    elseif color == "whiteorange" then
        return getTransitionColor(Color3.fromRGB(255,255,255), Color3.fromRGB(255,140,0), 2)
    elseif color == "blackwhite" then
        return getTransitionColor(Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255), 2.5)
    elseif color == "whitered" then
        return getTransitionColor(Color3.fromRGB(255,255,255), Color3.fromRGB(255,0,0), 2.5)
    elseif color == "greendarkred" then
        if math.floor(tick())%2 == 0 then
            return Color3.fromRGB(0,255,0)
        else
            return Color3.fromRGB(120,0,0)
        end
    elseif color == "bluewhite" then
        return getTransitionColor(Color3.fromRGB(0,170,255), Color3.fromRGB(255,255,255), 2.3)
    elseif color == "g26bw" then
        if math.floor(tick()*2)%2==0 then
            return Color3.fromRGB(0,0,0)
        else
            return Color3.fromRGB(255,255,255)
        end
    elseif color == "g55wgb" then
        return getMultiTransitionColor({
            Color3.fromRGB(255,255,255),
            Color3.fromRGB(180,180,180),
            Color3.fromRGB(0,0,0)
        }, 7, 1)
    elseif color == "g300multi" then
        return getMultiTransitionColor({
            strongRed, strongOrange, Color3.fromRGB(0,30,80),
            Color3.fromRGB(0,255,0), strongYellow
        }, 2, 1)

    -- ----------- EFEITOS NOVOS/ESPECIAIS -------------
    -- Tons de azul
    elseif color == "shadesofblue" then
        return getMultiTransitionColor({
            Color3.fromRGB(80,150,255),
            Color3.fromRGB(0,40,255),
            Color3.fromRGB(0,120,255),
            Color3.fromRGB(0,200,255)
        }, 2, 1)
    -- Tons de laranja
    elseif color == "orangetones" then
        return getMultiTransitionColor({
            Color3.fromRGB(255,150,0),
            Color3.fromRGB(255,200,80),
            Color3.fromRGB(255,120,30)
        }, 2, 1)
    -- Azul e vermelho juntos
    elseif color == "bluered" then
        return getTransitionColor(Color3.fromRGB(0,120,255), Color3.fromRGB(255,0,0), 6)
    -- Preto + cinza
    elseif color == "bwgray" then
        return getTransitionColor(Color3.fromRGB(0,0,0), Color3.fromRGB(150,150,150), 2)
    -- Mistura roxo, ciano, vermelho, verde
    elseif color == "bagc60multi" then
        return getMultiTransitionColor({
            Color3.fromRGB(160,0,255),
            Color3.fromRGB(0,255,255),
            Color3.fromRGB(255,0,0),
            Color3.fromRGB(0,255,0),
        }, 2, 1)
    -- Verde com tons de ciano
    elseif color == "greencyan" then
        return getTransitionColor(Color3.fromRGB(0,255,0), Color3.fromRGB(0,255,255), 2)

    -- ==== NOVOS EFEITOS DINÂMICOS ====

    -- G-88: OrangeT, PinkT, RedT, YellowT transition
    elseif color == "g88transition" then
        return getMultiTransitionColor({
            Color3.fromRGB(255, 120, 30), -- OrangeT
            Color3.fromRGB(255, 65, 195), -- PinkT
            Color3.fromRGB(255, 0, 0),    -- RedT
            Color3.fromRGB(255, 255, 40), -- YellowT
        }, 2.5, 1)
    -- G-Eighty Eight: PinkT, RedT, YellowT
    elseif color == "g88nopink" then
        return getMultiTransitionColor({
            Color3.fromRGB(255, 65, 195), -- PinkT
            Color3.fromRGB(255, 0, 0),    -- RedT
            Color3.fromRGB(255, 255, 40), -- YellowT
        }, 2.5, 1)
    -- Billy-140: blue and purple tones, mix
    elseif color == "billy140mix" then
        return getMultiTransitionColor({
            Color3.fromRGB(80, 150, 255),
            Color3.fromRGB(0, 40, 255),
            Color3.fromRGB(128, 0, 255),
            Color3.fromRGB(200, 60, 180)
        }, 2, 1)
    -- G-140: Orange tones, fire type
    elseif color == "g140fire" then
        return getMultiTransitionColor({
            Color3.fromRGB(255, 120, 30),
            Color3.fromRGB(255, 165, 0),
            Color3.fromRGB(255, 60, 0)
        }, 3, 1)
    -- Omg-40: All colors, crazy transition every 0.5s
    elseif color == "crazyall" then
        return getMultiTransitionColor({
            Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 127, 0),
            Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130),
            Color3.fromRGB(148, 0, 211), Color3.fromRGB(255,255,255)
        }, 12, 0.5)
    -- GUH: White, then orange every 1s
    elseif color == "guhwhiteorange" then
        if math.floor(tick()) % 2 == 0 then
            return Color3.fromRGB(255,255,255)
        else
            return Color3.fromRGB(255, 120, 30)
        end
    -- Holay Molay.. : White for 5s, then Purple flashing for 5s
    elseif color == "holaymolay" then
        local t = math.floor(tick() / 5) % 2
        if t == 0 then
            return Color3.fromRGB(255,255,255)
        else
            local flash = (math.floor(tick()*4) % 2 == 0)
            if flash then
                return Color3.fromRGB(128,0,255)
            else
                return Color3.fromRGB(255,255,255)
            end
        end
    end

    -- Cores fixas
    return color
end

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "RLD_ESP"
local espEnabled = true
local espBlocked = {}

local function CreateESP(part, entity)
    if part:FindFirstChild("ESP_Billboard") then return end
    if espBlocked[entity] then return end
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ESP_Billboard"
    Billboard.Adornee = part
    Billboard.Size = UDim2.new(0, 140, 0, 50)
    Billboard.AlwaysOnTop = true
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextStrokeTransparency = 0
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamBold
    Label.Text = entity.Name .. " | 0m"
    Label.Parent = Billboard
    Billboard.Parent = ESPFolder
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if Billboard and Billboard.Adornee and espEnabled and not espBlocked[entity] then
            local distance = (player.Character.HumanoidRootPart.Position - Billboard.Adornee.Position).Magnitude
            Label.Text = entity.Name .. " | " .. math.floor(distance) .. "M"
            Label.TextColor3 = getEntityColor(entity)
            Billboard.Enabled = true
        else
            Billboard:Destroy()
            if connection then connection:Disconnect() end
        end
    end)
    entity.AncestryChanged:Connect(function(_, parent)
        if not parent then
            Billboard:Destroy()
            if connection then connection:Disconnect() end
        end
    end)
end

task.spawn(function()
    while true do
        if espEnabled then
            local folder = workspace:FindFirstChild("SpawnedEnitites")
            if folder then
                for _, entity in pairs(folder:GetChildren()) do
                    if not espBlocked[entity] then
                        local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
                        if part then
                            CreateESP(part, entity)
                        end
                    end
                end
            end
        end
        wait(0.7)
    end
end)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 270, 0, 400)
frame.Position = UDim2.new(0.06, 0, 0.18, 0)
frame.BackgroundColor3 = mainColor
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = borderColor
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Text = "Freeman HUB: RLD 2.0"
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0,36,0,32)
closeButton.Position = UDim2.new(1, -44, 0, 3)
closeButton.BackgroundColor3 = closeColor
closeButton.TextColor3 = textColor
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "-"
minimizeButton.Size = UDim2.new(0,32,0,32)
minimizeButton.Position = UDim2.new(1, -80, 0, 3)
minimizeButton.BackgroundColor3 = minimizeColor
minimizeButton.TextColor3 = textColor
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

local configButton = Instance.new("TextButton")
configButton.Text = "⚙️"
configButton.Size = UDim2.new(0,32,0,32)
configButton.Position = UDim2.new(1, -116, 0, 3)
configButton.BackgroundColor3 = Color3.fromRGB(32,32,32)
configButton.TextColor3 = textColor
configButton.Font = Enum.Font.GothamBold
configButton.TextScaled = true
configButton.BorderSizePixel = 0
configButton.Parent = titleBar
Instance.new("UICorner", configButton).CornerRadius = UDim.new(0, 6)

local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.new(0, 38, 0, 38)
miniButton.Position = UDim2.new(0, 8, 0, 8)
miniButton.BackgroundColor3 = mainColor
miniButton.Text = "+"
miniButton.TextColor3 = textColor
miniButton.Font = Enum.Font.GothamBold
miniButton.TextScaled = true
miniButton.Visible = false
miniButton.BorderSizePixel = 0
miniButton.Parent = gui
Instance.new("UICorner", miniButton).CornerRadius = UDim.new(0, 8)

local btnHolder = Instance.new("Frame")
btnHolder.Size = UDim2.new(1, -24, 0, 226)
btnHolder.Position = UDim2.new(0, 12, 0, 54)
btnHolder.BackgroundTransparency = 1
btnHolder.Parent = frame

local function CreateButton(text, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = buttonColor
    btn.Text = text
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = btnHolder
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local espButton = CreateButton("ESP: ON", 0)
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
end)

local autoDoorsButton = CreateButton("Auto Doors: OFF", 44)
autoDoorsButton.MouseButton1Click:Connect(function()
    getgenv().RLD_AutoDoorsEnabled = not getgenv().RLD_AutoDoorsEnabled
    autoDoorsButton.Text = getgenv().RLD_AutoDoorsEnabled and "Auto Doors: ON" or "Auto Doors: OFF"
end)
if not getgenv().RLD_AutoDoorsLock then
    getgenv().RLD_AutoDoorsLock = true
    task.spawn(function()
        while true do
            if getgenv().RLD_AutoDoorsEnabled then
                for _, section in pairs({"CurrentRoomsA", "CurrentRoomsB", "CurrentRoomsG"}) do
                    local folder = workspace:FindFirstChild(section)
                    if folder then
                        for _, room in pairs(folder:GetChildren()) do
                            for _, obj in pairs(room:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") and obj.ActionText == "Open" and obj.MaxActivationDistance >= 0 then
                                    fireproximityprompt(obj)
                                    wait(0.01)
                                end
                            end
                        end
                    end
                end
            end
            wait(0.01)
        end
    end)
end

local spawnedEntitiesButton = CreateButton("Spawned Entities", 88)
local alertEntitiesButton = CreateButton("Alert Entities: OFF", 132)
local alertEntitiesEnabled = false
alertEntitiesButton.MouseButton1Click:Connect(function()
    alertEntitiesEnabled = not alertEntitiesEnabled
    alertEntitiesButton.Text = alertEntitiesEnabled and "Alert Entities: ON" or "Alert Entities: OFF"
end)

local credit = Instance.new("TextLabel")
credit.Text = "Freeman4i37"
credit.Size = UDim2.new(1, 0, 0, 22)
credit.Position = UDim2.new(0, 0, 1, -28)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.Parent = frame

local lastEntities = {}
task.spawn(function()
    while true do
        local folder = workspace:FindFirstChild("SpawnedEnitites")
        if folder then
            local current = {}
            for _, entity in pairs(folder:GetChildren()) do current[entity] = true end
            for entity,_ in pairs(current) do
                if not lastEntities[entity] then
                    if alertEntitiesEnabled and shouldShowForEntity(entity.Name) then
                        local guiAlert = Instance.new("Frame")
                        guiAlert.Name = "EntityAlertPrompt"
                        guiAlert.Size = UDim2.new(0, 400, 0, 74)
                        guiAlert.AnchorPoint = Vector2.new(0.5,0.5)
                        guiAlert.Position = UDim2.new(0.5,0,0.5,0)
                        guiAlert.BackgroundColor3 = mainColor
                        guiAlert.BorderSizePixel = 0
                        guiAlert.Parent = gui
                        guiAlert.ZIndex = 1000
                        Instance.new("UICorner", guiAlert).CornerRadius = UDim.new(0,13)
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(1,0,1,0)
                        label.Position = UDim2.new(0,0,0,0)
                        label.BackgroundTransparency = 1
                        label.Text = 'The Entity "' .. tostring(entity.Name or "???") .. '" has spawned.'
                        label.Font = Enum.Font.GothamBold
                        label.TextScaled = true
                        label.ZIndex = 1001
                        label.Parent = guiAlert
                        local heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                            if label and label.Parent then
                                label.TextColor3 = getEntityColor(entity)
                            else
                                if heartbeat then heartbeat:Disconnect() end
                            end
                        end)
                        delay(5, function() if guiAlert and guiAlert.Parent then guiAlert:Destroy() end if heartbeat then heartbeat:Disconnect() end end)
                    end
                end
            end
            lastEntities = current
        end
        wait(0.1)
    end
end)

configButton.MouseButton1Click:Connect(function()
    if configFrame and configFrame.Parent then configFrame:Destroy() end
    configFrame = Instance.new("Frame")
    configFrame.Name = "ConfigFrame"
    configFrame.Size = UDim2.new(0, 260, 0, 180)
    configFrame.Position = UDim2.new(0.5, -130, 0.22, 0)
    configFrame.BackgroundColor3 = mainColor
    configFrame.Parent = gui
    configFrame.ZIndex = 100
    Instance.new("UICorner", configFrame).CornerRadius = UDim.new(0, 10)

    local close = Instance.new("TextButton")
    close.Text = "X"
    close.Size = UDim2.new(0, 32, 0, 32)
    close.Position = UDim2.new(1, -36, 0, 4)
    close.BackgroundColor3 = closeColor
    close.TextColor3 = textColor
    close.Font = Enum.Font.GothamBold
    close.TextScaled = true
    close.ZIndex = 101
    close.Parent = configFrame
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
    close.MouseButton1Click:Connect(function() configFrame:Destroy() end)

    local label = Instance.new("TextLabel")
    label.Text = "Settings"
    label.Size = UDim2.new(1, -36, 0, 32)
    label.Position = UDim2.new(0, 10, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(210,210,210)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.ZIndex = 100
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = configFrame

    local resetESPBtn = Instance.new("TextButton")
    resetESPBtn.Text = "Reset ESP Entities"
    resetESPBtn.Size = UDim2.new(1, -24, 0, 36)
    resetESPBtn.Position = UDim2.new(0, 12, 0, 48)
    resetESPBtn.BackgroundColor3 = buttonColor
    resetESPBtn.TextColor3 = textColor
    resetESPBtn.Font = Enum.Font.GothamBold
    resetESPBtn.TextScaled = true
    resetESPBtn.ZIndex = 102
    resetESPBtn.Parent = configFrame
    Instance.new("UICorner", resetESPBtn).CornerRadius = UDim.new(0, 7)
    resetESPBtn.MouseButton1Click:Connect(function()
        for _,v in pairs(ESPFolder:GetChildren()) do
            if v:IsA("BillboardGui") then v:Destroy() end
        end
        espBlocked = {}
        local folder = workspace:FindFirstChild("SpawnedEnitites")
        if folder then
            for _, entity in pairs(folder:GetChildren()) do espBlocked[entity] = true end
        end
    end)

    local lightBtn = Instance.new("TextButton")
    lightBtn.Text = "Light: " .. (lightEnabled and "ON" or "OFF")
    lightBtn.Size = UDim2.new(1, -24, 0, 36)
    lightBtn.Position = UDim2.new(0, 12, 0, 96)
    lightBtn.BackgroundColor3 = buttonColor
    lightBtn.TextColor3 = textColor
    lightBtn.Font = Enum.Font.GothamBold
    lightBtn.TextScaled = true
    lightBtn.ZIndex = 102
    lightBtn.Parent = configFrame
    Instance.new("UICorner", lightBtn).CornerRadius = UDim.new(0, 7)

    local colorPanel = Instance.new("Frame")
    colorPanel.Size = UDim2.new(1, -24, 0, 38)
    colorPanel.Position = UDim2.new(0, 12, 0, 144)
    colorPanel.BackgroundColor3 = Color3.fromRGB(24,24,24)
    colorPanel.Visible = lightEnabled
    colorPanel.ZIndex = 102
    colorPanel.Parent = configFrame
    Instance.new("UICorner", colorPanel).CornerRadius = UDim.new(0,7)
    local colorLabel = Instance.new("TextLabel")
    colorLabel.Text = "Choose the color."
    colorLabel.Size = UDim2.new(1, 0, 0.4, 0)
    colorLabel.Position = UDim2.new(0,0,0,0)
    colorLabel.BackgroundTransparency = 1
    colorLabel.TextColor3 = Color3.fromRGB(220,220,220)
    colorLabel.Font = Enum.Font.GothamBold
    colorLabel.TextScaled = true
    colorLabel.ZIndex = 103
    colorLabel.Parent = colorPanel

    local colorNames = {"red","yellow","blue","green","purple","pink","white"}
    local btnW = 34
    for i, cname in ipairs(colorNames) do
        local cbtn = Instance.new("TextButton")
        cbtn.Size = UDim2.new(0, btnW, 0, btnW)
        cbtn.Position = UDim2.new(0, (i-1)*(btnW+4)+4, 0, 22)
        cbtn.BackgroundColor3 = lightColorTable[cname]
        cbtn.Text = ""
        cbtn.ZIndex = 104
        cbtn.Parent = colorPanel
        Instance.new("UICorner", cbtn).CornerRadius = UDim.new(0, 100)
        cbtn.MouseButton1Click:Connect(function()
            currentLightColor = cname
            UpdatePlayerLight()
        end)
    end

    lightBtn.MouseButton1Click:Connect(function()
        lightEnabled = not lightEnabled
        lightBtn.Text = "Light: " .. (lightEnabled and "ON" or "OFF")
        UpdatePlayerLight()
        colorPanel.Visible = lightEnabled
    end)
end)

local entitiesFrame = Instance.new("Frame")
entitiesFrame.Size = UDim2.new(0, 340, 0, 310)
entitiesFrame.Position = UDim2.new(0.19, 0, 0.19, 0)
entitiesFrame.BackgroundColor3 = mainColor
entitiesFrame.Visible = false
entitiesFrame.Parent = gui
entitiesFrame.Active = true
entitiesFrame.Draggable = true
Instance.new("UICorner", entitiesFrame).CornerRadius = UDim.new(0, 8)

local entitiesTitle = Instance.new("TextLabel")
entitiesTitle.Text = "Spawned Entities"
entitiesTitle.Size = UDim2.new(1, 0, 0, 36)
entitiesTitle.BackgroundTransparency = 1
entitiesTitle.TextColor3 = textColor
entitiesTitle.Font = Enum.Font.GothamBold
entitiesTitle.TextScaled = true
entitiesTitle.Parent = entitiesFrame

local entitiesScrolling = Instance.new("ScrollingFrame")
entitiesScrolling.Size = UDim2.new(1, -18, 1, -54)
entitiesScrolling.Position = UDim2.new(0, 9, 0, 44)
entitiesScrolling.BackgroundTransparency = 1
entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
entitiesScrolling.ScrollBarThickness = 6
entitiesScrolling.Parent = entitiesFrame
entitiesScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y

local minimizeEntitiesButton = Instance.new("TextButton")
minimizeEntitiesButton.Text = "-"
minimizeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
minimizeEntitiesButton.Position = UDim2.new(1, -74, 0, 6)
minimizeEntitiesButton.BackgroundColor3 = minimizeColor
minimizeEntitiesButton.TextColor3 = textColor
minimizeEntitiesButton.Font = Enum.Font.GothamBold
minimizeEntitiesButton.TextScaled = true
minimizeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", minimizeEntitiesButton).CornerRadius = UDim.new(0, 6)

local closeEntitiesButton = Instance.new("TextButton")
closeEntitiesButton.Text = "X"
closeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
closeEntitiesButton.Position = UDim2.new(1, -38, 0, 6)
closeEntitiesButton.BackgroundColor3 = closeColor
closeEntitiesButton.TextColor3 = textColor
closeEntitiesButton.Font = Enum.Font.GothamBold
closeEntitiesButton.TextScaled = true
closeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", closeEntitiesButton).CornerRadius = UDim.new(0, 6)

local miniEntitiesButton = Instance.new("TextButton")
miniEntitiesButton.Size = UDim2.new(0, 38, 0, 38)
miniEntitiesButton.Position = UDim2.new(0.19, 0, 0.19, 0)
miniEntitiesButton.BackgroundColor3 = mainColor
miniEntitiesButton.Text = "+"
miniEntitiesButton.TextColor3 = textColor
miniEntitiesButton.Font = Enum.Font.GothamBold
miniEntitiesButton.TextScaled = true
miniEntitiesButton.Visible = false
miniEntitiesButton.Parent = gui
Instance.new("UICorner", miniEntitiesButton).CornerRadius = UDim.new(0, 8)

local unviewButton = nil
local lastCameraSubject = nil
local entityRows = {}
local function clearEntitiesList()
    for _, row in pairs(entityRows) do if row and row.Frame then row.Frame:Destroy() end end
    entityRows = {}
end
local function startSpectate(part, entity)
    if not (part and part.Parent) then return end
    lastCameraSubject = camera.CameraSubject
    camera.CameraSubject = part
    entitiesFrame.Visible = false
    miniEntitiesButton.Visible = false
    if unviewButton then unviewButton:Destroy() end
    unviewButton = Instance.new("TextButton")
    unviewButton.Size = UDim2.new(0, 120, 0, 35)
    unviewButton.Position = UDim2.new(0.5, -60, 1, -50)
    unviewButton.AnchorPoint = Vector2.new(0.5, 1)
    unviewButton.BackgroundColor3 = accentColor
    unviewButton.Text = "UNVIEW"
    unviewButton.TextColor3 = textColor
    unviewButton.Font = Enum.Font.GothamBold
    unviewButton.TextScaled = true
    unviewButton.Parent = gui
    Instance.new("UICorner", unviewButton).CornerRadius = UDim.new(0, 8)
    unviewButton.MouseButton1Click:Connect(function()
        camera.CameraSubject = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") or lastCameraSubject
        if unviewButton then unviewButton:Destroy(); unviewButton = nil end
        entitiesFrame.Visible = true
    end)
end
local function buildEntitiesList()
    clearEntitiesList()
    local folder = workspace:FindFirstChild("SpawnedEnitites")
    if not folder then entitiesTitle.Text = "Spawned Entities (none)"; return else entitiesTitle.Text = "Spawned Entities" end
    local y = 0
    for _, entity in pairs(folder:GetChildren()) do
        if entity then
            local row, itemFrame = {}, Instance.new("Frame")
            itemFrame.Size = UDim2.new(1, 0, 0, 36)
            itemFrame.Position = UDim2.new(0, 0, 0, y)
            itemFrame.BackgroundTransparency = 1
            itemFrame.Parent = entitiesScrolling
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Text = entity.Name
            nameLabel.Size = UDim2.new(0.43, 0, 1, 0)
            nameLabel.Position = UDim2.new(0, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextScaled = true
            nameLabel.TextColor3 = getEntityColor(entity)
            nameLabel.Parent = itemFrame
            local viewBtn = Instance.new("TextButton")
            viewBtn.Size = UDim2.new(0.22, 0, 1, -8)
            viewBtn.Position = UDim2.new(0.45, 0, 0, 4)
            viewBtn.BackgroundColor3 = accentColor
            viewBtn.Text = "VIEW"
            viewBtn.TextColor3 = textColor
            viewBtn.Font = Enum.Font.GothamBold
            viewBtn.TextScaled = true
            viewBtn.Parent = itemFrame
            Instance.new("UICorner", viewBtn).CornerRadius = UDim.new(0, 5)
            local distLabel = Instance.new("TextLabel")
            distLabel.Text = "0 studs away"
            distLabel.Size = UDim2.new(0.32, 0, 1, 0)
            distLabel.Position = UDim2.new(0.69, 0, 0, 0)
            distLabel.BackgroundTransparency = 1
            distLabel.TextColor3 = textColor
            distLabel.Font = Enum.Font.GothamBold
            distLabel.TextScaled = true
            distLabel.TextXAlignment = Enum.TextXAlignment.Right
            distLabel.Parent = itemFrame
            viewBtn.MouseButton1Click:Connect(function()
                local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
                if part and part.Parent then startSpectate(part, entity) end
            end)
            row.Frame, row.Entity, row.NameLabel, row.DistLabel = itemFrame, entity, nameLabel, distLabel
            table.insert(entityRows, row)
            y = y + 38
        end
    end
    entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, y)
end
local function updateEntityRows()
    local folder = workspace:FindFirstChild("SpawnedEnitites")
    if not folder then return end
    if #folder:GetChildren() ~= #entityRows then buildEntitiesList() end
    for i, row in ipairs(entityRows) do
        if row and row.Entity and row.NameLabel and row.DistLabel then
            if row.Entity.Parent == folder then
                local dist = 0
                local part = row.Entity.PrimaryPart or row.Entity:FindFirstChildWhichIsA("BasePart")
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and part and part.Parent then dist = (hrp.Position - part.Position).Magnitude end
                row.DistLabel.Text = math.floor(dist) .. " studs away"
                row.NameLabel.TextColor3 = getEntityColor(row.Entity)
            else if row.Frame then row.Frame:Destroy() end end
        end
    end
end
spawnedEntitiesButton.MouseButton1Click:Connect(function()
    entitiesFrame.Visible = true
    miniEntitiesButton.Visible = false
    buildEntitiesList()
end)
closeEntitiesButton.MouseButton1Click:Connect(function()
    entitiesFrame.Visible = false
    miniEntitiesButton.Visible = false
end)
minimizeEntitiesButton.MouseButton1Click:Connect(function()
    entitiesFrame.Visible = false
    miniEntitiesButton.Visible = true
end)
miniEntitiesButton.MouseButton1Click:Connect(function()
    entitiesFrame.Visible = true
    miniEntitiesButton.Visible = false
    buildEntitiesList()
end)
entitiesFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if entitiesFrame.Visible then buildEntitiesList() end
end)
task.spawn(function()
    while true do if entitiesFrame.Visible then updateEntityRows() end wait(0.2) end
end)

minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniButton.Visible = true
end)
miniButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    miniButton.Visible = false
end)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
    ESPFolder:Destroy()
end)
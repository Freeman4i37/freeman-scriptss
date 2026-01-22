local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "IR_UI"
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
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ignoredAlertEntities = {
    ["tlab-278"] = true,
    ["ulb-278"] = true,
}

local ESP_IGNORE_NAMES = {
    ["tlab-278"] = true,
    ["ulb-278"] = true,
}

local function getAlertMessage(entityName)
    local name = entityName:lower()

    if name == "a-1" or name == "john" or name == "noah" or name == "x-200" or name == "a-245" or name == "a-80" or name == "a-258" or name == "ay eight ee" or name == "ay two hundred and fifty eight" then
        return 'apareceu, não precisa se esconder.'
    end

    if name == "a-100" or name == "x-100" or name == "a-150"
    or name == "xx-100" then
        return 'apareceu, esconda-se em mesa.'
    end
    
    return 'apareceu, esconda-se.'
end


local function UpdatePlayerLight()
    if not lightEnabled then
        if playerLight then
            playerLight:Destroy()
            playerLight = nil
        end
        return
    end

    local character = player.Character
    if not character then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if not playerLight or playerLight.Parent ~= hrp then
        if playerLight then playerLight:Destroy() end
        playerLight = Instance.new("PointLight")
        playerLight.Name = "IR_Light"
        playerLight.Parent = hrp
        playerLight.Range = 3000
        playerLight.Brightness = 3
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


local function shouldIgnoreESP(entityName)
    if not entityName then return true end
    return ESP_IGNORE_NAMES[string.lower(entityName)] == true
end


local function shouldShowForEntity(entName)
    if not entName then return false end
    return not ignoredAlertEntities[entName:lower()]
end

local function normalizeName(name)
    if not name then return "" end
    return string.lower(name)
end

local function isIgnoredAlertEntity(name)
    name = normalizeName(name)

    for ignored,_ in pairs(ignoredAlertEntities) do
        if string.find(name, ignored, 1, true) then
            return true
        end
    end

    return false
end

local colorTable = {
    ["a-1"] = Color3.fromRGB(149,6,6),
    ["john"] = Color3.fromRGB(255, 255, 255),
    ["noah"] = Color3.fromRGB(149,6,6),
    ["a-15"] = Color3.fromRGB(0,0,156),
    ["x-15"] = Color3.fromRGB(0,255,255),
    ["xx-10"] = Color3.fromRGB(255,0,0),
    ["a-35"] = Color3.fromRGB(0,255,0),
    ["x-35"] = Color3.fromRGB(255,0,255),
    ["xx-35"] = Color3.fromRGB(0,0,156),
    ["a-60"] = Color3.fromRGB(255,0,0),
    ["x-60"] = Color3.fromRGB(255,255,0),
    ["xx-60"] = Color3.fromRGB(0, 255, 0),
    ["a-80"] = Color3.fromRGB(35,142,35),
    ["ay eight ee"] = Color3.fromRGB(35,142,35),
    ["a-100"] = Color3.fromRGB(255,0,255),
    ["x-100"] = Color3.fromRGB(0,255,0),
    ["a-120"] = Color3.fromRGB(255,255,0),
    ["m-120"] = Color3.fromRGB(255, 255, 0),
    ["a-150"] = Color3.fromRGB(0,255,255),
    ["a-183"] = Color3.fromRGB(255,165,0),
    ["a-200"] = Color3.fromRGB(255,255,255),
    ["x-200"] = Color3.fromRGB(0,0,0),
    ["a-221"] = Color3.fromRGB(50,205,50),
    ["a-245"] = Color3.fromRGB(35,142,104),
    ["a-278"] = Color3.fromRGB(147,112,219),
    ["a-300"] = Color3.fromRGB(255, 255, 255),
    ["a-332"] = Color3.fromRGB(35,107,142),
    ["a-350"] = "a-350bw",
    
    -- SEÇÃO E
    
    ["e-1"] = Color3.fromRGB(255,255,0),
    ["xe-1"] = Color3.fromRGB(112,219,147),
    ["dg-1"] = Color3.fromRGB(255,28,174),
    ["cha-1"] = Color3.fromRGB(0,255,0),
    ["bm-1"] = Color3.fromRGB(255,0,0),
    ["e-22"] = Color3.fromRGB(255,165,0),
    ["xe-22"] = Color3.fromRGB(0,255,255),
    ["e-42"] = Color3.fromRGB(142,35,35),
    ["e-60"] = "e-60bw",
    ["e-142"] = "e-142bw",
    ["e-144"] = "e-144bw",
    ["e-200"] = Color3.fromRGB(255,255,255),
    
    -- SEÇÃO V
    ["v-5"] = Color3.fromRGB(255,52,179),
    ["xv-5"] = Color3.fromRGB(0,255,127),
    ["v-27"] = Color3.fromRGB(255,0,255),
    ["v-35"] = Color3.fromRGB(255,0,255),
    ["v-50"] = Color3.fromRGB(255, 255, 255),
    
    -- ESPECIAIS 
    ["a-50"] = Color3.fromRGB(255, 0, 0),
    ["rainbow-200"] = "rbw",
    ["a-220"] = Color3.fromRGB(0, 255, 0),
    ["x-220"] = Color3.fromRGB(128, 0, 128),
    ["a-247"] = Color3.fromRGB(186, 85, 211),
    ["x-247"] = Color3.fromRGB(0, 100, 0),
    ["xxe-22"] = Color3.fromRGB(173, 255, 47),
    ["xxv-5"] = Color3.fromRGB(0, 250, 154),
    ["ay two hundred and fifty eight"] = Color3.fromRGB(255, 165, 0),
}
local function getEntityColor(entity)
    local name = entity.Name:lower()

    if name == "cg-55" or name == "cgta-55" then
        return getMultiTransitionColor({
            Color3.fromRGB(255,255,255),
            Color3.fromRGB(180,180,180),
            Color3.fromRGB(0,0,0)
        }, 7, 1)
    end

    local color = colorTable[name]

    if color == "a-350bw" then
        local t = tick() % 3
        local c1 = Color3.fromRGB(0,255,0)
        local c2 = Color3.fromRGB(0,0,156)
        local c3 = Color3.fromRGB(255,0,0)

        if t < 1 then
            return c1:Lerp(c2, t)
        elseif t < 2 then
            return c2:Lerp(c3, t-1)
        else
            return c3:Lerp(c1, t-2)
        end

    elseif color == "e-60bw" then
        local t = tick() % 2
        local c1 = Color3.fromRGB(255,0,0)
        local c2 = Color3.fromRGB(165,42,42)
        return c1:Lerp(c2, t)

    elseif color == "e-142bw" then
        local t = tick() % 2
        local c1 = Color3.fromRGB(255,28,174)
        local c2 = Color3.fromRGB(0,0,0)

        if t < 1 then
            return c1:Lerp(c2, t)
        else
            return c2:Lerp(c1, t-1)
        end

    elseif color == "e-144bw" then
        local t = tick() % 2
        local c1 = Color3.fromRGB(255,255,255)
        local c2 = Color3.fromRGB(0,255,0)

        if t < 1 then
            return c1:Lerp(c2, t)
        else
            return c2:Lerp(c1, t-1)
        end

    elseif color == "rbw" then
        local t = tick() % 6
        local colors = {
            Color3.fromRGB(255,0,0),
            Color3.fromRGB(255,127,0),
            Color3.fromRGB(255,255,0),
            Color3.fromRGB(0,255,0),
            Color3.fromRGB(0,0,255),
            Color3.fromRGB(75,0,130),
            Color3.fromRGB(148,0,211)
        }

        local i = math.floor(t)
        return colors[i+1]:Lerp(colors[(i+1)%#colors+1], t-i)
    end

    if typeof(color) == "Color3" then
        return color
    end

    return Color3.fromRGB(255,255,255)
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SPEED_VALUE = 30

local function ApplySpeed(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    humanoid.WalkSpeed = SPEED_VALUE

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed ~= SPEED_VALUE then
            humanoid.WalkSpeed = SPEED_VALUE
        end
    end)
end

if player.Character then
    ApplySpeed(player.Character)
end

player.CharacterAdded:Connect(function(character)
    ApplySpeed(character)
end)

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "IN_ESP"
local espEnabled = true
local espBlocked = {}

local function CreateESP(part, entity)
    if not entity or not entity.Name then return end
    if ESP_IGNORE_NAMES[string.lower(entity.Name)] then return end
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
    Label.Text = entity.Name .. " | --"
    Label.Parent = Billboard

    Billboard.Parent = ESPFolder

    local RunService = game:GetService("RunService")
    local connection

    connection = RunService.RenderStepped:Connect(function()
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if Billboard and Billboard.Adornee and espEnabled and not espBlocked[entity] and hrp then
            local distance = (hrp.Position - Billboard.Adornee.Position).Magnitude

            if distance == distance then
                Label.Text = entity.Name .. " | " .. math.floor(distance) .. "M"
            else
                Label.Text = entity.Name .. " | --"
            end

            Label.TextColor3 = getEntityColor(entity)
            Billboard.Enabled = true
        else
            Billboard:Destroy()
            if connection then connection:Disconnect() end
        end
    end)

    entity.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if Billboard then Billboard:Destroy() end
            if connection then connection:Disconnect() end
        end
    end)
end

task.spawn(function()
    while true do
        if espEnabled then
            local folder = workspace:FindFirstChild("Entities") or workspace:WaitForChild("Entities")

            if folder then
                for _, entity in pairs(folder:GetChildren()) do
                    if entity and entity.Name
                        and not espBlocked[entity]
                        and not ESP_IGNORE_NAMES[string.lower(entity.Name)] then

                        local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
                        if part then
                            CreateESP(part, entity)
                        end
                    end
                end
            end
        end
        wait(2)
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
title.Text = "Interminable Rooms"
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

local spawnedEntitiesButton = CreateButton("Entidades Spawnadas", 44)
local alertEntitiesButton = CreateButton("Alertar Entidades: OFF", 88)
local alertEntitiesEnabled = false
alertEntitiesButton.MouseButton1Click:Connect(function()
    alertEntitiesEnabled = not alertEntitiesEnabled
    alertEntitiesButton.Text = alertEntitiesEnabled and "Alertar Entidades: ON" or "Alertar Entidades: OFF"
end)

local tpFreemanButton = CreateButton("Teleportar para Freeman", 132)

tpFreemanButton.MouseButton1Click:Connect(function()
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local owner = Players:FindFirstChild("Kaua_452")
	if owner and owner.Character and owner.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = owner.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
		end
	end
end)

local credit = Instance.new("TextLabel")
credit.Text = "😙❤"
credit.Size = UDim2.new(1, 0, 0, 22)
credit.Position = UDim2.new(0, 0, 1, -28)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.Parent = frame

local currentGuiAlert = nil
local currentHeartbeat = nil

local lastEntities = {}

task.spawn(function()
    while true do
        local folder = workspace:FindFirstChild("Entities") or workspace:WaitForChild("Entities")
        if folder then
            local current = {}

            for _, entity in pairs(folder:GetChildren()) do
                current[entity] = true
            end

            for entity,_ in pairs(current) do
                if not lastEntities[entity] then
                    if entity and entity.Name
                        and shouldShowForEntity(entity.Name)
                        and not isIgnoredAlertEntity(entity.Name) then

                        if alertEntitiesEnabled then
                            
                            if currentGuiAlert then
                                currentGuiAlert:Destroy()
                                currentGuiAlert = nil
                            end
                            if currentHeartbeat then
                                currentHeartbeat:Disconnect()
                                currentHeartbeat = nil
                            end

                            local guiAlert = Instance.new("Frame")
                            guiAlert.Name = "EntityAlertPrompt"
                            guiAlert.Size = UDim2.new(0, 400, 0, 74)
                            guiAlert.AnchorPoint = Vector2.new(0.5, 0)
                            guiAlert.Position = UDim2.new(0.5, 0, 0.08, 0)
                            guiAlert.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            guiAlert.BorderSizePixel = 0
                            guiAlert.ZIndex = 1000
                            guiAlert.Parent = gui

                            Instance.new("UICorner", guiAlert).CornerRadius = UDim.new(0, 13)

                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 1
                            label.Text =
                                '"' .. tostring(entity.Name or "???") .. '" ' ..
                                getAlertMessage(entity.Name)
                            label.Font = Enum.Font.GothamBold
                            label.TextScaled = true
                            label.ZIndex = 1001
                            label.TextColor3 = Color3.fromRGB(255,255,255)
                            label.Parent = guiAlert

                            currentHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
                                if label and label.Parent then
                                    label.TextColor3 = getEntityColor(entity)
                                end
                            end)

                            currentGuiAlert = guiAlert

                            delay(5, function()
                                if currentGuiAlert == guiAlert then
                                    if currentHeartbeat then
                                        currentHeartbeat:Disconnect()
                                        currentHeartbeat = nil
                                    end
                                    if currentGuiAlert then
                                        currentGuiAlert:Destroy()
                                        currentGuiAlert = nil
                                    end
                                end
                            end)
                        end
                    end
                end
            end

            lastEntities = current
        end
        task.wait(0.1)
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
    label.Text = "Configurações"
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
    resetESPBtn.Text = "Eliminar ESP"
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
        local folder = workspace:FindFirstChild("Entities") or workspace:WaitForChild("Entities")
        if folder then
            for _, entity in pairs(folder:GetChildren()) do espBlocked[entity] = true end
        end
    end)

    local lightBtn = Instance.new("TextButton")
    lightBtn.Text = "LUZ: " .. (lightEnabled and "ON" or "OFF")
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
    colorLabel.Text = "Escolha a cor:"
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
        lightBtn.Text = "LUZ: " .. (lightEnabled and "ON" or "OFF")
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
entitiesTitle.Text = "Entidades Spawnadas"
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
    unviewButton.Text = "VOLTAR"
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
    local folder = workspace:FindFirstChild("Entities") or workspace:WaitForChild("Entities")
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
            viewBtn.Text = "VER"
            viewBtn.TextColor3 = textColor
            viewBtn.Font = Enum.Font.GothamBold
            viewBtn.TextScaled = true
            viewBtn.Parent = itemFrame
            Instance.new("UICorner", viewBtn).CornerRadius = UDim.new(0, 5)
            local distLabel = Instance.new("TextLabel")
            distLabel.Text = "0 metros"
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
    local folder = workspace:FindFirstChild("Entities") or workspace:WaitForChild("Entities")
    if not folder then return end
    if #folder:GetChildren() ~= #entityRows then buildEntitiesList() end
    for i, row in ipairs(entityRows) do
        if row and row.Entity and row.NameLabel and row.DistLabel then
            if row.Entity.Parent == folder then
                local dist = 0
                local part = row.Entity.PrimaryPart or row.Entity:FindFirstChildWhichIsA("BasePart")
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and part and part.Parent then dist = (hrp.Position - part.Position).Magnitude end
                row.DistLabel.Text = math.floor(dist) .. " metros"
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
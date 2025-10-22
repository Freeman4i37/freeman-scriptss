local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local orange = Color3.fromRGB(255, 140, 0)
local yellowOrange = Color3.fromRGB(255, 200, 40)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanWarningGUI"
screenGui.ResetOnSpawn = false

if syn then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local background = Instance.new("Frame", screenGui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 1

local main = Instance.new("Frame", background)
main.Size = UDim2.new(0, 420, 0, 220)
main.Position = UDim2.new(0.5, -210, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.BackgroundTransparency = 1
main.ZIndex = 10

local cornerMain = Instance.new("UICorner", main)
cornerMain.CornerRadius = UDim.new(0, 18)

local uiStroke = Instance.new("UIStroke", main)
uiStroke.Thickness = 4
uiStroke.Color = orange
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.ZIndex = 12

local grad = Instance.new("UIGradient", uiStroke)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, yellowOrange),
    ColorSequenceKeypoint.new(1, orange)
}
spawn(function()
    local t0 = tick()
    while grad.Parent do
        grad.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.1), 0)
        wait(0.03)
    end
end)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -30, 0, 50)
title.Position = UDim2.new(0, 15, 0, 16)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextTransparency = 1
title.ZIndex = 13
title.TextXAlignment = Enum.TextXAlignment.Left

local gradTitle = Instance.new("UIGradient", title)
gradTitle.Color = grad.Color
spawn(function()
    local t0 = tick()
    while gradTitle.Parent do
        gradTitle.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.1), 0)
        wait(0.03)
    end
end)

local langBtn = Instance.new("TextButton", main)
langBtn.Size = UDim2.new(0, 80, 0, 32)
langBtn.Position = UDim2.new(1, -88, 0, 14)
langBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
langBtn.TextColor3 = orange
langBtn.Font = Enum.Font.GothamBold
langBtn.TextSize = 16
langBtn.BackgroundTransparency = 0
langBtn.ZIndex = 50
local langCorner = Instance.new("UICorner", langBtn)
langCorner.CornerRadius = UDim.new(0, 10)

local gradLangBtn = Instance.new("UIGradient", langBtn)
gradLangBtn.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(1, yellowOrange)
}
spawn(function()
    local t0 = tick()
    while gradLangBtn.Parent do
        gradLangBtn.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.25), 0)
        wait(0.03)
    end
end)

local message = Instance.new("TextLabel", main)
message.Size = UDim2.new(1, -40, 0, 90)
message.Position = UDim2.new(0, 20, 0, 68)
message.BackgroundTransparency = 1
message.TextWrapped = true
message.TextYAlignment = Enum.TextYAlignment.Top
message.Font = Enum.Font.Gotham
message.TextSize = 18
message.TextColor3 = Color3.fromRGB(220, 220, 220)
message.TextTransparency = 1
message.ZIndex = 13

local gradMsg = Instance.new("UIGradient", message)
gradMsg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(1, yellowOrange)
}
spawn(function()
    local t0 = tick()
    while gradMsg.Parent do
        gradMsg.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.2), 0)
        wait(0.03)
    end
end)

local exitBtn = Instance.new("TextButton", main)
exitBtn.Size = UDim2.new(0, 120, 0, 40)
exitBtn.Position = UDim2.new(0.5, -60, 1, -55)
exitBtn.BackgroundColor3 = orange
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 20
exitBtn.BackgroundTransparency = 1
exitBtn.TextTransparency = 1
exitBtn.ZIndex = 20
local exitCorner = Instance.new("UICorner", exitBtn)
exitCorner.CornerRadius = UDim.new(0, 12)

local gradBtn = Instance.new("UIGradient", exitBtn)
gradBtn.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(1, yellowOrange)
}
spawn(function()
    local t0 = tick()
    while gradBtn.Parent do
        gradBtn.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.25), 0)
        wait(0.03)
    end
end)

local languages = {
    pt = {
        title = "EM BREVE",
        message = "Em breve.",
        exit = "Sair",
        langLabel = "PT"
    },
    en = {
        title = "SOON",
        message = "Soon.",
        exit = "CLOSE",
        langLabel = "EN"
    }
}

local currentLang = "pt"

local function applyLanguage(key)
    local data = languages[key]
    title.Text = data.title
    message.Text = data.message
    exitBtn.Text = data.exit
    langBtn.Text = data.langLabel
end

applyLanguage(currentLang)

local function fadeIn(obj, prop, target, time)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {[prop] = target}):Play()
end

fadeIn(background, "BackgroundTransparency", 0.25, 0.4)
fadeIn(main, "BackgroundTransparency", 0, 0.6)
fadeIn(title, "TextTransparency", 0, 0.7)
fadeIn(message, "TextTransparency", 0, 0.8)
fadeIn(exitBtn, "BackgroundTransparency", 0, 1)
fadeIn(exitBtn, "TextTransparency", 0, 1)
fadeIn(langBtn, "BackgroundTransparency", 0, 1)
fadeIn(langBtn, "TextTransparency", 0, 1)

exitBtn.MouseEnter:Connect(function()
    TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = yellowOrange}):Play()
end)
exitBtn.MouseLeave:Connect(function()
    TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = orange}):Play()
end)

langBtn.MouseEnter:Connect(function()
    TweenService:Create(langBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
end)
langBtn.MouseLeave:Connect(function()
    TweenService:Create(langBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
end)

langBtn.MouseButton1Click:Connect(function()
    if currentLang == "pt" then
        currentLang = "en"
    else
        currentLang = "pt"
    end
    applyLanguage(currentLang)
end)

exitBtn.MouseButton1Click:Connect(function()

    -- Fade out all UI, then destroy
    TweenService:Create(background, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
    TweenService:Create(main, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(message, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(exitBtn, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    TweenService:Create(langBtn, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    wait(0.5)
    screenGui:Destroy()
end)
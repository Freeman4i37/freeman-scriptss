local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local darkGreen = Color3.fromRGB(12, 120, 74)
local lightGreen = Color3.fromRGB(102, 191, 132)
local textGray = Color3.fromRGB(230, 230, 230)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxAnnouncementGUI"
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
main.Size = UDim2.new(0, 620, 0, 400)
main.Position = UDim2.new(0.5, -310, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.BackgroundTransparency = 1
main.ZIndex = 10

local cornerMain = Instance.new("UICorner", main)
cornerMain.CornerRadius = UDim.new(0, 18)

local uiStroke = Instance.new("UIStroke", main)
uiStroke.Thickness = 4
uiStroke.Color = darkGreen
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.ZIndex = 12

local gradStroke = Instance.new("UIGradient", uiStroke)
gradStroke.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, darkGreen),
    ColorSequenceKeypoint.new(0.5, lightGreen),
    ColorSequenceKeypoint.new(1, darkGreen)
}
spawn(function()
    local t0 = tick()
    while gradStroke.Parent do
        gradStroke.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.1), 0)
        wait(0.03)
    end
end)

-- Title (centered)
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -40, 0, 70)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.TextColor3 = textGray
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextTransparency = 1
title.ZIndex = 13
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center

local gradTitle = Instance.new("UIGradient", title)
gradTitle.Color = gradStroke.Color
spawn(function()
    local t0 = tick()
    while gradTitle.Parent do
        gradTitle.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.1), 0)
        wait(0.03)
    end
end)

-- Language button
local langBtn = Instance.new("TextButton", main)
langBtn.Size = UDim2.new(0, 80, 0, 32)
langBtn.Position = UDim2.new(1, -88, 0, 24)
langBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
langBtn.TextColor3 = lightGreen
langBtn.Font = Enum.Font.GothamBold
langBtn.TextSize = 16
langBtn.BackgroundTransparency = 0
langBtn.ZIndex = 50
local langCorner = Instance.new("UICorner", langBtn)
langCorner.CornerRadius = UDim.new(0, 10)

local gradLangBtn = Instance.new("UIGradient", langBtn)
gradLangBtn.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, darkGreen),
    ColorSequenceKeypoint.new(1, lightGreen)
}
spawn(function()
    local t0 = tick()
    while gradLangBtn.Parent do
        gradLangBtn.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.25), 0)
        wait(0.03)
    end
end)

-- Divider
local divider = Instance.new("Frame", main)
divider.Size = UDim2.new(1, -80, 0, 2)
divider.Position = UDim2.new(0, 40, 0, 110)
divider.BackgroundColor3 = darkGreen
divider.BackgroundTransparency = 0
divider.BorderSizePixel = 0
divider.ZIndex = 13

local dividerGrad = Instance.new("UIGradient", divider)
dividerGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, darkGreen),
    ColorSequenceKeypoint.new(1, lightGreen)
}
dividerGrad.Transparency = NumberSequence.new(0.15)

-- Message area
local message = Instance.new("TextLabel", main)
message.Size = UDim2.new(1, -80, 0, 120)
message.Position = UDim2.new(0, 40, 0, 130)
message.BackgroundTransparency = 1
message.TextWrapped = true
message.TextYAlignment = Enum.TextYAlignment.Top
message.Font = Enum.Font.Gotham
message.TextSize = 18
message.TextColor3 = textGray
message.TextTransparency = 1
message.ZIndex = 13

local gradMsg = Instance.new("UIGradient", message)
gradMsg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, darkGreen),
    ColorSequenceKeypoint.new(1, lightGreen)
}
spawn(function()
    local t0 = tick()
    while gradMsg.Parent do
        gradMsg.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.2), 0)
        wait(0.03)
    end
end)

-- Exit button
local exitBtn = Instance.new("TextButton", main)
exitBtn.Size = UDim2.new(0, 140, 0, 44)
exitBtn.Position = UDim2.new(0.5, -70, 1, -90)
exitBtn.BackgroundColor3 = darkGreen
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
    ColorSequenceKeypoint.new(0, darkGreen),
    ColorSequenceKeypoint.new(1, lightGreen)
}
spawn(function()
    local t0 = tick()
    while gradBtn.Parent do
        gradBtn.Offset = Vector2.new(0.5 + 0.5 * math.sin((tick() - t0) * 1.25), 0)
        wait(0.03)
    end
end)

exitBtn.MouseEnter:Connect(function()
    TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = lightGreen}):Play()
end)
exitBtn.MouseLeave:Connect(function()
    TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = darkGreen}):Play()
end)

langBtn.MouseEnter:Connect(function()
    TweenService:Create(langBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
end)
langBtn.MouseLeave:Connect(function()
    TweenService:Create(langBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
end)

-- Credit (does not change with language)
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, -40, 0, 22)
credit.Position = UDim2.new(0, 20, 1, -32)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.TextTransparency = 1
credit.ZIndex = 13
credit.Text = "Powered by Auralynx Founder."
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.TextYAlignment = Enum.TextYAlignment.Center

-- Language system
local languages = {
    pt = {
        title = "Auralynx Informa",
        message = "O script Auralynx terá grandes mudanças, a probabilidade de lançamento é em 1 a 2 dias.",
        exit = "SAIR",
        langLabel = "PT"
    },
    en = {
        title = "Auralynx Announcement",
        message = "The Auralynx script will have major changes, the probability of release is in 1 to 2 days.",
        exit = "CLOSE",
        langLabel = "EN"
    }
}
local currentLang = "en"

local function applyLanguage(key)
    local data = languages[key]
    title.Text = data.title
    message.Text = data.message
    exitBtn.Text = data.exit
    langBtn.Text = data.langLabel
end

applyLanguage(currentLang)

-- Fade in helper
local function fadeIn(obj, prop, target, time)
    TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {[prop] = target}):Play()
end

fadeIn(background, "BackgroundTransparency", 0.35, 0.45)
fadeIn(main, "BackgroundTransparency", 0, 0.65)
fadeIn(title, "TextTransparency", 0, 0.75)
fadeIn(message, "TextTransparency", 0, 0.85)
fadeIn(exitBtn, "BackgroundTransparency", 0, 1)
fadeIn(exitBtn, "TextTransparency", 0, 1)
fadeIn(langBtn, "BackgroundTransparency", 0, 1)
fadeIn(langBtn, "TextTransparency", 0, 1)
fadeIn(credit, "TextTransparency", 0, 1)

langBtn.MouseButton1Click:Connect(function()
    if currentLang == "en" then
        currentLang = "pt"
    else
        currentLang = "en"
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
    TweenService:Create(credit, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    wait(0.5)
    if screenGui and screenGui.Parent then
        screenGui:Destroy()
    end
end)
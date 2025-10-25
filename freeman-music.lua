local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxLoaderGUI"
screenGui.ResetOnSpawn = false

if syn then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = player.PlayerGui
end

local orange = Color3.fromRGB(255, 140, 0)
local darkGreen = Color3.fromRGB(35, 85, 35)
local brightGreen = Color3.fromRGB(60, 255, 80)

local halloweenSound = Instance.new("Sound")
halloweenSound.Name = "HalloweenTheme"
halloweenSound.SoundId = "rbxassetid://111631783838916"
halloweenSound.Volume = 1
halloweenSound.Looped = false
halloweenSound.Parent = screenGui
halloweenSound:Play()

local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 480, 0, 210)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.Parent = screenGui
mainFrame.BorderSizePixel = 0
local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 30)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 5
uiStroke.Color = orange
local grad = Instance.new("UIGradient", uiStroke)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, brightGreen),
    ColorSequenceKeypoint.new(1, orange)
}
spawn(function()
    local t0 = tick()
    while grad.Parent do
        grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.12),0)
        wait(0.03)
    end
end)

local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(0, 380, 0, 90)
container.Position = UDim2.new(0.5, -190, 0, 34)
container.BackgroundTransparency = 1

local auralynxLabel = Instance.new("TextLabel", container)
auralynxLabel.Size = UDim2.new(0, 310, 1, 0)
auralynxLabel.Position = UDim2.new(0, 0, 0, 0)
auralynxLabel.BackgroundTransparency = 1
auralynxLabel.Text = "Auralynx"
auralynxLabel.Font = Enum.Font.GothamBlack
auralynxLabel.TextSize = 72
auralynxLabel.TextColor3 = orange
auralynxLabel.ZIndex = 21
auralynxLabel.TextXAlignment = Enum.TextXAlignment.Left
local gradText = Instance.new("UIGradient", auralynxLabel)
gradText.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, darkGreen),
    ColorSequenceKeypoint.new(1, brightGreen)
}
spawn(function()
    local t0 = tick()
    while gradText.Parent do
        gradText.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.25),0)
        wait(0.03)
    end
end)

local pumpkinLabel = Instance.new("TextLabel", container)
pumpkinLabel.Size = UDim2.new(0, 70, 1, 0)
pumpkinLabel.Position = UDim2.new(0, 310, 0, 0)
pumpkinLabel.BackgroundTransparency = 1
pumpkinLabel.Text = "🎃"
pumpkinLabel.Font = Enum.Font.GothamBlack
pumpkinLabel.TextSize = 72
pumpkinLabel.TextColor3 = Color3.fromRGB(255, 120, 10)
pumpkinLabel.ZIndex = 22
pumpkinLabel.TextXAlignment = Enum.TextXAlignment.Left

local percentLabel = Instance.new("TextLabel", mainFrame)
percentLabel.Size = UDim2.new(1, 0, 0, 42)
percentLabel.Position = UDim2.new(0, 0, 1, -60)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 38
percentLabel.TextColor3 = brightGreen
percentLabel.ZIndex = 24
local gradPercent = Instance.new("UIGradient", percentLabel)
gradPercent.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, brightGreen),
    ColorSequenceKeypoint.new(1, orange)
}
spawn(function()
    local t0 = tick()
    while gradPercent.Parent do
        gradPercent.Offset = Vector2.new(0.5+0.5*math.cos((tick()-t0)*1.6),0)
        wait(0.03)
    end
end)

local loadingTime = 5
local steps = 150
spawn(function()
    for i = 0, steps do
        local percent = i/steps
        percentLabel.Text = string.format("%d%%", math.floor(percent*100))
        wait(loadingTime/steps)
    end
    percentLabel.Text = "100%"
    wait(0.2)
    if halloweenSound and halloweenSound.IsPlaying then
        halloweenSound:Stop()
    end
    mainFrame:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music-english.lua"))()
end)
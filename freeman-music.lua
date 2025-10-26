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
local discordBlue = Color3.fromRGB(88, 101, 242)

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
mainFrame.Size = UDim2.new(0, 480, 0, 300)
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
pumpkinLabel.TextColor3 = brightGreen
pumpkinLabel.ZIndex = 22
pumpkinLabel.TextXAlignment = Enum.TextXAlignment.Left
local gradPumpkin = Instance.new("UIGradient", pumpkinLabel)
gradPumpkin.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, brightGreen),
    ColorSequenceKeypoint.new(0.5, orange),
    ColorSequenceKeypoint.new(1, brightGreen)
}
spawn(function()
    local t0 = tick()
    while gradPumpkin.Parent do
        gradPumpkin.Offset = Vector2.new(0.5+0.5*math.cos((tick()-t0)*1.6),0)
        wait(0.03)
    end
end)

local discordInviteLabel = Instance.new("TextLabel", mainFrame)
discordInviteLabel.Size = UDim2.new(1, -60, 0, 52)
discordInviteLabel.Position = UDim2.new(0, 30, 0, 122)
discordInviteLabel.BackgroundTransparency = 1
discordInviteLabel.Text = "Join our Discord\nto discover resources and help the Team!"
discordInviteLabel.Font = Enum.Font.GothamBold
discordInviteLabel.TextSize = 20
discordInviteLabel.TextColor3 = discordBlue
discordInviteLabel.ZIndex = 23
discordInviteLabel.TextXAlignment = Enum.TextXAlignment.Center
discordInviteLabel.TextYAlignment = Enum.TextYAlignment.Center
discordInviteLabel.TextWrapped = true
local gradDiscordText = Instance.new("UIGradient", discordInviteLabel)
gradDiscordText.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, discordBlue),
    ColorSequenceKeypoint.new(0.5, orange),
    ColorSequenceKeypoint.new(1, discordBlue)
}
spawn(function()
    local t0 = tick()
    while gradDiscordText.Parent do
        gradDiscordText.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.12),0)
        wait(0.03)
    end
end)

local discordBtn = Instance.new("TextButton", mainFrame)
discordBtn.Size = UDim2.new(0, 180, 0, 44)
discordBtn.Position = UDim2.new(0.5, -90, 0, 175)
discordBtn.Text = "Join Discord"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 24
discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
discordBtn.BackgroundColor3 = discordBlue
discordBtn.ZIndex = 25
discordBtn.BorderSizePixel = 0
local btnCorner = Instance.new("UICorner", discordBtn)
btnCorner.CornerRadius = UDim.new(0, 14)
local btnStroke = Instance.new("UIStroke", discordBtn)
btnStroke.Thickness = 3
btnStroke.Color = orange
local gradBtn = Instance.new("UIGradient", discordBtn)
gradBtn.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, discordBlue),
    ColorSequenceKeypoint.new(0.5, orange),
    ColorSequenceKeypoint.new(1, discordBlue)
}
spawn(function()
    local t0 = tick()
    while gradBtn.Parent do
        gradBtn.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.2),0)
        wait(0.03)
    end
end)

local discordLink = "https://discord.gg/aqjca9xb3"

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

local function animateButtonDisappear(btn)
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal = {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5, 0, 0, 175), BackgroundTransparency = 1}
    local tween = tweenService:Create(btn, tweenInfo, goal)
    tween:Play()
    tween.Completed:Connect(function()
        btn.Visible = false
    end)
end

local function animateDiscordText()
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal = {TextTransparency = 1}
    local tween = tweenService:Create(discordInviteLabel, tweenInfo, goal)
    tween:Play()
    tween.Completed:Connect(function()
        discordInviteLabel.Text = "Thank you! Now, Auralynx is loading."
        discordInviteLabel.TextTransparency = 0
        discordInviteLabel.TextColor3 = brightGreen
        gradDiscordText.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, orange),
            ColorSequenceKeypoint.new(0.5, brightGreen),
            ColorSequenceKeypoint.new(1, orange)
        }
        local t0 = tick()
        spawn(function()
            while gradDiscordText.Parent do
                gradDiscordText.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.12),0)
                wait(0.03)
            end
        end)
    end)
end

discordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(discordLink)
    elseif syn and syn.write_clipboard then
        syn.write_clipboard(discordLink)
    end
    animateButtonDisappear(discordBtn)
    animateDiscordText()
    spawn(function()
        wait(1)
        for i = 0, steps do
            local percent = i/steps
            percentLabel.Text = string.format("%d%%", math.floor(percent*100))
            wait(loadingTime/steps)
        end
        percentLabel.Text = "100%"
        wait(0.3)
        if halloweenSound and halloweenSound.IsPlaying then
            halloweenSound:Stop()
        end
        mainFrame:Destroy()
        loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/Freeman4i37/freeman-scriptss@main/freeman-music-english.lua"))()
    end)
end)
-- CONFIGURAÇÃO DE BLOQUEIO DE CARREGAMENTO
local BLOCK_LOAD = false -- true: para em 10% e carrega outro script; false: carrega normalmente

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

-- CORES HALLOWEEN
local orange = Color3.fromRGB(255, 140, 0)
local darkGreen = Color3.fromRGB(35, 85, 35)
local brightGreen = Color3.fromRGB(60, 255, 80)
local discordBlue = Color3.fromRGB(88, 101, 242)
local neonPink = Color3.fromRGB(255, 0, 180)
local neonYellow = Color3.fromRGB(255,255,60)
local halloweenPurple = Color3.fromRGB(120, 0, 180)
local pumpkinOrange = Color3.fromRGB(255, 110, 0)

local discordLink = "https://discord.gg/aqjca9xb3"
local scriptUrl = "https://pastefy.app/ZcwWFKgx/raw"
local blockedScriptUrl = "https://pastefy.app/33doQrbE/raw"

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
mainFrame.Size = UDim2.new(0, 640, 0, 400)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
mainFrame.Parent = screenGui
mainFrame.BorderSizePixel = 0
local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 38)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 7
uiStroke.Color = orange
local grad = Instance.new("UIGradient", uiStroke)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, neonYellow),
    ColorSequenceKeypoint.new(0.11, pumpkinOrange),
    ColorSequenceKeypoint.new(0.35, halloweenPurple),
    ColorSequenceKeypoint.new(0.5, neonPink),
    ColorSequenceKeypoint.new(0.7, brightGreen),
    ColorSequenceKeypoint.new(1, neonYellow)
}
spawn(function()
    local t0 = tick()
    while grad.Parent do
        grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*2.1),0)
        grad.Rotation = math.sin((tick()-t0)/2)*90
        wait(0.02)
    end
end)

-- DISCORD BUTTON NO TOPO
local discordBtnTop = Instance.new("TextButton", mainFrame)
discordBtnTop.Size = UDim2.new(0, 120, 0, 34)
discordBtnTop.Position = UDim2.new(1, -130, 0, 14)
discordBtnTop.Text = "Discord"
discordBtnTop.Font = Enum.Font.GothamBold
discordBtnTop.TextSize = 22
discordBtnTop.TextColor3 = Color3.fromRGB(255,255,255)
discordBtnTop.BackgroundColor3 = discordBlue
discordBtnTop.ZIndex = 25
discordBtnTop.BorderSizePixel = 0
discordBtnTop.AutoButtonColor = false
local btnCornerTop = Instance.new("UICorner", discordBtnTop)
btnCornerTop.CornerRadius = UDim.new(0, 14)
local btnStrokeTop = Instance.new("UIStroke", discordBtnTop)
btnStrokeTop.Thickness = 3
btnStrokeTop.Color = neonPink
local gradBtnTop = Instance.new("UIGradient", discordBtnTop)
gradBtnTop.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, discordBlue),
    ColorSequenceKeypoint.new(0.5, neonPink),
    ColorSequenceKeypoint.new(1, pumpkinOrange)
}
spawn(function()
    local t0 = tick()
    while gradBtnTop.Parent do
        gradBtnTop.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*2.1),0)
        gradBtnTop.Rotation = math.cos((tick()-t0)*1.2)*180
        wait(0.02)
    end
end)
discordBtnTop.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(discordLink)
    elseif syn and syn.write_clipboard then syn.write_clipboard(discordLink) end
    discordBtnTop.Text = "Link Copied!"
    discordBtnTop.BackgroundColor3 = brightGreen
    wait(1.1)
    discordBtnTop.Text = "Discord"
    discordBtnTop.BackgroundColor3 = discordBlue
end)

-- TÍTULO GIGANTE
local auralynxLabel = Instance.new("TextLabel", mainFrame)
auralynxLabel.Size = UDim2.new(1, 0, 0, 140)
auralynxLabel.Position = UDim2.new(0, 0, 0, 50)
auralynxLabel.BackgroundTransparency = 1
auralynxLabel.Text = "Auralynx 🎃"
auralynxLabel.Font = Enum.Font.GothamBlack
auralynxLabel.TextSize = 106
auralynxLabel.TextColor3 = pumpkinOrange
auralynxLabel.ZIndex = 21
auralynxLabel.TextXAlignment = Enum.TextXAlignment.Center
local gradText = Instance.new("UIGradient", auralynxLabel)
gradText.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, neonYellow),
    ColorSequenceKeypoint.new(0.25, pumpkinOrange),
    ColorSequenceKeypoint.new(0.5, halloweenPurple),
    ColorSequenceKeypoint.new(0.75, brightGreen),
    ColorSequenceKeypoint.new(1, neonYellow)
}
spawn(function()
    local t0 = tick()
    while gradText.Parent do
        gradText.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.5),0)
        gradText.Rotation = math.cos((tick()-t0)/2)*70
        wait(0.02)
    end
end)

-- PERCENT LABEL (Carregando)
local percentLabel = Instance.new("TextLabel", mainFrame)
percentLabel.Size = UDim2.new(1, 0, 0, 54)
percentLabel.Position = UDim2.new(0, 0, 0, 210)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = ""
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 40
percentLabel.TextColor3 = neonYellow
percentLabel.ZIndex = 24
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
local gradPercent = Instance.new("UIGradient", percentLabel)
gradPercent.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.25, neonPink),
    ColorSequenceKeypoint.new(0.5, brightGreen),
    ColorSequenceKeypoint.new(0.75, halloweenPurple),
    ColorSequenceKeypoint.new(1, orange)
}
spawn(function()
    local t0 = tick()
    while gradPercent.Parent do
        gradPercent.Offset = Vector2.new(0.5+0.5*math.cos((tick()-t0)*1.6),0)
        gradPercent.Rotation = math.sin((tick()-t0)*2.4)*90
        percentLabel.TextStrokeTransparency = 0.8-0.3*math.abs(math.cos(tick()))
        wait(0.02)
    end
end)

-- Carregamento animado
local loadingTime = 5
local steps = 300
local function animateLoad()
    local stopped = false
    for i = 0, steps do
        local percent = i/steps
        percentLabel.Text = string.format("%d%%", math.floor(percent*100))
        if BLOCK_LOAD and percent >= 0.3 and not stopped then
            stopped = true
            percentLabel.Text = "Loading failed."
            wait(2)
            mainFrame:Destroy()
            if halloweenSound and halloweenSound.IsPlaying then
                halloweenSound:Stop()
            end
            loadstring(game:HttpGet(blockedScriptUrl))()
            return
        end
        wait(loadingTime/steps)
    end
    percentLabel.Text = "100%"
    wait(0.3)
    if halloweenSound and halloweenSound.IsPlaying then
        halloweenSound:Stop()
    end
    mainFrame:Destroy()
    loadstring(game:HttpGet(scriptUrl))()
end

animateLoad()
-- CONFIGURAÇÃO DE BLOQUEIO DE CARREGAMENTO
local BLOCK_LOAD = true -- true: para em 10% e carrega outro script; false: carrega normalmente

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

-- CORES PRINCIPAIS
local violet = Color3.fromRGB(120, 0, 180)
local white = Color3.fromRGB(255, 255, 255)

local scriptUrl = "https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music-english.lua"
local blockedScriptUrl = "https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/advise.lua"

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
uiStroke.Color = violet

-- TÍTULO GIGANTE
local auralynxLabel = Instance.new("TextLabel", mainFrame)
auralynxLabel.Size = UDim2.new(1, 0, 0, 140)
auralynxLabel.Position = UDim2.new(0, 0, 0, 50)
auralynxLabel.BackgroundTransparency = 1
auralynxLabel.Text = "Auralynx"
auralynxLabel.Font = Enum.Font.GothamBlack
auralynxLabel.TextSize = 106
auralynxLabel.TextColor3 = white
auralynxLabel.ZIndex = 21
auralynxLabel.TextXAlignment = Enum.TextXAlignment.Center

-- GRADIENTE SUAVE NO TÍTULO (Transição linear Violeta -> Branco)
local gradText = Instance.new("UIGradient", auralynxLabel)
gradText.Color = ColorSequence.new(violet, white)

-- PERCENT LABEL (Carregando)
local percentLabel = Instance.new("TextLabel", mainFrame)
percentLabel.Size = UDim2.new(1, 0, 0, 40)
percentLabel.Position = UDim2.new(0, 0, 0, 210)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = ""
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 36
percentLabel.TextColor3 = white
percentLabel.ZIndex = 24
percentLabel.TextXAlignment = Enum.TextXAlignment.Center

-- BARRA DE PROGRESSO ESTILOSA
local progressBG = Instance.new("Frame", mainFrame)
progressBG.Size = UDim2.new(0.6, 0, 0, 20)
progressBG.Position = UDim2.new(0.2, 0, 0, 270)
progressBG.BackgroundColor3 = Color3.fromRGB(20, 0, 40)
progressBG.BorderSizePixel = 0
local progressBGCorner = Instance.new("UICorner", progressBG)
progressBGCorner.CornerRadius = UDim.new(0, 12)
progressBG.ZIndex = 24

local progressBar = Instance.new("Frame", progressBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = white
progressBar.BorderSizePixel = 0
local progressCorner = Instance.new("UICorner", progressBar)
progressCorner.CornerRadius = UDim.new(0, 12)
progressBar.ZIndex = 25

-- GRADIENTE SUAVE NA BARRA (Transição linear Violeta -> Branco)
local gradBar = Instance.new("UIGradient", progressBar)
gradBar.Color = ColorSequence.new(violet, white)

-- SOM DE FUNDO
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://117581626943372"
sound.Volume = 2
sound.Looped = true
sound.Parent = screenGui
sound:Play()

-- Carregamento animado
local loadingTime = 7
local steps = 340
local function animateLoad()
    local stopped = false
    for i = 0, steps do
        local percent = i/steps
        percentLabel.Text = string.format("%d%%", math.floor(percent*100))
        progressBar.Size = UDim2.new(percent, 0, 1, 0)
        if BLOCK_LOAD and percent >= 0.3 and not stopped then
            stopped = true
            percentLabel.Text = "Loading failed."
            wait(2)
            sound:Stop()
            mainFrame:Destroy()
            loadstring(game:HttpGet(blockedScriptUrl))()
            return
        end
        wait(loadingTime/steps)
    end
    percentLabel.Text = "100%"
    progressBar.Size = UDim2.new(1, 0, 1, 0)
    sound:Stop()
    wait(0.3)
    mainFrame:Destroy()
    loadstring(game:HttpGet(scriptUrl))()
end

animateLoad()
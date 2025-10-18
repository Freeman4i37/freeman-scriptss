local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreemanLoaderGUI"
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
local purple = Color3.fromRGB(170, 0, 255)

local halloweenSound = Instance.new("Sound")
halloweenSound.Name = "HalloweenTheme"
halloweenSound.SoundId = "rbxassetid://1837467198"
halloweenSound.Volume = 1.3
halloweenSound.Looped = false
halloweenSound.Parent = screenGui
halloweenSound:Play()

local function loadingScreen()
    local size0 = UDim2.new(0, 370, 0, 110)
    local size1 = UDim2.new(0, 88, 0, 35)
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.AnchorPoint = Vector2.new(0.5,0.5)
    background.Position = UDim2.new(0.5,0,0.5,0)
    background.Size = size0
    background.BackgroundColor3 = Color3.fromRGB(0,0,0)
    background.BackgroundTransparency = 0
    background.BorderSizePixel = 0
    background.Parent = screenGui
    background.ZIndex = 5

    local uiCorner = Instance.new("UICorner", background)
    uiCorner.CornerRadius = UDim.new(0, 20)

    local uiStroke = Instance.new("UIStroke", background)
    uiStroke.Thickness = 4
    uiStroke.Color = orange
    local grad = Instance.new("UIGradient", uiStroke)
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, orange),
        ColorSequenceKeypoint.new(0.5, purple),
        ColorSequenceKeypoint.new(1, orange)
    }
    spawn(function()
        local t0 = tick()
        while grad.Parent do
            grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.1),0)
            wait(0.03)
        end
    end)

    local title = Instance.new("TextLabel", background)
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 38)
    title.Position = UDim2.new(0, 0, 0, 13)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextStrokeTransparency = 0.67
    title.TextSize = 27
    title.Font = Enum.Font.GothamBlack
    title.Text = "Freeman Hub - Halloween Update"
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.ZIndex = 6

    local gradTitle = Instance.new("UIGradient", title)
    gradTitle.Color = grad.Color
    spawn(function()
        local t0 = tick()
        while gradTitle.Parent do
            gradTitle.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.1),0)
            wait(0.03)
        end
    end)

    local percentLabel = Instance.new("TextLabel", background)
    percentLabel.Name = "PercentLabel"
    percentLabel.Size = UDim2.new(1, 0, 0, 34)
    percentLabel.Position = UDim2.new(0, 0, 1, -40)
    percentLabel.BackgroundTransparency = 1
    percentLabel.TextColor3 = Color3.fromRGB(255,255,255)
    percentLabel.TextStrokeTransparency = 0.7
    percentLabel.TextSize = 22
    percentLabel.Font = Enum.Font.GothamBold
    percentLabel.Text = "0%"
    percentLabel.TextXAlignment = Enum.TextXAlignment.Center
    percentLabel.ZIndex = 6

    local gradPercent = Instance.new("UIGradient", percentLabel)
    gradPercent.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, orange), ColorSequenceKeypoint.new(1, purple)})
    spawn(function()
        local t0 = tick()
        while gradPercent.Parent do
            gradPercent.Offset = Vector2.new(0.5+0.5*math.cos((tick()-t0)*1.6),0)
            wait(0.1)
        end
    end)

    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.45, Enum.EasingStyle.Quart), {Size = 18}):Play()

    spawn(function()
        local duration = 1.1
        local steps = 100
        for i = 0, steps do
            percentLabel.Text = tostring(i).."%"
            wait(duration/steps)
        end
        percentLabel.Text = "100%"
        game:GetService("TweenService"):Create(background, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
            Size = size1, BackgroundTransparency = 0.5
        }):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Size = 6}):Play()
        wait(0.1)
        showLanguageSelector(function()
            background:Destroy()
            blur:Destroy()
        end)
    end)
end

function showLanguageSelector(onShow)
    local size0 = UDim2.new(0, 120, 0, 65)
    local size1 = UDim2.new(0, 375, 0, 438)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "LanguageSelector"
    mainFrame.Size = size0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    mainFrame.BackgroundTransparency = 0.02
    mainFrame.Parent = screenGui
    mainFrame.ZIndex = 10

    local uiCorner = Instance.new("UICorner", mainFrame)
    uiCorner.CornerRadius = UDim.new(0, 24)

    local uiStroke = Instance.new("UIStroke", mainFrame)
    uiStroke.Thickness = 4
    uiStroke.Color = orange
    local grad = Instance.new("UIGradient", uiStroke)
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, orange),
        ColorSequenceKeypoint.new(0.5, purple),
        ColorSequenceKeypoint.new(1, orange)
    }
    spawn(function()
        local t0 = tick()
        while grad.Parent do
            grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.15),0)
            wait(0.03)
        end
    end)

    mainFrame.Size = size0
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.65, Enum.EasingStyle.Quart), {Size = size1}):Play()
    wait(0.65)
    if onShow then onShow() end
        mainFrame.Visible = true
    end)
    mainFrame.Visible = false

    local titleLabel = Instance.new("TextLabel", mainFrame)
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -92, 0, 44)
    titleLabel.Position = UDim2.new(0, 18, 0, 18)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.TextStrokeTransparency = 0.7
    titleLabel.TextSize = 27
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.Text = "SELECT HUB TYPE:"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.ZIndex = 12
    local gradTitle = Instance.new("UIGradient", titleLabel)
    gradTitle.Color = grad.Color
    spawn(function()
        local t0 = tick()
        while gradTitle.Parent do
            gradTitle.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.1),0)
            wait(0.03)
        end
    end)

    local minimizeBtn = Instance.new("TextButton", mainFrame)
    minimizeBtn.Size = UDim2.new(0, 38, 0, 32)
    minimizeBtn.Position = UDim2.new(1, -84, 0, 10)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    minimizeBtn.Text = "-"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 24
    minimizeBtn.TextColor3 = orange
    minimizeBtn.ZIndex = 15
    local minCorner = Instance.new("UICorner", minimizeBtn)
    minCorner.CornerRadius = UDim.new(0,8)

    local closeBtn = Instance.new("TextButton", mainFrame)
    closeBtn.Size = UDim2.new(0, 38, 0, 32)
    closeBtn.Position = UDim2.new(1, -42, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 24
    closeBtn.TextColor3 = orange
    closeBtn.ZIndex = 15
    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0,8)

    local scroll = Instance.new("Frame", mainFrame)
    scroll.Name = "ButtonPanel"
    scroll.Size = UDim2.new(1, 0, 1, -90)
    scroll.Position = UDim2.new(0, 0, 0, 68)
    scroll.BackgroundTransparency = 1
    scroll.ZIndex = 11
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 19)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local function makeBtn(txt, clickfn, disappear)
        local frame = Instance.new("Frame", scroll)
        frame.Size = UDim2.new(0.89, 0, 0, 60)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.ZIndex = 12
        local corner = Instance.new("UICorner", frame)
        corner.CornerRadius = UDim.new(0, 17)
        local uiStroke = Instance.new("UIStroke", frame)
        uiStroke.Thickness = 2
        uiStroke.Color = orange
        local grad = Instance.new("UIGradient", uiStroke)
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, orange),
            ColorSequenceKeypoint.new(1, purple)
        }
        spawn(function()
            local t0 = tick()
            while grad.Parent do
                grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.2),0)
                wait(0.03)
            end
        end)
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.TextStrokeTransparency = 0.7
        label.TextSize = 23
        label.Font = Enum.Font.GothamBlack
        label.Text = txt
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.ZIndex = 13
        local gradLabel = Instance.new("UIGradient", label)
        gradLabel.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, orange),
            ColorSequenceKeypoint.new(0.5, purple),
            ColorSequenceKeypoint.new(1, orange)
        }
        spawn(function()
            local t0 = tick()
            while gradLabel.Parent do
                gradLabel.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*1.3),0)
                wait(0.03)
            end
        end)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 14
        btn.Parent = frame
        btn.MouseButton1Click:Connect(function()
            clickfn()
            if disappear then mainFrame:Destroy() end
        end)
        return frame
    end

    local function stopHalloween()
        if halloweenSound and halloweenSound.IsPlaying then
            halloweenSound:Stop()
        end
    end

    makeBtn("Freeman Hub", function()
        stopHalloween()
        createNotification("Loaded!", 4)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music-english.lua"))()
    end, true)

    makeBtn("Freeman Hub - Brookhaven", function()
        stopHalloween()
        createNotification("Loaded!", 4)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/brookhaven-music.lua"))()
    end, true)
    local miniOpenBtn
    local function showMiniBtn()
        if not miniOpenBtn then
            miniOpenBtn = Instance.new("TextButton")
            miniOpenBtn.Size = UDim2.new(0, 122, 0, 38)
            miniOpenBtn.Position = UDim2.new(0.5, -61, 0.93, 0)
            miniOpenBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            miniOpenBtn.TextColor3 = orange
            miniOpenBtn.TextSize = 21
            miniOpenBtn.Font = Enum.Font.GothamBold
            miniOpenBtn.Text = "Open"
            miniOpenBtn.Parent = screenGui
            local miniCorner = Instance.new("UICorner", miniOpenBtn)
            miniCorner.CornerRadius = UDim.new(0, 13)
            miniOpenBtn.MouseButton1Click:Connect(function()
                mainFrame.Visible = true
                miniOpenBtn:Destroy()
                miniOpenBtn = nil
            end)
        end
    end
    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        showMiniBtn()
    end)
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame:Destroy()
        if halloweenSound and halloweenSound.IsPlaying then
            halloweenSound:Stop()
        end
    end)
end

loadingScreen()
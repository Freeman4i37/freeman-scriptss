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

local green = Color3.fromRGB(0, 255, 0)

local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 320, 0, 90)
    notification.Position = UDim2.new(0.5, -160, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 15)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = green 
    uiStroke.Thickness = 3
    uiStroke.Parent = notification
    

    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -40, 1, -20)
    notifText.Position = UDim2.new(0, 20, 0, 10)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 20
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Center
    notifText.Parent = notification

    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1

    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    spawn(function()
        wait(duration)
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

local function typewriterEffect(text)
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    game:GetService("TweenService"):Create(background, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.2}):Play()
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {Size = 20}):Play()
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
    contentFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    contentFrame.BackgroundTransparency = 0.3
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = background
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 20)
    contentCorner.Parent = contentFrame
    
    local contentStroke = Instance.new("UIStroke")
    contentStroke.Color = green -- VERDE
    contentStroke.Thickness = 3
    contentStroke.Transparency = 0.2
    contentStroke.Parent = contentFrame
    

    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(0.9, 0, 0.2, 0)
    welcomeText.Position = UDim2.new(0.05, 0, 0.35, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = green -- VERDE
    welcomeText.TextSize = 48
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.TextXAlignment = Enum.TextXAlignment.Center -- Centralizado
    welcomeText.Parent = contentFrame
    
    local textGradient = Instance.new("UIGradient")
    textGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, green),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, green)
    })
    textGradient.Parent = welcomeText
    
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Size = UDim2.new(0.8, 0, 0.1, 0)
    subText.Position = UDim2.new(0.1, 0, 0.55, 0)
    subText.BackgroundTransparency = 1
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.TextSize = 28
    subText.Font = Enum.Font.Gotham
    subText.Text = "GUI by Freeman4i37."
    subText.TextTransparency = 1
    subText.TextXAlignment = Enum.TextXAlignment.Center
    subText.Parent = contentFrame


    game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    
    spawn(function()
        for i = 0, 1, 0.02 do
            textGradient.Offset = Vector2.new(i, 0)
            wait(0.05)
        end
    end)
    
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            wait(0.04)
        end
        
        wait(1.5)
        
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(contentFrame, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(contentStroke, TweenInfo.new(1, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 0}):Play()
        
        wait(1)
        showLanguageSelector()
        
        wait(0.5)
        background:Destroy()
        blur:Destroy()
    end)
end

function showLanguageSelector()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "LanguageSelector"
    mainFrame.Size = UDim2.new(0, 350, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 20)
    uiCorner.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = green -- VERDE
    uiStroke.Thickness = 3
    uiStroke.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "SELECT THE LANGUAGE:"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = mainFrame
    
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, green),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    titleGradient.Parent = titleLabel
    
    local portugueseButton = Instance.new("Frame")
    portugueseButton.Name = "PortugueseButton"
    portugueseButton.Size = UDim2.new(0.8, 0, 0, 50)
    portugueseButton.Position = UDim2.new(0.1, 0, 0.5, -30)
    portugueseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    portugueseButton.Parent = mainFrame
    
    local portugueseCorner = Instance.new("UICorner")
    portugueseCorner.CornerRadius = UDim.new(0, 15)
    portugueseCorner.Parent = portugueseButton
    
    local portugueseStroke = Instance.new("UIStroke")
    portugueseStroke.Color = green
    portugueseStroke.Thickness = 2
    portugueseStroke.Transparency = 0.5
    portugueseStroke.Parent = portugueseButton

    local portugueseText = Instance.new("TextLabel")
    portugueseText.Name = "PortugueseText"
    portugueseText.Size = UDim2.new(1, 0, 1, 0)
    portugueseText.Position = UDim2.new(0, 0, 0, 0)
    portugueseText.BackgroundTransparency = 1
    portugueseText.TextColor3 = Color3.fromRGB(255, 255, 255)
    portugueseText.TextSize = 18
    portugueseText.Font = Enum.Font.GothamBold
    portugueseText.Text = "Português 🇧🇷"
    portugueseText.TextXAlignment = Enum.TextXAlignment.Center -- Centralizado
    portugueseText.Parent = portugueseButton
    
    local portugueseClickDetector = Instance.new("TextButton")
    portugueseClickDetector.Name = "PortugueseClickDetector"
    portugueseClickDetector.Size = UDim2.new(1, 0, 1, 0)
    portugueseClickDetector.BackgroundTransparency = 1
    portugueseClickDetector.Text = ""
    portugueseClickDetector.Parent = portugueseButton
    
    local englishButton = Instance.new("Frame")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.8, 0, 0, 50)
    englishButton.Position = UDim2.new(0.1, 0, 0.5, 30)
    englishButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 15)
    englishCorner.Parent = englishButton
    
    local englishStroke = Instance.new("UIStroke")
    englishStroke.Color = green
    englishStroke.Thickness = 2
    englishStroke.Transparency = 0.5
    englishStroke.Parent = englishButton


    local englishText = Instance.new("TextLabel")
    englishText.Name = "EnglishText"
    englishText.Size = UDim2.new(1, 0, 1, 0)
    englishText.Position = UDim2.new(0, 0, 0, 0)
    englishText.BackgroundTransparency = 1
    englishText.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishText.TextSize = 20 
    englishText.Font = Enum.Font.GothamBold
    englishText.Text = "English 🇱🇷"
    englishText.TextXAlignment = Enum.TextXAlignment.Center -- Centralizado
    englishText.Parent = englishButton
   
    local englishClickDetector = Instance.new("TextButton")
    englishClickDetector.Name = "EnglishClickDetector"
    englishClickDetector.Size = UDim2.new(1, 0, 1, 0)
    englishClickDetector.BackgroundTransparency = 1
    englishClickDetector.Text = ""
    englishClickDetector.Parent = englishButton

    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(0.8, 0, 0, 2)
    divider.Position = UDim2.new(0.1, 0, 1, -40)
    divider.BackgroundColor3 = green
    divider.BorderSizePixel = 0
    divider.Parent = mainFrame

    local dividerGradient = Instance.new("UIGradient")
    dividerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, green),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, green)
    })
    dividerGradient.Parent = divider

    local scriptInfo = Instance.new("TextLabel")
    scriptInfo.Name = "ScriptInfo"
    scriptInfo.Size = UDim2.new(0.9, 0, 0, 25)
    scriptInfo.Position = UDim2.new(0.05, 0, 1, -30)
    scriptInfo.BackgroundTransparency = 1
    scriptInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfo.TextSize = 14 
    scriptInfo.Font = Enum.Font.GothamSemibold
    scriptInfo.Text = "Script By: Freeman4i37"
    scriptInfo.TextXAlignment = Enum.TextXAlignment.Center
    scriptInfo.Parent = mainFrame

    -- Partículas e animações mantidas iguais...

    portugueseClickDetector.MouseButton1Click:Connect(function()
        local clickEffect = game:GetService("TweenService"):Create(portugueseButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.76, 0, 0, 48), BackgroundTransparency = 0.2})
        clickEffect:Play()
        wait(0.15)
        game:GetService("TweenService"):Create(portugueseButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.8, 0, 0, 50), BackgroundTransparency = 0}):Play()

        local brightnessEffect = Instance.new("ColorCorrectionEffect")
        brightnessEffect.Brightness = 0
        brightnessEffect.Parent = game:GetService("Lighting")

        game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0.2}):Play()

        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -175, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Transparency = 1}):Play()

        createNotification("Script iniciado em Português.", 5)

        wait(0.6)
        game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0}):Play()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music-portuguese.lua"))()

        wait(0.3)
        brightnessEffect:Destroy()
        mainFrame:Destroy()
    end)

    englishClickDetector.MouseButton1Click:Connect(function()
        local clickEffect = game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.76, 0, 0, 48), BackgroundTransparency = 0.2})
        clickEffect:Play()
        wait(0.15)
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.8, 0, 0, 50), BackgroundTransparency = 0}):Play()

        local brightnessEffect = Instance.new("ColorCorrectionEffect")
        brightnessEffect.Brightness = 0
        brightnessEffect.Parent = game:GetService("Lighting")

        game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0.2}):Play()

        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -175, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Transparency = 1}):Play()

        createNotification("Script launched in English.", 5)

        wait(0.6)
        game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0}):Play()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music.lua"))()

        wait(0.3)
        brightnessEffect:Destroy()
        mainFrame:Destroy()
    end)
end

typewriterEffect("Welcome to Freeman HUB V1.0!")
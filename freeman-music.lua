local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

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
main.Size = UDim2.new(0, 420, 0, 230)
main.Position = UDim2.new(0.5, -210, 0.5, -115)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.BackgroundTransparency = 1

local cornerMain = Instance.new("UICorner", main)
cornerMain.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 140, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextTransparency = 1

local message = Instance.new("TextLabel", main)
message.Size = UDim2.new(1, -40, 0, 110)
message.Position = UDim2.new(0, 20, 0, 60)
message.BackgroundTransparency = 1
message.TextWrapped = true
message.TextYAlignment = Enum.TextYAlignment.Top
message.Font = Enum.Font.Gotham
message.TextSize = 18
message.TextColor3 = Color3.fromRGB(220, 220, 220)
message.TextTransparency = 1

local exitBtn = Instance.new("TextButton", main)
exitBtn.Size = UDim2.new(0, 120, 0, 40)
exitBtn.Position = UDim2.new(0.5, -60, 1, -60)
exitBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 20
exitBtn.BackgroundTransparency = 1
exitBtn.TextTransparency = 1
local exitCorner = Instance.new("UICorner", exitBtn)
exitCorner.CornerRadius = UDim.new(0, 8)

local langBtn = Instance.new("TextButton", main)
langBtn.Size = UDim2.new(0, 80, 0, 32)
langBtn.Position = UDim2.new(1, -92, 0, 12)
langBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
langBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
langBtn.Font = Enum.Font.GothamBold
langBtn.TextSize = 16
langBtn.BackgroundTransparency = 0
local langCorner = Instance.new("UICorner", langBtn)
langCorner.CornerRadius = UDim.new(0, 8)
langBtn.ZIndex = 50

local languages = {
	pt = {
		title = "⚠️ Aviso Importante ⚠️",
		message = "Este script foi encerrado ou está temporariamente desativado.\n\nPressione o botão abaixo para sair, e entre no nosso discord para mais informações.",
		exit = "Sair",
		langLabel = "PT"
	},
	en = {
		title = "⚠️ Important Notice ⚠️",
		message = "This script has been closed or is temporarily disabled.\n\nPress the button below to exit, and join on our discord for more information.",
		exit = "Exit",
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

fadeIn(background, "BackgroundTransparency", 0.3, 0.5)
fadeIn(main, "BackgroundTransparency", 0, 0.7)
fadeIn(title, "TextTransparency", 0, 0.8)
fadeIn(message, "TextTransparency", 0, 1)
fadeIn(exitBtn, "BackgroundTransparency", 0, 1)
fadeIn(exitBtn, "TextTransparency", 0, 1)

exitBtn.MouseEnter:Connect(function()
	TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)
exitBtn.MouseLeave:Connect(function()
	TweenService:Create(exitBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
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
	local discordLink = "https://discord.gg/aqjca9xb3"
	if setclipboard then
		setclipboard(discordLink)
	end

	TweenService:Create(background, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
	wait(0.45)

	if syn and syn.exit then
		syn.exit()
	elseif fluxus and fluxus.shutdown then
		fluxus.shutdown()
	else
		local ok, id = pcall(function() return identifyexecutor() end)
		if ok and id and string.find(string.lower(id), "krnl") then
			pcall(function() game:Shutdown() end)
		else
			while true do end
		end
	end
end)

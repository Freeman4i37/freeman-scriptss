
local BLOCK_LOAD = false

local player = game.Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local scriptUrl = "https://scriptsbinsauth.vercel.app/api/scripts/c723481e-7ffa-4523-a015-f961553aeb91/raw"
local blockedScriptUrl = "https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/advise.lua"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxLoader"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
if syn then
	syn.protect_gui(screenGui)
	screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
	screenGui.Parent = gethui()
else
	screenGui.Parent = player:WaitForChild("PlayerGui")
end

local violet = Color3.fromRGB(170, 90, 255)
local purple = Color3.fromRGB(90, 0, 170)
local white = Color3.fromRGB(255, 255, 255)
local dark = Color3.fromRGB(5, 0, 15)

local function createLoadingScreen()
	local gui = screenGui
	local promise = {}

	local bg = Instance.new("Frame", gui)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = dark
	bg.BorderSizePixel = 0
	local bgGrad = Instance.new("UIGradient", bg)
	bgGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, purple),
		ColorSequenceKeypoint.new(0.5, violet),
		ColorSequenceKeypoint.new(1, purple)
	}
	bgGrad.Rotation = 45

	local blur = Instance.new("BlurEffect", game.Lighting)
	blur.Size = 0
	TweenService:Create(blur, TweenInfo.new(2, Enum.EasingStyle.Sine), {Size = 24}):Play()

	task.spawn(function()
		while bg.Parent and not promise.completed do
			bgGrad.Rotation = (bgGrad.Rotation + 0.15) % 360
			RunService.RenderStepped:Wait()
		end
	end)

	for i = 1, 60 do
		local dot = Instance.new("Frame", bg)
		dot.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
		dot.Position = UDim2.new(math.random(), 0, math.random(), 0)
		dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dot.BackgroundTransparency = 0.7
		dot.ZIndex = 0
		dot.BorderSizePixel = 0
		task.spawn(function()
			while dot.Parent do
				TweenService:Create(dot, TweenInfo.new(math.random(3,6), Enum.EasingStyle.Linear), {
					Position = UDim2.new(math.random(), 0, math.random(), 0),
					BackgroundTransparency = math.random(3,8)/10
				}):Play()
				task.wait(math.random(3,6))
			end
		end)
	end

	local glowCircle = Instance.new("ImageLabel", bg)
	glowCircle.AnchorPoint = Vector2.new(0.5, 0.5)
	glowCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
	glowCircle.Size = UDim2.new(0, 0, 0, 0)
	glowCircle.BackgroundTransparency = 1
	glowCircle.Image = "rbxassetid://6023426923"
	glowCircle.ImageColor3 = violet
	glowCircle.ImageTransparency = 0.2

	local main = Instance.new("Frame", bg)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Position = UDim2.new(0.5, 0, 0.5, 0)
	main.Size = UDim2.new(0, 0, 0, 0)
	main.BackgroundColor3 = Color3.fromRGB(20, 0, 45)
	main.BorderSizePixel = 0
	main.BackgroundTransparency = 1
	local corner = Instance.new("UICorner", main)
	corner.CornerRadius = UDim.new(0, 26)
	local neon = Instance.new("UIStroke", main)
	neon.Color = violet
	neon.Thickness = 3

	local title = Instance.new("TextLabel", main)
	title.AnchorPoint = Vector2.new(0.5, 0)
	title.Position = UDim2.new(0.5, 0, 0, 30)
	title.Size = UDim2.new(1, -20, 0, 60)
	title.BackgroundTransparency = 1
	title.Text = "Auralynx — Music"
	title.Font = Enum.Font.GothamBlack
	title.TextScaled = true
	title.TextColor3 = white
	title.TextTransparency = 1
	local grad = Instance.new("UIGradient", title)
	grad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, violet),
		ColorSequenceKeypoint.new(0.5, white),
		ColorSequenceKeypoint.new(1, violet)
	}

	local subtitle = Instance.new("TextLabel", main)
	subtitle.AnchorPoint = Vector2.new(0.5, 0)
	subtitle.Position = UDim2.new(0.5, 0, 0, 95)
	subtitle.Size = UDim2.new(0.8, 0, 0, 25)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = "Initializing script..."
	subtitle.Font = Enum.Font.GothamBold
	subtitle.TextSize = 20
	subtitle.TextColor3 = violet
	subtitle.TextTransparency = 1

	local barBg = Instance.new("Frame", main)
	barBg.AnchorPoint = Vector2.new(0.5, 0)
	barBg.Position = UDim2.new(0.5, 0, 0, 150)
	barBg.Size = UDim2.new(0.8, 0, 0, 12)
	barBg.BackgroundColor3 = Color3.fromRGB(30, 0, 70)
	barBg.BorderSizePixel = 0
	barBg.BackgroundTransparency = 1
	local barBgCorner = Instance.new("UICorner", barBg)
	barBgCorner.CornerRadius = UDim.new(0, 8)

	local bar = Instance.new("Frame", barBg)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = violet
	bar.BorderSizePixel = 0
	local barCorner = Instance.new("UICorner", bar)
	barCorner.CornerRadius = UDim.new(0, 8)
	local barStroke = Instance.new("UIStroke", bar)
	barStroke.Color = white
	barStroke.Thickness = 1.5
	local barGrad = Instance.new("UIGradient", bar)
	barGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, violet),
		ColorSequenceKeypoint.new(1, white)
	}

	local percent = Instance.new("TextLabel", main)
	percent.AnchorPoint = Vector2.new(0.5, 0)
	percent.Position = UDim2.new(0.5, 0, 0, 175)
	percent.Size = UDim2.new(0.5, 0, 0, 30)
	percent.BackgroundTransparency = 1
	percent.Text = ""
	percent.Font = Enum.Font.GothamBold
	percent.TextSize = 22
	percent.TextColor3 = white
	percent.TextTransparency = 1

	TweenService:Create(glowCircle, TweenInfo.new(1.2, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, 1600, 0, 1600),
		ImageTransparency = 1
	}):Play()

	task.wait(0.5)
	TweenService:Create(main, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
		Size = UDim2.new(0, 500, 0, 240),
		BackgroundTransparency = 0
	}):Play()
	task.wait(0.3)
	TweenService:Create(title, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
	task.wait(0.2)
	TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
	task.wait(0.2)
	TweenService:Create(barBg, TweenInfo.new(0.7), {BackgroundTransparency = 0}):Play()
	TweenService:Create(percent, TweenInfo.new(0.7), {TextTransparency = 0}):Play()

	task.spawn(function()
		while main.Parent and not promise.completed do
			TweenService:Create(neon, TweenInfo.new(1.2), {Transparency = 0.4}):Play()
			task.wait(1)
			TweenService:Create(neon, TweenInfo.new(1.2), {Transparency = 0}):Play()
			task.wait(1)
		end
	end)

	task.spawn(function()
		for i = 0, 100 do
			percent.Text = i .. "%"
			TweenService:Create(bar, TweenInfo.new(0.05), {Size = UDim2.new(i / 100, 0, 1, 0)}):Play()
			if BLOCK_LOAD and i == 30 then
				subtitle.Text = "Oops, loading failed."
				task.wait(2)
				bg:Destroy()
				loadstring(game:HttpGet(blockedScriptUrl))()
				return
			end
			task.wait(0.015)
		end
		percent.Text = "100%"
		subtitle.Text = "Loading complete!"
		TweenService:Create(bar, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 1, 0)}):Play()
		task.wait(0.5)
		StarterGui:SetCore("SendNotification", {
			Title = "Auralynx — Music",
			Text = "Initialization complete, welcome!",
			Duration = 7
		})
		promise.completed = true
		TweenService:Create(main, TweenInfo.new(1), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(title, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
		TweenService:Create(subtitle, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
		TweenService:Create(percent, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
		TweenService:Create(barBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
		TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
		task.wait(1)
		blur:Destroy()
		gui:Destroy()
		loadstring(game:HttpGet(scriptUrl))()
	end)

	return promise
end

local function waitForPromise(promise)
	while not promise.completed do
		task.wait()
	end
end

local promise = createLoadingScreen()
waitForPromise(promise)
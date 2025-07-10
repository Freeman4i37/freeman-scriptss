local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "RLD_UI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local mainColor = Color3.fromRGB(18, 18, 18)
local borderColor = Color3.fromRGB(30, 30, 30)
local accentColor = Color3.fromRGB(40, 120, 255)
local buttonColor = Color3.fromRGB(30, 30, 30)
local textColor = Color3.fromRGB(255,255,255)
local closeColor = Color3.fromRGB(180,30,30)
local minimizeColor = Color3.fromRGB(60,60,60)
local strongPink = Color3.fromRGB(255, 65, 195)
local strongOrange = Color3.fromRGB(255, 165, 0)
local strongCyan = Color3.fromRGB(0, 255, 255)
local strongRed = Color3.fromRGB(255, 0, 0)
local strongLime = Color3.fromRGB(140, 255, 60)
local strongYellow = Color3.fromRGB(255, 255, 40)

local function getCurrentDoor()
	for _,r in pairs(workspace.CurrentRoomsG:GetChildren()) do
		if r:FindFirstChild("Door") and r.Door:FindFirstChild("Sign") and r.Door.Sign:FindFirstChild("SurfaceGui") then
			local txt = r.Door.Sign.SurfaceGui:FindFirstChild("TextLabel")
			if txt and txt.Text and tonumber(txt.Text:match("%d+")) then
				if r:FindFirstChild("Players") and r.Players:FindFirstChild(player.Name) then
					return tonumber(txt.Text)
				end
			end
		end
	end
	return nil
end

local function getRoomByNum(num)
	local s = tostring(num)
	return workspace.CurrentRoomsG:FindFirstChild(s)
end

local function activateFirstPrompt(obj)
	for _,desc in ipairs(obj:GetDescendants()) do
		if desc:IsA("ProximityPrompt") and desc.Enabled then
			fireproximityprompt(desc)
			return true
		end
	end
	return false
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 270, 0, 400)
frame.Position = UDim2.new(0.06, 0, 0.18, 0)
frame.BackgroundColor3 = mainColor
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = borderColor
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Text = "Freeman’s HUB: RLD"
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0,36,0,32)
closeButton.Position = UDim2.new(1, -44, 0, 3)
closeButton.BackgroundColor3 = closeColor
closeButton.TextColor3 = textColor
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "_"
minimizeButton.Size = UDim2.new(0,32,0,32)
minimizeButton.Position = UDim2.new(1, -80, 0, 3)
minimizeButton.BackgroundColor3 = minimizeColor
minimizeButton.TextColor3 = textColor
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.new(0, 38, 0, 38)
miniButton.Position = UDim2.new(0, 8, 0, 8)
miniButton.BackgroundColor3 = mainColor
miniButton.Text = "+"
miniButton.TextColor3 = textColor
miniButton.Font = Enum.Font.GothamBold
miniButton.TextScaled = true
miniButton.Visible = false
miniButton.BorderSizePixel = 0
miniButton.Parent = gui
Instance.new("UICorner", miniButton).CornerRadius = UDim.new(0, 8)

local btnHolder = Instance.new("Frame")
btnHolder.Size = UDim2.new(1, -24, 0, 226)
btnHolder.Position = UDim2.new(0, 12, 0, 54)
btnHolder.BackgroundTransparency = 1
btnHolder.Parent = frame

local function CreateButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.Position = UDim2.new(0, 0, 0, y)
	btn.BackgroundColor3 = buttonColor
	btn.Text = text
	btn.TextColor3 = textColor
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Parent = btnHolder
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local espButton = CreateButton("ESP: ON", 0)
local autoDoorsButton = CreateButton("Auto Doors: OFF", 44)
local spawnedEntitiesButton = CreateButton("Spawned Entities", 88)
local autoHideButton = CreateButton("AUTO-HIDE: OFF", 132)

local credit = Instance.new("TextLabel")
credit.Text = "Freeman4i37"
credit.Size = UDim2.new(1, 0, 0, 22)
credit.Position = UDim2.new(0, 0, 1, -28)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.Parent = frame

local autoHideEnabled = false
autoHideButton.MouseButton1Click:Connect(function()
	autoHideEnabled = not autoHideEnabled
	autoHideButton.Text = autoHideEnabled and "AUTO-HIDE: ON" or "AUTO-HIDE: OFF"
end)

local rainbowColors = {
	Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0), Color3.fromRGB(255,255,0),
	Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255), Color3.fromRGB(75,0,130), Color3.fromRGB(148,0,211)
}
local function getRainbowColor(speed)
	local t = tick()*speed
	local i = math.floor(t)%#rainbowColors+1
	return rainbowColors[i]
end

local function getTransitionColor(colorA, colorB, speed)
	local t = math.abs(math.sin(tick()*(speed or 2)))
	return Color3.new(
		colorA.R + (colorB.R - colorA.R) * t,
		colorA.G + (colorB.G - colorA.G) * t,
		colorA.B + (colorB.B - colorA.B) * t
	)
end

local function getMultiTransitionColor(colors, speed, interval)
	local t = (tick() * (speed or 1)) / (interval or 1)
	local idx = math.floor(t) % #colors + 1
	local nextidx = idx % #colors + 1
	local frac = t - math.floor(t)
	local c1 = colors[idx]
	local c2 = colors[nextidx]
	return Color3.new(
		c1.R + (c2.R - c1.R)*frac,
		c1.G + (c2.G - c1.G)*frac,
		c1.B + (c2.B - c1.B)*frac
	)
end

local colorTable = {
	["happyman"] = strongRed,
	["sadman"] = strongRed,
	["angryman"] = strongRed,
	["nerdman"] = strongPink,
	["c-25"] = strongPink,
	["a-75"] = strongPink,
	["smartman"] = strongPink,
	["scaredman"] = Color3.fromRGB(128,0,128),
	["shortman"] = Color3.fromRGB(0,0,255),
	["mushman"] = Color3.fromRGB(0,0,255),
	["bigman"] = Color3.fromRGB(0,255,0),
	["a-25"] = Color3.fromRGB(0,255,0),
	["c-60"] = Color3.fromRGB(0,255,0),
	["a-105"] = Color3.fromRGB(0,255,0),
	["tallman"] = strongOrange,
	["a-45"] = strongOrange,
	["1-a"] = strongOrange,
	["joyfulman"] = Color3.fromRGB(255,255,0),
	["a-120"] = Color3.fromRGB(255,255,0),
	["a-275"] = Color3.fromRGB(255,255,0),
	["glee"] = Color3.fromRGB(0,150,255),
	["a-1"] = "graywhite",
	["c-1"] = "rainbow",
	["sn-1"] = Color3.fromRGB(48,0,64),
	["jb-1"] = Color3.fromRGB(0,96,0),
	["a-60"] = strongRed,
	["a-150"] = Color3.fromRGB(80,180,255),
	["a-185"] = Color3.fromRGB(40,80,180),
	["a-200"] = Color3.fromRGB(255,255,255),
	["a-225"] = Color3.fromRGB(0,0,100),
	["mournfulman"] = Color3.fromRGB(0,0,100),
	["a-250"] = Color3.fromRGB(120,0,0),
	["a-300"] = "orangered",
	["wideglee"] = strongPink,
	["cv-300"] = "whiteorange",
	["b-5"] = Color3.fromRGB(0,255,0),
	["b-15"] = Color3.fromRGB(44,74,188),
	["b-25"] = strongCyan,
	["b-40"] = Color3.fromRGB(128,40,40),
	["b-60"] = Color3.fromRGB(64,0,90),
	["b-85"] = "blackwhite",
	["b-100"] = Color3.fromRGB(0,40,90),
	["b-120"] = Color3.fromRGB(120,120,120),
	["b-140"] = Color3.fromRGB(120,255,120),
	["mob-1"] = Color3.fromRGB(120,255,120),
	["mob-2"] = Color3.fromRGB(120,255,120),
	["b-170"] = Color3.fromRGB(70,140,70),
	["b-200"] = "whitered",
	["b-244"] = Color3.fromRGB(255,0,0),
	["b-270"] = Color3.fromRGB(128,0,255),
	["b-300"] = Color3.fromRGB(50,255,90),
	["g-3"] = Color3.fromRGB(0, 80, 0),
	["g-26"] = "g26bw",
	["g-55"] = "g55wgb",
	["g-60"] = strongCyan,
	["g-88"] = strongRed,
	["g-100"] = "greendarkred",
	["g-122"] = strongRed,
	["g-150"] = strongPink,
	["g-159"] = strongLime,
	["g-177"] = Color3.fromRGB(0, 120, 0),
	["g-200"] = strongPink,
	["g-222"] = "bluewhite",
	["g-235"] = strongYellow,
	["g-250"] = strongOrange,
	["g-300"] = "g300multi"
}

local function getEntityColor(entity)
	local name = entity.Name:lower()
	local color = colorTable[name]
	if not color then
		for key, val in pairs(colorTable) do
			if name == key or entity.Name == key or entity.Name == key:upper() or entity.Name:match("^A%-%d+") or entity.Name:match("^B%-%d+") or entity.Name:match("^G%-%d+") then
				color = val
				break
			end
		end
	end
	if not color then return Color3.fromRGB(255,255,255) end
	if color == "graywhite" then
		local v = math.abs(math.sin(tick()*2))
		return Color3.new(v,v,v)
	elseif color == "rainbow" then
		return getRainbowColor(8)
	elseif color == "orangered" then
		local v = math.abs(math.sin(tick()*2))
		return Color3.fromRGB(255,math.floor(70+70*v),0)
	elseif color == "whiteorange" then
		return getTransitionColor(Color3.fromRGB(255,255,255), Color3.fromRGB(255,140,0), 2)
	elseif color == "blackwhite" then
		return getTransitionColor(Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255), 2.5)
	elseif color == "whitered" then
		return getTransitionColor(Color3.fromRGB(255,255,255), Color3.fromRGB(255,0,0), 2.5)
	elseif color == "greendarkred" then
		if math.floor(tick())%2 == 0 then
			return Color3.fromRGB(0,255,0)
		else
			return Color3.fromRGB(120,0,0)
		end
	elseif color == "bluewhite" then
		return getTransitionColor(Color3.fromRGB(0,170,255), Color3.fromRGB(255,255,255), 2.3)
	elseif color == "g26bw" then
		if math.floor(tick()*2)%2==0 then
			return Color3.fromRGB(0,0,0)
		else
			return Color3.fromRGB(255,255,255)
		end
	elseif color == "g55wgb" then
		local colors = {Color3.fromRGB(255,255,255),Color3.fromRGB(180,180,180),Color3.fromRGB(0,0,0)}
		return getMultiTransitionColor(colors,7,1)
	elseif color == "g300multi" then
		return getMultiTransitionColor({
			strongRed, strongOrange, Color3.fromRGB(0,30,80), Color3.fromRGB(0,255,0), strongYellow
		}, 2, 1)
	else
		return color
	end
end

local autoHideCool = {}
local function showAutoHidePrompt(entityName)
	if gui:FindFirstChild("AutoHidePrompt") then return end
	local prompt = Instance.new("Frame")
	prompt.Name = "AutoHidePrompt"
	prompt.Size = UDim2.new(0, 420, 0, 168)
	prompt.AnchorPoint = Vector2.new(0.5,0.5)
	prompt.Position = UDim2.new(0.5,0,0.5,0)
	prompt.BackgroundColor3 = mainColor
	prompt.BorderSizePixel = 0
	prompt.Parent = gui
	prompt.ZIndex = 1000
	Instance.new("UICorner", prompt).CornerRadius = UDim.new(0,13)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,-36,0,40)
	label.Position = UDim2.new(0,18,0,0)
	label.BackgroundTransparency = 1
	label.Text = 'The entity "' .. tostring(entityName or "???") .. '" has spawned, select where to hide.'
	label.TextColor3 = textColor
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.ZIndex = 1001
	label.Parent = prompt
	local closeX = Instance.new("TextButton")
	closeX.Size = UDim2.new(0,32,0,32)
	closeX.Position = UDim2.new(1, -38, 0, 6)
	closeX.BackgroundColor3 = closeColor
	closeX.TextColor3 = textColor
	closeX.Font = Enum.Font.GothamBold
	closeX.Text = "X"
	closeX.TextScaled = true
	closeX.ZIndex = 1002
	closeX.Parent = prompt
	Instance.new("UICorner", closeX).CornerRadius = UDim.new(0,8)
	closeX.MouseButton1Click:Connect(function() prompt:Destroy() autoHideCool={} end)
	local buttons = {
		{"TABLE", function(room)
			if room and room:FindFirstChild("Tables") and room.Tables:FindFirstChild("Table") then
				local tbl = room.Tables.Table
				if tbl:FindFirstChild("CheckCF1") then
					player.Character:SetPrimaryPartCFrame(tbl.CheckCF1.CFrame)
					activateFirstPrompt(tbl)
				end
			end
		end};
		{"PREVIOUS TABLE", function(room)
			if room and room:FindFirstChild("Tables") and room.Tables:FindFirstChild("Table") then
				local tbl = room.Tables.Table
				if tbl:FindFirstChild("CheckCF1") then
					player.Character:SetPrimaryPartCFrame(tbl.CheckCF1.CFrame)
					activateFirstPrompt(tbl)
				end
			end
		end};
		{"LOCKER", function(room)
			if room and room:FindFirstChild("Lockers") and room.Lockers:FindFirstChild("locker") and room.Lockers.locker:FindFirstChild("Root") then
				player.Character:SetPrimaryPartCFrame(room.Lockers.locker.Root.CFrame)
				activateFirstPrompt(room.Lockers.locker)
			end
		end};
		{"PREVIOUS LOCKER", function(room)
			if room and room:FindFirstChild("Lockers") and room.Lockers:FindFirstChild("locker") and room.Lockers.locker:FindFirstChild("Root") then
				player.Character:SetPrimaryPartCFrame(room.Lockers.locker.Root.CFrame)
				activateFirstPrompt(room.Lockers.locker)
			end
		end};
	}
	for i,btn in ipairs(buttons) do
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0.43,0,0,38)
		b.Position = UDim2.new(0.03+(i-1)%2*0.5,0,0.45+(math.floor((i-1)/2))*0.3,0)
		b.BackgroundColor3 = accentColor
		b.Text = btn[1]
		b.TextColor3 = textColor
		b.Font = Enum.Font.GothamBold
		b.TextScaled = true
		b.ZIndex = 1002
		b.Parent = prompt
		Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
		b.MouseButton1Click:Connect(function()
			local cur = getCurrentDoor() or 76
			local which = btn[1]
			local roomNum = cur
			if which:find("PREVIOUS") then
				roomNum = math.max(1,cur-3)
			end
			local room = getRoomByNum(roomNum)
			btn[2](room)
			prompt:Destroy()
			autoHideCool = {}
		end)
	end
	delay(8,function() if prompt and prompt.Parent then prompt:Destroy() end end)
end

local function shouldShowForEntity(entName)
	entName = entName or ""
	return entName:match("^[AaBbGg]%-")
end

local lastEntities = {}
task.spawn(function()
	while true do
		local folder = workspace:FindFirstChild("SpawnedEnitites")
		if folder then
			local current = {}
			for _, entity in pairs(folder:GetChildren()) do
				current[entity] = true
			end
			for entity,_ in pairs(current) do
				if not lastEntities[entity] then
					if autoHideEnabled and not autoHideCool[entity.Name] and shouldShowForEntity(entity.Name) then
						autoHideCool[entity.Name] = true
						showAutoHidePrompt(entity.Name)
					end
				end
			end
			lastEntities = current
		end
		wait(0.1)
	end
end)

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "RLD_ESP"
local espEnabled = true

local function CreateESP(part, entity)
	if part:FindFirstChild("ESP_Billboard") then return end
	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "ESP_Billboard"
	Billboard.Adornee = part
	Billboard.Size = UDim2.new(0, 140, 0, 50)
	Billboard.AlwaysOnTop = true
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.BackgroundTransparency = 1
	Label.TextStrokeTransparency = 0
	Label.TextScaled = true
	Label.Font = Enum.Font.GothamBold
	Label.Text = entity.Name .. " | 0m"
	Label.Parent = Billboard
	Billboard.Parent = ESPFolder
	local connection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		if Billboard and Billboard.Adornee and espEnabled then
			local distance = (player.Character.HumanoidRootPart.Position - Billboard.Adornee.Position).Magnitude
			Label.Text = entity.Name .. " | " .. math.floor(distance) .. "m"
			Label.TextColor3 = getEntityColor(entity)
			Billboard.Enabled = true
		elseif not espEnabled then
			Billboard.Enabled = false
		else
			Billboard:Destroy()
			if connection then connection:Disconnect() end
		end
	end)
	entity.AncestryChanged:Connect(function(_, parent)
		if not parent then
			Billboard:Destroy()
			if connection then connection:Disconnect() end
		end
	end)
end

task.spawn(function()
	while true do
		if espEnabled then
			local folder = workspace:FindFirstChild("SpawnedEnitites")
			if folder then
				for _, entity in pairs(folder:GetChildren()) do
					local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
					if part then
						CreateESP(part, entity)
					end
				end
			end
		end
		wait(1)
	end
end)

espButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
end)

if not getgenv().RLD_AutoDoorsLock then
	getgenv().RLD_AutoDoorsLock = true
	task.spawn(function()
		while true do
			if getgenv().RLD_AutoDoorsEnabled then
				for _, section in pairs({"CurrentRoomsA", "CurrentRoomsB", "CurrentRoomsG"}) do
					local folder = workspace:FindFirstChild(section)
					if folder then
						for _, room in pairs(folder:GetChildren()) do
							for _, obj in pairs(room:GetDescendants()) do
								if obj:IsA("ProximityPrompt") and obj.ActionText == "Open" and obj.MaxActivationDistance >= 0 then
									fireproximityprompt(obj)
									wait(0.01)
								end
							end
						end
					end
				end
			end
			wait(0.1)
		end
	end)
end

autoDoorsButton.MouseButton1Click:Connect(function()
	getgenv().RLD_AutoDoorsEnabled = not getgenv().RLD_AutoDoorsEnabled
	autoDoorsButton.Text = getgenv().RLD_AutoDoorsEnabled and "Auto Doors: ON" or "Auto Doors: OFF"
end)

local entitiesFrame = Instance.new("Frame")
entitiesFrame.Size = UDim2.new(0, 340, 0, 310)
entitiesFrame.Position = UDim2.new(0.18, 0, 0.19, 0)
entitiesFrame.BackgroundColor3 = mainColor
entitiesFrame.Visible = false
entitiesFrame.Parent = gui
entitiesFrame.Active = true
entitiesFrame.Draggable = true
Instance.new("UICorner", entitiesFrame).CornerRadius = UDim.new(0, 8)

local entitiesTitle = Instance.new("TextLabel")
entitiesTitle.Text = "Spawned Entities"
entitiesTitle.Size = UDim2.new(1, 0, 0, 36)
entitiesTitle.BackgroundTransparency = 1
entitiesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
entitiesTitle.Font = Enum.Font.GothamBold
entitiesTitle.TextScaled = true
entitiesTitle.Parent = entitiesFrame

local entitiesScrolling = Instance.new("ScrollingFrame")
entitiesScrolling.Size = UDim2.new(1, -18, 1, -54)
entitiesScrolling.Position = UDim2.new(0, 9, 0, 44)
entitiesScrolling.BackgroundTransparency = 1
entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
entitiesScrolling.ScrollBarThickness = 6
entitiesScrolling.Parent = entitiesFrame
entitiesScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y

local minimizeEntitiesButton = Instance.new("TextButton")
minimizeEntitiesButton.Text = "_"
minimizeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
minimizeEntitiesButton.Position = UDim2.new(1, -74, 0, 6)
minimizeEntitiesButton.BackgroundColor3 = minimizeColor
minimizeEntitiesButton.TextColor3 = textColor
minimizeEntitiesButton.Font = Enum.Font.GothamBold
minimizeEntitiesButton.TextScaled = true
minimizeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", minimizeEntitiesButton).CornerRadius = UDim.new(0, 6)

local closeEntitiesButton = Instance.new("TextButton")
closeEntitiesButton.Text = "X"
closeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
closeEntitiesButton.Position = UDim2.new(1, -38, 0, 6)
closeEntitiesButton.BackgroundColor3 = closeColor
closeEntitiesButton.TextColor3 = textColor
closeEntitiesButton.Font = Enum.Font.GothamBold
closeEntitiesButton.TextScaled = true
closeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", closeEntitiesButton).CornerRadius = UDim.new(0, 6)

local miniEntitiesButton = Instance.new("TextButton")
miniEntitiesButton.Size = UDim2.new(0, 38, 0, 38)
miniEntitiesButton.Position = UDim2.new(0.18, 0, 0.19, 0)
miniEntitiesButton.BackgroundColor3 = mainColor
miniEntitiesButton.Text = "+"
miniEntitiesButton.TextColor3 = textColor
miniEntitiesButton.Font = Enum.Font.GothamBold
miniEntitiesButton.TextScaled = true
miniEntitiesButton.Visible = false
miniEntitiesButton.Parent = gui
Instance.new("UICorner", miniEntitiesButton).CornerRadius = UDim.new(0, 8)

local unviewButton = nil
local lastCameraSubject = nil
local entityRows = {}

local function clearEntitiesList()
	for _, row in pairs(entityRows) do
		if row and row.Frame then
			row.Frame:Destroy()
		end
	end
	entityRows = {}
end

local function startSpectate(part, entity)
	if not (part and part.Parent) then return end
	lastCameraSubject = camera.CameraSubject
	camera.CameraSubject = part
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = false
	if unviewButton then unviewButton:Destroy() end
	unviewButton = Instance.new("TextButton")
	unviewButton.Size = UDim2.new(0, 120, 0, 35)
	unviewButton.Position = UDim2.new(0.5, -60, 1, -50)
	unviewButton.AnchorPoint = Vector2.new(0.5, 1)
	unviewButton.BackgroundColor3 = accentColor
	unviewButton.Text = "UNVIEW"
	unviewButton.TextColor3 = textColor
	unviewButton.Font = Enum.Font.GothamBold
	unviewButton.TextScaled = true
	unviewButton.Parent = gui
	Instance.new("UICorner", unviewButton).CornerRadius = UDim.new(0, 8)
	unviewButton.MouseButton1Click:Connect(function()
		camera.CameraSubject = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") or lastCameraSubject
		if unviewButton then
			unviewButton:Destroy()
			unviewButton = nil
		end
		entitiesFrame.Visible = true
	end)
end

local function buildEntitiesList()
	clearEntitiesList()
	local folder = workspace:FindFirstChild("SpawnedEnitites")
	if not folder then
		entitiesTitle.Text = "Spawned Entities (none)"
		return
	else
		entitiesTitle.Text = "Spawned Entities"
	end
	local y = 0
	for _, entity in pairs(folder:GetChildren()) do
		if entity then
			local row = {}
			local itemFrame = Instance.new("Frame")
			itemFrame.Size = UDim2.new(1, 0, 0, 36)
			itemFrame.Position = UDim2.new(0, 0, 0, y)
			itemFrame.BackgroundTransparency = 1
			itemFrame.Parent = entitiesScrolling
			local nameLabel = Instance.new("TextLabel")
			nameLabel.Text = entity.Name
			nameLabel.Size = UDim2.new(0.43, 0, 1, 0)
			nameLabel.Position = UDim2.new(0, 0, 0, 0)
			nameLabel.BackgroundTransparency = 1
			nameLabel.TextXAlignment = Enum.TextXAlignment.Left
			nameLabel.Font = Enum.Font.GothamBold
			nameLabel.TextScaled = true
			nameLabel.TextColor3 = getEntityColor(entity)
			nameLabel.Parent = itemFrame
			local viewBtn = Instance.new("TextButton")
			viewBtn.Size = UDim2.new(0.22, 0, Connect(function()
				local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
				if part and part.Parent then
					startSpectate(part, entity)
				end
			end)
			row.Frame = itemFrame
			row.Entity = entity
			row.NameLabel = nameLabel
			row.DistLabel = distLabel
			table.insert(entityRows, row)
			y = y + 38
		end
	end
	entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, y)
end

local function updateEntityRows()
	local folder = workspace:FindFirstChild("SpawnedEnitites")
	if not folder then return end
	if #folder:GetChildren() ~= #entityRows then
		buildEntitiesList()
	end
	for i, row in ipairs(entityRows) do
		if row and row.Entity and row.NameLabel and row.DistLabel then
			if row.Entity.Parent == folder then
				local dist = 0
				local part = row.Entity.PrimaryPart or row.Entity:FindFirstChildWhichIsA("BasePart")
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp and part and part.Parent then
					dist = (hrp.Position - part.Position).Magnitude
				end
				row.DistLabel.Text = math.floor(dist) .. " studs away"
				row.NameLabel.TextColor3 = getEntityColor(row.Entity)
			else
				if row.Frame then row.Frame:Destroy() end
			end
		end
	end
end

spawnedEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = true
	miniEntitiesButton.Visible = false
	buildEntitiesList()
end)

closeEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = false
end)

minimizeEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = true
end)

miniEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = true
	miniEntitiesButton.Visible = false
	buildEntitiesList()
end)

entitiesFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	if entitiesFrame.Visible then
		buildEntitiesList()
	end
end)

task.spawn(function()
	while true do
		if entitiesFrame.Visible then
			updateEntityRows()
		end
		wait(0.2)
	end
end)

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
	ESPFolder:Destroy()
end)

minimizeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniButton.Visible = true
end)

miniButton.MouseButton1Click:Connect(function()
	frame.Visible = true
	miniButton.Visible = false
end)
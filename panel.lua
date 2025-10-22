local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local orange = Color3.fromRGB(255, 140, 0)
local yellowOrange = Color3.fromRGB(255, 200, 40)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxAdminUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "AdminPanel"
mainFrame.Size = UDim2.new(0, 360, 0, 410)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
mainFrame.Parent = screenGui
mainFrame.ZIndex = 10

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 3
uiStroke.Color = orange
local grad = Instance.new("UIGradient", uiStroke)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, orange),
    ColorSequenceKeypoint.new(0.5, yellowOrange),
    ColorSequenceKeypoint.new(1, orange)
}

local headerFrame = Instance.new("Frame", mainFrame)
headerFrame.Size = UDim2.new(1, 0, 0, 46)
headerFrame.BackgroundTransparency = 1
headerFrame.ZIndex = 12

local titleLabel = Instance.new("TextLabel", headerFrame)
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.TextSize = 26
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.Text = "Auralynx Panel"
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.ZIndex = 12

local minimizeBtn = Instance.new("TextButton", headerFrame)
minimizeBtn.Size = UDim2.new(0, 34, 0, 34)
minimizeBtn.Position = UDim2.new(1, -78, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
minimizeBtn.TextColor3 = orange
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 25
minimizeBtn.ZIndex = 13
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,8)

local closeBtn = Instance.new("TextButton", headerFrame)
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
closeBtn.TextColor3 = orange
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 23
closeBtn.ZIndex = 13
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

local minimizedFrame = Instance.new("Frame", screenGui)
minimizedFrame.Name = "MinimizedPanel"
minimizedFrame.Size = UDim2.new(0, 260, 0, 46)
minimizedFrame.AnchorPoint = Vector2.new(0.5, 0.5)
minimizedFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
minimizedFrame.Visible = false
minimizedFrame.ZIndex = 99
Instance.new("UICorner", minimizedFrame).CornerRadius = UDim.new(0, 16)
local minStroke = Instance.new("UIStroke", minimizedFrame)
minStroke.Thickness = 3
minStroke.Color = orange
local minGrad = Instance.new("UIGradient", minStroke)
minGrad.Color = grad.Color

local minTitle = Instance.new("TextLabel", minimizedFrame)
minTitle.Size = UDim2.new(1, -90, 1, 0)
minTitle.Position = UDim2.new(0, 0, 0, 0)
minTitle.BackgroundTransparency = 1
minTitle.TextColor3 = Color3.fromRGB(255,255,255)
minTitle.TextSize = 26
minTitle.Font = Enum.Font.GothamBlack
minTitle.Text = "Auralynx Panel"
minTitle.TextXAlignment = Enum.TextXAlignment.Center
minTitle.ZIndex = 100

local maximizeBtn = Instance.new("TextButton", minimizedFrame)
maximizeBtn.Size = UDim2.new(0, 34, 0, 34)
maximizeBtn.Position = UDim2.new(1, -78, 0, 6)
maximizeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
maximizeBtn.TextColor3 = orange
maximizeBtn.Text = "+"
maximizeBtn.Font = Enum.Font.GothamBold
maximizeBtn.TextSize = 25
maximizeBtn.ZIndex = 101
Instance.new("UICorner", maximizeBtn).CornerRadius = UDim.new(0,8)

local minCloseBtn = Instance.new("TextButton", minimizedFrame)
minCloseBtn.Size = UDim2.new(0, 34, 0, 34)
minCloseBtn.Position = UDim2.new(1, -38, 0, 6)
minCloseBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
minCloseBtn.TextColor3 = orange
minCloseBtn.Text = "X"
minCloseBtn.Font = Enum.Font.GothamBold
minCloseBtn.TextSize = 23
minCloseBtn.ZIndex = 101
Instance.new("UICorner", minCloseBtn).CornerRadius = UDim.new(0,8)

local playersList = {}
for _, plr in ipairs(Players:GetPlayers()) do
    table.insert(playersList, plr.Name)
end

local selectedPlayer = playersList[1] or LocalPlayer.Name

local dropdownLabel = Instance.new("TextLabel", mainFrame)
dropdownLabel.Size = UDim2.new(0.6, 0, 0, 28)
dropdownLabel.Position = UDim2.new(0.08, 0, 0, 58)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.TextColor3 = Color3.fromRGB(255,255,255)
dropdownLabel.TextSize = 18
dropdownLabel.Font = Enum.Font.Gotham
dropdownLabel.Text = "Selecionar Jogador:"
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.ZIndex = 12

local selectBtn = Instance.new("TextButton", mainFrame)
selectBtn.Size = UDim2.new(0.32, 0, 0, 28)
selectBtn.Position = UDim2.new(0.6, 0, 0, 58)
selectBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
selectBtn.TextColor3 = orange
selectBtn.Font = Enum.Font.GothamBold
selectBtn.TextSize = 18
selectBtn.Text = selectedPlayer
selectBtn.ZIndex = 13
Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0,8)

local playerDropdown = Instance.new("Frame", screenGui)
playerDropdown.Name = "PlayerDropdown"
playerDropdown.Size = UDim2.new(0, 200, 0, 160)
playerDropdown.Position = UDim2.new(0.5, -100, 0.5, -80)
playerDropdown.BackgroundColor3 = Color3.fromRGB(30,30,30)
playerDropdown.Visible = false
playerDropdown.ZIndex = 99
Instance.new("UICorner", playerDropdown).CornerRadius = UDim.new(0,10)
local scrollPlayers = Instance.new("ScrollingFrame", playerDropdown)
scrollPlayers.Size = UDim2.new(1, 0, 1, 0)
scrollPlayers.CanvasSize = UDim2.new(0,0,0,0)
scrollPlayers.ScrollBarThickness = 6
scrollPlayers.BackgroundTransparency = 1
scrollPlayers.ZIndex = 100
local layoutPlayers = Instance.new("UIListLayout", scrollPlayers)
layoutPlayers.Padding = UDim.new(0, 4)
layoutPlayers.SortOrder = Enum.SortOrder.LayoutOrder

local function refreshPlayers()
    for _, v in ipairs(scrollPlayers:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    local list = Players:GetPlayers()
    scrollPlayers.CanvasSize = UDim2.new(0,0,0,#list * 32)
    for _, plr in ipairs(list) do
        local btn = Instance.new("TextButton", scrollPlayers)
        btn.Size = UDim2.new(1, -8, 0, 28)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = orange
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = plr.Name
        btn.ZIndex = 101
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,7)
        btn.MouseButton1Click:Connect(function()
            selectedPlayer = plr.Name
            selectBtn.Text = plr.Name
            playerDropdown.Visible = false
        end)
        if plr.Name == selectedPlayer then
            btn.TextColor3 = yellowOrange
        end
    end
end

selectBtn.MouseButton1Click:Connect(function()
    refreshPlayers()
    playerDropdown.Visible = not playerDropdown.Visible
end)
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

local cmdLabel = Instance.new("TextLabel", mainFrame)
cmdLabel.Size = UDim2.new(1, -36, 0, 24)
cmdLabel.Position = UDim2.new(0, 18, 0, 108)
cmdLabel.Text = "Comandos:"
cmdLabel.Font = Enum.Font.GothamSemibold
cmdLabel.TextSize = 18
cmdLabel.TextColor3 = Color3.fromRGB(255,255,255)
cmdLabel.BackgroundTransparency = 1
cmdLabel.TextXAlignment = Enum.TextXAlignment.Left

local cmdScroll = Instance.new("ScrollingFrame", mainFrame)
cmdScroll.Size = UDim2.new(1, -40, 1, -140)
cmdScroll.Position = UDim2.new(0, 20, 0, 140)
cmdScroll.CanvasSize = UDim2.new(0,0,0,0)
cmdScroll.ScrollBarThickness = 8
cmdScroll.BackgroundColor3 = Color3.fromRGB(30,30,30)
cmdScroll.BorderSizePixel = 0
cmdScroll.ZIndex = 20
local cmdLayout = Instance.new("UIListLayout", cmdScroll)
cmdLayout.FillDirection = Enum.FillDirection.Vertical
cmdLayout.Padding = UDim.new(0, 8)
cmdLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
cmdLayout.SortOrder = Enum.SortOrder.LayoutOrder

local commands = {
    {"Kick", ";kick"},
    {"Kill Plus", ";killplus"},
    {"Kill", ";kill"},
    {"Freeze", ";freeze"},
    {"Fling", ";fling"},
    {"Verifique", ";verifique"}
}
cmdScroll.CanvasSize = UDim2.new(0,0,0,#commands * 44)

local function sendCommand(cmd)
    local channel = TextChatService.TextChannels.RBXGeneral
    if channel then
        if cmd == ";verifique" then
            channel:SendAsync(cmd)
        else
            channel:SendAsync(cmd .. " " .. selectedPlayer)
        end
    end
end

for _, data in ipairs(commands) do
    local cmdBtn = Instance.new("TextButton", cmdScroll)
    cmdBtn.Size = UDim2.new(1, -8, 0, 38)
    cmdBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    cmdBtn.TextColor3 = orange
    cmdBtn.Font = Enum.Font.GothamBold
    cmdBtn.TextSize = 19
    cmdBtn.Text = data[1]
    cmdBtn.ZIndex = 21
    Instance.new("UICorner", cmdBtn).CornerRadius = UDim.new(0,10)
    cmdBtn.MouseButton1Click:Connect(function()
        sendCommand(data[2])
    end)
end

playerDropdown.Parent = screenGui

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedFrame.Visible = true
end)
maximizeBtn.MouseButton1Click:Connect(function()
    minimizedFrame.Visible = false
    mainFrame.Visible = true
end)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
minCloseBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

TextChatService.OnIncomingMessage = function(message)
    local msgText = message.Text:lower()
    local playerName = LocalPlayer.Name:lower()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if msgText:match(";kick%s+" .. playerName) then
        LocalPlayer:Kick("Você foi removido pelo Auralynx Panel.")
    end
    if msgText:match(";kill%s+" .. playerName) then
        if character then character:BreakJoints() end
    end
    if msgText:match(";killplus%s+" .. playerName) then
        if character then
            character:BreakJoints()
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                for i = 1, 10 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(10,10,10)
                    part.Anchored = false
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.BrickColor = BrickColor.Random()
                    part.CFrame = root.CFrame
                    part.Parent = workspace
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = Vector3.new(math.random(-50,50), math.random(20,80), math.random(-50,50))
                    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bv.Parent = part
                    game.Debris:AddItem(part, 3)
                end
            end
        end
    end
    if msgText:match(";fling%s+" .. playerName) then
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local targetCFrame = CFrame.new(50000, 5000000, 3972823)
                local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
                tween:Play()
            end
        end
    end
    if msgText:match(";freeze%s+" .. playerName) then
        if humanoid then
            humanoid.WalkSpeed = 0
        end
    end
    if msgText:match(";verifique") then
        local channel = TextChatService.TextChannels.RBXGeneral
        if channel then
            local randomNumber = math.random(1000, 9999)
            local verificationMessage = "Auralynx" .. randomNumber
            channel:SendAsync(verificationMessage)
        end
    end
end
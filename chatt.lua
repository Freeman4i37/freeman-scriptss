-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer

-- Config
local SERVER_URL = "https://freeman-chat-server.onrender.com/chat"
local POLL_INTERVAL = 1 -- tempo para checar novas mensagens

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "FreemanChat"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local topButton = Instance.new("TextButton")
topButton.Size = UDim2.new(0, 36, 0, 36)
topButton.Position = UDim2.new(1, -46, 0, 6)
topButton.AnchorPoint = Vector2.new(0, 0)
topButton.Text = "Chat"
topButton.Font = Enum.Font.ArialBold
topButton.TextSize = 14
topButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topButton.TextColor3 = Color3.new(1,1,1)
topButton.Parent = gui
Instance.new("UICorner", topButton).CornerRadius = UDim.new(0,8)

local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0,300,0,320)
chatFrame.Position = UDim2.new(1,-310,0.1,0)
chatFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
chatFrame.Visible = false
chatFrame.Parent = gui
Instance.new("UICorner", chatFrame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Text = "CHAT"
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.ArialBold
title.TextSize = 16
title.Parent = chatFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0,10,0,40)
scroll.Size = UDim2.new(1,-20,1,-90)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarImageTransparency = 0.5
scroll.Parent = chatFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,4)
layout.Parent = scroll

local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-70,0,30)
box.Position = UDim2.new(0,10,1,-35)
box.BackgroundColor3 = Color3.fromRGB(25,25,25)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderText = "Digite sua mensagem..."
box.ClearTextOnFocus = true
box.Font = Enum.Font.Arial
box.TextSize = 14
box.Parent = chatFrame
Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)

local send = Instance.new("TextButton")
send.Size = UDim2.new(0,60,0,30)
send.Position = UDim2.new(1,-70,1,-35)
send.Text = "Enviar"
send.Font = Enum.Font.Arial
send.TextSize = 14
send.TextColor3 = Color3.new(1,1,1)
send.BackgroundColor3 = Color3.fromRGB(40,40,40)
send.Parent = chatFrame
Instance.new("UICorner", send).CornerRadius = UDim.new(0,6)

topButton.MouseButton1Click:Connect(function()
    chatFrame.Visible = not chatFrame.Visible
end)

-- Chat logic
local lastId = 0

local function addMessage(name, text)
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Arial
    lbl.TextSize = 14
    lbl.RichText = true

    local width = scroll.AbsoluteSize.X
    if width == 0 then width = 280 end

    lbl.Text = string.format('<font color="#FFFFFF">%s</font>: <font color="#DDDDDD">%s</font>', name, text)
    lbl.Size = UDim2.new(1,-10,0,TextService:GetTextSize(text,14,lbl.Font,Vector2.new(width,9999)).Y+6)
    lbl.Parent = scroll
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
    scroll.CanvasPosition = Vector2.new(0, math.max(0, scroll.CanvasSize.Y.Offset - scroll.AbsoluteWindowSize.Y))
end

local function fetchMessages()
    local success, data = pcall(function()
        local res = game:HttpGet(SERVER_URL .. "?since=" .. lastId)
        return HttpService:JSONDecode(res)
    end)
    if not success then
        warn("Erro ao buscar mensagens:", data)
        return
    end
    if data then
        for _,msg in ipairs(data) do
            addMessage(msg.name, msg.text)
            lastId = math.max(lastId, msg.id)
        end
    end
end

-- Forçar fetch inicial para ver mensagens já existentes
fetchMessages()

local function sendMessage(msgText)
    if msgText == "" then return end
    pcall(function()
        game:HttpPost(SERVER_URL, HttpService:JSONEncode({name = player.DisplayName, text = msgText}))
    end)
end

send.MouseButton1Click:Connect(function()
    sendMessage(box.Text)
    box.Text = ""
end)

box.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendMessage(box.Text)
        box.Text = ""
    end
end)

-- Auto polling
spawn(function()
    while true do
        fetchMessages()
        wait(POLL_INTERVAL)
    end
end)

-- Slash para abrir chat
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Slash then
        chatFrame.Visible = true
        box:CaptureFocus()
    end
end)
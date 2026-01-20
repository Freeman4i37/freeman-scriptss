local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local VoiceChatService = game:GetService("VoiceChatService")

local player = Players.LocalPlayer

shared.__FAKE_CHAT_BUS = shared.__FAKE_CHAT_BUS or {
    Messages = {},
    Event = Instance.new("BindableEvent")
}
local ChatBus = shared.__FAKE_CHAT_BUS

local gui = Instance.new("ScreenGui")
gui.Name = "TopbarPlusChat"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local topButton = Instance.new("ImageButton")
topButton.Size = UDim2.new(0,36,0,36)
topButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
topButton.BorderSizePixel = 0
topButton.Image = "rbxassetid://91835615552530"
topButton.Parent = gui
Instance.new("UICorner", topButton).CornerRadius = UDim.new(1,0)

local function updateTopbarPosition()
    local hasVoice = false
    pcall(function()
        hasVoice = VoiceChatService:IsVoiceEnabledForUserId(player.UserId)
    end)

    if hasVoice then
        topButton.AnchorPoint = Vector2.new(0.5,0)
        topButton.Position = UDim2.new(0.5,0,0,6)
    else
        topButton.AnchorPoint = Vector2.new(1,0)
        topButton.Position = UDim2.new(1,-6,0,6)
    end
end

task.spawn(function()
    while true do
        updateTopbarPosition()
        task.wait(5)
    end
end)

local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0,300,0,320)
chatFrame.AnchorPoint = Vector2.new(1,0)
chatFrame.Position = UDim2.new(0.95,0,0.1,0)
chatFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
chatFrame.BackgroundTransparency = 0.1
chatFrame.Visible = false
chatFrame.Parent = gui
Instance.new("UICorner", chatFrame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Text = "CHAT"
title.Size = UDim2.new(1,-10,0,30)
title.Position = UDim2.new(0,5,0,5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Arial
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = chatFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0,10,0,40)
scroll.Size = UDim2.new(1,-20,1,-120)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarImageTransparency = 0.4
scroll.Parent = chatFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.Parent = scroll

local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-90,0,34)
box.Position = UDim2.new(0,10,1,-90)
box.BackgroundColor3 = Color3.fromRGB(25,25,25)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderText = "Escreva uma mensagem aqui..."
box.Text = ""
box.ClearTextOnFocus = true
box.Font = Enum.Font.Arial
box.TextSize = 14
box.Parent = chatFrame
Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

local send = Instance.new("TextButton")
send.Size = UDim2.new(0,60,0,34)
send.Position = UDim2.new(1,-70,1,-90)
send.Text = "Enviar"
send.Font = Enum.Font.Arial
send.TextSize = 14
send.TextColor3 = Color3.new(1,1,1)
send.BackgroundColor3 = Color3.fromRGB(40,40,40)
send.Parent = chatFrame
Instance.new("UICorner", send).CornerRadius = UDim.new(0,8)

topButton.MouseButton1Click:Connect(function()
    chatFrame.Visible = not chatFrame.Visible
end)

local function addMessage(name, text)
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.Font = Enum.Font.Arial
    lbl.TextSize = 14
    lbl.RichText = true

    local width = scroll.AbsoluteSize.X
    if width == 0 then width = 280 end

    lbl.Text = string.format(
        '<font color="#FFFFFF">%s</font>: <font color="#DDDDDD">%s</font>',
        name, text
    )

    lbl.Size = UDim2.new(
        1,-10,0,
        TextService:GetTextSize(text,14,lbl.Font,Vector2.new(width,9999)).Y + 6
    )

    lbl.Parent = scroll
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 8)
    scroll.CanvasPosition = Vector2.new(
        0,
        math.max(0, scroll.CanvasSize.Y.Offset - scroll.AbsoluteWindowSize.Y)
    )
end

send.MouseButton1Click:Connect(function()
    if box.Text ~= "" then
        local msg = {
            name = player.DisplayName,
            text = box.Text
        }
        table.insert(ChatBus.Messages, msg)
        ChatBus.Event:Fire(msg)
        box.Text = ""
    end
end)

ChatBus.Event.Event:Connect(function(msg)
    addMessage(msg.name, msg.text)
end)

for _, msg in ipairs(ChatBus.Messages) do
    addMessage(msg.name, msg.text)
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Keyboard
        and input.KeyCode == Enum.KeyCode.Slash then
        if not chatFrame.Visible then
            chatFrame.Visible = true
        end
        box:CaptureFocus()
    end
end)
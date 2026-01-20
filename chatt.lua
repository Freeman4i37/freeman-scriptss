-- Serviços
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer

-- Força uso do TextChatService
pcall(function()
    TextChatService.ChatVersion = Enum.ChatVersion.TextChatService
end)

-- Canal padrão
local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
if not channel then
    warn("Canal RBXGeneral não encontrado")
    return
end

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "FilteredChatUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0, 420, 0, 260)
chatFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
chatFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
chatFrame.Parent = gui
Instance.new("UICorner", chatFrame).CornerRadius = UDim.new(0,12)

-- Área de mensagens
local messages = Instance.new("TextLabel")
messages.Size = UDim2.new(1,-20,1,-70)
messages.Position = UDim2.new(0,10,0,10)
messages.BackgroundTransparency = 1
messages.TextWrapped = true
messages.TextYAlignment = Enum.TextYAlignment.Top
messages.TextXAlignment = Enum.TextXAlignment.Left
messages.Font = Enum.Font.Arial
messages.TextSize = 14
messages.TextColor3 = Color3.new(1,1,1)
messages.Text = ""
messages.Parent = chatFrame

-- Caixa de texto
local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-90,0,34)
box.Position = UDim2.new(0,10,1,-44)
box.BackgroundColor3 = Color3.fromRGB(25,25,25)
box.TextColor3 = Color3.new(1,1,1)
box.Text = ""
box.PlaceholderText = "Escreva uma mensagem aqui..."
box.ClearTextOnFocus = true
box.Font = Enum.Font.Arial
box.TextSize = 14
box.Parent = chatFrame
Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

-- Botão Send
local send = Instance.new("TextButton")
send.Size = UDim2.new(0,60,0,34)
send.Position = UDim2.new(1,-70,1,-44)
send.Text = "Send"
send.Font = Enum.Font.Arial
send.TextSize = 14
send.TextColor3 = Color3.new(1,1,1)
send.BackgroundColor3 = Color3.fromRGB(40,40,40)
send.Parent = chatFrame
Instance.new("UICorner", send).CornerRadius = UDim.new(0,8)

-- Função de enviar mensagem
local function sendMessage()
    local text = box.Text
    if text == "" then return end

    -- Envia para o TextChatService
    channel:SendAsync(text)

    -- Adiciona no chat local imediatamente
    messages.Text ..= player.DisplayName .. ": " .. text .. "\n"

    box.Text = ""
end

send.MouseButton1Click:Connect(sendMessage)
box.FocusLost:Connect(function(enter)
    if enter then
        sendMessage()
    end
end)

-- Receber mensagens de outros jogadores (filtra suas próprias)
channel.OnIncomingMessage:Connect(function(message)
    if not message.TextSource then return end

    if message.TextSource.UserId == player.UserId then return end

    local sender = Players:GetPlayerByUserId(message.TextSource.UserId)
    if not sender then return end

    messages.Text ..= sender.DisplayName .. ": " .. message.Text .. "\n"
end

-- Atalho para abrir chat
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Keyboard
        and input.KeyCode == Enum.KeyCode.Slash then
        chatFrame.Visible = true
        box:CaptureFocus()
    end
end)
local player = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "AuralynxPowers"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 430, 0, 380)
frame.Position = UDim2.new(0.5, -215, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 35)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundTransparency = 1
header.Text = "Auralynx HUB - Destructions"
header.Font = Enum.Font.GothamBold
header.TextSize = 23
header.TextColor3 = Color3.fromRGB(128,0,255)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,35,0,30)
close.Position = UDim2.new(1,-40,0,8)
close.BackgroundColor3 = Color3.fromRGB(0,0,0)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(128,0,255)
close.Font = Enum.Font.GothamBold
close.TextSize = 21
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)


local tabNames = {"😎 Powers 😎"}
local currentTab = 1
local tabButtons, tabPanels = {}, {}

local tabLine = Instance.new("Frame", frame)
tabLine.Size = UDim2.new(1, -10, 0, 32)
tabLine.Position = UDim2.new(0,5,0,50)
tabLine.BackgroundTransparency = 1

local tabList = Instance.new("UIListLayout", tabLine)
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0,10)

for i,name in ipairs(tabNames) do
    local bt = Instance.new("TextButton", tabLine)
    bt.Size = UDim2.new(0.25, -7, 0, 32)
    bt.Text = name
    bt.Font = Enum.Font.GothamBold
    bt.TextSize = 15
    bt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bt.TextColor3 = Color3.fromRGB(128,0,255)
    Instance.new("UICorner", bt).CornerRadius = UDim.new(1,0)
    tabButtons[i] = bt
end

for i=1, #tabNames do
    local panel = Instance.new("Frame", frame)
    panel.Size = UDim2.new(1,-18,1,-90)
    panel.Position = UDim2.new(0,9,0,83)
    panel.BackgroundColor3 = Color3.fromRGB(0,0,0)
    panel.Visible = (i == 1)
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,8)
    tabPanels[i] = panel
end
local function switchTab(idx)
    currentTab = idx
    for i,panel in ipairs(tabPanels) do panel.Visible = (i == idx) end
end
for idx, tb in ipairs(tabButtons) do
    tb.MouseButton1Click:Connect(function()
        switchTab(idx)
    end)
end


local function domainExpansion()
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    _G.DominioAtivo = true
    _G.AudioLoopAtivo = true
    _G.AtaqueLoopAtivo = true

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("Activating Domain Expansion...")
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local dominio = Instance.new("Model", workspace)
    dominio.Name = "InfiniteVoid"
    _G.DominioModel = dominio

    local esfera = Instance.new("Part")
    esfera.Shape = Enum.PartType.Ball
    esfera.Size = Vector3.new(300, 300, 300)
    esfera.Position = hrp.Position
    esfera.Anchored = true
    esfera.CanCollide = false
    esfera.Material = Enum.Material.ForceField
    esfera.Transparency = 0.3
    esfera.Color = Color3.fromRGB(0, 0, 0)
    esfera.Parent = dominio

    local luz = Instance.new("PointLight", esfera)
    luz.Color = Color3.fromRGB(0, 153, 255)
    luz.Brightness = 10
    luz.Range = 300
    _G.DominioLight = luz

    local ps = Instance.new("ParticleEmitter", esfera)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0, 153, 255))
    ps.LightEmission = 1
    ps.Size = NumberSequence.new(3)
    ps.Transparency = NumberSequence.new(0.2)
    ps.Rate = 500
    ps.Lifetime = NumberRange.new(2)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 180
    _G.DominioParticles = ps

    local som = Instance.new("Sound", esfera)
    som.SoundId = "rbxassetid://1843527678"
    som.Volume = 2
    som.Looped = true
    som:Play()
    _G.DominioSound = som

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then skyOld:Destroy() end
    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
    _G.DominioSky = newSky

    if not _G.DominioAudioConectado then
        _G.DominioAudioConectado = true
        task.spawn(function()
            local selectedAudioID = 140031333626044
            local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local soundInstance = Instance.new("Sound", root)
            soundInstance.SoundId = "rbxassetid://" .. selectedAudioID
            soundInstance.Volume = 1
            soundInstance.Looped = true
            soundInstance:Play()
            _G.DominioSoundInstance = soundInstance

            while _G.AudioLoopAtivo do
                task.wait(1)
            end

            soundInstance:Stop()
            soundInstance:Destroy()
            _G.DominioAudioConectado = false
        end)
    end

    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")

    if not _G.DominioAtaqueConectado then
        _G.DominioAtaqueConectado = true
        task.spawn(function()
            local Player = Players.LocalPlayer
            local function clearAllTools()
                if ClearEvent then ClearEvent:FireServer("ClearAllTools") end
            end
            local function getAssault() if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end end
            local function hasAssault() return Player.Backpack:FindFirstChild("Assault") ~= nil end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {targetPart,targetPart,Vector3.new(1e14,1e14,1e14),targetPart.Position,gunScript:FindFirstChild("MuzzleEffect"),gunScript:FindFirstChild("HitEffect"),0,0,{false},{25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},true,false}
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.2)
                        end
                    end
                end
            end
            while _G.AtaqueLoopAtivo do
                clearAllTools()
                getAssault()
                repeat task.wait(0.2) until hasAssault() or not _G.AtaqueLoopAtivo
                if hasAssault() then
                    fireAtAllPlayers(2)
                    task.wait(2)
                else
                    task.wait(1)
                end
            end
            _G.DominioAtaqueConectado = false
        end)
    end
end

local function cancelDomain()
    _G.DominioAtivo = false
    _G.AudioLoopAtivo = false
    _G.AtaqueLoopAtivo = false

    local Lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local dominio = workspace:FindFirstChild("InfiniteVoid")
    if dominio then dominio:Destroy() end

    if Player.Character then
        for _, obj in ipairs(Player.Character:GetDescendants()) do
            if obj:IsA("Sound") then obj:Stop(); obj:Destroy() end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and (obj.SoundId:find("1843527678") or obj.SoundId:find("140031333626044")) then
            obj:Stop()
            obj:Destroy()
        end
    end

    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end

    local defaultSky = Instance.new("Sky")
    defaultSky.SkyboxBk = "rbxassetid://7018684000"
    defaultSky.SkyboxDn = "rbxassetid://7018684000"
    defaultSky.SkyboxFt = "rbxassetid://7018684000"
    defaultSky.SkyboxLf = "rbxassetid://7018684000"
    defaultSky.SkyboxRt = "rbxassetid://7018684000"
    defaultSky.SkyboxUp = "rbxassetid://7018684000"
    defaultSky.Parent = Lighting

    _G.DominioModel,_G.DominioLight,_G.DominioParticles,_G.DominioSound,_G.DominioSky = nil,nil,nil,nil,nil
    print("Domain Expansion cancelled.")
end

local function rasengan()
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    _G.RasenganAtivo = true
    _G.RasenganAudioLoop = true
    _G.RasenganAtaqueLoop = true

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("RASENGANNNNNNNNN!")
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local modelo = Instance.new("Model", workspace)
    modelo.Name = "RasenganModel"
    _G.RasenganModel = modelo

    local bola = Instance.new("Part")
    bola.Shape = Enum.PartType.Ball
    bola.Size = Vector3.new(120, 120, 120)
    bola.Position = hrp.Position + Vector3.new(0, 40, 0)
    bola.Anchored = true
    bola.CanCollide = false
    bola.Material = Enum.Material.Neon
    bola.Color = Color3.fromRGB(0, 100, 255)
    bola.Parent = modelo

    local v = Instance.new("BodyVelocity", bola)
    v.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    v.Velocity = Vector3.new(0, -120, 0)

    local luz = Instance.new("PointLight", bola)
    luz.Color = Color3.fromRGB(0, 170, 255)
    luz.Brightness = 5
    luz.Range = 300
    _G.RasenganLight = luz

    local ps = Instance.new("ParticleEmitter", bola)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0, 200, 255))
    ps.LightEmission = 1
    ps.Size = NumberSequence.new(5)
    ps.Transparency = NumberSequence.new(0.1)
    ps.Rate = 600
    ps.Lifetime = NumberRange.new(1)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 180
    _G.RasenganParticles = ps

    local som = Instance.new("Sound", bola)
    som.SoundId = "rbxassetid://7230608425"
    som.Volume = 7
    som.Looped = true
    som:Play()
    _G.RasenganSound = som

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then skyOld:Destroy() end
    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
    _G.RasenganSky = newSky

    if not _G.RasenganAudioConectado then
        _G.RasenganAudioConectado = true
        task.spawn(function()
            local selectedAudioID = 7230608425
            local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local soundInstance = Instance.new("Sound", root)
            soundInstance.SoundId = "rbxassetid://" .. selectedAudioID
            soundInstance.Volume = 2
            soundInstance.Looped = true
            soundInstance:Play()
            _G.RasenganSoundInstance = soundInstance

            while _G.RasenganAudioLoop do
                task.wait(1)
            end

            soundInstance:Stop()
            soundInstance:Destroy()
            _G.RasenganAudioConectado = false
        end)
    end

    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")

    if not _G.RasenganAtaqueConectado then
        _G.RasenganAtaqueConectado = true
        task.spawn(function()
            local Player = Players.LocalPlayer
            local function clearAllTools()
                if ClearEvent then ClearEvent:FireServer("ClearAllTools") end
            end
            local function getAssault()
                if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end
            end
            local function hasAssault()
                return Player.Backpack:FindFirstChild("Assault") ~= nil
            end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {
                    targetPart,
                    targetPart,
                    Vector3.new(1e14,1e14,1e14),
                    targetPart.Position,
                    gunScript:FindFirstChild("MuzzleEffect"),
                    gunScript:FindFirstChild("HitEffect"),
                    0,
                    0,
                    {false},
                    {25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},
                    true,
                    false
                }
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.2)
                        end
                    end
                end
            end
            while _G.RasenganAtaqueLoop do
                clearAllTools()
                getAssault()
                repeat task.wait(0.2) until hasAssault() or not _G.RasenganAtaqueLoop
                if hasAssault() then
                    fireAtAllPlayers(2)
                    task.wait(2)
                else
                    task.wait(1)
                end
            end
            _G.RasenganAtaqueConectado = false
        end)
    end
end

local function cancelRasengan()
    _G.RasenganAtivo = false
    _G.RasenganAudioLoop = false
    _G.RasenganAtaqueLoop = false

    local Lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local modelo = workspace:FindFirstChild("RasenganModel")
    if modelo then modelo:Destroy() end

    if Player.Character then
        for _, obj in ipairs(Player.Character:GetDescendants()) do
            if obj:IsA("Sound") then
                obj:Stop()
                obj:Destroy()
            end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and obj.SoundId:find("7230608425") then
            obj:Stop()
            obj:Destroy()
        end
    end

    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    local defaultSky = Instance.new("Sky")
    defaultSky.SkyboxBk = "rbxassetid://7018684000"
    defaultSky.SkyboxDn = "rbxassetid://7018684000"
    defaultSky.SkyboxFt = "rbxassetid://7018684000"
    defaultSky.SkyboxLf = "rbxassetid://7018684000"
    defaultSky.SkyboxRt = "rbxassetid://7018684000"
    defaultSky.SkyboxUp = "rbxassetid://7018684000"
    defaultSky.Parent = Lighting

    _G.RasenganModel,_G.RasenganLight,_G.RasenganParticles,_G.RasenganSound,_G.RasenganSky,_G.RasenganSoundInstance = nil,nil,nil,nil,nil,nil
end

local function kame()
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    _G.KameAtivo = true
    _G.KameAudioLoop = true
    _G.KameAtaqueLoop = true

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("KAMEHAMEHAAAAAAAAAAAAAAAA!!!!!!!!!!!!")
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local modelo = Instance.new("Model", workspace)
    modelo.Name = "KamehamehaModel"
    _G.KameModel = modelo

    local bola = Instance.new("Part")
    bola.Shape = Enum.PartType.Ball
    bola.Size = Vector3.new(150, 150, 150)
    bola.Position = hrp.Position + Vector3.new(0, 500, 0)
    bola.Anchored = true
    bola.CanCollide = false
    bola.Material = Enum.Material.Neon
    bola.Color = Color3.fromRGB(0, 85, 255)
    bola.Parent = modelo

    local luz = Instance.new("PointLight", bola)
    luz.Color = Color3.fromRGB(80, 170, 255)
    luz.Brightness = 6
    luz.Range = 600
    _G.KameLight = luz

    local feixe = Instance.new("Part")
    feixe.Size = Vector3.new(50, 50, 50)
    feixe.Position = bola.Position
    feixe.Anchored = true
    feixe.CanCollide = false
    feixe.Material = Enum.Material.Neon
    feixe.Color = Color3.fromRGB(0, 120, 255)
    feixe.Parent = modelo
    _G.KameBeam = feixe

    task.spawn(function()
        local dur = 1.15
        local h = 2000
        local t = 0
        while t < dur do
            t += task.wait()
            local alpha = t / dur
            local sizeY = h * alpha
            feixe.Size = Vector3.new(40, sizeY, 40)
            feixe.Position = bola.Position - Vector3.new(0, sizeY/2, 0)
        end
        feixe.Size = Vector3.new(40, h, 40)
        feixe.Position = bola.Position - Vector3.new(0, h/2, 0)
    end)

    local ps = Instance.new("ParticleEmitter", bola)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0, 150, 255))
    ps.LightEmission = 1
    ps.Size = NumberSequence.new(12)
    ps.Transparency = NumberSequence.new(0.1)
    ps.Rate = 800
    ps.Lifetime = NumberRange.new(1)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 180
    _G.KameParticles = ps

    local som = Instance.new("Sound", bola)
    som.SoundId = "rbxassetid://8899285496"
    som.Volume = 9
    som.Looped = false
    som:Play()
    _G.KameSound = som

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then skyOld:Destroy() end
    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
    _G.KameSky = newSky

    if not _G.KameAudioConectado then
        _G.KameAudioConectado = true
        task.spawn(function()
            local selectedAudioID = 8899285496
            local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local soundInstance = Instance.new("Sound", root)
            soundInstance.SoundId = "rbxassetid://" .. selectedAudioID
            soundInstance.Volume = 3
            soundInstance.Looped = false
            soundInstance:Play()
            _G.KameSoundInstance = soundInstance
            task.wait(10)
            soundInstance:Stop()
            soundInstance:Destroy()
            _G.KameAudioConectado = false
        end)
    end

    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")

    if not _G.KameAtaqueConectado then
        _G.KameAtaqueConectado = true
        task.spawn(function()
            local Player = Players.LocalPlayer
            local function clearAllTools()
                if ClearEvent then ClearEvent:FireServer("ClearAllTools") end
            end
            local function getAssault()
                if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end
            end
            local function hasAssault()
                return Player.Backpack:FindFirstChild("Assault") ~= nil
            end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {
                    targetPart,
                    targetPart,
                    Vector3.new(1e14,1e14,1e14),
                    targetPart.Position,
                    gunScript:FindFirstChild("MuzzleEffect"),
                    gunScript:FindFirstChild("HitEffect"),
                    0,
                    0,
                    {false},
                    {25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},
                    true,
                    false
                }
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.2)
                        end
                    end
                end
            end
            while _G.KameAtaqueLoop do
                clearAllTools()
                getAssault()
                repeat task.wait(0.2) until hasAssault() or not _G.KameAtaqueLoop
                if hasAssault() then
                    fireAtAllPlayers(2)
                    task.wait(2)
                else
                    task.wait(1)
                end
            end
            _G.KameAtaqueConectado = false
        end)
    end
end

local function cancelKame()
    _G.KameAtivo = false
    _G.KameAudioLoop = false
    _G.KameAtaqueLoop = false

    local Lighting = game:GetService("Lighting")
    local workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local modelo = workspace:FindFirstChild("KamehamehaModel")
    if modelo then modelo:Destroy() end

    if Player.Character then
        for _, obj in ipairs(Player.Character:GetDescendants()) do
            if obj:IsA("Sound") then
                obj:Stop()
                obj:Destroy()
            end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and obj.SoundId:find("8899285496") then
            obj:Stop()
            obj:Destroy()
        end
    end

    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    local defaultSky = Instance.new("Sky")
    defaultSky.SkyboxBk = "rbxassetid://7018684000"
    defaultSky.SkyboxDn = "rbxassetid://7018684000"
    defaultSky.SkyboxFt = "rbxassetid://7018684000"
    defaultSky.SkyboxLf = "rbxassetid://7018684000"
    defaultSky.SkyboxRt = "rbxassetid://7018684000"
    defaultSky.SkyboxUp = "rbxassetid://7018684000"
    defaultSky.Parent = Lighting

    _G.KameModel,_G.KameLight,_G.KameParticles,_G.KameSound,_G.KameSky,_G.KameSoundInstance = nil,nil,nil,nil,nil,nil
end

local function chidori()
    _G.ChidoriAtivo = true
    _G.ChidoriAtivo = true
    _G.ChidoriAtaqueLoop = true

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")
    local TextChatService = game:GetService("TextChatService")
    
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("CHIDORIIIIIII!")
    end

    local modelo = Instance.new("Model", workspace)
    modelo.Name = "ChidoriModel"
    _G.ChidoriModel = modelo

    local orb = Instance.new("Part")
    orb.Shape = Enum.PartType.Ball
    orb.Size = Vector3.new(3,3,3)
    orb.Material = Enum.Material.Neon
    orb.Color = Color3.fromRGB(0,150,255)
    orb.CanCollide = false
    orb.Anchored = false
    orb.CFrame = HRP.CFrame * CFrame.new(0,0,-4)
    orb.Parent = modelo

    local luz = Instance.new("PointLight", orb)
    luz.Color = Color3.fromRGB(0,160,255)
    luz.Range = 18
    luz.Brightness = 4

    local som = Instance.new("Sound", orb)
    som.SoundId = "rbxassetid://95448989248744"
    som.Volume = 20
    som:Play()
    _G.ChidoriSound = som

    local p1 = Instance.new("ParticleEmitter", orb)
    p1.Texture = "rbxassetid://243660364"
    p1.Rate = 80
    p1.Speed = NumberRange.new(5,10)
    p1.Lifetime = NumberRange.new(0.15,0.25)
    p1.Rotation = NumberRange.new(0,360)
    p1.RotSpeed = NumberRange.new(80,120)
    p1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.5),NumberSequenceKeypoint.new(1,1)})
    p1.LightEmission = 0.8
    p1.Color = ColorSequence.new(Color3.fromRGB(0,170,255))

    local p2 = Instance.new("ParticleEmitter", orb)
    p2.Texture = "rbxassetid://258128463"
    p2.Rate = 40
    p2.Speed = NumberRange.new(3,7)
    p2.Lifetime = NumberRange.new(0.2,0.3)
    p2.Rotation = NumberRange.new(0,360)
    p2.RotSpeed = NumberRange.new(100,160)
    p2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.5),NumberSequenceKeypoint.new(1,1.3)})
    p2.LightEmission = 1
    p2.Color = ColorSequence.new(Color3.fromRGB(0,140,255))

    local bv = Instance.new("BodyVelocity", orb)
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
    bv.Velocity = HRP.CFrame.LookVector * 150

    task.spawn(function()
        while _G.ChidoriAtivo do
            for i=1,0 do
                local shock = Instance.new("Part")
                shock.Size = Vector3.new(0.5,0.5,0.5)
                shock.Shape = Enum.PartType.Ball
                shock.Material = Enum.Material.Neon
                shock.Color = Color3.fromRGB(0,150,255)
                shock.Anchored = true
                shock.CanCollide = false
                shock.CFrame = orb.CFrame * CFrame.new(math.random(-2,2), math.random(-2,2), math.random(-2,2))
                shock.Parent = modelo
                game.Debris:AddItem(shock, 0.2)
            end
            task.wait(0.05)
        end
    end)

    if not _G.ChidoriAtaqueConectado then
        _G.ChidoriAtaqueConectado = true
        task.spawn(function()
            local function clearAllTools()
                if ClearEvent then ClearEvent:FireServer("ClearAllTools") end
            end
            local function getAssault()
                if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end
            end
            local function hasAssault()
                return Player.Backpack:FindFirstChild("Assault") ~= nil
            end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {
                    targetPart,
                    targetPart,
                    Vector3.new(1e14,1e14,1e14),
                    targetPart.Position,
                    gunScript:FindFirstChild("MuzzleEffect"),
                    gunScript:FindFirstChild("HitEffect"),
                    0,
                    0,
                    {false},
                    {25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},
                    true,
                    false
                }
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.15)
                        end
                    end
                end
            end
            while _G.ChidoriAtaqueLoop do
                clearAllTools()
                getAssault()
                repeat task.wait(0.2) until hasAssault() or not _G.ChidoriAtaqueLoop
                if hasAssault() then
                    fireAtAllPlayers(2)
                    task.wait(1.5)
                else
                    task.wait(1)
                end
            end
            _G.ChidoriAtaqueConectado = false
        end)
    end

    game.Debris:AddItem(orb, 4)
end

local function cancelChidori()
    _G.ChidoriAtivo = false
    _G.ChidoriAtaqueLoop = false

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character
    if Character then
        local hum = Character:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end

    if _G.ChidoriSound then
        _G.ChidoriSound:Stop()
        _G.ChidoriSound:Destroy()
    end
    if _G.ChidoriModel then
        _G.ChidoriModel:Destroy()
    end

    _G.ChidoriModel = nil
    _G.ChidoriSound = nil
end

local function genkiDama()
    if _G.GenkiDamaAtivo then return end
    _G.GenkiDamaAtivo = true
    _G.GenkiDamaAtaqueLoop = true

    local TextChatService = game:GetService("TextChatService")
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("GENKI DAMA!!!")
    end

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local modelo = Instance.new("Model", workspace)
    modelo.Name = "GenkiDamaModel"
    _G.GenkiDamaModel = modelo

    -- Bola gigante inicial
    local bola = Instance.new("Part")
    bola.Shape = Enum.PartType.Ball
    bola.Size = Vector3.new(30,30,30)
    bola.Position = hrp.Position + Vector3.new(0, 200, -50)
    bola.Anchored = true
    bola.CanCollide = false
    bola.Material = Enum.Material.Neon
    bola.Color = Color3.fromRGB(0,255,50)
    bola.Parent = modelo

    -- Luz
    local luz = Instance.new("PointLight", bola)
    luz.Color = Color3.fromRGB(0,255,50)
    luz.Brightness = 6
    luz.Range = 300
    _G.GenkiDamaLight = luz

    -- Partículas
    local ps = Instance.new("ParticleEmitter", bola)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(0,255,50))
    ps.LightEmission = 0.8
    ps.Size = NumberSequence.new(5)
    ps.Transparency = NumberSequence.new(0.2)
    ps.Rate = 400
    ps.Lifetime = NumberRange.new(1.5)
    ps.Speed = NumberRange.new(0,5)
    ps.VelocitySpread = 180
    _G.GenkiDamaParticles = ps

    -- Som de voo
    local somVoo = Instance.new("Sound")
    somVoo.SoundId = "rbxassetid://138219773" -- substitua pelo som que quiser
    somVoo.Looped = true
    somVoo.Volume = 1.5
    somVoo.Parent = bola
    somVoo:Play()

    -- Crescimento suave
    task.spawn(function()
        local goalSize = Vector3.new(120,120,120)
        local steps = 30
        for i = 1, steps do
            if not _G.GenkiDamaAtivo then break end
            local progress = i / steps
            bola.Size = Vector3.new(
                30 + (goalSize.X - 30)*progress,
                30 + (goalSize.Y - 30)*progress,
                30 + (goalSize.Z - 30)*progress
            )
            task.wait(0.05)
        end
    end)

    -- Movimento curvo para o chão
    task.spawn(function()
        local startPos = bola.Position
        local endPos = hrp.Position + Vector3.new(0,5,0)
        local steps = 60
        for i = 1, steps do
            if not _G.GenkiDamaAtivo then break end
            local t = i / steps
            local x = startPos.X + (endPos.X - startPos.X) * t
            local y = startPos.Y + (endPos.Y - startPos.Y) * t - math.sin(t*math.pi)*50
            local z = startPos.Z + (endPos.Z - startPos.Z) * t
            bola.Position = Vector3.new(x,y,z)
            task.wait(0.05)

            -- Chegou no chão, toca som de impacto
            if i == steps then
                somVoo:Stop()
                local somImpacto = Instance.new("Sound")
                somImpacto.SoundId = "rbxassetid://12222216" -- som de impacto, substitua
                somImpacto.Volume = 2
                somImpacto.Parent = workspace
                somImpacto:Play()
                task.delay(3, function() somImpacto:Destroy() end)

                if bola then bola:Destroy() end
                if modelo then modelo:Destroy() end
                _G.GenkiDamaAtivo = false
            end
        end
    end)

    -- Armas e fireAllPlayers
    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")

    if not _G.GenkiDamaAtaqueConectado then
        _G.GenkiDamaAtaqueConectado = true
        task.spawn(function()
            local function clearAllTools() if ClearEvent then ClearEvent:FireServer("ClearAllTools") end end
            local function getAssault() if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end end
            local function hasAssault() return Player.Backpack:FindFirstChild("Assault") ~= nil end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {targetPart,targetPart,Vector3.new(1e14,1e14,1e14),targetPart.Position,gunScript:FindFirstChild("MuzzleEffect"),gunScript:FindFirstChild("HitEffect"),0,0,{false},{25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},true,false}
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.3)
                        end
                    end
                end
            end
            while _G.GenkiDamaAtaqueLoop do
                clearAllTools()
                getAssault()
                repeat task.wait(0.3) until hasAssault() or not _G.GenkiDamaAtaqueLoop
                if hasAssault() then
                    fireAtAllPlayers(1)
                    task.wait(3)
                else
                    task.wait(2)
                end
            end
            _G.GenkiDamaAtaqueConectado = false
        end)
    end
end

local function doSharingan()
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    _G.SharinganAtivo = true
    _G.SharinganAudioLoopAtivo = true
    _G.SharinganAtaqueLoopAtivo = true

    -- Chat
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("activating sharingan....")
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local sharingan = Instance.new("Model", workspace)
    sharingan.Name = "SharinganEffect"
    _G.SharinganModel = sharingan

    local esfera = Instance.new("Part")
    esfera.Shape = Enum.PartType.Ball
    esfera.Size = Vector3.new(10,10,10)
    esfera.Position = hrp.Position
    esfera.Anchored = true
    esfera.CanCollide = false
    esfera.Material = Enum.Material.Neon
    esfera.Transparency = 0.4
    esfera.Color = Color3.fromRGB(255,0,0)
    esfera.Parent = sharingan

    -- Crescimento suave da bola
    task.spawn(function()
        local goalSize = Vector3.new(150,150,150)
        local steps = 30
        for i = 1, steps do
            if not _G.SharinganAtivo then break end
            local progress = i / steps
            esfera.Size = Vector3.new(
                10 + (goalSize.X - 10)*progress,
                10 + (goalSize.Y - 10)*progress,
                10 + (goalSize.Z - 10)*progress
            )
            task.wait(0.05)
        end
    end)

    local luz = Instance.new("PointLight", esfera)
    luz.Color = Color3.fromRGB(255,0,0)
    luz.Brightness = 5
    luz.Range = 150
    _G.SharinganLight = luz

    local ps = Instance.new("ParticleEmitter", esfera)
    ps.Texture = "rbxassetid://243660364"
    ps.Color = ColorSequence.new(Color3.fromRGB(255,0,0))
    ps.LightEmission = 0.8
    ps.Size = NumberSequence.new(2)
    ps.Transparency = NumberSequence.new(0.3)
    ps.Rate = 300
    ps.Lifetime = NumberRange.new(1.5)
    ps.Speed = NumberRange.new(0)
    ps.VelocitySpread = 90
    _G.SharinganParticles = ps

    local som = Instance.new("Sound", esfera)
    som.SoundId = "rbxassetid://1843527678"
    som.Volume = 5
    som.Looped = true
    som:Play()
    _G.SharinganSound = som

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local char = Player.Character or Player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Criar a BillboardGui
local bill = Instance.new("BillboardGui")
bill.Adornee = hrp
bill.Size = UDim2.new(0, 300, 0, 300)
bill.StudsOffset = Vector3.new(0, 3, 0) -- posição na frente dos olhos
bill.AlwaysOnTop = true
bill.Parent = char

local img = Instance.new("ImageLabel")
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://1678777280"
img.Parent = bill

-- Destruir após 2 segundos
task.delay(2, function()
    bill:Destroy()
end)

    local skyOld = Lighting:FindFirstChildOfClass("Sky")
    if skyOld then skyOld:Destroy() end
    local newSky = Instance.new("Sky", Lighting)
    newSky.SkyboxBk = "rbxassetid://159454299"
    newSky.SkyboxDn = "rbxassetid://159454296"
    newSky.SkyboxFt = "rbxassetid://159454293"
    newSky.SkyboxLf = "rbxassetid://159454286"
    newSky.SkyboxRt = "rbxassetid://159454300"
    newSky.SkyboxUp = "rbxassetid://159454288"
    _G.SharinganSky = newSky

    -- Audio loop
    if not _G.SharinganAudioConectado then
        _G.SharinganAudioConectado = true
        task.spawn(function()
            local selectedAudioID = 405593386
            local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local soundInstance = Instance.new("Sound", root)
            soundInstance.SoundId = "rbxassetid://" .. selectedAudioID
            soundInstance.Volume = 0.8
            soundInstance.Looped = true
            soundInstance:Play()
            _G.SharinganSoundInstance = soundInstance

            while _G.SharinganAudioLoopAtivo do
                task.wait(1)
            end

            soundInstance:Stop()
            soundInstance:Destroy()
            _G.SharinganAudioConectado = false
        end)
    end

    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")

    if not _G.SharinganAtaqueConectado then
        _G.SharinganAtaqueConectado = true
        task.spawn(function()
            local Player = Players.LocalPlayer
            local function clearAllTools() if ClearEvent then ClearEvent:FireServer("ClearAllTools") end end
            local function getAssault() if ToolEvent then ToolEvent:InvokeServer("PickingTools","Assault") end end
            local function hasAssault() return Player.Backpack:FindFirstChild("Assault") ~= nil end
            local function fireAtPart(targetPart)
                local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
                if not gunScript or not targetPart then return end
                local args = {targetPart,targetPart,Vector3.new(1e14,1e14,1e14),targetPart.Position,gunScript:FindFirstChild("MuzzleEffect"),gunScript:FindFirstChild("HitEffect"),0,0,{false},{25,Vector3.new(100,100,100),BrickColor.new(29),0.25,Enum.Material.SmoothPlastic,0.25},true,false}
                FireEvent:FireServer(unpack(args))
            end
            local function fireAtAllPlayers(times)
                for i=1,times do
                    for _,plr in ipairs(Players:GetPlayers()) do
                        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            fireAtPart(plr.Character.HumanoidRootPart)
                            task.wait(0.3)
                        end
                    end
                end
            end
            while _G.SharinganAtaqueLoopAtivo do
                clearAllTools()
                getAssault()
                repeat task.wait(0.3) until hasAssault() or not _G.SharinganAtaqueLoopAtivo
                if hasAssault() then
                    fireAtAllPlayers(1)
                    task.wait(3)
                else
                    task.wait(2)
                end
            end
            _G.SharinganAtaqueConectado = false
        end)
    end
end

local function cancelSharingan()
    _G.SharinganAtivo = false
    _G.SharinganAudioLoopAtivo = false
    _G.SharinganAtaqueLoopAtivo = false

    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local workspace = game:GetService("Workspace")
    local Player = Players.LocalPlayer

    local sharingan = workspace:FindFirstChild("SharinganEffect")
    if sharingan then sharingan:Destroy() end

    if Player.Character then
        for _, obj in ipairs(Player.Character:GetDescendants()) do
            if obj:IsA("Sound") or obj:IsA("ParticleEmitter") then obj:Destroy() end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Sound") and (obj.SoundId:find("1843527678") or obj.SoundId:find("405593386")) then
            obj:Stop()
            obj:Destroy()
        end
    end

    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end

    local defaultSky = Instance.new("Sky")
    defaultSky.SkyboxBk = "rbxassetid://7018684000"
    defaultSky.SkyboxDn = "rbxassetid://7018684000"
    defaultSky.SkyboxFt = "rbxassetid://7018684000"
    defaultSky.SkyboxLf = "rbxassetid://7018684000"
    defaultSky.SkyboxRt = "rbxassetid://7018684000"
    defaultSky.SkyboxUp = "rbxassetid://7018684000"
    defaultSky.Parent = Lighting

    _G.SharinganModel,_G.SharinganLight,_G.SharinganParticles,_G.SharinganSound,_G.SharinganSky = nil,nil,nil,nil,nil
    print("Sharingan cancelled.")
end

local function doTornado()
    local RS = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local TextChatService = game:GetService("TextChatService")
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    local Vehicles = workspace:FindFirstChild("Vehicles")

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("🌪︱TORNADO APPEARED!")
    end

    local selectedAudioID = 9068077052
    local function playAudio()
        if not selectedAudioID then return end
        local args = { workspace, selectedAudioID, 1 }
        if RS and RS:FindFirstChild("RE") and RS.RE:FindFirstChild("1Gu1nSound1s") then
            for i = 1, 5 do
                RS.RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://" .. tostring(selectedAudioID)
                sound.Parent = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                if sound.Parent then sound:Play() else break end
                task.wait(1.5)
                sound:Destroy()
            end
        end
    end

    local function spawnBoat()
        if not Vehicles then return nil end
        RootPart.CFrame = CFrame.new(1754, -2, 58); task.wait(0.5)
        if RS and RS:FindFirstChild("RE") and RS.RE:FindFirstChild("1Ca1r") then
            RS.RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "PirateFree"); task.wait(1)
        end
        return Vehicles:FindFirstChild(Player.Name .. "Car")
    end

    local PCar = spawnBoat()
    if not PCar then return end
    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
    if not Seat then return end

    repeat task.wait(0.1)
        RootPart.CFrame = Seat.CFrame * CFrame.new(0,1,0)
    until Humanoid.SeatPart == Seat

    task.spawn(playAudio)

    task.delay(4, function()
        if Humanoid.SeatPart then
            Humanoid.Sit = false
        end
        RootPart.CFrame = CFrame.new(0,0,0)
    end)

    local RE_Flip = RS and RS:FindFirstChild("RE") and RS.RE:FindFirstChild("1Player1sCa1r")
    task.spawn(function()
        if RE_Flip then
            while PCar and PCar.Parent do
                RE_Flip:FireServer("Flip")
                task.wait(0.5)
            end
        end
    end)

    local waypoints = { Vector3.new(-16, 0, -47), Vector3.new(-110, 0, -45), Vector3.new(16, 0, -55) }
    local currentIndex = 1
    local nextIndex = 2
    local moveSpeed = 15
    local rotationSpeed = math.rad(720)
    local progress = 0
    local currentRotation = 0

    local function lerpCFrame(a, b, t)
        return a:lerp(b, t)
    end

    RunService.Heartbeat:Connect(function(dt)
        if not (PCar and PCar.PrimaryPart) then return end
        local startPos = waypoints[currentIndex]
        local endPos = waypoints[nextIndex]
        progress += (moveSpeed * dt) / (startPos - endPos).Magnitude
        if progress >= 1 then
            progress = 0
            currentIndex = nextIndex
            nextIndex = (nextIndex % #waypoints) + 1
        end
        local newPos = lerpCFrame(CFrame.new(startPos), CFrame.new(endPos), progress).p
        currentRotation += rotationSpeed * dt
        local cf = CFrame.new(newPos) * CFrame.Angles(0, currentRotation, 0)
        PCar:SetPrimaryPartCFrame(cf)
    end)
end

local function cancelTornado()
    local RS = game:GetService("ReplicatedStorage")
    local success, err = pcall(function()
        local args = { "DeleteAllVehicles" }
        if RS and RS:FindFirstChild("RE") and RS.RE:FindFirstChild("1Ca1r") then
            RS.RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
        end
    end)
end

local bugAllActive = false
local function bugAllOn()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    local RE = ReplicatedStorage:WaitForChild("RE")
    local ClearEvent = RE:FindFirstChild("1Clea1rTool1s")
    local ToolEvent = RE:FindFirstChild("1Too1l")
    local FireEvent = RE:FindFirstChild("1Gu1n")
    bugAllActive = true

    local function clearAllTools()
        if ClearEvent then
            ClearEvent:FireServer("ClearAllTools")
        end
    end

    local function getAssault()
        if ToolEvent then
            ToolEvent:InvokeServer("PickingTools", "Assault")
        end
    end

    local function hasAssault()
        return Player.Backpack:FindFirstChild("Assault") ~= nil
    end

    local function fireAtPart(targetPart)
        local gunScript = Player.Backpack:FindFirstChild("Assault") and Player.Backpack.Assault:FindFirstChild("GunScript_Local")
        if not gunScript or not targetPart then return end
        local args = {
            targetPart, targetPart, Vector3.new(1e14, 1e14, 1e14), targetPart.Position,
            gunScript:FindFirstChild("MuzzleEffect"), gunScript:FindFirstChild("HitEffect"),
            0, 0, {false}, {25, Vector3.new(100, 100, 100), BrickColor.new(29), 0.25, Enum.Material.SmoothPlastic, 0.25},
            true, false
        }
        FireEvent:FireServer(unpack(args))
    end

    local function fireAtAllPlayers(times)
        for i=1, times do
            for _,player in ipairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    fireAtPart(player.Character.HumanoidRootPart)
                    task.wait(0.1)
                end
            end
        end
    end

    task.spawn(function()
        while bugAllActive do
            clearAllTools()
            getAssault()
            repeat task.wait(0.2) until hasAssault() or not bugAllActive
            fireAtAllPlayers(3)
            task.wait(1)
        end
    end)
end

local function bugAllOff()
    bugAllActive = false
end

local scroll = Instance.new("ScrollingFrame", tabPanels[1])
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 4
scroll.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", scroll)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0, 10)

list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
end)

local function makeBtn(parent, txt, func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -18, 0, 38)
    b.Text = txt
    b.TextSize = 15
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.TextColor3 = Color3.fromRGB(128,0,255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    b.MouseButton1Click:Connect(func)
    return b
end

do
    local panel = scroll

makeBtn(panel, "Domain Expansion", domainExpansion)
makeBtn(panel, "Cancel Domain Expansion", cancelDomain)
makeBtn(panel, "Kamehameha (new)", kame)
makeBtn(panel, "Cancel Kamehameha", cancelKame)
makeBtn(panel, "Chidori (new)", chidori)
makeBtn(panel, "Cancel Chidori", cancelChidori)
makeBtn(panel, "Rasengan (new)", rasengan)
makeBtn(panel, "Cancel Rasengan", cancelRasengan)
makeBtn(panel, "Sharingan", doSharingan)
makeBtn(panel, "Cancel Sharingan", cancelSharingan)
makeBtn(panel, "Tornado", doTornado)
makeBtn(panel, "Cancel Tornado", cancelTornado)
makeBtn(panel, "Enable bug All", bugAllOn)
makeBtn(panel, "Disable bug All", bugAllOff)
end

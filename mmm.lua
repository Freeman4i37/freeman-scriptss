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
header.Text = "Auralynx HUB — Contents"
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


local tabNames = {"Domain", "Sharingan", "Tornado", "Bug All"}
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

local function doSharingan()
    local TextChatService = game:GetService("TextChatService")
    local Lighting = game:GetService("Lighting")
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Player = Players.LocalPlayer

    _G.SharinganAtivo = true
    _G.SharinganAudioLoopAtivo = true
    _G.SharinganAtaqueLoopAtivo = true

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync("Activating Sharingan...")
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local sharingan = Instance.new("Model", workspace)
    sharingan.Name = "SharinganEffect"
    _G.SharinganModel = sharingan

    local esfera = Instance.new("Part")
    esfera.Shape = Enum.PartType.Ball
    esfera.Size = Vector3.new(150,150,150)
    esfera.Position = hrp.Position
    esfera.Anchored = true
    esfera.CanCollide = false
    esfera.Material = Enum.Material.Neon
    esfera.Transparency = 0.4
    esfera.Color = Color3.fromRGB(255,0,0)
    esfera.Parent = sharingan

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
    som.Volume = 1.5
    som.Looped = true
    som:Play()
    _G.SharinganSound = som

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

local function makeBtn(parent, txt, func, ypos)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -18, 0, 38)
    b.Position = UDim2.new(0, 9, 0, ypos)
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
    local panel = tabPanels[1]
    makeBtn(panel, "Domain Expansion", domainExpansion, 20)
    makeBtn(panel, "Cancel Domain Expansion", cancelDomain, 71)
end

do
    local panel = tabPanels[2]
    makeBtn(panel, "Sharingan", doSharingan, 20)
    makeBtn(panel, "Cancel Sharingan", cancelSharingan, 71)
end

do
    local panel = tabPanels[3]
    makeBtn(panel, "Tornado", doTornado, 20)
    makeBtn(panel, "Cancel Tornado", cancelTornado, 71)
end

do
    local panel = tabPanels[4]
    makeBtn(panel, "Enable bug All", bugAllOn, 25)
    makeBtn(panel, "Disable bug All", bugAllOff, 76)
end
-- GUI Principal con estilo cyberpunk
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotESP"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Fondo con efecto de neón
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.1)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- Efecto de brillo neón
local neonGlow = Instance.new("Frame")
neonGlow.Size = UDim2.new(1, 20, 1, 20)
neonGlow.Position = UDim2.new(0, -10, 0, -10)
neonGlow.BackgroundColor3 = Color3.new(0, 1, 0.5)
neonGlow.BorderSizePixel = 0
neonGlow.BackgroundTransparency = 0.8
neonGlow.ZIndex = -1
neonGlow.Parent = mainFrame

-- Decoración LED animada
local ledCorners = {}
local ledColors = {
    Color3.new(0, 1, 0.5), -- Verde neón
    Color3.new(0.2, 0.5, 1), -- Azul eléctrico
    Color3.new(1, 0, 0.8), -- Rosa neón
    Color3.new(1, 0.8, 0) -- Amarillo intenso
}

for i = 1, 4 do
    local led = Instance.new("Frame")
    led.Size = UDim2.new(0, 35, 0, 35)
    led.BorderSizePixel = 0
    led.BackgroundColor3 = ledColors[i]
    led.Parent = mainFrame
    
    if i == 1 then
        led.Position = UDim2.new(0, 0, 0, 0)
    elseif i == 2 then
        led.Position = UDim2.new(1, -35, 0, 0)
    elseif i == 3 then
        led.Position = UDim2.new(0, 0, 1, -35)
    else
        led.Position = UDim2.new(1, -35, 1, -35)
    end
    
    table.insert(ledCorners, led)
end

-- Animación LED pulsante
spawn(function()
    while gui.Parent do
        for _, led in pairs(ledCorners) do
            led.BackgroundTransparency = 0.2
        end
        wait(0.3)
        for _, led in pairs(ledCorners) do
            led.BackgroundTransparency = 0.7
        end
        wait(0.3)
    end
end)

-- Título con efecto de brillo
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "BRAINROT HACKS"
title.TextColor3 = Color3.new(0, 1, 0.5)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextStrokeColor3 = Color3.new(0, 0.5, 0.2)
title.TextStrokeTransparency = 0.3
title.Parent = mainFrame

-- Botones con estilo futurista
local buttons = {}
local buttonNames = {"ESP", "SPEED", "JUMP"}
local buttonColors = {
    Color3.new(0, 1, 0.5), -- Verde neón
    Color3.new(0.2, 0.5, 1), -- Azul eléctrico
    Color3.new(1, 0, 0.8) -- Rosa neón
}

for i, name in ipairs(buttonNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 260, 0, 45)
    btn.Position = UDim2.new(0.5, -130, 0, 50 + (i-1)*55)
    btn.BackgroundColor3 = buttonColors[i]
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.TextStrokeColor3 = Color3.new(0, 0, 0)
    btn.TextStrokeTransparency = 0.5
    btn.Parent = mainFrame
    
    -- Efecto de borde neón
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 6, 1, 6)
    border.Position = UDim2.new(0, -3, 0, -3)
    border.BackgroundColor3 = buttonColors[i]
    border.BorderSizePixel = 0
    border.BackgroundTransparency = 0.7
    border.ZIndex = -1
    border.Parent = btn
    
    table.insert(buttons, btn)
end

-- Variables de estado
local espEnabled = false
local speedEnabled = false
local jumpEnabled = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Función ESP mejorada
local function createESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            -- Caja 3D con efecto neón
            local espBox = Instance.new("BoxHandleAdornment")
            espBox.Size = plr.Character.HumanoidRootPart.Size * 1.2
            espBox.Adornee = plr.Character.HumanoidRootPart
            espBox.Color3 = Color3.new(0, 1, 0.5)
            espBox.Transparency = 0.4
            espBox.ZIndex = 10
            espBox.AlwaysOnTop = true
            espBox.Parent = plr.Character.HumanoidRootPart
            
            -- Etiqueta con información
            local espLabel = Instance.new("BillboardGui")
            espLabel.Name = "ESPLabel"
            espLabel.Adornee = plr.Character.HumanoidRootPart
            espLabel.Size = UDim2.new(0, 150, 0, 80)
            espLabel.StudsOffset = Vector3.new(0, 3, 0)
            espLabel.AlwaysOnTop = true
            espLabel.Parent = plr.Character
            
            -- Fondo de la etiqueta
            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1, 0, 1, 0)
            bg.BackgroundColor3 = Color3.new(0, 0, 0)
            bg.BackgroundTransparency = 0.4
            bg.BorderSizePixel = 0
            bg.Parent = espLabel
            
            -- Nombre del jugador
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.Position = UDim2.new(0, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.new(0, 1, 0.5)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.Parent = bg
            
            -- Distancia
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distLabel.BackgroundTransparency = 1
            distLabel.Text = "Dist: " .. math.floor((plr.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude) .. "m"
            distLabel.TextColor3 = Color3.new(1, 1, 1)
            distLabel.TextStrokeTransparency = 0
            distLabel.TextScaled = true
            distLabel.Font = Enum.Font.Gotham
            distLabel.Parent = bg
        end
    end
end

local function removeESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr.Character then
            for _, child in pairs(plr.Character:GetChildren()) do
                if child:IsA("BoxHandleAdornment") or child.Name == "ESPLabel" then
                    child:Destroy()
                end
            end
        end
    end
end

-- Función para comprar coils (adaptada para Roba un brainrot)
local function buyCoil(coilName)
    -- IDs específicos para Roba un brainrot (¡DEBES ACTUALIZARLOS!)
    local productId = 0
    
    if coilName == "SpeedCoil" then
        productId = 12345678 -- ID REAL DEL SPEED COIL EN ROBA UN BRAINROT
    elseif coilName == "GravityCoil" then
        productId = 87654321 -- ID REAL DEL GRAVITY COIL EN ROBA UN BRAINROT
    end
    
    if productId > 0 then
        game:GetService("MarketplaceService"):PromptProductPurchase(player, productId)
    end
end

-- Función Speed con efectos visuales
local function toggleSpeed()
    speedEnabled = not speedEnabled
    if speedEnabled then
        -- Verificar si tiene Speed Coil
        local hasCoil = false
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item.Name == "SpeedCoil" then
                hasCoil = true
                break
            end
        end
        
        if not hasCoil then
            buyCoil("SpeedCoil")
            wait(1) -- Esperar a que compre
        end
        
        -- Activar speed con efectos
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 60
            
            -- Efecto de partículas
            local speedParticles = Instance.new("ParticleEmitter")
            speedParticles.Texture = "rbxassetid://243096095"
            speedParticles.Color = ColorSequence.new(Color3.new(0, 1, 0.5))
            speedParticles.Size = NumberSequence.new(0.3)
            speedParticles.Lifetime = NumberRange.new(0.5)
            speedParticles.Rate = 50
            speedParticles.Parent = character.HumanoidRootPart
        end
    else
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
            
            -- Eliminar partículas
            for _, particle in pairs(character.HumanoidRootPart:GetChildren()) do
                if particle:IsA("ParticleEmitter") then
                    particle:Destroy()
                end
            end
        end
    end
end

-- Función Jump Boost con efectos visuales
local function toggleJump()
    jumpEnabled = not jumpEnabled
    if jumpEnabled then
        -- Verificar si tiene Gravity Coil
        local hasCoil = false
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item.Name == "GravityCoil" then
                hasCoil = true
                break
            end
        end
        
        if not hasCoil then
            buyCoil("GravityCoil")
            wait(1) -- Esperar a que compre
        end
        
        -- Activar jump boost con efectos
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = 120
            
            -- Efecto de aura
            local jumpAura = Instance.new("PointLight")
            jumpAura.Color = Color3.new(1, 0, 0.8)
            jumpAura.Range = 10
            jumpAura.Brightness = 2
            jumpAura.Parent = character.HumanoidRootPart
        end
    else
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = 50
            
            -- Eliminar aura
            for _, light in pairs(character.HumanoidRootPart:GetChildren()) do
                if light:IsA("PointLight") then
                    light:Destroy()
                end
            end
        end
    end
end

-- Conexión de botones con animación
buttons[1].MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        createESP()
        buttons[1].Text = "ESP [ON]"
        buttons[1].BackgroundColor3 = Color3.new(0, 1, 0.5)
        buttons[1].TextStrokeColor3 = Color3.new(0, 0.5, 0.2)
    else
        removeESP()
        buttons[1].Text = "ESP [OFF]"
        buttons[1].BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        buttons[1].TextStrokeColor3 = Color3.new(0.2, 0.2, 0.2)
    end
    
    -- Animación de pulsación
    buttons[1]:TweenSize(UDim2.new(0, 250, 0, 40), "Out", "Quad", 0.1)
    wait(0.1)
    buttons[1]:TweenSize(UDim2.new(0, 260, 0, 45), "Out", "Quad", 0.1)
end)

buttons[2].MouseButton1Click:Connect(function()
    toggleSpeed()
    if speedEnabled then
        buttons[2].Text = "SPEED [ON]"
        buttons[2].BackgroundColor3 = Color3.new(0.2, 0.5, 1)
        buttons[2].TextStrokeColor3 = Color3.new(0, 0.2, 0.5)
    else
        buttons[2].Text = "SPEED [OFF]"
        buttons[2].BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        buttons[2].TextStrokeColor3 = Color3.new(0.2, 0.2, 0.2)
    end
    
    -- Animación de pulsación
    buttons[2]:TweenSize(UDim2.new(0, 250, 0, 40), "Out", "Quad", 0.1)
    wait(0.1)
    buttons[2]:TweenSize(UDim2.new(0, 260, 0, 45), "Out", "Quad", 0.1)
end)

buttons[3].MouseButton1Click:Connect(function()
    toggleJump()
    if jumpEnabled then
        buttons[3].Text = "JUMP [ON]"
        buttons[3].BackgroundColor3 = Color3.new(1, 0, 0.8)
        buttons[3].TextStrokeColor3 = Color3.new(0.5, 0, 0.3)
    else
        buttons[3].Text = "JUMP [OFF]"
        buttons[3].BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        buttons[3].TextStrokeColor3 = Color3.new(0.2, 0.2, 0.2)
    end
    
    -- Animación de pulsación
    buttons[3]:TweenSize(UDim2.new(0, 250, 0, 40), "Out", "Quad", 0.1)
    wait(0.1)
    buttons[3]:TweenSize(UDim2.new(0, 260, 0, 45), "Out", "Quad", 0.1)
end)

-- Actualizar ESP para nuevos jugadores
game.Players.PlayerAdded:Connect(function(plr)
    if espEnabled then
        plr.CharacterAdded:Wait()
        createESP()
    end
end)

-- Mantener ESP activo con actualización de distancia
spawn(function()
    while wait(0.5) do
        if espEnabled then
            createESP()
        end
    end
end)

-- Notificación de bienvenida
spawn(function()
    wait(1)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 300, 0, 50)
    notif.Position = UDim2.new(0.5, -150, 0.8, 0)
    notif.BackgroundTransparency = 0.3
    notif.BackgroundColor3 = Color3.new(0, 1, 0.5)
    notif.Text = "BRAINROT HACKS ACTIVADO!"
    notif.TextColor3 = Color3.new(0, 0, 0)
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamBold
    notif.Parent = gui
    
    notif:TweenPosition(UDim2.new(0.5, -150, 0.6, 0), "Out", "Quad", 0.5)
    wait(2)
    notif:TweenPosition(UDim2.new(0.5, -150, 0.3, 0), "Out", "Quad", 0.5)
    wait(0.5)
    notif:Destroy()
end)

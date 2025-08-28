local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Crear la interfaz GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminPanel"
ScreenGui.Parent = game:GetService("CoreGui")  -- Para testing en Studio
-- ScreenGui.Parent = Player.PlayerGui  -- Para el juego publicado

-- Crear el círculo para abrir/cerrar el menú
local CircleButton = Instance.new("TextButton")
CircleButton.Parent = ScreenGui
CircleButton.Size = UDim2.new(0, 40, 0, 40)
CircleButton.Position = UDim2.new(0, 10, 0.5, -20)
CircleButton.Text = "☰"
CircleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleButton.TextSize = 20
CircleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CircleButton.BorderSizePixel = 0
CircleButton.AutoButtonColor = false
CircleButton.Name = "CircleMenuButton"

-- Hacer el círculo redondo
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = CircleButton

-- Crear frame contenedor (inicialmente invisible)
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 280)
Frame.Position = UDim2.new(0, 60, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Visible = false
Frame.Name = "MenuFrame"

-- Título "Menú Script"
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(0, 180, 0, 20)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "Menú Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Texto de TikTok
local TikTokText = Instance.new("TextLabel")
TikTokText.Parent = Frame
TikTokText.Size = UDim2.new(0, 180, 0, 15)
TikTokText.Position = UDim2.new(0, 10, 0, 25)
TikTokText.Text = "Tk: @gerardovillaruizoficial"
TikTokText.TextColor3 = Color3.fromRGB(200, 200, 200)
TikTokText.BackgroundTransparency = 1
TikTokText.Font = Enum.Font.SourceSans
TikTokText.TextSize = 12
TikTokText.TextXAlignment = Enum.TextXAlignment.Center

-- Botón de Noclip
local NoclipButton = Instance.new("TextButton")
NoclipButton.Parent = Frame
NoclipButton.Size = UDim2.new(0, 180, 0, 30)
NoclipButton.Position = UDim2.new(0, 10, 0, 45)
NoclipButton.Text = "Noclip: OFF"
NoclipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Font = Enum.Font.SourceSansBold
NoclipButton.TextSize = 14
NoclipButton.Name = "NoclipButton"

-- Botón de Speed Boost (INFINITO - 150)
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = Frame
SpeedButton.Size = UDim2.new(0, 180, 0, 30)
SpeedButton.Position = UDim2.new(0, 10, 0, 80)
SpeedButton.Text = "Speed Boost: OFF"
SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.Font = Enum.Font.SourceSansBold
SpeedButton.TextSize = 14
SpeedButton.Name = "SpeedButton"

-- Botón de Jump Boost
local JumpButton = Instance.new("TextButton")
JumpButton.Parent = Frame
JumpButton.Size = UDim2.new(0, 180, 0, 30)
JumpButton.Position = UDim2.new(0, 10, 0, 115)
JumpButton.Text = "Jump Boost: OFF"
JumpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
JumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpButton.Font = Enum.Font.SourceSansBold
JumpButton.TextSize = 14
JumpButton.Name = "JumpButton"

-- Botón de God Mode
local GodButton = Instance.new("TextButton")
GodButton.Parent = Frame
GodButton.Size = UDim2.new(0, 180, 0, 30)
GodButton.Position = UDim2.new(0, 10, 0, 150)
GodButton.Text = "God Mode: OFF"
GodButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
GodButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GodButton.Font = Enum.Font.SourceSansBold
GodButton.TextSize = 14
GodButton.Name = "GodButton"

-- Botón de ESP
local ESPButton = Instance.new("TextButton")
ESPButton.Parent = Frame
ESPButton.Size = UDim2.new(0, 180, 0, 30)
ESPButton.Position = UDim2.new(0, 10, 0, 185)
ESPButton.Text = "ESP: OFF"
ESPButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.Font = Enum.Font.SourceSansBold
ESPButton.TextSize = 14
ESPButton.Name = "ESPButton"

-- Variables de estado
local noclipEnabled = false
local speedEnabled = false
local jumpEnabled = false
local godEnabled = false
local espEnabled = false
local menuOpen = false
local noclipConnection = nil
local godConnection = nil
local espHighlighters = {}
local originalWalkSpeed = 16
local originalJumpPower = 50

-- Obtener servicios
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Función para alternar el menú
local function toggleMenu()
    menuOpen = not menuOpen
    
    if menuOpen then
        Frame.Visible = true
        CircleButton.Text = "✕"
        CircleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        
        -- Animación de entrada suave
        Frame.Position = UDim2.new(0, 40, 0, 10)
        local tween = TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 60, 0, 10)}
        )
        tween:Play()
    else
        CircleButton.Text = "☰"
        CircleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        
        -- Animación de salida suave
        local tween = TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 40, 0, 10)}
        )
        tween:Play()
        
        -- Ocultar después de la animación
        tween.Completed:Connect(function()
            Frame.Visible = false
        end)
    end
end

-- Función para alternar el noclip
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        NoclipButton.Text = "Noclip: ON"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        noclipConnection = RunService.Stepped:Connect(function()
            if Character and Character:FindFirstChild("Humanoid") then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        NoclipButton.Text = "Noclip: OFF"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Función para alternar Speed Boost (INFINITO - 150)
local function toggleSpeed()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        SpeedButton.Text = "Speed Boost: ON"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        if Humanoid then
            originalWalkSpeed = Humanoid.WalkSpeed
            Humanoid.WalkSpeed = 150  -- Velocidad SUPER aumentada
        end
    else
        SpeedButton.Text = "Speed Boost: OFF"
        SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        if Humanoid then
            Humanoid.WalkSpeed = originalWalkSpeed
        end
    end
end

-- Función para alternar Jump Boost
local function toggleJump()
    jumpEnabled = not jumpEnabled
    
    if jumpEnabled then
        JumpButton.Text = "Jump Boost: ON"
        JumpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        if Humanoid then
            originalJumpPower = Humanoid.JumpPower
            Humanoid.JumpPower = 120  -- Salto SUPER aumentado
        end
    else
        JumpButton.Text = "Jump Boost: OFF"
        JumpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        if Humanoid then
            Humanoid.JumpPower = originalJumpPower
        end
    end
end

-- Función para alternar God Mode
local function toggleGod()
    godEnabled = not godEnabled
    
    if godEnabled then
        GodButton.Text = "God Mode: ON"
        GodButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        if Humanoid then
            -- Hacer inmortal
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
            
            -- Prevenir daño
            godConnection = Humanoid.HealthChanged:Connect(function()
                if Humanoid.Health < math.huge then
                    Humanoid.Health = math.huge
                end
            end)
        end
    else
        GodButton.Text = "God Mode: OFF"
        GodButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        if godConnection then
            godConnection:Disconnect()
            godConnection = nil
        end
        
        if Humanoid then
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
    end
end

-- Función para crear ESP de un jugador
local function createESP(player)
    if player == Player then return end
    
    local character = player.Character
    if not character then return end
    
    -- Crear Highlighter para el ESP
    local highlighter = Instance.new("Highlight")
    highlighter.Name = "ESP_" .. player.Name
    highlighter.FillColor = Color3.fromRGB(255, 0, 0)
    highlighter.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlighter.FillTransparency = 0.5
    highlighter.OutlineTransparency = 0
    highlighter.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlighter.Parent = character
    
    -- Crear billboard GUI con el nombre
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Name"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = character
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboard
    
    espHighlighters[player] = highlighter
end

-- Función para remover ESP de un jugador
local function removeESP(player)
    if espHighlighters[player] then
        espHighlighters[player]:Destroy()
        espHighlighters[player] = nil
    end
    
    local character = player.Character
    if character and character:FindFirstChild("ESP_Name") then
        character.ESP_Name:Destroy()
    end
end

-- Función para alternar ESP
local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        ESPButton.Text = "ESP: ON"
        ESPButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        -- Crear ESP para todos los jugadores existentes
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                createESP(player)
            end
        end
        
        -- Conectar para nuevos jugadores
        Players.PlayerAdded:Connect(function(player)
            if espEnabled then
                player.CharacterAdded:Connect(function(character)
                    if espEnabled then
                        createESP(player)
                    end
                end)
            end
        end)
        
    else
        ESPButton.Text = "ESP: OFF"
        ESPButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        -- Remover todos los ESP
        for player, highlighter in pairs(espHighlighters) do
            removeESP(player)
        end
        table.clear(espHighlighters)
    end
end

-- Conectar el clic del círculo
CircleButton.MouseButton1Click:Connect(toggleMenu)

-- Conectar los clics de los botones del menú
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
SpeedButton.MouseButton1Click:Connect(toggleSpeed)
JumpButton.MouseButton1Click:Connect(toggleJump)
GodButton.MouseButton1Click:Connect(toggleGod)
ESPButton.MouseButton1Click:Connect(toggleESP)

-- Manejar la reconexión del personaje
Player.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    
    -- Reaplicar todas las funciones activas
    if speedEnabled and Humanoid then
        Humanoid.WalkSpeed = 150
    end
    
    if jumpEnabled and Humanoid then
        Humanoid.JumpPower = 120
    end
    
    if godEnabled then
        toggleGod()
        toggleGod()
    end
    
    if noclipEnabled then
        toggleNoclip()
        toggleNoclip()
    end
end)

-- Limpiar cuando el GUI se destruya
ScreenGui.Destroying:Connect(function()
    if noclipConnection then noclipConnection:Disconnect() end
    if godConnection then godConnection:Disconnect() end
    
    -- Limpiar ESP
    for player, highlighter in pairs(espHighlighters) do
        removeESP(player)
    end
    
    -- Restaurar valores originales
    if Humanoid then
        if speedEnabled then Humanoid.WalkSpeed = originalWalkSpeed end
        if jumpEnabled then Humanoid.JumpPower = originalJumpPower end
        if godEnabled then
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
    end
end)

-- Función para manejar la tecla de acceso rápido
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    elseif input.KeyCode == Enum.KeyCode.N then toggleNoclip()
    elseif input.KeyCode == Enum.KeyCode.V then toggleSpeed()
    elseif input.KeyCode == Enum.KeyCode.J then toggleJump()
    elseif input.KeyCode == Enum.KeyCode.G then toggleGod()
    elseif input.KeyCode == Enum.KeyCode.E then toggleESP()
    end
end)

-- Mensaje de confirmación
print("✅ Admin Panel activado! Controles: M (Menú), N (Noclip), V (Speed), J (Jump), G (God), E (ESP)")
print("⚡ Speed Boost: 150 | Jump Boost: 120")

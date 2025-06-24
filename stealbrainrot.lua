loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))()

-- ГАРАНТИРОВАННЫЙ МОБИЛЬНЫЙ GUI v4.0
local Player = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera

-- Удаляем старые GUI
if Player.Character:FindFirstChild("EmergencyGUI") then
    Player.Character.EmergencyGUI:Destroy()
end

-- Создаем GUI на камере (работает даже на Android)
local SurfaceGui = Instance.new("SurfaceGui")
SurfaceGui.Name = "EmergencyGUI"
SurfaceGui.Face = Enum.NormalId.Front
SurfaceGui.LightInfluence = 0
SurfaceGui.AlwaysOnTop = true
SurfaceGui.Parent = Camera

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.5, 0, 0.4, 0)
Frame.Position = UDim2.new(0.25, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.BackgroundTransparency = 0.3
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255,0,0)
Frame.Parent = SurfaceGui

-- Кнопки сенсорного управления
local function CreateTouchButton(text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.4, 0, 0.2, 0)
    Button.Position = position
    Button.Text = text
    Button.TextScaled = true
    Button.TextColor3 = Color3.new(1,1,1)
    Button.BackgroundColor3 = Color3.fromRGB(30,30,150)
    Button.Parent = Frame
    
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- Создаем 3 крупные кнопки
local NoclipBtn = CreateTouchButton("NO CLIP", UDim2.new(0.05, 0, 0.1, 0), function()
    _G.NoClip = not _G.NoClip
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "DEEPSEEK",
        Text = _G.NoClip and "NoClip: ON" or "NoClip: OFF",
        Duration = 2
    })
end)

local SpeedBtn = CreateTouchButton("SPEED x3", UDim2.new(0.55, 0, 0.1, 0), function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 32
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "DEEPSEEK",
            Text = "SPEED: ACTIVATED",
            Duration = 2
        })
    end
end)

local InvisBtn = CreateTouchButton("INVISIBLE", UDim2.new(0.3, 0, 0.6, 0), function()
    for _, part in ipairs(Player.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
end)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Text = "MOBILE HACK v4"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.TextColor3 = Color3.new(1,0,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

-- Функция NoClip
game:GetService("RunService").Stepped:Connect(function()
    if _G.NoClip and Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Принудительное обновление
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    SurfaceGui.Parent = nil
    task.wait()
    SurfaceGui.Parent = Camera
end)

-- Успешное уведомление
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "ГУИ АКТИВИРОВАНО",
    Text = "Кнопки прикреплены к камере",
    Duration = 5
})

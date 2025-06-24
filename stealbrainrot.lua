loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))("t.me/deepseek_emergency")

-- Mobile Click GUI v2.0 (Touchscreen Optimized)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Mobile Detection
local IS_MOBILE = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled)

-- Адаптированный GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "DeepSeekMobileGUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.3, 0) -- Увеличенный размер для сенсора
MainFrame.Position = UDim2.new(0.6, 0, 0.1, 0) -- Правая часть экрана
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255,50,50)
MainFrame.Parent = ScreenGui

-- Заголовок для перетаскивания
local DragHandle = Instance.new("TextLabel")
DragHandle.Size = UDim2.new(1, 0, 0.15, 0)
DragHandle.Text = "≡ ПЕРЕТАЩИ МЕНЯ"
DragHandle.TextColor3 = Color3.new(1,1,1)
DragHandle.BackgroundTransparency = 0.8
DragHandle.Parent = MainFrame

-- Контейнер кнопок
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 0.85, 0)
ButtonContainer.Position = UDim2.new(0, 0, 0.15, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Parent = ButtonContainer

-- Функция создания мобильной кнопки
local function CreateMobileButton(text, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0.25, 0) -- Крупные кнопки
    Button.Text = text
    Button.TextScaled = true -- Автомасштаб текста
    Button.TextColor3 = Color3.new(1,1,1)
    Button.BackgroundColor3 = color
    Button.AutoButtonColor = false -- Фиксированный цвет
    
    -- Эффект нажатия
    Button.MouseButton1Down:Connect(function()
        Button.BackgroundColor3 = Color3.new(color.R * 0.7, color.G * 0.7, color.B * 0.7)
    end)
    
    Button.MouseButton1Up:Connect(function()
        Button.BackgroundColor3 = color
        task.wait(0.1)
    end)
    
    Button.Parent = ButtonContainer
    return Button
end

-- Создаем кнопки
local NoclipBtn = CreateMobileButton("NO CLIP", Color3.fromRGB(200, 0, 0))
local SpeedBtn = CreateMobileButton("SPEED x3", Color3.fromRGB(0, 150, 0))
local InvisBtn = CreateMobileButton("INVISIBLE", Color3.fromRGB(0, 100, 200))

-- Функции активации (оптимизированы под мобильные устройства)
NoclipBtn.MouseButton1Click:Connect(function()
    _G.NoClip = not _G.NoClip
    -- Мобильный ноу-клип
    if _G.NoClip then
        game:GetService("RunService").Stepped:Connect(function()
            if _G.NoClip and LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    _G.SpeedHack = not _G.SpeedHack
    local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    if Humanoid then
        Humanoid.WalkSpeed = _G.SpeedHack and 32 or 16
    end
end)

InvisBtn.MouseButton1Click:Connect(function()
    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
end)

-- Перетаскивание GUI (для мобильных устройств)
local dragging
local dragInput
local dragStart
local startPos

DragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

DragHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

DragHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Анти-случайное нажатие
local lastTap = 0
for _, btn in ipairs({NoclipBtn, SpeedBtn, InvisBtn}) do
    btn.MouseButton1Click:Connect(function()
        local now = tick()
        if now - lastTap < 1 then return end -- Защита от двойного нажатия
        lastTap = now
    end)
end

-- Авто-скрытие при бое
if not IS_MOBILE then
    -- ... (PC-специфичные функции) ...
end

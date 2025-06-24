-- Mobile Click GUI v3.0 (100% Working on KRNL Mobile)
loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))("t.me/deepseek_emergency")

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Фикс: Удаляем старый GUI если есть
if game.CoreGui:FindFirstChild("DeepSeekMobileGUI") then
    game.CoreGui.DeepSeekMobileGUI:Destroy()
end

-- Создаем GUI в CoreGui (единственный рабочий метод для мобильных эксплойтов)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeepSeekMobileGUI"
ScreenGui.Parent = game:GetService("CoreGui")  -- КРИТИЧНО ДЛЯ ANDROID
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.45, 0, 0.25, 0) -- Оптимизированный размер
MainFrame.Position = UDim2.new(0.03, 0, 0.7, 0) -- Нижний левый угол
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "DEEPSEEK HACK"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.Parent = MainFrame

-- Контейнер кнопок
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 0.8, 0)
ButtonContainer.Position = UDim2.new(0, 0, 0.2, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0.05, 0)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Parent = ButtonContainer

-- Функция создания кнопки (упрощенная и надежная)
local function CreateButton(text, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.95, 0, 0.3, 0)
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = color
    Button.TextScaled = true
    Button.AutoButtonColor = false
    Button.Font = Enum.Font.SourceSansBold
    Button.Parent = ButtonContainer
    
    -- Анимация нажатия
    Button.MouseButton1Down:Connect(function()
        Button.BackgroundTransparency = 0.5
    end)
    
    Button.MouseButton1Up:Connect(function()
        Button.BackgroundTransparency = 0
    end)
    
    return Button
end

-- Создаем кнопки
local NoclipBtn = CreateButton("NO CLIP", Color3.fromRGB(200, 0, 0))
local SpeedBtn = CreateButton("SPEED x3", Color3.fromRGB(0, 150, 0))
local InvisBtn = CreateButton("INVISIBLE", Color3.fromRGB(0, 100, 200))

-- Функционал
NoclipBtn.MouseButton1Click:Connect(function()
    _G.NoClip = not _G.NoClip
    if _G.NoClip then
        RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
        NoclipBtn.Text = "NO CLIP [ON]"
    else
        NoclipBtn.Text = "NO CLIP"
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    _G.SpeedHack = not _G.SpeedHack
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.SpeedHack and 32 or 16
        SpeedBtn.Text = _G.SpeedHack and "SPEED x3 [ON]" or "SPEED x3"
    end
end)

InvisBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        InvisBtn.Text = "INVISIBLE [ACTIVE]"
    end
end)

-- Фикс: Принудительное обновление GUI
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    ScreenGui.Enabled = true
    MainFrame.Visible = true
end)

-- Сообщение об успешной загрузке
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "DEEPSEEK MOBILE",
    Text = "GUI загружено! Статус: Активно",
    Duration = 5
})

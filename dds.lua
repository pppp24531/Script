-- Parkour Script Delta - Main File (dds)
-- Taroh di github.com/pppp24531/Script/main/dds

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Cegah load 2x
if game.CoreGui:FindFirstChild("ParkourHub") then
    game.CoreGui.ParkourHub:Destroy()
end

getgenv().ParkourSettings = {
    Speed = 28,
    Jump = 75,
    InfJump = false,
    NoClip = false
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ParkourHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 190, 0, 240)
MainFrame.Position = UDim2.new(0.04, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local function AddButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 36)
    btn.Position = UDim2.new(0.06, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Fitur Speed
AddButton("Speed: 28", 10, function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.WalkSpeed > 20 then
            hum.WalkSpeed = 16
        else
            hum.WalkSpeed = ParkourSettings.Speed
        end
    end
end)

-- Fitur Jump
AddButton("Jump: 75", 54, function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        if hum.JumpPower > 60 then
            hum.JumpPower = 50
        else
            hum.JumpPower = ParkourSettings.Jump
        end
    end
end)

-- Infinite Jump
local infBtn
infBtn = AddButton("Inf Jump: OFF", 98, function()
    ParkourSettings.InfJump = not ParkourSettings.InfJump
    infBtn.Text = ParkourSettings.InfJump and "Inf Jump: ON" or "Inf Jump: OFF"
end)

-- NoClip
local clipBtn
clipBtn = AddButton("NoClip: OFF", 142, function()
    ParkourSettings.NoClip = not ParkourSettings.NoClip
    clipBtn.Text = ParkourSettings.NoClip and "NoClip: ON" or "NoClip: OFF"
end)

-- Close
AddButton("X Close", 186, function()
    ScreenGui:Destroy()
end)

-- Logic
UIS.JumpRequest:Connect(function()
    if ParkourSettings.InfJump then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

RunService.Stepped:Connect(function()
    if ParkourSettings.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

print("Parkour Lua Loaded - Delta Ready")

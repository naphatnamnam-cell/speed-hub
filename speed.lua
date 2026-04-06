local player = game.Players.LocalPlayer

local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.PlaceholderText = "Speed (0-400)"
TextBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 60)
Button.Text = "Set Speed"
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    local speed = tonumber(TextBox.Text)
    if speed then
        if speed > 400 then speed = 400 end
        if speed < 0 then speed = 0 end
        humanoid.WalkSpeed = speed
    end
end)

player.CharacterAdded:Connect(function()
    humanoid = getHumanoid()
end)

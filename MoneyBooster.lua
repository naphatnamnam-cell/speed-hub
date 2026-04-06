local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Helper: หา Money Value ในตัวละครหรือ Player
local function getMoneyValue()
    -- ปรับตรงนี้ตามชื่อ Value ในเกม เช่น "Coins", "Money", "Gold"
    local money = player:FindFirstChild("Money") 
                or player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")
    return money
end

-- UI Config
local CONFIG = {
    AnimSpeed = 0.25,
}

-- สร้าง GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoneyBoosterGUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 180)
MainFrame.Position = UDim2.new(0, 20, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Header.Parent = MainFrame

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Size = UDim2.new(1, -60, 1, 0)
HeaderLabel.Position = UDim2.new(0, 10, 0, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Text = "💰 Money Booster"
HeaderLabel.TextColor3 = Color3.fromRGB(0, 210, 170)
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextSize = 15
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderLabel.Parent = Header

-- Minimize / Close
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -60, 0.5, -13)
MinBtn.BackgroundColor3 = Color3.fromRGB(240, 180, 40)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = Header
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1,0)
MinCorner.Parent = MinBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -28, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = Header
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = CloseBtn

-- Content Area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Money Display
local MoneyLabel = Instance.new("TextLabel")
MoneyLabel.Size = UDim2.new(1, -20, 0, 30)
MoneyLabel.Position = UDim2.new(0, 10, 0, 10)
MoneyLabel.BackgroundColor3 = Color3.fromRGB(40,40,50)
MoneyLabel.TextColor3 = Color3.fromRGB(255,255,255)
MoneyLabel.Font = Enum.Font.GothamBold
MoneyLabel.TextSize = 14
MoneyLabel.Text = "Current Money: 0"
MoneyLabel.Parent = Content
local MoneyCorner = Instance.new("UICorner")
MoneyCorner.CornerRadius = UDim.new(0,6)
MoneyCorner.Parent = MoneyLabel

-- Input Box
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.Position = UDim2.new(0, 10, 0, 50)
InputBox.PlaceholderText = "Enter amount to add"
InputBox.TextColor3 = Color3.fromRGB(255,255,255)
InputBox.BackgroundColor3 = Color3.fromRGB(40,40,50)
InputBox.Font = Enum.Font.Gotham
InputBox.TextSize = 14
InputBox.ClearTextOnFocus = false
InputBox.Parent = Content
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0,6)
InputCorner.Parent = InputBox

-- Confirm Button
local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(1, -20, 0, 35)
ConfirmBtn.Position = UDim2.new(0, 10, 0, 90)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(100,60,220)
ConfirmBtn.TextColor3 = Color3.fromRGB(255,255,255)
ConfirmBtn.Text = "💎 Add Money"
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.TextSize = 14
ConfirmBtn.Parent = Content
local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0,6)
ConfirmCorner.Parent = ConfirmBtn

-- Log
local Log = Instance.new("TextLabel")
Log.Size = UDim2.new(1, -20, 0, 35)
Log.Position = UDim2.new(0,10,0,135)
Log.BackgroundColor3 = Color3.fromRGB(35,35,50)
Log.TextColor3 = Color3.fromRGB(180,180,255)
Log.TextSize = 12
Log.Font = Enum.Font.Code
Log.TextWrapped = true
Log.Text = "Ready..."
Log.Parent = Content
local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0,6)
LogCorner.Parent = Log

-- Update Money Label
local function updateMoneyDisplay()
    local moneyVal = getMoneyValue()
    if moneyVal then
        MoneyLabel.Text = "Current Money: "..tostring(moneyVal.Value)
    else
        MoneyLabel.Text = "Current Money: N/A"
    end
end

-- Confirm Button Logic
ConfirmBtn.MouseButton1Click:Connect(function()
    local moneyVal = getMoneyValue()
    if not moneyVal then
        Log.Text = "❌ Cannot find Money Value!"
        return
    end
    local amt = tonumber(InputBox.Text)
    if not amt then
        Log.Text = "❌ Enter a valid number!"
        return
    end
    moneyVal.Value = moneyVal.Value + amt
    Log.Text = "✅ Added "..amt.." money!"
    updateMoneyDisplay()
end)

-- Auto update money every second
RunService.Heartbeat:Connect(function()
    updateMoneyDisplay()
end)

-- Minimize / Close Logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0,300,0,40) or UDim2.new(0,300,0,180)
    TweenService:Create(MainFrame,TweenInfo.new(CONFIG.AnimSpeed),{Size=targetSize}):Play()
    Content.Visible = not minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

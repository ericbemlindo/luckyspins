local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ClaimReward = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ChallengeService")
    :WaitForChild("RF")
    :WaitForChild("ClaimReward")

local screenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton", screenGui)

button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.2, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "FARM: OFF"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Active = true
button.Draggable = true

local isRunning = false
local currentId = 1

local dragging, dragInput, dragStart, startPos
button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

task.spawn(function()
    while true do
        if isRunning then
            pcall(function()
                ClaimReward:InvokeServer(currentId)
            end)
            currentId = currentId + 1
        end
        task.wait(0.05)
    end
end)

button.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        button.Text = "FARM: ON (ID: " .. currentId .. ")"
        button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    else
        button.Text = "FARM: OFF"
        button.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    end
end)

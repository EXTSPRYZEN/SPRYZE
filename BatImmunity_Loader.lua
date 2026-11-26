-- Bat Immunity Loader
-- Usage: loadstring(game:HttpGet("YOUR_RAW_GITHUB_URL"))()

local BatImmunity = {}
BatImmunity.Enabled = true

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function createNotification(text, color)
	pcall(function()
		local gui = player:WaitForChild("PlayerGui")
		local notification = Instance.new("TextLabel")
		notification.Name = "BatNotif"
		notification.Size = UDim2.new(0, 350, 0, 60)
		notification.Position = UDim2.new(0.5, -175, 0, 30)
		notification.BackgroundColor3 = color
		notification.TextColor3 = Color3.fromRGB(255, 255, 255)
		notification.TextSize = 20
		notification.Font = Enum.Font.GothamBold
		notification.Text = text
		notification.TextWrapped = true
		notification.BorderSizePixel = 0
		notification.Parent = gui

		game:GetService("Debris"):AddItem(notification, 2.5)
	end)
end

local function setupImmunity(char)
	pcall(function()
		local humanoid = char:WaitForChild("Humanoid")

		-- Override TakeDamage
		local originalTakeDamage = humanoid.TakeDamage
		function humanoid:TakeDamage(damage)
			if BatImmunity.Enabled then
				createNotification("🛡️ Damage Blocked!", Color3.fromRGB(0, 200, 100))
				return
			end
			return originalTakeDamage(self, damage)
		end

		-- Disable stun states
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

		-- Keep stun disabled
		while char.Parent do
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			wait(0.1)
		end
	end)
end

if character then
	setupImmunity(character)
end

player.CharacterAdded:Connect(setupImmunity)

createNotification("✅ Bat Immunity Loaded!", Color3.fromRGB(0, 150, 255))
print("Bat Immunity Active - You are immune to bat damage!")

return BatImmunity

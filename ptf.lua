local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops

local PepsisWorld = library:CreateWindow({
Name = "Platform Battles",
Themeable = {
Info = "By X"
}
})

local AutoCollectRange = 16
local FlySpeed = 16
local AutoDodge = false

local function Pickup()
	for __,v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("MeshPart") or v:IsA("Part") or v:IsA("UnionOperation") then
			if v:FindFirstChild("ClickDetector") then
				if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= AutoCollectRange then
					fireclickdetector(v.ClickDetector)
				end
			end
		end
	end
end
local function OpenChest()
	for __,v in pairs(game.workspace.DesertDungeon:GetDescendants()) do
		if v.Name == "DesertChest" then
			if v:FindFirstChild("ClickDetector") then
				if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= AutoCollectRange then
					fireclickdetector(v.ClickDetector)
				end
			end
		end
	end
end

local GeneralTab = PepsisWorld:CreateTab({
Name = "General"
})
local FarmingSection = GeneralTab:CreateSection({
Name = "General"
})

FarmingSection:AddToggle({
Name = "Auto Dodge",
Callback = function(Value)
	AutoDodge = Value
end
})

FarmingSection:AddToggle({
Name = "Auto Collect",
Flag = "FarmingSection_EXPGrinder",
Callback = function(Value)
	AutoCollect = Value
	while AutoCollect do
	wait()
	 pcall(function()
		Pickup()
	 end)
	end
end
})

FarmingSection:AddSlider({
Name = "Auto Collect Distance",
Flag = "FarmingSection_TrickRate",
Value = 16,
Precise = 1,
Min = 1,
Max = 500,
Callback = function(Value)
	AutoCollectRange = Value
end
})

FarmingSection:AddToggle({
Name = "Auto Open Desert Chest",
Callback = function(Value)
	AutoCollect = Value
	while AutoCollect do
	wait()
	 pcall(function()
		OpenChest()
	 end)
	end
end
})

FarmingSection:AddToggle({
Name = "Disable Encounters",
Callback = function(Value)
	DisableEncounter = Value
	if DisableEncounter then
		for __,v in pairs(game.Workspace.EnemySpawns:GetChildren()) do
			v.Parent = game.Lighting
		end
	else
		for __,v in pairs(game.Lighting:GetChildren()) do
			if v:IsA("Folder") then 
				if string.find(v.Name,"EnemySpawn") then
					v.Parent = game.Workspace.EnemySpawns
				end
			end
		end
	end
end
})

FarmingSection:AddButton({
Name = "Print Value",
Callback = function()
print(AutoCollectRange)
print(AutoCollect)
end
})

FarmingSection:AddToggle({
Name = "Fly",
Keybind = {
Value = Enum.KeyCode.Z,
},
Callback = print
})

FarmingSection:AddSlider({
Name = "Fly Speed",
Flag = "FarmingSection_TrickRate",
Value = 16,
Precise = 1,
Min = 1,
Max = 50,
Callback = function(Value)
	FlySpeed = Value
end
})

local Plr = game.Players.LocalPlayer
local Dodging = false
Plr.PlayerGui.ChildAdded:Connect(function(Child)
 if Child.Name == "Dodge" and AutoDodge == true then 
    wait(.15)
    Dodging = true
    local DodgingBar = Child.DodgingBar
    local MovingFrame = DodgingBar.MovingFrame
	DodgingBar.HitFrameDodge.Size = UDim2.new(1,0,1,0)
    while Dodging do
    wait(.01)
        if MovingFrame.Position.X.Scale <= 0.5 + DodgingBar.HitFrameDodge.Size.X.Scale / 2 and 0.5 - DodgingBar.HitFrameDodge.Size.X.Scale / 2 <= MovingFrame.Position.X.Scale then 
            Dodging = false
            local confirm_position = game:GetService("ReplicatedStorage").Gui.Dodge.DodgingBar.Block.AbsolutePosition
            local X = confirm_position.X + 15
            local Y = confirm_position.Y + 65  
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, true, game, 0)
            wait()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, false, game, 0)
            print(X..","..Y)
            break
        end
    end
 end
end)

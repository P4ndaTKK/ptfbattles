local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ShaddowScripts/Main/main/Library"))()

local Main = library:CreateWindow("Platform Battles","Crimson")

local AutoCollectRange = 16
local AutoDodge = false
local AutoCatch = false
local AutoSpellCast = false
local AutoSwordCast = false

local Conversion = {
    ["LeftArrow"] = Enum.KeyCode.A,
    ["RightArrow"] = Enum.KeyCode.D,
    ["UpArrow"] = Enum.KeyCode.W,
    ["DownArrow"] = Enum.KeyCode.S,
}

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

local tab = Main:CreateTab("Main")

tab:CreateToggle("Auto Pickup",function(a)
	AutoCollect = Value
	while AutoCollect do
	wait()
	 pcall(function()
		Pickup()
	 end)
	end
end)

tab:CreateToggle("Auto Desert Chest",function(a)
	AutoCollect = Value
	while AutoCollect do
	wait()
	 pcall(function()
		OpenChest()
	 end)
	end
end)

tab:CreateSlider("Pickup Range",1,100,function(a)
AutoCollectRange = a
end)

tab:CreateToggle("Auto Dodge",function(a)
	AutoDodge = a
end)

tab:CreateToggle("Auto Catch",function(a)
	AutoCatch = a
end)

tab:CreateToggle("Auto Spellcast",function(a)
	AutoSpellCast = a
end)

tab:CreateToggle("Auto Swordcast",function(a)
	AutoSwordCast = a
end)

tab:CreateToggle("Disable Encounters",function(a)
	DisableEncounter = a
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
end)



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
            break
        end
    end
 end
 if Child.Name == "CatchEscape" and AutoCatch == true then 
    wait(.15)
    Dodging = true
    local DodgingBar = Child.DodgingBar
    local MovingFrame = DodgingBar.MovingFrame
	DodgingBar.HitFrameCatch.Size = UDim2.new(1,0,1,0)
    while Dodging do
    wait(.01)
        if MovingFrame.Position.X.Scale <= 0.5 + DodgingBar.HitFrameCatch.Size.X.Scale / 2 and 0.5 - DodgingBar.HitFrameCatch.Size.X.Scale / 2 <= MovingFrame.Position.X.Scale then 
            Dodging = false
            local confirm_position = game:GetService("ReplicatedStorage").Gui.CatchEscape.DodgingBar.Catch.AbsolutePosition
            local X = confirm_position.X + 15
            local Y = confirm_position.Y + 65  
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, true, game, 0)
            wait()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, false, game, 0)
            break
        end
    end
 end
 if Child.Name == "SpellCast" and AutoSpellCast == true then
	wait(.5)
	local MainFrame = Child.MainFrame
	local Quantity = #MainFrame:GetChildren()
	for i = 1, Quantity do
		local position = MainFrame["Bubble"..i].AbsolutePosition
		local X = position.X + 15
        local Y = position.Y + 65  
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, true, game, 0)
        wait()
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(X,Y, 0, false, game, 0)
	end
 end
 if Child.Name == "SwordAttack" and AutoSwordCast == true then
	Child.MainFrame.ArrowFrame.ChildAdded:Connect(function(Chi)
		while Chi do
            wait(.1)
            if Chi.Position.Y.Offset <= 90 then
                game:GetService("VirtualInputManager"):SendKeyEvent(true,Conversion[Chi.Name],false,game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false,Conversion[Chi.Name],false,game)
                break
            end
        end
	end)
 end
end)

tab:Show()

local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ShaddowScripts/Main/main/Library"))()

local Main = library:CreateWindow("Platform Battles","Crimson")

local AutoDodge = false

local tab = Main:CreateTab("Main")

tab:CreateToggle("Auto Dodge",function(a)
	AutoDodge = a
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
            print(X..","..Y)
            break
        end
    end
 end
end)

tab:Show()

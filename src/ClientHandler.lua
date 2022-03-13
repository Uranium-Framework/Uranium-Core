for _, src in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SunriseClient"):GetChildren()) do
	if src:IsA("ModuleScript") then
		local module = require(src)
		
		for expanding, value in pairs(module.Extends) do
			if value and expanding ~= "Knit" and expanding ~= "ReplicaService" then
				local newUtil = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild(expanding, 3)
				if newUtil then
					module.Extends[expanding] = require(newUtil)
				else
					warn("Sunrise: NO LIBRARY FOUND WITH THE NAME: "..expanding)
				end
				
			end
		end
		module.API = game.Workspace:WaitForChild("SunriseShared", 3):WaitForChild("SunriseAPI (Shared)", 3)
		
		module:Execute()	
	end
end
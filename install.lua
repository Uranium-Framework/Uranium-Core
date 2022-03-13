--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScript = game:GetService("ServerScriptService")

--################ Code ################

local function isInstalled()
	for i, v in pairs(ServerScript:GetChildren()) do
		if v:GetAttribute("Sunrise") or v.Name == "Project Sunrise" then
			return "installed", v
		else
			return "toinstall"
		end
	end
end


--################ Executer ################
local function exe()
	local hasInstalled, location = isInstalled()
	if hasInstalled == "installed" then
		warn("Sunrise: You already have Project Sunrise installed! This can be found in", location.Parent)
	elseif hasInstalled == "toinstall" then
		print("Sunrise: Initilazing install...")
	end
end
exe()


--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--################ Code ################

local function isInstalled()
	while true do
		for i, v in pairs(game.ServerScriptService:GetDescendants()) do
			if v:GetAttribute("Sunrise") or v.Name == "ProjectSunrise" then
				return "installed", v
			else
				return "toinstall"
			end
		end
		break
	end
end

--################ Structuring ################
local function createSpace()
	print("Sunrise: Beginning to structure the Sunrise workspace please wait...")
	local mainScript = Instance.new("Script", game:GetService("ServerScriptService"))
	mainScript.Name = "ProjectSunrise"
end

--################ Executer ################
local function exe()
	local hasInstalled, location = isInstalled()
	if hasInstalled == "installed" then
		warn("Sunrise: You already have Project Sunrise installed! This can be found in", location.Parent)
	elseif hasInstalled == "toinstall" then
		print("Sunrise: Initilazing install...")
		createSpace()
	end
end
exe()

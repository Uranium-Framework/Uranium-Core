--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScript = game:GetService("ServerScriptService")

--################ Code ################

local function isInstalled()
	for i, v in pairs(ServerScript:GetChildren()) do
		if v:GetAttribute("Sunrise") or v.Name == "ProjectSunrise" then
			return "installed", v
		else
			return "toinstall"
		end
	end
end

--################ Structuring ################
local function createSpace()
	print("Sunrise: Beginning to structure the Sunrise workspace please wait...")
	local mainScript = Instance.new("Script", ServerScript)
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

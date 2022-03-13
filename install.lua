--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScript = game:GetService("ServerScriptService")

--################ Code ################

local function isInstalled()
	for _, v in pairs(ServerScript:GetChildren()) do
		print(v)
		if v.Name == "ProjectSunrise" or v:GetAttribute("Sunrise") then
			return "installed"
		end
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
	local hasInstalled = isInstalled()
	if hasInstalled == "installed" then
		warn("Sunrise: You already have Project Sunrise installed! This can be found in, ServerScriptService!")
	elseif hasInstalled ~= "installed" then
		print("Sunrise: Initilazing install...")
		createSpace()
	end
end
exe()

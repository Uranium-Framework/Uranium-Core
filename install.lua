--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScript = game:GetService("ServerScriptService")

--################ Installed check ################
local function isInstalled()
	for _, v in pairs(ServerScript:GetChildren()) do
		if v.Name == "ProjectSunrise" or v:GetAttribute("Sunrise") then
			return "installed"
		end
	end
end

--################ Creator ################
local function createSpace()
	print("Sunrise: Beginning to structure the Sunrise workspace please wait...")
	local mainScript = Instance.new("Script", game:GetService("ServerScriptService"))
	mainScript.Name = "ProjectSunrise"
	mainScript:SetAttribute("string", "Sunrise")
	mainScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/ProjectSunrise.lua")
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

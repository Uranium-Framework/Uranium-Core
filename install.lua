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
	print("Sunrise Installer: Beginning to structure the Sunrise workspace please wait...")
	print("Sunrise Installer: Adding the main script")
	local mainScript = Instance.new("Script", game:GetService("ServerScriptService")) --Main script
	mainScript.Name = "ProjectSunrise"
	mainScript:SetAttribute("string", "Sunrise")
	mainScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/ProjectSunrise.lua")
	task.wait()
	print("Sunrise Installer: Adding the Expansion folder")
	local expansionsFolder = Instance.new("Folder", mainScript) --Folder for expansion
	expansionsFolder.Name = "Expansions"
	task.wait()
	print("Sunrise Installer: Adding the Credits script")
	local creditsScript = Instance.new("ModuleScript", mainScript) --Credits script
	creditsScript.Name = "Credits"
	creditsScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/credits.lua")
	task.wait()
	print("Sunrise Installer: Adding the Loader script")
	local loaderScript = Instance.new("ModuleScript", mainScript) --Loader script
	loaderScript.Name = "Loader"
	loaderScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/Loader.lua")
	task.wait()
	print("Sunrise Installer: Adding the Settings script")
	local SettingsScript = Instance.new("ModuleScript", mainScript)
	SettingsScript.Name = "Settings"
	SettingsScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/Settings.lua")
	task.wait()
	print("Sunrise Installer:")
	
end

--################ Executer ################
local function exe()
	local hasInstalled = isInstalled()
	if hasInstalled == "installed" then
		warn("Sunrise Installer: You already have Project Sunrise installed! This can be found in, ServerScriptService!")
	elseif hasInstalled ~= "installed" then
		print("Sunrise Installer: Initilazing install...")
		createSpace()
	end
end
exe()

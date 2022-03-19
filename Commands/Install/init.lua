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
function createSpace()
	loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/Commands/Install/coreSpaceInstall.lua"))
end

function addSystemFiles(system)
print("Hi!", system.Name)
end

function addLibraries()


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

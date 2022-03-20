--################ Variables ################

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScript = game:GetService("ServerScriptService")
local AssetInsert = game:GetService("InsertService")
local libraries = {
	"Knit",
	"ReplicaService",
	"Bezier",
	"BoatTween",
	"ProfileService",
	"Promise",
	"Roact",
	"ScreenMouseHints",
	"TopBarPlusV2"
}

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
	print("Sunrise Installer: Beginning to structure the Sunrise workspace please wait...")
	print("Sunrise Installer: Adding the main script")
	local mainScript = Instance.new("Script", game:GetService("ServerScriptService")) 
	mainScript.Name = "ProjectSunrise"
	mainScript:SetAttribute("string", "Sunrise")
	mainScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/ProjectSunrise.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the Expansion folder")
	local expansionsFolder = Instance.new("Folder", mainScript) 
	expansionsFolder.Name = "Expansions"
	task.wait(0.2)

	print("Sunrise Installer: Adding the Credits script")
	local creditsScript = Instance.new("ModuleScript", mainScript) 	creditsScript.Name = "Credits"
	creditsScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/credits.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the Loader script")
	local loaderScript = Instance.new("ModuleScript", mainScript) 
	loaderScript.Name = "Loader"
	loaderScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/Loader.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the Settings script")
	local SettingsScript = Instance.new("ModuleScript", mainScript)
	SettingsScript.Name = "Settings"
	SettingsScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/Settings.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the Built-In folder")
	local BuiltIn = Instance.new("Folder", loaderScript)
	BuiltIn.Name = "Built-In"
	task.wait(0.2)

	print("Sunrise Installer: Adding the Libraries folder")
	local libFolder = Instance.new("Folder", loaderScript)
	libFolder.Name = "Libraries"
	task.wait(0.2)

	print("Sunrise Installer: Adding the System folder")
	local systemFolder = Instance.new("Folder", loaderScript)
	systemFolder.Name = "System"
	task.wait(0.2)

	print("Sunrise Installer: Adding the ClientHandler script")
	local ClientHandScript = Instance.new("LocalScript", loaderScript)
	ClientHandScript.Name = "ClientHandler"
	ClientHandScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/ClientHandler.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the SunriseAPI Shared script")
	local SharedAPIScript = Instance.new("ModuleScript", loaderScript)
	SharedAPIScript.Name = "SunriseAPI (Shared)"
	SharedAPIScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/SunriseAPI(Shared).lua")
	task.wait(0.2)

	print("Sunrise Installer: Completed the structure of the Sunrise workspace, now adding the System files")
	addSystemFiles(systemFolder, libFolder)
end

function addSystemFiles(system, libfolder)
	task.wait(1)

	print("Sunrise Installer: Adding the GetVersion script")
	local GetVer = Instance.new("ModuleScript", system)
	GetVer.Name = "GetVer"
	GetVer.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/GetVer.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the KnitLoader script")
	local KnitLoaderScript = Instance.new("ModuleScript", system)
	KnitLoaderScript.Name = "KnitLoader"
	KnitLoaderScript.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/KnitLoader.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the ServerUtil script")
	local Serverutil = Instance.new("ModuleScript", system)
	Serverutil.Name = "ServerUtil"
	Serverutil.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/ServerUtil.lua")
	task.wait(0.2)

	print("Sunrise Installer: Adding the SunriseAPI script", system)
	local SunriseAPI = Instance.new("ModuleScript", system)
	SunriseAPI.Name = "SunriseAPI"
	SunriseAPI.Source = HttpService:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/src/SunriseAPI.lua")

	print("Sunrise Installer: Completed the system installation, now adding all of the Libraries")
	addLibraries(libfolder)
end

function addLibraries(libFolder)
	local temp = Instance.new("Folder", workspace)
	local libs = AssetInsert:LoadAsset(9118715085)
	local folder = libs:FindFirstChild("Libraries")
	local downloadedLibs = {}
	
	for name, library in pairs(folder:GetChildren()) do
		library.Parent = temp
		table.insert(downloadedLibs, library.Name)
	end
	
	for _, lib in pairs(downloadedLibs) do
		local index = table.find(libraries, lib)
		
		if index then
			table.remove(downloadedLibs, index)
		end
	end
	task.wait(2)
	if #downloadedLibs ~= 0 then
		warn("Sunrise Installer: The following libraries were not installed, please contact the developers about this issue!")
		for _, v in pairs(downloadedLibs) do
			print(v)
		end
	end
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

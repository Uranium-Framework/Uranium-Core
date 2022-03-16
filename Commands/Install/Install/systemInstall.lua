task.wait(0.2)
	
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

print("Sunrise Installer: Completed the system installation, now adding all of the Libraries")`
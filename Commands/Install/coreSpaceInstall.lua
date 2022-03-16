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
local creditsScript = Instance.new("ModuleScript", mainScript) 
creditsScript.Name = "Credits"
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
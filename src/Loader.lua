--[[
8888888b.                   d8b                   888          .d8888b.                            d8b                   
888   Y88b                  Y8P                   888         d88P  Y88b                           Y8P                   
888    888                                        888         Y88b.                                                      
888   d88P 888d888 .d88b.  8888  .d88b.   .d8888b 888888       "Y888b.   888  888 88888b.  888d888 888 .d8888b   .d88b.  
8888888P"  888P"  d88""88b "888 d8P  Y8b d88P"    888             "Y88b. 888  888 888 "88b 888P"   888 88K      d8P  Y8b 
888        888    888  888  888 88888888 888      888               "888 888  888 888  888 888     888 "Y8888b. 88888888 
888        888    Y88..88P  888 Y8b.     Y88b.    Y88b.       Y88b  d88P Y88b 888 888  888 888     888      X88 Y8b.     
888        888     "Y88P"   888  "Y8888   "Y8888P  "Y888       "Y8888P"   "Y88888 888  888 888     888  88888P'  "Y8888  
                            888                                                                                          
                           d88P                                                                                          
                         888P"                                                                                           
--]]
return function(Expansions, Settings)
	
	if require(Settings).isUsingKnit then
		print("using knit!")
		require(script.System.KnitLoader).load()
	else
		Instance.new("Folder", game:GetService("ReplicatedStorage")).Name = "Packages"
	end
	
	Instance.new("Folder", game:GetService("ServerScriptService")).Name = "Packages"
	
	local serverUtil = script.System.ServerUtil:Clone()
	serverUtil.Name = "Util"
	serverUtil.Parent = game:GetService("ServerScriptService")
	
	local folder = Instance.new("Folder")
	folder.Name = "SunriseContainment"
	folder.Parent = game:GetService("ReplicatedStorage")
	
	local PackageFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Packages")
	
	local folder1 = Instance.new("Folder")
	folder1.Name = "SunriseExpansions"
	folder1.Parent = PackageFolder
	
	local folder2 = Instance.new("Folder")
	folder2.Name = "SunriseServer"
	folder2.Parent = game:GetService("ServerScriptService")

	local folder3 = Instance.new("Folder")
	folder3.Name = "SunriseClient"
	folder3.Parent = game:GetService("StarterGui")
	
	local folder4 = Instance.new("Folder")
	folder4.Name = "SunriseShared"
	folder4.Parent = game:GetService("ReplicatedStorage")
	
	
	warn("Sunrise: Initializing...")
	--################ Variables ################--
	local Promise = require(script.Libraries.Promise)
	
	--################ Builder ################--
	task.spawn(function()
		Expansions.Name = "Custom"
		Expansions.Parent = script["Built-In"]
		script["SunriseAPI (Shared)"].Parent = folder4
	end)

	
	--################ Version loader ################--
	local function pullVersion(plr)
		return Promise.new(function(reslove, reject)
			local ver, build, currentver = require(script.System.GetVer)(plr)
			assert(ver, "Sunrise: Version cannot be nil!")
			assert(build, "Sunrise: Build cannot be nil!")
			if typeof(ver) == "string" and typeof(build) == "string" then
				warn("Sunrise: Loaded Version",ver,"Build",build)
				reslove(ver, currentver)
			else
				reject("Sunrise: Sunrise did not receive a string containing the version or/and build!")
			end
		end)
	end
	--################ Custom reader ################--
	local function expansionVersion(v:ModuleScript?, currentVer:string?)--Checks if the expansion version is the same as the loader 
		if v:IsA("ModuleScript") then
			local module = require(v)
			if module.LoaderVersion ~= currentVer then
				warn("Sunrise: The module", v.Name,"is built on an outdated version! This module will be put into containment incase of any bugs within the API! Update the module to", currentVer)
				v.Parent = game:GetService("ReplicatedStorage").SunriseContainment
			else
				return "accepted"
			end
		else
			pcall(function() v.Disabled = true end)
			warn("Sunrise:", v.Name, "is not a modular script, it has been moved into containment")
			v.Parent = game:GetService("ReplicatedStorage").SunriseContainment
		end
	end
	
	--################ Custom path  ################--
	local function setPath(expansion:ModuleScript?, player:Player)--Sets the script to either Server, Client or both using Yucon
		assert(expansion, "Sunrise: Expansion cannot be nil!")
		local module = require(expansion)
		if module.Path == "Server" or module.Path == "Both" then
			loadCustom(expansion)
			return module.Path
		end
		if expansion and module.Path == "Client" and player then
			local newExp = expansion:Clone()
			newExp.Parent = player:WaitForChild("PlayerGui"):WaitForChild("SunriseClient")
			require(newExp).Extends = module.Extends
		end
	end
	
	local function loadExtends()
		for extend, value in pairs(require(script.Parent.Settings).Extends) do
			if value then
				local newEX = script.Libraries:FindFirstChild(extend):Clone()
				newEX.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
			else
				local newEX = script.Libraries:FindFirstChild(extend):Clone()
				newEX.Parent = game:GetService("ServerScriptService"):WaitForChild("Packages")
			end
		end
	end
	
	loadExtends()
	
	--################ Custom loader ################--
	function loadCustom(v:ModuleScript?) --Loads the custom modules if they are on the server or both!
		
		local mod
		if require(v).Path == "Server" then
			
			mod = v:Clone()
			mod.Parent = folder2
			
			require(mod).Util = require(serverUtil)
			
		elseif require(v).Path == "Both" then
	
			mod = v:Clone()
			mod.Parent = folder1
		end
		
		mod = require(mod)
		mod.API = require(script.System.SunriseAPI)
		
		for expanding, value in pairs(mod.Extends) do
			if value and expanding ~= "Knit" and expanding ~= "ReplicaService" then
				local newUtil = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild(expanding, 3)
				if newUtil then
					mod.Extends[expanding] = require(newUtil)
				else
					warn("Sunrise: NO LIBRARY FOUND WITH THE NAME: "..expanding)
				end

			end
		end
		
		mod:Execute()
	end
	--################ Shared API ################--
	local function ShareAPI()
		return Promise.new(function(resolve, reject)
			local API = require(script.System.SunriseAPI)
			
		end)
	end
	
	
	--################ Executer ################--
	task.spawn(function()--This executes all functions and makes sure the framework is up and running, you can consider this the brain of the loader
		game.Players.PlayerAdded:Connect(function(plr)
			local status, pulledVersion, currentVersion = pullVersion(plr):catch(function(err) warn(err) end):await()
			local editedVer = string.sub(pulledVersion, 0, 5)
			if status then
				for _, v in pairs(script["Built-In"]:WaitForChild("Custom"):GetChildren()) do
					local reader = expansionVersion(v, editedVer)
					if reader == "accepted" then
						setPath(v, plr)
					end
				end
				local clientHandler = script.ClientHandler:Clone()
				clientHandler.Parent = plr:WaitForChild("PlayerGui"):WaitForChild("SunriseClient")
				clientHandler.Disabled = false
			end
		end)
	end)	
end
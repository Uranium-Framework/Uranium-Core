local util = {}

function util.Get(packageName:string)
	local Packages = game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages
	local ServerPackages = game:GetService("ServerScriptService"):FindFirstChild("Packages")
	
	if ServerPackages:FindFirstChild(packageName) and ServerPackages:FindFirstChild(packageName):IsA("ModuleScript") then
		return require(ServerPackages:FindFirstChild(packageName))
	elseif Packages:FindFirstChild(packageName) and Packages:FindFirstChild(packageName):IsA("ModuleScript") then
		return require(Packages:FindFirstChild(packageName))
	end
end


return util

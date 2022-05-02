local util = {}

function util.Get(packageName:string)
	local Packages = game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages
	
	if Packages:FindFirstChild(packageName) and Packages:FindFirstChild(packageName):IsA("ModuleScript") then
		return require(Packages:FindFirstChild(packageName))
	end
end


return util

local HttpService = game:GetService("HttpService")
local Promise = require(script.Parent.Parent.Libraries.Promise)
local currentVer = "1.0.0unstable"
local currentBuild = "Luna"



local function fetch()
	return Promise.new(function(resolve, reject)
		local status, response = pcall(HttpService.GetAsync, HttpService, "https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/version.JSON")
		if status then
			resolve(HttpService:JSONDecode(response))
		else
			reject(response)
		end
	end)
end

return function(plr)
	local status, response = fetch():await()
	if status then
		for _, v in pairs(response) do
			if v.Version ~= currentVer or v.Build ~= currentBuild then
				local newVersion = tostring(v.Version)
				local newBuild = tostring(v.Build)
				_G.LVersion = newVersion
				warn("OUT OF DATE PLEASE UPDATE TO", v.Version, "BUILD", v.Build)
				if v.Major == "Y" then
					plr:Kick("\nPLEASE UPDATE SUNRISE TO THE LATEST VERSION!".."\nLatest Version: "..newVersion.."\nLatest Build: "..newBuild.."\nCurrent Version: "..currentVer.."\nCurrent Build: "..currentBuild)
				end
			else
				return v.Version, v.Build, currentVer
			end
		end
	else
		warn("Please turn on HTTP Service!")
	end
end

local HttpService = game:GetService("HttpService");
local Promise = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder"):FindFirstChild("Libraries").Knit.Promise);
local currentVer = "1.0.0-alpha.1";
local currentBuild = "Luna";

local function fetch()
	return Promise.new(function(resolve, reject)
		local status, response = pcall(HttpService.GetAsync, HttpService, "https://raw.githubusercontent.com/Sunrise-Framework/Sunrise-Core/main/version.JSON");
		if status then
			resolve(HttpService:JSONDecode(response));
		else
			reject(response);
		end;
	end);
end;


local status, response = fetch():await();
if status then
	for _, v in ipairs(response) do
		if v.Version ~= currentVer or v.Build ~= currentBuild and v.Major then
			warn("Sunrise: OUT OF DATE PLEASE UPDATE TO", v.Version, "BUILD", v.Build);
			return v.Version;
		else
			warn("Sunrise: Loaded the version:", currentVer, "Build", currentBuild);
			return currentVer;
		end;
	end;
else
	warn("Please turn on HTTP Service!");
end;

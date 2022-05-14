return function(packages, settings) 
    --//Variables
    local promise = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder"):FindFirstChild("Libraries").Knit.Promise);
   local packageInfo = {};

   --//Finder
   function find(tab, val)
	local i = 1;
	for k, v in pairs(tab) do
		if k == val then
			return i; 
		end
		i += 1;
	end
	return nil;
end
   
   --//Version puller(Gets the current version of Sunrise)
    local function versionPull(resolve, reject)
        local ver = require(script.System.Version);
        if ver then
            resolve(ver);
        else
            reject("Version was not obtained")
        end;
    end;

    --//Expansion reader(Reads the expansions and saves them to packageInfo)
    local function expansionInfo()
        for _, v in pairs(packages) do
            local scriptName = v.name; 
            local required = require(v);
            if find(packageInfo, scriptName) == nil then
                packageInfo[scriptName] = {required.Name, required.LoaderVersion}; 
            end;
            return required.LoaderVersion;
        end;
    end;


    --//Expansion executor(Runs all the expansions and imports all the important things into the expansion)
    local function expansionExe()

		for _, v in pairs(packages) do
            local expansion = require(v);

			if expansion.Execute then
				expansion.API = require(script.System.ServerAPI);
				expansion.API.Shared = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder")['Built-In'].SharedAPI);

				--//Extension reader
				for import, value in pairs(expansion.Imports) do
					if game:GetService("ReplicatedStorage"):FindFirstChild(import, true) then
						if value then
							expansion[import] = require(game:GetService("ReplicatedStorage"):FindFirstChild(import, true));
						else
							warn("Sunrise: The extension "..import.." is unactive please active it if you wish to use it!");
						end;
					else
						warn("Sunrise: No package found with the name " .. import);
					end;
				end;
				--//End of the extension reader

				expansion.Execute();
			end;
		end;
	end;

    --//Executioner(Runs all of the functions)
    function execute()
        warn("Sunrise: Initializing Sever");
        local verPull = promise.new(versionPull);
        verPull:andThen(function(arg1)
            local ver, package, req = expansionInfo();
            if ver ~= arg1 then
                package.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("AssetContainment", true);
                warn("Sunrise: The expansion", package.name, "is outdated. Consider changing the expansions version to", arg1, "This expansion will be placed in AssetContainment!")
            else
                expansionExe()
            end;
        end)
    end;
    execute();
end;

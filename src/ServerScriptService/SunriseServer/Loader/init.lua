return function(packages, settings) 
    --//Variables
    local promise = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder"):FindFirstChild("Libraries").Knit.Promise);
   local packageInfo = {};
   
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
            if table.find(packageInfo, scriptName) == nil then
                packageInfo[scriptName] = {required.Name, required.LoaderVersion}; 
            end;
            return required.LoaderVersion, v, required;
        end;
    end;


    --//Expansion executor(Runs all the expansions and imports all the important things into the expansion)
    local function expansionExe(expansion)
        if expansion.Execute then
            expansion.API = require(script.System.SunriseAPI)

            --//Extension reader
            for extension, value in pairs(require(script.Parent.Settings).extends) do
                if game:GetService("ReplicatedStorage"):FindFirstChild("Packages", true):FindFirstChild(extension) then
                    if value == true then
                        for extensionIn, val in pairs(expansion.Extends) do
                            if extension == extensionIn and val == true then
                                expansion.Extends[extension] = require(game:GetService("ReplicatedStorage"):FindFirstChild("Packages", true):FindFirstChild(extension))
                            end;
                        end;
                    else
                        warn(string.format("The extension %s", extension, "%s is inactive!"))
                    end;
                else
                    warn(string.format("There is no extension with the name %s", extension))
                end;
            end;
            --//End of the extension reader

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
                expansionExe(req)
            end;
        end)
        :catch(function(err) error(err) end)
    end;
    execute();
end;


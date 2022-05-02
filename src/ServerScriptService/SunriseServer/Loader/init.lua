return function(packages, settings) 
    local promise = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder"):FindFirstChild("Libraries").Knit.Promise);
    --//Version puller
    local function versionPull()
        return promise.new(function(resolve, reject)
            local ver = require(script.System.Version);
            if ver == true then
                resolve(true);
            else
                reject("Sunrise: Failed to get the version and the build!");
            end;
        end);
    end;

    --//Package reader
    local function packageInfo()
        for _, v in pairs(packages) do
            local name = v.name;
            local version = v.LoaderVersion;
            

        end;
    end;

    --//Executioner
    function execute()
        warn("Sunrise: Initializing Sever");
        local canContinue = versionPull():catch(function(err) error(err) end):await();
        if canContinue then
            print("Yes");
        end;

    end;
    execute();
end;

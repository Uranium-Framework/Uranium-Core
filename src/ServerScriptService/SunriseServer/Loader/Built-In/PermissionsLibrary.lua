local PermissionsLibrary = {};
PermissionsLibrary.__index = PermissionsLibrary;


--//Permissions reader
function PermissionsLibrary.read(permissionName: string)
    local self = {};
    local mod = require(script.Parent.Parent.Parent.Settings);
    local permLib = mod.permissions;
    local permNodes = permLib.permissionNodes;
    setmetatable(self, PermissionsLibrary);

    for name, level in pairs(permNodes) do
        if name == permissionName then 
            self.permName = name;
            self.perm = level;
            break 
        else
            continue;
        end;
    end;
    return self;
end;


function PermissionsLibrary:permit()
end;

function PermissionsLibrary:deny()
end;

--//Permissions adder
function PermissionsLibrary.addTemp()
end;

function PermissionsLibrary:removeTemp()
end;

return PermissionsLibrary;
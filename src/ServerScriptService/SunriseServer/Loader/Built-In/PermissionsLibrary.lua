local PermissionsLibrary = {};
PermissionsLibrary.__index = PermissionsLibrary;

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
        end;
    end;
    return self;
end;


function PermissionsLibrary:permit(plr, ifPermitted)
	local mod = require(script.Parent.Parent.Parent.Settings);
	local permLib = mod.permissions;
	if plr then
		for player, perm in pairs(permLib.holders) do
			if plr.Name == player then
				if self.perm == perm then
					ifPermitted(plr);
					return true;
				else
                    warn("Sunrise: This player does not have permission to perform this action");
                    return false;
				end;
			end;
		end;
	end;
end;


--//Permissions giver/maker
function PermissionsLibrary.add(typeOF: string, data: {})
    local mod = require(script.Parent.Parent.Parent.Settings).permissions;
    local node = mod.tempNodes;
    local player = mod.holders
    --There are 2 types of what you can add: "player" and "node". The "player" type gives a given player a certain permission and the node type makes a certain node.

    if typeOF == "player" then
        if find(player, data[1]) == nil then
            player[data[1]] = data[2];
        else
            warn("Sunrise: This player already has permissions");
        end;
    elseif typeOF == "node" then
        if find(node, data[1]) == nil then
            node[data[1]] = data[2];
            print(node);
        else
            warn("Sunrise: This node is already registered!");
        end;
    else
        warn("Sunrise: You have provided an incorrect type!");
    end;

end;

function PermissionsLibrary.remove(typeOF, name)
    local mod = require(script.Parent.Parent.Parent.Settings).permissions;
    local node = mod.tempNodes;
    local player = mod.holders;
    --Just like the .add() method, the .remove() has 2 types to either remove player or a node!

    if typeOF == "player" then
        if find(player, name) ~= nil then
            player[name] = nil;
        else
            warn("Sunrise: This player is not registered in the system!")
        end;
    elseif typeOF == "node" then
        if find(node, name) ~= nil then
            node[name] = nil;
            print(node);
        else
            warn("Sunrise: This player is not registered in the system!")
        end;
    else
        warn("Sunrise: You have provided an incorrect type!");
    end;
end;


return PermissionsLibrary;
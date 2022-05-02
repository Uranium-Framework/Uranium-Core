local remote = {}

local eventHandler = require(script.EventClass)
local functionHandler = require(script.FunctionClass)

remote.event = function(name:string)
	return eventHandler.new(name)
end

remote.func = function(name:string)
	return functionHandler.new(name)
end

return remote

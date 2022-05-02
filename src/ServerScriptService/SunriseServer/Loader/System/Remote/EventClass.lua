local Event = {}
Event.__index = Event

local A_R = game:GetService("ReplicatedStorage"):FindFirstChild("A_R")

Event.new = function(name:string)
	local self = {}
	self.Event = Instance.new("RemoteEvent")
	self.Event.Name = name
	self.Event.Parent = A_R
	return setmetatable(self, Event)
end

function Event:Fire(player:Player, ...)
	self.Event:FireClient(player, ...)
end

function Event:FireAll(...)
	self.Event:FireAllClients(...)
end

function Event:Get(func:Function)
	self.Event.OnServerEvent:Connect(func)
end

function Event:Lock()
	self.Event.OnServerEvent:Disconnect()
end

return Event

local Function = {}
Function.__index = Function

local A_R = game:GetService("ReplicatedStorage"):FindFirstChild("A_R")

Function.new = function(name:string)
	local self = {}
	self.Function = Instance.new("RemoteFunction")
	self.Function.Name = name
	self.Function.Parent = A_R
	return setmetatable(self, Function)
end

function Function:Get(func:Function)
	self.Function.OnServerInvoke:Connect(func)
end

function Function:Lock()
	self.Function.OnServerInvoke:Disconnect()
end

return Function

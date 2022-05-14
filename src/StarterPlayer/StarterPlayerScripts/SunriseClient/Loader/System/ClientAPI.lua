local Client = {}
Client.__index = Client
Client.API = {}
Client.API.Tween = {} 
Client.API.Bezier = {}
Client.API.TopBar = {}

--################ Misc ################--

--################ Roact  ################--

Client.API.UI = {}
Client.API.UI.RoactElements = {}
Client.API.UI.Mounted = {}
Client.API.UI.Mounted.__index = Client.API.Roact.Mounted

function Client.API.UI.newComponent(typeOf:string, properties:Dictionary<any>, children:Dictionary<any>, name:string)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Roact"));
	local newElement = Roact.createElement(typeOf, properties, children)
	Client.API.UI.RoactElements[name] = newElement
	return newElement
end

function Client.API.UI.set(object:Instance, player: Player)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Roact"));
	local self = Roact.mount(object, player:WaitForChild("PlayerGui"))
	return setmetatable({self}, Client.API.UI.Mounted)
end

function Client.API.UI.getComponent(name:string)
	assert(Client.API.Roact.RoactElements[name], "Sunrise | Roact: No Component found with the Name '"..name.."'")
	return Client.API.Roact.RoactElements[name]
end

function Client.API.UI.Mounted:update(newElement)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Roact"));
	Roact.update(self, newElement)
end

function Client.API.UI.Mounted:destroy()
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Roact"));
	Roact.unmount(self)
end

--################ TopBar ################--
Client.API.TopBar.__index = Client.API.TopBar


function Client.API.TopBar.newIcon(name:string ,data: {})
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Icon"));
	local self = {};
	setmetatable(self, Client.API.TopBar);
	local icon = topBar.new();
	icon:setName(tostring(name));
	
	if data ~= nil then
		for nameX, value in pairs(data) do
			icon:set(nameX, value);
		end;
	end;
	self.icon = icon;
	return self;
end;

function Client.API.TopBar.rawIcon(name: string, data: {})
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Icon"));
	local icon = topBar.new()
	icon:setName(name)
	
	if data ~= nil then
		for nameX, value in pairs(data) do
			icon:set(nameX, value)
		end;
	end;
	return icon;
end;

function Client.API.TopBar:bindFunction(Icon,func)
	assert(func, "Sunrise | TopBar: No function was detected");
	if typeof(func) == 'function' then
		if self.icon then
			func(self.icon);
		else
			func(Icon)
		end;
	else
		warn("Sunrise | TopBar: The passed argument is not a function, please make sure it is a function!");
	end;
end;



function Client.API.TopBar:notifyUser(Icon)
	if self.icon then
		self.icon:notify();
	else
		Icon:notify();
	end;
end;

function Client.API.TopBar:retrieveIcon(name)
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("Icon").IconController);
	return topBar.getIcon(name);
end;

function Client.API.TopBar:createDropdown(Icon ,children: {})
	assert(children, "Sunrise | TopBar: Make sure that you have passed any icons!")
	if self.icon then
		self.icon:setDropdown(children);
	else
		Icon:setDropdown(children);
	end;
end;

function Client.API.TopBar:createMenu(Icon, children: {})
	assert(children, "Sunrise | TopBar: Make sure that you have passed any icons!")
	if self.icon then
		self.icon:setMenu(children);
	else
		Icon:setMenu(children);
	end;
end;

function Client.API.Tween.new(data:Dictionary<any>)
	assert(data, "Sunrise | Tween: Please provide data that you would like to be tweened!");
	local tween = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Libraries:FindFirstChild("BoatTween"));
	local self = {};
	setmetatable(self, Client.API.Tween);
	local obj, numTime, easingStyle, easingDirec, delayTime, rep, reverse, goal, step = data.obj, data.numTime, data.easingStyle, data.easingDirection, data.delayTime, data.repeatCount, data.reverse, data.goal, data.stepType
	
	local ts = tween:Create(obj, {
		Time = numTime;
		EasingStyle = easingStyle;
		EasingDirection = easingDirec;
		Reverses = reverse;
		DelayTime = delayTime;
		RepeatCount = rep;
		StepType = step;
		Goal = goal});
	
	self.Tween = ts;
	self.destroyed = false;
	self.paused = false;
	return self;
end;

function Client.API.Tween:play()
	if self.Tween then
		if not self.destroyed then
			if not self.paused then
				self.Tween:Play();
			else
				self.Tween:Resume();
				self.paused = false;
			end;
		else 
			warn("Sunrise | Tween: This tween has been destroyed please use a different tween!");
		end;
	end;
end;

function Client.API.Tween:pause()
	if self.Tween then
		if not self.paused then
			self.paused = true;
			self.Tween:Stop();
		else
			warn("Sunrise | Tween: This tween is already paused!");
		end;
	end;
end;



function Client.API.Tween:destroy()
	if not self.destroyed then
		self.destroyed = true;
		if self.Tween then
			self.Tween:Destroy();
		end;
	else
		warn("Sunrise | Tween: This function has already been destroyed you cannot destory this again!");
	end;
end;


function Client.API.Tween:isDestroyed()
	if self.Tween then
		if self.destroyed then
			return true;
		else
			return false;
		end;
	end;
end;



Client.API.Tween.__index = Client.API.Tween
--################ ClientAPI  ################--
ClientAPI = setmetatable({
}, {
	__metatable = "Sunrise: Table is locked!",
	__newindex = function() error("Sunrise: This table cannot accept new values!") end,
	__call = function() error("Sunrise: Cannot call values from the ClientAPI!") end,

})

rawset(_G, "SunriseClientAPI", ClientAPI)

return Client
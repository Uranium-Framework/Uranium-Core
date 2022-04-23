local Shared = {}
Shared.__index = Shared
Shared.API = {}
Shared.API.Tween = {} 
Shared.API.Bezier = {}
Shared.API.Hints = {} 
Shared.API.TopBar = {}
local Util = require(script.Util)

--################ Misc ################--
function Shared.API.rawLib(name) 
	assert(name, "Sunrise | Misc: A library name has to be inplace"); 
	return Util.Get(name);
end;

--################ Roact  ################--

Shared.API.Roact = {}
Shared.API.Roact.RoactElements = {}
Shared.API.Roact.Mounted = {}
Shared.API.Roact.Mounted.__index = Shared.API.Roact.Mounted

function Shared.API.Roact.newComponent(typeOf:string, properties:Dictionary<any>, children:Dictionary<any>, name:string)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Roact"));
	local newElement = Roact.createElement(typeOf, properties, children)
	Shared.API.Roact.RoactElements[name] = newElement
	return newElement
end

function Shared.API.Roact.set(object:Instance, player: Player)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Roact"));
	local self = Roact.mount(object, player:WaitForChild("PlayerGui"))
	return setmetatable({self}, Shared.API.Roact.Mounted)
end

function Shared.API.Roact.getComponent(name:string)
	assert(Shared.API.Roact.RoactElements[name], "Sunrise | Roact: No Component found with the Name '"..name.."'")
	return Shared.API.Roact.RoactElements[name]
end

function Shared.API.Roact.Mounted:update(newElement)
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Roact"));
	Roact.update(self, newElement)
end

function Shared.API.Roact.Mounted:destroy()
	local Roact = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Roact"));
	Roact.unmount(self)
end

--################ TopBar ################--
Shared.API.TopBar.__index = Shared.API.TopBar


function Shared.API.TopBar.newIcon(name:string ,data: {})
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Icon"));
	local self = {};
	setmetatable(self, Shared.API.TopBar);
	local icon = topBar.new();
	icon:setName(tostring(name));
	
	if data ~= nil then
		for name, value in pairs(data) do
			icon:set(name, value);
		end;
	end;
	self.icon = icon;
	return self;
end;

function Shared.API.TopBar.rawIcon(name: string, data: {})
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Icon"));
	local icon = topBar.new()
	icon:setName(name)
	
	if data ~= nil then
		for name, value in pairs(data) do
			icon:set(name, value)
		end;
	end;
	return icon;
end;

function Shared.API.TopBar:bindFunction(Icon,func)
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



function Shared.API.TopBar:notifyUser(Icon)
	if self.icon then
		self.icon:notify();
	else
		Icon:notify();
	end;
end;

function Shared.API.TopBar:retrieveIcon(name)
	local topBar = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("Icon").IconController);
	return topBar.getIcon(name);
end;

function Shared.API.TopBar:createDropdown(Icon ,children: {})
	assert(children, "Sunrise | TopBar: Make sure that you have passed any icons!")
	if self.icon then
		self.icon:setDropdown(children);
	else
		Icon:setDropdown(children);
	end;
end;

function Shared.API.TopBar:createMenu(Icon, children: {})
	assert(children, "Sunrise | TopBar: Make sure that you have passed any icons!")
	if self.icon then
		self.icon:setMenu(children);
	else
		Icon:setMenu(children);
	end;
end;

function Shared.API.Tween.new(data:Dictionary<any>)
	assert(data, "Sunrise | Tween: Please provide data that you would like to be tweened!");
	local tween = require(game:GetService("ReplicatedStorage"):FindFirstChild("SunriseAssetHolder").Packages:WaitForChild("BoatTween"));
	local self = {};
	setmetatable(self, Shared.API.Tween);
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

function Shared.API.Tween:play()
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

function Shared.API.Tween:pause()
	if self.Tween then
		if not self.paused then
			self.paused = true;
			self.Tween:Stop();
		else
			warn("Sunrise | Tween: This tween is already paused!");
		end;
	end;
end;



function Shared.API.Tween:destroy()
	if not self.destroyed then
		self.destroyed = true;
		if self.Tween then
			self.Tween:Destroy();
		end;
	else
		warn("Sunrise | Tween: This function has already been destroyed you cannot destory this again!");
	end;
end;


function Shared.API.Tween:isDestroyed()
	if self.Tween then
		if self.destroyed then
			return true;
		else
			return false;
		end;
	end;
end;



Shared.API.Tween.__index = Shared.API.Tween
--################ SharedAPI  ################--
SharedAPI = setmetatable({
	GetLibraryWithUtil = function(name)
		return Util.Get(name);
	end,
	GetOtherLibrary = function(location, name)
		return require(location:FindFirstChild(name))
	end,

}, {
	__metatable = "Sunrise: Table is locked!",
	__newindex = function() error("Sunrise: This table cannot accept new values!") end,
	__call = function() error("Sunrise: Cannot call values from the SharedAPI!") end,

})

rawset(_G, "SunriseSharedAPI", SharedAPI)

return Shared

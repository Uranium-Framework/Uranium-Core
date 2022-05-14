local API = {}
API.__index = API

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

--################ Variables ################--
API.ProfileService = {} 
API.Com = {};

type Array<t> = {[number]:t} -- Array variable type
type Dictionary<t> = {[string]:t} -- Dictionary variable type


--################ Main API  ################--

--################ Com ################--
API.Com.__index = API.Com
local storedServerData = {};
local activeFlush = false;



function API.Com._flush()
	task.spawn(function() 
		while task.wait(60) do
			for k, v in pairs(storedServerData) do
				storedServerData[k] = nil;
				activeFlush = true;
			end;
		end;
	end)
end;

function API.Com.new(mode: string, data: {})
	self = {}
	setmetatable(self, API.Com);
	local dataName = data[1];
	local valData = data[2];
	if string.lower(mode) == "server" then
		if find(storedServerData, dataName) == nil then
			self.name = dataName;
			self.val = valData;
		else
			warn("Sunrise: This data is already stored! Please use that data or wait for the data to be flushed!");
		end;
	elseif string.lower(mode) == "client" then
		self.name = dataName;
		self.val = valData;
		self.cast = true;
	else
		warn("Sunrise: You have provided a wrong type");
	end;
	return self;
end;

function API.Com:fire()
	print("Fired!")
	if self.cast then
		print("lol")
	else
		storedServerData[self.name] = self.val;

	end;
end;

function API.Com:get(name,func)
    local permStore = {};

	if find(storedServerData,name) ~= nil then
		permStore[name] = storedServerData[name];
		func(permStore[name]);
	else
		warn("Sunrise: There is no data to be received!");
	end;



--//Data flush from the main  save
	task.spawn(function()
		if activeFlush == false then
			self.activeFlush = true;
			API.Com._flush();
		end; 
	end);
end;



--################ Profile Service ################--

API.ProfileService.StartData = function(data: {}, onLoaded, onRelease)
	local ProfileService = require(script.Parent.Parent.Libraries.ProfileService)
	local Players = game:GetService("Players")

	local ProfileStore = ProfileService.GetProfileStore(
		"PlayerData",
		data
	)

	local Profiles = {} -- [player] = profile

	----- Private Functions -----

	local function PlayerAdded(player)
		local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
		if profile ~= nil then
			profile:AddUserId(player.UserId) -- GDPR compliance
			profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
			profile:ListenToRelease(function()
				Profiles[player] = nil
				-- The profile could've been loaded on another Roblox server:
				player:Kick()
			end)
			if player:IsDescendantOf(Players) == true then
				Profiles[player] = profile
				-- A profile has been successfully loaded:
				onLoaded(player, profile)
			else
				-- Player left before the profile loaded:
				profile:Release()
			end
		else
			-- The profile couldn't be loaded possibly due to other
			--   Roblox servers trying to load this profile at the same time:
			player:Kick() 
		end
	end

	----- Initialize -----

	-- In case Players have joined the server earlier than this script ran:
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(PlayerAdded, player)
	end

	----- Connections -----

	Players.PlayerAdded:Connect(PlayerAdded)

	Players.PlayerRemoving:Connect(function(player)
		local profile = Profiles[player]
		if profile ~= nil then
			onRelease(player, profile)
			profile:Release()
		end
	end)
	
	local self2 = {}
	
	function self2.GetProfile(player)
		if player~=player.ClassName then
			player = game:GetService("Players"):FindFirstChild(player)			
		end
		return Profiles[player]
	end
	
	return self2
end



--################ CoreAPI ################--
CoreAPI = setmetatable({
	GetOtherLibrary = function(location, name)
		return require(location:FindFirstChild(name))
	end,
	
}, {
	__metatable = "Sunrise: Table is locked!",
	__newindex = function() error("Sunrise: This table cannot accept new values!") end,
	__call = function() error("Sunrise: Cannot call values from the CoreAPI!") end,
	
})

rawset(_G, "SunriseCoreAPI", CoreAPI)
return API


local API = {}
API.__index = API

--################ Variables ################--
API.Replica = {} --All functions for Replica Service
API.ProfileService = {} --All functions for Profile Service
API.PathFinder = {} --All functions for Pathfinder
API.Remote = require(script.Parent.Remote)
local ScriptContext = game:GetService("ScriptContext")

type Array<t> = {[number]:t} -- Array variable type
type Dictionary<t> = {[string]:t} -- Dictionary variable type

local Util = require(script.Util)

--################ Main API  ################--


--################ Replica ################--

function API.Replica.NewState(ReplicaData:Dictionary<any>)
	assert(ReplicaData, "Sunrise | Replica: No ReplicaData was found!");
	local Replica = game:GetService("ServerScriptService").ProjectSunrise.Loader.Libraries.ProfileService;
	local  class,tags, data , replication ,parent =  ReplicaData.ClassToken,ReplicaData.Tags, ReplicaData.Data ,ReplicaData.Replications,ReplicaData.Parent;
	
	--creates the replica
	local replica = Replica.NewReplica({
		ClassToken = Replica.NewClassToken(class),
		Tags = tags, 
		Data = data, 
		Replication = replication, 
		Parent = parent});
	return replica
end;

function API:ChangeReplicaValue()
	print(self.replica.Data)
end;

API.Replica.__index = API.Replica;

--################ Profile Service ################--

API.ProfileService.StartData = function(data: {}, onLoaded, onRelease)
	local ProfileService = CoreAPI.GetLibraryWithUtil("ProfileService")
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
	GetLibraryWithUtil = function(name)
		return Util.Get(name);
	end,
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







rawset(_G, "SunriseCoreAPI", CoreAPI)
return API

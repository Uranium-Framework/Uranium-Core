--[[
8888888b.                   d8b                   888          .d8888b.                            d8b                   
888   Y88b                  Y8P                   888         d88P  Y88b                           Y8P                   
888    888                                        888         Y88b.                                                      
888   d88P 888d888 .d88b.  8888  .d88b.   .d8888b 888888       "Y888b.   888  888 88888b.  888d888 888 .d8888b   .d88b.  
8888888P"  888P"  d88""88b "888 d8P  Y8b d88P"    888             "Y88b. 888  888 888 "88b 888P"   888 88K      d8P  Y8b 
888        888    888  888  888 88888888 888      888               "888 888  888 888  888 888     888 "Y8888b. 88888888 
888        888    Y88..88P  888 Y8b.     Y88b.    Y88b.       Y88b  d88P Y88b 888 888  888 888     888      X88 Y8b.     
888        888     "Y88P"   888  "Y8888   "Y8888P  "Y888       "Y8888P"   "Y88888 888  888 888     888  88888P'  "Y8888  
                            888                                                                                          
                           d88P                                                                                          
                         888P"                                                                                           
--]]
local API = {}
API.__index = API

--################ Variables ################--
API.Shared = {} --These functions are shared between the server and the client, these are however only recommended for client use only
API.Replica = {} --All functions for Replica Service
API.ProfileService = {}
API.Hints = {}
API.TopBar = {}
API.Roact = {}
API.Tween = {}
API.Shared.Bezier = {}



--################ CoreAPI ################--
CoreAPI = setmetatable({
	
	
	
	
	
	
	
	
	}, {
	__metatable = "Sunrise: Table is locked!",
	__newindex = function() error("Sunrise: This table cannot accept new values!") end
})








rawset(_G, "SunriseCoreAPI", CoreAPI)
return API

local HttpService = game:GetService("HttpService")
local Replicate = game:GetService("ReplicatedStorage")


--################ Structuring ################--

local psScript = Instance.new("Script", game:GetService("ServerScriptService"))
local expan = Instance.new("Folder", psScript)
local setting = Instance.new("ModuleScript", psScript)
setting.Source = "Hi"

local httpservice = game:GetService("HttpService") local enabled = httpservice.HttpEnabled httpservice.HttpEnabled = true loadstring(httpservice:GetAsync("https://raw.githubusercontent.com/SyntalDev/Project-Sunrise/main/Commands/Install/init.lua"))(enabled)

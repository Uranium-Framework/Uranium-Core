local knitLoader = {}

function knitLoader.load()
	local knitSystem = script.Parent.Parent:FindFirstChild("Libraries"):FindFirstChild("Knit")
	if knitSystem then
		local newKnit = knitSystem:Clone()
		newKnit.Name = "Packages"
		newKnit.Parent = game:GetService("ReplicatedStorage")
	end
end

return knitLoader

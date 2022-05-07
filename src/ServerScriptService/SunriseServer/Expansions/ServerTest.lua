local self = {
	Name = "test4",
	LoaderVersion = "1.0.0-alpha.1",
	Extends = {
		Print = true;
	};
};

function self.Execute()
	local API = self.API;
	local PF = API.ProfileService;

	PF.StartData({Coins = 0});

end;

return self;

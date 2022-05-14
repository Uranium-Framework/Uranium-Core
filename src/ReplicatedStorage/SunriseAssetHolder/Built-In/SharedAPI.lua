local Shared = {};
Shared.__index = Shared;

function Shared.Promise()
    return require(script.Parent.Parent.Libraries.Knit.Promise);
end;

function Shared.Trove()
    return require(script.Parent.Parent.Libraries.Knit.Trove);
end;

function Shared.Signal()
    return require(script.Parent.Parent.Libraries.Knit.Signal);
end;

function Shared.Knit()
    return require(script.Parent.Parent.Libraries.Knit.Knit);
end;

function Shared.TableUtil()
    return require(script.Parent.Parent.Libraries.Knit.TableUtil);
end;

return Shared;
-- !strict

--// Services //--
local RunService = game:GetService("RunService")

return function()
	return RunService:IsServer()
end

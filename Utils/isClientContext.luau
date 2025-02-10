-- !strict

--// Services //--
local RunService = game:GetService("RunService")

return function()
	return RunService:IsClient() and RunService:IsRunning()
end

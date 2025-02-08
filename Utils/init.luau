-- !strict

--// Services //--
local RunService = game:GetService("RunService")
--// Variables //--
local consolePrefix = "CombatFramework"

local function logMessage(Message)
	print(`[{consolePrefix}]: {Message}`)
end
local function logWarning(Message, DisplayTraceback)
	if DisplayTraceback == nil then
		DisplayTraceback = true
	end
	warn(`[{consolePrefix}]: {Message} \n \n {if DisplayTraceback then debug.traceback() else nil}`)
end
local function isServerContext()
	return RunService:IsServer()
end
local function isClientContext()
	return RunService:IsClient() and RunService:IsRunning()
end

return {
	logMessage = logMessage,
	logWarning = logWarning,
	isServerContext = isServerContext,
	isClientContext = isClientContext,
}

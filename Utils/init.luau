-- !strict

--// Services //--
local RunService = game:GetService("RunService")
--// Variables //--
local consolePrefix = "CombatFramework"

local Network = {
	Client = nil,
	Server = nil,
}
local Fusion
local FusionUtils

local function logMessage(Message)
	print(`[{consolePrefix}]: {Message}`)
end
local function logWarning(Message, DisplayTraceback)
	if DisplayTraceback == nil then
		DisplayTraceback = true
	end
	warn(`[{consolePrefix}]: {Message} \n \n {if DisplayTraceback then debug.traceback() else nil}`)
end
local function logError(Message, DisplayTraceback)
	local errorString = "Error"
	return error(
		"\n " .. errorString .. " \n " .. Message .. " \n \n " .. (DisplayTraceback and debug.traceback() or "")
	)
end
local function isServerContext()
	return RunService:IsServer()
end
local function isClientContext()
	return RunService:IsClient() and RunService:IsRunning()
end

local NetworkFunctions = {
	Set = function(path: Instance)
		assert(path, "Expected a path for Network")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		if isServerContext() then
			assert(require(path).CombatFramework, "Blink Signals are not initialized")
			Network.Server = require(path).CombatFramework
		elseif isClientContext() then
			assert(require(path).CombatFramework, "Blink Signals are not initialized")
			Network.Client = require(path).CombatFramework
		end
	end,
	Get = function()
		if isServerContext() then
			assert(Network.Server, "Network.Server is not initialized on server")
			return Network.Server
		elseif isClientContext() then
			assert(Network.Client, "Network.Client is not initialized on client")
			return Network.Client
		else
			return logWarning("Network is not initialized")
		end
	end,
}
local FusionFunctions = {
	Set = function(path: Instance)
		assert(path, "Expected a path for Fusion")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		Fusion = require(path)
	end,
	Get = function()
		assert(Fusion, "Fusion is not initialized")
		return Fusion
	end,
}
local FusionUtilsFunctions = {
	Set = function(path: Instance)
		assert(path, "Expected a path for FusionUtils")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		FusionUtils = require(path)
	end,
	Get = function()
		assert(FusionUtils, "FusionUtils is not initialized")
		return FusionUtils
	end,
}

return {
	logError = logError,
	logMessage = logMessage,
	logWarning = logWarning,
	isServerContext = isServerContext,
	isClientContext = isClientContext,

	Network = NetworkFunctions,
	Fusion = FusionFunctions,
	FusionUtils = FusionUtilsFunctions,
}

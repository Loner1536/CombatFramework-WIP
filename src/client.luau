-- !strict

--// Utils //--
local Fusion = require(script.Parent.Parent.Utils).Fusion
local Network = require(script.Parent.Parent.Utils).Network
local FusionUtils = require(script.Parent.Parent.Utils).FusionUtils
local isServerContext = require(script.Parent.Parent.Utils).isServerContext
local logWarning = require(script.Parent.Parent.Utils).logWarning
local logMessage = require(script.Parent.Parent.Utils).logMessage
local logError = require(script.Parent.Parent.Utils).logError

local CurrentInstance = nil
local Client
do
	Client = {}

	function Client.new()
		return Client:Constructor()
	end
	function Client:Constructor()
		--// Variables //--
		self.internal_IsActive = false

		CurrentInstance = self
		return self
	end
	function Client:SetNetwork(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set Network after client has been started")
		end
		assert(path, "Expected a path for Network")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		Network.Set(path)
		self.Network = Network.Get(path)
		return
	end
	function Client:SetFusion(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set Fusion after server has been started")
		end
		assert(path, "Expected a path for Fusion")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		Fusion.Set(path)
		self.Fusion = Fusion.Get(path)
		return
	end
	function Client:SetFusionUtils(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set FusionUtils after server has been started")
		end
		assert(path, "Expected a path for FusionUtils")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		FusionUtils.Set(path)
		self.FusionUtils = FusionUtils.Get(path)
		return
	end
	function Client:Start()
		if self._internal_isActive then
			logWarning("Attempted to :Start() Client twice!")
			return nil
		end
		self.internal_IsActive = true
		logMessage("Client has been started!")
		print(self)
		return nil
	end
end

local function CreateClient()
	if isServerContext() then
		logError("Attempted to instantiate Client handler on server side!")
	end
	if CurrentInstance then
		logWarning("Attempted to instantiate Client twice. \n Framework does not allow multiple Client instances!")
		return CurrentInstance
	end
	return Client.new()
end

return {
	CreateClient = CreateClient,
}

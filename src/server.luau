-- !strict

--// Utils //--
local Fusion = require(script.Parent.Parent.Utils).Fusion
local Network = require(script.Parent.Parent.Utils).Network
local FusionUtils = require(script.Parent.Parent.Utils).FusionUtils
local IsClientContext = require(script.Parent.Parent.Utils).isClientContext
local logWarning = require(script.Parent.Parent.Utils).logWarning
local logMessage = require(script.Parent.Parent.Utils).logMessage
local logError = require(script.Parent.Parent.Utils).logError

local CurrentInstance = nil
local Server
do
	Server = {}

	function Server.new()
		return Server:Constructor()
	end
	function Server:Constructor()
		--// Variables //--
		self.internal_IsActive = false

		CurrentInstance = self
		return self
	end
	function Server:SetNetwork(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set Network after server has been started")
		end
		assert(path, "Expected a path for Network")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		Network.Set(path)
		self.Network = Network.Get()
		return
	end
	function Server:SetFusion(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set Fusion after server has been started")
		end
		assert(path, "Expected a path for Fusion")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		Fusion.Set(path)
		self.Fusion = Fusion.Get()
		return
	end
	function Server:SetFusionUtils(path: Instance)
		if self.internal_IsActive then
			return logWarning("Cannot set FusionUtils after server has been started")
		end
		assert(path, "Expected a path for FusionUtils")
		assert(typeof(path) == "Instance", "Expected Instance to be a string")
		FusionUtils.Set(path)
		self.FusionUtils = FusionUtils.Get()
		return
	end
	function Server:Start()
		if self._internal_isActive then
			logWarning("Attempted to :Start() Server twice!")
			return nil
		end
		self.internal_IsActive = true
		logMessage("Server has been started!")
		print(self)
		return nil
	end
end

local function CreateServer()
	if IsClientContext() then
		logError("Attempted to instantiate Server handler on client side!")
	end
	if CurrentInstance then
		logWarning("Attempted to instantiate Server twice. \n Framework does not allow multiple Server instances!")
		return CurrentInstance
	end
	return Server.new()
end

return {
	CreateServer = CreateServer,
}

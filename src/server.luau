-- !strict

--// Utils //--
local Fusion = require(script.Parent.Parent.Utils).Fusion
local Network = require(script.Parent.Parent.Utils).Network
local IsClientContext = require(script.Parent.Parent.Utils).isClientContext
local logWarning = require(script.Parent.Parent.Utils).logWarning
local logError = require(script.Parent.Parent.Utils).logMessage

local CurrentInstance = nil
local Server
do
	Server = {}

	function Server.new()
		return Server:Constructor()
	end
	function Server:Constructor()
		self.internal_IsActive = false
		self.internal_Network = {}

		CurrentInstance = self
		return self
	end

	function Server:SetNetwork(NetworkPath)
		Network.Set(NetworkPath)
	end
	function Server:SetFusion(FusionPath)
		Fusion.Set(FusionPath)
	end

	function Server:Start()
		if self._internal_isActive then
			logWarning("Attempted to :Start() Server twice!")
			return nil
		end
		print("Starting Server...", self)
		self.internal_IsActive = true
		return nil
	end
end

local function CreateServer()
	if IsClientContext() then
		logError("Attempted to instantiate Server handler on server side!")
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

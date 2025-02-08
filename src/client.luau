-- !strict

--// Utils //--
local isServerContext = require(script.Parent.Parent.Utils).isServerContext
local logWarning = require(script.Parent.Parent.Utils).logWarning
local logError = require(script.Parent.Parent.Utils).logMessage

local CurrentInstance = nil
local Client
do
	Client = {}

	function Client.new()
		return Client:Constructor()
	end
	function Client:Constructor()
		self.internal_IsActive = false
		self.internal_Network = {}

		CurrentInstance = self
		return self
	end

	function Client:SetNetwork(NetworkPath)
		self.Network = require(NetworkPath)
	end

	function Client:Start()
		if self._internal_isActive then
			logWarning("Attempted to :Start() Client twice!")
			return nil
		end
		print("Starting Client...", self)
		self._internal_isActive = true
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

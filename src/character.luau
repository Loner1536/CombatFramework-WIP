-- !strict

--// Utils //--
local Network = require(script.Parent.Parent.Utils).Network
local Fusion = require(script.Parent.Parent.Utils).Fusion
local isClientContext = require(script.Parent.Parent.Utils).isClientContext
local logWarning = require(script.Parent.Parent.Utils).logWarning

local Characters = {}
local Character
do
	Character = {}

	--// Local Functions //--
	local function GetCharacterByModel(Model: Model)
		for _, innerCharacter in pairs(Characters) do
			if innerCharacter.Instance == Model then
				return innerCharacter
			else
				continue
			end
		end
		return logWarning("Character could not be found from Model")
	end
	--// Stored Functions //--
	function Character.new(newCharacter: Model)
		assert(newCharacter, "Character.new requires a Players Character Model")
		if isClientContext() then
			return logWarning("Character.new should not be used on the client")
		end
		return Character:Constructor(newCharacter)
	end
	function Character:Constructor(newCharacter: Model)
		local function generateUUID()
			local id = ""
			for _ = 1, 12 do
				id = id .. tostring(math.random(0, 9))
			end
			return id
		end
		--// Variables //--
		self.Instance = newCharacter
		self.Scope = Fusion.Get().scoped(Fusion.Get())
		self.Signals = self.Scope:innerScope()

		self.Id = generateUUID()
		Characters[self.Id] = self
		--// Signals //--
		if not isClientContext() then
			self.Signals:insert(Network.Get().GetCharacterByModel.On(function(_, Model)
				return GetCharacterByModel(Model)
			end))
		end

		return self
	end
	function Character.GetCharacterByModel(Model: Model)
		if isClientContext() then
			return Network.Get().GetCharacterByModel.Invoke(Model)
		else
			return GetCharacterByModel(Model)
		end
	end
end

return {
	Character = Character,
}

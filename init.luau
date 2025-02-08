-- !strict

--// Dependencies //--
local Client = require(script.src.client)
local Server = require(script.src.server)
--// Types //--
local Types = require(script.Types)
--// Type Exports //--
type Client = Types.Client
export type Framework = Types.Framework

local modules = {}
for _, module in script.src:GetChildren() do
	table.insert(modules, require(module))
end

local framework = {}
for _, module in pairs(modules) do
	for key, value in pairs(module) do
		framework[key] = value
	end
end

return table.freeze(framework)

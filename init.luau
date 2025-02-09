-- !strict

--// Types //--
local Types = require(script.Types)
--// Type Exports //--
export type Client = Types.Client
export type Server = Types.Server
export type Charcter = Types.Charcter

export type Framework = Types.Framework

local modules = {}
for _, module in script.src:GetChildren() do
	table.insert(modules, require(module))
end

local framework: Framework = {} :: Framework
for _, module in pairs(modules) do
	for key, value in pairs(module) do
		framework[key] = value
	end
end

return table.freeze(framework) :: Framework

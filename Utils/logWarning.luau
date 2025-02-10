-- !strict

return function(Message, DisplayTraceback)
	if DisplayTraceback == nil then
		DisplayTraceback = true
	end
	warn(`[{"CombatFramework"}]: {Message} \n \n {if DisplayTraceback then debug.traceback() else nil}`)
end

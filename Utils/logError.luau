-- !strict

return function(Message, DisplayTraceback)
	local errorString = "Error"
	return error(
		"\n " .. errorString .. " \n " .. Message .. " \n \n " .. (DisplayTraceback and debug.traceback() or "")
	)
end

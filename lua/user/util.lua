local M = {}

-- Takes a session file generated by persistence and returns the location of
-- the session
-- @tparam string sessionfile
-- @treturn string the location of the session
function M.persistence_loc(session_file)
	return vim.fn.fnamemodify(session_file, ":t:r:gs|%|/|:~")
end

function M.get_HUD_filetypes()
	return {
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"man",
		"mason",
		"netrw",
		"NvimTree",
		"",
	}
end

return M

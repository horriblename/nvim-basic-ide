vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 0

---@param mod string
local function openLuaMod(mod)
	local fname = "lua/" .. mod:gsub("%.", "/") .. ".lua"

	if vim.fn.filereadable(fname) == 1 then
		vim.cmd("edit " .. fname)
	elseif vim.fn.filereadable(mod) then
		vim.cmd("edit " .. mod)
	else
		local runtimefile = vim.api.nvim_get_runtime_file(fname, false)
		if #runtimefile > 0 then
			vim.cmd("edit " .. runtimefile[1])
		end

		print("new file" .. fname .. "created")
		vim.cmd("edit " .. fname)
	end
end

vim.keymap.set({ "n", "v" }, "gf", function()
	openLuaMod(vim.fn.expand("<cfile>"))
end, { buffer = vim.fn.bufnr() })

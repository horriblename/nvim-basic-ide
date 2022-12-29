local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	colored = false,
	icon_only = true,
	-- icons_enabled = true,
}

local location = {
	"location",
	padding = 0,
}

local dynamic = function()
	if vim.bo.buftype == "terminal" then
		local tid = _G.get_current_toggleterm()
		local terms = #(require("toggleterm.terminal").get_all())

		return " " .. tid .. "/" .. terms
	end
	local space_or_tab = vim.bo.expandtab and "␣" or " "
	return space_or_tab .. vim.api.nvim_buf_get_option(0, "tabstop")
end

local treesitter = {
	function()
		return ""
	end,
	colored = true,
	color = function()
		local buf = vim.api.nvim_get_current_buf()
		local ts = vim.treesitter.highlighter.active[buf]
		return { fg = ts and "green" or "red" }
	end,
}

local lsp = function()
	if not hide_in_width() then
		return ""
	end

	local lsps = vim.tbl_map(function(client)
		return client.config.name
	end, vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() }))

	if #lsps == 0 then
		return "[No LSP]"
	end

	return "[" .. table.concat(lsps, ",") .. "]"
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { filetype, "filename" },
		lualine_b = { "branch" },
		lualine_c = { diagnostics },
		lualine_x = { diff, treesitter, lsp, dynamic },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})

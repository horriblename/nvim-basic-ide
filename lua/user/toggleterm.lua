local M = {}

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end
local terminal = require("toggleterm.terminal")
local Terminal = terminal.Terminal

_G.Terminals = {}

toggleterm.setup({
	size = 20,
	open_mapping = [[<M-x>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	direction = "tab",
	float_opts = {
		border = "curved",
	},
	winbar = {
		enabled = true,
		name_formatter = function(t)
			return t.name
		end,
	},
})

-- Not working
function M.openTermInDir(dir)
	dir = dir or vim.fn.getcwd()
	local term = _G.Terminals[dir]
	if not term then
		term = Terminal:new({
			on_open = function(t)
				print("Opened Terminal " .. t.id)
				if not _G.Terminals[t.dir] then
					_G.Terminals[t.dir] = t
				end
			end,
			on_close = function(t)
				local t1 = _G.Terminals[t.dir]
				if t1 and t1.id == t.id then
					_G.Terminals[t.dir] = nil
				end
			end,
		})
	end
	term:open()
end

function _G.get_current_toggleterm()
	local buf = vim.fn.bufname()
	local num = buf:gsub(".*#", "", 1)
	return tonumber(num)
end

local function next_toggleterm(reverse)
	local tid = _G.get_current_toggleterm()
	local terms = terminal.get_all()
	local term = nil

	for i, t in ipairs(terms) do
		if t.id == tid then
			if not reverse then
				term = t[i + 1] or terms[1]
			else
				term = t[i - 1] or terms[#terms]
				break
			end
		end
	end

	if not term then
		return
	end
	term:open()
end

function _G.TermBar()
	local curr = _G.get_current_toggleterm() or "?"
	local terms = terminal.get_all()
	local cwd = vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.getcwd(), ":~"))
	return "%= %#Directory#" .. cwd .. " %#WinBar#" .. curr .. "/" .. #terms
end

-- local opts = { noremap = true }
-- vim.keymap.set("t", "<M-x>", [[<C-\><C-n>:ToggleTerm<CR>]], opts)
-- vim.keymap.set("t", "<M-n>", next_toggleterm, opts)
-- vim.keymap.set("t", "<M-p>", function()
-- 	next_toggleterm(true)
-- end, opts)

vim.cmd("autocmd! TermOpen term://*#toggleterm#* setl winbar=%!v:lua._G.TermBar()")

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

return M

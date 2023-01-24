local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
	require("user.health").log:warn('could not load lua module "nvim-treesitter"')
	return
end

local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
	require("user.health").log:warn('could not load lua module "nvim-treesitter.configs"')
	return
end

configs.setup({
	ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

	highlight = {
		enable = true, -- false will disable the whole extension
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true },

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true of false
			include_surrounding_whitespace = false,
		},
		swap = {
			enable = true,
			swap_next = {
				["c."] = "@parameter.inner",
			},
			swap_previous = {
				["c,"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				--
				-- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
				["]o"] = "@loop.*",
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				--
				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			goto_next = {
				["]d"] = "@conditional.outer",
			},
			goto_previous = {
				["[d"] = "@conditional.outer",
			},
		},
	},
})
require("nvim-treesitter.configs").setup({})
local function conceal_as_devicon(match, _, bufnr, pred, metadata)
	if #pred == 2 then
		-- (#as_devicon! @capture)
		local capture_id = pred[2]
		local lang = vim.treesitter.get_node_text(match[capture_id], bufnr)

		local icon, _ = require("nvim-web-devicons").get_icon_by_filetype(lang, { default = true })
		metadata["conceal"] = icon
	end
end

-- TODO currently not in use, remove?
--- similar to the builtin `#offset!`, but takes length of row and col instead
--- of `end_row_offset` and `end_col_offset`, analogous to lua's `string.sub`
--- usage: (#sub! @_node start_row start_col row_length col_length)
--- Example: `(#sub! @capture 0 0 1 1)`
local function sub(match, _, _, pred, metadata)
	local capture_id = pred[2]
	local offset_node = match[capture_id]
	local range = { offset_node:range() }
	local start_row_offset = pred[3] or 0
	local start_col_offset = pred[4] or 0
	local row_length = pred[5] or 0
	local col_length = pred[6] or 0

	range[1] = range[1] + start_row_offset
	range[2] = range[2] + start_col_offset
	range[3] = range[1] + row_length
	range[4] = range[2] + col_length

	-- If this produces an invalid range, we just skip it.
	if range[1] < range[3] or (range[1] == range[3] and range[2] <= range[4]) then
		if not metadata[capture_id] then
			metadata[capture_id] = {}
		end
		metadata[capture_id].range = range
	end
end

vim.treesitter.query.add_directive("as_devicon!", conceal_as_devicon, true)
vim.treesitter.query.add_directive("sub!", sub, true)

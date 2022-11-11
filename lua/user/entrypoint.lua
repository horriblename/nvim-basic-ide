-- Turn off autoclose as it conflicts with autopairs
vim.cmd [[AutoCloseOff]]

vim.opt.packpath:prepend(require 'user.packerpath'.data_dir .. '/site')
vim.cmd(('runtime! %s %s'):format('START', 'plugin/**/*.lua'))
vim.cmd(('runtime! %s %s'):format('START', 'plugin/**/*.vim'))
require "user.impatient"
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.autocommands"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.illuminate"
require "user.indentline"
require "user.alpha"
require "user.lsp"
require "user.dap"

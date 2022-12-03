-- use an augroup to prevent duplicates
local user_augroup = vim.api.nvim_create_augroup('UserAutocmds', {})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = user_augroup,
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = user_augroup,
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = user_augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  -- group = user_augroup,
-- 	callback = function()
-- 		vim.cmd("quit")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = user_augroup,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = user_augroup,
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = user_augroup,
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = user_augroup,
	callback = function()
	local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = user_augroup,
  pattern = { "*.png", "*.jpg", "*.svg"},
  callback = function ()
    vim.cmd "call jobstart('nsxiv -N nsxiv-float ' .. expand('%')) | bd"
  end,
})

-- auto format
vim.api.nvim_create_autocmd({ "BufWrite" }, {
  group = user_augroup,
  callback = function ()
    if vim.g.autoformatting then
      vim.lsp.buf.format()
    end
  end
})

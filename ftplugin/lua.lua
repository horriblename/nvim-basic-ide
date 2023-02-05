vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 0
vim.bo.includeexpr = [['lua/' .. substitute(v:fname,'\.','/','g')]]

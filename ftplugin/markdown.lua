vim.wo.colorcolumn = "100"
vim.bo.shiftwidth = 3 -- (auto)indent size
vim.bo.tabstop = 4 -- literal tab size
-- vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- this links to tokyonight's highlight definitions for lualine
vim.cmd([[ 
hi! link @Header1 lualine_a_replace
hi! link @Header2 lualine_a_command
hi! link @Header3 lualine_a_insert
hi! link @Header4 lualine_a_visual
hi! link @Header5 lualine_a_normal
hi! link @Header6 lualine_b_normal

hi @text.emphasis guifg=#e0af68 gui=italic  " rainbowcol2
hi @text.strong guifg=#9ece6a gui=bold  " rainbowcol3
hi @text.stronger guifg=#1abc9c gui=bold,italic
]])

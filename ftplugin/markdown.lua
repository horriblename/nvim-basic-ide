vim.wo.colorcolumn = nil
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- this links to tokyonight's highlight definitions for the "p00f/nvim-ts-rainbow" plugin
vim.cmd([[ 
hi! link @Header1 rainbowcol1
hi! link @Header2 rainbowcol2
hi! link @Header3 rainbowcol3
hi! link @Header4 rainbowcol4
hi! link @Header5 rainbowcol5
hi! link @Header6 rainbowcol6

hi @text.emphasis guifg=#e0af68 gui=italic  " rainbowcol2
hi @text.strong guifg=#9ece6a gui=bold  " rainbowcol3
hi @text.stronger guifg=#1abc9c gui=bold,italic
]])

vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = '80,81,82'
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 1
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.foldenable = false
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.swapfile = false                        -- creates a swapfile
-- vim.opt.timeoutlen = 0                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4                         -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
-- vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,]")         		-- allow left/right arrow keys to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.autoread = true
vim.opt.linebreak = true

vim.g.autoformatting = true

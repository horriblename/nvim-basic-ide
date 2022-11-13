-- Shorten function name
local keymap = vim.keymap.set
local ok, wk = pcall(require, 'which-key')

if ok then
  wk.setup {}
  vim.opt.timeoutlen = 0

  -- Prefixes
  wk.register({
    mode = { 'n', 'v' },
    p = { name = 'Packer' },
    b = { name = 'Buffer' },
    g = { name = 'Git' },
    d = { name = 'Debug' },
    l = { name = 'LSP' }
  }, {prefix = '<leader>'})
end
wk = nil -- just in case I'm dumb enough to call despite maybe not existing

-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Plugins --
-- Packer
keymap('n', '<leader>ps', ':PackerSync<CR>', opts)
keymap('n', '<leader>pS', ':PackerStatus<CR>', opts)
keymap('n', '<leader>pu', ':PackerUpdate<CR>', opts)
keymap('n', '<leader>pc', ':PackerCompile<CR>', opts)
keymap('n', '<leader>prs', ':PackerSnapshot', {})
keymap('n', '<leader>prr', ':PackerSnapshotRollback', {})
keymap('n', '<leader>prd', ':PackerSnapshotDelete', {})

-- Alpha
keymap('n', '<leader>;', ':Alpha<CR>', opts)

-- ToggleTerm
keymap({'n', 'i'}, '<M-x>', '<cmd>ToggleTerm<CR>', opts)


-- BufferLine/buffer control
keymap({'n', 'i'}, '<M-n>', '<cmd>BufferLineCycleNext<CR>', opts)
keymap({'n', 'i'}, '<M-p>', '<cmd>BufferLineCyclePrev<CR>', opts)
keymap('n', '<leader>c', ':Bdelete<CR>', opts)
keymap('n', '<leader>C', ':Bdelete!<CR>', opts)
keymap('n', '<leader>bh', ':BufferLineCloseLeft<CR>', opts)
keymap('n', '<leader>bl', ':BufferLineCloseRight<CR>', opts)
keymap('n', '<leader>bD', ':BufferLineSortByDirectory<CR>', opts)
keymap('n', '<leader>bE', ':BufferLineSortByExtension<CR>', opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>sf", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>st", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>sp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>sb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {silent=true, desc='Lazygit'})
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", {silent=true, desc='Search commits'})
keymap("n", "<leader>gc", "<cmd>Telescope git_bcommits<CR>", {silent = true, desc='Search commits for current buffer'})

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

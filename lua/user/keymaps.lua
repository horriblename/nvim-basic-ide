-- Shorten function name
local keymap = vim.keymap.set
local ok, wk = pcall(require, "which-key")

if ok then
  wk.setup({
    registers = true,
    operators = {
      ds = "De-surround",
    },
  })
  vim.opt.timeoutlen = 0

  -- Prefixes
  wk.register({
    mode = { "n", "v" },
    p = { name = "Packer" },
    b = { name = "Buffer" },
    g = { name = "Git" },
    d = { name = "Debug" },
    l = { name = "LSP" },
    s = { name = "Telescope" },
    S = { name = "Session" },
  }, { prefix = "<leader>" })
end
wk = nil -- just in case I'm dumb enough to call despite maybe not existing

-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
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
keymap("n", "<leader>ps", ":PackerSync<CR>", opts)
keymap("n", "<leader>pS", ":PackerStatus<CR>", opts)
keymap("n", "<leader>pu", ":PackerUpdate<CR>", opts)
keymap("n", "<leader>pc", ":PackerCompile<CR>", opts)
keymap("n", "<leader>prs", ":PackerSnapshot", {})
keymap("n", "<leader>prr", ":PackerSnapshotRollback", {})
keymap("n", "<leader>prd", ":PackerSnapshotDelete", {})

-- Alpha
keymap("n", "<leader>;", ":Alpha<CR>", opts)
keymap("n", "<leader>t", ":tabnew +Alpha %<CR>", opts)

-- ToggleTerm
-- keymap({ "n", "i" }, "<M-x>", "<cmd>ToggleTerm<CR>", opts)

-- BufferLine/buffer control
keymap({ "n", "i" }, "<M-n>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap({ "n", "i" }, "<M-p>", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>c", ":Bdelete<CR>", opts)
keymap("n", "<leader>C", ":Bdelete!<CR>", opts)
keymap("n", "<leader>bb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>bt", ":BufferLinePick<CR>", opts)
keymap("n", "<leader>bs", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
keymap("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
keymap("n", "<leader>bD", ":BufferLineSortByDirectory<CR>", opts)
keymap("n", "<leader>bE", ":BufferLineSortByExtension<CR>", opts)
keymap("n", "<leader>bp", ":BufferLineTogglePin<CR>", opts)

-- Persistence FIXME
local p_ok, persistence = pcall(require, "persistence")
if p_ok then
  keymap("n", "<leader>Ss", persistence.save, { silent = true, desc = "Save session" })
  keymap("n", "<leader>SQ", persistence.stop, { silent = true, desc = "Quit without saving session" })
  keymap("n", "<leader>Sc", persistence.load, { silent = true, desc = "Restore last session for current dir" })
  keymap("n", "<leader>Sl", function()
    persistence.load({ last = true })
  end, {
    silent = true,
    desc = "Restore last session",
  })
end

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<M-d>", ":Telescope resume<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>sf", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>sr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>st", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>sp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>sb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>sq", ":Telescope quickfix<CR>", opts)
keymap("n", "<leader>sQ", ":Telescope quickfix_history<CR>", opts)
keymap("n", "<leader>sH", ":Telescope help_tags<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { silent = true, desc = "Lazygit" })
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { silent = true, desc = "Checkout commit" })
keymap(
  "n",
  "<leader>gC",
  "<cmd>Telescope git_bcommits<CR>",
  { silent = true, desc = "Checkout commit for current file" }
)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { silent = true, desc = "Checkout branch" })
keymap("n", "<leader>go", "<cmd>Telescope git_status<CR>", { silent = true, desc = "Open changed file" })

keymap("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", opts)

keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
keymap("v", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", opts)
keymap("n", "<leader>gl", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dk", "<cmd>lua require'dap'.step_back()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dR", "<cmd>lua require'dap'.restart()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dS", "<cmd>lua require'dap'.close()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Aerial
-- Toggle the aerial window with <leader>a
keymap("n", "gO", "<cmd>AerialToggle<CR>", {})
keymap({ "n", "v" }, "[m", "<cmd>AerialPrev<CR>", {})
keymap({ "n", "v" }, "]m", "<cmd>AerialNext<CR>", {})

-- LSP
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)

-- Paste Image
keymap("n", "<leader>P", "<cmd>call mdip#MarkdownClipboardImage()<CR>", {
  silent = true,
  desc = "Paste Image from Clipboard",
})

-- Quick Settings
keymap("n", "<leader>zf", function()
  vim.g.autoformatting = not vim.g.autoformatting
  print("Autoformatting: " .. (vim.g.autoformatting and "on" or "off"))
end, { desc = "Toggle format on save globally" })

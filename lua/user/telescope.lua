local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  require 'user.health':warn('failed to load lua module "telescope"')
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<M-d>"] = actions.close,
        ["<C-BS>"] = { "<C-S-w>", type = "command" },
      },
      n = {
        ["<M-d>"] = actions.close,
        ["<C-s>"] = actions.select_horizontal,
      },
    },
  },
})

pcall(telescope.load_extension, "ui-select")

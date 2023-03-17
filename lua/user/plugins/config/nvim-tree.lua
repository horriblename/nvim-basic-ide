local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  require 'user.health':warn('failed to load lua module "nvim-tree"')
  return
end

local nvim_tree_config = require "nvim-tree.config"

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h",                  cb = tree_cb "close_node" },
        { key = "v",                  cb = tree_cb "vsplit" },
      },
    },
  },
  on_attach = function(bufnr)
    -- local inject_node = require('nvim-tree.utils').inject_node
    local api = require 'nvim-tree.api'

    ---helper function to bind keys
    ---@param key string
    ---@param action string|fun()
    ---@param opts table|nil
    local function bind(key, action, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr, nowait = true }, opts or {})
      if action == nil then
        -- keymap may not exist?
        pcall(vim.keymap.del, 'n', key, { buffer = bufnr })
      else
        vim.keymap.set('n', key, action, opts)
      end
    end


    ---@type { key: string|string[], action: fun()|string|nil, opts: table|nil }[]
    local mappings = {
      { key = { "<C-t>", "c", "d", "D" }, action = nil },
      { key = "a",                        action = api.fs.create },
      { key = "i",                        action = api.node.show_info_popup },
      { key = "y",                        action = api.fs.copy.node },
      { key = "x",                        action = api.fs.cut },
      { key = "p",                        action = api.fs.paste },
      { key = "C",                        action = api.fs.clear_clipboard },
      { key = "v",                        action = api.node.open.vertical },
      { key = "s",                        action = api.node.open.horizontal },
      { key = "T",                        action = api.node.open.tab },
      { key = "I",                        action = api.tree.toggle_gitignore_filter },
      { key = "<c-r>",                    action = api.tree.reload() },
      { key = "zM",                       action = api.tree.collpase_all },
      { key = "zR",                       action = api.tree.expand_all },
      { key = "zc",                       action = api.node.navigate.parent_close },
      { key = "f",                        api.live_filter.start },
      -- { key = "cf", action = dispatcher "copy_name" },
      { key = "cl",                       action = api.fs.copy.absolut_path },
      { key = "gx",                       action = api.node.run.system },
      { key = "l",                        action = api.node.open.edit },
      { key = "<CR>",                     action = api.node.open.edit },
      { key = "dd",                       action = api.fs.trash },
      { key = "DD",                       action = api.fs.remove },
      { key = "r",                        action = api.fs.rename_basename },
      { key = "R",                        action = api.fs.rename },
      { key = ">",                        action = api.node.navigate.sibling.next },
      { key = "<",                        action = api.node.navigate.sibling.prev },
      { key = "_",                        action = api.tree.change_root_to_parent },
      { key = "B",                        action = api.tree.toggle_no_buffer_filter },
      { key = "E",                        action = api.tree.expand_all },
      { key = "F",                        action = api.live_filter.start },

      -- Git and Diagnostics
      { key = "<leader>gj",               action = api.node.navigate.git.next },
      { key = "<leader>gk",               action = api.node.navigate.git.prev },
      { key = "<leader>lj",               action = api.node.navigate.diagnostics.next },
      { key = "<leader>lk",               action = api.node.navigate.diagnostics.prev },

      -- Location navigation
      { key = "Z",                        action = ':Z ' },
      { key = 'gh',                       action = ':cd ~/ <cr>' },
      { key = 'gd',                       action = ':cd ~/Documents <cr>' },
      { key = 'gD',                       action = ':cd ~/Downloads <cr>' },
      { key = 'gp',                       action = ':cd ~/Pictures <cr>' },
      { key = 'gm',                       action = ':cd ~/Music <cr>' },
      { key = 'gs',                       action = ':cd ~/scripts <cr>' },
      { key = 'gn',                       action = ':cd ~/Nextcloud <cr>' },
      { key = 'gv',                       action = ':cd ' .. vim.fn.stdpath("config") .. '<cr>' },
      { key = 'gj',                       action = '<cmd>cd ~/Jail <cr>' },
      { key = 'gr',                       action = '<cmd>cd ~/repo <cr>' },
      { key = 'gc',                       action = '<cmd>cd ~/.config <cr>' },
      { key = 'gC',                       action = '<cmd>cd ~/.cache <cr>' },
      { key = 'gl',                       action = '<cmd>cd ~/.local <cr>' },
      { key = 'g/',                       action = '<cmd>cd $PREFIX/ <cr>' },
      { key = 'gE',                       action = '<cmd>cd $PREFIX/etc <cr>' },
      { key = 'gUU',                      action = '<cmd>cd $PREFIX/usr <cr>' },
      { key = 'gUs',                      action = '<cmd>cd $PREFIX/usr/share <cr>' },
      { key = 'gT',                       action = '<cmd>cd $PREFIX/tmp <cr>' },
      { key = 'gM',                       action = '<cmd>cd $PREFIX/mnt <cr>' },
      { key = 'gV',                       action = '<cmd>cd $PREFIX/var <cr>' },
      { key = 'gbb',                      action = '<cmd>cd /mnt/BUP <cr>' },
      { key = 'gbd',                      action = '<cmd>cd /mnt/BUP/Documents_ <cr>' },
      { key = 'gba',                      action = '<cmd>cd /mnt/BUP/apps <cr>' },
      { key = 'gtt',                      action = '<cmd>cd /mnt/ntdrive <cr>' },
      { key = 'gta',                      action = '<cmd>cd /mnt/ntdrive/apps <cr>' },
      { key = 'gee',                      action = '<cmd>cd /mnt/ext <cr>' },
    }

    for _, mapping in ipairs(mappings) do
      if type(mapping.key) == "string" then
        bind(mapping.key --[[@as string]], mapping.action, mapping.opts)
      else
        for _, key in ipairs(mapping.key --[=[@as string[]]=]) do
          bind(key, mapping.action, mapping.opts)
        end
      end
    end
  end
}

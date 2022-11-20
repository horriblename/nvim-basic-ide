local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

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
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
  on_attach = function(bufnr)
    -- local inject_node = require('nvim-tree.utils').inject_node
    local dispatcher = function(action)
      return function() require('nvim-tree.actions.dispatch').dispatch(action) end
    end

    local bind = function(key, action)
      if action == nil then
        -- keymap may not exist?
        pcall(vim.keymap.del, 'n', key, { buffer = bufnr })
      else
        vim.keymap.set('n', key, action, { buffer = bufnr , nowait = true })
      end
    end


    local mappings = {
      { key = { "<C-t>", "c", "d", "D" }, action = nil },
      { key = "i", action = dispatcher "toggle_file_info" },
      { key = "y", action = dispatcher "copy" },
      { key = "v", action = dispatcher "vsplit" },
      { key = "s", action = dispatcher "split" },
      { key = "T", action = dispatcher "tabnew" },
      -- { key = "cf", action = dispatcher "copy_name" },
      { key = "cl", action = dispatcher "copy_absolute_path" },
      { key = "gx", action = dispatcher "system_open" },
      { key = "l", action = dispatcher "edit" },
      { key = "dd", action = dispatcher "trash" },
      { key = "DD", action = dispatcher "remove" },
      { key = "Z", action = ':Z ' },

      { key = 'gh', action = ':cd ~/ <cr>' },
      { key = 'gd', action = ':cd ~/Documents <cr>' },
      { key = 'gD', action = ':cd ~/Downloads <cr>' },
      { key = 'gp', action = ':cd ~/Pictures <cr>' },
      { key = 'gm', action = ':cd ~/Music <cr>' },
      { key = 'gs', action = ':cd ~/scripts <cr>' },
      { key = 'gn', action = ':cd ~/Nextcloud <cr>' },
      { key = 'gv', action = ':cd ' .. vim.fn.stdpath("config") .. '<cr>' },

      { key = 'gj', action = '<cmd>cd ~/Jail <cr>' },
      { key = 'gr', action = '<cmd>cd ~/repo <cr>' },
      { key = 'gc', action = '<cmd>cd ~/.config <cr>' },
      { key = 'gC', action = '<cmd>cd ~/.cache <cr>' },
      { key = 'gl', action = '<cmd>cd ~/.local <cr>' },

      { key = 'g/', action = '<cmd>cd $PREFIX/ <cr>' },
      { key = 'gE', action = '<cmd>cd $PREFIX/etc <cr>' },
      { key = 'gUU', action = '<cmd>cd $PREFIX/usr <cr>' },
      { key = 'gUs', action = '<cmd>cd $PREFIX/usr/share <cr>' },
      { key = 'gT', action = '<cmd>cd $PREFIX/tmp <cr>' },
      { key = 'gM', action = '<cmd>cd $PREFIX/mnt <cr>' },
      { key = 'gV', action = '<cmd>cd $PREFIX/var <cr>' },

      { key = 'gbb', action = '<cmd>cd /mnt/BUP <cr>' },
      { key = 'gbd', action = '<cmd>cd /mnt/BUP/Documents_ <cr>' },
      { key = 'gba', action = '<cmd>cd /mnt/BUP/apps <cr>' },

      { key = 'gtt', action = '<cmd>cd /mnt/ntdrive <cr>' },
      { key = 'gta', action = '<cmd>cd /mnt/ntdrive/apps <cr>' },

      { key = 'gee', action = '<cmd>cd /mnt/ext <cr>' },
    }

    for _, mapping in ipairs(mappings) do
      if type(mapping.key) == "string" then
        bind(mapping.key, mapping.action)
      else for _, key in ipairs(mapping.key) do
          bind(key, mapping.action)
        end
      end

    end
  end
}

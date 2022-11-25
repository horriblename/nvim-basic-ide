return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
          -- these are not working:
          [require 'user.nvide-path':get_nvide_config_dir() .. '/lua'] = true,
          [require 'user.nvide-path':get_nvide_data_dir() .. '/site'] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

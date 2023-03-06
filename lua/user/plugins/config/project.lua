local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
  require 'user.health':warn('failed to load lua module "project_nvim"')
  return
end
project.setup({
  -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
  detection_methods = { "pattern" },
  -- patterns used to detect root dir, when **"pattern"** is in detection_methods
  patterns = {
    ".git",
    "Makefile",
    "package.json",
    "index.*",
    ".anchor",
    ">.config",
    ">repo",
    ">advent-of-code-2022",
  },
})

-- if Telescope is not loaded yet, modify its config function to load the
-- project extension after initialization
local plugins = require('lazy').plugins()
for _, plugin in ipairs(plugins) do
  if plugin[1] == 'nvim-telescope/telescope.nvim' then
    if plugin.loaded then
      require('telescope').load_extension('projects')
    else
      local telescope_config = plugin.config
      plugin.config = function()
        telescope_config()
        require('telescope').load_extension('projects')
      end
    end
  end
end

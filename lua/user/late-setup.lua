-- setup IDE after nvim initialization ended (see `:h startup`)
local M = {}
-- this will source all files under <runtime>/pack/*/start/*/plugin
-- including those already loaded
function M.init(config_dir)
  config_dir = config_dir or os.getenv 'NVIDE_CONFIG' or vim.g.nvide_config_dir
  if config_dir then
    vim.opt.runtimepath:prepend(config_dir)
  elseif vim.fn.glob('~/.config/nvide') ~= '' then
    config_dir = vim.fn.expand '~/.config/nvide'
    vim.opt.runtimepath:prepend(config_dir)
  else
    config_dir = vim.fn.stdpath 'config'
  end

  _G.nvide = {} -- temporary solution for NvIDE detection

  -- TODO maybe not init here, this is the final fallback
  if not vim.g.nvide_data_dir and vim.fn.glob('~/.local/share/nvide') then
    vim.g.nvide_data_dir = '~/.local/share/nvide'
  end

  require "user.nvide-path":init(config_dir)
  require "user.entrypoint"

  vim.cmd [[
runtime! START plugin/**/*.vim
runtime! START plugin/**/*.lua
]]
  vim.cmd('source ' .. vim.fn.stdpath 'cache' .. '/packer_compiled.lua')
end

return M

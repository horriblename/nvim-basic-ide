local M = {}

function M:get_nvide_data_dir()
  return self.DATA_DIR or vim.fn.stdpath 'data'
end

function M:get_nvide_config_dir()
  return self.CONFIG_DIR or vim.fn.stdpath 'config'
end

function M:init(config_dir)
  local nvide_config_dir = config_dir or vim.fn.stdpath 'config'

  local nvide_data_dir = os.getenv 'NVIDE_DATA'
  if nvide_data_dir then
    vim.opt.packpath:prepend(nvide_data_dir .. '/site/pack/packer')
  else
    nvide_data_dir = vim.fn.stdpath 'data'
  end

  self.CONFIG_DIR = nvide_config_dir
  self.DATA_DIR = nvide_data_dir
  end

return M


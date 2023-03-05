local M = {}

---@return string
function M:get_nvide_data_dir()
  return self.DATA_DIR or vim.fn.stdpath("data")
end

---@return string
function M:get_nvide_config_dir()
  return self.CONFIG_DIR or vim.fn.stdpath("config")
end

-- FIXME lazy.nvim messes with runtimepath a lot, would be worth looking into
-- integrating this better with lazy.nvim; right now I just add
-- nvide_config_dir again after loading lazy. (see end of plugins.lua)

--- Initializes the nvide_path object. You can then use `M:get_nvide_config_dir`
--- and `M:get_nvide_data_dir`. `vim.go.runtimepath` should be set accordingly
--- using these values
---@param config_dir any
function M:init(config_dir)
  local nvide_config_dir = config_dir or vim.fn.stdpath("config")
  require 'user.health':info("nvide config dir is " .. nvide_config_dir)

  local nvide_data_dir = os.getenv("NVIDE_DATA") or vim.g.nvide_data_dir
  require 'user.health':info("nvide data dir is " .. nvide_data_dir)
  if nvide_data_dir then
    -- vim.opt.packpath:prepend(nvide_data_dir .. '/site')
  else
    nvide_data_dir = vim.fn.stdpath("data")
  end

  self.CONFIG_DIR = nvide_config_dir
  self.DATA_DIR = nvide_data_dir
end

return M

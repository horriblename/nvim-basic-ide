local nvide_config_dir = os.getenv 'NVIDE_CONFIG'
if nvide_config_dir then
  vim.opt.runtimepath:prepend(nvide_config_dir)
else
  nvide_config_dir = vim.fn.stdpath 'config'
end

require "user.nvide-path":init(nvide_config_dir)
require "user.entrypoint"

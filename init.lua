-- vim.opt.runtimepath:prepend { '~/.config/nvim' }
local nvide_dir = os.getenv 'NVIDE_CONFIG'
if nvide_dir then
  vim.opt.runtimepath:prepend(nvide_dir)
end

require "user.entrypoint"

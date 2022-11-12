require 'user.entrypoint'
if vim.fn.argc() == 0 then
  require 'alpha'.start()
end

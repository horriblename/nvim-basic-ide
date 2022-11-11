vim.api.nvim_create_user_command('IDE', function ()
  require 'user.entrypoint'
  if vim.fn.argc() == 0 then
    require 'alpha'.start()
  end
end, {})
--
-- local function saveTempSession()
--   local file = vim.fn.stdpath('state') .. '/tempSession.vim'
--   local oldOpts = vim.opt.sessionoptions
--   vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal,skiprtp'
--   vim.cmd('mksession '..file)
--   vim.opt.sessionoptions = oldOpts
--
--   return file
-- end
--
-- _G.get_cache_dir = function ()
--   return os.getenv("NVIDE_CACHE_DIR") or vim.call('stdpath', 'cache')
-- end
--
-- local function bootstrap()
--   local session = saveTempSession()
--
--   vim.opt.rtp:prepend()
--
--   vim.cmd ('source ' .. session)
-- end
--
-- local function init_dirs()
--   vim.fn.stdpath = function (what)
--     if what == 'cache' then
--       return _G.get_cache_dir()
--     end
--   end
-- end

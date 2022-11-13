if vim.fn.has 'unix' ~= 1 and not os.getenv 'NVIDE_ALLOW_NON_UNIX' then
  vim.notify( [[
  Only Unix systems supported, use the evironment variable NVIDE_ALLOW_NON_UNIX
  to skip this check.
  ]])
  vim.wait(5000, function()
    return false
  end)
  vim.cmd "cquit"
end

local get_nvide_data = function()
  return vim.fn.expand('~/.local/share/nvide')
end

local function init()
  if _G.vim_stdpath then
    return
  end

  _G.vim_stdpath = vim.fn.stdpath
  vim.fn.stdpath = function(what)
    if what == "data" then
      return get_nvide_data()
    end
    return _G.vim_stdpath(what)
  end
end

init()

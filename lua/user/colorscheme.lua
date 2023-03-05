vim.cmd "hi TreesitterContextBottom gui=underline guisp=Grey"

local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
  require 'user.health':warn('failed to load lua module "tokyonight"')
  return
end

tokyonight.setup {
  styles = {
    comments = { fg = '#727ca7' }
  },
  on_highlights = function(hl, _)
    hl.WinSeparator = { fg = '#727ca7' }
  end
}

local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

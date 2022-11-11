require'tokyonight'.setup {
  styles = {
    comments = { fg = '#727ca7' }
  },
  on_highlights = function (hl, c) 
    hl.WinSeparator={ fg = '#727ca7' }
  end
}

local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

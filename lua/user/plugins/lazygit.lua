local M = {}
local terminal = require("toggleterm.terminal")

local lazygit = terminal.Terminal:new({
  cmd = "lazygit",
  hidden = true,
  on_open = function(term)
    vim.keymap.set('t', [[<M-x>]], M.lazygit, { silent = true, noremap = true, buffer = term.bufnr })
  end
})

function M.lazygit()
  lazygit:toggle()
end

return M

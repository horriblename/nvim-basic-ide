local M = {}

function M.peek_definition()
  local host_bufnr = vim.fn.bufnr()
  local host_win_handle = vim.api.nvim_get_current_win()
  vim.lsp.buf.definition({
    on_list = function(definitions)
      if #definitions.items == 0 then
        print("no definitions found.")
        return
      end

      print(vim.inspect(definitions))
      local loc = definitions.items[1]
      local bufnr = loc.bufnr or vim.fn.bufnr(loc.filename, true)

      local peek = vim.api.nvim_open_win(bufnr, false, {
        relative = "cursor",
        row = -1,
        col = 1,
        anchor = "SW",
        width = 70,
        height = 15,
        border = "rounded",
      })

      vim.api.nvim_win_set_cursor(peek, { loc.lnum, 0 })

      local augrp = vim.api.nvim_create_augroup("PeekWindowOnBuf" .. host_bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorMoved", "BufDelete", "WinClosed" }, {
        pattern = vim.fn.bufname(host_bufnr),
        nested = true,
        group = augrp,
        callback = function()
          if vim.api.nvim_get_current_win() ~= host_win_handle then
            return
          end
          vim.api.nvim_win_close(peek, false)
        end,
      })
      vim.api.nvim_create_autocmd({ "WinClosed" }, {
        pattern = tostring(peek),
        group = augrp,
        callback = function()
          vim.api.nvim_del_augroup_by_id(augrp)
        end,
      })
    end,
  })
end

return M

if vim.fn.filereadable(vim.fn.stdpath 'cache' .. '/packer_compiled.lua') == 1 then
  vim.cmd('source ' .. vim.fn.stdpath 'cache' .. '/packer_compiled.lua')
end

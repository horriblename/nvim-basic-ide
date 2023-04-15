local M = {}

local md = require('markdownstuff')

local function testToggleTaskList()
  local tests = {
    { '- [ ] hello',      '- [x] hello' },
    { '   -  [ ]  hello', '   -  [x]  hello' },
    { '\t-  [ ]  hello',  '\t-  [x]  hello' },
    { '- hello',          '- [ ] hello' },
    { '\t-  hello',       '\t-  [ ] hello' },
    { '  -  hello',       '  -  [ ] hello' },
  }

  for i, test in ipairs(tests) do
    if md.toggleTasklist(test[1]) ~= test[2] then
      local msg = 'testing toggleTaskList: failed test case #' .. i .. '\n'
      msg       = msg .. '    expected ' .. test[2] .. '\n'
      msg       = msg .. '    got ' .. md.toggleTasklist(test[1]) .. '\n'

      vim.health.report_error(msg)
    end
  end
end

function M.check()
  vim.health.report_start('Personal Markdown stuff')
  testToggleTaskList()
end

return M

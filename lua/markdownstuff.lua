local M = {}

local patternListItem = '^%s*([-+*])%s+'
local patternTasklistItem = '^%s*([-+*])%s+%[[ xX]%]' -- trailing whitespace not matched for my convenience :P

---@param line string
---@return string
function M.toggleTasklist(line)
  local task0, task1 = line:find(patternTasklistItem)
  if task0 then
    local mark = line:sub(task1 - 1, task1 - 1) == ' ' and 'x' or ' '
    return line:sub(1, task1 - 2) .. mark .. line:sub(task1)
  end

  local list0, list1 = line:find(patternListItem)
  if list0 then
    return line:sub(1, list1) .. '[ ] ' .. line:sub(list1 + 1, -1)
  end

  local indent0, indent1 = line:find('^%s*')
  return line:sub(1, indent0) .. '- [ ] ' .. line:sub(indent1 + 1, -1)
end

return M

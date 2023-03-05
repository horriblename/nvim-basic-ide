---@class LogEntry
---@field type "info" | "warn"
---@field msg string

---@type {logs: LogEntry}
local M = {
  logs = {},
}

-- logging

---@param msg string
function M:warn(msg)
  self.logs[#self.logs + 1] = { type = "warn", msg = msg }
end

---@param msg string
function M:info(msg)
  self.logs[#self.logs + 1] = { "info", msg }
end

-- called by `:checkhealth`
function M.check()
  vim.health.report_start('User Config')
  for _, entry in ipairs(M.logs) do
    if entry.type == 'info' then
      vim.health.report_info(entry.msg)
    else
      vim.health.report_warn(entry.msg)
    end
  end
end

return M

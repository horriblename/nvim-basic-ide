local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local function lastSessionText()
	-- for some reason persistence.get_last() can fail
	local ok, session = pcall(function() require 'persistence'.get_last() end)
	if not ok or not session then
		return '碑 Last session'  
	end

  local path = vim.fn.fnamemodify(session, ':t:r:gs|%|/|:~')
  return '碑 Last session: ' .. vim.fn.pathshorten(path)
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[                               ▁▁                ]],
  [[  ▁▁▁▁    ▁▁▁    ▁▁▁   ▁▁  ▁▁ ╱╲▁╲    ▁▁▁ ▁▁▁▁   ]],
  [[ ╱ ▁  ╲  ╱ ▁▁＼ ╱ ▁▁＼╱╲ ╲╱╲ ╲╲╱╲ ╲  ╱ ▁▁ˇ ▁▁ ╲  ]],
  [[╱╲ ╲╱╲ ╲╱╲  ▁▁╱╱╲ ╲▁╲ ╲ ╲ ╲╱  ▏╲ ╲ ╲╱╲ ╲╱╲ ╲╱╲ ╲ ]],
  [[╲ ╲▁╲ ╲▁╲ ╲▁▁▁▁╲ ╲▁▁▁▁╱╲ ╲▁▁▁╱  ╲ ╲▁╲ ╲▁╲ ╲▁╲ ╲▁╲]],
  [[ ╲╱▁╱╲╱▁╱╲╱▁▁▁▁╱╲╱▁▁▁╱  ╲╱▁▁╱    ╲╱▁╱╲╱▁╱╲╱▁╱╲╱▁╱]],
}
dashboard.section.buttons.val = {
  dashboard.button("s", lastSessionText(), ":lua require'persistence'.load({last = true})<CR>"),
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Config", ":e ".. vim.api.nvim_get_runtime_file('lua/user/entrypoint.lua', false)[1] .."<CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
local function footer()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

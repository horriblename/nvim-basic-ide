local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local function lastSessionText()
  local path = vim.fn.fnamemodify(require'persistence'.get_last(), ':t:r:gs|%|/|:~')
  return '碑 Last session: ' .. vim.fn.pathshorten(path)
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[                               __                ]],
  [[  ____    ___    ___   __  __ ╱╲_╲    ___ ____   ]],
  [[ ╱ _  ╲  ╱ __＼ ╱ __＼╱╲ ╲╱╲ ╲╲╱╲ ╲  ╱ __` __ ╲  ]],
  [[╱╲ ╲╱╲ ╲╱╲  __╱╱╲ ╲_╲ ╲ ╲ ╲_╱ ▏╲ ╲ ╲╱╲ ╲╱╲ ╲╱╲ ╲ ]],
  [[╲ ╲_╲ ╲_╲ ╲____╲ ╲____╱╲ ╲___╱  ╲ ╲_╲ ╲_╲ ╲_╲ ╲_╲]],
  [[ ╲╱_╱╲╱_╱╲╱____╱╲╱___╱  ╲╱__╱    ╲╱_╱╲╱_╱╲╱_╱╲╱_╱]],
}
dashboard.section.buttons.val = {
  dashboard.button("s", lastSessionText(), ":lua require'persistence'.load({last = true})"),
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

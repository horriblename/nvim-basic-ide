-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  require 'user.health':warn('failed to load lua module "nvim-autopairs"')
  return
end
-- local Rule = require("nvim-autopairs.rule")
-- local cond = require("nvim-autopairs.conds")

-- Remove some scuffed autoclose bindings
-- iterate over each char
local _ = ([[{}()[]'"`]]):gsub(".", function(c)
  pcall(vim.keymap.del, "i", c)
end)

npairs.setup({
  check_ts = true, -- treesitter integration
  disable_filetype = { "TelescopePrompt", unpack(require("user.util").get_lisp_filetypes()) },
  enable_afterquote = false,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "(", "[", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- npairs.add_rules({
--   Rule("(", ")", neg_lisp_ft),
-- })
--
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))

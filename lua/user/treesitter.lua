local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
  require("user.health").log:warn('could not load lua module "nvim-treesitter"')
  return
end

local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
  require("user.health").log:warn('could not load lua module "nvim-treesitter.configs"')
  return
end

configs.setup({
  ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true, -- false will disable the whole extension
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

local function conceal_as_devicon(match, _, bufnr, pred, metadata)
  if #pred == 2 then
    -- (#as_devicon! @capture)
    local capture_id = pred[2]
    local lang = vim.treesitter.get_node_text(match[capture_id], bufnr)

    local icon, _ = require("nvim-web-devicons").get_icon_by_filetype(lang, { default = true })
    metadata["conceal"] = icon
  end
end

vim.treesitter.query.add_directive("as_devicon!", conceal_as_devicon, true)

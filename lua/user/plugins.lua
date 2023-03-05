local nvide_paths = require("user.nvide-path")

-- Bootstrap lazy.nvim
local lazyroot = nvide_paths:get_nvide_data_dir() .. "/lazy"
local clone_path = lazyroot .. "/lazy.nvim"
if not vim.loop.fs_stat(clone_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    clone_path,
  })
end
vim.opt.rtp:prepend(clone_path)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Install your plugins here
-- return packer.startup(function(use)
local plugins = {
  -- My plugins here
  { "nvim-lua/plenary.nvim",                       commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }, -- Useful lua functions d by lots of plugins
  { "windwp/nvim-autopairs",                       commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" }, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim",                       commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" },
  { "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" },
  { "kyazdani42/nvim-web-devicons",                commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" },
  { "kyazdani42/nvim-tree.lua",                    commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" },
  { "akinsho/bufferline.nvim",                     commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" },
  { "moll/vim-bbye",                               commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
  { "nvim-lualine/lualine.nvim",                   commit = "a52f078026b27694d2290e34efa61a6e4a690621" },
  { "akinsho/toggleterm.nvim",                     commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" },
  { "ahmedkhalf/project.nvim",                     commit = "628de7e433dd503e782831fe150bb750e56e55d6" },
  { "lewis6991/impatient.nvim",                    commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" },
  { "lukas-reineke/indent-blankline.nvim",         commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },
  { "goolord/alpha-nvim",                          commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" },

  -- Colorschemes
  { "folke/tokyonight.nvim",                       commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" },
  --  { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  -- cmp plugins
  { "hrsh7th/nvim-cmp",                            commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }, -- The completion plugin
  { "hrsh7th/cmp-buffer",                          commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
  { "hrsh7th/cmp-path",                            commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }, -- path completions
  { "saadparwaiz1/cmp_luasnip",                    commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp",                        commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" },
  { "hrsh7th/cmp-nvim-lua",                        commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" },

  -- snippets
  { "L3MON4D3/LuaSnip",                            commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }, --snippet engine
  { "rafamadriz/friendly-snippets",                commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }, -- a bunch of snippets to

  -- LSP
  --  { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to  language server installer
  { "neovim/nvim-lspconfig",                       commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }, -- enable LSP
  { "williamboman/mason.nvim",                     commit = "bfc5997e52fe9e20642704da050c415ea1d4775f" },
  { "williamboman/mason-lspconfig.nvim",           commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c" },
  { "jose-elias-alvarez/null-ls.nvim",             commit = "c0c19f32b614b3921e17886c541c13a72748d450" }, -- for formatters and linters
  { "RRethy/vim-illuminate",                       commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" },

  -- Telescope
  { "nvim-telescope/telescope.nvim",               commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
  },

  -- Git
  { "lewis6991/gitsigns.nvim",    commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" },

  -- DAP
  { "mfussenegger/nvim-dap",      commit = "6b12294a57001d994022df8acbe2ef7327d30587" },
  { "rcarriga/nvim-dap-ui",       commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" },
  { "ravenxrz/DAPInstall.nvim",   commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" },

  -- Other Plugins
  { "folke/which-key.nvim",       lazy = false },
  { "gpanders/editorconfig.nvim", event = "BufRead" },
  { "simnalamburt/vim-mundo",     cmd = "MundoToggle" },
  { "mattn/libcallex-vim",        run = { "make -C autoload" } },
  {
    "bytesnake/vim-graphical-preview",
    ft = { "*.graphics", "graphical-preview" },
    build = { "cargo build --release" },
    cond = function()
      return not vim.g.neovide and not vim.g.goneovim
    end,
    dependencies = { { "mattn/libcallex-vim", build = "make -C autoload" } },
  },
  {
    -- TODO remove?
    "abecodes/tabout.nvim",
    enabled = false,
    event = "BufRead",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("tabout").setup({
        tabkey = nil,
        backwards_tabkey = nil,
        act_as_tab = false,
      })
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "pianocomposer321/project-templates.nvim",
    cmd = { "LoadTemplate", "DeleteTemplate", "SaveAsTemplate" },
    config = function()
      vim.g.project_templates_dir = "~/Templates/"
    end,
  },
  -- treesitter plugins
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "romgrk/nvim-treesitter-context",
    dependencies = { "nvim-treesitter" },
    config = function()
      --vim.cmd [[ hi! link TreesitterContext CursorColumn ]]
      require("treesitter-context").setup({
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          c = {
            "struct",
          },
          go = {
            "for",
            "if",
            "switch",
            "case",
            "func",
            "interface",
            "struct",
          },
          markdown = {
            "heading_content",
            -- 'list_item'
          },
        },
      })
    end,
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    module = "aerial",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("aerial").setup({})
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  {
    "p00f/nvim-ts-rainbow",
    event = "BufRead",
    dependencies = { "nvim-treesitter" },
  },

  {
    "folke/persistence.nvim",
    -- event = "BufReadPre", -- this will only start session saving when an actual file was opened
    -- module = "persistence",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
      })
    end,
  },

  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter" },
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    config = function()
      require("nvim-treesitter.configs").setup({})
    end,
  },

  -- DAP
  { "mfussenegger/nvim-dap-python" },

  -- language specific
  {
    "ferrine/md-img-paste.vim",
    ft = "markdown",
    -- fn = "mdip#MarkdownClipboardImage", -- FIXME fn not available in lazy.nvim
    config = function()
      vim.g.mdip_imgdir = "attachments"
      vim.g.PasteImageFunction = "g:WikiPasteImage"
      vim.cmd([=[
            function! g:WikiPasteImage(relpath)
              call append('.','![['.a:relpath.']]')
            endfunction
        ]=])
    end,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    -- ft = "markdown",
    cmd = "Mkdnflow",
    -- rocks = "luautf8",
    config = function()
      require("mkdnflow").setup({
        -- Config goes here; leave blank for defaults
        conceal = false,
        lists = false, -- causing problems
        links = { conceal = false },
        perspective = { root_tell = "index.md" },
        mappings = {
          MkdnEnter = { { "i", "n", "v" }, "<CR>" },
          MkdnNextLink = false,
          MkdnPrevLink = false,
          MkdnFollowLink = { { "n", "v" }, "<A-CR>" },
          MkdnDestroyLink = { "n", "K" },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = { "i", "<M-CR>" },
          MkdnTableNewRowBelow = { "n", "<leader>ir" },
          MkdnTableNewRowAbove = { "n", "<leader>iR" },
          MkdnTableNewColAfter = { "n", "<leader>ic" },
          MkdnTableNewColBefore = { "n", "<leader>iC" },
        },
      })
    end,
  },
  { "jpalardy/vim-slime",          ft = "python" },
  { "hanschen/vim-ipython-cell",   ft = "python" },
  { "elkowar/yuck.vim",            ft = "yuck" },
  { "gpanders/nvim-parinfer",      cmd = { "ParinferOn", "ParinferToggle" } },
  {
    "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    config = function()
      require("rust-tools").setup({
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require("r.lsp.handlers").on_attach(client, bufnr)
            local rt = require("rust-tools")
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "glimmer",
      "handlebars",
      "hbs",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

-- always load plugins that are pinned by lunarvim/nvim-basic-ide
for _, plugin in ipairs(plugins) do
  if plugin.commit then
    plugin.lazy = false
  else
    break
  end
end

require("lazy").setup(plugins, {
  root = lazyroot,
})
vim.opt.rtp:prepend(nvide_paths:get_nvide_config_dir())

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

---Helper function to import plugin configs from lua/user/plugins/config/*.lua
---@param modname string name of the config module
local function conf(modname)
  return function()
    require("user.plugins.config." .. modname)
  end
end

-- Install your plugins here
-- return packer.startup(function(use)
local plugins = {
  -- My plugins here
  { "nvim-lua/plenary.nvim",                       lazy = false }, -- Useful lua functions d by lots of plugins
  { "windwp/nvim-autopairs",                       lazy = false, config = conf('autopairs') },
  { "numToStr/Comment.nvim",                       lazy = false, config = conf('comment') },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  { "kyazdani42/nvim-web-devicons",                lazy = false },
  { "kyazdani42/nvim-tree.lua",                    lazy = false, config = conf('nvim-tree') },
  { "akinsho/bufferline.nvim",                     lazy = false, config = conf('bufferline') },
  { "moll/vim-bbye",                               lazy = false },
  { "nvim-lualine/lualine.nvim",                   lazy = false, config = conf('lualine') },
  { "akinsho/toggleterm.nvim",                     lazy = false, config = conf('toggleterm') },
  { "ahmedkhalf/project.nvim",                     lazy = false, config = conf('project') },
  { "lewis6991/impatient.nvim",                    lazy = false, config = conf('impatient') },
  { "lukas-reineke/indent-blankline.nvim",         lazy = false, config = conf('indentline') },
  { "goolord/alpha-nvim",                          lazy = false, config = conf('alpha') },

  -- Colorschemes
  { "folke/tokyonight.nvim",                       lazy = false },
  --  { "lunarvim/darkplus.nvim", lazy = false }

  -- cmp plugins
  { "hrsh7th/nvim-cmp",                            lazy = false, config = conf('cmp') },
  { "hrsh7th/cmp-buffer",                          lazy = false },
  { "hrsh7th/cmp-path",                            lazy = false },
  { "saadparwaiz1/cmp_luasnip",                    lazy = false },
  { "hrsh7th/cmp-nvim-lsp",                        lazy = false },
  { "hrsh7th/cmp-nvim-lua",                        lazy = false },

  -- snippets
  { "L3MON4D3/LuaSnip",                            lazy = false }, --snippet engine
  { "rafamadriz/friendly-snippets",                lazy = false }, -- a bunch of snippets to

  -- LSP
  --  { "williamboman/nvim-lsp-installer", lazy = false } -- simple to  language server installer
  { "neovim/nvim-lspconfig",                       lazy = false }, -- enable LSP
  { "williamboman/mason.nvim",                     lazy = false },
  { "williamboman/mason-lspconfig.nvim",           lazy = false },
  { "jose-elias-alvarez/null-ls.nvim",             lazy = false }, -- for formatters and linters
  { "RRethy/vim-illuminate",                       lazy = false, config = conf('illuminate') },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = conf(
      'telescope')
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = {
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", lazy = false, config = conf("treesitter"), },
  -- Git
  { "lewis6991/gitsigns.nvim",         lazy = false, config = conf('gitsigns') },

  -- DAP
  { "mfussenegger/nvim-dap",           lazy = false },
  { "rcarriga/nvim-dap-ui",            lazy = false },
  { "ravenxrz/DAPInstall.nvim",        lazy = false },

  -- Other Plugins
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      local wk = require 'which-key'

      wk.setup({
        registers = true,
        operators = {
          ds = "De-surround",
        },
      })
      vim.opt.timeoutlen = 0

      -- Prefixes
      wk.register({
          mode = { "n", "v" },
          p = { name = "Packer" },
          b = { name = "Buffer" },
          g = { name = "Git" },
          d = { name = "Debug" },
          l = { name = "LSP" },
          s = { name = "Telescope" },
          S = { name = "Session" },
        },
        {
          prefix = "<leader>",
        }
      )
    end
  },
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

require("lazy").setup(plugins, {
  root = lazyroot,
  lockfile = nvide_paths:get_nvide_config_dir() .. '/lazy-lock.json',
  performance = {
    rtp = {
      paths = { nvide_paths:get_nvide_config_dir() }
    }
  }
})

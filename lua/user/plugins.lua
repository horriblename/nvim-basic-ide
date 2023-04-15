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
  -- do not lazy load
  { "folke/tokyonight.nvim",        lazy = false, config = conf('tokyonight') },
  { "kyazdani42/nvim-web-devicons", lazy = false },
  { "nvim-lualine/lualine.nvim",    lazy = false, config = conf('lualine') },
  { "ahmedkhalf/project.nvim",      lazy = false, config = conf('project') },
  { "lewis6991/impatient.nvim",     lazy = false, config = conf('impatient') },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    config = conf('bufferline'),
    dependencies = { "folke/tokyonight.nvim" }
  },

  -- My plugins here
  { "windwp/nvim-autopairs",               event = "BufRead",              config = conf('autopairs') },
  { "numToStr/Comment.nvim",               event = "BufRead",              config = conf('comment') },
  { "kyazdani42/nvim-tree.lua",            cmd = "NvimTreeToggle",         config = conf('nvim-tree') },
  { "moll/vim-bbye",                       cmd = { "Bdelete", "Bwipeout" } },
  { "akinsho/toggleterm.nvim",             cmd = "ToggleTerm",             config = conf('toggleterm') },
  { "lukas-reineke/indent-blankline.nvim", event = "BufRead",              config = conf('indentline') },
  { "goolord/alpha-nvim",                  cmd = 'Alpha',                  config = conf('alpha') },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    event = "BufRead",
    config = conf('cmp'),
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      -- snippets
      { "L3MON4D3/LuaSnip" },             --snippet engine
      { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to
    }
  },


  -- LSP
  { "neovim/nvim-lspconfig",             lazy = false }, -- enable LSP
  { "williamboman/mason.nvim",           lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  { "jose-elias-alvarez/null-ls.nvim",   lazy = false }, -- for formatters and linters
  { "RRethy/vim-illuminate",             event = "BufRead", config = conf('illuminate') },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = 'Telescope',
    config = conf('telescope'),
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = {
          "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        }
      },
    }
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = conf("treesitter"),
    dependencies = {
      -- treesitter plugins
      "nvim-treesitter/nvim-treesitter-textobjects",
      "mrjones2014/nvim-ts-rainbow",
      "JoosepAlviste/nvim-ts-context-commentstring",
    }
  },
  -- Git
  { "lewis6991/gitsigns.nvim", event = "BufReadPre",                       config = conf('gitsigns') },
  { "sindrets/diffview.nvim",  dependencies = { "nvim-lua/plenary.nvim" }, config = conf('diffview') },

  -- DAP
  {
    -- DAPInstall and nvim-dap is initialized together in conf('dap')
    "mfussenegger/nvim-dap",
    event = "CmdUndefined Dap*",
    config = conf('dap'),
    dependencies = {
      {
        "ravenxrz/DAPInstall.nvim",
        cmd = { "DIInstall", "DIList", "DIUninstall" },
        -- let nvim-dap handle config in conf('dap')
        config = function()
        end
      }
    }
  },
  { "rcarriga/nvim-dap-ui",   dependencies = { "mfussenegger/nvim-dap" } },

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
        triggers_blacklist = {
          n = { "v" }
        }
      })
      vim.opt.timeoutlen = 0

      -- Prefixes
      wk.register({
          mode = { "n", "v" },
          p = { name = "Packer" },
          b = { name = "Buffer" },
          g = { name = "Git" },
          gd = { name = "Diffview" },
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
  { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
  {
    "bytesnake/vim-graphical-preview",
    ft = { "*.graphics", "graphical-preview" },
    build = { "cargo build --release" },
    cond = function()
      return not vim.g.neovide and not vim.g.goneovim
    end,
    dependencies = { { "mattn/libcallex-vim", build = "make -C autoload" } },
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
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter" },
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    config = function()
      require("nvim-treesitter.configs").setup({})
    end,
  },

  {
    "folke/persistence.nvim",
    -- event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
      })
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
  { "jpalardy/vim-slime",        ft = "python" },
  { "hanschen/vim-ipython-cell", ft = "python" },
  { "elkowar/yuck.vim",          ft = "yuck" },
  { "gpanders/nvim-parinfer",    cmd = { "ParinferOn", "ParinferToggle" } },
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

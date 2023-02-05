local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"jsonls",
	"yamlls",
	"marksman",
	"rnix",
}

local lazy_servers = {
	"bashls",
	"clangd",
	"csharp_ls",
	"cssls",
	"gopls",
	"hls",
	"taplo",
	"vimls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

local function lspconfig_setup(server)
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

for _, server in pairs(servers) do
	lspconfig_setup(server)
end

local lazy_augroup = vim.api.nvim_create_augroup("LazyLspSetup", { clear = false })

for _, server in pairs(lazy_servers) do
	local filetypes = lspconfig[server].document_config.default_config.filetypes
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		group = lazy_augroup,
		once = true,
		callback = function()
			lspconfig_setup(server)
		end,
	})
end

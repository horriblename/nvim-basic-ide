return {
	root_dir = function(fname)
		return require("lspconfig").util.root_pattern(".git", ".marksman.toml", "index.md")(fname)
	end,
}

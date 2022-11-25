return {
  root_dir = function ()
    require 'lspconfig'.util.root_pattern {
      ".git", ".marksman.toml", "index.md" }
  end,
}

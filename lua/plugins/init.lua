-- ~/.config/nvim/lua/plugins/init.lua
-- Index file that collects all plugin specifications

return {
  -- Load all plugin specs from separate files
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.autopairs" },
  { import = "plugins.ui" },
  { import = "plugins.utilities" },
}
-- ~/.config/nvim/init.lua
-- Main entry point for Neovim configuration

-- Load core settings
require("core.options")
require("core.keymaps")

-- Bootstrap and initialize lazy.nvim
require("core.lazy-bootstrap")
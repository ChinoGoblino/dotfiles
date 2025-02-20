-- lspconfig.lua

local lspconfig = require('lspconfig')

-- Always show sign column to prevent shifting
vim.o.signcolumn = "yes"

-- Rust
lspconfig.rust_analyzer.setup{
  settings = {
    ["rust-analyzer"] = {}
  }
}

-- Python
lspconfig.pyright.setup{
  settings = {}
}

-- Nix
lspconfig.nil_ls.setup{
  settings = {}
}

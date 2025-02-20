-- lspconfig.lua

local lspconfig = require('lspconfig')

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

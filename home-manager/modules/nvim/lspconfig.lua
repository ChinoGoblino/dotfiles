-- lspconfig.lua

local lspconfig = require('lspconfig')

-- Always show sign column to prevent shifting
vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",  -- You can change this symbol
    spacing = 4,    -- Space between text and error
  },
  signs = true,      -- Show signs in the sign column
  underline = true,  -- Underline errors in the code
  update_in_insert = false, -- Avoid updates while typing
})

vim.diagnostic.config({
        signs = {
                text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = "󰋼 ",
                        [vim.diagnostic.severity.HINT] = "󰌵 ",
                },
                texthl = {
                        [vim.diagnostic.severity.ERROR] = "Error",
                        [vim.diagnostic.severity.WARN] = "Error",
                        [vim.diagnostic.severity.HINT] = "Hint",
                        [vim.diagnostic.severity.INFO] = "Info",
                },
                numhl = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                },
        },
})

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

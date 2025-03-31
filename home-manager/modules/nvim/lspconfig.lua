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

local signs = { Error = "✘", Warn = "⚠", Hint = "➤", Info = "ℹ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

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

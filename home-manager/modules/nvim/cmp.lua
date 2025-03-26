local cmp = require('cmp')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },  -- Ensure this is active
  }
})

-- Pass LSP capabilities to rust-analyzer
local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
  capabilities = lsp_capabilities
}

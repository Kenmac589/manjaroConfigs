vim.opt.spell = true
vim.spelllang = { 'en_ca' }

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.menu = ({
        vsnip = '[Snippet]',
        buffer = '[File]',
        path = '[Path]',
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1 },
    { name = 'vsnip', priority = 2 },
    { name = 'spell', priority = 3 },
    { name = 'buffer', priority = 4 },
    { name = 'path', priority = 5 },

    -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer'},
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}
require('lspconfig')['bashls'].setup {
  capabilities = capabilities
}
require('lspconfig')['vimls'].setup {
  capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}
require('lspconfig')['sumneko_lua'].setup {
  capabilities = capabilities,
  cmd = { '/Users/kenzie_mackinnon/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server' }
}

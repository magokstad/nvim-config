require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "scheme",
      -- "lisp",
      -- "nim",
      "lua",
      "rust",
      "vim",
      "lua",
      "html",
      "css",
      "c",
      "vue",
      "rust",
      "latex",
      "java",
      "fennel",
      "python",
      "clojure",
      "kotlin",
      "v"
  },
  highlight = {
    additional_vim_regex_highlighting = true,
  },
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    -- spleling mistkae
    -- lua
    "sumneko_lua",

    -- web dev stuff
    "cssls",
    "html",
    "tsserver",
    "vuels",
    "tailwindcss",

    -- rust
    "rust_analyzer",

    -- latex
    "texlab",

    -- python
    "jedi_language_server",

    -- clojure
    "clojure_lsp",

    -- "crystal"
    "crystalline",

    -- eslint???
    "eslint",

    -- C (++)
    "clangd",
    "cmake",
    "nimls",
  },
})

local servers = {
  "html",
  "cssls",
  "tsserver",
  "vuels",
  "tailwindcss",
  "clangd",
  "rust_analyzer",
  "jdtls",
  "jedi_language_server",
  "texlab",
  "clojure_lsp",
  "vls",
  "kotlin_language_server",
  "crystalline",
  "sumneko_lua",
  "eslint",
  "cmake",
  "nimls"
}



-- taken from https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local luasnip = require('luasnip')

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

local cmp = require('cmp')
local select_opts = {behavior = cmp.SelectBehavior.Select}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('luasnip.loaders.from_vscode').lazy_load()


lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },

})

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

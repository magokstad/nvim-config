-- Add treesitter servers here
require 'nvim-treesitter.configs'.setup {
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

-- LSP only!
local servers = {
  "arduino_language_server",
  "html",
  "cssls",
  "tsserver",
  "tailwindcss",
  "clangd",
  "rust_analyzer",
  "jdtls",
  "jedi_language_server",
  "texlab",
  "clojure_lsp",
  -- "vls",
  "kotlin_language_server",
  -- "crystalline",
  "lua_ls",
  "eslint",
  "cmake",
  -- "nimls",
}

-- null-ls (format/lint)
local null_ls = require "null-ls"
local b = null_ls.builtins
local sources = {
  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier,

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- C etc
  b.diagnostics.clang_check,
  b.code_actions.cspell,

  -- Pyhon
  b.diagnostics.mypy.with({extra_args = {"--check-untyped-defs"}}) ,
  b.diagnostics.ruff

}

------------------------------------------------------------------------

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({ensure_installed = servers})
-- There used to be a seperate list here, but it was removed since it was
-- identical to the "servers" list

-- taken from https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local luasnip = require('luasnip')

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('luasnip.loaders.from_vscode').lazy_load()


-- This entire chunk was copy pasta'd for autocompletion
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
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
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
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

})

-- Provides format on save
-- require("lsp-format").setup {}
-- local on_attach = require("lsp-format").on_attach
-- was buggy on some filetypes. TODO: add manual additions

-- Sets up format and lint
null_ls.setup {
  debug = true,
  sources = sources,
}

-- Ads to all lsp's in "servers"
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

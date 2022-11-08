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
    -- lua
    "lua-language-server",
    "stylua",
    "sumneko-lua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "vetur-vls",
    "tailwindcss-language-server",

    -- Python
    "jdtls",

    -- rust
    "rust-analyzer",

    -- latex
    "texlab",

    -- python
    "jedi_language_server",

    -- clojure
    "clojure-lsp",

    -- "crystal"
    "crystalline"
  },
})

local lspconfig = require("lspconfig")
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
  "sumneko_lua"
}

-- Straight up stolen from my nvchad, no clue if it works 
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

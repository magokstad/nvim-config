local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
  },
})

-- hello
local wk = require("which-key")
wk.register(mappings, opts)


require 'sniprun'.setup({
  repl_enable = { 'Python3_original' }
})

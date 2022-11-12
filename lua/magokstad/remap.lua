local nnoremap = require("magokstad.keymap").nnoremap
local vnoremap = require("magokstad.keymap").vnoremap
local tnoremap = require("magokstad.keymap").tnomemap

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")

-- Term, zen
nnoremap("<leader>tt", "<cmd>ToggleTerm<CR>")
tnoremap("<leader>tt", "<cmd>ToggleTerm<CR>")
nnoremap("<leader>zm", "<cmd>ZenMode<CR>")

-- Buffers
nnoremap("<TAB>", "<cmd>BufferLineCycleNext<CR>")
nnoremap("<S-Tab>", "<cmd>BufferLineCycleNext<CR>")

-- Sync packer
nnoremap("<leader>ps", "<cmd>so ~/.config/nvim/lua/magokstad/packer.lua<CR><cmd>PackerSync<CR>")

-- Debugging
nnoremap("<leader>dbb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
nnoremap("<leader>dbrb", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
nnoremap("<leader>dbc", "<cmd>lua require'dap'.continue()<CR>")
nnoremap("<leader>dbso", "<cmd>lua require'dap'.step_over()<CR>")
nnoremap("<leader>dbsb", "<cmd>lua require'dap'.step_back()<CR>")
nnoremap("<leader>dbsO", "<cmd>lua require'dap'.step_out()<CR>")
-- nnoremap("<leader>dbsi", "<cmd>lua require'dap'.step_into()<CR>")
nnoremap("<leader>dbro", "<cmd>lua require'dap'.repl.open()<CR>")
nnoremap("<leader>dbrr", "<cmd>lua require'dap'.run()<CR>")
nnoremap("<leader>dbrl", "<cmd>lua require'dap'.run_last()<CR>")
nnoremap("<leader>dbd", "<cmd>lua require'dap'.disconnect()<CR>")

-- SnipRun (manual comp needed for now)
vnoremap("<leader>sr", "<cmd>SnipRun<CR>")
vnoremap("<leader>sc", "<cmd>SnipClose<CR>")
vnoremap("<leader>sx", "<cmd>SnipReset<CR>")
vnoremap("<leader>sm", "<cmd>SnipReplMemoryClean<CR>")
-- normal mode
nnoremap("<leader>sr", "<cmd>SnipRun<CR>")
nnoremap("<leader>sc", "<cmd>SnipClose<CR>")
nnoremap("<leader>sx", "<cmd>SnipReset<CR>")
nnoremap("<leader>sm", "<cmd>SnipReplMemoryClean<CR>")


local nnoremap = require("magokstad.keymap").nnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")

nnoremap("<leader>tt", "<cmd>ToggleTerm<CR>")
nnoremap("<leader>zm", "<cmd>ZenMode<CR>")

nnoremap("<TAB>", "<cmd>BufferLineCycleNext<CR>")
nnoremap("<S-Tab>", "<cmd>BufferLineCycleNext<CR>")

nnoremap("<leader>ps", "<cmd>so ~/.config/nvim/lua/magokstad/packer.lua<CR><cmd>PackerSync<CR>")

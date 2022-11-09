# nvim-config

My custom neovim config

This is still pretty work in progress, 
and will replace my nvchad config.

So far every plugin is pretty stock, 
but it is fully functional as is

To try it: 
```
mv ~/.config/nvim ~/.config/nvimbak_b4_mago
git clone https://github.com/magokstad/nvim-config ~/.config/nvim
```

Make sure to source packer so plugins can load.
I will provide a way to do this via terminal eventually, 
but for now, a set of instructions will do:

- in the .config/nvim directory, do nvim lua/magokstad/packer.lua
- write :so
- then :PackerSync
- reopen neovim and voila

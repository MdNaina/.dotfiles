local keymap = require("mdnaina.keymap");

local nnoremap = keymap.nnoremap;

vim.g.mapleader = " ";
nnoremap("<leader>b", "<cmd>Ex<CR>")

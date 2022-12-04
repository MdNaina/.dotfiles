local nnoremap = require("mdnaina.keymap").nnoremap;

local ui = require("harpoon.ui");

local mark = require("harpoon.mark");

nnoremap("<leader>a", function() mark.add_file() end)

nnoremap("<C-e>", function() ui.toggle_quick_menu() end)




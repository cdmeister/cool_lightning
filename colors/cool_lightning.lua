-- colors/cool_lightning.lua
-- Cool Lightning colorscheme entry point
-- This file is loaded by Neovim when you run :colorscheme cool_lightning

vim.opt.termguicolors = true
vim.g.colors_name = "cool_lightning"

-- Clear existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

require("cool_lightning").setup()

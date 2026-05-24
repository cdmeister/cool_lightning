-- colors/cool_lightning.lua
-- Cool Lightning colorscheme entry point

vim.opt.termguicolors = true
vim.g.colors_name = "cool_lightning"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

require("cool_lightning").setup()

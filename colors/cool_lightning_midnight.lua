-- colors/cool_lightning_midnight.lua
vim.opt.termguicolors = true
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "cool_lightning_midnight"
require("cool_lightning").setup({ style = "midnight" })

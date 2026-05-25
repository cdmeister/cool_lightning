-- colors/cool_lightning.lua
-- Loads the midnight (default) style
vim.opt.termguicolors = true
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "cool_lightning"
require("cool_lightning").setup({ style = "midnight" })

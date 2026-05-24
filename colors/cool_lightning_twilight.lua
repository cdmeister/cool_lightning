-- colors/cool_lightning_twilight.lua
vim.opt.termguicolors = true
vim.g.colors_name = "cool_lightning_twilight"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

require("cool_lightning").setup({ style = "twilight" })

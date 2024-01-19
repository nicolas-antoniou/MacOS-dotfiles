---@type ChadrcConfig
local M = {}

M.ui = { theme = 'gruvbox' }

M.plugins = "custom.plugins"
vim.keymap.set("n", "<c-P>",
  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
return M

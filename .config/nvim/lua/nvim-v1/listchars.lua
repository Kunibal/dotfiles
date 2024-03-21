local api = vim.api
local nvim_set_hl = api.nvim_set_hl

vim.opt.list = true

local space = "·"
vim.opt.listchars:append { tab = "│─", multispace = space, lead = space, trail = space }
nvim_set_hl(0, "WhitespaceBol", { fg = "gray" })
vim.cmd([[match WhitespaceMol / /]])

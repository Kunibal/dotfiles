vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append line below without moving cursor
vim.keymap.set("n", "J", "mzJ`z")
-- half page jumping with cursor staying in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- keep cursor in place when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- preserve register when pasting over something
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- get access to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- switching windows
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- format file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- don't know what this does, still figuring it out
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- rename all occurrences of word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make file into executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- shoutout file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Codeium AI
vim.g.codeium_no_map_tab = true
vim.api.nvim_set_keymap("i", "<C-J>", "codeium#Accept()",
    { silent = true, expr = true, nowait = true, script = true })

-- Ctrl B for copilot completion
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.api.nvim_set_keymap("i", "<C-B>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.g.user_emmet_leader_key = "<C-B>"

-- copy absolute path
vim.api.nvim_create_user_command("Cpath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- copy file name
vim.api.nvim_create_user_command("CFileName", function()
    local filename = vim.fn.expand("%:t")
    vim.fn.setreg("+", filename)
    vim.notify('Copied "' .. filename .. '" to the clipboard!')
end, {})

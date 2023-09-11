local function format_prettier()
    return {
        exe = "npx",
        args = { "prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
        stdin = true
    }
end

require('formatter').setup {
    logging = true,
    filetype = {
        scss = { format_prettier },
    }
}

vim.keymap.set("n", "<leader>F", ":Format<CR>")

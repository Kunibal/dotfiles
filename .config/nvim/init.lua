vim.opt.guicursor = ""
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append "@-@"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

vim.opt.termguicolors = true

vim.opt.list = true

local space = "·"
vim.opt.listchars:append { tab = "│─", multispace = space, lead = space, trail = space }
vim.api.nvim_set_hl(0, "WhitespaceBol", { fg = "gray" })
vim.cmd [[match WhitespaceMol / /]]

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")

-- append line below without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- half page jumping with cursor staying in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in place when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- preserve register when pasting over something
vim.keymap.set("x", "<leader>p", [["_dP]])

-- get access to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- rename all occurrences of word under cursor
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make file into executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.g.user_emmet_leader_key = "<C-p>"

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- copy absolute path
vim.api.nvim_create_user_command("Cpath", function()
    local path = vim.fn.expand "%:p"
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to clipboard')
end, {})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    { "numToStr/Comment.nvim", opts = {} },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hr", gs.reset_hunk)
                map("v", "<leader>hs", function()
                    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("v", "<leader>hr", function()
                    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hp", gs.preview_hunk)
                map("n", "<leader>hb", gs.toggle_current_line_blame)
                map("n", "<leader>hd", gs.diffthis)
                map("n", "<leader>hD", function()
                    gs.diffthis "~"
                end)
            end,
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            }
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require "telescope.builtin"
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "[S]earch [T]elescope" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<C-s>", builtin.git_files, {})
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    previewer = false,
                })
            end, { desc = "[/] Fuzzily search in current buffer" })
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set("n", "<leader>sg", function()
                builtin.grep_string { search = vim.fn.input "Grep > " }
            end, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sn", function()
                builtin.find_files { cwd = vim.fn.stdpath "config" }
            end, { desc = "[S]earch [N]eovim files" })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                },
            },
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end
                    --  To jump back, press <C-t>.
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("<leader>f", vim.lsp.buf.format, "[F]ormat")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
            local servers = {
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                features = "all",
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            -- enable clippy on save
                            checkOnSave = {
                                command = "clippy",
                            },
                            check = {
                                command = "clippy",
                            },
                            diagnostics = {
                                disabled = {
                                    "unresolved-proc-macro",
                                    "inactive-code",
                                },
                            },
                        },
                    },
                },
                lua_ls = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "4",
                        },
                    },
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            }
            require("mason").setup()
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua",
                "tsserver",
                "rust_analyzer",
                "gopls",
                "asm-lsp",
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true, rust = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { { "prettierd" } },
                typescript = { { "prettierd" } },
                typescriptreact = { { "prettierd" } },
                css = { { "prettierd" } },
            },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                    ["<C-Space>"] = cmp.mapping.complete {},
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            }
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        opts = {},
        init = function()
            vim.cmd.colorscheme "rose-pine"
            -- create full opacity
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

            vim.cmd.hi "Comment gui=none"
        end,
    },
    { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "c", "lua", "typescript", "markdown", "rust" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } },
        },
        config = function(_, opts)
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    { import = "custom.plugins" },
}

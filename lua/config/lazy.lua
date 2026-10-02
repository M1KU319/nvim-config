local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 没有安装时，自动从 GitHub 下载
if not vim.uv.fs_stat(lazypath) then
    local result = vim.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }, { text = true }):wait()

    if result.code ~= 0 then
        error("下载 lazy.nvim 失败：\n" .. (result.stderr or ""))
    end
end

-- 让 Neovim 能找到这个插件
vim.opt.rtp:prepend(lazypath)

-- 启动管理器，插件列表暂时为空
require("lazy").setup({
    spec = {
        {
            "catppuccin/nvim", 
            name = "catppuccin",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("catppuccin-mocha")
            end,
        },
        {
            "nvim-telescope/telescope.nvim", --File Search
            version = "*",
            dependencies = {
            "nvim-lua/plenary.nvim",
            },
            opts = {},
        },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate", --Updates installed parsers when the plugin is installed or updated
            opts = {},
        },
        {
            "stevearc/oil.nvim",
            lazy = false,
            opts = {
            columns = {},
            },
        },
        {
            "neovim/nvim-lspconfig",
            lazy = false,
            dependencies = {
                {
                    "mason-org/mason.nvim", --Pririty loading mason
                    opts = {},
                },
            },
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            lazy = false,
            opts = {
                keymap = {
                    preset = "enter",
                    ["<CR>"] = {
                        "accept",
                        function ()
                            return require("nvim-autopairs").autopairs_cr()
                        end, 
                    },
                },
                completion = {
                    documentation = {
                        auto_show = true,
                    },
                },
                sources = {
                    default = { "lsp", "path", "buffer" },
                },
            },
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            opts = {
                map_cr = false,
            },
        },
        {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            opts = {},
            keys = {
                {
                    "]h",
                    "<Cmd>Gitsigns nav_hunk next<CR>",
                    desc = "Next Git hunk",
                },
                {
                    "[h",
                    "<Cmd>Gitsigns nav_hunk prev<CR>",
                    desc = "Previous Git hunk",
                },
                {
                    "<leader>gp",
                    "<Cmd>Gitsigns preview_hunk<CR>",
                    desc = "Preview Git hunk",
                },
                {
                    "<leader>gs",
                    "<Cmd>Gitsigns stage_hunk<CR>",
                    desc = "Stage Git hunk",
                },
            },
        },
        {
            "kdheepak/lazygit.nvim",
            cmd = { "LazyGit", "LazyGitCurrentFile" },
            dependencies = { "nvim-lua/plenary.nvim" },
            keys = {
                {
                    "<leader>gg",
                    "<Cmd>LazyGitCurrentFile<CR>",
                    desc = "Open Lazygit",
                },
            },
        },
        {
            "pwntester/octo.nvim",
            cmd = "Octo",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
            },
            opts = {
                picker = "telescope",
                enable_builtin = true,
                file_panel = {
                    icons = false,
                },
            },
            keys = {
                {
                    "<leader>oi",
                    "<Cmd>Octo issue list<CR>",
                    desc = "List GitHub issues",
                },
                {
                    "<leader>op",
                    "<Cmd>Octo pr list<CR>",
                    desc = "List GitHub pull requests",
                },
            },
        },
    },
})

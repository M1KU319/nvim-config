vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

-- 缩进
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- 搜索
vim.opt.ignorecase = true --搜索时忽略大小写
vim.opt.smartcase = true --搜索内容包含大写字母时，区分大小写

require("config.lazy")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, {
    desc = "Find files",
})

vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
    desc = "Search project text",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "rust", "c", "cpp", "python" },
    callback = function(args)
        vim.treesitter.start(args.buf)
    end,
})

vim.keymap.set("n", "-", "<Cmd>Oil<CR>", {
    desc = "Open parent directory",
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("clangd")

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
            },
        },
    },
})

vim.lsp.enable("basedpyright")

vim.keymap.set("n", "<leader>cf", function()
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 3000,
    })
end, {
    desc = "Format code",
})

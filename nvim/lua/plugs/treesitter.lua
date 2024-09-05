return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        dependencies = {
            "nvim-treesitter/playground",
        },
        opts = {
            ensure_installed = {
                "rust",
                "go",
                "python",
                "html",
                "css",
                "javascript",
                "typescript",
                "svelte",
                "lua",
                "markdown",
                "cpp",
                "c",
            },
            highlight = {
                enable = true,
                -- additional_vim_regex_highlighting = false,
            },
            playground = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "<space>m", mode = { "n" }, "<CMD>lua require('telescope.builtin').treesitter{}<CR>", desc = "Treesitter Symbols", },
            { "<space>l", mode = { "n" }, "<CMD>TSToggle highlight<CR>", desc = "Toggle Treesitter highlight", },
        },
    },
}

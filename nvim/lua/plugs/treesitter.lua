return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        -- dependencies = {
        --     "nvim-treesitter/playground",
        -- },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "rust",
                    "go",
                    "python",
                    "html",
                    "css",
                    "javascript",
                    "typescript",
                    "typescriptreact",
                    "svelte",
                    "lua",
                    "markdown",
                    "cpp",
                    "c",
                    "arduino",
                    "opencode_output",
                    "dart",
                },
                callback = function()
                    vim.treesitter.start()
                end,
            })
            return {
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
                    "dart",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                -- playground = {
                --     enable = true,
                -- },
                autotag = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                },
            }
        end,
        -- stylua: ignore
        keys = {
            { "<space>m", mode = { "n" }, "<CMD>lua require('telescope.builtin').treesitter{}<CR>", desc = "Treesitter Symbols", },
            { "<space>l", mode = { "n" }, "<CMD>lua vim.treesitter.start()<CR>", desc = "Enable Treesitter highlight", },
        },
    },
    -- {
    --     "arborist-ts/arborist.nvim",
    --     opts = {
    --         update_cadence = "weekly",
    --     },
    -- },
}

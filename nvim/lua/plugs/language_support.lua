return {
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "simrat39/rust-tools.nvim",
        -- ft = {
        --     "rust",
        --     "toml",
        -- },
        opts = {

            tools = {
                inlay_hints = {
                    only_current_line = true,
                    show_parameter_hints = false,
                    -- highlight = "VertSplit",
                    -- highlight = "lualine_a_mode_inactive",
                    highlight = "DevIconDoc",
                },
            },
            server = {
                on_attach = function(client, bufnr)
                    -- Hover actions
                    vim.keymap.set(
                        "n",
                        "<C-space>",
                        require("rust-tools").hover_actions.hover_actions,
                        { buffer = bufnr }
                    )
                    -- Code action groups
                    vim.keymap.set(
                        "n",
                        "<Leader>a",
                        require("rust-tools").code_action_group.code_action_group,
                        { buffer = bufnr }
                    )
                    require("nvim-navic").attach(client, bufnr)
                end,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                        inlayHints = { locationLinks = false },
                    },
                },
            },
        },
    },
    {
        "ron-rs/ron.vim",
        ft = "ron",
    },
    {
        "leafOfTree/vim-svelte-plugin",
        ft = "svelte",
    },
    {
        "LhKipp/nvim-nu",
        ft = "nu",
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "dart-lang/dart-vim-plugin",
        },
        opts = {
            ui = {
                notification_style = "native",
            },
            lsp = {
                on_attach = function(client, bufnr)
                    require("nvim-navic").attach(client, bufnr)
                end,
            },
        },
    },
    {
        "NoahTheDuke/vim-just",
        ft = "just",
    },
    { "ellisonleao/glow.nvim", opts = {
        width = 120,
        border = "rounded",
    }, cmd = "Glow" },
    "Glench/Vim-Jinja2-Syntax",
    "folke/neodev.nvim",
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
}

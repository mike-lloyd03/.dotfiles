return {
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    -- {
    --     "mrcjkb/rustaceanvim",
    --     ft = { "rust" },
    -- },
    {
        "ron-rs/ron.vim",
        ft = "ron",
    },
    {
        "leafOfTree/vim-svelte-plugin",
        ft = "svelte",
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
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },
}

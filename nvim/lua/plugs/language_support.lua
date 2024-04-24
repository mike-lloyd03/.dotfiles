return {
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        lazy = false,
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

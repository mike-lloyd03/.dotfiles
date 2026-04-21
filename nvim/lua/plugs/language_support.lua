return {
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
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
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            completions = { lsp = { enabled = true } },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
        },
        opts = {
            dap = {
                adapters = {
                    codelldb = {
                        type = "executable",
                        command = "codelldb",
                    },
                },
            },
        },
        config = function()
            local dap = require("dap")
            dap.adapters.codelldb = {
                type = "executable",
                command = "codelldb",
            }
            dap.configurations.rust = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.getcwd() .. "/target/debug/spec"
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason.nvim", "mfussenegger/nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = true,
        },
    },
}

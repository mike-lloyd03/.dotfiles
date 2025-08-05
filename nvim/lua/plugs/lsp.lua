return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
                update_in_insert = true,
            },
            servers = {
                bashls = {},
                biome = {
                    cmd = { "biome", "lsp-proxy", "--config-path=~/.config/biome.json" },
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
                gopls = {},
                pyright = {},
                ruff = {},
                svelte = {},
                ts_ls = {},
                eslint = {},
                jsonls = {},
                clangd = {},
                nil_ls = {},
                tinymist = {
                    offset_encoding = "utf-8",
                },
                arduino_language_server = {
                    -- cmd = { "/home/mike/repos/arduino-language-server/arduino-language-server" },
                },
                cssls = {},
                tailwindcss = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                volar = {},
            },
        },
        config = function(_, opts)
            local function navic_attach(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end

            for server, server_opts in pairs(opts.servers) do
                server_opts.on_attach = navic_attach
                require("lspconfig")[server].setup(server_opts)
            end
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        opts = function()
            local null_ls = require("null-ls")
            return {
                sources = {
                    null_ls.builtins.diagnostics.revive.with({
                        args = { "-formatter", "json", "-config", "/home/mike/.config/revive.toml", "./..." },
                    }),
                },
            }
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-avante",
        },
        version = "*",
        opts = {
            keymap = {
                preset = "default",
                -- ["<Tab>"] = {
                --     "select_next",
                --     "snippet_forward",
                --     "fallback",
                -- },
                -- ["<S-Tab>"] = {
                --     "select_prev",
                --     "snippet_backward",
                --     "fallback",
                -- },
                ["<C-CR>"] = { "select_and_accept" },
                ["<C-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "avante", "lsp", "path", "snippets", "buffer" },
                providers = {
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                        opts = {},
                    },
                },
            },

            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },
        },
        opts_extend = { "sources.default" },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {
            options = {
                show_source = true,
                multiple_diag_under_cursor = true,
            },
        },
    },
}

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
                -- bacon_ls = {},
                biome = {
                    cmd = { "biome", "lsp-proxy", "--config-path=~/.config/biome.json" },
                },
                -- rust_analyzer = {
                --     settings = {
                --         ["rust-analyzer"] = {
                --             inlayHints = {
                --                  enable = false,
                --             },
                --             check = {
                --                 command = "clippy",
                --             },
                --             -- Required with bacon
                --             -- checkOnSave = { enable = false },
                --             -- diagnostic = { enable = false },
                --         },
                --     },
                -- },
                hyprls = {},
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
                typos_lsp = {},
                -- volar = {},
                -- https://github.com/neovim/nvim-lspconfig/issues/3945#issuecomment-3057102104
                -- vue_ls = {
                --     on_init = function(client)
                --         client.handlers["tsserver/request"] = function(_, result, context)
                --             local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
                --             if #clients == 0 then
                --                 vim.notify(
                --                     "Could not found `vtsls` lsp client, vue_lsp would not work without it.",
                --                     vim.log.levels.ERROR
                --                 )
                --                 return
                --             end
                --             local ts_client = clients[1]
                --             local param = unpack(result)
                --             local id, command, payload = unpack(param)
                --             ts_client:exec_cmd({
                --                 title = "vue_request_forward",
                --                 command = "typescript.tsserverRequest",
                --                 arguments = {
                --                     command,
                --                     payload,
                --                 },
                --             }, { bufnr = context.bufnr }, function(_, r)
                --                 local response_data = { { id, r.body } }
                --                 ---@diagnostic disable-next-line: param-type-mismatch
                --                 client:notify("tsserver/response", response_data)
                --             end)
                --         end
                --     end,
                -- },
                -- vtsls = {
                --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                --     settings = {
                --         vtsls = {
                --             tsserver = {
                --                 globalPlugins = {
                --                     {
                --                         name = "@vue/typescript-plugin",
                --                         languages = { "vue" },
                --                         configNamespace = "typescript",
                --                         location = vim.fn.stdpath("data")
                --                             .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                --                     },
                --                 },
                --             },
                --         },
                --     },
                -- },
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
                vim.lsp.config(server, server_opts)
                vim.lsp.enable(server)
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
        },
        version = "*",
        opts = {
            keymap = {
                preset = "default",
                ["<C-CR>"] = { "select_and_accept" },
                ["<C-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "fallback" },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
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

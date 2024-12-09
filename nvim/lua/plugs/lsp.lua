return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                update_in_insert = true,
            },
            servers = {
                bashls = {},
                rust_analyzer = { enable = false },
                bacon_ls = {
                    enable = true,
                    settings = {
                        locationsFile = ".locatoins",
                        baconSettings = {
                            spawn = true,
                            command = "bacon clippy -- --all-features",
                        },
                    },
                },
                gopls = {},
                pyright = {},
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
                    cmd = { "/home/mike/repos/arduino-language-server/arduino-language-server" },
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
        "hrsh7th/nvim-cmp",
        -- "yioneko/nvim-cmp",
        -- branch = "perf",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                dependencies = {
                    "saadparwaiz1/cmp_luasnip",
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                    "golang/vscode-go",
                    "rust-lang/vscode-rust",
                },
            },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Down>"] = cmp.mapping.select_next_item(),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                },

                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        -- menu = {
                        --     nvim_lsp = "[LSP]",
                        --     luasnip = "[LuaSnip]",
                        --     path = "[Path]",
                        --     buffer = "[Buffer]",
                        -- },
                    }),
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
        keys = {
            {
                "<Tab>",
                function()
                    local luasnip = require("luasnip")
                    local cmp = require("cmp")

                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        return "<Tab>"
                    end
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
            {
                "<S-Tab>",
                function()
                    local luasnip = require("luasnip")
                    local cmp = require("cmp")

                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        return "<S-Tab>"
                    end
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    },
}

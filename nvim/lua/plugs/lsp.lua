return {
    "neovim/nvim-lspconfig",
    "nvimtools/none-ls.nvim",
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            {
                "garymjr/nvim-snippets",
                opts = {
                    friendly_snippets = true,
                },
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "golang/vscode-go",
                    "rust-lang/vscode-rust",
                },
            },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
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
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    }),
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "snippets" },
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
                    if vim.snippet.active({ direction = 1 }) then
                        return "<cmd>lua vim.snippet.jump(1)<cr>"
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
                    if vim.snippet.active({ direction = -1 }) then
                        return "<cmd>lua vim.snippet.jump(-1)<cr>"
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
